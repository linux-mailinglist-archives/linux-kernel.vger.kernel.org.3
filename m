Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 151314F4875
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 02:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbiDEVjs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 17:39:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382370AbiDEMPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 08:15:04 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21DF1A8886;
        Tue,  5 Apr 2022 04:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1649157927; x=1680693927;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VyOpHSV5HKkBdPnmNq5O+pK+4MQGLYr78YNp/R3g7B4=;
  b=t8iYuilbKLzNj1kcbqzJxUoEE58Rlx7Ip3NzCvTF9uLNPWiW0uWrVv8f
   zy3iptPUApl6Ne7Cj0kG/01usEagfPhi/9j9/0+mCv+/hwxUFtIClEWBh
   3EqjB2N/aHixxbwHbAYmwZAiu2PGuj64HgTQvl5Vj3towhDrXBhd/jip3
   wWyU6UaBQtSvVxXTYAjEKtgxPQjarOq+o6ej6wG0FKFaeqcUrzVfAtT5c
   ZAVS4yIkeWxFlOw0lDTNg92PDOR7KpLP2r3oSXVPrT+qBH9ISKrlA2MR8
   LtA7hKS02hAwAOO4MoWkjQ4vmKSqFe+W0PX3CqQzsIQiyM9AZNvKXSt5r
   g==;
X-IronPort-AV: E=Sophos;i="5.90,236,1643698800"; 
   d="scan'208";a="158916307"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 05 Apr 2022 04:25:26 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 5 Apr 2022 04:25:24 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Tue, 5 Apr 2022 04:25:22 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <robh+dt@kernel.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <p.zabel@pengutronix.de>,
        <sre@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 1/8] ARM: dts: at91: use generic name for reset controller
Date:   Tue, 5 Apr 2022 14:27:17 +0300
Message-ID: <20220405112724.2760905-2-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220405112724.2760905-1-claudiu.beznea@microchip.com>
References: <20220405112724.2760905-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use generic name for reset controller of AT91 devices to comply with
DT specifications.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 arch/arm/boot/dts/at91sam9260.dtsi | 2 +-
 arch/arm/boot/dts/at91sam9261.dtsi | 2 +-
 arch/arm/boot/dts/at91sam9263.dtsi | 2 +-
 arch/arm/boot/dts/at91sam9g45.dtsi | 2 +-
 arch/arm/boot/dts/at91sam9n12.dtsi | 2 +-
 arch/arm/boot/dts/at91sam9rl.dtsi  | 2 +-
 arch/arm/boot/dts/at91sam9x5.dtsi  | 2 +-
 arch/arm/boot/dts/sam9x60.dtsi     | 2 +-
 arch/arm/boot/dts/sama5d2.dtsi     | 2 +-
 arch/arm/boot/dts/sama5d3.dtsi     | 2 +-
 arch/arm/boot/dts/sama5d4.dtsi     | 2 +-
 11 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/arm/boot/dts/at91sam9260.dtsi b/arch/arm/boot/dts/at91sam9260.dtsi
index 7368347c9357..9d9820db9482 100644
--- a/arch/arm/boot/dts/at91sam9260.dtsi
+++ b/arch/arm/boot/dts/at91sam9260.dtsi
@@ -123,7 +123,7 @@ pmc: pmc@fffffc00 {
 				clock-names = "slow_xtal", "main_xtal";
 			};
 
