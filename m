Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84783573770
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 15:32:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231759AbiGMNbv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 09:31:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231352AbiGMNbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 09:31:47 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5941A1BF;
        Wed, 13 Jul 2022 06:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1657719103; x=1689255103;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=7RAwLlkavri+ef+7yhzzyVKIadFCcedXqPX61KMv+Gc=;
  b=p6yGxL8zaFAFoRQG5MOfDu3on7R+0BLevhQD9r4rkdUvS+JAI3TerhMi
   5vy4aCpcXtHFvTxozNzRx/l7qobe9YLnMLVsiS/nG+xLDvSqTqCduQ/Nd
   sIybsV7Hm/ujt6iOQZprGFoY1PT+qRO5DGmWcUJlZ6x8SrKW+hz4y8bPq
   yx/s5BzSTfD1IFpV+t/0ej5I6017mj5c+odvVp2EosYtoPzh0W9dSBhgX
   NlZ1nOC1QoxqxSenZePcjfwfTPqz86sti/QL4ROQ5XbsI9PvABLb9raI6
   Z3lUY8wK7pzepxlPskK2KrIA4C1BfrEO0jNwCA6Voc2mwEkosG/+7vvOH
   Q==;
X-IronPort-AV: E=Sophos;i="5.92,267,1650956400"; 
   d="scan'208";a="171925387"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Jul 2022 06:31:42 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 13 Jul 2022 06:31:39 -0700
Received: from ROB-ULT-M68701.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Wed, 13 Jul 2022 06:31:31 -0700
From:   Sergiu Moga <sergiu.moga@microchip.com>
To:     <broonie@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <claudiu.beznea@microchip.com>
CC:     <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Kavyasree.Kotagiri@microchip.com>,
        <UNGLinuxDriver@microchip.com>, <tudor.ambarus@microchip.com>,
        Sergiu Moga <sergiu.moga@microchip.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4] spi: dt-bindings: atmel,at91rm9200-spi: convert to json-schema
Date:   Wed, 13 Jul 2022 16:29:10 +0300
Message-ID: <20220713132908.175026-1-sergiu.moga@microchip.com>
X-Mailer: git-send-email 2.25.1
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

Convert SPI DT binding for Atmel/Microchip SoCs to json-schema.

Signed-off-by: Sergiu Moga <sergiu.moga@microchip.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---

v1 -> v2:
- change subject headline prefix from "dt-bindings: spi" to "spi: atmel"
- change maintainer
- kept the compatbile as items (instead of switching to enums) and at91rm9200
as fallback for sam9x60, since the evolution of IP's is incremental.
- removed unnecessay "cs-gpios" property and descriptions
- added min/max for fifo-size property.


v2 -> v3:
- change subject headline prefix from "spi: atmel" to
"spi: dt-bindings: atmel,at91rm9200-spi: convert to json-schema"
- use enum instead of a range for "atmel,fifo-size"
- change file name from "atmel,spi" to "atmel,at91rm9200-spi"


v3 -> v4:
- use "atmel,at91rm9200-spi.yaml" (the new file name) in $id
- use "const" instead of "items" for single compatible


 .../bindings/spi/atmel,at91rm9200-spi.yaml    | 75 +++++++++++++++++++
 .../devicetree/bindings/spi/spi_atmel.txt     | 36 ---------
 2 files changed, 75 insertions(+), 36 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/atmel,at91rm9200-spi.yaml
 delete mode 100644 Documentation/devicetree/bindings/spi/spi_atmel.txt

diff --git a/Documentation/devicetree/bindings/spi/atmel,at91rm9200-spi.yaml b/Documentation/devicetree/bindings/spi/atmel,at91rm9200-spi.yaml
new file mode 100644
index 000000000000..d85d54024b2e
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/atmel,at91rm9200-spi.yaml
@@ -0,0 +1,75 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (C) 2022 Microchip Technology, Inc. and its subsidiaries
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/atmel,at91rm9200-spi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Atmel SPI device
+
+maintainers:
+  - Tudor Ambarus <tudor.ambarus@microchip.com>
+
+allOf:
+  - $ref: spi-controller.yaml#
+
+properties:
+  compatible:
+    oneOf:
+      - const: atmel,at91rm9200-spi
+      - items:
+          - const: microchip,sam9x60-spi
+          - const: atmel,at91rm9200-spi
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clock-names:
+    contains:
+      const: spi_clk
+
+  clocks:
+    maxItems: 1
+
+  atmel,fifo-size:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Maximum number of data the RX and TX FIFOs can store for FIFO
+      capable SPI controllers.
+    enum: [ 16, 32 ]
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clock-names
+  - clocks
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    spi1: spi@fffcc000 {
+        compatible = "atmel,at91rm9200-spi";
+        reg = <0xfffcc000 0x4000>;
+        interrupts = <13 IRQ_TYPE_LEVEL_HIGH 5>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+        clocks = <&spi1_clk>;
+        clock-names = "spi_clk";
+        cs-gpios = <&pioB 3 GPIO_ACTIVE_HIGH>;
+        atmel,fifo-size = <32>;
+
+        mmc@0 {
+            compatible = "mmc-spi-slot";
+            reg = <0>;
+            gpios = <&pioC 4 GPIO_ACTIVE_HIGH>;    /* CD */
+            spi-max-frequency = <25000000>;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/spi/spi_atmel.txt b/Documentation/devicetree/bindings/spi/spi_atmel.txt
deleted file mode 100644
index 5bb4a8f1df7a..000000000000
--- a/Documentation/devicetree/bindings/spi/spi_atmel.txt
+++ /dev/null
@@ -1,36 +0,0 @@
-Atmel SPI device
-
-Required properties:
-- compatible : should be "atmel,at91rm9200-spi" or "microchip,sam9x60-spi".
-- reg: Address and length of the register set for the device
-- interrupts: Should contain spi interrupt
-- cs-gpios: chipselects (optional for SPI controller version >= 2 with the
-  Chip Select Active After Transfer feature).
-- clock-names: tuple listing input clock names.
-	Required elements: "spi_clk"
-- clocks: phandles to input clocks.
-
-Optional properties:
-- atmel,fifo-size: maximum number of data the RX and TX FIFOs can store for FIFO
-  capable SPI controllers.
-
-Example:
-
-spi1: spi@fffcc000 {
-	compatible = "atmel,at91rm9200-spi";
-	reg = <0xfffcc000 0x4000>;
-	interrupts = <13 4 5>;
-	#address-cells = <1>;
-	#size-cells = <0>;
-	clocks = <&spi1_clk>;
-	clock-names = "spi_clk";
-	cs-gpios = <&pioB 3 0>;
-	atmel,fifo-size = <32>;
-
-	mmc-slot@0 {
-		compatible = "mmc-spi-slot";
-		reg = <0>;
-		gpios = <&pioC 4 0>;	/* CD */
-		spi-max-frequency = <25000000>;
-	};
-};
-- 
2.25.1

