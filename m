Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B4CE5A4D54
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 15:15:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbiH2NPV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 09:15:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230142AbiH2NOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 09:14:49 -0400
Received: from wnew2-smtp.messagingengine.com (wnew2-smtp.messagingengine.com [64.147.123.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 291837C1EC
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 06:14:15 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailnew.west.internal (Postfix) with ESMTP id 19C952B06060;
        Mon, 29 Aug 2022 09:13:55 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 29 Aug 2022 09:13:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1661778834; x=
        1661786034; bh=Xt4h71qgo36Lun6EJqBoeTJELWWLQIvV4RB+WH0LhHQ=; b=A
        URRgIN0UNq9YgAaMUAmS47vuw8XNqz5mG/9qj2U6JoVDiEIF4wL6gnT6QVoVhKVT
        lAae47kfEO1J5li7lDSMsRM3pylMMP+Ph9Kl57XBwr1rG/hKcyuaRZ12IuGyCLwH
        hkre6zhwHJ1t0IeAfqm3T5nnzfoynu4F349aVB2XEhd2PGhW3E8g9wMwf5/HXy8K
        GnTB9wEtlpCZIRxmdt6uHiPu/yqiT3TUTGCAa1Mri+hSezeG4EvUNoCeNuQdJdTE
        2LgBQqDdlmsYtunHMd89JUbgYlSRAY3disQYPw7KcZ48fDlij/DS3ubs7WH/ffNT
        AdIKpoad30xnanhEdV+Tw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1661778834; x=
        1661786034; bh=Xt4h71qgo36Lun6EJqBoeTJELWWLQIvV4RB+WH0LhHQ=; b=y
        9kG0RkitVaKWooVlwojzV9xib8E89NbQ9Gw7FKJkGFcyOXt6xZDe9mRJQccbVs9j
        rz3OfAO/Ue45qpg4H2oBeseZwqomZ0iLYApw9u1hLjd4YQ8hH71osulAJbcfs2JP
        otqCtX9pYSHsoI/ERw6zVDznKGpxoMwQPaL8EolkvBkzW1MujM2NeLbMDIEUZVhs
        vJMNL/DasLUTXwiZEqp0QJdWQzYC588ln4bsAPW9Cj/4wV4GrT9LWd5sf9BS0E9X
        jDSAI0ofDx7hbXKlSRJr0ZT5DKXnMrkwtowGCGQ4Qknv6bEzS6cSaPxUqLHWyZbt
        qgjbIRH6ZzFzyvP6UgDFw==
X-ME-Sender: <xms:krsMYyroaZCeWJdR23ePxMUvfJi1iYKkIf2QpH8H1gAbZJ52OohxoA>
    <xme:krsMYwqyW17yz_4lSoujerDfeK_FL7Whf4_1yYJFKwa9NvjFDyqgO_DMH2y0s5Jn3
    T7yHLziQ_DIfjPyr6Q>
X-ME-Received: <xmr:krsMY3MimFPj1QTFda4jfNBsfyFHaHb8ING43iLYdxBBhhpJgbofzA658hl7>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdekuddgieegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhggtgfogfesthhqredtredtjeenucfhrhhomhepofgr
    gihimhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtf
    frrghtthgvrhhnpeefiedvfefggffgffehveejieffuddtgffhjefggeetieduvdeileet
    lefgveegtdenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:krsMYx5poQeIKbgQTAzeQ27EjCVN9Zpfh8YGoSJ-ldktwwKOW4fk9Q>
    <xmx:krsMYx56FmzpBo8wKjzueVa0Ykr5if_bJXTmyjp3np_4-1473Q0cWQ>
    <xmx:krsMYxiP108-KuS93AL73B7Vg6FwhlN_BsnyIRwXz9P2zsBvgdrXxQ>
    <xmx:krsMY-Qpfai3eR79udgmllMQJpndMAZjdWaBYTJyDdvxrCn64xpwny7d_28>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Aug 2022 09:13:53 -0400 (EDT)
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
Subject: [PATCH v2 17/41] drm/connector: Add pixel clock to cmdline mode
Date:   Mon, 29 Aug 2022 15:11:31 +0200
Message-Id: <20220728-rpi-analog-tv-properties-v2-17-459522d653a7@cerno.tech>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220728-rpi-analog-tv-properties-v2-0-459522d653a7@cerno.tech>
References: <20220728-rpi-analog-tv-properties-v2-0-459522d653a7@cerno.tech>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.10.0-dev-65ba7
X-Developer-Signature: v=1; a=openpgp-sha256; l=2061; i=maxime@cerno.tech; h=from:subject:message-id; bh=g8InIRf4u9qt8kxe4oCM32qGfcUWItUjH3nMpSZ44ak=; b=owGbwMvMwCX2+D1vfrpE4FHG02pJDMk8uxS+ZRn27zx4v121K3itq9sdkSPCYYzLbkxMfrzTX27K tj2fO0pZGMS4GGTFFFlihM2XxJ2a9bqTjW8ezBxWJpAhDFycAjARcz2Gf7azWNkqq6+t2bDQMKGJ9+ cdL9Ot/IWFj2sXrzPRYmIMTWBkaK0s3shnor4oplDh+/Nvv1V3a1abeZm+9ajcXVaqP/E/KwA=
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

We'll need to get the pixel clock to generate proper display modes for=0D
all the current named modes. Let's add it to struct drm_cmdline_mode and=0D
fill it when parsing the named mode.=0D
=0D
Signed-off-by: Maxime Ripard <maxime@cerno.tech>=0D
=0D
diff --git a/drivers/gpu/drm/drm_modes.c b/drivers/gpu/drm/drm_modes.c=0D
index 5e898699b532..73d01e755496 100644=0D
--- a/drivers/gpu/drm/drm_modes.c=0D
+++ b/drivers/gpu/drm/drm_modes.c=0D
@@ -2208,22 +2208,24 @@ static int drm_mode_parse_cmdline_options(const cha=
r *str,=0D
 =0D
 struct drm_named_mode {=0D
 	const char *name;=0D
+	unsigned int pixel_clock_khz;=0D
 	unsigned int xres;=0D
 	unsigned int yres;=0D
 	unsigned int flags;=0D
 };=0D
 =0D
-#define NAMED_MODE(_name, _x, _y, _flags)		\=0D
+#define NAMED_MODE(_name, _pclk, _x, _y, _flags)	\=0D
 	{						\=0D
 		.name =3D _name,				\=0D
+		.pixel_clock_khz =3D _pclk,		\=0D
 		.xres =3D _x,				\=0D
 		.yres =3D _y,				\=0D
 		.flags =3D _flags,			\=0D
 	}=0D
 =0D
 static const struct drm_named_mode drm_named_modes[] =3D {=0D
-	NAMED_MODE("NTSC", 720, 480, DRM_MODE_FLAG_INTERLACE),=0D
-	NAMED_MODE("PAL", 720, 576, DRM_MODE_FLAG_INTERLACE),=0D
+	NAMED_MODE("NTSC", 13500, 720, 480, DRM_MODE_FLAG_INTERLACE),=0D
+	NAMED_MODE("PAL", 13500, 720, 576, DRM_MODE_FLAG_INTERLACE),=0D
 };=0D
 =0D
 static int drm_mode_parse_cmdline_named_mode(const char *name,=0D
@@ -2265,6 +2267,7 @@ static int drm_mode_parse_cmdline_named_mode(const ch=
ar *name,=0D
 			continue;=0D
 =0D
 		strcpy(cmdline_mode->name, mode->name);=0D
+		cmdline_mode->pixel_clock =3D mode->pixel_clock_khz;=0D
 		cmdline_mode->xres =3D mode->xres;=0D
 		cmdline_mode->yres =3D mode->yres;=0D
 		cmdline_mode->interlace =3D !!(mode->flags & DRM_MODE_FLAG_INTERLACE);=0D
diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h=0D
index 7d3881f35e7c..bb39d2bb806e 100644=0D
--- a/include/drm/drm_connector.h=0D
+++ b/include/drm/drm_connector.h=0D
@@ -1352,6 +1352,13 @@ struct drm_cmdline_mode {=0D
 	 */=0D
 	bool bpp_specified;=0D
 =0D
+	/**=0D
+	 * @pixel_clock:=0D
+	 *=0D
+	 * Pixel Clock in kHz. Optional.=0D
+	 */=0D
+	unsigned int pixel_clock;=0D
+=0D
 	/**=0D
 	 * @xres:=0D
 	 *=0D
=0D
-- =0D
b4 0.10.0-dev-65ba7=0D
