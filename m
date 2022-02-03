Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F7324A7DD7
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 03:18:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349019AbiBCCSF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 21:18:05 -0500
Received: from wnew4-smtp.messagingengine.com ([64.147.123.18]:56541 "EHLO
        wnew4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1349001AbiBCCR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 21:17:59 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.west.internal (Postfix) with ESMTP id 897822B001B2;
        Wed,  2 Feb 2022 21:17:57 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 02 Feb 2022 21:17:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; bh=u20cRLPCNmgihLyJzxfwZojJZX4mFA
        rOnu2FjtdYFhY=; b=UyPGXbZ1o0OVMGwBTdi0SCm2ZEs5SQwoLUg0GNi9D7Ae6U
        rBZb3/W142QXqmzznHZ1nydZTi0/Z6xEiqwUxHvbZa1BYxzu8aUQy3xQEqjPG9di
        w5nmXc2rrHyrjI/yO8jbgyx0OXAQUzRu8iPdYTOUwAMvgVN0fjF9heYqXqMNK0Dv
        ni9gtsXbez8gx6m50wNHuz0nuSq4UUiOps9bpq/W4ruxav5+KG9jvoM19gRGnfcd
        5LStM/ZwpQsvKSe02wdYsRCf3/J1w5h7iXl1UlM6AxMLnKC2EFwbIGJoSSExNwdG
        mw5ZjNk48R7ymx0FDSx4tX/lK6eImoAGc1LXpS6g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=u20cRL
        PCNmgihLyJzxfwZojJZX4mFArOnu2FjtdYFhY=; b=Gkq8nQqhZKkGuh1g6TYTNy
        WCsWn0Ov8YE/IpVTtIB3X2MkNPGR+hJanp+BPl/n4kW8PzvYlJ6w5M6lFzXIPXMa
        rfjC7SYfPel25z6ZkROHEREfPzzA8upvRXvrzCghWAlW6M0hhtrMjf9XBeJnM5vK
        9DER3gk1I7toYzz5heq+j4Pd/0iYiNyB5s17dqj/emLHjm+zA2St1V5eX18P1ebo
        VvLAWTKlsrczuYYwPXquIEXdq2f8pLeKkOsc+iMgJ20upIAkH65THDTCrgjPeuPe
        qmpAKcCKJ7jpTWdZKiMO/aOrN8+T0EJzRNxT1x0q7u2vU5lZJCoE4AVixpeCIA9g
        ==
X-ME-Sender: <xms:VDv7YfFKDXMDtVoMkLoe9TdADz9c979Mea5kahWFVOztpAzwkvGATQ>
    <xme:VDv7YcWKH0qu_wlnbtzraHoCc3RKoVaBn_SE36SKqoLGvG5e-6mbc8pUKz_9IZQEt
    LgEVgwnHH1mq5pN3g>
X-ME-Received: <xmr:VDv7YRJsF6FjaRRCpVevSvV9LaG8mt6facgYCVofGq0jhbOb4POhTkDe-MWbNGlkgkh0DGfTx6VkmkXEpIB_NAXQoJl5VvbTr8rVNznI7CWbcCd35eLT6Y6UQLIlvhOrlNEuhA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrgeeigdeggecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecuggftrf
    grthhtvghrnhepudfhjeefvdfhgfefheetgffhieeigfefhefgvddvveefgeejheejvdfg
    jeehueeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:VDv7YdGbjCN-srtoUJjaRXGMkdC8qUQ1Oke51PwHKfZe0HBZMbhozg>
    <xmx:VDv7YVXiy5XrzXX2lVacSk_077m2pAoaGuLb23RfTWRkSRDw76TGbw>
    <xmx:VDv7YYNYatIpNapUYUI1SYAfVHe-Bl3_nDmiYl9HLoh6l43sOWGi6g>
    <xmx:VTv7YaXh-0RRILKZM4mkAkfz-LvXsO3DLlhlS3TJ9dv3_CnavdNnrdgjPtY>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Feb 2022 21:17:55 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-sunxi@lists.linux.dev
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Michael Turquette <mturquette@baylibre.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH v3 5/6] clk: sunxi-ng: Add support for the sun6i RTC clocks
Date:   Wed,  2 Feb 2022 20:17:35 -0600
Message-Id: <20220203021736.13434-6-samuel@sholland.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220203021736.13434-1-samuel@sholland.org>
References: <20220203021736.13434-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RTC power domain in sun6i and newer SoCs manages the 16 MHz RC
oscillator (called "IOSC" or "osc16M") and the optional 32 kHz crystal
oscillator (called "LOSC" or "osc32k"). Starting with the H6, this power
domain also handles the 24 MHz DCXO (called variously "HOSC", "dcxo24M",
or "osc24M") as well. The H6 also adds a calibration circuit for IOSC.

