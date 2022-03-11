Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51C114D6862
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 19:20:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350869AbiCKSVV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 13:21:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232361AbiCKSVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 13:21:19 -0500
Received: from smtp-out3.electric.net (smtp-out3.electric.net [208.70.128.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA12EADD44;
        Fri, 11 Mar 2022 10:20:13 -0800 (PST)
Received: from 1nSjs1-0006JP-VO by out3d.electric.net with emc1-ok (Exim 4.94.2)
        (envelope-from <kris@embeddedTS.com>)
        id 1nSjs3-0006N2-T2; Fri, 11 Mar 2022 10:20:11 -0800
Received: by emcmailer; Fri, 11 Mar 2022 10:20:10 -0800
Received: from [66.210.251.27] (helo=mail.embeddedts.com)
        by out3d.electric.net with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <kris@embeddedTS.com>)
        id 1nSjs1-0006JP-VO; Fri, 11 Mar 2022 10:20:09 -0800
Received: from tsdebian.Massive (unknown [75.164.75.221])
        by mail.embeddedts.com (Postfix) with ESMTPSA id F2ACF1CCE;
        Fri, 11 Mar 2022 11:20:08 -0700 (MST)
From:   Kris Bahnsen <kris@embeddedTS.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Kris Bahnsen <kris@embeddedTS.com>
Subject: [PATCH] gpio: ts4900: Fix comment formatting and grammar
Date:   Fri, 11 Mar 2022 10:19:58 -0800
Message-Id: <20220311181958.4487-1-kris@embeddedTS.com>
X-Mailer: git-send-email 2.11.0
X-Outbound-IP: 66.210.251.27
X-Env-From: kris@embeddedTS.com
X-Proto: esmtps
X-Revdns: wsip-66-210-251-27.ph.ph.cox.net
X-HELO: mail.embeddedts.com
X-TLS:  TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256
X-Authenticated_ID: 
X-Virus-Status: Scanned by VirusSMART (c)
X-Virus-Status: Scanned by VirusSMART (b)
X-FM-Delivery-Delay: 15749372,23518412
X-PolicySMART: 13164782, 15749372, 26810492
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=embeddedTS.com; s=mailanyone20220121;h=Message-Id:Date:To:From; bh=PZik48CDl4NTh8V8pU0BjeRE5OMY5u/gVavkDrajapo=;b=ElXUfmpRjmprbRp2GNubtyCNDvC/UvS300xvrbE2g6a8DNpQvuKunSMl25PIAmmkwv+cwU77BaTlKXeUb0L3XsY0wdFKGrz1qoHdn6ORdUmEXt55l+3HfO6hLv26iM41wVViLY7fl6uBkbJqiNHX2jANI4Rz8v9UXkscnYMNxLG/RFlZX+UuuE/CDLf1sTLZBf5MPRCUEotsVRBMh/LqZ6oKRnvFFaxNQ/IqxWP2/HsAYndtLxEvZbloFrcKOb2s/PllNN51fBEv43oY1yWWiaGoKz4Lk2khZIY6374oGt/8fG0Jf3nm/rtyfJGg6U68e9mo1Glsj3ne0lfrE01OkQ==;
X-FM-Delivery-Delay: 15749372,23518412
X-PolicySMART: 13164782, 15749372, 26810492
X-FM-Delivery-Delay: 15749372,23518412
X-PolicySMART: 13164782, 15749372, 26810492
X-FM-Delivery-Delay: 15749372,23518412
X-PolicySMART: 13164782, 15749372, 26810492
X-FM-Delivery-Delay: 15749372,23518412
X-PolicySMART: 13164782, 15749372, 26810492
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The issues were pointed out after the prior commit was applied

Signed-off-by: Kris Bahnsen <kris@embeddedTS.com>
---
 drivers/gpio/gpio-ts4900.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/gpio/gpio-ts4900.c b/drivers/gpio/gpio-ts4900.c
index d918d2df4de2..ede605b8e098 100644
--- a/drivers/gpio/gpio-ts4900.c
+++ b/drivers/gpio/gpio-ts4900.c
@@ -55,8 +55,9 @@ static int ts4900_gpio_direction_input(struct gpio_chip *chip,
 {
 	struct ts4900_gpio_priv *priv = gpiochip_get_data(chip);
 
-	/* Only clear the OE bit here, requires a RMW. Prevents potential issue
-	 * with OE and data getting to the physical pin at different times.
+	/*
+	 * Only clear the OE bit here, requires a RMW. Prevents a potential issue
+	 * with OE and DAT getting to the physical pin at different times.
 	 */
 	return regmap_update_bits(priv->regmap, offset, TS4900_GPIO_OE, 0);
 }
@@ -68,9 +69,10 @@ static int ts4900_gpio_direction_output(struct gpio_chip *chip,
 	unsigned int reg;
 	int ret;
 
-	/* If changing from an input to an output, we need to first set the
-	 * proper data bit to what is requested and then set OE bit. This
-	 * prevents a glitch that can occur on the IO line
+	/*
+	 * If changing from an input to an output, we need to first set the
+	 * GPIO's DAT bit to what is requested and then set the OE bit. This
+	 * prevents a glitch that can occur on the IO line.
 	 */
 	regmap_read(priv->regmap, offset, &reg);
 	if (!(reg & TS4900_GPIO_OE)) {
-- 
2.11.0

