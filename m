Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A82356745A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 18:31:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbiGEQbA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 12:31:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbiGEQaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 12:30:55 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B16518395;
        Tue,  5 Jul 2022 09:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1657038654; x=1688574654;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=oWR1kcX+pfNDwzKsva055KxmWA5wzkEFB86zso2e49Y=;
  b=p1SESKr44RNnPlE4docEvxI8hZq37mEqVBOAqSDYJvKSrjxK87hL/8aj
   dv5Ip8zl6LI5vPNTTQf4zkskWUZf1Sy7OxfwYS48P6mh9+bTT8ZC1wGH7
   S1BwGi8Qlbv7qmEkC02QPvAEHomSP5+uwXuzAAw/a+48NEoOa8/mo613z
   IG7aQ3Hvfg/RWwyGVBCNt/JaWDvYk76T3weWSgmGCya1kX0pMiHFtu2Du
   +Y+oZRH0yfqwfGDyiGXTaNBunfO7DjxoKYFp16futt1fJUjWKBXd44Tor
   0EEKbivT05BG0zK7rs8j+WdCpA6RXZb2hf9T+OaWLpyNMrSvNkSds2VCa
   g==;
X-IronPort-AV: E=Sophos;i="5.92,247,1650956400"; 
   d="scan'208";a="103111233"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 05 Jul 2022 09:30:53 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 5 Jul 2022 09:30:52 -0700
Received: from ryan-Precision-5560.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Tue, 5 Jul 2022 09:30:52 -0700
From:   <Ryan.Wanner@microchip.com>
To:     <Claudiu.Beznea@microchip.com>, <nicolas.ferre@microchip.com>,
        <alexandre.berna@microchip.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Ryan Wanner <Ryan.Wanner@microchip.com>
Subject: [PATCH] dt-bindings: sound: Convert atmel CLASSD to json-schema
Date:   Tue, 5 Jul 2022 09:30:46 -0700
Message-ID: <20220705163046.18409-1-Ryan.Wanner@microchip.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ryan Wanner <Ryan.Wanner@microchip.com>

Convert atmel CLASSD devicetree binding to json-schema.
Change file name to match json-scheme naming.

Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
---
 .../bindings/sound/atmel,sama5d2-classd.yaml  | 111 ++++++++++++++++++
 .../bindings/sound/atmel-classd.txt           |  55 ---------
 2 files changed, 111 insertions(+), 55 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/atmel,sama5d2-classd.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/atmel-classd.txt

