CC = gcc
ZLIB = libztemp.a
ZLIB_VER = 1.1.3
LZMA=yes

ifeq ($(LZMA), yes)
#lzma stuff
ifeq ($(FLAT), yes)
LDFLAGS = -L../../tools/lib/ -Llzma -llzma -lpthread
else
LDFLAGS = -L../../../tools/lib -Llzma -llzma -lpthread
endif
LZMA_LIB = lzma/liblzma.a
LZMA_DEFINE = -D__TI_SQUASHFS_LZMA

else
# zlib stuff
ifeq ($(FLAT), yes)
LDFLAGS = -L../../tools/lib/ -lztemp -lpthread
else
LDFLAGS = -L../../../tools/lib -lztemp -lpthread
endif

endif

#CFLAGS = -Wall -O2 -g -I./include -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE
#CFLAGS = -Wall -O2 -g -I./include  -D_FILE_OFFSET_BITS=64 -D_LARGEFILE64_SOURCE $(LZMA_DEFINE) -U__REDIRECT
CFLAGS = -O2 -I.  -D_FILE_OFFSET_BITS=64 -D_LARGEFILE64_SOURCE $(LZMA_DEFINE) -U__REDIRECT

TARGETS = mksquashfs

all: $(TARGETS)

mksquashfs: mksquashfs.o read_fs.o sort.o $(LZMA_LIB)
	$(CXX) $(CFLAGS) $(LZMA_DEFINE) -o $@ mksquashfs.o read_fs.o sort.o $(LDFLAGS)

read_fs.o: read_fs.c read_fs.h lzma/liblzma.h

mksquashfs.o: mksquashfs.c mksquashfs.h lzma/liblzma.h

sort.o: sort.c

unsquashfs: unsquashfs.o $(LZMA_LIB)
	$(CXX) $(CFLAGS) $(LZMA_DEFINE) -o $@ unsquashfs.o $(LDFLAGS)
        
unsquashfs.o: unsquashfs.c squashfs_fs.h read_fs.h global.h
        
lzma/liblzma.a:
	make -C lzma liblzma.a

clean:
	make -C lzma clean
	rm -f $(TARGETS)
	rm -f *.o *~

.PHONY: all clean
