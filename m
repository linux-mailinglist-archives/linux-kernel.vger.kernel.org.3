Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17D484A83D2
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 13:27:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235686AbiBCM1T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 07:27:19 -0500
Received: from mga09.intel.com ([134.134.136.24]:22670 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229653AbiBCM1S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 07:27:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643891238; x=1675427238;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=t+43pAAzTpKs/88JDXTPAQ1G3PUzcC6reh1Ne51FWI8=;
  b=Le3GoxoDPoIJFzP/nm0yZqiRXoPcWBv2THNe/DvbCe/O/9FhE9wnkVq/
   eY1pU1U/VltAfCtimSi3B5tHqRCqD/7k0/nLna9DB178H/m+KhiG4ErEg
   GGkSzREdhJFFe4gnxnpzI8bZaKvTN8TpCks0Zwsh9PEJBWrqtOjk8eodQ
   oyKQDyzuQcMr0/Wd5p6BZcYPica7M7Q77Ei+7rzskmn3kvRZNOgNJzwsJ
   mNZgnWvkXJUBMQdwHeg+LoLZ6WfAvhkUJYjGhprVQYU9e/j7s6/rtAgiP
   zHlgTMaZWUmnfsv/OiO8kJzNHfsnIS2AU9rDYku4+mlf/NE+2UXxAKdOi
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10246"; a="247898625"
X-IronPort-AV: E=Sophos;i="5.88,339,1635231600"; 
   d="scan'208";a="247898625"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2022 04:27:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,339,1635231600"; 
   d="scan'208";a="566385394"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 03 Feb 2022 04:27:16 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 59A9118D; Thu,  3 Feb 2022 14:27:30 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v1 1/1] iio: chemical: bme680: Switch from of headers to mod_devicetable.h
Date:   Thu,  3 Feb 2022 14:27:25 +0200
Message-Id: <20220203122725.75939-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is nothing directly using of specific interfaces in this driver,
so lets not include the headers.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/chemical/bme680_spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/chemical/bme680_spi.c b/drivers/iio/chemical/bme680_spi.c
index cc579a7ac5ce..0a064a395178 100644
--- a/drivers/iio/chemical/bme680_spi.c
+++ b/drivers/iio/chemical/bme680_spi.c
@@ -4,8 +4,8 @@
  *
  * Copyright (C) 2018 Himanshu Jha <himanshujha199640@gmail.com>
  */
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
-#include <linux/of.h>
 #include <linux/regmap.h>
 #include <linux/spi/spi.h>
 
-- 
2.34.1

