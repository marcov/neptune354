/*
 * @(#) prototypes for FreeSWAN functions 
 *
 * Copyright (C) 2001  Richard Guy Briggs  <rgb@freeswan.org>
 *                 and Michael Richardson  <mcr@freeswan.org>
 * 
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU General Public License as published by the
 * Free Software Foundation; either version 2 of the License, or (at your
 * option) any later version.  See <http://www.fsf.org/copyleft/gpl.txt>.
 * 
 * This program is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
 * or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
 * for more details.
 *
 * RCSID $Id: ipsec_proto.h,v 1.1.1.2 2005/03/28 06:57:39 sparq Exp $
 *
 */

#ifndef _IPSEC_PROTO_H_

#include "ipsec_param.h"

/* 
 * This file is a kernel only file that declares prototypes for
 * all intra-module function calls and global data structures.
 *
 * Include this file last.
 *
 */

/* ipsec_sa.c */
extern struct ipsec_sa *ipsec_sadb_hash[SADB_HASHMOD];
extern spinlock_t       tdb_lock;
extern int ipsec_sadb_init(void);

extern struct ipsec_sa *ipsec_sa_getbyid(struct sa_id*);
extern /* void */ int ipsec_sa_del(struct ipsec_sa *);
extern /* void */ int ipsec_sa_delchain(struct ipsec_sa *);
extern /* void */ int ipsec_sa_put(struct ipsec_sa *);

extern int ipsec_sa_init(struct ipsec_sa *, struct encap_msghdr *);
extern int ipsec_sadb_cleanup(__u8);
extern int ipsec_sa_wipe(struct ipsec_sa *);

/* debug declarations */

/* ipsec_proc.c */
extern int  ipsec_proc_init(void);
extern void ipsec_proc_cleanup(void);

/* ipsec_radij.c */
extern int ipsec_makeroute(struct sockaddr_encap *ea,
			   struct sockaddr_encap *em,
			   struct sa_id said,
			   uint32_t pid,
			   struct sk_buff *skb,
			   struct ident *ident_s,
			   struct ident *ident_d);

extern int ipsec_breakroute(struct sockaddr_encap *ea,
			    struct sockaddr_encap *em,
			    struct sk_buff **first,
			    struct sk_buff **last);

int ipsec_radijinit(void);
int ipsec_cleareroutes(void);
int ipsec_radijcleanup(void);

/* ipsec_life.c */
extern enum ipsec_life_alive ipsec_lifetime_check(struct ipsec_lifetime64 *il64,
						  const char *lifename,
						  const char *saname,
						  enum ipsec_life_type ilt,
						  enum ipsec_direction idir,
						  struct ipsec_sa *ips);


extern int ipsec_lifetime_format(char *buffer,
				 int   buflen,
				 char *lifename,
				 enum ipsec_life_type timebaselife,
				 struct ipsec_lifetime64 *lifetime);

extern void ipsec_lifetime_update_hard(struct ipsec_lifetime64 *lifetime,
				       __u64 newvalue);

extern void ipsec_lifetime_update_soft(struct ipsec_lifetime64 *lifetime,
				       __u64 newvalue);




#ifdef CONFIG_IPSEC_DEBUG

extern int debug_xform;
extern int debug_eroute;
extern int debug_spi;

#endif /* CONFIG_IPSEC_DEBUG */




#define _IPSEC_PROTO_H
#endif /* _IPSEC_PROTO_H_ */

/*
 * $Log: ipsec_proto.h,v $
 * Revision 1.1.1.2  2005/03/28 06:57:39  sparq
 * - GuangZhou release v1.00.57
 *
 * Revision 1.1.1.1  2004/07/26 01:39:25  sparq
 * Mirror v0.01.9 release from K.C division of CyberTAN.
 *
 * Revision 1.3  2003/01/19 22:32:30  ken
 * X.509 0.9.19 -> 0.9.20
 *
 * Revision 1.2  2002/12/12 03:32:07  ken
 * Upgraded to X.509 0.9.16 w/manual merges for NAT-T support
 *
 * Revision 1.1.1.1  2002/09/05 03:13:17  ken
 * 1.98b
 *
 * Revision 1.2  2001/11/26 09:16:15  rgb
 * Merge MCR's ipsec_sa, eroute, proc and struct lifetime changes.
 *
 * Revision 1.1.2.1  2001/09/25 02:21:01  mcr
 * 	ipsec_proto.h created to keep prototypes rather than deal with
 * 	cyclic dependancies of structures and prototypes in .h files.
 *
 *
 *
 * Local variables:
 * c-file-style: "linux"
 * End:
 *
 */

