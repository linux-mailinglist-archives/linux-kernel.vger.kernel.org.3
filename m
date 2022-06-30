Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3227561BF4
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 15:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235604AbiF3NuM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 09:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235471AbiF3NtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 09:49:12 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80B94344F4
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 06:48:45 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id pk21so39185115ejb.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 06:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ctpa/T2vVk1WErHGmcuqVVZ1P5/ZM5PQkEWqW8vXr7A=;
        b=QWHMm6Rv+FtY91S2WQN+wWSdGk5S+1HjGiFpU56tVt5eNsTLFjV0VtdEBwwFl2SMfU
         FB9VFX90c+uREFxecu7xHH+lB8bpJ2kWphGm8H9gfjC1uQrnFsMTt59dSC3SMiBfduaQ
         0flOFeBchkgjBAjirTzkfxmyBhGikH6i5IAdc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ctpa/T2vVk1WErHGmcuqVVZ1P5/ZM5PQkEWqW8vXr7A=;
        b=zJ+3X8LRDV/Eganrul4j4vp5ArsgWV/pIMAK9EuRsc57xDvNdNu+IvoL/4EFxH1had
         9fZERap0t+F6G+2kHa+q8dldcCU9sYEZS8d7Txzua36hWG5n/M4tYudldtspuIYFWUtv
         riGHWEtJbNHWiW97kNvaV1WsNaZFYQuS5yQS7OWvn/3m9M9mdMJCjzsVihEaUVnjOHKF
         BrgwisiGDh15ZpSYxBA0Iv89Q9DNp4FnvHDbAvuhpOdWZFnn3yws7PzLF0NVeOFDlCHb
         yxcFsE//U8QOPTlxY4Pq1UVUZhUXWlMuw60zpIAQhu9/kNF7UrYCipYNecYrydAiiejp
         Hv+Q==
X-Gm-Message-State: AJIora8Yi8qg0wWdzFJecTYunKChZ3beVgKsaCImrab8jNwXuaZEoKwQ
        TjzBKu2+VAMAcXKidEYoDkCRLeZisx6o5A==
X-Google-Smtp-Source: AGRyM1tl742IH4K4tuQ/XGHDZg4XSsuoE/udHOGl0i4J+cjgZcY/NrutYCDCorUvQi0EY0/51otDIA==
X-Received: by 2002:a17:907:3dac:b0:722:e6ab:8d9 with SMTP id he44-20020a1709073dac00b00722e6ab08d9mr9931791ejc.20.1656596923839;
        Thu, 30 Jun 2022 06:48:43 -0700 (PDT)
Received: from tom-ThinkPad-T14s-Gen-2i.station (net-188-217-58-216.cust.vodafonedsl.it. [188.217.58.216])
        by smtp.gmail.com with ESMTPSA id k5-20020a1709067ac500b006fee526ed72sm9130288ejo.217.2022.06.30.06.48.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 06:48:43 -0700 (PDT)
From:   Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
To:     tommaso.merciai@amarulasolutions.com
Cc:     linuxfancy@googlegroups.com, linux-amarula@amarulasolutions.com,
        quentin.schulz@theobroma-systems.com,
        Jacopo Mondi <jacopo@jmondi.org>,
        Daniel Scally <djrscally@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 3/6] media: ov5693: rename clk into xvclk
Date:   Thu, 30 Jun 2022 15:48:32 +0200
Message-Id: <20220630134835.592521-4-tommaso.merciai@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220630134835.592521-1-tommaso.merciai@amarulasolutions.com>
References: <20220630134835.592521-1-tommaso.merciai@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
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

