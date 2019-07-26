#!/bin/bash

if [[ $target_platform == osx-64 ]]; then
  sed -ie 's/.Platform\$dynlib.ext/".so"/g' R/jags.R
fi

if [[ $target_platform =~ linux.* ]] || [[ $target_platform == win-32 ]] || [[ $target_platform == win-64 ]] || [[ $target_platform == osx-64 ]]; then
  export DISABLE_AUTOBREW=1
  find $PREFIX -name basemod* -print
  $R CMD INSTALL --configure-args='--enable-rpath' --build .
else
  mkdir -p $PREFIX/lib/R/library/rjags
  mv * $PREFIX/lib/R/library/rjags
fi
