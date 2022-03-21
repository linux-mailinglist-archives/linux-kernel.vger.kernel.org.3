Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BF534E24EE
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 12:03:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346650AbiCULE1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 07:04:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346602AbiCULDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 07:03:55 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DE329D4DE
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 04:02:29 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1647860548;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=fRyAQrj5X8b3qtvkTVjf+JkcNhrIcho5k+KJpvlBlf0=;
        b=epapMmQlSGKdch0VC8T42keRMe1y8ABr1IeLzkr+gizIQCCgnOL60nDiir1Gw5tub580IX
        UKWGuq9QD5CI7KNTQAj5Z7Qsmj8hi6zHqMcp+YYFgHQBfBF1Zu/FxpA/ktCHTdXLvQQJvf
        OeN+063Xh6Du4rBMKBmZLqx+JOOX4+ZUDwph4xCknR51YHqbr2wKuZBIhqhXoodA4OQRWQ
        ZQJl4P6f/z96IpEo1c1MDKXNfVX25d65HvHMiVcuf1nsUKia1bAGQ8yyC9bVfb7agHpV8l
        jwSgcL9tFub5iLm/v66dtbDGG2Tg0YebWFNi0U15IS2vBqDVGOq9XdsI1Qddjg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1647860548;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=fRyAQrj5X8b3qtvkTVjf+JkcNhrIcho5k+KJpvlBlf0=;
        b=qzIVXNj3fwPK6ivjxceys7oAf0Uc/epleLnN0RIivQOZfQ+HsdVhuk/xqnrM56Fn/Lg7fc
        3TbHerdQyjWMc/AA==
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] x86/irq for v5.18-rc1
References: <164786042536.122591.4459156564791679956.tglx@xen13>
Message-ID: <164786043041.122591.4693682080153649212.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Date:   Mon, 21 Mar 2022 12:02:27 +0100 (CET)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest x86/irq branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-irq-2022-03-=
21

up to:  449972c67ea7: x86/PCI: Fix coding style in PIRQ table search functions


X86 PCI interrupt updates:

 - Cleanup and robustify the PCI interrupt routing table handling

 - Add support for Intel 82378ZB/82379AB, SiS85C497 PIRQ routers

 - Fix the ALi M1487 router handling

 - Handle the IRT routing table format in AMI BIOSes correctly


Thanks,

	tglx

------------------>
Maciej W. Rozycki (11):
      x86/PCI: Show the physical address of the $PIR table
      x86/PCI: Include function number in $PIR table dump
      x86/PCI: Also match function number in $PIR table
      x86/PCI: Handle IRQ swizzling with PIRQ routers
      x86/PCI: Add support for the Intel 82378ZB/82379AB (SIO/SIO.A) PIRQ rou=
ter
      x86/PCI: Disambiguate SiS85C503 PIRQ router code entities
      x86/PCI: Add support for the SiS85C497 PIRQ router
      x86/PCI: Handle PIRQ routing tables with no router device given
      x86/PCI: Add $IRT PIRQ routing table support
      x86/PCI: Fix ALi M1487 (IBC) PIRQ router link value interpretation
      x86/PCI: Fix coding style in PIRQ table search functions


 arch/x86/include/asm/pci_x86.h |   8 +
 arch/x86/pci/irq.c             | 372 ++++++++++++++++++++++++++++++++++-----=
--
 2 files changed, 315 insertions(+), 65 deletions(-)

diff --git a/arch/x86/include/asm/pci_x86.h b/arch/x86/include/asm/pci_x86.h
index 490411dba438..7be45daaf31d 100644
--- a/arch/x86/include/asm/pci_x86.h
+++ b/arch/x86/include/asm/pci_x86.h
@@ -90,6 +90,14 @@ struct irq_routing_table {
 	struct irq_info slots[0];
 } __attribute__((packed));
=20
+struct irt_routing_table {
+	u32 signature;			/* IRT_SIGNATURE should be here */
+	u8 size;			/* Number of entries provided */
+	u8 used;			/* Number of entries actually used */
+	u16 exclusive_irqs;		/* IRQs devoted exclusively to PCI usage */
+	struct irq_info slots[0];
+} __packed;
+
 extern unsigned int pcibios_irq_mask;
