#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/stat.h>
#include <stdarg.h>
#include <getopt.h>
#include <time.h>
#include <sys/time.h>

#include <cyutils.h>
//#include <code_pattern.h>

#define MAX_BUF	1024

extern struct code_header * init_code_header(char * patt);

int fd, fd_w;

void die(const char * str, ...)
{
	va_list args;
	va_start(args, str);
	vfprintf(stderr, str, args);
	fputc('\n', stderr);
	exit(1);
}

int 
fill_null0(int size)
{
	unsigned char buf[1];
	int i;

	fprintf(stderr,"Fill null\n");

	buf[0] = 0xff;
	for (i=0 ; i< size; i++ )
		if (write(fd_w, buf, 1) != 1)
			return 0;

	return 1;
}

long
file_open(const char *name)
{
	struct stat sb;
	if ((fd = open(name, O_RDONLY, 0)) < 0){
		die("Unable to open `%s' : %m", name);
	}

	if (fstat (fd, &sb))
		die("Unable to stat `%s' : %m", name);

	return sb.st_size;
}

void usage(void)
{
	die("Usage: addpattern [-i|--input] code.bin [-o|--output] code.trx -p ABCD");
}

int main(int argc, char ** argv)
{
	int i, debug;
	long input_size,c;
	char *input_file=NULL, *output_file=NULL;
	char *patt;
        int opt;
        int option_index=0;
	int garbage = 0;
	char *buf = NULL;
        extern char *optarg;
        extern int optind, opterr, optopt;

	struct code_header *pattern;

        static struct option long_options[] =
	{
		{"debug", 0, 0, 'd'},
		{"input", 1, 0, 'i'},
		{"output", 1, 0, 'o'},
		{"pattern", 1, 0, 'p'},
		{"garbage", 0, 0, 'g'},
		{0, 0, 0, 0}
	};

	printf("\n---------- add code pattern --------\n");

        pattern = malloc(sizeof(struct code_header));
	memset(pattern, 0, sizeof(struct code_header));	

	while(1){
		opt = getopt_long(argc, argv, "di:o:p:g",long_options, &option_index);
		if(opt == -1)
			break;
		switch(opt){
			case 'd' : 
				debug=1; break;
			case 'h' : 
				usage(); break;
			case 'i' :
				input_file = optarg;
				printf("input file is [%s]\n",input_file); break;
			case 'o' :
				output_file = optarg;
				printf("output file is [%s]\n",output_file); break;
			case 'p' :	// no use
				patt = optarg;
				printf("code pattern is [%s]\n",patt);
				if(patt && strlen(patt) != 4){
					printf("The code pattern must be %d characters!\n\a", 4);
					getchar();
					exit(0);
				}
				for(i=0;i<4;i++)
					pattern->magic[i] = *(patt+i);
				break;
			case 'g' :
				garbage = 1; break;
			default :
				usage();
		}
	}
	if(!input_file || !output_file || !patt)
		usage();

	unlink(output_file);
	if ((fd_w = open(output_file,O_RDWR|O_CREAT, S_IREAD | S_IWRITE)) < 0){
		die("Unable to open `%s' : %m", output_file);
	}
	
	input_size = file_open(input_file);

	pattern = (struct code_header *)init_code_header(patt);
	
	/* write code pattern header */
	write(fd_w,pattern,sizeof(struct code_header));

	/* Allocate temporary buffer */
	if(!(buf = malloc(input_size))){
		perror("malloc");
		goto fail;
	}

	c=read(fd,buf,input_size);

	if(write(fd_w,buf,c)!=c)
		die("Write call failed!\n");

	if(garbage == 1){			// add garbage, let image is a multiple of 1024, and the web upgrade will ok
		printf("Add %d bytes garbage\n",1024-32);	
		if(!fill_null0(1024-32))
			die("error!\n");
	}

fail:
	if(buf)
		free(buf);
	close (fd);
	close (fd_w);
	
	return 0;
}
