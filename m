Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F9D55A2D34
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 19:17:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344515AbiHZRQe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 13:16:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232757AbiHZRQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 13:16:29 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6C574DB6A;
        Fri, 26 Aug 2022 10:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661534188; x=1693070188;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=FfFIK+JFW+0b6Ao4zVJ5GS+N8o3sRHua/8mxgsHvrCg=;
  b=lx0Q3EEF9HFiE3vT3PRUqBUx1Z9je10zqmER7r8bN/hfBKSqsax5nWk7
   3Qjc84djbSSF0HCmi7ACKFGVoeToCA98ee5Kf18bZW2HxHJR34+U5ddh+
   ttlYRRYuYI92xgLZ7fVsukqP1VOjQ67tkzgCfrx2hmrDiDj9lQM6VAChO
   JYA4qiwjZiUv+lOTuj4MIO4/WZHwmMV3qrJnoIQ3rTW9uGx4mL9o/W7dq
   HQHfu1Slf3fLIX+tQ6rIAQFkNEfdRu+TI2O6etVJyr1R6w25r+5Milz9j
   16KELDUiAEod/vzhh9K/3Y5B3K/wpL3dzb2ytKshow0nxQ0BNOEdoVh5d
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10451"; a="292134231"
X-IronPort-AV: E=Sophos;i="5.93,265,1654585200"; 
   d="scan'208";a="292134231"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2022 10:16:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,265,1654585200"; 
   d="scan'208";a="699914142"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 26 Aug 2022 10:16:26 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 2C5E719D; Fri, 26 Aug 2022 20:16:41 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 1/2] ACPI: bus: Drop kernel doc annotation from acpi_bus_notify()
Date:   Fri, 26 Aug 2022 20:16:34 +0300
Message-Id: <20220826171635.15652-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The description for acpi_bus_notify() is quite far from what
kernel doc expects. It complains about this:

  Function parameter or member 'handle' not described in 'acpi_bus_notify'
  Function parameter or member 'type' not described in 'acpi_bus_notify'
  Function parameter or member 'data' not described in 'acpi_bus_notify'

Fix this by dropping kernel doc annotation.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: no changes
 drivers/acpi/bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index f60d4dc45c1f..f3e868d35144 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -456,7 +456,7 @@ static void acpi_bus_osc_negotiate_usb_control(void)
                              Notification Handling
    -------------------------------------------------------------------------- */
 
-/**
+/*
  * acpi_bus_notify
  * ---------------
  * Callback for all 'system-level' device notifications (values 0x00-0x7F).
-- 
2.35.1

