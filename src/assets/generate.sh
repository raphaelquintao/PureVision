#!/bin/bash

BG_COLOR="#2B3136"
BS_COLOR="#434F5B"
FG_COLOR="#B2B9BF"


DIR="$( cd "$( dirname "$0" )" && pwd )"

render_assets() {
THEME_NAME="PureVision"
# shellcheck disable=SC2123
PATH="./build/$THEME_NAME"

INKSCAPE="/usr/bin/inkscape"
OPTIPNG="/usr/bin/optipng"

SRC_FILE="$PATH/assets.svg"
TMP_FILE="$PATH/tmp.svg"
ASSETS_DIR="$PATH/assets"
INDEX="$PATH/assets.txt"

sed "s/#ff9900/$FG_COLOR/g" $SRC_FILE > $TMP_FILE

if [[ ! -ne $ASSETS_DIR ]]; then
    echo "$ASSETS_DIR already exists but is not a directory"
    mkdir -r $ASSETS_DIR
elif [[ ! -d $ASSETS_DIR ]]; then
    echo "$ASSETS_DIR already exists but is not a directory" 1>&2
fi

for i in `cat $INDEX`
do
#if [ -f $ASSETS_DIR/$i.png ]; then
# echo " * $ASSETS_DIR/$i.png exists."
#fi
echo "Rendering $ASSETS_DIR/$i.png"
$INKSCAPE --export-id=$i \
          --export-id-only \
          --export-plain-svg=$ASSETS_DIR/$i.svg $TMP_FILE >/dev/null
#          --export-svg=$ASSETS_DIR/$i.svg $TMP_FILE >/dev/null
# && $OPTIPNG -o7 --quiet $ASSETS_DIR/$i.png
done

rm $TMP_FILE




}

render_assets

exit 0
