#!/bin/bash

backup=`pwd`
DIR="$( cd "$( dirname "$0" )" && pwd )"
cd "$DIR"

sh ./build-source.sh
dput ppa:teejee2008/ppa ../builds/aptik-battery-monitor*.changes

cd "$backup"
