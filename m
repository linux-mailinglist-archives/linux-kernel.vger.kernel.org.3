Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6606E4BF43E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 10:01:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbiBVJAk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 04:00:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbiBVJAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 04:00:24 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8913813D577;
        Tue, 22 Feb 2022 00:59:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645520399; x=1677056399;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1c9hIlH3yPx51Kr/6d+A+9A79GZySCBX2XnqF73Hkz8=;
  b=jF5QNGZGd+X1D/dX3n9OBgMaWuBPGFynra6XY6K+Z3z1iGkOAZs3J382
   0HMfBhJVDBSbTKexkfppTMhhfdSsPCbRWt3z1419NTwMR/dLI5Q3ucn2u
   HjWLoEVDhdAQ5bzN2uqKPVFYdB2bJySiNcvKXNwwRiKUdNEnyLYSL0QmC
   QxBfVXYMKW8YTIzJg3sXaQH7CUasC2FNQGh0b8oNsH/utvo59TwtLprQK
   YSUvQN+5fuEeDA0663UzfAhvFPfJKYQxwt3js1PAltE2PqWYk8vhx/1Wv
   rbA6VvG3/2ysxBuYgGPZDtlc8M7/LiIpOruluN4XS/JWrkDpfOljAtfyS
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10265"; a="338076734"
X-IronPort-AV: E=Sophos;i="5.88,387,1635231600"; 
   d="scan'208";a="338076734"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2022 00:59:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,387,1635231600"; 
   d="scan'208";a="606621831"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 22 Feb 2022 00:59:57 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id EB82D811; Tue, 22 Feb 2022 11:00:10 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH v2 8/8] iio: accel: adxl345: Remove unneeded blank lines
Date:   Tue, 22 Feb 2022 11:00:09 +0200
Message-Id: <20220222090009.2060-8-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220222090009.2060-1-andriy.shevchenko@linux.intel.com>
References: <20220222090009.2060-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unneeded blank lines where they separate the data type definitions
and the macros which are using them.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: no changes
 drivers/iio/accel/adxl345_i2c.c | 3 ---
 drivers/iio/accel/adxl345_spi.c | 3 ---
 2 files changed, 6 deletions(-)

diff --git a/drivers/iio/accel/adxl345_i2c.c b/drivers/iio/accel/adxl345_i2c.c
index 1ceb9be13cdf..0d0b34cf2b69 100644
--- a/drivers/iio/accel/adxl345_i2c.c
+++ b/drivers/iio/accel/adxl345_i2c.c
@@ -36,7 +36,6 @@ static const struct i2c_device_id adxl345_i2c_id[] = {
 	{ "adxl375", ADXL375 },
 	{ }
 };
-
 MODULE_DEVICE_TABLE(i2c, adxl345_i2c_id);
 
 static const struct of_device_id adxl345_of_match[] = {
@@ -44,7 +43,6 @@ static const struct of_device_id adxl345_of_match[] = {
 	{ .compatible = "adi,adxl375", .data = (const void *)ADXL375 },
 	{ }
 };
-
 MODULE_DEVICE_TABLE(of, adxl345_of_match);
 
 static const struct acpi_device_id adxl345_acpi_match[] = {
@@ -62,7 +60,6 @@ static struct i2c_driver adxl345_i2c_driver = {
 	.probe_new	= adxl345_i2c_probe,
 	.id_table	= adxl345_i2c_id,
 };
-
 module_i2c_driver(adxl345_i2c_driver);
 
 MODULE_AUTHOR("Eva Rachel Retuya <eraretuya@gmail.com>");
diff --git a/drivers/iio/accel/adxl345_spi.c b/drivers/iio/accel/adxl345_spi.c
index 2f5fc565f1f4..aaade5808657 100644
--- a/drivers/iio/accel/adxl345_spi.c
+++ b/drivers/iio/accel/adxl345_spi.c
@@ -41,7 +41,6 @@ static const struct spi_device_id adxl345_spi_id[] = {
 	{ "adxl375", ADXL375 },
 	{ }
 };
-
 MODULE_DEVICE_TABLE(spi, adxl345_spi_id);
 
 static const struct of_device_id adxl345_of_match[] = {
@@ -49,7 +48,6 @@ static const struct of_device_id adxl345_of_match[] = {
 	{ .compatible = "adi,adxl375", .data = (const void *)ADXL375 },
 	{ }
 };
-
 MODULE_DEVICE_TABLE(of, adxl345_of_match);
 
 static const struct acpi_device_id adxl345_acpi_match[] = {
@@ -67,7 +65,6 @@ static struct spi_driver adxl345_spi_driver = {
 	.probe		= adxl345_spi_probe,
 	.id_table	= adxl345_spi_id,
 };
-
 module_spi_driver(adxl345_spi_driver);
 
 MODULE_AUTHOR("Eva Rachel Retuya <eraretuya@gmail.com>");
-- 
2.34.1

