#!/bin/sh
#
for i in $(cat filelist)
do
	rm $i
done
