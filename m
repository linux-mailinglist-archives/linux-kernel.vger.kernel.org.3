Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3FCA54C822
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 14:08:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348389AbiFOMIJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 08:08:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343836AbiFOMIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 08:08:07 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0672637ABF;
        Wed, 15 Jun 2022 05:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655294887; x=1686830887;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=iSJPh1Ju/IQynP0+FbgSKh4cSdCd7nA7rEU6e/3J6Bs=;
  b=S8csEvDE9sGNDbFp12TRR/6kKEbXUUL84xQYq+WOLE/AsuNWPorLxH5O
   KOq6VvC+4EGLGL2biUgdbfWvEX4aTqThoiSK5A+Fo5JrFDI80dsN4pDps
   Rsxaj74n9rj1nYIbO4sEVFg6u2SicNYXOin+SwtlttlxPq69OeOJ6qB+U
   wqguozJeHvUME3bjk+ZddGjhHiPrGGyUPQ9Gd2FilZJiXdfonNfnPIMAy
   uPdymRW/lsbDyV7ic+9M+4LIDo2UNUwVZtCe2rPE/IiTIB8hXbcTLIbpr
   mhE/AvMGjNI/b6JO734GJgGWWDCf7cwlcgol6rXGPnZmxy0LaNEYy1VqG
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10378"; a="277731274"
X-IronPort-AV: E=Sophos;i="5.91,302,1647327600"; 
   d="scan'208";a="277731274"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2022 05:08:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,302,1647327600"; 
   d="scan'208";a="536013045"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 15 Jun 2022 05:08:04 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id C2F8B18F; Wed, 15 Jun 2022 15:08:08 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Alexandru Ardelean <aardelean@deviqon.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v1 1/1] iio: adc: intel_mrfld_adc: explicitly add proper header files
Date:   Wed, 15 Jun 2022 15:08:03 +0300
Message-Id: <20220615120803.41350-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do not trust the fact that iio.h includes of.h which in turn includes
all the headers we are relying on.

The ultimate goal is to actually drop of.h from iio.h.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---

Jonathan, this should be squeezed before we remove of.h in iio.h
I think Nuno somehow missed this

 drivers/iio/adc/intel_mrfld_adc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/adc/intel_mrfld_adc.c b/drivers/iio/adc/intel_mrfld_adc.c
index 616de0c3a049..7263ad76124d 100644
--- a/drivers/iio/adc/intel_mrfld_adc.c
+++ b/drivers/iio/adc/intel_mrfld_adc.c
@@ -15,6 +15,7 @@
 #include <linux/interrupt.h>
 #include <linux/mfd/intel_soc_pmic.h>
 #include <linux/mfd/intel_soc_pmic_mrfld.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/platform_device.h>
-- 
2.35.1

