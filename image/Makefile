include ../router_type.def
include ../cy_codepattern.mak


rom:	
	rm -rf rom_code.bin
	../tools/merge ram_zimage.bin target.squshfs 0
	chmod 644 rom_code.bin

upgrade:	
	rm -rf code.bin
	../tools/merge ram_zimage.bin target.squshfs 1
	chmod 644 code.bin
	../tools/addpattern -i code.bin -o upgrade_code.bin -p $(CODE_PATTERN)
	../tools/tichksum upgrade_code.bin
	
	
	
	
	
	
	

