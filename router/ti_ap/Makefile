#
# Router Wireless Interface Configuration Utility Makefile
#
# Copyright 2001-2003, Broadcom Corporation
# All Rights Reserved.
# 
# THIS SOFTWARE IS OFFERED "AS IS", AND BROADCOM GRANTS NO WARRANTIES OF ANY
# KIND, EXPRESS OR IMPLIED, BY STATUTE, COMMUNICATION OR OTHERWISE. BROADCOM
# SPECIFICALLY DISCLAIMS ANY IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS
# FOR A SPECIFIC PURPOSE OR NONINFRINGEMENT CONCERNING THIS SOFTWARE.
#
# $Id: Makefile,v 1.5 2005/03/22 12:50:28 sparq Exp $
#

include $(TOP)/.config

ifneq ($(wildcard $(SRCBASE)/cy_conf.mak),)
  include $(SRCBASE)/cy_conf.mak
endif
include $(SRCBASE)/router_type.def

ifeq ($(FLASH_SIZE), 8)
	ifeq ($(WL_OLD_CODE),y)
			APDK_VERSION := 5.5.4
	else
			APDK_VERSION := 5.7.0.4_8
	endif
else
	ifeq ($(FLASH_SIZE), 4)
		ifeq ($(WL_OLD_CODE),y)
			APDK_VERSION := 5.5.20
		else
			APDK_VERSION := 5.7.0.4_4
		endif
	endif
endif


ifeq ($(PROJECT), WAG354GV2)
	VERSION := v2
else
	VERSION := v1
endif



all:

clean:
	rm -f $(TOP)/lib/modules/2.4.17_mvl21-malta-mips_fp_le/kernel/drivers/net/tiap.o
	rm -f $(TOP)/lib/modules/2.4.17_mvl21-malta-mips_fp_le/kernel/drivers/net/writemac.o

install:
	
	install -D lib/$(VERSION)/tiap_$(APDK_VERSION).o $(TOP)/lib/modules/2.4.17_mvl21-malta-mips_fp_le/kernel/drivers/net/tiap.o
	install -D lib/$(VERSION)/writemac.o $(TOP)/lib/modules/2.4.17_mvl21-malta-mips_fp_le/kernel/drivers/net/writemac.o
	install -D bin/$(VERSION)/wpa_authenticator_$(APDK_VERSION) $(INSTALLDIR)/ti_ap/usr/sbin/wpa_authenticator
ifeq ($(PROJECT), WAG354GV2)
	install -D lib/$(VERSION)/hsk_drv.o $(TOP)/lib/modules/2.4.17_mvl21-malta-mips_fp_le/kernel/drivers/net/hsk_drv.o
	cd $(INSTALLDIR)/ti_ap/usr/sbin && ln -sf wlcfg wlnv
	install -D lib/v2/libhidden_prof.so $(INSTALLDIR)/ti_ap/usr/lib/libhidden_prof.so
	install -D lib/v2/libWdsMngr.so     $(INSTALLDIR)/ti_ap/usr/lib/libWdsMngr.so
endif
	install -D bin/$(VERSION)/wlcfg $(INSTALLDIR)/ti_ap/usr/sbin/wlcfg
	$(STRIP) $(INSTALLDIR)/ti_ap/usr/sbin/wlcfg
	cd $(INSTALLDIR)/ti_ap/usr/sbin && ln -sf wlcfg antsel

