dnl $Id$
dnl config.m4 for extension timing

dnl Comments in this file start with the string 'dnl'.
dnl Remove where necessary. This file will not work
dnl without editing.

dnl If your extension references something external, use with:

dnl PHP_ARG_WITH(timing, for timing support,
dnl Make sure that the comment is aligned:
dnl [  --with-timing             Include timing support])

dnl Otherwise use enable:

PHP_ARG_ENABLE(timing, whether to enable timing support,
[  --enable-timing           Enable timing support])

if test "$PHP_TIMING" != "no"; then
  dnl Write more examples of tests here...

  dnl # --with-timing -> check with-path
  dnl SEARCH_PATH="/usr/local /usr"     # you might want to change this
  dnl SEARCH_FOR="/include/timing.h"  # you most likely want to change this
  dnl if test -r $PHP_TIMING/$SEARCH_FOR; then # path given as parameter
  dnl   TIMING_DIR=$PHP_TIMING
  dnl else # search default path list
  dnl   AC_MSG_CHECKING([for timing files in default path])
  dnl   for i in $SEARCH_PATH ; do
  dnl     if test -r $i/$SEARCH_FOR; then
  dnl       TIMING_DIR=$i
  dnl       AC_MSG_RESULT(found in $i)
  dnl     fi
  dnl   done
  dnl fi
  dnl
  dnl if test -z "$TIMING_DIR"; then
  dnl   AC_MSG_RESULT([not found])
  dnl   AC_MSG_ERROR([Please reinstall the timing distribution])
  dnl fi

  dnl # --with-timing -> add include path
  dnl PHP_ADD_INCLUDE($TIMING_DIR/include)

  dnl # --with-timing -> check for lib and symbol presence
  dnl LIBNAME=timing # you may want to change this
  dnl LIBSYMBOL=timing # you most likely want to change this 

  dnl PHP_CHECK_LIBRARY($LIBNAME,$LIBSYMBOL,
  dnl [
  dnl   PHP_ADD_LIBRARY_WITH_PATH($LIBNAME, $TIMING_DIR/$PHP_LIBDIR, TIMING_SHARED_LIBADD)
  dnl   AC_DEFINE(HAVE_TIMINGLIB,1,[ ])
  dnl ],[
  dnl   AC_MSG_ERROR([wrong timing lib version or lib not found])
  dnl ],[
  dnl   -L$TIMING_DIR/$PHP_LIBDIR -lm
  dnl ])
  dnl
  dnl PHP_SUBST(TIMING_SHARED_LIBADD)

  PHP_NEW_EXTENSION(timing, timing.c, $ext_shared)
fi