Later SoCs introduce further variations on the design:
 - H616 adds an additional mux for the 32 kHz fanout source.
 - R329 adds an additional mux for the RTC timekeeping clock, a clock
   for the SPI bus between power domains inside the RTC, and removes the
   IOSC calibration functionality.

Take advantage of the CCU framework to handle this increased complexity.
This driver is intended to be a drop-in replacement for the existing RTC
clock provider. So some runtime adjustment of the clock parents is
needed, both to handle hardware differences, and to support the old
binding which omitted some of the input clocks.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

Changes in v3:
 - Rebase on v5.17-rc2 (CCU module support series was merged).
 - Move IOSC calibration control to prepare/unprepare operations.
 - Declare several `struct clk_init_data`s as static variables (instead
   of as anonymous) so they can be modified from the probe function
   without casting away const.
 - Instead of creating two copies of clocks which may or may not have
   muxes, change the number of parents to 1 in the non-mux case.
 - Use a single CCU description for all variants.
 - Use IS_REACHABLE to guard the call to sun6i_rtc_ccu_probe.
 - Allow the driver to be built on !ARM64 (i.e. RISCV).

Changes in v2:
 - Rebase on v2 of the CCU module support series.
 - Load the CCU driver from the RTC driver, not as an OF provider.

 drivers/clk/sunxi-ng/Kconfig         |   5 +
 drivers/clk/sunxi-ng/Makefile        |   2 +
 drivers/clk/sunxi-ng/ccu-sun6i-rtc.c | 378 +++++++++++++++++++++++++++
 drivers/clk/sunxi-ng/ccu-sun6i-rtc.h |  15 ++
 drivers/rtc/rtc-sun6i.c              |   7 +
 include/linux/clk/sunxi-ng.h         |   2 +
 6 files changed, 409 insertions(+)
 create mode 100644 drivers/clk/sunxi-ng/ccu-sun6i-rtc.c
 create mode 100644 drivers/clk/sunxi-ng/ccu-sun6i-rtc.h

diff --git a/drivers/clk/sunxi-ng/Kconfig b/drivers/clk/sunxi-ng/Kconfig
index 68a94e5af8ed..461537679c04 100644
--- a/drivers/clk/sunxi-ng/Kconfig
+++ b/drivers/clk/sunxi-ng/Kconfig
@@ -69,6 +69,11 @@ config SUN6I_A31_CCU
 	default MACH_SUN6I
 	depends on MACH_SUN6I || COMPILE_TEST
 
+config SUN6I_RTC_CCU
+	tristate "Support for the Allwinner H616/R329 RTC CCU"
+	default ARCH_SUNXI
+	depends on ARCH_SUNXI || COMPILE_TEST
+
 config SUN8I_A23_CCU
 	tristate "Support for the Allwinner A23 CCU"
 	default MACH_SUN8I
