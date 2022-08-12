Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AACBF590D0A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 09:56:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237145AbiHLH4a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 03:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237695AbiHLH4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 03:56:12 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41E6C99B69;
        Fri, 12 Aug 2022 00:56:12 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id A453D5C0093;
        Fri, 12 Aug 2022 03:56:11 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Fri, 12 Aug 2022 03:56:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1660290971; x=1660377371; bh=Ku
        PNx3e+Sm9vGFleyNWbDoSIPJDEO6zCItICk8V/+dA=; b=Brk9lXs7GgGEb+m5Jn
        +T9S+mP79jOOIoEoavKZg2ipEPWsEFjEGE437NKhxxpP23VdEsSRKTIN+n5g4ouL
        q0v+F4vLk6cbq8J6sipe0SQXXP0hSnk9M5injNPpqcEuDBNuwIETQ/HwxFaJe6/T
        fsMvaifDpgE86fAmyL+btx7BDI1lPPLgWzMRVeMDykjsBeJtT/wh0VQbQzxRsYzp
        SazfA6R6cYpgSeBQkdPIsmtp0sDAanmAOqnHeL3RtQdSIvG9NzRUCCAaFtzHaFYo
        PUMfWjDquCyWxNM4Q5yVPS8ZVu9UE9tY0c2/5MgQWsALRobh6fbZMKcBt9x51D+9
        YwUw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1660290971; x=1660377371; bh=KuPNx3e+Sm9vG
        FleyNWbDoSIPJDEO6zCItICk8V/+dA=; b=n6OUOQdmH/4seqTdDZGZhUd3mNXYt
        7EIDmX596A96pW+aJ+op9FUvyVZFWJY3q28fNNJagH4S0nyplCG3Dg3Vfj+W0RAn
        bHzPGhAkgNx1MGVmB79LBd1DUKFSLI9fwnZ3RNjMUkiKX0+a6M/MxovYWgtKor4a
        IjDP45DDYH03pKh6PYJ094CKC6MSKBvYa/bGfwZ4miYK+M4JVdWe7R+IS7DAvGP8
        RwuGSa47kECXIv44l/DQsz5ZB2qvmok899Wr7eAchga+LvQ0UsChMlcruoekQ56J
        S4fg7dBBYokrvUzaytM4+yOf11nJ67UvQ1iFPoP+4Clunr52DKyUk4jcA==
X-ME-Sender: <xms:mwf2YsLNx0Zlpm_77pnC3CNkNSrtZK29JbMnKiMt-uGEEf1gMGCE8w>
    <xme:mwf2YsIDvdh54luOtLNw-Mfd0DTdxkvhv2mt4HyGQkL-AkanVdZYMhKO-LHfm6_bA
    9qpB3oXYbgjzcJlug>
X-ME-Received: <xmr:mwf2Yss9E8SLVm_OjBr3LuBtNhZzFt4ZQl9dh1gUXEBoRepykIg1iOpxht_JX2AUCW1iaNDjxGgUoWuWLHHM_4MnZBP98FQzUR4RQrkqYl3qxqjo-pP4nZvpyIUoUCBguxvWsw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdeghedguddvjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghm
    uhgvlhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenuc
    ggtffrrghtthgvrhhnpedukeetueduhedtleetvefguddvvdejhfefudelgfduveeggeeh
    gfdufeeitdevteenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:mwf2YpYdvQt736OOElQx1hkLYtDnx_fnlIkZ_di3WJHty0Yl7doj3w>
    <xmx:mwf2YjYhpn4x6gYI6N0UPmpMJZTQp7I-m-kX-D4jeKhmh6DhaetHuA>
    <xmx:mwf2YlBEQSGonJWKrRB2tfaIYgO5sRPv24Fpo6yz6cLAGj3NIR5eug>
    <xmx:mwf2YpxcnVKVfH7cNlPyqoumBeaZE33a429pUyr4cKBr-5UGJRyuFQ>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 Aug 2022 03:56:10 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maxime Ripard <mripard@kernel.org>
Cc:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Samuel Holland <samuel@sholland.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: [PATCH 5/8] phy: allwinner: phy-sun6i-mipi-dphy: Make RX support optional
Date:   Fri, 12 Aug 2022 02:56:00 -0500
Message-Id: <20220812075603.59375-6-samuel@sholland.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220812075603.59375-1-samuel@sholland.org>
References: <20220812075603.59375-1-samuel@sholland.org>
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

While all variants of the DPHY likely support RX mode, the new variant
in the A100 is not used in this direction by the BSP, and it has some
analog register changes, so its RX power-on sequence is unknown. To be
safe, limit RX support to variants where the power-on sequence is known.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

 drivers/phy/allwinner/phy-sun6i-mipi-dphy.c | 25 +++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/allwinner/phy-sun6i-mipi-dphy.c b/drivers/phy/allwinner/phy-sun6i-mipi-dphy.c
index 3900f1650851..625c6e1e9990 100644
--- a/drivers/phy/allwinner/phy-sun6i-mipi-dphy.c
+++ b/drivers/phy/allwinner/phy-sun6i-mipi-dphy.c
@@ -114,6 +114,10 @@ enum sun6i_dphy_direction {
 	SUN6I_DPHY_DIRECTION_RX,
 };
 
+struct sun6i_dphy_variant {
+	bool	supports_rx;
+};
+
 struct sun6i_dphy {
 	struct clk				*bus_clk;
 	struct clk				*mod_clk;
@@ -123,6 +127,7 @@ struct sun6i_dphy {
 	struct phy				*phy;
 	struct phy_configure_opts_mipi_dphy	config;
 
+	const struct sun6i_dphy_variant		*variant;
 	enum sun6i_dphy_direction		direction;
 };
 
@@ -409,6 +414,10 @@ static int sun6i_dphy_probe(struct platform_device *pdev)
 	if (!dphy)
 		return -ENOMEM;
 
+	dphy->variant = device_get_match_data(&pdev->dev);
+	if (!dphy->variant)
+		return -EINVAL;
+
 	regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(regs)) {
 		dev_err(&pdev->dev, "Couldn't map the DPHY encoder registers\n");
@@ -445,8 +454,13 @@ static int sun6i_dphy_probe(struct platform_device *pdev)
 	ret = of_property_read_string(pdev->dev.of_node, "allwinner,direction",
 				      &direction);
 
-	if (!ret && !strncmp(direction, "rx", 2))
+	if (!ret && !strncmp(direction, "rx", 2)) {
+		if (!dphy->variant->supports_rx) {
+			dev_err(&pdev->dev, "RX not supported on this variant\n");
+			return -EOPNOTSUPP;
+		}
 		dphy->direction = SUN6I_DPHY_DIRECTION_RX;
+	}
 
 	phy_set_drvdata(dphy->phy, dphy);
 	phy_provider = devm_of_phy_provider_register(&pdev->dev, of_phy_simple_xlate);
@@ -454,8 +468,15 @@ static int sun6i_dphy_probe(struct platform_device *pdev)
 	return PTR_ERR_OR_ZERO(phy_provider);
 }
 
+static const struct sun6i_dphy_variant sun6i_a31_mipi_dphy_variant = {
+	.supports_rx	= true,
+};
+
 static const struct of_device_id sun6i_dphy_of_table[] = {
-	{ .compatible = "allwinner,sun6i-a31-mipi-dphy" },
+	{
+		.compatible	= "allwinner,sun6i-a31-mipi-dphy",
+		.data		= &sun6i_a31_mipi_dphy_variant,
+	},
 	{ }
 };
 MODULE_DEVICE_TABLE(of, sun6i_dphy_of_table);
-- 
2.35.1

