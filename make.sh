#!/bin/sh
XE_VERSION=$1

BUILD_DIR="./build"
SRC_DIR="./src"
XE_BIN_DIR="./xe"
XE="$XE_BIN_DIR/xe-$XE_VERSION.zip"

if [ -z "$XE_VERSION" ]; then
    echo "usage: $0 XE_VERSION"
    echo "example: $0 1.7.8"
    echo "available xe distribution"
    for f in $XE_BIN_DIR/*.zip
    do
        echo "  " $f
    done
    exit 1
fi

clean() {
    rm -fr $BUILD_DIR
    echo "clean OK."
}

copy_contents() {
    mkdir $BUILD_DIR
    cp -r $SRC_DIR/ $BUILD_DIR
    unzip -q $XE -d $BUILD_DIR/package
    echo "contents build OK."
}

make_spk() {
    cd $BUILD_DIR/package
    tar -czf package.tgz *
    mv package.tgz ..
    cd ..
    rm -fr ./package

    tar -czvf xe-$XE_VERSION-unsigned.spk *

    echo "package OK."
}

clean;
copy_contents;
make_spk;

