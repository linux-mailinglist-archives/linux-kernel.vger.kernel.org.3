Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19A2557E1E5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 15:04:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235483AbiGVNE1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 09:04:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235357AbiGVNEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 09:04:11 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94247AFB45;
        Fri, 22 Jul 2022 06:04:08 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id j26so5387464lji.1;
        Fri, 22 Jul 2022 06:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x/nyurVBH7ue7nYvu0dJP8wwIsDDtOcE5tkxfN9/wqE=;
        b=B64q7QIIbYL/qDMsOwTzd5v9HYBhBbi6BcoRhUZxe/eHlvCs/dZPokGubRqDLWGMFa
         dmeeRkTBcCSA5rHDZ8SsFo/wdBzJ797eaiyuXcdCabdeidSE3tP7a7qRvAgHCfbJNzTH
         oKB1uyzuEZWwCyYphBzo3v3/uvAm8Sh8pc/aFK3zdj0lhOQiyJnvbSezsqDszAUUpkNz
         /9C3ESH6S9p1vZdFktFWb9G2b0Ucrvcdo+1mNXOjD47r1zZDyGEo4QCNk5cQkrEySjRt
         8Sx0ZGFx6z1a4uwWupv+RIDMeEoLO23J6Z6tWxii2zYpKM6sZ2+/k1p0XbVG7/8/aTp9
         MCVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x/nyurVBH7ue7nYvu0dJP8wwIsDDtOcE5tkxfN9/wqE=;
        b=qvtYf02G0YooF6/PLKfnsU74GkddG60B4YQ1rvh1wzZEw68+qTiFCtClq2qF9e9yBs
         McI/7qgcBtN2NwAkrUEXhI2J1e7BdW4nFwE96D1GxHbWgUlIq7uGTRITAPmwXmXKg3dp
         VUtq6WlmNPMAdM1+uBgASUhYdgG9kBDVIhjUjFcRLNSIPnWgbwrPpgpG9hZdPz+v9ZKs
         dlvnEOfrCTjEapw3PcI51x8PkDVUxljzl7QgHAqH9teJOiON7y66+lMQ4riIHOmMdcln
         ILijsSbinyf1flKzRDKjm9xp4I+buE2KnMe5Kb02ogv4Ahen9QEDHMbDpXEv2UkYOn/s
         7nyQ==
X-Gm-Message-State: AJIora/2LvT1lUaHEpfqKexAm1b2IxgcqMcGlhyuArRjmjT0WQs6Suzg
        OlYxjq2GL5QNMwC8YvzBZ6Y=
X-Google-Smtp-Source: AGRyM1ucnvYY1/cFheV/5KueYIJLX3zfCMGKQb/vSJLEQXwFcgOBy73H3rSIardVq8rZukT5Y0LJ6Q==
X-Received: by 2002:a2e:934f:0:b0:250:a7bc:2b8f with SMTP id m15-20020a2e934f000000b00250a7bc2b8fmr165404ljh.512.1658495046816;
        Fri, 22 Jul 2022 06:04:06 -0700 (PDT)
Received: from localhost.localdomain (82-209-154-112.cust.bredband2.com. [82.209.154.112])
        by smtp.gmail.com with ESMTPSA id s18-20020a056512203200b004786d37229csm1039673lfs.155.2022.07.22.06.04.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jul 2022 06:04:06 -0700 (PDT)
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
Subject: [PATCH v4 5/9] iio: adc: mcp3911: add support for buffers
Date:   Fri, 22 Jul 2022 15:07:22 +0200
Message-Id: <20220722130726.7627-6-marcus.folkesson@gmail.com>
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

Add support for buffers to make the driver fit for more usecases.

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/iio/adc/mcp3911.c | 96 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 89 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/adc/mcp3911.c b/drivers/iio/adc/mcp3911.c
index 00dadb1761dc..96c0a2a50c7c 100644
--- a/drivers/iio/adc/mcp3911.c
+++ b/drivers/iio/adc/mcp3911.c
@@ -5,15 +5,22 @@
  * Copyright (C) 2018 Marcus Folkesson <marcus.folkesson@gmail.com>
  * Copyright (C) 2018 Kent Gustavsson <kent@minoris.se>
  */
