Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E7F74C8908
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 11:11:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234198AbiCAKMa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 05:12:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233723AbiCAKMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 05:12:20 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B70AD8CD9F
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 02:11:39 -0800 (PST)
Date:   Tue, 01 Mar 2022 10:11:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1646129498;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pRangvu5RLboKHIye5cT1C5tqZ2xo+0UuANkfhLKFwM=;
        b=2fHRgp6m6wGnmscqaCzEIkJ+rACQuCvm86dKXUAj++M6y/C7iYmsGg5RDOHk5hyxii7wwv
        hWE7d/Ge64Iq5mdWLb/5WEuAUHGm2yxhR+QZN2oj9Fl7kkB3U8/xiJHo8YgBshYZkQWQRL
        WdxIW6pV/mn7jud5hwgNpLPupjTEFzdydNFG5qpQeKYK3MjcrrU9RFiRppFgZvPgfjZkeG
        a1jnO4YrYQPhCkPPyG6zrXUfeCkh2wpYxXpP0dILDgnENtfPzlxs3LM9PB7hsb3zaCfe4z
        Kk75/lRYFJ9V4ib/uqFMEGSjiFSpUMVaRGACTSlgVsKlDgHRRKAxaVOFjDh5Sw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1646129498;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pRangvu5RLboKHIye5cT1C5tqZ2xo+0UuANkfhLKFwM=;
        b=v9+IJJL0gX4hgGYHet6llSxYdlzaYXtzbZiI1Srq1uZAdlcgH3QZZaX+oaKmVkxRdA3tSO
        yZZ02JseGEDExrBA==
From:   "irqchip-bot for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/qcom-pdc: Kill PDC_NO_PARENT_IRQ
Cc:     Marc Zyngier <maz@kernel.org>,
        Maulik Shah <quic_mkshah@quicinc.com>, tglx@linutronix.de
In-Reply-To: <20220224101226.88373-2-maz@kernel.org>
References: <20220224101226.88373-2-maz@kernel.org>
MIME-Version: 1.0
Message-ID: <164612949730.16921.4244489669028892146.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     8d4c998919320206f8832dc413e23fdd27ef2274
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/8d4c998919320206f8832dc413e23fdd27ef2274
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Thu, 24 Feb 2022 10:12:22 
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Tue, 01 Mar 2022 10:06:24 

irqchip/qcom-pdc: Kill PDC_NO_PARENT_IRQ

PDC_NO_PARENT_IRQ is pretty pointless, as all it indicates is
that the PDC terminates the interrupt hierarchy. Which is
exactly the same as not having a mapping in the GIC space.
This is also bad practice to treat the absence of a hwirq
as a hwirq itself.

Just explicitly use the region mapping pointer, and drop
the definition.

Signed-off-by: Marc Zyngier <maz@kernel.org>
Reviewed-by: Maulik Shah <quic_mkshah@quicinc.com>
Link: https://lore.kernel.org/r/20220224101226.88373-2-maz@kernel.org
---
 drivers/irqchip/qcom-pdc.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/irqchip/qcom-pdc.c b/drivers/irqchip/qcom-pdc.c
index 173e652..3b214c4 100644
--- a/drivers/irqchip/qcom-pdc.c
+++ b/drivers/irqchip/qcom-pdc.c
@@ -30,14 +30,14 @@
 #define IRQ_ENABLE_BANK		0x10
 #define IRQ_i_CFG		0x110
 
-#define PDC_NO_PARENT_IRQ	~0UL
-
 struct pdc_pin_region {
 	u32 pin_base;
 	u32 parent_base;
 	u32 cnt;
 };
 
+#define pin_to_hwirq(r, p)	((r)->parent_base + (p) - (r)->pin_base)
+
 static DEFINE_RAW_SPINLOCK(pdc_lock);
 static void __iomem *pdc_base;
 static struct pdc_pin_region *pdc_region;
@@ -186,19 +186,17 @@ static struct irq_chip qcom_pdc_gic_chip = {
 	.irq_set_affinity	= irq_chip_set_affinity_parent,
 };
 
