Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2CA151F30D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 05:53:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233836AbiEIDwR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 23:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233301AbiEIDrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 23:47:33 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3176186E06
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 20:43:41 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 8F93D5C0114;
        Sun,  8 May 2022 23:43:40 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sun, 08 May 2022 23:43:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1652067820; x=1652154220; bh=cR
        qjRcNVYtqC51Nn/ZV3tYv8+W5V46C9d1O6IJ4rhWE=; b=SOrY909sBDtvCDGLCq
        mRkl4pc4UCfiUxpk/pPVcZpEUEASplhDWeb8Qig0cK2ddOzwgwEyCHkVar5UJZco
        sxI/SfbwPL31fYNE5sDIvlKs3aHZnR8u/KDDvw4wOQHD3nrU9NTfMSAF0vePaC7C
        tuFzON0lzlUShBKzS/cSZOzzSPWRRLef7MCVxScNkNjhE+Vayo9J03OAKXGNKpbf
        5atrE/GuToHnnkkF9qZ1lGS3zM9yibyCozX44GQ+64q5imRg5upAs4AqEYwAW6H+
        lItGQFBPJq3dIK8ejF0gNNkMVMVOxysvcNRGnA2OZm5IM7Ltm33dIqZ+6uSFpH79
        VPaQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1652067820; x=1652154220; bh=cRqjRcNVYtqC51Nn/ZV3tYv8+W5V46C9d1O
        6IJ4rhWE=; b=uNmHDBSBOtjRDuRpgzvVwde0VP7Dpg1JBV5pXsbFZhy7VmI3USt
        nCEvwcwUsNtJTWUlaNSvUbtaqIyiVArwHWgMrvFJ7j3O587CUL+aPe3dqPaubyVc
        VWeEoDqZREt7MvXeTalkWED0zoVZ5sgeJ3hr8ytRHZ1Qdz3hCaHz4S6ODZ3ROsHx
        oXOZ/9tINy42gFbn/gzeCDpp/5j5Znl0SNlJ9A/dgopL5gsWBpTmxoCYGv0jpMT/
        3KJycWKqMXQBaS2jf9ALtV4Ma4d2uWHOKHP/B/eDPdOFXgY2uaYITE6zBiPHjH0J
        mPH72NlNuCuPHzFVDqIZP9/m/TmFtUw2Myw==
X-ME-Sender: <xms:7I14Yj2Eptfgee3x6VL6mTx4hEMXYqvS5aohVuPwvVTYQEn-L1vZaw>
    <xme:7I14YiE454L8T1975bjTnxMgHfjxXyMwn9v4G_0TK4sf_fsjxALpYfvfBFloj9zDY
    UMuOG1bBN8eBZ-1UA>
X-ME-Received: <xmr:7I14Yj7krMxADt78Rh6AZWB5_ZCy63lIKGh-ee72F1UT51uvDGEq5HutAaqgasZIpCVq2IPZMs-j0Lb2L1QotySsZP-ICTvi0yu66g3mDkLiO_FGfO2VVesqbiFGMMwEV58Pfw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeekgdejhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpedukeetueduhedtleetvefguddvvdejhfefudelgfduveeggeehgfdu
    feeitdevteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:7I14Yo1OuOw5pn4TvQP80f3s1MJe1bamroihr7w_eHmtwGfxjaBCTA>
    <xmx:7I14YmHkS02UozCCB-9R0M_Q56c5RA36hOYsElKxgnuK5Dvdj73XsQ>
    <xmx:7I14Yp__0UDbDcbGQ4q9eRXFFO8J3nTXb0Guze9kwXJOgS8LEHYv2g>
    <xmx:7I14YiEbpAzWoPDSHBdhC9pwQOLBMWt9v9eV4N_Aqwz7x2harDjnJw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 8 May 2022 23:43:39 -0400 (EDT)
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
Subject: [PATCH 4/5] irqchip/sifive-plic: Make better use of the effective affinity mask
Date:   Sun,  8 May 2022 22:43:32 -0500
Message-Id: <20220509034333.60017-5-samuel@sholland.org>
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

 drivers/irqchip/Kconfig           |  1 +
 drivers/irqchip/irq-sifive-plic.c | 26 ++++++++------------------
 2 files changed, 9 insertions(+), 18 deletions(-)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index bc90500a7573..56ef2fc6d2eb 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -529,6 +529,7 @@ config SIFIVE_PLIC
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