=20
 extern raw_spinlock_t pci_config_lock;
diff --git a/arch/x86/pci/irq.c b/arch/x86/pci/irq.c
index 97b63e35e152..9be158078f66 100644
--- a/arch/x86/pci/irq.c
+++ b/arch/x86/pci/irq.c
@@ -25,6 +25,8 @@
 #define PIRQ_SIGNATURE	(('$' << 0) + ('P' << 8) + ('I' << 16) + ('R' << 24))
 #define PIRQ_VERSION 0x0100
=20
+#define IRT_SIGNATURE	(('$' << 0) + ('I' << 8) + ('R' << 16) + ('T' << 24))
+
 static int broken_hp_bios_irq9;
 static int acer_tm360_irqrouting;
=20
@@ -74,7 +76,7 @@ static inline struct irq_routing_table *pirq_check_routing_=
table(u8 *addr)
 	int i;
 	u8 sum;
=20
-	rt =3D (struct irq_routing_table *) addr;
+	rt =3D (struct irq_routing_table *)addr;
 	if (rt->signature !=3D PIRQ_SIGNATURE ||
 	    rt->version !=3D PIRQ_VERSION ||
 	    rt->size % 16 ||
@@ -84,35 +86,103 @@ static inline struct irq_routing_table *pirq_check_routi=
ng_table(u8 *addr)
 	for (i =3D 0; i < rt->size; i++)
 		sum +=3D addr[i];
 	if (!sum) {
-		DBG(KERN_DEBUG "PCI: Interrupt Routing Table found at 0x%p\n",
-			rt);
+		DBG(KERN_DEBUG "PCI: Interrupt Routing Table found at 0x%lx\n",
+		    __pa(rt));
 		return rt;
 	}
 	return NULL;
 }
=20
+/*
+ * Handle the $IRT PCI IRQ Routing Table format used by AMI for its BCP
+ * (BIOS Configuration Program) external tool meant for tweaking BIOS
+ * structures without the need to rebuild it from sources.  The $IRT
+ * format has been invented by AMI before Microsoft has come up with its
+ * $PIR format and a $IRT table is therefore there in some systems that
+ * lack a $PIR table.
+ *
+ * It uses the same PCI BIOS 2.1 format for interrupt routing entries
+ * themselves but has a different simpler header prepended instead,
+ * occupying 8 bytes, where a `$IRT' signature is followed by one byte
+ * specifying the total number of interrupt routing entries allocated in
+ * the table, then one byte specifying the actual number of entries used
+ * (which the BCP tool can take advantage of when modifying the table),
+ * and finally a 16-bit word giving the IRQs devoted exclusively to PCI.
+ * Unlike with the $PIR table there is no alignment guarantee.
+ *
+ * Given the similarity of the two formats the $IRT one is trivial to
+ * convert to the $PIR one, which we do here, except that obviously we
+ * have no information as to the router device to use, but we can handle
+ * it by matching PCI device IDs actually seen on the bus against ones
+ * that our individual routers recognise.
+ *
+ * Reportedly there is another $IRT table format where a 16-bit word
+ * follows the header instead that points to interrupt routing entries
+ * in a $PIR table provided elsewhere.  In that case this code will not
+ * be reached though as the $PIR table will have been chosen instead.
+ */
+static inline struct irq_routing_table *pirq_convert_irt_table(u8 *addr)
+{
+	struct irt_routing_table *ir;
+	struct irq_routing_table *rt;
+	u16 size;
+	u8 sum;
+	int i;
+
+	ir =3D (struct irt_routing_table *)addr;
+	if (ir->signature !=3D IRT_SIGNATURE || !ir->used || ir->size < ir->used)
+		return NULL;
+
+	DBG(KERN_DEBUG "PCI: $IRT Interrupt Routing Table found at 0x%lx\n",
+	    __pa(ir));
+
+	size =3D sizeof(*rt) + ir->used * sizeof(rt->slots[0]);
+	rt =3D kzalloc(size, GFP_KERNEL);
+	if (!rt)
+		return NULL;
+
+	rt->signature =3D PIRQ_SIGNATURE;
+	rt->version =3D PIRQ_VERSION;
+	rt->size =3D size;
+	rt->exclusive_irqs =3D ir->exclusive_irqs;
+	for (i =3D 0; i < ir->used; i++)
+		rt->slots[i] =3D ir->slots[i];
+
+	addr =3D (u8 *)rt;
+	sum =3D 0;
+	for (i =3D 0; i < size; i++)
+		sum +=3D addr[i];
+	rt->checksum =3D -sum;
=20
+	return rt;
+}
=20
 /*
  *  Search 0xf0000 -- 0xfffff for the PCI IRQ Routing Table.
  */
