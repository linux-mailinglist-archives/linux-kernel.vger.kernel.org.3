Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20F754A796D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 21:30:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347111AbiBBUao (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 15:30:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347103AbiBBUam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 15:30:42 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C25E8C061714;
        Wed,  2 Feb 2022 12:30:42 -0800 (PST)
Date:   Wed, 02 Feb 2022 20:30:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1643833840;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9O6WyxcBrOo+QQFyI2l+l5J3E31MMOYOI0rMxKD3zYk=;
        b=dwiu5TSCZ3gutpoMjy37Z7V9K31s6feM1oizwF91oxzlnHPuCs3Zpo1eKkKztaZj7VdjxL
        Po96SVCUz8i9EAls6fUjbyloVTmaODjLV1q5JEsbUWoijQxJkZMPz7Wg16Xd/0+0a2Ge+V
        Pj6POp10X02suctIomyu/5DxFB2F6TpM8zm9LVaLu4DIzcRFjTwEGDp2zS9WB4I98VLGe3
        W8JBrZQT3mQ/TwxwgvW7Hc38QmsuzuwJJHLC1qHdQ3Ax+6UaScPxKJm8pz+7ioINO9Ey5L
        qURVxAYIKjSVu9tilyrGRuHF2kzg4+dMReugx7aKs1+ejWwluU2dVyvoPXPtzQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1643833840;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9O6WyxcBrOo+QQFyI2l+l5J3E31MMOYOI0rMxKD3zYk=;
        b=noFPejSPr7BrWAXRaAZuSIhWzA+5MXaN0YmMY5IxB9IJX+bMYI+nYrlnqM6XP/vV5EZXgT
        LQzL8FPpoSaA3mDg==
From:   "tip-bot2 for Maciej W. Rozycki" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/irq] x86/PCI: Fix coding style in PIRQ table search functions
Cc:     "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <alpine.DEB.2.21.2201022143470.56863@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2201022143470.56863@angie.orcam.me.uk>
MIME-Version: 1.0
Message-ID: <164383383887.16921.5598146936310753231.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/irq branch of tip:

Commit-ID:     449972c67ea78158bcd55d6a5ce6f941f8a4afa0
Gitweb:        https://git.kernel.org/tip/449972c67ea78158bcd55d6a5ce6f941f8a4afa0
Author:        Maciej W. Rozycki <macro@orcam.me.uk>
AuthorDate:    Thu, 06 Jan 2022 11:24:21 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 02 Feb 2022 21:27:55 +01:00

x86/PCI: Fix coding style in PIRQ table search functions

Remove extraneous spaces around casts.

Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/alpine.DEB.2.21.2201022143470.56863@angie.orcam.me.uk

---
 arch/x86/pci/irq.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/x86/pci/irq.c b/arch/x86/pci/irq.c
index b0d0640..9be1580 100644
--- a/arch/x86/pci/irq.c
+++ b/arch/x86/pci/irq.c
@@ -76,7 +76,7 @@ static inline struct irq_routing_table *pirq_check_routing_table(u8 *addr)
 	int i;
 	u8 sum;
 
-	rt = (struct irq_routing_table *) addr;
+	rt = (struct irq_routing_table *)addr;
 	if (rt->signature != PIRQ_SIGNATURE ||
 	    rt->version != PIRQ_VERSION ||
 	    rt->size % 16 ||
@@ -160,19 +160,19 @@ static inline struct irq_routing_table *pirq_convert_irt_table(u8 *addr)
 /*
  *  Search 0xf0000 -- 0xfffff for the PCI IRQ Routing Table.
  */
-
 static struct irq_routing_table * __init pirq_find_routing_table(void)
 {
 	u8 *addr;
 	struct irq_routing_table *rt;
 
 	if (pirq_table_addr) {
-		rt = pirq_check_routing_table((u8 *) __va(pirq_table_addr));
+		rt = pirq_check_routing_table((u8 *)__va(pirq_table_addr));
 		if (rt)
 			return rt;
 		printk(KERN_WARNING "PCI: PIRQ table NOT found at pirqaddr\n");
 	}
-	for (addr = (u8 *) __va(0xf0000); addr < (u8 *) __va(0x100000); addr += 16) {
+
+	for (addr = (u8 *)__va(0xf0000); addr < (u8 *)__va(0x100000); addr += 16) {
 		rt = pirq_check_routing_table(addr);
 		if (rt)
 			return rt;
@@ -191,7 +191,6 @@ static struct irq_routing_table * __init pirq_find_routing_table(void)
  *  bridges.  It's a gross hack, but since there are no other known
  *  ways how to get a list of buses, we have to go this way.
  */
-
 static void __init pirq_peer_trick(void)
 {
 	struct irq_routing_table *rt = pirq_table;
@@ -226,7 +225,6 @@ static void __init pirq_peer_trick(void)
  *  Code for querying and setting of IRQ routes on various interrupt routers.
  *  PIC Edge/Level Control Registers (ELCR) 0x4d0 & 0x4d1.
  */
-
 void elcr_set_level_irq(unsigned int irq)
 {
 	unsigned char mask = 1 << (irq & 7);
