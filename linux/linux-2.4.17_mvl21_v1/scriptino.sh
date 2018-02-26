#!/bin/sh
#
for i in $(cat filelist)
do
	svn del  $i
done
