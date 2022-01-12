Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC3FA48BFCC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 09:25:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351559AbiALIZe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 03:25:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351554AbiALIZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 03:25:31 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AFE7C06173F
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 00:25:31 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id g21so2064238qtk.4
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 00:25:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZCLOQ7++2QfW2m0rsDei0rqRdeUSY6GZN2Og7N4emHA=;
        b=e/9d3uN74jIVDOPjqrRRJ2tN67VjP3qJyvuMPgJUm/fdVftErmvOhNEHTin3X20KRO
         QNpJmvEceXwzVypa0yqYvAqpb2Ms6l/dBf+J3EKFpNC+KEjVg6hIzQ5vx8VNG+4DBlnC
         80NGcpqm0Lt3MUJfAltzBdg238hC5yzTjU3jeRl/7G9hN4TBq/qIPy5ScLTkXv/Oztpz
         iXcu8tiTdJcsu9uXogSYLGWzAdxD9h8GEsEZnwMq7QT7boaYHXhU68y/VBQZaNp9wR6Q
         b7eoiPDH8B4ja51jgn0Z1nYTNDWCzAYgrvC346+O4DUY/ve0kmwafzlgaYznuTGHtaoc
         AZaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZCLOQ7++2QfW2m0rsDei0rqRdeUSY6GZN2Og7N4emHA=;
        b=cUPEZfOQfsG97kw5NiWIUs8jCkvv9orlPuiciBCy2d8+f9/OW9qGaZn0bbe7wUGO90
         tQlscysF6F0AEfAjaHRICOIfKb5AfzZAhF0hSdt2BUMjMTvyHa/+SeOfnYcEUPPfD74n
         f0aeAEfawl/quscwx59Ql4CPT+2wkTsC2o/wz9NmtY/CPMlXAVIXeo29odQ7XHdV5qBy
         FhRMi8QnZAKdH1dPInaRF6VlSLrP9vKo/pzcVnxXAUIGkChgUAaQie2Wh5HrUCOJ1kdu
         W6Od88GSXEkNcspsPADLo//F4BUDd9RaKkxJ3ygH+XimAdrCZRD7z68S9Sbg9mXcIp+H
         NgsQ==
X-Gm-Message-State: AOAM53344vIhzxSjKwGN1eAY5UFYUHk7BwekWSeI+6E7nUxR6X/L1XaS
        rjbhC+QFyYW0JPdkckBaqN4BOMdnTJo=
X-Google-Smtp-Source: ABdhPJw9jOsXa56W5lqO3RFBU1VEoiy8scsNFVqmufsWd3jsHB+kGetR7roaTSluD+Ll3FNGH4X1Ug==
X-Received: by 2002:a05:622a:14cd:: with SMTP id u13mr1768837qtx.532.1641975930836;
        Wed, 12 Jan 2022 00:25:30 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id l20sm5367458qkp.121.2022.01.12.00.25.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jan 2022 00:25:30 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     patrik.r.jakobsson@gmail.com
Cc:     airlied@linux.ie, daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>, CGEL ZTE <cgel.zte@gmail.com>
Subject: [PATCH] drm/gma500: remove redundant ret variable
Date:   Wed, 12 Jan 2022 08:25:24 +0000
Message-Id: <20220112082524.667552-1-chi.minghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Minghao Chi <chi.minghao@zte.com.cn>

Return value directly instead of taking this in another redundant
variable.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
Signed-off-by: CGEL ZTE <cgel.zte@gmail.com>
---
 drivers/gpu/drm/gma500/cdv_intel_dp.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/gma500/cdv_intel_dp.c b/drivers/gpu/drm/gma500/cdv_intel_dp.c
index ba6ad1466374..74e67679714e 100644
--- a/drivers/gpu/drm/gma500/cdv_intel_dp.c
+++ b/drivers/gpu/drm/gma500/cdv_intel_dp.c
@@ -82,7 +82,6 @@ i2c_algo_dp_aux_address(struct i2c_adapter *adapter, u16 address, bool reading)
 {
 	struct i2c_algo_dp_aux_data *algo_data = adapter->algo_data;
 	int mode = MODE_I2C_START;
-	int ret;
 
 	if (reading)
 		mode |= MODE_I2C_READ;
@@ -90,8 +89,7 @@ i2c_algo_dp_aux_address(struct i2c_adapter *adapter, u16 address, bool reading)
 		mode |= MODE_I2C_WRITE;
 	algo_data->address = address;
 	algo_data->running = true;
-	ret = i2c_algo_dp_aux_transaction(adapter, mode, 0, NULL);
-	return ret;
+	return i2c_algo_dp_aux_transaction(adapter, mode, 0, NULL);
 }
 
 /*
@@ -122,13 +120,11 @@ static int
 i2c_algo_dp_aux_put_byte(struct i2c_adapter *adapter, u8 byte)
 {
 	struct i2c_algo_dp_aux_data *algo_data = adapter->algo_data;
-	int ret;
 
 	if (!algo_data->running)
 		return -EIO;
 
-	ret = i2c_algo_dp_aux_transaction(adapter, MODE_I2C_WRITE, byte, NULL);
-	return ret;
+	return i2c_algo_dp_aux_transaction(adapter, MODE_I2C_WRITE, byte, NULL);
 }
 
 /*
@@ -139,13 +135,11 @@ static int
 i2c_algo_dp_aux_get_byte(struct i2c_adapter *adapter, u8 *byte_ret)
 {
 	struct i2c_algo_dp_aux_data *algo_data = adapter->algo_data;
-	int ret;
 
 	if (!algo_data->running)
 		return -EIO;
 
-	ret = i2c_algo_dp_aux_transaction(adapter, MODE_I2C_READ, 0, byte_ret);
-	return ret;
+	return i2c_algo_dp_aux_transaction(adapter, MODE_I2C_READ, 0, byte_ret);
 }
 
 static int
-- 
2.25.1

