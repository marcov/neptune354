/*
 * linux/include/asm-arm/arch-sa1100/system.h
 *
 * Copyright (c) 1999 Nicolas Pitre <nico@cam.org>
 */
#include <linux/config.h>

static inline void arch_idle(void)
{
	if (!hlt_counter) {
		int flags;
		local_irq_save(flags);
		if (!current->need_resched)
			cpu_do_idle(0);
		local_irq_restore(flags);
	}
}

#ifdef CONFIG_SA1100_VICTOR

/* power off unconditionally */
#define arch_reset(x) machine_power_off()

#else

static inline void arch_reset(char mode)
{
	if (mode == 's') {
		/* Jump into ROM at address 0 */
		cpu_reset(0);
	} else {
		/* Use on-chip reset capability */
		RSRR = RSRR_SWR;
	}
}

#endif
