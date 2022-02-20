Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A4AD4BCBB9
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 03:46:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243317AbiBTCrF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Feb 2022 21:47:05 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230431AbiBTCrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Feb 2022 21:47:02 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3701060FF;
        Sat, 19 Feb 2022 18:46:40 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id l73so11211740pge.11;
        Sat, 19 Feb 2022 18:46:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=w9jy9lnBDfLmIqFJjt9CXkg0EOVyG3IWJdyZ7MDDT48=;
        b=b3RBdQujzShbpXP9ftARDtcyv9s2VFuR2g7D++WbG/gSp8no5uspjH+cKliZ8KxvP0
         nyAxatpn+brK5PhyONXzneWm6ROXvU9eCK9JcmveUthOcwlXdo6nX+4Mq2jZljK+BkqF
         BD1xdGO8FRyW3ZOgYs6ymI8RYQIFmA3PAm6wy1cKeyouclNDJxGV517/LiQW6AfYnx2Z
         Y5PmRYkKRhoUuOSKkQebJwqytW72hLSKPtcWT3FWmaFVG6X871gHFFm9tAMncPij3Oef
         /T7leM+uplL5k1hBFHXG8aBJZ9arB/i6XBzyOidtxYRHHfGuLMddRaXg7/5c0P4ZD0Nn
         LbFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=w9jy9lnBDfLmIqFJjt9CXkg0EOVyG3IWJdyZ7MDDT48=;
        b=EbIpd4fGcWKR4zE8S50tCNe8CVkaiq42TaYmzIyTkMRY8YElvcuqFVdyVGatY/9be1
         AEYExrXhiutpthym5hPIJrjrlX/JMT7ptuCAeQhAnc1l29dofEjCrWuBmGopYafV3Rb5
         BrkXsJ/ZEg9OUn9XxZbTlFYIem4Euzmp0TGJXSxof0Wxoi1uNlEPcv/oAs+fIj/yIzXt
         D+kyabwSZ/h6a5SKwLGc6gD6Rq7j/p5KxJBWeNqtiNDjwA+RdDVQc8OmJeQRx1lRv2i2
         BFbP3GBbiDBA+KQnlafx5Hw7zMir8Wtzmum2X09KZ81tlIiPeuSHn8HdmJMJPYaJQe5p
         HNfw==
X-Gm-Message-State: AOAM530MP16dKEvgyUIX78JRDqGSRvGbqS/YBGcgn8PoaOR2dmlUHqXG
        hxm94QEvmQ4BZfo0cDMwf90=
X-Google-Smtp-Source: ABdhPJwTi4oEX21GhDHC/eBc+pSCwzv/eDr62xXJLSjr1+uG4/tr8bBJlNhNskpfzFgelXuHXh34hA==
X-Received: by 2002:a05:6a00:190d:b0:4e9:57a9:af13 with SMTP id y13-20020a056a00190d00b004e957a9af13mr11003812pfi.43.1645325199691;
        Sat, 19 Feb 2022 18:46:39 -0800 (PST)
Received: from localhost.localdomain ([116.73.72.178])
        by smtp.gmail.com with ESMTPSA id lw16sm3488761pjb.51.2022.02.19.18.46.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Feb 2022 18:46:39 -0800 (PST)
From:   Jagath Jog J <jagathjog1996@gmail.com>
To:     jic23@kernel.org, lars@metafoo.de, andy.shevchenko@gmail.com,
        sst@poczta.fm, robh+dt@kernel.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/7] iio: potentiometer: Alignment to match the open parenthesis
Date:   Sun, 20 Feb 2022 08:16:26 +0530
Message-Id: <20220220024632.4183-2-jagathjog1996@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220220024632.4183-1-jagathjog1996@gmail.com>
References: <20220220024632.4183-1-jagathjog1996@gmail.com>
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

