Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5800457E1F5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 15:05:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235581AbiGVNEn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 09:04:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235453AbiGVNEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 09:04:15 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CED4DAF957;
        Fri, 22 Jul 2022 06:04:14 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id bf9so7479492lfb.13;
        Fri, 22 Jul 2022 06:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QchHYYaodKcbw6uTcWqsRbkjdQtlMxZfWSHqeYa1TyE=;
        b=FATcg7DMmBGvOSu0G+irWKJOqwynRWNlB6Dp1aUBqISDi6R3RM3+fUQIeVKcgFObvg
         VLnCu8jcfUdIxPWv2jvjRfQS1sX4aNIyDWGmqNeUVwQH3zr6JLnpwJq4E0t8GNQKHJOU
         n887vixckl98ga5hsDZCuvxTn+lULDLY21buWx3FDIaMD7B/wCIdGwIxM+Jup16oGkmx
         6bsIZTdY5jM/tAffuFBgMaaKKmif7EFK599nLtTL4bqxMvAB3H9HlNcWJ5FFubm3e1ci
         gqlc/GzL1rkjSOy6JiJZv/eOq2O+oZdo3A0OSPHg84DVj6U1GZYB/s8yqaHNk1uPjUSQ
         pLvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QchHYYaodKcbw6uTcWqsRbkjdQtlMxZfWSHqeYa1TyE=;
        b=T5ZGAMYKb2ZJLsY4H2tCzJ3rmPZjxq/LD9MgzSrZ1FOWnpC6L992vHAPhsUppja9gY
         g1n1p2g/8YCfyr69Y9RbhCdR1+C75HfHRTvKp/YVSK+9k5lIPcTeF7aAjw1Mwbw1lJwe
         j4ZGrqBsG5aEbVztnzOY9tZfwRS47jR4G2IzqdSc+26MSZuo+umxty5uA9pHabVGqNwK
         yhbTOKne+Nbi0S9hAm54/8upR1eoKixEj8i6SsVA7bkQKf8un1GhqzCImW/QH0A9Pp1o
         IaevBAkvl4AbFG9KVPMGT8/eeZ6SM2XTuvXLJ7rWWa0oCgIZm47KLUYzddRAMrrOJMAh
         XNOw==
X-Gm-Message-State: AJIora9floMqnfoiCqe6X5rAoSWr3YZHW0CTylx0vWp2ZNYsVGIIzo3w
        VttcVIkXWjI/2WaxjB1d/5E=
X-Google-Smtp-Source: AGRyM1twYx53HVAyU8h+h3sd75qI/5edkEenReu4YksqwKTpjUShFYbKZsYzhnPapJeVtINr2ty6Fw==
X-Received: by 2002:a05:6512:2613:b0:48a:6f26:5c5a with SMTP id bt19-20020a056512261300b0048a6f265c5amr203744lfb.116.1658495053202;
        Fri, 22 Jul 2022 06:04:13 -0700 (PDT)
Received: from localhost.localdomain (82-209-154-112.cust.bredband2.com. [82.209.154.112])
        by smtp.gmail.com with ESMTPSA id s18-20020a056512203200b004786d37229csm1039673lfs.155.2022.07.22.06.04.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jul 2022 06:04:12 -0700 (PDT)
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
Subject: [PATCH v4 8/9] iio: adc: mcp3911: add support for oversampling ratio
Date:   Fri, 22 Jul 2022 15:07:25 +0200
Message-Id: <20220722130726.7627-9-marcus.folkesson@gmail.com>
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

The chip supports oversampling ratio, so expose it to userspace.

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/iio/adc/mcp3911.c | 58 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/drivers/iio/adc/mcp3911.c b/drivers/iio/adc/mcp3911.c
index 7db2c75da4ac..30c91ccc5fb6 100644
--- a/drivers/iio/adc/mcp3911.c
+++ b/drivers/iio/adc/mcp3911.c
@@ -39,6 +39,7 @@
 #define MCP3911_REG_CONFIG		0x0c
 #define MCP3911_CONFIG_CLKEXT		BIT(1)
 #define MCP3911_CONFIG_VREFEXT		BIT(2)
