#!/bin/bash

if [[ $target_platform ~= osx-* ]]; then
  sed -ie 's/.Platform\$dynlib.ext/".so"/g' R/jags.R
fi

export DISABLE_AUTOBREW=1
find $PREFIX -name basemod* -print
# shellcheck disable=SC2086
$R CMD INSTALL --configure-args='--enable-rpath' --build . ${R_ARGS}

## BEGIN DEBUG
cat src/Makevars
cat R/unix/zzz.R
## END DEBUG
