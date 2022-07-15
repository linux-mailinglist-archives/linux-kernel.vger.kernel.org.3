Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B41F57654A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 18:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233548AbiGOQ3c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 12:29:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233356AbiGOQ3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 12:29:21 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B284237D0;
        Fri, 15 Jul 2022 09:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1657902560; x=1689438560;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Yd5dATdWcgi5iFQh7VwJ69l17xqkQ/Eaq6hTAVdJgSI=;
  b=ORozKc/pOzwl06UXkLmCHAMG/iqaCjfiGiymsuGNhRbAf0mrC7y/Pe8+
   7NWS8M1f/eQeXA3L1Fd1MlFE/NfpRpOibMMYQGO/A2i0BC2GsaGziQQP/
   7PqrrDVyYRHbaIBiLs0Ap30iofkOKBH+KLpOXKQz1/G/GmtASK9Aj6JQ3
   5LZAE/dXitYhN7tH7kn57gam4Fg3zjJwK8a2fI0TUEH3viWOs5AmPn3G4
   N8u5eQ08BYLI0DXJ6gXF9xWrAdE09npx8sMZqAuvpqZd1ioxcgBzDZ6oX
   N/HzTqSYLOpJTqJi44DbwiuppI/dCORyQ9C6KMZpCYsEtoZDCM536EpR1
   w==;
X-IronPort-AV: E=Sophos;i="5.92,274,1650956400"; 
   d="scan'208";a="168040855"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Jul 2022 09:29:14 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 15 Jul 2022 09:29:14 -0700
Received: from ryan-Precision-5560.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Fri, 15 Jul 2022 09:29:14 -0700
From:   <Ryan.Wanner@microchip.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <claudiu.beznea@microchip.com>
CC:     <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        "Ryan Wanner" <Ryan.Wanner@microchip.com>
Subject: [PATCH v3 2/2] ASoC: dt-bindings: atmel-classd: PDMIC convert to json-schema
Date:   Fri, 15 Jul 2022 09:29:22 -0700
Message-ID: <20220715162922.660859-3-Ryan.Wanner@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220715162922.660859-1-Ryan.Wanner@microchip.com>
References: <20220715162922.660859-1-Ryan.Wanner@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ryan Wanner <Ryan.Wanner@microchip.com>

Convert Atmel PDMIC devicetree binding to json-schema.
Change file naming to match json-schema naming.

Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
---
v1 -> v2:
- Fix title.
- Removed trivial descriptions.
- Fix formatting.
v2 -> v3:
- Correct location for description.
- Correct dts example indentation.

 .../bindings/sound/atmel,sama5d2-pdmic.yaml   | 98 +++++++++++++++++++
 .../devicetree/bindings/sound/atmel-pdmic.txt | 55 -----------
 2 files changed, 98 insertions(+), 55 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/atmel,sama5d2-pdmic.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/atmel-pdmic.txt

