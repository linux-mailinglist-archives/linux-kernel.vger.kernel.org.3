Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE879563AF1
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 22:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232404AbiGAUYv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 16:24:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231148AbiGAUYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 16:24:46 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB3F9326CE
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 13:24:43 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 4B4F95C0110;
        Fri,  1 Jul 2022 16:24:43 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Fri, 01 Jul 2022 16:24:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1656707083; x=1656793483; bh=kL
        8pFphnsD3mAujBeB5qjcFnmIsFAIeaKX30aQbz51E=; b=EyONw1Yu8+T8p37RO4
        awUhCi6wA0+MiVEULKxYCoBi8opKLEwVnuzqcYCGc6lIt3sEg2tlyw8yKTa/Jh0u
        Ce/Tz0B9RU6QyDFg5MzJZmMHE5Bb5Ru8D+LEw14tRsGhhetxXym0Bh2QRoF00L0D
        EdKBF9AWDZIki/Z31FhBb44tAEHsOyzUef4gdUVd0t00bstUC+KbGFbnwzw8JpQm
        hNrdFdL1cucfuwH4UepWSh6DoUObnWuIDqXYKAzhi2frpfl4v2HH40jQSY3bJOcz
        uhlBRLgSJT+y8PjrxSkqyRX3Arb9/IjrrRaFputEeqc8zu4qQjYn5vhkMpvO0K5h
        +bDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1656707083; x=1656793483; bh=kL8pFphnsD3mA
        ujBeB5qjcFnmIsFAIeaKX30aQbz51E=; b=muW6pOx1zWkvnYbBckILhkJLyNo3e
        30s7Nczk/nFtiR54O0nfjOGokUT+7P4YAZoQCmYqxCT7/KUu5aYOhdI6f4QsiY+V
        pc4IQERuGlbkQMDPNp4nSO4yjbGOIfF4VC6JfwBEz6Yb2tzF49xU2xt4gfZ/0ZRW
        SpiP6MWkYqVB398hD3kxX8JWe/CCJphDI2rXoD3nHmeAjXfHBUw0M+R52IwPf5D7
        m38b/jIN9ducIKseTBCuYRWI6Qk4KYE0C/sa+GMTYE4pw/xX/taTKt5nIPRu86Fn
        zEqIkGzP+g2Vj+Y1Av1KR8Ph6BL52gFONe/L+jzhEuUq6rd8t8s2EjAoQ==
X-ME-Sender: <xms:Cli_YmgaJ3czx9-G9oRmTBSu3ou3fHlHQKdC8nTMtw9WT7GJvW63Hg>
    <xme:Cli_YnDKNa1AWX10EhOKVHIlBwGR_R4GyY70pjSWJ-UdZGQ-m2WSOCyUGU0flz61o
    LA14AlfX77KrfqKKQ>
X-ME-Received: <xmr:Cli_YuEpaMp2_4RntfgIDMDBSssYVOq8lSMpmfumx7-xjFi3pe0yxmgJzS3QrizV1bTWFN4LuzbGwYgA4oMscnl6mPQT3HSZ_ZdJYKg9mHYeE3Tg-4hgAgnh9apTDV4TGuc6gQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudehfedgudeglecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghm
    uhgvlhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenuc
    ggtffrrghtthgvrhhnpedukeetueduhedtleetvefguddvvdejhfefudelgfduveeggeeh
    gfdufeeitdevteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:C1i_YvRmScJbKUt6dOSckYYzhYtWcZpcY3nMteIRakXAGT-JKERHkQ>
    <xmx:C1i_YjzS82ggCSWYyu6jXZVC6mXnx8ZkkIHAlK7MfYCSeqYaMid_EQ>
    <xmx:C1i_Yt4H6RZHWqZswBr0Ccx14NrdQaMWzk2X1sR2asucJMnTv8C_pQ>
    <xmx:C1i_YqnprzGe5mhc1ktw5ddYdRZV5jL3Zt_y1LEHOQDXhBkVVzitJQ>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 1 Jul 2022 16:24:42 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Samuel Holland <samuel@sholland.org>, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH v3 1/2] irqchip/sifive-plic: Make better use of the effective affinity mask
