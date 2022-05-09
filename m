Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9CE451F317
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 05:53:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233635AbiEIDv5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 23:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233088AbiEIDrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 23:47:31 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0418474DEC
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 20:43:38 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 1CE8E5C0059;
        Sun,  8 May 2022 23:43:37 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Sun, 08 May 2022 23:43:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1652067817; x=1652154217; bh=d0
        1N/erYFX7bR8qphSaL0E+u7qcuOLHPoAFbrgswNxo=; b=SkhbTEZCfHoUSC+hT6
        Xw+sFgzQf3tB7PglZb4Gc/AEYXzaMxZaf7tMx7v9GuEQU1iBVtRfpyuY78VM7FN7
        O75GxUP5ljbDG1ROmHXc/s4/h+mFFmeziGzx/HGY/uxQlJFR9OrowoDRSLHo7EGT
        O6yHyoqTn5TYuWTUYzVcluxtV8SRntRHRn2J9NC8y7TgPgb53buYwtULZFMNv0Q4
        eAq4EPfV8Eg+MkaHzWOZgd33QddU93SLje5Flk/sjVsoAgXwm3EeGhThVZn1Uq04
        oHhJ8f9ZP+fLiNC6IDMG+idFltghxB3YOnkcv5D+lmWo+bqYmt4KTbCOJnqWw/RB
        cZqw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1652067817; x=1652154217; bh=d01N/erYFX7bR8qphSaL0E+u7qcuOLHPoAF
        brgswNxo=; b=waT+PST6TZOCYGD6+mgqu8u9k1ii+EPtIJNJguXjbc/Q/xk2Vv/
        fOX3Naupih4ONT8Ac/MzrVD47b0KOOXwRBlu2u8ln0u9klvMQbUwn6jgoqBA/ZI4
        Pvam9p4tP76MIPoHBqbsApWlvjG5ik5pd5/jsfqffpGG6ZVQSpPJ9QVp78VxcvDR
        GGfXa+M/wZbPBkCSuB76+aZre6Bckipgn6KMF82DRQr+m4j8upHqkHWRH4wEENnD
        qN58YlPEBVFeuqJpLRl/Y4a12Ty+Z9VBECWSVRDcgynuAlOUi2nzlAXwQyBpiVGI
        6cUcszL+uxnia5sEmlZnVwnsvFN4fCqqKiA==
X-ME-Sender: <xms:6I14YlfMxm6yXgecgNla9R1vp9G8_d6jTXfjEDhMHXs3IVnpO123ZQ>
    <xme:6I14YjNHZeDXcbF32oP_3t708469Lh6TmQQ4eLVYgx30sC_BayZve2QOlo7xFHaop
    POYy-MtbtlmMaa8WQ>
X-ME-Received: <xmr:6I14Yuh6e13NnjrctaKO3V8PXQ9AHEnPeCQv_RQD5vkFm0RlZmbGbrdot9h9GZNAz5dH4l1PWbS_oVRc0lCcIHfdFxLOHDsBfy-k4R_vryZWY6Ae4CEUf-qd8ncjiwRUBTDG9A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeekgdejiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpedukeetueduhedtleetvefguddvvdejhfefudelgfduveeggeehgfdu
    feeitdevteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:6I14Yu8ww4CedLGln1ZCC9mVFYIyQE8k3kSLV-gI-RVxGhfsww1Ukw>
    <xmx:6I14YhtUqsuXIR7sZi5sPTOF1LCBiD0m_pVaACz9V7pqLbp6EB__eA>
    <xmx:6I14YtGt4DKnc4WdT-HeJsB6j7wAHe9SzT8w9ZPFDLrzd19l6NDeEQ>
    <xmx:6Y14YiMmxiAlhAZmaToDDYiiXTxdIm0obahsuDaiptHj_PVMe96uCw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 8 May 2022 23:43:36 -0400 (EDT)
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
Subject: [PATCH 1/5] genirq: GENERIC_IRQ_EFFECTIVE_AFF_MASK depends on SMP
Date:   Sun,  8 May 2022 22:43:29 -0500
Message-Id: <20220509034333.60017-2-samuel@sholland.org>
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

An IRQ's effective affinity can only be different from its configured
affinity if there are multiple CPUs. Make it clear that this option is
only meaningful when SMP is enabled. Most of the relevant code in
irqdesc.c is already hidden behind CONFIG_SMP anyway.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

 arch/arm/mach-hisi/Kconfig |  2 +-
 drivers/irqchip/Kconfig    | 14 +++++++-------
 kernel/irq/Kconfig         |  1 +
 3 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-hisi/Kconfig b/arch/arm/mach-hisi/Kconfig
