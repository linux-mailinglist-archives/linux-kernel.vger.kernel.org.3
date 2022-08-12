Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E957590D09
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 09:56:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237214AbiHLH4d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 03:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237115AbiHLH4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 03:56:14 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67E0D9AFD2;
        Fri, 12 Aug 2022 00:56:13 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id CB7555C00E4;
        Fri, 12 Aug 2022 03:56:12 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Fri, 12 Aug 2022 03:56:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1660290972; x=1660377372; bh=88
        QB6K6RMHFX6L5k2LBFzL7b2vGRx9MIF2yOLaRtynY=; b=OpEpoz/HG/oBMRVUi9
        upByrHpG2nTvBLwTjd6i7AAOWmfij4vHaWBAERjj1I8Cobz0+vNvHu76kqq2a1g3
        a0ynv3j8t/m86Rh+FvF1aSr6nbx4PKCJIjSU1mFgB7khucoQk3H2gt6ulghw73NH
        bg9mTDdJ+WzXro/3pC3Pq+kQDKShLp9Kc65t6Fo5gS2ibdyQ/oex4O5+CILHQNII
        9nIR5kBTmYDjuj73xCSYPnl/4sbDtwBGVed/38k4u8kRWmdo7xGhDUiJR1OrftIY
        mi1j4k2b4VhvtF5vyElRrQoUktQRkAXI9UO24Ng7EC4slRqgwP9IlMI45JsTA2Wo
        Ehzw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1660290972; x=1660377372; bh=88QB6K6RMHFX6
        L5k2LBFzL7b2vGRx9MIF2yOLaRtynY=; b=jrb/CiVXpdw5Wdy2da5/yIPTvMoH2
        7rz4+UEJo7OIgy3Zlcfl4ikzTlcIhefpOUdfq4ztfHUgA9q1q7i3V5crBEc4na23
        6TVgnHMCnVlPsWa+kBn9CsP/6TvikDuQE0B1FGHQn0LON54FcEGy1zIwW0B5YTdt
        hOeaIm1kBvkGkc6VrfDdPLeqkz2zxk4RdXfUCPrM8R5utL6GQd8F4MMeGunu5rq/
        39kfQwI0+qKXw6IZCe0oVZFpiFytUs0cq5QYg1v94lgNGPwdvPZ+gFIOPRjsUz1F
        XBr5uFG0o/hwEbQuqQdiYTrwcRFGE6ELByJAICaTsyB63F9H2wk6Xh2bg==
X-ME-Sender: <xms:nAf2YgVoMZp4NEIOuwAOirA4Cwde2u61oX2GHqpBakwQtqxh9Ho4cQ>
    <xme:nAf2YknkD420v-siHqED5tfSbgUMHc8HEqcpxe2nqeF_nNHrYHcjZ-xIOophS5j-X
    V_kbI8d5ifJaMdtsA>
X-ME-Received: <xmr:nAf2YkYhig-9IgspZ5KxoUYXaJFfJ6kVGKjEzXSg9iqqYq2zV6KWCXZhUzSU_1n85ccBXGs-HwkNOLjI4vRjNKDYVe2nsZE0rFcM377f0HM4wfdTjLMHui7vai49mTMSCiWEYA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdeghedguddvjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghm
    uhgvlhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenuc
    ggtffrrghtthgvrhhnpedukeetueduhedtleetvefguddvvdejhfefudelgfduveeggeeh
    gfdufeeitdevteenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:nAf2YvV6IF0sxIx52qGkuhcmZ4OSO3v1Uf8t3LAc3pjkKkSkg-gHlw>
    <xmx:nAf2Yqk8bOGSGiF48zrglgr1DQ2ZU48gB4xb7AxmdLSVme2qQ35h-w>
    <xmx:nAf2YkdGSDRBCAaBpKL7UC3tOaQWu9vpjuIAvtjLIIZ5X2Ki0r_JWg>
    <xmx:nAf2Yv8KdMYKC1iONlV5XUL5Bxmlh78U8FxxD3IGtrSOV_dYr5mGFA>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 Aug 2022 03:56:11 -0400 (EDT)
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
Subject: [PATCH 6/8] phy: allwinner: phy-sun6i-mipi-dphy: Set enable bit last
Date:   Fri, 12 Aug 2022 02:56:01 -0500
Message-Id: <20220812075603.59375-7-samuel@sholland.org>
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

The A100 variant of the DPHY requires configuring the analog registers
before setting the global enable bit. Since this order also works on the
other variants, always use it, to minimize the differences between them.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

 drivers/phy/allwinner/phy-sun6i-mipi-dphy.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/phy/allwinner/phy-sun6i-mipi-dphy.c b/drivers/phy/allwinner/phy-sun6i-mipi-dphy.c
index 625c6e1e9990..9698d68d0db7 100644
--- a/drivers/phy/allwinner/phy-sun6i-mipi-dphy.c
+++ b/drivers/phy/allwinner/phy-sun6i-mipi-dphy.c
@@ -183,10 +183,6 @@ static int sun6i_dphy_tx_power_on(struct sun6i_dphy *dphy)
 		     SUN6I_DPHY_TX_TIME4_HS_TX_ANA0(3) |
 		     SUN6I_DPHY_TX_TIME4_HS_TX_ANA1(3));
 
-	regmap_write(dphy->regs, SUN6I_DPHY_GCTL_REG,
-		     SUN6I_DPHY_GCTL_LANE_NUM(dphy->config.lanes) |
-		     SUN6I_DPHY_GCTL_EN);
-
 	regmap_write(dphy->regs, SUN6I_DPHY_ANA0_REG,
 		     SUN6I_DPHY_ANA0_REG_PWS |
 		     SUN6I_DPHY_ANA0_REG_DMPC |
@@ -244,6 +240,10 @@ static int sun6i_dphy_tx_power_on(struct sun6i_dphy *dphy)
 			   SUN6I_DPHY_ANA2_EN_P2S_CPU_MASK,
 			   SUN6I_DPHY_ANA2_EN_P2S_CPU(lanes_mask));
 
+	regmap_write(dphy->regs, SUN6I_DPHY_GCTL_REG,
+		     SUN6I_DPHY_GCTL_LANE_NUM(dphy->config.lanes) |
+		     SUN6I_DPHY_GCTL_EN);
+
 	return 0;
 }
 
-- 
2.35.1

