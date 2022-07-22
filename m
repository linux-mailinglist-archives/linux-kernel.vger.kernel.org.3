Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A293B57E1F6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 15:05:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235594AbiGVNEq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 09:04:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235233AbiGVNES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 09:04:18 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7E93AF960;
        Fri, 22 Jul 2022 06:04:16 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id r14so5365754ljp.2;
        Fri, 22 Jul 2022 06:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F3i1nh0A1DHu/AJzxatV5Ku9zoBWXQ5Yp0VbvHDsCrw=;
        b=EDRNUioqRnq0DZaVEO2bvdnLyHv1qmw16uc9geh3IsTDCf/ZVX/zikyN0y+fZZEuQz
         ylWhEkP0OVB4oOTXIW0pG/woVg0EQ5j2kM2bH5s4HUgeRBA/VmvSclln9iInvje29Lgi
         yaA1qezL8iGOwfCHxwLukornUQtPkS88drkXfUTqVjB6gB1Rc71SjUvrmRV6pLw8wkOT
         2umkQ5KuAqflHsPeCiNAtDkgChirRGTULbIzbt/+eXYA5USQyIus3lCIKpqnOgjRjYGN
         7I6Ou9vmvrs4SGpafGbcrM5744Ns8hWhYThjb3t8EEotY2+aPPoni/8pueCo0FMpBQzz
         eKRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F3i1nh0A1DHu/AJzxatV5Ku9zoBWXQ5Yp0VbvHDsCrw=;
        b=IykRaXMZxGJj7tgSm7izjBbzERWbFIRwXiiWTeU8fg49vML8aUb1LcqvVZHGDDD2RP
         9ZZfeY716g0l31Q36qW09Izwj+HeixzVoMGhKP8dOPHiZSrU4+U9iOr1M9kRPU67yfyG
         bDNRWzlKYVN0GL9Wl7BaX9/dvEZqF25NT+zCfhGHrHpnBZe9hTb0Bsis2BRkfNIBq5eu
         r9IQvlbz0Mtqb5mdrGwNOyJq/mPS22HjNCgGeZdKROI9Fe0jRGp/0mcvxRp/ZeXhDLgi
         hkexB7YylaxxVFqomlLjVQdsv3H9b9hp+y6M7++c/UjqsJeD1CdGnbXAUQxcbqXmB7Hc
         fvhw==
X-Gm-Message-State: AJIora/Gb1Q8/WHJ8A2MmeoBgEIeDW6h36Z/lEN7tL6m5oDG4tVNfdal
        D32ANUvYg48ZYrnJ8QBjXvM=
X-Google-Smtp-Source: AGRyM1viDf923Qcug9VOj5X/cN4Oq4EE1XKhddh1BkKFwmk/LlkItvoZ3WcgJQEvh8GrC9oD5cYwww==
X-Received: by 2002:a2e:93c8:0:b0:24d:b348:b070 with SMTP id p8-20020a2e93c8000000b0024db348b070mr167912ljh.434.1658495055190;
        Fri, 22 Jul 2022 06:04:15 -0700 (PDT)
Received: from localhost.localdomain (82-209-154-112.cust.bredband2.com. [82.209.154.112])
        by smtp.gmail.com with ESMTPSA id s18-20020a056512203200b004786d37229csm1039673lfs.155.2022.07.22.06.04.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jul 2022 06:04:14 -0700 (PDT)
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
Subject: [PATCH v4 9/9] iio: adc: mcp3911: add support to set PGA
Date:   Fri, 22 Jul 2022 15:07:26 +0200
Message-Id: <20220722130726.7627-10-marcus.folkesson@gmail.com>
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

Add support for setting the Programmable Gain Amplifiers by adjust the
scale value.

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/iio/adc/mcp3911.c | 107 +++++++++++++++++++++++++++++---------
 1 file changed, 83 insertions(+), 24 deletions(-)

diff --git a/drivers/iio/adc/mcp3911.c b/drivers/iio/adc/mcp3911.c
index 30c91ccc5fb6..22a43d3fe402 100644
--- a/drivers/iio/adc/mcp3911.c
+++ b/drivers/iio/adc/mcp3911.c
@@ -27,6 +27,8 @@
 #define MCP3911_REG_MOD			0x06
 #define MCP3911_REG_PHASE		0x07
 #define MCP3911_REG_GAIN		0x09
+#define MCP3911_GAIN_MASK(ch)		(GENMASK(2, 0) << 3 * ch)
+#define MCP3911_GAIN_VAL(ch, val)      ((val << 3 * ch) & MCP3911_GAIN_MASK(ch))
 
 #define MCP3911_REG_STATUSCOM		0x0a
 #define MCP3911_STATUSCOM_DRHIZ         BIT(12)
@@ -57,8 +59,10 @@
 #define MCP3911_REG_WRITE(reg, id)	((((reg) << 1) | ((id) << 5) | (0 << 0)) & 0xff)
 
 #define MCP3911_NUM_CHANNELS		2
+#define MCP3911_NUM_SCALES		6
 
 static const int mcp3911_osr_table[] = { 32, 64, 128, 256, 512, 1024, 2048, 4096 };