diff --git a/Documentation/devicetree/bindings/sound/atmel,sama5d2-classd.yaml b/Documentation/devicetree/bindings/sound/atmel,sama5d2-classd.yaml
new file mode 100644
index 000000000000..6daf120686a7
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/atmel,sama5d2-classd.yaml
@@ -0,0 +1,111 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright (C) 2022 Microchip Technology, Inc. and its subsidiaries
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/atmel,classd.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Atmel ClassD driver under ALSA SoC architecture
+
+maintainers:
+  - Nicolas Ferre <nicolas.ferre@microchip.com>
+  - Alexandre Belloni <alexandre.belloni@bootlin.com>
+  - Claudiu Beznea <claudiu.beznea@microchip.com>
+
+description:
+  The Audio Class D Amplifier (CLASSD) is a digital input, Pulse Width Modulated (PWM)
+  output stereo Class D amplifier.
+
+properties:
+  compatible:
+    const: atmel,sama5d2-classd
+
+  reg:
+    maxItems: 1
+    description:
+      Should contain ClassD registers location and length.
+
+  interrupts:
+    maxItems: 1
+    description:
+      Should contain the IRQ line for the ClassD.
+
+  dmas:
+    description:
+      One DMA specifiers as described in atmel-dma.txt and dma.txt files.
+    maxItems: 1
+
+  dma-names:
+    const: tx
+
+  clocks:
+    maxItems: 2
+    description: Please refer to clock-bindings.txt.
+
+  clock-names:
+    items:
+      - const: pclk
+      - const: gclk
+
+  assigned-clocks:
+    maxItems: 1
+    description: classd_gclk
+
+  atmel,model:
+    $ref: /schemas/types.yaml#/definitions/string
+    description: The user-visible name of this sound complex.
+    default: CLASSD
+
+  atmel,pwm-type:
+    $ref: /schemas/types.yaml#/definitions/string
+    enum:
+      - single
+      - diff
+    default: single
+    description: PWM modulation type, "single" or "diff".
+
+  atmel,non-overlap-time:
+    description:
+      Set non-overlapping time, the unit is nanosecond(ns).
+      Non-overlapping will be disabled if not specified.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum:
+      - 5
+      - 10
+      - 15
+      - 20
+    default: 10
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - dmas
+  - dma-names
+  - clock-names
+  - clocks
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/dma/at91.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    classd: sound@fc048000 {
+              compatible = "atmel,sama5d2-classd";
+              reg = <0xfc048000 0x100>;
+              interrupts = <59 IRQ_TYPE_LEVEL_HIGH 7>;
+              dmas = <&dma0
+                      (AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1)
+                      | AT91_XDMAC_DT_PERID(47))>;
+              dma-names = "tx";
+              clocks = <&classd_clk>, <&classd_gclk>;
+              clock-names = "pclk", "gclk";
+              assigned-clocks = <&classd_gclk>;
+              pinctrl-names = "default";
+              pinctrl-0 = <&pinctrl_classd_default>;
+              atmel,model = "classd @ SAMA5D2-Xplained";
+              atmel,pwm-type = "diff";
+              atmel,non-overlap-time = <10>;
+    };
diff --git a/Documentation/devicetree/bindings/sound/atmel-classd.txt b/Documentation/devicetree/bindings/sound/atmel-classd.txt
deleted file mode 100644
index 898551076382..000000000000
--- a/Documentation/devicetree/bindings/sound/atmel-classd.txt
+++ /dev/null
@@ -1,55 +0,0 @@
-* Atmel ClassD driver under ALSA SoC architecture
-
-Required properties:
-- compatible
-	Should be "atmel,sama5d2-classd".
-- reg
-	Should contain ClassD registers location and length.
-- interrupts
-	Should contain the IRQ line for the ClassD.
-- dmas
-	One DMA specifiers as described in atmel-dma.txt and dma.txt files.
-- dma-names
-	Must be "tx".
-- clock-names
-	Tuple listing input clock names.
-	Required elements: "pclk" and "gclk".
-- clocks
-	Please refer to clock-bindings.txt.
-- assigned-clocks
-	Should be <&classd_gclk>.
-
-Optional properties:
-- pinctrl-names, pinctrl-0
-	Please refer to pinctrl-bindings.txt.
-- atmel,model
-	The user-visible name of this sound complex.
-	The default value is "CLASSD".
-- atmel,pwm-type
-	PWM modulation type, "single" or "diff".
-	The default value is "single".
-- atmel,non-overlap-time
-	Set non-overlapping time, the unit is nanosecond(ns).
-	There are four values,
-	<5>, <10>, <15>, <20>, the default value is <10>.
-	Non-overlapping will be disabled if not specified.
-
-Example:
-classd: classd@fc048000 {
-		compatible = "atmel,sama5d2-classd";
-		reg = <0xfc048000 0x100>;
-		interrupts = <59 IRQ_TYPE_LEVEL_HIGH 7>;
-		dmas = <&dma0
-			(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1)
-			| AT91_XDMAC_DT_PERID(47))>;
-		dma-names = "tx";
-		clocks = <&classd_clk>, <&classd_gclk>;
-		clock-names = "pclk", "gclk";
-		assigned-clocks = <&classd_gclk>;
-
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_classd_default>;
-		atmel,model = "classd @ SAMA5D2-Xplained";
-		atmel,pwm-type = "diff";
-		atmel,non-overlap-time = <10>;
-};
-- 
2.34.1

