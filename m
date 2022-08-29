Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A660E5A4E09
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 15:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbiH2N1l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 09:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbiH2N1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 09:27:05 -0400
Received: from wnew2-smtp.messagingengine.com (wnew2-smtp.messagingengine.com [64.147.123.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19BAA832E2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 06:25:48 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailnew.west.internal (Postfix) with ESMTP id 7E50E2B06083;
        Mon, 29 Aug 2022 09:15:47 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 29 Aug 2022 09:15:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1661778947; x=
        1661786147; bh=xPKClgXEhgbZIku/wD+WYQoXLvH5DXbkNRiUTcpaiXA=; b=D
        iq1Lken6FPUNY6rixKynLAYM0aUp0Y8hCQW8/cHoIUuRCQ3MIotHbVe3Oj1Wld9D
        q8rziTtUo6iwNwmgBwzXqq8hlsXqBdtfEso3aBerfVESdHyeQPog9SiNC948Ba/n
        Wni8XNvw5d5ayPhbMvLsKHl6a0Iog8XuQsL7V55NuD+KoGyPTGWEQzWhYx9OE+NI
        LMBjNxT45iB/T/VXCqETMvc0UZ8ingxcjJBfArIhWLg2zhVQ92r69H7FbYi6Ju/E
        n/2vAMOQRnMOdXHevDd5ycfIUhYEC0dkymlW+QZO5B61Jl6x9ONqD1IZ03uCVOYK
        Hrx4UTd7Ur7hCKtXj0iTQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1661778947; x=
        1661786147; bh=xPKClgXEhgbZIku/wD+WYQoXLvH5DXbkNRiUTcpaiXA=; b=Q
        6Ot/UO86TeWLcTnOqWGbhFftfW5ZYp54/HxY3lKQHK1wJ9ZN8Z1exXYYSbqUm+PI
        q/qjgyiU8y2EfM2n325LeqEMSsx/zJBL8HeecwCxLZAN1g5xwhCw+edHReuhiazL
        3sTfnL45HjCYBV1csTzW8thlZ1abueJGlc4SBIerk5SZR0mQ0s9oeRTxjGueuslr
        L9JVUVmuzuhLWx1waPF/tiN/ZE1aaTKyJe6Oi85QjETFz4WyXKJ29bK96oCyKT8q
        DWr0iNmd2My7ue6ymNQkakb/YdcjGIMNLCd7kW1624dlXG7lATvZBHj53+iK6WjA
        9cL5DAzdJMUXyEM1a+ngw==
X-ME-Sender: <xms:ArwMY-AOGWy_xe3mcsVdGEbPbOgLxS-QST-A-Y1rOc4oJ_DxWHOxAQ>
    <xme:ArwMY4ixfsgF-90wCRMinT5zDMFWSFgFEYsqR-GSHofiCXBIIcxhDdyNwPkZXTC85
    TEg37iycaKIV5jRUTg>
X-ME-Received: <xmr:ArwMYxkfMsLQHkkGI5PD3H2vqLxlAxdmqLQTZWkHBLLBqoBoewrfqvymdJ3L>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdekuddgieegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhggtgfogfesthhqredtredtjeenucfhrhhomhepofgr
    gihimhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtf
    frrghtthgvrhhnpeefiedvfefggffgffehveejieffuddtgffhjefggeetieduvdeileet
    lefgveegtdenucevlhhushhtvghrufhiiigvpeeinecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:ArwMY8wfN1WATSydQph6wejGOhCazk6AaDCuKXmfCxqUbe8AahNqOg>
    <xmx:ArwMYzSWXUOqKylzKtDsW2MZhq0Lrl-Da4Lzld55JglA5Ql7220_1g>
    <xmx:ArwMY3ZIotTAU_sGaVWkK_Tf16dzYnq1nM2uIkAXt7ITYosb5ISfjw>
    <xmx:A7wMY3K8d4gN3iSSesO6KEYa-x9QyZO4pAp_AQKivOx6SSjuHmSxO8X8x5s>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Aug 2022 09:15:46 -0400 (EDT)
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
Subject: [PATCH v2 34/41] drm/sun4i: tv: Remove unused mode_valid
Date:   Mon, 29 Aug 2022 15:11:48 +0200
Message-Id: <20220728-rpi-analog-tv-properties-v2-34-459522d653a7@cerno.tech>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220728-rpi-analog-tv-properties-v2-0-459522d653a7@cerno.tech>
References: <20220728-rpi-analog-tv-properties-v2-0-459522d653a7@cerno.tech>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.10.0-dev-65ba7
X-Developer-Signature: v=1; a=openpgp-sha256; l=873; i=maxime@cerno.tech; h=from:subject:message-id; bh=WJLJuDlfN2CfTt2hGqbzVPVAYa+Qd5gtSkAkaL2kavM=; b=owGbwMvMwCX2+D1vfrpE4FHG02pJDMk8uxTzLnKv3fU95cidZ/cME2bzmpemL61aKH77+n3X0G2u nwLOdpSyMIhxMciKKbLECJsviTs163UnG988mDmsTCBDGLg4BWAieocZGa74rSi88fc6b71wiKChU4 Hag72tny67LGHlMnsacnnXinSG/3ln25P3CD2Rae+ytG+e5/bso+vSBMtZvu61rz/Ixv/W5QAA
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

The mode_valid implementation is pretty much a nop, let's remove it.=0D
=0D
Signed-off-by: Maxime Ripard <maxime@cerno.tech>=0D
Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>=0D
=0D
diff --git a/drivers/gpu/drm/sun4i/sun4i_tv.c b/drivers/gpu/drm/sun4i/sun4i=
_tv.c=0D
index 94883abe0dfd..53152d77c392 100644=0D
--- a/drivers/gpu/drm/sun4i/sun4i_tv.c=0D
+++ b/drivers/gpu/drm/sun4i/sun4i_tv.c=0D
@@ -497,16 +497,8 @@ static int sun4i_tv_comp_get_modes(struct drm_connecto=
r *connector)=0D
 	return i;=0D
 }=0D
 =0D
-static int sun4i_tv_comp_mode_valid(struct drm_connector *connector,=0D
-				    struct drm_display_mode *mode)=0D
-{=0D
-	/* TODO */=0D
-	return MODE_OK;=0D
-}=0D
-=0D
 static const struct drm_connector_helper_funcs sun4i_tv_comp_connector_hel=
per_funcs =3D {=0D
 	.get_modes	=3D sun4i_tv_comp_get_modes,=0D
-	.mode_valid	=3D sun4i_tv_comp_mode_valid,=0D
 };=0D
 =0D
 static void=0D
=0D
-- =0D
b4 0.10.0-dev-65ba7=0D
