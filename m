Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 165315A4E07
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 15:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbiH2N1r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 09:27:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiH2N1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 09:27:06 -0400
Received: from wnew2-smtp.messagingengine.com (wnew2-smtp.messagingengine.com [64.147.123.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19CA5832F7
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 06:25:48 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailnew.west.internal (Postfix) with ESMTP id 360F32B06082;
        Mon, 29 Aug 2022 09:15:41 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 29 Aug 2022 09:15:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1661778940; x=
        1661786140; bh=wfBLSlubLXJalTEhWev5uur9f+B7LIZiZbKRIJCYb+g=; b=M
        IsznkJ/OuhR6dLcTIvg6xEt2xwl6yCbHI0sCXVUam35yMlewp1q2gjTGj+TiOhG+
        3bMZnmvK8R5p3k3SzgqHmCyjadymmu7be5B97TFMGooLtOnpOSEANGoR/Tabr1vZ
        mmaGFw/J02wI0dnRl8HlXVLUVeWhs1xTeYBKBkueq2BeCUr4RQoZ12SB1+Io999r
        X67oEWm1M3Ot71x5XcpOFzV8cXSvhmFopun86CS/0pyHiTyVjSeMYzhfOhjDgfrK
        rKdRES20qoswpaxkC/UbA5RAYKyYv4SpYujoPB4hmmpvRU3rUxMy0WL5IdFk/Q0b
        VYxhoj/3/YVq0yPz5DDUA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1661778940; x=
        1661786140; bh=wfBLSlubLXJalTEhWev5uur9f+B7LIZiZbKRIJCYb+g=; b=I
        m5C/ztp/OPrqpNxvH2rv4fHrfwYgegyQytUpvXDy9oZKK1u5xiv9nhv2qPwGJ4Nj
        tL2clOP+tq9gUn+KiSZaNCDOSrweYXjDgBxTVXKH7x9h1gm4JT2fp4iEP3K9zUQ7
        SkArVp30xBK46iKp5ZK0IB57k7El97d0W1e4eRLKF0dfaEZVQJdc5nXT5nTK3SjB
        ZVMHEG9CkleKksB6og2sg9HEJEX1QFeZBLd7OWWFnO4xXqtqAdIEd3ryRQcipMpO
        IFr2NgsOx9bhJr+SYK5+i29AS6g2O/ZPOQl/+FFGhsF4daN5DLJDsNIh9O3p8dvn
        yP53QiZUfXzCIBllCZSBw==
X-ME-Sender: <xms:_LsMY4lBp9BpxD7hnON6LnfO44BL0qY7h5uaN0gYsCgec7E4s0Z9QQ>
    <xme:_LsMY30ZWpxtOItkS41FchT4TSNzm8ru7h9MO1P4JOW2n7moKVySPxzRy06NsS-Wq
    O8DcoYrjOqXMCYOYrE>
X-ME-Received: <xmr:_LsMY2qA32GiUyxxVsoYT3_D8SfF4MN5Vp-doN2EaqUSYkNEx3BjN9Sfuycm>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdekuddgieegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhggtgfogfesthhqredtredtjeenucfhrhhomhepofgr
    gihimhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtf
    frrghtthgvrhhnpeefiedvfefggffgffehveejieffuddtgffhjefggeetieduvdeileet
    lefgveegtdenucevlhhushhtvghrufhiiigvpeehnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:_LsMY0lVJAzu1lLq12S3s_IkkhaEZkdOdfQNnrVUbnC7trfObsZQOQ>
    <xmx:_LsMY22qp_n8w7t89-xBEPqTEdjQxNbQSICDSq_-B4TrvQ6F0PbL-Q>
    <xmx:_LsMY7sa5BLtt_XWhXiTY5eXaA4XolhEOUPDVYReOmyfbrYf97oUSQ>
    <xmx:_LsMYz_XlHzB88e_KwbRclESG18R7p7bKqXaLGMP54C1_I3HKoOCC3gsY3E>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Aug 2022 09:15:39 -0400 (EDT)
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
Subject: [PATCH v2 33/41] drm/vc4: vec: Add support for more analog TV standards
Date:   Mon, 29 Aug 2022 15:11:47 +0200
Message-Id: <20220728-rpi-analog-tv-properties-v2-33-459522d653a7@cerno.tech>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220728-rpi-analog-tv-properties-v2-0-459522d653a7@cerno.tech>
References: <20220728-rpi-analog-tv-properties-v2-0-459522d653a7@cerno.tech>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.10.0-dev-65ba7
X-Developer-Signature: v=1; a=openpgp-sha256; l=7769; i=maxime@cerno.tech; h=from:subject:message-id; bh=e55qQaypUDvDhsz0bG1RkxImTDd6VGSv09qX0RaaQDw=; b=owGbwMvMwCX2+D1vfrpE4FHG02pJDMk8uxQFTtgK6It8SA/TPZpyMGZxj9vLjksus2c+VA5RYFX8 ePFgRykLgxgXg6yYIkuMsPmSuFOzXney8c2DmcPKBDKEgYtTACayegYjw1Ime7EwqTXP2u4W+wdaRV hc9/I53H30Rfwhp3nTM04ycDAyrLgbIF7rJLj7iR7fuilv4w2O1c+fWDFDTadt2e87K1b6cgMA
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

From: Mateusz Kwiatkowski <kfyatek+publicgit@gmail.com>=0D
=0D
Add support for the following composite output modes (all of them are=0D
somewhat more obscure than the previously defined ones):=0D
=0D
- NTSC_443 - NTSC-style signal with the chroma subcarrier shifted to=0D
  4.43361875 MHz (the PAL subcarrier frequency). Never used for=0D
  broadcasting, but sometimes used as a hack to play NTSC content in PAL=0D
  regions (e.g. on VCRs).=0D
- PAL_N - PAL with alternative chroma subcarrier frequency,=0D
  3.58205625 MHz. Used as a broadcast standard in Argentina, Paraguay=0D
  and Uruguay to fit 576i50 with colour in 6 MHz channel raster.=0D
- PAL60 - 480i60 signal with PAL-style color at normal European PAL=0D
  frequency. Another non-standard, non-broadcast mode, used in similar=0D
  contexts as NTSC_443. Some displays support one but not the other.=0D
- SECAM - French frequency-modulated analog color standard; also have=0D
  been broadcast in Eastern Europe and various parts of Africa and Asia.=0D
  Uses the same 576i50 timings as PAL.=0D
=0D
Also added some comments explaining color subcarrier frequency=0D
registers.=0D
=0D
Signed-off-by: Mateusz Kwiatkowski <kfyatek+publicgit@gmail.com>=0D
Signed-off-by: Maxime Ripard <maxime@cerno.tech>=0D
=0D
diff --git a/drivers/gpu/drm/vc4/vc4_vec.c b/drivers/gpu/drm/vc4/vc4_vec.c=
=0D
index 58286acf4b9e..55f6f490877c 100644=0D
--- a/drivers/gpu/drm/vc4/vc4_vec.c=0D
+++ b/drivers/gpu/drm/vc4/vc4_vec.c=0D
@@ -46,6 +46,7 @@=0D
 #define VEC_CONFIG0_YDEL(x)		((x) << 26)=0D
 #define VEC_CONFIG0_CDEL_MASK		GENMASK(25, 24)=0D
 #define VEC_CONFIG0_CDEL(x)		((x) << 24)=0D
+#define VEC_CONFIG0_SECAM_STD		BIT(21)=0D
 #define VEC_CONFIG0_PBPR_FIL		BIT(18)=0D
 #define VEC_CONFIG0_CHROMA_GAIN_MASK	GENMASK(17, 16)=0D
 #define VEC_CONFIG0_CHROMA_GAIN_UNITY	(0 << 16)=0D
@@ -76,6 +77,27 @@=0D
 #define VEC_SOFT_RESET			0x10c=0D
 #define VEC_CLMP0_START			0x144=0D
 #define VEC_CLMP0_END			0x148=0D
+=0D
+/*=0D
+ * These set the color subcarrier frequency=0D
+ * if VEC_CONFIG1_CUSTOM_FREQ is enabled.=0D
+ *=0D
+ * VEC_FREQ1_0 contains the most significant 16-bit half-word,=0D
+ * VEC_FREQ3_2 contains the least significant 16-bit half-word.=0D
+ * 0x80000000 seems to be equivalent to the pixel clock=0D
+ * (which itself is the VEC clock divided by 8).=0D
+ *=0D
+ * Reference values (with the default pixel clock of 13.5 MHz):=0D
+ *=0D
+ * NTSC  (3579545.[45] Hz)     - 0x21F07C1F=0D
+ * PAL   (4433618.75 Hz)       - 0x2A098ACB=0D
+ * PAL-M (3575611.[888111] Hz) - 0x21E6EFE3=0D
+ * PAL-N (3582056.25 Hz)       - 0x21F69446=0D
+ *=0D
+ * NOTE: For SECAM, it is used as the Dr center frequency,=0D
+ * regardless of whether VEC_CONFIG1_CUSTOM_FREQ is enabled or not;=0D
+ * that is specified as 4406250 Hz, which corresponds to 0x29C71C72.=0D
+ */=0D
 #define VEC_FREQ3_2			0x180=0D
 #define VEC_FREQ1_0			0x184=0D
 =0D
@@ -118,6 +140,14 @@=0D
 =0D
 #define VEC_INTERRUPT_CONTROL		0x190=0D
 #define VEC_INTERRUPT_STATUS		0x194=0D
+=0D
+/*=0D
+ * Db center frequency for SECAM; the clock for this is the same as for=0D
+ * VEC_FREQ3_2/VEC_FREQ1_0, which is used for Dr center frequency.=0D
+ *=0D
+ * This is specified as 4250000 Hz, which corresponds to 0x284BDA13.=0D
+ * That is also the default value, so no need to set it explicitly.=0D
+ */=0D
 #define VEC_FCW_SECAM_B			0x198=0D
 #define VEC_SECAM_GAIN_VAL		0x19c=0D
 =0D
@@ -194,9 +224,13 @@ connector_to_vc4_vec(struct drm_connector *connector)=
=0D
 =0D
 enum vc4_vec_tv_mode_id {=0D
 	VC4_VEC_TV_MODE_NTSC,=0D
+	VC4_VEC_TV_MODE_NTSC_443,=0D
 	VC4_VEC_TV_MODE_NTSC_J,=0D
 	VC4_VEC_TV_MODE_PAL,=0D
+	VC4_VEC_TV_MODE_PAL_60,=0D
 	VC4_VEC_TV_MODE_PAL_M,=0D
+	VC4_VEC_TV_MODE_PAL_N,=0D
+	VC4_VEC_TV_MODE_SECAM,=0D
 };=0D
 =0D
 struct vc4_vec_tv_mode {=0D
@@ -234,6 +268,12 @@ static const struct debugfs_reg32 vec_regs[] =3D {=0D
 };=0D
 =0D
 static const struct vc4_vec_tv_mode vc4_vec_tv_modes[] =3D {=0D
+	{=0D
+		.mode =3D DRM_MODE_TV_MODE_NTSC_443,=0D
+		.config0 =3D VEC_CONFIG0_NTSC_STD,=0D
+		.config1 =3D VEC_CONFIG1_C_CVBS_CVBS | VEC_CONFIG1_CUSTOM_FREQ,=0D
+		.custom_freq =3D 0x2a098acb,=0D
+	},=0D
 	{=0D
 		.mode =3D DRM_MODE_TV_MODE_NTSC_M,=0D
 		.config0 =3D VEC_CONFIG0_NTSC_STD | VEC_CONFIG0_PDEN,=0D
@@ -244,6 +284,12 @@ static const struct vc4_vec_tv_mode vc4_vec_tv_modes[]=
 =3D {=0D
 		.config0 =3D VEC_CONFIG0_NTSC_STD,=0D
 		.config1 =3D VEC_CONFIG1_C_CVBS_CVBS,=0D
 	},=0D
+	{=0D
+		.mode =3D DRM_MODE_TV_MODE_PAL_60,=0D
+		.config0 =3D VEC_CONFIG0_PAL_M_STD,=0D
+		.config1 =3D VEC_CONFIG1_C_CVBS_CVBS | VEC_CONFIG1_CUSTOM_FREQ,=0D
+		.custom_freq =3D 0x2a098acb,=0D
+	},=0D
 	{=0D
 		.mode =3D DRM_MODE_TV_MODE_PAL_B,=0D
 		.config0 =3D VEC_CONFIG0_PAL_BDGHI_STD,=0D
@@ -254,6 +300,17 @@ static const struct vc4_vec_tv_mode vc4_vec_tv_modes[]=
 =3D {=0D
 		.config0 =3D VEC_CONFIG0_PAL_M_STD,=0D
 		.config1 =3D VEC_CONFIG1_C_CVBS_CVBS,=0D
 	},=0D
+	{=0D
+		.mode =3D DRM_MODE_TV_MODE_PAL_N,=0D
+		.config0 =3D VEC_CONFIG0_PAL_N_STD,=0D
+		.config1 =3D VEC_CONFIG1_C_CVBS_CVBS,=0D
+	},=0D
+	{=0D
+		.mode =3D DRM_MODE_TV_MODE_SECAM_B,=0D
+		.config0 =3D VEC_CONFIG0_SECAM_STD,=0D
+		.config1 =3D VEC_CONFIG1_C_CVBS_CVBS,=0D
+		.custom_freq =3D 0x29c71c72,=0D
+	},=0D
 };=0D
 =0D
 static inline const struct vc4_vec_tv_mode *=0D
@@ -273,9 +330,13 @@ vc4_vec_tv_mode_lookup(unsigned int mode)=0D
 =0D
 static const struct drm_prop_enum_list tv_mode_names[] =3D {=0D
 	{ VC4_VEC_TV_MODE_NTSC, "NTSC", },=0D
+	{ VC4_VEC_TV_MODE_NTSC_443, "NTSC-443", },=0D
 	{ VC4_VEC_TV_MODE_NTSC_J, "NTSC-J", },=0D
 	{ VC4_VEC_TV_MODE_PAL, "PAL", },=0D
+	{ VC4_VEC_TV_MODE_PAL_60, "PAL-60", },=0D
 	{ VC4_VEC_TV_MODE_PAL_M, "PAL-M", },=0D
+	{ VC4_VEC_TV_MODE_PAL_N, "PAL-N", },=0D
+	{ VC4_VEC_TV_MODE_SECAM, "SECAM", },=0D
 };=0D
 =0D
 static enum drm_connector_status=0D
@@ -332,6 +393,10 @@ vc4_vec_connector_set_property(struct drm_connector *c=
onnector,=0D
 		state->tv.mode =3D DRM_MODE_TV_MODE_NTSC_M;=0D
 		break;=0D
 =0D
+	case VC4_VEC_TV_MODE_NTSC_443:=0D
+		state->tv.mode =3D DRM_MODE_TV_MODE_NTSC_443;=0D
+		break;=0D
+=0D
 	case VC4_VEC_TV_MODE_NTSC_J:=0D
 		state->tv.mode =3D DRM_MODE_TV_MODE_NTSC_J;=0D
 		break;=0D
@@ -340,10 +405,22 @@ vc4_vec_connector_set_property(struct drm_connector *=
connector,=0D
 		state->tv.mode =3D DRM_MODE_TV_MODE_PAL_B;=0D
 		break;=0D
 =0D
+	case VC4_VEC_TV_MODE_PAL_60:=0D
+		state->tv.mode =3D DRM_MODE_TV_MODE_PAL_60;=0D
+		break;=0D
+=0D
 	case VC4_VEC_TV_MODE_PAL_M:=0D
 		state->tv.mode =3D DRM_MODE_TV_MODE_PAL_M;=0D
 		break;=0D
 =0D
+	case VC4_VEC_TV_MODE_PAL_N:=0D
+		state->tv.mode =3D DRM_MODE_TV_MODE_PAL_N;=0D
+		break;=0D
+=0D
+	case VC4_VEC_TV_MODE_SECAM:=0D
+		state->tv.mode =3D DRM_MODE_TV_MODE_SECAM_B;=0D
+		break;=0D
+=0D
 	default:=0D
 		return -EINVAL;=0D
 	}=0D
@@ -363,6 +440,10 @@ vc4_vec_connector_get_property(struct drm_connector *c=
onnector,=0D
 		return -EINVAL;=0D
 =0D
 	switch (state->tv.mode) {=0D
+	case DRM_MODE_TV_MODE_NTSC_443:=0D
+		*val =3D VC4_VEC_TV_MODE_NTSC_443;=0D
+		break;=0D
+=0D
 	case DRM_MODE_TV_MODE_NTSC_J:=0D
 		*val =3D VC4_VEC_TV_MODE_NTSC_J;=0D
 		break;=0D
@@ -371,6 +452,10 @@ vc4_vec_connector_get_property(struct drm_connector *c=
onnector,=0D
 		*val =3D VC4_VEC_TV_MODE_NTSC;=0D
 		break;=0D
 =0D
+	case DRM_MODE_TV_MODE_PAL_60:=0D
+		*val =3D VC4_VEC_TV_MODE_PAL_60;=0D
+		break;=0D
+=0D
 	case DRM_MODE_TV_MODE_PAL_B:=0D
 		*val =3D VC4_VEC_TV_MODE_PAL;=0D
 		break;=0D
@@ -379,6 +464,14 @@ vc4_vec_connector_get_property(struct drm_connector *c=
onnector,=0D
 		*val =3D VC4_VEC_TV_MODE_PAL_M;=0D
 		break;=0D
 =0D
+	case DRM_MODE_TV_MODE_PAL_N:=0D
+		*val =3D VC4_VEC_TV_MODE_PAL_N;=0D
+		break;=0D
+=0D
+	case DRM_MODE_TV_MODE_SECAM_B:=0D
+		*val =3D VC4_VEC_TV_MODE_SECAM;=0D
+		break;=0D
+=0D
 	default:=0D
 		return -EINVAL;=0D
 	}=0D
@@ -608,10 +701,14 @@ static int vc4_vec_bind(struct device *dev, struct de=
vice *master, void *data)=0D
 	int ret;=0D
 =0D
 	ret =3D drm_mode_create_tv_properties(drm,=0D
+					    BIT(DRM_MODE_TV_MODE_NTSC_443) |=0D
 					    BIT(DRM_MODE_TV_MODE_NTSC_J) |=0D
 					    BIT(DRM_MODE_TV_MODE_NTSC_M) |=0D
+					    BIT(DRM_MODE_TV_MODE_PAL_60) |=0D
 					    BIT(DRM_MODE_TV_MODE_PAL_B) |=0D
-					    BIT(DRM_MODE_TV_MODE_PAL_M));=0D
+					    BIT(DRM_MODE_TV_MODE_PAL_M) |=0D
+					    BIT(DRM_MODE_TV_MODE_PAL_N) |=0D
+					    BIT(DRM_MODE_TV_MODE_SECAM_B));=0D
 	if (ret)=0D
 		return ret;=0D
 =0D
=0D
-- =0D
b4 0.10.0-dev-65ba7=0D
