Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8452855F9F3
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 10:03:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232643AbiF2H7y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 03:59:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbiF2H7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 03:59:51 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9095C39810;
        Wed, 29 Jun 2022 00:59:49 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 25T7xDbN048237;
        Wed, 29 Jun 2022 02:59:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1656489553;
        bh=UFFq1KovGjvjekKq08QHl5e958WTDQd6GMWm+70TOOA=;
        h=From:To:CC:Subject:Date;
        b=O6CEs/pDejdirwLHA8lc1p5M8bpdKcg8Y+f41j7A1wJPdlCnrWHZMiID+zn9suujg
         Jdb+o7YTpDwAZXVjcdqHSxHVp/3FHVapntFRPIDSNMmSoIv0gdWF7SsfJ70o7FyAPh
         GV/Up5FD44kHH5JQu0kcjg8p65tgNbl50tQcoNgA=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 25T7xDH6040483
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 29 Jun 2022 02:59:13 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 29
 Jun 2022 02:59:12 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 29 Jun 2022 02:59:12 -0500
Received: from swubn03.india.englab.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 25T7x8Ip129499;
        Wed, 29 Jun 2022 02:59:09 -0500
From:   Aparna M <a-m1@ti.com>
To:     <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>,
        <ada@thorsis.com>, <pavel@ucw.cz>
CC:     <praneeth@ti.com>, <robh+dt@kernel.org>, <devarsht@ti.com>,
        <s-adivi@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-leds@vger.kernel.org>
Subject: [PATCH v2] arm64: dts: ti: k3-am642-sk: Add DT entry for onboard LEDs
Date:   Wed, 29 Jun 2022 13:28:59 +0530
Message-ID: <20220629075859.6939-1-a-m1@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

v1 -> v2: Fixed led-controller name and changed led-7 funtion to show
heartbeat functionality. Rebased on top for 5.19-rc4.

 arch/arm64/boot/dts/ti/k3-am642-sk.dts | 69 ++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am642-sk.dts b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
index 59f506cbd275..47476fd068a8 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
@@ -150,6 +150,67 @@
 		vin-supply = <&com8_ls_en>;
 		gpio = <&main_gpio0 48 GPIO_ACTIVE_HIGH>;
 	};
+
+        led-controller {
+	        compatible = "gpio-leds";
+
+                led-0 {
+                        color = <LED_COLOR_ID_GREEN>;
+                        function = LED_FUNCTION_INDICATOR;
+                        function-enumerator = <1>;
+                        gpios = <&exp2 0 GPIO_ACTIVE_HIGH>;
+                        default-state = "off";
+                };
+                led-1 {
+                        color = <LED_COLOR_ID_RED>;
+                        function = LED_FUNCTION_INDICATOR;
+                        function-enumerator = <2>;
+                        gpios = <&exp2 1 GPIO_ACTIVE_HIGH>;
+                        default-state = "off";
+                };
+                led-2 {
+                        color = <LED_COLOR_ID_GREEN>;
+                        function = LED_FUNCTION_INDICATOR;
+                        function-enumerator = <3>;
+                        gpios = <&exp2 2 GPIO_ACTIVE_HIGH>;
+                        default-state = "off";
+                };
+                led-3 {
+                        color = <LED_COLOR_ID_AMBER>;
+                        function = LED_FUNCTION_INDICATOR;
+                        function-enumerator = <4>;
+                        gpios = <&exp2 3 GPIO_ACTIVE_HIGH>;
+                        default-state = "off";
+                };
+                led-4 {
+                        color = <LED_COLOR_ID_GREEN>;
+                        function = LED_FUNCTION_INDICATOR;
+                        function-enumerator = <5>;
+                        gpios = <&exp2 4 GPIO_ACTIVE_HIGH>;
+                        default-state = "off";
+                };
+                led-5 {
+                        color = <LED_COLOR_ID_RED>;
+                        function = LED_FUNCTION_INDICATOR;
+                        function-enumerator = <6>;
+                        gpios = <&exp2 5 GPIO_ACTIVE_HIGH>;
+                        default-state = "off";
+                };
+                led-6 {
+                        color = <LED_COLOR_ID_GREEN>;
+                        function = LED_FUNCTION_INDICATOR;
+                        function-enumerator = <7>;
+                        gpios = <&exp2 6 GPIO_ACTIVE_HIGH>;
+                        default-state = "off";
+                };
+                led-7 {
+                        color = <LED_COLOR_ID_AMBER>;
+                        function = LED_FUNCTION_HEARTBEAT;
+                        function-enumerator = <8>;
+                        linux,default-trigger = "heartbeat";
+                        gpios = <&exp2 7 GPIO_ACTIVE_HIGH>;
+                };
+        };
 };
 
 &main_pmx0 {
@@ -316,6 +377,14 @@
 				  "VPP_LDO_EN", "RPI_PS_3V3_En",
 				  "RPI_PS_5V0_En", "RPI_HAT_DETECT";
 	};
+
+        exp2: gpio@60 {
+                compatible = "ti,tpic2810";
+                reg = <0x60>;
+                gpio-controller;
+                #gpio-cells = <2>;
+                gpio-line-names = "LED1","LED2","LED3","LED4","LED5","LED6","LED7","LED8";
+        };
 };
 
 &main_i2c3 {
-- 
2.17.1

