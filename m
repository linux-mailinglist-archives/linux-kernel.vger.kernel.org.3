Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1240954DAE4
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 08:41:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359259AbiFPGlM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 02:41:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359255AbiFPGkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 02:40:51 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5A1B583AB
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 23:40:50 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 401C83200B3D;
        Thu, 16 Jun 2022 02:40:49 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 16 Jun 2022 02:40:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1655361648; x=1655448048; bh=MH
        jenYqjbc5iX1DDQJLjs+/Q4o7cKcluDYa/ibxYolQ=; b=onjoECb1FpSrXJCS/Z
        dGfDdPKPqcy+ugDA3IPIwTu539hY/LrBhXjU1sDZ+NRRcEeVlvzsOjGpoWdZ25Ft
        7rzPDNqXWQbWz8r/+L4eTtdZOBSt06EFfjUaU2AXxWjFhZfJKDNCbe9oBJ1Sl3eV
        CoThwcyUvpV2SV0rXIGXNIZ9JJMMCbsj5ihvde+0wJdjzQiloUHG2KCVwxoSoIDs
        LpydQOCWvArPm6s9bdxZddwdqTjH0BUJlb8X1fTOVD8kwPjLMWm5U5ZaP+DyzVZ1
        g+P+KvKOeqMRPwJxa6l3Wsp8ja716H3DrR7DxUhtEFiY61bQUe0mP46h3Nf/FNds
        k0/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1655361648; x=1655448048; bh=MHjenYqjbc5iX
        1DDQJLjs+/Q4o7cKcluDYa/ibxYolQ=; b=ZQumxlvxPeRsrOH9vREPiNuwKRnrE
        e6ZOPExBR1beMVWdbAznpM5ObZlHSRQUvpKdQmvkshq4CQwjd53UkWoqTooDyZ5L
        BCU9l9Tp43wAJpo+OnBS2+OAsTSfrchJXpXloseLWcQK1SVwgJiHfPkXTH6ZyWEN
        R5qGrnv8kM8BbGy+QEfLS9MdzqBYbF5NVduqA6Kzyp5P19wnhfUvCBC0iz0MTqiG
        mKQ0Sye/ibs9JUEi5P3rYXpYmp4dNogCh183Km/+i8HjW3eLUh/DcLKfP3wq0bbE
        zkOgb5KR/QZlXubrKhdMvdb/v3m/XkB5fQQvDN9P8TLBBb1nvuLhGb63w==
X-ME-Sender: <xms:cNCqYg_KQ1voYWBh7E0VZojE6_B5EIYlJ8-kdFVPDLu2WzgYL95YZg>
    <xme:cNCqYoueMFP0zR76yYnZGE7VTJ1GCDnJP-e3Quu6KjBo8dbUqu-dLZ3CmYv2mBFxf
    xO3l5OpfEmGj1JngA>
X-ME-Received: <xmr:cNCqYmC7qMO4fFjl7xKtl4QjQHsZoK2CRW4IKYMGyIRLYN5eVULc66o1T0Sdihp0rrnrXhkeeRnTyD4iLkH3BZbromyjjuVuMsSJNYVXxDHioZL1CTw9-sgyvZ8esHkz10t4Vw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedruddvvddguddtkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghm
    uhgvlhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenuc
    ggtffrrghtthgvrhhnpedukeetueduhedtleetvefguddvvdejhfefudelgfduveeggeeh
    gfdufeeitdevteenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:cNCqYgd0kyiiQJ86e2vSuWUyUXjAz6yIWi7aC1yiQwnjYeB_ISjpew>
    <xmx:cNCqYlN1vgW0yN5eEEbMFsSJoBnM_wMBiHxrIOzNIal5xoDHoD-2iA>
    <xmx:cNCqYqki6zJVX__ed6nFZfPzuB85_c-kvym3NaNTyXm5mChG-K5IRg>
    <xmx:cNCqYpl-MLciV_OUz5LqoUH52lW8Mn_Suh884K_N9-dCyVeJv5LJvw>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Jun 2022 02:40:48 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Samuel Holland <samuel@sholland.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Guo Ren <guoren@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Wei Xu <xuwei5@hisilicon.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH v2 6/6] irqchip/sifive-plic: Separate the enable and mask operations
Date:   Thu, 16 Jun 2022 01:40:28 -0500
Message-Id: <20220616064028.57933-7-samuel@sholland.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220616064028.57933-1-samuel@sholland.org>
References: <20220616064028.57933-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PLIC has two per-IRQ checks before sending an IRQ to a hart context.
First, it checks that the IRQ's priority is nonzero. Then, it checks
that the enable bit is set for that combination of IRQ and context.

