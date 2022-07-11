Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AD44570CC5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 23:35:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231124AbiGKVfk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 17:35:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbiGKVf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 17:35:29 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 123ED27154;
        Mon, 11 Jul 2022 14:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657575328; x=1689111328;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=ITmJehlTeY0Jspvd4mmNPMY0ltE3dJzEIxfg7goZ1kQ=;
  b=Q+mb5WLjFgY18ELXf3hxKfbMHW8aVukplnjoi6JPTuU3RDhWLtZF/RCW
   guXe1f05ofafTByV0/9isTiYvxU2o8+iaN8B6tho2ESFRwzS2twkSrNT2
   hYQbHGKsXeD+5S4YT8IfFmcnQs8Ay0Nzx4HPHM0tVkkzvkINutzkO1njQ
   UtMBQOKoMGTkVZzkgw89Y5CDb/307yMUpqT8OPBGJx4hQhMF8nFwOPFZB
   2//zwABG5FPcFh9qb8v7W6RgJNYzlS6s4sTFfi+gFQT4TfU3LL9QFwXvP
   wveMPkurHTrFaBDkNm/OrU5OYHMlbp9i0+hqNsKqHq4btlNLuvTb4Ehv6
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10405"; a="284800682"
X-IronPort-AV: E=Sophos;i="5.92,263,1650956400"; 
   d="scan'208";a="284800682"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2022 14:35:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,263,1650956400"; 
   d="scan'208";a="652633392"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 11 Jul 2022 14:35:25 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 97DBA5CC; Tue, 12 Jul 2022 00:35:33 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Pavel Machek <pavel@ucw.cz>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Vincent Knecht <vincent.knecht@mailoo.org>,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 5/5] leds: is31fl319x: sort header inclusion alphabetically
Date:   Tue, 12 Jul 2022 00:35:24 +0300
Message-Id: <20220711213524.3587-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220711213524.3587-1-andriy.shevchenko@linux.intel.com>
References: <20220711213524.3587-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sort header inclusion alphabetically.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/leds/leds-is31fl319x.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/leds/leds-is31fl319x.c b/drivers/leds/leds-is31fl319x.c
index 52b59b62f437..f2d05ae91753 100644
--- a/drivers/leds/leds-is31fl319x.c
+++ b/drivers/leds/leds-is31fl319x.c
@@ -8,7 +8,9 @@
  * effect LEDs.
  */
 
+#include <linux/delay.h>
 #include <linux/err.h>
+#include <linux/gpio/consumer.h>
 #include <linux/i2c.h>
 #include <linux/leds.h>
 #include <linux/mod_devicetable.h>
@@ -16,8 +18,6 @@
 #include <linux/property.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
-#include <linux/delay.h>
-#include <linux/gpio/consumer.h>
 
 /* register numbers */
 #define IS31FL319X_SHUTDOWN		0x00
-- 
2.35.1

