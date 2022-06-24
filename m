Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C092A55A49E
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 01:06:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231690AbiFXXDj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 19:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiFXXDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 19:03:35 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14F3481C42
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 16:03:33 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id h23so7480961ejj.12
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 16:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l2qHBG28ZF/0BqgZtfUZ2wwyoD54f6fad9bi6YF6qP8=;
        b=j/EW46XmjD1+C0Yl6GvfN54Mr4rCGg3DSTzJVutybtOCGMpbiPDgpjSmgRtp4m7BhK
         2MJqzuxyPnRgQOxcKMKHAdbP3tqnV8FO4LXhhiX09+bBNGNzG8UPgZTWO2VNoLINPAWR
         OpFWNFQYe26IW2MmoNCLrjtfzTfNq8GTKlREQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l2qHBG28ZF/0BqgZtfUZ2wwyoD54f6fad9bi6YF6qP8=;
        b=PSyPNXC268O9mbmhtg+BuCstlzDZo1zgUlC9uHaNVZ300AfmEBQ8UormUEAcFg8N4U
         hlZIgoJTG7wAD3RR/IFGOoX6LiKcVXJXTL/RglohrUWE8MhKDHu6FW/SFWpeVWIVDHam
         EJjgjeZJjzuhXRgpBbVNiIRBpU04qdcW95Cb/cswFa5Yv+lBQT73Yx25/AV9y9bosckt
         VvVXD6MqPy2i8JYYMcijxtZAKrSQUh1eaYHlUezLofIzZ9p+4yVpi90ZMgZPTF6PW2qz
         sJeyhNs6xGdqODriTAur3hoW2dd78PWZ+pEL8b40l2+CDmbledL+BwQnVZGYtf3cOM6Z
         mFCA==
X-Gm-Message-State: AJIora8CQbzHA3EX20jl3G5ak/V8I8zGFywVh/3aGYt4q5Ook5a39C+e
        bB78/nbD87tHHl4weCLzyisNiA==
X-Google-Smtp-Source: AGRyM1ukJ4p7wfz/NeE9J04z4qMVxbrWxclP3ijoDLcfvuhGxZjXeTvHu2Tw7Q8EBQhsQ6OoDLm9eA==
X-Received: by 2002:a17:906:e104:b0:711:d510:54ca with SMTP id gj4-20020a170906e10400b00711d51054camr1320076ejb.342.1656111812463;
        Fri, 24 Jun 2022 16:03:32 -0700 (PDT)
Received: from tom-ThinkPad-T14s-Gen-2i.station (net-188-217-58-216.cust.vodafonedsl.it. [188.217.58.216])
        by smtp.gmail.com with ESMTPSA id w1-20020aa7da41000000b004356a647d08sm2880291eds.94.2022.06.24.16.03.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jun 2022 16:03:32 -0700 (PDT)
From:   Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
Cc:     linuxfancy@googlegroups.com, linux-amarula@amarulasolutions.com,
        quentin.schulz@theobroma-systems.com,
        Tommaso Merciai <tommaso.merciai@amarulasolutions.com>,
        Daniel Scally <djrscally@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/7] media: ov5693: rename clk into xvclk
Date:   Sat, 25 Jun 2022 01:03:03 +0200
Message-Id: <20220624230307.3066530-4-tommaso.merciai@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220624230307.3066530-1-tommaso.merciai@amarulasolutions.com>
References: <20220624230307.3066530-1-tommaso.merciai@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename clk pdata pointer into xvclk (system clock input).
Same for clk_rate into xvclk_rate. This is more explicit

Signed-off-by: Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
---
 drivers/media/i2c/ov5693.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/media/i2c/ov5693.c b/drivers/media/i2c/ov5693.c
index 9e84468d920e..d2adc5513a21 100644
--- a/drivers/media/i2c/ov5693.c
+++ b/drivers/media/i2c/ov5693.c
@@ -157,7 +157,7 @@ struct ov5693_device {
 	struct gpio_desc *reset;
 	struct gpio_desc *powerdown;
 	struct regulator_bulk_data supplies[OV5693_NUM_SUPPLIES];
-	struct clk *clk;
+	struct clk *xvclk;
 
 	struct ov5693_mode {
 		struct v4l2_rect crop;
@@ -794,7 +794,7 @@ static void ov5693_sensor_powerdown(struct ov5693_device *ov5693)
 
 	regulator_bulk_disable(OV5693_NUM_SUPPLIES, ov5693->supplies);
 
-	clk_disable_unprepare(ov5693->clk);
+	clk_disable_unprepare(ov5693->xvclk);
 }
 
 static int ov5693_sensor_powerup(struct ov5693_device *ov5693)
@@ -804,7 +804,7 @@ static int ov5693_sensor_powerup(struct ov5693_device *ov5693)
 	gpiod_set_value_cansleep(ov5693->reset, 1);
 	gpiod_set_value_cansleep(ov5693->powerdown, 1);
 
-	ret = clk_prepare_enable(ov5693->clk);
+	ret = clk_prepare_enable(ov5693->xvclk);
 	if (ret) {
 		dev_err(ov5693->dev, "Failed to enable clk\n");
 		goto fail_power;
@@ -1390,7 +1390,7 @@ static int ov5693_check_hwcfg(struct ov5693_device *ov5693)
 static int ov5693_probe(struct i2c_client *client)
 {
 	struct ov5693_device *ov5693;
-	u32 clk_rate;
+	u32 xvclk_rate;
 	int ret = 0;
 
 	ov5693 = devm_kzalloc(&client->dev, sizeof(*ov5693), GFP_KERNEL);
@@ -1408,16 +1408,16 @@ static int ov5693_probe(struct i2c_client *client)
 
 	v4l2_i2c_subdev_init(&ov5693->sd, client, &ov5693_ops);
 
-	ov5693->clk = devm_clk_get(&client->dev, "xvclk");
-	if (IS_ERR(ov5693->clk)) {
+	ov5693->xvclk = devm_clk_get(&client->dev, "xvclk");
+	if (IS_ERR(ov5693->xvclk)) {
 		dev_err(&client->dev, "Error getting clock\n");
-		return PTR_ERR(ov5693->clk);
+		return PTR_ERR(ov5693->xvclk);
 	}
 
-	clk_rate = clk_get_rate(ov5693->clk);
-	if (clk_rate != OV5693_XVCLK_FREQ)
+	xvclk_rate = clk_get_rate(ov5693->xvclk);
+	if (xvclk_rate != OV5693_XVCLK_FREQ)
 		dev_warn(&client->dev, "Found clk freq %u, expected %u\n",
-			 clk_rate, OV5693_XVCLK_FREQ);
+			 xvclk_rate, OV5693_XVCLK_FREQ);
 
 	ret = ov5693_configure_gpios(ov5693);
 	if (ret)
-- 
2.25.1

