Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 113F8590D08
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 09:56:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237745AbiHLH4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 03:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237685AbiHLH4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 03:56:15 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B466D99B7C;
        Fri, 12 Aug 2022 00:56:14 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 2026B5C0093;
        Fri, 12 Aug 2022 03:56:14 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Fri, 12 Aug 2022 03:56:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1660290974; x=1660377374; bh=Xh
        qRMH3MJeMc6YrQbqiTmLMH13EPFmaYzv6faVKxorM=; b=WZU+6aZvdLjRK/J+pm
        DhSPRq8+2HALluyZujThpLBO1xqmBlNmzMX22dExx4294kLhvD4yW1D7X4hmgYlb
        EFH/+S5dpse6/DdFuAWsIrFGabo+HnR5rtnyt7iG5eqkIi8mi7VD/yiVfb/cowwM
        DSyffMtGYrpVEeVhjHUzoFfpmAazCmp0yVzfT2M8Uu2tD0+GlLoo5/Op3MrIaGfg
        50keaS1DUcn/sMa8whKkyFAC6UP4DgjQ7V68xEkyvoyWuV+SQ/QLd/HqAd/cDI35
        Xzvg8Hdx3qYjxbZtEfd10MM350JzqwXntwTEIviQ5Jqq7LncNCP6LnumbURqFwry
        RP5A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1660290974; x=1660377374; bh=XhqRMH3MJeMc6
        YrQbqiTmLMH13EPFmaYzv6faVKxorM=; b=MWQADjMIosg2aHbFkUI/R7PJnC9V0
        1koHuooHgoScbFhJxQowO37I1kbaGHPajMzTclPgORzRPgGLq5jF+hfR2aG+js2j
        xyJ2WbBevZzDdmS9woZFnI9dsMEsSgtVukN0rM1o1q9SO0YnWK6GIgkPhlIrKP/0
        C591RKV+Xt8/PwVWsxfKiRZiWxg4cUnXPYrku4PUqMyonzMQY0fTxwSqtoqPCVtK
        c/6sFfXmJ/aagmcoN3zXR0N+kd//1PydZSqTQxn2vmgJa+2cIg1V9ysaO5XXwo1I
        YLcSAaL2z23NyGR0IGTUzWnvJTYr5Px0H5WyHA3luGW2TT1nUVzPXJ5Gg==
X-ME-Sender: <xms:nQf2YmeQHSYGD8zkB6Z7sFiwIfA36BXYJLlay_t1nrs2Lna3wXZB2Q>
    <xme:nQf2YgMiPYOAbhbnLT7zDvi9SB0yYjsxUV5J5Outxaos5mM_F_EVlyosU8grATQ8T
    _r33_gi-s-sVY33zg>
X-ME-Received: <xmr:nQf2YniFurl0dBlKpWAClTfo0sWe1Aq3vu5IeXaZ9TO3iYxbF5LIInx8YkdQKO9teado-oK1fSDPsgJ6y8yQH-_I8VzfHGk04T_uOU7FzfL2f6XI5yjzjaQ_jmEHFH1X6Ozf-g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdeghedguddviecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghm
    uhgvlhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenuc
    ggtffrrghtthgvrhhnpedukeetueduhedtleetvefguddvvdejhfefudelgfduveeggeeh
    gfdufeeitdevteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:nQf2Yj8Q2AePKnrMN8CsovvEDmfRlsGzPoQIeH0zaa2ziAOFy1qbfw>
    <xmx:nQf2YitJ7001INZ_RMw4zxAi_QYoGbSJECHhx8t18WnbX7xQ6vWBDg>
    <xmx:nQf2YqFlKWmiRSTM4UUErYIjxbXT-WoMrBQQl_FUT5MZHcqFQmsrQw>
    <xmx:ngf2YiEKtm4w8Vurc38nqVNHlTYWjqnuKRwb5W_n_j7dNfv2kfetsg>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 Aug 2022 03:56:13 -0400 (EDT)
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
Subject: [PATCH 7/8] phy: allwinner: phy-sun6i-mipi-dphy: Add a variant power-on hook
Date:   Fri, 12 Aug 2022 02:56:02 -0500
Message-Id: <20220812075603.59375-8-samuel@sholland.org>
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

The A100 variant uses the same values for the timing registers, and it
uses the same final power-on sequence, but it needs a different analog
register configuration in the middle. Support this by moving the
variant-specific parts to a hook provided by the variant.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

 drivers/phy/allwinner/phy-sun6i-mipi-dphy.c | 59 ++++++++++++---------
 1 file changed, 35 insertions(+), 24 deletions(-)

diff --git a/drivers/phy/allwinner/phy-sun6i-mipi-dphy.c b/drivers/phy/allwinner/phy-sun6i-mipi-dphy.c
index 9698d68d0db7..6a1993c434e8 100644
--- a/drivers/phy/allwinner/phy-sun6i-mipi-dphy.c
+++ b/drivers/phy/allwinner/phy-sun6i-mipi-dphy.c
@@ -114,7 +114,10 @@ enum sun6i_dphy_direction {
 	SUN6I_DPHY_DIRECTION_RX,
 };
 
