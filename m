Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACEDE586854
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 13:42:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231389AbiHALma (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 07:42:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230521AbiHALmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 07:42:11 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A39483342E
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 04:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659354130; x=1690890130;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cfFwAZTqn5tM4q6iksY6jHPLwcpemAGxTIyWJMX2QDI=;
  b=LwYAThXXOo0UDeNsSzZlXhcpxcnCRfl3GA4eAHRGJ/tqExrYDnrmUoS1
   grSgCk0A0EhgtkSdouhKa2/HumaFwZXIDUV2b7BRrGgBXboOqnY38/S2h
   MbSp0JefjTLGB6RXbQSe2AG6yzi8U+IduDg2ZvDCEzGlIgOAESScFOzyv
   0EWr02CYLnf7x86bhwCV59Q2t0wDqH39ibs8g1VGmqVjpYYmrPciY8u7U
   3uTSit1Zw5Q1Vai10bCqWnOxnRaUGxrqCutDgQYTdRRfLI+h9hzzu/DMR
   BbTPWVsc7q6LMeO0iHypIUVJwiJ3pNKD6pB6i7eI+Ms+Et4gZLsXLwduq
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10425"; a="290334895"
X-IronPort-AV: E=Sophos;i="5.93,206,1654585200"; 
   d="scan'208";a="290334895"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2022 04:42:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,206,1654585200"; 
   d="scan'208";a="602007953"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 01 Aug 2022 04:42:08 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 48E24450; Mon,  1 Aug 2022 14:42:14 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Lee Jones <lee.jones@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     Lee Jones <lee@kernel.org>, Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v3 10/10] mfd: intel_soc_pmic_crc: Update the copyright year
Date:   Mon,  1 Aug 2022 14:42:11 +0300
Message-Id: <20220801114211.36267-10-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220801114211.36267-1-andriy.shevchenko@linux.intel.com>
References: <20220801114211.36267-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the copyright year to be 2012-2014, 2022.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Tested-by: Hans de Goede <hdegoede@redhat.com>
---

v3: no changes
v2: added tags and rebased on top of new patch 1

 drivers/mfd/intel_soc_pmic_crc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/intel_soc_pmic_crc.c b/drivers/mfd/intel_soc_pmic_crc.c
index bbb30060d2fb..40f14a0c0790 100644
--- a/drivers/mfd/intel_soc_pmic_crc.c
+++ b/drivers/mfd/intel_soc_pmic_crc.c
@@ -2,7 +2,7 @@
 /*
  * Device access for Crystal Cove PMIC
  *
- * Copyright (C) 2012-2014 Intel Corporation. All rights reserved.
+ * Copyright (C) 2012-2014, 2022 Intel Corporation. All rights reserved.
  *
  * Author: Yang, Bin <bin.yang@intel.com>
  * Author: Zhu, Lejun <lejun.zhu@linux.intel.com>
-- 
2.35.1

