Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C45F95720D6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 18:28:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233827AbiGLQ2o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 12:28:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233188AbiGLQ2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 12:28:37 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73F81FE5;
        Tue, 12 Jul 2022 09:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1657643313; x=1689179313;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=I3mUL3/zAiCGwntN0HY2apn/gTgpJHWfc8dI+sFDedg=;
  b=R9x9RD8Nb4XUanuPGaXyePTLej7vd/AVWXfJntPQjn5ffVqi4ihGYsJd
   7KVC6rewtImA3K887tmy429c2DmkD6jfpWZJpVarVQvficOSQbLrgDMyM
   L8cT/J9MCn/O1veuMj1z5mI864H/piBvJu8+ftdZarcUHLuDufjDnEoFd
   tI82uRY54q1qlW3/pKAOz3uVNWD/aLPvuMoRYC/CmHNnCEM+qyB8IG1Nc
   ywncALbGVD7a57fzc4j4z8XlrlsZVfK6FsR4asVP5FbqIZeMEimkJBOn5
   /cVTf3fqNM36qoqqf5KrDBj84SG7Nvt46HvupGtCud/7Am6ObpqGnnr6/
   A==;
X-IronPort-AV: E=Sophos;i="5.92,266,1650956400"; 
   d="scan'208";a="104127836"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 12 Jul 2022 09:28:03 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 12 Jul 2022 09:28:01 -0700
Received: from ROB-ULT-M68701.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Tue, 12 Jul 2022 09:27:54 -0700
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
Subject: [PATCH v3] spi: dt-bindings: atmel,at91rm9200-spi: convert to json-schema
Date:   Tue, 12 Jul 2022 19:25:55 +0300
Message-ID: <20220712162554.148741-1-sergiu.moga@microchip.com>
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


 .../bindings/spi/atmel,at91rm9200-spi.yaml    | 76 +++++++++++++++++++
 .../devicetree/bindings/spi/spi_atmel.txt     | 36 ---------
 2 files changed, 76 insertions(+), 36 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/atmel,at91rm9200-spi.yaml
 delete mode 100644 Documentation/devicetree/bindings/spi/spi_atmel.txt

diff --git a/Documentation/devicetree/bindings/spi/atmel,at91rm9200-spi.yaml b/Documentation/devicetree/bindings/spi/atmel,at91rm9200-spi.yaml
new file mode 100644
index 000000000000..084897cc8f66
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/atmel,at91rm9200-spi.yaml
@@ -0,0 +1,76 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (C) 2022 Microchip Technology, Inc. and its subsidiaries
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/atmel,spi.yaml#
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
+      - items:
+          - const: atmel,at91rm9200-spi
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
+  enum: [ 16, 32 ]
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

