Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C01F251F324
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 06:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232657AbiEID5a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 23:57:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234083AbiEIDxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 23:53:49 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D36CF61F3
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 20:49:57 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 3AAE95C00E3;
        Sun,  8 May 2022 23:49:44 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Sun, 08 May 2022 23:49:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm2; t=1652068184; x=1652154584; bh=M8c+rWOG2tl/Ozu3xwi5hO5jK
        mpxMCpEbGJNM99i7+w=; b=ooF5GKGp2cg5L2N2Tpr8VM4sB6j1ewQWnjTz9Y3NE
        47VJHRzWElom5nREXP2RK+U+K4PtD3iK2mEsTxbWLmKN6KbOvB7N5cpMUbV5k841
        xBn59G7hhOOJTHbFwpWCKMuzew6M0dzL1/alBoRu3UP/ipaFA1dU7i4NqKkGJDqu
        ogPUJHHmSYLZR7Q0RWxHPtSU4xeUjY3gdzFOQCLL6rpmIVsfxZRF5/LU3kKGtQvK
        PXfAxnTYmuBW1h8PYaq1/f5w0RHaEC1Rd8bxEWWsjuVsMX2W07jP9NFiWUuGajOa
        xTz6w/eiunXTCDnEOYQpqWA3TKRNYzXEx1TkBQ/EsJxdg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:message-id:mime-version:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; t=1652068184; x=1652154584; bh=M
        8c+rWOG2tl/Ozu3xwi5hO5jKmpxMCpEbGJNM99i7+w=; b=Dl+OLImYeWZgRQKl7
        zBfuXrSCrQ2LnPEu6skSVls95GpC5duSbXe7GZoYQ3AaF6F0ivjOUlICg4ogTO4R
        l3Ph2nA/9vc1TSzJz32uoXsWisdvAE4jbD/lRVzbXSd6A0pz3ARILSzTDPLlUYX9
        F7T02519LRoUxjIValjyXjWS1jS5ky0dwzrEwmF/8jGNvFV4bLMEs99T+gveGKcN
        DQrouCJGNjANWpVS8dw3RQdpWsxVLsj2ol5gvO0uKhPDiQd7YEo/kpnCXP2MWspw
        eLJicr/Kv9k0BX6X0s1AWOOWl1Wh90FkS/KTpvYCz22p8+qFvD4LdoCZZn8pDPeE
        az4jg==
X-ME-Sender: <xms:V494YjItRvSRNKaLccJCXEkjoIekBb-RHHM5mUdCNSHeMEiW8g5-fA>
    <xme:V494YnJGilxRhniQTRm68Mg9wGBcPNJ1xbojNwklRvqPWBA3xbkM3jIWVVS-0gk4X
    qhrFbUVdaUB1luOyQ>
X-ME-Received: <xmr:V494YrvComZ1dHN-YuFuPLYrNQkFjyXczgPPxHfhF-whHX7dRwOXX8VgJcNDPy9R1ZNmsylG1DP3xAAfbhSOqElVrybJbeolAptvQP9-5L3HDeer52iUWp4TlTsa3xVlpg07sw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeekgdejiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgvlhcu
    jfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtffrrg
    htthgvrhhnpeekveelhfejueelleetvdejvdeffeetgeelheeujeffhefgffefkeehhffh
    keekgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:V494YsZXiOGCskiS-Chy_oTwadfT97wxJhArZAl2QKWATtLc_bwdLg>
    <xmx:V494YqYHtWCsfAP1hOOHz0ZzWOkxrL0RN4JwfUed3fMbMjSLhzMF8w>
    <xmx:V494YgAC4lO11G2bltf-SQDmI1vN7l5aXMZyNUXjh7od6ZVkfK2Vuw>
    <xmx:WI94Ygn2Gnc52AKSVi-8MwuguqOLjG9WcjzNt1JaqW0Sw-jDXY3vDg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 8 May 2022 23:49:42 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>
Cc:     Samuel Holland <samuel@sholland.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev
Subject: [PATCH] irqchip: Add Kconfig symbols for sunxi drivers
Date:   Sun,  8 May 2022 22:49:41 -0500
Message-Id: <20220509034941.30704-1-samuel@sholland.org>
X-Mailer: git-send-email 2.35.1
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

Not all of these drivers are needed on every ARCH_SUNXI platform. In
particular, the ARCH_SUNXI symbol will be reused for the Allwinner D1,
a RISC-V SoC which contains none of these irqchips.

Introduce Kconfig symbols so we can select only the drivers actually
used by a particular set of platforms. This also lets us move the
irqchip driver dependencies to a more appropriate location.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

 arch/arm/mach-sunxi/Kconfig  | 12 +++++++++---
 arch/arm64/Kconfig.platforms |  5 ++---
 drivers/irqchip/Kconfig      | 12 ++++++++++++
 drivers/irqchip/Makefile     |  6 +++---
 4 files changed, 26 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
index e5c2fce281cd..abdb99fe1e97 100644
--- a/arch/arm/mach-sunxi/Kconfig
+++ b/arch/arm/mach-sunxi/Kconfig
@@ -4,10 +4,7 @@ menuconfig ARCH_SUNXI
 	depends on ARCH_MULTI_V5 || ARCH_MULTI_V7
 	select ARCH_HAS_RESET_CONTROLLER
 	select CLKSRC_MMIO
