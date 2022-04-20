Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58BE550822F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 09:31:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359808AbiDTHdm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 03:33:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359798AbiDTHdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 03:33:39 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E8FD2DD74;
        Wed, 20 Apr 2022 00:30:52 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 23K7Uhev080633;
        Wed, 20 Apr 2022 02:30:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1650439843;
        bh=7jce7pVMCQfztGGAX7hetps3rpfzHuAPIlJY/Ijzf9M=;
        h=From:To:CC:Subject:Date;
        b=wgYzL4sjJWr9KZXDCymWseVzLdxkRzHJVIK2rgEbZ28k7HshyYZf/Q5k86Zebfvh6
         Bc4SqldszaSvuXGH/gsLHTlbCflGigg2Wo4eO0EjGQiROLqk9TlEHdbBPpnXiyDZs9
         FCroJhvO4IfRKV5aCRpWm07OW+ePqBf3oF+6vj0I=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 23K7Uhsb106934
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 20 Apr 2022 02:30:43 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 20
 Apr 2022 02:30:43 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 20 Apr 2022 02:30:43 -0500
Received: from swubn03.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 23K7UdYK002316;
        Wed, 20 Apr 2022 02:30:40 -0500
From:   Aparna M <a-m1@ti.com>
To:     <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <praneeth@ti.com>, <grygorii.strashko@ti.com>, <nikhil.nd@ti.com>
Subject: [PATCH RESEND] arm64: dts: ti: k3-am642-sk: Add DT entry for onboard LEDs
Date:   Wed, 20 Apr 2022 12:59:52 +0530
Message-ID: <20220420072952.3509-1-a-m1@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AM642 SK has 8 leds connected to tpic2810 onboard. Add support for these
gpio leds.

Signed-off-by: Aparna M <a-m1@ti.com>
---

This patch is dependent on:
https://lore.kernel.org/all/20220223174215.17838-1-a-m1@ti.com/ 

RESEND patch has been rebased on top of v5.18-rc2.

 arch/arm64/boot/dts/ti/k3-am642-sk.dts | 70 ++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am642-sk.dts b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
index 1d7db8bf3a5c..c5979d03c287 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
@@ -8,6 +8,7 @@
 #include <dt-bindings/mux/ti-serdes.h>
 #include <dt-bindings/phy/phy.h>
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/leds/common.h>
 #include <dt-bindings/net/ti-dp83867.h>
 #include "k3-am642.dtsi"
 
@@ -125,6 +126,67 @@
 		vin-supply = <&vcc_3v3_sys>;
 		gpio = <&exp1 3 GPIO_ACTIVE_HIGH>;
 	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		led-0 {
+			color = <LED_COLOR_ID_GREEN>;
+			function = LED_FUNCTION_INDICATOR;
+			function-enumerator = <1>;
+			gpios = <&exp2 0 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+		};
+		led-1 {
+			color = <LED_COLOR_ID_RED>;
+			function = LED_FUNCTION_INDICATOR;
+			function-enumerator = <2>;
+			gpios = <&exp2 1 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+		};
+		led-2 {
+			color = <LED_COLOR_ID_GREEN>;
+			function = LED_FUNCTION_INDICATOR;
+			function-enumerator = <3>;
+			gpios = <&exp2 2 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+		};
+		led-3 {
+			color = <LED_COLOR_ID_AMBER>;
+			function = LED_FUNCTION_INDICATOR;
+			function-enumerator = <4>;
+			gpios = <&exp2 3 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+		};
+		led-4 {
+			color = <LED_COLOR_ID_GREEN>;
+			function = LED_FUNCTION_INDICATOR;
+			function-enumerator = <5>;
+			gpios = <&exp2 4 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+		};
+		led-5 {
+			color = <LED_COLOR_ID_RED>;
+			function = LED_FUNCTION_INDICATOR;
+			function-enumerator = <6>;
+			gpios = <&exp2 5 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+		};
+		led-6 {
+			color = <LED_COLOR_ID_GREEN>;
+			function = LED_FUNCTION_INDICATOR;
+			function-enumerator = <7>;
+			gpios = <&exp2 6 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+		};
+		led-7 {
+			color = <LED_COLOR_ID_AMBER>;
+			function = LED_FUNCTION_INDICATOR;
+			function-enumerator = <8>;
+			linux,default-trigger = "heartbeat";
+			gpios = <&exp2 7 GPIO_ACTIVE_HIGH>;
+		};
+	};
 };
 
 &main_pmx0 {
@@ -274,6 +336,14 @@
 				  "VPP_LDO_EN", "RPI_PS_3V3_En",
 				  "RPI_PS_5V0_En", "RPI_HAT_DETECT";
 	};
+
+	exp2: gpio@60 {
+		compatible = "ti,tpic2810";
+		reg = <0x60>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		gpio-line-names = "LED1","LED2","LED3","LED4","LED5","LED6","LED7","LED8";
+	};
 };
 
 &main_i2c3 {
-- 
2.17.1

