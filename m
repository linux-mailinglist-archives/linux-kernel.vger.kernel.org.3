Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDD694FB2F2
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 06:36:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244681AbiDKEh2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 00:37:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237387AbiDKEhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 00:37:00 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ECE9AE70;
        Sun, 10 Apr 2022 21:34:46 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 8B2083201F24;
        Mon, 11 Apr 2022 00:34:45 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 11 Apr 2022 00:34:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1649651685; x=1649738085; bh=dV
        6axH3/ykmO8vUfS4KlQCnk6Z++gzInmDF0xTlcbdk=; b=gp5qekperI4VFnl6Me
        RmvGnnnZEKAzcp6PuSYfi+rzeLj3ZtH5G5qGDz32qtAYEqWSaZa/eo4Tnf/EoxwA
        +rd62xGKF8WiYGcklanb5/090dwWhDcmClcvJCkAkzOiLdvydayMslZMacpN5Ky/
        aDZepD1df+7qBHhn1P48ltuZGQuW2LCgRWdlnsGj/uWueFml/GGtz2iFy3NObRUD
        +EdYptcpYQL9cUCE5zGmGyKq/+lsYW/negEnMvaSxJN7pdJgw8f9f4tkLCLy0/WB
        ty2yJOJRgpT39sHIWilHHKykQrgzwl2Hitt8NEt+jjM3jGWGxBHXf1k/ig7YmBZz
        Z4sg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1649651685; x=1649738085; bh=dV6axH3/ykmO8vUfS4KlQCnk6Z++gzInmDF
        0xTlcbdk=; b=jsjVoBhU1ztzQyOb8kQ61N3J1gp1NWoAet2nMt55WG31Xj8vzLr
        SBDwFQ8Wt+GVY34GLH2KTO7rFGYqQ01mllZUhU4ntnlfKEoocT/idKAu62i3IvDx
        OK/ua8HllVJaBd9T3NrevcIYHKIkSG/Ad769+dnnkSaFL5jgJx6nquX6t0My5it0
        o/iTFyLyIL9ASXTFXAHlSBR8KVuW+4jkmUcWz+ad8QeZdW3D2og/FERGSMmzVPRn
        x04Enmz2tb7qc+AIarnMgYY0AD5GUjSmYHrvlhhiykMJbc/pMJzLLxEF47mj7gbd
        Tc/pohZKT4APsbODmzZLFcW5o+nzWjzo9Vg==
X-ME-Sender: <xms:5a9TYnQt7yezjhW54d1yEH4Zmhg2wbvMjx-8avdKHGgcTu2aVCjEzg>
    <xme:5a9TYoyukqq3L74xehmGpALxOh-Et_fIFHVS7pU-R3Zk6ZTBEyIsUWxhBzsQTlMMo
    JwKagEtDtQNKkpWCQ>
X-ME-Received: <xmr:5a9TYs1xtrHrE7Pg_YqOBK3qFgd61m5Ltm-X1iPluZGtwqVzxOQ-VdIAK6hl8fW-7eyJoBw7f5mmNPIfhRH2STvEyFoOoXSg8c8U6dP0rcCUKm_0f-coE6DtRN2zpxNDL9vAIA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudekhedgkedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpeduhfejfedvhffgfeehtefghfeiiefgfeehgfdvvdevfeegjeehjedv
    gfejheeuieenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:5a9TYnAOzIgYCUBUlXLdfx38nwQLru6OZG8MMOAHSUzAesQm6cBrIw>
    <xmx:5a9TYgiKXj-TV7UihJsBXjYU_eFkBkYYfsLiWGA3iVr8iLjnAppS0g>
    <xmx:5a9TYrqRipuU9pchi6va5UXHLggYI3XfiSnVeMJf5UYW2W5EzjLJ3w>
    <xmx:5a9TYvqGMJqX62nfra0nf5nuFtE01jweIpvVYO0DimRigkMjEN2sAA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Apr 2022 00:34:44 -0400 (EDT)
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
Subject: [PATCH 06/10] drm/sun4i: Allow VI layers to be primary planes
Date:   Sun, 10 Apr 2022 23:34:18 -0500
Message-Id: <20220411043423.37333-7-samuel@sholland.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220411043423.37333-1-samuel@sholland.org>
References: <20220411043423.37333-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

