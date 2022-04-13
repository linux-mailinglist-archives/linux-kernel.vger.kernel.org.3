Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C103E4FFE1D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 20:46:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237803AbiDMSs6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 14:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236436AbiDMSsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 14:48:53 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79E875748F;
        Wed, 13 Apr 2022 11:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649875591; x=1681411591;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=YrbvQdqmqIWwdbZzvon7XEQuqJjjLdhgss70+44J5xo=;
  b=CNljGK5ne4aJY7yNsvvMen13Y0Jo7EZ8Pd2Nk5EeZpbkBuYFJ5nzJOq7
   lCVNEw5upnT1s3U23/FRvYtp6qgsbU4S4Y9WqBkJDCMw7fJkhFFtnCL7C
   3+haY8JW/+ikZ9ioRPKyCEZroF5T3vl4DVRfNfzbtvOJzEEiLhMi5itMN
   nMI0SzRzT9JJdugk45WVbpDxJd6H3apOdni6p293BjAXJDT2Fko4YtQ6z
   Sl5fhF6TsmU+dAMu/33/1uqNkj3Spgelwkj5T9KvvJdjrYNVNjHF0x3eH
   39sYURmGJgLpk/DNPC+41CKQd56Xm5aVDunLFfm8MDNSzIP9Dmg9PxfZl
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10316"; a="260343575"
X-IronPort-AV: E=Sophos;i="5.90,257,1643702400"; 
   d="scan'208";a="260343575"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 11:46:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,257,1643702400"; 
   d="scan'208";a="508088919"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 13 Apr 2022 11:46:28 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 3C5A812C; Wed, 13 Apr 2022 21:46:28 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Joe Sandom <joe.g.sandom@gmail.com>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] iio: light: cm3605: Drop dependency on OF
Date:   Wed, 13 Apr 2022 21:46:27 +0300
Message-Id: <20220413184627.21125-1-andriy.shevchenko@linux.intel.com>
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

Nothing in this driver depends on OF firmware so drop the dependency
and update the headers to remove the false impression such a dependency
exists.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/light/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
index a62c7b4b8678..8537e88f02e3 100644
--- a/drivers/iio/light/Kconfig
+++ b/drivers/iio/light/Kconfig
@@ -155,7 +155,6 @@ config CM3323
 
 config CM3605
 	tristate "Capella CM3605 ambient light and proximity sensor"
-	depends on OF
 	help
 	  Say Y here if you want to build a driver for Capella CM3605
 	  ambient light and short range proximity sensor.
-- 
2.35.1

