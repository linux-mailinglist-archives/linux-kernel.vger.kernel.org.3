Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46A8E59295F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 08:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240925AbiHOGMS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 02:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240434AbiHOGMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 02:12:03 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B81A18E1F;
        Sun, 14 Aug 2022 23:11:54 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id u3so9380180lfk.8;
        Sun, 14 Aug 2022 23:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=A94+rVG8JrCDTtewt08INKI8qvn+pZTQbHqa2vUYGEk=;
        b=MumJUolJo3QnQmbo7lvmH1fA551GjksTC9JoipFnYnXeuKIs3lAdIz/7iBqdeR6PbI
         LpO/RZ+KENHNzO5Q26kCWhVImY7+9CzJLuLD+eORqnU1L997vRAA+tGagiXYDr8wvg/U
         OlRWtC8G3jfJg9a+ii6ajL0aOYp1Yvl/HGaYsftN3B4NehtYPee8mEQCcDQV5d75JeFf
         hHLnZRfd7yMexTgsdXAoJCLP158cwN8wm6diRaq5ac7/5c+6hDRra+EY7CKjzBDnMv+I
         zadVuU8+sllVsQ74UhJ97IoxVIzT+43Rg3oqSU8Z18a6av0wyzvz5T/VAm+fU2bKvpQK
         c0xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=A94+rVG8JrCDTtewt08INKI8qvn+pZTQbHqa2vUYGEk=;
        b=Aki/0PqKBw14Mi2lwlsqmv0n2MCTnxX8mU7brdI0/MCd3KEvr+BuPuk0cjbHtdSbBp
         1+uyNdG/vSE9x8PgPpmbahPyiAD4BafkYHUUdbZIYohMA7nmmhQL+qj8yp1P1IxToX4s
         WFtBlvNrKTurrtsVck2OfzEbx5f4QF3lIKHdy9v3sbJ59iRFW+oN7E3emwyyulOG3WCm
         W7lFAVm0s88hO1hnY5xsdufyB5JIWB7BaiDMOVfT7XifBYX2CfMhSpCS0JnrKpiVCDS1
         p12/02+qV6hkS0uZxShogYqEiuERwrmetAt3tjRKjT/tF1KOWu4hv2zv9X+hsiONT2BH
         Ds0Q==
X-Gm-Message-State: ACgBeo0Rg2r2Prk7JEO9nAUfVtQf0A+BMLubVDGQ8cSNkJIlTFpwL/lO
        rw06SxIQipPX6CDmbvz6naWychbnwdAAcA==
X-Google-Smtp-Source: AA6agR55WB6eTLFqV9LpQJyQRqXgaQGHnNBh0FaayENZfOvzh28cW016E8pDvvjpCYqlmScdtAeTbg==
X-Received: by 2002:a05:6512:3faa:b0:48a:f17a:579e with SMTP id x42-20020a0565123faa00b0048af17a579emr5334597lfa.30.1660543912635;
        Sun, 14 Aug 2022 23:11:52 -0700 (PDT)
Received: from localhost.localdomain (82-209-154-112.cust.bredband2.com. [82.209.154.112])
        by smtp.gmail.com with ESMTPSA id g17-20020a2eb5d1000000b0025d70efeaaasm1296464ljn.75.2022.08.14.23.11.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Aug 2022 23:11:51 -0700 (PDT)
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
Subject: [PATCH v6 4/9] iio: adc: mcp3911: use resource-managed version of iio_device_register
Date:   Mon, 15 Aug 2022 08:16:20 +0200
Message-Id: <20220815061625.35568-5-marcus.folkesson@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220815061625.35568-1-marcus.folkesson@gmail.com>
References: <20220815061625.35568-1-marcus.folkesson@gmail.com>
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

Keep using managed resources as much as possible.

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/iio/adc/mcp3911.c | 53 ++++++++++++---------------------------
 1 file changed, 16 insertions(+), 37 deletions(-)

diff --git a/drivers/iio/adc/mcp3911.c b/drivers/iio/adc/mcp3911.c
index 890af7dca62d..7e2efe702e57 100644
--- a/drivers/iio/adc/mcp3911.c
+++ b/drivers/iio/adc/mcp3911.c
@@ -258,6 +258,13 @@ static int mcp3911_config(struct mcp3911 *adc)
 	return  mcp3911_write(adc, MCP3911_REG_CONFIG, configreg, 2);
 }
 
+static void mcp3911_cleanup_regulator(void *_adc)
+{
+	struct mcp3911 *adc = _adc;
+
+	regulator_disable(adc->vref);
+}
+
 static int mcp3911_probe(struct spi_device *spi)
 {
 	struct iio_dev *indio_dev;
@@ -286,9 +293,14 @@ static int mcp3911_probe(struct spi_device *spi)
 		ret = regulator_enable(adc->vref);
 		if (ret)
 			return ret;
+
+		ret = devm_add_action_or_reset(&spi->dev,
+				mcp3911_cleanup_regulator, adc);
+		if (ret)
+			return ret;
 	}
 
-	adc->clki = devm_clk_get(&adc->spi->dev, NULL);
+	adc->clki = devm_clk_get_enabled(&adc->spi->dev, NULL);
 	if (IS_ERR(adc->clki)) {
 		if (PTR_ERR(adc->clki) == -ENOENT) {
 			adc->clki = NULL;
@@ -296,21 +308,13 @@ static int mcp3911_probe(struct spi_device *spi)
 			dev_err(&adc->spi->dev,
 				"failed to get adc clk (%ld)\n",
 				PTR_ERR(adc->clki));
-			ret = PTR_ERR(adc->clki);
-			goto reg_disable;
-		}
-	} else {
-		ret = clk_prepare_enable(adc->clki);
-		if (ret < 0) {
-			dev_err(&adc->spi->dev,
-				"Failed to enable clki: %d\n", ret);
-			goto reg_disable;
+			return PTR_ERR(adc->clki);
 		}
 	}
 
 	ret = mcp3911_config(adc);
 	if (ret)
-		goto clk_disable;
+		return ret;
 
 	indio_dev->name = spi_get_device_id(spi)->name;
 	indio_dev->modes = INDIO_DIRECT_MODE;
@@ -322,31 +326,7 @@ static int mcp3911_probe(struct spi_device *spi)
 
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
-}
-
-static void mcp3911_remove(struct spi_device *spi)
-{
-	struct iio_dev *indio_dev = spi_get_drvdata(spi);
-	struct mcp3911 *adc = iio_priv(indio_dev);
-
-	iio_device_unregister(indio_dev);
-
-	clk_disable_unprepare(adc->clki);
-	if (adc->vref)
-		regulator_disable(adc->vref);
+	return devm_iio_device_register(&adc->spi->dev, indio_dev);
 }
 
 static const struct of_device_id mcp3911_dt_ids[] = {
@@ -367,7 +347,6 @@ static struct spi_driver mcp3911_driver = {
 		.of_match_table = mcp3911_dt_ids,
 	},
 	.probe = mcp3911_probe,
-	.remove = mcp3911_remove,
 	.id_table = mcp3911_id,
 };
 module_spi_driver(mcp3911_driver);
-- 
2.37.1

