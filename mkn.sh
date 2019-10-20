#!/usr/bin/env bash
set -e
CWD="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
VERSION="master"
DIR="eigen"
GIT_URL="https://github.com/eigenteam/eigen-git-mirror"
HAS=1
[ ! -d "$CWD/$DIR" ] && HAS=0 && git clone --depth 1 $GIT_URL -b $VERSION $DIR --recursive --shallow-submodules
cd $CWD/$DIR
[ $HAS -eq 1 ] && git pull --recurse-submodules origin $VERSION
rm -rf build && mkdir build && cd build
read -r -d '' CMAKE <<- EOM || echo "running cmake"
cmake -DCMAKE_INSTALL_PREFIX=$CWD
      -DCMAKE_BUILD_TYPE=Release ..
EOM
$CMAKE && make -j && make install
rm -rf $CWD/$DIR/build
