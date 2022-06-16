Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFE6D54DA48
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 08:10:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359033AbiFPGJh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 02:09:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359006AbiFPGJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 02:09:30 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABB6D29828;
        Wed, 15 Jun 2022 23:09:24 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 5D4403200B93;
        Thu, 16 Jun 2022 02:09:23 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 16 Jun 2022 02:09:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1655359762; x=1655446162; bh=vz
        nRDmlsb3zTjKCOceYDuGVn1WQxrFjMwm/ALiW9ePA=; b=rl3sp9hOPvz3C0ndZ3
        irR9rMiB3QyZTl6B946b3+/YWwGZ745+V1mqz03/xBpAHVG/Mlzfu851c1dHsxIP
        G0WQYWX/p/DHMLuqJOVTnv4DImaF4ULRHSDcEb2FRxtG5JAVZeL6PGvqSvj2dmbX
        8W6YVuFf3FIOgD6IHjQP37d7mXsI2AgBpyE5lJOfyDoNk/dWrSaZdn6z2PAfSIAg
        udgtBYIYKH8JuwIRT/lAkterwehK5XTUj/4jX9omUIwS8iv9KyC0g/WP0ymeoclb
        frL6Fk+tGZTrtC1SAbana69rGtVbwheyOkbv5cCx5j4JwVIPwhT2VVQRJNVS9KLz
        COQA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1655359762; x=1655446162; bh=vznRDmlsb3zTj
        KCOceYDuGVn1WQxrFjMwm/ALiW9ePA=; b=Nb1jXD3F9NeGHW5HGa4/oKlcmvWrh
        NWPE34E2kZnZs9udAcvthSA2sqHECfO8+7kyGxwQuj4cjWoQr6WW50nG22/QZ3gC
        258gq4pBWvRnsNlswadBdYyYTX1dpaxO7vx3Dtx++w8P3RwzDKLA1ux/sZ2bWehJ
        5RutMocfm6DU+etmUjLSTqojVUAguoW5jSjoi5qv5cx47hlQagxNCv5MXLjxBJ5l
        u5nlxX4IAXw5saf9WGDchm/fdygJYypLuapacdAr5kdt3VuBjIdfGBAeUppb27jk
        TBmFlX6giBYhwLIbwH9pB8RFl/85nQeP9ms6/uQMo+/g9/sPCTYFzUL2A==
X-ME-Sender: <xms:EsmqYgFgluQEI6K_D0AyCDSZjSfYLIzUMCrc5GPeJ6gk8LqtEGw80A>
    <xme:EsmqYpXiKRUKZBUpKonJhx2JrQWHR1boA9HHvlaY8g01P15SMq0hiHt-O1LpF8bTE
    DS-UHAyCOaKkf9isg>
X-ME-Received: <xmr:EsmqYqKvI7POzX8zvjU2m2FOF-1oPd4woyiexcLkh0r9h1LN1ifIsRWdOEYxIWau37coUxoeUya-KtwyB5R1FuWzcRJGgG4aa7xgtnlilmHqF3rku6wzaEo_qfy_hQ1i8mqMDQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedruddvvddguddtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghm
    uhgvlhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenuc
    ggtffrrghtthgvrhhnpedukeetueduhedtleetvefguddvvdejhfefudelgfduveeggeeh
    gfdufeeitdevteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:EsmqYiHAOADJRDGLatb0sJ45ufflsCfts-bPEsQlgicKUXIzfDMqRA>
    <xmx:EsmqYmU4dw2c72eDifJN-Ydnmyyp7W9KVjbXBWca5mbt9JfIY98Dig>
    <xmx:EsmqYlNdcOwfw_nJafFpMYAg4gHYjlmpdLvKZU6HyzFEp8FJoOrFnA>
    <xmx:EsmqYqrEhVD46On-txYs8tcvDQkRBKjk19A3_q4cPPgo3jTAFxXLIg>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Jun 2022 02:09:21 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Chen-Yu Tsai <wens@csie.org>, Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Samuel Holland <samuel@sholland.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] mfd: axp20x: Add AXP221/AXP223/AXP809 GPIO cells
Date:   Thu, 16 Jun 2022 01:09:13 -0500
Message-Id: <20220616060915.48325-3-samuel@sholland.org>
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

These PMICs all contain a compatible GPIO controller.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

 drivers/mfd/axp20x.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
index 8161a5dc68e8..88a212a8168c 100644
--- a/drivers/mfd/axp20x.c
+++ b/drivers/mfd/axp20x.c
@@ -619,6 +619,9 @@ static const struct mfd_cell axp20x_cells[] = {
 
 static const struct mfd_cell axp221_cells[] = {
 	{
+		.name		= "axp20x-gpio",
+		.of_compatible	= "x-powers,axp221-gpio",
+	}, {
 		.name		= "axp221-pek",
 		.num_resources	= ARRAY_SIZE(axp22x_pek_resources),
 		.resources	= axp22x_pek_resources,
@@ -645,6 +648,9 @@ static const struct mfd_cell axp221_cells[] = {
 
 static const struct mfd_cell axp223_cells[] = {
 	{
+		.name		= "axp20x-gpio",
+		.of_compatible	= "x-powers,axp221-gpio",
+	}, {
 		.name		= "axp221-pek",
 		.num_resources	= ARRAY_SIZE(axp22x_pek_resources),
 		.resources	= axp22x_pek_resources,
@@ -785,6 +791,9 @@ static const struct mfd_cell axp806_cells[] = {
 
 static const struct mfd_cell axp809_cells[] = {
 	{
+		.name		= "axp20x-gpio",
+		.of_compatible	= "x-powers,axp221-gpio",
+	}, {
 		.name		= "axp221-pek",
 		.num_resources	= ARRAY_SIZE(axp809_pek_resources),
 		.resources	= axp809_pek_resources,
-- 
2.35.1

