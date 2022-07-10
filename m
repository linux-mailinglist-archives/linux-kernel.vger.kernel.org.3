Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DDAD56CE5A
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 11:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbiGJJQb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 05:16:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiGJJQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 05:16:30 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F6481116F;
        Sun, 10 Jul 2022 02:16:29 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id v67-20020a1cac46000000b003a1888b9d36so3432276wme.0;
        Sun, 10 Jul 2022 02:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Wk03GQ0nSPYqIEk1dZzt6VvmKU7y/8252uMqRAR8CRY=;
        b=lnOa2OrmGZXQoo4U96oCF3147qcSMQyzUZhuTR8ZTHgk0sCyP59mV6M7nwyXb4coD8
         oC0QMh0e252gQZr06eCRQ5cykUep4JYZjKQMQKVq5G6XUbJYa4Z8tIAWQouWaySTERGc
         qnM+QiTGwsI/Y159nE967HjbT8jiBA/x/kXzyTnilsL4tCiLbN3uuzZS1UxkQVKh4CW1
         fjMwpOD4c+L4u9Y3vgkroC1u2f1igPa+1zmJEkw6JBv6BM5QgUVaqsr6x2UmcPXvSd5x
         SuJagatcOV/pM0zK6EEMO1v+QqGU35PFRF1Wy6jaDjS2QN9+cClBLBtxb+7NppeTslCi
         Y3OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Wk03GQ0nSPYqIEk1dZzt6VvmKU7y/8252uMqRAR8CRY=;
        b=H8tjD1jbDN3Kmtv51iFV8DD3fGxD+/KTIlHNsHT+98F8/lMfga3gYzRWntZecj637S
         sES7ukoxRynXkoXdEtghPITPO4dtD+I8VR3Yl4F/1B7wAwZmqoSvwG4yn8HfYcNHgKT1
         lONu/ZWM23k/WXACAtIY5NsF8ng4MIipH9QgacVGYnIt/6znWkTRsN70FEgNbJ+oOAbb
         UIWh22Z4VMzLRC3lX8xCZoI7gSm7yZDfp2raR9Nd+qOOVRFEzi5jZbFNKJTgtGIseX0o
         Qv9z/UCNzrD5bGOwZe82Wdul5ysY9KxlSH7WjuQ/C/wybdAwXPpsJm0LXT98r8Vh1znv
         FWAA==
X-Gm-Message-State: AJIora8Crp0e86wrdupw6XBxW9XuCFMs3TJ7vNeyzPYlSX37eCxBgX5+
        ybEgzAGVY5dcJYblFJedKDQ=
X-Google-Smtp-Source: AGRyM1sjw0koCCA2LlABsjzsANrayWgZ6Q8pHskW/7mzOeFTnHWWKu38ONlz86dhve/zO6DsHYG7Nw==
X-Received: by 2002:a05:600c:4f03:b0:3a0:55a2:bb4 with SMTP id l3-20020a05600c4f0300b003a055a20bb4mr9402455wmq.181.1657444587982;
        Sun, 10 Jul 2022 02:16:27 -0700 (PDT)
Received: from xps-work.lan (214.red-83-37-4.dynamicip.rima-tde.net. [83.37.4.214])
        by smtp.gmail.com with ESMTPSA id i2-20020adfdec2000000b0021d76985929sm3143569wrn.80.2022.07.10.02.16.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jul 2022 02:16:27 -0700 (PDT)
From:   Angel Iglesias <ang.iglesiasg@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Angel Iglesias <ang.iglesiasg@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/5] iio: pressure: Kconfig: Add references to BMP380
Date:   Sun, 10 Jul 2022 11:16:17 +0200
Message-Id: <20220710091618.15890-1-ang.iglesiasg@gmail.com>
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
 drivers/iio/pressure/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/pressure/Kconfig b/drivers/iio/pressure/Kconfig
index 0ff756cea63a..c9453389e4f7 100644
--- a/drivers/iio/pressure/Kconfig
+++ b/drivers/iio/pressure/Kconfig
@@ -17,14 +17,14 @@ config ABP060MG
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
-	  pressure and temperature sensors. Also supports the BME280 with
+	  Say yes here to build support for Bosch Sensortec BMP180, BMP280 and
+	  BMP380 pressure and temperature sensors. Also supports the BME280 with
 	  an additional humidity sensor channel.
 
 	  To compile this driver as a module, choose M here: the core module
-- 
2.36.1

