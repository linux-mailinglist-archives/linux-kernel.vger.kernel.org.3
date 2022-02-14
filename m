Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E85E74B4059
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 04:36:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240013AbiBNDgh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 22:36:37 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231682AbiBNDge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 22:36:34 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DA1855499;
        Sun, 13 Feb 2022 19:36:28 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id y18so9493435plb.11;
        Sun, 13 Feb 2022 19:36:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5VhvayD2Jc8dwud20cGrPE69DlH/zxn3R9XFQ9KzGKE=;
        b=VtkVHw4rLG4MqsijMorJoABoJyrczVKpYJBrRVPFXIwb1jIEWviZny0RrErLo9IevO
         oF//xlli/i5MJKX5d5yS1B7XWBbRY/HkebLfWv10WIXZLevgG37LPYF6+XzjMLRHk00g
         0x6W/F9ATyYNFrqgZERcAkuoVEZpmPakNSgjmGs0YATMsbWrAFaAios844X+/sT8E60o
         x8eZmSooydFgvpkdooIVBQbEEeq3OC/MqGqJ49L3F725XTE5YxoAVZVkZYUI4zA2RPzp
         huXn04mv6Zo4z3impbXBFCwClcFTKl3Q3cKMiN3HfxQtAEv+tvXHiiGemdTyHFIecrSD
         s5dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5VhvayD2Jc8dwud20cGrPE69DlH/zxn3R9XFQ9KzGKE=;
        b=mqOBKOiGYyqyaW8c0SV0EB895/rRbt0EyWlXznrvO0/3Pd5OFAGP3pfzleOvN5rxPh
         rad+6Wg72EMcvs/5Bp0HbpB+HIkzsPWHuf9nqgXYqjb6QZzz+5Nb9hnws0TPGJ9iGyP5
         e+B9Xn9aXKuBfk+RzRNwTez7R+31Th+PUTLku9xilahv++nkc8RpkGAbTlm8rGlA+N2l
         8kky91h2M+9Df7Z8XXgYpdRnEdQ/ViCXDcwDmTXxebTwRRRRH9zbf2bZ5dgrfHuVRku1
         KG3rOEw7/LJjdZ3fPRI5WbJz8rZZ96VN7Mg9GaYvfLjY5ocdSs4iHwLnnqSDJwjp498m
         OnWA==
X-Gm-Message-State: AOAM533BHwEEAtXDnw58Hu8fLJWgsE9ecl5hskJy6x0/0I4PmLcypL2d
        vKXO2iCBLKPuJfAamLUU3c4=
X-Google-Smtp-Source: ABdhPJw2APNMGXAeRL3m60gWQS+lNR5Vw+G3zphDeTd3UndF75Lv77FwwcF0JT2Q8szCRHBazvp/OQ==
X-Received: by 2002:a17:902:eb85:: with SMTP id q5mr323264plg.173.1644809787778;
        Sun, 13 Feb 2022 19:36:27 -0800 (PST)
Received: from localhost.localdomain ([27.7.103.158])
        by smtp.gmail.com with ESMTPSA id me14sm36012pjb.41.2022.02.13.19.36.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Feb 2022 19:36:27 -0800 (PST)
From:   Jagath Jog J <jagathjog1996@gmail.com>
To:     jic23@kernel.org, lars@metafoo.de, andy.shevchenko@gmail.com,
        sst@poczta.fm, robh+dt@kernel.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/4] iio: potentiometer: Alignment to match the open parenthesis
Date:   Mon, 14 Feb 2022 09:06:17 +0530
Message-Id: <20220214033620.4059-2-jagathjog1996@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220214033620.4059-1-jagathjog1996@gmail.com>
References: <20220214033620.4059-1-jagathjog1996@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix following checkpatch.pl check by removing black space
CHECK: Alignment should match open parenthesis

Signed-off-by: Jagath Jog J <jagathjog1996@gmail.com>
---
 drivers/iio/potentiometer/ds1803.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/potentiometer/ds1803.c b/drivers/iio/potentiometer/ds1803.c
index 20b45407eaac..3481dd460525 100644
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
@@ -110,7 +110,7 @@ static const struct iio_info ds1803_info = {
 };
 
 static int ds1803_probe(struct i2c_client *client,
-			 const struct i2c_device_id *id)
+			const struct i2c_device_id *id)
 {
 	struct device *dev = &client->dev;
 	struct ds1803_data *data;
-- 
2.17.1

