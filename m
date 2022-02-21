Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 607164BEE41
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 00:40:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237264AbiBUXd2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 18:33:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237021AbiBUXdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 18:33:02 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D39F525583;
        Mon, 21 Feb 2022 15:32:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645486354; x=1677022354;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=J9T0Ru/E/pDZCa82wTTPnm1pIG14c3Q6XR+ip3LKuxo=;
  b=kCroSEi6n+cv3ptBLg33miTywlknXQjxXVq/0yG80KVdB6yNqFpQZJrc
   0YMGpKJRg8jijOMrcqoavht84/1EX2Cca3XisuhuKvkXKya0E8Q/RzKj/
   zfqWdQ0Xe0PhKHSxDie+ng7eeLSqnYclXq5L3SU3ZVjRhiguDWly/yVWD
   /1mngq93/5g39L4ExgXYZHvQVphlplvlYFinbF6QMQhLjsCbSlzkhym7z
   4ZnT4rN/7LXCIRW9F8GvtYEBIbNa7t3XF+EzoeOo1U19/znzTgLk70UqX
   UihW4HEpTncTvkQvboNmv3e0izVSc+Uwt70G7vqwRPl6ERKkZg0UvHrP6
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10265"; a="251347128"
X-IronPort-AV: E=Sophos;i="5.88,386,1635231600"; 
   d="scan'208";a="251347128"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2022 15:32:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,386,1635231600"; 
   d="scan'208";a="627497023"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 21 Feb 2022 15:32:30 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id E6982763; Tue, 22 Feb 2022 01:32:43 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH v1 7/8] iio: accel: adxl345: Drop comma in terminator entries
Date:   Tue, 22 Feb 2022 01:32:34 +0200
Message-Id: <20220221233235.86893-7-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220221233235.86893-1-andriy.shevchenko@linux.intel.com>
References: <20220221233235.86893-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Terminator entries are by definition should terminate the array.
Dropping comma make this enforced at compile time.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
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
index 3216345e87bf..2b5e64c467ec 100644
--- a/drivers/iio/accel/adxl345_i2c.c
+++ b/drivers/iio/accel/adxl345_i2c.c
@@ -42,7 +42,7 @@ MODULE_DEVICE_TABLE(i2c, adxl345_i2c_id);
 static const struct of_device_id adxl345_of_match[] = {
 	{ .compatible = "adi,adxl345", ADXL345 },
 	{ .compatible = "adi,adxl375", ADXL375 },
-	{ },
+	{ }
 };
 
 MODULE_DEVICE_TABLE(of, adxl345_of_match);
diff --git a/drivers/iio/accel/adxl345_spi.c b/drivers/iio/accel/adxl345_spi.c
index 784e41965f00..4bc4c842357d 100644
--- a/drivers/iio/accel/adxl345_spi.c
+++ b/drivers/iio/accel/adxl345_spi.c
@@ -46,7 +46,7 @@ MODULE_DEVICE_TABLE(spi, adxl345_spi_id);
 static const struct of_device_id adxl345_of_match[] = {
 	{ .compatible = "adi,adxl345", ADXL345 },
 	{ .compatible = "adi,adxl375", ADXL375 },
-	{ },
+	{ }
 };
 
 MODULE_DEVICE_TABLE(of, adxl345_of_match);
-- 
2.34.1