diff --git a/drivers/clk/sunxi-ng/Makefile b/drivers/clk/sunxi-ng/Makefile
index ec931cb7aa14..6b3ae2b620db 100644
--- a/drivers/clk/sunxi-ng/Makefile
+++ b/drivers/clk/sunxi-ng/Makefile
@@ -36,6 +36,7 @@ obj-$(CONFIG_SUN50I_H616_CCU)	+= sun50i-h616-ccu.o
 obj-$(CONFIG_SUN4I_A10_CCU)	+= sun4i-a10-ccu.o
 obj-$(CONFIG_SUN5I_CCU)		+= sun5i-ccu.o
 obj-$(CONFIG_SUN6I_A31_CCU)	+= sun6i-a31-ccu.o
+obj-$(CONFIG_SUN6I_RTC_CCU)	+= sun6i-rtc-ccu.o
 obj-$(CONFIG_SUN8I_A23_CCU)	+= sun8i-a23-ccu.o
 obj-$(CONFIG_SUN8I_A33_CCU)	+= sun8i-a33-ccu.o
 obj-$(CONFIG_SUN8I_A83T_CCU)	+= sun8i-a83t-ccu.o
@@ -60,6 +61,7 @@ sun50i-h616-ccu-y		+= ccu-sun50i-h616.o
 sun4i-a10-ccu-y			+= ccu-sun4i-a10.o
 sun5i-ccu-y			+= ccu-sun5i.o
 sun6i-a31-ccu-y			+= ccu-sun6i-a31.o
+sun6i-rtc-ccu-y			+= ccu-sun6i-rtc.o
 sun8i-a23-ccu-y			+= ccu-sun8i-a23.o
 sun8i-a33-ccu-y			+= ccu-sun8i-a33.o
 sun8i-a83t-ccu-y		+= ccu-sun8i-a83t.o
