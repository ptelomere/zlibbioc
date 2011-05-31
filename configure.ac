AC_INIT("DESCRIPTION")

: ${R_HOME=`R RHOME`}
if test -z "${R_HOME}"; then
  echo "could not determine R_HOME"
  exit 1
fi
R_CC=`"${R_HOME}/bin/R" CMD config CC`

cd src/zlib-1.2.5 && \
  CC=${R_CC} ./configure --zprefix && \
  cd ../..

AC_OUTPUT(src/Makevars)
