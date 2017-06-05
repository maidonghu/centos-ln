#!/bin/bash
yum -y groupinstall 'Development Tools'
yum -y install wget openssl-devel libxml2-devel libxslt-devel jemalloc-devel gd-devel perl-ExtUtils-Embed GeoIP-devel rpmdevtools

OPENSSL="openssl-1.0.2k"
NGINX_VERSION="1.13.1-1"
NJS_VERSION="1.13.1.0.1.10-1"

rpm -ivh http://nginx.org/packages/mainline/centos/7/SRPMS/nginx-$NGINX_VERSION.el7.ngx.src.rpm
rpm -ivh http://nginx.org/packages/mainline/centos/7/SRPMS/nginx-module-geoip-$NGINX_VERSION.el7.ngx.src.rpm
rpm -ivh http://nginx.org/packages/mainline/centos/7/SRPMS/nginx-module-image-filter-$NGINX_VERSION.el7.ngx.src.rpm
rpm -ivh http://nginx.org/packages/mainline/centos/7/SRPMS/nginx-module-njs-$NJS_VERSION.el7.ngx.src.rpm
rpm -ivh http://nginx.org/packages/mainline/centos/7/SRPMS/nginx-module-perl-$NGINX_VERSION.el7.ngx.src.rpm
rpm -ivh http://nginx.org/packages/mainline/centos/7/SRPMS/nginx-module-xslt-$NGINX_VERSION.el7.ngx.src.rpm

sed -i "/Source12: .*/a Source100: https://raw.githubusercontent.com/maidonghu/centos-ln/master/$OPENSSL.tar.gz" /root/rpmbuild/SPECS/nginx.spec
sed -i "s|--with-http_ssl_module|--with-http_ssl_module --with-openssl=$OPENSSL|g" /root/rpmbuild/SPECS/nginx.spec
sed -i '/%setup -q/a tar zxf %{SOURCE100}' /root/rpmbuild/SPECS/nginx.spec
sed -i '/.*Requires: openssl.*/d' /root/rpmbuild/SPECS/nginx.spec
sed -i '/BuildRequires: pcre-devel/a BuildRequires: jemalloc-devel' /root/rpmbuild/SPECS/nginx.spec
# hardening whatnots since 1.11.9
sed -i 's|%define WITH_LD_OPT .*|%define WITH_LD_OPT "-ljemalloc"|g' /root/rpmbuild/SPECS/nginx.spec
sed -i 's| -fPIC||g' /root/rpmbuild/SPECS/nginx.spec

spectool -g -R /root/rpmbuild/SPECS/nginx.spec
# if '.rpmmacros' contains "%_sourcedir    %{_topdir}/SOURCES/%{name}"
#spectool -g -C /root/rpmbuild/SOURCES/nginx/ /root/rpmbuild/SPECS/nginx.spec

rpmbuild -ba /root/rpmbuild/SPECS/nginx.spec
rpmbuild -ba /root/rpmbuild/SPECS/nginx-module-geoip.spec
rpmbuild -ba /root/rpmbuild/SPECS/nginx-module-image-filter.spec
rpmbuild -ba /root/rpmbuild/SPECS/nginx-module-njs.spec
rpmbuild -ba /root/rpmbuild/SPECS/nginx-module-perl.spec
rpmbuild -ba /root/rpmbuild/SPECS/nginx-module-xslt.spec

#rpm -Uvh /root/rpmbuild/RPMS/x86_64/nginx-$NGINX_VERSION.el7.centos.ngx.x86_64.rpm
