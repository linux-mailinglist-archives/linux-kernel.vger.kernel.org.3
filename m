Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14C704FFE6F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 21:06:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235758AbiDMTJF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 15:09:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232238AbiDMTJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 15:09:01 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A929650E31;
        Wed, 13 Apr 2022 12:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649876799; x=1681412799;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=sjMCo+JPH2dv/2Oq/rzIhDstRkLMKDuK5xD3Pomj/Mo=;
  b=oDk+Q5XbpUZCrAApsitQVKuvXru8dM+QRPr3JqaZ7c1DT48Df1qo+tDZ
   hMWuRFahWwkLHbSHmVHbsuY9jDe8chQDn+TG2ZOiHLA+F1kOGmiXk6UEy
   ZqpqVfFGKkQTYi+yieXJq6u0pKgYKRN25HgnG4vQJTM3nsTZmXMj6kxAE
   v9tRvpKoMBsHHED8DcM7WMN4rZ8jKF5YgZ1n4BNDTztmbJOKsh+7Wix5A
   ep+WaKRU/XZqHLf71RfXTS88WcU5EuVTLFs5S8T54amONx6MApnVY6SzA
   BrnedCdl8Oat+zo3BXcbx7iPh/Q+MLKm4sckw/ruk9o993iJGQ1eq5fEs
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10316"; a="243338568"
X-IronPort-AV: E=Sophos;i="5.90,257,1643702400"; 
   d="scan'208";a="243338568"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 12:06:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,257,1643702400"; 
   d="scan'208";a="508094962"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 13 Apr 2022 12:06:37 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 40D7E12C; Wed, 13 Apr 2022 22:06:36 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] iio: dac: dpot: Drop dependency on OF
Date:   Wed, 13 Apr 2022 22:06:32 +0300
Message-Id: <20220413190632.30365-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
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

Nothing in this driver depends on OF firmware so drop the dependency
and update the headers to remove the false impression such a dependency
exists.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/dac/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
index c0bf0d84197f..8d5b3bad75ad 100644
--- a/drivers/iio/dac/Kconfig
+++ b/drivers/iio/dac/Kconfig
@@ -285,7 +285,6 @@ config CIO_DAC
 
 config DPOT_DAC
 	tristate "DAC emulation using a DPOT"
-	depends on OF
 	help
 	  Say yes here to build support for DAC emulation using a digital
 	  potentiometer.
-- 
2.35.1

