Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A0B558D49B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 09:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239437AbiHIHcs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 03:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239069AbiHIHce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 03:32:34 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F6311F63F;
        Tue,  9 Aug 2022 00:32:32 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id u6so6789895ljk.8;
        Tue, 09 Aug 2022 00:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MmAFyPEWTYXBpGJTGxeKOerbkQVNbVS4fi1FukS6r28=;
        b=a9mz3qIq8uByvysJppH43ZSQyAN3lHYP5KwLeUAfKSW/KGOIIfT0oYm2RrAFvXUGRE
         AKuElskMVLxy1Q023Ev3N9GnG7xJ9h1Xxxpcju0gQX0afO0RntR7qBe2btdyw9Oia5ul
         RB03GdNnJRgnnEypv+GTe6Fr4vvXmIdEZcYNjxXIjve4zq6f8ffV1/JVz9KUzsEwQuM1
         1YEx0j19ezYdxP+p/LAUSbpcs6pE8ca2t2SyMwBrZjuDx1/YAQCn29AjqkidHJnNFJJK
         SMVb+FAlwFNx96/EjgOb+O0xphvVxIb4ucSJdmpLd/fuC4rVbpG0rmsDRGXp9Ns0EM2B
         wZFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MmAFyPEWTYXBpGJTGxeKOerbkQVNbVS4fi1FukS6r28=;
        b=c+AT17pmYE2r7mLMFGnmcneINMlBIqMibWCjpxQIGWk+PUzqSyC1VRnydKsVkQtK8b
         d7BFVg0KXZZZYCyUTKHN8plwbapquWfSWP/sAM/porF+MmPa0/4iAbDRdNiWqalZjSCn
         BSfZu5QFfXDqsPMfcEPnvra90h1mXoo4+bvqXDefdklGSLcG9KvFufqY7vqq2IaEBzHG
         Rx0UJVX6oagpp7drPGcK2wUWzcZBqMyDgAjwN//91lfQUkwX2yXR+19hMRmTwZSrEbTp
         lIW9rVSGaSY3HM49ZLi0z/nrlS6OQ8LI6cqgLrH4M3vhwkPSY2LqbRVsz6E73/OptVWc
         wPDA==
X-Gm-Message-State: ACgBeo3KpxhHvMN96Mp7oVUFPziHu3BigBvK/733OLKe5k3qAeM+jdEr
        p+aF/l9prRoHOtamlryelG8=
X-Google-Smtp-Source: AA6agR77YR8aVVE5TvMuJydOWPQWOYZEWzygkDLcLS7VZAL/396FriRzqDNHbeGghdP9uDxh3M0nCQ==
X-Received: by 2002:a2e:be88:0:b0:25f:e9a8:44b8 with SMTP id a8-20020a2ebe88000000b0025fe9a844b8mr1762235ljr.92.1660030350921;
        Tue, 09 Aug 2022 00:32:30 -0700 (PDT)
Received: from localhost.localdomain (82-209-154-112.cust.bredband2.com. [82.209.154.112])
        by smtp.gmail.com with ESMTPSA id k15-20020a05651c10af00b0025d620892cdsm1528911ljn.107.2022.08.09.00.32.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 00:32:30 -0700 (PDT)
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
Subject: [PATCH v5 4/9] iio: adc: mcp3911: use resource-managed version of iio_device_register
Date:   Tue,  9 Aug 2022 09:36:43 +0200
Message-Id: <20220809073648.167821-5-marcus.folkesson@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220809073648.167821-1-marcus.folkesson@gmail.com>
References: <20220809073648.167821-1-marcus.folkesson@gmail.com>
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
 drivers/iio/adc/mcp3911.c | 56 ++++++++++++++++++---------------------
 1 file changed, 26 insertions(+), 30 deletions(-)

diff --git a/drivers/iio/adc/mcp3911.c b/drivers/iio/adc/mcp3911.c
index 890af7dca62d..29d73b847f5f 100644
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
@@ -322,31 +343,7 @@ static int mcp3911_probe(struct spi_device *spi)
 
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
@@ -367,7 +364,6 @@ static struct spi_driver mcp3911_driver = {
 		.of_match_table = mcp3911_dt_ids,
 	},
 	.probe = mcp3911_probe,
-	.remove = mcp3911_remove,
 	.id_table = mcp3911_id,
 };
 module_spi_driver(mcp3911_driver);
-- 
2.37.1

