Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFBF14BEE3A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 00:40:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237328AbiBUXdc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 18:33:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236985AbiBUXdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 18:33:00 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD3E924F3E;
        Mon, 21 Feb 2022 15:32:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645486353; x=1677022353;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7Sp016gWiFymeeK5GqSm/jmRV32k3K/juTtOS55z76U=;
  b=EhS5Uk7HnE81P99SCkqWVE7kh2WJiqcqr/Cww7RbEtlxCaTUIFxY5suJ
   NecmIvmxmhMogr21ePOma9i2nLI5T9hK4iDGntWXQNrX8V+fToC3x/8G1
   JQ9H73lieiDfFXguOUSSPCCm8pILnhgZRuA3pNdiMCeEwvBY/NwMgXCF7
   OdJuU0VMOETbe3JVtNrfEuu6P8oww2cT1Or5mKEbUR8eYGt1WYae230dw
   X5vJYrSMv1ppkHEV6ZLk0nuvD7nUcdYzRx/Jx35Mn1uwbOmf+R+owKBSZ
   h0j0F9LG4vSdwfuEdsWVpXkh/QzfGyWc2VJDn56WmwAfGvrEGUgpokzyd
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10265"; a="314841875"
X-IronPort-AV: E=Sophos;i="5.88,386,1635231600"; 
   d="scan'208";a="314841875"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2022 15:32:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,386,1635231600"; 
   d="scan'208";a="505303713"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 21 Feb 2022 15:32:30 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id EF3567CC; Tue, 22 Feb 2022 01:32:43 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH v1 8/8] iio: accel: adxl345: Remove unneeded blank lines
Date:   Tue, 22 Feb 2022 01:32:35 +0200
Message-Id: <20220221233235.86893-8-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220221233235.86893-1-andriy.shevchenko@linux.intel.com>
References: <20220221233235.86893-1-andriy.shevchenko@linux.intel.com>
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
 drivers/iio/accel/adxl345_i2c.c | 3 ---
 drivers/iio/accel/adxl345_spi.c | 3 ---
 2 files changed, 6 deletions(-)

diff --git a/drivers/iio/accel/adxl345_i2c.c b/drivers/iio/accel/adxl345_i2c.c
index 2b5e64c467ec..6fcd439ab554 100644
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
 	{ .compatible = "adi,adxl375", ADXL375 },
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
index 4bc4c842357d..aded5da4928e 100644
--- a/drivers/iio/accel/adxl345_spi.c
+++ b/drivers/iio/accel/adxl345_spi.c
@@ -40,7 +40,6 @@ static const struct spi_device_id adxl345_spi_id[] = {
 	{ "adxl375", ADXL375 },
 	{ }
 };
-
 MODULE_DEVICE_TABLE(spi, adxl345_spi_id);
 
 static const struct of_device_id adxl345_of_match[] = {
@@ -48,7 +47,6 @@ static const struct of_device_id adxl345_of_match[] = {
 	{ .compatible = "adi,adxl375", ADXL375 },
 	{ }
 };
-
 MODULE_DEVICE_TABLE(of, adxl345_of_match);
 
 static const struct acpi_device_id adxl345_acpi_match[] = {
@@ -66,7 +64,6 @@ static struct spi_driver adxl345_spi_driver = {
 	.probe		= adxl345_spi_probe,
 	.id_table	= adxl345_spi_id,
 };
-
 module_spi_driver(adxl345_spi_driver);
 
 MODULE_AUTHOR("Eva Rachel Retuya <eraretuya@gmail.com>");
-- 
2.34.1

