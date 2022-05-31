Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7077538AD0
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 07:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243950AbiEaFRt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 01:17:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232815AbiEaFRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 01:17:47 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 442AE3F883;
        Mon, 30 May 2022 22:17:45 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 1AB5A320097D;
        Tue, 31 May 2022 01:17:44 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 31 May 2022 01:17:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm2; t=1653974263; x=1654060663; bh=OgiPG+U4zIk0Jt48BHpc6497A
        JSnBBy/ITnA0OSv0KQ=; b=jDNq31pf9JIwx/Ez6zeDEd6l20nYTE6tSmtAofj1t
        ADUnPrKV8D8lHH3BcPQonnGR/XoKWk5OCtvCPgBNIFDlKm3dBgW4xDLiGwbj5xJN
        ZIOXrQOwDLeXgKu4pmRthvYBix6BtNJDDXLAxxdobv4BBReLvkNqpgna1XOW8JSM
        pNq8ujWqSyJyNorSxT/XXbHMEJfM/0w1qWgoak+o8du0bTYyC/1pXFyE6fU6m+50
        lI1h6aJtX+STtvJNaDJPwbN/TOhg7z38gnSJJdo5jMpvWPIo6H9Y2DrQcyIjtL7P
        l9feJT/xmylLE1Z4Bwu8KJO8TGbnxkkVz6xk1tU/oZe+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1653974263; x=1654060663; bh=OgiPG+U4zIk0Jt48BHpc6497AJSnBBy/ITn
        A0OSv0KQ=; b=dT9ynzy/BYuC0zOib12EdO8r4BqtZJobMQ4cONDsCd6uGw99ifF
        x7QKwhG4cSCPdxJonQWO5ylhNVPkcJv6tTJfemrZsb70NexpauR0E8gJ8onbyb8K
        uJa+jyX1oaT8Hcucv1TIfoJiWwSuFZQrpbXZEln25jpl/kgC45HjPP8Qj+jDrdBR
        XKJ7XXB7073TdtkC6AQbdrpwzdn1Cql6EqMWqnx4Nm4avuJ5rIlW7NwLU2Q94+oj
        nrLi2C5z+NDiryQRZfF5VN/IE7Ts2IIc09BOKpqRTAqOE4lCjbTPRmQvHw2yjaAS
        UwML7H84QbvPff/pcBK5muWazR2ZYNX//rw==
X-ME-Sender: <xms:96SVYgtKivYJLh9pMTrx40QVlQODfgIW1gluYAaJlYZMjWdBQg4d5w>
    <xme:96SVYteEgUsqMCPZ0j1YmDZfZ_OquFoI3A2dfdmRLwHEfZ8j_YmMiK7GDwgG5J-af
    De5LpdvLrKmyHcGSw>
X-ME-Received: <xmr:96SVYrwRE2PujhLFzvIv8Owkw3hydR6ka2_UGc-XUmGJ1zQ3rtmE3Z-HDRW7GaH1aykQw90UopOlAVANUgrGG3rrRqOnTFpQo0tGqqGoIdkHj_BwLCW7l2oRwHFKrkJ3qrkQEA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrkeejgdelfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgvlhcu
    jfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtffrrg
    htthgvrhhnpeekveelhfejueelleetvdejvdeffeetgeelheeujeffhefgffefkeehhffh
    keekgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:96SVYjPhQPeP9oJOpmXjJnNrVNoyRuWzeCUe7LRS7zMF2hVd_1cPWw>
    <xmx:96SVYg95O6KP980BF6aF0FxkoBH91iljRnlCeUSKUTW0A22byWnrKQ>
    <xmx:96SVYrWh0J5uUvbNMQ1vrk6MM69cgOgCcN75ke1ZTruYTAYJyxv3iw>
    <xmx:96SVYgxIGgbFC3NQXgE6kG2iJdCHJWw-jumdKCkcYvJeoq2Oz-_OjQ>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 31 May 2022 01:17:42 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Jernej Skrabec <jernej.skrabec@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <mripard@kernel.org>,
        Samuel Holland <samuel@sholland.org>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] clk: fixed: Remove Allwinner A10 special-case logic
Date:   Tue, 31 May 2022 00:17:41 -0500
Message-Id: <20220531051742.43273-1-samuel@sholland.org>
X-Mailer: git-send-email 2.35.1
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

This compatible is part of the legacy sunxi clock support, and has not
been used since commit 6b48644b1d29 ("ARM: gr8: Convert to CCU") in
October 2016. Since supporting this compatible adds some overhead to
generic clock code, let's clean it up.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

 drivers/clk/clk-fixed-factor.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/clk/clk-fixed-factor.c b/drivers/clk/clk-fixed-factor.c
index 54942d758ee6..e6b36247c16b 100644
--- a/drivers/clk/clk-fixed-factor.c
+++ b/drivers/clk/clk-fixed-factor.c
@@ -210,16 +210,10 @@ struct clk_hw *devm_clk_hw_register_fixed_factor(struct device *dev,
 EXPORT_SYMBOL_GPL(devm_clk_hw_register_fixed_factor);
 
 #ifdef CONFIG_OF
-static const struct of_device_id set_rate_parent_matches[] = {
-	{ .compatible = "allwinner,sun4i-a10-pll3-2x-clk" },
-	{ /* Sentinel */ },
-};
-
 static struct clk_hw *_of_fixed_factor_clk_setup(struct device_node *node)
 {
 	struct clk_hw *hw;
 	const char *clk_name = node->name;
-	unsigned long flags = 0;
 	u32 div, mult;
 	int ret;
 
@@ -237,11 +231,8 @@ static struct clk_hw *_of_fixed_factor_clk_setup(struct device_node *node)
 
 	of_property_read_string(node, "clock-output-names", &clk_name);
 
-	if (of_match_node(set_rate_parent_matches, node))
-		flags |= CLK_SET_RATE_PARENT;
-
 	hw = __clk_hw_register_fixed_factor(NULL, node, clk_name, NULL, 0,
-					    flags, mult, div, false);
+					    0, mult, div, false);
 	if (IS_ERR(hw)) {
 		/*
 		 * Clear OF_POPULATED flag so that clock registration can be
-- 
2.35.1

