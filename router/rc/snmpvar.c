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
#include <fcntl.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <sys/types.h>
#include <dirent.h>
#include <time.h>
#include <net/if.h>
#include <sys/stat.h>
#include <unistd.h>
#include <stdarg.h>


#include <bcmnvram.h>
#include <shutils.h>
#include <rc.h>
/* Lai add for L2TP over PPPoE at 2005.12.02 */
#include "rc.h"
#include "pvc.h"
#include <code_pattern.h>
#include <utils.h>
#include <cy_conf.h>
#define my_print(fmt,args...)  
#define nvram_saft_get(name) (nvram_get(name)?:"")
#define writefile(fname,buff,size) \
        size=strlen(buff);\
	if(write(fname,buff,size)!=size)\
{\
	printf("error: can't write file ");\
		close (fname);\
}\
/* Lai add for L2TP over PPPoE at 2005.12.02 */
extern struct vcc_config *vcc_config_ptr;
extern int which_conn;

/* Lai modify at 2006.09.25 */
int create_snmpvar(void)
{
	int fp, ft, length;
    char v2setuser[40], v2readuser[40];
	char v3support[10], traphost[20];
    char buf[250], *ptr;
        
	if((fp=open("/var/snmpd.conf",O_WRONLY|O_CREAT|O_TRUNC))==-1)
    {
    	printf("Cannot open conf write file exit!");
        exit(1);
    }
    eval("rm", "-rf","/var/ucd-snmp");
    eval("mkdir", "/var/ucd-snmp");
    if((ft=open("/var/ucd-snmp/snmpd.conf",O_WRONLY|O_CREAT|O_TRUNC))==-1)
    {
    	printf("Cannot open ucd write file exit!");
        exit(1);
    }
	strcpy(v3support, nvram_saft_get("snmpv3_support"));
	strcpy(v2setuser, nvram_saft_get("set_auth"));
    strcpy(v2readuser, nvram_saft_get("get_auth"));
	strcpy(traphost, nvram_saft_get("trap_ipaddr"));
    ptr = traphost;
    
   	if(!strcmp(v3support, "Disable"))
	{
		/* Specify an SNMPv1 or SNMPv2c community that will be allowed read-only
	   	   (GET and GETNEXT) or read-write (GET,GETNEXT and SET) access 
	   	   respectively -- Lai 2006.03.16 */
		if (!strcmp(v2readuser, v2setuser))
			sprintf(buf, "rwcommunity %s\n", v2setuser);
		else
			sprintf(buf, "rocommunity %s\nrwcommunity %s\n",v2readuser,v2setuser);
    	writefile(fp, buf, length);
	}
	else
	{
		/* Using following way to sepcify an SNMPv3 user that will be 
		   allowed read-only or write-read access respectively 
		   rouser USER [noauth|auth|priv]
		   rwuser USER [noauth|auth|priv]
                   Lai 2006.03.16 */
    	char v3rwuser[40], v3authpasw[50], v3privpasw[50];
		char privprotocol[10], authprotocol[10];

  		strcpy(v3rwuser,nvram_saft_get ("v3rwuser"));
    	strcpy(v3authpasw,nvram_saft_get ("v3authpasw"));
    	strcpy(v3privpasw,nvram_saft_get ("v3privpasw"));
    	strcpy(authprotocol,nvram_saft_get ("authprotocol"));
    	strcpy(privprotocol,nvram_saft_get ("privprotocol"));

		sprintf(buf,"rwuser %s\n",v3rwuser);
      	writefile(fp,buf,length);
       	if (!strcmp (privprotocol, "None"))
       	{
           	sprintf (buf, "createUser %s %s %s\n", v3rwuser, authprotocol, v3authpasw);
      	}
    #ifdef HTTPS_SUPPORT	
		else
      	{
           	sprintf(buf,"createUser %s %s %s %s %s\n",v3rwuser,authprotocol,v3authpasw,privprotocol,v3privpasw);
       	}
	#else
		else
		{
           	sprintf(buf,"createUser %s %s %s\n",v3rwuser,authprotocol,v3authpasw);
		}
	#endif	
      	writefile(fp,buf,length);
       	if (!strcmp (privprotocol, "None"))
       	{
           	sprintf(buf,"trapsess -v 3 -u %s -l authNoPriv -a %s -A %s %s:162\n",v3rwuser,authprotocol,v3authpasw,ptr);
           	writefile(fp,buf,length);
           	sprintf(buf,"createUser %s %s %s\n",v3rwuser,authprotocol,v3authpasw);       
		}
    #ifdef HTTPS_SUPPORT
		else
       	{
       		sprintf(buf,"trapsess -v 3 -u %s -l authPriv -a %s -A %s -x %s -X %s %s:162\n",v3rwuser,authprotocol,v3authpasw,privprotocol,v3privpasw,ptr);
           	writefile(fp,buf,length);
           	sprintf(buf,"createUser %s %s %s %s %s\n",v3rwuser,authprotocol,v3authpasw,privprotocol,v3privpasw);
      	}
	#else
		else
		{	
      		sprintf(buf,"trapsess -v 3 -u %s -l authNoPriv -a %s -A %s %s:162\n",v3rwuser,authprotocol,v3authpasw,ptr);
           	writefile(fp,buf,length);
           	sprintf(buf,"createUser %s %s %s\n",v3rwuser,authprotocol,v3authpasw);
		}
	#endif	
   	 	writefile(ft,buf,length);
	}
	sprintf(buf, "trapsink %s\ntrap2sink %s\ninformsink %s\n", ptr, ptr, ptr);
	writefile(fp, buf, length);
	close (fp);
    close (ft);
    return 0;
}
#define PRINTD(args...)

/* Lai modify at 2005.08.23 */
int start_snmp(void)
{          
	int ret = 0;
    char buf[64];

    if (nvram_match ("snmp_enable", "1"))
	{      
   		create_snmpvar ();
	#ifdef L2TP_SUPPORT
		{
          	struct in_addr network_addr, netmask_addr, eth_addr;
           	unsigned int ip_addr;
           	char *str_addr;
                       	
			if (inet_aton(nvram_safe_get("l2tp_lan_network"), &network_addr) && (inet_aton(nvram_safe_get ("l2tp_lan_netmask"), &netmask_addr))) 
			{
           		ip_addr = ntohl(network_addr.s_addr & netmask_addr.s_addr)+1;
           		eth_addr.s_addr = htonl(ip_addr);
           		str_addr = inet_ntoa(eth_addr);
           		which_conn = atoi(nvram_safe_get("wan_active_connection"));
          		vcc_global_init();
           		if (strstr(encapmode, "l2tp_ppp"))
              		snprintf(buf, 65, "snmpd");
				else 
              		snprintf(buf, 65, "snmpd");
			}
			else
               	snprintf(buf, 65, "snmpd");
		}
	#else
		snprintf(buf, 65, "snmpd");
	#endif /* L2TP_SUPPORT */
	}
    system(buf);
    return ret;
}

int stop_snmp (void)
{   
	int ret = 0;   
        
	ret = eval ("killall","-9","snmpd");
    return ret;
}

