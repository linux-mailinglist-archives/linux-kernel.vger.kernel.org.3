Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F1BE5A636B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 14:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbiH3MdP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 08:33:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiH3MdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 08:33:13 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FC11EF9C6;
        Tue, 30 Aug 2022 05:33:11 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 27UCWxHq127102;
        Tue, 30 Aug 2022 07:32:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1661862779;
        bh=d64uRuElyXn+nnuwkRe6NcehSJcas6x/0Wpuh/pQkRc=;
        h=From:To:CC:Subject:Date;
        b=PugNvUNEOS2IWg18pBUSRIiwfxhqlql4QuVJxqHoCI+qPBmuUnoPCvjcaSI+x9X9i
         HlkSwDy5+6iN8mXipb2sE2b3yea6f2yFRhTNcq+QcFQHLZkl19q4f5th1oZr3MDODH
         KTPRFxb5eJNV5i5WJeYXS6rQEDfbe1q9WhtS6yk0=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 27UCWxso058939
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 30 Aug 2022 07:32:59 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Tue, 30
 Aug 2022 07:32:58 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Tue, 30 Aug 2022 07:32:58 -0500
Received: from uda0132425.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 27UCWua8067799;
        Tue, 30 Aug 2022 07:32:56 -0500
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3] arm64: dts: ti: k3-am642-sk: Add DT entry for onboard LEDs
Date:   Tue, 30 Aug 2022 18:02:54 +0530
Message-ID: <20220830123254.522222-1-vigneshr@ti.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aparna M <a-m1@ti.com>

AM642 SK has 8 leds connected to tpic2810 onboard. Add support for these
gpio leds.

Signed-off-by: Aparna M <a-m1@ti.com>
Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
---
v3:
Fix compile error due to missing header
Fix whitespace issues

v2: https://lore.kernel.org/all/20220629075859.6939-1-a-m1@ti.com/

 arch/arm64/boot/dts/ti/k3-am642-sk.dts | 70 ++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am642-sk.dts b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
index 2620469a7517..cc36b9368356 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
@@ -9,6 +9,7 @@
 #include <dt-bindings/phy/phy.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/net/ti-dp83867.h>
+#include <dt-bindings/leds/common.h>
 #include "k3-am642.dtsi"
 
 / {
@@ -150,6 +151,67 @@ wlan_en: regulator-2 {
 		vin-supply = <&com8_ls_en>;
 		gpio = <&main_gpio0 48 GPIO_ACTIVE_HIGH>;
 	};
+
+	led-controller {
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
+			function = LED_FUNCTION_HEARTBEAT;
+			function-enumerator = <8>;
+			linux,default-trigger = "heartbeat";
+			gpios = <&exp2 7 GPIO_ACTIVE_HIGH>;
+		};
+	};
 };
 
 &main_pmx0 {
@@ -330,6 +392,14 @@ exp1: gpio@70 {
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
2.37.2

