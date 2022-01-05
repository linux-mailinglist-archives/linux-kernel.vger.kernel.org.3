Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9374485B4F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 23:07:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244854AbiAEWHi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 17:07:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244760AbiAEWHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 17:07:18 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C90FC0611FD
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jan 2022 14:07:17 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id h1so574016pls.11
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jan 2022 14:07:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3tBLstDG5IBEnUmNPwXxcy4jvFsdC689KoqRwrjBZDs=;
        b=RWmWQowAD/jDBIJu2NV5lsoHwP38cCvOKhoMGOFFYT4e+E8HS2CRI9z50Nn2qN7OIF
         jjvl4JGEyLv2x62JjAi6oJKkGoTUhgV8sGwXcFVPN9lY9TCXze3vX/l6EdA3MVmzyVFk
         XbfLAmutXj0AEtzBYQyFYapq1qtYUnv5mpxpY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3tBLstDG5IBEnUmNPwXxcy4jvFsdC689KoqRwrjBZDs=;
        b=VLKySsocBtd/JlPr4nWhjjBs1aw1jJ8asWkiqj3R7trPYfCmn+tIC1MOYt4vvCxMIg
         NhsRTMucnZcXb15gvgTRAYE8D7JZdRgBuvG0j4SnmQA0WKwM0WxEmTuTygoMQk1VlPOa
         C84rSbqdmnEP+LRcPJJbvAwydh32kFJmRVQeZaqDkrEcA2urGgwFmidRiH8iqMHc+I3H
         /6iUi8wEoNw7kp9CXcYdiQrboEM4qv6+/25CX2mfH4x+i82+r+hAtvvugo4tqIG9mSFT
         Pn81n1facLo21Q+CGhtR+VbhbiaQK7qmV34xhO047lDvU/jxEl0igdb1B/aLjX6s5guQ
         Q/aw==
X-Gm-Message-State: AOAM533rDi1KQdYuht7r38wbCzr58U8W55ZVhRMBDfLAzY4pIAtxDTtX
        vn/uISBpsMozA37aInQKAINSVw==
X-Google-Smtp-Source: ABdhPJzXJGH+x9AvUqWZcWT7CD7XSzohpE6eU7SeTEXlP3IyOMIluJoBIFIZCRVcGTpJoR8oyoIl9A==
X-Received: by 2002:a17:90a:4305:: with SMTP id q5mr6625529pjg.20.1641420436942;
        Wed, 05 Jan 2022 14:07:16 -0800 (PST)
Received: from localhost ([2620:15c:202:201:7fcd:6709:f1b5:a22a])
        by smtp.gmail.com with UTF8SMTPSA id f4sm103832pfj.25.2022.01.05.14.07.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jan 2022 14:07:16 -0800 (PST)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     bleung@chromium.org, groeck@chromium.org, myungjoo.ham@samsung.com,
        cw00.choi@samsung.com, benjamin.tissoires@redhat.com,
        jic23@kernel.org, dtor@chromium.org, hverkuil-cisco@xs4all.nl,
        mchehab@kernel.org, lee.jones@linaro.org, pmalani@chromium.org,
        sre@kernel.org, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, lgirdwood@gmail.com,
        a.zummo@towertech.it, cychiang@chromium.org, perex@perex.cz
Cc:     linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH 07/17] platform: chrome: Add PL_CHROMEOS dependency
Date:   Wed,  5 Jan 2022 14:06:43 -0800
Message-Id: <20220105220653.122451-8-gwendal@chromium.org>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
In-Reply-To: <20220105220653.122451-1-gwendal@chromium.org>
References: <20220105220653.122451-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use 'make nsdeps' to add missing dependencies.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 drivers/platform/chrome/cros_ec.c           | 1 +
 drivers/platform/chrome/cros_ec_chardev.c   | 1 +
 drivers/platform/chrome/cros_ec_debugfs.c   | 1 +
 drivers/platform/chrome/cros_ec_i2c.c       | 1 +
 drivers/platform/chrome/cros_ec_ishtp.c     | 1 +
 drivers/platform/chrome/cros_ec_lightbar.c  | 1 +
 drivers/platform/chrome/cros_ec_lpc.c       | 1 +
 drivers/platform/chrome/cros_ec_rpmsg.c     | 1 +
 drivers/platform/chrome/cros_ec_spi.c       | 1 +
 drivers/platform/chrome/cros_ec_sysfs.c     | 1 +
 drivers/platform/chrome/cros_ec_vbc.c       | 1 +
 drivers/platform/chrome/cros_usbpd_logger.c | 1 +
 12 files changed, 12 insertions(+)

