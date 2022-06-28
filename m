Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90B2C55F133
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 00:32:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbiF1WV7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 18:21:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230173AbiF1WVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 18:21:33 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E8773EABD
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 15:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656454704; x=1687990704;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tsrIS7eevSFDeW6trWsynUK7xKIjsc1FM2rbb0q95ao=;
  b=SUJ3Snc+ei3lcyZyvxUMM/ho2VhwoNks/JmzTFSzP/WudTdUYffgC1ZD
   i4eDz1Trs81mDjoPOLJ3U6aMlHrkkoUjzfBr24VL77l99kK/NZ0Aaty/F
   y1v+dENB2GCZGwg2Co8Sc1vs0Q6t0TWOTAbckuhatZMYhZthqOaXnf+TA
   bjaj9PudBUOSJaKdm80tMJcj7tukBO506020SIYLr6BbHB8/7sWKsxp/O
   LYM81N4Ha3LB7jDZrbgjdkfkMBja4xTGaZxvoKoYTdx0+J5CLJoG1kfL3
   qXFmRdH8XUsUfmUcMDFiMjuxgH9dZKj78+evHTfO8ZKPkA1jUoN/27aqE
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10392"; a="282596267"
X-IronPort-AV: E=Sophos;i="5.92,230,1650956400"; 
   d="scan'208";a="282596267"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 15:17:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,230,1650956400"; 
   d="scan'208";a="717590950"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 28 Jun 2022 15:17:45 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 3CABC7AA; Wed, 29 Jun 2022 01:17:49 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andy@kernel.org>, Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v2 11/11] mfd: intel_soc_pmic_bxtwc: Fix spelling in the comment
Date:   Wed, 29 Jun 2022 01:17:47 +0300
Message-Id: <20220628221747.33956-11-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220628221747.33956-1-andriy.shevchenko@linux.intel.com>
References: <20220628221747.33956-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are a few of spelling issues in the comment, fix them.
While at it, fix indentation in the MODULE_AUTHOR() parameter
and update copyright years.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: more spelling and grammar fixes (Lee)
 drivers/mfd/intel_soc_pmic_bxtwc.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/mfd/intel_soc_pmic_bxtwc.c b/drivers/mfd/intel_soc_pmic_bxtwc.c
index 1a80038c0e36..8dac0d41f64f 100644
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
@@ -525,11 +525,11 @@ static int bxtwc_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, ret, "Failed to add devices\n");
 
 	/*
-	 * There is known hw bug. Upon reset BIT 5 of register
+	 * There is a known H/W bug. Upon reset, BIT 5 of register
 	 * BXTWC_CHGR_LVL1_IRQ is 0 which is the expected value. However,
 	 * later it's set to 1(masked) automatically by hardware. So we
-	 * have the software workaround here to unmaksed it in order to let
-	 * charger interrutp work.
+	 * place the software workaround here to unmask it again in order
+	 * to re-enable the charger interrupt.
 	 */
 	regmap_update_bits(pmic->regmap, BXTWC_MIRQLVL1, BXTWC_MIRQLVL1_MCHGR, 0);
 
@@ -582,4 +582,4 @@ static struct platform_driver bxtwc_driver = {
 module_platform_driver(bxtwc_driver);
 
 MODULE_LICENSE("GPL v2");
-MODULE_AUTHOR("Qipeng Zha<qipeng.zha@intel.com>");
+MODULE_AUTHOR("Qipeng Zha <qipeng.zha@intel.com>");
-- 
2.35.1

