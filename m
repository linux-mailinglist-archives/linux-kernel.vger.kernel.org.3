Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9837258D4AC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 09:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239823AbiHIHdS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 03:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239308AbiHIHcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 03:32:43 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA20021267;
        Tue,  9 Aug 2022 00:32:37 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id y23so12107030ljh.12;
        Tue, 09 Aug 2022 00:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xJYIUaLcJnfA7jR+QMucT/pwh4GYvtALN5i/Jagf/fA=;
        b=khy3TteSikCWgpJ3E/7/42mmpA3Qc3Kg7mMaxSLA8WK/vcBaxFHdCLfOLTI2PGhB0s
         yoc03/xmi/KpuhzzD01XKERBCl9MPB7hGo4s2L2+ujRq0teQn9JY7cdm8CVXowHuI92r
         jQ32coHHwzHYOdT+9HaIIwQ0980BWFaDHuRdkwcYA6+bFbOk4XhULY2/kzlnYaswQdlY
         TGJBXxv92Cg+cMaVQlkLzjwZgxZt4hQFXdqIT83r3Dx3un5b7gaw+w//6BECsFKni/p4
         KyOgRSUSw+qX+j0H66RV7XfH2VntuVNR5PN9TxSHpz9D3oHioYoe7MNdrLqDOhYlTkYo
         pTXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xJYIUaLcJnfA7jR+QMucT/pwh4GYvtALN5i/Jagf/fA=;
        b=OODdcmtHsTPeYk1su0USoYb02b7cFn0e4N0B2uy7DhbHylaBUNa/RpovrTTigAm8Am
         /AefBdAeLYcu/8Kr/RNrsb2Tj5L9yzMzdfNi41UB1SHEz1ZVpaxfv+loBW1S2MQtui3L
         iP8r+7fXTnFfZfD3iMT3c5/RrojEMpO/AnVWarP43DHXI4yuOmfViO0xL6XaN9NHCCbH
         KR6rH/HWnoQEvxXOVgghejxgim7pYIItsqCRCXCb50rByFqXONZ34+TQj9IWGuBDqT+L
         jtpPcLYd71AXx8B4pKOX7BtafEuIb52TqtRe0Lehg41GNa0qtl5Uqj4obiqyCSf6xLgk
         oVkg==
X-Gm-Message-State: ACgBeo2FVqskNpptK03N+SCFYmSmOH9/FfAGg7xcedTr1GHceNt+/EHX
        y/xNBrN5RwElyFOX3QCOGDs=
X-Google-Smtp-Source: AA6agR4NF0sVbqATqatNT+TK8TtTA+zwj9ggS7BCjr+zRYFl1NxOnhzSKHjx8ioqLhQkym0WlubNzA==
X-Received: by 2002:a2e:597:0:b0:25e:4a64:1628 with SMTP id 145-20020a2e0597000000b0025e4a641628mr6791595ljf.378.1660030356126;
        Tue, 09 Aug 2022 00:32:36 -0700 (PDT)
Received: from localhost.localdomain (82-209-154-112.cust.bredband2.com. [82.209.154.112])
        by smtp.gmail.com with ESMTPSA id k15-20020a05651c10af00b0025d620892cdsm1528911ljn.107.2022.08.09.00.32.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 00:32:35 -0700 (PDT)
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
Subject: [PATCH v5 9/9] iio: adc: mcp3911: add support to set PGA
Date:   Tue,  9 Aug 2022 09:36:48 +0200
Message-Id: <20220809073648.167821-10-marcus.folkesson@gmail.com>
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

Add support for setting the Programmable Gain Amplifiers by adjust the
scale value.

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/iio/adc/mcp3911.c | 107 +++++++++++++++++++++++++++++---------
 1 file changed, 83 insertions(+), 24 deletions(-)

diff --git a/drivers/iio/adc/mcp3911.c b/drivers/iio/adc/mcp3911.c
index 61b516573207..ed8d0bb11fd6 100644
--- a/drivers/iio/adc/mcp3911.c
+++ b/drivers/iio/adc/mcp3911.c
@@ -28,6 +28,8 @@
 #define MCP3911_REG_MOD			0x06
 #define MCP3911_REG_PHASE		0x07
 #define MCP3911_REG_GAIN		0x09
+#define MCP3911_GAIN_MASK(ch)		(GENMASK(2, 0) << 3 * ch)
+#define MCP3911_GAIN_VAL(ch, val)      ((val << 3 * ch) & MCP3911_GAIN_MASK(ch))
 
 #define MCP3911_REG_STATUSCOM		0x0a
 #define MCP3911_STATUSCOM_DRHIZ         BIT(12)
@@ -58,8 +60,10 @@
 #define MCP3911_REG_WRITE(reg, id)	((((reg) << 1) | ((id) << 5) | (0 << 0)) & 0xff)
 
 #define MCP3911_NUM_CHANNELS		2
+#define MCP3911_NUM_SCALES		6
 
 static const int mcp3911_osr_table[] = { 32, 64, 128, 256, 512, 1024, 2048, 4096 };
+static u32 mcp3911_scale_table[MCP3911_NUM_SCALES][2];
 
 struct mcp3911 {
 	struct spi_device *spi;
@@ -68,6 +72,7 @@ struct mcp3911 {
 	struct clk *clki;
 	u32 dev_addr;
 	struct iio_trigger *trig;
+	u32 gain[MCP3911_NUM_CHANNELS];
 	struct {
 		u32 channels[MCP3911_NUM_CHANNELS];
 		s64 ts __aligned(8);
@@ -144,6 +149,11 @@ static int mcp3911_read_avail(struct iio_dev *indio_dev,
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
@@ -188,29 +198,9 @@ static int mcp3911_read_raw(struct iio_dev *indio_dev,
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
 
@@ -228,6 +218,18 @@ static int mcp3911_write_raw(struct iio_dev *indio_dev,
 
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
@@ -263,6 +265,47 @@ static int mcp3911_write_raw(struct iio_dev *indio_dev,
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
@@ -272,8 +315,10 @@ static int mcp3911_write_raw(struct iio_dev *indio_dev,
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
@@ -501,6 +546,20 @@ static int mcp3911_probe(struct spi_device *spi)
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

