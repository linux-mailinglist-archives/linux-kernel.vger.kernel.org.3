Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 762F65A4D2D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 15:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbiH2NMh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 09:12:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiH2NMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 09:12:12 -0400
Received: from wnew2-smtp.messagingengine.com (wnew2-smtp.messagingengine.com [64.147.123.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA2D11096
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 06:12:11 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailnew.west.internal (Postfix) with ESMTP id 590872B05FB1;
        Mon, 29 Aug 2022 09:12:08 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 29 Aug 2022 09:12:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1661778727; x=
        1661785927; bh=zJuhyh+MgUs2/ekVdAk6Kq0Wq9YXzzJHxtL6DSlw5Og=; b=k
        zHKsj20k4Y1V8oAN8pdbv09/LtrrxTfu6xKOFoSAUycKY4JOCCduqUyHRsntS+et
        IM7lsrOH6nm6Xvsq+47vfHBvEr0Y/tnvEYZ9AZRuwMvJKshBkHYwIr0rsrRUTbcy
        eshM1LtLdsFXNWZpBPBNeZdII53z+surSm2v4H52XqXT2iPAxWt6XWWmZJ3Szayn
        hKsvgPEb0g6q75CiYQFpjlWl5caWAQa+xouZv1UrhAnBpvEIVqPs1HqeTmm5ctzu
        KkdCker+kfOnOswaCFFSnMdAle5IJ+9lEAoYCy0CvxFx97g3zMgFm1NVJ/uDFRSf
        GihPrFbwQgqt0zuKmOTyw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1661778727; x=
        1661785927; bh=zJuhyh+MgUs2/ekVdAk6Kq0Wq9YXzzJHxtL6DSlw5Og=; b=c
        ftMy0ztc0ShuXT+IqZw9bSUt5U+hyi2h7n8R0hLq8ouh5wBvh8zAu21pCESuKn8W
        KI5HZPBSaCwI1wtEfCMioTeUGA3//z1fTeIsA6vwnhwzSG47jchavbSTLUm0p69H
        oTKi93f3Wp6v1t5Ewnb3dxc1s4KmxA3XKGTmQvOpH1wBToONSX5LjiER/4YqMiDf
        Ikccon49YxgN5GnbLTg6lQPa9MqR0IbVJnigiGqp2E6KD5OMq1IBDfNI45OuceV0
        Hztcgf7kTuhCWGaiwZGHkAIsP0DZKSa8uAgTGz9FzqKlStgpybjelId3VGvucdxe
        FyDKkY9hH8yEXd0jLm18w==
X-ME-Sender: <xms:J7sMY6hePGuVxWxRIJZf5x4IelO5UrQZE1KNj52UndvMubdKz9l50g>
    <xme:J7sMY7BZlSAoP7Jlz0pvtVMhqgH0jEDgKnUGYjmKfmkU1618vqMUbmr1k6OrMLBJu
    F6SQxpxAlrqkE8zSr4>
X-ME-Received: <xmr:J7sMYyGoy1MI4w7qVE_5xh8ryUd3XGNjtGygeAdimxebcdnaCsMWzjyI5YSW>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdekuddgieefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhggtgfogfesthhqredtredtjeenucfhrhhomhepofgr
    gihimhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtf
    frrghtthgvrhhnpeefiedvfefggffgffehveejieffuddtgffhjefggeetieduvdeileet
    lefgveegtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:J7sMYzSoE4gUKhbx6qxQke5xDHJoi9oBCWLtJLKUmN6VnB3lmSDmcQ>
    <xmx:J7sMY3wasf2R1BwniKvBXezBWo1kO4LYyWBikwsprl5TBdP7aegbug>
    <xmx:J7sMYx5LapU8G_AiAS-96RU9kahBV0ZTqVT_tDbpAR_YKoV0Yl-FUQ>
    <xmx:J7sMY1r3QHlTqLj8Lj8A4i9kMzpuAwC4Y3QKcFSsN2qGNhFCk-pxfLO7L0c>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Aug 2022 09:12:06 -0400 (EDT)
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
Subject: [PATCH v2 01/41] drm/tests: Order Kunit tests in Makefile
Date:   Mon, 29 Aug 2022 15:11:15 +0200
Message-Id: <20220728-rpi-analog-tv-properties-v2-1-459522d653a7@cerno.tech>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220728-rpi-analog-tv-properties-v2-0-459522d653a7@cerno.tech>
References: <20220728-rpi-analog-tv-properties-v2-0-459522d653a7@cerno.tech>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.10.0-dev-65ba7
X-Developer-Signature: v=1; a=openpgp-sha256; l=1038; i=maxime@cerno.tech; h=from:subject:message-id; bh=7wf09uYZmOlzEdMLSbfvbGYOI6J6pbrZA084PMpLFI8=; b=owGbwMvMwCX2+D1vfrpE4FHG02pJDMk8u+QCtJc+19tw1dnPLoUp63uAlPSLTZNOzt7jFLTp8xRp vUd1HaUsDGJcDLJiiiwxwuZL4k7Net3JxjcPZg4rE8gQBi5OAZiIxwyGvwJi6fvdU59tEF2+1WaTqG fLLKOP7P4v1x/7V8fsu+XSoRhGht/bauWCa76+r5Cz/DXnwv07FYkCMW2rF6967BCaNfWRFB8A
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

Since we've recently added a ton of tests, the list starts to be a bit=0D
of a mess and creates unneeded conflicts.=0D
=0D
Let's order it alphabetically.=0D
=0D
Signed-off-by: Maxime Ripard <maxime@cerno.tech>=0D
=0D
diff --git a/drivers/gpu/drm/tests/Makefile b/drivers/gpu/drm/tests/Makefil=
e=0D
index 91b70f7d2769..2d9f49b62ecb 100644=0D
--- a/drivers/gpu/drm/tests/Makefile=0D
+++ b/drivers/gpu/drm/tests/Makefile=0D
@@ -1,5 +1,13 @@=0D
 # SPDX-License-Identifier: GPL-2.0=0D
 =0D
-obj-$(CONFIG_DRM_KUNIT_TEST) +=3D drm_format_helper_test.o drm_damage_help=
er_test.o \=0D
-	drm_cmdline_parser_test.o drm_rect_test.o drm_format_test.o drm_plane_hel=
per_test.o \=0D
-	drm_dp_mst_helper_test.o drm_framebuffer_test.o drm_buddy_test.o drm_mm_t=
est.o=0D
+obj-$(CONFIG_DRM_KUNIT_TEST) +=3D \=0D
+	drm_buddy_test.o \=0D
+	drm_cmdline_parser_test.o \=0D
+	drm_damage_helper_test.o \=0D
+	drm_dp_mst_helper_test.o \=0D
+	drm_format_helper_test.o \=0D
+	drm_format_test.o \=0D
+	drm_framebuffer_test.o \=0D
+	drm_mm_test.o \=0D
+	drm_plane_helper_test.o \=0D
+	drm_rect_test.o=0D
=0D
-- =0D
b4 0.10.0-dev-65ba7=0D
