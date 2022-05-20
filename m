Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E50D252F3D8
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 21:36:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241221AbiETTgK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 15:36:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbiETTfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 15:35:55 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E50AD12746
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 12:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653075352; x=1684611352;
  h=from:to:cc:subject:date:message-id;
  bh=w2JnZrIp8/jMmEigdBtBfWMoSXN8kT5Zs5nenVJullg=;
  b=k4leO0bce+s2cLtF6lgUKrhXMV2oCjlwqOMQoBBeYS78JT0AO+JGpW/U
   fEKxzmc/PHRs4n0h0aKRsRQWNlljihPI9aqK7e6Lt+krFoMRyAJyoVLKA
   gVZ2kq+gs9uFixpFrzsvUMp03nPF6owXfb+0FCfKzQejyHyu1athvhzZ4
   bzVoIb/eqE2uNVB4upqhIiw25gNwuXstnmAjw1Zro+o2Kw3xDNnepJAXa
   04S2ND2zujp3SBr1eCa4DyVB6q6SyshiqjFsRjoNeXZSTrBylDE1UF1E4
   07H1GLI3F2r63XRG8xs19YkUFSiPQFb3gp5vuYJvHdurJMz9/97Jnwm17
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10353"; a="333336489"
X-IronPort-AV: E=Sophos;i="5.91,240,1647327600"; 
   d="scan'208";a="333336489"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2022 12:35:52 -0700
X-IronPort-AV: E=Sophos;i="5.91,240,1647327600"; 
   d="scan'208";a="570985122"
Received: from gaggery-w2600cr.sc.intel.com ([10.3.63.151])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2022 12:35:52 -0700
From:   gaggery.tsai@intel.com
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>,
        Orlando Chamberlain <redecorating@protonmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Gaggery Tsai <gaggery.tsai@intel.com>
Subject: [PATCH v1 1/1] mfd: intel-lpss: Add support for ADL-P i2c6 and i2c7
Date:   Fri, 20 May 2022 12:35:37 -0700
Message-Id: <20220520193537.26090-1-gaggery.tsai@intel.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gaggery Tsai <gaggery.tsai@intel.com>

Added 8086:51d8 and 8086:51d9 to the intel_lpss_pci driver. They are
Intel Alder Lake-P i2c controllers.

Signed-off-by: Gaggery Tsai <gaggery.tsai@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mfd/intel-lpss-pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mfd/intel-lpss-pci.c b/drivers/mfd/intel-lpss-pci.c
index 962ee14c62dd..f7950d2197df 100644
--- a/drivers/mfd/intel-lpss-pci.c
+++ b/drivers/mfd/intel-lpss-pci.c
@@ -319,6 +319,8 @@ static const struct pci_device_id intel_lpss_pci_ids[] = {
 	{ PCI_VDEVICE(INTEL, 0x51c5), (kernel_ulong_t)&bxt_i2c_info },
 	{ PCI_VDEVICE(INTEL, 0x51c6), (kernel_ulong_t)&bxt_i2c_info },
 	{ PCI_VDEVICE(INTEL, 0x51c7), (kernel_ulong_t)&bxt_uart_info },
+	{ PCI_VDEVICE(INTEL, 0x51d8), (kernel_ulong_t)&bxt_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0x51d9), (kernel_ulong_t)&bxt_i2c_info },
 	{ PCI_VDEVICE(INTEL, 0x51e8), (kernel_ulong_t)&bxt_i2c_info },
 	{ PCI_VDEVICE(INTEL, 0x51e9), (kernel_ulong_t)&bxt_i2c_info },
 	{ PCI_VDEVICE(INTEL, 0x51ea), (kernel_ulong_t)&bxt_i2c_info },
-- 
2.17.1

