Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 169225925CF
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 19:37:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238927AbiHNRhM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 13:37:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231265AbiHNRhG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 13:37:06 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D828615707;
        Sun, 14 Aug 2022 10:37:05 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 70FCE32005C1;
        Sun, 14 Aug 2022 13:37:04 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Sun, 14 Aug 2022 13:37:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1660498623; x=1660585023; bh=gG
        x++uZuYm9XsKFB3DjNDrE1NoVs5U98OkdD7W5x8KI=; b=TXSiHVaHjWlzDn7Dba
        Q0U+q/3VvyRrEjwnG6dDFJWC7sUGuJTfECfoGWvBUZK53G3KfIoZ8hpQjHSr/XiA
        JYjL1raULlivYsXrWKQMU5UCoa7Z6Zb1L47ekh3XeQVcsmzCEIZIwbzDjlYT6apu
        DGfkl0adKhPokuznlLmploSAtmOmlTcjs31IrBrlphib0aFMMdkztRAz1oT/eey1
        ALZtoTsFwzVGbh/ZzLIt6MlGd8nWe6Y01vBbOnptAqJndh95ApCSK70qAVD0v5v9
        fMibfSdyAxpAVPf8tgjZ8FrQbS/ruClPd0W/geHCliMv9MOJww20uw5WbxU/N9sO
        wfew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1660498623; x=1660585023; bh=gGx++uZuYm9Xs
        KFB3DjNDrE1NoVs5U98OkdD7W5x8KI=; b=W6rsmJyKK7y56esvwejcSYSb47CsW
        1IMMWbixKYVu5+UyPfIU3p8RTb/VQc/8aMoSyTX3J0cpp5Igw2bsv0Ded00pjT5k
        /7g56ltLGRRCKZXHX0Ab9RkTF+wKSBteBtC3Rdq79bB5V+HcdAMApSrcHC3nPJ5I
        nAlCIzuBCbvY77N+s+oYxhoP3cW8A5Flo3v9so53xk9/kj+rgVUnYNjYQ/NmPE1a
        0YRevuKxczzE2B2ta8BeRhVUPRWa/A8i/nIMZC8VWLKIujV5DgaS4eoYq1iHJaOK
        fkP4EP3H9YqI93mWOAmTEUZ0IVxo+RodIWbdJy0+eY5IehY48vLoruw1g==
X-ME-Sender: <xms:vzL5Yob8aki7An9kzzIV1U9fXQ-iN2iak3VobTHW5zYMUl7XBoUMOA>
    <xme:vzL5YjYF7DufidY6hUWm32qREg0vdiEG2pcrAG-ogY562CCogGrP2-vTdSWDWzHji
    nu63_xtVW7qViE_zA>
X-ME-Received: <xmr:vzL5Yi8UVSlrgT3xYh6-yCvutFiXlhp_YZ259Mhc_HCfFM9Xs1_YsR0QbyYiVkZfuXv3bzCbHK-QcoyjSpdJtQdPz2SYHJOC5mFF8FLhSvLR-7nRH658g8Cmg0LB_7nBTk9Lsw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdehtddgudduiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghm
    uhgvlhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenuc
    ggtffrrghtthgvrhhnpedukeetueduhedtleetvefguddvvdejhfefudelgfduveeggeeh
    gfdufeeitdevteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:vzL5Yio-k6vIt4SAlMUq-O7FlhCGkbMcJVV0mCBZVwP08dBX0jY3mg>
    <xmx:vzL5Yjr4hk4ekLQHpYOAWof4W3WUgVXz-AYPC7-DX8b0LnNM7aq5xA>
    <xmx:vzL5YgRp2lQkklNUMdsAByYqIT4Oj7VmCK-gl-cLW2o7TAOMxQK1OA>
    <xmx:vzL5Ym09_L5LXsMoguQgb9sOa2jjN6XKht4J2S0ihxyTn0bYXNikbw>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 14 Aug 2022 13:37:03 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     Samuel Holland <samuel@sholland.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev
Subject: [PATCH 2/4] nvmem: sunxi_sid: Drop the workaround on A64
Date:   Sun, 14 Aug 2022 12:36:53 -0500
Message-Id: <20220814173656.11856-3-samuel@sholland.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220814173656.11856-1-samuel@sholland.org>
References: <20220814173656.11856-1-samuel@sholland.org>
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

Now that the SRAM readout code is fixed by using 32-bit accesses, it
always returns the same values as register readout, so the A64 variant
no longer needs the workaround. This makes the D1 variant structure
redundant, so remove it.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

 drivers/nvmem/sunxi_sid.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/nvmem/sunxi_sid.c b/drivers/nvmem/sunxi_sid.c
index 92dfe4cb10e3..a970f1741cc6 100644
--- a/drivers/nvmem/sunxi_sid.c
+++ b/drivers/nvmem/sunxi_sid.c
@@ -197,15 +197,9 @@ static const struct sunxi_sid_cfg sun8i_h3_cfg = {
 	.need_register_readout = true,
 };
 
-static const struct sunxi_sid_cfg sun20i_d1_cfg = {
-	.value_offset = 0x200,
-	.size = 0x100,
-};
-
 static const struct sunxi_sid_cfg sun50i_a64_cfg = {
 	.value_offset = 0x200,
 	.size = 0x100,
-	.need_register_readout = true,
 };
 
 static const struct sunxi_sid_cfg sun50i_h6_cfg = {
@@ -218,7 +212,7 @@ static const struct of_device_id sunxi_sid_of_match[] = {
 	{ .compatible = "allwinner,sun7i-a20-sid", .data = &sun7i_a20_cfg },
 	{ .compatible = "allwinner,sun8i-a83t-sid", .data = &sun50i_a64_cfg },
 	{ .compatible = "allwinner,sun8i-h3-sid", .data = &sun8i_h3_cfg },
-	{ .compatible = "allwinner,sun20i-d1-sid", .data = &sun20i_d1_cfg },
+	{ .compatible = "allwinner,sun20i-d1-sid", .data = &sun50i_a64_cfg },
 	{ .compatible = "allwinner,sun50i-a64-sid", .data = &sun50i_a64_cfg },
 	{ .compatible = "allwinner,sun50i-h5-sid", .data = &sun50i_a64_cfg },
 	{ .compatible = "allwinner,sun50i-h6-sid", .data = &sun50i_h6_cfg },
-- 
2.35.1