diff --git a/drivers/clk/sunxi-ng/ccu-sun6i-rtc.c b/drivers/clk/sunxi-ng/ccu-sun6i-rtc.c
new file mode 100644
index 000000000000..a39670a7c446
--- /dev/null
+++ b/drivers/clk/sunxi-ng/ccu-sun6i-rtc.c
@@ -0,0 +1,378 @@
+// SPDX-License-Identifier: GPL-2.0-only
+//
+// Copyright (c) 2021 Samuel Holland <samuel@sholland.org>
+//
+
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+
+#include "ccu_common.h"
+
+#include "ccu_div.h"
+#include "ccu_gate.h"
+#include "ccu_mux.h"
+
+#include "ccu-sun6i-rtc.h"
+
+#define IOSC_ACCURACY			300000000 /* 30% */
+#define IOSC_RATE			16000000
+
+#define LOSC_RATE			32768
+#define LOSC_RATE_SHIFT			15
+
+#define LOSC_CTRL_REG			0x0
+#define LOSC_CTRL_KEY			0x16aa0000
+
+#define IOSC_32K_CLK_DIV_REG		0x8
+#define IOSC_32K_CLK_DIV		GENMASK(4, 0)
+#define IOSC_32K_PRE_DIV		32
+
+#define IOSC_CLK_CALI_REG		0xc
+#define IOSC_CLK_CALI_DIV_ONES		22
+#define IOSC_CLK_CALI_EN		BIT(1)
+#define IOSC_CLK_CALI_SRC_SEL		BIT(0)
+
+#define LOSC_OUT_GATING_REG		0x60
+
+#define DCXO_CTRL_REG			0x160
+#define DCXO_CTRL_CLK16M_RC_EN		BIT(0)
+
+struct sun6i_rtc_match_data {
+	bool				have_ext_osc32k		: 1;
+	bool				have_iosc_calibration	: 1;
+	bool				rtc_32k_single_parent	: 1;
+	const struct clk_parent_data	*osc32k_fanout_parents;
+	u8				osc32k_fanout_nparents;
+};
+
+static bool have_iosc_calibration;
+
+static int ccu_iosc_enable(struct clk_hw *hw)
+{
+	struct ccu_common *cm = hw_to_ccu_common(hw);
+
+	return ccu_gate_helper_enable(cm, DCXO_CTRL_CLK16M_RC_EN);
+}
+
+static void ccu_iosc_disable(struct clk_hw *hw)
+{
+	struct ccu_common *cm = hw_to_ccu_common(hw);
+
+	return ccu_gate_helper_disable(cm, DCXO_CTRL_CLK16M_RC_EN);
+}
+
+static int ccu_iosc_is_enabled(struct clk_hw *hw)
+{
+	struct ccu_common *cm = hw_to_ccu_common(hw);
+
+	return ccu_gate_helper_is_enabled(cm, DCXO_CTRL_CLK16M_RC_EN);
+}
+
+static unsigned long ccu_iosc_recalc_rate(struct clk_hw *hw,
+					  unsigned long parent_rate)
+{
+	struct ccu_common *cm = hw_to_ccu_common(hw);
+
+	if (have_iosc_calibration) {
+		u32 reg = readl(cm->base + IOSC_CLK_CALI_REG);
+
+		/*
+		 * Recover the IOSC frequency by shifting the ones place of
+		 * (fixed-point divider * 32768) into bit zero.
+		 */
+		if (reg & IOSC_CLK_CALI_EN)
+			return reg >> (IOSC_CLK_CALI_DIV_ONES - LOSC_RATE_SHIFT);
+	}
+
+	return IOSC_RATE;
+}
+
+static unsigned long ccu_iosc_recalc_accuracy(struct clk_hw *hw,
+					      unsigned long parent_accuracy)
+{
+	return IOSC_ACCURACY;
+}
+
+static const struct clk_ops ccu_iosc_ops = {
+	.enable			= ccu_iosc_enable,
+	.disable		= ccu_iosc_disable,
+	.is_enabled		= ccu_iosc_is_enabled,
+	.recalc_rate		= ccu_iosc_recalc_rate,
+	.recalc_accuracy	= ccu_iosc_recalc_accuracy,
+};
+
+static struct ccu_common iosc_clk = {
+	.reg		= DCXO_CTRL_REG,
+	.hw.init	= CLK_HW_INIT_NO_PARENT("iosc", &ccu_iosc_ops,
+						CLK_GET_RATE_NOCACHE),
+};
+
+static int ccu_iosc_32k_prepare(struct clk_hw *hw)
+{
+	struct ccu_common *cm = hw_to_ccu_common(hw);
+	u32 val;
+
+	if (!have_iosc_calibration)
+		return 0;
+
+	val = readl(cm->base + IOSC_CLK_CALI_REG);
+	writel(val | IOSC_CLK_CALI_EN | IOSC_CLK_CALI_SRC_SEL,
+	       cm->base + IOSC_CLK_CALI_REG);
+
+	return 0;
+}
+
+static void ccu_iosc_32k_unprepare(struct clk_hw *hw)
+{
+	struct ccu_common *cm = hw_to_ccu_common(hw);
+	u32 val;
+
+	if (!have_iosc_calibration)
+		return;
+
+	val = readl(cm->base + IOSC_CLK_CALI_REG);
+	writel(val & ~(IOSC_CLK_CALI_EN | IOSC_CLK_CALI_SRC_SEL),
+	       cm->base + IOSC_CLK_CALI_REG);
+}
+
+static unsigned long ccu_iosc_32k_recalc_rate(struct clk_hw *hw,
+					      unsigned long parent_rate)
+{
+	struct ccu_common *cm = hw_to_ccu_common(hw);
+	u32 val;
+
+	if (have_iosc_calibration) {
+		val = readl(cm->base + IOSC_CLK_CALI_REG);
+
+		/* Assume the calibrated 32k clock is accurate. */
+		if (val & IOSC_CLK_CALI_SRC_SEL)
+			return LOSC_RATE;
+	}
+
+	val = readl(cm->base + IOSC_32K_CLK_DIV_REG) & IOSC_32K_CLK_DIV;
+
+	return parent_rate / IOSC_32K_PRE_DIV / (val + 1);
+}
+
+static unsigned long ccu_iosc_32k_recalc_accuracy(struct clk_hw *hw,
+						  unsigned long parent_accuracy)
+{
+	struct ccu_common *cm = hw_to_ccu_common(hw);
+	u32 val;
+
+	if (have_iosc_calibration) {
+		val = readl(cm->base + IOSC_CLK_CALI_REG);
+
+		/* Assume the calibrated 32k clock is accurate. */
+		if (val & IOSC_CLK_CALI_SRC_SEL)
+			return 0;
+	}
+
+	return parent_accuracy;
+}
+
+static const struct clk_ops ccu_iosc_32k_ops = {
+	.prepare		= ccu_iosc_32k_prepare,
+	.unprepare		= ccu_iosc_32k_unprepare,
+	.recalc_rate		= ccu_iosc_32k_recalc_rate,
+	.recalc_accuracy	= ccu_iosc_32k_recalc_accuracy,
+};
+
+static struct ccu_common iosc_32k_clk = {
+	.hw.init	= CLK_HW_INIT_HW("iosc-32k", &iosc_clk.hw,
+					 &ccu_iosc_32k_ops,
+					 CLK_GET_RATE_NOCACHE),
+};
+
+static const struct clk_hw *ext_osc32k[] = { NULL }; /* updated during probe */
+
+static SUNXI_CCU_GATE_HWS(ext_osc32k_gate_clk, "ext-osc32k-gate",
+			  ext_osc32k, 0x0, BIT(4), 0);
+
+static const struct clk_hw *osc32k_parents[] = {
+	&iosc_32k_clk.hw,
+	&ext_osc32k_gate_clk.common.hw
+};
+
+static struct clk_init_data osc32k_init_data = {
+	.name		= "osc32k",
+	.ops		= &ccu_mux_ops,
+	.parent_hws	= osc32k_parents,
+	.num_parents	= ARRAY_SIZE(osc32k_parents), /* updated during probe */
+};
+
+static struct ccu_mux osc32k_clk = {
+	.mux	= _SUNXI_CCU_MUX(0, 1),
+	.common	= {
+		.reg		= LOSC_CTRL_REG,
+		.features	= CCU_FEATURE_KEY_FIELD,
+		.hw.init	= &osc32k_init_data,
+	},
+};
+
+/* This falls back to the global name for fwnodes without a named reference. */
+static const struct clk_parent_data osc24M[] = {
+	{ .fw_name = "hosc", .name = "osc24M" }
+};
+
+static struct ccu_gate osc24M_32k_clk = {
+	.enable	= BIT(16),
+	.common	= {
+		.reg		= LOSC_OUT_GATING_REG,
+		.prediv		= 750,
+		.features	= CCU_FEATURE_ALL_PREDIV,
+		.hw.init	= CLK_HW_INIT_PARENTS_DATA("osc24M-32k", osc24M,
+							   &ccu_gate_ops, 0),
+	},
+};
+
+static const struct clk_hw *rtc_32k_parents[] = {
+	&osc32k_clk.common.hw,
+	&osc24M_32k_clk.common.hw
+};
+
+static struct clk_init_data rtc_32k_init_data = {
+	.name		= "rtc-32k",
+	.ops		= &ccu_mux_ops,
+	.parent_hws	= rtc_32k_parents,
+	.num_parents	= ARRAY_SIZE(rtc_32k_parents), /* updated during probe */
+};
+
+static struct ccu_mux rtc_32k_clk = {
+	.mux	= _SUNXI_CCU_MUX(1, 1),
+	.common	= {
+		.reg		= LOSC_CTRL_REG,
+		.features	= CCU_FEATURE_KEY_FIELD,
+		.hw.init	= &rtc_32k_init_data,
+	},
+};
+
+static struct clk_init_data osc32k_fanout_init_data = {
+	.name		= "osc32k-fanout",
+	.ops		= &ccu_mux_ops,
+	/* parents are set during probe */
+};
+
+static struct ccu_mux osc32k_fanout_clk = {
+	.enable	= BIT(0),
+	.mux	= _SUNXI_CCU_MUX(1, 2),
+	.common	= {
+		.reg		= LOSC_OUT_GATING_REG,
+		.hw.init	= &osc32k_fanout_init_data,
+	},
+};
+
+static struct ccu_common *sun6i_rtc_ccu_clks[] = {
+	&iosc_clk,
+	&iosc_32k_clk,
+	&ext_osc32k_gate_clk.common,
+	&osc32k_clk.common,
+	&osc24M_32k_clk.common,
+	&rtc_32k_clk.common,
+	&osc32k_fanout_clk.common,
+};
+
+static struct clk_hw_onecell_data sun6i_rtc_ccu_hw_clks = {
+	.num = CLK_NUMBER,
+	.hws = {
+		[CLK_OSC32K]		= &osc32k_clk.common.hw,
+		[CLK_OSC32K_FANOUT]	= &osc32k_fanout_clk.common.hw,
+		[CLK_IOSC]		= &iosc_clk.hw,
+		[CLK_IOSC_32K]		= &iosc_32k_clk.hw,
+		[CLK_EXT_OSC32K_GATE]	= &ext_osc32k_gate_clk.common.hw,
+		[CLK_OSC24M_32K]	= &osc24M_32k_clk.common.hw,
+		[CLK_RTC_32K]		= &rtc_32k_clk.common.hw,
+	},
+};
+
+static const struct sunxi_ccu_desc sun6i_rtc_ccu_desc = {
+	.ccu_clks	= sun6i_rtc_ccu_clks,
+	.num_ccu_clks	= ARRAY_SIZE(sun6i_rtc_ccu_clks),
+
+	.hw_clks	= &sun6i_rtc_ccu_hw_clks,
+};
+
+static const struct clk_parent_data sun50i_h616_osc32k_fanout_parents[] = {
+	{ .hw = &osc32k_clk.common.hw },
+	{ .fw_name = "pll-32k" },
+	{ .hw = &osc24M_32k_clk.common.hw }
+};
+
+static const struct clk_parent_data sun50i_r329_osc32k_fanout_parents[] = {
+	{ .hw = &osc32k_clk.common.hw },
+	{ .hw = &ext_osc32k_gate_clk.common.hw },
+	{ .hw = &osc24M_32k_clk.common.hw }
+};
+
+static const struct sun6i_rtc_match_data sun50i_h616_rtc_ccu_data = {
+	.have_iosc_calibration	= true,
+	.rtc_32k_single_parent	= true,
+	.osc32k_fanout_parents	= sun50i_h616_osc32k_fanout_parents,
+	.osc32k_fanout_nparents	= ARRAY_SIZE(sun50i_h616_osc32k_fanout_parents),
+};
+
+static const struct sun6i_rtc_match_data sun50i_r329_rtc_ccu_data = {
+	.have_ext_osc32k	= true,
+	.osc32k_fanout_parents	= sun50i_r329_osc32k_fanout_parents,
+	.osc32k_fanout_nparents	= ARRAY_SIZE(sun50i_r329_osc32k_fanout_parents),
+};
+
+static const struct of_device_id sun6i_rtc_ccu_match[] = {
+	{
+		.compatible	= "allwinner,sun50i-h616-rtc",
+		.data		= &sun50i_h616_rtc_ccu_data,
+	},
+	{
+		.compatible	= "allwinner,sun50i-r329-rtc",
+		.data		= &sun50i_r329_rtc_ccu_data,
+	},
+};
+
+int sun6i_rtc_ccu_probe(struct device *dev, void __iomem *reg)
+{
+	const struct sun6i_rtc_match_data *data;
+	struct clk *ext_osc32k_clk = NULL;
+	const struct of_device_id *match;
+
+	/* This driver is only used for newer variants of the hardware. */
+	match = of_match_device(sun6i_rtc_ccu_match, dev);
+	if (!match)
+		return 0;
+
+	data = match->data;
+	have_iosc_calibration = data->have_iosc_calibration;
+
+	if (data->have_ext_osc32k) {
+		const char *fw_name;
+
+		/* ext-osc32k was the only input clock in the old binding. */
+		fw_name = of_property_read_bool(dev->of_node, "clock-names")
+			? "ext-osc32k" : NULL;
+		ext_osc32k_clk = devm_clk_get_optional(dev, fw_name);
+		if (IS_ERR(ext_osc32k_clk))
+			return PTR_ERR(ext_osc32k_clk);
+	}
+
+	if (ext_osc32k_clk) {
+		/* Link ext-osc32k-gate to its parent. */
+		*ext_osc32k = __clk_get_hw(ext_osc32k_clk);
+	} else {
+		/* ext-osc32k-gate is an orphan, so do not register it. */
+		sun6i_rtc_ccu_hw_clks.hws[CLK_EXT_OSC32K_GATE] = NULL;
+		osc32k_init_data.num_parents = 1;
+	}
+
+	if (data->rtc_32k_single_parent)
+		rtc_32k_init_data.num_parents = 1;
+
+	osc32k_fanout_init_data.parent_data = data->osc32k_fanout_parents;
+	osc32k_fanout_init_data.num_parents = data->osc32k_fanout_nparents;
+
+	return devm_sunxi_ccu_probe(dev, reg, &sun6i_rtc_ccu_desc);
+}
+
+MODULE_IMPORT_NS(SUNXI_CCU);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/sunxi-ng/ccu-sun6i-rtc.h b/drivers/clk/sunxi-ng/ccu-sun6i-rtc.h
new file mode 100644
index 000000000000..9ae821fc2599
--- /dev/null
+++ b/drivers/clk/sunxi-ng/ccu-sun6i-rtc.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _CCU_SUN6I_RTC_H
+#define _CCU_SUN6I_RTC_H
+
+#include <dt-bindings/clock/sun6i-rtc.h>
+
+#define CLK_IOSC_32K		3
+#define CLK_EXT_OSC32K_GATE	4
+#define CLK_OSC24M_32K		5
+#define CLK_RTC_32K		6
+
+#define CLK_NUMBER		(CLK_RTC_32K + 1)
+
+#endif /* _CCU_SUN6I_RTC_H */
diff --git a/drivers/rtc/rtc-sun6i.c b/drivers/rtc/rtc-sun6i.c
index d5a86cbb2e94..35b34d14a1db 100644
--- a/drivers/rtc/rtc-sun6i.c
+++ b/drivers/rtc/rtc-sun6i.c
@@ -13,6 +13,7 @@
 
 #include <linux/clk.h>
 #include <linux/clk-provider.h>
+#include <linux/clk/sunxi-ng.h>
 #include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/fs.h>
@@ -707,6 +708,12 @@ static int sun6i_rtc_probe(struct platform_device *pdev)
 		chip->base = devm_platform_ioremap_resource(pdev, 0);
 		if (IS_ERR(chip->base))
 			return PTR_ERR(chip->base);
+
+		if (IS_REACHABLE(CONFIG_SUN6I_RTC_CCU)) {
+			ret = sun6i_rtc_ccu_probe(dev, chip->base);
+			if (ret)
+				return ret;
+		}
 	}
 
 	platform_set_drvdata(pdev, chip);
diff --git a/include/linux/clk/sunxi-ng.h b/include/linux/clk/sunxi-ng.h
index cf32123b39f5..57c8ec44ab4e 100644
--- a/include/linux/clk/sunxi-ng.h
+++ b/include/linux/clk/sunxi-ng.h
@@ -9,4 +9,6 @@
 int sunxi_ccu_set_mmc_timing_mode(struct clk *clk, bool new_mode);
 int sunxi_ccu_get_mmc_timing_mode(struct clk *clk);
 
+int sun6i_rtc_ccu_probe(struct device *dev, void __iomem *reg);
+
 #endif
-- 
2.33.1

