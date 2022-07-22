Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6542357E1F1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 15:04:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235479AbiGVNEb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 09:04:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235319AbiGVNEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 09:04:07 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5243AF97D;
        Fri, 22 Jul 2022 06:04:05 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id z22so7540832lfu.7;
        Fri, 22 Jul 2022 06:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fzXEWH4hDhz8Ds7uR4+Q3KQN6VTJZX7sN1d8PJvppqU=;
        b=WVqFoCaiooJSy/gM2Zbhu4GH8dfBL8u7leYCY+EBNMk4j+NGKEDf2rRJdeVDC4nt+y
         rQER8X1dEDJp1ozHNEs9JxaQG7zjUooI2EF2eirDtq51OsPMNu+nMADYxLa10Mb/lZGM
         NYzlWzdd0ZiMXkuSMIWS77t0m5oF1q1xsqvbhlpEHv+dSWY4dc0aautDYU9Gh7sjFMbE
         UFtZ5IJcVc8HjYE8uv3IzroZrXRZfdQmrkKcDQ8B6kNn+cbp3Kp7maWLHvs88DGc5SQz
         go6YpXNW8EebUGTbE/u92zzmplgkPje9Q5a8dBoGsJQuIoSAQwVgkYhG+oGy6YCbLQia
         yOnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fzXEWH4hDhz8Ds7uR4+Q3KQN6VTJZX7sN1d8PJvppqU=;
        b=TWRwhZp4gl8S2IKIelflxRKAywxwx5YqBn00bDDDBIjHnR93k+pctjpGPZBaw3UKWH
         fgozw21mkHvb2ZEz8m2aO91Q0LTS2tb/SAAbmbAPamm1119plyAVA7pdvbpDdq7vdjPU
         5voUieggB7xzZad+gM/bMVFfVq/45IMp0fKfvw8pBj7Z1HP5G6gRhTX7Dk7HsahD2WBz
         GfqFJ9MT/LjQin11Eix+Amg1exzNeE+CxFq1HQg1s4eC5aZhiOvgQ5q8otGOzMSh34F8
         UgPV+gfKNIyQekj1tfQVUq2mwEbFydX/BlR7F1Fj6UpfHZYoC+HYTw8TfTAFJAE/wluo
         MgtA==
X-Gm-Message-State: AJIora8C5OJOHA2IfLDHUsV7/RY+Ih4WPAEslEVH91V7TrlaavBkGY6D
        FVitJKECjIq0hRYe17HY+tM=
X-Google-Smtp-Source: AGRyM1vP1xGFwXyFjlW1PXuB+nVZufJAhxUEPm6x+ex4iDF/jjgDMu0kZg3yU+2m2wUbuDNgnoH8SQ==
X-Received: by 2002:a05:6512:376d:b0:48a:49fa:5574 with SMTP id z13-20020a056512376d00b0048a49fa5574mr195982lft.30.1658495045225;
        Fri, 22 Jul 2022 06:04:05 -0700 (PDT)
Received: from localhost.localdomain (82-209-154-112.cust.bredband2.com. [82.209.154.112])
        by smtp.gmail.com with ESMTPSA id s18-20020a056512203200b004786d37229csm1039673lfs.155.2022.07.22.06.04.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jul 2022 06:04:04 -0700 (PDT)
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     Marcus Folkesson <marcus.folkesson@gmail.com>,
        Kent Gustavsson <kent@minoris.se>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 4/9] iio: adc: mcp3911: use resource-managed version of iio_device_register
