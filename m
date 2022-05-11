Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8D3E523FB2
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 23:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348423AbiEKVs3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 17:48:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348390AbiEKVsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 17:48:11 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9D7D443E9;
        Wed, 11 May 2022 14:48:06 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 4so4227209ljw.11;
        Wed, 11 May 2022 14:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NBwjBAjLmyyb61HAFn6uQh2uqKVzaEjVLl9vH6ELw+E=;
        b=mOi4Dfi99gDfBK3ToAmlb5QrQRONhoKohrWOS9c2HiM4BhUSyr29iX0z/t5Ydp+WES
         W0XlU8Fk6U4kqDbKtk7Vca8Ey9eAaMexZHe2p6ktCPnX3GSZMC/2syypz8i7prAvwpLg
         N3KO1IsL3HRqt3KD2oBwOMNuP0609LXl0ZHJDBxuoXS2WduHkR5rCbqJNxkeAw0Ila5S
         0eCrfjPaXZVxUN9dseKkgGpkdRuCM4wkJlV5mq0AIy6uEgDSUxxhkwqvbMzcaPuWIi3G
         co8EgTvVUUC0TkxTN84UHl0g6vB3Uq9iZHrpGa4MKofWl9pdwPjQfI4Lp/cnBsRIFjnQ
         vN5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NBwjBAjLmyyb61HAFn6uQh2uqKVzaEjVLl9vH6ELw+E=;
        b=Od7Q6UnilOl4pG/rsl9eNNgzuPtkspwCCg4FXXqxaBYltoP+PV6/tXQ7Xy6TiNnIJB
         VrCR4WJpmmXmhc+UVWHHZc20LN7ZcTuCMwzinKIcufYvkloiK6amvyaom9gf/r1YXzrO
         rIHFei1paHJnvy3HCD1xO2XYMGFi+k9QR/foQFu8O2QSGaiOxv8FpFstQsD+DTitRIR4
         ZJ0faPzltoG1WWsTcCx7fHwOoZlVmV+lvN5vT4usC11c+gHFFEwSsdfE/hH5VRt9JDeO
         2AhZI8m/tx/boQW/VpOES+37x3V3/UBz3gYTUhfIQuR8nnCJYamzpvvZN2NepDFdvB1c
         5P+g==
X-Gm-Message-State: AOAM532gHrLT1OCCWDT7h7rF4mr0okxsjTC+xQAO/9Ai/zf4BQpU3Sbc
        ZLDKq7eXIuiaWIz4sDqch5Ygo02nn//JGQ==
X-Google-Smtp-Source: ABdhPJzosFUsYOVsuX/mjcjoJuWYO84mt3rxQER1lfHU04D5qsfYeQYBlRyAhlKmkft0FBo6Xn10fA==
X-Received: by 2002:a2e:351a:0:b0:24f:c3b:c2d5 with SMTP id z26-20020a2e351a000000b0024f0c3bc2d5mr17529744ljz.505.1652305685206;
        Wed, 11 May 2022 14:48:05 -0700 (PDT)
Received: from nergzd-desktop.localdomain ([194.39.226.133])
        by smtp.gmail.com with ESMTPSA id 7-20020ac25687000000b0047255d211afsm458891lfr.222.2022.05.11.14.48.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 14:48:04 -0700 (PDT)
From:   Markuss Broks <markuss.broks@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Markuss Broks <markuss.broks@gmail.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Song Qiang <songqiang1304521@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH v2 4/5] proximity: vl53l0x: Handle the reset GPIO
Date:   Thu, 12 May 2022 00:47:16 +0300
Message-Id: <20220511214718.50879-5-markuss.broks@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220511214718.50879-1-markuss.broks@gmail.com>
References: <20220511214718.50879-1-markuss.broks@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Handle the GPIO connected to the XSHUT/RST_N pin of VL53L0X.

Signed-off-by: Markuss Broks <markuss.broks@gmail.com>
---
 drivers/iio/proximity/vl53l0x-i2c.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/iio/proximity/vl53l0x-i2c.c b/drivers/iio/proximity/vl53l0x-i2c.c
index e65c4fcd32d6..7aa9c1e95006 100644
--- a/drivers/iio/proximity/vl53l0x-i2c.c
+++ b/drivers/iio/proximity/vl53l0x-i2c.c
@@ -15,6 +15,7 @@
  */
 
 #include <linux/delay.h>
+#include <linux/gpio/consumer.h>
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
@@ -43,6 +44,7 @@ struct vl53l0x_data {
 	struct i2c_client *client;
 	struct completion completion;
 	struct regulator *vdd_supply;
+	struct gpio_desc *reset_gpio;
 };
 
 static irqreturn_t vl53l0x_handle_irq(int irq, void *priv)
@@ -196,6 +198,8 @@ static void vl53l0x_power_off(void *_data)
 {
 	struct vl53l0x_data *data = _data;
 
+	gpiod_set_value_cansleep(data->reset_gpio, 1);
+
 	regulator_disable(data->vdd_supply);
 }
 
@@ -207,6 +211,8 @@ static int vl53l0x_power_on(struct vl53l0x_data *data)
 	if (ret)
 		return ret;
 
+	gpiod_set_value_cansleep(data->reset_gpio, 0);
+
 	usleep_range(3200, 5000);
 
 	return 0;
@@ -236,6 +242,11 @@ static int vl53l0x_probe(struct i2c_client *client)
 		return dev_err_probe(&client->dev, PTR_ERR(data->vdd_supply),
 				     "Unable to get VDD regulator\n");
 
+	data->reset_gpio = devm_gpiod_get_optional(&client->dev, "reset", GPIOD_OUT_HIGH);
+	if (IS_ERR(data->reset_gpio))
+		return dev_err_probe(&client->dev, PTR_ERR(data->reset_gpio),
+				     "Cannot get reset GPIO\n");
+
 	error = devm_add_action_or_reset(&client->dev, vl53l0x_power_off, data);
 	if (error)
 		return dev_err_probe(&client->dev, error,
-- 
2.36.1

