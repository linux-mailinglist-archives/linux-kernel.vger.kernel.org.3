Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0037E590D0C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 09:56:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237762AbiHLH4l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 03:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237705AbiHLH4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 03:56:16 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D173B99B45;
        Fri, 12 Aug 2022 00:56:15 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 40FAB5C0115;
        Fri, 12 Aug 2022 03:56:15 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Fri, 12 Aug 2022 03:56:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1660290975; x=1660377375; bh=Bf
        V3swjxdx5USfEaE1XeMwxBAoZADIoLTz1F96t9hyc=; b=mvhlbbw8hqnin7iWcj
        j9ayN8AKVFxbvvsBfnJBdUZWQAb11a1GmPy9ygUUVF4sQE63XL/2TCBSCBL3FnCE
        a9chhyqZZVKXpMIVEXrL/c85vV8RCDkNlJZ79PkTNs3dB7nppYAPeLzBNqxP8NfS
        YOZ5xZhzRiSlBGhFY1v2fM2Gd8VuGltI2v4oIEh8/uIRZ0YV8dHLxeSkSZ4FXzAM
        glPfRvYyxR1156ZM5CgaKZPDkOS6lD4mPp0pykdeRnfAIzWwuG/7wvodsBFym6c8
        ZX5K1cFUt6kqQKeVIaKsTlLcdiQe9HS2b1zyV6OhBgHFEZ3snQ6CJ46AUoht3nyE
        oV8Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1660290975; x=1660377375; bh=BfV3swjxdx5US
        fEaE1XeMwxBAoZADIoLTz1F96t9hyc=; b=fydXvwbHgZ4JtYaMqdaUC89RBeCOQ
        beUbmsCp0snlosi4OFRwCMKNgQ/6oTgtVtSyUW2Z0pojGiwRiqzAwH9Z0nMyzq4q
        y/fkFbVkrm6vMgTaxZBdZi/2MtvM2TGo+YjqCqOd1g+sftai7WNwUa/CzYCmP4EB
        QSE48HYvGCmMJQuaWn3rm6YzlapENStfBp+G+UOefGF9DGXPRNfcThux1ejFQv6q
        jT5CUXjsbaufZ6cZyaTvTPA3hbWEnosfqn9iYGodrsrTEQB7wtXWy/2aKvBi4aSb
        MghntvjpJyv5iBI8sAVSGHhZu+UTmZHlN9XGg24uALIDCT3u767dAc1Yg==
X-ME-Sender: <xms:nwf2YsTcidG-5ff6Qdq2jvqYlzlaxJne6QTV3XdDBTnaAYOgbPkccg>
    <xme:nwf2YpwzsdjLeLNMfgVRC33fAbsp5xFsPFEQwHuo_f06OIIrFIEJQPYewfKWqxOxM
    lwOqHrsUyCyv6Qxig>
X-ME-Received: <xmr:nwf2Yp15AUvG5oQhg3F-UxzM8vwUEx7yYlgdlJOLYMIb7WkmMnvK5rubA04__VmlE10IE_BAQTFy7VFmV6xjfitQ_uaBuE8pbEtqWwxnzNIM5OgtuJCdDMUWpG3RercE4NHJig>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdeghedguddvjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghm
    uhgvlhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenuc
    ggtffrrghtthgvrhhnpedukeetueduhedtleetvefguddvvdejhfefudelgfduveeggeeh
    gfdufeeitdevteenucevlhhushhtvghrufhiiigvpeehnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:nwf2YgBCg8qO0B-6xul1HMAcq3XMc4uX_XmPpH-hsOP0xg6h62z3Mw>
    <xmx:nwf2YljecjsV57Qf1EuePOCacz2Q9qfBgM6i5b5L_SW5Y3awWOFsEA>
    <xmx:nwf2YspXsk3XEoFPtMSXg4GAc9v9nLKF0MQgTjOd6F1XA3PxVnXWpA>
    <xmx:nwf2Yl5ei5AYU0joqZubc-zmHzfJ3cYiAm2tEQ15hov7Qx7QxpdZJg>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 Aug 2022 03:56:14 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maxime Ripard <mripard@kernel.org>
Cc:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Samuel Holland <samuel@sholland.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: [PATCH 8/8] phy: allwinner: phy-sun6i-mipi-dphy: Add the A100 DPHY variant
Date:   Fri, 12 Aug 2022 02:56:03 -0500
Message-Id: <20220812075603.59375-9-samuel@sholland.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220812075603.59375-1-samuel@sholland.org>
References: <20220812075603.59375-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A100 features an updated DPHY, which moves PLL control inside the DPHY
register space (previously the PLL was controlled from the CCU). It also
requires a modified analog power-on sequence. This "combo PHY" can also
be used as an LVDS PHY, but that is not yet supported by the driver.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

 drivers/phy/allwinner/phy-sun6i-mipi-dphy.c | 143 +++++++++++++++++++-
 1 file changed, 142 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/allwinner/phy-sun6i-mipi-dphy.c b/drivers/phy/allwinner/phy-sun6i-mipi-dphy.c
