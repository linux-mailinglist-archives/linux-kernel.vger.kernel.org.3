Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8617B4FFEFC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 21:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238223AbiDMTSu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 15:18:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237464AbiDMTSi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 15:18:38 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A765547AE0;
        Wed, 13 Apr 2022 12:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649877375; x=1681413375;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+CW/WSr8XX3TMv+N0o2bnxngt07Q45WJ59o1iwCVt2E=;
  b=Wc9HKJ3KECnBNVAbwaz8NkwWHmtbDJuZbHOwTlQ/x85L0gLTWrQqNmMj
   E2mpc4icK7ti73Ju2UtWl/xy73lsVl7NfBfe4vNJYBmWlbwPmtHVEc5/l
   0vS4Nx/YV2i7GGx6RCIbsqaDbsGOXV3e38yU+L94a6Coskh/8VrLa9iKP
   AFXVmV6tCRDUkRsKh+oliYod7zUIKIq8gQ5xn4qjUmJFD2RG2Mfh2cRYD
   6t7MTT0AOmu9pcFbyYzySwumeQXIMlvR/XhhGubczJ2DWcTK2jI9jmPkQ
   lGkYTFXP+lwI9C+qJdhAQNnqiUfPaFUQUPt2iIGlInZShFciAYRuZVZT3
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10316"; a="262193392"
X-IronPort-AV: E=Sophos;i="5.90,257,1643702400"; 
   d="scan'208";a="262193392"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 12:16:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,257,1643702400"; 
   d="scan'208";a="526593327"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 13 Apr 2022 12:16:12 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 6863912C; Wed, 13 Apr 2022 22:16:12 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v1 1/1] iio: dac: vf610: Drop dependency on OF
Date:   Wed, 13 Apr 2022 22:16:11 +0300
Message-Id: <20220413191611.46204-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/iio/dac/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
index 7ab3b0839e55..015d307a9c6d 100644
--- a/drivers/iio/dac/Kconfig
+++ b/drivers/iio/dac/Kconfig
@@ -441,7 +441,6 @@ config TI_DAC7612
 
 config VF610_DAC
 	tristate "Vybrid vf610 DAC driver"
-	depends on OF
 	depends on HAS_IOMEM
 	help
 	  Say yes here to support Vybrid board digital-to-analog converter.
-- 
2.35.1

