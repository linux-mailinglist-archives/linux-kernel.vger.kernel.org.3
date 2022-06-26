Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EDBD55AE28
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 04:12:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233865AbiFZCMR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 22:12:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233779AbiFZCMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 22:12:09 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B91113E8A;
        Sat, 25 Jun 2022 19:12:08 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 8E1AC3200907;
        Sat, 25 Jun 2022 22:12:06 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sat, 25 Jun 2022 22:12:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1656209526; x=1656295926; bh=Ie
        2shZlqbF9ISooi+Z6UgE2fom/hcX9G2fRtGnU+A3U=; b=V9eXtb011o+1WFKvFT
        onpqFAcGaCGQY9jqhgiVfftAXPASDjDgxaK/P4SXGUe2NlGoxfCix4PYjFQzW3Zx
        X9p1YLQZSzT6XddJU1BH5jblnC1QPUV1cXY/WhP9FKw50bIcXj8xuJqa9NB919vr
        tvPf2nn5MyZw1zy+Pp0oPUDAuxYeiQz4Nn46Zxa4gBFo+BUdyJLCibDbatzZ9qPL
        2AGmA3x3+tQf3iV9GHzeg6waBADwvYXXLtHM2b9sUuclPYuO8TgH0PWL7MVI0lIQ
        nlxHXgUikn4vbQgsL03H4vJl5DjjsBfpEZLgRhPBU9viG6GxxGMRl83biPiO2E3y
        qS+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1656209526; x=1656295926; bh=Ie2shZlqbF9IS
        ooi+Z6UgE2fom/hcX9G2fRtGnU+A3U=; b=lagbhV0XP22XozSMb8sBJo3Y3Lb4+
        2nTiMfBuSQbnuZX6j21VuNjekCGX8MQ3XiHTABzTsH1fVX/QdLcmL69VX8zT1Jfx
        825/JDJ0anzbVfYAThEEaP3ozjIrzZw95LrufXuhIPOJiyk4mUyZTzO0M9YqBPy1
        JQH/bG/Dwj9pi0mHSxuExku3fjfLWeE1Joshmmu+2SB0F52ypuvjivrM/b28/BRs
        rXE+vsN4qV4HtSJoMbkidYdFBkIlIQc3KrPBJ0kDgd/SMh+XcSmRqyPrj8j5dWLh
        TCeA/Bx3sbEYMFBsbGbC4V+A8MGAjATQU8RRmDvc0TaLnH0L5sUd9ogUg==
X-ME-Sender: <xms:dcC3YorUuWgMSkZ9YL5u_9yJMSkohQTzit6R5cuUN-pfhEhM5_zyFw>
    <xme:dcC3YuqWQW8XJzYdJeO7QTWrvavTfgETl8emYD2X5YW6C-386HtuBO0BmV5P9zfwz
    gxChXVvh21pZ75CEw>
X-ME-Received: <xmr:dcC3YtPVm09iIEkTzximD9oz_Q_WZJAiX00Uj0ORq3ntPSMnbaCZKUnfP_ywpIoPOnpsCG8ADD431rJ1B8nPBQJus3eYMkSey_0j8R0_-FmV1VU7CQ6ZA6xBkodWQttrL0BEKA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudegvddgheehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepudekteeuudehtdelteevgfduvddvjefhfedulefgudevgeeghefg
    udefiedtveetnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrh
    homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:dcC3Yv4I3URwb_9s6Yi9UbbKJyjCeh79dwQBzTLeuqbN50F2pJcpHQ>
    <xmx:dcC3Yn7MnLJ5TMZddSM7wT6oF6oHUgeodRu1B5vY_m0Um_dWqKbAiQ>
    <xmx:dcC3YvjhijWPu5sr5IapcbSeVcUhX0GYE_7rp6Wv3vL13h8x5l_uKA>
    <xmx:dsC3Yrhi_VB51nzYWRWWGmLIavuNd9Sdb2BDEnpaYN0aFOye_54pDw>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 25 Jun 2022 22:12:05 -0400 (EDT)
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
Subject: [PATCH 5/6] pinctrl: sunxi: Make some layout parameters dynamic
Date:   Sat, 25 Jun 2022 21:11:46 -0500
Message-Id: <20220626021148.56740-6-samuel@sholland.org>
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

Starting with the D1/D1s/T113 SoC, Allwinner changed the layout of the
pinctrl registers. This new layout widens the drive level field, which
affects the pull register offset and the overall bank size.

