#!/bin/bash
cd $(dirname $0)
BASE=$(pwd)
cd debian #/home/ryan/Backports/debian ;
apt-ftparchive generate -c=${BASE}/aptftp.conf ${BASE}/aptgenerate.conf
apt-ftparchive release -c=${BASE}/aptftp.conf dists/stretch >dists/stretch/Release
rm -f dists/stretch/Release.gpg 
gpg -u 0E3262EB787BF6A279A6DBCA9BEB60027612AE6D -bao dists/stretch/Release.gpg dists/stretch/Release
echo 'Package archive created!'