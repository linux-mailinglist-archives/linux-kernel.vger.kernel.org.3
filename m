Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 938DE55AE36
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 04:13:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233755AbiFZCMI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 22:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233838AbiFZCMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 22:12:03 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EF7214020;
        Sat, 25 Jun 2022 19:12:02 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id B9C903200907;
        Sat, 25 Jun 2022 22:12:00 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sat, 25 Jun 2022 22:12:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1656209520; x=1656295920; bh=Vm
        kPadUXm+jNeGFZShV9Kc9gEUi6keCx3qEtbHtSObY=; b=I7x1Vz7ELq3OA26XSP
        N+Fs2X4E39/2bSpj07Zyje7oNUyXphaEQgfbW7ms+cxz64KxEvL/9MD/ZLCB48A7
        Y5xa/ohA5+kVrJfccP3jn6ZvD4EYkEBX+Y+XA7U8kBR5Q62HNPvcuD3k4rVsyAC4
        Z7R92pa+Z9cQKGsrtUEtf8G3cnx0qpVPiBAOIhNZR3FJzfZ9MdxMe7ozW0m3Epwt
        ei+5EQ6QwMs+FlxpfPb111DyH4wHC+16hH1LrpTO8XSDx5cislSUjWPbjAYXIdd5
        CwtTWgH/uT16mEIqWJmZnS9SMJrOzHWA0e1ICoF1v7GHpIk5wYfifjUZIs4HcT8Y
        +GiA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1656209520; x=1656295920; bh=VmkPadUXm+jNe
        GFZShV9Kc9gEUi6keCx3qEtbHtSObY=; b=tXTcfpyw0gAV0GyG0lwuZ5zr0SPHg
        jkcP+b7cV8T9nNDVuaD4IRnoq138EKEPt+3jdQBhB3DoCVur9JB6xMcQiET63L3c
        OaGODm9y1hrm4F75i4rltPrQtHW/poGa0qsin5twsE32Z/GobMAhGRYPC2cXGk7d
        L9P07LRBAJG3fDadRZUcvzE5ginQ6wuVv46XPvHBV8TuC9lT2equ+z0FMs0BYFHv
        yGqBZD9aE0MoPQj3kHiM65MTps3+G6KFJSFOvvsg9xlRihQvblJNIndaO2UBik+T
        pEQScuwRQArSOTKtFlzFnRg/QHOkPsvDLwz2cpv+5zcxJeV/rCwAOa2fA==
X-ME-Sender: <xms:cMC3YmggcDtJmqZNnT39L6QaejguyTZeoyKUPfY1xuVd3ROSf494ZQ>
    <xme:cMC3YnBYsWPzSddaEzc1NWH_wKUIPDHnAwLEdnhOIBz5c1G3zcW8c4bTXxfiTP11p
    w0YdpX2j2iTtj48Lg>
X-ME-Received: <xmr:cMC3YuGfl2bUsWNtdSFJV8PGbt3SC3F4ULFLrOZtvba0QDCzeR5zp-fis7nVQFJy0E5NszzkJWzTUO_r43cmrTkrlXOBF03_Xli07GJ6h8sAzNBkRastv11MyDbDRz6AxC3CiQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudegvddgheehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepudekteeuudehtdelteevgfduvddvjefhfedulefgudevgeeghefg
    udefiedtveetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:cMC3YvSkgq7gTzPx6YuI40OZYm7lSko_HyQIempakdzY7AjMSXPLJQ>
    <xmx:cMC3Yjw4B5M-b88LuI34Mr32-xeXSJeanQRTP5qE-s2cThEfI9iEIg>
    <xmx:cMC3Yt51z3aX_zIWAmosNDhtIR0_7AYKguxZMvqrMMBk-sfq40Of1w>
    <xmx:cMC3Yh68xrBWqgjyBCrR4Mkj55_Z1_woPwFgpb1YdX_U8CIYnNvK8g>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 25 Jun 2022 22:11:59 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Samuel Holland <samuel@sholland.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Ripard <mripard@kernel.org>, Ondrej Jirman <x@xff.cz>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev
Subject: [PATCH 3/6] pinctrl: sunxi: Support the 2.5V I/O bias mode
Date:   Sat, 25 Jun 2022 21:11:44 -0500
Message-Id: <20220626021148.56740-4-samuel@sholland.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220626021148.56740-1-samuel@sholland.org>
References: <20220626021148.56740-1-samuel@sholland.org>
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

H616 and newer SoCs feature a 2.5V I/O bias mode in addition to the
1.8V and 3.3V modes. This mode is entered by selecting the 3.3V level
and disabling the "withstand function".

