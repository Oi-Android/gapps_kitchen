#!/sbin/sh
#
# Functions for backuptool.sh
#

export S=/system

# removes subdirectories if found apk (v 5.0.1+)
delete_file() {
  local DIR=`dirname "$1"`
  if [ -e $1 ]; then
    if ( echo "$1" | grep -q "\.apk$" ); then
     rm -r $DIR
    else
     rm -rf $1
    fi
  fi
}

# crutch for compatibility with other gapps 
backup_file() {
  delete_file $1
}

