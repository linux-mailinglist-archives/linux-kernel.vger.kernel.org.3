Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BB65573B26
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 18:25:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237164AbiGMQZs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 12:25:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237167AbiGMQZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 12:25:45 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CEFC308;
        Wed, 13 Jul 2022 09:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1657729544; x=1689265544;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=RktsUe463dGeJ6JVuFeGZ56J3iA/MJCDqhL6VP3o8oc=;
  b=UTHQhH0McW/S9p1VrDqBUOH94eHB7gnrk62EryS/npHsQrSm5nHsAlmd
   qcwzE5unVZ4Ml3ehxExBYAIhAhFAamMIq0VwOUfB/9X0zMvOmgxBqp92P
   xOw3cuvhFv98BWeHVzMQQlb6dO6KA+zdUzD1+wEJ3SMkm3UwWcFvY0FoU
   QHNqqoMuiX5fr2MFhj/9WxZiy8r6VflLdi9At2OZbGmWlDLLpMx0gtwZb
   Vl377Ha+RII1CviX2o2/na4gPQldilnz5PV/7QlDtpiHYNBhalKesivKD
   kdT3yeQ1tE8U6ReomjNVlFW+xiqfmDLCs52VkwIlc7jANa7cAG7FqPl1i
   A==;
X-IronPort-AV: E=Sophos;i="5.92,267,1650956400"; 
   d="scan'208";a="171953385"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Jul 2022 09:25:29 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 13 Jul 2022 09:25:27 -0700
Received: from ryan-Precision-5560.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Wed, 13 Jul 2022 09:25:27 -0700
From:   <Ryan.Wanner@microchip.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <claudiu.beznea@microchip.com>
CC:     <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        "Ryan Wanner" <Ryan.Wanner@microchip.com>
Subject: [PATCH] ASoC: dt-bindings: atmel-i2s: Convert to json-schema
Date:   Wed, 13 Jul 2022 09:25:38 -0700
Message-ID: <20220713162538.139115-1-Ryan.Wanner@microchip.com>
X-Mailer: git-send-email 2.34.1
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

Convert atmel i2s devicetree binding to json-schema.
Change file name to match json-schema naming.

Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
---
 .../bindings/sound/atmel,sama5d2-i2s.yaml     | 83 +++++++++++++++++++
 .../devicetree/bindings/sound/atmel-i2s.txt   | 46 ----------
 2 files changed, 83 insertions(+), 46 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/atmel,sama5d2-i2s.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/atmel-i2s.txt

diff --git a/Documentation/devicetree/bindings/sound/atmel,sama5d2-i2s.yaml b/Documentation/devicetree/bindings/sound/atmel,sama5d2-i2s.yaml
new file mode 100644
index 000000000000..1cadc476565c
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/atmel,sama5d2-i2s.yaml
@@ -0,0 +1,83 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright (C) 2022 Microchip Technology, Inc. and its subsidiaries
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/atmel,sama5d2-i2s.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Atmel I2S controller
+
+maintainers:
+  - Nicolas Ferre <nicolas.ferre@microchip.com>
+  - Alexandre Belloni <alexandre.belloni@bootlin.com>
+  - Claudiu Beznea <claudiu.beznea@microchip.com>
+
+description:
+  Atmel I2S (Inter-IC Sound Controller) bus is the standard
+  interface for connecting audio devices, such as audio codecs.
+
+properties:
+  compatible:
+    const: atmel,sama5d2-i2s
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    description:
+      Only the peripheral clock (pclk) is required. The generated clock (gclk)
+      and the I2S mux clock (muxclk) are optional and should only be set together,
+      when Master Mode is required.
+
+  clock-names:
+    items:
+      - const: pclk
+      - const: gclk
+      - const: muxclk
+    minItems: 1
+
+  dmas:
+    description:
+      Should be one per channel name listed in the dma-names property.
+    maxItems: 2
+
+  dma-names:
+    items:
+      - const: tx
+      - const: rx
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - dmas
+  - dma-names
+  - clocks
+  - clock-names
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/dma/at91.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    i2s@f8050000 {
+        compatible = "atmel,sama5d2-i2s";
+        reg = <0xf8050000 0x300>;
+        interrupts = <54 IRQ_TYPE_LEVEL_HIGH 7>;
+        dmas = <&dma0
+                (AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1) |
+                AT91_XDMAC_DT_PERID(31))>,
+               <&dma0
+                (AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1) |
+                AT91_XDMAC_DT_PERID(32))>;
+        dma-names = "tx", "rx";
+        clocks = <&i2s0_clk>, <&i2s0_gclk>, <&i2s0muxck>;
+        clock-names = "pclk", "gclk", "muxclk";
+        pinctrl-names = "default";
+        pinctrl-0 = <&pinctrl_i2s0_default>;
+    };
diff --git a/Documentation/devicetree/bindings/sound/atmel-i2s.txt b/Documentation/devicetree/bindings/sound/atmel-i2s.txt
deleted file mode 100644
index 40549f496a81..000000000000
--- a/Documentation/devicetree/bindings/sound/atmel-i2s.txt
+++ /dev/null
@@ -1,46 +0,0 @@
-* Atmel I2S controller
-
-Required properties:
-- compatible:     Should be "atmel,sama5d2-i2s".
-- reg:            Should be the physical base address of the controller and the
-                  length of memory mapped region.
-- interrupts:     Should contain the interrupt for the controller.
-- dmas:           Should be one per channel name listed in the dma-names property,
-                  as described in atmel-dma.txt and dma.txt files.
-- dma-names:      Two dmas have to be defined, "tx" and "rx".
-                  This IP also supports one shared channel for both rx and tx;
-                  if this mode is used, one "rx-tx" name must be used.
-- clocks:         Must contain an entry for each entry in clock-names.
-                  Please refer to clock-bindings.txt.
-- clock-names:    Should be one of each entry matching the clocks phandles list:
-                  - "pclk" (peripheral clock) Required.
-                  - "gclk" (generated clock) Optional (1).
-                  - "muxclk" (I2S mux clock) Optional (1).
-
-Optional properties:
-- pinctrl-0:      Should specify pin control groups used for this controller.
-- princtrl-names: Should contain only one value - "default".
-
-
-(1) : Only the peripheral clock is required. The generated clock and the I2S
-      mux clock are optional and should only be set together, when Master Mode
-      is required.
-
-Example:
-
-	i2s@f8050000 {
-		compatible = "atmel,sama5d2-i2s";
-		reg = <0xf8050000 0x300>;
-		interrupts = <54 IRQ_TYPE_LEVEL_HIGH 7>;
-		dmas = <&dma0
-			(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1) |
-			 AT91_XDMAC_DT_PERID(31))>,
-		       <&dma0
-			(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1) |
-			 AT91_XDMAC_DT_PERID(32))>;
-		dma-names = "tx", "rx";
-		clocks = <&i2s0_clk>, <&i2s0_gclk>, <&i2s0muxck>;
-		clock-names = "pclk", "gclk", "muxclk";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_i2s0_default>;
-	};
-- 
2.34.1

