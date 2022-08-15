Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BCB4592876
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 06:13:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240134AbiHOEN2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 00:13:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240427AbiHOENP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 00:13:15 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1C7F140A0;
        Sun, 14 Aug 2022 21:13:10 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id A269E320034E;
        Mon, 15 Aug 2022 00:13:08 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 15 Aug 2022 00:13:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1660536788; x=1660623188; bh=bs
        QRvr/fSy27iYvVN9Y3M8XtrRlfI3kw9DiTc9wURok=; b=Zofwc9ihrKJdg51xHx
        yltqKhiMGW8wV4p4LRFyM9wuQNn516Ln+PUvvS8bnelUSdTvG2qQeO+L23tl++q7
        uPUybi5aX/BRvR74qx7DBXME/R96wbpyGJcuIqJF/TXxny2EnEVbeWSV/5DWVlRg
        VuoGkJ+QTxc51tgyT8XYsc5sbfgS5E8TYAuLy2m+tKGrf7tZeTMyY/iuBcKbKGXJ
        A0MnspvlAEjuX+1LPWRx8mAxAMgHgK4SXrhz/UZ6mNe/ypu89hSioS7HZ8bIljAZ
        yLYu0c4k34cCwbXIgGMXQydZNsTe0IUYd5lbTPNtwqwR98MEolhIQAsrCgamz5zH
        8GYA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1660536788; x=1660623188; bh=bsQRvr/fSy27i
        YvVN9Y3M8XtrRlfI3kw9DiTc9wURok=; b=S+7jvBq81uWR26r8f7rQACLxEB40u
        QyaeAK6KO/mAQ9nA7ej2sIVtBqJNeClq1165prwoRxMfNPfcAgyGfag6vblHF78P
        wli45DfZFRiuaGfvUq5YJblvtWeC46CwL4wutrTyfD+vuKwIXOudWLncmv4AiIbS
        nUhXAEXF64DK95gAbNDOWW5aoO7yJgMNQ2K8FD32Lx1JpvPklIdleLgrWuTSfTlM
        WJWoX3wbERx42+q+mRUw7fbeK5M35kxTPVKhCI1fmngpecEe6pzIplmHnitbdj02
        2jKaPlUdZi81iGAKuL+a7rNkxdYd5Ycp7PvSc/aRVplO6yMZBFYdENRAg==
X-ME-Sender: <xms:08f5Yr2x2LPtskfh47Gf3-wh-HavEHwC14w-wwU6WHqNjfIp1LSBcA>
    <xme:08f5YqGXJUs6q0UtrqsCve1yMYZ31svJjiG93Xyt4a6_Ey5gALAuJLqZ8G-99HNCl
    ETiI9t0bVWItqyREg>
X-ME-Received: <xmr:08f5Yr6NCCPSVCApyNbY65ac4AUw3WAQmKYy2Q0xcQ6WlGPKWy5m4odFizla0PdoHzz5yhXdAi3ykW4lavyLbmFTRkP-r9IuQEpnhC-xbqv2Aj7l12zxhH_Mui-FhsUzAzY0DQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdehuddgkeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepudekteeuudehtdelteevgfduvddvjefhfedulefgudevgeeghefg
    udefiedtveetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:08f5Yg16CE4cNSPdyB2oMXXJjkDviALBJE3KBnVHF5YIVX2_mUmhYQ>
    <xmx:08f5YuFpg91JaPJqrWsyw5_jT2RUMbj4bquATat00quAb0XS-mnSiQ>
    <xmx:08f5Yh_XZpx8xKOQafYtiDM7R2_C06_IcKW7GBFoKTc9hBphfcHZrA>
    <xmx:1Mf5Yp_vbNylVGWj21rx0I5jXTbr1UnzNaS216JpkQqEZhf0dSrosw>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Aug 2022 00:13:07 -0400 (EDT)
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
Subject: [PATCH v2 05/10] soc: sunxi: sram: Fix probe function ordering issues
Date:   Sun, 14 Aug 2022 23:12:42 -0500
Message-Id: <20220815041248.53268-6-samuel@sholland.org>
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

Errors from debugfs are intended to be non-fatal, and should not prevent
the driver from probing.

Since debugfs file creation is treated as infallible, move it below the
parts of the probe function that can fail. This prevents an error
elsewhere in the probe function from causing the file to leak. Do the
same for the call to of_platform_populate().

Finally, checkpatch suggests an octal literal for the file permissions.

Fixes: 4af34b572a85 ("drivers: soc: sunxi: Introduce SoC driver to map SRAMs")
Fixes: 5828729bebbb ("soc: sunxi: export a regmap for EMAC clock reg on A64")
Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>
Signed-off-by: Samuel Holland <samuel@sholland.org>
---

(no changes since v1)

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

