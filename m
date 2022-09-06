Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8386E5AE2D5
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 10:36:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239349AbiIFIgW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 04:36:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238867AbiIFIf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 04:35:26 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93B99726B2
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 01:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1662453313; x=1693989313;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=HkzJS+1pxz3+fMJ1d0janqGdg2+3VxYnrZ/Zcj36PUw=;
  b=qlHVZfnM5hm4pukCVfhoX98aOvcRDX6jooJXWpQobtHkiBWQo7qi/Bbv
   cz8redmfZEsxHJGGF9GJ4zmvMoXCJxj1GTzV3eyt5QfHBrLCkhg2i3Dab
   ID8jwdzqAEAwO6zcApKHUDlnE6tVISDvbAWcQ7RCtQhgIo7jdDTozsktP
   vt7mEtl6wCQCEP0bsXM17AK5mUhPuUdg/jidzCZVkzC3b/3O9dzgy+c2Y
   95WZQJuq4zu9kd3paN1RTnk9v8QRQG7ix00TRGogTiT8Rx0l0Zg/3Co+g
   VVSIGPmmN2bep26nOgrZNeBi1eIhPObUeDVRwZCCRJ3LNU9ijMmitp8lS
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,293,1654585200"; 
   d="scan'208";a="179177295"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 Sep 2022 01:35:11 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Tue, 6 Sep 2022 01:35:11 -0700
Received: from CHE-LT-UNGSOFTWARE.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Tue, 6 Sep 2022 01:35:09 -0700
From:   Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>
To:     <linux-kernel@vger.kernel.org>, <kbuild-all@lists.01.org>,
        <lkp@intel.com>, <gregkh@linuxfoundation.org>
Subject: [PATCH char-misc-next] misc: microchip: pci1xxxx: Include depends on PCI & select AUXILIARY_BUS  in the Kconfig file to resolve build issues.
Date:   Tue, 6 Sep 2022 14:05:55 +0530
Message-ID: <20220906083555.475103-1-kumaravel.thiagarajan@microchip.com>
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

Some build errors were reported by kernel test robot <lkp@intel.com> on
the char-misc-next branch. This add-on patch will fix the errors.

Fixes: 393fc2f5948fd340d016a9557eea6e1ac2f6c60c
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>
---
 drivers/misc/mchp_pci1xxxx/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/misc/mchp_pci1xxxx/Kconfig b/drivers/misc/mchp_pci1xxxx/Kconfig
index f6a6970d2a59..0fd0aaa218d5 100644
--- a/drivers/misc/mchp_pci1xxxx/Kconfig
+++ b/drivers/misc/mchp_pci1xxxx/Kconfig
@@ -1,7 +1,9 @@
 config GP_PCI1XXXX
        tristate "Microchip PCI1XXXX PCIe to GPIO Expander + OTP/EEPROM manager"
        depends on PCI	
+       depends on GPIOLIB
        select GPIOLIB_IRQCHIP
+       select AUXILIARY_BUS
        help
          PCI1XXXX is a PCIe GEN 3 switch with one of the endpoints having
          multiple functions and one of the functions is a GPIO controller
-- 
2.25.1

