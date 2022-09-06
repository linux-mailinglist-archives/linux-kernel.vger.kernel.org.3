Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB8005AF540
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 22:03:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231182AbiIFUDY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 16:03:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbiIFUC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 16:02:59 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14C9BBB011;
        Tue,  6 Sep 2022 12:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662494314; x=1694030314;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=v2bmBUdg7tTSWGG6WO2kYa469atbFuZ0zlWdbeqwE3Q=;
  b=Sd8psmHVeN2Ac4AfILrWZJTAIF76QD2GpvuEQ37se6TVpxj63l2cHUGG
   jSRGznnXPVQPmAC+eWxIgL28sx9HidgkTKEgWAkCJnYgtQlszgS6fHevW
   L7Bka04ULf+4kbpcOq/dLAeTgBqWc5CLJvtBegMyaQSKUuvmXIBmG/ha6
   V41LB1Iu8ssAhwkX9kS6EJa/rAemFYn6+ayWigpwtQr9baFwFvG8gAyj3
   8Fl0i0mgS1m3Vjca5ohJmMikHvX+TTZ+vK9pI2r/FsZKfzSfaEu4MsZzx
   hBHFhbRwqh5OPCAXUSkyILaxp0Dh971QdWIFfON8wiOfFpTsExstTzjJ3
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10462"; a="322871071"
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="322871071"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 12:57:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="675844718"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 06 Sep 2022 12:57:30 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 14752235; Tue,  6 Sep 2022 22:57:46 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: [PATCH v1 4/9] pwm: lpss: Include headers we are direct user of
Date:   Tue,  6 Sep 2022 22:57:30 +0300
Message-Id: <20220906195735.87361-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220906195735.87361-1-andriy.shevchenko@linux.intel.com>
References: <20220906195735.87361-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For the sake of integrity, include headers we are direct user of.

While at it, replace device.h with a forward declaration.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pwm/pwm-lpss.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-lpss.h b/drivers/pwm/pwm-lpss.h
index 5995b6b750a8..832cb86996d7 100644
--- a/drivers/pwm/pwm-lpss.h
+++ b/drivers/pwm/pwm-lpss.h
@@ -10,11 +10,15 @@
 #ifndef __PWM_LPSS_H
 #define __PWM_LPSS_H
 
-#include <linux/device.h>
 #include <linux/pwm.h>
+#include <linux/types.h>
 
 #define MAX_PWMS			4
 
+struct device;
+
+struct pwm_lpss_boardinfo;
+
 struct pwm_lpss_chip {
 	struct pwm_chip chip;
 	void __iomem *regs;
-- 
2.35.1