-static irq_hw_number_t get_parent_hwirq(int pin)
+static struct pdc_pin_region *get_pin_region(int pin)
 {
 	int i;
-	struct pdc_pin_region *region;
 
 	for (i = 0; i < pdc_region_cnt; i++) {
-		region = &pdc_region[i];
-		if (pin >= region->pin_base &&
-		    pin < region->pin_base + region->cnt)
-			return (region->parent_base + pin - region->pin_base);
+		if (pin >= pdc_region[i].pin_base &&
+		    pin < pdc_region[i].pin_base + pdc_region[i].cnt)
+			return &pdc_region[i];
 	}
 
-	return PDC_NO_PARENT_IRQ;
+	return NULL;
 }
 
 static int qcom_pdc_translate(struct irq_domain *d, struct irq_fwspec *fwspec,
@@ -221,7 +219,8 @@ static int qcom_pdc_alloc(struct irq_domain *domain, unsigned int virq,
 {
 	struct irq_fwspec *fwspec = data;
 	struct irq_fwspec parent_fwspec;
-	irq_hw_number_t hwirq, parent_hwirq;
+	struct pdc_pin_region *region;
+	irq_hw_number_t hwirq;
 	unsigned int type;
 	int ret;
 
@@ -234,8 +233,8 @@ static int qcom_pdc_alloc(struct irq_domain *domain, unsigned int virq,
 	if (ret)
 		return ret;
 
-	parent_hwirq = get_parent_hwirq(hwirq);
-	if (parent_hwirq == PDC_NO_PARENT_IRQ)
+	region = get_pin_region(hwirq);
+	if (!region)
 		return irq_domain_disconnect_hierarchy(domain->parent, virq);
 
 	if (type & IRQ_TYPE_EDGE_BOTH)
@@ -247,7 +246,7 @@ static int qcom_pdc_alloc(struct irq_domain *domain, unsigned int virq,
 	parent_fwspec.fwnode      = domain->parent->fwnode;
 	parent_fwspec.param_count = 3;
 	parent_fwspec.param[0]    = 0;
-	parent_fwspec.param[1]    = parent_hwirq;
+	parent_fwspec.param[1]    = pin_to_hwirq(region, hwirq);
 	parent_fwspec.param[2]    = type;
 
 	return irq_domain_alloc_irqs_parent(domain, virq, nr_irqs,
@@ -265,7 +264,8 @@ static int qcom_pdc_gpio_alloc(struct irq_domain *domain, unsigned int virq,
 {
 	struct irq_fwspec *fwspec = data;
 	struct irq_fwspec parent_fwspec;
-	irq_hw_number_t hwirq, parent_hwirq;
+	struct pdc_pin_region *region;
+	irq_hw_number_t hwirq;
 	unsigned int type;
 	int ret;
 
@@ -281,8 +281,8 @@ static int qcom_pdc_gpio_alloc(struct irq_domain *domain, unsigned int virq,
 	if (ret)
 		return ret;
 
-	parent_hwirq = get_parent_hwirq(hwirq);
-	if (parent_hwirq == PDC_NO_PARENT_IRQ)
+	region = get_pin_region(hwirq);
+	if (!region)
 		return irq_domain_disconnect_hierarchy(domain->parent, virq);
 
 	if (type & IRQ_TYPE_EDGE_BOTH)
@@ -294,7 +294,7 @@ static int qcom_pdc_gpio_alloc(struct irq_domain *domain, unsigned int virq,
 	parent_fwspec.fwnode      = domain->parent->fwnode;
 	parent_fwspec.param_count = 3;
 	parent_fwspec.param[0]    = 0;
-	parent_fwspec.param[1]    = parent_hwirq;
+	parent_fwspec.param[1]    = pin_to_hwirq(region, hwirq);
 	parent_fwspec.param[2]    = type;
 
 	return irq_domain_alloc_irqs_parent(domain, virq, nr_irqs,
