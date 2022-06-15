Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 001E254C0EE
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 06:58:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242162AbiFOE4G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 00:56:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239557AbiFOEz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 00:55:59 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F89231344
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 21:55:59 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 992F632002D8;
        Wed, 15 Jun 2022 00:55:57 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 15 Jun 2022 00:55:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1655268957; x=1655355357; bh=dC
        BZtoBVILfECus7qg2DlxiYpAC2GWJbCJsguToVhOk=; b=elluduuYcLPXejHCGK
        G5buTngPVkEDpO5e4o0+xspJIUlDhzNphtJGwuR0xX87rma81mB62cbz6/y4sqVX
        lm2Q0vAUh6HokDEWBseuYzWkrW71gpfVAVsZ72NUrWm00yD1MCOaFpjiWhHG262j
        JVsJja6Qt/leHqDei117zWof1Fu2At92OmhuqQ7P111PPOL0C8MmSQhHjRzG2CKh
        ghD25lqu3S70JwDarw1a8RoLkRR6mqzMZA+Mrdfrdjhcv8ZsUndmz7bGZkQUceB8
        NsUPYUqvcDbXa0E9BTVCH/0nIBEwH0ExgMw3hoWNluEf1xnSc3KzAs9uL5vdtb6l
        EtCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1655268957; x=1655355357; bh=dCBZtoBVILfEC
        us7qg2DlxiYpAC2GWJbCJsguToVhOk=; b=mPfnY6KuBDJepHeoCODh/H5Hn15dd
        RGgyvx1NQYXFrN8swknzQqsHF1QF0juug7EIGNk1dTxiqmV11WCLhwQBzzaf6b+2
        7DMHJXkXUk4nQyf7idfBPycmJgKtnsgT1+LApqKYkO6605wSLHLNUpPtSKDZo1FS
        UgEyHBfinMGhGdnQe8tPuKCAxzllWcwjXvUC83vSGDgMQNdHq/3mvQlbMjedMRE9
        31QFHLfP7Pub/1tTEurM/kzFVujrBbT6IWRDeMwlSdgp/xdKcyMYN4CmY29YrJWd
        UZ4S/nBykJUEvXh0osDyfa8kWbkCh7hvLtXBLRYzKLOTYQzIKzZaJt/6g==
X-ME-Sender: <xms:XGapYj_X2VD3V5cXKuXXS7nKEyTch1b_ML8AIhghJq4iJLWOv021kQ>
    <xme:XGapYvtbLXyWnfcburViWULPoNqS2L3Ib2WawWnw0vqKyP7nCuqNLhI2PATgDJvK6
    tUUAUMx-E7Dr4XSPw>
X-ME-Received: <xmr:XGapYhAEuAyyZa9v1-dMLmSGDJye_Lw1u2CIB3p2D_gjkwoIJAUIcAXe35tCp30uYGuow4lwexpFB8CZ3fILewV3YaF3oqxtecpEoioewau8s8TwXnqg8LWmyavwzlQ646HStA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedruddvtddgkeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepudekteeuudehtdelteevgfduvddvjefhfedulefgudevgeeghefg
    udefiedtveetnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrh
    homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:XWapYveGo6E9X9Ot7e9IijrAU2DF2SSWjLq--s-47v_quKW41O6xYw>
    <xmx:XWapYoMl2pcAZr2GZtgSjqkdaH1zCi1EOw4tEFe5Flw90pXrCE12kQ>
    <xmx:XWapYhlHQFU1lLuZ6HeV3NZeukvzHKFCIR1jOJaIW88Jy0vtD9px3g>
    <xmx:XWapYnpTlDY2uafrkyeAsE2SSoEUxgZn5zfLTMdWFh3SMl_g-7ufuA>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Jun 2022 00:55:56 -0400 (EDT)
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
Subject: [PATCH v2 4/6] drm/sun4i: sun8i-hdmi-phy: Support multiple custom PHY ops
Date:   Tue, 14 Jun 2022 23:55:41 -0500
Message-Id: <20220615045543.62813-5-samuel@sholland.org>
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

