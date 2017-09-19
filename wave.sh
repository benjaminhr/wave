#!/bin/sh

set -e

case $1 in
  "install")
    echo "This might take a while... "

    brew_installed=$(which brew)
    if [ "$brew_installed" != "/usr/local/bin/brew" ]; then
      brew_installation=$(/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)")
      echo brew_installation
    else
      brew install ffmpeg
      brew install gifsicle
    fi

    echo "--------------Dependencies installed --------------"
  ;;

  "update")
    git pull
  ;;
esac

input=$1
output=$2

echo $(ffmpeg -i $input.mov -pix_fmt rgb24 -r 10 -f gif - | gifsicle --optimize=3 --delay=3 > $ouput.gif)
