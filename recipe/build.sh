#!/bin/bash

## copy precomputed files
cp ${RECIPE_DIR}/patches/Makevars src/Makevars
cp ${RECIPE_DIR}/patches/zzz.R R/unix/zzz.R

if [[ $target_platform =~ osx-* ]]; then
  sed -ie 's/.Platform\$dynlib.ext/".so"/g' R/jags.R
fi

export DISABLE_AUTOBREW=1
find $PREFIX -name basemod* -print
# shellcheck disable=SC2086
$R CMD INSTALL --no-configure -build . ${R_ARGS}
