Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFBD4538ABD
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 06:51:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243916AbiEaEuy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 00:50:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiEaEut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 00:50:49 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D6DA941B3;
        Mon, 30 May 2022 21:50:48 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id BB4333200935;
        Tue, 31 May 2022 00:50:45 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 31 May 2022 00:50:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1653972645; x=1654059045; bh=FW
        jZmI4EaR1XZe8Uu9VR6zEl9VrAmbrBoz7dMVCbOZc=; b=Yf3f6anEAJsfy/RfKH
        PrSfWvx9acPMXnwF2eQ5g72tm0NHUl2EzsiP/Xc6VMnx8ALZQMxcIt6GywWStDVh
        kuYq4g+Ipv/K6HTWylHK7DIUntjP6Y7OIrIlXt+lRG0Qee8gEZdEkSu8UaDmOeaQ
        9LcAdDXeRSms+Jtt6UUvpkPO2HmqbjmTYLgJe4Mxp/UDGj8lQcFSwnexGf5JYPYh
        +R41X7bCrL5qr28kKudQItKl0jpi9Jncl2CjrMeuKgZHA6pCHZMp0z4tYt82JazN
        rsiR+FWI3XlVnzqhLiaWFBT0ehJhD+QFRSkawJm9QiheAfptfTdQxp8dnvhJlYib
        Q8nA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1653972645; x=1654059045; bh=FWjZmI4EaR1XZ
        e8Uu9VR6zEl9VrAmbrBoz7dMVCbOZc=; b=G72N9V5vr7ojnqjYAJ0VpxsMEFnTy
        7j8Rio2+pmIKiotZWukVm6ZGUssAizpOjyhe2cyC7+GRruSZHqfQdE8VJeVBBGJr
        Y4jjuXomtA67UNgNbOZXwkvxrJpzsnBGPorVsqm4AL8LpZKvFqNhLYym9n0DHTon
        fST6M63NaBlL9CyqWyt00yZu2h8j8NHvKbgJlaUcZvYGpaEjFUZISijp7WrMZ6bn
        N2hhJ8kgdz47wiMlCTeGiAy4Ce1BhWmB7GI1PprXFQLSNoYFy6IbOk3my57rYlFh
        ylVlGrhEyxZ2/dEhvfiydwgxG7LP7AsQQYZRArkDUYVFKxTQ/MSojCLCw==
X-ME-Sender: <xms:pZ6VYhPIwjgcq7B-8GkttNxkT4CJESNevzOQDOdVgi54t-iwuFrjRA>
    <xme:pZ6VYj9eKl6Ue3tGPSNhNhLv-3wa0GR-zwaojNtTqTH9DKKC7hAOY5PE8fwzgaBF0
    pIgV8T6CDtlyZEA4A>
X-ME-Received: <xmr:pZ6VYgQTK6R_HA8bzsBB5S5TN5ZkECS7sFKiP6g569Oc8vDePKfJZC0ecvwR_kthG2dP9UdC5fPngY5NlTo4A_f_G8vlzV5_ZsLw0ePORwY7J_BDuHRc90-8ePvw6dR9M0Toow>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrkeejgdeklecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpedukeetueduhedtleetvefguddvvdejhfefudelgfduveeggeehgfdu
    feeitdevteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:pZ6VYtscAN6e93R1Y03vP5KiItVmt8i-sfWBC1xMMZH2leelunkrUQ>
    <xmx:pZ6VYpfPIGCNBeqFITDM-JFpFnUwBAm28YmfV7v5M6JOvlCN6Ib89A>
    <xmx:pZ6VYp2plDoSSP49RKkdxmmnombAphEBuxFmlDYUVmbkV0eoj2VlJw>
    <xmx:pZ6VYsAz0OYL26Y1wXk7HhNjikLaPakwxfZTQKVSFkOhgH-cvGljMw>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 31 May 2022 00:50:44 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Samuel Holland <samuel@sholland.org>,
        Bartosz Dudziak <bartosz.dudziak@snejp.pl>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Luca Weiss <luca@z3ntu.xyz>, Maxime Ripard <maxime@cerno.tech>,
        Rob Herring <robh+dt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Thierry Reding <treding@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev
Subject: [PATCH 1/3] ARM: sunxi: Remove A31 and A23/A33 platform SMP code
Date:   Mon, 30 May 2022 23:50:36 -0500
Message-Id: <20220531045038.42230-2-samuel@sholland.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220531045038.42230-1-samuel@sholland.org>
References: <20220531045038.42230-1-samuel@sholland.org>
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

U-Boot has provided PSCI on Allwinner A31 and A23/A33 since May 2015,
commit 014414f53695 ("ARM: sunxi: Enable PSCI for sun8i"). Since we can
assume PSCI is available on these platforms, the custom SMP bringup code
is no longer used, and it can be removed.