+static u32 mcp3911_scale_table[MCP3911_NUM_SCALES][2];
 
 struct mcp3911 {
 	struct spi_device *spi;
@@ -67,6 +71,7 @@ struct mcp3911 {
 	struct clk *clki;
 	u32 dev_addr;
 	struct iio_trigger *trig;
+	u32 gain[MCP3911_NUM_CHANNELS];
 	struct {
 		u32 channels[MCP3911_NUM_CHANNELS];
 		s64 ts __aligned(8);
@@ -143,6 +148,11 @@ static int mcp3911_read_avail(struct iio_dev *indio_dev,
 		*vals = mcp3911_osr_table;
 		*length = ARRAY_SIZE(mcp3911_osr_table);
 		return IIO_AVAIL_LIST;
+	case IIO_CHAN_INFO_SCALE:
+		*type = IIO_VAL_INT_PLUS_NANO;
+		*vals = (int *)mcp3911_scale_table;
+		*length = ARRAY_SIZE(mcp3911_scale_table) * 2;
+		return IIO_AVAIL_LIST;
 	default:
 		return -EINVAL;
 	}
@@ -187,29 +197,9 @@ static int mcp3911_read_raw(struct iio_dev *indio_dev,
 		break;
 
 	case IIO_CHAN_INFO_SCALE:
-		if (adc->vref) {
-			ret = regulator_get_voltage(adc->vref);
-			if (ret < 0) {
-				dev_err(indio_dev->dev.parent,
-					"failed to get vref voltage: %d\n",
-				       ret);
-				goto out;
-			}
-
-			*val = ret / 1000;
-		} else {
-			*val = MCP3911_INT_VREF_MV;
-		}
-
-		/*
-		 * For 24bit Conversion
-		 * Raw = ((Voltage)/(Vref) * 2^23 * Gain * 1.5
-		 * Voltage = Raw * (Vref)/(2^23 * Gain * 1.5)
-		 */
-
-		/* val2 = (2^23 * 1.5) */
-		*val2 = 12582912;
-		ret = IIO_VAL_FRACTIONAL;
+		*val = mcp3911_scale_table[ilog2(adc->gain[channel->channel])][0];
+		*val2 = mcp3911_scale_table[ilog2(adc->gain[channel->channel])][1];
+		ret = IIO_VAL_INT_PLUS_NANO;
 		break;
 	}
 
@@ -227,6 +217,18 @@ static int mcp3911_write_raw(struct iio_dev *indio_dev,
 
 	mutex_lock(&adc->lock);
 	switch (mask) {
+	case IIO_CHAN_INFO_SCALE:
+		for (int i = 0; i < MCP3911_NUM_SCALES; i++) {
+			if (val == mcp3911_scale_table[i][0] &&
+				val2 == mcp3911_scale_table[i][1]) {
+
+				adc->gain[channel->channel] = BIT(i);
+				ret = mcp3911_update(adc, MCP3911_REG_GAIN,
+						MCP3911_GAIN_MASK(channel->channel),
+						MCP3911_GAIN_VAL(channel->channel, i), 1);
+			}
+		}
+		break;
 	case IIO_CHAN_INFO_OFFSET:
 		if (val2 != 0) {
 			ret = -EINVAL;
@@ -262,6 +264,47 @@ static int mcp3911_write_raw(struct iio_dev *indio_dev,
 	return ret;
 }
 
+static int mcp3911_calc_scale_table(struct mcp3911 *adc)
+{
+	u32 ref = MCP3911_INT_VREF_MV;
+	u32 div;
+	int ret;
+	int tmp0, tmp1;
+	s64 tmp2;
+
+	if (adc->vref) {
+		ret = regulator_get_voltage(adc->vref);
+		if (ret < 0) {
+			dev_err(&adc->spi->dev,
+				"failed to get vref voltage: %d\n",
+			       ret);
+			return ret;
+		}
+
+		ref = ret / 1000;
+	}
+
+	/*
+	 * For 24-bit Conversion
+	 * Raw = ((Voltage)/(Vref) * 2^23 * Gain * 1.5
+	 * Voltage = Raw * (Vref)/(2^23 * Gain * 1.5)
+	 *
+	 * ref = Reference voltage
+	 * div = (2^23 * 1.5 * gain) = 12582912 * gain
+	 */
+	for (int i = 0; i < MCP3911_NUM_SCALES; i++) {
+		div = 12582912 * BIT(i);
+		tmp2 = div_s64((s64)ref * 1000000000LL, div);
+		tmp1 = div;
+		tmp0 = (int)div_s64_rem(tmp2, 1000000000, &tmp1);
+
+		mcp3911_scale_table[i][0] = 0;
+		mcp3911_scale_table[i][1] = tmp1;
+	}
+
+	return 0;
+}
+
 #define MCP3911_CHAN(idx) {					\
 		.type = IIO_VOLTAGE,				\
 		.indexed = 1,					\
@@ -271,8 +314,10 @@ static int mcp3911_write_raw(struct iio_dev *indio_dev,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |	\
 			BIT(IIO_CHAN_INFO_OFFSET) |		\
 			BIT(IIO_CHAN_INFO_SCALE),		\
-		.info_mask_shared_by_type_available =		\
+		.info_mask_shared_by_type_available =           \
 			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),	\
+		.info_mask_separate_available =			\
+			BIT(IIO_CHAN_INFO_SCALE),		\
 		.scan_type = {					\
 			.sign = 's',				\
 			.realbits = 24,				\
@@ -495,6 +540,20 @@ static int mcp3911_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
+	ret = mcp3911_calc_scale_table(adc);
+	if (ret)
+		return ret;
+
+       /* Set gain to 1 for all channels */
+	for (int i = 0; i < MCP3911_NUM_CHANNELS; i++) {
+		adc->gain[i] = 1;
+		ret = mcp3911_update(adc, MCP3911_REG_GAIN,
+				MCP3911_GAIN_MASK(i),
+				MCP3911_GAIN_VAL(i, 0), 1);
+		if (ret)
+			return ret;
+	}
+
 	indio_dev->name = spi_get_device_id(spi)->name;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = &mcp3911_info;
-- 
2.36.1

