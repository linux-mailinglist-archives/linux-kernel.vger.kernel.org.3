Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DEC14B284A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 15:51:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351038AbiBKOvC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 09:51:02 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350681AbiBKOvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 09:51:00 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B3A5131
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 06:50:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644591059; x=1676127059;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3Rn5MR/dfuaZghH1JbSBG2WVghwUCCbSJi+tT54yz+A=;
  b=ZA5cZH0IYBmj2mivCQ7+wpPHaReX3l4ITjT4V+9UL/xcCxx2n+2u59ha
   aFdYzIyJas6lUKiEWfIo4d9Apr4svlTNl1Vvkw6weMj30a1BLHRRrRTbb
   2HebP3W3NjctBNcntfpnqTtJtTBcrPATSflOkYuBrUWiBR1q4Oyc7QaQ4
   9W5h6g0lanEEop5PLol5LWaCgRi713bGkv6jMPGBdOAFp7pUhE7xiIRK9
   3Y7wJGrGsm0gLXpMGCJ5Adxfjc9odmuPHj5ajQRuAsaOJdqGvWxEAb3eg
   oyjB1jV0zBSQvBpG2KdTxC+CKcCPxutb1gDGowTBvVTl3xIxI0UHyi7FQ
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10254"; a="230385284"
X-IronPort-AV: E=Sophos;i="5.88,361,1635231600"; 
   d="scan'208";a="230385284"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2022 06:50:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,361,1635231600"; 
   d="scan'208";a="679526180"
Received: from mylly.fi.intel.com (HELO mylly.fi.intel.com.) ([10.237.72.152])
  by fmsmga001.fm.intel.com with ESMTP; 11 Feb 2022 06:50:57 -0800
From:   Jarkko Nikula <jarkko.nikula@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lee Jones <lee.jones@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH] mfd: intel-lpss: Add Intel Raptor Lake PCH-S PCI IDs
Date:   Fri, 11 Feb 2022 16:50:55 +0200
Message-Id: <20220211145055.992179-1-jarkko.nikula@linux.intel.com>
X-Mailer: git-send-email 2.34.1
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

Add Intel Raptor Lake PCH-S LPSS PCI IDs.

Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
 drivers/mfd/intel-lpss-pci.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/mfd/intel-lpss-pci.c b/drivers/mfd/intel-lpss-pci.c
index 5513fae6be92..962ee14c62dd 100644
--- a/drivers/mfd/intel-lpss-pci.c
+++ b/drivers/mfd/intel-lpss-pci.c
@@ -353,6 +353,21 @@ static const struct pci_device_id intel_lpss_pci_ids[] = {
 	{ PCI_VDEVICE(INTEL, 0x5ac4), (kernel_ulong_t)&bxt_info },
 	{ PCI_VDEVICE(INTEL, 0x5ac6), (kernel_ulong_t)&bxt_info },
 	{ PCI_VDEVICE(INTEL, 0x5aee), (kernel_ulong_t)&bxt_uart_info },
+	/* RPL-S */
+	{ PCI_VDEVICE(INTEL, 0x7a28), (kernel_ulong_t)&bxt_uart_info },
+	{ PCI_VDEVICE(INTEL, 0x7a29), (kernel_ulong_t)&bxt_uart_info },
+	{ PCI_VDEVICE(INTEL, 0x7a2a), (kernel_ulong_t)&bxt_info },
+	{ PCI_VDEVICE(INTEL, 0x7a2b), (kernel_ulong_t)&bxt_info },
+	{ PCI_VDEVICE(INTEL, 0x7a4c), (kernel_ulong_t)&bxt_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0x7a4d), (kernel_ulong_t)&bxt_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0x7a4e), (kernel_ulong_t)&bxt_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0x7a4f), (kernel_ulong_t)&bxt_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0x7a5c), (kernel_ulong_t)&bxt_uart_info },
+	{ PCI_VDEVICE(INTEL, 0x7a79), (kernel_ulong_t)&bxt_info },
+	{ PCI_VDEVICE(INTEL, 0x7a7b), (kernel_ulong_t)&bxt_info },
+	{ PCI_VDEVICE(INTEL, 0x7a7c), (kernel_ulong_t)&bxt_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0x7a7d), (kernel_ulong_t)&bxt_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0x7a7e), (kernel_ulong_t)&bxt_uart_info },
 	/* ADL-S */
 	{ PCI_VDEVICE(INTEL, 0x7aa8), (kernel_ulong_t)&bxt_uart_info },
 	{ PCI_VDEVICE(INTEL, 0x7aa9), (kernel_ulong_t)&bxt_uart_info },
-- 
2.34.1

