Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ACCD507AE0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 22:21:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347911AbiDSUYE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 16:24:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352873AbiDSUX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 16:23:57 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A6941D314;
        Tue, 19 Apr 2022 13:21:13 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id v64-20020a1cac43000000b0038cfd1b3a6dso2318891wme.5;
        Tue, 19 Apr 2022 13:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M0Qza2rtZ0RajpV4HFFpld0YJXw2QLLdgEYNKlixzhM=;
        b=A7kGqzc0Q6KkHSPiL7QmBTAd8JFefcZvwK41ebKFz/0w9FyKWBw2cjxdlAlqXsEYeu
         m6XcTcRokJm75kooNKVFccGnmWcfvJ/54LpjitkLTKdbc44rZnQFwY4/XvblrdCcsGP8
         wsBIvtVfQP9c/uJlrxGwcSy6Kcq9x7UXtowpcfXisAucQ25uTwNcSdZGUMd0OX81oMMO
         AJO+VEULTrYmKYp9AiY0A9NdWnqgRMKfVPU/ghhBQdF3LCd2S79KdS+koX7DfmwVhE9y
         y/Du795x4jXahQ5PSW09g1b4mM3xGcvdPDKuY0SgqYjaC2Ok9FD2S+j5wauGmGTg474Q
         9AFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M0Qza2rtZ0RajpV4HFFpld0YJXw2QLLdgEYNKlixzhM=;
        b=Kx/eK0beAbZHufw4z7wREzlfcatWNXHMQLXW65Sfr2p+IeGM5LTfynz5X1uFWXKdxw
         SBS7sSGpLw19y3YnZBHiDgixNgi+vOg7Ov1UtedHDYvEPnTJGQdj0Vote3W3qmkCA5eX
         nA0xqtbC9/PUj5bs64cCSgIKfS98MeT39+q83ItyCLPPOjJBRwEhIqzT7zdOrIXxAmxT
         QFaeLxkDpBeu5DRvfejgppvFt1rGrj84CbfiKkPz9DO7VNnc/wQKQ2nWpOqLZG6NWPLU
         rGty3UsNHNggGPJaxvK5sZBi7yAlfnKDxY9uKkTLHRBeosTv+J3n5UFvHRdRWp91UiUR
         afLA==
X-Gm-Message-State: AOAM532n6kxTa/kczEYBQZnfqAlIqsNXSICzYZkC/gODhgsZo0lyOvv4
        GRhIvDDTufTlbdOg8do8UWx5LxID4VQ=
X-Google-Smtp-Source: ABdhPJwXaZ4sRx4KlXVYDxz6HIugRIaQA0yWiL8ZsbyMLa3V+sn8z8PKyyZsTahCeKX8maohyc1+zQ==
X-Received: by 2002:a05:600c:1e85:b0:391:ca59:76be with SMTP id be5-20020a05600c1e8500b00391ca5976bemr271629wmb.184.1650399671690;
        Tue, 19 Apr 2022 13:21:11 -0700 (PDT)
Received: from localhost.localdomain ([141.72.243.13])
        by smtp.gmail.com with ESMTPSA id b11-20020a5d45cb000000b0020a810f7726sm9959168wrs.5.2022.04.19.13.21.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 13:21:11 -0700 (PDT)
From:   Moses Christopher Bollavarapu <mosescb.dev@gmail.com>
To:     matt.ranostay@konsulko.com, mchehab@kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Moses Christopher Bollavarapu <mosescb.dev@gmail.com>
Subject: [PATCH 2/3] media: i2c: video-i2c: Replace constants with proper names
Date:   Tue, 19 Apr 2022 22:20:50 +0200
Message-Id: <20220419202051.44013-3-mosescb.dev@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220419202051.44013-1-mosescb.dev@gmail.com>
References: <20220419202051.44013-1-mosescb.dev@gmail.com>
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

Acc to MLX90640 datasheet:
 - 0x0400 represents the start of RAM address
 - 0x2400 represents the start of EEPROM address

Reference: https://www.melexis.com/-/media/files/documents\
           /datasheets/mlx90640-datasheet-melexis.pdf

Signed-off-by: Moses Christopher Bollavarapu <mosescb.dev@gmail.com>
---
 drivers/media/i2c/video-i2c.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/media/i2c/video-i2c.c b/drivers/media/i2c/video-i2c.c
index b3fe9a507f7f..1d5f48329cb2 100644
--- a/drivers/media/i2c/video-i2c.c
+++ b/drivers/media/i2c/video-i2c.c
@@ -54,6 +54,12 @@
 /* Temperature register */
 #define AMG88XX_REG_T01L	0x80
 
+/* RAM */
+#define MLX90640_RAM_START_ADDR		0x0400
+
+/* EEPROM */
+#define MLX90640_EEPROM_START_ADDR	0x2400
+
 /* Control register */
 #define MLX90640_REG_CTL1		0x800d
 #define MLX90640_REG_CTL1_MASK		0x0380
@@ -149,7 +155,7 @@ static int mlx90640_nvram_read(void *priv, unsigned int offset, void *val,
 {
 	struct video_i2c_data *data = priv;
 
-	return regmap_bulk_read(data->regmap, 0x2400 + offset, val, bytes);
+	return regmap_bulk_read(data->regmap, MLX90640_EEPROM_START_ADDR + offset, val, bytes);
 }
 
 static struct nvmem_config mlx90640_nvram_config = {
@@ -168,7 +174,7 @@ static int amg88xx_xfer(struct video_i2c_data *data, char *buf)
 
 static int mlx90640_xfer(struct video_i2c_data *data, char *buf)
 {
-	return regmap_bulk_read(data->regmap, 0x400, buf,
+	return regmap_bulk_read(data->regmap, MLX90640_RAM_START_ADDR, buf,
 				data->chip->buffer_size);
 }
 
-- 
2.30.2

