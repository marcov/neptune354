/*
 *  Copyright � 2001 Flaga hf. Medical Devices, K�ri Dav��sson <kd@flaga.is>
 *
 *  $Id: cfi_flagadm.c,v 1.1.1.2 2005/03/28 06:56:09 sparq Exp $
 *  
 *  This program is free software; you can redistribute  it and/or modify it
 *  under  the terms of  the GNU General  Public License as published by the
 *  Free Software Foundation;  either version 2 of the  License, or (at your
 *  option) any later version.
 *
 *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR IMPLIED
 *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
 *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
 *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, INDIRECT,
 *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
 *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; LOSS OF
 *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
 *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT
 *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
 *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 *  You should have received a copy of the  GNU General Public License along
 *  with this program; if not, write  to the Free Software Foundation, Inc.,
 *  675 Mass Ave, Cambridge, MA 02139, USA.
 */

#include <linux/module.h>
#include <linux/types.h>
#include <linux/kernel.h>
#include <asm/io.h>
#include <linux/mtd/mtd.h>
#include <linux/mtd/map.h>
#include <linux/mtd/partitions.h>


/* We split the flash chip up into four parts.
 * 1: bootloader firts 128k			(0x00000000 - 0x0001FFFF) size 0x020000
 * 2: kernel 640k					(0x00020000 - 0x000BFFFF) size 0x0A0000
 * 3: compressed 1536k root ramdisk	(0x000C0000 - 0x0023FFFF) size 0x180000
 * 4: writeable diskpartition (jffs)(0x00240000 - 0x003FFFFF) size 0x1C0000
 */

#define FLASH_PHYS_ADDR 0x40000000
#define FLASH_SIZE 0x400000  

#define FLASH_PARTITION0_ADDR 0x00000000
#define FLASH_PARTITION0_SIZE 0x00020000

#define FLASH_PARTITION1_ADDR 0x00020000
#define FLASH_PARTITION1_SIZE 0x000A0000

#define FLASH_PARTITION2_ADDR 0x000C0000
#define FLASH_PARTITION2_SIZE 0x00180000

#define FLASH_PARTITION3_ADDR 0x00240000
#define FLASH_PARTITION3_SIZE 0x001C0000

__u8 flagadm_read8(struct map_info *map, unsigned long ofs)
{
	return __raw_readb(map->map_priv_1 + ofs);
}

__u16 flagadm_read16(struct map_info *map, unsigned long ofs)
{
	return __raw_readw(map->map_priv_1 + ofs);
}

__u32 flagadm_read32(struct map_info *map, unsigned long ofs)
{
	return __raw_readl(map->map_priv_1 + ofs);
}

void flagadm_copy_from(struct map_info *map, void *to, unsigned long from, ssize_t len)
{
	memcpy_fromio(to, map->map_priv_1 + from, len);
}

void flagadm_write8(struct map_info *map, __u8 d, unsigned long adr)
{
	__raw_writeb(d, map->map_priv_1 + adr);
	mb();
}

void flagadm_write16(struct map_info *map, __u16 d, unsigned long adr)
{
	__raw_writew(d, map->map_priv_1 + adr);
	mb();
}

void flagadm_write32(struct map_info *map, __u32 d, unsigned long adr)
{
	__raw_writel(d, map->map_priv_1 + adr);
	mb();
}

void flagadm_copy_to(struct map_info *map, unsigned long to, const void *from, ssize_t len)
{
	memcpy_toio(map->map_priv_1 + to, from, len);
}

struct map_info flagadm_map = {
		name: "FlagaDM flash device",
		size: FLASH_SIZE,
		buswidth: 2,
		read8: flagadm_read8,
		read16: flagadm_read16,
		read32: flagadm_read32,
		copy_from: flagadm_copy_from,
		write8: flagadm_write8,
		write16: flagadm_write16,
		write32: flagadm_write32,
		copy_to: flagadm_copy_to
};

struct mtd_partition flagadm_parts[] = {
	{
		name	: "Bootloader",
		offset	: FLASH_PARTITION0_ADDR,
		size	: FLASH_PARTITION0_SIZE
	},
	{
		name	: "Kernel image",
		offset	: FLASH_PARTITION1_ADDR,
		size	: FLASH_PARTITION1_SIZE
	},
	{
		name	: "Initial ramdisk image",
		offset	: FLASH_PARTITION2_ADDR,
		size	: FLASH_PARTITION2_SIZE
	},
	{	
		name	: "Persistant storage",
		offset	: FLASH_PARTITION3_ADDR,
		size	: FLASH_PARTITION3_SIZE
	}
};

#define PARTITION_COUNT (sizeof(flagadm_parts)/sizeof(struct mtd_partition))

static struct mtd_info *mymtd;

int __init init_flagadm(void)
{	
	printk(KERN_NOTICE "FlagaDM flash device: %x at %x\n",
			FLASH_SIZE, FLASH_PHYS_ADDR);
	
	flagadm_map.map_priv_1 = (unsigned long)ioremap(FLASH_PHYS_ADDR,
					FLASH_SIZE);

	if (!flagadm_map.map_priv_1) {
		printk("Failed to ioremap\n");
		return -EIO;
	}
	mymtd = do_map_probe("cfi_probe", &flagadm_map);
	if (mymtd) {
		mymtd->module = THIS_MODULE;
		add_mtd_partitions(mymtd, flagadm_parts, PARTITION_COUNT);
		printk(KERN_NOTICE "FlagaDM flash device initialized\n");
		return 0;
	}

	iounmap((void *)flagadm_map.map_priv_1);
	return -ENXIO;
}

static void __exit cleanup_flagadm(void)
{
	if (mymtd) {
		del_mtd_partitions(mymtd);
		map_destroy(mymtd);
	}
	if (flagadm_map.map_priv_1) {
		iounmap((void *)flagadm_map.map_priv_1);
		flagadm_map.map_priv_1 = 0;
	}
}

module_init(init_flagadm);
module_exit(cleanup_flagadm);


MODULE_LICENSE("GPL");
MODULE_AUTHOR("K�ri Dav��sson <kd@flaga.is>");
MODULE_DESCRIPTION("MTD map driver for Flaga digital module");
