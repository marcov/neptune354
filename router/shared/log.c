
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
#include <unistd.h>
#include <errno.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <sys/klog.h>
#include <netdb.h>

#include <broadcom.h>
#include <support.h>
#include "pvc.h"

#define LOG_BUF	16384	// max buf, total have 64 entries
#define IFNAMSIZ 16
#define LOG_FILE "/tmp/.messages"

extern int status;
extern int cl_page;
extern int refresh;
extern int selet_flags;
extern struct logmsg *head;
extern struct show_page *cur_page;
extern struct show_page *show_page_head;
extern struct show_page *show_page_tail;
extern struct logmsg *cur_line; 
void syslog_refresh()
{/*       status=1;
	refresh=1;
	printf("refresh the page!\n");*/
}
void syslog_pagepre()
{/*       
	status=2;
	printf("back page!\n");*/
	if(status>=1)
	status--;
}
void syslog_pagenext()
{/*
	status=3;
	printf("front page!\n");*/
	status++;
}
void syslog_clear()
{
        cl_page=1;
//	printf("clear the page!\n");
}
static void bail(const char *on_what){
	  fputs(strerror(errno),stderr);
	  fputs(":",stderr);
	  fputs(on_what,stderr);
	  fputc('\n',stderr);
	//   exit(1);

}

int ej_entry_logmsg(int eid,webs_t wp,int argc, char_t **argv)
{    
    	char *arg;
        char *temp="0";
        int count;
        int ret=0;

       if(ejArgs(argc, argv, "%d", &count) <1 )
        {
          websError(wp, 400, "Insufficient args\n");
          return -1;
        }
       if(gozila_action )
        {
          temp = websGetVar(wp, "sel_sysLogType", NULL);
          selet_flags=atoi(temp);
	  printf("sel_sysLogType= %s\n", temp);
          if(((count == 0) && (!strcmp(temp, "0"))) || ((count == 1) && (!strcmp(temp, "1")))||((count==2)&&(!strcmp(temp,"2")))||((count==3)&&(!strcmp(temp,"3")))||((count==4)&&(!strcmp(temp,"4")))||((count==5)&&(!strcmp(temp,"5"))))
                 return ret=websWrite(wp, "selected");
         }
         else
         {
	  printf("sel_sysLogType= %s\n", temp);
          if(((count == 0) && (!strcmp(temp, "0"))) || ((count == 1) && (!strcmp(temp, "1")))||((count==2)&&(!strcmp(temp,"2")))||((count==3)&&(!strcmp(temp,"3")))||((count==4)&&(!strcmp(temp,"4")))||((count==5)&&(!strcmp(temp,"5"))))
           return ret=websWrite(wp, "selected");
         }

	 return 0;
}

			  
int ej_dump_syslog(int eid, webs_t wp, int argc, char_t **argv)
{
	FILE *fp;
	char *line = NULL;
	size_t len = 0;
	ssize_t read;
	int page_length=10;
	int sel_sysLogType=1;
	int count =0;
	int min;
	int max;	
	char * cmd;
	
	if(cl_page)
	{
		cl_page=0;
		/* Not working with circular buffer */
		/*
		eval("rm","/var/log/messages");
		sleep(1);
		status=0;
		return websWrite(wp,"%s<br>","");
		*/
		return websWrite(wp,"%s<br>","Not implemented.");
	}
	
	sprintf(cmd,"logread > %s",LOG_FILE);
	system(cmd);
	
	if((fp = fopen(LOG_FILE,"r")) == NULL)
	{
		printf("Error reading log");
		return-1;
	}
	
	sel_sysLogType =selet_flags ;
	min = sel_sysLogType*page_length*status;
	max = min + page_length*sel_sysLogType;
	
	while((read = getline(&line,&len,fp))!=-1)
	{
		if(count >= min && count < max)
		{
			websWrite(wp,"%s<br>",line);
		}
		count++;
	}
	
	if(line)
		free(line);
	
	fclose(fp);
	unlink(fp);
	return 0;
}


struct show_page* create_showpage(struct logmsg *head_node,int type,int yes)
{
	struct logmsg *ptr;
	struct show_page *show_page_head_lo,*show_page_tail;
	struct show_page *show_page_ptr,*show_page_ptr1;
	int k,i,j,tmp,relen;
	int pagemax=0;
	k=0;
	relen=0;
////////////
	ptr=head_node;
	
	if(ptr==NULL)
		return NULL;
	
	show_page_head_lo=show_page_tail=(struct show_page *)malloc(sizeof(struct show_page));
	
	if(!show_page_head_lo)
		return NULL;
	
	show_page_head_lo->next=NULL;
	show_page_head_lo->front=NULL;
	show_page_ptr=show_page_head_lo;
	printf("the ptr->len=%d\n",ptr->len);
	
	while(k<ptr->len)
	{        		
		for(i=0;i<30;)
		{
			if(yes==1)
			{
				tmp=atoi(ptr->type[k]);	     
				
				if(tmp==type)
				{
					show_page_ptr->level[i]=ptr->level[k];
					
					for(j=0;j<125;j++)
						show_page_ptr->line[i][j]=ptr->contant[k][j];
	        
					show_page_ptr->len=++i;
					k++;
					relen++;	
                 }//end if((type-ptr->line[k].type)==type)
				
				else 
					k++;
				
				printf("the k=%d",k);
				if(k>=ptr->len)
				break;
			} //end if yes==1
			
			else 
				if(yes==0)
				{ 
					tmp=atoi(ptr->type[k]);	     
					
					if((tmp==1)||(tmp==2)||(tmp==3)||(tmp==4)||(tmp==5))
					{
						printf("the tmp=%d",tmp);   
					
						relen++;
						show_page_ptr->level[i]=ptr->level[k];
					
						for(j=0;j<125;j++)
							show_page_ptr->line[i][j]=ptr->contant[k][j];
 						show_page_ptr->len=++i;
						k++;
					}
					else
						k++;		
		 
					if(k>ptr->len)
					break;
				}
		}//end the for first

		i=0;
		pagemax++;
		
		if((k>=ptr->len)||(pagemax>10))
		{
			printf("the 2\n");
			break;
		}
		else
		{
			show_page_ptr1=(struct show_page*)malloc(sizeof(struct show_page));
			memset(show_page_ptr1,0,sizeof(struct show_page));
			show_page_ptr->next=show_page_ptr1;
			show_page_ptr1->front=show_page_ptr;
			show_page_ptr1->next=NULL;
			show_page_tail  =show_page_ptr1;
			show_page_ptr=show_page_ptr1;
		}
	}//end while(1)

	printf("alllen=%d\n",relen);
	if(relen==0)
		show_page_head_lo=NULL;

	return show_page_head_lo;

}
/////////////////////////////////////////////////////////////////////////////
int
ej_dumpvpnlog(int eid, webs_t wp, int argc, char_t **argv)
{
     FILE *fp;
     char readbuf[15];
     int n,shmid;
     void *shmdata;
     char *buffer;
        if((fp = fopen("/tmp/shm","r")) == NULL)
        {
                printf("Cann't open /tmp/shm!\n");
                return -1;
        }
        if((n = fread(readbuf,10,1,fp)) < 0)
	        {
		                printf("can't read anything!\n");
			        }
        readbuf[n] = '\0';
        shmid = atoi(readbuf);
        shmdata = shmat(shmid,0,0);
        buffer = shmdata;
        websWrite(wp,"%s",buffer);
        return 0;
}

////////////////////////////////////////////////////////////////////////////
	