+#include <linux/bitfield.h>
+#include <linux/bits.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/iio/iio.h>
+#include <linux/iio/buffer.h>
+#include <linux/iio/triggered_buffer.h>
+#include <linux/iio/trigger_consumer.h>
+#include <linux/iio/trigger.h>
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
 #include <linux/property.h>
 #include <linux/regulator/consumer.h>
 #include <linux/spi/spi.h>
+#include <asm/unaligned.h>
 
 #define MCP3911_REG_CHANNEL0		0x00
 #define MCP3911_REG_CHANNEL1		0x03
@@ -22,6 +29,7 @@
 #define MCP3911_REG_GAIN		0x09
 
 #define MCP3911_REG_STATUSCOM		0x0a
+#define MCP3911_STATUSCOM_READ		GENMASK(7, 6)
 #define MCP3911_STATUSCOM_CH1_24WIDTH	BIT(4)
 #define MCP3911_STATUSCOM_CH0_24WIDTH	BIT(3)
 #define MCP3911_STATUSCOM_EN_OFFCAL	BIT(2)
@@ -54,6 +62,13 @@ struct mcp3911 {
 	struct regulator *vref;
 	struct clk *clki;
 	u32 dev_addr;
+	struct {
+		u32 channels[MCP3911_NUM_CHANNELS];
+		s64 ts __aligned(8);
+	} scan;
+
+	u8 tx_buf[MCP3911_NUM_CHANNELS * 3] __aligned(IIO_DMA_MINALIGN);
+	u8 rx_buf[MCP3911_NUM_CHANNELS * 3];
 };
 
 static int mcp3911_read(struct mcp3911 *adc, u8 reg, u32 *val, u8 len)
@@ -196,16 +211,63 @@ static int mcp3911_write_raw(struct iio_dev *indio_dev,
 		.type = IIO_VOLTAGE,				\
 		.indexed = 1,					\
 		.channel = idx,					\
+		.scan_index = idx,				\
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |	\
 			BIT(IIO_CHAN_INFO_OFFSET) |		\
 			BIT(IIO_CHAN_INFO_SCALE),		\
+		.scan_type = {					\
+			.sign = 's',				\
+			.realbits = 24,				\
+			.storagebits = 32,			\
+			.endianness = IIO_BE,			\
+		},						\
 }
 
 static const struct iio_chan_spec mcp3911_channels[] = {
 	MCP3911_CHAN(0),
 	MCP3911_CHAN(1),
+	IIO_CHAN_SOFT_TIMESTAMP(2),
 };
 
