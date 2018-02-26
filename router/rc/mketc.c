#include <stdio.h>
#include <stdlib.h>
#include <netinet/in.h>
#include <unistd.h>

#include <bcmnvram.h>
#include <rc.h>

int mk_etc_passwd(void){
	FILE *passwd;

	passwd=fopen("/tmp/passwd","w");

	fprintf(passwd,"%s:",nvram_safe_get("http_username"));
	fprintf(passwd,"%s:0:0::/tmp:/bin/sh\n",crypt(nvram_safe_get("http_passwd"),"Zi"));
	//Added root for ntpd
	fprintf(passwd,"%s:","root");
	fprintf(passwd,"%s:0:0::/tmp:/bin/sh\n",crypt(nvram_safe_get("http_passwd"),"Zi"));
#ifdef HTTPS_SUPPORT	
	if ( nvmram_match(remote_management,"1") )
	{
		fprintf(passwd,"%s:",nvram_safe_get("http_remote_username"));
		fprintf(passwd,"%s:0:0::/tmp:/bin/sh\n",crypt(nvram_safe_get("http_remote_passwd"),"Zi"));
	}
#endif
	fclose(passwd);
	return 0;

};

