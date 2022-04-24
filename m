Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB05350D35E
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 18:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235006AbiDXQaP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 12:30:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234868AbiDXQaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 12:30:00 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24F1288785;
        Sun, 24 Apr 2022 09:26:56 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 58E755C006B;
        Sun, 24 Apr 2022 12:26:56 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Sun, 24 Apr 2022 12:26:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1650817616; x=1650904016; bh=Qk
        iqJQsRMBNjDm556z2E8TzPBn5kwgUgalPVUN5j18M=; b=Q/c5IPmxsggKWmRxpq
        +C+jTeClr+XKPnylCa22/GBMsnOYOtyPreGQdSBqQgVBXEeXAyXCadGdddFXzNBc
        ld1cAyWBkd7ls04A/kWdMKiz/TdraQN96zBfVl3cbNvN4pjZ1kFRTiiY9mt63A0v
        uYnrblMrEc8hdbC8nfTPy2ciTulsiRn7ygK6mJ+/7sf7Ye+e2r44bAwG1zaVemyF
        VvqLlv8PA3k4bLjMSZ7VedxAvIP7yjGeqkTzIRWe4GKKdcFxwuGjOS/imn4r3Gks
        WUW/m7tcll42Lu/3JImRgZyjy5SkHYbbExeAUGL/9+j6BT4sFpzFb31GoqwpYFCk
        z7yw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1650817616; x=1650904016; bh=QkiqJQsRMBNjDm556z2E8TzPBn5kwgUgalP
        VUN5j18M=; b=L6qCzV1y0/apGCUEP0lR+3CD/yl0nVhR+xFgGuvMyHGuUFeoBmS
        kLUFZUEYYa1NIcbshTL/dbDRgPERDNLT5npUkedKOzeofZrIj+2ws6JQVDx6xMvR
        RS/47Y83XFwiGHWBxsAhdAWQ8ktRmgzvvL1XLGWPdmblLZ1Ez0sfoblIQ+cPmBy2
        60CEdax7UzyMs+mbljFnVzqUTAoMIROqN752nBI+vIHLUiLEL85v3i4aauXuS2Cx
        RxqVNixVCL8XHLANkbcjeLZEs6VS6UmXO2o730ktS6x2LOfDDwVg99s6hK1A3iHz
        n0lA4jVVNMRRS760ZwAaNX70b79WJQaekOw==
X-ME-Sender: <xms:UHplYoRa_9JXMj6Ov_GQ0WbpjmyLxHuHf25lsInAG20JMt6ykXi4NQ>
    <xme:UHplYlw-snOdvUu8pe-29brYF4_Q0y4LLhJRm7knVLm_WetV1wuqXheXPbPT5IGYw
    obs-fA9ACeMOr_K0A>
X-ME-Received: <xmr:UHplYl2NG6NX_D6OrxVWD-hIROY7UBLXu5bTDxAre9MVDX73AktEG3bNj1ceCvQt6ELCruDZ6PY56v9SeyN796JNDD3oqZtxvnix2ubJ25_7y330X_DXMmbF5zo97dBuC_9qzw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrtdelgddutdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepudekteeuudehtdelteevgfduvddvjefhfedulefgudevgeeghefg
    udefiedtveetnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrh
    homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:UHplYsAqXHCdRsaSif6NSSjIUu__IdNk8be07hHFSG5tktprVJNFHQ>
    <xmx:UHplYhh46sppP6CbH8TiYs5SlpwLkW_H68Wzv94rajIcZbbYvYdNkg>
    <xmx:UHplYopOwRSqkNOcY2fR-Wr8Ia2RgDlOMtYHoy8LCcTzfdqwYxFr-g>
    <xmx:UHplYsoX0FyUamTvpsUCnD4yZ6oETwvOu6Ah_gNTB0MuLCfNsNxvfA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 24 Apr 2022 12:26:55 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maxime Ripard <mripard@kernel.org>
Cc:     Samuel Holland <samuel@sholland.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev
Subject: [PATCH v3 11/14] drm/sun4i: Add support for D1 mixers
Date:   Sun, 24 Apr 2022 11:26:29 -0500
Message-Id: <20220424162633.12369-12-samuel@sholland.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220424162633.12369-1-samuel@sholland.org>
References: <20220424162633.12369-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

D1 has a display engine with the usual pair of mixers, albeit with
relatively few layers. In fact, D1 appears to be the first SoC to have
a mixer without any UI layers. Add support for these new variants.

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>
Signed-off-by: Samuel Holland <samuel@sholland.org>
---

(no changes since v1)

 drivers/gpu/drm/sun4i/sun8i_mixer.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.c b/drivers/gpu/drm/sun4i/sun8i_mixer.c
index 4ce593c99807..875a1156c04e 100644
--- a/drivers/gpu/drm/sun4i/sun8i_mixer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_mixer.c
@@ -615,6 +615,24 @@ static const struct sun8i_mixer_cfg sun8i_v3s_mixer_cfg = {
 	.mod_rate = 150000000,
 };
 
+static const struct sun8i_mixer_cfg sun20i_d1_mixer0_cfg = {
+	.ccsc		= CCSC_D1_MIXER0_LAYOUT,
+	.mod_rate	= 297000000,
+	.scaler_mask	= 0x3,
+	.scanline_yuv	= 2048,
+	.ui_num		= 1,
+	.vi_num		= 1,
+};
+
+static const struct sun8i_mixer_cfg sun20i_d1_mixer1_cfg = {
+	.ccsc		= CCSC_MIXER1_LAYOUT,
+	.mod_rate	= 297000000,
+	.scaler_mask	= 0x1,
+	.scanline_yuv	= 1024,
+	.ui_num		= 0,
+	.vi_num		= 1,
+};
+
 static const struct sun8i_mixer_cfg sun50i_a64_mixer0_cfg = {
 	.ccsc		= CCSC_MIXER0_LAYOUT,
 	.mod_rate	= 297000000,
@@ -668,6 +686,14 @@ static const struct of_device_id sun8i_mixer_of_table[] = {
 		.compatible = "allwinner,sun8i-v3s-de2-mixer",
 		.data = &sun8i_v3s_mixer_cfg,
 	},
+	{
+		.compatible = "allwinner,sun20i-d1-de2-mixer-0",
+		.data = &sun20i_d1_mixer0_cfg,
+	},
+	{
+		.compatible = "allwinner,sun20i-d1-de2-mixer-1",
+		.data = &sun20i_d1_mixer1_cfg,
+	},
 	{
 		.compatible = "allwinner,sun50i-a64-de2-mixer-0",
 		.data = &sun50i_a64_mixer0_cfg,
-- 
2.35.1

