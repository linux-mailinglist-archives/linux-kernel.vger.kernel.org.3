Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DA915A16D5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 18:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241838AbiHYQlK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 12:41:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233141AbiHYQlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 12:41:06 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CB17BA175;
        Thu, 25 Aug 2022 09:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661445661; x=1692981661;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=BCS0lNtsDfsx98IzhJrcwhFoiZhfU/dhPFeN+3Lsdl0=;
  b=CxLgUyNFlYcQTbllMDhZIYYY9XeDdw8XkfelQeXywU0paNuBxk0YLlHU
   1gkC+c/LiSXpSrycw8TKTa4O/qzz1NGkaDRNmdpfd3G0qrv/P8etwRRQh
   0bqu3/wOCJD+wV5F3BFuPKrPQC0gfgifNzXEtlf9RnIpKqQ6EryH0uaDO
   zY/eyXmX+GkRUNofCGuC+KeBd+SwFhOtweAHNRXaRcbnXKGZT/Rw3LNH1
   0hG73qEglsqWB6Q/SsQcmouMbErH3Fl+3FPOVnG1Gq15+OMAiUIdevDM6
   UpC43Gjp65w7KVMQMQBm/zMSuYCxo8vyjtXyJWTdoTU6zrS9lwo1UcK99
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10450"; a="274689061"
X-IronPort-AV: E=Sophos;i="5.93,263,1654585200"; 
   d="scan'208";a="274689061"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2022 09:41:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,263,1654585200"; 
   d="scan'208";a="752554097"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 25 Aug 2022 09:40:59 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 8EBFB19D; Thu, 25 Aug 2022 19:41:13 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>
Subject: [PATCH v1 1/5] ACPI: bus: Drop kernel doc annotation from acpi_bus_notify()
Date:   Thu, 25 Aug 2022 19:40:59 +0300
Message-Id: <20220825164103.27694-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
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
 drivers/acpi/bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 6a1476cba3d3..8e87996607ec 100644
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

