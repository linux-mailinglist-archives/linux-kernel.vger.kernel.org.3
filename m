Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A8A154DAE1
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 08:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358723AbiFPGlJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 02:41:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358713AbiFPGkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 02:40:49 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C087580CF
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 23:40:48 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 6D33C3200B2A;
        Thu, 16 Jun 2022 02:40:46 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 16 Jun 2022 02:40:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1655361645; x=1655448045; bh=uM
        iU0/vHQtAYhOmb6s+DsH12Q6brnpKc++SzAj3L2mk=; b=ljk4IdZT1ix1CUp2mu
        x/d7g0roVuaRQxHX+k4o8jNJ5NMZTAw5FXPvN0RdjgPQBiblruWaEsPkCCoZkLyq
        Q1TdHJieHlVHU39AxVK4DBDm2FpRLyAxkrmThAqbboDyTdaWPE9WGKVgkzsPAjmY
        4GWBY+I/81d9WLiUeguuWzzBCr1g29OUN2ZN+BNCAcKst1HwYTY7KHxjEdWrWtWA
        iWSYDAM8WOMoC+fxn7FPUBnKgpwXJarnyOg8S0KvveTCMewlEKteC0oRyUg4n+02
        xflUAW9mARqu3g6bSwiqns+ykWUhNt7bn5ZpYZcwz0UiznCzplsUbdGfKurSbLmF
        1vXA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1655361645; x=1655448045; bh=uMiU0/vHQtAYh
        Omb6s+DsH12Q6brnpKc++SzAj3L2mk=; b=nCOuqmSycUFRrZ5kNB8lkFHB/jFhg
        rBzlOlhN5aqDLMQXlU5Ys4OmR/wY65DQ9vpEIB7y5qmLCy9uknsueDCnGqE7IybJ
        DQW3n1/CT6KX6YxfuKZCSPZcvPmd9BzALd7AmqvW5vHIk5zrtYLY8HXs79Es3OB7
        JN8f5VvYpi8Zs5u5SxoJZdyQBz2XfnYJp1bxA28usiFNY4OKS604bVNsIndH0GEW
        +LayIee92TZJmIBUuZQwroNggOWzfel2VOEQhK/vqGn/jl+mZBo2jVE2VU2iQU0m
        jNS7+G255vMmFxUj+xcyi7/S43umuXA8ZwXNkQp4I+o9zpUaJtJX17JsQ==
X-ME-Sender: <xms:bdCqYhGFWAb6jV2diQY44yz2TlUptkgNzmeZbKtLAlkgoeMZ-W0V2A>
    <xme:bdCqYmUK4Oz1t58f_fKT_X9hLt25iM3MsJtmX8xburpJ1gb_HhW95bfaeu6u9GeKg
    4BaXPu_AaAwruHccw>
X-ME-Received: <xmr:bdCqYjKDN0eRWyQFj73cpxmMpM2uHhAJRrfoTNuXLtSLZDhcHI2yDUUe2Soj73u5yZh12is3ZnGvMGytjA0Jd14hGTYj0nTulLIMifeQwLMfUSLQ6gH9CgZaGfpRubY5oKLlNA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedruddvvddguddtkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghm
    uhgvlhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenuc
    ggtffrrghtthgvrhhnpedukeetueduhedtleetvefguddvvdejhfefudelgfduveeggeeh
    gfdufeeitdevteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:bdCqYnE0fcXiX5mQ11Whz8Pv2U-034XH3RqHUSo9SzN3URLi4NJFwQ>
    <xmx:bdCqYnWe3CVLSDhC39ZjJUvIEuJaY9LeQnWA127ryqk1QH03PURaZA>
    <xmx:bdCqYiMyD2D9ar8la0F8nsVqP6mYezMUBvPthVsqIjuZeSXJwneoJg>
    <xmx:bdCqYgtShV7gntXQVJkQAywOcMx-bTyH0EglRSEXE-oc8F9ae3VZJQ>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Jun 2022 02:40:45 -0400 (EDT)
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
Subject: [PATCH v2 5/6] irqchip/sifive-plic: Make better use of the effective affinity mask
Date:   Thu, 16 Jun 2022 01:40:27 -0500
Message-Id: <20220616064028.57933-6-samuel@sholland.org>
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

The PLIC driver already updates the effective affinity mask in its
.irq_set_affinity callback. Take advantage of that information to only
touch bits (and take spinlocks) for the specific relevant hart contexts.

First, make sure the effective affinity mask is set before IRQ startup.
Since this mask already takes priv->lmask into account, checking that
mask later is no longer needed (and handler->present is equivalent to
the bit being set in priv->lmask).

Then, when (un)masking or changing affinity, only clear/set the enable
bits in the specific old/new context(s). The cpumask operations in
plic_irq_unmask() are not needed because they duplicate the code in
plic_set_affinity().

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

(no changes since v1)

 drivers/irqchip/Kconfig           |  1 +
 drivers/irqchip/irq-sifive-plic.c | 26 ++++++++------------------
 2 files changed, 9 insertions(+), 18 deletions(-)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 68be9eccc897..ccaa13b727c9 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -530,6 +530,7 @@ config SIFIVE_PLIC
 	bool "SiFive Platform-Level Interrupt Controller"
 	depends on RISCV
 	select IRQ_DOMAIN_HIERARCHY
+	select GENERIC_IRQ_EFFECTIVE_AFF_MASK if SMP
 	help
 	   This enables support for the PLIC chip found in SiFive (and
 	   potentially other) RISC-V systems.  The PLIC controls devices
diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index bb87e4c3b88e..bf7d5bee0c0c 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -109,31 +109,18 @@ static inline void plic_irq_toggle(const struct cpumask *mask,
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
@@ -154,11 +141,13 @@ static int plic_set_affinity(struct irq_data *d,
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
@@ -184,6 +173,7 @@ static struct irq_chip plic_chip = {
 #ifdef CONFIG_SMP
 	.irq_set_affinity = plic_set_affinity,
 #endif
+	.flags		= IRQCHIP_AFFINITY_PRE_STARTUP,
 };
 
 static int plic_irqdomain_map(struct irq_domain *d, unsigned int irq,
-- 
2.35.1

