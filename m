Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25D5746E87A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 13:30:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237246AbhLIMdW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 07:33:22 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:50895 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbhLIMdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 07:33:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1639052987; x=1670588987;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Xd9Rwi9IKDoW7SY8FYHsa3ZNF0l93uiiSgNbg2ztoig=;
  b=oxaw43OmLAoQlcotiJz9V2tRWzs0gTwgmYXy9rFIv118HB8l6nvbSysY
   wX7pihN10OPnqglBbRWDT1RdZ6vO7j32EcdijIZIwlVEp72AvHBU+1XBO
   e6La026u+9iqQPPoIgp/Qmy/LG6WTotAMH4VLfeXELCvZDwj+y/uBCn2d
   +vdaOcxFs3rsedo1NpFgPG4Utd8IjDEBLlwmikjc9UzKfOQ3YiGgJKXek
   vg6WIQYmdCkJuBs9AxkTBxuP2vc2JhHx0/4c1j+ueUJN6kSVdlK2AwHhJ
   o2KTEJHW3aSB88E+rKDxJo+5kbwxKkEN/HLOVvPD3n9hVFB1mMTGOCKA1
   g==;
IronPort-SDR: Jsuv8MMuzlCCj2a9A9IE96GxHYar/oz9bADe2OdIP/rQ/y5SHHUjSLjGrM91LiIfkT6PVddxEP
 RHe9ZVDlJUMWYBtoIZqGZRI6BgfMWNbjj68X/BESkwZVgCSwZq+zaejc3daoO6T9dHiq0gtj8x
 01O+5FTskkfH9njODe9MlZfndpVMFKPR2il9oDxteheHjSGxpeZK8gAdR2ZPRSbrbzSyEuUlpi
 rLORDV0m6C3YzQImfIpU7AMCrR/s/SP4VOjiYY+Z1Sntxckt0GbZ4qsUsQ7omGrSkBCU9vV9sv
 9LGSw7wUFX3ZfcCGBhGztpZF
X-IronPort-AV: E=Sophos;i="5.88,192,1635231600"; 
   d="scan'208";a="154857067"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Dec 2021 05:29:46 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 9 Dec 2021 05:29:46 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Thu, 9 Dec 2021 05:29:43 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <broonie@kernel.org>, <robh+dt@kernel.org>
CC:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: [PATCH 1/2] dt-bindings: spi: atmel,quadspi: Convert to json-schema
Date:   Thu, 9 Dec 2021 14:29:38 +0200
Message-ID: <20211209122939.339810-2-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211209122939.339810-1-tudor.ambarus@microchip.com>
References: <20211209122939.339810-1-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the Atmel QuadSPI controller Device Tree binding documentation
to json-schema.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 .../bindings/spi/atmel,quadspi.yaml           | 87 +++++++++++++++++++
 .../devicetree/bindings/spi/atmel-quadspi.txt | 37 --------
 2 files changed, 87 insertions(+), 37 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/atmel,quadspi.yaml
 delete mode 100644 Documentation/devicetree/bindings/spi/atmel-quadspi.txt

diff --git a/Documentation/devicetree/bindings/spi/atmel,quadspi.yaml b/Documentation/devicetree/bindings/spi/atmel,quadspi.yaml
new file mode 100644
index 000000000000..7d0408f53c5f
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/atmel,quadspi.yaml
@@ -0,0 +1,87 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/atmel,quadspi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Atmel Quad Serial Peripheral Interface (QSPI)
+
+maintainers:
+  - Tudor Ambarus <tudor.ambarus@microchip.com>
+
+allOf:
+  - $ref: spi-controller.yaml#
+
+properties:
+  compatible:
+    enum:
+      - atmel,sama5d2-qspi
+      - microchip,sam9x60-qspi
+
+  reg:
+    items:
+      - description: base registers
+      - description: mapped memory
+
+  reg-names:
+    items:
+      - const: qspi_base
+      - const: qspi_mmap
+
+  clocks:
+    minItems: 1
+    items:
+      - description: peripheral clock
+      - description: system clock, if available
+
+  clock-names:
+    minItems: 1
+    items:
+      - const: pclk
+      - const: qspick
+
+  interrupts:
+    maxItems: 1
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 0
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - interrupts
+  - clocks
+  - clock-names
+  - '#address-cells'
+  - '#size-cells'
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/clock/at91.h>
+    spi@f0020000 {
+        compatible = "atmel,sama5d2-qspi";
+        reg = <0xf0020000 0x100>, <0xd0000000 0x8000000>;
+        reg-names = "qspi_base", "qspi_mmap";
+        interrupts = <52 IRQ_TYPE_LEVEL_HIGH 7>;
+        clocks = <&pmc PMC_TYPE_PERIPHERAL 52>;
+        clock-names = "pclk";
+        #address-cells = <1>;
+        #size-cells = <0>;
+        pinctrl-names = "default";
+        pinctrl-0 = <&pinctrl_spi0_default>;
+
+        flash@0 {
+            compatible = "jedec,spi-nor";
+            spi-max-frequency = <50000000>;
+            reg = <0>;
+            spi-rx-bus-width = <4>;
+            spi-tx-bus-width = <4>;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/spi/atmel-quadspi.txt b/Documentation/devicetree/bindings/spi/atmel-quadspi.txt
deleted file mode 100644
index 7c40ea694352..000000000000
--- a/Documentation/devicetree/bindings/spi/atmel-quadspi.txt
+++ /dev/null
@@ -1,37 +0,0 @@
-* Atmel Quad Serial Peripheral Interface (QSPI)
-
-Required properties:
-- compatible:     Should be one of the following:
-		  - "atmel,sama5d2-qspi"
-		  - "microchip,sam9x60-qspi"
-- reg:            Should contain the locations and lengths of the base registers
-                  and the mapped memory.
-- reg-names:      Should contain the resource reg names:
-                  - qspi_base: configuration register address space
-                  - qspi_mmap: memory mapped address space
-- interrupts:     Should contain the interrupt for the device.
-- clocks:         Should reference the peripheral clock and the QSPI system
-                  clock if available.
-- clock-names:    Should contain "pclk" for the peripheral clock and "qspick"
-                  for the system clock when available.
-- #address-cells: Should be <1>.
-- #size-cells:    Should be <0>.
-
-Example:
-
-spi@f0020000 {
-	compatible = "atmel,sama5d2-qspi";
-	reg = <0xf0020000 0x100>, <0xd0000000 0x8000000>;
-	reg-names = "qspi_base", "qspi_mmap";
-	interrupts = <52 IRQ_TYPE_LEVEL_HIGH 7>;
-	clocks = <&pmc PMC_TYPE_PERIPHERAL 52>;
-	clock-names = "pclk";
-	#address-cells = <1>;
-	#size-cells = <0>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_spi0_default>;
-
-	m25p80@0 {
-		...
-	};
-};
-- 
2.25.1

