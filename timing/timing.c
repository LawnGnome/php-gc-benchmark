
#ifdef HAVE_CONFIG_H
#include "config.h"
#endif

#include "php.h"
#include "php_ini.h"
#include "ext/standard/info.h"
#include "php_timing.h"
#include "zend_gc.h"

/* Remove if there's nothing to do at request end */
/* {{{ PHP_RSHUTDOWN_FUNCTION
 */
PHP_RSHUTDOWN_FUNCTION(timing)
{
	printf("GC duration:  %ld\n", GC_G(duration));
	printf("GC runs:      %u\n",  GC_G(gc_runs));
	printf("GC collected: %u\n",  GC_G(collected));

	return SUCCESS;
}
/* }}} */

/* {{{ PHP_MINFO_FUNCTION
 */
PHP_MINFO_FUNCTION(timing)
{
	php_info_print_table_start();
	php_info_print_table_header(2, "timing support", "enabled");
	php_info_print_table_end();
}
/* }}} */

/* {{{ timing_module_entry
 */
zend_module_entry timing_module_entry = {
	STANDARD_MODULE_HEADER,
	"timing",
	NULL,
	NULL,
	NULL,
	NULL,
	PHP_RSHUTDOWN(timing),	/* Replace with NULL if there's nothing to do at request end */
	PHP_MINFO(timing),
	PHP_TIMING_VERSION,
	STANDARD_MODULE_PROPERTIES
};
/* }}} */

#ifdef COMPILE_DL_TIMING
ZEND_GET_MODULE(timing)
#endif

/*
 * Local variables:
 * tab-width: 4
 * c-basic-offset: 4
 * End:
 * vim600: noet sw=4 ts=4 fdm=marker
 * vim<600: noet sw=4 ts=4
 */