+static irqreturn_t mcp3911_trigger_handler(int irq, void *p)
+{
+	struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->indio_dev;
+	struct mcp3911 *adc = iio_priv(indio_dev);
+	struct spi_transfer xfer = {
+		.tx_buf = adc->tx_buf,
+		.rx_buf = adc->rx_buf,
+		.len = sizeof(adc->rx_buf),
+	};
+	int scan_index;
+	int i = 0;
+	int ret;
+
+	mutex_lock(&adc->lock);
+	adc->tx_buf[0] = MCP3911_REG_READ(MCP3911_CHANNEL(0), adc->dev_addr);
+	ret = spi_sync_transfer(adc->spi, &xfer, 1);
+	if (ret < 0) {
+		dev_warn(&adc->spi->dev,
+				"failed to get conversion data\n");
+		goto out;
+	}
+
+	for_each_set_bit(scan_index, indio_dev->active_scan_mask,
+			indio_dev->masklength) {
+		const struct iio_chan_spec *scan_chan = &indio_dev->channels[scan_index];
+
+		adc->scan.channels[i] = get_unaligned_be24(&adc->rx_buf[scan_chan->channel * 3]);
+		i++;
+	}
+	iio_push_to_buffers_with_timestamp(indio_dev, &adc->scan,
+			iio_get_time_ns(indio_dev));
+out:
+	mutex_unlock(&adc->lock);
+	iio_trigger_notify_done(indio_dev->trig);
+
+	return IRQ_HANDLED;
+}
+
 static const struct iio_info mcp3911_info = {
 	.read_raw = mcp3911_read_raw,
 	.write_raw = mcp3911_write_raw,
@@ -214,7 +276,7 @@ static const struct iio_info mcp3911_info = {
 static int mcp3911_config(struct mcp3911 *adc)
 {
 	struct device *dev = &adc->spi->dev;
-	u32 configreg;
+	u32 regval;
 	int ret;
 
 	ret = device_property_read_u32(dev, "microchip,device-addr", &adc->dev_addr);
@@ -233,29 +295,43 @@ static int mcp3911_config(struct mcp3911 *adc)
 	}
 	dev_dbg(&adc->spi->dev, "use device address %i\n", adc->dev_addr);
 
-	ret = mcp3911_read(adc, MCP3911_REG_CONFIG, &configreg, 2);
+	ret = mcp3911_read(adc, MCP3911_REG_CONFIG, &regval, 2);
 	if (ret)
 		return ret;
 
+	regval &= ~MCP3911_CONFIG_VREFEXT;
 	if (adc->vref) {
 		dev_dbg(&adc->spi->dev, "use external voltage reference\n");
-		configreg |= MCP3911_CONFIG_VREFEXT;
+		regval |= FIELD_PREP(MCP3911_CONFIG_VREFEXT, 1);
 	} else {
 		dev_dbg(&adc->spi->dev,
 			"use internal voltage reference (1.2V)\n");
-		configreg &= ~MCP3911_CONFIG_VREFEXT;
+		regval |= FIELD_PREP(MCP3911_CONFIG_VREFEXT, 0);
 	}
 
+	regval &= ~MCP3911_CONFIG_CLKEXT;
 	if (adc->clki) {
 		dev_dbg(&adc->spi->dev, "use external clock as clocksource\n");
-		configreg |= MCP3911_CONFIG_CLKEXT;
+		regval |= FIELD_PREP(MCP3911_CONFIG_CLKEXT, 1);
 	} else {
 		dev_dbg(&adc->spi->dev,
 			"use crystal oscillator as clocksource\n");
-		configreg &= ~MCP3911_CONFIG_CLKEXT;
+		regval |= FIELD_PREP(MCP3911_CONFIG_CLKEXT, 0);
 	}
 
-	return  mcp3911_write(adc, MCP3911_REG_CONFIG, configreg, 2);
+	ret = mcp3911_write(adc, MCP3911_REG_CONFIG, regval, 2);
+	if (ret)
+		return ret;
+
+	ret = mcp3911_read(adc, MCP3911_REG_STATUSCOM, &regval, 2);
+	if (ret)
+		return ret;
+
+	/* Address counter incremented, cycle through register types */
+	regval &= ~MCP3911_STATUSCOM_READ;
+	regval |= FIELD_PREP(MCP3911_STATUSCOM_READ, 0x02);
+
+	return  mcp3911_write(adc, MCP3911_REG_STATUSCOM, regval, 2);
 }
 
 static void mcp3911_cleanup_clock(void *_adc)
@@ -343,6 +419,12 @@ static int mcp3911_probe(struct spi_device *spi)
 
 	mutex_init(&adc->lock);
 
+	ret = devm_iio_triggered_buffer_setup(&spi->dev, indio_dev,
+			NULL,
+			mcp3911_trigger_handler, NULL);
+	if (ret)
+		return ret;
+
 	return devm_iio_device_register(&adc->spi->dev, indio_dev);
 }
 
-- 
2.36.1

