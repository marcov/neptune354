#@Author: Marco Vedovati
#@Date  : 2007/02/22
#
#Makefile for install misc things in routerfs
#
include $(TOP)/.config

ifneq ($(wildcard $(SRCBASE)/cy_conf.mak),)
  include $(SRCBASE)/cy_conf.mak
endif

all:

install: all
	install -d $(INSTALLDIR)/etc/
	install $(TOP)/misc/profile $(INSTALLDIR)/etc/
	install $(TOP)/misc/banner  $(INSTALLDIR)/etc/
	install $(TOP)/misc/protocols  $(INSTALLDIR)/etc/
	install $(TOP)/misc/optimize.sh  $(INSTALLDIR)/etc/
	install $(TOP)/misc/ntpd.conf  $(INSTALLDIR)/etc/
	install -d $(INSTALLDIR)/sbin/
	install $(TOP)/misc/optware-install  $(INSTALLDIR)/sbin/
	
	
ifeq ($(CONFIG_DROPBEAR),y)
#	rm dropbear_rsa_host_key dropbear_dss_host_key
#	$(TOP)/misc/dropbearkey -t rsa -f dropbear_rsa_host_key
#	$(TOP)/misc/dropbearkey -t dss -f dropbear_dss_host_key
#	install -d $(INSTALLDIR)/etc/dropbear
#	install -m 700 $(TOP)/misc/dropbear_rsa_host_key $(INSTALLDIR)/etc/dropbear/
endif
		
clean: 
	rm -f *_host_key
