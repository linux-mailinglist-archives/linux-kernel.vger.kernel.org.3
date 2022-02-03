Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE08B4A7DDA
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 03:18:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349028AbiBCCSK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 21:18:10 -0500
Received: from wnew4-smtp.messagingengine.com ([64.147.123.18]:43337 "EHLO
        wnew4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1349021AbiBCCSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 21:18:03 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailnew.west.internal (Postfix) with ESMTP id 8BFB72B001C0;
        Wed,  2 Feb 2022 21:18:01 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 02 Feb 2022 21:18:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; bh=maCEeMW114688LGhZUXh1aNyGAyiVI
        HXt4rdxe/VoDw=; b=F+f5FK5qTyyMNgna3BSpVupfP0HYFclzdKXQKrMVVA+a4P
        j6+Vg/yo/jrfjO+uaIOrzkaGOx3vTCpe3Kk/BlY1oK/hQr6coWQc5jijJAS//vQ7
        BnsBfCeSUeY6Le8JvQX7oh4hn2AbjqKO6x9nDInlVmxXYygCQHVglsQ9H/7whKDl
        v3D0zfgAp4KH4UC5IjqAkjrWngLFe4lz/k6bPRyhdkOm09wB3F/1IGVpEGMwXiOV
        Cn8kSXMVetdrrKA5Y4XyKuBrJSoV8mjTZnOkSQzycZ9/pb7IpeFt+nJyZGY4nWE7
        QgQ527H6S46yNgE+9aQtb0GlUDpGfWyYOu8ZZ8JA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=maCEeM
        W114688LGhZUXh1aNyGAyiVIHXt4rdxe/VoDw=; b=YVZe1VLXX/Fug6Q6vVzQdl
        2R13W8v2rmw24HtGJjF9i0R7rNXlkjU+4MpRaD05ffvyyyrIAQ7lhiqioGZ+xFk1
        B3KgN8j0p+Ho6Yijv2OEUbP4uDZQmB0XV86o4mN7hhrkdlcWSGlvWjtz5wCtxWDu
        9xXaQDZkTXjVBXUh99UlE0VGeRiPzVyA1oWsDFFcb/HKm3cTwnHkjpy534nnYpTT
        Kj0ehBpfGnWMLNJmkK5eTcyNDKwHd8Xi5fgbTCUJADNM48FfrT0eag0rerYZdLbT
        xMeO0z5wTKffC1JBcXT/idK8QFl60sWC56zOnV4DIDVxKc1mwosGvXbeO4rWk9Yw
        ==
X-ME-Sender: <xms:WDv7YYKL2jNz8tJ2C_1X-hpsf2Y7kEYwzuT3MtX5TneCnmGrc4xyDQ>
    <xme:WDv7YYJOMg0YzG1e_zXzW60gl1Xt3XklaAWVg7aDqpZVAk3qcaPeFkZuvHO7W1Zrl
    YfnMETI0UY8A3DHkQ>
X-ME-Received: <xmr:WDv7YYuRLOTEAv-8HCQ-0qrP0FMfhNHdubhkojehTEX-K9_x-j8k28DREsFq5dh2J-sFiIOOmHnayS1VjB6s8CEVoUgbwWiQOz0JjOPDcT8Oj3QgS-7KFWPbYPxnTuIU1zNzhw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrgeeigdeggecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecuggftrf
    grthhtvghrnhepudfhjeefvdfhgfefheetgffhieeigfefhefgvddvveefgeejheejvdfg
    jeehueeinecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomh
    epshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:WTv7YVZGxCxTxui2FqdkoinOZUFanasEzrdy-eKTu1nXMdOsr6ISPQ>
    <xmx:WTv7Yfb6Tg5a-pyKqGiDdUdS25Mw7I_yo2PWhQd1bDVh9o5uGQKqFw>
    <xmx:WTv7YRB7yDxskKrWEkHIdWuGnC-jiz_fqBpkfl_fdiTS7oQE34SOng>
    <xmx:WTv7YbquHLHHS8c6QCMF8feKGk63iSBQM8Q37KsDElQRENH0vBrzS0uQDJU>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Feb 2022 21:18:00 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-sunxi@lists.linux.dev
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Michael Turquette <mturquette@baylibre.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH v3 6/6] [DO NOT MERGE] clk: sunxi-ng: sun6i-rtc: Add support for H6
Date:   Wed,  2 Feb 2022 20:17:36 -0600
Message-Id: <20220203021736.13434-7-samuel@sholland.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220203021736.13434-1-samuel@sholland.org>
References: <20220203021736.13434-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

