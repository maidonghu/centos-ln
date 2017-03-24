<?php
/**
 * The base configuration for WordPress
 *
 * The wp-config.php creation script uses this file during the
 * installation. You don't have to use the web site, you can
 * copy this file to "wp-config.php" and fill in the values.
 *
 * This file contains the following configurations:
 *
 * * MySQL settings
 * * Secret keys
 * * Database table prefix
 * * ABSPATH
 *
 * @link https://codex.wordpress.org/Editing_wp-config.php
 *
 * @package WordPress
 */

// ** MySQL settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define('DB_NAME', 'wordpress');

/** MySQL database username */
define('DB_USER', 'wpuser');

/** MySQL database password */
define('DB_PASSWORD', '1745401@Ch');

/** MySQL hostname */
define('DB_HOST', 'localhost');

/** Database Charset to use in creating database tables. */
define('DB_CHARSET', 'utf8mb4');

/** The Database Collate type. Don't change this if in doubt. */
define('DB_COLLATE', '');

/**#@+
 * Authentication Unique Keys and Salts.
 *
 * Change these to different unique phrases!
 * You can generate these using the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}
 * You can change these at any point in time to invalidate all existing cookies. This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
define('AUTH_KEY',         '7473KB_R3)h|G|-_]VL@,%wszNA+-lv6:>.s=%=kcIME,}S_kA2[L/@>ku[ p2^Q');
define('SECURE_AUTH_KEY',  'zpK*St)||Uhv2m!16<JG@0mT[~1cg+4ZzsLUuStqw^26/p5%;B*E-}1b{HzFGTAe');
define('LOGGED_IN_KEY',    'ycv^4)[z).X?>&zeL@_/K/C4aOwkRBaY`x>O?Bl%$C3t[tP+Iy`&TPJ1yq$`7A!p');
define('NONCE_KEY',        'Ky3S^_St~-mp$z@_+{b#I|$HDb0Eb$aipI%J2v/qlt!{l4R,=8b@wjiU+G^KA!)I');
define('AUTH_SALT',        'q}It{z%g.Py9f6z;~p18m_<`G<ho}F%I96a]%l}B!Fxr1m;JDGA8QnzT)fX+eNd;');
define('SECURE_AUTH_SALT', ',Gdf8#YW;1.Du2x-`2AMaeopg&o=c;syahlro|M?J^En$Q:, ,Ev?p=WSUe;[`Z*');
define('LOGGED_IN_SALT',   'Y )L%4SIh`DpCy-+nTcc/Sm>48BpLEEB|nh{sw{$/=6 OkFM)$k;`e6L3xdq?]CN');
define('NONCE_SALT',       '>3)^23Bk@<@m$g`J?I%@R/}TE1q,ekF&UYBSVI}x&p2ijt.$JYT~j:!N~HM?mv_d');

/**#@-*/

/**
 * WordPress Database Table prefix.
 *
 * You can have multiple installations in one database if you give each
 * a unique prefix. Only numbers, letters, and underscores please!
 */
$table_prefix  = 'wp_';

/**
 * For developers: WordPress debugging mode.
 *
 * Change this to true to enable the display of notices during development.
 * It is strongly recommended that plugin and theme developers use WP_DEBUG
 * in their development environments.
 *
 * For information on other constants that can be used for debugging,
 * visit the Codex.
 *
 * @link https://codex.wordpress.org/Debugging_in_WordPress
 */
define('WP_DEBUG', false);
define('WP_CACHE', true);
define('FS_METHOD','direct');

/* That's all, stop editing! Happy blogging. */

/** Absolute path to the WordPress directory. */
if ( !defined('ABSPATH') )
	define('ABSPATH', dirname(__FILE__) . '/');

/** Sets up WordPress vars and included files. */
require_once(ABSPATH . 'wp-settings.php');
