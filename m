Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 992BA54C0F0
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 06:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242498AbiFOE4O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 00:56:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242130AbiFOE4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 00:56:05 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 551C836692
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 21:56:04 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id DC95132002D8;
        Wed, 15 Jun 2022 00:56:02 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 15 Jun 2022 00:56:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1655268962; x=1655355362; bh=ei
        fZR+rkb7Pl0q/tlESZNdAQghMG8hJv8oUZqbBJ87E=; b=lpYhE3imjXxM9qpcvv
        GfEKzM1NTLSHHUt9X/UJ4jm6+tfyGg1+kPGtsqGxiYbpdNwFolCYV0ajPaALUl9b
        0+YshqjpPbpZC7HGxpVrCA6J/eebx4KHh22mImGdQKonAWOsE6JGnDuqa0C0L2EB
        TsHhivo2OxxaOK5d1Jox9rG+ST4td5c5x49vo6JwNhZGMsF6ozc2c60WGeeg0mU2
        BpIM2UkHNDCAHP49fQT31qfDozqJUaVGUllLMMk4+xN9mtpzGL6Lo6maF1Eo+6vy
        QS57tAk9N8+n42D7Lc96IgQ/9++iG29LVrC4/FtZ07OoWHkNyRgceXKRboR/osZD
        kiCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1655268962; x=1655355362; bh=eifZR+rkb7Pl0
        q/tlESZNdAQghMG8hJv8oUZqbBJ87E=; b=JYyxK58vtzSheCX2MFZUAvDd4PTLL
        VotbJ0/5RWF1kqhVoAlqWe0FJIUk9YNCrYEC3T+AXaTinD3paF8awjsrbupi34gS
        qPbpHB6cDDxsUVYeBStfdeFOIbKfR71ntPXXBNfX77qO/QWPHwSt/qAROorzgf70
        cz3lsAI1tpx0CpAAUxdPFI8syF7LzWP2QK1QmUzui9VxixMRa+OuzovSD73Y6Nsm
        VsSUclPEHRHSI0tMyWI4akzddgiytFJwPsEP1plw83Tm+MtI6QbLa5TPoZyRcJBH
        +71iKnfO+AUebTBpsV4yiUA9l76IwWhwRjcJK0E+t7j4ZyFiEsZOtoyXw==
X-ME-Sender: <xms:YmapYlVgBfaGZiPKAXTYx1q6taPqNOVE6cELlBGP_lJj2scjCjyMIA>
    <xme:YmapYll-KGE00CeOOBSoCbMUCjyHlPOODzFwc8_PwnIdrQphyFZUdcE870ZXJFRKa
    FVTdclU3-1wziMO1w>
X-ME-Received: <xmr:YmapYhYaLl_fT1pOEmgBjFIQbXGYO-C8TaOMswfXTDLg0SwFOT1oPLkkg_I4aF2NFidcuwCPJd2NXHPAEEDkTHqcUVspPCf8fOB0eM78hB8xOY8JFdKqxXXiPiHl6hdwfvDySQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedruddvtddgkeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepudekteeuudehtdelteevgfduvddvjefhfedulefgudevgeeghefg
    udefiedtveetnecuvehluhhsthgvrhfuihiivgepfeenucfrrghrrghmpehmrghilhhfrh
    homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:YmapYoVLPFc7ASMMk4q4yGi8cE99f4O7zxrYlchb-6d0eQT4eQE_mg>
    <xmx:YmapYvlpZYGdaRITDOe_YhhPj-G1ASaPUoSlOlBd4i0SYeJO30WDXw>
    <xmx:YmapYldx1lWWij-l-c74IsqB0V8609kgMf3FSOjfDyuK6fQCwa_Vew>
    <xmx:YmapYohXP9RsMXZfvzT5miVcyG2j_O-yASwz0kDt0Y-IxDJbxejd0Q>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Jun 2022 00:56:01 -0400 (EDT)
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
Subject: [PATCH v2 6/6] drm/sun4i: sun8i-hdmi-phy: Group PHY ops functions by generation
Date:   Tue, 14 Jun 2022 23:55:43 -0500
Message-Id: <20220615045543.62813-7-samuel@sholland.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220615045543.62813-1-samuel@sholland.org>
References: <20220615045543.62813-1-samuel@sholland.org>
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

Now that the PHY ops are separated, sort them topologically, with the
common sun8i_hdmi_phy_set_polarity helper at the top. No function
contents are changed in this commit.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

(no changes since v1)

 drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c | 67 ++++++++++++--------------
 1 file changed, 32 insertions(+), 35 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c b/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c
