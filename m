Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9EC35862F0
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 05:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239646AbiHADFl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 23:05:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239509AbiHADFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 23:05:25 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29E852186;
        Sun, 31 Jul 2022 20:05:24 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 8ABBC32007CF;
        Sun, 31 Jul 2022 23:05:22 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Sun, 31 Jul 2022 23:05:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1659323122; x=1659409522; bh=7E
        qXmtvRWN3harpfqilHqd1KdE7zLHtd34jbY/6w4ZE=; b=eFSIgj/zUkcefTKGuO
        Y/zxVkUVTYypNyf6bjSKOr6tSKuNx24GxMXPibu9Uz09eoAqMst1fxYC/nYe36UX
        gPmiD3pzCQ92ndnwv0NwJGZtWLOptLQl+wwLd866zzKIUuPwfBabnhdX3YlXbmuq
        nagR+49Mwlznz+R/lFjqwaxoTxzJdFvAAGhdIQTzCQJGa5q2Xx4Os6bd4Zoe3n9G
        BpZRXOeZ1B20nT/+9+uJmTeTO8L2bdUV2YRlKem9PXKJySmOaNyA3Cnlw2GjecYG
        TmZICynbV61Pqb/q4FGoidEHh0OHYQkzVFPJ/Cl7n4DaJxBDGTyq88q15C9TwWtU
        p9Hg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1659323122; x=1659409522; bh=7EqXmtvRWN3ha
        rpfqilHqd1KdE7zLHtd34jbY/6w4ZE=; b=DltB057GwG0zCnuEKMZb7mkjwmRD8
        mMYLgCHkGFOqq7K1Z3N0uyKQh6GWlZpyEO6mMBie5KEvc1TvHL2UgGVYta80Qrwf
        HfhjjK5ARnxl1uVxhH2nI4nTbqLH3vFZlcGcD09VtKnyuIyh/3Po0N53v22GA3FF
        R795aV2L9YSvcnaPX0KsoP/bD4XAxygUfzfOdlRPZ6nZaTbmHYwhX9srFcnAQ9oW
        ltaewQHsm+tSwy8dH8nw3zeVv1gJhouduU/Ts0FTXTnmaxZz0I90SKIaBna1Bi1z
        EiBK0vDQlAyXXW44BUezcelcPCzxuYduU0ZQxeEGgBCxrakzLg450DefA==
X-ME-Sender: <xms:8ULnYvjuLrldCLQctICYn2YYKrQMqQ7RCet0yuT1-SSjAMn6FPx2ZA>
    <xme:8ULnYsCrRKgk96Hshgi_qJ-ZF8zhnW1oYJmZ046tvZ9xOaV0VE8rrPbaFRvcTmMxO
    DhKTpr5aVFk6fySNw>
X-ME-Received: <xmr:8ULnYvH46yPTlpY_HDQVya6e8cDDIXMcSc7THoe8_3G8Kk83lwh9OEiY8pVgePeDagInaKI6zZ0aPHU4cZ7kDE96-u3IpIbW52kMocKsILKMyPQR2T59lV8CX0dewr-eRLGJwQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvddvvddgheekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepudekteeuudehtdelteevgfduvddvjefhfedulefgudevgeeghefg
    udefiedtveetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:8ULnYsTwMA6m9bQ8Rg4WkmvdwezE1pAAovFuNhYOAdn-IEnHfaMahw>
    <xmx:8ULnYsxfGixJ8BLkowGRkLcccmw5czha30a4ZRposmOhNmX7m0gP0g>
    <xmx:8ULnYi6uQjIiXxw7jwf1tKdW_Y4ip4iGj_8hzymB3ONEj1qevD1yng>
    <xmx:8kLnYm6ouLO122iFBupxlwz5yksr3T0qZ84OOCXlg3ox7VWxVF2YJw>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 31 Jul 2022 23:05:21 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     Samuel Holland <samuel@sholland.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Hans de Goede <hdegoede@redhat.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev
Subject: [PATCH 3/9] soc: sunxi: sram: Prevent the driver from being unbound
Date:   Sun, 31 Jul 2022 22:05:03 -0500
Message-Id: <20220801030509.21966-4-samuel@sholland.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220801030509.21966-1-samuel@sholland.org>
References: <20220801030509.21966-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver exports a regmap tied to the platform device (as opposed to
a syscon, which exports a regmap tied to the OF node). Because of this,
the driver can never be unbound, as that would destroy the regmap. Use
builtin_platform_driver_probe() to enforce this limitation.

Fixes: 5828729bebbb ("soc: sunxi: export a regmap for EMAC clock reg on A64")
Signed-off-by: Samuel Holland <samuel@sholland.org>
---

 drivers/soc/sunxi/sunxi_sram.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/soc/sunxi/sunxi_sram.c b/drivers/soc/sunxi/sunxi_sram.c
index f3d3f9259df9..a858a37fcdd4 100644
--- a/drivers/soc/sunxi/sunxi_sram.c
+++ b/drivers/soc/sunxi/sunxi_sram.c
@@ -330,7 +330,7 @@ static struct regmap_config sunxi_sram_emac_clock_regmap = {
 	.writeable_reg	= sunxi_sram_regmap_accessible_reg,
 };
 
-static int sunxi_sram_probe(struct platform_device *pdev)
+static int __init sunxi_sram_probe(struct platform_device *pdev)
 {
 	struct dentry *d;
 	struct regmap *emac_clock;
@@ -410,9 +410,8 @@ static struct platform_driver sunxi_sram_driver = {
 		.name		= "sunxi-sram",
 		.of_match_table	= sunxi_sram_dt_match,
 	},
-	.probe	= sunxi_sram_probe,
 };
-module_platform_driver(sunxi_sram_driver);
+builtin_platform_driver_probe(sunxi_sram_driver, sunxi_sram_probe);
 
 MODULE_AUTHOR("Maxime Ripard <maxime.ripard@free-electrons.com>");
 MODULE_DESCRIPTION("Allwinner sunXi SRAM Controller Driver");
-- 
2.35.1

