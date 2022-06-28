Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99E0E55F149
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 00:32:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbiF1Wa7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 18:30:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbiF1Waz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 18:30:55 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F88637ABA
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 15:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656455454; x=1687991454;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=WqbvOHtSPkepCglwtnQ+7SAVw0SN06TBCcfCpmv3EOs=;
  b=bx/0HResG68/TV/BPPfTcPBquHxQUJE56argd4aWD4QVfbYgJG4D9mWK
   rWlpZti/4dBQze9IRlrzCI89CIqrUXsiJc0jGH6383dg4LBQb+rYoJC5B
   NLUsJijbYx8VpWGj1EekVj+dGhxYRbeDDgA2vYDEl5xIHhFfH6G9K6Tdg
   1itDtdsw/8SDl2myXUPZR0IPfTGM/XhOmhUu9d3r1WubQkPezH2sO5GPg
   tSfDmmCM6UmRZ63/sR6sHoeT8Y4y6zq5CPpgVR2eO1vL1gO/gTiOIx5N0
   EyN/2Wkr5NSBWdI/nPK6DZsh6zk+HQe8SHPG3ulzGSdWSXEEjeb8+gH35
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10392"; a="307351317"
X-IronPort-AV: E=Sophos;i="5.92,230,1650956400"; 
   d="scan'208";a="307351317"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 15:30:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,230,1650956400"; 
   d="scan'208";a="717594035"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 28 Jun 2022 15:30:44 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 511B3CE; Wed, 29 Jun 2022 01:30:50 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>,
        Orlando Chamberlain <redecorating@protonmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/1] mfd: intel-lpss: Add Intel Meteor Lake-P PCI IDs
Date:   Wed, 29 Jun 2022 01:30:47 +0300
Message-Id: <20220628223047.34301-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Intel Meteor Lake-P LPSS PCI IDs.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mfd/intel-lpss-pci.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/mfd/intel-lpss-pci.c b/drivers/mfd/intel-lpss-pci.c
index f7950d2197df..bb08b7a73fe1 100644
--- a/drivers/mfd/intel-lpss-pci.c
+++ b/drivers/mfd/intel-lpss-pci.c
@@ -385,6 +385,19 @@ static const struct pci_device_id intel_lpss_pci_ids[] = {
 	{ PCI_VDEVICE(INTEL, 0x7afc), (kernel_ulong_t)&bxt_i2c_info },
 	{ PCI_VDEVICE(INTEL, 0x7afd), (kernel_ulong_t)&bxt_i2c_info },
 	{ PCI_VDEVICE(INTEL, 0x7afe), (kernel_ulong_t)&bxt_uart_info },
+	/* MTL-P */
+	{ PCI_VDEVICE(INTEL, 0x7e25), (kernel_ulong_t)&bxt_uart_info },
+	{ PCI_VDEVICE(INTEL, 0x7e26), (kernel_ulong_t)&bxt_uart_info },
+	{ PCI_VDEVICE(INTEL, 0x7e27), (kernel_ulong_t)&bxt_info },
+	{ PCI_VDEVICE(INTEL, 0x7e30), (kernel_ulong_t)&bxt_info },
+	{ PCI_VDEVICE(INTEL, 0x7e46), (kernel_ulong_t)&bxt_info },
+	{ PCI_VDEVICE(INTEL, 0x7e50), (kernel_ulong_t)&bxt_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0x7e51), (kernel_ulong_t)&bxt_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0x7e52), (kernel_ulong_t)&bxt_uart_info },
+	{ PCI_VDEVICE(INTEL, 0x7e78), (kernel_ulong_t)&bxt_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0x7e79), (kernel_ulong_t)&bxt_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0x7e7a), (kernel_ulong_t)&bxt_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0x7e7b), (kernel_ulong_t)&bxt_i2c_info },
 	/* LKF */
 	{ PCI_VDEVICE(INTEL, 0x98a8), (kernel_ulong_t)&bxt_uart_info },
 	{ PCI_VDEVICE(INTEL, 0x98a9), (kernel_ulong_t)&bxt_uart_info },
-- 
2.35.1

