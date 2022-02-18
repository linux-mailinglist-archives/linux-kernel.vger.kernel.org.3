Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F7004BB0AC
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 05:21:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbiBREVN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 23:21:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbiBREVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 23:21:03 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 934CE1AE2EA;
        Thu, 17 Feb 2022 20:20:46 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id r64-20020a17090a43c600b001b8854e682eso7440426pjg.0;
        Thu, 17 Feb 2022 20:20:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=w9jy9lnBDfLmIqFJjt9CXkg0EOVyG3IWJdyZ7MDDT48=;
        b=UPCTlZ0swfrwbFLXVOya701Jv3B3HlhbJUKkpxB93yMY/H//u+pKHOLpW2I2K2WsM1
         oIAVwWIi9TD5AStUBpZNUL2i7s7QAcQV75kfILaKo1uUKDegQonoPcGCnIUaq5PA5qZA
         RKXzmdn2nG3nwTRvkRrOUi5nT4p8BP78VYsrCtqB2y1aj4lDD4tUr4fkJPcEKGN2VPOo
         32XZOuM5Slxs5ddGEfp22/ytOihp7E5HrFa/5CqKL9sJNv5rtNkwK/3IrG9pK9dOes43
         BKKCpR9F/XhxQI9YXj6LhZxgjjhYo5JNSrOgVUrkzUPuRui7zMfon9fauX9MWP20ez/z
         +QzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=w9jy9lnBDfLmIqFJjt9CXkg0EOVyG3IWJdyZ7MDDT48=;
        b=Kcj24vIO4eGIzrPmXMMxi/gghB7rE3ajeL6SbqJtjptDMda67vqLcI4VeLcRFvERHF
         RSfcudv0YQdMTA07NhhCTHJ3Io1+Jvj/pABsgykPSEgnj781iY+ZwaNJHwe5yMQdVS4x
         FgejCfLdLh7F4+wkkXntNL5PUqNjyoGXUYRXGzXLH+sRU22T6kQ0/w/q1iJOjnyK9g62
         0i5MdUOiezIOeMo2MYSoxg5OZgZYgk7enRFu+6zXAuLTX3ipMOveEPsN/no6V+Kllm7m
         a+fYSVAobSh/paL3lk+F/XIk0aZQV+oxzllrhKAou2ACMEjq1jxYFob2/SrilWx9fEXO
         Ei5g==
X-Gm-Message-State: AOAM532rjZmnN3Gn/tJoUIsQYtH5qf1KCvsCcziwBTsUrcW6LiMUxRSu
        7YuEb3YqlJeyDizpHsusFTY=
X-Google-Smtp-Source: ABdhPJx7par3ttPSlRlhWiG9GkZzNtHe8Ay6NFd7jXeJwRRjl3JBqPtPpyhQt7a2/ZmJxl7jJ5MiSg==
X-Received: by 2002:a17:902:ac96:b0:14d:3633:b0ad with SMTP id h22-20020a170902ac9600b0014d3633b0admr5843721plr.32.1645158045991;
        Thu, 17 Feb 2022 20:20:45 -0800 (PST)
Received: from localhost.localdomain ([60.243.248.66])
        by smtp.gmail.com with ESMTPSA id h26sm9530300pgm.72.2022.02.17.20.20.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 20:20:45 -0800 (PST)
From:   Jagath Jog J <jagathjog1996@gmail.com>
To:     jic23@kernel.org, lars@metafoo.de, andy.shevchenko@gmail.com,
        sst@poczta.fm, robh+dt@kernel.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/6] iio: potentiometer: Alignment to match the open parenthesis
Date:   Fri, 18 Feb 2022 09:50:33 +0530
Message-Id: <20220218042038.15176-2-jagathjog1996@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220218042038.15176-1-jagathjog1996@gmail.com>
References: <20220218042038.15176-1-jagathjog1996@gmail.com>
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

