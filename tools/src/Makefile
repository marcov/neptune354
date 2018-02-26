CFLAGS  += -I../../include
CFLAGS  += -s

all:
	gcc $(CFLAGS) -o ../buildimage buildimage.c
	gcc $(CFLAGS) -o ../fillff fillff.c
	gcc $(CFLAGS) -o ../add_ver_to_boot add_ver_to_boot.c
	gcc $(CFLAGS) -o ../addpattern addpattern.c code_header.c
	gcc $(CFLAGS) -o ../gen_define gen_define.c
	gcc $(CFLAGS) -o ../gen_release_file gen_release_file.c
	gcc $(CFLAGS) -o ../checksum2 checksum2.c

addpattern:
	gcc $(CFLAGS) -s -o addpattern addpattern.c code_header.c
