Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB1845A4D63
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 15:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbiH2NQa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 09:16:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbiH2NP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 09:15:56 -0400
Received: from wnew2-smtp.messagingengine.com (wnew2-smtp.messagingengine.com [64.147.123.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E0EE22519
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 06:15:03 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.west.internal (Postfix) with ESMTP id 3E2FD2B0606B;
        Mon, 29 Aug 2022 09:14:28 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 29 Aug 2022 09:14:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1661778867; x=
        1661786067; bh=JaYvZqhoL+I2fhvomldPF+TuSJaxqGQFbEriKS3Go/A=; b=Y
        Xfs3mbm989aKrGXKe0mGPveD6TPj5bQ6DjeLA3Tr3o641EmcPbgVXNlHlKtrIIYc
        aQuCxg1mCEIHWdCyuTVoUCQgiNW7Pp3SCe7ZxiUUXG+Yn5XUkOkVv3qAjGgkMRWb
        UDuGRvsiFpf5S25z95YNTkn+mvx6qsrpqmgWlneSuCFpb4/bU9/nu7hdJtWoVLtp
        6PQyT1TE24meqojJszFcGZhy7rlSK2ruX+HW76t6RJe7hrZhDgq4GHEsr2sYWB+h
        dvLP4njPB1WJKJZhHgiuqeW2cbFqgKsrKrNSiJPIT9Qud1Q3EVLCBnv4pehUxT5T
        NCap1Lv3409l86k+KWLtA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1661778867; x=
        1661786067; bh=JaYvZqhoL+I2fhvomldPF+TuSJaxqGQFbEriKS3Go/A=; b=J
        H3tunYjZBoytNo+XqAZeI9jkkrDEu/nhP3JhChpfadLKlkoo7/aiVLr5FjSqialA
        QeX8yxYIRhTu4mmd+VeEytRMZUzu+xnN2qkbg31TqMoipp2GKYZ8c3fJIksmJF6X
        8XRm+muDJDNsKK9w3Vi2VcS/Rpd8kilUgF8+AuBce1WMwKiz5mScgdPhfLjtTR36
        WRL3TEjsS+mpFotJwGsBNIrjRr6sCZf/OcdDqPW0gJcJudDJb3omC5X3ZiKZuEz4
        x1mzzQwvqdlV4NRMqW+l/SNBNE1nVR0S6oUKFq0ep8JUjI5f9CUJOkZkTYSFHDdw
        Yp3/sBwHeeIVLC2KJl/tA==
X-ME-Sender: <xms:s7sMY87Wlzs1zdhVjZiMxLkxW2rRxZUPhLGNMpPNPLcU7U9bKd4qXg>
    <xme:s7sMY96lgbwD8Wfh42DY42gL3D6LnbNE4NrdO20GosTfZ325l0PCSnu60oMF1LPPW
    bOAqIg6Bqde5B1xMW0>
X-ME-Received: <xmr:s7sMY7drQSJSHtxKlVMNopWZU7LD5KjsTfRXqCsu7g-jChNMq6lXpVW9hBuW>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdekuddgieefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhggtgfogfesthhqredtredtjeenucfhrhhomhepofgr
    gihimhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtf
    frrghtthgvrhhnpeefiedvfefggffgffehveejieffuddtgffhjefggeetieduvdeileet
    lefgveegtdenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:s7sMYxKzOKAyx5ijFQOKi8u6D5T-DaHgEBmR9zv9aKsGan7zkCUXBA>
    <xmx:s7sMYwIv4hURmVXtk2hGe2p-KGJ2jiqm0YxGgsVTOmNFMSJApVhEyg>
    <xmx:s7sMYyxsSBodlCNief0Ceursy5i9DjliPjVXgb2Ha7Nuonh35BL7xQ>
    <xmx:s7sMYxhJ8V3UIF1BYodeY859WYeNcaWaKhl0sZae7i3uPDlZtykwXSA4U5o>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Aug 2022 09:14:26 -0400 (EDT)
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
Subject: [PATCH v2 22/41] drm/atomic-helper: Add a TV properties reset helper
Date:   Mon, 29 Aug 2022 15:11:36 +0200
Message-Id: <20220728-rpi-analog-tv-properties-v2-22-459522d653a7@cerno.tech>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220728-rpi-analog-tv-properties-v2-0-459522d653a7@cerno.tech>
References: <20220728-rpi-analog-tv-properties-v2-0-459522d653a7@cerno.tech>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.10.0-dev-65ba7
X-Developer-Signature: v=1; a=openpgp-sha256; l=4049; i=maxime@cerno.tech; h=from:subject:message-id; bh=svXKowsDyxo006OqnLCPuhwNUZ0/qgk/SYOpnaKRW24=; b=owGbwMvMwCX2+D1vfrpE4FHG02pJDMk8uxTKjk3UUTvSvv657Fpvy6LIp1NYLpV5Sd7wf6jrsnXG 2iW3OkpZGMS4GGTFFFlihM2XxJ2a9bqTjW8ezBxWJpAhDFycAjCRqdUM/5Ryjs/53BAcc2qO6RbO/c emr/c5WTVHVfHa+yW39/hfvbmYkaHZbpJokZDgm83NFQFREkYP3xpMPSsyiyv0uGNb7a6QfcwA
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

The drm_tv_create_properties() function will create a bunch of properties,=
=0D
but it's up to each and every driver using that function to properly reset=
=0D
the state of these properties leading to inconsistent behaviours.=0D
=0D
Let's create a helper that will take care of it.=0D
=0D
Signed-off-by: Maxime Ripard <maxime@cerno.tech>=0D
=0D
diff --git a/drivers/gpu/drm/drm_atomic_state_helper.c b/drivers/gpu/drm/dr=
m_atomic_state_helper.c=0D
index dfb57217253b..0373c3dc824b 100644=0D
--- a/drivers/gpu/drm/drm_atomic_state_helper.c=0D
+++ b/drivers/gpu/drm/drm_atomic_state_helper.c=0D
@@ -481,6 +481,81 @@ void drm_atomic_helper_connector_tv_margins_reset(stru=
ct drm_connector *connecto=0D
 }=0D
 EXPORT_SYMBOL(drm_atomic_helper_connector_tv_margins_reset);=0D
 =0D
+/**=0D
+ * drm_atomic_helper_connector_tv_reset - Resets Analog TV connector prope=
rties=0D
+ * @connector: DRM connector=0D
+ *=0D
+ * Resets the analog TV properties attached to a connector=0D
+ */=0D
+void drm_atomic_helper_connector_tv_reset(struct drm_connector *connector)=
=0D
+{=0D
+	struct drm_device *dev =3D connector->dev;=0D
+	struct drm_cmdline_mode *cmdline =3D &connector->cmdline_mode;=0D
+	struct drm_connector_state *state =3D connector->state;=0D
+	struct drm_property *prop;=0D
+	uint64_t val;=0D
+=0D
+	prop =3D dev->mode_config.tv_mode_property;=0D
+	if (prop)=0D
+		if (!drm_object_property_get_default_value(&connector->base,=0D
+							   prop, &val))=0D
+			state->tv.mode =3D val;=0D
+=0D
+	if (cmdline->tv_mode)=0D
+		state->tv.mode =3D cmdline->tv_mode;=0D
+=0D
+	prop =3D dev->mode_config.tv_select_subconnector_property;=0D
+	if (prop)=0D
+		if (!drm_object_property_get_default_value(&connector->base,=0D
+							   prop, &val))=0D
+			state->tv.select_subconnector =3D val;=0D
+=0D
+	prop =3D dev->mode_config.tv_subconnector_property;=0D
+	if (prop)=0D
+		if (!drm_object_property_get_default_value(&connector->base,=0D
+							   prop, &val))=0D
+			state->tv.subconnector =3D val;=0D
+=0D
+	prop =3D dev->mode_config.tv_brightness_property;=0D
+	if (prop)=0D
+		if (!drm_object_property_get_default_value(&connector->base,=0D
+							   prop, &val))=0D
+			state->tv.brightness =3D val;=0D
+=0D
+	prop =3D dev->mode_config.tv_contrast_property;=0D
+	if (prop)=0D
+		if (!drm_object_property_get_default_value(&connector->base,=0D
+							   prop, &val))=0D
+			state->tv.contrast =3D val;=0D
+=0D
+	prop =3D dev->mode_config.tv_flicker_reduction_property;=0D
+	if (prop)=0D
+		if (!drm_object_property_get_default_value(&connector->base,=0D
+							   prop, &val))=0D
+			state->tv.flicker_reduction =3D val;=0D
+=0D
+	prop =3D dev->mode_config.tv_overscan_property;=0D
+	if (prop)=0D
+		if (!drm_object_property_get_default_value(&connector->base,=0D
+							   prop, &val))=0D
+			state->tv.overscan =3D val;=0D
+=0D
+	prop =3D dev->mode_config.tv_saturation_property;=0D
+	if (prop)=0D
+		if (!drm_object_property_get_default_value(&connector->base,=0D
+							   prop, &val))=0D
+			state->tv.saturation =3D val;=0D
+=0D
+	prop =3D dev->mode_config.tv_hue_property;=0D
+	if (prop)=0D
+		if (!drm_object_property_get_default_value(&connector->base,=0D
+							   prop, &val))=0D
+			state->tv.hue =3D val;=0D
+=0D
+	drm_atomic_helper_connector_tv_margins_reset(connector);=0D
+}=0D
+EXPORT_SYMBOL(drm_atomic_helper_connector_tv_reset);=0D
+=0D
 /**=0D
  * __drm_atomic_helper_connector_duplicate_state - copy atomic connector s=
tate=0D
  * @connector: connector object=0D
diff --git a/include/drm/drm_atomic_state_helper.h b/include/drm/drm_atomic=
_state_helper.h=0D
index 192766656b88..c8fbce795ee7 100644=0D
--- a/include/drm/drm_atomic_state_helper.h=0D
+++ b/include/drm/drm_atomic_state_helper.h=0D
@@ -70,6 +70,7 @@ void __drm_atomic_helper_connector_state_reset(struct drm=
_connector_state *conn_=0D
 void __drm_atomic_helper_connector_reset(struct drm_connector *connector,=
=0D
 					 struct drm_connector_state *conn_state);=0D
 void drm_atomic_helper_connector_reset(struct drm_connector *connector);=0D
+void drm_atomic_helper_connector_tv_reset(struct drm_connector *connector)=
;=0D
 void drm_atomic_helper_connector_tv_margins_reset(struct drm_connector *co=
nnector);=0D
 void=0D
 __drm_atomic_helper_connector_duplicate_state(struct drm_connector *connec=
tor,=0D
=0D
-- =0D
b4 0.10.0-dev-65ba7=0D
