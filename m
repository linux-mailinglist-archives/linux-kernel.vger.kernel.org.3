Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83EDA4C18B9
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 17:36:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242881AbiBWQgO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 11:36:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242867AbiBWQgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 11:36:07 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F6BE56C3F;
        Wed, 23 Feb 2022 08:35:39 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id m22so3214349pja.0;
        Wed, 23 Feb 2022 08:35:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Wuoe6//698fzWFtSPEf4qQyavX9sdiATrcn5KHdyTWQ=;
        b=ZEC+UKEo6VznFd6EFEO3nWFawUDsHoGCOzFjQxvmOtwi2LdH5yfXy3qPhqTXGLEFhw
         A8ByJ0RcLygYDVOH5jo92Y+0Qv5lnha7nD4LHSpKeiR7h9afTy0VFqqR5B/pW+EBHMJr
         dS2aVw/YkwZqWJwilKonD0sXjOXbRDc7LeDtVEARxIFUE5L/XeGvX4MtDC3QA21AmRu7
         lU9yjTp5Kj37Nvf+Jz7h8Ocv5i8Dt0ELbYbWwxj9tlVoHh2z2LhUHemKL/W+VF0IzP5U
         TvUeP536YIIU2ZxEmIWpCIxYMzoHenfIpuicJhNa8qIxPd0w0gADsDDised5Bc3IOTJJ
         M8aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Wuoe6//698fzWFtSPEf4qQyavX9sdiATrcn5KHdyTWQ=;
        b=19gaP4PZUivOmT+kOWJ+5oahkLnvw6b5Tlp6yoUo7oNYLAiO2yLc3f6zJDrn9gDyei
         8V0RwpkkDZMwU+yr2O6y13QlK31/cj3/9bDc2dwV7guTfJ0QfVJhxRFwq6tkJK7kUc/+
         LXLdRpk059UL5aP+3tA6LmVaz62NxquoqEv0n13MnHUrf4Fg0DzrhtXk4pKexcUYwwy2
         OcijZKZuD1RhqQ3TE3dWv8a5Ze79g5sV86+7oXxhJcGhYkkqxbr5J+NzBG3DKWMbgSjl
         ks4HdUrEN8d+z/FFTKs3LUKNQ7uDTJ3fXuDquMLyCs08r7ZwtpEnSwi9TnspVmsDKXmy
         sSYw==
X-Gm-Message-State: AOAM530L5zmHI99h7eUG31wTcLgy4b/OnqV1AIvTPCqEZBAE5rcdPxe0
        JeFqYTGbJViTP1vxCg9H6X0=
X-Google-Smtp-Source: ABdhPJzwp2w+tNkvRPX12NoUmqxFBjCDrWB1l+lbut6fIv6wPUhO78eriZobE+f4kX855gidQTQMZA==
X-Received: by 2002:a17:90a:800b:b0:1bc:1954:9640 with SMTP id b11-20020a17090a800b00b001bc19549640mr148588pjn.89.1645634139005;
        Wed, 23 Feb 2022 08:35:39 -0800 (PST)
Received: from localhost.localdomain ([27.7.190.133])
        by smtp.gmail.com with ESMTPSA id q93-20020a17090a4fe600b001b9ba2a1dc3sm3455106pjh.25.2022.02.23.08.35.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 08:35:38 -0800 (PST)
From:   Jagath Jog J <jagathjog1996@gmail.com>
To:     jic23@kernel.org, lars@metafoo.de, andy.shevchenko@gmail.com,
        sst@poczta.fm, robh+dt@kernel.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/7] iio: potentiometer: Add available functionality
Date:   Wed, 23 Feb 2022 22:05:20 +0530
Message-Id: <20220223163525.13399-3-jagathjog1996@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220223163525.13399-1-jagathjog1996@gmail.com>
References: <20220223163525.13399-1-jagathjog1996@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding available functionality for DS1803 driver which
will show the minimum, step and maximum values that the
driver can accepts through sysfs entry.
Now using the max value present in avail array instead of chip
type specific macro to make the driver flexible to add other
type of potentiometer with different max position value.

Signed-off-by: Jagath Jog J <jagathjog1996@gmail.com>
---
 drivers/iio/potentiometer/ds1803.c | 61 ++++++++++++++++++++++--------
 1 file changed, 45 insertions(+), 16 deletions(-)

