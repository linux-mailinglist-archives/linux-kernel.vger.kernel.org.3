Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B2A24FCE12
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 06:37:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346523AbiDLEil (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 00:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346046AbiDLEhq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 00:37:46 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 292A829808
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 21:35:30 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 0CF633201F1D;
        Tue, 12 Apr 2022 00:35:28 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 12 Apr 2022 00:35:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1649738128; x=1649824528; bh=rY
        Lzl5FjsfxzUu/BInArPLkvtCxBciKAPiIhUS768VQ=; b=wOU3KLkuzj/8JiGKLM
        opzOa+Cpd/8mjBHVPMhPKvhtteYdtGxEwFmwlNmnsvU5QoYeJA8t8H3RhvEPIRzY
        hKXtg6UlH7Pt1dUA2eqzU6a3hCWBfmNih70sNE0tZvGPV0bJZIgcPjqdzWzC5lg0
        tFATapyBa8nSDSLpT1Ub2yBOOOusgnfcpTYZJLC6WnxpFv0TOLJfcNryw0Pawn3U
        HTYsAUCoTzHEh8oSGnSvqKaJlnoqqphRBuBf21igzEFofK8ztLzM89USgbPOOOj4
        c+7AHVWbcOjPnu/iFGrC0nQSqA5O48EFMCHQbQMzR4pWGkw0QsQ2MilfwJQOsF9r
        3k0w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1649738128; x=1649824528; bh=rYLzl5FjsfxzUu/BInArPLkvtCxBciKAPiI
        hUS768VQ=; b=E7t4/0t2UVrXKaI+UXwGhcDY1R2m4bK6LrQz046ipSqibIAgsfl
        LgUwl5gJsCdbF2Gv37jY5E7onrkCLllhw2TO30zHhz8f6f4QjuLT6GYSTTLJgaSP
        kBdnll1q4aJiguii1SZOyc4Sf7gP3At1v0jt7HHa3oGJ/fUq4FsdFnvCHQD7sAAW
        uYoRpgCD+ZL01h+euDuQ26pbasZFkwK3leTrGpe34ZLN/f9VRJWmuQQ0xCRWuGo9
        Y0porcvRr3t+Gz0AaDw+LF9EgUVc7bHgQbM6M++RhGV5U9OgFGmC5YbMXpuzgneU
        lK6xM/2ZH95c82nLWEkbMNGikehVnX4zYSQ==
X-ME-Sender: <xms:kAFVYu1mgsn5rPfLx5C8CNYxsCmwMwt3Zj6flyIe01BYQOA6xrR1Lw>
    <xme:kAFVYhHdcKWiA6tOaf1p9lUTu9e8ugfzx_44mPkYGUdspUygePvoAzyakZCnVw2CV
    _Frp1djZvuouSkIbQ>
X-ME-Received: <xmr:kAFVYm6-t1jku_78bgUBc1MixTtMtaPInaFcSunjzmuM3N-RPEqPnzDq1aKGdvnqDKodgwJT4nvekFFHtvSSImaXosr1AkMtraW2uzo3eme3JLdtP7yypoD3jH2qgVY99Afv7Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudekjedgkedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpeduhfejfedvhffgfeehtefghfeiiefgfeehgfdvvdevfeegjeehjedv
    gfejheeuieenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:kAFVYv1UnhF-bdey_mTBwOmD0J9_jULTnC4L461zdJqv4cbkfxgHlg>
    <xmx:kAFVYhFCRbx1vbTL3xehcLRaOopDI-ZFilenlZYzLcpmjKMyLwMhAA>
    <xmx:kAFVYo8Da4mZmJcV8IdYQVosZXpxT_tdkRoGFacKKhQHG6Zlzrtwzw>
    <xmx:kAFVYgCvljVVb-PXuqki5W_xtqx4GRLr54gOtAX-RbZcPeZ_hBwDpg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Apr 2022 00:35:28 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maxime Ripard <mripard@kernel.org>
Cc:     Samuel Holland <samuel@sholland.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev
Subject: [PATCH 5/6] drm/sun4i: sun8i-hdmi-phy: Separate A83T and H3 PHY ops
Date:   Mon, 11 Apr 2022 23:35:10 -0500
Message-Id: <20220412043512.49364-6-samuel@sholland.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220412043512.49364-1-samuel@sholland.org>
References: <20220412043512.49364-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the driver already needs to support multiple sets of ops, we can
drop the mid-layer used by the A83T and H3 PHYs. They share only a small
amount of code; factor this out as sun8i_hdmi_phy_set_polarity.

For clarity, this commit keeps the existing function order.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

 drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h  |  5 --
 drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c | 89 +++++++++++++-------------
 2 files changed, 46 insertions(+), 48 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h
index f0b1aaad27d9..f082b8ecfe2c 100644
--- a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h
+++ b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h
@@ -156,11 +156,6 @@ struct sun8i_hdmi_phy_variant {
 	const struct dw_hdmi_phy_config *phy_cfg;
 	const struct dw_hdmi_phy_ops *phy_ops;
 	void (*phy_init)(struct sun8i_hdmi_phy *phy);
-	void (*phy_disable)(struct dw_hdmi *hdmi,
-			    struct sun8i_hdmi_phy *phy);
-	int  (*phy_config)(struct dw_hdmi *hdmi,
-			   struct sun8i_hdmi_phy *phy,
-			   unsigned int clk_rate);
 };
 
 struct sun8i_hdmi_phy {
diff --git a/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c b/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c
index 71062e4e8666..5be5c360ca7d 100644
--- a/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c
+++ b/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c
@@ -123,10 +123,18 @@ static const struct dw_hdmi_phy_config sun50i_h6_phy_config[] = {
 	{ ~0UL,	     0x0000, 0x0000, 0x0000}
 };
 
-static int sun8i_hdmi_phy_config_a83t(struct dw_hdmi *hdmi,
-				      struct sun8i_hdmi_phy *phy,
-				      unsigned int clk_rate)
+static void sun8i_hdmi_phy_set_polarity(struct sun8i_hdmi_phy *phy,
+					const struct drm_display_mode *mode);
+
+static int sun8i_a83t_hdmi_phy_config(struct dw_hdmi *hdmi, void *data,
+				      const struct drm_display_info *display,
+				      const struct drm_display_mode *mode)
 {
+	unsigned int clk_rate = mode->crtc_clock * 1000;
+	struct sun8i_hdmi_phy *phy = data;
+
+	sun8i_hdmi_phy_set_polarity(phy, mode);
+
 	regmap_update_bits(phy->regs, SUN8I_HDMI_PHY_REXT_CTRL_REG,
 			   SUN8I_HDMI_PHY_REXT_CTRL_REXT_EN,
 			   SUN8I_HDMI_PHY_REXT_CTRL_REXT_EN);
@@ -185,10 +193,12 @@ static int sun8i_hdmi_phy_config_a83t(struct dw_hdmi *hdmi,
 	return 0;
 }
 
-static int sun8i_hdmi_phy_config_h3(struct dw_hdmi *hdmi,
-				    struct sun8i_hdmi_phy *phy,
-				    unsigned int clk_rate)
+static int sun8i_h3_hdmi_phy_config(struct dw_hdmi *hdmi, void *data,
+				    const struct drm_display_info *display,
+				    const struct drm_display_mode *mode)
 {
+	unsigned int clk_rate = mode->crtc_clock * 1000;
+	struct sun8i_hdmi_phy *phy = data;
 	u32 pll_cfg1_init;
 	u32 pll_cfg2_init;
 	u32 ana_cfg1_end;
@@ -197,6 +207,11 @@ static int sun8i_hdmi_phy_config_h3(struct dw_hdmi *hdmi,
 	u32 b_offset = 0;
 	u32 val;
 
+	if (phy->variant->has_phy_clk)
+		clk_set_rate(phy->clk_phy, clk_rate);
+
+	sun8i_hdmi_phy_set_polarity(phy, mode);
+
 	/* bandwidth / frequency independent settings */
 
 	pll_cfg1_init = SUN8I_HDMI_PHY_PLL_CFG1_LDO2_EN |
@@ -333,11 +348,9 @@ static int sun8i_hdmi_phy_config_h3(struct dw_hdmi *hdmi,
 	return 0;
 }
 
-static int sun8i_hdmi_phy_config(struct dw_hdmi *hdmi, void *data,
-				 const struct drm_display_info *display,
-				 const struct drm_display_mode *mode)
+static void sun8i_hdmi_phy_set_polarity(struct sun8i_hdmi_phy *phy,
+					const struct drm_display_mode *mode)
 {
-	struct sun8i_hdmi_phy *phy = (struct sun8i_hdmi_phy *)data;
 	u32 val = 0;
 
 	if (mode->flags & DRM_MODE_FLAG_NHSYNC)
@@ -348,16 +361,12 @@ static int sun8i_hdmi_phy_config(struct dw_hdmi *hdmi, void *data,
 
 	regmap_update_bits(phy->regs, SUN8I_HDMI_PHY_DBG_CTRL_REG,
 			   SUN8I_HDMI_PHY_DBG_CTRL_POL_MASK, val);
-
-	if (phy->variant->has_phy_clk)
-		clk_set_rate(phy->clk_phy, mode->crtc_clock * 1000);
-
-	return phy->variant->phy_config(hdmi, phy, mode->crtc_clock * 1000);
 };
 
-static void sun8i_hdmi_phy_disable_a83t(struct dw_hdmi *hdmi,
-					struct sun8i_hdmi_phy *phy)
+static void sun8i_a83t_hdmi_phy_disable(struct dw_hdmi *hdmi, void *data)
 {
+	struct sun8i_hdmi_phy *phy = data;
+
 	dw_hdmi_phy_gen2_txpwron(hdmi, 0);
 	dw_hdmi_phy_gen2_pddq(hdmi, 1);
 
@@ -365,9 +374,10 @@ static void sun8i_hdmi_phy_disable_a83t(struct dw_hdmi *hdmi,
 			   SUN8I_HDMI_PHY_REXT_CTRL_REXT_EN, 0);
 }
 
-static void sun8i_hdmi_phy_disable_h3(struct dw_hdmi *hdmi,
-				      struct sun8i_hdmi_phy *phy)
+static void sun8i_h3_hdmi_phy_disable(struct dw_hdmi *hdmi, void *data)
 {
+	struct sun8i_hdmi_phy *phy = data;
+
 	regmap_write(phy->regs, SUN8I_HDMI_PHY_ANA_CFG1_REG,
 		     SUN8I_HDMI_PHY_ANA_CFG1_LDOEN |
 		     SUN8I_HDMI_PHY_ANA_CFG1_ENVBS |
@@ -375,19 +385,20 @@ static void sun8i_hdmi_phy_disable_h3(struct dw_hdmi *hdmi,
 	regmap_write(phy->regs, SUN8I_HDMI_PHY_PLL_CFG1_REG, 0);
 }
 
-static void sun8i_hdmi_phy_disable(struct dw_hdmi *hdmi, void *data)
-{
-	struct sun8i_hdmi_phy *phy = (struct sun8i_hdmi_phy *)data;
-
-	phy->variant->phy_disable(hdmi, phy);
-}
+static const struct dw_hdmi_phy_ops sun8i_a83t_hdmi_phy_ops = {
+	.init		= sun8i_a83t_hdmi_phy_config,
+	.disable	= sun8i_a83t_hdmi_phy_disable,
+	.read_hpd	= dw_hdmi_phy_read_hpd,
+	.update_hpd	= dw_hdmi_phy_update_hpd,
+	.setup_hpd	= dw_hdmi_phy_setup_hpd,
+};
 
-static const struct dw_hdmi_phy_ops sun8i_hdmi_phy_ops = {
-	.init = &sun8i_hdmi_phy_config,
-	.disable = &sun8i_hdmi_phy_disable,
-	.read_hpd = &dw_hdmi_phy_read_hpd,
-	.update_hpd = &dw_hdmi_phy_update_hpd,
-	.setup_hpd = &dw_hdmi_phy_setup_hpd,
+static const struct dw_hdmi_phy_ops sun8i_h3_hdmi_phy_ops = {
+	.init		= sun8i_h3_hdmi_phy_config,
+	.disable	= sun8i_h3_hdmi_phy_disable,
+	.read_hpd	= dw_hdmi_phy_read_hpd,
+	.update_hpd	= dw_hdmi_phy_update_hpd,
+	.setup_hpd	= dw_hdmi_phy_setup_hpd,
 };
 
 static void sun8i_hdmi_phy_unlock(struct sun8i_hdmi_phy *phy)
@@ -587,35 +598,27 @@ static const struct regmap_config sun8i_hdmi_phy_regmap_config = {
 };
 
 static const struct sun8i_hdmi_phy_variant sun8i_a83t_hdmi_phy = {
-	.phy_ops = &sun8i_hdmi_phy_ops,
+	.phy_ops = &sun8i_a83t_hdmi_phy_ops,
 	.phy_init = &sun8i_hdmi_phy_init_a83t,
-	.phy_disable = &sun8i_hdmi_phy_disable_a83t,
-	.phy_config = &sun8i_hdmi_phy_config_a83t,
 };
 
 static const struct sun8i_hdmi_phy_variant sun8i_h3_hdmi_phy = {
 	.has_phy_clk = true,
-	.phy_ops = &sun8i_hdmi_phy_ops,
+	.phy_ops = &sun8i_h3_hdmi_phy_ops,
 	.phy_init = &sun8i_hdmi_phy_init_h3,
-	.phy_disable = &sun8i_hdmi_phy_disable_h3,
-	.phy_config = &sun8i_hdmi_phy_config_h3,
 };
 
 static const struct sun8i_hdmi_phy_variant sun8i_r40_hdmi_phy = {
 	.has_phy_clk = true,
 	.has_second_pll = true,
-	.phy_ops = &sun8i_hdmi_phy_ops,
+	.phy_ops = &sun8i_h3_hdmi_phy_ops,
 	.phy_init = &sun8i_hdmi_phy_init_h3,
-	.phy_disable = &sun8i_hdmi_phy_disable_h3,
-	.phy_config = &sun8i_hdmi_phy_config_h3,
 };
 
 static const struct sun8i_hdmi_phy_variant sun50i_a64_hdmi_phy = {
 	.has_phy_clk = true,
-	.phy_ops = &sun8i_hdmi_phy_ops,
+	.phy_ops = &sun8i_h3_hdmi_phy_ops,
 	.phy_init = &sun8i_hdmi_phy_init_h3,
-	.phy_disable = &sun8i_hdmi_phy_disable_h3,
-	.phy_config = &sun8i_hdmi_phy_config_h3,
 };
 
 static const struct sun8i_hdmi_phy_variant sun50i_h6_hdmi_phy = {
-- 
2.35.1

