Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 995D059287A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 06:14:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240711AbiHOENq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 00:13:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240410AbiHOENY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 00:13:24 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D78EF140DB;
        Sun, 14 Aug 2022 21:13:20 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id A03F032005C1;
        Mon, 15 Aug 2022 00:13:18 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 15 Aug 2022 00:13:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1660536798; x=1660623198; bh=RX
        0SlEktfrQtPXw+non/OchyG9cDMb9wJ6p6VMV+d1s=; b=EwSRzuob6nUdMkFGOq
        OtlL8jLm0ztjwX8kZ6U1ruba8+lk7YbMSl9l3tcE5/95GvZibNmn7sN/Fz5iOVc7
        qcg+l17CrGgzC8MDVxBZlD9ATI0Tf/bqUvOyiyGXl8GgwPiD2RlHs+r4+EmV1YhC
        FHzPWI2xSaaKJ8695KV8ZAYmsr5BBLGGlpg46BDzAZCOQg0NKY93gVEI/W8kopjU
        3oQE0RiOfPj30lsC5gnH1YWQJ3u2xodlinChYTRhUNRogAr2IL815lWzpcsXHJyE
        ntNWGBjcqip97YnRRwtg1X9B2rIQF/cJbN78Sn7GXPmkyNHEPxj0RaZzjtS4uQSl
        tCTg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1660536798; x=1660623198; bh=RX0SlEktfrQtP
        Xw+non/OchyG9cDMb9wJ6p6VMV+d1s=; b=PI544408CbPVobr4ngPD4cmYSzoQe
        BwCmcS5c/KAiflTF3MuhegUJ3F3Qct7zeQMqNAZPlPec/Sft73jQItlzghw7yueY
        dhEpRZSYf73e6IsrNf3GddKTv8PSw3jbNSOi8jHCVR/KQEtNXz5Ssymk+YY9dtaV
        zLPadexzfADR3X4vqK8iiZAwDQB5jSC9B1MxnhI47mb7pFiYeUEhuCT5zbS3JsUq
        6Adpu5j+SJMbhd+BVXN1AWUaieeFTjFiJqr3A+yTwQBlDgMYzUHFof4n6CYjUcbw
        XKL+hESNObgp+hSZZNbplECgp8Z71YTgMPDno5lp56ULMKFI0MKpfhcrQ==
X-ME-Sender: <xms:3sf5Ykj-xYvYh-IBDdUIi8n11sqez-F8HwAO9qbh6NKqLJDsZPwOqw>
    <xme:3sf5YtAQGIjoyXcK77AePwBNfqJLdtq_4TuGFlj9gvAIQdcvls2-MJ1IlY8TyHNfS
    TDKuQLRTVWwRPR5FQ>
X-ME-Received: <xmr:3sf5YsFgemjf-v4GwHvCZhb3Omwi9QHzVZrnHSL1w9IDkyDLM--0E6OsZi5qoyWrf7qiJxXYobhWiKvDwDrHkqgGwCdla9Zag5fZNhd2m_OB21BYryvEiKSuhqiKZ84XeX89JA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdehuddgkeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepudekteeuudehtdelteevgfduvddvjefhfedulefgudevgeeghefg
    udefiedtveetnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrh
    homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:3sf5YlQE2EPuXY3FWLq8tAaaxXsr056YgfhJ8rBz7aauix-PnQPGEw>
    <xmx:3sf5YhwUkQip5yaXbI4OOAPqclPhQIH20T4roi9XNNfW_SFa_mcK-Q>
    <xmx:3sf5Yj5UjVCPr7lGTRSpJxNapLOwl1BWKFmgF-lfthmg_dSWFH72jg>
    <xmx:3sf5Yn7yODn30h2SY4xuMzQ-fMGy4naPT8D_jIY8PDj0q94Xx0THxQ>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Aug 2022 00:13:17 -0400 (EDT)
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
Subject: [PATCH v2 08/10] soc: sunxi: sram: Save a pointer to the OF match data
Date:   Sun, 14 Aug 2022 23:12:45 -0500
Message-Id: <20220815041248.53268-9-samuel@sholland.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220815041248.53268-1-samuel@sholland.org>
References: <20220815041248.53268-1-samuel@sholland.org>
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

It is inefficient to match the compatible string every time the regmap
is accessed.

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>
Signed-off-by: Samuel Holland <samuel@sholland.org>
---

(no changes since v1)

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

