Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA94C5A4D9B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 15:19:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbiH2NS7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 09:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230350AbiH2NRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 09:17:54 -0400
Received: from wnew2-smtp.messagingengine.com (wnew2-smtp.messagingengine.com [64.147.123.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDC5F82F92
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 06:17:03 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailnew.west.internal (Postfix) with ESMTP id C3CD12B0607D;
        Mon, 29 Aug 2022 09:15:27 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 29 Aug 2022 09:15:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1661778927; x=
        1661786127; bh=bQFyjpMNqkENbIjlSD35Zj5sFEYA6vUdCkuwZuqm7TI=; b=T
        9IkExrnDo9ILGrnq65wN97FCrtXIWEkeAbP7nG+06RyRiXlLSVe3R7e00njnxjxW
        ihQ7N3hJahATrSjNUdUwxLJ/KsBVUDjsR0LCVAdPmE8DbuWPT/Cg1Gl32hPb2f26
        CL+VqMnWH5A0hHYOTBqtn/d27OQN2g6B5v+Q3pFmZOQtA0H2RnhRRORhY08k0oGE
        J25NC+YLvd+tMlnu3jILDJuRAhEmalcH4sA4335YDZavHGur3s5grORCWCLpbHxZ
        9l1yqbMR7z3zUAqS+qnCfb9kjs+PIlRFirN7otRAgE/53ijdKXHt9f98qaBejXEN
        N71z0ZXNz+okkgR24LbIg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1661778927; x=
        1661786127; bh=bQFyjpMNqkENbIjlSD35Zj5sFEYA6vUdCkuwZuqm7TI=; b=w
        8Xcr7VMECbXJcl7zuFEBY1iPiaxVXjWlcOy4VKZovQgyi17NMpiUYtj155sYq0LZ
        N0edC6V1dOZAqqPSY2zHcS2D9PspSaBi3bp6u7JEi5u3DYjXWue66PIzdcNP/qmP
        jGOer/3WtP+mnVQyHlQ8EwMLq+2QOCbsXEdXqk1Hehsa700xtF47tSQa+3p4nj1e
        gnHEqXNuEZb8MeYGZuQMF6ZwWlIywbtt6Mp5fjkRVw7zBh2OVHL/hFRBEKz2I4Cz
        2lMcKoIJIoAdorEeLBNKDWvOl7fLCxEnTqQ+bns1HY0JLI/Seqhu7R2kEWxQbmai
        fRDyRwrKoeVv/1kN8ccrw==
X-ME-Sender: <xms:77sMY43svq0XTMq1D8GkJ4GfCAYLaDiRUO7V99tseGcbkZbgSywdZg>
    <xme:77sMYzGCwyLJisatZYIdsUHAGwL2rjD_6ayJO7NjVcGULvf_I8sXmA9aj96zeXZLY
    0eXQmcR_sN1NRanB3s>
X-ME-Received: <xmr:77sMYw7Nwu6JUynm4S3d-HW-k79s3C9MmmBgNyQuKXkXCDbSVub0kP90X0ab>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdekuddgieegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhggtgfogfesthhqredtredtjeenucfhrhhomhepofgr
    gihimhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtf
    frrghtthgvrhhnpeefiedvfefggffgffehveejieffuddtgffhjefggeetieduvdeileet
    lefgveegtdenucevlhhushhtvghrufhiiigvpeegnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:77sMYx1P9x52He3Mg77DiCCa-KCczGJ8Uie6pETXMrbzpzzbjBfsXA>
    <xmx:77sMY7GBYLFVpwrTQn02RvcENGHBBdhagEqTRHIhP4LzT8EMDl3FLw>
    <xmx:77sMY6_arsjgK6IndJoQaGAlCWk58Gvx3QPehDb6sgLfa9IYij1Jdg>
    <xmx:77sMY1M0oB61Jo2868sQfv_B44QheY63yiqDOENEV2JABVK0vUAGIHnTFkU>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Aug 2022 09:15:26 -0400 (EDT)
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
Subject: [PATCH v2 31/41] drm/vc4: vec: Use TV Reset implementation
Date:   Mon, 29 Aug 2022 15:11:45 +0200
Message-Id: <20220728-rpi-analog-tv-properties-v2-31-459522d653a7@cerno.tech>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220728-rpi-analog-tv-properties-v2-0-459522d653a7@cerno.tech>
References: <20220728-rpi-analog-tv-properties-v2-0-459522d653a7@cerno.tech>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.10.0-dev-65ba7
X-Developer-Signature: v=1; a=openpgp-sha256; l=1413; i=maxime@cerno.tech; h=from:subject:message-id; bh=qDLYBra+oWv7qr1ofEsAPnJEYg3c17J8Q720Wj/k2mc=; b=owGbwMvMwCX2+D1vfrpE4FHG02pJDMk8uxTUr6gwqegmf4jUmrupInBnsidH0hqHF5vePV/cONdk 29zdHaUsDGJcDLJiiiwxwuZL4k7Net3JxjcPZg4rE8gQBi5OAZjIETOGf9p7mWTvl6jclM39d6qm90 TxRs2+DTfepCVap7b/PPSIR4aR4fiBWr6yQ9N+Xb7aP/NzffBEvtS6Tl67ookBZXEGQQfCWQA=
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

The analog TV properties created by the drm_mode_create_tv_properties() are=
=0D
not properly initialised at reset. Let's switch our implementation to call=
=0D
drm_atomic_helper_connector_tv_reset().=0D
=0D
Signed-off-by: Maxime Ripard <maxime@cerno.tech>=0D
=0D
diff --git a/drivers/gpu/drm/vc4/vc4_vec.c b/drivers/gpu/drm/vc4/vc4_vec.c=
=0D
index fa85dd260742..ba6f81908923 100644=0D
--- a/drivers/gpu/drm/vc4/vc4_vec.c=0D
+++ b/drivers/gpu/drm/vc4/vc4_vec.c=0D
@@ -254,6 +254,12 @@ vc4_vec_connector_detect(struct drm_connector *connect=
or, bool force)=0D
 	return connector_status_unknown;=0D
 }=0D
 =0D
+static void vc4_vec_connector_reset(struct drm_connector *connector)=0D
+{=0D
+	drm_atomic_helper_connector_reset(connector);=0D
+	drm_atomic_helper_connector_tv_reset(connector);=0D
+}=0D
+=0D
 static int vc4_vec_connector_get_modes(struct drm_connector *connector)=0D
 {=0D
 	struct drm_connector_state *state =3D connector->state;=0D
@@ -274,7 +280,7 @@ static int vc4_vec_connector_get_modes(struct drm_conne=
ctor *connector)=0D
 static const struct drm_connector_funcs vc4_vec_connector_funcs =3D {=0D
 	.detect =3D vc4_vec_connector_detect,=0D
 	.fill_modes =3D drm_helper_probe_single_connector_modes,=0D
-	.reset =3D drm_atomic_helper_connector_reset,=0D
+	.reset =3D vc4_vec_connector_reset,=0D
 	.atomic_duplicate_state =3D drm_atomic_helper_connector_duplicate_state,=
=0D
 	.atomic_destroy_state =3D drm_atomic_helper_connector_destroy_state,=0D
 };=0D
=0D
-- =0D
b4 0.10.0-dev-65ba7=0D
