Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 088584BF440
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 10:01:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbiBVJAg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 04:00:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbiBVJAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 04:00:24 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99B3913D57B;
        Tue, 22 Feb 2022 00:59:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645520399; x=1677056399;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PEBKM9cjvF9E46ZXCcu9Vcaz3w5crzSB7igw+tUNYp4=;
  b=WMWAYlY61VDrOdrDci6D/nXLsn7yC4NZlacymdN4hbBNVrO8Vssmn92a
   tjuQ48b1ttFG53Q2m/WvEwgGhp6/eUsYTjgtRET6oYfwJOXc4fgpvYuvY
   samM9kBflibsl/IAh5E6cad3KI8MAlD6v2v3gDU41D+NJSQKyTvhcIqe0
   Bp74dejAz7CBhHTuLvfEcJ+6aPey34ZgWLV79pQCT3Xc1fWWpMMJad85F
   dgEn1msUe3rdDez44jWduBOZc00kXVTzfPcJh0H0KnwRramwwSfkmRgIo
   WsDIe6dY0M+/5YlCNuCAVEHcW1k62IxE0mWzZoGBzhJg1D2JtiLd3YiJf
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10265"; a="232263794"
X-IronPort-AV: E=Sophos;i="5.88,387,1635231600"; 
   d="scan'208";a="232263794"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2022 00:59:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,387,1635231600"; 
   d="scan'208";a="683448552"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 22 Feb 2022 00:59:57 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id E00127CC; Tue, 22 Feb 2022 11:00:10 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH v2 7/8] iio: accel: adxl345: Drop comma in terminator entries
Date:   Tue, 22 Feb 2022 11:00:08 +0200
Message-Id: <20220222090009.2060-7-andriy.shevchenko@linux.intel.com>
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

Terminator entries are by definition should terminate the array.
Dropping comma make this enforced at compile time.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: no changes
 drivers/iio/accel/adxl345_core.c | 2 +-
 drivers/iio/accel/adxl345_i2c.c  | 2 +-
 drivers/iio/accel/adxl345_spi.c  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index 4e4562fc35c9..370bfec1275a 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -195,7 +195,7 @@ static IIO_CONST_ATTR_SAMP_FREQ_AVAIL(
 
 static struct attribute *adxl345_attrs[] = {
 	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
-	NULL,
+	NULL
 };
 
 static const struct attribute_group adxl345_attrs_group = {
diff --git a/drivers/iio/accel/adxl345_i2c.c b/drivers/iio/accel/adxl345_i2c.c
index 11ecff0e0405..1ceb9be13cdf 100644
--- a/drivers/iio/accel/adxl345_i2c.c
+++ b/drivers/iio/accel/adxl345_i2c.c
@@ -42,7 +42,7 @@ MODULE_DEVICE_TABLE(i2c, adxl345_i2c_id);
 static const struct of_device_id adxl345_of_match[] = {
 	{ .compatible = "adi,adxl345", .data = (const void *)ADXL345 },
 	{ .compatible = "adi,adxl375", .data = (const void *)ADXL375 },
-	{ },
+	{ }
 };
 
 MODULE_DEVICE_TABLE(of, adxl345_of_match);
diff --git a/drivers/iio/accel/adxl345_spi.c b/drivers/iio/accel/adxl345_spi.c
index 850ac616d65e..2f5fc565f1f4 100644
--- a/drivers/iio/accel/adxl345_spi.c
+++ b/drivers/iio/accel/adxl345_spi.c
@@ -47,7 +47,7 @@ MODULE_DEVICE_TABLE(spi, adxl345_spi_id);
 static const struct of_device_id adxl345_of_match[] = {
 	{ .compatible = "adi,adxl345", .data = (const void *)ADXL345 },
 	{ .compatible = "adi,adxl375", .data = (const void *)ADXL375 },
-	{ },
+	{ }
 };
 
 MODULE_DEVICE_TABLE(of, adxl345_of_match);
-- 
2.34.1