In order to support multiple register layouts, some of the layout
parameters need to be set based on the pinctrl variant. This requires
passing the pinctrl struct pointer to the register/offset calculation
functions.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

 drivers/pinctrl/sunxi/pinctrl-sunxi.c | 44 ++++++++++++++++-----------
 drivers/pinctrl/sunxi/pinctrl-sunxi.h |  3 ++
 2 files changed, 29 insertions(+), 18 deletions(-)

diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.c b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
index 78b7ab69d7a5..ec7daaa5666b 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sunxi.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
@@ -59,45 +59,49 @@ static struct irq_chip sunxi_pinctrl_level_irq_chip;
  * The following functions calculate the register and the bit offset to access.
  * They take a pin number which is relative to the start of the current device.
  */
-static void sunxi_mux_reg(u32 pin, u32 *reg, u32 *shift, u32 *mask)
+static void sunxi_mux_reg(const struct sunxi_pinctrl *pctl,
+			  u32 pin, u32 *reg, u32 *shift, u32 *mask)
 {
 	u32 bank   = pin / PINS_PER_BANK;
 	u32 offset = pin % PINS_PER_BANK * MUX_FIELD_WIDTH;
 
-	*reg   = bank * BANK_MEM_SIZE + MUX_REGS_OFFSET +
+	*reg   = bank * pctl->bank_mem_size + MUX_REGS_OFFSET +
 		 offset / BITS_PER_TYPE(u32) * sizeof(u32);
 	*shift = offset % BITS_PER_TYPE(u32);
 	*mask  = (BIT(MUX_FIELD_WIDTH) - 1) << *shift;
 }
 
-static void sunxi_data_reg(u32 pin, u32 *reg, u32 *shift, u32 *mask)
+static void sunxi_data_reg(const struct sunxi_pinctrl *pctl,
+			   u32 pin, u32 *reg, u32 *shift, u32 *mask)
 {
 	u32 bank   = pin / PINS_PER_BANK;
 	u32 offset = pin % PINS_PER_BANK * DATA_FIELD_WIDTH;
 
-	*reg   = bank * BANK_MEM_SIZE + DATA_REGS_OFFSET +
+	*reg   = bank * pctl->bank_mem_size + DATA_REGS_OFFSET +
 		 offset / BITS_PER_TYPE(u32) * sizeof(u32);
 	*shift = offset % BITS_PER_TYPE(u32);
 	*mask  = (BIT(DATA_FIELD_WIDTH) - 1) << *shift;
 }
 
-static void sunxi_dlevel_reg(u32 pin, u32 *reg, u32 *shift, u32 *mask)
+static void sunxi_dlevel_reg(const struct sunxi_pinctrl *pctl,
+			     u32 pin, u32 *reg, u32 *shift, u32 *mask)
 {
 	u32 bank   = pin / PINS_PER_BANK;
-	u32 offset = pin % PINS_PER_BANK * DLEVEL_FIELD_WIDTH;
+	u32 offset = pin % PINS_PER_BANK * pctl->dlevel_field_width;
 
-	*reg   = bank * BANK_MEM_SIZE + DLEVEL_REGS_OFFSET +
+	*reg   = bank * pctl->bank_mem_size + DLEVEL_REGS_OFFSET +
 		 offset / BITS_PER_TYPE(u32) * sizeof(u32);
 	*shift = offset % BITS_PER_TYPE(u32);
-	*mask  = (BIT(DLEVEL_FIELD_WIDTH) - 1) << *shift;
+	*mask  = (BIT(pctl->dlevel_field_width) - 1) << *shift;
 }
 
