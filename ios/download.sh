#!/bin/bash

WORKSPACE="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
cd $WORKSPACE

# Exit if in debugging mode
if [ -f $WORKSPACE/../.debugging ]; then
  exit 0
fi

# Determine DEPSURL based on whether DEPS is a URL or not
if [[ $DEPS == http* ]]; then
  DEPSURL=$DEPS
else
  DEPSURL=$(grep 'ios:' $WORKSPACE/../DEPS.yaml | cut -d ' ' -f 2)
fi

# Extract the version number from DEPSURL
DEPSVER=$(echo $DEPSURL | cut -d'?' -f2 | cut -d'=' -f2)

LIBSDIR=$WORKSPACE/libs
mkdir -p $LIBSDIR

# Check existing version and exit if matches
if [ -f $LIBSDIR/VERSION.txt ] && [ -f $LIBSDIR/ZegoExpressEngine.xcframework/Info.plist ]; then
  VERSION=$(head -n 1 "$LIBSDIR/VERSION.txt" | tr -d '\n')
  if [ "$VERSION" = "$DEPSVER" ]; then
    exit 0
  fi
fi

# Download and extract new SDK if version does not match
curl -s "$DEPSURL" --output $LIBSDIR/sdk.zip
unzip -q -o $LIBSDIR/sdk.zip -d $LIBSDIR

# Move and clean up files
rm -rf $LIBSDIR/ZegoExpressEngine.xcframework
mv $LIBSDIR/release/Library/ZegoExpressEngine.xcframework $LIBSDIR
mv -f $LIBSDIR/release/VERSION.txt $LIBSDIR

rm -rf $LIBSDIR/release
rm -f $LIBSDIR/sdk.zip

exit 0
