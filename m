Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BE6C538725
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 20:13:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242597AbiE3SNW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 14:13:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242538AbiE3SNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 14:13:20 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1119335DF5;
        Mon, 30 May 2022 11:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653934400; x=1685470400;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=q1d3QMDatfHZTojCsxeXpjPOUf93aWFPRMtS4MtChGk=;
  b=GVSjI5KNA/txi30469QaVHF56h5b9ZnP67Nl79NPPB1TN/l9l8tulTHN
   woNCEe9zAq7QoNla9s768pdAloDfOFBP6GBJQUd8lIlzZP+mffnOz31qe
   qERN30aFlJv4WhEegojnzYMD/p2j0ms1mcI/PY4S3edaBNlCrt25OMoHq
   sPdkWmFrZTRDklxC2drktTip45r4S2JXeHs/oueR0feAfW0frx9AYmj9k
   eVhp17HNZ/1m3lqXSLBW2hcbIvaxOzl37482rh7xMf/HOfXIKz/nbykK7
   nv9lYkepDAQVR9uO7kRh/3WvMte66zMu0oqRDl7oSjYJBsn6HYW+7lx9x
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10363"; a="275144715"
X-IronPort-AV: E=Sophos;i="5.91,263,1647327600"; 
   d="scan'208";a="275144715"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2022 11:13:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,263,1647327600"; 
   d="scan'208";a="822946743"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 30 May 2022 11:13:18 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 6899A147; Mon, 30 May 2022 21:13:20 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] iio: adc: envelope-detector: Drop dependency on OF
Date:   Mon, 30 May 2022 21:13:13 +0300
Message-Id: <20220530181313.2789-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
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

Nothing in this driver depends on OF so drop the dependency
to remove the false impression such a dependency exists.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/adc/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 48ace7412874..d0122b363ee8 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -417,7 +417,6 @@ config DLN2_ADC
 
 config ENVELOPE_DETECTOR
 	tristate "Envelope detector using a DAC and a comparator"
-	depends on OF
 	help
 	  Say yes here to build support for an envelope detector using a DAC
 	  and a comparator.
-- 
2.35.1

