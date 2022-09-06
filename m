Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1D945AE8B7
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 14:49:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240143AbiIFMtL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 08:49:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232428AbiIFMtJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 08:49:09 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80C19558D1
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 05:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1662468547; x=1694004547;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Hi2qklq2xhnRG4gCIuro5N1FGkvddM43euvA3ELuofs=;
  b=GZpYqsZwZsvBfZMlZhC2+OLudIsW1UBkj3pgRCl4bhe+aau8G4D0jbJ3
   xl4H3yYRIuDqKbsHClVXKTepOJmMO7NedYYtcD8PD9X/bF5ZRTWB9Huka
   BEDXB4y9pYbmLSGQOM+rQSMtc6roRr6AaNG4dbboXWHEnfA/OAtQMEoGI
   3sHclareIFovP2Fd60sV8Bt+pF+QlEnEdOqhiTQ+/d8GQ8gplF6ZBZcv4
   X8DP1avxBOywAZa8B4ytSClOwsRn2w4WphMcVhkY0ZmpirgH1lwM0dI0F
   HjqoZTErQpvyXypJ2wAcmVBtwNwKGXY3zplo20cfMFdFfO96CQX77Hc31
   g==;
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="179335532"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 Sep 2022 05:49:07 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Tue, 6 Sep 2022 05:49:07 -0700
Received: from CHE-LT-UNGSOFTWARE.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Tue, 6 Sep 2022 05:49:05 -0700
From:   Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>
To:     <linux-kernel@vger.kernel.org>, <kbuild-all@lists.01.org>,
        <lkp@intel.com>, <gregkh@linuxfoundation.org>,
        <kumaravel.thiagarajan@microchip.com>
Subject: [PATCH v3 char-misc-next] misc: microchip: pci1xxxx: fix dependency issues in building the pci1xxxx's aux bus driver.
Date:   Tue, 6 Sep 2022 18:19:51 +0530
Message-ID: <20220906124951.696776-1-kumaravel.thiagarajan@microchip.com>
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

build errors and warnings listed below and reported by kernel
test robot <lkp@intel.com> on the char-misc-next branch are
fixed in this add-on patch.

errors:
ERROR: modpost: "auxiliary_device_init" [drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gp.ko] undefined!
ERROR: modpost: "__auxiliary_device_add" [drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gp.ko] undefined!
ERROR: modpost: "auxiliary_driver_unregister" [drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gpio.ko] undefined!
ERROR: modpost: "__auxiliary_driver_register" [drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gpio.ko] undefined!
ia64-linux-ld: drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gp.o: in function `gp_aux_bus_probe.part.0':
mchp_pci1xxxx_gp.c:(.text+0x342): undefined reference to `auxiliary_device_init'
ia64-linux-ld: mchp_pci1xxxx_gp.c:(.text+0x392): undefined reference to `__auxiliary_device_add'
ia64-linux-ld: mchp_pci1xxxx_gp.c:(.text+0x5c2): undefined reference to `auxiliary_device_init'
ia64-linux-ld: mchp_pci1xxxx_gp.c:(.text+0x612): undefined reference to `__auxiliary_device_add'
ia64-linux-ld: drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gpio.o: in function `pci1xxxx_gpio_driver_init':
mchp_pci1xxxx_gpio.c:(.init.text+0x42): undefined reference to `__auxiliary_driver_register'

warnings:
unmet direct dependencies detected for GPIOLIB_IRQCHIP when selected by GP_PCI1XXXX

Fixes: 393fc2f5948f ("misc: microchip: pci1xxxx: load auxiliary bus driver for the PIO function in the multi-function endpoint of pci1xxxx device.")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>
---
Changes in v3:
  - Unwrap the error messages & warnings to display in single line

Changes in v2:
  - Shorten the subject line.
  - List the errors and warnings that would be fixed by this patch
  - In Fixes Tag, add only first 12 characters of SHA-1 and include one
    line summary
---
 drivers/misc/mchp_pci1xxxx/Kconfig | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/mchp_pci1xxxx/Kconfig b/drivers/misc/mchp_pci1xxxx/Kconfig
index f6a6970d2a59..4abb47de7219 100644
--- a/drivers/misc/mchp_pci1xxxx/Kconfig
+++ b/drivers/misc/mchp_pci1xxxx/Kconfig
@@ -1,7 +1,9 @@
 config GP_PCI1XXXX
        tristate "Microchip PCI1XXXX PCIe to GPIO Expander + OTP/EEPROM manager"
-       depends on PCI	
+       depends on PCI
+       depends on GPIOLIB
        select GPIOLIB_IRQCHIP
+       select AUXILIARY_BUS
        help
          PCI1XXXX is a PCIe GEN 3 switch with one of the endpoints having
          multiple functions and one of the functions is a GPIO controller
-- 
2.25.1

