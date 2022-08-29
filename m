Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9277C5A4DB2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 15:19:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbiH2NTd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 09:19:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230487AbiH2NSn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 09:18:43 -0400
Received: from wnew2-smtp.messagingengine.com (wnew2-smtp.messagingengine.com [64.147.123.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CA285C374
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 06:17:21 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id D39432B06042;
        Mon, 29 Aug 2022 09:16:06 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 29 Aug 2022 09:16:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1661778966; x=
        1661786166; bh=d7clZxO7I3eO98KnGdsmo+IO+/vbylIbR6+bBaeoXdw=; b=r
        Yebl8gxFwJmJvRJ+TAQrxa2mZzy9LMyCcQTFVma7R7SzwQUA66DgZlZqNF25NHMj
        L3PiguJJmWk8wMWPJ1rM6MNUecQMSEm8fy5qIcNGnvsQhfX5nnCLlfSsybShX22l
        vWfsR3ngGRm2NpwRJf+fA8PtwEDdW+JA4I2HLHHklLMvA6HW/rslBVjucJAuZe18
        Y7lOxDLgPrHoIIwq3M4ps0KEl4jSUIzDH64039T3e7GEf0A0tnI5OO3r2kWHLdaY
        GSMnl2FhqCPnwbWJ/qkOndrSMZEz8Q7LgVKXGF5kKT3COz6R03cpb1ltx0fZQ5Db
        2SJd4bUnl0g5wsdgSpfgw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1661778966; x=
        1661786166; bh=d7clZxO7I3eO98KnGdsmo+IO+/vbylIbR6+bBaeoXdw=; b=z
        66An1LQGGHpif1xWysF2LJUXkLrlRKOYi0c6475Wq2Y1GRdr8iAr9H+sSmJBqPq9
        JRSoTMwOoMgnvHOUyRp6Fus77Y1K/RL6NFw4O5Wv9SnON1KwCmhZqXz+f5gVTtnk
        zbtCbk0Jrnki19Vf3MDFReoWtVC3dxBrmQYpYOFW8xJxYkXBO6safcX1qOSi/Hkp
        YLHtEIEYFU71z2yNTAI4AB3A/ppZ3O799MnWm27eWTsj8xsIvRDE0JOP2aVDYpP/
        rJ+aD0Cx7a8IYoKfWYMaLcEVu+KFdNY96I0ZwoUsXkTCnIGbRbsz/tOn+EOvwEJ/
        GdLBJtpTW0Eb1I4V2hEOg==
X-ME-Sender: <xms:FrwMY1gdM8t6C4cbVzbHwOZdjwpBaStfT6KO3rNFOvoZebm9cTLr_A>
    <xme:FrwMY6CqNhbTcEkyfkhMh_mI-PWcrzOydSGoIvy3gqEC220tB6dfxqxKItKDH4NRW
    riQ06emzA3arIOV5BU>
X-ME-Received: <xmr:FrwMY1G-cpWUh5f8ugQhOhAmjWQXTl_rt63Jywqedg41tkCn9Lk2Z1HFd_TG>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdekuddgieefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhggtgfogfesthhqredtredtjeenucfhrhhomhepofgr
    gihimhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtf
    frrghtthgvrhhnpeefiedvfefggffgffehveejieffuddtgffhjefggeetieduvdeileet
    lefgveegtdenucevlhhushhtvghrufhiiigvpeeinecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:FrwMY6Q6Z67PJLSAC2093kB412p3PL0XXOayWFDNEqe0cdCcGZnfDA>
    <xmx:FrwMYywUF4S2zmhSI5dctw2uX3nhR6irH-PvXZ61qMoCbakm908oXg>
    <xmx:FrwMYw67aTtbepsh0oeHW8E9CWlS4roX-lp4iu0IaBZWNWJKnPTwVA>
    <xmx:FrwMY8q49ofEqsOCAHBVLEoVGA43s74JpT8hueTbl8yQCqBZRI4zeflGBtA>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Aug 2022 09:16:05 -0400 (EDT)
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
Subject: [PATCH v2 37/41] drm/sun4i: tv: Remove useless function
Date:   Mon, 29 Aug 2022 15:11:51 +0200
Message-Id: <20220728-rpi-analog-tv-properties-v2-37-459522d653a7@cerno.tech>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220728-rpi-analog-tv-properties-v2-0-459522d653a7@cerno.tech>
References: <20220728-rpi-analog-tv-properties-v2-0-459522d653a7@cerno.tech>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.10.0-dev-65ba7
X-Developer-Signature: v=1; a=openpgp-sha256; l=761; i=maxime@cerno.tech; h=from:subject:message-id; bh=azl4tdJEs9Q+qPax/2oZwteOATZIm73l0YTHGZIqrtQ=; b=owGbwMvMwCX2+D1vfrpE4FHG02pJDMk8uxQzNPYcqlDddEq8sk43uLttZt9+fX95AwGNtYZ8XFqf DH50lLIwiHExyIopssQImy+JOzXrdScb3zyYOaxMIEMYuDgFYCJVbYwMM98mf2BaJX7jtZ+YdP+7NW arv9/IWJm0yetM6Pb91oFVkQz/CzfcT/zIZWG291nTivZcq/Pzb/jf8hWXykjambbzUaoRGwA=
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

The drm_connector_to_sun4i_tv() function isn't used anywhere in the driver,=
=0D
so let's remove it.=0D
=0D
Signed-off-by: Maxime Ripard <maxime@cerno.tech>=0D
=0D
diff --git a/drivers/gpu/drm/sun4i/sun4i_tv.c b/drivers/gpu/drm/sun4i/sun4i=
_tv.c=0D
index 3944da9a3c34..52bbba8f19dc 100644=0D
--- a/drivers/gpu/drm/sun4i/sun4i_tv.c=0D
+++ b/drivers/gpu/drm/sun4i/sun4i_tv.c=0D
@@ -275,13 +275,6 @@ drm_encoder_to_sun4i_tv(struct drm_encoder *encoder)=0D
 			    encoder);=0D
 }=0D
 =0D
-static inline struct sun4i_tv *=0D
-drm_connector_to_sun4i_tv(struct drm_connector *connector)=0D
-{=0D
-	return container_of(connector, struct sun4i_tv,=0D
-			    connector);=0D
-}=0D
-=0D
 /*=0D
  * FIXME: If only the drm_display_mode private field was usable, this=0D
  * could go away...=0D
=0D
-- =0D
b4 0.10.0-dev-65ba7=0D