H616 supports this capability on its main PIO only. A100 supports this
capability on both its PIO and R-PIO.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

 drivers/pinctrl/sunxi/pinctrl-sun50i-a100-r.c |  1 +
 drivers/pinctrl/sunxi/pinctrl-sun50i-a100.c   |  2 +-
 drivers/pinctrl/sunxi/pinctrl-sun50i-h616.c   |  2 +-
 drivers/pinctrl/sunxi/pinctrl-sunxi.c         | 10 ++++++++++
 drivers/pinctrl/sunxi/pinctrl-sunxi.h         |  7 +++++++
 5 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/sunxi/pinctrl-sun50i-a100-r.c b/drivers/pinctrl/sunxi/pinctrl-sun50i-a100-r.c
index 21054fcacd34..afc1f5df7545 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sun50i-a100-r.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sun50i-a100-r.c
@@ -82,6 +82,7 @@ static const struct sunxi_pinctrl_desc a100_r_pinctrl_data = {
 	.npins = ARRAY_SIZE(a100_r_pins),
 	.pin_base = PL_BASE,
 	.irq_banks = 1,
+	.io_bias_cfg_variant = BIAS_VOLTAGE_PIO_POW_MODE_CTL,
 };
 
 static int a100_r_pinctrl_probe(struct platform_device *pdev)
diff --git a/drivers/pinctrl/sunxi/pinctrl-sun50i-a100.c b/drivers/pinctrl/sunxi/pinctrl-sun50i-a100.c
index e69f6da40dc0..f682e0e4244d 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sun50i-a100.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sun50i-a100.c
@@ -684,7 +684,7 @@ static const struct sunxi_pinctrl_desc a100_pinctrl_data = {
 	.npins = ARRAY_SIZE(a100_pins),
 	.irq_banks = 7,
 	.irq_bank_map = a100_irq_bank_map,
-	.io_bias_cfg_variant = BIAS_VOLTAGE_PIO_POW_MODE_SEL,
+	.io_bias_cfg_variant = BIAS_VOLTAGE_PIO_POW_MODE_CTL,
 };
 
 static int a100_pinctrl_probe(struct platform_device *pdev)
diff --git a/drivers/pinctrl/sunxi/pinctrl-sun50i-h616.c b/drivers/pinctrl/sunxi/pinctrl-sun50i-h616.c
index 152b71226a80..d6ca720ee8d8 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sun50i-h616.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sun50i-h616.c
@@ -525,7 +525,7 @@ static const struct sunxi_pinctrl_desc h616_pinctrl_data = {
 	.irq_banks = ARRAY_SIZE(h616_irq_bank_map),
 	.irq_bank_map = h616_irq_bank_map,
 	.irq_read_needs_mux = true,
-	.io_bias_cfg_variant = BIAS_VOLTAGE_PIO_POW_MODE_SEL,
+	.io_bias_cfg_variant = BIAS_VOLTAGE_PIO_POW_MODE_CTL,
 };
 
 static int h616_pinctrl_probe(struct platform_device *pdev)
diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.c b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
index 3c5e71359ca8..eb3d595f816a 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sunxi.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
@@ -662,6 +662,16 @@ static int sunxi_pinctrl_set_io_bias_cfg(struct sunxi_pinctrl *pctl,
 		reg &= ~IO_BIAS_MASK;
 		writel(reg | val, pctl->membase + sunxi_grp_config_reg(pin));
 		return 0;
+	case BIAS_VOLTAGE_PIO_POW_MODE_CTL:
+		val = uV > 1800000 && uV <= 2500000 ? BIT(bank) : 0;
+
+		raw_spin_lock_irqsave(&pctl->lock, flags);
+		reg = readl(pctl->membase + PIO_POW_MOD_CTL_REG);
+		reg &= ~BIT(bank);
+		writel(reg | val, pctl->membase + PIO_POW_MOD_CTL_REG);
+		raw_spin_unlock_irqrestore(&pctl->lock, flags);
+
+		fallthrough;
 	case BIAS_VOLTAGE_PIO_POW_MODE_SEL:
 		val = uV <= 1800000 ? 1 : 0;
 
diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.h b/drivers/pinctrl/sunxi/pinctrl-sunxi.h
index a32bb5bcb754..0f1aab58650c 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sunxi.h
+++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.h
@@ -98,6 +98,7 @@
 #define PINCTRL_SUN8I_V3S	BIT(10)
 
 #define PIO_POW_MOD_SEL_REG	0x340
+#define PIO_POW_MOD_CTL_REG	0x344
 
 enum sunxi_desc_bias_voltage {
 	BIAS_VOLTAGE_NONE,
@@ -111,6 +112,12 @@ enum sunxi_desc_bias_voltage {
 	 * register, as seen on H6 SoC, for example.
 	 */
 	BIAS_VOLTAGE_PIO_POW_MODE_SEL,
+	/*
+	 * Bias voltage is set through PIO_POW_MOD_SEL_REG
+	 * and PIO_POW_MOD_CTL_REG register, as seen on
+	 * A100 and D1 SoC, for example.
+	 */
+	BIAS_VOLTAGE_PIO_POW_MODE_CTL,
 };
 
 struct sunxi_desc_function {
-- 
2.35.1

