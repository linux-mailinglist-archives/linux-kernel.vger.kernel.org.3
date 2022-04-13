Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF37E4FFE18
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 20:45:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236735AbiDMSr2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 14:47:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233329AbiDMSr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 14:47:27 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C401451312;
        Wed, 13 Apr 2022 11:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649875505; x=1681411505;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=5ThnHmPmDATZ6h79VWKU2Znwd4VMv+7OYSzt5p/0Kbo=;
  b=ZuaGR0vk6PmemhSkvRkvrvOmWYxU55Y9jHxdB/3KI1JD/0js0lYROdGw
   l2GJPmYrlWlWbThs6mLUTnLYxTtQTI4O1tn6WSfMu/uQKPtoLv7jtWavH
   u3f34lBZUAqcTnRgSd7YSNVYlCXvES3+xyrONfieHAizGpOh2O+181CN+
   Ume+Fq2IeTljCF4Ils1m0rHslLL59O+F7jwMlN/Qzu/0rv9dvM7SlmqdS
   g0g6Xut8BNEXy66U7nFxRbgoOUaxsqaWGNzklcUC1AhXXAvMDHkaNBa8J
   roJ+UYHeoSUgUZIvMilMDh93KvOHoZ1WoooDXnFPrTWxEpndMpF/ULyem
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10316"; a="261592759"
X-IronPort-AV: E=Sophos;i="5.90,257,1643702400"; 
   d="scan'208";a="261592759"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 11:45:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,257,1643702400"; 
   d="scan'208";a="725015341"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 13 Apr 2022 11:45:03 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 2655612C; Wed, 13 Apr 2022 21:45:03 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] iio: magnetometer: ak8974: Drop dependency on OF
Date:   Wed, 13 Apr 2022 21:45:02 +0300
Message-Id: <20220413184502.20998-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
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

Nothing in this driver depends on OF firmware so drop the dependency
and update the headers to remove the false impression such a dependency
exists.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/magnetometer/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/magnetometer/Kconfig b/drivers/iio/magnetometer/Kconfig
index 54445365c4bc..07eb619bcfe8 100644
--- a/drivers/iio/magnetometer/Kconfig
+++ b/drivers/iio/magnetometer/Kconfig
@@ -9,7 +9,6 @@ menu "Magnetometer sensors"
 config AK8974
 	tristate "Asahi Kasei AK8974 3-Axis Magnetometer"
 	depends on I2C
-	depends on OF
 	select REGMAP_I2C
 	select IIO_BUFFER
 	select IIO_TRIGGERED_BUFFER
-- 
2.35.1

