Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55A144FCDF3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 06:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346161AbiDLEbD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 00:31:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346213AbiDLEas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 00:30:48 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1643232EE3;
        Mon, 11 Apr 2022 21:28:30 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 7C5A03201F24;
        Tue, 12 Apr 2022 00:28:28 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 12 Apr 2022 00:28:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1649737708; x=1649824108; bh=4n
        wYaXxDyOycdxQgOz6ehxTPViKo4RhrkjN+WH6iVtY=; b=qvraaC7W7woakTPyuM
        dDp0M4+H5ECMAk7SP/ZtytJHc38AXNatMR/0f3QYSOnjj969Wz9T1QF8H1mqiaUC
        tpDMnXAbFTQpVketbx51dJmVj5Vi3QZeAGJ2Ch6eS06ewjkQGU6HgWm9VlxTR4bD
        8U+yLQ9oDTzt40oJwuI5A4eoZw7ydIwlqB4DTUy/0w7GWk7ifX2un3o2OTdGRl/1
        TjzJP9Rb09EHWIsoEBgsX3FqCdV7g1U//oZZusR663EtnvK94hv6/VcgNjwPdi3A
        oJ2LyFm1HSrqzcF05EknqvIyUBCquIHcJxTDl6qjWZpkI0l0haMX/YbgUEBCRpzj
        KqBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1649737708; x=1649824108; bh=4nwYaXxDyOycdxQgOz6ehxTPViKo4RhrkjN
        +WH6iVtY=; b=ZMhxt6q5rqlrseSb5/1nLbuHOKYd2FSnU4QASLlC/43n/H5HFFU
        pjcUHTTWj5fBmoAY6OiAv3kGpJ9VE9dtuXJ6Xp/Cfh9vUYgiZd0Sxin5FXaBkLyM
        aERWITzaVcQ3frkNOcjzCy1pkYhuTRSx0GvmcxVvmZCRKOPU7WJEI8zHRebkOORi
        mPjsRH5onSfoM2qKf/c8jvt97biyLnlZQUKWw2SxCvcmwXsoytvwxP29y2/JHuK5
        /ECgL9bEgyu37kOAoi9xQqYGB3gGPcogiBYI2GUlDXqFxLmmSFnE4AH1Z9GFPQZY
        KuHnHakljkMHhOV/810C/YX7jytmOU3nqZA==
X-ME-Sender: <xms:6_9UYhhOc9T__b-4fn_IL-3zexro7NDz8urmSJMctELMU4FVBNSjEw>
    <xme:6_9UYmDsVyOsr2evmxdvoDtqr6B0lgrbXBjYbZ9VU9-Yp1QTWkw0_xs0NAw1-g6BM
    kD4zfvvEQkNBK5xPw>
X-ME-Received: <xmr:6_9UYhE9rioYz4bufuf-83zrXMwiG6XTZhUXClHcWIZJ6fVHDzHZN1v_SubTRMLOjBKdcNky2CS5EHflO2KZdC6LIkGDGsCy9pXpOJE7ljVdtQqK6QKJT125OHdxvYokOTccuA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudekjedgkeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpeduhfejfedvhffgfeehtefghfeiiefgfeehgfdvvdevfeegjeehjedv
    gfejheeuieenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:7P9UYmSynAWhJW-9d24rvzsGcSIB5mr4gmKUVcVbSb36Dvt8g2zEmQ>
    <xmx:7P9UYuyQcZRHKuYL5Su9ED6LCHr1sfswWbYh6hSvLsWEyverZa1-DA>
    <xmx:7P9UYs5YBf--WHCx_WCndKqtfpZzjWs1jGxa8xn7LnuIdcEJTBpXkg>
    <xmx:7P9UYg47-4afUBMi-EtU2vzc619369SSnY2-o7wxdqPduXeEf2T8fw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Apr 2022 00:28:27 -0400 (EDT)
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
Subject: [PATCH v2 06/14] sun4i/drm: engine: Add mode_set callback
Date:   Mon, 11 Apr 2022 23:27:58 -0500
Message-Id: <20220412042807.47519-7-samuel@sholland.org>
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

This optional callback is useful for setting properties which depends
only on current mode. Such properties are width, height and interlaced
output.

These properties are currently set in update layer callback for primary
plane which is less than ideal. More about that in follow up patches,
which will migrate that code to this newly defined callback.

Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
Signed-off-by: Samuel Holland <samuel@sholland.org>
---

Changes in v2:
 - Use Jernej's patches for mixer mode setting.

 drivers/gpu/drm/sun4i/sun4i_crtc.c   |  1 +
 drivers/gpu/drm/sun4i/sunxi_engine.h | 27 +++++++++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun4i_crtc.c b/drivers/gpu/drm/sun4i/sun4i_crtc.c
index 45d9eb552d86..c06d7cd45388 100644
--- a/drivers/gpu/drm/sun4i/sun4i_crtc.c
+++ b/drivers/gpu/drm/sun4i/sun4i_crtc.c
@@ -146,6 +146,7 @@ static void sun4i_crtc_mode_set_nofb(struct drm_crtc *crtc)
 	struct sun4i_crtc *scrtc = drm_crtc_to_sun4i_crtc(crtc);
 
 	sun4i_tcon_mode_set(scrtc->tcon, encoder, mode);
+	sunxi_engine_mode_set(scrtc->engine, mode);
 }
 
 static const struct drm_crtc_helper_funcs sun4i_crtc_helper_funcs = {
diff --git a/drivers/gpu/drm/sun4i/sunxi_engine.h b/drivers/gpu/drm/sun4i/sunxi_engine.h
index 548710a936d5..ec8cf9b2bda4 100644
--- a/drivers/gpu/drm/sun4i/sunxi_engine.h
+++ b/drivers/gpu/drm/sun4i/sunxi_engine.h
@@ -9,6 +9,7 @@
 struct drm_plane;
 struct drm_device;
 struct drm_crtc_state;
+struct drm_display_mode;
 
 struct sunxi_engine;
 
@@ -108,6 +109,17 @@ struct sunxi_engine_ops {
 	 * This function is optional.
 	 */
 	void (*vblank_quirk)(struct sunxi_engine *engine);
+
+	/**
+	 * @mode_set
+	 *
+	 * This callback is used to set mode related parameters
+	 * like interlacing, screen size, etc. once per mode set.
+	 *
+	 * This function is optional.
+	 */
+	void (*mode_set)(struct sunxi_engine *engine,
+			 const struct drm_display_mode *mode);
 };
 
 /**
@@ -181,4 +193,19 @@ sunxi_engine_disable_color_correction(struct sunxi_engine *engine)
 	if (engine->ops && engine->ops->disable_color_correction)
 		engine->ops->disable_color_correction(engine);
 }
+
+/**
+ * sunxi_engine_mode_set - Inform engine of a new mode
+ * @engine:	pointer to the engine
+ * @mode:	new mode
+ *
+ * Engine can use this functionality to set specifics once per mode change.
+ */
+static inline void
+sunxi_engine_mode_set(struct sunxi_engine *engine,
+		      const struct drm_display_mode *mode)
+{
+	if (engine->ops && engine->ops->mode_set)
+		engine->ops->mode_set(engine, mode);
+}
 #endif /* _SUNXI_ENGINE_H_ */
-- 
2.35.1

