Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0E5954E835
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 19:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350315AbiFPQ7v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 12:59:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239867AbiFPQ6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 12:58:31 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A2A13CFF7
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 09:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655398711; x=1686934711;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5LIUNq3A1YHHdIISMtbksOe6rN9yJFBm6vL/yG7ouBM=;
  b=f2OsDZurzp20F4pANlhE+K3Fmqah8DDbTHijDIkAlDLgm3eFroRyH1Xh
   KXFWr157kWMrSaUce+uArEg3x7aunvuLCrEVEtV+9j5/BzZqpb+wYmsGD
   irbu6LwBmIB0FPoNH5vVvM0Ih8Ddc/mvnMCUfFlpvaJ2MJO4R4QhNT2tr
   enoOYTF7mXGa0OHsz3HXtii7mw6Rb9Ul5lege4eMIOjWiW8q5xirYWGqF
   V33lqwf3ZG64f3wLSfq5vDby4fGHwaE5VyKzVLHHHg+vdRRc3woayGtsR
   +ITyJKh9jOItK8D1UrlGqScYcg7bprhUPQo3IvDDFxdfXt9zgZxLabGV5
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="259756092"
X-IronPort-AV: E=Sophos;i="5.92,305,1650956400"; 
   d="scan'208";a="259756092"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2022 09:58:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,305,1650956400"; 
   d="scan'208";a="589725025"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 16 Jun 2022 09:58:29 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id BD3B9537; Thu, 16 Jun 2022 19:58:31 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andy@kernel.org>, Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v1 11/11] mfd: intel_soc_pmic_bxtwc: Fix spelling in the comment
Date:   Thu, 16 Jun 2022 19:58:23 +0300
Message-Id: <20220616165823.4919-11-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220616165823.4919-1-andriy.shevchenko@linux.intel.com>
References: <20220616165823.4919-1-andriy.shevchenko@linux.intel.com>
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

There are a couple of spelling issues in the comment, fix them.
While at it, fix indentation in the MODULE_AUTHOR() parameter
and update copyright years.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mfd/intel_soc_pmic_bxtwc.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/mfd/intel_soc_pmic_bxtwc.c b/drivers/mfd/intel_soc_pmic_bxtwc.c
index 953f535a3c93..9e412d1d00f1 100644
--- a/drivers/mfd/intel_soc_pmic_bxtwc.c
+++ b/drivers/mfd/intel_soc_pmic_bxtwc.c
@@ -2,7 +2,7 @@
 /*
  * MFD core driver for Intel Broxton Whiskey Cove PMIC
  *
- * Copyright (C) 2015 Intel Corporation. All rights reserved.
+ * Copyright (C) 2015-2017, 2022 Intel Corporation. All rights reserved.
  */
 
 #include <linux/acpi.h>
@@ -527,11 +527,11 @@ static int bxtwc_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, ret, "Failed to add devices\n");
 
 	/*
-	 * There is known hw bug. Upon reset BIT 5 of register
+	 * There is known HW bug. Upon reset BIT 5 of register
 	 * BXTWC_CHGR_LVL1_IRQ is 0 which is the expected value. However,
 	 * later it's set to 1(masked) automatically by hardware. So we
-	 * have the software workaround here to unmaksed it in order to let
-	 * charger interrutp work.
+	 * have the software workaround here to unmasked it in order to let
+	 * charger interrupt work.
 	 */
 	regmap_update_bits(pmic->regmap, BXTWC_MIRQLVL1, BXTWC_MIRQLVL1_MCHGR, 0);
 
@@ -584,4 +584,4 @@ static struct platform_driver bxtwc_driver = {
 module_platform_driver(bxtwc_driver);
 
 MODULE_LICENSE("GPL v2");
-MODULE_AUTHOR("Qipeng Zha<qipeng.zha@intel.com>");
+MODULE_AUTHOR("Qipeng Zha <qipeng.zha@intel.com>");
-- 
2.35.1

