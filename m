Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C24285A4E06
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 15:27:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbiH2N1h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 09:27:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbiH2N1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 09:27:05 -0400
Received: from wnew2-smtp.messagingengine.com (wnew2-smtp.messagingengine.com [64.147.123.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19957832DF
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 06:25:48 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailnew.west.internal (Postfix) with ESMTP id 3C1002B06079;
        Mon, 29 Aug 2022 09:15:13 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 29 Aug 2022 09:15:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1661778912; x=
        1661786112; bh=Cy32MWV8KYEmUS1RyGwWX/yQEjQBWMj/hXAbB2FpSbs=; b=V
        s4RNIpSxGeLQo1UWIoyjlMUQe2kKesyCj00VfmTnmA9s9809cRUTc1FY6i9RyLIS
        o6oM8OQNSa+LoOX3ilxktbPyOqhY28lk4l95SvMzowQnC9i7p5nNgJ+rurtgqQyR
        aeKWX5TaqBTFDj86loR8aBpYmX7U5HYNwGwjezJukbNFdSVgPkdFtkecMyb2Lk+Y
        BnrNI8xva/TuVhnCFcRtSZawg0rT2jeMmFkJ2z/5yT9L202/xHzYGwr99BwEWN63
        I4yy9eVWAtJNKlexbdCQaoYoXFei+8wrwoRNAdgdnLwDkxVPXxomadxKHK2vv7GG
        nI6r74d/X93ysd/fCssdA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1661778912; x=
        1661786112; bh=Cy32MWV8KYEmUS1RyGwWX/yQEjQBWMj/hXAbB2FpSbs=; b=1
        SbjYncYrBzBlWAhPZio1zMuS1gF3Tuw/UJSvnjsxHB4IMZNtXjgSRIyC9PJzxZbY
        dZ0wibnoYzomzbiK8gCH2DqK5gu/uSlLRgnIhbGDbVNrgt79CGRwS5oUbG0UXwHe
        OES/fBSbLfjGtD65t7dVE8ckm8biUqW6CW1N9Oo0bS51SYvj/nZ0cAcK/0SvXnu+
        /Ma6rIq0xRHU98/CSilD292MvmY81AkEeMY4RrQMI9oXLbK6YHxHL/CHX5c+TVN3
        gqxrYZK/M0qmCBe3ZeoaJdishLgqIg+cWaIWH3zukyx17ec/M8EWR4E15cqPfAkZ
        N7O0RSVVjvdch78d1oTJA==
X-ME-Sender: <xms:4LsMYy5rqAcxGSbmlVmw92RrO8cMXwF2PgIVky7ANkonHLrtf2kJZg>
    <xme:4LsMY74SX43GMhpl2E7sCd_GJOtyVqzfGWm1RPrIkPhgIKvwIs5hrP0MaB_o3vuYL
    DtzkBR35jaAdnu0owI>
X-ME-Received: <xmr:4LsMYxcH2p43M9xbM63IynEIiAg4UeS48NeWfhKCpnYA_wdWnMdhL-e69PBB>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdekuddgieegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhggtgfogfesthhqredtredtjeenucfhrhhomhepofgr
    gihimhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtf
    frrghtthgvrhhnpeefiedvfefggffgffehveejieffuddtgffhjefggeetieduvdeileet
    lefgveegtdenucevlhhushhtvghrufhiiigvpeefnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:4LsMY_IaS0W-q_Ac4y_dh7FP304dFAizyLlha88koiUAXTCWiKNTzw>
    <xmx:4LsMY2Kpi-rJcTmFKKSYnmYoXfVE7q16mGfjsKzPsVCFn46czlYVKw>
    <xmx:4LsMYwzH4_qoibpjvsBtEV8CMuDSdistNt0RfgnpYUyU8ZicRqzHRg>
    <xmx:4LsMY_i-jlos2mlt_jq9eXUYJ9YtyiK24AgyGRmcjXqWRlQKiKNwxnjAvEA>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Aug 2022 09:15:11 -0400 (EDT)
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
Subject: [PATCH v2 29/41] drm/vc4: vec: Switch for common modes
Date:   Mon, 29 Aug 2022 15:11:43 +0200
Message-Id: <20220728-rpi-analog-tv-properties-v2-29-459522d653a7@cerno.tech>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220728-rpi-analog-tv-properties-v2-0-459522d653a7@cerno.tech>
References: <20220728-rpi-analog-tv-properties-v2-0-459522d653a7@cerno.tech>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.10.0-dev-65ba7
X-Developer-Signature: v=1; a=openpgp-sha256; l=1771; i=maxime@cerno.tech; h=from:subject:message-id; bh=ul/McL233i67f1nEv4GMQq5Y+Mz3yULy3JKyqht7K6U=; b=owGbwMvMwCX2+D1vfrpE4FHG02pJDMk8uxScppTyPA6c1CT3/72hZHRYkmxbl0+oeE+68H7NMBaG KYc7SlkYxLgYZMUUWWKEzZfEnZr1upONbx7MHFYmkCEMXJwCMBGp1YwMUyYynfdOaz62c20d82dHjm enCsvPav52uCj7gfsoe0FJFyPD2u7zHxnX1Zy8rrFL0sB8sodJRpxW3O6ym1V+q6tV0zx5AA==
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

Now that the core has a definition for the 525 and 625 lines analog TV=0D
modes, let's switch to it for vc4.=0D
=0D
Signed-off-by: Maxime Ripard <maxime@cerno.tech>=0D
=0D
diff --git a/drivers/gpu/drm/vc4/vc4_vec.c b/drivers/gpu/drm/vc4/vc4_vec.c=
=0D
index d1d40b69279e..63e4e617e321 100644=0D
--- a/drivers/gpu/drm/vc4/vc4_vec.c=0D
+++ b/drivers/gpu/drm/vc4/vc4_vec.c=0D
@@ -224,38 +224,24 @@ static const struct debugfs_reg32 vec_regs[] =3D {=0D
 	VC4_REG32(VEC_DAC_MISC),=0D
 };=0D
 =0D
-static const struct drm_display_mode ntsc_mode =3D {=0D
-	DRM_MODE("720x480", DRM_MODE_TYPE_DRIVER, 13500,=0D
-		 720, 720 + 14, 720 + 14 + 64, 720 + 14 + 64 + 60, 0,=0D
-		 480, 480 + 7, 480 + 7 + 6, 525, 0,=0D
-		 DRM_MODE_FLAG_INTERLACE)=0D
-};=0D
-=0D
-static const struct drm_display_mode pal_mode =3D {=0D
-	DRM_MODE("720x576", DRM_MODE_TYPE_DRIVER, 13500,=0D
-		 720, 720 + 20, 720 + 20 + 64, 720 + 20 + 64 + 60, 0,=0D
-		 576, 576 + 4, 576 + 4 + 6, 625, 0,=0D
-		 DRM_MODE_FLAG_INTERLACE)=0D
-};=0D
-=0D
 static const struct vc4_vec_tv_mode vc4_vec_tv_modes[] =3D {=0D
 	[VC4_VEC_TV_MODE_NTSC] =3D {=0D
-		.mode =3D &ntsc_mode,=0D
+		.mode =3D &drm_mode_480i,=0D
 		.config0 =3D VEC_CONFIG0_NTSC_STD | VEC_CONFIG0_PDEN,=0D
 		.config1 =3D VEC_CONFIG1_C_CVBS_CVBS,=0D
 	},=0D
 	[VC4_VEC_TV_MODE_NTSC_J] =3D {=0D
-		.mode =3D &ntsc_mode,=0D
+		.mode =3D &drm_mode_480i,=0D
 		.config0 =3D VEC_CONFIG0_NTSC_STD,=0D
 		.config1 =3D VEC_CONFIG1_C_CVBS_CVBS,=0D
 	},=0D
 	[VC4_VEC_TV_MODE_PAL] =3D {=0D
-		.mode =3D &pal_mode,=0D
+		.mode =3D &drm_mode_576i,=0D
 		.config0 =3D VEC_CONFIG0_PAL_BDGHI_STD,=0D
 		.config1 =3D VEC_CONFIG1_C_CVBS_CVBS,=0D
 	},=0D
 	[VC4_VEC_TV_MODE_PAL_M] =3D {=0D
-		.mode =3D &pal_mode,=0D
+		.mode =3D &drm_mode_576i,=0D
 		.config0 =3D VEC_CONFIG0_PAL_BDGHI_STD,=0D
 		.config1 =3D VEC_CONFIG1_C_CVBS_CVBS | VEC_CONFIG1_CUSTOM_FREQ,=0D
 		.custom_freq =3D 0x223b61d1,=0D
=0D
-- =0D
b4 0.10.0-dev-65ba7=0D
