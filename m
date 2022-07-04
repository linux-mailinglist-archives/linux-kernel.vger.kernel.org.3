Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4841C564AE5
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 02:28:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233112AbiGDA2L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 20:28:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiGDA2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 20:28:08 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A0FB6259;
        Sun,  3 Jul 2022 17:28:07 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id n4so3769866wru.11;
        Sun, 03 Jul 2022 17:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e61HiYnOkxlIFlPtVK9g7qilEmpC+C4CRTA6gqMaRHM=;
        b=oTDIs/3gD7juvWWfvTV3CEV/Wcw0UAVCm9kMPKrCDMyBi+FCz4QC3hhy86/QKXbPCR
         qEw9kSZKHudVewqBgbZO6i5oKmSJvO8e/F28vr+L93InewTh/66neE0NYWBMBWiXQdYJ
         N+uTA28aXwGbfNe9esf5yPbD0I43LrmEvXOYBK9d8TqqJpJXZw2jkUpBpCippP8iPWPh
         tvXulVhPsiksJ8+M6CY/F0nlFNxMNSH6WTYRnRVp7sxSo/Y/vn4XF7Vy7T+jH0K83a/c
         x94LSMFWiuOrnuVDyw012xPmYmEWJW5QZSysUEfwESZsxzEf3ma8X+JlNpL93pVFx78q
         U30Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e61HiYnOkxlIFlPtVK9g7qilEmpC+C4CRTA6gqMaRHM=;
        b=sU3BBLLJ4JNbmDo9mCV0qr7TCh/zclt9bOHD3mfn2cqy3sICIl4MtQDu3iLWibRy4a
         NtvMPD2hAMCvSQXddVKFMUcwlY1QRXo8tOxp0qerhXS1LDtV1tvd8gzlvnw3W5x+/xqj
         APGWAd16Ws+XJ1+TeGW9CRaIwKvBk2Ezh6rbXnIPSlHyihkkBmM6lgkBCnVW2mLanSc7
         8nh2Ei7k+kK0+rMb7MlLMEETmp2ED/eLNM0/2uy80qnHaw9In5djbLCxtUOpuEPPHRWO
         6ix1Ok3qiveNQYQFme8g3DocDgAvhiRBbAsz8y9lrko8i6lZU6CyPT97cBXu5OiseRiJ
         JxKQ==
X-Gm-Message-State: AJIora/OtiJFboT8BTEVm9+QTKgB40fDIHq6RVTfsdc3Kxxxaw0Hj9FH
        z9VZQ9IL0elMF5Mg39gPZ5FYk38XC14=
X-Google-Smtp-Source: AGRyM1s5RvPF2J53ALVfqoRRAyPjMqF/JdNK8xQ5PsTpJxm11Oq9ZQhJ/76HcLkZnV5Wz93i4I7r3Q==
X-Received: by 2002:a05:6000:1ac7:b0:21d:134e:5d74 with SMTP id i7-20020a0560001ac700b0021d134e5d74mr25337164wry.78.1656894485482;
        Sun, 03 Jul 2022 17:28:05 -0700 (PDT)
Received: from xps-work.lan (214.red-83-37-4.dynamicip.rima-tde.net. [83.37.4.214])
        by smtp.gmail.com with ESMTPSA id j22-20020a05600c1c1600b003a046549a85sm14110820wms.37.2022.07.03.17.28.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Jul 2022 17:28:05 -0700 (PDT)
From:   Angel Iglesias <ang.iglesiasg@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     Angel Iglesias <ang.iglesiasg@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/5] iio: pressure: Kconfig: Add references to BMP380
Date:   Mon,  4 Jul 2022 02:27:45 +0200
Message-Id: <20220704002747.207401-1-ang.iglesiasg@gmail.com>
X-Mailer: git-send-email 2.36.1
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

Adds reference to BMP380 in bmp280 driver descriptions and symbols

Signed-off-by: Angel Iglesias <ang.iglesiasg@gmail.com>
---
 drivers/iio/pressure/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/pressure/Kconfig b/drivers/iio/pressure/Kconfig
index 0ff756cea63a..c73a52b5aed7 100644
--- a/drivers/iio/pressure/Kconfig
+++ b/drivers/iio/pressure/Kconfig
@@ -17,13 +17,13 @@ config ABP060MG
 	  will be called abp060mg.
 
 config BMP280
-	tristate "Bosch Sensortec BMP180/BMP280 pressure sensor I2C driver"
+	tristate "Bosch Sensortec BMP180/BMP280/BMP380 pressure sensor I2C driver"
 	depends on (I2C || SPI_MASTER)
 	select REGMAP
 	select BMP280_I2C if (I2C)
 	select BMP280_SPI if (SPI_MASTER)
 	help
-	  Say yes here to build support for Bosch Sensortec BMP180 and BMP280
+	  Say yes here to build support for Bosch Sensortec BMP1/2/380
 	  pressure and temperature sensors. Also supports the BME280 with
 	  an additional humidity sensor channel.
 
-- 
2.36.1

