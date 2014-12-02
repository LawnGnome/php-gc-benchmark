#ifndef PHP_TIMING_H
#define PHP_TIMING_H

extern zend_module_entry timing_module_entry;
#define phpext_timing_ptr &timing_module_entry

#define PHP_TIMING_VERSION "0.1.0" /* Replace with version number for your extension */

#ifdef PHP_WIN32
#	define PHP_TIMING_API __declspec(dllexport)
#elif defined(__GNUC__) && __GNUC__ >= 4
#	define PHP_TIMING_API __attribute__ ((visibility("default")))
#else
#	define PHP_TIMING_API
#endif

#ifdef ZTS
#include "TSRM.h"
#endif

#endif	/* PHP_TIMING_H */

