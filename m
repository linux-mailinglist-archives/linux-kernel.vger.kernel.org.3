Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D443D5853CE
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 18:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238126AbiG2QqR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 12:46:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238123AbiG2Qps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 12:45:48 -0400
Received: from new4-smtp.messagingengine.com (new4-smtp.messagingengine.com [66.111.4.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDDD588F14
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 09:45:47 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailnew.nyi.internal (Postfix) with ESMTP id 9E44458094F;
        Fri, 29 Jul 2022 12:36:24 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 29 Jul 2022 12:36:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1659112584; x=
        1659119784; bh=HUTF54qcrEltxzuIrBwhVolQypRjTlRuOsWlypQ6pmU=; b=Y
        3qvbMg0nMPY/sSD+ANhC6NoLOghOrembCe1ttCjztXQ2l7ogT0Y+fWmrmpAH/NXm
        /9kv0RnY/Qpvn9sF/6zd1Bfr/IjZLrjFMl6SlI0bW3oadrWHw452dKIylhjC0nq1
        l+ZK4pDoe8BS5WVBUkosSetZpteAuRQOjOjNtQXCpPOj01Xi8FW7ngYfQNTqypfJ
        pBW7Feenp5eE6mFwUcr7um5GVrGewPLtUMHCBugBbrkBkPXDMpNtcAmezO5oy/J+
        ALu1Up7V2KcKE4RkwOt8OylDVw0QARU/BiJ/dTZ2aLpyFqTWRm5zKruHw2YV7S25
        wu5/a7TQmebkxp1WUubeA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1659112584; x=
        1659119784; bh=HUTF54qcrEltxzuIrBwhVolQypRjTlRuOsWlypQ6pmU=; b=j
        x+492p3mBGelDO/J5BTtexdxgdebe0Y6tqY904gOm5dkSo/jHdL8xbP1xOsscBd+
        ZuVRBbe2UsGTTKFiv98e8mBwaeRjpQeDXGO/BNFHaDKzlrq5IARsVSgY9TE2W8if
        SQ/KlAaVbYe9zrrbCbyiXovT2fZ9jxUokUqkeGCnrbrtK/eluymVEUczT/cD0ArT
        ck+G+JUvvvAEkw+toXuylIBGDhQZfO9lW81HKGiCKuePuld2jHCYi9afWd1PBM+N
        Dt+F+4hEDdsx/WEw9r8l2FqNWRO2yQZJIu4qTTWU6RWA6QyEwC+iC/N5EX3lNuvv
        QeCgQgG8cMp6RCRN+BOsw==
X-ME-Sender: <xms:iAzkYpmtiRn-da7KR7fdlMBNk4ZEp-UvVasIgEOonZWSMu6bqo-Qgw>
    <xme:iAzkYk18mJCAXeX7oW6lohVRrN1-vIKTCBeVjo_-dtYTjrGCBVWg9TKekPnfIZ_WN
    iglEnIY0ympab-WIt8>
X-ME-Received: <xmr:iAzkYvpy9uTq3XzxzPjqz-dEIIS2I97W2_-OP8_yvG3UVSOVqVRzd7-AuCHTSRSHXz_of_JsrIJp6cUv9YE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvddujedguddtgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvfevufffkffojghfgggtoffgsehtkeertdertdejnecuhfhrohhmpefo
    rgigihhmvgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecugg
    ftrfgrthhtvghrnhepgfffgfetffduudelhfevieffffduleevgfegkeeutefgffejheel
    leekjeefhfejnecuvehluhhsthgvrhfuihiivgepgeenucfrrghrrghmpehmrghilhhfrh
    homhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:iAzkYpn8lveDuwGB43as4FpZMYL0kIKwCdZK52Qte6XabTH66F11MQ>
    <xmx:iAzkYn3HitmPCMfvRR308V1Vxrs_d-dJYomcrrbKPOVcIJXpFsw8pA>
    <xmx:iAzkYovacx27N2JoBD8YUJTjLOrf3uaLHYgDAAt_-X9pahAXP2mjfg>
    <xmx:iAzkYiFahJ68lyA8bT6vERSXox_ZGa0Rt2a7M-Yy0qmE3bgYfXJ7oA>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 29 Jul 2022 12:36:22 -0400 (EDT)
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
Subject: [PATCH v1 16/35] drm/vc4: vec: Convert to atomic helpers
Date:   Fri, 29 Jul 2022 18:34:59 +0200
Message-Id: <20220728-rpi-analog-tv-properties-v1-16-3d53ae722097@cerno.tech>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220728-rpi-analog-tv-properties-v1-0-3d53ae722097@cerno.tech>
References: <20220728-rpi-analog-tv-properties-v1-0-3d53ae722097@cerno.tech>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.10.0-dev-49460
X-Developer-Signature: v=1; a=openpgp-sha256; l=1629; i=maxime@cerno.tech; h=from:subject:message-id; bh=wVpNGhINRc9XThGUAhn0EA3UH3mvunqoxgBDqkbwN5Q=; b=owGbwMvMwCHc4XzqmfnC7acZT6slMSQ94VG6xvf4oSR3yY7Oi/Vbm2aslYzTtm1Z13u3QovjwtEY HaVvHaUsDMIcDLJiiizXBd/a8YVFuUXwfNgMM4eVCWQIAxenAEwkUpuR4YEvN8NXTddpXNp/8rY+7l Q8udq9SSVyvrLN+WW3pv9f/Ybhf0DqlncdV19tmPb6R/Np8efuewJmutnXrDOMq9xlfi76zHoA
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

The VC4 VEC driver still uses legacy enable and disable hook
implementation. Let's convert to the atomic variants.

Signed-off-by: Maxime Ripard <maxime@cerno.tech>

diff --git a/drivers/gpu/drm/vc4/vc4_vec.c b/drivers/gpu/drm/vc4/vc4_vec.c
index 17a6afac61cd..ba0a81250d08 100644
--- a/drivers/gpu/drm/vc4/vc4_vec.c
+++ b/drivers/gpu/drm/vc4/vc4_vec.c
@@ -375,7 +375,8 @@ static int vc4_vec_connector_init(struct drm_device *dev, struct vc4_vec *vec)
 	return 0;
 }
 
-static void vc4_vec_encoder_disable(struct drm_encoder *encoder)
+static void vc4_vec_encoder_disable(struct drm_encoder *encoder,
+				    struct drm_atomic_state *state)
 {
 	struct drm_device *drm = encoder->dev;
 	struct vc4_vec *vec = encoder_to_vc4_vec(encoder);
@@ -406,7 +407,8 @@ static void vc4_vec_encoder_disable(struct drm_encoder *encoder)
 	drm_dev_exit(idx);
 }
 
-static void vc4_vec_encoder_enable(struct drm_encoder *encoder)
+static void vc4_vec_encoder_enable(struct drm_encoder *encoder,
+				   struct drm_atomic_state *state)
 {
 	struct drm_device *drm = encoder->dev;
 	struct vc4_vec *vec = encoder_to_vc4_vec(encoder);
@@ -508,9 +510,9 @@ static int vc4_vec_encoder_atomic_check(struct drm_encoder *encoder,
 }
 
 static const struct drm_encoder_helper_funcs vc4_vec_encoder_helper_funcs = {
-	.disable = vc4_vec_encoder_disable,
-	.enable = vc4_vec_encoder_enable,
 	.atomic_check = vc4_vec_encoder_atomic_check,
+	.atomic_disable = vc4_vec_encoder_disable,
+	.atomic_enable = vc4_vec_encoder_enable,
 	.atomic_mode_set = vc4_vec_encoder_atomic_mode_set,
 };
 

-- 
b4 0.10.0-dev-49460
