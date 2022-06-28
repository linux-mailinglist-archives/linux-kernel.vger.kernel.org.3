Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E911155EE0B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 21:46:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbiF1Tpw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 15:45:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231454AbiF1Tp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 15:45:29 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAA003BF8E;
        Tue, 28 Jun 2022 12:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656445144; x=1687981144;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=WFRvrLrs78r9lnnA1EVYp7hsPys2q5PlSUAARxpTtuQ=;
  b=QDIZ0azXgtPNSaFEzJiZnzabbHkVymkcQjtcwMR8lJRE5+SHi51WkqYU
   v2DLRRMYEwQ8OrZ0fimOLCmH7Di8omel6gavWYDbdrXCXnVL3Zf/sfOLe
   lroNofva8glxIwG5lW2WVocbW17p9sPlw7TyhqdApHzyh8cs17/RtjZzC
   RvUyJEDyA/NdvgZATVqcHP5xokINscbXA10RiTgo3+OcXuVi6z+ufEczx
   K6/F/qbYqQp16wfofWYZmiZWvUkOqG9/2IbLQtJre9H9Ybhvd3YdPferz
   rre5Mxg1cxiXGAfSP231DIZxEBQEFrBgG3piGEOsL0XMktfOkUJELjaTb
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10392"; a="262241171"
X-IronPort-AV: E=Sophos;i="5.92,229,1650956400"; 
   d="scan'208";a="262241171"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 12:39:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,229,1650956400"; 
   d="scan'208";a="540596666"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 28 Jun 2022 12:39:02 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 37383F1; Tue, 28 Jun 2022 22:39:08 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Michael Hennerich <michael.hennerich@analog.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v1 1/3] gpio: adp5588: Switch from of headers to mod_devicetable.h
Date:   Tue, 28 Jun 2022 22:39:03 +0300
Message-Id: <20220628193906.36350-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is nothing directly using of specific interfaces in this driver,
so lets not include the headers.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpio-adp5588.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/gpio/gpio-adp5588.c b/drivers/gpio/gpio-adp5588.c
index e388e75103f4..51ed23ba4645 100644
--- a/drivers/gpio/gpio-adp5588.c
+++ b/drivers/gpio/gpio-adp5588.c
@@ -6,7 +6,6 @@
  * Copyright 2009-2010 Analog Devices Inc.
  */
 
-#include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/init.h>
@@ -14,7 +13,8 @@
 #include <linux/gpio/driver.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
-#include <linux/of_device.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
 
 #include <linux/platform_data/adp5588.h>
 
@@ -427,18 +427,16 @@ static const struct i2c_device_id adp5588_gpio_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, adp5588_gpio_id);
 
-#ifdef CONFIG_OF
 static const struct of_device_id adp5588_gpio_of_id[] = {
 	{ .compatible = "adi," DRV_NAME, },
 	{},
 };
 MODULE_DEVICE_TABLE(of, adp5588_gpio_of_id);
-#endif
 
 static struct i2c_driver adp5588_gpio_driver = {
 	.driver = {
 		.name = DRV_NAME,
-		.of_match_table = of_match_ptr(adp5588_gpio_of_id),
+		.of_match_table = adp5588_gpio_of_id,
 	},
 	.probe_new = adp5588_gpio_probe,
 	.remove = adp5588_gpio_remove,
-- 
2.35.1