-
 static struct irq_routing_table * __init pirq_find_routing_table(void)
 {
 	u8 *addr;
 	struct irq_routing_table *rt;
=20
 	if (pirq_table_addr) {
-		rt =3D pirq_check_routing_table((u8 *) __va(pirq_table_addr));
+		rt =3D pirq_check_routing_table((u8 *)__va(pirq_table_addr));
 		if (rt)
 			return rt;
 		printk(KERN_WARNING "PCI: PIRQ table NOT found at pirqaddr\n");
 	}
-	for (addr =3D (u8 *) __va(0xf0000); addr < (u8 *) __va(0x100000); addr +=3D=
 16) {
+
+	for (addr =3D (u8 *)__va(0xf0000); addr < (u8 *)__va(0x100000); addr +=3D 1=
6) {
 		rt =3D pirq_check_routing_table(addr);
 		if (rt)
 			return rt;
 	}
+
+	for (addr =3D (u8 *)__va(0xf0000); addr < (u8 *)__va(0x100000); addr++) {
+		rt =3D pirq_convert_irt_table(addr);
+		if (rt)
+			return rt;
+	}
 	return NULL;
 }
=20
@@ -121,7 +191,6 @@ static struct irq_routing_table * __init pirq_find_routin=
g_table(void)
  *  bridges.  It's a gross hack, but since there are no other known
  *  ways how to get a list of buses, we have to go this way.
  */
-
 static void __init pirq_peer_trick(void)
 {
 	struct irq_routing_table *rt =3D pirq_table;
@@ -135,7 +204,8 @@ static void __init pirq_peer_trick(void)
 #ifdef DEBUG
 		{
 			int j;
-			DBG(KERN_DEBUG "%02x:%02x slot=3D%02x", e->bus, e->devfn/8, e->slot);
+			DBG(KERN_DEBUG "%02x:%02x.%x slot=3D%02x",
+			    e->bus, e->devfn / 8, e->devfn % 8, e->slot);
 			for (j =3D 0; j < 4; j++)
 				DBG(" %d:%02x/%04x", j, e->irq[j].link, e->irq[j].bitmap);
 			DBG("\n");
@@ -155,7 +225,6 @@ static void __init pirq_peer_trick(void)
  *  Code for querying and setting of IRQ routes on various interrupt routers.
  *  PIC Edge/Level Control Registers (ELCR) 0x4d0 & 0x4d1.
  */
-
 void elcr_set_level_irq(unsigned int irq)
 {
 	unsigned char mask =3D 1 << (irq & 7);
@@ -253,6 +322,15 @@ static void write_pc_conf_nybble(u8 base, u8 index, u8 v=
al)
 	pc_conf_set(reg, x);
 }
=20
+/*
+ * FinALi pirq rules are as follows:
+ *
+ * - bit 0 selects between INTx Routing Table Mapping Registers,
+ *
+ * - bit 3 selects the nibble within the INTx Routing Table Mapping Register,
+ *
+ * - bits 7:4 map to bits 3:0 of the PCI INTx Sensitivity Register.
+ */
 static int pirq_finali_get(struct pci_dev *router, struct pci_dev *dev,
 			   int pirq)
 {
@@ -260,11 +338,13 @@ static int pirq_finali_get(struct pci_dev *router, stru=
ct pci_dev *dev,
 		0, 9, 3, 10, 4, 5, 7, 6, 0, 11, 0, 12, 0, 14, 0, 15
 	};
 	unsigned long flags;
+	u8 index;
 	u8 x;
=20
+	index =3D (pirq & 1) << 1 | (pirq & 8) >> 3;
 	raw_spin_lock_irqsave(&pc_conf_lock, flags);
 	pc_conf_set(PC_CONF_FINALI_LOCK, PC_CONF_FINALI_LOCK_KEY);
-	x =3D irqmap[read_pc_conf_nybble(PC_CONF_FINALI_PCI_INTX_RT1, pirq - 1)];
+	x =3D irqmap[read_pc_conf_nybble(PC_CONF_FINALI_PCI_INTX_RT1, index)];
 	pc_conf_set(PC_CONF_FINALI_LOCK, 0);
 	raw_spin_unlock_irqrestore(&pc_conf_lock, flags);
 	return x;
@@ -278,13 +358,15 @@ static int pirq_finali_set(struct pci_dev *router, stru=
ct pci_dev *dev,
 	};
 	u8 val =3D irqmap[irq];
 	unsigned long flags;
+	u8 index;
=20
 	if (!val)
 		return 0;
=20
+	index =3D (pirq & 1) << 1 | (pirq & 8) >> 3;
 	raw_spin_lock_irqsave(&pc_conf_lock, flags);
 	pc_conf_set(PC_CONF_FINALI_LOCK, PC_CONF_FINALI_LOCK_KEY);
-	write_pc_conf_nybble(PC_CONF_FINALI_PCI_INTX_RT1, pirq - 1, val);
+	write_pc_conf_nybble(PC_CONF_FINALI_PCI_INTX_RT1, index, val);
 	pc_conf_set(PC_CONF_FINALI_LOCK, 0);
 	raw_spin_unlock_irqrestore(&pc_conf_lock, flags);
 	return 1;
@@ -293,7 +375,7 @@ static int pirq_finali_set(struct pci_dev *router, struct=
 pci_dev *dev,
 static int pirq_finali_lvl(struct pci_dev *router, struct pci_dev *dev,
 			   int pirq, int irq)
 {
-	u8 mask =3D ~(1u << (pirq - 1));
+	u8 mask =3D ~((pirq & 0xf0u) >> 4);
 	unsigned long flags;
 	u8 trig;
=20
@@ -579,6 +661,81 @@ static int pirq_cyrix_set(struct pci_dev *router, struct=
 pci_dev *dev, int pirq,
 	return 1;
 }
=20
+
+/*
+ *	PIRQ routing for the SiS85C497 AT Bus Controller & Megacell (ATM)
+ *	ISA bridge used with the SiS 85C496/497 486 Green PC VESA/ISA/PCI
+ *	Chipset.
+ *
+ *	There are four PCI INTx#-to-IRQ Link registers provided in the
+ *	SiS85C497 part of the peculiar combined 85C496/497 configuration
+ *	space decoded by the SiS85C496 PCI & CPU Memory Controller (PCM)
+ *	host bridge, at 0xc0/0xc1/0xc2/0xc3 respectively for the PCI INT
+ *	A/B/C/D lines.  Bit 7 enables the respective link if set and bits
+ *	3:0 select the 8259A IRQ line as follows:
+ *
+ *	0000 : Reserved
+ *	0001 : Reserved
+ *	0010 : Reserved
+ *	0011 : IRQ3
+ *	0100 : IRQ4
+ *	0101 : IRQ5
+ *	0110 : IRQ6
+ *	0111 : IRQ7
+ *	1000 : Reserved
+ *	1001 : IRQ9
+ *	1010 : IRQ10
+ *	1011 : IRQ11
+ *	1100 : IRQ12
+ *	1101 : Reserved
+ *	1110 : IRQ14
+ *	1111 : IRQ15
+ *
+ *	We avoid using a reserved value for disabled links, hence the
+ *	choice of IRQ15 for that case.
+ *
+ *	References:
+ *
+ *	"486 Green PC VESA/ISA/PCI Chipset, SiS 85C496/497", Rev 3.0,
+ *	Silicon Integrated Systems Corp., July 1995
+ */
+
+#define PCI_SIS497_INTA_TO_IRQ_LINK	0xc0u
+
+#define PIRQ_SIS497_IRQ_MASK		0x0fu
+#define PIRQ_SIS497_IRQ_ENABLE		0x80u
+
+static int pirq_sis497_get(struct pci_dev *router, struct pci_dev *dev,
+			   int pirq)
+{
+	int reg;
+	u8 x;
+
+	reg =3D pirq;
+	if (reg >=3D 1 && reg <=3D 4)
+		reg +=3D PCI_SIS497_INTA_TO_IRQ_LINK - 1;
+
+	pci_read_config_byte(router, reg, &x);
+	return (x & PIRQ_SIS497_IRQ_ENABLE) ? (x & PIRQ_SIS497_IRQ_MASK) : 0;
+}
+
+static int pirq_sis497_set(struct pci_dev *router, struct pci_dev *dev,
+			   int pirq, int irq)
+{
+	int reg;
+	u8 x;
+
+	reg =3D pirq;
+	if (reg >=3D 1 && reg <=3D 4)
+		reg +=3D PCI_SIS497_INTA_TO_IRQ_LINK - 1;
+
+	pci_read_config_byte(router, reg, &x);
+	x &=3D ~(PIRQ_SIS497_IRQ_MASK | PIRQ_SIS497_IRQ_ENABLE);
+	x |=3D irq ? (PIRQ_SIS497_IRQ_ENABLE | irq) : PIRQ_SIS497_IRQ_MASK;
+	pci_write_config_byte(router, reg, x);
+	return 1;
+}
+
 /*
  *	PIRQ routing for SiS 85C503 router used in several SiS chipsets.
  *	We have to deal with the following issues here:
@@ -640,11 +797,12 @@ static int pirq_cyrix_set(struct pci_dev *router, struc=
t pci_dev *dev, int pirq,
  *				bit 6-4 are probably unused, not like 5595
  */
=20
-#define PIRQ_SIS_IRQ_MASK	0x0f
-#define PIRQ_SIS_IRQ_DISABLE	0x80
-#define PIRQ_SIS_USB_ENABLE	0x40
+#define PIRQ_SIS503_IRQ_MASK	0x0f
+#define PIRQ_SIS503_IRQ_DISABLE	0x80
+#define PIRQ_SIS503_USB_ENABLE	0x40
=20
-static int pirq_sis_get(struct pci_dev *router, struct pci_dev *dev, int pir=
q)
+static int pirq_sis503_get(struct pci_dev *router, struct pci_dev *dev,
+			   int pirq)
 {
 	u8 x;
 	int reg;
@@ -653,10 +811,11 @@ static int pirq_sis_get(struct pci_dev *router, struct =
pci_dev *dev, int pirq)
 	if (reg >=3D 0x01 && reg <=3D 0x04)
 		reg +=3D 0x40;
 	pci_read_config_byte(router, reg, &x);
-	return (x & PIRQ_SIS_IRQ_DISABLE) ? 0 : (x & PIRQ_SIS_IRQ_MASK);
+	return (x & PIRQ_SIS503_IRQ_DISABLE) ? 0 : (x & PIRQ_SIS503_IRQ_MASK);
 }
=20
-static int pirq_sis_set(struct pci_dev *router, struct pci_dev *dev, int pir=
q, int irq)
+static int pirq_sis503_set(struct pci_dev *router, struct pci_dev *dev,
+			   int pirq, int irq)
 {
 	u8 x;
 	int reg;
@@ -665,8 +824,8 @@ static int pirq_sis_set(struct pci_dev *router, struct pc=
i_dev *dev, int pirq, i
 	if (reg >=3D 0x01 && reg <=3D 0x04)
 		reg +=3D 0x40;
 	pci_read_config_byte(router, reg, &x);
-	x &=3D ~(PIRQ_SIS_IRQ_MASK | PIRQ_SIS_IRQ_DISABLE);
-	x |=3D irq ? irq: PIRQ_SIS_IRQ_DISABLE;
+	x &=3D ~(PIRQ_SIS503_IRQ_MASK | PIRQ_SIS503_IRQ_DISABLE);
+	x |=3D irq ? irq : PIRQ_SIS503_IRQ_DISABLE;
 	pci_write_config_byte(router, reg, x);
 	return 1;
 }
@@ -800,11 +959,18 @@ static __init int intel_router_probe(struct irq_router =
*r, struct pci_dev *route
 		return 0;
=20
 	switch (device) {
+		u8 rid;
 	case PCI_DEVICE_ID_INTEL_82375:
 		r->name =3D "PCEB/ESC";
 		r->get =3D pirq_esc_get;
 		r->set =3D pirq_esc_set;
 		return 1;
+	case PCI_DEVICE_ID_INTEL_82378:
+		pci_read_config_byte(router, PCI_REVISION_ID, &rid);
+		/* Tell 82378IB (rev < 3) and 82378ZB/82379AB apart.  */
+		if ((rid & 0xfu) < 3)
+			break;
+		fallthrough;
 	case PCI_DEVICE_ID_INTEL_82371FB_0:
 	case PCI_DEVICE_ID_INTEL_82371SB_0:
 	case PCI_DEVICE_ID_INTEL_82371AB_0:
@@ -846,7 +1012,7 @@ static __init int intel_router_probe(struct irq_router *=
r, struct pci_dev *route
 	case PCI_DEVICE_ID_INTEL_ICH10_3:
 	case PCI_DEVICE_ID_INTEL_PATSBURG_LPC_0:
 	case PCI_DEVICE_ID_INTEL_PATSBURG_LPC_1:
-		r->name =3D "PIIX/ICH";
+		r->name =3D "SIO/PIIX/ICH";
 		r->get =3D pirq_piix_get;
 		r->set =3D pirq_piix_set;
 		return 1;
@@ -865,7 +1031,7 @@ static __init int intel_router_probe(struct irq_router *=
r, struct pci_dev *route
 	     device <=3D PCI_DEVICE_ID_INTEL_DH89XXCC_LPC_MAX)
 	||  (device >=3D PCI_DEVICE_ID_INTEL_PANTHERPOINT_LPC_MIN &&
 	     device <=3D PCI_DEVICE_ID_INTEL_PANTHERPOINT_LPC_MAX)) {
-		r->name =3D "PIIX/ICH";
+		r->name =3D "SIO/PIIX/ICH";
 		r->get =3D pirq_piix_get;
 		r->set =3D pirq_piix_set;
 		return 1;
@@ -958,13 +1124,19 @@ static __init int serverworks_router_probe(struct irq_=
router *r,
=20
 static __init int sis_router_probe(struct irq_router *r, struct pci_dev *rou=
ter, u16 device)
 {
-	if (device !=3D PCI_DEVICE_ID_SI_503)
-		return 0;
-
-	r->name =3D "SIS";
-	r->get =3D pirq_sis_get;
-	r->set =3D pirq_sis_set;
-	return 1;
+	switch (device) {
+	case PCI_DEVICE_ID_SI_496:
+		r->name =3D "SiS85C497";
+		r->get =3D pirq_sis497_get;
+		r->set =3D pirq_sis497_set;
+		return 1;
+	case PCI_DEVICE_ID_SI_503:
+		r->name =3D "SiS85C503";
+		r->get =3D pirq_sis503_get;
+		r->set =3D pirq_sis503_set;
+		return 1;
+	}
+	return 0;
 }
=20
 static __init int cyrix_router_probe(struct irq_router *r, struct pci_dev *r=
outer, u16 device)
@@ -1084,10 +1256,32 @@ static struct pci_dev *pirq_router_dev;
  *	chipset" ?
  */
=20
+static bool __init pirq_try_router(struct irq_router *r,
+				   struct irq_routing_table *rt,
+				   struct pci_dev *dev)
+{
+	struct irq_router_handler *h;
+
+	DBG(KERN_DEBUG "PCI: Trying IRQ router for [%04x:%04x]\n",
+	    dev->vendor, dev->device);
+
+	for (h =3D pirq_routers; h->vendor; h++) {
+		/* First look for a router match */
+		if (rt->rtr_vendor =3D=3D h->vendor &&
+		    h->probe(r, dev, rt->rtr_device))
+			return true;
+		/* Fall back to a device match */
+		if (dev->vendor =3D=3D h->vendor &&
+		    h->probe(r, dev, dev->device))
+			return true;
+	}
+	return false;
+}
+
 static void __init pirq_find_router(struct irq_router *r)
 {
 	struct irq_routing_table *rt =3D pirq_table;
-	struct irq_router_handler *h;
+	struct pci_dev *dev;
=20
 #ifdef CONFIG_PCI_BIOS
 	if (!rt->signature) {
@@ -1106,50 +1300,95 @@ static void __init pirq_find_router(struct irq_router=
 *r)
 	DBG(KERN_DEBUG "PCI: Attempting to find IRQ router for [%04x:%04x]\n",
 	    rt->rtr_vendor, rt->rtr_device);
=20
-	pirq_router_dev =3D pci_get_domain_bus_and_slot(0, rt->rtr_bus,
-						      rt->rtr_devfn);
-	if (!pirq_router_dev) {
-		DBG(KERN_DEBUG "PCI: Interrupt router not found at "
-			"%02x:%02x\n", rt->rtr_bus, rt->rtr_devfn);
-		return;
+	/* Use any vendor:device provided by the routing table or try all.  */
+	if (rt->rtr_vendor) {
+		dev =3D pci_get_domain_bus_and_slot(0, rt->rtr_bus,
+						  rt->rtr_devfn);
+		if (dev && pirq_try_router(r, rt, dev))
+			pirq_router_dev =3D dev;
+	} else {
+		dev =3D NULL;
+		for_each_pci_dev(dev) {
+			if (pirq_try_router(r, rt, dev)) {
+				pirq_router_dev =3D dev;
+				break;
+			}
+		}
 	}
=20
-	for (h =3D pirq_routers; h->vendor; h++) {
-		/* First look for a router match */
-		if (rt->rtr_vendor =3D=3D h->vendor &&
-			h->probe(r, pirq_router_dev, rt->rtr_device))
-			break;
-		/* Fall back to a device match */
-		if (pirq_router_dev->vendor =3D=3D h->vendor &&
-			h->probe(r, pirq_router_dev, pirq_router_dev->device))
-			break;
+	if (pirq_router_dev) {
+		dev_info(&pirq_router_dev->dev, "%s IRQ router [%04x:%04x]\n",
+			 pirq_router.name,
+			 pirq_router_dev->vendor, pirq_router_dev->device);
+	} else {
+		DBG(KERN_DEBUG "PCI: Interrupt router not found at %02x:%02x\n",
+		    rt->rtr_bus, rt->rtr_devfn);
 	}
-	dev_info(&pirq_router_dev->dev, "%s IRQ router [%04x:%04x]\n",
-		 pirq_router.name,
-		 pirq_router_dev->vendor, pirq_router_dev->device);
=20
 	/* The device remains referenced for the kernel lifetime */
 }
=20
-static struct irq_info *pirq_get_info(struct pci_dev *dev)
+/*
+ * We're supposed to match on the PCI device only and not the function,
+ * but some BIOSes build their tables with the PCI function included
+ * for motherboard devices, so if a complete match is found, then give
+ * it precedence over a slot match.
+ */
+static struct irq_info *pirq_get_dev_info(struct pci_dev *dev)
 {
 	struct irq_routing_table *rt =3D pirq_table;
 	int entries =3D (rt->size - sizeof(struct irq_routing_table)) /
 		sizeof(struct irq_info);
+	struct irq_info *slotinfo =3D NULL;
 	struct irq_info *info;
=20
 	for (info =3D rt->slots; entries--; info++)
-		if (info->bus =3D=3D dev->bus->number &&
-			PCI_SLOT(info->devfn) =3D=3D PCI_SLOT(dev->devfn))
-			return info;
-	return NULL;
+		if (info->bus =3D=3D dev->bus->number) {
+			if (info->devfn =3D=3D dev->devfn)
+				return info;
+			if (!slotinfo &&
+			    PCI_SLOT(info->devfn) =3D=3D PCI_SLOT(dev->devfn))
+				slotinfo =3D info;
+		}
+	return slotinfo;
+}
+
+/*
+ * Buses behind bridges are typically not listed in the PIRQ routing table.
+ * Do the usual dance then and walk the tree of bridges up adjusting the
+ * pin number accordingly on the way until the originating root bus device
+ * has been reached and then use its routing information.
+ */
+static struct irq_info *pirq_get_info(struct pci_dev *dev, u8 *pin)
+{
+	struct pci_dev *temp_dev =3D dev;
+	struct irq_info *info;
+	u8 temp_pin =3D *pin;
+	u8 dpin =3D temp_pin;
+
+	info =3D pirq_get_dev_info(dev);
+	while (!info && temp_dev->bus->parent) {
+		struct pci_dev *bridge =3D temp_dev->bus->self;
+
+		temp_pin =3D pci_swizzle_interrupt_pin(temp_dev, temp_pin);
+		info =3D pirq_get_dev_info(bridge);
+		if (info)
+			dev_warn(&dev->dev,
+				 "using bridge %s INT %c to get INT %c\n",
+				 pci_name(bridge),
+				 'A' + temp_pin - 1, 'A' + dpin - 1);
+
+		temp_dev =3D bridge;
+	}
+	*pin =3D temp_pin;
+	return info;
 }
=20
 static int pcibios_lookup_irq(struct pci_dev *dev, int assign)
 {
-	u8 pin;
 	struct irq_info *info;
 	int i, pirq, newirq;
+	u8 dpin, pin;
 	int irq =3D 0;
 	u32 mask;
 	struct irq_router *r =3D &pirq_router;
@@ -1157,8 +1396,8 @@ static int pcibios_lookup_irq(struct pci_dev *dev, int =
assign)
 	char *msg =3D NULL;
=20
 	/* Find IRQ pin */
-	pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &pin);
-	if (!pin) {
+	pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &dpin);
+	if (!dpin) {
 		dev_dbg(&dev->dev, "no interrupt pin\n");
 		return 0;
 	}
@@ -1171,20 +1410,21 @@ static int pcibios_lookup_irq(struct pci_dev *dev, in=
t assign)
 	if (!pirq_table)
 		return 0;
=20
-	info =3D pirq_get_info(dev);
+	pin =3D dpin;
+	info =3D pirq_get_info(dev, &pin);
 	if (!info) {
 		dev_dbg(&dev->dev, "PCI INT %c not found in routing table\n",
-			'A' + pin - 1);
+			'A' + dpin - 1);
 		return 0;
 	}
 	pirq =3D info->irq[pin - 1].link;
 	mask =3D info->irq[pin - 1].bitmap;
 	if (!pirq) {
-		dev_dbg(&dev->dev, "PCI INT %c not routed\n", 'A' + pin - 1);
+		dev_dbg(&dev->dev, "PCI INT %c not routed\n", 'A' + dpin - 1);
 		return 0;
 	}
 	dev_dbg(&dev->dev, "PCI INT %c -> PIRQ %02x, mask %04x, excl %04x",
-		'A' + pin - 1, pirq, mask, pirq_table->exclusive_irqs);
+		'A' + dpin - 1, pirq, mask, pirq_table->exclusive_irqs);
 	mask &=3D pcibios_irq_mask;
=20
 	/* Work around broken HP Pavilion Notebooks which assign USB to
@@ -1226,7 +1466,7 @@ static int pcibios_lookup_irq(struct pci_dev *dev, int =
assign)
 				newirq =3D i;
 		}
 	}
-	dev_dbg(&dev->dev, "PCI INT %c -> newirq %d", 'A' + pin - 1, newirq);
+	dev_dbg(&dev->dev, "PCI INT %c -> newirq %d", 'A' + dpin - 1, newirq);
=20
 	/* Check if it is hardcoded */
 	if ((pirq & 0xf0) =3D=3D 0xf0) {
@@ -1260,15 +1500,17 @@ static int pcibios_lookup_irq(struct pci_dev *dev, in=
t assign)
 			return 0;
 		}
 	}
-	dev_info(&dev->dev, "%s PCI INT %c -> IRQ %d\n", msg, 'A' + pin - 1, irq);
+	dev_info(&dev->dev, "%s PCI INT %c -> IRQ %d\n",
+		 msg, 'A' + dpin - 1, irq);
=20
 	/* Update IRQ for all devices with the same pirq value */
 	for_each_pci_dev(dev2) {
-		pci_read_config_byte(dev2, PCI_INTERRUPT_PIN, &pin);
-		if (!pin)
+		pci_read_config_byte(dev2, PCI_INTERRUPT_PIN, &dpin);
+		if (!dpin)
 			continue;
=20
-		info =3D pirq_get_info(dev2);
+		pin =3D dpin;
+		info =3D pirq_get_info(dev2, &pin);
 		if (!info)
 			continue;
 		if (info->irq[pin - 1].link =3D=3D pirq) {

