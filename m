Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A46E4534907
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 04:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235527AbiEZCuO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 22:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238727AbiEZCuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 22:50:04 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33695A5010;
        Wed, 25 May 2022 19:50:02 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 142A15C01B1;
        Wed, 25 May 2022 22:49:59 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 25 May 2022 22:49:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm2; t=1653533399; x=1653619799; bh=5VTPfSq+6dr6vtXo0jyg38don
        JGkVsKzqsztDQHGzjw=; b=Mrr/SFuQZ1XxWgnPo9PO7kyvhM1r1PzO7m93WoOxo
        b/2PDwPMf75B4DDEgRfdb1NSo5A1B24XTyK3/Am2cTj/tNwdTw/2Drf1hGLWiO5l
        THRrQaEgIfDDdeDbLmYKzKb5D/55uHd1Q6o0SEOav6WaHj6dA+PpEUcMJlmSRTfg
        hzkT6pptor/KlqJZ+LH+Nnmqe5XHxxpw/PjMfxnaX5Gzvs+hy/L1RthQ8+66K31z
        GI4Dst3B4Snqa00UIFa82rkmjNuPNcvqtT5g+WjvjKnfrRv1ZOyzeDtVYUSwDfVV
        gaxhKhq2NYCJlcQLmHdZOSFxlkqLt6weM1kKJRXqN/Gmg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1653533399; x=1653619799; bh=5VTPfSq+6dr6vtXo0jyg38donJGkVsKzqsz
        tDQHGzjw=; b=Ps3CyIlDFtDkw37yt1d3zk/LMy4u53bbvg+wstLu2pTumVSAEs3
        0HerXNLmGXAIMmKaAvrPHQ1F31DgyKDrBQuMc0hSY496VuMPAG114cKq8sHrDzge
        UIzIknqdKDpIcICs2TgDR2VKAXvA9vHGAYrrc+vQhbJHi5iKT1VFCD7T+oN/PaCB
        ia5+OvXdJ8/8TRK4xGey5ZYvKSudbw2YU/w7tAXfL0n4svrr5MbAowCYivp3sw48
        FaWHXyANDe76nqvrosdxp5vHyI8Kkd3wESO+vs1FfBqpaA28yPHfaCSnND+xfLQo
        y/uVjRi7hj7Dwuo80o5o4zJTgA6auuiEzwg==
X-ME-Sender: <xms:1uqOYhexe3opPnjvgeZR6cFjAH0B06BSPlZaKThCm9PR-ErvmmhzGA>
    <xme:1uqOYvMs78L3hwf1wkjcphpOeUO3b78aWNEHgf3rB0LXNEnVXcyyg6mfq4WsoTeV9
    4maBxJaMCZFZosAog>
X-ME-Received: <xmr:1uqOYqjNnAOwhdAaWT4P-WGvoA1hcYj1z-SCLoVY_8OLMZq0TrD_-l8OOGH_OS5NLT7kKq_zDpV0z4_6nDqHTLadSNgUmbkd5o4vzN7pfy3YluqFDtZybbs3mR7kvXVld7n6qw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrjeeigdeifecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgvlhcu
    jfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtffrrg
    htthgvrhhnpeekveelhfejueelleetvdejvdeffeetgeelheeujeffhefgffefkeehhffh
    keekgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:1uqOYq_sS_beVBUrf94di_0cdKoia-JUeCXzQOqO79uPleNtjqfKAA>
    <xmx:1uqOYtvEkETeyvM4u-iInCFZUAqq5-b_0HWOrmJP9U_VtjTLXb_VFg>
    <xmx:1uqOYpEvSyd6vdJwJIubcML12grvRusN22oNHQgZqSy3y3sFKnIgsw>
    <xmx:1-qOYjBwOowl52MuTwVUpTbH4ePZWLpg6kBs1kKV902zBSFB4mWkNg>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 May 2022 22:49:57 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     Samuel Holland <samuel@sholland.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Maxime Ripard <mripard@kernel.org>,
        Vishnu Patekar <vishnupatekar0510@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev
Subject: [PATCH] pinctrl: sunxi: a83t: Fix NAND function name for some pins
Date:   Wed, 25 May 2022 21:49:56 -0500
Message-Id: <20220526024956.49500-1-samuel@sholland.org>
X-Mailer: git-send-email 2.35.1
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

The other NAND pins on Port C use the "nand0" function name.
"nand0" also matches all of the other Allwinner SoCs.

Fixes: 4730f33f0d82 ("pinctrl: sunxi: add allwinner A83T PIO controller support")
Signed-off-by: Samuel Holland <samuel@sholland.org>
---

 drivers/pinctrl/sunxi/pinctrl-sun8i-a83t.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/pinctrl/sunxi/pinctrl-sun8i-a83t.c b/drivers/pinctrl/sunxi/pinctrl-sun8i-a83t.c
index 4ada80317a3b..b5c1a8f363f3 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sun8i-a83t.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sun8i-a83t.c
@@ -158,26 +158,26 @@ static const struct sunxi_desc_pin sun8i_a83t_pins[] = {
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 14),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
-		  SUNXI_FUNCTION(0x2, "nand"),		/* DQ6 */
+		  SUNXI_FUNCTION(0x2, "nand0"),		/* DQ6 */
 		  SUNXI_FUNCTION(0x3, "mmc2")),		/* D6 */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 15),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
-		  SUNXI_FUNCTION(0x2, "nand"),		/* DQ7 */
+		  SUNXI_FUNCTION(0x2, "nand0"),		/* DQ7 */
 		  SUNXI_FUNCTION(0x3, "mmc2")),		/* D7 */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 16),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
-		  SUNXI_FUNCTION(0x2, "nand"),		/* DQS */
+		  SUNXI_FUNCTION(0x2, "nand0"),		/* DQS */
 		  SUNXI_FUNCTION(0x3, "mmc2")),		/* RST */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 17),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
-		  SUNXI_FUNCTION(0x2, "nand")),		/* CE2 */
+		  SUNXI_FUNCTION(0x2, "nand0")),	/* CE2 */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 18),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
-		  SUNXI_FUNCTION(0x2, "nand")),		/* CE3 */
+		  SUNXI_FUNCTION(0x2, "nand0")),	/* CE3 */
 	/* Hole */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 2),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
-- 
2.35.1

