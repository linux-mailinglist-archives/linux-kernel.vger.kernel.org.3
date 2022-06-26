Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3EB655AE2D
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 04:13:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233852AbiFZCMO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 22:12:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233853AbiFZCMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 22:12:06 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D5C313E8A;
        Sat, 25 Jun 2022 19:12:05 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id A3FA632000D9;
        Sat, 25 Jun 2022 22:12:03 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Sat, 25 Jun 2022 22:12:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1656209523; x=1656295923; bh=iV
        4OBHrYXn/FWupxdvHmXi2SF1JXob3kc0nH3FmmoBg=; b=IweKyLONzzr/Tw7aNe
        utNxVZQ2qxM4M3a21pssBuxBvLYY1pnfliHackuXLiGV81hoVkDjAI/BRw9TktN3
        N4ZBAI3e7PZ/dMWHjwe+I6LgVT0WEB1w/JzynKm2SzDtb/FPTW+chK14o6NBXcA2
        uUK+E0BQOqJMWLn48HAoV6n+d9/TKf3CjvZHYUzDoISDBMJUWQBUH3hyoHiRVJIU
        1CDjbpuG4WENPw3yWc5ndpKzHw/PyKYxeFTJyBtaGgB4ElzQQHIIsoZC/AQNxHi9
        6wqmxk5Dt44nIEYW1j2jM5juHEre929zyWQ3skhDdJmhKyq9XF47rU7p/wVFyLTm
        P1Rw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1656209523; x=1656295923; bh=iV4OBHrYXn/FW
        upxdvHmXi2SF1JXob3kc0nH3FmmoBg=; b=viv+tlhG+89Fs1IWMAvxjrlkhWuy+
        Egk/RqLI3Eb3ciqSebDrnsTqfNeCkYX2AxP+i0GU2m5Mw3HfA4lqrDM4j9mks1e8
        H5x+MTrT00R0ntY1D7MmpHJc0dMRDSTMSCUTOJQ6o+spKQsP8glfgFg4wyRWYRum
        oojnq9Vio+LVSgDIhDH4X3CIPFENCN/KvcOtZHEAsd6R8kxJg6KJHNTLXvldTgyq
        VRy1AotGf+WZUcLv5ujy+2gF72YtyeiDl79waP4r+xIO4JcynbSlAl23Z8E7TsyC
        4ZhuTk3LScSeOOfnxQUlBExP0qylxCSNNWtFAFrAFpyvfXPRbdfdr40AA==
X-ME-Sender: <xms:c8C3Yvi31DliaRJp2F78zuWNBX3EbqIFZ_gRw1gZ1HG6UrAkPBi_FQ>
    <xme:c8C3YsBAca0jYczQJdoz3VVRsOlsTOFkBVCV-BEIMBm0gm854_ekdaQBVW4L4Y2uz
    eDA9wB9s_x5CQ7JgA>
X-ME-Received: <xmr:c8C3YvFpxcHY5z_zJLflacbFBNMOitT8SRXb3gBoiQL-XcaMw8aXdHwbakFk2F2Bk7rsKZAfnKguPLWBi2YI_pMSeF-fd7A3U_OqMbW-pFGFeuNBch0ivXb9wofqerPwVi_Nww>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudegvddgheeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepudekteeuudehtdelteevgfduvddvjefhfedulefgudevgeeghefg
    udefiedtveetnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrh
    homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:c8C3YsQNTMsqH_SeUIHIRa2JsH5ssApRswAxAdnTs_dQYFg0UgfI1A>
    <xmx:c8C3Ysy4s8ih7wJpo54Or4dwS8NTlkCmRcd1O1z9uTzhCKO9MD66Zw>
    <xmx:c8C3Yi6Tg7Ectle3ifMLIVHay0tKEzj2jxpIIWpHMSPHAogh-ZDq6Q>
    <xmx:c8C3Ym7N_Eh7tnnhbinzmc-eg2MEpE3WMxjG1q5EYw2eOUrLYk1VAA>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 25 Jun 2022 22:12:02 -0400 (EDT)
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
Subject: [PATCH 4/6] pinctrl: sunxi: Refactor register/offset calculation
Date:   Sat, 25 Jun 2022 21:11:45 -0500
Message-Id: <20220626021148.56740-5-samuel@sholland.org>
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