-			rstc@fffffd00 {
+			reset-controller@fffffd00 {
 				compatible = "atmel,at91sam9260-rstc";
 				reg = <0xfffffd00 0x10>;
 				clocks = <&pmc PMC_TYPE_CORE PMC_SLOW>;
diff --git a/arch/arm/boot/dts/at91sam9261.dtsi b/arch/arm/boot/dts/at91sam9261.dtsi
index 7adc36ca8a46..259aca565305 100644
--- a/arch/arm/boot/dts/at91sam9261.dtsi
+++ b/arch/arm/boot/dts/at91sam9261.dtsi
@@ -603,7 +603,7 @@ pmc: pmc@fffffc00 {
 				clock-names = "slow_xtal", "main_xtal";
 			};
 
-			rstc@fffffd00 {
+			reset-controller@fffffd00 {
 				compatible = "atmel,at91sam9260-rstc";
 				reg = <0xfffffd00 0x10>;
 				clocks = <&slow_xtal>;
diff --git a/arch/arm/boot/dts/at91sam9263.dtsi b/arch/arm/boot/dts/at91sam9263.dtsi
index fe45d96239c9..c080df8c2312 100644
--- a/arch/arm/boot/dts/at91sam9263.dtsi
+++ b/arch/arm/boot/dts/at91sam9263.dtsi
@@ -151,7 +151,7 @@ tcb0: timer@fff7c000 {
 				clock-names = "t0_clk", "slow_clk";
 			};
 
-			rstc@fffffd00 {
+			reset-controller@fffffd00 {
 				compatible = "atmel,at91sam9260-rstc";
 				reg = <0xfffffd00 0x10>;
 				clocks = <&slow_xtal>;
diff --git a/arch/arm/boot/dts/at91sam9g45.dtsi b/arch/arm/boot/dts/at91sam9g45.dtsi
index 2ab730fd6472..09794561c7ce 100644
--- a/arch/arm/boot/dts/at91sam9g45.dtsi
+++ b/arch/arm/boot/dts/at91sam9g45.dtsi
@@ -137,7 +137,7 @@ pmc: pmc@fffffc00 {
 				clock-names = "slow_clk", "main_xtal";
 			};
 
-			rstc@fffffd00 {
+			reset-controller@fffffd00 {
 				compatible = "atmel,at91sam9g45-rstc";
 				reg = <0xfffffd00 0x10>;
 				clocks = <&clk32k>;
diff --git a/arch/arm/boot/dts/at91sam9n12.dtsi b/arch/arm/boot/dts/at91sam9n12.dtsi
index 0785389f5507..556f35ce49e3 100644
--- a/arch/arm/boot/dts/at91sam9n12.dtsi
+++ b/arch/arm/boot/dts/at91sam9n12.dtsi
@@ -126,7 +126,7 @@ pmc: pmc@fffffc00 {
 				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
 			};
 
-			rstc@fffffe00 {
+			reset-controller@fffffe00 {
 				compatible = "atmel,at91sam9g45-rstc";
 				reg = <0xfffffe00 0x10>;
 				clocks = <&clk32k>;
diff --git a/arch/arm/boot/dts/at91sam9rl.dtsi b/arch/arm/boot/dts/at91sam9rl.dtsi
index 730d1182c73e..12c634811820 100644
--- a/arch/arm/boot/dts/at91sam9rl.dtsi
+++ b/arch/arm/boot/dts/at91sam9rl.dtsi
@@ -766,7 +766,7 @@ pmc: pmc@fffffc00 {
 				clock-names = "slow_clk", "main_xtal";
 			};
 
-			rstc@fffffd00 {
+			reset-controller@fffffd00 {
 				compatible = "atmel,at91sam9260-rstc";
 				reg = <0xfffffd00 0x10>;
 				clocks = <&clk32k>;
diff --git a/arch/arm/boot/dts/at91sam9x5.dtsi b/arch/arm/boot/dts/at91sam9x5.dtsi
index 395e883644cd..ea3b11336c79 100644
--- a/arch/arm/boot/dts/at91sam9x5.dtsi
+++ b/arch/arm/boot/dts/at91sam9x5.dtsi
@@ -134,7 +134,7 @@ pmc: pmc@fffffc00 {
 				clock-names = "slow_clk", "main_xtal";
 			};
 
-			reset_controller: rstc@fffffe00 {
+			reset_controller: reset-controller@fffffe00 {
 				compatible = "atmel,at91sam9g45-rstc";
 				reg = <0xfffffe00 0x10>;
 				clocks = <&clk32k>;
diff --git a/arch/arm/boot/dts/sam9x60.dtsi b/arch/arm/boot/dts/sam9x60.dtsi
index ec45ced3cde6..211e743e2597 100644
--- a/arch/arm/boot/dts/sam9x60.dtsi
+++ b/arch/arm/boot/dts/sam9x60.dtsi
@@ -671,7 +671,7 @@ pmc: pmc@fffffc00 {
 				clock-names = "td_slck", "md_slck", "main_xtal";
 			};
 
-			reset_controller: rstc@fffffe00 {
+			reset_controller: reset-controller@fffffe00 {
 				compatible = "microchip,sam9x60-rstc";
 				reg = <0xfffffe00 0x10>;
 				clocks = <&clk32k 0>;
diff --git a/arch/arm/boot/dts/sama5d2.dtsi b/arch/arm/boot/dts/sama5d2.dtsi
index 09c741e8ecb8..769befc06b57 100644
--- a/arch/arm/boot/dts/sama5d2.dtsi
+++ b/arch/arm/boot/dts/sama5d2.dtsi
@@ -662,7 +662,7 @@ securam: sram@f8044000 {
 				ranges = <0 0xf8044000 0x1420>;
 			};
 
-			reset_controller: rstc@f8048000 {
+			reset_controller: reset-controller@f8048000 {
 				compatible = "atmel,sama5d3-rstc";
 				reg = <0xf8048000 0x10>;
 				clocks = <&clk32k>;
diff --git a/arch/arm/boot/dts/sama5d3.dtsi b/arch/arm/boot/dts/sama5d3.dtsi
index d1841bffe3c5..ab124c09f70e 100644
--- a/arch/arm/boot/dts/sama5d3.dtsi
+++ b/arch/arm/boot/dts/sama5d3.dtsi
@@ -1003,7 +1003,7 @@ pmc: pmc@fffffc00 {
 				clock-names = "slow_clk", "main_xtal";
 			};
 
-			reset_controller: rstc@fffffe00 {
+			reset_controller: reset-controller@fffffe00 {
 				compatible = "atmel,sama5d3-rstc", "atmel,at91sam9g45-rstc";
 				reg = <0xfffffe00 0x10>;
 				clocks = <&clk32k>;
diff --git a/arch/arm/boot/dts/sama5d4.dtsi b/arch/arm/boot/dts/sama5d4.dtsi
index f6e3e6f57252..bc41d302dbf3 100644
--- a/arch/arm/boot/dts/sama5d4.dtsi
+++ b/arch/arm/boot/dts/sama5d4.dtsi
@@ -729,7 +729,7 @@ pmecc: ecc-engine@ffffc070 {
 				};
 			};
 
-			reset_controller: rstc@fc068600 {
+			reset_controller: reset-controller@fc068600 {
 				compatible = "atmel,sama5d3-rstc", "atmel,at91sam9g45-rstc";
 				reg = <0xfc068600 0x10>;
 				clocks = <&clk32k>;
-- 
2.32.0

