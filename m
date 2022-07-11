Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 638725709F0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 20:30:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbiGKSaL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 14:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbiGKSaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 14:30:07 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FA224D830;
        Mon, 11 Jul 2022 11:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1657564202; x=1689100202;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8tAwHskEXN5iMTgIIlVW8hEMkkC75EH1yxYnzi6q0HU=;
  b=ZMNTzznXRpewcRVsgPmT9wqegQqxMHgrWvwFJxJpjIqyxbaVEufCdCYo
   yDCFoIqjAiF3MsSXs3osgWAHXw+x0/9/F5KqaAcYi8ttVIAd1E7CDhlIR
   LMjbxkmX93zJyhJLZjW1shpSIS0JqB7NwGOh/+MGe++QluBifksi/7eht
   1ZlUyxZe5eg+XRHShebg6xb+IgKeQNEqqT9bUUshCEwmcGGsQFER3+rxL
   aHOFZ3kBF5Fc/VeaOhdkFmLzx59MoW3+zQ1FOdIf2cnBA6QUz0nGd0Jfa
   UMsDfPLePn8UzvXCjrqR0oYrQ7tJH+nm0PDZZ5gkeLdqrX+3BTh2bMDtI
   Q==;
X-IronPort-AV: E=Sophos;i="5.92,263,1650956400"; 
   d="scan'208";a="103970028"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 11 Jul 2022 11:30:01 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 11 Jul 2022 11:30:01 -0700
Received: from ryan-Precision-5560.microchip.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Mon, 11 Jul 2022 11:30:01 -0700
From:   <Ryan.Wanner@microchip.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <claudiu.beznea@microchip.com>
CC:     <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        "Ryan Wanner" <Ryan.Wanner@microchip.com>
Subject: [PATCH v2 1/2] dt-bindings: sound: atmel,classd: Convert to json-schema
Date:   Mon, 11 Jul 2022 11:30:09 -0700
Message-ID: <20220711183010.39123-2-Ryan.Wanner@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220711183010.39123-1-Ryan.Wanner@microchip.com>
References: <20220711183010.39123-1-Ryan.Wanner@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
Change file name to match json-schema naming.

Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
---
v1 -> v2:
- Fix title.
- Fix formatting.
- Removed trivial descriptions.
- Fix filename.

 .../bindings/sound/atmel,sama5d2-classd.yaml  | 104 ++++++++++++++++++
 .../bindings/sound/atmel-classd.txt           |  55 ---------
 2 files changed, 104 insertions(+), 55 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/atmel,sama5d2-classd.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/atmel-classd.txt

diff --git a/Documentation/devicetree/bindings/sound/atmel,sama5d2-classd.yaml b/Documentation/devicetree/bindings/sound/atmel,sama5d2-classd.yaml
new file mode 100644
index 000000000000..9ef8c6dde8a8
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/atmel,sama5d2-classd.yaml
@@ -0,0 +1,104 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright (C) 2022 Microchip Technology, Inc. and its subsidiaries
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/atmel,sama5d2-classd.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Atmel ClassD Amplifier
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
+
+  interrupts:
+    maxItems: 1
+
+  dmas:
+    maxItems: 1
+
+  dma-names:
+    const: tx
+
+  clocks:
+    maxItems: 2
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
+    	compatible = "atmel,sama5d2-classd";
+    	reg = <0xfc048000 0x100>;
+        interrupts = <59 IRQ_TYPE_LEVEL_HIGH 7>;
+        dmas = <&dma0
+            (AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1)
+            | AT91_XDMAC_DT_PERID(47))>;
+        dma-names = "tx";
+        clocks = <&classd_clk>, <&classd_gclk>;
+        clock-names = "pclk", "gclk";
+        assigned-clocks = <&classd_gclk>;
+        pinctrl-names = "default";
+        pinctrl-0 = <&pinctrl_classd_default>;
+        atmel,model = "classd @ SAMA5D2-Xplained";
+        atmel,pwm-type = "diff";
+        atmel,non-overlap-time = <10>;
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

