#!/bin/bash
# This file is part of Neptune354.
#
#    Neptune354 is free software; you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation; either version 3 of the License, or
#    (at your option) any later version.

#    Neptune354 is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.

#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <http://www.gnu.org/licenses/>.

#Script to build the firmware. If arg2 is packages, no clean is performed, and kernel is not re-built

#export PATH=$PATH:/opt/cy/mipsfple/bin:/opt/cy/mipsfple-uclibc/bin
#Stop on errors
set -e


ROUTER_FILE=router_type.def
ROUTER_FILE_INCLUDE=include/router_type.h

clear

#Get new input if ROUTER_FILE not found
if [ ! -f $ROUTER_FILE ]
then
	echo "Enter router type [ WAG354G | WAG354GV2 | HG200 ]"
	read -e PROJECT
	echo "Enter annex  type [ AnnexA | AnnexB ]"
	read -e ADSL_TYPE
	
	echo PROJECT=$PROJECT >> router_type.def
	echo ADSL_TYPE=$ADSL_TYPE >> router_type.def
else
        . $ROUTER_FILE
fi


#Validate input
if [[ $PROJECT = WAG354G ]] || [[ $PROJECT = WAG354GV2 ]] || [[ $PROJECT = HG200 ]]
then
	if [[ $ADSL_TYPE = AnnexA ]] || [[ $ADSL_TYPE = AnnexB ]]
	then
		echo "Inputs are ok."
	else
		echo "Input error"
		rm $ROUTER_FILE
		echo "Bye."
		exit 0
	fi
else
	echo "Input error"
	rm $ROUTER_FILE
	echo "Bye."
	exit 0
fi


#Ask if settings are ok
echo -e "\n\nBuilding firmware for $PROJECT with adsl type $ADSL_TYPE."
echo -n "Continue? [y/n] "
read -e ANSWER
if [[ $ANSWER != "y" ]]
then
	rm $ROUTER_FILE
	echo "Bye."
	exit 0
fi
	
#Step 1: set up the headers
rm -f $ROUTER_FILE_INCLUDE
echo "#ifndef ROUTER_TYPE_H" >> $ROUTER_FILE_INCLUDE
echo "#define ROUTER_TYPE_H" >> $ROUTER_FILE_INCLUDE
if [[ $PROJECT = WAG354G ]]
then
	echo "#define	PROJECT		WAG354G" >> $ROUTER_FILE_INCLUDE
	echo "#define	MonitorMinorRev_PSBL	22" >> $ROUTER_FILE_INCLUDE
	echo "#define	TelogyMonitorRev_PSBL	19" >> $ROUTER_FILE_INCLUDE
	
elif [[ $PROJECT = WAG354GV2 ]]
then
	echo "#define	PROJECT		WAG354GV2" >> $ROUTER_FILE_INCLUDE
	echo "#define	MonitorMinorRev_PSBL	23" >> $ROUTER_FILE_INCLUDE
	echo "#define	TelogyMonitorRev_PSBL	02" >> $ROUTER_FILE_INCLUDE
elif [[ $PROJECT = HG200 ]]
then
	echo "#define	PROJECT		HG200" >> $ROUTER_FILE_INCLUDE
	echo "#define	MonitorMinorRev_PSBL	22" >> $ROUTER_FILE_INCLUDE
	echo "#define	TelogyMonitorRev_PSBL	17" >> $ROUTER_FILE_INCLUDE
fi

if [[ $ADSL_TYPE = AnnexA ]]
then
	echo "#define	ADSL_TYPE	AnnexA" >> $ROUTER_FILE_INCLUDE
	echo "#define	HARDWARE_TYPE	0" >> $ROUTER_FILE_INCLUDE
elif [[ $ADSL_TYPE = AnnexB ]]
then
	echo "#define	ADSL_TYPE	AnnexB" >> $ROUTER_FILE_INCLUDE
	echo "#define	HARDWARE_TYPE	1" >> $ROUTER_FILE_INCLUDE
fi
echo "#endif" >> $ROUTER_FILE_INCLUDE

#Step2: set up the kernel
if [[ $PROJECT = WAG354G ]]
then
	cd linux
	rm -f linux-2.4.17_mvl21
	ln -s linux-2.4.17_mvl21_v1 linux-2.4.17_mvl21
	cd ..
elif [[ $PROJECT = WAG354GV2 ]]
then
	cd linux
	rm -f linux-2.4.17_mvl21
	ln -s linux-2.4.17_mvl21_v2 linux-2.4.17_mvl21
	cd ..
fi	


#Step3: compile!

sleep 1
	
#Full Build follows
cd router
#make linux-clean
#make linux-dep
#make linux
make clean
	

make 
make linux-modules
make install
make rom
make upgrade

exit 0;
