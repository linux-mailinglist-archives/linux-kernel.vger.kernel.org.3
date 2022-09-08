Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33B865B2066
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 16:21:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231700AbiIHOVa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 10:21:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231460AbiIHOVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 10:21:25 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 515ACE6239;
        Thu,  8 Sep 2022 07:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662646885; x=1694182885;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=60ORDIIVfL3t8qlJ4N8A3gWo87+2KvGQb2s56oYebrU=;
  b=iJHjpa7gI1K29hvyvDH9bu30jTR9xjnqnYLYuupTBYRY0MmyO+bWoZL0
   7ARcfJ8sLEW3nRgKC8u/jLhMRfcSq2uYnSjjUcfUnoO5NRfuW4bEI1XJb
   s07KDHRtevNsK/4BFD3U/mbRDYi3ceXG2gGjOp1nixKGbOQ/7UTPv0cZm
   VBmknQyXW8j5bSTD46RjFIN2TY92qv7dCvD3ZHlATAmWCqcQODAPEWyzW
   Fj0ccfGMLTxYo4HwnvXmkfL/IHju4X1TpE5KwDioL8PfDIK8UD+xRQj+1
   Ur1VtxKRr9SbBTCv5l6SSJzWWBmUcUSbUszKT4UMxf6/MRXvvVupFRQWI
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10464"; a="297991987"
X-IronPort-AV: E=Sophos;i="5.93,300,1654585200"; 
   d="scan'208";a="297991987"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2022 07:21:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,300,1654585200"; 
   d="scan'208";a="592186339"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 08 Sep 2022 07:21:22 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id CF760F7; Thu,  8 Sep 2022 17:21:38 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/1] pinctrl: cy8c95x0: Use 'default' in all switch-cases (part 2)
Date:   Thu,  8 Sep 2022 17:21:34 +0300
Message-Id: <20220908142134.59068-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the default values to the 'default' case in the switches.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pinctrl/pinctrl-cy8c95x0.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-cy8c95x0.c b/drivers/pinctrl/pinctrl-cy8c95x0.c
index 1335d07822f9..79f73d364f3f 100644
--- a/drivers/pinctrl/pinctrl-cy8c95x0.c
+++ b/drivers/pinctrl/pinctrl-cy8c95x0.c
@@ -357,9 +357,9 @@ static bool cy8c95x0_volatile_register(struct device *dev, unsigned int reg)
 	case CY8C95X0_DRV_PP_SLOW:
 	case CY8C95X0_DRV_HIZ:
 		return true;
+	default:
+		return false;
 	}
-
-	return false;
 }
 
 static bool cy8c95x0_precious_register(struct device *dev, unsigned int reg)
-- 
2.35.1