-static void sunxi_pull_reg(u32 pin, u32 *reg, u32 *shift, u32 *mask)
+static void sunxi_pull_reg(const struct sunxi_pinctrl *pctl,
+			   u32 pin, u32 *reg, u32 *shift, u32 *mask)
 {
 	u32 bank   = pin / PINS_PER_BANK;
 	u32 offset = pin % PINS_PER_BANK * PULL_FIELD_WIDTH;
 
-	*reg   = bank * BANK_MEM_SIZE + PULL_REGS_OFFSET +
+	*reg   = bank * pctl->bank_mem_size + pctl->pull_regs_offset +
 		 offset / BITS_PER_TYPE(u32) * sizeof(u32);
 	*shift = offset % BITS_PER_TYPE(u32);
 	*mask  = (BIT(PULL_FIELD_WIDTH) - 1) << *shift;
@@ -508,18 +512,19 @@ static const struct pinctrl_ops sunxi_pctrl_ops = {
 	.get_group_pins		= sunxi_pctrl_get_group_pins,
 };
 
-static int sunxi_pconf_reg(unsigned pin, enum pin_config_param param,
+static int sunxi_pconf_reg(const struct sunxi_pinctrl *pctl,
+			   u32 pin, enum pin_config_param param,
 			   u32 *reg, u32 *shift, u32 *mask)
 {
 	switch (param) {
 	case PIN_CONFIG_DRIVE_STRENGTH:
-		sunxi_dlevel_reg(pin, reg, shift, mask);
+		sunxi_dlevel_reg(pctl, pin, reg, shift, mask);
 		break;
 
 	case PIN_CONFIG_BIAS_PULL_UP:
 	case PIN_CONFIG_BIAS_PULL_DOWN:
 	case PIN_CONFIG_BIAS_DISABLE:
-		sunxi_pull_reg(pin, reg, shift, mask);
+		sunxi_pull_reg(pctl, pin, reg, shift, mask);
 		break;
 
 	default:
@@ -540,7 +545,7 @@ static int sunxi_pconf_get(struct pinctrl_dev *pctldev, unsigned pin,
 
 	pin -= pctl->desc->pin_base;
 
-	ret = sunxi_pconf_reg(pin, param, &reg, &shift, &mask);
+	ret = sunxi_pconf_reg(pctl, pin, param, &reg, &shift, &mask);
 	if (ret < 0)
 		return ret;
 
@@ -606,7 +611,7 @@ static int sunxi_pconf_set(struct pinctrl_dev *pctldev, unsigned pin,
 		param = pinconf_to_config_param(configs[i]);
 		arg = pinconf_to_config_argument(configs[i]);
 
-		ret = sunxi_pconf_reg(pin, param, &reg, &shift, &mask);
+		ret = sunxi_pconf_reg(pctl, pin, param, &reg, &shift, &mask);
 		if (ret < 0)
 			return ret;
 
@@ -774,7 +779,7 @@ static void sunxi_pmx_set(struct pinctrl_dev *pctldev,
 	unsigned long flags;
 
 	pin -= pctl->desc->pin_base;
-	sunxi_mux_reg(pin, &reg, &shift, &mask);
+	sunxi_mux_reg(pctl, pin, &reg, &shift, &mask);
 
 	raw_spin_lock_irqsave(&pctl->lock, flags);
 
@@ -917,7 +922,7 @@ static int sunxi_pinctrl_gpio_get(struct gpio_chip *chip, unsigned offset)
 	u32 pin = offset + chip->base;
 	u32 reg, shift, mask, val;
 
-	sunxi_data_reg(offset, &reg, &shift, &mask);
+	sunxi_data_reg(pctl, offset, &reg, &shift, &mask);
 
 	if (set_mux)
 		sunxi_pmx_set(pctl->pctl_dev, pin, SUN4I_FUNC_INPUT);
@@ -937,7 +942,7 @@ static void sunxi_pinctrl_gpio_set(struct gpio_chip *chip,
 	u32 reg, shift, mask, val;
 	unsigned long flags;
 
-	sunxi_data_reg(offset, &reg, &shift, &mask);
+	sunxi_data_reg(pctl, offset, &reg, &shift, &mask);
 
 	raw_spin_lock_irqsave(&pctl->lock, flags);
 
@@ -1489,6 +1494,9 @@ int sunxi_pinctrl_init_with_variant(struct platform_device *pdev,
 	pctl->dev = &pdev->dev;
 	pctl->desc = desc;
 	pctl->variant = variant;
+	pctl->bank_mem_size = BANK_MEM_SIZE;
+	pctl->pull_regs_offset = PULL_REGS_OFFSET;
+	pctl->dlevel_field_width = DLEVEL_FIELD_WIDTH;
 
 	pctl->irq_array = devm_kcalloc(&pdev->dev,
 				       IRQ_PER_BANK * pctl->desc->irq_banks,
diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.h b/drivers/pinctrl/sunxi/pinctrl-sunxi.h
index efaa97457e08..c705828add73 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sunxi.h
+++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.h
@@ -169,6 +169,9 @@ struct sunxi_pinctrl {
 	raw_spinlock_t			lock;
 	struct pinctrl_dev		*pctl_dev;
 	unsigned long			variant;
+	u32				bank_mem_size;
+	u32				pull_regs_offset;
+	u32				dlevel_field_width;
 };
 
 #define SUNXI_PIN(_pin, ...)					\
-- 
2.35.1

