Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3A2958538A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 18:37:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237484AbiG2QhH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 12:37:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237302AbiG2Qgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 12:36:48 -0400
Received: from new4-smtp.messagingengine.com (new4-smtp.messagingengine.com [66.111.4.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9674F823B7
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 09:36:47 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailnew.nyi.internal (Postfix) with ESMTP id BFCA6580980;
        Fri, 29 Jul 2022 12:36:46 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Fri, 29 Jul 2022 12:36:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1659112606; x=
        1659119806; bh=F/VhzqSdix62l27XLYpBCO7aYppl/5mjESdrPRMdeMc=; b=R
        N2JuGdu18CHIuri+ZEN21A+gOWBanrWJAdBZfy8XN8R4Ow329APiorsMscoXqOQg
        eOE2YsLI6f7o8Gd2BCDy5z91TzE9qYxZEC0TWq0jLGQwoH6RO8LEXykeaf5LQ8e6
        dPLTOimT/CkauHyzo+UQEkPHpVNGSM1C7d7UgqYM1tddzyHWKiORXq8TeC1ctdNG
        +GOvyTLQeBaTu6FTJXzL6wRQVPfWWapk3t9HuiPW8HCqgzYKRcidbeEBgMaXhrEi
        m6tQcF1Rt1+ac7omlnFCBrlnEIWrUQi698cVL822Ax7y5l42VUqo0UjHNX6zoxIv
        5FNPH+uJjI/DfrvzYt+kg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1659112606; x=
        1659119806; bh=F/VhzqSdix62l27XLYpBCO7aYppl/5mjESdrPRMdeMc=; b=z
        4ueLWEyrH7WkXZUGIsik5MVqZNX+2HVLgIAEblLyKPrkk/8wzP8Ku5w0LvClM/Kq
        5S+wwmxEdGspf/YGU4TJfKTFveMCX5mB4ufSiD+Wpg7otR+XedA1arkqjYTnlj7W
        JDOUTaMsbQRzU7rW/hqzvGWmM8k21by6o3iL93GU9ZEv6cv+YKKZShd6ln6YS0tS
        P/rSpkPaPLunXPJd4Hmb6up3wRS2R/Q8ost6sbTFzf5OwyByAeb2TroBUNPFwG+6
        AgyQw6JImeocmGf5Ix4PnJo6Ne/evhdizBRXaQ0GmlbBoIGMTFdwOi5rtxoea70i
        UY7t25eF1qmwCoTJjwZQA==
X-ME-Sender: <xms:ngzkYvafpr2EdemV5seaOhBv1voZ-ojuQIgmyD0TgbLNVMDMr8_k3g>
    <xme:ngzkYuY7Z4ZopYVGu0pD7T86m0z62xW5Q8q4G9sALRVnKP4gU_7nPvvMR14Tfq77V
    0d2Qsxfywzk8BCgM60>
X-ME-Received: <xmr:ngzkYh99LZ0CxrogW1QcL-zgdquM9EvEO5V3J0F57ZpPXdMPtQgFGVpTNqerQzDyx7f8Hy5AFt2z-PsfTAI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvddujedguddtgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvfevufffkffojghfgggtoffgsehtkeertdertdejnecuhfhrohhmpefo
    rgigihhmvgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecugg
    ftrfgrthhtvghrnhepgfffgfetffduudelhfevieffffduleevgfegkeeutefgffejheel
    leekjeefhfejnecuvehluhhsthgvrhfuihiivgepheenucfrrghrrghmpehmrghilhhfrh
    homhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:ngzkYlqMP0q3Hl-LwPjelYRYtk8ORdydMEgkmObcWzyDSwb1aN_IOA>
    <xmx:ngzkYqpiY2DYSm3krmA7k7OcIdQfZAlGeuJKBVq-87yxQLL8M3QdDg>
    <xmx:ngzkYrRalDbhUZcnKZu2hPGQQ7Khdkuo3F297-8eYwT7uuMUxZzNtw>
    <xmx:ngzkYsZaTFUwQuJshpOgn4B7ern2UujR8T4vUOvywhse_np8eQYj_A>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 29 Jul 2022 12:36:45 -0400 (EDT)
From:   Maxime Ripard <maxime@cerno.tech>
To:     Jernej Skrabec <jernej.skrabec@gmail.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Samuel Holland <samuel@sholland.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel@ffwll.ch>, Emma Anholt <emma@anholt.net>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Maxime Ripard <mripard@kernel.org>
Cc:     Maxime Ripard <maxime@cerno.tech>, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, Phil Elwell <phil@raspberrypi.com>,
        Mateusz Kwiatkowski <kfyatek+publicgit@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        linux-amlogic@lists.infradead.org, dri-devel@lists.freedesktop.org,
        Dom Cobley <dom@raspberrypi.com>
Subject: [PATCH v1 22/35] drm/vc4: vec: Use TV Reset implementation
Date:   Fri, 29 Jul 2022 18:35:05 +0200
Message-Id: <20220728-rpi-analog-tv-properties-v1-22-3d53ae722097@cerno.tech>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220728-rpi-analog-tv-properties-v1-0-3d53ae722097@cerno.tech>
References: <20220728-rpi-analog-tv-properties-v1-0-3d53ae722097@cerno.tech>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.10.0-dev-49460
X-Developer-Signature: v=1; a=openpgp-sha256; l=1406; i=maxime@cerno.tech; h=from:subject:message-id; bh=2RWnJNFvJqSTsOQ2zvbFCwdfzkNymcZjtNpJxCcBkek=; b=owGbwMvMwCHc4XzqmfnC7acZT6slMSQ94VHyarC6xHSooKXyrvLmvZc77wnv4RNY+P+oe0HQp3XT nRzmdZSyMAhzMMiKKbJcF3xrxxcW5RbB82EzzBxWJpAhDFycAjCRGXkM/z0r68NfuC20lF0nu6tr62 opU9NUZQn9E6s7VlXdlDmh7sDwV+T79Zl3dwiu/WWotCiqwO6oxUc+myc2xiVPlzn4/fPWkwcA
X-Developer-Key: i=maxime@cerno.tech; a=openpgp; fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The analog TV properties created by the drm_mode_create_tv_properties() are
not properly initialised at reset. Let's switch our implementation to call
drm_atomic_helper_connector_tv_reset().

Signed-off-by: Maxime Ripard <maxime@cerno.tech>

diff --git a/drivers/gpu/drm/vc4/vc4_vec.c b/drivers/gpu/drm/vc4/vc4_vec.c
index fba15a14787e..6f4536bf537f 100644
--- a/drivers/gpu/drm/vc4/vc4_vec.c
+++ b/drivers/gpu/drm/vc4/vc4_vec.c
@@ -254,6 +254,12 @@ vc4_vec_connector_detect(struct drm_connector *connector, bool force)
 	return connector_status_unknown;
 }
 
+void vc4_vec_connector_reset(struct drm_connector *connector)
+{
+	drm_atomic_helper_connector_reset(connector);
+	drm_atomic_helper_connector_tv_reset(connector);
+}
+
 static int vc4_vec_connector_get_modes(struct drm_connector *connector)
 {
 	struct drm_connector_state *state = connector->state;
@@ -274,7 +280,7 @@ static int vc4_vec_connector_get_modes(struct drm_connector *connector)
 static const struct drm_connector_funcs vc4_vec_connector_funcs = {
 	.detect = vc4_vec_connector_detect,
 	.fill_modes = drm_helper_probe_single_connector_modes,
-	.reset = drm_atomic_helper_connector_reset,
+	.reset = vc4_vec_connector_reset,
 	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
 };

-- 
b4 0.10.0-dev-49460
