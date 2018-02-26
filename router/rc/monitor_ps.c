
/*
 *********************************************************
 *   Copyright 2003, CyberTAN  Inc.  All Rights Reserved *
 *********************************************************

 This is UNPUBLISHED PROPRIETARY SOURCE CODE of CyberTAN Inc.
 the contents of this file may not be disclosed to third parties,
 copied or duplicated in any form without the prior written
 permission of CyberTAN Inc.

 This software should be used as a reference only, and it not
 intended for production use!


 THIS SOFTWARE IS OFFERED "AS IS", AND CYBERTAN GRANTS NO WARRANTIES OF ANY
 KIND, EXPRESS OR IMPLIED, BY STATUTE, COMMUNICATION OR OTHERWISE.  CYBERTAN
 SPECIFICALLY DISCLAIMS ANY IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS
 FOR A SPECIFIC PURPOSE OR NONINFRINGEMENT CONCERNING THIS SOFTWARE
*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <signal.h>
#include <unistd.h>
#include <errno.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <wait.h>

#include <bcmnvram.h>
#include <netconf.h>
#include <shutils.h>
#include <utils.h>
#include <cy_conf.h>
#include <code_pattern.h>
#include <rc.h>

struct mon {
	char *name;		// Process name
	char *nvram_name;	// Process name as in nvram ?_enable
	int count;		// Process conut, 0 means don't check
	int type;		// LAN or WAN
	int (*stop)(void);	// stop function
	int (*start)(void);	// start function
};

enum {M_LAN, M_WAN};

struct mon mons[] = {
	//Lan procs
	{ "tftpd",	NULL,	1,	M_LAN,	stop_tftpd,		start_tftpd},
	{ "httpd",	NULL,	1,	M_LAN,	stop_httpd,		start_httpd},
	//FIX THIS!
	{ "ntpd",	NULL,	1,	M_LAN,	stop_ntp,		start_ntp},
	{ "udhcpd",	NULL,	1,	M_LAN,	stop_dhcpd,		start_dhcpd},
	//Wan procs
	//{ "upnpd-igd",	"upnp_enable",	1,	M_WAN,	stop_upnp_pak,		start_upnp },
	//{ "dnsmasq",	NULL,	1,	M_WAN,	stop_dns,		start_dns},
	
};

int
search_process(char *name, int count)
{
	int *pidList = NULL;
	int c = 0;

	pidList = find_all_pid_by_ps(name);
	if(pidList && *pidList > 0){
	    for(; pidList && *pidList!=0; pidList++) {
		dprintf("Find %s which pid is %d\n", name, *pidList);
		c ++;
	    }
	}

	if(!c){
		cprintf("Can't find %s\n", name);
		return 0;
	}
	else{
		dprintf("Find %s which count is %d\n", name, c);
		if(count && c != count){
			cprintf("%s count is not match\n", name);
			return 0;
		}
		else
			return 1;
	}
}

void stop_upnp_pak()
{
	stop_upnp(0);
	return;
}

int
do_mon(void)
{
	struct mon *v;
	
	//iterate on the list of processes
	for(v = mons ; v < &mons[sizeof(mons)/sizeof(mons[0])] ; v++)
	{
		if(!search_process(v->name, v->count)) //if process is not found
		{
			//If wan is not active, the process should not be running
			//If the process is not enabled in nvram, it should not be running
			if(    ( nvram_match( v->nvram_name, "0" ) ) ||   (  v->type == M_WAN && !check_wan_link(atoi(nvram_safe_get("wan_active_connection")))   )  )
					continue;
			//Macro-instruction eventually skipped by continue
			{
				cprintf(" %s is not running , restarting...\n", v->name);
				if(v->stop)
					v->stop();
				sleep(1);
				if(v->start)
					v->start();
			}
		}
	}

	if(strstr(nvram_safe_get("fqdn_cfg"),"1"))
	{
		check_ipsec_fqdn();
	}

	return 1;
}



int
monitor_ps_main(int argc, char**argv)
{
	pid_t pid;

	if(check_action() != ACT_IDLE){ // Don't execute during upgrading
		cprintf("nothing to do...\n");
		sleep(120);
		return 1;
	}

	pid = fork();
	switch(pid)
	{
		case -1:
			perror("fork failed");
			exit(1);
			break;
		case 0:
			do_mon();
			exit(0);
			break;
		default:
			_exit(0);
			break;
	}
}
