Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F6BB572B81
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 04:53:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234105AbiGMCxP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 22:53:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230112AbiGMCw7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 22:52:59 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B90EFD31D1;
        Tue, 12 Jul 2022 19:52:46 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 84F625C0179;
        Tue, 12 Jul 2022 22:52:43 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 12 Jul 2022 22:52:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1657680763; x=1657767163; bh=v2
        yi1GASBVynCiccINM4XtNZv3y087EmLmPr8NHBZS0=; b=D8wB+JEV724zajbtrM
        bhTo4dqoDUIYcCpVNVMuNsxLiVvt3xSaDpBYonc01/pWWe68BY43jCAT6hnKi95C
        JkfJq3mwohw4ZFd2O2tz+SJJ9A+VwXJnZ5dKoQP4Oe5asDwzCjlDuDNSLwbwyTSk
        GMg4ogs1dIglqE0ZaCSXc04/kTwJJxOSb4pbKbcMSCArLSPLke3Hw1QfUhFoNMFN
        mDelXFwirMlmE5TPP8ptzcQV4fV74stI6XSQiNlBgwNHLHfLJIfzIuBpOtwKxljb
        HuuelZLjaribjPvQ8fSqwMDrbmXaZ4GDo0n4NJcd4hiqh5i8ESDjjz+s8xBm9B6u
        Ggag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1657680763; x=1657767163; bh=v2yi1GASBVynC
        iccINM4XtNZv3y087EmLmPr8NHBZS0=; b=oYBm/2pVC3nyXGfl2qWu/4PIheZ3B
        o9jkfA+vdeJu4yalY79YizWBkfFS3UqiPccu4xHLIjhT0CyBwLY6wzrfpJJQicLE
        Sz1dEimSZTmNycjof1UCBuCE1SBoRdQkqe56DZg6QFAu/suJd65cKM5WgzsVzNhq
        2uM24luoU6RIu9bmGu1VUqZd6ETyJbFqeiMbw/s0A0SoxBa0kHkDsR8VHDagMzHq
        qR/vZynXs4l/cOV8S1Lb4ZdtBHC0JkQyP9xtAEN61RndSDIbXM1dw122cSnGPhJW
        3vYbfyjYJHV7rsjcv8CFdw45CnFeFYy7z+nduJ8xp4XQsyiIfo8JSuJjQ==
X-ME-Sender: <xms:ezPOYrWmgLJWjgCjp1Dyg0wPGA1jl_1Cr2Thbau8eIFJDwG2q5IAXA>
    <xme:ezPOYjm1X4N3Jw_bS7BBRowPXOYRuKm5EI2uQhT9TojD2a1LVkQCERTwC1QgOWWaH
    GlaOcRe1Rww0quMqQ>
X-ME-Received: <xmr:ezPOYna3fWIPob_HyIWSDepO_rY0XBcR0zLRfAJtAFfLcy4CmOlPs3BAKXM9r1QF_T0E7CSenrx9CTjJ49fts38gp7HURI3NhS2WuRUFXRYFclT0Z5tRwg4vLR4jb0XTsKtVtw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudejiedgieeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepudekteeuudehtdelteevgfduvddvjefhfedulefgudevgeeghefg
    udefiedtveetnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrh
    homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:ezPOYmWNBpxwTl3rXZ7h6TfvChYu3JOUEb-ggHTE5jXJyBUVZINrVw>
    <xmx:ezPOYlm2Mn3ePuUhiTBsD-N8CeajVx2ARDwBRcPkNti7o-iN1klc9g>
    <xmx:ezPOYjc2XqcQWnKSzfEqjXvVMkbMHx9D6kgW8Ku0V3enX-tLfacZTg>
    <xmx:ezPOYo8vKswicy_6Lr47tmLakHgBJd9-8WhbQ-tMYldFTzY2VK-GfQ>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Jul 2022 22:52:42 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andre Przywara <andre.przywara@arm.com>
Cc:     Samuel Holland <samuel@sholland.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev,
        Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH v2 6/6] pinctrl: sunxi: Add driver for Allwinner D1
Date:   Tue, 12 Jul 2022 21:52:33 -0500
Message-Id: <20220713025233.27248-7-samuel@sholland.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220713025233.27248-1-samuel@sholland.org>
References: <20220713025233.27248-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75 autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This SoC contains a pinctrl with a new register layout. Use the variant
parameter to set the right register offsets. This pinctrl also increases
the number of functions per pin from 8 to 16, taking advantage of all 4
bits in the mux config field (so far, only functions 0-8 and 14-15 are
used). This increases the maximum possible number of functions.

Reviewed-by: Heiko Stuebner <heiko@sntech.de>
Tested-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Samuel Holland <samuel@sholland.org>
---

Changes in v2:
 - Fix PE3 function "csi0" -> "ncsi0"
 - Fix comments for JTAG DI/DO pins
 - Include channel numbers in PWM functions
 - Drop the separate D1s variant, since D1s is a non-conflicting subset
 - Enable the driver for MACH_SUN8I to cover T113 (same die, but ARMv7)

 drivers/pinctrl/sunxi/Kconfig             |   5 +
 drivers/pinctrl/sunxi/Makefile            |   1 +
 drivers/pinctrl/sunxi/pinctrl-sun20i-d1.c | 840 ++++++++++++++++++++++
 drivers/pinctrl/sunxi/pinctrl-sunxi.c     |  16 +-
 drivers/pinctrl/sunxi/pinctrl-sunxi.h     |   6 +
 5 files changed, 863 insertions(+), 5 deletions(-)
 create mode 100644 drivers/pinctrl/sunxi/pinctrl-sun20i-d1.c

diff --git a/drivers/pinctrl/sunxi/Kconfig b/drivers/pinctrl/sunxi/Kconfig
index 7a7bcdc198a3..a78fdbbdfc0c 100644
--- a/drivers/pinctrl/sunxi/Kconfig
+++ b/drivers/pinctrl/sunxi/Kconfig
@@ -81,6 +81,11 @@ config PINCTRL_SUN9I_A80_R
 	default MACH_SUN9I
 	select PINCTRL_SUNXI
 
+config PINCTRL_SUN20I_D1
+	bool "Support for the Allwinner D1 PIO"
+	default MACH_SUN8I || (RISCV && ARCH_SUNXI)
+	select PINCTRL_SUNXI
+
 config PINCTRL_SUN50I_A64
 	bool "Support for the Allwinner A64 PIO"
 	default ARM64 && ARCH_SUNXI
diff --git a/drivers/pinctrl/sunxi/Makefile b/drivers/pinctrl/sunxi/Makefile
index d3440c42b9d6..2ff5a55927ad 100644
--- a/drivers/pinctrl/sunxi/Makefile
+++ b/drivers/pinctrl/sunxi/Makefile
@@ -20,6 +20,7 @@ obj-$(CONFIG_PINCTRL_SUN8I_A83T_R)	+= pinctrl-sun8i-a83t-r.o
 obj-$(CONFIG_PINCTRL_SUN8I_H3)		+= pinctrl-sun8i-h3.o
 obj-$(CONFIG_PINCTRL_SUN8I_H3_R)	+= pinctrl-sun8i-h3-r.o
 obj-$(CONFIG_PINCTRL_SUN8I_V3S)		+= pinctrl-sun8i-v3s.o
+obj-$(CONFIG_PINCTRL_SUN20I_D1)		+= pinctrl-sun20i-d1.o
 obj-$(CONFIG_PINCTRL_SUN50I_H5)		+= pinctrl-sun50i-h5.o
 obj-$(CONFIG_PINCTRL_SUN50I_H6)		+= pinctrl-sun50i-h6.o
 obj-$(CONFIG_PINCTRL_SUN50I_H6_R)	+= pinctrl-sun50i-h6-r.o
