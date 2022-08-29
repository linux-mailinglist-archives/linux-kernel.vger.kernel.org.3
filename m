Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 288035A4DAE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 15:19:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbiH2NT0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 09:19:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230482AbiH2NSn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 09:18:43 -0400
Received: from wnew2-smtp.messagingengine.com (wnew2-smtp.messagingengine.com [64.147.123.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 447BE7960D
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 06:17:17 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailnew.west.internal (Postfix) with ESMTP id 7C3232B0608B;
        Mon, 29 Aug 2022 09:16:19 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 29 Aug 2022 09:16:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1661778979; x=
        1661786179; bh=2pxPB8e3CUm+60/d+Ajs5F0Dd4Kd+gAOE9TGfZOvPi0=; b=s
        IFzr/KwlpJ8OIhfGNGLHBQZSFbYXA/GT17RVJbxwYyhlHyMA12oQDgfug6L0m9aD
        X0IDX/9OOlU5kSeAcMawyeLAQKO0XIgBCsm1ZFdVniAQWCHANKzHtpBNo3cAZww0
        5MicvOD/rEkF3wNV/UB9O7nKs1xzJY9wLXTV/GogF93gLyWvVWJi4ngfOWMSnWh5
        CwygGs605KWyBc1wCllQfe3TbNN6uVtsY9HtvpnE3O5Y/Zoag1prGyRPCSVL3nWo
        0Gabzdw9tf46rgj4C8mlK+bWWDnD7Q6ujmZDRNy1TSiqfDM1t95jNN/epM1ns6UZ
        Ph43mk9o9BiUEA0LYSdaw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1661778979; x=
        1661786179; bh=2pxPB8e3CUm+60/d+Ajs5F0Dd4Kd+gAOE9TGfZOvPi0=; b=K
        amRuNAMz7RG67NNqG11/jS2FJetLjnF/YCqhACRhauGq6fVhcyl24R02JFViBwod
        kN9W9BEWH6Qnz/aarJGl7Btr7qRERvCqBl8TbrtR4A8V5KBA3t0837rb60apLAw9
        xd7KmfwJlAIc76trDkH6gtlXNNURuAyRxS2nGYkKq8KXkIKHXNAyHKlfdtXQ+y6K
        HdJxeD4NiKCPAa6F9109Yq58K2kJCaWeFzj4dpW0sCMB9T281wJzF4SXFOh+wCG8
        jJmAZsevO8Fyfym2peyHMM6WQdbYnl4/4zdiM1Pm4AItNfYQXOCRF+UGirJUNFkP
        +BKov0Dj/yu9diciK0emQ==
X-ME-Sender: <xms:IrwMY6HKXmvjcrY5OUBLX29cLbQRNmqBvvc4dJt-ijjE3u7qqOZzpw>
    <xme:IrwMY7UIy5M6u2zppGrV1v1INpY7hHSWYxRrJ2pXn8-pEmjQeiTC0LSBU5KsWJ7Dp
    rQSBkomKIbxepqfW1Q>
X-ME-Received: <xmr:IrwMY0KrgUvJl6XDQktT5t25aTSJoP54fuSaRJv8HoOdknF2idNzwUoutWg_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdekuddgieegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhggtgfogfesthhqredtredtjeenucfhrhhomhepofgr
    gihimhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtf
    frrghtthgvrhhnpeefiedvfefggffgffehveejieffuddtgffhjefggeetieduvdeileet
    lefgveegtdenucevlhhushhtvghrufhiiigvpeelnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:IrwMY0GjzgcwM3BsMZ3jxQq-KmMz2K0Nqr9J9l5R-g0RmyXBXmW4iw>
    <xmx:IrwMYwWt1xN9sEbEUp3EbfmQBszTubS0qin7I7vvO_RPdmiq0ZTY7g>
    <xmx:IrwMY3PFyY_-BojPHYtG0V0KAsWDX6NIRt7zs8Y_ej0GKRowTr6nKQ>
    <xmx:I7wMY7co049-iAcdjZG-cJJFkWtE5pmmq790n3kevJM2HHXZuXHzz71yOeA>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Aug 2022 09:16:17 -0400 (EDT)
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
Subject: [PATCH v2 39/41] drm/sun4i: tv: Rename error label
Date:   Mon, 29 Aug 2022 15:11:53 +0200
Message-Id: <20220728-rpi-analog-tv-properties-v2-39-459522d653a7@cerno.tech>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220728-rpi-analog-tv-properties-v2-0-459522d653a7@cerno.tech>
References: <20220728-rpi-analog-tv-properties-v2-0-459522d653a7@cerno.tech>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.10.0-dev-65ba7
X-Developer-Signature: v=1; a=openpgp-sha256; l=1217; i=maxime@cerno.tech; h=from:subject:message-id; bh=992aKe2/qrCZVBZV8U/tKPDwh4IEN+c9wkBDNYDBbNw=; b=owGbwMvMwCX2+D1vfrpE4FHG02pJDMk8uxTL71furRMuLyvh3dMXLdC772S+DmPCi8cBU29O2WvA qFffUcrCIMbFICumyBIjbL4k7tSs151sfPNg5rAygQxh4OIUgIlsX8Hw36lcJjPlBVej+dHv2ofUdy 3jua8+67uphfXJTysbF+QuUmf4nzo9Nr7FyGiSnJlYzZNy83ZFqXeOm77bTWD/fCHy9fQybgA=
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

The other error labels in sun4i_tv_bind() are named after the task they=0D
perform (err_disable_clk to call clk_disable_unprepare for example).=0D
=0D
However, the err_cleanup_connector is named after the calling site=0D
(drm_connector_init failing) and will actually cleanup the encoder. Let's=0D
rename it to err_cleanup_encoder to be consistent.=0D
=0D
Signed-off-by: Maxime Ripard <maxime@cerno.tech>=0D
Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>=0D
=0D
diff --git a/drivers/gpu/drm/sun4i/sun4i_tv.c b/drivers/gpu/drm/sun4i/sun4i=
_tv.c=0D
index 6d7e1d51569a..ad6a3739bfa9 100644=0D
--- a/drivers/gpu/drm/sun4i/sun4i_tv.c=0D
+++ b/drivers/gpu/drm/sun4i/sun4i_tv.c=0D
@@ -580,7 +580,7 @@ static int sun4i_tv_bind(struct device *dev, struct dev=
ice *master,=0D
 	if (ret) {=0D
 		dev_err(dev,=0D
 			"Couldn't initialise the Composite connector\n");=0D
-		goto err_cleanup_connector;=0D
+		goto err_cleanup_encoder;=0D
 	}=0D
 	tv->connector.interlace_allowed =3D true;=0D
 =0D
@@ -588,7 +588,7 @@ static int sun4i_tv_bind(struct device *dev, struct dev=
ice *master,=0D
 =0D
 	return 0;=0D
 =0D
-err_cleanup_connector:=0D
+err_cleanup_encoder:=0D
 	drm_encoder_cleanup(&tv->encoder);=0D
 err_disable_clk:=0D
 	clk_disable_unprepare(tv->clk);=0D
=0D
-- =0D
b4 0.10.0-dev-65ba7=0D
