Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2FF6592972
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 08:13:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240756AbiHOGMn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 02:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240679AbiHOGMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 02:12:05 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF0A51900A;
        Sun, 14 Aug 2022 23:12:00 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id x19so9387699lfq.7;
        Sun, 14 Aug 2022 23:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=lQGu1TRp7KdFDwYlUVBw3FAbt2P+S+5rDnsKB5wE5ZI=;
        b=QmKtsPec/VFwlUtPAZFszC1JlbtLGUBFHLLt1lQ6nG5/B6+zZt+abbYI4vzC5KxNJC
         wsrjGBBcsmWOuT54y6lNCOlMqwixFCYiY9Ip4zZQzvzsFYmpDj7Y0qjxFJPoq2KkOIcM
         xToYn6d/h2Adl8+recIjHiFdCSCMPVEsmEsZ3oCg9Ox9KZ5IKKfDYhqGCQGNuJaCcsdW
         6iwqfOIX06SFkr5Daz1RYqzy6Xe5RpzXIz7IjtIJjkqrFccMsxac9OdMxhKKMD4RunGS
         1gTTjL6Pq84ddsl8dyq1bme57v3lqhgtCnUZkIj974sFXsmCJYMCntEWX2d6K1NEI8Z8
         z73g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=lQGu1TRp7KdFDwYlUVBw3FAbt2P+S+5rDnsKB5wE5ZI=;
        b=d5m7zAZExM4aSzAZEOiOk1nxOK/Fb6fIVL3ZaAcEUccQ1It/i/KKBZZMwlE7480H2V
         3rbtKDjVAlrGbgVJHZXrXqh3eH2X14W9cJgLiQ5gByCoG9wSgusIVCKM8w5YHP6ARDBC
         /5nZcoFkPFU98YigtiS778pP16c8bDgYN+wUzB8IFVEISnyiNC7SlF+k/uSaernbeRMy
         aPalRAsBMYrKdx+TSMRxZF0usxmQIFfe+hh/t0pByn9xRotR3xukTTxmIB/fV6Ly2X9p
         NwrojpZrgkc57Qr/IW5irlYluORD5XXxF+evzQ4DkP3VLH+FT7Gnf/nFUyNpx8AILS8e
         WCXQ==
X-Gm-Message-State: ACgBeo0hhd7EilFmg/zEeWuTnJceumAcNgDBqZl9VH6iTToWbWKcgoVa
        ibYMM0bYdIY6IdIeG5gdQyA=
X-Google-Smtp-Source: AA6agR5JU7hAMkKIxf0DPYA5hobegWMGGaWb/H+E18vbJPLpkU/pAG5yLyoQ97PcARiapfqmreGc3w==
X-Received: by 2002:a05:6512:2354:b0:48a:e29b:2bb4 with SMTP id p20-20020a056512235400b0048ae29b2bb4mr5361953lfu.435.1660543919115;
        Sun, 14 Aug 2022 23:11:59 -0700 (PDT)
Received: from localhost.localdomain (82-209-154-112.cust.bredband2.com. [82.209.154.112])
        by smtp.gmail.com with ESMTPSA id g17-20020a2eb5d1000000b0025d70efeaaasm1296464ljn.75.2022.08.14.23.11.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Aug 2022 23:11:58 -0700 (PDT)
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
Subject: [PATCH v6 9/9] iio: adc: mcp3911: add support to set PGA
Date:   Mon, 15 Aug 2022 08:16:25 +0200
Message-Id: <20220815061625.35568-10-marcus.folkesson@gmail.com>
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

Add support for setting the Programmable Gain Amplifiers by adjust the
scale value.

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/iio/adc/mcp3911.c | 107 +++++++++++++++++++++++++++++---------
 1 file changed, 83 insertions(+), 24 deletions(-)

diff --git a/drivers/iio/adc/mcp3911.c b/drivers/iio/adc/mcp3911.c
index 0151258b456c..de85a87b9287 100644
--- a/drivers/iio/adc/mcp3911.c
+++ b/drivers/iio/adc/mcp3911.c
@@ -29,6 +29,8 @@
 #define MCP3911_REG_MOD			0x06
 #define MCP3911_REG_PHASE		0x07
 #define MCP3911_REG_GAIN		0x09
+#define MCP3911_GAIN_MASK(ch)		(GENMASK(2, 0) << 3 * ch)
+#define MCP3911_GAIN_VAL(ch, val)      ((val << 3 * ch) & MCP3911_GAIN_MASK(ch))
 
 #define MCP3911_REG_STATUSCOM		0x0a
 #define MCP3911_STATUSCOM_DRHIZ         BIT(12)
@@ -59,8 +61,10 @@
 #define MCP3911_REG_WRITE(reg, id)	((((reg) << 1) | ((id) << 5) | (0 << 0)) & 0xff)
 
 #define MCP3911_NUM_CHANNELS		2
+#define MCP3911_NUM_SCALES		6
 
 static const int mcp3911_osr_table[] = { 32, 64, 128, 256, 512, 1024, 2048, 4096 };
+static u32 mcp3911_scale_table[MCP3911_NUM_SCALES][2];
 
 struct mcp3911 {
 	struct spi_device *spi;
@@ -69,6 +73,7 @@ struct mcp3911 {
 	struct clk *clki;
 	u32 dev_addr;
 	struct iio_trigger *trig;
+	u32 gain[MCP3911_NUM_CHANNELS];
 	struct {
 		u32 channels[MCP3911_NUM_CHANNELS];
 		s64 ts __aligned(8);
@@ -145,6 +150,11 @@ static int mcp3911_read_avail(struct iio_dev *indio_dev,
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
@@ -189,29 +199,9 @@ static int mcp3911_read_raw(struct iio_dev *indio_dev,
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
 
@@ -229,6 +219,18 @@ static int mcp3911_write_raw(struct iio_dev *indio_dev,
 
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
@@ -264,6 +266,47 @@ static int mcp3911_write_raw(struct iio_dev *indio_dev,
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
@@ -273,8 +316,10 @@ static int mcp3911_write_raw(struct iio_dev *indio_dev,
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
@@ -483,6 +528,20 @@ static int mcp3911_probe(struct spi_device *spi)
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
2.37.1

