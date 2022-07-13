Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68837572B83
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 04:53:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233871AbiGMCxC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 22:53:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232590AbiGMCwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 22:52:50 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D77B7D217A;
        Tue, 12 Jul 2022 19:52:40 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 386A25C0183;
        Tue, 12 Jul 2022 22:52:40 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 12 Jul 2022 22:52:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1657680760; x=1657767160; bh=Yc
        Qr5Z6M9BzyqkqmIJpel5Xs5U1LXNzbiUWZWi3PC6s=; b=SzwLfnGgbzzI6z9tBB
        EyHLdYUNKurpEOu4OF0u3CANe1LOyRBzw5uxBNNGlDOC8Ucees1P0iOyd7OQ/Luj
        7w+LQaZL4Zs2PVk3WNF7NVwWB3QEZk7P8Qnd9Qn0s+6iQKmB4zxuApoJREWkCpPx
        bKoUCYhc/d4FLKs9UI5Y/fApRtGu4pEyCQVx7drZO+v9IXoEIII5I1OkzKHVL2E3
        GWcMulMBPqOE7xjnQqrY/rNEXVeLL7sm25xb04ChkSmLIr0/XTAA67Hi6Kt4ARaj
        jiBd24RM022KM/6GnUmYQYS2A4YoFjjTROq1iYqonzRb5xa/CHQbPoJWDG/1JC8k
        FqXg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1657680760; x=1657767160; bh=YcQr5Z6M9Bzyq
        kqmIJpel5Xs5U1LXNzbiUWZWi3PC6s=; b=a2c2Px/851BKI0lY0B/T/rlt3APJM
        AAydQNNYl1HBkTyNPgKeaVIj1GcLl+pmHc/VA788OypbkHzaMiXRywuvzj8x2HJR
        vEdFYUSbcvDqkiz8AqAcnkDYLWSPeBygmOvF1dw2qTdmSCgJY9zIOrIII6ImLYY9
        UjEEEdqqhCmuNxWUGjZeV5Nr/buPJl1/TwqM5huCdYfXrTJ3WIVQKmOBe6cP8P18
        1VNLjnNWUl8ZfWc2P/dLXRF5U37+tesLU9jTYBt8pZ0HU+Co6tL+mCsIhtksh/4E
        89IPJObTV15qjLpVGXxj5Fyj3P+ZxYK9ImeRYJOpMGgjMG9oOA8EMs0/g==
X-ME-Sender: <xms:eDPOYj0VnUWt1TC35zUyNs1LN28Hej_otJGQ3rATXd1yJ8YHGAiAzA>
    <xme:eDPOYiH1KIdZnUjw0SXPNh2kkz51wEEWoHox-2dTpXXzfvmgCyEYFAM2q8gX5Id19
    u20SlbGaCQAHe_5oA>
X-ME-Received: <xmr:eDPOYj5deOgnBpwRD_7rCikxT_Nt-QeGJ7zvJsbSHN2n3HzVbZ1MZSYEBlJyAcF_StxBssEyCUDA__Qq9Mi6s3Mem4k8FCjnzkAExnN2KgB5gftL6yNb1bI5FUDFt-cV3f1itA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudejiedgieejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepudekteeuudehtdelteevgfduvddvjefhfedulefgudevgeeghefg
    udefiedtveetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:eDPOYo3TEB0bXGmaNI8uesFaQysEqKtz37gbWIuHJYZoLfVnyDxi3Q>
    <xmx:eDPOYmGFegZLS2RzOS2uCz0ab6vROq-b5C0kMA5s4tdMc_e6x0XU3A>
    <xmx:eDPOYp-MUmp1Hh1stJhlM5KMCK9-vBKo5wLotgnzlWeDXkmX0Hz4BQ>
    <xmx:eDPOYteLV4uBSKyZiCIZGgYQO0TLNS88oJyuwj5Pvh0xxlDKGknrNQ>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Jul 2022 22:52:39 -0400 (EDT)
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
Subject: [PATCH v2 3/6] pinctrl: sunxi: Support the 2.5V I/O bias mode
Date:   Tue, 12 Jul 2022 21:52:30 -0500
Message-Id: <20220713025233.27248-4-samuel@sholland.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220713025233.27248-1-samuel@sholland.org>
References: <20220713025233.27248-1-samuel@sholland.org>
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

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>
Tested-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Samuel Holland <samuel@sholland.org>
---

(no changes since v1)

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

