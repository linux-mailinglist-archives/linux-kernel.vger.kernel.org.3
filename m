Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D0A84FCE10
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 06:37:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346408AbiDLEih (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 00:38:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345280AbiDLEhn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 00:37:43 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5415029808
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 21:35:27 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 34E1E320187F;
        Tue, 12 Apr 2022 00:35:26 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 12 Apr 2022 00:35:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1649738125; x=1649824525; bh=po
        1u18MMNswH4cvKo16gtsd+jdi6t7nk240OGXF6/mc=; b=VTO/cBA0IyWJoApth6
        DjTKgtmbAgh9LJ6C/bVvZ3Rj0gnFVEiZHKDt1R5I8qd2Gz+7KM580jeAL/d1zeYw
        BX0JztCYOOs6CvgDj2AYXcrO7DrEgHm8SQukDoy1LOcWxSUoD7uSboEMLUAAVebj
        jcCnAd6jrEHVV76QbJrvOjpvqmr6VE3OZW2q/mubPPP5Kazdfykj7DeTFR7w3cRi
        FJYptEUG2bSspvbzUJluII1mrGV9PuIG8EVFgv0rbkrgsiWoKtgGFRss0mikYxB6
        Mvv2gOCNNogLD2M6vq63VJsfFdIRRXmaCYrjVVWSl6ipTWeOHwFSsQgSq3PmemfE
        TsFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1649738125; x=1649824525; bh=po1u18MMNswH4cvKo16gtsd+jdi6t7nk240
        OGXF6/mc=; b=Ce3k0/N+s9Stu6mPKa+3tEDbO9TW1KX286BYWz7ur3G3f/21oqr
        0IVGXy5v6acIQzgD6ghdh3wk5+byRDhmv8rMk31j08xUT237M311IF9ZDTU9hmvz
        6mfgNCG/u0bH7lFLE/YU2M604ZFB/jRA55RxDVM6wB2pRPUCfmVU7YpsToIwtjOW
        GW1eC7vop7Ay4E2hOnWMYskqugWJPs9ME6cqaCvBct6vhDqbgAHmfsI32NQ31ICE
        TI9EISmsffMgB8yhkdwX/kA1EGqp2BWZbev73srfsSiKfNJZyVh3rsbEw1hMW7N1
        6/41TaVT9OkVU2/InBo/OCCVab1dj/pkurg==
X-ME-Sender: <xms:jQFVYuq_Ixpl0S-OcxEs_vaG7Tam7f-4oJvr4lz697HGd0Mvk9YqEA>
    <xme:jQFVYsoOU1_mFeyhz2EFzXM9HJBEPb8iLK1NLqcnM4yDylqro6mAafKyz8YUE6UlF
    9r2GI3vWeHRoV1zyg>
X-ME-Received: <xmr:jQFVYjMgP_skeMPVurX1GQ3_DJcht6QUxRFmuCwTn9SVD0cIXUtN968-5AnnRhc7rSx5-aEDDzPec_XwX_qYWezXXcnO2YFtvK3j2xPhbrNvnR11qP58Ykl5PZJ-htHqciD46A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudekjedgkedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpeduhfejfedvhffgfeehtefghfeiiefgfeehgfdvvdevfeegjeehjedv
    gfejheeuieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:jQFVYt7ztd77EaYOZGeLm8DuijWiT4CMa9sUM8g3xRNxqoyPf7ksWA>
    <xmx:jQFVYt4Nft1vlYZdkOVQkyOsc9t6OqBvHCvGQgkrtY2FtfuDxAFzaA>
    <xmx:jQFVYtj3r1z9En4gyrB4o-0b_nEDj2DsckQisfz6_6mX9QsNJZDY1w>
    <xmx:jQFVYiHIx9WUPKCqNZ194QRpVBfd9wqcPXcAnEDl0AUsuDqODSSeBw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Apr 2022 00:35:25 -0400 (EDT)
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
Subject: [PATCH 4/6] drm/sun4i: sun8i-hdmi-phy: Support multiple custom PHY ops
Date:   Mon, 11 Apr 2022 23:35:09 -0500
Message-Id: <20220412043512.49364-5-samuel@sholland.org>
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

The D1 SoC comes with a new custom HDMI PHY, which does not share any
registers with the existing custom PHY. So it needs a new set of ops.
Instead of providing a flag in the variant structure, provide the ops
themselves.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

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
index 1351e633d485..71062e4e8666 100644
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

