#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include <broadcom.h>
#include <cy_conf.h>
#include <bcmnvram.h>
#include <cyutils.h>

#define DBKEY "/mnt/dropbear_rsa_host_key"

/*Change this and you will die!!*/
#define RWPART "/dev/mtdblock/4"
#define UPTIME_TMP	"/tmp/.uptime"

/*
 *  Test if ssh private key is located in DBKEY, and prints result to webif
 */
int
ej_get_dbkey_status(int eid, webs_t wp, int argc, char_t **argv)
{
	int ret = 0;
	FILE *fp;
	
	fp=fopen(DBKEY,"r");
	
	if ( fp == NULL )
	{
	//	cprintf("error reading a dropbear key\n");
		ret += websWrite(wp,"<b><font color=red>not setted</font></b>");
		if ( nvram_invmatch("rwpart_enable","1") )
			ret += websWrite(wp,"<br/>enable first rw partition!");
	}
	else
	{
	//	cprintf("\nThe ssh key is correctly setted\n");
		ret += websWrite(wp,"<b><font color=green>setted</font></b>");
		fclose(fp);
	}	

	return ret;
}

/*
 *  Generate a new sshd private key and stores it in DBKEY
 */
int
generate_sshkey(webs_t wp)
{
	int ret = 0;
	char cmd[80];
		
	cprintf("\nFirst removing old key..\n");
	system("rm -rf /mnt/dropbear_rsa_host_key");
	cprintf("\nNow generating dropbear key!\n");
	sprintf(cmd,"dropbearkey -t rsa -s 1024 -f %s", DBKEY);
	
	if (system(cmd)!=0)
	{
		cprintf("error creating dropbear key!!");
		do_ej("Fail.asp",wp);
		//websDone(wp, 200);				
	}
	else
	{	
		cprintf("\nNow unmount-remount to save changes!\n");
		system("umount /mnt");
		system("mount -t minix /dev/mtdblock/4 /mnt");
		do_ej("Success.asp",wp);
		//websDone(wp, 200);
	}
	
	return ret;
}

/*
 *  Create a new partition in RWPART
 */
 int 
create_partition(webs_t wp)
{
	int ret = 0;
	char cmd[80];
	char * value;
	
	cprintf("\nCreating the rw partition\n");
	
	system("umount /mnt");
	nvram_set("rwpart_enable","0");
	
	sprintf(cmd,"mkfs.minix %s", RWPART);
	if (system(cmd)!=0)
	{
		cprintf("\nError creating rw partition!\n");
		do_ej("Fail.asp",wp);
		//websDone(wp, 200);
	}
	else
	{	
		value =  websGetVar(wp, "mount", NULL);
		if (value != NULL)
		{
			cprintf("mounting the part\n");	
			sprintf(cmd,"mount -t minix -rw %s /mnt", RWPART);
			system(cmd);
		}
		cprintf("\nOki creating rw partition\n");
		do_ej("Success.asp",wp);
		//websDone(wp, 200);
	}
	return ret;
}

 
 /*
  * Returns router uptime
  */
char * string_uptime()
 {

 	FILE *fp;
 	int uptime;
 	int days,hours,minutes,seconds;
 	char * ret;
 	
 	if((fp = fopen("/proc/uptime","r")) == NULL){
 		sprintf(ret,"Error in uptime");
 		return ret;
 	}
   
 	fscanf(fp, "%d", &uptime);
   	fclose(fp);
 	minutes = uptime / 60;
 	hours = minutes / 60;
 	days = hours / 24;
  	seconds = uptime % 60;
  	minutes = minutes % 60;
  	hours = hours % 24;
  	
  	ret = malloc(100*sizeof(char));
  	sprintf(ret,"%d Day%s, %d Hour%s, %d Minute%s, %d Second%s",days,days!=1 ? "s": "",hours,hours!=1 ? "s" : "",minutes,minutes!=1 ? "s" : "", seconds, seconds!=1 ? "s" : "");
  	return ret;
  	
 }