index 2e980f834a6a..36d71f6797ca 100644
--- a/arch/arm/mach-hisi/Kconfig
+++ b/arch/arm/mach-hisi/Kconfig
@@ -40,7 +40,7 @@ config ARCH_HIP04
 	select HAVE_ARM_ARCH_TIMER
 	select MCPM if SMP
 	select MCPM_QUAD_CLUSTER if SMP
-	select GENERIC_IRQ_EFFECTIVE_AFF_MASK
+	select GENERIC_IRQ_EFFECTIVE_AFF_MASK if SMP
 	help
 	  Support for Hisilicon HiP04 SoC family
 
diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 15edb9a6fcae..bc90500a7573 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -8,7 +8,7 @@ config IRQCHIP
 config ARM_GIC
 	bool
 	select IRQ_DOMAIN_HIERARCHY
-	select GENERIC_IRQ_EFFECTIVE_AFF_MASK
+	select GENERIC_IRQ_EFFECTIVE_AFF_MASK if SMP
 
 config ARM_GIC_PM
 	bool
@@ -34,7 +34,7 @@ config ARM_GIC_V3
 	bool
 	select IRQ_DOMAIN_HIERARCHY
 	select PARTITION_PERCPU
-	select GENERIC_IRQ_EFFECTIVE_AFF_MASK
+	select GENERIC_IRQ_EFFECTIVE_AFF_MASK if SMP
 
 config ARM_GIC_V3_ITS
 	bool
@@ -76,7 +76,7 @@ config ARMADA_370_XP_IRQ
 	bool
 	select GENERIC_IRQ_CHIP
 	select PCI_MSI if PCI
-	select GENERIC_IRQ_EFFECTIVE_AFF_MASK
+	select GENERIC_IRQ_EFFECTIVE_AFF_MASK if SMP
 
 config ALPINE_MSI
 	bool
@@ -112,7 +112,7 @@ config BCM6345_L1_IRQ
 	bool
 	select GENERIC_IRQ_CHIP
 	select IRQ_DOMAIN
-	select GENERIC_IRQ_EFFECTIVE_AFF_MASK
+	select GENERIC_IRQ_EFFECTIVE_AFF_MASK if SMP
 
 config BCM7038_L1_IRQ
 	tristate "Broadcom STB 7038-style L1/L2 interrupt controller driver"
@@ -120,7 +120,7 @@ config BCM7038_L1_IRQ
 	default ARCH_BRCMSTB || BMIPS_GENERIC
 	select GENERIC_IRQ_CHIP
 	select IRQ_DOMAIN
-	select GENERIC_IRQ_EFFECTIVE_AFF_MASK
+	select GENERIC_IRQ_EFFECTIVE_AFF_MASK if SMP
 
 config BCM7120_L2_IRQ
 	tristate "Broadcom STB 7120-style L2 interrupt controller driver"
@@ -179,7 +179,7 @@ config IRQ_MIPS_CPU
 	select GENERIC_IRQ_CHIP
 	select GENERIC_IRQ_IPI if SYS_SUPPORTS_MULTITHREADING
 	select IRQ_DOMAIN
-	select GENERIC_IRQ_EFFECTIVE_AFF_MASK
+	select GENERIC_IRQ_EFFECTIVE_AFF_MASK if SMP
 
 config CLPS711X_IRQCHIP
 	bool
@@ -282,7 +282,7 @@ config VERSATILE_FPGA_IRQ_NR
 config XTENSA_MX
 	bool
 	select IRQ_DOMAIN
-	select GENERIC_IRQ_EFFECTIVE_AFF_MASK
+	select GENERIC_IRQ_EFFECTIVE_AFF_MASK if SMP
 
 config XILINX_INTC
 	bool "Xilinx Interrupt Controller IP"
diff --git a/kernel/irq/Kconfig b/kernel/irq/Kconfig
index 10929eda9825..a2a8df39c2bc 100644
--- a/kernel/irq/Kconfig
+++ b/kernel/irq/Kconfig
@@ -24,6 +24,7 @@ config GENERIC_IRQ_SHOW_LEVEL
 
 # Supports effective affinity mask
 config GENERIC_IRQ_EFFECTIVE_AFF_MASK
+       depends on SMP
        bool
 
 # Support for delayed migration from interrupt context
-- 
2.35.1

