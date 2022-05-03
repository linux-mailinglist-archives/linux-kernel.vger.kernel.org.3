Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A924D5182CD
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 12:57:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234485AbiECLBI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 07:01:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234581AbiECLAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 07:00:07 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC6031C907;
        Tue,  3 May 2022 03:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1651575377; x=1683111377;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=JMfILJt9Qdwbtxcn7LDS0ssDPoXBmd8C5LPlUEheFFI=;
  b=e/u0b6GBiWe+LQu2FlM8D7uNCEvtZfbonoQh2ZghsEa2BX7gWYHPwOUR
   FXGiX0gY/oXbAsIpuBKUZT5H3G/gsFN4oY6WOXXPds6oiWbTf7PWAN3eH
   co81BCzz+PlaHrYO7X6W8QblyqIYwZCh/VXUPqH5dTNx/EJtirCMk1117
   aoi7bwOp4/0g0/0mXWLxYjcY6CIWy1tVRghGNYgi+spjWdwoRMKyEz4Uz
   a5ruJgO9DEonA1mzoFUKCUp7Cjbw0jPaehCRPi86GRJw4c7HJyICGXigX
   ZPIQGK0gSVkitAYMxi27ONkjibWBiFXEkMn9RSR/QVNuNSFs0PFMCdR5/
   A==;
X-IronPort-AV: E=Sophos;i="5.91,195,1647327600"; 
   d="scan'208";a="162535319"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 03 May 2022 03:56:17 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 3 May 2022 03:56:17 -0700
Received: from kavya-HP-Compaq-6000-Pro-SFF-PC.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Tue, 3 May 2022 03:56:12 -0700
From:   Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
To:     <krzysztof.kozlowski+dt@linaro.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <claudiu.beznea@microchip.com>,
        <peda@axentia.se>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <lee.jones@linaro.org>,
        <linux@armlinux.org.uk>, <Manohar.Puri@microchip.com>,
        <Kavyasree.Kotagiri@microchip.com>, <UNGLinuxDriver@microchip.com>
Subject: [PATCH 1/4] dt-bindings: mfd: atmel,flexcom: Convert to json-schema
Date:   Tue, 3 May 2022 16:25:25 +0530
Message-ID: <20220503105528.12824-2-kavyasree.kotagiri@microchip.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220503105528.12824-1-kavyasree.kotagiri@microchip.com>
References: <20220503105528.12824-1-kavyasree.kotagiri@microchip.com>
MIME-Version: 1.0
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

Convert the Atmel flexcom device tree bindings to json schema.

Signed-off-by: Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
---
 .../bindings/mfd/atmel,flexcom.yaml           | 68 +++++++++++++++++++
 .../devicetree/bindings/mfd/atmel-flexcom.txt | 63 -----------------
 2 files changed, 68 insertions(+), 63 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/atmel,flexcom.yaml
 delete mode 100644 Documentation/devicetree/bindings/mfd/atmel-flexcom.txt

diff --git a/Documentation/devicetree/bindings/mfd/atmel,flexcom.yaml b/Documentation/devicetree/bindings/mfd/atmel,flexcom.yaml
new file mode 100644
index 000000000000..62dea9b891d8
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/atmel,flexcom.yaml
@@ -0,0 +1,68 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/atmel,flexcom.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Device tree bindings for Atmel Flexcom (Flexible Serial Communication Unit)
+
+maintainers:
+  - Rob Herring <robh+dt@kernel.org>
+
+description: |
+  The Atmel Flexcom is just a wrapper which embeds a SPI controller,
+  an I2C controller and an USART. Only one function can be used at a
+  time and is chosen at boot time according to the device tree.
+
+properties:
+  compatible:
+    enum:
+      - atmel,sama5d2-flexcom
+
+  reg:
+    minItems: 1
+    items:
+      - description: Flexcom registers
+
+  clocks:
+    maxItems: 1
+
+  "#address-cells": true
+
+  "#size-cells": true
+
+  ranges:
+    description:
+      One range for the full I/O register region. (including USART,
+      TWI and SPI registers).
+    items:
+      minItems: 3
+      maxItems: 3
+
+  atmel,flexcom-mode:
+    description:
+      One of the values. UART, I2C, SPI.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [0, 1, 2]
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - "#address-cells"
+  - "#size-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    flx0: flexcom@f8034000 {
+          compatible = "atmel,sama5d2-flexcom";
+          reg = <0xf8034000 0x200>;
+          clocks = <&flx0_clk>;
+          #address-cells = <1>;
+          #size-cells = <1>;
+          ranges = <0x0 0xf8034000 0x800>;
+          atmel,flexcom-mode = <2>;
+    };
+...
diff --git a/Documentation/devicetree/bindings/mfd/atmel-flexcom.txt b/Documentation/devicetree/bindings/mfd/atmel-flexcom.txt
deleted file mode 100644
index 692300117c64..000000000000
--- a/Documentation/devicetree/bindings/mfd/atmel-flexcom.txt
+++ /dev/null
@@ -1,63 +0,0 @@
-* Device tree bindings for Atmel Flexcom (Flexible Serial Communication Unit)
-
-The Atmel Flexcom is just a wrapper which embeds a SPI controller, an I2C
-controller and an USART. Only one function can be used at a time and is chosen
-at boot time according to the device tree.
-
-Required properties:
-- compatible:		Should be "atmel,sama5d2-flexcom"
-- reg:			Should be the offset/length value for Flexcom dedicated
-			I/O registers (without USART, TWI or SPI registers).
-- clocks:		Should be the Flexcom peripheral clock from PMC.
-- #address-cells:	Should be <1>
-- #size-cells:		Should be <1>
-- ranges:		Should be one range for the full I/O register region
-			(including USART, TWI and SPI registers).
-- atmel,flexcom-mode:	Should be one of the following values:
-			- <1> for USART
-			- <2> for SPI
-			- <3> for I2C
-
-Required child:
-A single available child device of type matching the "atmel,flexcom-mode"
-property.
-
-The phandle provided by the clocks property of the child is the same as one for
-the Flexcom parent.
-
-For other properties, please refer to the documentations of the respective
-device:
-- ../serial/atmel-usart.txt
-- ../spi/spi_atmel.txt
-- ../i2c/i2c-at91.txt
-
-Example:
-
-flexcom@f8034000 {
-	compatible = "atmel,sama5d2-flexcom";
-	reg = <0xf8034000 0x200>;
-	clocks = <&flx0_clk>;
-	#address-cells = <1>;
-	#size-cells = <1>;
-	ranges = <0x0 0xf8034000 0x800>;
-	atmel,flexcom-mode = <2>;
-
-	spi@400 {
-		compatible = "atmel,at91rm9200-spi";
-		reg = <0x400 0x200>;
-		interrupts = <19 IRQ_TYPE_LEVEL_HIGH 7>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_flx0_default>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-		clocks = <&flx0_clk>;
-		clock-names = "spi_clk";
-		atmel,fifo-size = <32>;
-
-		mtd_dataflash@0 {
-			compatible = "atmel,at25f512b";
-			reg = <0>;
-			spi-max-frequency = <20000000>;
-		};
-	};
-};
-- 
2.17.1

