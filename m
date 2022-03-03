Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1869E4CBFAA
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 15:13:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233972AbiCCON0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 09:13:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbiCCONT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 09:13:19 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C290C10FC5;
        Thu,  3 Mar 2022 06:12:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1646316754; x=1677852754;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TJ2IyJE4LtYevCR0x/vecLHr65fgQK+fMxds3YexPB4=;
  b=c3P1S5kS3Z5ng12DMEPVHGXlFoWmWdNNvvUViR4N76kaXuXTYVbiT6eW
   vhfEUZS90GG+fFPQSbxPvd2Lrerrl3tqN8XQ5ksXJboGGeouuS4INfDPW
   pFwtd+T5tbIGKqkGzwaSxL7crDTzA9w0XYgO2JBU4LMWssklK6jb4L0Ic
   91U/7J7vydo7RX3cw9+uSIOtkgLLuwHjPO58pAI7X26OKqE4tpLFO0VXF
   8f0oFFZcwiVjTHVM2EsU+xDSpmIit7jwCepDkOEceClRbQyWnrBzmwjv4
   rvMK/i+tvcTGwS5cD2c5K1IOkioXQItgBoQMOlCv/Kz9NcTOzg5XIRI0r
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,151,1643698800"; 
   d="scan'208";a="155125641"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 03 Mar 2022 07:12:32 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 3 Mar 2022 07:12:31 -0700
Received: from ROB-ULT-M68701.amer.actel.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Thu, 3 Mar 2022 07:12:26 -0700
From:   Sergiu Moga <sergiu.moga@microchip.com>
To:     <a.zummo@towertech.it>, <alexandre.belloni@bootlin.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski@canonical.com>,
        <nicolas.ferre@microchip.com>, <claudiu.beznea@microchip.com>
CC:     <linux-rtc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Sergiu Moga <sergiu.moga@microchip.com>
Subject: [PATCH v2 1/5] ARM: dts: at91: Move rtt node properties from "dts" file to "dtsi" file
Date:   Thu, 3 Mar 2022 16:06:22 +0200
Message-ID: <20220303140626.38129-2-sergiu.moga@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220303140626.38129-1-sergiu.moga@microchip.com>
References: <20220303140626.38129-1-sergiu.moga@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the properties of the rtt node of RTT IPs from the "dts" file to the
"dtsi" file, since it is more IP specific than it is board specific.

Signed-off-by: Sergiu Moga <sergiu.moga@microchip.com>
---
 arch/arm/boot/dts/at91-sam9x60ek.dts   | 5 -----
 arch/arm/boot/dts/at91-sama7g5ek.dts   | 4 ----
 arch/arm/boot/dts/at91sam9260.dtsi     | 1 +
 arch/arm/boot/dts/at91sam9260ek.dts    | 1 -
 arch/arm/boot/dts/at91sam9g45.dtsi     | 1 +
 arch/arm/boot/dts/at91sam9m10g45ek.dts | 1 -
 arch/arm/boot/dts/sam9x60.dtsi         | 1 +
 arch/arm/boot/dts/sama7g5.dtsi         | 1 +
 8 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/arch/arm/boot/dts/at91-sam9x60ek.dts b/arch/arm/boot/dts/at91-sam9x60ek.dts
index b1068cca4228..97ff91346cb4 100644
--- a/arch/arm/boot/dts/at91-sam9x60ek.dts
+++ b/arch/arm/boot/dts/at91-sam9x60ek.dts
@@ -656,11 +656,6 @@ kernel@200000 {
 	};
 };
 
