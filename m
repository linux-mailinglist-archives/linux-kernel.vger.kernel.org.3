Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 146A256168F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 11:39:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233276AbiF3Jiz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 05:38:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233082AbiF3JiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 05:38:19 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4983D21806;
        Thu, 30 Jun 2022 02:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656581896; x=1688117896;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Vj93OUArCPcOzTNax7R55Pn3eOycZ1bTRsIknl2WeMY=;
  b=FodXDyTfyaIrXHE8mTzvq6B/cEnJoybljYfP6Iw/KEatIfbly86BLmup
   ZBtYAuAUNDAQA1ibBRsz45eNGSMqe+9iOQHN5pT6wYJKtkV1VjtJg29EL
   nDmXziKKcENzj4r9Vi3jTbHCFMs6I6PhH3DE5CVWl8kBwIzJr9+2ps404
   INIewe1T1e9pJgLQ79+6aQyZ5pNNYqXi7FSjTUxjtvNjCYnDhryXIGLzS
   SRAMhkWsk7EXEazIemfgG+t2QjVaGsnPfy3SKf10BaSYsICF/j9AgvaxK
   LDEW+LeYJNh/FZ3FxYYpXgUnor11Konp05y3LrJrjGBtDD9Txe/TMNDa4
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10393"; a="283399328"
X-IronPort-AV: E=Sophos;i="5.92,233,1650956400"; 
   d="scan'208";a="283399328"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2022 02:38:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,233,1650956400"; 
   d="scan'208";a="768062873"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 30 Jun 2022 02:38:14 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 54DDD11E; Thu, 30 Jun 2022 12:38:20 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH v1 1/1] serial: 8250_dw: Sort headers alphabetically
Date:   Thu, 30 Jun 2022 12:38:16 +0300
Message-Id: <20220630093816.28271-1-andriy.shevchenko@linux.intel.com>
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

For the sake of better maintenance, sort included headers alphabetically.
While at it, split the serial group of headers which makes clear the
subsystem the driver belongs to.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/8250/8250_dw.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index d5df17455f1d..86762593579f 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -9,26 +9,27 @@
  * LCR is written whilst busy.  If it is, then a busy detect interrupt is
  * raised, the LCR needs to be rewritten and the uart status register read.
  */
+#include <linux/acpi.h>
+#include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/io.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
-#include <linux/serial_8250.h>
-#include <linux/serial_reg.h>
+#include <linux/notifier.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/property.h>
-#include <linux/workqueue.h>
-#include <linux/notifier.h>
-#include <linux/slab.h>
-#include <linux/acpi.h>
-#include <linux/clk.h>
 #include <linux/reset.h>
-#include <linux/pm_runtime.h>
+#include <linux/slab.h>
+#include <linux/workqueue.h>
 
 #include <asm/byteorder.h>
 
+#include <linux/serial_8250.h>
+#include <linux/serial_reg.h>
+
 #include "8250_dwlib.h"
 
 /* Offsets for the DesignWare specific registers */
-- 
2.35.1