+#define MCP3911_CONFIG_OSR		GENMASK(13, 11)
 
 #define MCP3911_REG_OFFCAL_CH0		0x0e
 #define MCP3911_REG_GAINCAL_CH0		0x11
@@ -57,6 +58,8 @@
 
 #define MCP3911_NUM_CHANNELS		2
 
+static const int mcp3911_osr_table[] = { 32, 64, 128, 256, 512, 1024, 2048, 4096 };
+
 struct mcp3911 {
 	struct spi_device *spi;
 	struct mutex lock;
@@ -115,6 +118,36 @@ static int mcp3911_update(struct mcp3911 *adc, u8 reg, u32 mask,
 	return mcp3911_write(adc, reg, val, len);
 }
 
+static int mcp3911_write_raw_get_fmt(struct iio_dev *indio_dev,
+					struct iio_chan_spec const *chan,
+					long mask)
+{
+	switch (mask) {
+	case IIO_CHAN_INFO_SCALE:
+		return IIO_VAL_INT_PLUS_NANO;
+	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
+		return IIO_VAL_INT;
+	default:
+		return IIO_VAL_INT_PLUS_NANO;
+	}
+}
+
+static int mcp3911_read_avail(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     const int **vals, int *type, int *length,
+			     long info)
+{
+	switch (info) {
+	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
+		*type = IIO_VAL_INT;
+		*vals = mcp3911_osr_table;
+		*length = ARRAY_SIZE(mcp3911_osr_table);
+		return IIO_AVAIL_LIST;
+	default:
+		return -EINVAL;
+	}
+}
+
 static int mcp3911_read_raw(struct iio_dev *indio_dev,
 			    struct iio_chan_spec const *channel, int *val,
 			    int *val2, long mask)
@@ -143,6 +176,15 @@ static int mcp3911_read_raw(struct iio_dev *indio_dev,
 
 		ret = IIO_VAL_INT;
 		break;
+	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
+		ret = mcp3911_read(adc, MCP3911_REG_CONFIG, val, 2);
+		if (ret)
+			goto out;
+
+		*val = FIELD_GET(MCP3911_CONFIG_OSR, *val);
+		*val = 32 << *val;
+		ret = IIO_VAL_INT;
+		break;
 
 	case IIO_CHAN_INFO_SCALE:
 		if (adc->vref) {
@@ -202,6 +244,17 @@ static int mcp3911_write_raw(struct iio_dev *indio_dev,
 				MCP3911_STATUSCOM_EN_OFFCAL,
 				MCP3911_STATUSCOM_EN_OFFCAL, 2);
 		break;
+
+	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
+		for (int i = 0; i < sizeof(mcp3911_osr_table); i++) {
+			if (val == mcp3911_osr_table[i]) {
+				val = FIELD_PREP(MCP3911_CONFIG_OSR, i);
+				ret = mcp3911_update(adc, MCP3911_REG_CONFIG, MCP3911_CONFIG_OSR,
+						val, 2);
+				break;
+			}
+		}
+		break;
 	}
 
 out:
@@ -214,9 +267,12 @@ static int mcp3911_write_raw(struct iio_dev *indio_dev,
 		.indexed = 1,					\
 		.channel = idx,					\
 		.scan_index = idx,				\
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO), \
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |	\
 			BIT(IIO_CHAN_INFO_OFFSET) |		\
 			BIT(IIO_CHAN_INFO_SCALE),		\
+		.info_mask_shared_by_type_available =		\
+			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),	\
 		.scan_type = {					\
 			.sign = 's',				\
 			.realbits = 24,				\
@@ -273,6 +329,8 @@ static irqreturn_t mcp3911_trigger_handler(int irq, void *p)
 static const struct iio_info mcp3911_info = {
 	.read_raw = mcp3911_read_raw,
 	.write_raw = mcp3911_write_raw,
+	.read_avail = mcp3911_read_avail,
+	.write_raw_get_fmt = mcp3911_write_raw_get_fmt,
 };
 
 static int mcp3911_config(struct mcp3911 *adc)
-- 
2.36.1

