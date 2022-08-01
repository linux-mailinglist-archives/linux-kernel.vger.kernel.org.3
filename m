Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A5E4586822
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 13:30:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbiHALaW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 07:30:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbiHALaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 07:30:14 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B8A6F55;
        Mon,  1 Aug 2022 04:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659353413; x=1690889413;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PFMECtufaSe+3XbYrGxvNwr17fDG9YAjKMceaa9Y/Lk=;
  b=cwhmRusZDRvIVOGoBti+s3bq0gI3hBKfSs/kz6YH/htDHAQqhgVHzm0d
   K96ddsKWZFv/4lNoIWwBsqBstj9X7h/FM+2FetiKWTRClHocq3A+T23JP
   2fCptrveBOtnkB0zHc/BE72EW9s6hSdY65Q3CboMf0z4zc6DlXDp/n/66
   oi3IUmxpWfh4m5SAa6PfhBoEDYp+tLvROFaJblnY0FAw3Su0JE8KBTTJQ
   NBjYlsTgV/00oOU8P30fZ0rVEVFiNd2FPmwPwd2TO5oAOC3ji3+BdYr/L
   Q5atsQU3Bs3irTUX2+/+bRQp4p3flTbK3t5GLEZ6eytG5tNKWv70EvqQ3
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10425"; a="272166609"
X-IronPort-AV: E=Sophos;i="5.93,206,1654585200"; 
   d="scan'208";a="272166609"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2022 04:30:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,206,1654585200"; 
   d="scan'208";a="847795811"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 01 Aug 2022 04:30:11 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 2722511C; Mon,  1 Aug 2022 14:30:22 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mark Gross <markgross@kernel.org>
Subject: [PATCH v1 4/4] platform/x86: pmc_atom: Amend comment style and grammar
Date:   Mon,  1 Aug 2022 14:30:18 +0300
Message-Id: <20220801113018.9882-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220801113018.9882-1-andriy.shevchenko@linux.intel.com>
References: <20220801113018.9882-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The style of the comments is not uniform, make it so and fix
a few grammar issues. While at it, update Copyright years.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/platform/x86/pmc_atom.c            | 19 ++++++++-----------
 include/linux/platform_data/x86/pmc_atom.h |  4 ++--
 2 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/drivers/platform/x86/pmc_atom.c b/drivers/platform/x86/pmc_atom.c
index 8d91999446f5..3271aec23abe 100644
--- a/drivers/platform/x86/pmc_atom.c
+++ b/drivers/platform/x86/pmc_atom.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Intel Atom SOC Power Management Controller Driver
- * Copyright (c) 2014, Intel Corporation.
+ * Intel Atom SoC Power Management Controller Driver
+ * Copyright (c) 2014-2015,2017,2022 Intel Corporation.
  */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
@@ -494,11 +494,7 @@ static int pmc_setup_dev(struct pci_dev *pdev, const struct pci_device_id *ent)
 	return ret;
 }
 
-/*
- * Data for PCI driver interface
- *
- * used by pci_match_id() call below.
- */
+/* Data for PCI driver interface used by pci_match_id() call below */
 static const struct pci_device_id pmc_pci_ids[] = {
 	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_VLV_PMC), (kernel_ulong_t)&byt_data },
 	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_CHT_PMC), (kernel_ulong_t)&cht_data },
@@ -510,8 +506,9 @@ static int __init pmc_atom_init(void)
 	struct pci_dev *pdev = NULL;
 	const struct pci_device_id *ent;
 
-	/* We look for our device - PCU PMC
-	 * we assume that there is max. one device.
+	/*
+	 * We look for our device - PCU PMC.
+	 * We assume that there is maximum one device.
 	 *
 	 * We can't use plain pci_driver mechanism,
 	 * as the device is really a multiple function device,
@@ -523,7 +520,7 @@ static int __init pmc_atom_init(void)
 		if (ent)
 			return pmc_setup_dev(pdev, ent);
 	}
-	/* Device not found. */
+	/* Device not found */
 	return -ENODEV;
 }
 
@@ -531,6 +528,6 @@ device_initcall(pmc_atom_init);
 
 /*
 MODULE_AUTHOR("Aubrey Li <aubrey.li@linux.intel.com>");
-MODULE_DESCRIPTION("Intel Atom SOC Power Management Controller Interface");
+MODULE_DESCRIPTION("Intel Atom SoC Power Management Controller Interface");
 MODULE_LICENSE("GPL v2");
 */
diff --git a/include/linux/platform_data/x86/pmc_atom.h b/include/linux/platform_data/x86/pmc_atom.h
index 1fee5d85f75d..08ecba0fb2f0 100644
--- a/include/linux/platform_data/x86/pmc_atom.h
+++ b/include/linux/platform_data/x86/pmc_atom.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 /*
- * Intel Atom SOC Power Management Controller Header File
- * Copyright (c) 2014, Intel Corporation.
+ * Intel Atom SoC Power Management Controller Header File
+ * Copyright (c) 2014-2015,2022 Intel Corporation.
  */
 
 #ifndef PMC_ATOM_H
-- 
2.35.1

