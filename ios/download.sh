#!/bin/bash

WORKSPACE="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
cd $WORKSPACE

if [ -f $WORKSPACE/../.debugging ]; then
  exit 0
fi

if [[ $DEPS == http* ]]; then
  DEPSURL=$DEPS
else
  DEPSURL=$(grep 'ios:' $WORKSPACE/../DEPS.yaml | cut -d ' ' -f 2)
fi

DEPSVER=$(echo $DEPSURL | cut -d'?' -f2 | cut -d'=' -f2)

LIBSDIR=$WORKSPACE/libs
mkdir -p $LIBSDIR

if [ -f $LIBSDIR/VERSION.txt ] && [ -f $LIBSDIR/ZegoExpressEngine.xcframework/Info.plist ]; then
  VERSION=$(head -n 1 "$LIBSDIR/VERSION.txt" | tr -d '\n')
  if [ "$VERSION" = "$DEPSVER" ]; then
    exit 0
  else
  fi
fi

curl -s "$DEPSURL" --output $LIBSDIR/sdk.zip
unzip -q -o $LIBSDIR/sdk.zip -d $LIBSDIR

rm -rf $LIBSDIR/ZegoExpressEngine.xcframework
mv $LIBSDIR/release/Library/ZegoExpressEngine.xcframework $LIBSDIR
mv -f $LIBSDIR/release/VERSION.txt $LIBSDIR

rm -rf $LIBSDIR/release
rm -f $LIBSDIR/sdk.zip

exit 0