index 6a1993c434e8..9911c4a5c318 100644
--- a/drivers/phy/allwinner/phy-sun6i-mipi-dphy.c
+++ b/drivers/phy/allwinner/phy-sun6i-mipi-dphy.c
@@ -70,11 +70,19 @@
 
 #define SUN6I_DPHY_ANA0_REG		0x4c
 #define SUN6I_DPHY_ANA0_REG_PWS			BIT(31)
+#define SUN6I_DPHY_ANA0_REG_PWEND		BIT(30)
+#define SUN6I_DPHY_ANA0_REG_PWENC		BIT(29)
 #define SUN6I_DPHY_ANA0_REG_DMPC		BIT(28)
 #define SUN6I_DPHY_ANA0_REG_DMPD(n)		(((n) & 0xf) << 24)
+#define SUN6I_DPHY_ANA0_REG_SRXDT(n)		(((n) & 0xf) << 20)
+#define SUN6I_DPHY_ANA0_REG_SRXCK(n)		(((n) & 0xf) << 16)
+#define SUN6I_DPHY_ANA0_REG_SDIV2		BIT(15)
 #define SUN6I_DPHY_ANA0_REG_SLV(n)		(((n) & 7) << 12)
 #define SUN6I_DPHY_ANA0_REG_DEN(n)		(((n) & 0xf) << 8)
+#define SUN6I_DPHY_ANA0_REG_PLR(n)		(((n) & 0xf) << 4)
 #define SUN6I_DPHY_ANA0_REG_SFB(n)		(((n) & 3) << 2)
+#define SUN6I_DPHY_ANA0_REG_RSD			BIT(1)
+#define SUN6I_DPHY_ANA0_REG_SELSCK		BIT(0)
 
 #define SUN6I_DPHY_ANA1_REG		0x50
 #define SUN6I_DPHY_ANA1_REG_VTTMODE		BIT(31)
@@ -97,8 +105,13 @@
 #define SUN6I_DPHY_ANA3_EN_LDOR			BIT(18)
 
 #define SUN6I_DPHY_ANA4_REG		0x5c
+#define SUN6I_DPHY_ANA4_REG_EN_MIPI		BIT(31)
+#define SUN6I_DPHY_ANA4_REG_EN_COMTEST		BIT(30)
+#define SUN6I_DPHY_ANA4_REG_COMTEST(n)		(((n) & 3) << 28)
+#define SUN6I_DPHY_ANA4_REG_IB(n)		(((n) & 3) << 25)
 #define SUN6I_DPHY_ANA4_REG_DMPLVC		BIT(24)
 #define SUN6I_DPHY_ANA4_REG_DMPLVD(n)		(((n) & 0xf) << 20)
+#define SUN6I_DPHY_ANA4_REG_VTT_SET(n)		(((n) & 0x7) << 17)
 #define SUN6I_DPHY_ANA4_REG_CKDV(n)		(((n) & 0x1f) << 12)
 #define SUN6I_DPHY_ANA4_REG_TMSC(n)		(((n) & 3) << 10)
 #define SUN6I_DPHY_ANA4_REG_TMSD(n)		(((n) & 3) << 8)
@@ -109,6 +122,56 @@
 
 #define SUN6I_DPHY_DBG5_REG		0xf4
 
