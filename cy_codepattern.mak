#Options to be moveD to make.sh!!!
#PROJECT=WAG354G
#ADSL_TYPE=AnnexA
#
#You dont need to edit anything below here
#
MonitorMajorRev=0
MonitorMinorRev=22
TelogyMonitorRev=6
MonitorMajorRev_PSBL=0
IncRev=TelogyMonitorRev_PSBL
BuildNum=5
CODE_TYPE=COMMON
CUSTOMER=VZ
LOCALE=EUROPE
RELCOUN=EUROPE
COUNTRY=LOCALE
FLASHTYPE=AMD
FLASH_SIZE=4
DRAM_SIZE=16
BOOT_SIZE=128
WEB_PAGE=wag354gm
#include router_type.def

ifeq ($(PROJECT),WAG354G)
	MonitorMinorRev_PSBL=22
	TelogyMonitorRev_PSBL=19
	ifeq ($(ADSL_TYPE),AnnexA)
		CODE_PATTERN=WA31
	else
		ifeq ($(ADSL_TYPE),AnnexB)
			CODE_PATTERN=WA32
		endif
	endif
else      #1 if
	ifeq ($(PROJECT),WAG354GV2)
		MonitorMinorRev_PSBL=23
6 		TelogyMonitorRev_PSBL=02
		ifeq ($(ADSL_TYPE),AnnexA)
			CODE_PATTERN=WA7A
		else
			ifeq ($(ADSL_TYPE),AnnexB)
				CODE_PATTERN=WA7B
			endif
		endif
	else            #2 if
		ifeq ($(PROJECT),HG200)
			MonitorMinorRev_PSBL=22
			TelogyMonitorRev_PSBL=17
			ifeq ($(ADSL_TYPE),AnnexA)
				CODE_PATTERN=HG1A
			else
				ifeq ($(ADSL_TYPE),AnnexB)
					CODE_PATTERN=HG1B
				endif
			endif
		endif
	endif       #2 if
endif          #1 if