diff --git a/Documentation/devicetree/bindings/sound/atmel,sama5d2-pdmic.yaml b/Documentation/devicetree/bindings/sound/atmel,sama5d2-pdmic.yaml
new file mode 100644
index 000000000000..f320b561f24c
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/atmel,sama5d2-pdmic.yaml
@@ -0,0 +1,98 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright (C) 2022 Microchip Technology, Inc. and its subsidiaries
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/atmel,sama5d2-pdmic.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Atmel PDMIC decoder
+
+maintainers:
+  - Claudiu Beznea <claudiu.beznea@microchip.com>
+
+description:
+  Atmel Pulse Density Modulation Interface Controller
+  (PDMIC) peripheral is a mono PDM decoder module
+  that decodes an incoming PDM sample stream.
+
+properties:
+  compatible:
+    const: atmel,sama5d2-pdmic
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: peripheral clock
+      - description: generated clock
+
+  clock-names:
+    items:
+      - const: pclk
+      - const: gclk
+
+  dmas:
+    maxItems: 1
+
+  dma-names:
+    const: rx
+
+  atmel,mic-min-freq:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      The minimal frequency that the microphone supports.
+
+  atmel,mic-max-freq:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      The maximal frequency that the microphone supports.
+
+  atmel,model:
+    $ref: /schemas/types.yaml#/definitions/string
+    default: PDMIC
+    description: The user-visible name of this sound card.
+
+  atmel,mic-offset:
+    $ref: /schemas/types.yaml#/definitions/int32
+    default: 0
+    description: The offset that should be added.
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - dmas
+  - dma-names
+  - clock-names
+  - clocks
+  - atmel,mic-min-freq
+  - atmel,mic-max-freq
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/dma/at91.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    pdmic: sound@f8018000 {
+        compatible = "atmel,sama5d2-pdmic";
+        reg = <0xf8018000 0x124>;
+        interrupts = <48 IRQ_TYPE_LEVEL_HIGH 7>;
+        dmas = <&dma0
+                (AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1)
+                | AT91_XDMAC_DT_PERID(50))>;
+        dma-names = "rx";
+        clocks = <&pdmic_clk>, <&pdmic_gclk>;
+        clock-names = "pclk", "gclk";
+        pinctrl-names = "default";
+        pinctrl-0 = <&pinctrl_pdmic_default>;
+        atmel,model = "PDMIC@sama5d2_xplained";
+        atmel,mic-min-freq = <1000000>;
+        atmel,mic-max-freq = <3246000>;
+        atmel,mic-offset = <0x0>;
+    };
diff --git a/Documentation/devicetree/bindings/sound/atmel-pdmic.txt b/Documentation/devicetree/bindings/sound/atmel-pdmic.txt
deleted file mode 100644
index e0875f17c229..000000000000
--- a/Documentation/devicetree/bindings/sound/atmel-pdmic.txt
+++ /dev/null
@@ -1,55 +0,0 @@
-* Atmel PDMIC driver under ALSA SoC architecture
-
-Required properties:
-- compatible
-	Should be "atmel,sama5d2-pdmic".
-- reg
-	Should contain PDMIC registers location and length.
-- interrupts
-	Should contain the IRQ line for the PDMIC.
-- dmas
-	One DMA specifiers as described in atmel-dma.txt and dma.txt files.
-- dma-names
-	Must be "rx".
-- clock-names
-	Required elements:
-	- "pclk"	peripheral clock
-	- "gclk"	generated clock
-- clocks
-	Must contain an entry for each required entry in clock-names.
-	Please refer to clock-bindings.txt.
-- atmel,mic-min-freq
-	The minimal frequency that the micphone supports.
-- atmel,mic-max-freq
-	The maximal frequency that the micphone supports.
-
-Optional properties:
-- pinctrl-names, pinctrl-0
-	Please refer to pinctrl-bindings.txt.
-- atmel,model
-	The user-visible name of this sound card.
-	The default value is "PDMIC".
-- atmel,mic-offset
-	The offset that should be added.
-	The range is from -32768 to 32767.
-	The default value is 0.
-
-Example:
-	pdmic@f8018000 {
-				compatible = "atmel,sama5d2-pdmic";
-				reg = <0xf8018000 0x124>;
-				interrupts = <48 IRQ_TYPE_LEVEL_HIGH 7>;
-				dmas = <&dma0
-					(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1)
-					| AT91_XDMAC_DT_PERID(50))>;
-				dma-names = "rx";
-				clocks = <&pdmic_clk>, <&pdmic_gclk>;
-				clock-names = "pclk", "gclk";
-
-				pinctrl-names = "default";
-				pinctrl-0 = <&pinctrl_pdmic_default>;
-				atmel,model = "PDMIC @ sama5d2_xplained";
-				atmel,mic-min-freq = <1000000>;
-				atmel,mic-max-freq = <3246000>;
-				atmel,mic-offset = <0x0>;
-	};
-- 
2.34.1

