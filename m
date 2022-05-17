Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8981A529E38
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 11:40:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238284AbiEQJkD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 05:40:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244935AbiEQJkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 05:40:00 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D0C945501
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 02:39:59 -0700 (PDT)
Date:   Tue, 17 May 2022 09:39:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652780397;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MV8ezNU8e3PB0A+yF5ypqa+dKa90kwYRQYPyFAoq/qI=;
        b=EYTwLTRmfhpAe42NrCS7NC0QB6xehUuakRNrVWXM8TxMAGn36vfmmoxJto0tbkpKK7gqtZ
        2IgGITWDuAxKEI0Ruk95g874x/jJA/0crNCoJUgp+21Z7pzpH+Cpbnb//N7tALCP45qjCD
        ruuOSSVbwLbTa+2Dq9/lM/QgtfGxjNVgP4rlMDIYTvGjOsXS8s2+9/sIMJ9/KMPMxqtXP1
        qNmNdnqLC2ZSnlmQ1WHqxmR6XSrde9ppWi3F78oJjyBx6d5dgz3IuN6rKhNeblAWaORcEY
        RKJo1Fnb6XTmzgSFhVek6ouEWrMpo0FoaXSGXTdB6xM6KoqZBaYooYduqIUq6Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652780397;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MV8ezNU8e3PB0A+yF5ypqa+dKa90kwYRQYPyFAoq/qI=;
        b=h1FM2yIRwiSbBFjz9EQzwMzfB2ARvQ/pYaDJIs+UW4JogkpFqFf/TKQovGdiLVJijEC/0s
        dYtDF1I15umNm5Dw==
From:   "irqchip-bot for Samuel Holland" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip: Add Kconfig symbols for sunxi drivers
Cc:     Samuel Holland <samuel@sholland.org>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20220509034941.30704-1-samuel@sholland.org>
References: <20220509034941.30704-1-samuel@sholland.org>
MIME-Version: 1.0
Message-ID: <165278039623.4207.11797429022378096478.tip-bot2@tip-bot2>
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

Commit-ID:     d421fd6d1fbf00b6481d836e65bad07d6bad61ed
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/d421fd6d1fbf00b6481d836e65bad07d6bad61ed
Author:        Samuel Holland <samuel@sholland.org>
AuthorDate:    Sun, 08 May 2022 22:49:41 -05:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Tue, 17 May 2022 10:13:57 +01:00

irqchip: Add Kconfig symbols for sunxi drivers

Not all of these drivers are needed on every ARCH_SUNXI platform. In
particular, the ARCH_SUNXI symbol will be reused for the Allwinner D1,
a RISC-V SoC which contains none of these irqchips.

Introduce Kconfig symbols so we can select only the drivers actually
used by a particular set of platforms. This also lets us move the
irqchip driver dependencies to a more appropriate location.

Signed-off-by: Samuel Holland <samuel@sholland.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20220509034941.30704-1-samuel@sholland.org
---
 arch/arm/mach-sunxi/Kconfig  | 12 +++++++++---
 arch/arm64/Kconfig.platforms |  5 ++---
 drivers/irqchip/Kconfig      | 12 ++++++++++++
 drivers/irqchip/Makefile     |  6 +++---
 4 files changed, 26 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
index e5c2fce..abdb99f 100644
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
index aaeaf57..6a6457f 100644
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
index 15edb9a..135c156 100644
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
index 160a1d8..9b1ffb0 100644
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
