Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 072CC590CB2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 09:43:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237462AbiHLHnN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 03:43:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237438AbiHLHnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 03:43:03 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AB2BA5C7A;
        Fri, 12 Aug 2022 00:43:02 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id BC3AE5C01A2;
        Fri, 12 Aug 2022 03:43:01 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Fri, 12 Aug 2022 03:43:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1660290181; x=1660376581; bh=Vq
        niFcDylYycBP8BNmnD1PxhokhoBt8SnraZf98bzRU=; b=YlCN6oCFBU7q8687oa
        yS22BDmZHNYdXkd5hG9xHhP9Q8UFxYvPFnUVLFMoP/weq08d2xvRexawXHXFV+8J
        Uxgz+UjpK2MIYyazzu2SdV2uxBPfsYN1yZAbeMV2VSqobApq22DxELBr+6SPefHM
        nxa6/6TLIIA49KVVz264maVueFo3VLX/821EmQFGuMQ49NCoRmBv/VeXQEunAV+/
        J+2u7lpvyWCLz2CmD8N9a3hG86wSZwP96ElI+c5oTxYCu83fUbxSqpsRYQzHIPF0
        6XUUv9dChlGJsw4EqOQXorydPOVLBRRasGVQlWYY8MI48eIoOqHhjLFgcLVRq3Ki
        beIA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1660290181; x=1660376581; bh=VqniFcDylYycB
        P8BNmnD1PxhokhoBt8SnraZf98bzRU=; b=IBkwYzFqzDMLqOOGM3nnPbufOeVqP
        g+q2f36Shay7kdZoL1pPfBc8ywVNbEXIoyEtznKzSEX8Rp1fFScCeuTcgiBdmLlX
        HJorA7tbEV5C2Me+c7+Y51iAEdlSa4CdXj0EvQ8p19retRK/VghjKrl+pyNuOJWx
        hyfen3XcSGvl5NsZ2QqLtE3POYMhsnx0Gs/XEETgHqjfHyYMKBvwzS8EzeR9gA1e
        pLguDxp9u4aBe4Jdlwn+Hs4rrwQlvP2yJem6DNMyFiWVdN1c0ZB71VrVa+wwy9SO
        hMJf3ornKN6j1QMAY52FRCJjo/M/9fziA2M96ehWhM65xlMUXtZsQQvZg==
X-ME-Sender: <xms:hQT2Ys5DrDIZmkmDnKQn9wOSb4bTBhnaFlERdi5QVgpodwAyMTQdew>
    <xme:hQT2Yt4OIsazaINvnZXDPEAD8iDfHtgWizi2PeZTKVMSio7kPK1fW5ai5L5oP0uES
    OixeIQRt6KP1eLDZw>
X-ME-Received: <xmr:hQT2Yrcg5CXxy-tSDZOcdUe_4h_wsIlAGyFMunxjOII0X7XOM17xq52pcMKgRQOT0ZNLmIUjbOlh-goT0pAypEt6V34DhxHbFsNrtOpwMreBds0p1wHzIofqLRFpN2LaHeZUIg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdeghedguddvgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghm
    uhgvlhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenuc
    ggtffrrghtthgvrhhnpedukeetueduhedtleetvefguddvvdejhfefudelgfduveeggeeh
    gfdufeeitdevteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:hQT2YhLEHTevke4qGQcqJQSuf73pdCHCn00gJduy8iu2O2cAOZrIqw>
    <xmx:hQT2YgJssM7qmZET3JvQcVV-nMlv1r3Ix5H-bhFscgjCEM3w-58VAQ>
    <xmx:hQT2Yixl5lAvQHopEawYM5lbBuHH2NsrTQLuH8SOU_stKx4x5Zo_UA>
    <xmx:hQT2YiACJpy8yw8TJjn5Xaq1jKjIsRZwMHVadhf_hORvGKWoYiHfhA>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 Aug 2022 03:43:00 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maxime Ripard <mripard@kernel.org>
Cc:     Samuel Holland <samuel@sholland.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev
Subject: [PATCH 3/4] drm/sun4i: dsi: Add a variant structure
Date:   Fri, 12 Aug 2022 02:42:55 -0500
Message-Id: <20220812074257.58254-4-samuel@sholland.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220812074257.58254-1-samuel@sholland.org>
References: <20220812074257.58254-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the ad-hoc calls to of_device_is_compatible() with a structure
describing the differences between variants. This is in preparation for
adding more variants to the driver.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 50 +++++++++++++++++---------
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h |  7 ++++
 2 files changed, 40 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