char * string_load()
{
	char * token;
	FILE * fp;
	char * line = NULL;
	char * filepath = "/tmp/.uptime";
	char * cmd = NULL;
	size_t len;

	cmd = (char *)malloc((size_t)50);
	sprintf(cmd,"/usr/bin/uptime > %s",filepath);
	system(cmd);
	if((fp = fopen(filepath,"r")) == NULL)
	{
	 		sprintf(token,"Error in load");
	 		return token;
	}
	getline(&line, &len ,fp);
	fclose(fp);
	unlink(filepath);
	token = strchr(line,',');
	free(line);
	free(cmd);
	token=token+2;
	return token;
}
 
 
/*
 * Prints router uptime in web interface 
 */
int 
ej_get_uptime(int eid, webs_t wp, int argc, char_t **argv)
{

	FILE *fp;
	int uptime;
	int days,hours,minutes,seconds;
	if((fp = fopen("/proc/uptime","r")) == NULL){
		return websWrite(wp,"\nError in uptime\n");
	}
  
	fscanf(fp, "%d", &uptime);
  	fclose(fp);
	minutes = uptime / 60;
	hours = minutes / 60;
	days = hours / 24;
 	seconds = uptime % 60;
 	minutes = minutes % 60;
 	hours = hours % 24;
 	
 	return websWrite(wp,"%d Day%s, %d Hour%s, %d Minute%s, %d Second%s",days,days!=1 ? "s": "",hours,hours!=1 ? "s" : "",minutes,minutes!=1 ? "s" : "", seconds, seconds!=1 ? "s" : "");
 	
}

/*
 * Prints wan uptime in web interface 
 */
int 
ej_get_wanuptime(int eid, webs_t wp, int argc, char_t **argv)
{

	FILE *fp;
	int uptime;
	int wantime;
	int days,hours,minutes,seconds;
	if((fp = fopen("/proc/uptime","r")) == NULL){
		return websWrite(wp,"\nError wanuptime\n");
	}
  
	fscanf(fp, "%d", &uptime);
  	fclose(fp);
  	wantime = strtoul(nvram_safe_get("wanuptime0"), NULL, 0);
  	if(wantime == 0){
  		return websWrite(wp,"\nInterface Down\n");
  		}
 	else	
  	{
	uptime = uptime - wantime;
	minutes = uptime / 60;
	hours = minutes / 60;
	days = hours / 24;
	seconds = uptime % 60;
	minutes = minutes % 60;
	hours = hours % 24;
	
	return websWrite(wp,"%d Day%s, %d Hour%s, %d Minute%s, %d Second%s",days,days!=1 ? "s": "",hours,hours!=1 ? "s" : "",minutes,minutes!=1 ? "s" : "", seconds, seconds!=1 ? "s" : "");
 	}
}


int 
ej_show_cpuinfo(int eid, webs_t wp, int argc, char_t **argv)
{
	int ret = 0;
	FILE* fp;
	char *line = NULL;
	size_t len = 0;
	size_t read;
	fp=fopen("/proc/cpuinfo","r");
	fseek(fp, 0L, SEEK_SET);
	while((read = getline(&line,&len,fp))!=-1){ 
		ret += websWrite(wp,"%s<br>",line);
		//printf("%s<br>",line);
	}
	free(line);
	fclose(fp);
	return ret;	
}

int 
ej_show_meminfo(int eid, webs_t wp, int argc, char_t **argv)
{
	int ret = 0;
	FILE * fp;
	char * line = NULL;
	size_t len = 0;
	size_t read;
	fp=fopen("/proc/meminfo","r");
	fseek(fp, 0L, SEEK_SET);
	while((read = getline(&line,&len,fp))!=-1){
		ret += websWrite(wp,"%s<br/>",line);
		//printf("%s<br>",line);
	}
	free(line);
	fclose(fp);
	return ret;		
}


