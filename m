Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21DB75862F9
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 05:06:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239635AbiHADGZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 23:06:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239642AbiHADFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 23:05:41 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29C9EDF5B;
        Sun, 31 Jul 2022 20:05:35 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 538CE320070D;
        Sun, 31 Jul 2022 23:05:34 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Sun, 31 Jul 2022 23:05:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1659323133; x=1659409533; bh=8B
        kUceWzOwh96rJjN19akdhtFgBFl98NUCkHeE2NzwA=; b=BC5vMiF1BXBxRjpBRE
        al8JabKsundk9Jx0brzO+RNg4d4XRFLuublrj4Odei2o0DCPbD6nFaJ6fAeKXHiw
        4TEWhdAOHRO9HxdRrawzc3dVNq7IpHingTBu2BJVXGlTrrkolFefR8glNN3wGqEb
        r9L2NQ5rxZfm0sIEcb55aC+1pt27uGKYyZ5py5uurvA/gyqCzUl+XmQzb4r4rWQ8
        Wj/ih/W/8jSbydpOUtJpTlyaOQzvrkDeOY/YZ5U8GnWOYx6tsJVPtTN98Y0ZfJhP
        qwTeRAX0RBNYfITLldGddU/3SkOmC0QvcQL0x+Ms+Lxn+B4SsTOh+B8UnPXaiLGs
        yhlg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1659323133; x=1659409533; bh=8BkUceWzOwh96
        rJjN19akdhtFgBFl98NUCkHeE2NzwA=; b=ZkOGuuOnBgcaP45QAzwKTxvAAwT6d
        awM2H8aXLyevOv2vOpBiIU/hmopqlAkHATp1eJTGeUNYusEJqjn0i6bZsAMLg7ds
        g8tAq5fQh3hAqNWVk7b9+zIOGwfL34lKueHAoNkoeZS0pAPK7m5sZwCrd4O1zAik
        12/Y+EqFjH7xOMPqCSeZMnrkG+UbgKURTouDehr7YH2objt3F0XPW6qVknP36xvi
        80nsJYqQ3Ta7pSSWYQy1llmGOdtaGuN/7D9100vO1sVagbxRHIIwiD5hSXs2rSUJ
        SphUz/D8NzjstOhRW6rCe4qN3m2x30taS6KnoSnMj1/o0DL2+m/U0wMPg==
X-ME-Sender: <xms:_ULnYhQUMLcY-x_33DAGSiw8T-vdUnoOCrbcaOgt9UjpwuwWzLRJcA>
    <xme:_ULnYqyg6FNBjXu8Bu8C3rgQpZGI1O74apLdZJaSjXI925md-1oGFNMlt6l1AnR9v
    RQAuhWQ1AjUlI_zEQ>
X-ME-Received: <xmr:_ULnYm1JV_gFweFY8pfq5sYV_knORYfxDJJboJmnLtCBFZJOOANf9QVAUGo_nj8pfJ7oW9fumoTIYW7GkPPPtwJFPLH3FCn_nBUgY8JSzSBzsob_652QC5R16ccgRE_RPHp-Qg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvddvvddgheekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepudekteeuudehtdelteevgfduvddvjefhfedulefgudevgeeghefg
    udefiedtveetnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrh
    homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:_ULnYpCdgaTqJV05PxALzrbNxZt0gQSeL64kueac-rB1hFbOFNNv-Q>
    <xmx:_ULnYqg6w9thfVNWkh6vjL28jDvyJqarF2ixocxCnYHp86lbue8C8w>
    <xmx:_ULnYtqFmTwSvBvlNf5-s9ot9xfZhr-f9Lz9xXqkeW8x2Q2cztpEJQ>
    <xmx:_ULnYhrDZDvXt33jp2Dhj8LjmqmHVi4nDaqmUWK9K30FZnJZL7JXUA>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 31 Jul 2022 23:05:33 -0400 (EDT)
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
Subject: [PATCH 7/9] soc: sunxi: sram: Save a pointer to the OF match data
Date:   Sun, 31 Jul 2022 22:05:07 -0500
Message-Id: <20220801030509.21966-8-samuel@sholland.org>
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

It is inefficient to match the compatible string every time the regmap
is accessed.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

 drivers/soc/sunxi/sunxi_sram.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/soc/sunxi/sunxi_sram.c b/drivers/soc/sunxi/sunxi_sram.c
index 9622fd45f5e5..7c6fb17cfe7f 100644
--- a/drivers/soc/sunxi/sunxi_sram.c
+++ b/drivers/soc/sunxi/sunxi_sram.c
@@ -305,9 +305,7 @@ static const struct sunxi_sramc_variant sun50i_h616_sramc_variant = {
 static bool sunxi_sram_regmap_accessible_reg(struct device *dev,
 					     unsigned int reg)
 {
-	const struct sunxi_sramc_variant *variant;
-
-	variant = of_device_get_match_data(dev);
+	const struct sunxi_sramc_variant *variant = dev_get_drvdata(dev);
 
 	if (reg < SUNXI_SRAM_EMAC_CLOCK_REG)
 		return false;
@@ -340,6 +338,8 @@ static int __init sunxi_sram_probe(struct platform_device *pdev)
 	if (!variant)
 		return -EINVAL;
 
+	dev_set_drvdata(dev, (struct sunxi_sramc_variant *)variant);
+
 	base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(base))
 		return PTR_ERR(base);
-- 
2.35.1