Currently, the PLIC driver sets both the priority value and the enable
bit in its (un)mask operations. However, modifying the enable bit is
problematic for two reasons:
  1) The enable bits are packed, so changes are not atomic and require
     taking a spinlock.
  2) The following requirement from the PLIC spec, which explains the
     racy (un)mask operations in plic_irq_eoi():

       If the completion ID does not match an interrupt source
       that is currently enabled for the target, the completion
       is silently ignored.

Both of these problems are solved by using the priority value to mask
IRQs. Each IRQ has a separate priority register, so writing the priority
value is atomic. And since the enable bit remains set while an IRQ is
masked, the EOI operation works normally. The enable bits are still used
to control the IRQ's affinity.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

(no changes since v1)

 drivers/irqchip/irq-sifive-plic.c | 53 +++++++++++++++++++------------
 1 file changed, 32 insertions(+), 21 deletions(-)

diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index bf7d5bee0c0c..53d266a571be 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -103,9 +103,7 @@ static inline void plic_irq_toggle(const struct cpumask *mask,
 				   struct irq_data *d, int enable)
 {
 	int cpu;
-	struct plic_priv *priv = irq_data_get_irq_chip_data(d);
 
-	writel(enable, priv->regs + PRIORITY_BASE + d->hwirq * PRIORITY_PER_ID);
 	for_each_cpu(cpu, mask) {
 		struct plic_handler *handler = per_cpu_ptr(&plic_handlers, cpu);
 
@@ -113,16 +111,37 @@ static inline void plic_irq_toggle(const struct cpumask *mask,
 	}
 }
 
-static void plic_irq_unmask(struct irq_data *d)
+static void plic_irq_enable(struct irq_data *d)
 {
 	plic_irq_toggle(irq_data_get_effective_affinity_mask(d), d, 1);
 }
 
-static void plic_irq_mask(struct irq_data *d)
+static void plic_irq_disable(struct irq_data *d)
 {
 	plic_irq_toggle(irq_data_get_effective_affinity_mask(d), d, 0);
 }
 
+static void plic_irq_unmask(struct irq_data *d)
+{
+	struct plic_priv *priv = irq_data_get_irq_chip_data(d);
+
+	writel(1, priv->regs + PRIORITY_BASE + d->hwirq * PRIORITY_PER_ID);
+}
+
+static void plic_irq_mask(struct irq_data *d)
+{
+	struct plic_priv *priv = irq_data_get_irq_chip_data(d);
+
+	writel(0, priv->regs + PRIORITY_BASE + d->hwirq * PRIORITY_PER_ID);
+}
+
+static void plic_irq_eoi(struct irq_data *d)
+{
+	struct plic_handler *handler = this_cpu_ptr(&plic_handlers);
+
+	writel(d->hwirq, handler->hart_base + CONTEXT_CLAIM);
+}
+
 #ifdef CONFIG_SMP
 static int plic_set_affinity(struct irq_data *d,
 			     const struct cpumask *mask_val, bool force)
@@ -141,32 +160,21 @@ static int plic_set_affinity(struct irq_data *d,
 	if (cpu >= nr_cpu_ids)
 		return -EINVAL;
 
-	plic_irq_mask(d);
+	plic_irq_disable(d);
 
 	irq_data_update_effective_affinity(d, cpumask_of(cpu));
 
-	if (!irqd_irq_masked(d))
-		plic_irq_unmask(d);
+	if (!irqd_irq_disabled(d))
+		plic_irq_enable(d);
 
 	return IRQ_SET_MASK_OK_DONE;
 }
 #endif
 
-static void plic_irq_eoi(struct irq_data *d)
-{
-	struct plic_handler *handler = this_cpu_ptr(&plic_handlers);
-
-	if (irqd_irq_masked(d)) {
-		plic_irq_unmask(d);
-		writel(d->hwirq, handler->hart_base + CONTEXT_CLAIM);
-		plic_irq_mask(d);
-	} else {
-		writel(d->hwirq, handler->hart_base + CONTEXT_CLAIM);
-	}
-}
-
 static struct irq_chip plic_chip = {
 	.name		= "SiFive PLIC",
+	.irq_enable	= plic_irq_enable,
+	.irq_disable	= plic_irq_disable,
 	.irq_mask	= plic_irq_mask,
 	.irq_unmask	= plic_irq_unmask,
 	.irq_eoi	= plic_irq_eoi,
@@ -372,8 +380,11 @@ static int __init plic_init(struct device_node *node,
 			i * CONTEXT_ENABLE_SIZE;
 		handler->priv = priv;
 done:
-		for (hwirq = 1; hwirq <= nr_irqs; hwirq++)
+		for (hwirq = 1; hwirq <= nr_irqs; hwirq++) {
 			plic_toggle(handler, hwirq, 0);
+			writel(1, priv->regs + PRIORITY_BASE +
+				  hwirq * PRIORITY_PER_ID);
+		}
 		nr_handlers++;
 	}
 
-- 
2.35.1

