Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BA9F59296A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 08:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240811AbiHOGMz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 02:12:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240393AbiHOGMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 02:12:03 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B80B218E32;
        Sun, 14 Aug 2022 23:11:55 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id f20so9382042lfc.10;
        Sun, 14 Aug 2022 23:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=iIcIavqTO/tEpGq8tOTkcwU3uozrM4gh/PI3QeIE7M4=;
        b=WKBryUPY4zZpTDp2XOi4j1+yz0GZPzKRQlAdI0J2LEVGAeHWh2yEu31CM5faYTI6WM
         oYOYEBZu7lB2kK+nzE2F5igu4hgQmeyizz1zAYTxLaBOZm+DWgdLhJIPk6MZ6c05cPmx
         Aoi/SAQme6P+NjRXHwBhCKx7CdP7ZFQ7WbGyEcfBNHETUCeIEZb7S1AjrpAf1RCyulMT
         26pdXknz50PnfOIqFxHhEUNnchnyxP288yIx+RXa3dO3avILsGCWYMqkdvaXLW/8fsgg
         wR3QGLrtFClQTATgeQln5oX5wH9pSqWBPZFsFC7rHat5nrKKnYBlfeSKiDw0KUjfEhBU
         vqyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=iIcIavqTO/tEpGq8tOTkcwU3uozrM4gh/PI3QeIE7M4=;
        b=FgkhPOqmpmZVWNRAcZZRV7FuIvcCaRO4BmlNBVds5jJew56Lbd+UaSBM1oqljk35Fh
         f01dCP6/MXWPSZgUtNrZtaMfYJ280/9mxd9kptpQy+FpzKUtrXn3mNLCKRLhlsAFVDsP
         Th+TqOEzNoI3bdj1ZUpOHqKWgEbZU12NE6v/NbT3IhAIhR/QdlUJlwrsiaYyMhF9srkB
         Dsi+5XHV802xDPFtXe4YpPOG5NdRT8Ccc1UumL0vu8sNwRFIIdg/iK7mC8CXEPE8hmgN
         X0vWWiNRFgOXT0OQjVT+SK0IH4iiAeyzraJ/hFovZ3SP1E3P9UxgiUBP3tqm8fL7IUfu
         GPZg==
X-Gm-Message-State: ACgBeo0XKHCTJkmJ76VUSBVFyoUFhK8wXZITRNQHjtE2OjSQ9gHxNb4R
        oNEsTZKdLHyAK0UFxl8Pk/k=
X-Google-Smtp-Source: AA6agR5WYctmeitAw9QBqDWwrGf620Hd0YhqTDf3pRevaiz3iUur7daIvMHrJ7oyDJvVtfa1oHeksg==
X-Received: by 2002:a05:6512:3286:b0:48a:f483:8713 with SMTP id p6-20020a056512328600b0048af4838713mr5282570lfe.194.1660543915321;
        Sun, 14 Aug 2022 23:11:55 -0700 (PDT)
Received: from localhost.localdomain (82-209-154-112.cust.bredband2.com. [82.209.154.112])
        by smtp.gmail.com with ESMTPSA id g17-20020a2eb5d1000000b0025d70efeaaasm1296464ljn.75.2022.08.14.23.11.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Aug 2022 23:11:54 -0700 (PDT)
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
Subject: [PATCH v6 6/9] iio: adc: mcp3911: add support for interrupts
Date:   Mon, 15 Aug 2022 08:16:22 +0200
Message-Id: <20220815061625.35568-7-marcus.folkesson@gmail.com>
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

Make it possible to read values upon interrupts.
Configure Data Ready Signal Output Pin to either HiZ or push-pull and
use it as interrupt source.

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/iio/adc/mcp3911.c | 53 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/drivers/iio/adc/mcp3911.c b/drivers/iio/adc/mcp3911.c
index 4452b01c76f3..b76d825c984d 100644
--- a/drivers/iio/adc/mcp3911.c
+++ b/drivers/iio/adc/mcp3911.c
@@ -31,6 +31,7 @@
 #define MCP3911_REG_GAIN		0x09
 
 #define MCP3911_REG_STATUSCOM		0x0a
+#define MCP3911_STATUSCOM_DRHIZ         BIT(12)
 #define MCP3911_STATUSCOM_READ		GENMASK(7, 6)
 #define MCP3911_STATUSCOM_CH1_24WIDTH	BIT(4)
 #define MCP3911_STATUSCOM_CH0_24WIDTH	BIT(3)
@@ -64,6 +65,7 @@ struct mcp3911 {
 	struct regulator *vref;
 	struct clk *clki;
 	u32 dev_addr;
+	struct iio_trigger *trig;
 	struct {
 		u32 channels[MCP3911_NUM_CHANNELS];
 		s64 ts __aligned(8);
@@ -346,6 +348,23 @@ static void mcp3911_cleanup_regulator(void *_adc)
 	regulator_disable(adc->vref);
 }
 
+static int mcp3911_set_trigger_state(struct iio_trigger *trig, bool enable)
+{
+	struct mcp3911 *adc = iio_trigger_get_drvdata(trig);
+
+	if (enable)
+		enable_irq(adc->spi->irq);
+	else
+		disable_irq(adc->spi->irq);
+
+	return 0;
+}
+
+static const struct iio_trigger_ops mcp3911_trigger_ops = {
+	.validate_device = iio_trigger_validate_own_device,
+	.set_trigger_state = mcp3911_set_trigger_state,
+};
+
 static int mcp3911_probe(struct spi_device *spi)
 {
 	struct iio_dev *indio_dev;
@@ -397,6 +416,15 @@ static int mcp3911_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
+	if (device_property_read_bool(&adc->spi->dev, "microchip,data-ready-hiz"))
+		ret = mcp3911_update(adc, MCP3911_REG_STATUSCOM, MCP3911_STATUSCOM_DRHIZ,
+				0, 2);
+	else
+		ret = mcp3911_update(adc, MCP3911_REG_STATUSCOM, MCP3911_STATUSCOM_DRHIZ,
+				MCP3911_STATUSCOM_DRHIZ, 2);
+	if (ret)
+		return ret;
+
 	indio_dev->name = spi_get_device_id(spi)->name;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = &mcp3911_info;
@@ -407,6 +435,31 @@ static int mcp3911_probe(struct spi_device *spi)
 
 	mutex_init(&adc->lock);
 
+	if (spi->irq > 0) {
+		adc->trig = devm_iio_trigger_alloc(&spi->dev, "%s-dev%d",
+				indio_dev->name,
+				iio_device_id(indio_dev));
+		if (!adc->trig)
+			return PTR_ERR(adc->trig);
+
+		adc->trig->ops = &mcp3911_trigger_ops;
+		iio_trigger_set_drvdata(adc->trig, adc);
+		ret = devm_iio_trigger_register(&spi->dev, adc->trig);
+		if (ret)
+			return ret;
+
+		/*
+		 * The device generates interrupts as long as it is powered up.
+		 * Some platforms might not allow the option to power it down so
+		 * don't enable the interrupt to avoid extra load on the system.
+		 */
+		ret = devm_request_irq(&spi->dev, spi->irq,
+				&iio_trigger_generic_data_rdy_poll, IRQF_NO_AUTOEN | IRQF_ONESHOT,
+				indio_dev->name, adc->trig);
+		if (ret)
+			return ret;
+	}
+
 	ret = devm_iio_triggered_buffer_setup(&spi->dev, indio_dev,
 			NULL,
 			mcp3911_trigger_handler, NULL);
-- 
2.37.1

