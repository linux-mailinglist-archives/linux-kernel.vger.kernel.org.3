Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D4A04FFEEE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 21:13:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238072AbiDMTPj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 15:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238328AbiDMTM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 15:12:56 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0042A72446;
        Wed, 13 Apr 2022 12:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649876903; x=1681412903;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/NRCMCz/oyRtVdmOgQk/fJ76afo2WGVrCiTYNHVE2xg=;
  b=jp1BTGQnqg6om4h3RVprXPx8foex2/AFlEgBn9uIgdsusvqtOC+ANY7b
   JwaDJMv105ChXwZjTwAB5UK7wtymp51mqnnF+nTUiXc4SKjMO1+YeOxXp
   Ofg4B/Mz+Hf1qSAwXKUi7sYaZPyysors26lvFQ6LmKXPKHR1uTSEAR447
   VTj0bctodH+fRDMnJZvL8stADFVRpp7rt9z07Do1AWqE35nAfWRzqSHw+
   fS5E+ZVqMflRZ3AkVL5E98iAkcDfEfZzh32gz+69kMWOFfxQcVZsvHcak
   FOk7Wzy/qib7kx44SEXAcsuf1IBmkHR7dqkqMfPv7rtjMXbGf8ZsHG856
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10316"; a="242686450"
X-IronPort-AV: E=Sophos;i="5.90,257,1643702400"; 
   d="scan'208";a="242686450"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 12:08:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,257,1643702400"; 
   d="scan'208";a="526590986"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 13 Apr 2022 12:08:20 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 6E66412C; Wed, 13 Apr 2022 22:08:20 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] iio: dac: lpc18xx: Drop dependency on OF
Date:   Wed, 13 Apr 2022 22:08:19 +0300
Message-Id: <20220413190819.38206-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
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
 drivers/iio/dac/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
index 8d5b3bad75ad..d578e242d74d 100644
--- a/drivers/iio/dac/Kconfig
+++ b/drivers/iio/dac/Kconfig
@@ -304,7 +304,7 @@ config DS4424
 config LPC18XX_DAC
 	tristate "NXP LPC18xx DAC driver"
 	depends on ARCH_LPC18XX || COMPILE_TEST
-	depends on OF && HAS_IOMEM
+	depends on HAS_IOMEM
 	help
 	  Say yes here to build support for NXP LPC18XX DAC.
 
-- 
2.35.1

