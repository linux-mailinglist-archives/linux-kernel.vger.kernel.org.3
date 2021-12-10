Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0BA74705BA
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 17:30:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243460AbhLJQdq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 11:33:46 -0500
Received: from mga12.intel.com ([192.55.52.136]:44543 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240513AbhLJQdo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 11:33:44 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10193"; a="218396693"
X-IronPort-AV: E=Sophos;i="5.88,196,1635231600"; 
   d="scan'208";a="218396693"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2021 08:30:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,196,1635231600"; 
   d="scan'208";a="581724173"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 10 Dec 2021 08:30:06 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id E5055329; Fri, 10 Dec 2021 18:30:12 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        "Luke D. Jones" <luke@ljones.dev>,
        acpi4asus-user@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Corentin Chary <corentin.chary@gmail.com>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 3/3] platform/x86: asus-wmi: Reshuffle headers for better maintenance
Date:   Fri, 10 Dec 2021 18:30:09 +0200
Message-Id: <20211210163009.19894-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211210163009.19894-1-andriy.shevchenko@linux.intel.com>
References: <20211210163009.19894-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reshuffle headers in alphabetical order for better maintenance.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/platform/x86/asus-wmi.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index c3e0394aa5f0..a3b83b22a3b1 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -13,29 +13,29 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
-#include <linux/kernel.h>
-#include <linux/module.h>
+#include <linux/acpi.h>
+#include <linux/backlight.h>
+#include <linux/debugfs.h>
+#include <linux/dmi.h>
+#include <linux/fb.h>
+#include <linux/hwmon.h>
+#include <linux/hwmon-sysfs.h>
 #include <linux/init.h>
-#include <linux/types.h>
-#include <linux/slab.h>
 #include <linux/input.h>
 #include <linux/input/sparse-keymap.h>
-#include <linux/fb.h>
-#include <linux/backlight.h>
+#include <linux/kernel.h>
 #include <linux/leds.h>
-#include <linux/rfkill.h>
+#include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/pci_hotplug.h>
+#include <linux/platform_data/x86/asus-wmi.h>
+#include <linux/platform_device.h>
 #include <linux/platform_profile.h>
 #include <linux/power_supply.h>
-#include <linux/hwmon.h>
-#include <linux/hwmon-sysfs.h>
-#include <linux/debugfs.h>
+#include <linux/rfkill.h>
 #include <linux/seq_file.h>
-#include <linux/platform_data/x86/asus-wmi.h>
-#include <linux/platform_device.h>
-#include <linux/acpi.h>
-#include <linux/dmi.h>
+#include <linux/slab.h>
+#include <linux/types.h>
 #include <linux/units.h>
 
 #include <acpi/battery.h>
-- 
2.33.0

