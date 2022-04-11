Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 742F84FB2EE
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 06:36:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244731AbiDKEhb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 00:37:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244621AbiDKEhF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 00:37:05 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CBDDDFB5;
        Sun, 10 Apr 2022 21:34:50 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id DEAF13201F43;
        Mon, 11 Apr 2022 00:34:48 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 11 Apr 2022 00:34:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1649651688; x=1649738088; bh=N4
        owQ9/Cd3nixi2R9mF9dun/uhDiVSwowfRJ5Lt96QU=; b=wYGxErcydPByZPckw1
        FGP092owOmC8xV7Lj+e2uCLfXDitkHg1SrOMc6FBAGfvwpB1nPaggjKO3Hm1GoqC
        Oim9JbETWrQETP+nZaGD/Et9mBTb2H9o6eckU58aF5YrLZ9d7VYS+ns89H8vYcDC
        VTZQMNzU35JFCSGasNv19qimSoXNH7laIegMZqsgTEQuohuh0SuAYfjSoxkJPPpM
        9uCWmt7KTpPQeggSv9sPojfAg6yuIJXu4tl3Ck/i+kmmrA3o06M3u8LrKrsCagPH
        IJx0/Wg/ZOfcxLH0vLFAbBbeWmCOrVch+pPEY0o9j3QC5nur+EzkdmlTjAiXRIVx
        ldqw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1649651688; x=1649738088; bh=N4owQ9/Cd3nixi2R9mF9dun/uhDiVSwowfR
        J5Lt96QU=; b=XaHpD8jZEslw3zz6Z+6Mnjw8n/TBt6U5gP370/WKVPYYJXGZp9C
        cyNJQjYnjLDyuxCQImaL4V1h4GAqpN0cceqjALV+DnGkUffNkqjefqOsfGu/P0WN
        II7vln8mfQqA/BCwjbdaMX0zNEBgK9Y/rCEni5dhNBBtRDFVA37Ru6heeLh3m1th
        Vq4sMTMt5qcAAVfCN9UuOo1nW9j/udenuRy7nKnq5APROG6CsT/MVna/8cEBcyny
        EinDdYoLuB6jBQp/AUP5pzuOnOl19xuHcpJAtSR0sSjWzA9mT49JLltaVc+kuC6U
        JgLqz2vj7jv8kmqvpY56PszijaJ2TGI1B7w==
X-ME-Sender: <xms:6K9TYqTk3WjS9aSTninm4CGzkFH6rz9F_4bmNwgulWs1-Al9Gde1MQ>
    <xme:6K9TYvzNC0nA_JKd4LnPPaNPYKKicfHhuZQdo8z6h85-DlKgcXvIFpJuAxLdiCI_L
    Kr-MHGtw3sEclNxdw>
X-ME-Received: <xmr:6K9TYn10xxhZXXHrRxPKiXZR1lm34dwOek2qIydVOmPrJun9aGNn4adgh50vsigmwDztNSoPM5KzLa8Lkw-T5idl_3QqyjzMIS6_tV7eHMuj4QPkAIng3iKYhu-nVLfzIqYF6A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudekhedgjeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpeduhfejfedvhffgfeehtefghfeiiefgfeehgfdvvdevfeegjeehjedv
    gfejheeuieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:6K9TYmBTtM0RSC-UeXdlnxiYQouvctD7MHU8YaaEnzJgk9Ip7QRZ6Q>
    <xmx:6K9TYjiEc_Ht3i06sJMMEpRfPED4mIjPwpKtiJYYlhMvGRqTYJ7j9w>
    <xmx:6K9TYio4gIsLVRxwrJN5tPP3flw0HTgGUHy1sX2fqFmYRkLXMWpCpg>
    <xmx:6K9TYmqpnN1UnVSEXNJEZRQ5UpbVgQxG1vJPuU7bIaJKTUNLdj0Nqw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Apr 2022 00:34:47 -0400 (EDT)
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
Subject: [PATCH 07/10] drm/sun4i: Add support for D1 mixers
Date:   Sun, 10 Apr 2022 23:34:19 -0500
Message-Id: <20220411043423.37333-8-samuel@sholland.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220411043423.37333-1-samuel@sholland.org>
References: <20220411043423.37333-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

D1 has a display engine with the usual pair of mixers, albeit with
relatively few layers. In fact, D1 appears to be the first SoC to have
a mixer without any UI layers. Add support for these new variants.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

 drivers/gpu/drm/sun4i/sun8i_mixer.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.c b/drivers/gpu/drm/sun4i/sun8i_mixer.c
index f5e8aeaa3cdf..49c0d17c6f0a 100644
--- a/drivers/gpu/drm/sun4i/sun8i_mixer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_mixer.c
@@ -585,6 +585,24 @@ static const struct sun8i_mixer_cfg sun8i_v3s_mixer_cfg = {
 	.mod_rate = 150000000,
 };
 
+static const struct sun8i_mixer_cfg sun20i_d1_mixer0_cfg = {
+	.ccsc		= 2,
+	.mod_rate	= 297000000,
+	.scaler_mask	= 0x3,
+	.scanline_yuv	= 2048,
+	.ui_num		= 1,
+	.vi_num		= 1,
+};
+
+static const struct sun8i_mixer_cfg sun20i_d1_mixer1_cfg = {
+	.ccsc		= 1,
+	.mod_rate	= 297000000,
+	.scaler_mask	= 0x1,
+	.scanline_yuv	= 1024,
+	.ui_num		= 0,
+	.vi_num		= 1,
+};
+
 static const struct sun8i_mixer_cfg sun50i_a64_mixer0_cfg = {
 	.ccsc		= 0,
 	.mod_rate	= 297000000,
@@ -638,6 +656,14 @@ static const struct of_device_id sun8i_mixer_of_table[] = {
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

