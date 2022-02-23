Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D0834C18B8
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 17:35:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238652AbiBWQgM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 11:36:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242854AbiBWQgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 11:36:04 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36AAD55762;
        Wed, 23 Feb 2022 08:35:36 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id g7-20020a17090a708700b001bb78857ccdso2850901pjk.1;
        Wed, 23 Feb 2022 08:35:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=w9jy9lnBDfLmIqFJjt9CXkg0EOVyG3IWJdyZ7MDDT48=;
        b=nlLBN5s4GQMQWjKPwI22UxkOH8KIvS+6KW2qFKrwM9aObdGHqa/w60mDMQO84XlXqr
         E5gJVv3NQYY9X9R/5pbnCnXWcH1yym5olfCtnQGZuvG2NgqqBL7695+CT0zXHbtk3uSW
         qQe+7hyvshb70QfHLHBfddekYruNx/mWnu+cqG1G6MGOjcGq0kdOuJhJfhvFVnpMCGao
         DWdE1dIY7QhZd7F+IFcmGtdBk9v34MbQ3od9mS5vHFl8LodgBnLtQB94EE6UgznKv7r+
         MJVn+t9pV5JHBncT35g1MCBmug2CF2+xZ03M0LZJ8bKBbDcOng6+8GeAQMd4aV4ReNvg
         We8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=w9jy9lnBDfLmIqFJjt9CXkg0EOVyG3IWJdyZ7MDDT48=;
        b=qDHjTfvCcfHry40nHOOm8tHZMCvC74tQPu5haFTkZn0QZnbc1P/PUhLX2tQuTYBSYf
         BFAOH4IMjitNfb2OwBRkkC1swJJe9mj1i8vbXQQ0hBottBe9bIPG8L5WTjVCgwbqT5u/
         h5aIUeiY/AexgPkC+qLDa4e+1NIF01VUbXtmEPgUykLE2WIvRhc19jVOXo5ejZrbjD46
         nHAVYwJWNCYoGvtWtvvKPdMTPXiU2sMotJtyOqCeK5hYilit2X57/e6ghxnpr1FnX38C
         2PaGrRvomYSG3RV+4GoqYruqLBXxCf2qdOqv+XQ6oytcKg/Vg8rB+AX/IxiAStTA8Y0+
         M4Bg==
X-Gm-Message-State: AOAM530hA++wPHS8U2XyUVgW55wm2lkrQu6nNhFOQjt+gMpaiq6lSzrq
        cTJ7Ys1dTfX1vGXB4j5UZGY=
X-Google-Smtp-Source: ABdhPJzwDNR3J0waYJQej6XoUvxUXwC8OECh1f8ElQnpmaTIYt2bTbq4AELnociBCX/6rsDVyk+HUw==
X-Received: by 2002:a17:90a:d50c:b0:1bc:6d27:75b with SMTP id t12-20020a17090ad50c00b001bc6d27075bmr177850pju.94.1645634135718;
        Wed, 23 Feb 2022 08:35:35 -0800 (PST)
Received: from localhost.localdomain ([27.7.190.133])
        by smtp.gmail.com with ESMTPSA id q93-20020a17090a4fe600b001b9ba2a1dc3sm3455106pjh.25.2022.02.23.08.35.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 08:35:35 -0800 (PST)
From:   Jagath Jog J <jagathjog1996@gmail.com>
To:     jic23@kernel.org, lars@metafoo.de, andy.shevchenko@gmail.com,
        sst@poczta.fm, robh+dt@kernel.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/7] iio: potentiometer: Alignment to match the open parenthesis
Date:   Wed, 23 Feb 2022 22:05:19 +0530
Message-Id: <20220223163525.13399-2-jagathjog1996@gmail.com>
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

Fix following checkpatch.pl check by removing blank space.
CHECK: Alignment should match open parenthesis.

Signed-off-by: Jagath Jog J <jagathjog1996@gmail.com>
---
 drivers/iio/potentiometer/ds1803.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/potentiometer/ds1803.c b/drivers/iio/potentiometer/ds1803.c
index 20b45407eaac..3c542a50ece6 100644
--- a/drivers/iio/potentiometer/ds1803.c
+++ b/drivers/iio/potentiometer/ds1803.c
@@ -55,8 +55,8 @@ static const struct iio_chan_spec ds1803_channels[] = {
 };
 
 static int ds1803_read_raw(struct iio_dev *indio_dev,
-			    struct iio_chan_spec const *chan,
-			    int *val, int *val2, long mask)
+			   struct iio_chan_spec const *chan,
+			   int *val, int *val2, long mask)
 {
 	struct ds1803_data *data = iio_priv(indio_dev);
 	int pot = chan->channel;
@@ -66,7 +66,7 @@ static int ds1803_read_raw(struct iio_dev *indio_dev,
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
 		ret = i2c_master_recv(data->client, result,
-				indio_dev->num_channels);
+				      indio_dev->num_channels);
 		if (ret < 0)
 			return ret;
 
@@ -83,8 +83,8 @@ static int ds1803_read_raw(struct iio_dev *indio_dev,
 }
 
 static int ds1803_write_raw(struct iio_dev *indio_dev,
-			     struct iio_chan_spec const *chan,
-			     int val, int val2, long mask)
+			    struct iio_chan_spec const *chan,
+			    int val, int val2, long mask)
 {
 	struct ds1803_data *data = iio_priv(indio_dev);
 	int pot = chan->channel;
@@ -109,8 +109,7 @@ static const struct iio_info ds1803_info = {
 	.write_raw = ds1803_write_raw,
 };
 
-static int ds1803_probe(struct i2c_client *client,
-			 const struct i2c_device_id *id)
+static int ds1803_probe(struct i2c_client *client, const struct i2c_device_id *id)
 {
 	struct device *dev = &client->dev;
 	struct ds1803_data *data;
-- 
2.17.1

