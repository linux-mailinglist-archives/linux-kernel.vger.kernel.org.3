Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2BB64A79D0
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 21:55:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347330AbiBBUzX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 15:55:23 -0500
Received: from mga09.intel.com ([134.134.136.24]:64097 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347331AbiBBUzU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 15:55:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643835321; x=1675371321;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=CdJlJPui20ZYUBnP9Qq9k7eB0SBmLsgUn7XCbKkohes=;
  b=FYi/pndRo+o1/Qg21NHeY6CLwmvFcUD+5PHSCdzVMBOkghqT7XUNXuxq
   cyjsNETFw2s1E9xPmWkXRl5J6qR7CufeCtWsaMAyNIGtxxTo8nGTsrAqK
   l6jciG2ME7+DgG0R7rizkFVAGlFnvRa6rSLTelPBoJfZI6kbiS8YKmyap
   W2dUS76R/uUM3t1RUudbA1kob5ed6n/Ufzl7s9YEMiZG+78garTKzDgDO
   j1sZELLN585GcIp1o3p89deWEMphONt0+cp+cQVlCq8c9cdT3mQ6xDtXZ
   CP5m2F63hFB3GJ+hzLNoQDG/geuIGkhQbEqsfA2UsHp8U/3UTJDKabNiM
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10246"; a="247785420"
X-IronPort-AV: E=Sophos;i="5.88,337,1635231600"; 
   d="scan'208";a="247785420"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 12:55:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,337,1635231600"; 
   d="scan'208";a="480247469"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 02 Feb 2022 12:55:18 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 7F5D93B7; Wed,  2 Feb 2022 22:55:32 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Crt Mori <cmo@melexis.com>, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v1 1/1] iio: temperature: mlx90632: Switch from of headers to mod_devicetable.h
Date:   Wed,  2 Feb 2022 22:55:31 +0200
Message-Id: <20220202205531.57966-1-andriy.shevchenko@linux.intel.com>
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
 drivers/iio/temperature/mlx90632.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/temperature/mlx90632.c b/drivers/iio/temperature/mlx90632.c
index 608ccb1d8bc8..7ee7ff8047a4 100644
--- a/drivers/iio/temperature/mlx90632.c
+++ b/drivers/iio/temperature/mlx90632.c
@@ -13,9 +13,9 @@
 #include <linux/iopoll.h>
 #include <linux/kernel.h>
 #include <linux/limits.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/math64.h>
-#include <linux/of.h>
 #include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 
-- 
2.34.1

