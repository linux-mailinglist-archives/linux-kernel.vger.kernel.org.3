Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3E7D51E8F0
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 19:34:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386648AbiEGRid (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 13:38:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233409AbiEGRib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 13:38:31 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A61BD205F8;
        Sat,  7 May 2022 10:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651944884; x=1683480884;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=X0ItBNJz50nkKAhRztUipXfBqiaaq+mP7b+UDMO9LAo=;
  b=HklHAe+KlzqqLLiVNZVCmUv4DcjcdlbLab8k9le5F2zqHTv+C8QFYe8K
   yEc+b7TLcX5SciW4R6ZAtpPRn+g5vncXmLBGFgNILmWK8VN8lWLqOw2L3
   niCn3BWiL3HrB8LY6djveWmBm79s8VwLxGuJu9t7T1bgABSpRRnoVy1xM
   Hkv/8ONL25v/vRgmmY4f+3mVNM3UM6Dz/N6jtdIkttbJCZG9gDam8C3PD
   lV0qZ9YIa9/qaCUlpobkBzICm/Fsrd0vNwALEUby+ZFZAvoWmIYvSejxR
   rynTUEzazNDZIFrr8MuSmfMbkQr5C7SKqJXVpv1HJefDKYhJSn8YGl2a7
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10340"; a="268631047"
X-IronPort-AV: E=Sophos;i="5.91,207,1647327600"; 
   d="scan'208";a="268631047"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2022 10:34:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,207,1647327600"; 
   d="scan'208";a="518537172"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 07 May 2022 10:34:42 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 0C58F155; Sat,  7 May 2022 20:34:43 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v1 1/1] iio: imu: st_lsm6dsx: Switch from of headers to mod_devicetable.h
Date:   Sat,  7 May 2022 20:34:40 +0300
Message-Id: <20220507173440.29053-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i3c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i3c.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i3c.c
index 8d4201b86e87..35556cd04284 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i3c.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i3c.c
@@ -6,11 +6,11 @@
  */
 
 #include <linux/kernel.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/i3c/device.h>
 #include <linux/i3c/master.h>
 #include <linux/slab.h>
-#include <linux/of.h>
 #include <linux/regmap.h>
 
 #include "st_lsm6dsx.h"
-- 
2.35.1