Date:   Fri,  1 Jul 2022 15:24:39 -0500
Message-Id: <20220701202440.59059-2-samuel@sholland.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220701202440.59059-1-samuel@sholland.org>
References: <20220701202440.59059-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PLIC driver already updates the effective affinity mask in its
.irq_set_affinity callback. Take advantage of that information to only
touch bits (and take spinlocks) for the specific relevant hart contexts.

First, make sure the effective affinity mask is set before IRQ startup.

Then, since this mask already takes priv->lmask into account, checking
that mask later is no longer needed (and handler->present is equivalent
to the bit being set in priv->lmask).

Finally, when (un)masking or changing affinity, only clear/set the
enable bits in the specific old/new context(s). The cpumask operations
in plic_irq_unmask() are not needed because they duplicate the code in
plic_set_affinity().

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

Changes in v3:
 - Rebased on top of irqchip-next

 drivers/irqchip/Kconfig           |  1 +
 drivers/irqchip/irq-sifive-plic.c | 27 +++++++++------------------
 2 files changed, 10 insertions(+), 18 deletions(-)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 462adac905a6..ea7b7485327c 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -531,6 +531,7 @@ config SIFIVE_PLIC
 	bool "SiFive Platform-Level Interrupt Controller"
 	depends on RISCV
 	select IRQ_DOMAIN_HIERARCHY
+	select GENERIC_IRQ_EFFECTIVE_AFF_MASK if SMP
 	help
 	   This enables support for the PLIC chip found in SiFive (and
 	   potentially other) RISC-V systems.  The PLIC controls devices
diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index b3a36dca7f1b..46595e607b0e 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -114,31 +114,18 @@ static inline void plic_irq_toggle(const struct cpumask *mask,
 	for_each_cpu(cpu, mask) {
 		struct plic_handler *handler = per_cpu_ptr(&plic_handlers, cpu);
 
-		if (handler->present &&
-		    cpumask_test_cpu(cpu, &handler->priv->lmask))
-			plic_toggle(handler, d->hwirq, enable);
+		plic_toggle(handler, d->hwirq, enable);
 	}
 }
 
 static void plic_irq_unmask(struct irq_data *d)
 {
-	struct cpumask amask;
-	unsigned int cpu;
-	struct plic_priv *priv = irq_data_get_irq_chip_data(d);
-
-	cpumask_and(&amask, &priv->lmask, cpu_online_mask);
-	cpu = cpumask_any_and(irq_data_get_affinity_mask(d),
-					   &amask);
-	if (WARN_ON_ONCE(cpu >= nr_cpu_ids))
-		return;
-	plic_irq_toggle(cpumask_of(cpu), d, 1);
+	plic_irq_toggle(irq_data_get_effective_affinity_mask(d), d, 1);
 }
 
 static void plic_irq_mask(struct irq_data *d)
 {
-	struct plic_priv *priv = irq_data_get_irq_chip_data(d);
-
-	plic_irq_toggle(&priv->lmask, d, 0);
+	plic_irq_toggle(irq_data_get_effective_affinity_mask(d), d, 0);
 }
 
 #ifdef CONFIG_SMP
@@ -159,11 +146,13 @@ static int plic_set_affinity(struct irq_data *d,
 	if (cpu >= nr_cpu_ids)
 		return -EINVAL;
 
-	plic_irq_toggle(&priv->lmask, d, 0);
-	plic_irq_toggle(cpumask_of(cpu), d, !irqd_irq_masked(d));
+	plic_irq_mask(d);
 
 	irq_data_update_effective_affinity(d, cpumask_of(cpu));
 
+	if (!irqd_irq_masked(d))
+		plic_irq_unmask(d);
+
 	return IRQ_SET_MASK_OK_DONE;
 }
 #endif
@@ -190,6 +179,7 @@ static struct irq_chip plic_edge_chip = {
 	.irq_set_affinity = plic_set_affinity,
 #endif
 	.irq_set_type	= plic_irq_set_type,
+	.flags		= IRQCHIP_AFFINITY_PRE_STARTUP,
 };
 
 static struct irq_chip plic_chip = {
@@ -201,6 +191,7 @@ static struct irq_chip plic_chip = {
 	.irq_set_affinity = plic_set_affinity,
 #endif
 	.irq_set_type	= plic_irq_set_type,
+	.flags		= IRQCHIP_AFFINITY_PRE_STARTUP,
 };
 
 static int plic_irq_set_type(struct irq_data *d, unsigned int type)
-- 
2.35.1