diff --git a/drivers/pinctrl/sunxi/pinctrl-sun20i-d1.c b/drivers/pinctrl/sunxi/pinctrl-sun20i-d1.c
new file mode 100644
index 000000000000..40858b881298
--- /dev/null
+++ b/drivers/pinctrl/sunxi/pinctrl-sun20i-d1.c
@@ -0,0 +1,840 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Allwinner D1 SoC pinctrl driver.
+ *
+ * Copyright (c) 2020 wuyan@allwinnertech.com
+ * Copyright (c) 2021-2022 Samuel Holland <samuel@sholland.org>
+ */
+
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/pinctrl/pinctrl.h>
+
+#include "pinctrl-sunxi.h"
+
+static const struct sunxi_desc_pin d1_pins[] = {
+	/* PB */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 0),
+		SUNXI_FUNCTION(0x0, "gpio_in"),
+		SUNXI_FUNCTION(0x1, "gpio_out"),
+		SUNXI_FUNCTION(0x2, "pwm3"),
+		SUNXI_FUNCTION(0x3, "ir"),		/* TX */
+		SUNXI_FUNCTION(0x4, "i2c2"),		/* SCK */
+		SUNXI_FUNCTION(0x5, "spi1"),		/* WP */
+		SUNXI_FUNCTION(0x6, "uart0"),		/* TX */
+		SUNXI_FUNCTION(0x7, "uart2"),		/* TX */
+		SUNXI_FUNCTION(0x8, "spdif"),		/* OUT */
+		SUNXI_FUNCTION_IRQ_BANK(0xe, 0, 0)),
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 1),
+		SUNXI_FUNCTION(0x0, "gpio_in"),
+		SUNXI_FUNCTION(0x1, "gpio_out"),
+		SUNXI_FUNCTION(0x2, "pwm4"),
+		SUNXI_FUNCTION(0x3, "i2s2_dout"),	/* DOUT3 */
+		SUNXI_FUNCTION(0x4, "i2c2"),		/* SDA */
+		SUNXI_FUNCTION(0x5, "i2s2_din"),	/* DIN3 */
+		SUNXI_FUNCTION(0x6, "uart0"),		/* RX */
+		SUNXI_FUNCTION(0x7, "uart2"),		/* RX */
+		SUNXI_FUNCTION(0x8, "ir"),		/* RX */
+		SUNXI_FUNCTION_IRQ_BANK(0xe, 0, 1)),
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 2),
+		SUNXI_FUNCTION(0x0, "gpio_in"),
+		SUNXI_FUNCTION(0x1, "gpio_out"),
+		SUNXI_FUNCTION(0x2, "lcd0"),		/* D0 */
+		SUNXI_FUNCTION(0x3, "i2s2_dout"),	/* DOUT2 */
+		SUNXI_FUNCTION(0x4, "i2c0"),		/* SDA */
+		SUNXI_FUNCTION(0x5, "i2s2_din"),	/* DIN2 */
+		SUNXI_FUNCTION(0x6, "lcd0"),		/* D18 */
+		SUNXI_FUNCTION(0x7, "uart4"),		/* TX */
+		SUNXI_FUNCTION_IRQ_BANK(0xe, 0, 2)),
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 3),
+		SUNXI_FUNCTION(0x0, "gpio_in"),
+		SUNXI_FUNCTION(0x1, "gpio_out"),
+		SUNXI_FUNCTION(0x2, "lcd0"),		/* D1 */
+		SUNXI_FUNCTION(0x3, "i2s2_dout"),	/* DOUT1 */
+		SUNXI_FUNCTION(0x4, "i2c0"),		/* SCK */
+		SUNXI_FUNCTION(0x5, "i2s2_din"),	/* DIN0 */
+		SUNXI_FUNCTION(0x6, "lcd0"),		/* D19 */
+		SUNXI_FUNCTION(0x7, "uart4"),		/* RX */
+		SUNXI_FUNCTION_IRQ_BANK(0xe, 0, 3)),
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 4),
+		SUNXI_FUNCTION(0x0, "gpio_in"),
+		SUNXI_FUNCTION(0x1, "gpio_out"),
+		SUNXI_FUNCTION(0x2, "lcd0"),		/* D8 */
+		SUNXI_FUNCTION(0x3, "i2s2_dout"),	/* DOUT0 */
+		SUNXI_FUNCTION(0x4, "i2c1"),		/* SCK */
+		SUNXI_FUNCTION(0x5, "i2s2_din"),	/* DIN1 */
+		SUNXI_FUNCTION(0x6, "lcd0"),		/* D20 */
+		SUNXI_FUNCTION(0x7, "uart5"),		/* TX */
+		SUNXI_FUNCTION_IRQ_BANK(0xe, 0, 4)),
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 5),
+		SUNXI_FUNCTION(0x0, "gpio_in"),
+		SUNXI_FUNCTION(0x1, "gpio_out"),
+		SUNXI_FUNCTION(0x2, "lcd0"),		/* D9 */
+		SUNXI_FUNCTION(0x3, "i2s2"),		/* BCLK */
+		SUNXI_FUNCTION(0x4, "i2c1"),		/* SDA */
+		SUNXI_FUNCTION(0x5, "pwm0"),
+		SUNXI_FUNCTION(0x6, "lcd0"),		/* D21 */
+		SUNXI_FUNCTION(0x7, "uart5"),		/* RX */
+		SUNXI_FUNCTION_IRQ_BANK(0xe, 0, 5)),
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 6),
+		SUNXI_FUNCTION(0x0, "gpio_in"),
+		SUNXI_FUNCTION(0x1, "gpio_out"),
+		SUNXI_FUNCTION(0x2, "lcd0"),		/* D16 */
+		SUNXI_FUNCTION(0x3, "i2s2"),		/* LRCK */
+		SUNXI_FUNCTION(0x4, "i2c3"),		/* SCK */
+		SUNXI_FUNCTION(0x5, "pwm1"),
+		SUNXI_FUNCTION(0x6, "lcd0"),		/* D22 */
+		SUNXI_FUNCTION(0x7, "uart3"),		/* TX */
+		SUNXI_FUNCTION(0x8, "bist0"),		/* BIST_RESULT0 */
+		SUNXI_FUNCTION_IRQ_BANK(0xe, 0, 6)),
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 7),
+		SUNXI_FUNCTION(0x0, "gpio_in"),
+		SUNXI_FUNCTION(0x1, "gpio_out"),
+		SUNXI_FUNCTION(0x2, "lcd0"),		/* D17 */
+		SUNXI_FUNCTION(0x3, "i2s2"),		/* MCLK */
+		SUNXI_FUNCTION(0x4, "i2c3"),		/* SDA */
+		SUNXI_FUNCTION(0x5, "ir"),		/* RX */
+		SUNXI_FUNCTION(0x6, "lcd0"),		/* D23 */
+		SUNXI_FUNCTION(0x7, "uart3"),		/* RX */
+		SUNXI_FUNCTION(0x8, "bist1"),		/* BIST_RESULT1 */
+		SUNXI_FUNCTION_IRQ_BANK(0xe, 0, 7)),
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 8),
+		SUNXI_FUNCTION(0x0, "gpio_in"),
+		SUNXI_FUNCTION(0x1, "gpio_out"),
+		SUNXI_FUNCTION(0x2, "dmic"),		/* DATA3 */
+		SUNXI_FUNCTION(0x3, "pwm5"),
+		SUNXI_FUNCTION(0x4, "i2c2"),		/* SCK */
+		SUNXI_FUNCTION(0x5, "spi1"),		/* HOLD */
+		SUNXI_FUNCTION(0x6, "uart0"),		/* TX */
+		SUNXI_FUNCTION(0x7, "uart1"),		/* TX */
+		SUNXI_FUNCTION_IRQ_BANK(0xe, 0, 8)),
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 9),
+		SUNXI_FUNCTION(0x0, "gpio_in"),
+		SUNXI_FUNCTION(0x1, "gpio_out"),
+		SUNXI_FUNCTION(0x2, "dmic"),		/* DATA2 */
+		SUNXI_FUNCTION(0x3, "pwm6"),
+		SUNXI_FUNCTION(0x4, "i2c2"),		/* SDA */
+		SUNXI_FUNCTION(0x5, "spi1"),		/* MISO */
+		SUNXI_FUNCTION(0x6, "uart0"),		/* RX */
+		SUNXI_FUNCTION(0x7, "uart1"),		/* RX */
+		SUNXI_FUNCTION_IRQ_BANK(0xe, 0, 9)),
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 10),
+		SUNXI_FUNCTION(0x0, "gpio_in"),
+		SUNXI_FUNCTION(0x1, "gpio_out"),
+		SUNXI_FUNCTION(0x2, "dmic"),		/* DATA1 */
+		SUNXI_FUNCTION(0x3, "pwm7"),
+		SUNXI_FUNCTION(0x4, "i2c0"),		/* SCK */
+		SUNXI_FUNCTION(0x5, "spi1"),		/* MOSI */
+		SUNXI_FUNCTION(0x6, "clk"),		/* FANOUT0 */
+		SUNXI_FUNCTION(0x7, "uart1"),		/* RTS */
+		SUNXI_FUNCTION_IRQ_BANK(0xe, 0, 10)),
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 11),
+		SUNXI_FUNCTION(0x0, "gpio_in"),
+		SUNXI_FUNCTION(0x1, "gpio_out"),
+		SUNXI_FUNCTION(0x2, "dmic"),		/* DATA0 */
+		SUNXI_FUNCTION(0x3, "pwm2"),
+		SUNXI_FUNCTION(0x4, "i2c0"),		/* SDA */
+		SUNXI_FUNCTION(0x5, "spi1"),		/* CLK */
+		SUNXI_FUNCTION(0x6, "clk"),		/* FANOUT1 */
+		SUNXI_FUNCTION(0x7, "uart1"),		/* CTS */
+		SUNXI_FUNCTION_IRQ_BANK(0xe, 0, 11)),
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 12),
+		SUNXI_FUNCTION(0x0, "gpio_in"),
+		SUNXI_FUNCTION(0x1, "gpio_out"),
+		SUNXI_FUNCTION(0x2, "dmic"),		/* CLK */
+		SUNXI_FUNCTION(0x3, "pwm0"),
+		SUNXI_FUNCTION(0x4, "spdif"),		/* IN */
+		SUNXI_FUNCTION(0x5, "spi1"),		/* CS0 */
+		SUNXI_FUNCTION(0x6, "clk"),		/* FANOUT2 */
+		SUNXI_FUNCTION(0x7, "ir"),		/* RX */
+		SUNXI_FUNCTION_IRQ_BANK(0xe, 0, 12)),
+	/* PC */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 0),
+		SUNXI_FUNCTION(0x0, "gpio_in"),
+		SUNXI_FUNCTION(0x1, "gpio_out"),
+		SUNXI_FUNCTION(0x2, "uart2"),		/* TX */
+		SUNXI_FUNCTION(0x3, "i2c2"),		/* SCK */
+		SUNXI_FUNCTION(0x4, "ledc"),
+		SUNXI_FUNCTION_IRQ_BANK(0xe, 1, 0)),
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 1),
+		SUNXI_FUNCTION(0x0, "gpio_in"),
+		SUNXI_FUNCTION(0x1, "gpio_out"),
+		SUNXI_FUNCTION(0x2, "uart2"),		/* RX */
+		SUNXI_FUNCTION(0x3, "i2c2"),		/* SDA */
+		SUNXI_FUNCTION_IRQ_BANK(0xe, 1, 1)),
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 2),
+		SUNXI_FUNCTION(0x0, "gpio_in"),
+		SUNXI_FUNCTION(0x1, "gpio_out"),
+		SUNXI_FUNCTION(0x2, "spi0"),		/* CLK */
+		SUNXI_FUNCTION(0x3, "mmc2"),		/* CLK */
+		SUNXI_FUNCTION_IRQ_BANK(0xe, 1, 2)),
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 3),
+		SUNXI_FUNCTION(0x0, "gpio_in"),
+		SUNXI_FUNCTION(0x1, "gpio_out"),
+		SUNXI_FUNCTION(0x2, "spi0"),		/* CS0 */
+		SUNXI_FUNCTION(0x3, "mmc2"),		/* CMD */
+		SUNXI_FUNCTION_IRQ_BANK(0xe, 1, 3)),
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 4),
+		SUNXI_FUNCTION(0x0, "gpio_in"),
+		SUNXI_FUNCTION(0x1, "gpio_out"),
+		SUNXI_FUNCTION(0x2, "spi0"),		/* MOSI */
+		SUNXI_FUNCTION(0x3, "mmc2"),		/* D2 */
+		SUNXI_FUNCTION(0x4, "boot"),		/* SEL0 */
+		SUNXI_FUNCTION_IRQ_BANK(0xe, 1, 4)),
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 5),
+		SUNXI_FUNCTION(0x0, "gpio_in"),
+		SUNXI_FUNCTION(0x1, "gpio_out"),
+		SUNXI_FUNCTION(0x2, "spi0"),		/* MISO */
+		SUNXI_FUNCTION(0x3, "mmc2"),		/* D1 */
+		SUNXI_FUNCTION(0x4, "boot"),		/* SEL1 */
+		SUNXI_FUNCTION_IRQ_BANK(0xe, 1, 5)),
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 6),
+		SUNXI_FUNCTION(0x0, "gpio_in"),
+		SUNXI_FUNCTION(0x1, "gpio_out"),
+		SUNXI_FUNCTION(0x2, "spi0"),		/* WP */
+		SUNXI_FUNCTION(0x3, "mmc2"),		/* D0 */
+		SUNXI_FUNCTION(0x4, "uart3"),		/* TX */
+		SUNXI_FUNCTION(0x5, "i2c3"),		/* SCK */
+		SUNXI_FUNCTION(0x6, "pll"),		/* DBG-CLK */
+		SUNXI_FUNCTION_IRQ_BANK(0xe, 1, 6)),
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 7),
+		SUNXI_FUNCTION(0x0, "gpio_in"),
+		SUNXI_FUNCTION(0x1, "gpio_out"),
+		SUNXI_FUNCTION(0x2, "spi0"),		/* HOLD */
+		SUNXI_FUNCTION(0x3, "mmc2"),		/* D3 */
+		SUNXI_FUNCTION(0x4, "uart3"),		/* RX */
+		SUNXI_FUNCTION(0x5, "i2c3"),		/* SDA */
+		SUNXI_FUNCTION(0x6, "tcon"),		/* TRIG0 */
+		SUNXI_FUNCTION_IRQ_BANK(0xe, 1, 7)),
+	/* PD */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 0),
+		SUNXI_FUNCTION(0x0, "gpio_in"),
+		SUNXI_FUNCTION(0x1, "gpio_out"),
+		SUNXI_FUNCTION(0x2, "lcd0"),		/* D2 */
+		SUNXI_FUNCTION(0x3, "lvds0"),		/* V0P */
+		SUNXI_FUNCTION(0x4, "dsi"),		/* D0P */
+		SUNXI_FUNCTION(0x5, "i2c0"),		/* SCK */
+		SUNXI_FUNCTION_IRQ_BANK(0xe, 2, 0)),
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 1),
+		SUNXI_FUNCTION(0x0, "gpio_in"),
+		SUNXI_FUNCTION(0x1, "gpio_out"),
+		SUNXI_FUNCTION(0x2, "lcd0"),		/* D3 */
+		SUNXI_FUNCTION(0x3, "lvds0"),		/* V0N */
+		SUNXI_FUNCTION(0x4, "dsi"),		/* D0N */
+		SUNXI_FUNCTION(0x5, "uart2"),		/* TX */
+		SUNXI_FUNCTION_IRQ_BANK(0xe, 2, 1)),
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 2),
+		SUNXI_FUNCTION(0x0, "gpio_in"),
+		SUNXI_FUNCTION(0x1, "gpio_out"),
+		SUNXI_FUNCTION(0x2, "lcd0"),		/* D4 */
+		SUNXI_FUNCTION(0x3, "lvds0"),		/* V1P */
+		SUNXI_FUNCTION(0x4, "dsi"),		/* D1P */
+		SUNXI_FUNCTION(0x5, "uart2"),		/* RX */
+		SUNXI_FUNCTION_IRQ_BANK(0xe, 2, 2)),
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 3),
+		SUNXI_FUNCTION(0x0, "gpio_in"),
+		SUNXI_FUNCTION(0x1, "gpio_out"),
+		SUNXI_FUNCTION(0x2, "lcd0"),		/* D5 */
+		SUNXI_FUNCTION(0x3, "lvds0"),		/* V1N */
+		SUNXI_FUNCTION(0x4, "dsi"),		/* D1N */
+		SUNXI_FUNCTION(0x5, "uart2"),		/* RTS */
+		SUNXI_FUNCTION_IRQ_BANK(0xe, 2, 3)),
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 4),
+		SUNXI_FUNCTION(0x0, "gpio_in"),
+		SUNXI_FUNCTION(0x1, "gpio_out"),
+		SUNXI_FUNCTION(0x2, "lcd0"),		/* D6 */
+		SUNXI_FUNCTION(0x3, "lvds0"),		/* V2P */
+		SUNXI_FUNCTION(0x4, "dsi"),		/* CKP */
+		SUNXI_FUNCTION(0x5, "uart2"),		/* CTS */
+		SUNXI_FUNCTION_IRQ_BANK(0xe, 2, 4)),
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 5),
+		SUNXI_FUNCTION(0x0, "gpio_in"),
+		SUNXI_FUNCTION(0x1, "gpio_out"),
+		SUNXI_FUNCTION(0x2, "lcd0"),		/* D7 */
+		SUNXI_FUNCTION(0x3, "lvds0"),		/* V2N */
+		SUNXI_FUNCTION(0x4, "dsi"),		/* CKN */
+		SUNXI_FUNCTION(0x5, "uart5"),		/* TX */
+		SUNXI_FUNCTION_IRQ_BANK(0xe, 2, 5)),
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 6),
+		SUNXI_FUNCTION(0x0, "gpio_in"),
+		SUNXI_FUNCTION(0x1, "gpio_out"),
+		SUNXI_FUNCTION(0x2, "lcd0"),		/* D10 */
+		SUNXI_FUNCTION(0x3, "lvds0"),		/* CKP */
+		SUNXI_FUNCTION(0x4, "dsi"),		/* D2P */
+		SUNXI_FUNCTION(0x5, "uart5"),		/* RX */
+		SUNXI_FUNCTION_IRQ_BANK(0xe, 2, 6)),
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 7),
+		SUNXI_FUNCTION(0x0, "gpio_in"),
+		SUNXI_FUNCTION(0x1, "gpio_out"),
+		SUNXI_FUNCTION(0x2, "lcd0"),		/* D11 */
+		SUNXI_FUNCTION(0x3, "lvds0"),		/* CKN */
+		SUNXI_FUNCTION(0x4, "dsi"),		/* D2N */
+		SUNXI_FUNCTION(0x5, "uart4"),		/* TX */
+		SUNXI_FUNCTION_IRQ_BANK(0xe, 2, 7)),
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 8),
+		SUNXI_FUNCTION(0x0, "gpio_in"),
+		SUNXI_FUNCTION(0x1, "gpio_out"),
+		SUNXI_FUNCTION(0x2, "lcd0"),		/* D12 */
+		SUNXI_FUNCTION(0x3, "lvds0"),		/* V3P */
+		SUNXI_FUNCTION(0x4, "dsi"),		/* D3P */
+		SUNXI_FUNCTION(0x5, "uart4"),		/* RX */
+		SUNXI_FUNCTION_IRQ_BANK(0xe, 2, 8)),
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 9),
+		SUNXI_FUNCTION(0x0, "gpio_in"),
+		SUNXI_FUNCTION(0x1, "gpio_out"),
+		SUNXI_FUNCTION(0x2, "lcd0"),		/* D13 */
+		SUNXI_FUNCTION(0x3, "lvds0"),		/* V3N */
+		SUNXI_FUNCTION(0x4, "dsi"),		/* D3N */
+		SUNXI_FUNCTION(0x5, "pwm6"),
+		SUNXI_FUNCTION_IRQ_BANK(0xe, 2, 9)),
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 10),
+		SUNXI_FUNCTION(0x0, "gpio_in"),
+		SUNXI_FUNCTION(0x1, "gpio_out"),
+		SUNXI_FUNCTION(0x2, "lcd0"),		/* D14 */
+		SUNXI_FUNCTION(0x3, "lvds1"),		/* V0P */
+		SUNXI_FUNCTION(0x4, "spi1"),		/* CS0 */
+		SUNXI_FUNCTION(0x5, "uart3"),		/* TX */
+		SUNXI_FUNCTION_IRQ_BANK(0xe, 2, 10)),
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 11),
+		SUNXI_FUNCTION(0x0, "gpio_in"),
+		SUNXI_FUNCTION(0x1, "gpio_out"),
+		SUNXI_FUNCTION(0x2, "lcd0"),		/* D15 */
+		SUNXI_FUNCTION(0x3, "lvds1"),		/* V0N */
+		SUNXI_FUNCTION(0x4, "spi1"),		/* CLK */
+		SUNXI_FUNCTION(0x5, "uart3"),		/* RX */
+		SUNXI_FUNCTION_IRQ_BANK(0xe, 2, 11)),
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 12),
+		SUNXI_FUNCTION(0x0, "gpio_in"),
+		SUNXI_FUNCTION(0x1, "gpio_out"),
+		SUNXI_FUNCTION(0x2, "lcd0"),		/* D18 */
+		SUNXI_FUNCTION(0x3, "lvds1"),		/* V1P */
+		SUNXI_FUNCTION(0x4, "spi1"),		/* MOSI */
+		SUNXI_FUNCTION(0x5, "i2c0"),		/* SDA */
+		SUNXI_FUNCTION_IRQ_BANK(0xe, 2, 12)),
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 13),
+		SUNXI_FUNCTION(0x0, "gpio_in"),
+		SUNXI_FUNCTION(0x1, "gpio_out"),
+		SUNXI_FUNCTION(0x2, "lcd0"),		/* D19 */
+		SUNXI_FUNCTION(0x3, "lvds1"),		/* V1N */
+		SUNXI_FUNCTION(0x4, "spi1"),		/* MISO */
+		SUNXI_FUNCTION(0x5, "uart3"),		/* RTS */
+		SUNXI_FUNCTION_IRQ_BANK(0xe, 2, 13)),
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 14),
+		SUNXI_FUNCTION(0x0, "gpio_in"),
+		SUNXI_FUNCTION(0x1, "gpio_out"),
+		SUNXI_FUNCTION(0x2, "lcd0"),		/* D20 */
+		SUNXI_FUNCTION(0x3, "lvds1"),		/* V2P */
+		SUNXI_FUNCTION(0x4, "spi1"),		/* HOLD */
+		SUNXI_FUNCTION(0x5, "uart3"),		/* CTS */
+		SUNXI_FUNCTION_IRQ_BANK(0xe, 2, 14)),
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 15),
+		SUNXI_FUNCTION(0x0, "gpio_in"),
+		SUNXI_FUNCTION(0x1, "gpio_out"),
+		SUNXI_FUNCTION(0x2, "lcd0"),		/* D21 */
+		SUNXI_FUNCTION(0x3, "lvds1"),		/* V2N */
+		SUNXI_FUNCTION(0x4, "spi1"),		/* WP */
+		SUNXI_FUNCTION(0x5, "ir"),		/* RX */
+		SUNXI_FUNCTION_IRQ_BANK(0xe, 2, 15)),
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 16),
+		SUNXI_FUNCTION(0x0, "gpio_in"),
+		SUNXI_FUNCTION(0x1, "gpio_out"),
+		SUNXI_FUNCTION(0x2, "lcd0"),		/* D22 */
+		SUNXI_FUNCTION(0x3, "lvds1"),		/* CKP */
+		SUNXI_FUNCTION(0x4, "dmic"),		/* DATA3 */
+		SUNXI_FUNCTION(0x5, "pwm0"),
+		SUNXI_FUNCTION_IRQ_BANK(0xe, 2, 16)),
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 17),
+		SUNXI_FUNCTION(0x0, "gpio_in"),
+		SUNXI_FUNCTION(0x1, "gpio_out"),
+		SUNXI_FUNCTION(0x2, "lcd0"),		/* D23 */
+		SUNXI_FUNCTION(0x3, "lvds1"),		/* CKN */
+		SUNXI_FUNCTION(0x4, "dmic"),		/* DATA2 */
+		SUNXI_FUNCTION(0x5, "pwm1"),
+		SUNXI_FUNCTION_IRQ_BANK(0xe, 2, 17)),
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 18),
+		SUNXI_FUNCTION(0x0, "gpio_in"),
+		SUNXI_FUNCTION(0x1, "gpio_out"),
+		SUNXI_FUNCTION(0x2, "lcd0"),		/* CLK */
+		SUNXI_FUNCTION(0x3, "lvds1"),		/* V3P */
+		SUNXI_FUNCTION(0x4, "dmic"),		/* DATA1 */
+		SUNXI_FUNCTION(0x5, "pwm2"),
+		SUNXI_FUNCTION_IRQ_BANK(0xe, 2, 18)),
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 19),
+		SUNXI_FUNCTION(0x0, "gpio_in"),
+		SUNXI_FUNCTION(0x1, "gpio_out"),
+		SUNXI_FUNCTION(0x2, "lcd0"),		/* DE */
+		SUNXI_FUNCTION(0x3, "lvds1"),		/* V3N */
+		SUNXI_FUNCTION(0x4, "dmic"),		/* DATA0 */
+		SUNXI_FUNCTION(0x5, "pwm3"),
+		SUNXI_FUNCTION_IRQ_BANK(0xe, 2, 19)),
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 20),
+		SUNXI_FUNCTION(0x0, "gpio_in"),
+		SUNXI_FUNCTION(0x1, "gpio_out"),
+		SUNXI_FUNCTION(0x2, "lcd0"),		/* HSYNC */
+		SUNXI_FUNCTION(0x3, "i2c2"),		/* SCK */
+		SUNXI_FUNCTION(0x4, "dmic"),		/* CLK */
+		SUNXI_FUNCTION(0x5, "pwm4"),
+		SUNXI_FUNCTION_IRQ_BANK(0xe, 2, 20)),
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 21),
+		SUNXI_FUNCTION(0x0, "gpio_in"),
+		SUNXI_FUNCTION(0x1, "gpio_out"),
+		SUNXI_FUNCTION(0x2, "lcd0"),		/* VSYNC */
+		SUNXI_FUNCTION(0x3, "i2c2"),		/* SDA */
+		SUNXI_FUNCTION(0x4, "uart1"),		/* TX */
+		SUNXI_FUNCTION(0x5, "pwm5"),
+		SUNXI_FUNCTION_IRQ_BANK(0xe, 2, 21)),
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 22),
+		SUNXI_FUNCTION(0x0, "gpio_in"),
+		SUNXI_FUNCTION(0x1, "gpio_out"),
+		SUNXI_FUNCTION(0x2, "spdif"),		/* OUT */
+		SUNXI_FUNCTION(0x3, "ir"),		/* RX */
+		SUNXI_FUNCTION(0x4, "uart1"),		/* RX */
+		SUNXI_FUNCTION(0x5, "pwm7"),
+		SUNXI_FUNCTION_IRQ_BANK(0xe, 2, 22)),
+	/* PE */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 0),
+		SUNXI_FUNCTION(0x0, "gpio_in"),
+		SUNXI_FUNCTION(0x1, "gpio_out"),
+		SUNXI_FUNCTION(0x2, "ncsi0"),		/* HSYNC */
+		SUNXI_FUNCTION(0x3, "uart2"),		/* RTS */
+		SUNXI_FUNCTION(0x4, "i2c1"),		/* SCK */
+		SUNXI_FUNCTION(0x5, "lcd0"),		/* HSYNC */
+		SUNXI_FUNCTION(0x8, "emac"),		/* RXCTL/CRS_DV */
+		SUNXI_FUNCTION_IRQ_BANK(0xe, 3, 0)),
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 1),
+		SUNXI_FUNCTION(0x0, "gpio_in"),
+		SUNXI_FUNCTION(0x1, "gpio_out"),
+		SUNXI_FUNCTION(0x2, "ncsi0"),		/* VSYNC */
+		SUNXI_FUNCTION(0x3, "uart2"),		/* CTS */
+		SUNXI_FUNCTION(0x4, "i2c1"),		/* SDA */
+		SUNXI_FUNCTION(0x5, "lcd0"),		/* VSYNC */
+		SUNXI_FUNCTION(0x8, "emac"),		/* RXD0 */
+		SUNXI_FUNCTION_IRQ_BANK(0xe, 3, 1)),
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 2),
+		SUNXI_FUNCTION(0x0, "gpio_in"),
+		SUNXI_FUNCTION(0x1, "gpio_out"),
+		SUNXI_FUNCTION(0x2, "ncsi0"),		/* PCLK */
+		SUNXI_FUNCTION(0x3, "uart2"),		/* TX */
+		SUNXI_FUNCTION(0x4, "i2c0"),		/* SCK */
+		SUNXI_FUNCTION(0x5, "clk"),		/* FANOUT0 */
+		SUNXI_FUNCTION(0x6, "uart0"),		/* TX */
+		SUNXI_FUNCTION(0x8, "emac"),		/* RXD1 */
+		SUNXI_FUNCTION_IRQ_BANK(0xe, 3, 2)),
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 3),
+		SUNXI_FUNCTION(0x0, "gpio_in"),
+		SUNXI_FUNCTION(0x1, "gpio_out"),
+		SUNXI_FUNCTION(0x2, "ncsi0"),		/* MCLK */
+		SUNXI_FUNCTION(0x3, "uart2"),		/* RX */
+		SUNXI_FUNCTION(0x4, "i2c0"),		/* SDA */
+		SUNXI_FUNCTION(0x5, "clk"),		/* FANOUT1 */
+		SUNXI_FUNCTION(0x6, "uart0"),		/* RX */
+		SUNXI_FUNCTION(0x8, "emac"),		/* TXCK */
+		SUNXI_FUNCTION_IRQ_BANK(0xe, 3, 3)),
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 4),
+		SUNXI_FUNCTION(0x0, "gpio_in"),
+		SUNXI_FUNCTION(0x1, "gpio_out"),
+		SUNXI_FUNCTION(0x2, "ncsi0"),		/* D0 */
+		SUNXI_FUNCTION(0x3, "uart4"),		/* TX */
+		SUNXI_FUNCTION(0x4, "i2c2"),		/* SCK */
+		SUNXI_FUNCTION(0x5, "clk"),		/* FANOUT2 */
+		SUNXI_FUNCTION(0x6, "d_jtag"),		/* MS */
+		SUNXI_FUNCTION(0x7, "r_jtag"),		/* MS */
+		SUNXI_FUNCTION(0x8, "emac"),		/* TXD0 */
+		SUNXI_FUNCTION_IRQ_BANK(0xe, 3, 4)),
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 5),
+		SUNXI_FUNCTION(0x0, "gpio_in"),
+		SUNXI_FUNCTION(0x1, "gpio_out"),
+		SUNXI_FUNCTION(0x2, "ncsi0"),		/* D1 */
+		SUNXI_FUNCTION(0x3, "uart4"),		/* RX */
+		SUNXI_FUNCTION(0x4, "i2c2"),		/* SDA */
+		SUNXI_FUNCTION(0x5, "ledc"),
+		SUNXI_FUNCTION(0x6, "d_jtag"),		/* DI */
+		SUNXI_FUNCTION(0x7, "r_jtag"),		/* DI */
+		SUNXI_FUNCTION(0x8, "emac"),		/* TXD1 */
+		SUNXI_FUNCTION_IRQ_BANK(0xe, 3, 5)),
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 6),
+		SUNXI_FUNCTION(0x0, "gpio_in"),
+		SUNXI_FUNCTION(0x1, "gpio_out"),
+		SUNXI_FUNCTION(0x2, "ncsi0"),		/* D2 */
+		SUNXI_FUNCTION(0x3, "uart5"),		/* TX */
+		SUNXI_FUNCTION(0x4, "i2c3"),		/* SCK */
+		SUNXI_FUNCTION(0x5, "spdif"),		/* IN */
+		SUNXI_FUNCTION(0x6, "d_jtag"),		/* DO */
+		SUNXI_FUNCTION(0x7, "r_jtag"),		/* DO */
+		SUNXI_FUNCTION(0x8, "emac"),		/* TXCTL/TXEN */
+		SUNXI_FUNCTION_IRQ_BANK(0xe, 3, 6)),
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 7),
+		SUNXI_FUNCTION(0x0, "gpio_in"),
+		SUNXI_FUNCTION(0x1, "gpio_out"),
+		SUNXI_FUNCTION(0x2, "ncsi0"),		/* D3 */
+		SUNXI_FUNCTION(0x3, "uart5"),		/* RX */
+		SUNXI_FUNCTION(0x4, "i2c3"),		/* SDA */
+		SUNXI_FUNCTION(0x5, "spdif"),		/* OUT */
+		SUNXI_FUNCTION(0x6, "d_jtag"),		/* CK */
+		SUNXI_FUNCTION(0x7, "r_jtag"),		/* CK */
+		SUNXI_FUNCTION(0x8, "emac"),		/* CK */
+		SUNXI_FUNCTION_IRQ_BANK(0xe, 3, 7)),
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 8),
+		SUNXI_FUNCTION(0x0, "gpio_in"),
+		SUNXI_FUNCTION(0x1, "gpio_out"),
+		SUNXI_FUNCTION(0x2, "ncsi0"),		/* D4 */
+		SUNXI_FUNCTION(0x3, "uart1"),		/* RTS */
+		SUNXI_FUNCTION(0x4, "pwm2"),
+		SUNXI_FUNCTION(0x5, "uart3"),		/* TX */
+		SUNXI_FUNCTION(0x6, "jtag"),		/* MS */
+		SUNXI_FUNCTION(0x8, "emac"),		/* MDC */
+		SUNXI_FUNCTION_IRQ_BANK(0xe, 3, 8)),
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 9),
+		SUNXI_FUNCTION(0x0, "gpio_in"),
+		SUNXI_FUNCTION(0x1, "gpio_out"),
+		SUNXI_FUNCTION(0x2, "ncsi0"),		/* D5 */
+		SUNXI_FUNCTION(0x3, "uart1"),		/* CTS */
+		SUNXI_FUNCTION(0x4, "pwm3"),
+		SUNXI_FUNCTION(0x5, "uart3"),		/* RX */
+		SUNXI_FUNCTION(0x6, "jtag"),		/* DI */
+		SUNXI_FUNCTION(0x8, "emac"),		/* MDIO */
+		SUNXI_FUNCTION_IRQ_BANK(0xe, 3, 9)),
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 10),
+		SUNXI_FUNCTION(0x0, "gpio_in"),
+		SUNXI_FUNCTION(0x1, "gpio_out"),
+		SUNXI_FUNCTION(0x2, "ncsi0"),		/* D6 */
+		SUNXI_FUNCTION(0x3, "uart1"),		/* TX */
+		SUNXI_FUNCTION(0x4, "pwm4"),
+		SUNXI_FUNCTION(0x5, "ir"),		/* RX */
+		SUNXI_FUNCTION(0x6, "jtag"),		/* DO */
+		SUNXI_FUNCTION(0x8, "emac"),		/* EPHY-25M */
+		SUNXI_FUNCTION_IRQ_BANK(0xe, 3, 10)),
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 11),
+		SUNXI_FUNCTION(0x0, "gpio_in"),
+		SUNXI_FUNCTION(0x1, "gpio_out"),
+		SUNXI_FUNCTION(0x2, "ncsi0"),		/* D7 */
+		SUNXI_FUNCTION(0x3, "uart1"),		/* RX */
+		SUNXI_FUNCTION(0x4, "i2s0_dout"),	/* DOUT3 */
+		SUNXI_FUNCTION(0x5, "i2s0_din"),	/* DIN3 */
+		SUNXI_FUNCTION(0x6, "jtag"),		/* CK */
+		SUNXI_FUNCTION(0x8, "emac"),		/* TXD2 */
+		SUNXI_FUNCTION_IRQ_BANK(0xe, 3, 11)),
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 12),
+		SUNXI_FUNCTION(0x0, "gpio_in"),
+		SUNXI_FUNCTION(0x1, "gpio_out"),
+		SUNXI_FUNCTION(0x2, "i2c2"),		/* SCK */
+		SUNXI_FUNCTION(0x3, "ncsi0"),		/* FIELD */
+		SUNXI_FUNCTION(0x4, "i2s0_dout"),	/* DOUT2 */
+		SUNXI_FUNCTION(0x5, "i2s0_din"),	/* DIN2 */
+		SUNXI_FUNCTION(0x8, "emac"),		/* TXD3 */
+		SUNXI_FUNCTION_IRQ_BANK(0xe, 3, 12)),
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 13),
+		SUNXI_FUNCTION(0x0, "gpio_in"),
+		SUNXI_FUNCTION(0x1, "gpio_out"),
+		SUNXI_FUNCTION(0x2, "i2c2"),		/* SDA */
+		SUNXI_FUNCTION(0x3, "pwm5"),
+		SUNXI_FUNCTION(0x4, "i2s0_dout"),	/* DOUT0 */
+		SUNXI_FUNCTION(0x5, "i2s0_din"),	/* DIN1 */
+		SUNXI_FUNCTION(0x6, "dmic"),		/* DATA3 */
+		SUNXI_FUNCTION(0x8, "emac"),		/* RXD2 */
+		SUNXI_FUNCTION_IRQ_BANK(0xe, 3, 13)),
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 14),
+		SUNXI_FUNCTION(0x0, "gpio_in"),
+		SUNXI_FUNCTION(0x1, "gpio_out"),
+		SUNXI_FUNCTION(0x2, "i2c1"),		/* SCK */
+		SUNXI_FUNCTION(0x3, "d_jtag"),		/* MS */
+		SUNXI_FUNCTION(0x4, "i2s0_dout"),	/* DOUT1 */
+		SUNXI_FUNCTION(0x5, "i2s0_din"),	/* DIN0 */
+		SUNXI_FUNCTION(0x6, "dmic"),		/* DATA2 */
+		SUNXI_FUNCTION(0x8, "emac"),		/* RXD3 */
+		SUNXI_FUNCTION_IRQ_BANK(0xe, 3, 14)),
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 15),
+		SUNXI_FUNCTION(0x0, "gpio_in"),
+		SUNXI_FUNCTION(0x1, "gpio_out"),
+		SUNXI_FUNCTION(0x2, "i2c1"),		/* SDA */
+		SUNXI_FUNCTION(0x3, "d_jtag"),		/* DI */
+		SUNXI_FUNCTION(0x4, "pwm6"),
+		SUNXI_FUNCTION(0x5, "i2s0"),		/* LRCK */
+		SUNXI_FUNCTION(0x6, "dmic"),		/* DATA1 */
+		SUNXI_FUNCTION(0x8, "emac"),		/* RXCK */
+		SUNXI_FUNCTION_IRQ_BANK(0xe, 3, 15)),
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 16),
+		SUNXI_FUNCTION(0x0, "gpio_in"),
+		SUNXI_FUNCTION(0x1, "gpio_out"),
+		SUNXI_FUNCTION(0x2, "i2c3"),		/* SCK */
+		SUNXI_FUNCTION(0x3, "d_jtag"),		/* DO */
+		SUNXI_FUNCTION(0x4, "pwm7"),
+		SUNXI_FUNCTION(0x5, "i2s0"),		/* BCLK */
+		SUNXI_FUNCTION(0x6, "dmic"),		/* DATA0 */
+		SUNXI_FUNCTION_IRQ_BANK(0xe, 3, 16)),
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 17),
+		SUNXI_FUNCTION(0x0, "gpio_in"),
+		SUNXI_FUNCTION(0x1, "gpio_out"),
+		SUNXI_FUNCTION(0x2, "i2c3"),		/* SDA */
+		SUNXI_FUNCTION(0x3, "d_jtag"),		/* CK */
+		SUNXI_FUNCTION(0x4, "ir"),		/* TX */
+		SUNXI_FUNCTION(0x5, "i2s0"),		/* MCLK */
+		SUNXI_FUNCTION(0x6, "dmic"),		/* CLK */
+		SUNXI_FUNCTION_IRQ_BANK(0xe, 3, 17)),
+	/* PF */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(F, 0),
+		SUNXI_FUNCTION(0x0, "gpio_in"),
+		SUNXI_FUNCTION(0x1, "gpio_out"),
+		SUNXI_FUNCTION(0x2, "mmc0"),		/* D1 */
+		SUNXI_FUNCTION(0x3, "jtag"),		/* MS */
+		SUNXI_FUNCTION(0x4, "r_jtag"),		/* MS */
+		SUNXI_FUNCTION(0x5, "i2s2_dout"),	/* DOUT1 */
+		SUNXI_FUNCTION(0x6, "i2s2_din"),	/* DIN0 */
+		SUNXI_FUNCTION_IRQ_BANK(0xe, 4, 0)),
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(F, 1),
+		SUNXI_FUNCTION(0x0, "gpio_in"),
+		SUNXI_FUNCTION(0x1, "gpio_out"),
+		SUNXI_FUNCTION(0x2, "mmc0"),		/* D0 */
+		SUNXI_FUNCTION(0x3, "jtag"),		/* DI */
+		SUNXI_FUNCTION(0x4, "r_jtag"),		/* DI */
+		SUNXI_FUNCTION(0x5, "i2s2_dout"),	/* DOUT0 */
+		SUNXI_FUNCTION(0x6, "i2s2_din"),	/* DIN1 */
+		SUNXI_FUNCTION_IRQ_BANK(0xe, 4, 1)),
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(F, 2),
+		SUNXI_FUNCTION(0x0, "gpio_in"),
+		SUNXI_FUNCTION(0x1, "gpio_out"),
+		SUNXI_FUNCTION(0x2, "mmc0"),		/* CLK */
+		SUNXI_FUNCTION(0x3, "uart0"),		/* TX */
+		SUNXI_FUNCTION(0x4, "i2c0"),		/* SCK */
+		SUNXI_FUNCTION(0x5, "ledc"),
+		SUNXI_FUNCTION(0x6, "spdif"),		/* IN */
+		SUNXI_FUNCTION_IRQ_BANK(0xe, 4, 2)),
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(F, 3),
+		SUNXI_FUNCTION(0x0, "gpio_in"),
+		SUNXI_FUNCTION(0x1, "gpio_out"),
+		SUNXI_FUNCTION(0x2, "mmc0"),		/* CMD */
+		SUNXI_FUNCTION(0x3, "jtag"),		/* DO */
+		SUNXI_FUNCTION(0x4, "r_jtag"),		/* DO */
+		SUNXI_FUNCTION(0x5, "i2s2"),		/* BCLK */
+		SUNXI_FUNCTION_IRQ_BANK(0xe, 4, 3)),
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(F, 4),
+		SUNXI_FUNCTION(0x0, "gpio_in"),
+		SUNXI_FUNCTION(0x1, "gpio_out"),
+		SUNXI_FUNCTION(0x2, "mmc0"),		/* D3 */
+		SUNXI_FUNCTION(0x3, "uart0"),		/* RX */
+		SUNXI_FUNCTION(0x4, "i2c0"),		/* SDA */
+		SUNXI_FUNCTION(0x5, "pwm6"),
+		SUNXI_FUNCTION(0x6, "ir"),		/* TX */
+		SUNXI_FUNCTION_IRQ_BANK(0xe, 4, 4)),
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(F, 5),
+		SUNXI_FUNCTION(0x0, "gpio_in"),
+		SUNXI_FUNCTION(0x1, "gpio_out"),
+		SUNXI_FUNCTION(0x2, "mmc0"),		/* D2 */
+		SUNXI_FUNCTION(0x3, "jtag"),		/* CK */
+		SUNXI_FUNCTION(0x4, "r_jtag"),		/* CK */
+		SUNXI_FUNCTION(0x5, "i2s2"),		/* LRCK */
+		SUNXI_FUNCTION_IRQ_BANK(0xe, 4, 5)),
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(F, 6),
+		SUNXI_FUNCTION(0x0, "gpio_in"),
+		SUNXI_FUNCTION(0x1, "gpio_out"),
+		SUNXI_FUNCTION(0x3, "spdif"),		/* OUT */
+		SUNXI_FUNCTION(0x4, "ir"),		/* RX */
+		SUNXI_FUNCTION(0x5, "i2s2"),		/* MCLK */
+		SUNXI_FUNCTION(0x6, "pwm5"),
+		SUNXI_FUNCTION_IRQ_BANK(0xe, 4, 6)),
+	/* PG */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(G, 0),
+		SUNXI_FUNCTION(0x0, "gpio_in"),
+		SUNXI_FUNCTION(0x1, "gpio_out"),
+		SUNXI_FUNCTION(0x2, "mmc1"),		/* CLK */
+		SUNXI_FUNCTION(0x3, "uart3"),		/* TX */
+		SUNXI_FUNCTION(0x4, "emac"),		/* RXCTRL/CRS_DV */
+		SUNXI_FUNCTION(0x5, "pwm7"),
+		SUNXI_FUNCTION_IRQ_BANK(0xe, 5, 0)),
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(G, 1),
+		SUNXI_FUNCTION(0x0, "gpio_in"),
+		SUNXI_FUNCTION(0x1, "gpio_out"),
+		SUNXI_FUNCTION(0x2, "mmc1"),		/* CMD */
+		SUNXI_FUNCTION(0x3, "uart3"),		/* RX */
+		SUNXI_FUNCTION(0x4, "emac"),		/* RXD0 */
+		SUNXI_FUNCTION(0x5, "pwm6"),
+		SUNXI_FUNCTION_IRQ_BANK(0xe, 5, 1)),
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(G, 2),
+		SUNXI_FUNCTION(0x0, "gpio_in"),
+		SUNXI_FUNCTION(0x1, "gpio_out"),
+		SUNXI_FUNCTION(0x2, "mmc1"),		/* D0 */
+		SUNXI_FUNCTION(0x3, "uart3"),		/* RTS */
+		SUNXI_FUNCTION(0x4, "emac"),		/* RXD1 */
+		SUNXI_FUNCTION(0x5, "uart4"),		/* TX */
+		SUNXI_FUNCTION_IRQ_BANK(0xe, 5, 2)),
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(G, 3),
+		SUNXI_FUNCTION(0x0, "gpio_in"),
+		SUNXI_FUNCTION(0x1, "gpio_out"),
+		SUNXI_FUNCTION(0x2, "mmc1"),		/* D1 */
+		SUNXI_FUNCTION(0x3, "uart3"),		/* CTS */
+		SUNXI_FUNCTION(0x4, "emac"),		/* TXCK */
+		SUNXI_FUNCTION(0x5, "uart4"),		/* RX */
+		SUNXI_FUNCTION_IRQ_BANK(0xe, 5, 3)),
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(G, 4),
+		SUNXI_FUNCTION(0x0, "gpio_in"),
+		SUNXI_FUNCTION(0x1, "gpio_out"),
+		SUNXI_FUNCTION(0x2, "mmc1"),		/* D2 */
+		SUNXI_FUNCTION(0x3, "uart5"),		/* TX */
+		SUNXI_FUNCTION(0x4, "emac"),		/* TXD0 */
+		SUNXI_FUNCTION(0x5, "pwm5"),
+		SUNXI_FUNCTION_IRQ_BANK(0xe, 5, 4)),
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(G, 5),
+		SUNXI_FUNCTION(0x0, "gpio_in"),
+		SUNXI_FUNCTION(0x1, "gpio_out"),
+		SUNXI_FUNCTION(0x2, "mmc1"),		/* D3 */
+		SUNXI_FUNCTION(0x3, "uart5"),		/* RX */
+		SUNXI_FUNCTION(0x4, "emac"),		/* TXD1 */
+		SUNXI_FUNCTION(0x5, "pwm4"),
+		SUNXI_FUNCTION_IRQ_BANK(0xe, 5, 5)),
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(G, 6),
+		SUNXI_FUNCTION(0x0, "gpio_in"),
+		SUNXI_FUNCTION(0x1, "gpio_out"),
+		SUNXI_FUNCTION(0x2, "uart1"),		/* TX */
+		SUNXI_FUNCTION(0x3, "i2c2"),		/* SCK */
+		SUNXI_FUNCTION(0x4, "emac"),		/* TXD2 */
+		SUNXI_FUNCTION(0x5, "pwm1"),
+		SUNXI_FUNCTION_IRQ_BANK(0xe, 5, 6)),
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(G, 7),
+		SUNXI_FUNCTION(0x0, "gpio_in"),
+		SUNXI_FUNCTION(0x1, "gpio_out"),
+		SUNXI_FUNCTION(0x2, "uart1"),		/* RX */
+		SUNXI_FUNCTION(0x3, "i2c2"),		/* SDA */
+		SUNXI_FUNCTION(0x4, "emac"),		/* TXD3 */
+		SUNXI_FUNCTION(0x5, "spdif"),		/* IN */
+		SUNXI_FUNCTION_IRQ_BANK(0xe, 5, 7)),
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(G, 8),
+		SUNXI_FUNCTION(0x0, "gpio_in"),
+		SUNXI_FUNCTION(0x1, "gpio_out"),
+		SUNXI_FUNCTION(0x2, "uart1"),		/* RTS */
+		SUNXI_FUNCTION(0x3, "i2c1"),		/* SCK */
+		SUNXI_FUNCTION(0x4, "emac"),		/* RXD2 */
+		SUNXI_FUNCTION(0x5, "uart3"),		/* TX */
+		SUNXI_FUNCTION_IRQ_BANK(0xe, 5, 8)),
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(G, 9),
+		SUNXI_FUNCTION(0x0, "gpio_in"),
+		SUNXI_FUNCTION(0x1, "gpio_out"),
+		SUNXI_FUNCTION(0x2, "uart1"),		/* CTS */
+		SUNXI_FUNCTION(0x3, "i2c1"),		/* SDA */
+		SUNXI_FUNCTION(0x4, "emac"),		/* RXD3 */
+		SUNXI_FUNCTION(0x5, "uart3"),		/* RX */
+		SUNXI_FUNCTION_IRQ_BANK(0xe, 5, 9)),
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(G, 10),
+		SUNXI_FUNCTION(0x0, "gpio_in"),
+		SUNXI_FUNCTION(0x1, "gpio_out"),
+		SUNXI_FUNCTION(0x2, "pwm3"),
+		SUNXI_FUNCTION(0x3, "i2c3"),		/* SCK */
+		SUNXI_FUNCTION(0x4, "emac"),		/* RXCK */
+		SUNXI_FUNCTION(0x5, "clk"),		/* FANOUT0 */
+		SUNXI_FUNCTION(0x6, "ir"),		/* RX */
+		SUNXI_FUNCTION_IRQ_BANK(0xe, 5, 10)),
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(G, 11),
+		SUNXI_FUNCTION(0x0, "gpio_in"),
+		SUNXI_FUNCTION(0x1, "gpio_out"),
+		SUNXI_FUNCTION(0x2, "i2s1"),		/* MCLK */
+		SUNXI_FUNCTION(0x3, "i2c3"),		/* SDA */
+		SUNXI_FUNCTION(0x4, "emac"),		/* EPHY-25M */
+		SUNXI_FUNCTION(0x5, "clk"),		/* FANOUT1 */
+		SUNXI_FUNCTION(0x6, "tcon"),		/* TRIG0 */
+		SUNXI_FUNCTION_IRQ_BANK(0xe, 5, 11)),
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(G, 12),
+		SUNXI_FUNCTION(0x0, "gpio_in"),
+		SUNXI_FUNCTION(0x1, "gpio_out"),
+		SUNXI_FUNCTION(0x2, "i2s1"),		/* LRCK */
+		SUNXI_FUNCTION(0x3, "i2c0"),		/* SCK */
+		SUNXI_FUNCTION(0x4, "emac"),		/* TXCTL/TXEN */
+		SUNXI_FUNCTION(0x5, "clk"),		/* FANOUT2 */
+		SUNXI_FUNCTION(0x6, "pwm0"),
+		SUNXI_FUNCTION(0x7, "uart1"),		/* TX */
+		SUNXI_FUNCTION_IRQ_BANK(0xe, 5, 12)),
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(G, 13),
+		SUNXI_FUNCTION(0x0, "gpio_in"),
+		SUNXI_FUNCTION(0x1, "gpio_out"),
+		SUNXI_FUNCTION(0x2, "i2s1"),		/* BCLK */
+		SUNXI_FUNCTION(0x3, "i2c0"),		/* SDA */
+		SUNXI_FUNCTION(0x4, "emac"),		/* CLKIN/RXER */
+		SUNXI_FUNCTION(0x5, "pwm2"),
+		SUNXI_FUNCTION(0x6, "ledc"),
+		SUNXI_FUNCTION(0x7, "uart1"),		/* RX */
+		SUNXI_FUNCTION_IRQ_BANK(0xe, 5, 13)),
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(G, 14),
+		SUNXI_FUNCTION(0x0, "gpio_in"),
+		SUNXI_FUNCTION(0x1, "gpio_out"),
+		SUNXI_FUNCTION(0x2, "i2s1_din"),	/* DIN0 */
+		SUNXI_FUNCTION(0x3, "i2c2"),		/* SCK */
+		SUNXI_FUNCTION(0x4, "emac"),		/* MDC */
+		SUNXI_FUNCTION(0x5, "i2s1_dout"),	/* DOUT1 */
+		SUNXI_FUNCTION(0x6, "spi0"),		/* WP */
+		SUNXI_FUNCTION(0x7, "uart1"),		/* RTS */
+		SUNXI_FUNCTION_IRQ_BANK(0xe, 5, 14)),
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(G, 15),
+		SUNXI_FUNCTION(0x0, "gpio_in"),
+		SUNXI_FUNCTION(0x1, "gpio_out"),
+		SUNXI_FUNCTION(0x2, "i2s1_dout"),	/* DOUT0 */
+		SUNXI_FUNCTION(0x3, "i2c2"),		/* SDA */
+		SUNXI_FUNCTION(0x4, "emac"),		/* MDIO */
+		SUNXI_FUNCTION(0x5, "i2s1_din"),	/* DIN1 */
+		SUNXI_FUNCTION(0x6, "spi0"),		/* HOLD */
+		SUNXI_FUNCTION(0x7, "uart1"),		/* CTS */
+		SUNXI_FUNCTION_IRQ_BANK(0xe, 5, 15)),
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(G, 16),
+		SUNXI_FUNCTION(0x0, "gpio_in"),
+		SUNXI_FUNCTION(0x1, "gpio_out"),
+		SUNXI_FUNCTION(0x2, "ir"),		/* RX */
+		SUNXI_FUNCTION(0x3, "tcon"),		/* TRIG0 */
+		SUNXI_FUNCTION(0x4, "pwm5"),
+		SUNXI_FUNCTION(0x5, "clk"),		/* FANOUT2 */
+		SUNXI_FUNCTION(0x6, "spdif"),		/* IN */
+		SUNXI_FUNCTION(0x7, "ledc"),
+		SUNXI_FUNCTION_IRQ_BANK(0xe, 5, 16)),
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(G, 17),
+		SUNXI_FUNCTION(0x0, "gpio_in"),
+		SUNXI_FUNCTION(0x1, "gpio_out"),
+		SUNXI_FUNCTION(0x2, "uart2"),		/* TX */
+		SUNXI_FUNCTION(0x3, "i2c3"),		/* SCK */
+		SUNXI_FUNCTION(0x4, "pwm7"),
+		SUNXI_FUNCTION(0x5, "clk"),		/* FANOUT0 */
+		SUNXI_FUNCTION(0x6, "ir"),		/* TX */
+		SUNXI_FUNCTION(0x7, "uart0"),		/* TX */
+		SUNXI_FUNCTION_IRQ_BANK(0xe, 5, 17)),
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(G, 18),
+		SUNXI_FUNCTION(0x0, "gpio_in"),
+		SUNXI_FUNCTION(0x1, "gpio_out"),
+		SUNXI_FUNCTION(0x2, "uart2"),		/* RX */
+		SUNXI_FUNCTION(0x3, "i2c3"),		/* SDA */
+		SUNXI_FUNCTION(0x4, "pwm6"),
+		SUNXI_FUNCTION(0x5, "clk"),		/* FANOUT1 */
+		SUNXI_FUNCTION(0x6, "spdif"),		/* OUT */
+		SUNXI_FUNCTION(0x7, "uart0"),		/* RX */
+		SUNXI_FUNCTION_IRQ_BANK(0xe, 5, 18)),
+};
+
+static const unsigned int d1_irq_bank_map[] = { 1, 2, 3, 4, 5, 6 };
+
+static const struct sunxi_pinctrl_desc d1_pinctrl_data = {
+	.pins			= d1_pins,
+	.npins			= ARRAY_SIZE(d1_pins),
+	.irq_banks		= ARRAY_SIZE(d1_irq_bank_map),
+	.irq_bank_map		= d1_irq_bank_map,
+	.io_bias_cfg_variant	= BIAS_VOLTAGE_PIO_POW_MODE_CTL,
+};
+
+static int d1_pinctrl_probe(struct platform_device *pdev)
+{
+	unsigned long variant = (unsigned long)of_device_get_match_data(&pdev->dev);
+
+	return sunxi_pinctrl_init_with_variant(pdev, &d1_pinctrl_data, variant);
+}
+
+static const struct of_device_id d1_pinctrl_match[] = {
+	{
+		.compatible = "allwinner,sun20i-d1-pinctrl",
+		.data = (void *)PINCTRL_SUN20I_D1
+	},
+	{}
+};
+
+static struct platform_driver d1_pinctrl_driver = {
+	.probe	= d1_pinctrl_probe,
+	.driver	= {
+		.name		= "sun20i-d1-pinctrl",
+		.of_match_table	= d1_pinctrl_match,
+	},
+};
+builtin_platform_driver(d1_pinctrl_driver);
diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.c b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
index ec7daaa5666b..350044d4c1b5 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sunxi.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
@@ -1297,11 +1297,11 @@ static int sunxi_pinctrl_build_state(struct platform_device *pdev)
 
 	/*
 	 * Find an upper bound for the maximum number of functions: in
-	 * the worst case we have gpio_in, gpio_out, irq and up to four
+	 * the worst case we have gpio_in, gpio_out, irq and up to seven
 	 * special functions per pin, plus one entry for the sentinel.
 	 * We'll reallocate that later anyway.
 	 */