index b4dfa166eccd..6479ade416b9 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
@@ -1101,12 +1101,16 @@ static const struct component_ops sun6i_dsi_ops = {
 
 static int sun6i_dsi_probe(struct platform_device *pdev)
 {
+	const struct sun6i_dsi_variant *variant;
 	struct device *dev = &pdev->dev;
-	const char *bus_clk_name = NULL;
 	struct sun6i_dsi *dsi;
 	void __iomem *base;
 	int ret;
 
+	variant = device_get_match_data(dev);
+	if (!variant)
+		return -EINVAL;
+
 	dsi = devm_kzalloc(dev, sizeof(*dsi), GFP_KERNEL);
 	if (!dsi)
 		return -ENOMEM;
@@ -1114,10 +1118,7 @@ static int sun6i_dsi_probe(struct platform_device *pdev)
 	dsi->dev = dev;
 	dsi->host.ops = &sun6i_dsi_host_ops;
 	dsi->host.dev = dev;
-
-	if (of_device_is_compatible(dev->of_node,
-				    "allwinner,sun6i-a31-mipi-dsi"))
-		bus_clk_name = "bus";
+	dsi->variant = variant;
 
 	base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(base)) {
@@ -1142,7 +1143,7 @@ static int sun6i_dsi_probe(struct platform_device *pdev)
 		return PTR_ERR(dsi->regs);
 	}
 
-	dsi->bus_clk = devm_clk_get(dev, bus_clk_name);
+	dsi->bus_clk = devm_clk_get(dev, variant->has_mod_clk ? "bus" : NULL);
 	if (IS_ERR(dsi->bus_clk))
 		return dev_err_probe(dev, PTR_ERR(dsi->bus_clk),
 				     "Couldn't get the DSI bus clock\n");
@@ -1151,21 +1152,21 @@ static int sun6i_dsi_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	if (of_device_is_compatible(dev->of_node,
-				    "allwinner,sun6i-a31-mipi-dsi")) {
+	if (variant->has_mod_clk) {
 		dsi->mod_clk = devm_clk_get(dev, "mod");
 		if (IS_ERR(dsi->mod_clk)) {
 			dev_err(dev, "Couldn't get the DSI mod clock\n");
 			ret = PTR_ERR(dsi->mod_clk);
 			goto err_attach_clk;
 		}
-	}
 
-	/*
-	 * In order to operate properly, that clock seems to be always
-	 * set to 297MHz.
-	 */
-	clk_set_rate_exclusive(dsi->mod_clk, 297000000);
+		/*
+		 * In order to operate properly, the module clock on the
+		 * A31 variant always seems to be set to 297MHz.
+		 */
+		if (variant->set_mod_clk)
+			clk_set_rate_exclusive(dsi->mod_clk, 297000000);
+	}
 
 	dsi->dphy = devm_phy_get(dev, "dphy");
 	if (IS_ERR(dsi->dphy)) {
@@ -1205,16 +1206,31 @@ static int sun6i_dsi_remove(struct platform_device *pdev)
 
 	component_del(&pdev->dev, &sun6i_dsi_ops);
 	mipi_dsi_host_unregister(&dsi->host);
-	clk_rate_exclusive_put(dsi->mod_clk);
+	if (dsi->variant->has_mod_clk && dsi->variant->set_mod_clk)
+		clk_rate_exclusive_put(dsi->mod_clk);
 
 	regmap_mmio_detach_clk(dsi->regs);
 
 	return 0;
 }
 
+static const struct sun6i_dsi_variant sun6i_a31_mipi_dsi_variant = {
+	.has_mod_clk	= true,
+	.set_mod_clk	= true,
+};
+
+static const struct sun6i_dsi_variant sun50i_a64_mipi_dsi_variant = {
+};
+
 static const struct of_device_id sun6i_dsi_of_table[] = {
-	{ .compatible = "allwinner,sun6i-a31-mipi-dsi" },
-	{ .compatible = "allwinner,sun50i-a64-mipi-dsi" },
+	{
+		.compatible	= "allwinner,sun6i-a31-mipi-dsi",
+		.data		= &sun6i_a31_mipi_dsi_variant,
+	},
+	{
+		.compatible	= "allwinner,sun50i-a64-mipi-dsi",
+		.data		= &sun50i_a64_mipi_dsi_variant,
+	},
 	{ }
 };
 MODULE_DEVICE_TABLE(of, sun6i_dsi_of_table);
diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h
index c863900ae3b4..f1ddefe0f554 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h
@@ -15,6 +15,11 @@
 
 #define SUN6I_DSI_TCON_DIV	4
 
+struct sun6i_dsi_variant {
+	bool			has_mod_clk;
+	bool			set_mod_clk;
+};
+
 struct sun6i_dsi {
 	struct drm_connector	connector;
 	struct drm_encoder	encoder;
@@ -31,6 +36,8 @@ struct sun6i_dsi {
 	struct mipi_dsi_device	*device;
 	struct drm_device	*drm;
 	struct drm_panel	*panel;
+
+	const struct sun6i_dsi_variant *variant;
 };
 
 static inline struct sun6i_dsi *host_to_sun6i_dsi(struct mipi_dsi_host *host)
-- 
2.35.1