As a first step to support this, combine the register and offset
calculation functions, and refactor the math to depend on one constant
for field widths instead of three. This minimizes the code size impact
of making some of the factors dynamic.

While rewriting these functions, move them to the implementation file,
since that is the only file where they are used. And make the comment
more generic, without mentioning specific offsets/sizes.

The callers are updated to expect a shifted mask, and to use consistent
terminology (reg/shift/mask/val).

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

 drivers/pinctrl/sunxi/pinctrl-sunxi.c | 119 ++++++++++++++++++--------
 drivers/pinctrl/sunxi/pinctrl-sunxi.h |  93 +-------------------
 2 files changed, 89 insertions(+), 123 deletions(-)

diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.c b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
index eb3d595f816a..78b7ab69d7a5 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sunxi.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
@@ -46,6 +46,63 @@ static struct lock_class_key sunxi_pinctrl_irq_request_class;
 static struct irq_chip sunxi_pinctrl_edge_irq_chip;
 static struct irq_chip sunxi_pinctrl_level_irq_chip;
 
+/*
+ * The sunXi PIO registers are organized as a series of banks, with registers
+ * for each bank in the following order:
+ *  - Mux config
+ *  - Data value
+ *  - Drive level
+ *  - Pull direction
+ *
+ * Multiple consecutive registers are used for fields wider than one bit.
+ *
+ * The following functions calculate the register and the bit offset to access.
+ * They take a pin number which is relative to the start of the current device.
+ */
+static void sunxi_mux_reg(u32 pin, u32 *reg, u32 *shift, u32 *mask)
+{
+	u32 bank   = pin / PINS_PER_BANK;
+	u32 offset = pin % PINS_PER_BANK * MUX_FIELD_WIDTH;
+
+	*reg   = bank * BANK_MEM_SIZE + MUX_REGS_OFFSET +
+		 offset / BITS_PER_TYPE(u32) * sizeof(u32);
+	*shift = offset % BITS_PER_TYPE(u32);
+	*mask  = (BIT(MUX_FIELD_WIDTH) - 1) << *shift;
+}
+
+static void sunxi_data_reg(u32 pin, u32 *reg, u32 *shift, u32 *mask)
+{
+	u32 bank   = pin / PINS_PER_BANK;
+	u32 offset = pin % PINS_PER_BANK * DATA_FIELD_WIDTH;
+
+	*reg   = bank * BANK_MEM_SIZE + DATA_REGS_OFFSET +
+		 offset / BITS_PER_TYPE(u32) * sizeof(u32);
+	*shift = offset % BITS_PER_TYPE(u32);
+	*mask  = (BIT(DATA_FIELD_WIDTH) - 1) << *shift;
+}
+
+static void sunxi_dlevel_reg(u32 pin, u32 *reg, u32 *shift, u32 *mask)
+{
+	u32 bank   = pin / PINS_PER_BANK;
+	u32 offset = pin % PINS_PER_BANK * DLEVEL_FIELD_WIDTH;
+
+	*reg   = bank * BANK_MEM_SIZE + DLEVEL_REGS_OFFSET +
+		 offset / BITS_PER_TYPE(u32) * sizeof(u32);
+	*shift = offset % BITS_PER_TYPE(u32);
+	*mask  = (BIT(DLEVEL_FIELD_WIDTH) - 1) << *shift;
+}
+
+static void sunxi_pull_reg(u32 pin, u32 *reg, u32 *shift, u32 *mask)
+{
+	u32 bank   = pin / PINS_PER_BANK;
+	u32 offset = pin % PINS_PER_BANK * PULL_FIELD_WIDTH;
+
+	*reg   = bank * BANK_MEM_SIZE + PULL_REGS_OFFSET +
+		 offset / BITS_PER_TYPE(u32) * sizeof(u32);
+	*shift = offset % BITS_PER_TYPE(u32);
+	*mask  = (BIT(PULL_FIELD_WIDTH) - 1) << *shift;
+}
+
 static struct sunxi_pinctrl_group *
 sunxi_pinctrl_find_group_by_name(struct sunxi_pinctrl *pctl, const char *group)
 {
@@ -452,21 +509,17 @@ static const struct pinctrl_ops sunxi_pctrl_ops = {
 };
 
 static int sunxi_pconf_reg(unsigned pin, enum pin_config_param param,
-			   u32 *offset, u32 *shift, u32 *mask)
+			   u32 *reg, u32 *shift, u32 *mask)
 {
 	switch (param) {
 	case PIN_CONFIG_DRIVE_STRENGTH:
-		*offset = sunxi_dlevel_reg(pin);
-		*shift = sunxi_dlevel_offset(pin);
-		*mask = DLEVEL_PINS_MASK;
+		sunxi_dlevel_reg(pin, reg, shift, mask);
 		break;
 
 	case PIN_CONFIG_BIAS_PULL_UP:
 	case PIN_CONFIG_BIAS_PULL_DOWN:
 	case PIN_CONFIG_BIAS_DISABLE:
-		*offset = sunxi_pull_reg(pin);
-		*shift = sunxi_pull_offset(pin);
-		*mask = PULL_PINS_MASK;
+		sunxi_pull_reg(pin, reg, shift, mask);
 		break;
 
 	default:
@@ -481,17 +534,17 @@ static int sunxi_pconf_get(struct pinctrl_dev *pctldev, unsigned pin,
 {
 	struct sunxi_pinctrl *pctl = pinctrl_dev_get_drvdata(pctldev);
 	enum pin_config_param param = pinconf_to_config_param(*config);
-	u32 offset, shift, mask, val;
+	u32 reg, shift, mask, val;
 	u16 arg;
 	int ret;
 
 	pin -= pctl->desc->pin_base;
 
-	ret = sunxi_pconf_reg(pin, param, &offset, &shift, &mask);
+	ret = sunxi_pconf_reg(pin, param, &reg, &shift, &mask);
 	if (ret < 0)
 		return ret;
 
-	val = (readl(pctl->membase + offset) >> shift) & mask;
+	val = (readl(pctl->membase + reg) & mask) >> shift;
 
 	switch (pinconf_to_config_param(*config)) {
 	case PIN_CONFIG_DRIVE_STRENGTH:
@@ -545,16 +598,15 @@ static int sunxi_pconf_set(struct pinctrl_dev *pctldev, unsigned pin,
 	int i;
 
 	for (i = 0; i < num_configs; i++) {
+		u32 arg, reg, shift, mask, val;
 		enum pin_config_param param;
 		unsigned long flags;
-		u32 offset, shift, mask, reg;
-		u32 arg, val;
 		int ret;
 
 		param = pinconf_to_config_param(configs[i]);
 		arg = pinconf_to_config_argument(configs[i]);
 
-		ret = sunxi_pconf_reg(pin, param, &offset, &shift, &mask);
+		ret = sunxi_pconf_reg(pin, param, &reg, &shift, &mask);
 		if (ret < 0)
 			return ret;
 
@@ -591,9 +643,8 @@ static int sunxi_pconf_set(struct pinctrl_dev *pctldev, unsigned pin,
 		}
 
 		raw_spin_lock_irqsave(&pctl->lock, flags);
-		reg = readl(pctl->membase + offset);
-		reg &= ~(mask << shift);
-		writel(reg | val << shift, pctl->membase + offset);
+		writel((readl(pctl->membase + reg) & ~mask) | val << shift,
+		       pctl->membase + reg);
 		raw_spin_unlock_irqrestore(&pctl->lock, flags);
 	} /* for each config */
 
@@ -719,16 +770,16 @@ static void sunxi_pmx_set(struct pinctrl_dev *pctldev,
 				 u8 config)
 {
 	struct sunxi_pinctrl *pctl = pinctrl_dev_get_drvdata(pctldev);
+	u32 reg, shift, mask;
 	unsigned long flags;
-	u32 val, mask;
+
+	pin -= pctl->desc->pin_base;
+	sunxi_mux_reg(pin, &reg, &shift, &mask);
 
 	raw_spin_lock_irqsave(&pctl->lock, flags);
 
-	pin -= pctl->desc->pin_base;
-	val = readl(pctl->membase + sunxi_mux_reg(pin));
-	mask = MUX_PINS_MASK << sunxi_mux_offset(pin);
-	writel((val & ~mask) | config << sunxi_mux_offset(pin),
-		pctl->membase + sunxi_mux_reg(pin));
+	writel((readl(pctl->membase + reg) & ~mask) | config << shift,
+	       pctl->membase + reg);
 
 	raw_spin_unlock_irqrestore(&pctl->lock, flags);
 }
@@ -861,43 +912,43 @@ static int sunxi_pinctrl_gpio_direction_input(struct gpio_chip *chip,
 static int sunxi_pinctrl_gpio_get(struct gpio_chip *chip, unsigned offset)
 {
 	struct sunxi_pinctrl *pctl = gpiochip_get_data(chip);
-	u32 reg = sunxi_data_reg(offset);
-	u8 index = sunxi_data_offset(offset);
 	bool set_mux = pctl->desc->irq_read_needs_mux &&
 		gpiochip_line_is_irq(chip, offset);
 	u32 pin = offset + chip->base;
-	u32 val;
+	u32 reg, shift, mask, val;
+
+	sunxi_data_reg(offset, &reg, &shift, &mask);
 
 	if (set_mux)
 		sunxi_pmx_set(pctl->pctl_dev, pin, SUN4I_FUNC_INPUT);
 
-	val = (readl(pctl->membase + reg) >> index) & DATA_PINS_MASK;
+	val = (readl(pctl->membase + reg) & mask) >> shift;
 
 	if (set_mux)
 		sunxi_pmx_set(pctl->pctl_dev, pin, SUN4I_FUNC_IRQ);
 
-	return !!val;
+	return val;
 }
 
 static void sunxi_pinctrl_gpio_set(struct gpio_chip *chip,
 				unsigned offset, int value)
 {
 	struct sunxi_pinctrl *pctl = gpiochip_get_data(chip);
-	u32 reg = sunxi_data_reg(offset);
-	u8 index = sunxi_data_offset(offset);
+	u32 reg, shift, mask, val;
 	unsigned long flags;
-	u32 regval;
+
+	sunxi_data_reg(offset, &reg, &shift, &mask);
 
 	raw_spin_lock_irqsave(&pctl->lock, flags);
 
-	regval = readl(pctl->membase + reg);
+	val = readl(pctl->membase + reg);
 
 	if (value)
-		regval |= BIT(index);
+		val |= mask;
 	else
-		regval &= ~(BIT(index));
+		val &= ~mask;
 
-	writel(regval, pctl->membase + reg);
+	writel(val, pctl->membase + reg);
 
 	raw_spin_unlock_irqrestore(&pctl->lock, flags);
 }
diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.h b/drivers/pinctrl/sunxi/pinctrl-sunxi.h
index 0f1aab58650c..efaa97457e08 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sunxi.h
+++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.h
@@ -36,23 +36,15 @@
 
 #define BANK_MEM_SIZE		0x24
 #define MUX_REGS_OFFSET		0x0
+#define MUX_FIELD_WIDTH		4
 #define DATA_REGS_OFFSET	0x10
+#define DATA_FIELD_WIDTH	1
 #define DLEVEL_REGS_OFFSET	0x14
+#define DLEVEL_FIELD_WIDTH	2
 #define PULL_REGS_OFFSET	0x1c
+#define PULL_FIELD_WIDTH	2
 
 #define PINS_PER_BANK		32
-#define MUX_PINS_PER_REG	8
-#define MUX_PINS_BITS		4
-#define MUX_PINS_MASK		0x0f
-#define DATA_PINS_PER_REG	32
-#define DATA_PINS_BITS		1
-#define DATA_PINS_MASK		0x01
-#define DLEVEL_PINS_PER_REG	16
-#define DLEVEL_PINS_BITS	2
-#define DLEVEL_PINS_MASK	0x03
-#define PULL_PINS_PER_REG	16
-#define PULL_PINS_BITS		2
-#define PULL_PINS_MASK		0x03
 
 #define IRQ_PER_BANK		32
 
@@ -222,83 +214,6 @@ struct sunxi_pinctrl {
 		.irqnum = _irq,					\
 	}
 
-/*
- * The sunXi PIO registers are organized as is:
- * 0x00 - 0x0c	Muxing values.
- *		8 pins per register, each pin having a 4bits value
- * 0x10		Pin values
- *		32 bits per register, each pin corresponding to one bit
- * 0x14 - 0x18	Drive level
- *		16 pins per register, each pin having a 2bits value
- * 0x1c - 0x20	Pull-Up values
- *		16 pins per register, each pin having a 2bits value
- *
- * This is for the first bank. Each bank will have the same layout,
- * with an offset being a multiple of 0x24.
- *
- * The following functions calculate from the pin number the register
- * and the bit offset that we should access.
- */
-static inline u32 sunxi_mux_reg(u16 pin)
-{
-	u8 bank = pin / PINS_PER_BANK;
-	u32 offset = bank * BANK_MEM_SIZE;
-	offset += MUX_REGS_OFFSET;
-	offset += pin % PINS_PER_BANK / MUX_PINS_PER_REG * 0x04;
-	return round_down(offset, 4);
-}
-
-static inline u32 sunxi_mux_offset(u16 pin)
-{
-	u32 pin_num = pin % MUX_PINS_PER_REG;
-	return pin_num * MUX_PINS_BITS;
-}
-
-static inline u32 sunxi_data_reg(u16 pin)
-{
-	u8 bank = pin / PINS_PER_BANK;
-	u32 offset = bank * BANK_MEM_SIZE;
-	offset += DATA_REGS_OFFSET;
-	offset += pin % PINS_PER_BANK / DATA_PINS_PER_REG * 0x04;
-	return round_down(offset, 4);
-}
-
-static inline u32 sunxi_data_offset(u16 pin)
-{
-	u32 pin_num = pin % DATA_PINS_PER_REG;
-	return pin_num * DATA_PINS_BITS;
-}
-
-static inline u32 sunxi_dlevel_reg(u16 pin)
-{
-	u8 bank = pin / PINS_PER_BANK;
-	u32 offset = bank * BANK_MEM_SIZE;
-	offset += DLEVEL_REGS_OFFSET;
-	offset += pin % PINS_PER_BANK / DLEVEL_PINS_PER_REG * 0x04;
-	return round_down(offset, 4);
-}
-
-static inline u32 sunxi_dlevel_offset(u16 pin)
-{
-	u32 pin_num = pin % DLEVEL_PINS_PER_REG;
-	return pin_num * DLEVEL_PINS_BITS;
-}
-
-static inline u32 sunxi_pull_reg(u16 pin)
-{
-	u8 bank = pin / PINS_PER_BANK;
-	u32 offset = bank * BANK_MEM_SIZE;
-	offset += PULL_REGS_OFFSET;
-	offset += pin % PINS_PER_BANK / PULL_PINS_PER_REG * 0x04;
-	return round_down(offset, 4);
-}
-
-static inline u32 sunxi_pull_offset(u16 pin)
-{
-	u32 pin_num = pin % PULL_PINS_PER_REG;
-	return pin_num * PULL_PINS_BITS;
-}
-
 static inline u32 sunxi_irq_hw_bank_num(const struct sunxi_pinctrl_desc *desc, u8 bank)
 {
 	if (!desc->irq_bank_map)
-- 
2.35.1

