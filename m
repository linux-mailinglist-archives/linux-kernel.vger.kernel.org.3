Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B99D854ED9D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 00:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379142AbiFPWty (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 18:49:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378446AbiFPWtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 18:49:51 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61FCD6221C;
        Thu, 16 Jun 2022 15:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655419790; x=1686955790;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=M/kbs4hpuxBedGBjPKpdONcCTJKC9Sqi4XBKaUNYaVM=;
  b=R2A7fMHwoC30MyqZiuv5LXESoHnUwaULj3GnUGvXe+2nmS5uVj+drsIH
   O8jqULkwWqSh9Mnp8bMguNUAm28X4qGGWsmL2ymb70DKkgN1/3+gfQz9M
   qMmTS1r2az0cB/trJOaNz1qzEs8QiXOSYhAycCW4a8WbFVEKpL/oxY3aG
   +06nNhO+1LO/GQxdwkL2NoUkaywCu6v7SOG5zFlxA6R19ARPRZFCIqenS
   nHAT8SfJGSpbtP6hVxWl+oRLt1wzSZSr4nt3YJJU+GUtOdsyb4yjvGa0m
   zTHmvEMTIyxBchv0B6bGxB1Jy/nb4j/JwtD14UQhreiYg0jpszPDzLwPL
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="280083249"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="280083249"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2022 15:49:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="583816357"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 16 Jun 2022 15:49:47 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 3B35E109; Fri, 17 Jun 2022 01:49:51 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/2] platform/x86: thinkpad_acpi: Sort headers for better maintenance
Date:   Fri, 17 Jun 2022 01:49:50 +0300
Message-Id: <20220616224951.66660-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's quite hard to understand in that zillions of headers that are included
if any specific one is already listed. Sort headers for better maintenance.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/platform/x86/thinkpad_acpi.c | 58 +++++++++++++++-------------
 1 file changed, 31 insertions(+), 27 deletions(-)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index e6cb4a14cdd4..eab50d47f567 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -34,46 +34,50 @@
  *			    thanks to Chris Wright <chrisw@osdl.org>
  */
 
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/init.h>
-#include <linux/types.h>
-#include <linux/string.h>
-#include <linux/list.h>
-#include <linux/mutex.h>
-#include <linux/sched.h>
-#include <linux/sched/signal.h>
-#include <linux/kthread.h>
-#include <linux/freezer.h>
-#include <linux/delay.h>
-#include <linux/slab.h>
-#include <linux/nvram.h>
-#include <linux/proc_fs.h>
-#include <linux/seq_file.h>
-#include <linux/sysfs.h>
+#include <linux/acpi.h>
 #include <linux/backlight.h>
 #include <linux/bitops.h>
+#include <linux/delay.h>
+#include <linux/dmi.h>
 #include <linux/fb.h>
-#include <linux/platform_device.h>
+#include <linux/freezer.h>
 #include <linux/hwmon.h>
 #include <linux/hwmon-sysfs.h>
+#include <linux/init.h>
 #include <linux/input.h>
-#include <linux/leds.h>
-#include <linux/rfkill.h>
-#include <linux/dmi.h>
 #include <linux/jiffies.h>
-#include <linux/workqueue.h>
-#include <linux/acpi.h>
+#include <linux/kernel.h>
+#include <linux/kthread.h>
+#include <linux/leds.h>
+#include <linux/list.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/nvram.h>
 #include <linux/pci.h>
-#include <linux/power_supply.h>
+#include <linux/platform_device.h>
 #include <linux/platform_profile.h>
-#include <sound/core.h>
-#include <sound/control.h>
-#include <sound/initval.h>
+#include <linux/power_supply.h>
+#include <linux/proc_fs.h>
+#include <linux/rfkill.h>
+#include <linux/sched.h>
+#include <linux/sched/signal.h>
+#include <linux/seq_file.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+#include <linux/sysfs.h>
+#include <linux/types.h>
 #include <linux/uaccess.h>
+#include <linux/workqueue.h>
+
 #include <acpi/battery.h>
 #include <acpi/video.h>
+
 #include <drm/drm_privacy_screen_driver.h>
+
+#include <sound/control.h>
+#include <sound/core.h>
+#include <sound/initval.h>
+
 #include "dual_accel_detect.h"
 
 /* ThinkPad CMOS commands */
-- 
2.35.1

