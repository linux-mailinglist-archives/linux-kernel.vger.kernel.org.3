Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1EDB4FFE68
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 21:03:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237923AbiDMTGQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 15:06:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237967AbiDMTGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 15:06:10 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2EFB70F50;
        Wed, 13 Apr 2022 12:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649876611; x=1681412611;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=1/j6us2vQzvew8d5Evck5ocXX85Adgtzj5Ev650bvo4=;
  b=XxEdVwORzWFuEeiWKX3iZQh2yjaLEsnrqM9yOAivAweLlCc6zT0R8feQ
   uLtNhZseEybzh5Yz2OoNSLIuWnyUYI3kf8VxcfyJK3dpKnA2PskqMuqJk
   QBxshRX1qIDKgFL1o1QQFE5YkC8V3mFcuSWBMROtxWgV+cVVc5F811g6o
   RIBnfrf23GBFT/nbNN+IG11PLYTCn5yNOcMPcsc4a9izD1MWwDe7J2Dri
   sYEMOFxqaaXhPLGhjKr+YI4o/m32RFgL6pidFTMujNzftNCOwzib0n5VG
   d1uJU2onyC347Z9tn40GkzzwqL5LQMj6igueFSphUMZr7poXSFRyoKEBu
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10316"; a="262929146"
X-IronPort-AV: E=Sophos;i="5.90,257,1643702400"; 
   d="scan'208";a="262929146"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 12:03:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,257,1643702400"; 
   d="scan'208";a="661046767"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 13 Apr 2022 12:03:29 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 3D9C612C; Wed, 13 Apr 2022 22:03:29 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] iio: accel: dmard06: Drop dependency on OF
Date:   Wed, 13 Apr 2022 22:03:27 +0300
Message-Id: <20220413190327.30054-1-andriy.shevchenko@linux.intel.com>
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
 drivers/iio/accel/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
index eac3f02662ae..b53f010f3e40 100644
--- a/drivers/iio/accel/Kconfig
+++ b/drivers/iio/accel/Kconfig
@@ -290,7 +290,6 @@ config DA311
 
 config DMARD06
 	tristate "Domintech DMARD06 Digital Accelerometer Driver"
-	depends on OF || COMPILE_TEST
 	depends on I2C
 	help
 	  Say yes here to build support for the Domintech low-g tri-axial
-- 
2.35.1