-	pctl->functions = kcalloc(4 * pctl->ngroups + 4,
+	pctl->functions = kcalloc(7 * pctl->ngroups + 4,
 				  sizeof(*pctl->functions),
 				  GFP_KERNEL);
 	if (!pctl->functions)
@@ -1494,9 +1494,15 @@ int sunxi_pinctrl_init_with_variant(struct platform_device *pdev,
 	pctl->dev = &pdev->dev;
 	pctl->desc = desc;
 	pctl->variant = variant;
-	pctl->bank_mem_size = BANK_MEM_SIZE;
-	pctl->pull_regs_offset = PULL_REGS_OFFSET;
-	pctl->dlevel_field_width = DLEVEL_FIELD_WIDTH;
+	if (pctl->variant >= PINCTRL_SUN20I_D1) {
+		pctl->bank_mem_size = D1_BANK_MEM_SIZE;
+		pctl->pull_regs_offset = D1_PULL_REGS_OFFSET;
+		pctl->dlevel_field_width = D1_DLEVEL_FIELD_WIDTH;
+	} else {
+		pctl->bank_mem_size = BANK_MEM_SIZE;
+		pctl->pull_regs_offset = PULL_REGS_OFFSET;
+		pctl->dlevel_field_width = DLEVEL_FIELD_WIDTH;
+	}
 
 	pctl->irq_array = devm_kcalloc(&pdev->dev,
 				       IRQ_PER_BANK * pctl->desc->irq_banks,
diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.h b/drivers/pinctrl/sunxi/pinctrl-sunxi.h
index c705828add73..a87a2f944d60 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sunxi.h
+++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.h
@@ -44,6 +44,10 @@
 #define PULL_REGS_OFFSET	0x1c
 #define PULL_FIELD_WIDTH	2
 
+#define D1_BANK_MEM_SIZE	0x30
+#define D1_DLEVEL_FIELD_WIDTH	4
+#define D1_PULL_REGS_OFFSET	0x24
+
 #define PINS_PER_BANK		32
 
 #define IRQ_PER_BANK		32
@@ -88,6 +92,8 @@
 #define PINCTRL_SUN8I_R40	BIT(8)
 #define PINCTRL_SUN8I_V3	BIT(9)
 #define PINCTRL_SUN8I_V3S	BIT(10)
+/* Variants below here have an updated register layout. */
+#define PINCTRL_SUN20I_D1	BIT(11)
 
 #define PIO_POW_MOD_SEL_REG	0x340
 #define PIO_POW_MOD_CTL_REG	0x344
-- 
2.35.1

