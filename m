Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6A514FCDF7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 06:29:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237921AbiDLEbY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 00:31:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346076AbiDLEaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 00:30:52 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16D19329B9;
        Mon, 11 Apr 2022 21:28:36 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id CA24A3200E89;
        Tue, 12 Apr 2022 00:28:34 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 12 Apr 2022 00:28:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1649737714; x=1649824114; bh=pV
        iO7HIKIf4dMoO0uJmq0mI9NZl0JOyJSqx5Pze8sH8=; b=qQCbEGNN43a+DD6e8j
        Mg8YwZHtuoxgHNPDU4rhKy42kSUIFaGCpGw+G48HZlVq1dRIgi1Hmqzy6KVtD6kA
        p5LSTdfdyso4Xt1SFhYks3kCDaUg2a2uTeW8sHTUaQKeQ+D2yJw2e+Sy4dSz0F7n
        kXgGmbTtrzE9Vh5QFXZJ1s4lQxTVZB8/r5zP619zSRI9oJjOVp0PR7CLeu9lSAmJ
        CFIRcrHCsQ6dGvhgKhIiAWMdvB7reqvLsCzENBxKJYWW8XYcvyFXayQd63s8ifU6
        tEdIhADcCqByI4MEtdEgFF5qrKvFux53pxzdbu/RSR+L7eQBWS1BIGn6Kj69UPxh
        V8fw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1649737714; x=1649824114; bh=pViO7HIKIf4dMoO0uJmq0mI9NZl0JOyJSqx
        5Pze8sH8=; b=ilPMGYwKh63O1bvyy6mVVLselDJxvAa6ZHpe+XBhQOskkJoqBJE
        ofNEeRTRQfu1VjYH/cBS/HtRvpvbFrBeXTDbVF4UkbJrzFV+HpdARz+u2lltNql9
        zHyOihuzFf2kaxM/fXoyoHbHeYiNXL+EYP4EvWdRNWKbGYZPRQjIsrWcEJOCgKwR
        YCvZrmg9CsUukaqCbBn53Y50tseIVi8jnh09kJuYIEB0oism/OKZPqaOE1fAUNSO
        9HgWLKeEWqg6OcdQOMQOuR6REVayFVbpRRKcyGrM5kS6hActUHSi9WlAt2t7yUS4
        0WqjVEnnBtKcW2hB5fFaUnSz5adaTj95Qrg==
X-ME-Sender: <xms:8v9UYhxVmp2Ep3e8fLqJxsY3Ib_-5itme99mcoHmQV994W9apBUl4Q>
    <xme:8v9UYhSB88i1zNc8IlL5ZPhzTfEUi5gmKdmYKX4oO9CqngekbI5xbelrNpBjXMweI
    -7Y9UmUVdPmaUd34g>
X-ME-Received: <xmr:8v9UYrVFdqNsOv0RLNBBpsJlkh6A6697L1PRFWwFpi_WyCdRchK-XQJ5ytVv1HYPu8fF08ujSv0EK84Glq5LgvvPuMs5l0FpUpLv12Ju7E5Uf3VB3eKtdAbSwmjRojFLXXU-Sg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudekjedgkeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpeduhfejfedvhffgfeehtefghfeiiefgfeehgfdvvdevfeegjeehjedv
    gfejheeuieenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:8v9UYji4u1mhnZWrB29vVuicwZHUibufyz6TPwfZvBy_E9M4oWPUww>
    <xmx:8v9UYjCEU3z0xSUKV7QGA-T2mtvIySin5lWVz_91CRAHwMPbQoBTow>
    <xmx:8v9UYsIEefXfhL8hI0-kjHjejbUtzYlGH2Rie51XDjJIYnYLJ2TRqw>
    <xmx:8v9UYgLMQWzP9Xr8OL6iVGz-LGrS-pB5j3kSGH73MfCGQjGNfiX0_g>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Apr 2022 00:28:33 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maxime Ripard <mripard@kernel.org>
Cc:     Samuel Holland <samuel@sholland.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev
Subject: [PATCH v2 08/14] sun4i/drm: sun8i: use mode_set engine callback
Date:   Mon, 11 Apr 2022 23:28:00 -0500
Message-Id: <20220412042807.47519-9-samuel@sholland.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220412042807.47519-1-samuel@sholland.org>
References: <20220412042807.47519-1-samuel@sholland.org>
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

From: Jernej Skrabec <jernej.skrabec@gmail.com>

Newly introduced mode_set callback in engine structure is a much better
place for setting mixer output size and interlace mode for the following
reasons:
1. Aforementioned properties change only when mode changes, so it's
   enough to be set only once per mode set. Currently it's done whenever
   properties of primary plane are changed.