D1's mixer 1 has no UI layers, only a single VI layer. That means the
mixer can only be used if the primary plane comes from this VI layer.
Add the code to handle this case, setting the mixer's global registers
in the same way as when the primary plane comes from a UI layer.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

 drivers/gpu/drm/sun4i/sun8i_vi_layer.c | 36 +++++++++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c b/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
index bb7c43036dfa..86212cb2098c 100644
--- a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
@@ -146,6 +146,36 @@ static int sun8i_vi_layer_update_coord(struct sun8i_mixer *mixer, int channel,
 	insize = SUN8I_MIXER_SIZE(src_w, src_h);
 	outsize = SUN8I_MIXER_SIZE(dst_w, dst_h);
 
+	if (plane->type == DRM_PLANE_TYPE_PRIMARY) {
+		bool interlaced = false;
+		u32 val;
+
+		DRM_DEBUG_DRIVER("Primary layer, updating global size W: %u H: %u\n",
+				 dst_w, dst_h);
+		regmap_write(mixer->engine.regs,
+			     SUN8I_MIXER_GLOBAL_SIZE,
+			     outsize);
+		regmap_write(mixer->engine.regs,
+			     SUN8I_MIXER_BLEND_OUTSIZE(bld_base), outsize);
+
+		if (state->crtc)
+			interlaced = state->crtc->state->adjusted_mode.flags
+				& DRM_MODE_FLAG_INTERLACE;
+
+		if (interlaced)
+			val = SUN8I_MIXER_BLEND_OUTCTL_INTERLACED;
+		else
+			val = 0;
+
+		regmap_update_bits(mixer->engine.regs,
+				   SUN8I_MIXER_BLEND_OUTCTL(bld_base),
+				   SUN8I_MIXER_BLEND_OUTCTL_INTERLACED,
+				   val);
+
+		DRM_DEBUG_DRIVER("Switching display mixer interlaced mode %s\n",
+				 interlaced ? "on" : "off");
+	}
+
 	/* Set height and width */
 	DRM_DEBUG_DRIVER("Layer source offset X: %d Y: %d\n",
 			 (state->src.x1 >> 16) & ~(format->hsub - 1),
@@ -542,6 +572,7 @@ struct sun8i_vi_layer *sun8i_vi_layer_init_one(struct drm_device *drm,
 					       struct sun8i_mixer *mixer,
 					       int index)
 {
+	enum drm_plane_type type = DRM_PLANE_TYPE_OVERLAY;
 	u32 supported_encodings, supported_ranges;
 	unsigned int plane_cnt, format_count;
 	struct sun8i_vi_layer *layer;
@@ -560,12 +591,15 @@ struct sun8i_vi_layer *sun8i_vi_layer_init_one(struct drm_device *drm,
 		format_count = ARRAY_SIZE(sun8i_vi_layer_formats);
 	}
 
+	if (!mixer->cfg->ui_num && index == 0)
+		type = DRM_PLANE_TYPE_PRIMARY;
+
 	/* possible crtcs are set later */
 	ret = drm_universal_plane_init(drm, &layer->plane, 0,
 				       &sun8i_vi_layer_funcs,
 				       formats, format_count,
 				       sun8i_layer_modifiers,
-				       DRM_PLANE_TYPE_OVERLAY, NULL);
+				       type, NULL);
 	if (ret) {
 		dev_err(drm->dev, "Couldn't initialize layer\n");
 		return ERR_PTR(ret);
-- 
2.35.1

