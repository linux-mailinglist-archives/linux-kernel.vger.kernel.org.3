Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CFBA5862F5
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 05:05:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239580AbiHADFq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 23:05:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239517AbiHADF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 23:05:28 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A16A260E;
        Sun, 31 Jul 2022 20:05:27 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 766553200077;
        Sun, 31 Jul 2022 23:05:25 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Sun, 31 Jul 2022 23:05:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1659323124; x=1659409524; bh=bK
        bLq8gXyaC/nciXymlgvBGqzJKGfY3EeYJHQps9uFk=; b=MyJcbt5TZlAyb0UE1/
        +XIHxklCzbXhu+wr+ER32MDbN0NvOTqY+wSgYKXkha3r0KqK52Qko/1v9MGXwLda
        rH1n/fTG596lu5SocVL6L4Uk4eI/PNp3OQx/watQBq2wbM3hyOgOqZ2QMvoyZPO7
        aFXSwXFo0IBUQ0jFKkp1Vbih/cJC2+ruSWOU7TN1tdNwG7zmtkgPYV3giI5wBAOD
        lBUoI5/JztXjzXWjLVeQRxz4IBNzLIURHPQARzu0EOJHxpO0K6pEtsDgQ/l/ieSJ
        qc91TY6OMw5RYXv62RWju4sksiU5b/eRTt99JVrEVwu81xmWCYird6kDnkhH1Suv
        uC7Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1659323124; x=1659409524; bh=bKbLq8gXyaC/n
        ciXymlgvBGqzJKGfY3EeYJHQps9uFk=; b=PLpcmrBpmOE5T/AJeRVL9k6HIVl7V
        IMwCYJAcoeE7yStOUVKwXYoQFEf3v8xO4TvnY7JFyUnnCaKouhhmJ/olJOhHLtYw
        p+mkCTYA5a3j2iHY7J7WpCoDZiMJap77dGWzo0iHJ0zfRz4JN4qQUwL9GhOobkoQ
        TQS0RtMG20ssUbWItykJ+c8WER7b0+Ki/hl9B6q8HSluQ/8/1dM8mHdIM3qEiYN8
        eYVvRy6mWBTizietF/dEScTjJ5z1VNtS9dNqZ0FjTTcAElK3KmMwbmhmT2asLA8z
        +12QOzpDigWunR5Yr7sRu6UBIAKmmuetjcAK31+b2eMthPmnfQN/fooNA==
X-ME-Sender: <xms:9ELnYtgRvaS-MGENgkzeBTu_iTQ018DKHfCyTF912Ljqrxjbl88enQ>
    <xme:9ELnYiDFng3s2O_6z0Xo5xM3XmgtEDwl7KfncNv-EEHQ1Tr1fiwEMAoQnPGbGWSRh
    ywbAkvc1EDjqpkpyg>
X-ME-Received: <xmr:9ELnYtEGleKAI3_9g5idzN2hr20b-xxigLOgOaDTkbp5IP3U9biq2dtGjNcUczRepmPbHXGVdG41rpCKTfQi1ZOc0u4l4lHIMEGlB3VV7MnIAo8NehuQ0gsxx3Yt5lfsvkZUNg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvddvvddgheejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepudekteeuudehtdelteevgfduvddvjefhfedulefgudevgeeghefg
    udefiedtveetnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrh
    homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:9ELnYiQZIynvpGl5kq6csn_w_4vzRIWe1HtysVb4Ty23egbUM8A24A>
    <xmx:9ELnYqzQ-602Z6tFd0XLIVhA34lBvtxBsf6aQjJ0XhKfS-qvJbRxvA>
    <xmx:9ELnYo79KFmcWlkuaCEgcVG86qLGib5YovRV8ICb_Vt_CN6wuhAWyA>
    <xmx:9ELnYs6PUVjRxVceN2uTnlkUUpzx9jhdxB2WEYxWj7LDZilBA3C1JA>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 31 Jul 2022 23:05:24 -0400 (EDT)
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
Subject: [PATCH 4/9] soc: sunxi: sram: Fix probe function ordering issues
Date:   Sun, 31 Jul 2022 22:05:04 -0500
Message-Id: <20220801030509.21966-5-samuel@sholland.org>
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

Errors from debugfs are intended to be non-fatal, and should not prevent
the driver from probing.

Since debugfs file creation is treated as infallible, move it below the
parts of the probe function that can fail. This prevents an error
elsewhere in the probe function from causing the file to leak. Do the
same for the call to of_platform_populate().

Finally, checkpatch suggests an octal literal for the file permissions.

Fixes: 4af34b572a85 ("drivers: soc: sunxi: Introduce SoC driver to map SRAMs")
Fixes: 5828729bebbb ("soc: sunxi: export a regmap for EMAC clock reg on A64")
Signed-off-by: Samuel Holland <samuel@sholland.org>
---

 drivers/soc/sunxi/sunxi_sram.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/soc/sunxi/sunxi_sram.c b/drivers/soc/sunxi/sunxi_sram.c
index a858a37fcdd4..52d07bed7664 100644
--- a/drivers/soc/sunxi/sunxi_sram.c
+++ b/drivers/soc/sunxi/sunxi_sram.c
@@ -332,9 +332,9 @@ static struct regmap_config sunxi_sram_emac_clock_regmap = {
 
 static int __init sunxi_sram_probe(struct platform_device *pdev)
 {
-	struct dentry *d;
 	struct regmap *emac_clock;
 	const struct sunxi_sramc_variant *variant;
+	struct device *dev = &pdev->dev;
 
 	sram_dev = &pdev->dev;
 
@@ -346,13 +346,6 @@ static int __init sunxi_sram_probe(struct platform_device *pdev)
 	if (IS_ERR(base))
 		return PTR_ERR(base);
 
-	of_platform_populate(pdev->dev.of_node, NULL, NULL, &pdev->dev);
-
-	d = debugfs_create_file("sram", S_IRUGO, NULL, NULL,
-				&sunxi_sram_fops);
-	if (!d)
-		return -ENOMEM;
-
 	if (variant->num_emac_clocks > 0) {
 		emac_clock = devm_regmap_init_mmio(&pdev->dev, base,
 						   &sunxi_sram_emac_clock_regmap);
@@ -361,6 +354,10 @@ static int __init sunxi_sram_probe(struct platform_device *pdev)
 			return PTR_ERR(emac_clock);
 	}
 
+	of_platform_populate(dev->of_node, NULL, NULL, dev);
+
+	debugfs_create_file("sram", 0444, NULL, NULL, &sunxi_sram_fops);
+
 	return 0;
 }
 
-- 
2.35.1

