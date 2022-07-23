#!/bin/bash

if [ "$UID" != "0" ]; then
  echo "This script must be run with sudo"
  exit 1
fi

REPO=https://github.com/powerline/fonts/raw/master
FONTDIR=/usr/share/fonts/truetype/literation

mkdir -p $FONTDIR

curl -L $REPO/LiberationMono/Literation%20Mono%20Powerline%20Bold%20Italic.ttf -o $FONTDIR/Literation_Mono_Powerline_Bold_Italic.ttf
curl -L $REPO/LiberationMono/Literation%20Mono%20Powerline%20Bold.ttf -o $FONTDIR/Literation_Mono_Powerline_Bold.ttf
curl -L $REPO/LiberationMono/Literation%20Mono%20Powerline%20Italic.ttf -o $FONTDIR/Literation_Mono_Powerline_Italic.ttf
curl -L $REPO/LiberationMono/Literation%20Mono%20Powerline.ttf -o $FONTDIR/Literation_Mono_Powerline.ttf

#fc-cache