-&rtt {
-	atmel,rtt-rtc-time-reg = <&gpbr 0x0>;
-	status = "okay";
-};
-
 &shutdown_controller {
 	debounce-delay-us = <976>;
 	status = "okay";
diff --git a/arch/arm/boot/dts/at91-sama7g5ek.dts b/arch/arm/boot/dts/at91-sama7g5ek.dts
index ccf9e224da78..b7416d9469e3 100644
--- a/arch/arm/boot/dts/at91-sama7g5ek.dts
+++ b/arch/arm/boot/dts/at91-sama7g5ek.dts
@@ -708,10 +708,6 @@ &pwm {
 	status = "disabled"; /* Conflict with leds. */
 };
 
-&rtt {
-	atmel,rtt-rtc-time-reg = <&gpbr 0x0>;
-};
-
 &sdmmc0 {
 	bus-width = <8>;
 	non-removable;
diff --git a/arch/arm/boot/dts/at91sam9260.dtsi b/arch/arm/boot/dts/at91sam9260.dtsi
index 7368347c9357..66d11c8f1a9b 100644
--- a/arch/arm/boot/dts/at91sam9260.dtsi
+++ b/arch/arm/boot/dts/at91sam9260.dtsi
@@ -713,6 +713,7 @@ rtc@fffffd20 {
 				reg = <0xfffffd20 0x10>;
 				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
 				clocks = <&pmc PMC_TYPE_CORE PMC_SLOW>;
+				atmel,rtt-rtc-time-reg = <&gpbr 0x0>;
 				status = "disabled";
 			};
 
diff --git a/arch/arm/boot/dts/at91sam9260ek.dts b/arch/arm/boot/dts/at91sam9260ek.dts
index ce96345d28a3..6932dab42f2e 100644
--- a/arch/arm/boot/dts/at91sam9260ek.dts
+++ b/arch/arm/boot/dts/at91sam9260ek.dts
@@ -118,7 +118,6 @@ shdwc@fffffd10 {
 			};
 
 			rtc@fffffd20 {
-				atmel,rtt-rtc-time-reg = <&gpbr 0x0>;
 				status = "okay";
 			};
 
diff --git a/arch/arm/boot/dts/at91sam9g45.dtsi b/arch/arm/boot/dts/at91sam9g45.dtsi
index 2ab730fd6472..fd308e2c15e8 100644
--- a/arch/arm/boot/dts/at91sam9g45.dtsi
+++ b/arch/arm/boot/dts/at91sam9g45.dtsi
@@ -929,6 +929,7 @@ rtc@fffffd20 {
 				reg = <0xfffffd20 0x10>;
 				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
 				clocks = <&clk32k>;
+				atmel,rtt-rtc-time-reg = <&gpbr 0x0>;
 				status = "disabled";
 			};
 
diff --git a/arch/arm/boot/dts/at91sam9m10g45ek.dts b/arch/arm/boot/dts/at91sam9m10g45ek.dts
index b6256a20fbc7..07bfa8ef715d 100644
--- a/arch/arm/boot/dts/at91sam9m10g45ek.dts
+++ b/arch/arm/boot/dts/at91sam9m10g45ek.dts
@@ -220,7 +220,6 @@ pwm0: pwm@fffb8000 {
 			};
 
 			rtc@fffffd20 {
-				atmel,rtt-rtc-time-reg = <&gpbr 0x0>;
 				status = "okay";
 			};
 
diff --git a/arch/arm/boot/dts/sam9x60.dtsi b/arch/arm/boot/dts/sam9x60.dtsi
index ec45ced3cde6..57ba47c54043 100644
--- a/arch/arm/boot/dts/sam9x60.dtsi
+++ b/arch/arm/boot/dts/sam9x60.dtsi
@@ -693,6 +693,7 @@ rtt: rtt@fffffe20 {
 				reg = <0xfffffe20 0x20>;
 				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
 				clocks = <&clk32k 0>;
+				atmel,rtt-rtc-time-reg = <&gpbr 0x0>;
 			};
 
 			pit: timer@fffffe40 {
diff --git a/arch/arm/boot/dts/sama7g5.dtsi b/arch/arm/boot/dts/sama7g5.dtsi
index eddcfbf4d223..1530d88ce80f 100644
--- a/arch/arm/boot/dts/sama7g5.dtsi
+++ b/arch/arm/boot/dts/sama7g5.dtsi
@@ -138,6 +138,7 @@ rtt: rtt@e001d020 {
 			reg = <0xe001d020 0x30>;
 			interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clk32k 0>;
+			atmel,rtt-rtc-time-reg = <&gpbr 0x0>;
 		};
 
 		clk32k: clock-controller@e001d050 {
-- 
2.25.1

