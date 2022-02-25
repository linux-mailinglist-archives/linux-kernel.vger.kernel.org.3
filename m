Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14A3A4C4C13
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 18:25:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243676AbiBYRZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 12:25:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243629AbiBYRYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 12:24:42 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF9C91A8CBB;
        Fri, 25 Feb 2022 09:24:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645809849; x=1677345849;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hNHti6tTy0PoN8MfewwykBYirfpqGBhg0XeiGh6x06g=;
  b=NuWhMUyflaKC1xkGqafq7+AT039ZXGBc46pC19x8ne/GyiuU+bpK6FuH
   n6grrulyLacAbEZQgZbCdYUzkc1VxvW0dbRJtxc35r1B2PQFw1AxaeSnZ
   IF1HVG6sCQyiVPXgHn1rAr2lwnmhj8TNa+7hLzpIv7lQBZE13mBEcjMWl
   XKXlkJfrbLdoZGmZidgEmCFcwIaVqpy+LIdEA4zLwHSWUIwYTbFhRZ2/2
   5LftgkZDyEluqcSaPVJn+r7MUCsWVWMq3Zbei+PhpIRwYd5mIkkp2G+vc
   20aB9ooYQfjEhV+92cRcLjvMTEl+ZZB2kSK6cgs7HyhFrfJx4C9avU+2q
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10268"; a="313259072"
X-IronPort-AV: E=Sophos;i="5.90,136,1643702400"; 
   d="scan'208";a="313259072"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2022 09:24:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,136,1643702400"; 
   d="scan'208";a="544119493"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 25 Feb 2022 09:24:07 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id A63857FA; Fri, 25 Feb 2022 19:24:21 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v1 11/11] spi: pxa2xx-pci: Constify struct pxa_spi_info variables
Date:   Fri, 25 Feb 2022 19:23:50 +0200
Message-Id: <20220225172350.69797-11-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220225172350.69797-1-andriy.shevchenko@linux.intel.com>
References: <20220225172350.69797-1-andriy.shevchenko@linux.intel.com>
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

Now when there are no dynamical changes required, we may
constify struct pxa_spi_info variables.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi-pxa2xx-pci.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx-pci.c b/drivers/spi/spi-pxa2xx-pci.c
index 3c5d14affa95..861b21c63504 100644
--- a/drivers/spi/spi-pxa2xx-pci.c
+++ b/drivers/spi/spi-pxa2xx-pci.c
@@ -164,7 +164,7 @@ static int lpss_spi_setup(struct pci_dev *dev, struct pxa2xx_spi_controller *c)
 	return 0;
 }
 
-static struct pxa_spi_info lpss_info_config = {
+static const struct pxa_spi_info lpss_info_config = {
 	.setup = lpss_spi_setup,
 };
 
@@ -179,7 +179,7 @@ static int ce4100_spi_setup(struct pci_dev *dev, struct pxa2xx_spi_controller *c
 	return pxa2xx_spi_pci_clk_register(dev, ssp, 3686400);
 }
 
-static struct pxa_spi_info ce4100_info_config = {
+static const struct pxa_spi_info ce4100_info_config = {
 	.setup = ce4100_spi_setup,
 };
 
@@ -236,7 +236,7 @@ static int mrfld_spi_setup(struct pci_dev *dev, struct pxa2xx_spi_controller *c)
 	return 0;
 }
 
-static struct pxa_spi_info mrfld_info_config = {
+static const struct pxa_spi_info mrfld_info_config = {
 	.setup = mrfld_spi_setup,
 };
 
@@ -251,18 +251,18 @@ static int qrk_spi_setup(struct pci_dev *dev, struct pxa2xx_spi_controller *c)
 	return pxa2xx_spi_pci_clk_register(dev, ssp, 50000000);
 }
 
-static struct pxa_spi_info qrk_info_config = {
+static const struct pxa_spi_info qrk_info_config = {
 	.setup = qrk_spi_setup,
 };
 
 static int pxa2xx_spi_pci_probe(struct pci_dev *dev,
 		const struct pci_device_id *ent)
 {
+	const struct pxa_spi_info *info;
 	struct platform_device_info pi;
 	int ret;
 	struct platform_device *pdev;
 	struct pxa2xx_spi_controller spi_pdata;
-	struct pxa_spi_info *info;
 	struct ssp_device *ssp;
 
 	ret = pcim_enable_device(dev);
-- 
2.34.1