diff --git a/drivers/iio/potentiometer/ds1803.c b/drivers/iio/potentiometer/ds1803.c
index 3c542a50ece6..9610269bed7f 100644
--- a/drivers/iio/potentiometer/ds1803.c
+++ b/drivers/iio/potentiometer/ds1803.c
@@ -16,7 +16,6 @@
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
 
-#define DS1803_MAX_POS		255
 #define DS1803_WRITE(chan)	(0xa8 | ((chan) + 1))
 
 enum ds1803_type {
@@ -26,27 +25,23 @@ enum ds1803_type {
 };
 
 struct ds1803_cfg {
+	int avail[3];
 	int kohms;
 };
 
-static const struct ds1803_cfg ds1803_cfg[] = {
-	[DS1803_010] = { .kohms =  10, },
-	[DS1803_050] = { .kohms =  50, },
-	[DS1803_100] = { .kohms = 100, },
-};
-
 struct ds1803_data {
 	struct i2c_client *client;
 	const struct ds1803_cfg *cfg;
 };
 
-#define DS1803_CHANNEL(ch) {					\
-	.type = IIO_RESISTANCE,					\
-	.indexed = 1,						\
-	.output = 1,						\
-	.channel = (ch),					\
-	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
-	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
+#define DS1803_CHANNEL(ch) {						\
+	.type = IIO_RESISTANCE,						\
+	.indexed = 1,							\
+	.output = 1,							\
+	.channel = (ch),						\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),			\
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),		\
+	.info_mask_shared_by_type_available = BIT(IIO_CHAN_INFO_RAW),   \
 }
 
 static const struct iio_chan_spec ds1803_channels[] = {
@@ -54,6 +49,21 @@ static const struct iio_chan_spec ds1803_channels[] = {
 	DS1803_CHANNEL(1),
 };
 
+static const struct ds1803_cfg ds1803_cfg[] = {
+	[DS1803_010] = {
+	  .avail = { 0, 1, 255 },
+	  .kohms =  10,
+	},
+	[DS1803_050] = {
+	  .avail = { 0, 1, 255 },
+	  .kohms =  50,
+	},
+	[DS1803_100] = {
+	  .avail = { 0, 1, 255 },
+	  .kohms = 100,
+	},
+};
+
 static int ds1803_read_raw(struct iio_dev *indio_dev,
 			   struct iio_chan_spec const *chan,
 			   int *val, int *val2, long mask)
@@ -75,7 +85,7 @@ static int ds1803_read_raw(struct iio_dev *indio_dev,
 
 	case IIO_CHAN_INFO_SCALE:
 		*val = 1000 * data->cfg->kohms;
-		*val2 = DS1803_MAX_POS;
+		*val2 = data->cfg->avail[2]; /* Max wiper position */
 		return IIO_VAL_FRACTIONAL;
 	}
 
@@ -88,13 +98,14 @@ static int ds1803_write_raw(struct iio_dev *indio_dev,
 {
 	struct ds1803_data *data = iio_priv(indio_dev);
 	int pot = chan->channel;
+	int max_pos = data->cfg->avail[2];
 
 	if (val2 != 0)
 		return -EINVAL;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
-		if (val > DS1803_MAX_POS || val < 0)
+		if (val > max_pos || val < 0)
 			return -EINVAL;
 		break;
 	default:
@@ -104,9 +115,27 @@ static int ds1803_write_raw(struct iio_dev *indio_dev,
 	return i2c_smbus_write_byte_data(data->client, DS1803_WRITE(pot), val);
 }
 
+static int ds1803_read_avail(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     const int **vals, int *type,
+			     int *length, long mask)
+{
+	struct ds1803_data *data = iio_priv(indio_dev);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		*vals = data->cfg->avail;
+		*length = ARRAY_SIZE(data->cfg->avail);
+		*type = IIO_VAL_INT;
+		return IIO_AVAIL_RANGE;
+	}
+	return -EINVAL;
+}
+
 static const struct iio_info ds1803_info = {
 	.read_raw = ds1803_read_raw,
 	.write_raw = ds1803_write_raw,
+	.read_avail = ds1803_read_avail,
 };
 
 static int ds1803_probe(struct i2c_client *client, const struct i2c_device_id *id)
-- 
2.17.1

