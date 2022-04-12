Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51A4E4FE816
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 20:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353502AbiDLSgo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 14:36:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243447AbiDLSgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 14:36:40 -0400
Received: from relay4.hostedemail.com (relay4.hostedemail.com [64.99.140.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB7323B005
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 11:34:18 -0700 (PDT)
Received: from omf19.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay12.hostedemail.com (Postfix) with ESMTP id CBF7D122568;
        Tue, 12 Apr 2022 18:34:17 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf19.hostedemail.com (Postfix) with ESMTPA id DEBF620026;
        Tue, 12 Apr 2022 18:34:16 +0000 (UTC)
Message-ID: <04eb301f5b3adbefdd78e76657eff0acb3e3d87f.camel@perches.com>
Subject: [PATCH] MAINTAINERS: Broadcom internal lists aren't maintainers
From:   Joe Perches <joe@perches.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     bcm-kernel-feedback-list@broadcom.com,
        LKML <linux-kernel@vger.kernel.org>
Date:   Tue, 12 Apr 2022 11:34:15 -0700
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: DEBF620026
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Stat-Signature: br7iz4upt3xza6e4yc3o8uiqtosr8zga
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/JnjivEUPuA3R/QA17Ahu/0BAGxspo9qU=
X-HE-Tag: 1649788456-329293
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the broadcom internal list M: and L: entries to R: as
exploder email addresses are neither maintainers nor mailing lists.

Reorder the entries as necessary.

Signed-off-by: Joe Perches <joe@perches.com>
---
 MAINTAINERS | 64 ++++++++++++++++++++++++++++++-------------------------------
 1 file changed, 32 insertions(+), 32 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 47d9862b21a95..0278782c14e19 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3746,7 +3746,7 @@ F:	include/linux/platform_data/b53.h
 
 BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE
 M:	Nicolas Saenz Julienne <nsaenz@kernel.org>
-L:	bcm-kernel-feedback-list@broadcom.com
+R:	Broadcom Kernel Team <bcm-kernel-feedback-list@broadcom.com>
 L:	linux-rpi-kernel@lists.infradead.org (moderated for non-subscribers)
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
@@ -3761,7 +3761,7 @@ BROADCOM BCM281XX/BCM11XXX/BCM216XX ARM ARCHITECTURE
 M:	Florian Fainelli <f.fainelli@gmail.com>
 M:	Ray Jui <rjui@broadcom.com>
 M:	Scott Branden <sbranden@broadcom.com>
-M:	bcm-kernel-feedback-list@broadcom.com
+R:	Broadcom Kernel Team <bcm-kernel-feedback-list@broadcom.com>
 S:	Maintained
 T:	git git://github.com/broadcom/mach-bcm
 F:	arch/arm/mach-bcm/
@@ -3781,7 +3781,7 @@ F:	arch/mips/include/asm/mach-bcm47xx/*
 
 BROADCOM BCM4908 ETHERNET DRIVER
 M:	Rafał Miłecki <rafal@milecki.pl>
-M:	bcm-kernel-feedback-list@broadcom.com
+R:	Broadcom Kernel Team <bcm-kernel-feedback-list@broadcom.com>
 L:	netdev@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/net/brcm,bcm4908-enet.yaml
@@ -3790,7 +3790,7 @@ F:	drivers/net/ethernet/broadcom/unimac.h
 
 BROADCOM BCM4908 PINMUX DRIVER
 M:	Rafał Miłecki <rafal@milecki.pl>
-M:	bcm-kernel-feedback-list@broadcom.com
+R:	Broadcom Kernel Team <bcm-kernel-feedback-list@broadcom.com>
 L:	linux-gpio@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/pinctrl/brcm,bcm4908-pinctrl.yaml
@@ -3800,7 +3800,7 @@ BROADCOM BCM5301X ARM ARCHITECTURE
 M:	Florian Fainelli <f.fainelli@gmail.com>
 M:	Hauke Mehrtens <hauke@hauke-m.de>
 M:	Rafał Miłecki <zajec5@gmail.com>
-M:	bcm-kernel-feedback-list@broadcom.com
+R:	Broadcom Kernel Team <bcm-kernel-feedback-list@broadcom.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	arch/arm/boot/dts/bcm470*
@@ -3811,7 +3811,7 @@ F:	arch/arm/mach-bcm/bcm_5301x.c
 BROADCOM BCM53573 ARM ARCHITECTURE
 M:	Florian Fainelli <f.fainelli@gmail.com>
 M:	Rafał Miłecki <rafal@milecki.pl>
-L:	bcm-kernel-feedback-list@broadcom.com
+R:	Broadcom Kernel Team <bcm-kernel-feedback-list@broadcom.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	arch/arm/boot/dts/bcm47189*
@@ -3819,7 +3819,7 @@ F:	arch/arm/boot/dts/bcm53573*
 
 BROADCOM BCM63XX ARM ARCHITECTURE
 M:	Florian Fainelli <f.fainelli@gmail.com>
-M:	bcm-kernel-feedback-list@broadcom.com
+R:	Broadcom Kernel Team <bcm-kernel-feedback-list@broadcom.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 T:	git git://github.com/broadcom/stblinux.git
@@ -3833,7 +3833,7 @@ F:	drivers/usb/gadget/udc/bcm63xx_udc.*
 
 BROADCOM BCM7XXX ARM ARCHITECTURE
 M:	Florian Fainelli <f.fainelli@gmail.com>
-M:	bcm-kernel-feedback-list@broadcom.com
+R:	Broadcom Kernel Team <bcm-kernel-feedback-list@broadcom.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 T:	git git://github.com/broadcom/stblinux.git
@@ -3851,21 +3851,21 @@ N:	bcm7120
 BROADCOM BDC DRIVER
 M:	Al Cooper <alcooperx@gmail.com>
 L:	linux-usb@vger.kernel.org
-L:	bcm-kernel-feedback-list@broadcom.com
+R:	Broadcom Kernel Team <bcm-kernel-feedback-list@broadcom.com>
 S:	Maintained
 F:	Documentation/devicetree/bindings/usb/brcm,bdc.yaml
 F:	drivers/usb/gadget/udc/bdc/
 
 BROADCOM BMIPS CPUFREQ DRIVER
 M:	Markus Mayer <mmayer@broadcom.com>
-M:	bcm-kernel-feedback-list@broadcom.com
+R:	Broadcom Kernel Team <bcm-kernel-feedback-list@broadcom.com>
 L:	linux-pm@vger.kernel.org
 S:	Maintained
 F:	drivers/cpufreq/bmips-cpufreq.c
 
 BROADCOM BMIPS MIPS ARCHITECTURE
 M:	Florian Fainelli <f.fainelli@gmail.com>
-L:	bcm-kernel-feedback-list@broadcom.com
+R:	Broadcom Kernel Team <bcm-kernel-feedback-list@broadcom.com>
 L:	linux-mips@vger.kernel.org
 S:	Maintained
 T:	git git://github.com/broadcom/stblinux.git
@@ -3931,53 +3931,53 @@ F:	drivers/net/wireless/broadcom/brcm80211/
 BROADCOM BRCMSTB GPIO DRIVER
 M:	Doug Berger <opendmb@gmail.com>
 M:	Florian Fainelli <f.fainelli@gmail.com>
-L:	bcm-kernel-feedback-list@broadcom.com
+R:	Broadcom Kernel Team <bcm-kernel-feedback-list@broadcom.com>
 S:	Supported
 F:	Documentation/devicetree/bindings/gpio/brcm,brcmstb-gpio.yaml
 F:	drivers/gpio/gpio-brcmstb.c
 
 BROADCOM BRCMSTB I2C DRIVER
 M:	Kamal Dasu <kdasu.kdev@gmail.com>
+R:	Broadcom Kernel Team <bcm-kernel-feedback-list@broadcom.com>
 L:	linux-i2c@vger.kernel.org
-L:	bcm-kernel-feedback-list@broadcom.com
 S:	Supported
 F:	Documentation/devicetree/bindings/i2c/brcm,brcmstb-i2c.yaml
 F:	drivers/i2c/busses/i2c-brcmstb.c
 
 BROADCOM BRCMSTB UART DRIVER
 M:	Al Cooper <alcooperx@gmail.com>
+R:	Broadcom Kernel Team <bcm-kernel-feedback-list@broadcom.com>
 L:	linux-serial@vger.kernel.org
-L:	bcm-kernel-feedback-list@broadcom.com
 S:	Maintained
 F:	Documentation/devicetree/bindings/serial/brcm,bcm7271-uart.yaml
 F:	drivers/tty/serial/8250/8250_bcm7271.c
 
 BROADCOM BRCMSTB USB EHCI DRIVER
 M:	Al Cooper <alcooperx@gmail.com>
+R:	Broadcom Kernel Team <bcm-kernel-feedback-list@broadcom.com>
 L:	linux-usb@vger.kernel.org
-L:	bcm-kernel-feedback-list@broadcom.com
 S:	Maintained
 F:	Documentation/devicetree/bindings/usb/brcm,bcm7445-ehci.yaml
 F:	drivers/usb/host/ehci-brcm.*
 
 BROADCOM BRCMSTB USB PIN MAP DRIVER
 M:	Al Cooper <alcooperx@gmail.com>
+R:	Broadcom Kernel Team <bcm-kernel-feedback-list@broadcom.com>
 L:	linux-usb@vger.kernel.org
-L:	bcm-kernel-feedback-list@broadcom.com
 S:	Maintained
 F:	Documentation/devicetree/bindings/usb/brcm,usb-pinmap.yaml
 F:	drivers/usb/misc/brcmstb-usb-pinmap.c
 
 BROADCOM BRCMSTB USB2 and USB3 PHY DRIVER
 M:	Al Cooper <alcooperx@gmail.com>
+R:	Broadcom Kernel Team <bcm-kernel-feedback-list@broadcom.com>
 L:	linux-kernel@vger.kernel.org
-L:	bcm-kernel-feedback-list@broadcom.com
 S:	Maintained
 F:	drivers/phy/broadcom/phy-brcm-usb*
 
 BROADCOM ETHERNET PHY DRIVERS
 M:	Florian Fainelli <f.fainelli@gmail.com>
-L:	bcm-kernel-feedback-list@broadcom.com
+R:	Broadcom Kernel Team <bcm-kernel-feedback-list@broadcom.com>
 L:	netdev@vger.kernel.org
 S:	Supported
 F:	Documentation/devicetree/bindings/net/broadcom-bcm87xx.txt
@@ -3988,7 +3988,7 @@ F:	include/linux/brcmphy.h
 BROADCOM GENET ETHERNET DRIVER
 M:	Doug Berger <opendmb@gmail.com>
 M:	Florian Fainelli <f.fainelli@gmail.com>
-L:	bcm-kernel-feedback-list@broadcom.com
+R:	Broadcom Kernel Team <bcm-kernel-feedback-list@broadcom.com>
 L:	netdev@vger.kernel.org
 S:	Supported
 F:	Documentation/devicetree/bindings/net/brcm,bcmgenet.yaml
@@ -4002,7 +4002,7 @@ F:	include/linux/platform_data/mdio-bcm-unimac.h
 BROADCOM IPROC ARM ARCHITECTURE
 M:	Ray Jui <rjui@broadcom.com>
 M:	Scott Branden <sbranden@broadcom.com>
-M:	bcm-kernel-feedback-list@broadcom.com
+R:	Broadcom Kernel Team <bcm-kernel-feedback-list@broadcom.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 T:	git git://github.com/broadcom/stblinux.git
@@ -4030,7 +4030,7 @@ N:	stingray
 
 BROADCOM IPROC GBIT ETHERNET DRIVER
 M:	Rafał Miłecki <rafal@milecki.pl>
-M:	bcm-kernel-feedback-list@broadcom.com
+R:	Broadcom Kernel Team <bcm-kernel-feedback-list@broadcom.com>
 L:	netdev@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/net/brcm,amac.yaml
@@ -4039,7 +4039,7 @@ F:	drivers/net/ethernet/broadcom/unimac.h
 
 BROADCOM KONA GPIO DRIVER
 M:	Ray Jui <rjui@broadcom.com>
-L:	bcm-kernel-feedback-list@broadcom.com
+R:	Broadcom Kernel Team <bcm-kernel-feedback-list@broadcom.com>
 S:	Supported
 F:	Documentation/devicetree/bindings/gpio/brcm,kona-gpio.txt
 F:	drivers/gpio/gpio-bcm-kona.c
@@ -4072,7 +4072,7 @@ F:	drivers/firmware/broadcom/*
 BROADCOM PMB (POWER MANAGEMENT BUS) DRIVER
 M:	Rafał Miłecki <rafal@milecki.pl>
 M:	Florian Fainelli <f.fainelli@gmail.com>
-M:	bcm-kernel-feedback-list@broadcom.com
+R:	Broadcom Kernel Team <bcm-kernel-feedback-list@broadcom.com>
 L:	linux-pm@vger.kernel.org
 S:	Maintained
 T:	git git://github.com/broadcom/stblinux.git
@@ -4088,7 +4088,7 @@ F:	include/linux/bcma/
 
 BROADCOM SPI DRIVER
 M:	Kamal Dasu <kdasu.kdev@gmail.com>
-M:	bcm-kernel-feedback-list@broadcom.com
+R:	Broadcom Kernel Team <bcm-kernel-feedback-list@broadcom.com>
 S:	Maintained
 F:	Documentation/devicetree/bindings/spi/brcm,spi-bcm-qspi.yaml
 F:	drivers/spi/spi-bcm-qspi.*
@@ -4097,7 +4097,7 @@ F:	drivers/spi/spi-iproc-qspi.c
 
 BROADCOM STB AVS CPUFREQ DRIVER
 M:	Markus Mayer <mmayer@broadcom.com>
-M:	bcm-kernel-feedback-list@broadcom.com
+R:	Broadcom Kernel Team <bcm-kernel-feedback-list@broadcom.com>
 L:	linux-pm@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/cpufreq/brcm,stb-avs-cpu-freq.txt
@@ -4105,7 +4105,7 @@ F:	drivers/cpufreq/brcmstb*
 
 BROADCOM STB AVS TMON DRIVER
 M:	Markus Mayer <mmayer@broadcom.com>
-M:	bcm-kernel-feedback-list@broadcom.com
+R:	Broadcom Kernel Team <bcm-kernel-feedback-list@broadcom.com>
 L:	linux-pm@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/thermal/brcm,avs-tmon.yaml
@@ -4113,7 +4113,7 @@ F:	drivers/thermal/broadcom/brcmstb*
 
 BROADCOM STB DPFE DRIVER
 M:	Markus Mayer <mmayer@broadcom.com>
-M:	bcm-kernel-feedback-list@broadcom.com
+R:	Broadcom Kernel Team <bcm-kernel-feedback-list@broadcom.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	Documentation/devicetree/bindings/memory-controllers/brcm,dpfe-cpu.yaml
@@ -4122,8 +4122,8 @@ F:	drivers/memory/brcmstb_dpfe.c
 BROADCOM STB NAND FLASH DRIVER
 M:	Brian Norris <computersforpeace@gmail.com>
 M:	Kamal Dasu <kdasu.kdev@gmail.com>
+R:	Broadcom Kernel Team <bcm-kernel-feedback-list@broadcom.com>
 L:	linux-mtd@lists.infradead.org
-L:	bcm-kernel-feedback-list@broadcom.com
 S:	Maintained
 F:	drivers/mtd/nand/raw/brcmnand/
 F:	include/linux/platform_data/brcmnand.h
@@ -4132,7 +4132,7 @@ BROADCOM STB PCIE DRIVER
 M:	Jim Quinlan <jim2101024@gmail.com>
 M:	Nicolas Saenz Julienne <nsaenz@kernel.org>
 M:	Florian Fainelli <f.fainelli@gmail.com>
-M:	bcm-kernel-feedback-list@broadcom.com
+R:	Broadcom Kernel Team <bcm-kernel-feedback-list@broadcom.com>
 L:	linux-pci@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
@@ -4140,7 +4140,7 @@ F:	drivers/pci/controller/pcie-brcmstb.c
 
 BROADCOM SYSTEMPORT ETHERNET DRIVER
 M:	Florian Fainelli <f.fainelli@gmail.com>
-L:	bcm-kernel-feedback-list@broadcom.com
+R:	Broadcom Kernel Team <bcm-kernel-feedback-list@broadcom.com>
 L:	netdev@vger.kernel.org
 S:	Supported
 F:	drivers/net/ethernet/broadcom/bcmsysport.*
@@ -4157,7 +4157,7 @@ F:	drivers/net/ethernet/broadcom/tg3.*
 
 BROADCOM VK DRIVER
 M:	Scott Branden <scott.branden@broadcom.com>
-L:	bcm-kernel-feedback-list@broadcom.com
+R:	Broadcom Kernel Team <bcm-kernel-feedback-list@broadcom.com>
 S:	Supported
 F:	drivers/misc/bcm-vk/
 F:	include/uapi/linux/misc/bcm_vk.h
@@ -17671,8 +17671,8 @@ K:	\bTIF_SECCOMP\b
 
 SECURE DIGITAL HOST CONTROLLER INTERFACE (SDHCI) Broadcom BRCMSTB DRIVER
 M:	Al Cooper <alcooperx@gmail.com>
+R:	Broadcom Kernel Team <bcm-kernel-feedback-list@broadcom.com>
 L:	linux-mmc@vger.kernel.org
-L:	bcm-kernel-feedback-list@broadcom.com
 S:	Maintained
 F:	drivers/mmc/host/sdhci-brcmstb*
 