diff --git a/drivers/platform/chrome/cros_ec.c b/drivers/platform/chrome/cros_ec.c
index fc5aa1525d13ca..9ca6759bfce587 100644
--- a/drivers/platform/chrome/cros_ec.c
+++ b/drivers/platform/chrome/cros_ec.c
@@ -398,4 +398,5 @@ EXPORT_SYMBOL(cros_ec_resume);
 #endif
 
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(PL_CHROMEOS);
 MODULE_DESCRIPTION("ChromeOS EC core driver");
diff --git a/drivers/platform/chrome/cros_ec_chardev.c b/drivers/platform/chrome/cros_ec_chardev.c
index e0bce869c49a92..666b291c3338ee 100644
--- a/drivers/platform/chrome/cros_ec_chardev.c
+++ b/drivers/platform/chrome/cros_ec_chardev.c
@@ -416,3 +416,4 @@ MODULE_ALIAS("platform:" DRV_NAME);
 MODULE_AUTHOR("Enric Balletbo i Serra <enric.balletbo@collabora.com>");
 MODULE_DESCRIPTION("ChromeOS EC Miscellaneous Character Driver");
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(PL_CHROMEOS);
diff --git a/drivers/platform/chrome/cros_ec_debugfs.c b/drivers/platform/chrome/cros_ec_debugfs.c
index 272c89837d745a..21b0f915eaca46 100644
--- a/drivers/platform/chrome/cros_ec_debugfs.c
+++ b/drivers/platform/chrome/cros_ec_debugfs.c
@@ -526,5 +526,6 @@ static struct platform_driver cros_ec_debugfs_driver = {
 module_platform_driver(cros_ec_debugfs_driver);
 
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(PL_CHROMEOS);
 MODULE_DESCRIPTION("Debug logs for ChromeOS EC");
 MODULE_ALIAS("platform:" DRV_NAME);
diff --git a/drivers/platform/chrome/cros_ec_i2c.c b/drivers/platform/chrome/cros_ec_i2c.c
index 30c8938c27d54e..7a1227058e5c13 100644
--- a/drivers/platform/chrome/cros_ec_i2c.c
+++ b/drivers/platform/chrome/cros_ec_i2c.c
@@ -373,4 +373,5 @@ static struct i2c_driver cros_ec_driver = {
 module_i2c_driver(cros_ec_driver);
 
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS(PL_CHROMEOS);
 MODULE_DESCRIPTION("I2C interface for ChromeOS Embedded Controller");
diff --git a/drivers/platform/chrome/cros_ec_ishtp.c b/drivers/platform/chrome/cros_ec_ishtp.c
index 4020b8354bae90..3ba619cfae8f75 100644
--- a/drivers/platform/chrome/cros_ec_ishtp.c
+++ b/drivers/platform/chrome/cros_ec_ishtp.c
@@ -794,3 +794,4 @@ MODULE_DESCRIPTION("ChromeOS EC ISHTP Client Driver");
 MODULE_AUTHOR("Rushikesh S Kadam <rushikesh.s.kadam@intel.com>");
 
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS(PL_CHROMEOS);
diff --git a/drivers/platform/chrome/cros_ec_lightbar.c b/drivers/platform/chrome/cros_ec_lightbar.c
index 469dfc7a4a0302..578a73bc9e2bb7 100644
--- a/drivers/platform/chrome/cros_ec_lightbar.c
+++ b/drivers/platform/chrome/cros_ec_lightbar.c
@@ -609,5 +609,6 @@ static struct platform_driver cros_ec_lightbar_driver = {
 module_platform_driver(cros_ec_lightbar_driver);
 
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(PL_CHROMEOS);
 MODULE_DESCRIPTION("Expose the Chromebook Pixel's lightbar to userspace");
 MODULE_ALIAS("platform:" DRV_NAME);
diff --git a/drivers/platform/chrome/cros_ec_lpc.c b/drivers/platform/chrome/cros_ec_lpc.c
index d6306d2a096f13..016970479de80e 100644
--- a/drivers/platform/chrome/cros_ec_lpc.c
+++ b/drivers/platform/chrome/cros_ec_lpc.c
@@ -597,4 +597,5 @@ module_init(cros_ec_lpc_init);
 module_exit(cros_ec_lpc_exit);
 
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(PL_CHROMEOS);
 MODULE_DESCRIPTION("ChromeOS EC LPC driver");
diff --git a/drivers/platform/chrome/cros_ec_rpmsg.c b/drivers/platform/chrome/cros_ec_rpmsg.c
index d96d15b8ca946d..87c087c557413f 100644
--- a/drivers/platform/chrome/cros_ec_rpmsg.c
+++ b/drivers/platform/chrome/cros_ec_rpmsg.c
@@ -304,4 +304,5 @@ static struct rpmsg_driver cros_ec_driver_rpmsg = {
 module_rpmsg_driver(cros_ec_driver_rpmsg);
 
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS(PL_CHROMEOS);
 MODULE_DESCRIPTION("ChromeOS EC multi function device (rpmsg)");
diff --git a/drivers/platform/chrome/cros_ec_spi.c b/drivers/platform/chrome/cros_ec_spi.c
index 14c4046fa04d52..88771bda2bf3be 100644
--- a/drivers/platform/chrome/cros_ec_spi.c
+++ b/drivers/platform/chrome/cros_ec_spi.c
@@ -838,4 +838,5 @@ static struct spi_driver cros_ec_driver_spi = {
 module_spi_driver(cros_ec_driver_spi);
 
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS(PL_CHROMEOS);
 MODULE_DESCRIPTION("SPI interface for ChromeOS Embedded Controller");
diff --git a/drivers/platform/chrome/cros_ec_sysfs.c b/drivers/platform/chrome/cros_ec_sysfs.c
index f07eabcf9494cd..bf5be8f3db129e 100644
--- a/drivers/platform/chrome/cros_ec_sysfs.c
+++ b/drivers/platform/chrome/cros_ec_sysfs.c
@@ -368,5 +368,6 @@ static struct platform_driver cros_ec_sysfs_driver = {
 module_platform_driver(cros_ec_sysfs_driver);
 
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(PL_CHROMEOS);
 MODULE_DESCRIPTION("Expose the ChromeOS EC through sysfs");
 MODULE_ALIAS("platform:" DRV_NAME);
diff --git a/drivers/platform/chrome/cros_ec_vbc.c b/drivers/platform/chrome/cros_ec_vbc.c
index c859c862d7ac55..ea98b708e34f85 100644
--- a/drivers/platform/chrome/cros_ec_vbc.c
+++ b/drivers/platform/chrome/cros_ec_vbc.c
@@ -142,5 +142,6 @@ static struct platform_driver cros_ec_vbc_driver = {
 module_platform_driver(cros_ec_vbc_driver);
 
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(PL_CHROMEOS);
 MODULE_DESCRIPTION("Expose the vboot context nvram to userspace");
 MODULE_ALIAS("platform:" DRV_NAME);
diff --git a/drivers/platform/chrome/cros_usbpd_logger.c b/drivers/platform/chrome/cros_usbpd_logger.c
index d16931203d8216..d322da22940b59 100644
--- a/drivers/platform/chrome/cros_usbpd_logger.c
+++ b/drivers/platform/chrome/cros_usbpd_logger.c
@@ -263,5 +263,6 @@ static struct platform_driver cros_usbpd_logger_driver = {
 module_platform_driver(cros_usbpd_logger_driver);
 
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS(PL_CHROMEOS);
 MODULE_DESCRIPTION("Logging driver for ChromeOS EC USBPD Charger.");
 MODULE_ALIAS("platform:" DRV_NAME);
-- 
2.34.1.448.ga2b2bfdf31-goog

