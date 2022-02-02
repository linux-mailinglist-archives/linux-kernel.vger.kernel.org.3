Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ACA84A7991
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 21:34:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347247AbiBBUeN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 15:34:13 -0500
Received: from mga02.intel.com ([134.134.136.20]:57185 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347204AbiBBUeK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 15:34:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643834050; x=1675370050;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=kaGF4zjlVjQH2cLghkyhdzSJMil11mI8Tptz4ANS6PM=;
  b=PeFPqvOMau6M+KTflin2Se8vb+/drPSY4QCL6Ppb49C0kCO71vX3Dbzb
   TOK8vQL8WA+buDBoAvbZzP7QUM82FJy3u4pKEI5st+/Ivg18TRV/UnPwE
   guNVCLjWC5/J4e8TKk3QXbbvuGrXxe0NobjM9l/2trcqxtsED45nxRrqV
   JeSSi1pvqdjPaQjZwRw6NeKCfi45MNXKGelFKybpfGi2Iv9+QC8gOiuZD
   W+PBrBFR23vIOrXadH43qkvWf2UXT7XXpWD0NoL7HRdzp9YFrRFAWjCHN
   o+ict0CT/MDJAzPV2tT9RX0x9gcugRmy4YNgHhS2G3ef4BTpIc/VBGbo4
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10246"; a="235414790"
X-IronPort-AV: E=Sophos;i="5.88,337,1635231600"; 
   d="scan'208";a="235414790"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 12:34:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,337,1635231600"; 
   d="scan'208";a="627205583"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 02 Feb 2022 12:34:08 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 7C5C23B7; Wed,  2 Feb 2022 22:34:22 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v1 1/1] iio: humidity: dht11: Switch from of headers to mod_devicetable.h
Date:   Wed,  2 Feb 2022 22:34:20 +0200
Message-Id: <20220202203420.56654-1-andriy.shevchenko@linux.intel.com>
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
 drivers/iio/humidity/dht11.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/humidity/dht11.c b/drivers/iio/humidity/dht11.c
index 9a7819817488..c97e25448772 100644
--- a/drivers/iio/humidity/dht11.c
+++ b/drivers/iio/humidity/dht11.c
@@ -11,10 +11,9 @@
 #include <linux/kernel.h>
 #include <linux/printk.h>
 #include <linux/slab.h>
-#include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/sysfs.h>
 #include <linux/io.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/wait.h>
-- 
2.34.1