-	select GENERIC_IRQ_CHIP
 	select GPIOLIB
-	select IRQ_DOMAIN_HIERARCHY
-	select IRQ_FASTEOI_HIERARCHY_HANDLERS
 	select PINCTRL
 	select PM_OPP
 	select SUN4I_TIMER
@@ -22,10 +19,12 @@ if ARCH_MULTI_V7
 config MACH_SUN4I
 	bool "Allwinner A10 (sun4i) SoCs support"
 	default ARCH_SUNXI
+	select SUN4I_INTC
 
 config MACH_SUN5I
 	bool "Allwinner A10s / A13 (sun5i) SoCs support"
 	default ARCH_SUNXI
+	select SUN4I_INTC
 	select SUN5I_HSTIMER
 
 config MACH_SUN6I
@@ -34,6 +33,8 @@ config MACH_SUN6I
 	select ARM_GIC
 	select MFD_SUN6I_PRCM
 	select SUN5I_HSTIMER
+	select SUN6I_R_INTC
+	select SUNXI_NMI_INTC
 
 config MACH_SUN7I
 	bool "Allwinner A20 (sun7i) SoCs support"
@@ -43,17 +44,21 @@ config MACH_SUN7I
 	select ARCH_SUPPORTS_BIG_ENDIAN
 	select HAVE_ARM_ARCH_TIMER
 	select SUN5I_HSTIMER
+	select SUNXI_NMI_INTC
 
 config MACH_SUN8I
 	bool "Allwinner sun8i Family SoCs support"
 	default ARCH_SUNXI
 	select ARM_GIC
 	select MFD_SUN6I_PRCM
+	select SUN6I_R_INTC
+	select SUNXI_NMI_INTC
 
 config MACH_SUN9I
 	bool "Allwinner (sun9i) SoCs support"
 	default ARCH_SUNXI
 	select ARM_GIC
+	select SUNXI_NMI_INTC
 
 config ARCH_SUNXI_MC_SMP
 	bool
@@ -69,6 +74,7 @@ if ARCH_MULTI_V5
 config MACH_SUNIV
 	bool "Allwinner ARMv5 F-series (suniv) SoCs support"
 	default ARCH_SUNXI
+	select SUN4I_INTC
 	help
 	  Support for Allwinner suniv ARMv5 SoCs.
 	  (F1C100A, F1C100s, F1C200s, F1C500, F1C600)
diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 30b123cde02c..b9a9d5de0e00 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -11,12 +11,11 @@ config ARCH_ACTIONS
 config ARCH_SUNXI
 	bool "Allwinner sunxi 64-bit SoC Family"
 	select ARCH_HAS_RESET_CONTROLLER
-	select GENERIC_IRQ_CHIP
-	select IRQ_DOMAIN_HIERARCHY
-	select IRQ_FASTEOI_HIERARCHY_HANDLERS
 	select PINCTRL
 	select RESET_CONTROLLER
 	select SUN4I_TIMER
+	select SUN6I_R_INTC
+	select SUNXI_NMI_INTC
 	help
 	  This enables support for Allwinner sunxi based SoCs like the A64.
 
diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 15edb9a6fcae..135c156673a7 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -257,6 +257,18 @@ config ST_IRQCHIP
 	help
 	  Enables SysCfg Controlled IRQs on STi based platforms.
 
+config SUN4I_INTC
+	bool
+
+config SUN6I_R_INTC
+	bool
+	select IRQ_DOMAIN_HIERARCHY
+	select IRQ_FASTEOI_HIERARCHY_HANDLERS
+
+config SUNXI_NMI_INTC
+	bool
+	select GENERIC_IRQ_CHIP
+
 config TB10X_IRQC
 	bool
 	select IRQ_DOMAIN
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index 160a1d8ceaa9..9b1ffb0f98cc 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -23,9 +23,9 @@ obj-$(CONFIG_OMPIC)			+= irq-ompic.o
 obj-$(CONFIG_OR1K_PIC)			+= irq-or1k-pic.o
 obj-$(CONFIG_ORION_IRQCHIP)		+= irq-orion.o
 obj-$(CONFIG_OMAP_IRQCHIP)		+= irq-omap-intc.o
-obj-$(CONFIG_ARCH_SUNXI)		+= irq-sun4i.o
-obj-$(CONFIG_ARCH_SUNXI)		+= irq-sun6i-r.o
-obj-$(CONFIG_ARCH_SUNXI)		+= irq-sunxi-nmi.o
+obj-$(CONFIG_SUN4I_INTC)		+= irq-sun4i.o
+obj-$(CONFIG_SUN6I_R_INTC)		+= irq-sun6i-r.o
+obj-$(CONFIG_SUNXI_NMI_INTC)		+= irq-sunxi-nmi.o
 obj-$(CONFIG_ARCH_SPEAR3XX)		+= spear-shirq.o
 obj-$(CONFIG_ARM_GIC)			+= irq-gic.o irq-gic-common.o
 obj-$(CONFIG_ARM_GIC_PM)		+= irq-gic-pm.o
-- 
2.35.1

