Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 833155A4D62
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 15:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbiH2NQX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 09:16:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230384AbiH2NPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 09:15:44 -0400
Received: from wnew2-smtp.messagingengine.com (wnew2-smtp.messagingengine.com [64.147.123.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27311101EA
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 06:14:51 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.west.internal (Postfix) with ESMTP id 86C652B06068;
        Mon, 29 Aug 2022 09:14:21 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Mon, 29 Aug 2022 09:14:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1661778861; x=
        1661786061; bh=xUx69T5hX2fgzzekWs43tH6MuWLfYP/NBJA83S5iUhw=; b=n
        Hy/7HUsYkgrW14q8p1uy250uAZbY1KARPRC0O0Sy4Ypv/7S93iuq1fpjUdC/0sls
        LAeU1IZCq6vcxzfZdoNkycdvXaXfqhk5wefGc9e3SLhituyood978j4RjIWrqOkA
        bSyHJGOr9SvDjPXb+PRV/aZwyYIUWcV8zJCAsUWMXVy2/RlA56naS/1to2iIr5yS
        YmNLMB9PsKL4yFAfRqEI3NZLCAjBxmKA1DBnSMjRfGnX0HNOm0ZFR7GRVaA+gn2i
        i6ScUh6a7b7txa9sLSXmyew8l9b91Jr3FzfvAQBU+xV7UjO67bYN9FWgK51D7g68
        HShIg3o5jZOJC2BEdPl6g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1661778861; x=
        1661786061; bh=xUx69T5hX2fgzzekWs43tH6MuWLfYP/NBJA83S5iUhw=; b=E
        DrVv8npucDXn8znu1Xw/Cg/2kCDmlNTJEE3eTfRJclXfKCYQnzxRtsOLfzEuuS4x
        XXfM4kjKJGf3LKOAaQ+bBz5HfE7vECbPTItsx11CxozlX1WBUG2b/xjsW4ssKMq/
        8I/7CpHL12sIjg6QkOUfzaQ3sSdKujcj97GpMVkpqgbHfdToyOaVV9oPioFqglFS
        0fZ06H18MaffNnN+TLtt7hMZ2NVlbB8K7N0qb/88SriKuhwqb/93v0IzisdxgP9w
        RuxnfhS+kTgKr2OiTgw42X2gI7R7wdgB2C2PcPagKCleZknqE/PJObV8U8qvIlta
        9T7YSwZJ/tLYlpFlt67MQ==
X-ME-Sender: <xms:rLsMY7TmEoUHyS45jxIneTLsdHyxE3WYPGjqfp8ZKpkevX6f49NycQ>
    <xme:rLsMY8wOOLLBTGSjcTvEWSL95tgzBnJAgIGZ4RQ22Xi7W3LXox3AbgXtYAbJhA7px
    uaCzOuoE7WqmQPma38>
X-ME-Received: <xmr:rLsMYw3tmcItMS1kRqvSl1WE8qgDuI7mw5-mMMZfUVyfDohhpndoIk3QkMQ6>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdekuddgieefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhggtgfogfesthhqredtredtjeenucfhrhhomhepofgr
    gihimhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtf
    frrghtthgvrhhnpeefiedvfefggffgffehveejieffuddtgffhjefggeetieduvdeileet
    lefgveegtdenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:rLsMY7AIYzm4Ddyi8g8R9FoVqQzEowf2RkxXwnP1DwjVdWuCtdNQ2Q>
    <xmx:rLsMY0iXfEc1pug-Am0oHC7CSPeOBPytfbDAT5H1UZl7MHe0Q0HB0g>
    <xmx:rLsMY_q1Pce8N8z3QFtfbaa51sDO2OqWiRjtgraGVWJPuaB_wlavKA>
    <xmx:rbsMY5YxW2_aVbf67Z9iOK1l18-CtXHyojGtoDT1NXYw9fP05iU7-guZF9k>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Aug 2022 09:14:19 -0400 (EDT)
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
Subject: [PATCH v2 21/41] drm/modes: Introduce more named modes
Date:   Mon, 29 Aug 2022 15:11:35 +0200
Message-Id: <20220728-rpi-analog-tv-properties-v2-21-459522d653a7@cerno.tech>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220728-rpi-analog-tv-properties-v2-0-459522d653a7@cerno.tech>
References: <20220728-rpi-analog-tv-properties-v2-0-459522d653a7@cerno.tech>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.10.0-dev-65ba7
X-Developer-Signature: v=1; a=openpgp-sha256; l=3800; i=maxime@cerno.tech; h=from:subject:message-id; bh=MTZV8fIdkeaI3gBczvsnL6767uj0eKwoOw+fn2Eyp+g=; b=owGbwMvMwCX2+D1vfrpE4FHG02pJDMk8uxRWxrxndmPbOMnEY/o9m4c6jcZly8Ivhs2Zuejp2hea D7WfdpSyMIhxMciKKbLECJsviTs163UnG988mDmsTCBDGLg4BWAiSR6MDFvjroqr7pA2NDPrPO2rVH QqfA+fdt69P52FcWGcmhv/CTD8M7Xdvbdq8/cN91UC71Sw7mCM2cLc92+p8JbEy6Zq03nrOQE=
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

Now that we can easily extend the named modes list, let's add a few more=0D
analog TV modes that were used in the wild, and some unit tests to make=0D
sure it works as intended.=0D
=0D
Signed-off-by: Maxime Ripard <maxime@cerno.tech>=0D
=0D
diff --git a/drivers/gpu/drm/drm_modes.c b/drivers/gpu/drm/drm_modes.c=0D
index 065dbfbd815e..7d769de4d31b 100644=0D
--- a/drivers/gpu/drm/drm_modes.c=0D
+++ b/drivers/gpu/drm/drm_modes.c=0D
@@ -2254,7 +2254,9 @@ struct drm_named_mode {=0D
 =0D
 static const struct drm_named_mode drm_named_modes[] =3D {=0D
 	NAMED_MODE("NTSC", 13500, 720, 480, DRM_MODE_FLAG_INTERLACE, DRM_MODE_TV_=
MODE_NTSC_M),=0D
+	NAMED_MODE("NTSC_J", 13500, 720, 480, DRM_MODE_FLAG_INTERLACE, DRM_MODE_T=
V_MODE_NTSC_J),=0D
 	NAMED_MODE("PAL", 13500, 720, 576, DRM_MODE_FLAG_INTERLACE, DRM_MODE_TV_M=
ODE_PAL_B),=0D
+	NAMED_MODE("PAL_M", 13500, 720, 480, DRM_MODE_FLAG_INTERLACE, DRM_MODE_TV=
_MODE_PAL_M),=0D
 };=0D
 =0D
 static int drm_mode_parse_cmdline_named_mode(const char *name,=0D
diff --git a/drivers/gpu/drm/tests/drm_client_modeset_test.c b/drivers/gpu/=
drm/tests/drm_client_modeset_test.c=0D
index 4380cf670fb4..d6ecb5fbe159 100644=0D
--- a/drivers/gpu/drm/tests/drm_client_modeset_test.c=0D
+++ b/drivers/gpu/drm/tests/drm_client_modeset_test.c=0D
@@ -140,6 +140,32 @@ static void drm_pick_cmdline_named_ntsc(struct kunit *=
test)=0D
 	KUNIT_EXPECT_TRUE(test, drm_mode_equal(drm_mode_analog_ntsc_480i(drm), mo=
de));=0D
 }=0D
 =0D
+static void drm_pick_cmdline_named_ntsc_j(struct kunit *test)=0D
+{=0D
+	struct drm_client_modeset_test_priv *priv =3D test->priv;=0D
+	struct drm_device *drm =3D priv->drm;=0D
+	struct drm_connector *connector =3D &priv->connector;=0D
+	struct drm_cmdline_mode *cmdline_mode =3D &connector->cmdline_mode;=0D
+	struct drm_display_mode *mode;=0D
+	const char *cmdline =3D "NTSC_J";=0D
+	int ret;=0D
+=0D
+	KUNIT_ASSERT_TRUE(test,=0D
+			  drm_mode_parse_command_line_for_connector(cmdline,=0D
+								    connector,=0D
+								    cmdline_mode));=0D
+=0D
+	mutex_lock(&drm->mode_config.mutex);=0D
+	ret =3D drm_helper_probe_single_connector_modes(connector, 1920, 1080);=0D
+	mutex_unlock(&drm->mode_config.mutex);=0D
+	KUNIT_ASSERT_GT(test, ret, 0);=0D
+=0D
+	mode =3D drm_connector_pick_cmdline_mode(connector);=0D
+	KUNIT_ASSERT_PTR_NE(test, mode, NULL);=0D
+=0D
+	KUNIT_EXPECT_TRUE(test, drm_mode_equal(drm_mode_analog_ntsc_480i(drm), mo=
de));=0D
+}=0D
+=0D
 static void drm_pick_cmdline_named_pal(struct kunit *test)=0D
 {=0D
 	struct drm_client_modeset_test_priv *priv =3D test->priv;=0D
@@ -166,10 +192,38 @@ static void drm_pick_cmdline_named_pal(struct kunit *=
test)=0D
 	KUNIT_EXPECT_TRUE(test, drm_mode_equal(drm_mode_analog_pal_576i(drm), mod=
e));=0D
 }=0D
 =0D
+static void drm_pick_cmdline_named_pal_m(struct kunit *test)=0D
+{=0D
+	struct drm_client_modeset_test_priv *priv =3D test->priv;=0D
+	struct drm_device *drm =3D priv->drm;=0D
+	struct drm_connector *connector =3D &priv->connector;=0D
+	struct drm_cmdline_mode *cmdline_mode =3D &connector->cmdline_mode;=0D
+	struct drm_display_mode *mode;=0D
+	const char *cmdline =3D "PAL_M";=0D
+	int ret;=0D
+=0D
+	KUNIT_ASSERT_TRUE(test,=0D
+			  drm_mode_parse_command_line_for_connector(cmdline,=0D
+								    connector,=0D
+								    cmdline_mode));=0D
+=0D
+	mutex_lock(&drm->mode_config.mutex);=0D
+	ret =3D drm_helper_probe_single_connector_modes(connector, 1920, 1080);=0D
+	mutex_unlock(&drm->mode_config.mutex);=0D
+	KUNIT_ASSERT_GT(test, ret, 0);=0D
+=0D
+	mode =3D drm_connector_pick_cmdline_mode(connector);=0D
+	KUNIT_ASSERT_PTR_NE(test, mode, NULL);=0D
+=0D
+	KUNIT_EXPECT_TRUE(test, drm_mode_equal(drm_mode_analog_ntsc_480i(drm), mo=
de));=0D
+}=0D
+=0D
 static struct kunit_case drm_pick_cmdline_tests[] =3D {=0D
 	KUNIT_CASE(drm_pick_cmdline_res_1920_1080_60),=0D
 	KUNIT_CASE(drm_pick_cmdline_named_ntsc),=0D
+	KUNIT_CASE(drm_pick_cmdline_named_ntsc_j),=0D
 	KUNIT_CASE(drm_pick_cmdline_named_pal),=0D
+	KUNIT_CASE(drm_pick_cmdline_named_pal_m),=0D
 	{}=0D
 };=0D
 =0D
=0D
-- =0D
b4 0.10.0-dev-65ba7=0D