+struct sun6i_dphy;
+
 struct sun6i_dphy_variant {
+	void	(*tx_power_on)(struct sun6i_dphy *dphy);
 	bool	supports_rx;
 };
 
@@ -156,33 +159,10 @@ static int sun6i_dphy_configure(struct phy *phy, union phy_configure_opts *opts)
 	return 0;
 }
 
-static int sun6i_dphy_tx_power_on(struct sun6i_dphy *dphy)
+static void sun6i_a31_mipi_dphy_tx_power_on(struct sun6i_dphy *dphy)
 {
 	u8 lanes_mask = GENMASK(dphy->config.lanes - 1, 0);
 
-	regmap_write(dphy->regs, SUN6I_DPHY_TX_CTL_REG,
-		     SUN6I_DPHY_TX_CTL_HS_TX_CLK_CONT);
-
-	regmap_write(dphy->regs, SUN6I_DPHY_TX_TIME0_REG,
-		     SUN6I_DPHY_TX_TIME0_LP_CLK_DIV(14) |
-		     SUN6I_DPHY_TX_TIME0_HS_PREPARE(6) |
-		     SUN6I_DPHY_TX_TIME0_HS_TRAIL(10));
-
-	regmap_write(dphy->regs, SUN6I_DPHY_TX_TIME1_REG,
-		     SUN6I_DPHY_TX_TIME1_CLK_PREPARE(7) |
-		     SUN6I_DPHY_TX_TIME1_CLK_ZERO(50) |
-		     SUN6I_DPHY_TX_TIME1_CLK_PRE(3) |
-		     SUN6I_DPHY_TX_TIME1_CLK_POST(10));
-
-	regmap_write(dphy->regs, SUN6I_DPHY_TX_TIME2_REG,
-		     SUN6I_DPHY_TX_TIME2_CLK_TRAIL(30));
-
-	regmap_write(dphy->regs, SUN6I_DPHY_TX_TIME3_REG, 0);
-
-	regmap_write(dphy->regs, SUN6I_DPHY_TX_TIME4_REG,
-		     SUN6I_DPHY_TX_TIME4_HS_TX_ANA0(3) |
-		     SUN6I_DPHY_TX_TIME4_HS_TX_ANA1(3));
-
 	regmap_write(dphy->regs, SUN6I_DPHY_ANA0_REG,
 		     SUN6I_DPHY_ANA0_REG_PWS |
 		     SUN6I_DPHY_ANA0_REG_DMPC |
@@ -214,6 +194,36 @@ static int sun6i_dphy_tx_power_on(struct sun6i_dphy *dphy)
 		     SUN6I_DPHY_ANA3_EN_LDOC |
 		     SUN6I_DPHY_ANA3_EN_LDOD);
 	udelay(1);
+}
+
+static int sun6i_dphy_tx_power_on(struct sun6i_dphy *dphy)
+{
+	u8 lanes_mask = GENMASK(dphy->config.lanes - 1, 0);
+
+	regmap_write(dphy->regs, SUN6I_DPHY_TX_CTL_REG,
+		     SUN6I_DPHY_TX_CTL_HS_TX_CLK_CONT);
+
+	regmap_write(dphy->regs, SUN6I_DPHY_TX_TIME0_REG,
+		     SUN6I_DPHY_TX_TIME0_LP_CLK_DIV(14) |
+		     SUN6I_DPHY_TX_TIME0_HS_PREPARE(6) |
+		     SUN6I_DPHY_TX_TIME0_HS_TRAIL(10));
+
+	regmap_write(dphy->regs, SUN6I_DPHY_TX_TIME1_REG,
+		     SUN6I_DPHY_TX_TIME1_CLK_PREPARE(7) |
+		     SUN6I_DPHY_TX_TIME1_CLK_ZERO(50) |
+		     SUN6I_DPHY_TX_TIME1_CLK_PRE(3) |
+		     SUN6I_DPHY_TX_TIME1_CLK_POST(10));
+
+	regmap_write(dphy->regs, SUN6I_DPHY_TX_TIME2_REG,
+		     SUN6I_DPHY_TX_TIME2_CLK_TRAIL(30));
+
+	regmap_write(dphy->regs, SUN6I_DPHY_TX_TIME3_REG, 0);
+
+	regmap_write(dphy->regs, SUN6I_DPHY_TX_TIME4_REG,
+		     SUN6I_DPHY_TX_TIME4_HS_TX_ANA0(3) |
+		     SUN6I_DPHY_TX_TIME4_HS_TX_ANA1(3));
+
+	dphy->variant->tx_power_on(dphy);
 
 	regmap_update_bits(dphy->regs, SUN6I_DPHY_ANA3_REG,
 			   SUN6I_DPHY_ANA3_EN_VTTC |
@@ -469,6 +479,7 @@ static int sun6i_dphy_probe(struct platform_device *pdev)
 }
 
 static const struct sun6i_dphy_variant sun6i_a31_mipi_dphy_variant = {
+	.tx_power_on	= sun6i_a31_mipi_dphy_tx_power_on,
 	.supports_rx	= true,
 };
 
-- 
2.35.1

