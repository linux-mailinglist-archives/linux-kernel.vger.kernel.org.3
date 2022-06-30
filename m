Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A902A56137C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 09:46:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233204AbiF3Hpl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 03:45:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233161AbiF3Hpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 03:45:35 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B7EC3A71C
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 00:45:34 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id r18so17532761edb.9
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 00:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ctpa/T2vVk1WErHGmcuqVVZ1P5/ZM5PQkEWqW8vXr7A=;
        b=lRMEg3/FRguw5FwS8pKZMz//6FUb1bmUu/durvcaUXE93Uz6C54xek86KnAfW5U1ca
         ntiBw22+0Z9UspHk18n14P34zxpuhqERuCCMNUPyduCT9sOFyyb5SZGWpgBUMdk6gN5G
         V92UCxsO3NxQGZGqLelxE9MLKBOblUkvc5F3s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ctpa/T2vVk1WErHGmcuqVVZ1P5/ZM5PQkEWqW8vXr7A=;
        b=75XeTDbzbe/HAQcfrioozBNTBirTn/W7z4ee0GSthpS7l2zCH8IU7diqsYbjixZTLr
         KuSU4ca+YcCAy9l59N5UvDaji1Hfg5zQVVSUwTqEwTtNbOkcucT5ncaBQGFVeqcrQ0TB
         J1uBNn86hXhESK5WN62YF0nN+HhnNDclMjSKXI6hqb2RpDJb++b1fo+9XL5GVGmtpZuv
         /AUifqdlTmjThmYOkYuXxKnrtez1tlz/disJoetVFdSDmz4/bOKvaY4Yp4ob9Xg6dgIr
         M5YxiRGvyz7sPwE7EdW+nCEOSMD6s51rWxEr9zTlAoDuk3aYaTEPBybZ77CXv77aGWPj
         YdZA==
X-Gm-Message-State: AJIora9dBrLLDar0cI/EOz5g/DWq8vZiNKnJqYH0uwmib5nYXftXJpfi
        ZzEV2Fsb5rhJAaSEvK+AU8M+yw==
X-Google-Smtp-Source: AGRyM1uuAMkrYZQ8JChtMp+7GI/hYI16/CjCaUjNyphloY7yDvh7i21GX7ol110y4S0BSN6t6q1vHw==
X-Received: by 2002:a05:6402:2786:b0:435:da07:14cb with SMTP id b6-20020a056402278600b00435da0714cbmr9744966ede.408.1656575133094;
        Thu, 30 Jun 2022 00:45:33 -0700 (PDT)
Received: from tom-ThinkPad-T14s-Gen-2i.station (net-188-217-58-216.cust.vodafonedsl.it. [188.217.58.216])
        by smtp.gmail.com with ESMTPSA id b13-20020aa7c90d000000b0043564320274sm12594731edt.19.2022.06.30.00.45.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 00:45:32 -0700 (PDT)
From:   Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
To:     tommaso.merciai@amarulasolutions.com
Cc:     linuxfancy@googlegroups.com, linux-amarula@amarulasolutions.com,
        quentin.schulz@theobroma-systems.com,
        Jacopo Mondi <jacopo@jmondi.org>,
        Daniel Scally <djrscally@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/6] media: ov5693: rename clk into xvclk
Date:   Thu, 30 Jun 2022 09:45:22 +0200
Message-Id: <20220630074525.481790-4-tommaso.merciai@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220630074525.481790-1-tommaso.merciai@amarulasolutions.com>
References: <20220630074525.481790-1-tommaso.merciai@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename clk pdata pointer into xvclk (system clock input).
Same for clk_rate into xvclk_rate. This is more explicit

Signed-off-by: Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
Reviewed-by: Jacopo Mondi <jacopo@jmondi.org>
---
Changes since v3:
 - Add reviewed-by tag, suggested by Jacopo, Krzysztof

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