The platform SMP code has a hidden dependency on the legacy PRCM
bindings, so it would be broken anyway when those are retired.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

 arch/arm/mach-sunxi/Makefile  |   1 -
 arch/arm/mach-sunxi/platsmp.c | 194 ----------------------------------
 2 files changed, 195 deletions(-)
 delete mode 100644 arch/arm/mach-sunxi/platsmp.c

diff --git a/arch/arm/mach-sunxi/Makefile b/arch/arm/mach-sunxi/Makefile
index 146e623c54d3..e5dc8530e98c 100644
--- a/arch/arm/mach-sunxi/Makefile
+++ b/arch/arm/mach-sunxi/Makefile
@@ -3,4 +3,3 @@ CFLAGS_mc_smp.o	+= -march=armv7-a
 
 obj-$(CONFIG_ARCH_SUNXI) += sunxi.o
 obj-$(CONFIG_ARCH_SUNXI_MC_SMP) += mc_smp.o headsmp.o
-obj-$(CONFIG_SMP) += platsmp.o
diff --git a/arch/arm/mach-sunxi/platsmp.c b/arch/arm/mach-sunxi/platsmp.c
deleted file mode 100644
index 052097e78e6e..000000000000
--- a/arch/arm/mach-sunxi/platsmp.c
+++ /dev/null
@@ -1,194 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * SMP support for Allwinner SoCs
- *
- * Copyright (C) 2013 Maxime Ripard
- *
- * Maxime Ripard <maxime.ripard@free-electrons.com>
- *
- * Based on code
- *  Copyright (C) 2012-2013 Allwinner Ltd.
- *
- */
-
-#include <linux/delay.h>
-#include <linux/init.h>
-#include <linux/io.h>
-#include <linux/memory.h>
-#include <linux/of.h>
-#include <linux/of_address.h>
-#include <linux/smp.h>
-
-#define CPUCFG_CPU_PWR_CLAMP_STATUS_REG(cpu)	((cpu) * 0x40 + 0x64)
-#define CPUCFG_CPU_RST_CTRL_REG(cpu)		(((cpu) + 1) * 0x40)
-#define CPUCFG_CPU_CTRL_REG(cpu)		(((cpu) + 1) * 0x40 + 0x04)
-#define CPUCFG_CPU_STATUS_REG(cpu)		(((cpu) + 1) * 0x40 + 0x08)
-#define CPUCFG_GEN_CTRL_REG			0x184
-#define CPUCFG_PRIVATE0_REG			0x1a4
-#define CPUCFG_PRIVATE1_REG			0x1a8
-#define CPUCFG_DBG_CTL0_REG			0x1e0
-#define CPUCFG_DBG_CTL1_REG			0x1e4
-
-#define PRCM_CPU_PWROFF_REG			0x100
-#define PRCM_CPU_PWR_CLAMP_REG(cpu)		(((cpu) * 4) + 0x140)
-
-static void __iomem *cpucfg_membase;
-static void __iomem *prcm_membase;
-
-static DEFINE_SPINLOCK(cpu_lock);
-
-static void __init sun6i_smp_prepare_cpus(unsigned int max_cpus)
-{
-	struct device_node *node;
-
-	node = of_find_compatible_node(NULL, NULL, "allwinner,sun6i-a31-prcm");
-	if (!node) {
-		pr_err("Missing A31 PRCM node in the device tree\n");
-		return;
-	}
-
-	prcm_membase = of_iomap(node, 0);
-	of_node_put(node);
-	if (!prcm_membase) {
-		pr_err("Couldn't map A31 PRCM registers\n");
-		return;
-	}
-
-	node = of_find_compatible_node(NULL, NULL,
-				       "allwinner,sun6i-a31-cpuconfig");
-	if (!node) {
-		pr_err("Missing A31 CPU config node in the device tree\n");
-		return;
-	}
-
-	cpucfg_membase = of_iomap(node, 0);
-	of_node_put(node);
-	if (!cpucfg_membase)
-		pr_err("Couldn't map A31 CPU config registers\n");
-
-}
-
-static int sun6i_smp_boot_secondary(unsigned int cpu,
-				    struct task_struct *idle)
-{
-	u32 reg;
-	int i;
-
-	if (!(prcm_membase && cpucfg_membase))
-		return -EFAULT;
-
-	spin_lock(&cpu_lock);
-
-	/* Set CPU boot address */
-	writel(__pa_symbol(secondary_startup),
-	       cpucfg_membase + CPUCFG_PRIVATE0_REG);
-
-	/* Assert the CPU core in reset */
-	writel(0, cpucfg_membase + CPUCFG_CPU_RST_CTRL_REG(cpu));
-
-	/* Assert the L1 cache in reset */
-	reg = readl(cpucfg_membase + CPUCFG_GEN_CTRL_REG);
-	writel(reg & ~BIT(cpu), cpucfg_membase + CPUCFG_GEN_CTRL_REG);
-
-	/* Disable external debug access */
-	reg = readl(cpucfg_membase + CPUCFG_DBG_CTL1_REG);
-	writel(reg & ~BIT(cpu), cpucfg_membase + CPUCFG_DBG_CTL1_REG);
-
-	/* Power up the CPU */
-	for (i = 0; i <= 8; i++)
-		writel(0xff >> i, prcm_membase + PRCM_CPU_PWR_CLAMP_REG(cpu));
-	mdelay(10);
-
-	/* Clear CPU power-off gating */
-	reg = readl(prcm_membase + PRCM_CPU_PWROFF_REG);
-	writel(reg & ~BIT(cpu), prcm_membase + PRCM_CPU_PWROFF_REG);
-	mdelay(1);
-
-	/* Deassert the CPU core reset */
-	writel(3, cpucfg_membase + CPUCFG_CPU_RST_CTRL_REG(cpu));
-
-	/* Enable back the external debug accesses */
-	reg = readl(cpucfg_membase + CPUCFG_DBG_CTL1_REG);
-	writel(reg | BIT(cpu), cpucfg_membase + CPUCFG_DBG_CTL1_REG);
-
-	spin_unlock(&cpu_lock);
-
-	return 0;
-}
-
-static const struct smp_operations sun6i_smp_ops __initconst = {
-	.smp_prepare_cpus	= sun6i_smp_prepare_cpus,
-	.smp_boot_secondary	= sun6i_smp_boot_secondary,
-};
-CPU_METHOD_OF_DECLARE(sun6i_a31_smp, "allwinner,sun6i-a31", &sun6i_smp_ops);
-
-static void __init sun8i_smp_prepare_cpus(unsigned int max_cpus)
-{
-	struct device_node *node;
-
-	node = of_find_compatible_node(NULL, NULL, "allwinner,sun8i-a23-prcm");
-	if (!node) {
-		pr_err("Missing A23 PRCM node in the device tree\n");
-		return;
-	}
-
-	prcm_membase = of_iomap(node, 0);
-	of_node_put(node);
-	if (!prcm_membase) {
-		pr_err("Couldn't map A23 PRCM registers\n");
-		return;
-	}
-
-	node = of_find_compatible_node(NULL, NULL,
-				       "allwinner,sun8i-a23-cpuconfig");
-	if (!node) {
-		pr_err("Missing A23 CPU config node in the device tree\n");
-		return;
-	}
-
-	cpucfg_membase = of_iomap(node, 0);
-	of_node_put(node);
-	if (!cpucfg_membase)
-		pr_err("Couldn't map A23 CPU config registers\n");
-
-}
-
-static int sun8i_smp_boot_secondary(unsigned int cpu,
-				    struct task_struct *idle)
-{
-	u32 reg;
-
-	if (!(prcm_membase && cpucfg_membase))
-		return -EFAULT;
-
-	spin_lock(&cpu_lock);
-
-	/* Set CPU boot address */
-	writel(__pa_symbol(secondary_startup),
-	       cpucfg_membase + CPUCFG_PRIVATE0_REG);
-
-	/* Assert the CPU core in reset */
-	writel(0, cpucfg_membase + CPUCFG_CPU_RST_CTRL_REG(cpu));
-
-	/* Assert the L1 cache in reset */
-	reg = readl(cpucfg_membase + CPUCFG_GEN_CTRL_REG);
-	writel(reg & ~BIT(cpu), cpucfg_membase + CPUCFG_GEN_CTRL_REG);
-
-	/* Clear CPU power-off gating */
-	reg = readl(prcm_membase + PRCM_CPU_PWROFF_REG);
-	writel(reg & ~BIT(cpu), prcm_membase + PRCM_CPU_PWROFF_REG);
-	mdelay(1);
-
-	/* Deassert the CPU core reset */
-	writel(3, cpucfg_membase + CPUCFG_CPU_RST_CTRL_REG(cpu));
-
-	spin_unlock(&cpu_lock);
-
-	return 0;
-}
-
-static const struct smp_operations sun8i_smp_ops __initconst = {
-	.smp_prepare_cpus	= sun8i_smp_prepare_cpus,
-	.smp_boot_secondary	= sun8i_smp_boot_secondary,
-};
-CPU_METHOD_OF_DECLARE(sun8i_a23_smp, "allwinner,sun8i-a23", &sun8i_smp_ops);
-- 
2.35.1

