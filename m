Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46F325A4D6C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 15:17:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbiH2NRS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 09:17:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiH2NQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 09:16:43 -0400
Received: from wnew2-smtp.messagingengine.com (wnew2-smtp.messagingengine.com [64.147.123.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57EE73889
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 06:16:07 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.west.internal (Postfix) with ESMTP id AE7762B06070;
        Mon, 29 Aug 2022 09:14:47 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 29 Aug 2022 09:14:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1661778887; x=
        1661786087; bh=1ES+VOTkYU9rnnkPaBougZFX79N+rt0kzSsceGA4Dk4=; b=M
        wZDwK3QFSLqZ36eWW+KO1/5GMbyX9ChUPOFrT6PvlScVECJOImCcBqpeht8w8ulb
        ogPSElJUwpgl9ERxHhdYtTltYUcuc61gN7734nHtlWtRaVv3W1oLgMUWs0WmovQd
        TL6I56S0tCInc4Z4C4chLyUtsSJi9VsUP9bt2BKQ1ZgAzovM6anF2q9X8VN+g//i
        X5XyOmrXV2k22dO7KJN9awbAlfPmFj71KIxS1T/sTAoJhJ9CGWHnTVr2sgJGxvxe
        dALbZFQR7Q1cAQjvFgIC//wXd/dGuWblC/yp8GYpDBodShNTCxP15gZntj7/kB1t
        Stm31oKJUNCzO79AbBQmA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1661778887; x=
        1661786087; bh=1ES+VOTkYU9rnnkPaBougZFX79N+rt0kzSsceGA4Dk4=; b=w
        97fUtYA19t9UK+q9mCQiBJHAOH+axUa0YqjU5/XMg2iPAhrYN00M/6+SluyFgdvf
        +69/5+YyOapg1HP2UTkMEatEvoSPwR0PQCbSv/YotPgh4lz0W7BUzVnT30k8rzAg
        VKL4x5t9nxKpWEyWTlGWrfmfTFMLVq85MkX9iwj40BNVzDKqHVPbcvofyMQxSJHN
        joCulLM2R+sabLZx2wlXVUCXzLXm/v4rCL8Fv6/DwUT3AgFFRn8/FLXAWNortXTR
        aNbBzO2JuwTKj2hDrbcguqKooDv1VR8sEzLpZW4pzGWTxMa8d5GHgf4tx8/cQQjz
        orY73i1Jj6Vf+53W2hKGQ==
X-ME-Sender: <xms:x7sMYzTs4trYybJjPiDt8rdltEu4bzDju4zsuxh-loRZmiYgkNK-Ig>
    <xme:x7sMY0xmuzJTbpQqB_O5rDXh0g2ojoTozEijLZcKL4y12XugVgG34mLtP7AFXNRAG
    zwM4HWSIAhousDcpXY>
X-ME-Received: <xmr:x7sMY40uIyWCD4NzwRUYgnq-Fb1hckxwcQ6DtHjYlRmrhpWk0WOva_3OSEh5>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdekuddgieefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhggtgfogfesthhqredtredtjeenucfhrhhomhepofgr
    gihimhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtf
    frrghtthgvrhhnpeefiedvfefggffgffehveejieffuddtgffhjefggeetieduvdeileet
    lefgveegtdenucevlhhushhtvghrufhiiigvpeefnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:x7sMYzDsrOB5cbSBR3mdmof8mOIunJ4aU7m_S4sQFOHTIzZUMRkP8Q>
    <xmx:x7sMY8h0V56AVRtPSHBFDBMKVmBDqP4uk2IwP4NDzpT2aF5Llk0F0Q>
    <xmx:x7sMY3oFb5esYG9Y600cA1mdtUuyKvInXk2d5Se144IkyE_osfcitg>
    <xmx:x7sMYxaNo8zfdA562v1KyQlnIJixUP-awwbp95qZy1uWdNjq32yjL6vV64Y>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Aug 2022 09:14:46 -0400 (EDT)
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
Subject: [PATCH v2 25/41] drm/vc4: vec: Convert to atomic helpers
Date:   Mon, 29 Aug 2022 15:11:39 +0200
Message-Id: <20220728-rpi-analog-tv-properties-v2-25-459522d653a7@cerno.tech>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220728-rpi-analog-tv-properties-v2-0-459522d653a7@cerno.tech>
References: <20220728-rpi-analog-tv-properties-v2-0-459522d653a7@cerno.tech>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.10.0-dev-65ba7
X-Developer-Signature: v=1; a=openpgp-sha256; l=1629; i=maxime@cerno.tech; h=from:subject:message-id; bh=SxDDz/o7uhOTCndIHsGuYDX1d+DNJtbtuvzEgbuAGH4=; b=owGbwMvMwCX2+D1vfrpE4FHG02pJDMk8uxR+LFyY/Frnu8fpLtE/ZnOKX0TuDe6bF7j1w6svMbv/ emY87ihlYRDjYpAVU2SJETZfEndq1utONr55MHNYmUCGMHBxCsBEMtQZ/rtyan/KSFCUMIrkmjBRka PAOOmKk7KsuOHKvTGhUy0cHjH805uite6Zrn/J+68tOo77wpeGn/cQuD7t6ZTPD1ZZNcmeZgQA
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

The VC4 VEC driver still uses legacy enable and disable hook=0D
implementation. Let's convert to the atomic variants.=0D
=0D
Signed-off-by: Maxime Ripard <maxime@cerno.tech>=0D
=0D
diff --git a/drivers/gpu/drm/vc4/vc4_vec.c b/drivers/gpu/drm/vc4/vc4_vec.c=
=0D
index d521ffd8d75c..72eee0cbb615 100644=0D
--- a/drivers/gpu/drm/vc4/vc4_vec.c=0D
+++ b/drivers/gpu/drm/vc4/vc4_vec.c=0D
@@ -375,7 +375,8 @@ static int vc4_vec_connector_init(struct drm_device *de=
v, struct vc4_vec *vec)=0D
 	return 0;=0D
 }=0D
 =0D
-static void vc4_vec_encoder_disable(struct drm_encoder *encoder)=0D
+static void vc4_vec_encoder_disable(struct drm_encoder *encoder,=0D
+				    struct drm_atomic_state *state)=0D
 {=0D
 	struct drm_device *drm =3D encoder->dev;=0D
 	struct vc4_vec *vec =3D encoder_to_vc4_vec(encoder);=0D
@@ -406,7 +407,8 @@ static void vc4_vec_encoder_disable(struct drm_encoder =
*encoder)=0D
 	drm_dev_exit(idx);=0D
 }=0D
 =0D
-static void vc4_vec_encoder_enable(struct drm_encoder *encoder)=0D
+static void vc4_vec_encoder_enable(struct drm_encoder *encoder,=0D
+				   struct drm_atomic_state *state)=0D
 {=0D
 	struct drm_device *drm =3D encoder->dev;=0D
 	struct vc4_vec *vec =3D encoder_to_vc4_vec(encoder);=0D
@@ -508,9 +510,9 @@ static int vc4_vec_encoder_atomic_check(struct drm_enco=
der *encoder,=0D
 }=0D
 =0D
 static const struct drm_encoder_helper_funcs vc4_vec_encoder_helper_funcs =
=3D {=0D
-	.disable =3D vc4_vec_encoder_disable,=0D
-	.enable =3D vc4_vec_encoder_enable,=0D
 	.atomic_check =3D vc4_vec_encoder_atomic_check,=0D
+	.atomic_disable =3D vc4_vec_encoder_disable,=0D
+	.atomic_enable =3D vc4_vec_encoder_enable,=0D
 	.atomic_mode_set =3D vc4_vec_encoder_atomic_mode_set,=0D
 };=0D
 =0D
=0D
-- =0D
b4 0.10.0-dev-65ba7=0D
