Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F156D4A797B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 21:31:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231300AbiBBUa6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 15:30:58 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:48962 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347118AbiBBUar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 15:30:47 -0500
Date:   Wed, 02 Feb 2022 20:30:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1643833845;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3aRGWud/DOOi8mTHRFG78/eFU/G8fOMLWznS+Mwub84=;
        b=b7uIfN/MsO/CWENSqO+XRJUFWH7Cp8ucZIdHavK6o27m+MC8O5pxMcgCxOhim7Zk3aSxUT
        UIhbkXVFsN3aXNJAS9llf8LCR6FffHt4VDnCwDsurfIW1vNxnSX0EUKbEx/tQWdZQ/+gqT
        uUE2nqWWdmKkE26rmK9b+gndbIuBnhyuPOWNuFBPAif33nmpdZOTJ50FlFXjXVx67Uc3S1
        jfdnofissUiRn1/ymbhUjcPFBxoKPmR5AUDrFwGMsbpByUn3Iawf3GkZ2lRcWnZvom1x8+
        /8iCj0rPOzuaz0wAWm63I6pGNXNOjbJ1Fe/L0KFwl3dzMGAH4Y2t9GJL9tMGXw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1643833845;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3aRGWud/DOOi8mTHRFG78/eFU/G8fOMLWznS+Mwub84=;
        b=U28t1mfNqehgulE7IM2/p867FLGCxIQkQYMsZcgvLFfIOkg2dk3b0fM6nhgCwEweeVuTfL
        bNm/hn3CgGblOnBw==
From:   "tip-bot2 for Maciej W. Rozycki" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/irq] x86/PCI: Disambiguate SiS85C503 PIRQ router code entities
Cc:     "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <alpine.DEB.2.21.2201022044250.56863@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2201022044250.56863@angie.orcam.me.uk>
MIME-Version: 1.0
Message-ID: <164383384445.16921.7041710605452893451.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/irq branch of tip:

Commit-ID:     040a35f1a327d6ffaf7bce58d429339ac96e3712
Gitweb:        https://git.kernel.org/tip/040a35f1a327d6ffaf7bce58d429339ac96e3712
Author:        Maciej W. Rozycki <macro@orcam.me.uk>
AuthorDate:    Sun, 02 Jan 2022 23:25:05 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 02 Feb 2022 21:27:55 +01:00

x86/PCI: Disambiguate SiS85C503 PIRQ router code entities

In preparation to adding support for the SiS85C497 PIRQ router add `503' 
to the names of SiS85C503 PIRQ router code entities so that they clearly 
indicate which device they refer to.

Also restructure `sis_router_probe' such that new device IDs will be 
just new switch cases.

No functional change.

Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/alpine.DEB.2.21.2201022044250.56863@angie.orcam.me.uk

---
 arch/x86/pci/irq.c | 33 ++++++++++++++++++---------------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/arch/x86/pci/irq.c b/arch/x86/pci/irq.c
index 23c69c4..e003541 100644
--- a/arch/x86/pci/irq.c
+++ b/arch/x86/pci/irq.c
@@ -641,11 +641,12 @@ static int pirq_cyrix_set(struct pci_dev *router, struct pci_dev *dev, int pirq,
  *				bit 6-4 are probably unused, not like 5595
  */
 
-#define PIRQ_SIS_IRQ_MASK	0x0f
-#define PIRQ_SIS_IRQ_DISABLE	0x80
-#define PIRQ_SIS_USB_ENABLE	0x40
+#define PIRQ_SIS503_IRQ_MASK	0x0f
+#define PIRQ_SIS503_IRQ_DISABLE	0x80
+#define PIRQ_SIS503_USB_ENABLE	0x40
 
-static int pirq_sis_get(struct pci_dev *router, struct pci_dev *dev, int pirq)
+static int pirq_sis503_get(struct pci_dev *router, struct pci_dev *dev,
+			   int pirq)
 {
 	u8 x;
 	int reg;
@@ -654,10 +655,11 @@ static int pirq_sis_get(struct pci_dev *router, struct pci_dev *dev, int pirq)
 	if (reg >= 0x01 && reg <= 0x04)
 		reg += 0x40;
 	pci_read_config_byte(router, reg, &x);
-	return (x & PIRQ_SIS_IRQ_DISABLE) ? 0 : (x & PIRQ_SIS_IRQ_MASK);
+	return (x & PIRQ_SIS503_IRQ_DISABLE) ? 0 : (x & PIRQ_SIS503_IRQ_MASK);
 }
 
-static int pirq_sis_set(struct pci_dev *router, struct pci_dev *dev, int pirq, int irq)
+static int pirq_sis503_set(struct pci_dev *router, struct pci_dev *dev,
+			   int pirq, int irq)
 {
 	u8 x;
 	int reg;
@@ -666,8 +668,8 @@ static int pirq_sis_set(struct pci_dev *router, struct pci_dev *dev, int pirq, i
 	if (reg >= 0x01 && reg <= 0x04)
 		reg += 0x40;
 	pci_read_config_byte(router, reg, &x);
-	x &= ~(PIRQ_SIS_IRQ_MASK | PIRQ_SIS_IRQ_DISABLE);
-	x |= irq ? irq: PIRQ_SIS_IRQ_DISABLE;
+	x &= ~(PIRQ_SIS503_IRQ_MASK | PIRQ_SIS503_IRQ_DISABLE);
+	x |= irq ? irq : PIRQ_SIS503_IRQ_DISABLE;
 	pci_write_config_byte(router, reg, x);
 	return 1;
 }
@@ -966,13 +968,14 @@ static __init int serverworks_router_probe(struct irq_router *r,
 
 static __init int sis_router_probe(struct irq_router *r, struct pci_dev *router, u16 device)
 {
-	if (device != PCI_DEVICE_ID_SI_503)
-		return 0;
-
-	r->name = "SIS";
-	r->get = pirq_sis_get;
-	r->set = pirq_sis_set;
-	return 1;
+	switch (device) {
+	case PCI_DEVICE_ID_SI_503:
+		r->name = "SiS85C503";
+		r->get = pirq_sis503_get;
+		r->set = pirq_sis503_set;
+		return 1;
+	}
+	return 0;
 }
 
 static __init int cyrix_router_probe(struct irq_router *r, struct pci_dev *router, u16 device)
