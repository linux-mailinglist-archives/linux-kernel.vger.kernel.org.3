Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B89605A4DBE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 15:20:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230516AbiH2NUo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 09:20:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230502AbiH2NUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 09:20:11 -0400
Received: from wnew2-smtp.messagingengine.com (wnew2-smtp.messagingengine.com [64.147.123.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E057868A5
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 06:17:55 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id 7FF612B06030;
        Mon, 29 Aug 2022 09:16:00 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 29 Aug 2022 09:16:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1661778960; x=
        1661786160; bh=HaNtO91X8wVp/AZd+CLfPSi0rxBzaPaGsS0q1kMO3AQ=; b=P
        SspWNLxyOHIFND0XwCfhQ2aYf/rmiRHAWMqStot70EXQWCaBKE5b9+EZR1p2yb4r
        mY6KQiCJWyhVru8bpb0lcyIOmbJDydDVGL1Cc6Cp6ZR1E4CQHHrv8+c99MZ8uZDg
        LnDGUqf7eih9BeEDW5oGmBesvj6C4UlnA4okbHEc3Rj+iYlG095D+IbBOErKhOH8
        b+u0UxlBaLEPFxtElyH2W+i2zb2nYjUs70b55okgmcIPOeJ1yHAwIMlWbNXMT5RR
        bllxPiteF6QrQGE6Q7CFkOIkG0xmLM8aOWNBvf1Vt7GknYG6sUYV9hn7uAqJt+10
        jf7RBDrQjzydabB6RN1Ag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1661778960; x=
        1661786160; bh=HaNtO91X8wVp/AZd+CLfPSi0rxBzaPaGsS0q1kMO3AQ=; b=1
        F0qVieGIST1yez16+8a4Mz82pbcvqCH9ddqWGKh/W2iGqvwP630MUUY7poBiK/ce
        TsC2Aa8fTkdtk0Abo6841ZDzQ6BDNbaQuuEH2srUpaEr1UIChcfDNxlQir0t/XWM
        x4hQqlPKNug31eeK6p0KlSahBhxZ15PB9Kfo8FZaKdsDZIlgNAeMF7zl7DigUlVN
        pEyceb1AcpT7fTacQks3HKQVxKfPnEdF+ybCCdE4xOTIPpNuZlh61cSPfwS6Hy2J
        6USBNwlw2mTcGCEZDWntG9dx7ybGTa7bWkFwhTIPoSgg2OD+D6RgjBOvtHdhQLk2
        1WxohkbZFdbdzUm2kqcRg==
X-ME-Sender: <xms:D7wMY85vOAm_67u7YQfstT2UOHeppy4eWpnzU--1S4Ubjqvz8yzqzg>
    <xme:D7wMY97KWJ_-9lpI2EONBa9dlqhviTGNC_l87mue3BsDarFYjmYEKUH-r3D8APx4c
    qfmcbILZ8CVujmKlBU>
X-ME-Received: <xmr:D7wMY7csGh9K5p8e4Y05DQ65tUTlrY8WC6Zusyu5m4Hd3hjZwaElEcexna_Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdekuddgieefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhggtgfogfesthhqredtredtjeenucfhrhhomhepofgr
    gihimhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtf
    frrghtthgvrhhnpeefiedvfefggffgffehveejieffuddtgffhjefggeetieduvdeileet
    lefgveegtdenucevlhhushhtvghrufhiiigvpeehnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:D7wMYxLg6PHiGTvaCOGkenCks7J0bihmUtKn0dyXBMpGV7vvv5iMdA>
    <xmx:D7wMYwJYU6Kk20wB2htDGhs0Yp7UPObgozVk0WPO8yi6y20OyYC0Cg>
    <xmx:D7wMYyzhTF1pfxXSHvVzIG2iwa_Tqe6VwrYXwVP7PP5rnO_iAFxPwQ>
    <xmx:ELwMYxjGGcu1a7aVhUezt1y2rjE71fsOF-tdPTkSV3C7Z4pXj9JVEkEGbpU>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Aug 2022 09:15:58 -0400 (EDT)
From:   Maxime Ripard <maxime@cerno.tech>
To:     Maxime Ripard <mripard@kernel.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>, Chen-Yu Tsai <wens@csie.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Lyude Paul <lyude@redhat.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Karol Herbst <kherbst@redhat.com>,
        =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Emma Anholt <emma@anholt.net>, Daniel Vetter <daniel@ffwll.ch>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc:     Maxime Ripard <maxime@cerno.tech>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-arm-kernel@lists.infradead.org,
        Phil Elwell <phil@raspberrypi.com>,
        intel-gfx@lists.freedesktop.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        dri-devel@lists.freedesktop.org, Dom Cobley <dom@raspberrypi.com>,
        linux-kernel@vger.kernel.org, nouveau@lists.freedesktop.org,
        linux-sunxi@lists.linux.dev,
        Mateusz Kwiatkowski <kfyatek+publicgit@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH v2 36/41] drm/sun4i: tv: Merge mode_set into atomic_enable
Date:   Mon, 29 Aug 2022 15:11:50 +0200
Message-Id: <20220728-rpi-analog-tv-properties-v2-36-459522d653a7@cerno.tech>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220728-rpi-analog-tv-properties-v2-0-459522d653a7@cerno.tech>
References: <20220728-rpi-analog-tv-properties-v2-0-459522d653a7@cerno.tech>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.10.0-dev-65ba7
X-Developer-Signature: v=1; a=openpgp-sha256; l=2077; i=maxime@cerno.tech; h=from:subject:message-id; bh=8f83P3U97bSAZ8QzllfF75YiPBqFH3osodi8Teklke8=; b=owGbwMvMwCX2+D1vfrpE4FHG02pJDMk8uxSPr+f6yCBW9/9izvzc6Iz4iQJvsqXPHAz1rYn9mCWQ 5jWlo5SFQYyLQVZMkSVG2HxJ3KlZrzvZ+ObBzGFlAhnCwMUpABNJ42f475z7reFT0/X19t18drN6tj A9Yww4MbVAb8pibYbLPd+T+Bj+x64KOXCkcffFr7y8KhdXbdVe3POP/bi8xo8fe7oDjZI52AE=
X-Developer-Key: i=maxime@cerno.tech; a=openpgp; fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Our mode_set implementation can be merged into our atomic_enable=0D
implementation to simplify things, so let's do this.=0D
=0D
Signed-off-by: Maxime Ripard <maxime@cerno.tech>=0D
=0D
diff --git a/drivers/gpu/drm/sun4i/sun4i_tv.c b/drivers/gpu/drm/sun4i/sun4i=
_tv.c=0D
index f7aad995ab5b..3944da9a3c34 100644=0D
--- a/drivers/gpu/drm/sun4i/sun4i_tv.c=0D
+++ b/drivers/gpu/drm/sun4i/sun4i_tv.c=0D
@@ -359,23 +359,13 @@ static void sun4i_tv_enable(struct drm_encoder *encod=
er,=0D
 {=0D
 	struct sun4i_tv *tv =3D drm_encoder_to_sun4i_tv(encoder);=0D
 	struct sun4i_crtc *crtc =3D drm_crtc_to_sun4i_crtc(encoder->crtc);=0D
-=0D
-	DRM_DEBUG_DRIVER("Enabling the TV Output\n");=0D
-=0D
-	sunxi_engine_apply_color_correction(crtc->engine);=0D
-=0D
-	regmap_update_bits(tv->regs, SUN4I_TVE_EN_REG,=0D
-			   SUN4I_TVE_EN_ENABLE,=0D
-			   SUN4I_TVE_EN_ENABLE);=0D
-}=0D
-=0D
-static void sun4i_tv_mode_set(struct drm_encoder *encoder,=0D
-			      struct drm_display_mode *mode,=0D
-			      struct drm_display_mode *adjusted_mode)=0D
-{=0D
-	struct sun4i_tv *tv =3D drm_encoder_to_sun4i_tv(encoder);=0D
+	struct drm_crtc_state *crtc_state =3D=0D
+		drm_atomic_get_new_crtc_state(state, encoder->crtc);=0D
+	struct drm_display_mode *mode =3D &crtc_state->mode;=0D
 	const struct tv_mode *tv_mode =3D sun4i_tv_find_tv_by_mode(mode);=0D
 =0D
+	DRM_DEBUG_DRIVER("Enabling the TV Output\n");=0D
+=0D
 	/* Enable and map the DAC to the output */=0D
 	regmap_update_bits(tv->regs, SUN4I_TVE_EN_REG,=0D
 			   SUN4I_TVE_EN_DAC_MAP_MASK,=0D
@@ -468,12 +458,17 @@ static void sun4i_tv_mode_set(struct drm_encoder *enc=
oder,=0D
 		      SUN4I_TVE_RESYNC_FIELD : 0));=0D
 =0D
 	regmap_write(tv->regs, SUN4I_TVE_SLAVE_REG, 0);=0D
+=0D
+	sunxi_engine_apply_color_correction(crtc->engine);=0D
+=0D
+	regmap_update_bits(tv->regs, SUN4I_TVE_EN_REG,=0D
+			   SUN4I_TVE_EN_ENABLE,=0D
+			   SUN4I_TVE_EN_ENABLE);=0D
 }=0D
 =0D
 static const struct drm_encoder_helper_funcs sun4i_tv_helper_funcs =3D {=0D
 	.atomic_disable	=3D sun4i_tv_disable,=0D
 	.atomic_enable	=3D sun4i_tv_enable,=0D
-	.mode_set	=3D sun4i_tv_mode_set,=0D
 };=0D
 =0D
 static int sun4i_tv_comp_get_modes(struct drm_connector *connector)=0D
=0D
-- =0D
b4 0.10.0-dev-65ba7=0D
