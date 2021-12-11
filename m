Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEF32471581
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 20:00:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231795AbhLKTAY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 14:00:24 -0500
Received: from hostingweb31-40.netsons.net ([89.40.174.40]:46978 "EHLO
        hostingweb31-40.netsons.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231765AbhLKTAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 14:00:23 -0500
Received: from [77.244.183.192] (port=64660 helo=melee.fritz.box)
        by hostingweb31.netsons.net with esmtpa (Exim 4.94.2)
        (envelope-from <luca@lucaceresoli.net>)
        id 1mw6g3-0009HU-JY; Sat, 11 Dec 2021 19:00:55 +0100
From:   Luca Ceresoli <luca@lucaceresoli.net>
To:     linux-kernel@vger.kernel.org
Cc:     Luca Ceresoli <luca@lucaceresoli.net>, linux-rtc@vger.kernel.org,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Chiwoong Byun <woong.byun@samsung.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v5 6/9] watchdog: Kconfig: fix help text indentation
Date:   Sat, 11 Dec 2021 18:59:48 +0100
Message-Id: <20211211175951.30763-7-luca@lucaceresoli.net>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211211175951.30763-1-luca@lucaceresoli.net>
References: <20211211175951.30763-1-luca@lucaceresoli.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hostingweb31.netsons.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lucaceresoli.net
X-Get-Message-Sender-Via: hostingweb31.netsons.net: authenticated_id: luca+lucaceresoli.net/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: hostingweb31.netsons.net: luca@lucaceresoli.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some entries indent their help text with 1 tab + 1 space or 1 tab only
instead of 1 tab + 2 spaces. Add the missing spaces.

Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
Acked-by: Randy Dunlap <rdunlap@infradead.org>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>

---

Changes in v5: none

Changes in v4: none

Changes in v3: none
---
 drivers/watchdog/Kconfig | 48 ++++++++++++++++++++--------------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 9d222ba17ec6..a6d97f30325a 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -680,10 +680,10 @@ config MAX77620_WATCHDOG
 	depends on MFD_MAX77620 || COMPILE_TEST
 	select WATCHDOG_CORE
 	help
-	 This is the driver for the Max77620 watchdog timer.
-	 Say 'Y' here to enable the watchdog timer support for
-	 MAX77620 chips. To compile this driver as a module,
-	 choose M here: the module will be called max77620_wdt.
+	  This is the driver for the Max77620 watchdog timer.
+	  Say 'Y' here to enable the watchdog timer support for
+	  MAX77620 chips. To compile this driver as a module,
+	  choose M here: the module will be called max77620_wdt.
 
 config IMX2_WDT
 	tristate "IMX2+ Watchdog"
@@ -1440,26 +1440,26 @@ config TQMX86_WDT
 	depends on X86
 	select WATCHDOG_CORE
 	help
-	This is the driver for the hardware watchdog timer in the TQMX86 IO
-	controller found on some of their ComExpress Modules.
+	  This is the driver for the hardware watchdog timer in the TQMX86 IO
+	  controller found on some of their ComExpress Modules.
 
-	To compile this driver as a module, choose M here; the module
-	will be called tqmx86_wdt.
+	  To compile this driver as a module, choose M here; the module
+	  will be called tqmx86_wdt.
 
-	Most people will say N.
+	  Most people will say N.
 
 config VIA_WDT
 	tristate "VIA Watchdog Timer"
 	depends on X86 && PCI
 	select WATCHDOG_CORE
 	help
-	This is the driver for the hardware watchdog timer on VIA
-	southbridge chipset CX700, VX800/VX820 or VX855/VX875.
+	  This is the driver for the hardware watchdog timer on VIA
+	  southbridge chipset CX700, VX800/VX820 or VX855/VX875.
 
-	To compile this driver as a module, choose M here; the module
-	will be called via_wdt.
+	  To compile this driver as a module, choose M here; the module
+	  will be called via_wdt.
 
-	Most people will say N.
+	  Most people will say N.
 
 config W83627HF_WDT
 	tristate "Watchdog timer for W83627HF/W83627DHG and compatibles"
@@ -1745,10 +1745,10 @@ config BCM7038_WDT
 	depends on HAS_IOMEM
 	depends on ARCH_BRCMSTB || BMIPS_GENERIC || COMPILE_TEST
 	help
-	 Watchdog driver for the built-in hardware in Broadcom 7038 and
-	 later SoCs used in set-top boxes.  BCM7038 was made public
-	 during the 2004 CES, and since then, many Broadcom chips use this
-	 watchdog block, including some cable modem chips.
+	  Watchdog driver for the built-in hardware in Broadcom 7038 and
+	  later SoCs used in set-top boxes.  BCM7038 was made public
+	  during the 2004 CES, and since then, many Broadcom chips use this
+	  watchdog block, including some cable modem chips.
 
 config IMGPDC_WDT
 	tristate "Imagination Technologies PDC Watchdog Timer"
@@ -2109,12 +2109,12 @@ config KEEMBAY_WATCHDOG
 	depends on ARCH_KEEMBAY || (ARM64 && COMPILE_TEST)
 	select WATCHDOG_CORE
 	help
-	 This option enable support for an In-secure watchdog timer driver for
-	 Intel Keem Bay SoC. This WDT has a 32 bit timer and decrements in every
-	 count unit. An interrupt will be triggered, when the count crosses
-	 the threshold configured in the register.
+	  This option enable support for an In-secure watchdog timer driver for
+	  Intel Keem Bay SoC. This WDT has a 32 bit timer and decrements in every
+	  count unit. An interrupt will be triggered, when the count crosses
+	  the threshold configured in the register.
 
-	 To compile this driver as a module, choose M here: the
-	 module will be called keembay_wdt.
+	  To compile this driver as a module, choose M here: the
+	  module will be called keembay_wdt.
 
 endif # WATCHDOG
-- 
2.25.1