int
ej_show_macadd(int eid, webs_t wp, int argc, char_t **argv)
{
	int ret = 0;
	FILE * fp;
	char * line = NULL;
	size_t len = 0;
	size_t read;
	system("ifconfig nas0 > /tmp/.ifconfig");
	fp = fopen("/tmp/.ifconfig","r");
	if ( (read = getline(&line,&len,fp)) != -1){
		char *hwaddr = strstr(line, "HWaddr ");
		if (hwaddr!=NULL)
			ret += websWrite(wp,"<b>%s</b>",hwaddr);
		else
			ret += websWrite(wp,"<b>Error getting Wan MAC Address, probably interface is down.</b>");	
	}
	else
		ret += websWrite(wp,"<b>Error getting Wan MAC Address.</b>");
	free(line);
	fclose(fp);
	unlink("/tmp/.ifconfig");
	cprintf("ciao END");
	return ret;
}

unsigned strtobyte(char * byte)
{
	//This is a true hex number like "A0"
	unsigned hex;
	sscanf(byte, "%i", &hex);
	return hex;
}

#define ATUCNUM 8


typedef struct
{
	char * code;
	char * brand;
}atuc_t;


int ej_get_atuc(int eid, webs_t wp, int argc, char_t **argv)
{
	FILE * fp;
	//char * filepath="/proc/avalanche/avsar_modem_stats";
	const char * filepath="/tmp/avsar_modem_stats";
	char * line = NULL;
	char * substring=NULL;
	char letter[5];
	void * token = NULL;
	char * cp = NULL;
	const char delimiter[]="\t: ";
	
	size_t len = 0;
	
	int i,asciicode;
	
	atuc_t atuc[ATUCNUM];
	atuc[0].code="ALCB";
	atuc[0].brand="Alcatel (now ST Micro)";
	atuc[1].code="ANDV";
	atuc[1].brand="Analog Devices";
	atuc[2].code="BDCM";
	atuc[2].brand="Broadcom";
	atuc[3].code="GSPN";
	atuc[3].brand="Globespan";
	atuc[4].code="IFTN";
	atuc[4].brand="Infineon";
	atuc[5].code="STMI";
	atuc[5].brand="ST Micro";
	atuc[6].code="TMMB";
	atuc[6].brand="Thomson Multimedia Broadband";
	atuc[7].code="TSTC";
	atuc[7].brand="Texas Instruments";
	
	system("cp /proc/avalanche/avsar_modem_stats /tmp/");
        
	if ( (fp = fopen(filepath, "r")) == NULL ) 
		return ( websWrite(wp,"Error<br/>") );
	
	fseek(fp, 0L, SEEK_SET);
	getline(&line,&len,fp);
	line = strstr(line,"ATUC");
	
	/*
	 * Extract line where ATUC Vendor code is
	 */
	while (  (read!=(int)-1) &&  (line == NULL) )
	{
		getline(&line,&len,fp);
		line = strstr(line,"ATUC");
	}
	fclose(fp);
	unlink(filepath);
	
	if(line==NULL)
		return(websWrite(wp,"Error<br/>") );
	
	/*
	 * Extract ATUC Code as a string of bytes(token).
	 */
	substring = (char *) malloc(sizeof(char)*50);
	substring = strchr(line,':');
	token = strtok(substring, delimiter);
	//websWrite(wp,"The ATUC ASCII  Code is: %s<br/>",token);
	
	/*  Convert ascii token into characters:
	 *  Take 2 digits of asciicode and assign it to letter[].
	 *  Every element of letter[] is a BYTE corresponding to a character.
	 */
	cp = (char *)malloc((size_t)3);
	substring = malloc((size_t)sizeof("0x")+ (size_t)sizeof(cp));
	
	for(i=0 ; i<(int)sizeof(token) ; i++)
	{
		memcpy(cp,token+2*i,(size_t)2);
		sprintf(substring,"0x%s",cp);
		//printf("sub: %c\n",strtobyte(substring));
		letter[i] = strtobyte(substring);
	}
	letter[i]='\0';
	
	free(substring);
	free(cp);
	/*
	 * Prints the code
	 */
	for (i=0; letter[i]!='\0';i++)
	{
		websWrite(wp,"%c",letter[i]);
	}
	websWrite(wp,"&nbsp;--&nbsp;");

	/*
	 * Try to detect the brand of DSLAM
	 */
	for(i=0; i<ATUCNUM;i++)
		if ( memcmp(letter,atuc[i].code,4)==0 )
			return (websWrite(wp,"%s<br/>",atuc[i].brand));
	
	return (websWrite(wp,"Error getting the brand<br/>"));
	

}