index f94c1ddddbad..ca53b5e9fffc 100644
--- a/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c
+++ b/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c
@@ -124,7 +124,19 @@ static const struct dw_hdmi_phy_config sun50i_h6_phy_config[] = {
 };
 
 static void sun8i_hdmi_phy_set_polarity(struct sun8i_hdmi_phy *phy,
-					const struct drm_display_mode *mode);
+					const struct drm_display_mode *mode)
+{
+	u32 val = 0;
+
+	if (mode->flags & DRM_MODE_FLAG_NHSYNC)
+		val |= SUN8I_HDMI_PHY_DBG_CTRL_POL_NHSYNC;
+
+	if (mode->flags & DRM_MODE_FLAG_NVSYNC)
+		val |= SUN8I_HDMI_PHY_DBG_CTRL_POL_NVSYNC;
+
+	regmap_update_bits(phy->regs, SUN8I_HDMI_PHY_DBG_CTRL_REG,
+			   SUN8I_HDMI_PHY_DBG_CTRL_POL_MASK, val);
+};
 
 static int sun8i_a83t_hdmi_phy_config(struct dw_hdmi *hdmi, void *data,
 				      const struct drm_display_info *display,
@@ -193,6 +205,25 @@ static int sun8i_a83t_hdmi_phy_config(struct dw_hdmi *hdmi, void *data,
 	return 0;
 }
 
+static void sun8i_a83t_hdmi_phy_disable(struct dw_hdmi *hdmi, void *data)
+{
+	struct sun8i_hdmi_phy *phy = data;
+
+	dw_hdmi_phy_gen2_txpwron(hdmi, 0);
+	dw_hdmi_phy_gen2_pddq(hdmi, 1);
+
+	regmap_update_bits(phy->regs, SUN8I_HDMI_PHY_REXT_CTRL_REG,
+			   SUN8I_HDMI_PHY_REXT_CTRL_REXT_EN, 0);
+}
+
+static const struct dw_hdmi_phy_ops sun8i_a83t_hdmi_phy_ops = {
+	.init		= sun8i_a83t_hdmi_phy_config,
+	.disable	= sun8i_a83t_hdmi_phy_disable,
+	.read_hpd	= dw_hdmi_phy_read_hpd,
+	.update_hpd	= dw_hdmi_phy_update_hpd,
+	.setup_hpd	= dw_hdmi_phy_setup_hpd,
+};
+
 static int sun8i_h3_hdmi_phy_config(struct dw_hdmi *hdmi, void *data,
 				    const struct drm_display_info *display,
 				    const struct drm_display_mode *mode)
@@ -348,32 +379,6 @@ static int sun8i_h3_hdmi_phy_config(struct dw_hdmi *hdmi, void *data,
 	return 0;
 }
 
-static void sun8i_hdmi_phy_set_polarity(struct sun8i_hdmi_phy *phy,
-					const struct drm_display_mode *mode)
-{
-	u32 val = 0;
-
-	if (mode->flags & DRM_MODE_FLAG_NHSYNC)
-		val |= SUN8I_HDMI_PHY_DBG_CTRL_POL_NHSYNC;
-
-	if (mode->flags & DRM_MODE_FLAG_NVSYNC)
-		val |= SUN8I_HDMI_PHY_DBG_CTRL_POL_NVSYNC;
-
-	regmap_update_bits(phy->regs, SUN8I_HDMI_PHY_DBG_CTRL_REG,
-			   SUN8I_HDMI_PHY_DBG_CTRL_POL_MASK, val);
-};
-
-static void sun8i_a83t_hdmi_phy_disable(struct dw_hdmi *hdmi, void *data)
-{
-	struct sun8i_hdmi_phy *phy = data;
-
-	dw_hdmi_phy_gen2_txpwron(hdmi, 0);
-	dw_hdmi_phy_gen2_pddq(hdmi, 1);
-
-	regmap_update_bits(phy->regs, SUN8I_HDMI_PHY_REXT_CTRL_REG,
-			   SUN8I_HDMI_PHY_REXT_CTRL_REXT_EN, 0);
-}
-
 static void sun8i_h3_hdmi_phy_disable(struct dw_hdmi *hdmi, void *data)
 {
 	struct sun8i_hdmi_phy *phy = data;
@@ -385,14 +390,6 @@ static void sun8i_h3_hdmi_phy_disable(struct dw_hdmi *hdmi, void *data)
 	regmap_write(phy->regs, SUN8I_HDMI_PHY_PLL_CFG1_REG, 0);
 }
 
-static const struct dw_hdmi_phy_ops sun8i_a83t_hdmi_phy_ops = {
-	.init		= sun8i_a83t_hdmi_phy_config,
-	.disable	= sun8i_a83t_hdmi_phy_disable,
-	.read_hpd	= dw_hdmi_phy_read_hpd,
-	.update_hpd	= dw_hdmi_phy_update_hpd,
-	.setup_hpd	= dw_hdmi_phy_setup_hpd,
-};
-
 static const struct dw_hdmi_phy_ops sun8i_h3_hdmi_phy_ops = {
 	.init		= sun8i_h3_hdmi_phy_config,
 	.disable	= sun8i_h3_hdmi_phy_disable,
-- 
2.35.1

