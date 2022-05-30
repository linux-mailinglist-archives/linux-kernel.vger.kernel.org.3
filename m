Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1677C538728
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 20:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238277AbiE3SRM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 14:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232948AbiE3SRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 14:17:10 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D5C733EBA;
        Mon, 30 May 2022 11:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653934628; x=1685470628;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3ls+BsK4fTG0JDFxVmbLsjxL03ClO9vf+BEQFDq2RKE=;
  b=hbd/ZttssClxozYDoH5R1KgD59hCQu7QI4QwFF3haml57kcNTfyzZlF1
   uKnx8FiGSsANB36+E+ngp/UbubVXBuS1YSkAsuqxdVsHb99IU7o+eitNB
   rQ0Td7N1xXXpyhCppNGGgrmcebAx9LM7Aytr1vS51fKjnrsR8Dx7Y6yHb
   AmNpacfTfp6dm6Pq0Yk7NdiKP2obsa+Mx9BUwkMGriXFHJcsXAi6QTmc2
   igI2yGoLvx+GA/Z24vp74G40blhAoBwL13+QOczALK7gr0jxqPvBZAye5
   GI8IZKHPiRytU0OpMH8/NET6Njxa8Kl3MqrmqvPVEDmjUXW46jdGbc+yk
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10363"; a="335707956"
X-IronPort-AV: E=Sophos;i="5.91,263,1647327600"; 
   d="scan'208";a="335707956"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2022 11:17:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,263,1647327600"; 
   d="scan'208";a="632704755"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 30 May 2022 11:17:05 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id E5BD5147; Mon, 30 May 2022 21:17:07 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] iio: adc: sd_adc_modulator: Drop dependency on OF
Date:   Mon, 30 May 2022 21:17:06 +0300
Message-Id: <20220530181706.3045-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
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
index d0122b363ee8..3b6a80786b51 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -940,7 +940,6 @@ config SPEAR_ADC
 
 config SD_ADC_MODULATOR
 	tristate "Generic sigma delta modulator"
-	depends on OF
 	select IIO_BUFFER
 	select IIO_TRIGGERED_BUFFER
 	help
-- 
2.35.1

