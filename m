Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E6225AABD1
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 11:51:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235547AbiIBJvO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 05:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235589AbiIBJu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 05:50:59 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F5CF3E75F
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 02:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1662112257; x=1693648257;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=bqm+zowBjVzB2+VAXhCBM414+ubRvd6H9wPv94kzRWI=;
  b=0pe4LdBSFN2HOrtPR6Migjz2OqZtmE05NVDcea8hr0bu7Zc89GernnbR
   cxdLACM82RSca8rqgCsE0HBHQ5G3Kyu7dk4NVN/To+g7YbZKOm4pjANoq
   /eGoIX8fUlX78X5Z5wtWIHTk4rD+brh9wWwBWCulOigPd2+e+0Lf3Zlfg
   XCBINazc/KJw0SMPLqZE24Ujmc/bO0SIlLtsYTOH9zCBh4mWFiATskPUY
   cHb52SgB1/j0c+GlznONXmKDuTrRG2MjlOn0wbuGwwLApu3VhwAOrUJdU
   lwbDzcqDWGNkp/lmh+eZRz0akzKwjxeaAjpTG6LsPMMTvtHCmOClPjnqH
   A==;
X-IronPort-AV: E=Sophos;i="5.93,283,1654585200"; 
   d="scan'208";a="111901500"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Sep 2022 02:50:45 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Fri, 2 Sep 2022 02:50:45 -0700
Received: from CHE-LT-UNGSOFTWARE.microchip.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Fri, 2 Sep 2022 02:50:43 -0700
From:   Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>
To:     <linux-kernel@vger.kernel.org>, <gregkh@linuxfoundation.org>
CC:     kernel test robot <lkp@intel.com>
Subject: [PATCH char-misc-testing] misc: microchip: pci1xxxx: fix the build issue due to missing  depends on PCI in the Kconfig file.
Date:   Fri, 2 Sep 2022 15:20:40 +0530
Message-ID: <20220902095041.2429996-1-kumaravel.thiagarajan@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some build errors were reported by the kernel test robot
<lkp@intel.com> on the char-misc-testing branch. This add-on patch
will fix those errors.

Fixes: 3f359bf61b6f65be474fbcdf557cd412f19d0f1d
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>
---
 drivers/misc/mchp_pci1xxxx/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/misc/mchp_pci1xxxx/Kconfig b/drivers/misc/mchp_pci1xxxx/Kconfig
index 387a88addfb0..f6a6970d2a59 100644
--- a/drivers/misc/mchp_pci1xxxx/Kconfig
+++ b/drivers/misc/mchp_pci1xxxx/Kconfig
@@ -1,5 +1,6 @@
 config GP_PCI1XXXX
        tristate "Microchip PCI1XXXX PCIe to GPIO Expander + OTP/EEPROM manager"
+       depends on PCI	
        select GPIOLIB_IRQCHIP
        help
          PCI1XXXX is a PCIe GEN 3 switch with one of the endpoints having
-- 
2.25.1

