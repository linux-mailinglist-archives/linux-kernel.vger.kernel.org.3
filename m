Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F40765A7FE6
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 16:17:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232194AbiHaOQ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 10:16:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232112AbiHaOP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 10:15:59 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75B405F103;
        Wed, 31 Aug 2022 07:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661955322; x=1693491322;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cTT/KqVlDmHBzjaZlDZPkQW4EK0I9w1vtnHk+yiXkv0=;
  b=Kln22zzwi/xjJgKRu/CDdzY2By3pTFpB6VzOLrSMOo/FzTwAk2xE2zdl
   cAEmOJ39a5VBWw3noCu1NCzMGSYVoyjB0i4JQRE5jyXqST6x6wABAK0FF
   m7XHTk/XAsfhQFsgTaSTGdAm7XehGVV4+KypCuNiuwHBYeb6JQCwf1wof
   ebcRtuSGxn00r5rBc1Syvcsy4TNy0RLlk9KRX4zRmfjO8RDz4GxNvFF2N
   UlYX1UJgELoa/5iTGgD1VFNksajnRc8LMCtYuSbPJxtQZOHiJjvxPSc7s
   jhSP2oVlHrxunnFmq7ITcLX173Af5i8cuupMVcG3LBuMtiQGRdXLXrtsD
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10456"; a="381752743"
X-IronPort-AV: E=Sophos;i="5.93,278,1654585200"; 
   d="scan'208";a="381752743"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2022 07:15:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,278,1654585200"; 
   d="scan'208";a="641885629"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 31 Aug 2022 07:15:18 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id B7EDFAD; Wed, 31 Aug 2022 17:15:32 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jakob Hauser <jahau@rocketmail.com>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v2 2/3] iio: magnetometer: yamaha-yas530: Make strings const in chip info
Date:   Wed, 31 Aug 2022 17:15:29 +0300
Message-Id: <20220831141530.80572-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220831141530.80572-1-andriy.shevchenko@linux.intel.com>
References: <20220831141530.80572-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For better compiler coverage mark strings consts in the chip info.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: no changes
 drivers/iio/magnetometer/yamaha-yas530.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/magnetometer/yamaha-yas530.c b/drivers/iio/magnetometer/yamaha-yas530.c
index 58f527cfde07..a6e34d5f3e85 100644
--- a/drivers/iio/magnetometer/yamaha-yas530.c
+++ b/drivers/iio/magnetometer/yamaha-yas530.c
@@ -189,8 +189,8 @@ struct yas5xx;
  */
 struct yas5xx_chip_info {
 	unsigned int devid;
-	char *product_name;
-	char *version_names[2];
+	const char *product_name;
+	const char *version_names[2];
 	const int *volatile_reg;
 	int volatile_reg_qty;
 	u32 scaling_val2;
-- 
2.35.1