2. It's assumed that primary plane will always cover whole screen. While
   this is true most of the time, it's not always. DE2/3 planes are
   universal and mostly equal in functionality. There is no reason to
   add artificial limitation to primary planes.
3. The current code only works for UI layers, but some mixers do not
   have any UI layers.

Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
[Samuel: update commit message]
Signed-off-by: Samuel Holland <samuel@sholland.org>
---

Changes in v2:
 - Use Jernej's patches for mixer mode setting.

 drivers/gpu/drm/sun4i/sun8i_mixer.c    | 30 ++++++++++++++++++++++++++
 drivers/gpu/drm/sun4i/sun8i_ui_layer.c | 30 --------------------------
 2 files changed, 30 insertions(+), 30 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.c b/drivers/gpu/drm/sun4i/sun8i_mixer.c
index f5e8aeaa3cdf..6b1711a9a71f 100644
--- a/drivers/gpu/drm/sun4i/sun8i_mixer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_mixer.c
@@ -298,9 +298,39 @@ static struct drm_plane **sun8i_layers_init(struct drm_device *drm,
 	return planes;
 }
 
+static void sun8i_mixer_mode_set(struct sunxi_engine *engine,
+				 const struct drm_display_mode *mode)
+{
+	struct sun8i_mixer *mixer = engine_to_sun8i_mixer(engine);
+	u32 bld_base, size, val;
+	bool interlaced;
+
+	bld_base = sun8i_blender_base(mixer);
+	interlaced = !!(mode->flags & DRM_MODE_FLAG_INTERLACE);
+	size = SUN8I_MIXER_SIZE(mode->hdisplay, mode->vdisplay);
+
+	DRM_DEBUG_DRIVER("Updating global size W: %u H: %u\n",
+			 mode->hdisplay, mode->vdisplay);
+
+	regmap_write(engine->regs, SUN8I_MIXER_GLOBAL_SIZE, size);
+	regmap_write(engine->regs, SUN8I_MIXER_BLEND_OUTSIZE(bld_base), size);
+
+	if (interlaced)
+		val = SUN8I_MIXER_BLEND_OUTCTL_INTERLACED;
+	else
+		val = 0;
+
+	regmap_update_bits(engine->regs, SUN8I_MIXER_BLEND_OUTCTL(bld_base),
+			   SUN8I_MIXER_BLEND_OUTCTL_INTERLACED, val);
+
+	DRM_DEBUG_DRIVER("Switching display mixer interlaced mode %s\n",
+			 interlaced ? "on" : "off");
+}
+
 static const struct sunxi_engine_ops sun8i_engine_ops = {
 	.commit		= sun8i_mixer_commit,
 	.layers_init	= sun8i_layers_init,
+	.mode_set	= sun8i_mixer_mode_set,
 };
 
 static const struct regmap_config sun8i_mixer_regmap_config = {
diff --git a/drivers/gpu/drm/sun4i/sun8i_ui_layer.c b/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
index 7845c2a53a7f..4632dea2dc1e 100644
--- a/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
@@ -120,36 +120,6 @@ static int sun8i_ui_layer_update_coord(struct sun8i_mixer *mixer, int channel,
 	insize = SUN8I_MIXER_SIZE(src_w, src_h);
 	outsize = SUN8I_MIXER_SIZE(dst_w, dst_h);
 
-	if (plane->type == DRM_PLANE_TYPE_PRIMARY) {
-		bool interlaced = false;
-		u32 val;
-
-		DRM_DEBUG_DRIVER("Primary layer, updating global size W: %u H: %u\n",
-				 dst_w, dst_h);
-		regmap_write(mixer->engine.regs,
-			     SUN8I_MIXER_GLOBAL_SIZE,
-			     outsize);
-		regmap_write(mixer->engine.regs,
-			     SUN8I_MIXER_BLEND_OUTSIZE(bld_base), outsize);
-
-		if (state->crtc)
-			interlaced = state->crtc->state->adjusted_mode.flags
-				& DRM_MODE_FLAG_INTERLACE;
-
-		if (interlaced)
-			val = SUN8I_MIXER_BLEND_OUTCTL_INTERLACED;
-		else
-			val = 0;
-
-		regmap_update_bits(mixer->engine.regs,
-				   SUN8I_MIXER_BLEND_OUTCTL(bld_base),
-				   SUN8I_MIXER_BLEND_OUTCTL_INTERLACED,
-				   val);
-
-		DRM_DEBUG_DRIVER("Switching display mixer interlaced mode %s\n",
-				 interlaced ? "on" : "off");
-	}
-
 	/* Set height and width */
 	DRM_DEBUG_DRIVER("Layer source offset X: %d Y: %d\n",
 			 state->src.x1 >> 16, state->src.y1 >> 16);
-- 
2.35.1