+#define SUN50I_DPHY_TX_SLEW_REG0	0xf8
+#define SUN50I_DPHY_TX_SLEW_REG1	0xfc
+#define SUN50I_DPHY_TX_SLEW_REG2	0x100
+
+#define SUN50I_DPHY_PLL_REG0		0x104
+#define SUN50I_DPHY_PLL_REG0_CP36_EN		BIT(23)
+#define SUN50I_DPHY_PLL_REG0_LDO_EN		BIT(22)
+#define SUN50I_DPHY_PLL_REG0_EN_LVS		BIT(21)
+#define SUN50I_DPHY_PLL_REG0_PLL_EN		BIT(20)
+#define SUN50I_DPHY_PLL_REG0_P(n)		(((n) & 0xf) << 16)
+#define SUN50I_DPHY_PLL_REG0_N(n)		(((n) & 0xff) << 8)
+#define SUN50I_DPHY_PLL_REG0_NDET		BIT(7)
+#define SUN50I_DPHY_PLL_REG0_TDIV		BIT(6)
+#define SUN50I_DPHY_PLL_REG0_M0(n)		(((n) & 3) << 4)
+#define SUN50I_DPHY_PLL_REG0_M1(n)		((n) & 0xf)
+
+#define SUN50I_DPHY_PLL_REG1		0x108
+#define SUN50I_DPHY_PLL_REG1_UNLOCK_MDSEL(n)	(((n) & 3) << 14)
+#define SUN50I_DPHY_PLL_REG1_LOCKMDSEL		BIT(13)
+#define SUN50I_DPHY_PLL_REG1_LOCKDET_EN		BIT(12)
+#define SUN50I_DPHY_PLL_REG1_VSETA(n)		(((n) & 0x7) << 9)
+#define SUN50I_DPHY_PLL_REG1_VSETD(n)		(((n) & 0x7) << 6)
+#define SUN50I_DPHY_PLL_REG1_LPF_SW		BIT(5)
+#define SUN50I_DPHY_PLL_REG1_ICP_SEL(n)		(((n) & 3) << 3)
+#define SUN50I_DPHY_PLL_REG1_ATEST_SEL(n)	(((n) & 3) << 1)
+#define SUN50I_DPHY_PLL_REG1_TEST_EN		BIT(0)
+
+#define SUN50I_DPHY_PLL_REG2		0x10c
+#define SUN50I_DPHY_PLL_REG2_SDM_EN		BIT(31)
+#define SUN50I_DPHY_PLL_REG2_FF_EN		BIT(30)
+#define SUN50I_DPHY_PLL_REG2_SS_EN		BIT(29)
+#define SUN50I_DPHY_PLL_REG2_SS_FRAC(n)		(((n) & 0x1ff) << 20)
+#define SUN50I_DPHY_PLL_REG2_SS_INT(n)		(((n) & 0xff) << 12)
+#define SUN50I_DPHY_PLL_REG2_FRAC(n)		((n) & 0xfff)
+
+#define SUN50I_COMBO_PHY_REG0		0x110
+#define SUN50I_COMBO_PHY_REG0_EN_TEST_COMBOLDO	BIT(5)
+#define SUN50I_COMBO_PHY_REG0_EN_TEST_0P8	BIT(4)
+#define SUN50I_COMBO_PHY_REG0_EN_MIPI		BIT(3)
+#define SUN50I_COMBO_PHY_REG0_EN_LVDS		BIT(2)
+#define SUN50I_COMBO_PHY_REG0_EN_COMBOLDO	BIT(1)
+#define SUN50I_COMBO_PHY_REG0_EN_CP		BIT(0)
+
+#define SUN50I_COMBO_PHY_REG1		0x114
+#define SUN50I_COMBO_PHY_REG2_REG_VREF1P6(n)	(((n) & 0x7) << 4)
+#define SUN50I_COMBO_PHY_REG2_REG_VREF0P8(n)	((n) & 0x7)
+
+#define SUN50I_COMBO_PHY_REG2		0x118
+#define SUN50I_COMBO_PHY_REG2_HS_STOP_DLY(n)	((n) & 0xff)
+
 enum sun6i_dphy_direction {
 	SUN6I_DPHY_DIRECTION_TX,
 	SUN6I_DPHY_DIRECTION_RX,
@@ -196,6 +259,76 @@ static void sun6i_a31_mipi_dphy_tx_power_on(struct sun6i_dphy *dphy)
 	udelay(1);
 }
 
