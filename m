Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 292865862FB
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 05:06:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239316AbiHADGj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 23:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239517AbiHADFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 23:05:50 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3153FD0D;
        Sun, 31 Jul 2022 20:05:39 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id C3F753200681;
        Sun, 31 Jul 2022 23:05:37 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Sun, 31 Jul 2022 23:05:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1659323137; x=1659409537; bh=S1
        F/EjoEEvOcsDP7ZCJIvR1d094GwH7IrcgOjq4zzfE=; b=t5BOHuQW80+TN2ov0K
        sGhaXEL58slfsulgWE4jXPGM2txk+pP142Uj0v/oWiTurT9n6+SRUXxCg5N17fs2
        Bk7QjljOJjYSjERcr2F0kAwFAP3DE07BnT1rJDmJe99HVNgczfhlxtqRv1sGs5uG
        uXhwUk8L4Jvsbs65o8W7jAhNvRdk0i5aDLCekXgrA3T6DZwCLRG3CwCEN5NFS18q
        DIJltOFqoVItDwGCRe/S7xnKcmkLFm7Xn4S9yQL8DhZzjdh/k8cbRHyJi6s+UDfG
        gmvkmJqnDwcsOq/0v7bjGOW3yj2HzsIaoID/Ks0+xMTCAq02/804sfh0Zjdna1FI
        li8g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1659323137; x=1659409537; bh=S1F/EjoEEvOcs
        DP7ZCJIvR1d094GwH7IrcgOjq4zzfE=; b=pySYn+nfFGKiQf13ZOQVdu00F/9Lz
        40omZiTbGi2rMuAFRnrogICjJWLPLoYmvhOHZ/aKM+VPR6gEt46Jht0RaNjFdFRj
        6bUYhOEal8Xt4DMCobaOzKEvxz1Yv/hwm61YysRibsUmGdcPDWYaI0A4OReFKa8Q
        rC/lXDlWV6A79r1X+9LW6As2xur1P7bHwiM7bXFEBHNV17vMksrmJ+dyaL2tga8B
        xjLew/aK4xx5GR19Hoq/R0ZYMLMGshOm3LfHCVvWq6+snK7daYi16xK9lq76152h
        GgCUNbIs8yb43xlDwPbrMCaonsTNiJRlIyeJZwV1GMOvL6PjXR8+s8meQ==
X-ME-Sender: <xms:AUPnYsqibzSPhIvZ9XlNOJwHVWyL4B2AR2vVZ47ihibnOg9OqRFHHw>
    <xme:AUPnYiro9yWoKTqNGUM-cnC7Tea11y4rnjPcCSM7z8Nls4UeaDoPDB9EtaW60hY2U
    joXPvRiVMc-lbP48g>
X-ME-Received: <xmr:AUPnYhPuO0_Yq84OMbzlzuD-fkSsEEEJzCsQd0LW6fNANFyUEz-Ld0eHEeVvuMTXTR0cUfXzE5v1uVqbnVqacdCJLYVPRufqVKWqEiBoo3JhvlVtuyqfIp8ADMV23h6uN5JoXw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvddvvddgheejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepudekteeuudehtdelteevgfduvddvjefhfedulefgudevgeeghefg
    udefiedtveetnecuvehluhhsthgvrhfuihiivgepgeenucfrrghrrghmpehmrghilhhfrh
    homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:AUPnYj7c0MxOlmVlKZDZvnBjcSRhqOnkANKpgwtGriPAjYlbtk9ubw>
    <xmx:AUPnYr4-OeRqTHgyiJDeqQs7M9ROGaDhPYCuCMnyjdBC3IKDo8nIpg>
    <xmx:AUPnYjgHzbZGsV6EtdESDsT7xk_4xy5E7gqUjSw7AvtyU95-Ef-EkA>
    <xmx:AUPnYvhXE4gV3EJyNCQaflh_1m0_MGfJQbDFcNZ3ZbZNP_hWGfGROw>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 31 Jul 2022 23:05:36 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     Samuel Holland <samuel@sholland.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Hans de Goede <hdegoede@redhat.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev
