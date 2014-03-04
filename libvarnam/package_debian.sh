#!/bin/sh

set -e

version=$@
started_directory=`pwd`

# If a libvarnam tar available at /tmp, use that. else download the specified version
# this allows local testing easy. just put the file to package in /tmp
source_tarball=/tmp/libvarnam-$version.tar.gz
if [ -f $source_tarball ]
then
	echo "Using $source_tarball"
else
	wget --directory-prefix /tmp http://download.savannah.gnu.org/releases/varnamproject/libvarnam/source/libvarnam-$version.tar.gz
fi

working_dir=`mktemp -d`
cp $source_tarball $working_dir/libvarnam_$version.orig.tar.gz
cd $working_dir
tar -xvf libvarnam_$version.orig.tar.gz && cd libvarnam-$version && cp -rf $started_directory/debian .
dpkg-buildpackage -us -uc
echo "Created package in: $working_dir"

echo "Linting the package"