The D1 SoC comes with a new custom HDMI PHY, which does not share any
registers with the existing custom PHY. So it needs a new set of ops.
Instead of providing a flag in the variant structure, provide the ops
themselves.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

(no changes since v1)

 drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h  |  2 +-
 drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c | 12 ++++++------
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h
index 0adbfac6eb31..f0b1aaad27d9 100644
--- a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h
+++ b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h
@@ -151,10 +151,10 @@ struct sun8i_hdmi_phy;
 struct sun8i_hdmi_phy_variant {
 	bool has_phy_clk;
 	bool has_second_pll;
-	unsigned int is_custom_phy : 1;
 	const struct dw_hdmi_curr_ctrl *cur_ctr;
 	const struct dw_hdmi_mpll_config *mpll_cfg;
 	const struct dw_hdmi_phy_config *phy_cfg;
+	const struct dw_hdmi_phy_ops *phy_ops;
 	void (*phy_init)(struct sun8i_hdmi_phy *phy);
 	void (*phy_disable)(struct dw_hdmi *hdmi,
 			    struct sun8i_hdmi_phy *phy);
diff --git a/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c b/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c
index 9086ce547fad..e6d25bbe3d2f 100644
--- a/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c
+++ b/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c
@@ -567,8 +567,8 @@ void sun8i_hdmi_phy_set_ops(struct sun8i_hdmi_phy *phy,
 {
 	const struct sun8i_hdmi_phy_variant *variant = phy->variant;
 
-	if (variant->is_custom_phy) {
-		plat_data->phy_ops = &sun8i_hdmi_phy_ops;
+	if (variant->phy_ops) {
+		plat_data->phy_ops = variant->phy_ops;
 		plat_data->phy_name = "sun8i_dw_hdmi_phy";
 		plat_data->phy_data = phy;
 	} else {
@@ -587,7 +587,7 @@ static const struct regmap_config sun8i_hdmi_phy_regmap_config = {
 };
 
 static const struct sun8i_hdmi_phy_variant sun8i_a83t_hdmi_phy = {
-	.is_custom_phy = true,
+	.phy_ops = &sun8i_hdmi_phy_ops,
 	.phy_init = &sun8i_hdmi_phy_init_a83t,
 	.phy_disable = &sun8i_hdmi_phy_disable_a83t,
 	.phy_config = &sun8i_hdmi_phy_config_a83t,
@@ -595,7 +595,7 @@ static const struct sun8i_hdmi_phy_variant sun8i_a83t_hdmi_phy = {
 
 static const struct sun8i_hdmi_phy_variant sun8i_h3_hdmi_phy = {
 	.has_phy_clk = true,
-	.is_custom_phy = true,
+	.phy_ops = &sun8i_hdmi_phy_ops,
 	.phy_init = &sun8i_hdmi_phy_init_h3,
 	.phy_disable = &sun8i_hdmi_phy_disable_h3,
 	.phy_config = &sun8i_hdmi_phy_config_h3,
@@ -604,7 +604,7 @@ static const struct sun8i_hdmi_phy_variant sun8i_h3_hdmi_phy = {
 static const struct sun8i_hdmi_phy_variant sun8i_r40_hdmi_phy = {
 	.has_phy_clk = true,
 	.has_second_pll = true,
-	.is_custom_phy = true,
+	.phy_ops = &sun8i_hdmi_phy_ops,
 	.phy_init = &sun8i_hdmi_phy_init_h3,
 	.phy_disable = &sun8i_hdmi_phy_disable_h3,
 	.phy_config = &sun8i_hdmi_phy_config_h3,
@@ -612,7 +612,7 @@ static const struct sun8i_hdmi_phy_variant sun8i_r40_hdmi_phy = {
 
 static const struct sun8i_hdmi_phy_variant sun50i_a64_hdmi_phy = {
 	.has_phy_clk = true,
-	.is_custom_phy = true,
+	.phy_ops = &sun8i_hdmi_phy_ops,
 	.phy_init = &sun8i_hdmi_phy_init_h3,
 	.phy_disable = &sun8i_hdmi_phy_disable_h3,
 	.phy_config = &sun8i_hdmi_phy_config_h3,
-- 
2.35.1