Date:   Fri, 22 Jul 2022 15:07:21 +0200
Message-Id: <20220722130726.7627-5-marcus.folkesson@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220722130726.7627-1-marcus.folkesson@gmail.com>
References: <20220722130726.7627-1-marcus.folkesson@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Keep using managed resources as much as possible.

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/iio/adc/Kconfig   |  2 ++
 drivers/iio/adc/mcp3911.c | 51 ++++++++++++++++++++-------------------
 2 files changed, 28 insertions(+), 25 deletions(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 7fe5930891e0..3b5db59f3931 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -718,6 +718,8 @@ config MCP3422
 config MCP3911
 	tristate "Microchip Technology MCP3911 driver"
 	depends on SPI
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
 	help
 	  Say yes here to build support for Microchip Technology's MCP3911
 	  analog to digital converter.
diff --git a/drivers/iio/adc/mcp3911.c b/drivers/iio/adc/mcp3911.c
index 890af7dca62d..00dadb1761dc 100644
--- a/drivers/iio/adc/mcp3911.c
+++ b/drivers/iio/adc/mcp3911.c
@@ -258,6 +258,18 @@ static int mcp3911_config(struct mcp3911 *adc)
 	return  mcp3911_write(adc, MCP3911_REG_CONFIG, configreg, 2);
 }
 
+static void mcp3911_cleanup_clock(void *_adc)
+{
+	struct mcp3911 *adc = _adc;
+	clk_disable_unprepare(adc->clki);
+}
+
+static void mcp3911_cleanup_regulator(void *_adc)
+{
+	struct mcp3911 *adc = _adc;
+	regulator_disable(adc->vref);
+}
+
 static int mcp3911_probe(struct spi_device *spi)
 {
 	struct iio_dev *indio_dev;
@@ -286,6 +298,11 @@ static int mcp3911_probe(struct spi_device *spi)
 		ret = regulator_enable(adc->vref);
 		if (ret)
 			return ret;
+
+		ret = devm_add_action_or_reset(&spi->dev,
+				mcp3911_cleanup_regulator, adc);
+		if (ret)
+			return ret;
 	}
 
 	adc->clki = devm_clk_get(&adc->spi->dev, NULL);
@@ -296,21 +313,25 @@ static int mcp3911_probe(struct spi_device *spi)
 			dev_err(&adc->spi->dev,
 				"failed to get adc clk (%ld)\n",
 				PTR_ERR(adc->clki));
-			ret = PTR_ERR(adc->clki);
-			goto reg_disable;
+			return PTR_ERR(adc->clki);
 		}
 	} else {
 		ret = clk_prepare_enable(adc->clki);
 		if (ret < 0) {
 			dev_err(&adc->spi->dev,
 				"Failed to enable clki: %d\n", ret);
-			goto reg_disable;
+			return ret;
 		}
+
+		ret = devm_add_action_or_reset(&spi->dev,
+				mcp3911_cleanup_clock, adc);
+		if (ret)
+			return ret;
 	}
 
 	ret = mcp3911_config(adc);
 	if (ret)
-		goto clk_disable;
+		return ret;
 
 	indio_dev->name = spi_get_device_id(spi)->name;
 	indio_dev->modes = INDIO_DIRECT_MODE;
@@ -322,31 +343,11 @@ static int mcp3911_probe(struct spi_device *spi)
 
 	mutex_init(&adc->lock);
 
-	ret = iio_device_register(indio_dev);
-	if (ret)
-		goto clk_disable;
-
-	return ret;
-
-clk_disable:
-	clk_disable_unprepare(adc->clki);
-reg_disable:
-	if (adc->vref)
-		regulator_disable(adc->vref);
-
-	return ret;
+	return devm_iio_device_register(&adc->spi->dev, indio_dev);
 }
 
 static void mcp3911_remove(struct spi_device *spi)
 {
-	struct iio_dev *indio_dev = spi_get_drvdata(spi);
-	struct mcp3911 *adc = iio_priv(indio_dev);
-
-	iio_device_unregister(indio_dev);
-
-	clk_disable_unprepare(adc->clki);
-	if (adc->vref)
-		regulator_disable(adc->vref);
 }
 
 static const struct of_device_id mcp3911_dt_ids[] = {
-- 
2.36.1

