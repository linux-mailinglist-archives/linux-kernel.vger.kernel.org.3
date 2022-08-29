Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E75A5A4D43
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 15:14:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbiH2NOK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 09:14:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbiH2NNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 09:13:44 -0400
Received: from wnew2-smtp.messagingengine.com (wnew2-smtp.messagingengine.com [64.147.123.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F5CA550B7
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 06:13:19 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id DE0332B06057;
        Mon, 29 Aug 2022 09:13:15 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 29 Aug 2022 09:13:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1661778795; x=
        1661785995; bh=5SmMwyB9Gqo8FDnXGtfd83YIIFTn/fwrRNe//5Xw3dI=; b=t
        vkJx7SeS1Cy1yJQMfqERqufTAT+s42Q/fsY8BqGnHF2WH82nxv54orocvcQsDRSe
        xHEwnDwiAvdCRWdgtIvjdVG138mZX/FkxJqXEvuQ2j+3dljstbGtxuvN0NKS8cqm
        yrtyLvP1AF5gttBnR3m9QyGJWOHtqfHWm7ZVwmUsaAkcLptw6gsPBkO6fbBADeuW
        5JpByOliaT/Dz6oYTS753tpSe8UO96aZOQaK+AdLwZeuUygTcELBH9EPS8rMva7m
        RDe16clj6vI4xOwZWXcKW/Iyl95azTUmuBDD9kbJuHdDOntoCfrQO6Bn4vaudqHD
        bg5dC3i1jsG08ffjD5y4Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1661778795; x=
        1661785995; bh=5SmMwyB9Gqo8FDnXGtfd83YIIFTn/fwrRNe//5Xw3dI=; b=T
        DNq5wlW/QB6mLqqaE8+uTZxuMwFFIAAdRI99gXbGZGcs2Bp0L+7EnGqbP0ApWb32
        E9+sbTKvmaSY29vURTvbnYqlD8Xc1Trl/mDCb117C/Oz83UyaShSxoiPmhGr1/o8
        3UCcx6RpckiTNPH+uvYeSfzGrnAg1gLg/wjiJUMgpYNy4DYd2RDAG6icAguhH8Rx
        wYBH9bYFVYo+qJbG+5PajyHfJT4X6lf4OClsEi4HlK0zhyR8PymfIYw9kNVHzTh0
        m1kx2cKWIQog50gFNd29gd48AyVJIpxZdi+amzF7hU0ds70gLTiTsHEwK/rADDsi
        Sw7P6ZMPx4x/qinOZSC7Q==
X-ME-Sender: <xms:a7sMYwyB-k92QNp8-nQ9XvK_0dfuOCEAaDSzJjtVa9ARGDDcaWM8Nw>
    <xme:a7sMY0TWn8SnlNgA0BcQGz9GBnFSC_9GLrYrxSSLUTgHCLgYOC0sGgR_7nCAwa9o6
    0kEW5u6rcFzf1gx51M>
X-ME-Received: <xmr:a7sMYyWrn8jEeKYdkKXaGuDlma7RgsvSgFrPMtk-eNPgjKhOtktVUvLbKpZb>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdekuddgieefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhggtgfogfesthhqredtredtjeenucfhrhhomhepofgr
    gihimhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtf
    frrghtthgvrhhnpeefiedvfefggffgffehveejieffuddtgffhjefggeetieduvdeileet
    lefgveegtdenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:a7sMY-iIvgCVvL2dem2GF3eP8kaq3WYieT102Utpg0w3jw-wqjhb8g>
    <xmx:a7sMYyB_RCJ6kF6QlGRzTf1bCClGBbLnJ3SHOpqyfegcBooyfiWb8g>
    <xmx:a7sMY_J8x5PafkdERhvaHQliP5Z64LnTNyH9-p0iiUdh6A07RKPpUA>
    <xmx:a7sMY065C0Zvo9S-7e8fcRgLIBQnTqOJ1YpBSk4Vc7NDK_iS5wJP4mEmE5E>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Aug 2022 09:13:14 -0400 (EDT)
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
Subject: [PATCH v2 11/41] drm/modes: Only consider bpp and refresh before options
Date:   Mon, 29 Aug 2022 15:11:25 +0200
Message-Id: <20220728-rpi-analog-tv-properties-v2-11-459522d653a7@cerno.tech>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220728-rpi-analog-tv-properties-v2-0-459522d653a7@cerno.tech>
References: <20220728-rpi-analog-tv-properties-v2-0-459522d653a7@cerno.tech>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.10.0-dev-65ba7
X-Developer-Signature: v=1; a=openpgp-sha256; l=1602; i=maxime@cerno.tech; h=from:subject:message-id; bh=8m2oE9knJwjnJjXPGWMUzPqprWg4Yy2kfTXAOXrvUBw=; b=owGbwMvMwCX2+D1vfrpE4FHG02pJDMk8u+TFb5186ny1/84sy/s5f/fZntb7tNzPRSPttvTSm1cN ez4c6ihlYRDjYpAVU2SJETZfEndq1utONr55MHNYmUCGMHBxCsBELosxMhxUVWW7O7lOLH3qibNR5y 7/5vyrydC9J37Pi3/7lBmPvqhl+GelPS+9T6HOxO6kutbhwMIzWZXcy7ojzn15b1s2dQ1nJTMA
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

Some video=3D options might have a value that contains a dash. However, the=
=0D
command line parsing mode considers all dashes as the separator between the=
=0D
mode and the bpp count.=0D
=0D
Let's rework the parsing code a bit to only consider a dash as the bpp=0D
separator if it before a comma, the options separator.=0D
=0D
A follow-up patch will add a unit-test for this once such an option is=0D
introduced.=0D
=0D
Signed-off-by: Maxime Ripard <maxime@cerno.tech>=0D
Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>=0D
=0D
diff --git a/drivers/gpu/drm/drm_modes.c b/drivers/gpu/drm/drm_modes.c=0D
index ee581ee17171..b4e1ff56b4d8 100644=0D
--- a/drivers/gpu/drm/drm_modes.c=0D
+++ b/drivers/gpu/drm/drm_modes.c=0D
@@ -2254,20 +2254,22 @@ bool drm_mode_parse_command_line_for_connector(cons=
t char *mode_option,=0D
 =0D
 	name =3D mode_option;=0D
 =0D
+	/* Locate the start of named options */=0D
+	options_ptr =3D strchr(name, ',');=0D
+	if (options_ptr)=0D
+		options_off =3D options_ptr - name;=0D
+	else=0D
+		options_off =3D strlen(name);=0D
+=0D
 	/* Try to locate the bpp and refresh specifiers, if any */=0D
-	bpp_ptr =3D strchr(name, '-');=0D
+	bpp_ptr =3D strnchr(name, options_off, '-');=0D
 	if (bpp_ptr)=0D
 		bpp_off =3D bpp_ptr - name;=0D
 =0D
-	refresh_ptr =3D strchr(name, '@');=0D
+	refresh_ptr =3D strnchr(name, options_off, '@');=0D
 	if (refresh_ptr)=0D
 		refresh_off =3D refresh_ptr - name;=0D
 =0D
-	/* Locate the start of named options */=0D
-	options_ptr =3D strchr(name, ',');=0D
-	if (options_ptr)=0D
-		options_off =3D options_ptr - name;=0D
-=0D
 	/* Locate the end of the name / resolution, and parse it */=0D
 	if (bpp_ptr) {=0D
 		mode_end =3D bpp_off;=0D
=0D
-- =0D
b4 0.10.0-dev-65ba7=0D