Subject: [PATCH 8/9] soc: sunxi: sram: Export the LDO control register
Date:   Sun, 31 Jul 2022 22:05:08 -0500
Message-Id: <20220801030509.21966-9-samuel@sholland.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220801030509.21966-1-samuel@sholland.org>
References: <20220801030509.21966-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some newer Allwinner SoCs contain internal LDOs managed by a register in
the system control MMIO space. Export this from the regmap in addtion to
the EMAC register.

Use generic names now that the regmap is no longer EMAC-specific.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

 drivers/soc/sunxi/sunxi_sram.c | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/drivers/soc/sunxi/sunxi_sram.c b/drivers/soc/sunxi/sunxi_sram.c
index 7c6fb17cfe7f..7e8dab0f0ec4 100644
--- a/drivers/soc/sunxi/sunxi_sram.c
+++ b/drivers/soc/sunxi/sunxi_sram.c
@@ -283,6 +283,7 @@ EXPORT_SYMBOL(sunxi_sram_release);
 
 struct sunxi_sramc_variant {
 	int num_emac_clocks;
+	bool has_ldo_ctrl;
 };
 
 static const struct sunxi_sramc_variant sun4i_a10_sramc_variant = {
@@ -302,25 +303,28 @@ static const struct sunxi_sramc_variant sun50i_h616_sramc_variant = {
 };
 
 #define SUNXI_SRAM_EMAC_CLOCK_REG	0x30
+#define SUNXI_SYS_LDO_CTRL_REG		0x150
+
 static bool sunxi_sram_regmap_accessible_reg(struct device *dev,
 					     unsigned int reg)
 {
 	const struct sunxi_sramc_variant *variant = dev_get_drvdata(dev);
 
-	if (reg < SUNXI_SRAM_EMAC_CLOCK_REG)
-		return false;
-	if (reg > SUNXI_SRAM_EMAC_CLOCK_REG + variant->num_emac_clocks * 4)
-		return false;
+	if (reg >= SUNXI_SRAM_EMAC_CLOCK_REG &&
+	    reg <  SUNXI_SRAM_EMAC_CLOCK_REG + variant->num_emac_clocks * 4)
+		return true;
+	if (reg == SUNXI_SYS_LDO_CTRL_REG && variant->has_ldo_ctrl)
+		return true;
 
-	return true;
+	return false;
 }
 
-static struct regmap_config sunxi_sram_emac_clock_regmap = {
+static struct regmap_config sunxi_sram_regmap_config = {
 	.reg_bits       = 32,
 	.val_bits       = 32,
 	.reg_stride     = 4,
 	/* last defined register */
-	.max_register   = SUNXI_SRAM_EMAC_CLOCK_REG + 4,
+	.max_register   = SUNXI_SYS_LDO_CTRL_REG,
 	/* other devices have no business accessing other registers */
 	.readable_reg	= sunxi_sram_regmap_accessible_reg,
 	.writeable_reg	= sunxi_sram_regmap_accessible_reg,
@@ -328,9 +332,9 @@ static struct regmap_config sunxi_sram_emac_clock_regmap = {
 
 static int __init sunxi_sram_probe(struct platform_device *pdev)
 {
-	struct regmap *emac_clock;
 	const struct sunxi_sramc_variant *variant;
 	struct device *dev = &pdev->dev;
+	struct regmap *regmap;
 
 	sram_dev = &pdev->dev;
 
@@ -344,12 +348,10 @@ static int __init sunxi_sram_probe(struct platform_device *pdev)
 	if (IS_ERR(base))
 		return PTR_ERR(base);
 
-	if (variant->num_emac_clocks > 0) {
-		emac_clock = devm_regmap_init_mmio(&pdev->dev, base,
-						   &sunxi_sram_emac_clock_regmap);
-
-		if (IS_ERR(emac_clock))
-			return PTR_ERR(emac_clock);
+	if (variant->num_emac_clocks || variant->has_ldo_ctrl) {
+		regmap = devm_regmap_init_mmio(dev, base, &sunxi_sram_regmap_config);
+		if (IS_ERR(regmap))
+			return PTR_ERR(regmap);
 	}
 
 	of_platform_populate(dev->of_node, NULL, NULL, dev);
-- 
2.35.1

