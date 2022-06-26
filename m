Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 132AC55AE31
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 04:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233541AbiFZCMH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 22:12:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233811AbiFZCMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 22:12:03 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82B5713F37;
        Sat, 25 Jun 2022 19:11:59 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 7BAF23200909;
        Sat, 25 Jun 2022 22:11:57 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Sat, 25 Jun 2022 22:11:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1656209517; x=1656295917; bh=Rs
        /fITujWP8gCqOdfm6a/ydgF+XVF/nxsSLYWExuY7o=; b=UfmcXm7D9oHNO1+UJz
        IuvACek7SvmSSz8hsd7DhEaF8kzI0pw4hGkeWxBa3yA7ph1CXylEzqF0eLluaYbT
        owXLjUbzNCSpsUdRtIPXOyYiHEp30M9Ez7RvyR+8cBMywl9lmDLbx1rrvvLbSRfl
        76ox0+xwC5U/9sacT3wF9KineHOZMXASA381zUxFZ6tECSX1W1PRybbBwtFWNntz
        nV5q/jR17oioMcLiuXIJIxqVR6RUmWVzDZdAN24/zQBPBqtKZRrR/0QR3eAdbi1V
        u14DfXSToULLA3c3KhWJ/TqtylUXsbJ57YQIFWTj1SB0+phplfATlEhJ8Fkx1WE1
        zyzA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1656209517; x=1656295917; bh=Rs/fITujWP8gC
        qOdfm6a/ydgF+XVF/nxsSLYWExuY7o=; b=MDhp15BJGPEv/pc6UiqDVy4bb5qaN
        +bMaZf11iZU4s+l1lvLmjc9NYmJB8tIPBGbD+gnaixP9jnOGbVN+JGQr8geIzSlV
        agwP1zh99skzHm0rKB5KL0OYWmqZrKIfr1kR2WJsqBSvvs8jomBP4lQiVSnFWyws
        a9oLovnQHBI6vLjrRHslGxKAh+Tx6DwjmQ5B0y/SeDo0H/7Qj1mbIZKDv3r0GNz2
        v20TGVSAnnpnjrkKW9UgoB5c9KFK1RhKXS5HjsD1YzT4zSn/Kc2sXVknWa052n3d
        AQIbPHce6PQQjfLSuS0isb9BXKPsv0q76Ac3KINNX8/yn56cA98frE1lQ==
X-ME-Sender: <xms:bMC3YjHj6FNKH6S-RnrASQLEo7WCOcEq2pDkxPHcRyQ02TK3uzAZ2Q>
    <xme:bMC3YgXeaC2JmRVSARbi9Q3Mj4ALokIuRvMYd5tLyKZsXj-nTxCAUlf2GyQ5lzi60
    kkgq6SCKpoBfSm2Qw>
X-ME-Received: <xmr:bMC3YlJeG4f26H1s_IGnCQCQ3_qtaV8VAjfL8JYni1B6WRBNbVaUv7moKqWCcLN9GuGf9QPvjaNWMLt19sby4-ltOcwcuyOvddZ5Dzuynp96g4Ur76vyVoQEd_iVHuUtKxxKFg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudegvddgheeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepudekteeuudehtdelteevgfduvddvjefhfedulefgudevgeeghefg
    udefiedtveetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:bMC3YhFB4HF2ZMd2Hh0saG6JhmoCUT3IDljYJ7CMGkh3vH6oV6lohg>
    <xmx:bMC3YpW-4Owt-IKwbQJYXZKD8Bvz9PQCGdVwBslPyPRzBYpMft-O9A>
    <xmx:bMC3YsOfLS_gAPp9WqKBHElm2HYLyhhba62jJhxzb-5GNMeiznnwWw>
    <xmx:bcC3YkMpxxi4YyXtGwC3AbMPwyA_j22qsilHFFPYlngiqQX8EvhKaw>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 25 Jun 2022 22:11:56 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Samuel Holland <samuel@sholland.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Ripard <mripard@kernel.org>, Ondrej Jirman <x@xff.cz>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev
Subject: [PATCH 2/6] pinctrl: sunxi: Add I/O bias setting for H6 R-PIO
Date:   Sat, 25 Jun 2022 21:11:43 -0500
Message-Id: <20220626021148.56740-3-samuel@sholland.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220626021148.56740-1-samuel@sholland.org>
References: <20220626021148.56740-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

H6 requires I/O bias configuration on both of its PIO devices.
Previously it was only done for the main PIO.

The setting for Port L is at bit 0, so the bank calculation needs to
account for the pin base. Otherwise the wrong bit is used.

Fixes: cc62383fcebe ("pinctrl: sunxi: Support I/O bias voltage setting on H6")
Signed-off-by: Samuel Holland <samuel@sholland.org>
---

 drivers/pinctrl/sunxi/pinctrl-sun50i-h6-r.c | 1 +
 drivers/pinctrl/sunxi/pinctrl-sunxi.c       | 7 ++++---
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/sunxi/pinctrl-sun50i-h6-r.c b/drivers/pinctrl/sunxi/pinctrl-sun50i-h6-r.c
index c7d90c44e87a..7b4b9f3d4555 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sun50i-h6-r.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sun50i-h6-r.c
@@ -107,6 +107,7 @@ static const struct sunxi_pinctrl_desc sun50i_h6_r_pinctrl_data = {
 	.npins = ARRAY_SIZE(sun50i_h6_r_pins),
 	.pin_base = PL_BASE,
 	.irq_banks = 2,
+	.io_bias_cfg_variant = BIAS_VOLTAGE_PIO_POW_MODE_SEL,
 };
 
 static int sun50i_h6_r_pinctrl_probe(struct platform_device *pdev)
diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.c b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
index d9327d7d56ee..3c5e71359ca8 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sunxi.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
@@ -622,7 +622,7 @@ static int sunxi_pinctrl_set_io_bias_cfg(struct sunxi_pinctrl *pctl,
 					 unsigned pin,
 					 struct regulator *supply)
 {
-	unsigned short bank = pin / PINS_PER_BANK;
+	unsigned short bank;
 	unsigned long flags;
 	u32 val, reg;
 	int uV;
@@ -638,6 +638,9 @@ static int sunxi_pinctrl_set_io_bias_cfg(struct sunxi_pinctrl *pctl,
 	if (uV == 0)
 		return 0;
 
+	pin -= pctl->desc->pin_base;
+	bank = pin / PINS_PER_BANK;
+
 	switch (pctl->desc->io_bias_cfg_variant) {
 	case BIAS_VOLTAGE_GRP_CONFIG:
 		/*
@@ -655,8 +658,6 @@ static int sunxi_pinctrl_set_io_bias_cfg(struct sunxi_pinctrl *pctl,
 		else
 			val = 0xD; /* 3.3V */
 
-		pin -= pctl->desc->pin_base;
-
 		reg = readl(pctl->membase + sunxi_grp_config_reg(pin));
 		reg &= ~IO_BIAS_MASK;
 		writel(reg | val, pctl->membase + sunxi_grp_config_reg(pin));
-- 
2.35.1