+static void sun50i_a100_mipi_dphy_tx_power_on(struct sun6i_dphy *dphy)
+{
+	unsigned long mipi_symbol_rate = dphy->config.hs_clk_rate;
+	unsigned int div, n;
+
+	regmap_write(dphy->regs, SUN6I_DPHY_ANA4_REG,
+		     SUN6I_DPHY_ANA4_REG_IB(2) |
+		     SUN6I_DPHY_ANA4_REG_DMPLVD(4) |
+		     SUN6I_DPHY_ANA4_REG_VTT_SET(3) |
+		     SUN6I_DPHY_ANA4_REG_CKDV(3) |
+		     SUN6I_DPHY_ANA4_REG_TMSD(1) |
+		     SUN6I_DPHY_ANA4_REG_TMSC(1) |
+		     SUN6I_DPHY_ANA4_REG_TXPUSD(2) |
+		     SUN6I_DPHY_ANA4_REG_TXPUSC(3) |
+		     SUN6I_DPHY_ANA4_REG_TXDNSD(2) |
+		     SUN6I_DPHY_ANA4_REG_TXDNSC(3));
+
+	regmap_update_bits(dphy->regs, SUN6I_DPHY_ANA2_REG,
+			   SUN6I_DPHY_ANA2_EN_CK_CPU,
+			   SUN6I_DPHY_ANA2_EN_CK_CPU);
+
+	regmap_update_bits(dphy->regs, SUN6I_DPHY_ANA2_REG,
+			   SUN6I_DPHY_ANA2_REG_ENIB,
+			   SUN6I_DPHY_ANA2_REG_ENIB);
+
+	regmap_write(dphy->regs, SUN6I_DPHY_ANA3_REG,
+		     SUN6I_DPHY_ANA3_EN_LDOR |
+		     SUN6I_DPHY_ANA3_EN_LDOC |
+		     SUN6I_DPHY_ANA3_EN_LDOD);
+
+	regmap_write(dphy->regs, SUN6I_DPHY_ANA0_REG,
+		     SUN6I_DPHY_ANA0_REG_PLR(4) |
+		     SUN6I_DPHY_ANA0_REG_SFB(1));
+
+	regmap_write(dphy->regs, SUN50I_COMBO_PHY_REG0,
+		     SUN50I_COMBO_PHY_REG0_EN_CP);
+
+	/* Choose a divider to limit the VCO frequency to around 2 GHz. */
+	div = 16 >> order_base_2(DIV_ROUND_UP(mipi_symbol_rate, 264000000));
+	n = mipi_symbol_rate * div / 24000000;
+
+	regmap_write(dphy->regs, SUN50I_DPHY_PLL_REG0,
+		     SUN50I_DPHY_PLL_REG0_CP36_EN |
+		     SUN50I_DPHY_PLL_REG0_LDO_EN |
+		     SUN50I_DPHY_PLL_REG0_EN_LVS |
+		     SUN50I_DPHY_PLL_REG0_PLL_EN |
+		     SUN50I_DPHY_PLL_REG0_NDET |
+		     SUN50I_DPHY_PLL_REG0_P((div - 1) % 8) |
+		     SUN50I_DPHY_PLL_REG0_N(n) |
+		     SUN50I_DPHY_PLL_REG0_M0((div - 1) / 8) |
+		     SUN50I_DPHY_PLL_REG0_M1(2));
+
+	/* Disable sigma-delta modulation. */
+	regmap_write(dphy->regs, SUN50I_DPHY_PLL_REG2, 0);
+
+	regmap_update_bits(dphy->regs, SUN6I_DPHY_ANA4_REG,
+			   SUN6I_DPHY_ANA4_REG_EN_MIPI,
+			   SUN6I_DPHY_ANA4_REG_EN_MIPI);
+
+	regmap_update_bits(dphy->regs, SUN50I_COMBO_PHY_REG0,
+			   SUN50I_COMBO_PHY_REG0_EN_MIPI |
+			   SUN50I_COMBO_PHY_REG0_EN_COMBOLDO,
+			   SUN50I_COMBO_PHY_REG0_EN_MIPI |
+			   SUN50I_COMBO_PHY_REG0_EN_COMBOLDO);
+
+	regmap_write(dphy->regs, SUN50I_COMBO_PHY_REG2,
+		     SUN50I_COMBO_PHY_REG2_HS_STOP_DLY(20));
+	udelay(1);
+}
+
 static int sun6i_dphy_tx_power_on(struct sun6i_dphy *dphy)
 {
 	u8 lanes_mask = GENMASK(dphy->config.lanes - 1, 0);
@@ -408,7 +541,7 @@ static const struct regmap_config sun6i_dphy_regmap_config = {
 	.reg_bits	= 32,
 	.val_bits	= 32,
 	.reg_stride	= 4,
-	.max_register	= SUN6I_DPHY_DBG5_REG,
+	.max_register	= SUN50I_COMBO_PHY_REG2,
 	.name		= "mipi-dphy",
 };
 
@@ -483,11 +616,19 @@ static const struct sun6i_dphy_variant sun6i_a31_mipi_dphy_variant = {
 	.supports_rx	= true,
 };
 
+static const struct sun6i_dphy_variant sun50i_a100_mipi_dphy_variant = {
+	.tx_power_on	= sun50i_a100_mipi_dphy_tx_power_on,
+};
+
 static const struct of_device_id sun6i_dphy_of_table[] = {
 	{
 		.compatible	= "allwinner,sun6i-a31-mipi-dphy",
 		.data		= &sun6i_a31_mipi_dphy_variant,
 	},
+	{
+		.compatible	= "allwinner,sun50i-a100-mipi-dphy",
+		.data		= &sun50i_a100_mipi_dphy_variant,
+	},
 	{ }
 };
 MODULE_DEVICE_TABLE(of, sun6i_dphy_of_table);
-- 
2.35.1

