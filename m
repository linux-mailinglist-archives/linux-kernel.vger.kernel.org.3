Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F45454DA46
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 08:10:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359072AbiFPGJo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 02:09:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359012AbiFPGJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 02:09:30 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24CE22AE31;
        Wed, 15 Jun 2022 23:09:27 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id C96123200B89;
        Thu, 16 Jun 2022 02:09:25 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 16 Jun 2022 02:09:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1655359765; x=1655446165; bh=Wp
        QPo7pmmXPFcZpqgi6pg7aulqg71qCMS9O5OKvOTSk=; b=hS+NI950tjavec7au1
        N80n1ca/2Df1cwURXnMmf7XrhK4fj6OOCfjbQGonlc1TwJcvlLc6yrN7hoJoOTDj
        Brd7cyhTjN/W6Lf/MdcsoyZ4Y8736RSu3NKwSivwT+xrecdpIlCLZEh0CEzF+gEv
        iiIeDdwSLZPj1KzQuayba54kIlYRhe9GkpkwT5LhEH6IuzGk3XzguIqtOvW6EMT3
        F7JN9MsiuIGFiC4A7EHk/5YLGRt6/uF6bNr5Aq/xQDzvacW0hif7VbZwljfe46cj
        0ecAlkptb1caxVOk11NMbclSiYggVjKJU+njJXfM+X5Y2AU6yy3Ho+Q3VgCUvnIO
        jUew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1655359765; x=1655446165; bh=WpQPo7pmmXPFc
        Zpqgi6pg7aulqg71qCMS9O5OKvOTSk=; b=PMBetWNY7VysMfnpxryA7xrX9WfsB
        I/NTr2kARcBi0Z3yzmI1P2K8cTy4/iP/W7OwafshuDsug/j004N+++53SZ1zL5Ue
        0UEjLXmm3UfqrGeHHr7U67ME8Njt902hAOXjv5EJkvpHxYUREcaLnw1CS9llGR5b
        jT9ho3d6QzNYFtY+jUyYlP+xGJ4AUsDq9XJStYbeECeKTG8knmSrNjE+rgVPxw6t
        IRVrW8c6yflUl7/CbkM+iVewcCfUu6OBGjP3/bFqEwOlQST8/2XSEgy1Kc7gFpcD
        HFRy91KmzovxsHmeKzN8YzbxjxhfisoVYIrBWnK1ugFgd98cMLm/ekzHw==
X-ME-Sender: <xms:FcmqYpoBHtQPo0bZEmd3tFPLHEDNcApBFxxOilkh14qT6akpi5rDeA>
    <xme:FcmqYromJZRr9J2KW9Ga_l-V4xeT8z-FSmVENk3SY3iFNViyTdBNMq8R5FdHt21xy
    B5DQ2pP5XdyqgLzxQ>
X-ME-Received: <xmr:FcmqYmPxdGu-4BCgnOLD08S6PMszxm5GYiGCp0UKaHs1wKIoI2JFDa_BVYRwSuCO98N2ZsOX5d6YB0h0LXshklr5Sv8IGFVY8cJHLcRg3ART-4_GeWClR1j9UfXRePkV89T0kQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedruddvvddguddtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghm
    uhgvlhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenuc
    ggtffrrghtthgvrhhnpedukeetueduhedtleetvefguddvvdejhfefudelgfduveeggeeh
    gfdufeeitdevteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:FcmqYk4l0XcO7PrDQ3toTSAw2z8pX_X7rr1_K-t6li6O-dSl6fhyCQ>
    <xmx:FcmqYo66vC86p4IdN-dz2SL9RmqFOMISCUVpHulin5gDwuMDKvt0iw>
    <xmx:FcmqYsiexYKtZkD17ZprJAiht7zw8-ytjUBaQ20jyk-bTiSm7yFKXA>
    <xmx:FcmqYqv4HutdvmeQ0CSD_DRK6DLlmQ7ID1V6CFS9dGmFZi7xlQhHyw>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Jun 2022 02:09:24 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Chen-Yu Tsai <wens@csie.org>, Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Samuel Holland <samuel@sholland.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] pinctrl: axp209: Support the AXP221/AXP223/AXP809 variant
Date:   Thu, 16 Jun 2022 01:09:14 -0500
Message-Id: <20220616060915.48325-4-samuel@sholland.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220616060915.48325-1-samuel@sholland.org>
References: <20220616060915.48325-1-samuel@sholland.org>
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

These PMICs each have 2 GPIOs with the same register layout as AXP813,
but without an ADC function. They all fall back to the AXP221 compatible
string, so only that one needs to be listed in the driver.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

 drivers/pinctrl/pinctrl-axp209.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-axp209.c b/drivers/pinctrl/pinctrl-axp209.c
index 207cbae3a7bf..7ab20ac15391 100644
--- a/drivers/pinctrl/pinctrl-axp209.c
+++ b/drivers/pinctrl/pinctrl-axp209.c
@@ -73,7 +73,7 @@ static const struct pinctrl_pin_desc axp209_pins[] = {
 	PINCTRL_PIN(2, "GPIO2"),
 };
 
-static const struct pinctrl_pin_desc axp813_pins[] = {
+static const struct pinctrl_pin_desc axp22x_pins[] = {
 	PINCTRL_PIN(0, "GPIO0"),
 	PINCTRL_PIN(1, "GPIO1"),
 };
@@ -87,9 +87,16 @@ static const struct axp20x_pctrl_desc axp20x_data = {
 	.adc_mux = AXP20X_MUX_ADC,
 };
 
+static const struct axp20x_pctrl_desc axp22x_data = {
+	.pins	= axp22x_pins,
+	.npins	= ARRAY_SIZE(axp22x_pins),
+	.ldo_mask = BIT(0) | BIT(1),
+	.gpio_status_offset = 0,
+};
+
 static const struct axp20x_pctrl_desc axp813_data = {
-	.pins	= axp813_pins,
-	.npins	= ARRAY_SIZE(axp813_pins),
+	.pins	= axp22x_pins,
+	.npins	= ARRAY_SIZE(axp22x_pins),
 	.ldo_mask = BIT(0) | BIT(1),
 	.adc_mask = BIT(0),
 	.gpio_status_offset = 0,
@@ -388,6 +395,7 @@ static int axp20x_build_funcs_groups(struct platform_device *pdev)
 
 static const struct of_device_id axp20x_pctl_match[] = {
 	{ .compatible = "x-powers,axp209-gpio", .data = &axp20x_data, },
+	{ .compatible = "x-powers,axp221-gpio", .data = &axp22x_data, },
 	{ .compatible = "x-powers,axp813-gpio", .data = &axp813_data, },
 	{ }
 };
-- 
2.35.1

