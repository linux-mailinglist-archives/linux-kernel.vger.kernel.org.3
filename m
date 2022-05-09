Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBC7F51F31A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 05:53:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233676AbiEIDwB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 23:52:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233338AbiEIDrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 23:47:35 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38C8D74DEC
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 20:43:42 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 9AD2E5C0115;
        Sun,  8 May 2022 23:43:41 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Sun, 08 May 2022 23:43:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1652067821; x=1652154221; bh=/2
        9rtCFFrhMq7Dm0L/1ahNgZdkKRCrzt5ZSJjaaJ7o4=; b=pml44wNydIpx6sIAHs
        QutFDoKw+jCtahf93JAI2UzQkHx8pxJc7ge66fT7SvrhOBQuwoAUZxyKQBl8btEh
        BYbQjjDUPPxoBF9g/0ACHSU9E+N4hu6Rf3M/qMKTRxV4TZSV5NR1W4xotiypXbQ1
        vnHI2cusAcXs+NhIMwqjYA/s1zduVRR/iBVQEIuDJrrFeh37QlHFCWEV+TnysPIr
        B9lD9Cj2IrUya1DeMf3CExgyB0XPwNX0PqodEFaNqxmXQTOoDK76fEVdjq3/XYBX
        OuWtT6yA42ILLi9KJ7Hi1iY1iUzzlbIPgaqt2nvRCjin/CI6dbFJT/UN5tyLgoU3
        rOTA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1652067821; x=1652154221; bh=/29rtCFFrhMq7Dm0L/1ahNgZdkKRCrzt5ZS
        JjaaJ7o4=; b=F5EJGKjhgjYiMng4/n8TtMnPjEZ1TLztMgYNwJXbI5qi3EJuwid
        jOx+ZNcXcgAHZWOWjXFYjQchpO7hxa79iDd2FruWGeXa6sqH8RqSLRrQ8MtOaxw1
        svD8YkLU4nK4ekOr5TVcodRSvRFslGq+EYwaS1R1hG7RWkFKGd/dZahEtV/XqVzQ
        YjOEtvbIvnuWW7snrLHz6GRCIddoYqsWTkoKs4lyIGdJS6cZgodpTI4t9LRdRsGj
        VtlpcQ5/+iRh1/NwdAOBi2qsTVvHyzy5KkRbDlM1oeYXfHu4gC2Wc5uyhpPM0syp
        szwrq6pNyQ7tGT2EeKmnvINAZGiHLx2iVFw==
X-ME-Sender: <xms:7Y14YmEESqvVCuF8oy4RX1zWLGMohKBfRlUJKQLwSOyrbpunpt8JGw>
    <xme:7Y14YnUf1d1OArytOZnuh8qADLeWxttJrTT4dvWVErvP1Kr9u6qLGD5tvT59QKfX5
    JOb3U8SzANRZtzIpQ>
X-ME-Received: <xmr:7Y14YgLbPVvm5Hvrjq6yxLQrCsGDsWsdZ0ztwYuEs_9UYHVNH9k7QVoi56g8PhJFO-GRM4Jh0Ct9wzStbIyYdUsmkfCTv84nO8KVKpRPiFxDQ9B9V0l6Gl3weszMfEcOuS1PVQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeekgdejiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpedukeetueduhedtleetvefguddvvdejhfefudelgfduveeggeehgfdu
    feeitdevteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:7Y14YgF41VKTEU3VBDJl3CzjTlMOgrzD0O5LMmMw7BiiNkIcjgLAVw>
    <xmx:7Y14YsXC5MnXadZNwC5VnGWWmTPLONt_9Fzmk0AorOGl-K-jgxdUaw>
    <xmx:7Y14YjOI5mHJUxlZwYRYk2Z5M8NiZcQ8-Ih_leB7ALFMLJbfNr7_Uw>
    <xmx:7Y14YtV8ggjvNp-j6HIIsp_QyYwo7xxyt4gI_TnXkhPqnzMs6YhWQQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 8 May 2022 23:43:40 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Samuel Holland <samuel@sholland.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Guo Ren <guoren@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Wei Xu <xuwei5@hisilicon.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH 5/5] irqchip/sifive-plic: Separate the enable and mask operations
Date:   Sun,  8 May 2022 22:43:33 -0500
Message-Id: <20220509034333.60017-6-samuel@sholland.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220509034333.60017-1-samuel@sholland.org>
References: <20220509034333.60017-1-samuel@sholland.org>
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
  2) The following requirememnt from the PLIC spec, which explains the
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