H6 supports IOSC calibration and an ext-osc32k input. Unlike newer SoCs,
it has a single parent for its fanout clock.

Add support for H6 in the CCU driver, replacing the support in the
existing early OF clock provider.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

Changes in v3:
 - Rebase example on top of driver changes, and drop the second example.

 drivers/clk/sunxi-ng/ccu-sun6i-rtc.c | 15 +++++++++++++++
 drivers/rtc/rtc-sun6i.c              | 17 -----------------
 2 files changed, 15 insertions(+), 17 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun6i-rtc.c b/drivers/clk/sunxi-ng/ccu-sun6i-rtc.c
index a39670a7c446..712fda22efd5 100644
--- a/drivers/clk/sunxi-ng/ccu-sun6i-rtc.c
+++ b/drivers/clk/sunxi-ng/ccu-sun6i-rtc.c
@@ -295,6 +295,10 @@ static const struct sunxi_ccu_desc sun6i_rtc_ccu_desc = {
 	.hw_clks	= &sun6i_rtc_ccu_hw_clks,
 };
 
+static const struct clk_parent_data sun50i_h6_osc32k_fanout_parents[] = {
+	{ .hw = &osc32k_clk.common.hw },
+};
+
 static const struct clk_parent_data sun50i_h616_osc32k_fanout_parents[] = {
 	{ .hw = &osc32k_clk.common.hw },
 	{ .fw_name = "pll-32k" },
@@ -307,6 +311,13 @@ static const struct clk_parent_data sun50i_r329_osc32k_fanout_parents[] = {
 	{ .hw = &osc24M_32k_clk.common.hw }
 };
 
+static const struct sun6i_rtc_match_data sun50i_h6_rtc_ccu_data = {
+	.have_ext_osc32k	= true,
+	.have_iosc_calibration	= true,
+	.osc32k_fanout_parents	= sun50i_h6_osc32k_fanout_parents,
+	.osc32k_fanout_nparents	= ARRAY_SIZE(sun50i_h6_osc32k_fanout_parents),
+};
+
 static const struct sun6i_rtc_match_data sun50i_h616_rtc_ccu_data = {
 	.have_iosc_calibration	= true,
 	.rtc_32k_single_parent	= true,
@@ -321,6 +332,10 @@ static const struct sun6i_rtc_match_data sun50i_r329_rtc_ccu_data = {
 };
 
 static const struct of_device_id sun6i_rtc_ccu_match[] = {
+	{
+		.compatible	= "allwinner,sun50i-h6-rtc",
+		.data		= &sun50i_h6_rtc_ccu_data,
+	},
 	{
 		.compatible	= "allwinner,sun50i-h616-rtc",
 		.data		= &sun50i_h616_rtc_ccu_data,
diff --git a/drivers/rtc/rtc-sun6i.c b/drivers/rtc/rtc-sun6i.c
index 35b34d14a1db..1a875a32357d 100644
--- a/drivers/rtc/rtc-sun6i.c
+++ b/drivers/rtc/rtc-sun6i.c
@@ -364,23 +364,6 @@ CLK_OF_DECLARE_DRIVER(sun8i_h3_rtc_clk, "allwinner,sun8i-h3-rtc",
 CLK_OF_DECLARE_DRIVER(sun50i_h5_rtc_clk, "allwinner,sun50i-h5-rtc",
 		      sun8i_h3_rtc_clk_init);
 
-static const struct sun6i_rtc_clk_data sun50i_h6_rtc_data = {
-	.rc_osc_rate = 16000000,
-	.fixed_prescaler = 32,
-	.has_prescaler = 1,
-	.has_out_clk = 1,
-	.export_iosc = 1,
-	.has_losc_en = 1,
-	.has_auto_swt = 1,
-};
-
-static void __init sun50i_h6_rtc_clk_init(struct device_node *node)
-{
-	sun6i_rtc_clk_init(node, &sun50i_h6_rtc_data);
-}
-CLK_OF_DECLARE_DRIVER(sun50i_h6_rtc_clk, "allwinner,sun50i-h6-rtc",
-		      sun50i_h6_rtc_clk_init);
-
 /*
  * The R40 user manual is self-conflicting on whether the prescaler is
  * fixed or configurable. The clock diagram shows it as fixed, but there
-- 
2.33.1

