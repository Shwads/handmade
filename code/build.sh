#!/bin/bash

LINKER_FLAGS="-framework AppKit"


mkdir ../build
pushd ../build

clang -g $LINKER_FLAGS -o handmade ../code/osx_main.mm

popd
