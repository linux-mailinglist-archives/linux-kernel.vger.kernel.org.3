Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAAE34A83DE
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 13:33:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350552AbiBCMdp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 07:33:45 -0500
Received: from mga17.intel.com ([192.55.52.151]:23607 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350455AbiBCMdn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 07:33:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643891623; x=1675427623;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=yT9k+zTUxwu1TXM+VzXDrKvcqnvS/GwhevCFkqm0aiU=;
  b=a3AvrdefBVA1KGBbZObjP8UMyy1R1crjlN6QseF5ZeGTn6WQbxOYE+VU
   SQFbnSwquRwcNd10b/5pnggjQQ7IjBkuEWFIty5eV93gMDfeNLEpqrgHw
   1GVb+ennMI4UCSw5v5C1iASqMLY8X98qNUxWTxBdljZHOwN8+4ZBJeTAe
   v4eM4lSUiqn5XVr/0CzgIIpKlAUxD3fk0kln0ePzN9CRGzyJiRLnKnKsh
   AVgxpaJuXkdKynt+dip1+l6RKuUK5IqcaB98sXpfvabQAZ3peJczMBOjX
   4wmv4SjZ+vQJHP62Gp5QuxUTAw9Ie7kf6aHSB9Y+OlIEVUqSZs+RUJJPL
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10246"; a="228785606"
X-IronPort-AV: E=Sophos;i="5.88,339,1635231600"; 
   d="scan'208";a="228785606"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2022 04:33:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,339,1635231600"; 
   d="scan'208";a="538726865"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 03 Feb 2022 04:33:41 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 98D91204; Thu,  3 Feb 2022 14:33:55 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] iio: dac: ad5592r: Drop leftover header inclusion
Date:   Thu,  3 Feb 2022 14:33:54 +0200
Message-Id: <20220203123354.76573-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no use of of.h in the module, drop it.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/dac/ad5592r-base.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/dac/ad5592r-base.c b/drivers/iio/dac/ad5592r-base.c
index 2fcc59728fd6..a9c654b614a4 100644
--- a/drivers/iio/dac/ad5592r-base.c
+++ b/drivers/iio/dac/ad5592r-base.c
@@ -11,7 +11,6 @@
 #include <linux/iio/iio.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
-#include <linux/of.h>
 #include <linux/regulator/consumer.h>
 #include <linux/gpio/consumer.h>
 #include <linux/gpio/driver.h>
-- 
2.34.1