int ej_get_dspver(int eid, webs_t wp, int argc, char_t **argv)
{
	size_t len = 0;
	FILE * fp;
	char * line = NULL;
	void * token = NULL;
	const char delimiter[]=":";
	const char * filepath="/tmp/avsar_ver";
	
	system("cp /proc/avalanche/avsar_ver /tmp/");
	
	if ( (fp = fopen(filepath, "r")) == NULL ) 
		return ( websWrite(wp,"Error<br/>") );
	
	fseek(fp, 0L, SEEK_SET);
	getline(&line,&len,fp);
	line = strstr(line,"DSP");
	
	/*
	 * Extract line where ATUC Vendor code is
	 */
	while (  (read!=(int)-1) &&  (line == NULL) )
	{
		getline(&line,&len,fp);
		line = strstr(line,"DSP");
	}
	
	fclose(fp);
	unlink(filepath);
	
	strtok(line, delimiter);
	token = strtok(NULL, delimiter);
	free(line);
	return (websWrite(wp,"%s",token));
}

int ej_get_freemem(int eid, webs_t wp, int argc, char_t **argv)
{
	size_t len = 0;
	FILE * fp;
	char * line = NULL;
	void * token = NULL;
	const char delimiter[]=":";
	const char * filepath="/proc/meminfo";
	char * memtotal;
	int ret;
	
	if ( (fp = fopen(filepath, "r")) == NULL ) 
		return ( websWrite(wp,"Error<br/>") );
	fseek(fp, 0L, SEEK_SET);
	//Total MEM
	getline(&line,&len,fp);
	line = strstr(line,"MemTotal");
	while (  (read!=(int)-1) &&  (line == NULL) )
	{
		getline(&line,&len,fp);
		line = strstr(line,"MemTotal");
	}
	strtok(line, delimiter);
	token = strtok(NULL, delimiter);
	token = token + 7;
	memtotal = strdup(token);
	
	//Free MEM
	line = NULL;
	getline(&line,&len,fp);
	line = strstr(line,"MemFree");
	while (  (read!=(int)-1) &&  (line == NULL) )
	{
		getline(&line,&len,fp);
		line = strstr(line,"MemFree");
	}
	strtok(line, delimiter);
	token = strtok(NULL, delimiter);
	token = token + 7;
	free(line);
	fclose(fp);
	unlink(filepath);
	ret = websWrite(wp,"%s/%s",token,memtotal);
	free(memtotal);
	return ret;

}

int ej_get_failtrain(int eid, webs_t wp, int argc, char_t **argv)
{
	size_t len = 0;
	size_t read;
	FILE * fp;
	char * line = NULL;
	void * token = NULL;
	const char delimiter[]="=";
	const char * filepath="/tmp/avsar_modem_training";
	
	system("cp /proc/avalanche/avsar_modem_training /tmp/");
	
	if ( (fp = fopen(filepath, "r")) == NULL ) 
		return ( websWrite(wp,"Error<br/>") );
	
	fseek(fp, 0L, SEEK_SET);
	read = getline(&line,&len,fp);
	line = strstr(line,"failTrains");
	
	/*
	 * Extract line where ATUC Vendor code is
	 */
	while (  (read!=(int)-1) &&  (line == NULL) )
	{
		read = getline(&line,&len,fp);
		line = strstr(line,"failTrains");
	}
	
	fclose(fp);
	unlink(filepath);
	
	strtok(line, delimiter);
	token = strtok(NULL, delimiter);
	
	return (websWrite(wp,"%s",token));
}


/* DEMO GET FUNCTION */
int
pippo_start(webs_t wp)
{
	int ret = 0;
	char * valore  =  websGetVar(wp, "input_pippo", NULL);
	
	cprintf("\n Il valore buttato in input_pippo e': %s", valore);
	ret += websWrite(wp,"<br /> Hai schiaffato in input il valore %s <br />",valore);
	
	//do_ej("Fail_s.asp",wp);
	//websDone(wp, 200);
	
	return ret;
}
