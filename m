Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 539C9572B80
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 04:53:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234095AbiGMCxJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 22:53:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233530AbiGMCw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 22:52:58 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8179D216F;
        Tue, 12 Jul 2022 19:52:46 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 579A55C017E;
        Tue, 12 Jul 2022 22:52:42 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 12 Jul 2022 22:52:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1657680762; x=1657767162; bh=85
        dYMDBxkngf3AGHqpJfPSNEwCAp/9eapLV0Ti+OS/E=; b=g5+UnNSl9hTJb6NTtt
        3VQLXbKNeZSf2QSWCWzs4le9MjWzFvPhEksLx/FiN3SikjsscMEK/xaBHN7/veRv
        48vcPIltb9pW0PnFtyB8eZqS2b5gOo93DEqYBMFe7dLUq918EcIKduHCAyhAfoXR
        AurmHua98LvvWuYJ9r8eITgEACPrrmNQl/EGR579rSvtH1DEIjAFh4GvsFi3iun1
        mFbwL52gx0uTqYMZsWaF5Vf5WKjwEayuYpxZyIZhdSunRPMNwHTHOMp6Lp1Moszl
        Bd12rmhLVEGjOXOk2FvNHjp9+LAKl9JcSicKUT7aB78e/ksOFNQi8vsRKPjZTU95
        fNew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1657680762; x=1657767162; bh=85dYMDBxkngf3
        AGHqpJfPSNEwCAp/9eapLV0Ti+OS/E=; b=RFvlKNLL7w+TC3ou5kL2cEVhZCSel
        zHgFvDYYSJZ87GsljtrYcj5BsETmKUxCs8vRw0r9E+8jGFc/vzv/PZpqVZOTFzaT
        RThRKl2+ySzCOKN4Dlg50RlkqlJFkEwq30B4sMZaZAIJT/MjY8V5GUHjyNGbF1sd
        HcdWb2VVzwv/8fHiWWt9E+yNDLfo9cv9NZbYYitxiGBmC6F//68If/woHDqD8URM
        Usfb+hHkPptuYn79Kds9qjzFd0HL1pif7AQg0J4A9hctHVtKB4/a8k5P+iDaFex8
        9641vIcF0iWIIImKr0tGqIKiDBjUjt4kbSBNBHRRtIO/oLRKG8DVqe8mQ==
X-ME-Sender: <xms:ejPOYlmN29_g-vgURmIOZu2JkVenTxaMyemRSw5cPfzbBnQ6ZwRlow>
    <xme:ejPOYg1Be1UTNdR0J97COp0rh2AeRq6BLLlUzHgpmbgbrLJRQ-Y7qiISOnsQrQLMv
    xM6BWIxacWKP1-5ug>
X-ME-Received: <xmr:ejPOYrq4SFcJLQT8BQ9ShgOXCNgzmGZHNEToRp3xodB7bYV5rXTospOtPVTJ0jKzmsdAn_-jaaDE1PSfS8nyLm_9VNossOYdXYGxceABilYhvaZnUyoxJkih_WtDf8fbFYMp7g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudejiedgieejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepudekteeuudehtdelteevgfduvddvjefhfedulefgudevgeeghefg
    udefiedtveetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:ejPOYlkvSVx5V3UAJe9YbiC6sk8nA2s0NHMUcIjJCkkp4jASde3xXg>
    <xmx:ejPOYj3jAhzj-dDPlQ19sstbm4gdjEFRquQjhA3Ds3muk-LovB-pDQ>
    <xmx:ejPOYksrhmhWiA35m5oK1hFQz3UHmJUdGaJLKS1hFLlhyFJSC45KDQ>
    <xmx:ejPOYhPqFJbdxjri0Zjoja8dtCtlESb7vGT1spTlYqzS_J6wODHosw>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Jul 2022 22:52:41 -0400 (EDT)
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
Subject: [PATCH v2 5/6] pinctrl: sunxi: Make some layout parameters dynamic
Date:   Tue, 12 Jul 2022 21:52:32 -0500
Message-Id: <20220713025233.27248-6-samuel@sholland.org>
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

Starting with the D1/D1s/T113 SoC, Allwinner changed the layout of the
pinctrl registers. This new layout widens the drive level field, which
affects the pull register offset and the overall bank size.

In order to support multiple register layouts, some of the layout
parameters need to be set based on the pinctrl variant. This requires
passing the pinctrl struct pointer to the register/offset calculation
functions.

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
Tested-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Samuel Holland <samuel@sholland.org>
---

(no changes since v1)

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

