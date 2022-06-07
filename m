Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BA585401B9
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 16:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343533AbiFGOsD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 10:48:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343511AbiFGOr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 10:47:59 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 430F72650;
        Tue,  7 Jun 2022 07:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1654613277; x=1686149277;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=T4IDVN5xjKwI8K2UtI24MAuMfSjf6CJ6I+y9+SETrZ0=;
  b=Ji5qQhuAueVWE3Q5I8GRkwsLHBIY0x9JzpC2fql2dr7/ZFriLQE11hui
   iilSs/tu7kOQaElGpRIv7hq/1UGcgLX70SkeWLqEGAeeehH1oYgL5lxm1
   AS4I+FGYfxbHcqUnRqAtcQQqGncVRnPJfmMX/ZCdpdQ7InTcYNQBKYQZs
   AugaFX41NHCLveiou6euf7aHq8bRayvY2tjCvz7VA8HSdoIljCdaneX5y
   PxeJLI1/4rppwiQczYTzG16+Vn0zXokYsErgAFZMWjtwQdTppMStQNmSS
   Vnh57L0O71dXKfWYfjwK7O4M9t4IIiwgkPNrZBXpq+8Ooqsij/jWbw6pa
   A==;
X-IronPort-AV: E=Sophos;i="5.91,284,1647327600"; 
   d="scan'208";a="162250840"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Jun 2022 07:47:56 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 7 Jun 2022 07:47:55 -0700
Received: from kavya-HP-Compaq-6000-Pro-SFF-PC.microchip.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Tue, 7 Jun 2022 07:47:51 -0700
From:   Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
To:     <krzysztof.kozlowski+dt@linaro.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <claudiu.beznea@microchip.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kavyasree.kotagiri@microchip.com>,
        <UNGLinuxDriver@microchip.com>
Subject: [PATCH v2 1/3] dt-bindings: mfd: atmel,flexcom: Convert to json-schema
Date:   Tue, 7 Jun 2022 20:17:38 +0530
Message-ID: <20220607144740.14937-2-kavyasree.kotagiri@microchip.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220607144740.14937-1-kavyasree.kotagiri@microchip.com>
References: <20220607144740.14937-1-kavyasree.kotagiri@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
v1 -> v2:
 - Fix title.

 .../bindings/mfd/atmel,flexcom.yaml           | 97 +++++++++++++++++++
 .../devicetree/bindings/mfd/atmel-flexcom.txt | 63 ------------
 2 files changed, 97 insertions(+), 63 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/atmel,flexcom.yaml
 delete mode 100644 Documentation/devicetree/bindings/mfd/atmel-flexcom.txt

diff --git a/Documentation/devicetree/bindings/mfd/atmel,flexcom.yaml b/Documentation/devicetree/bindings/mfd/atmel,flexcom.yaml
new file mode 100644
index 000000000000..05cb6ebb4b2a
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/atmel,flexcom.yaml
@@ -0,0 +1,97 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/atmel,flexcom.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Atmel Flexcom (Flexible Serial Communication Unit)
+
+maintainers:
+  - Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
+
+description:
+  The Atmel Flexcom is just a wrapper which embeds a SPI controller,
+  an I2C controller and an USART. Only one function can be used at a
+  time and is chosen at boot time according to the device tree.
+
+properties:
+  compatible:
+    const: atmel,sama5d2-flexcom
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 1
+
+  ranges:
+    description:
+      One range for the full I/O register region. (including USART,
+      TWI and SPI registers).
+    items:
+      maxItems: 3
+
+  atmel,flexcom-mode:
+    description: |
+      Specifies the flexcom mode as follows:
+      1: USART
+      2: SPI
+      3: I2C.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [1, 2, 3]
+
+patternProperties:
+  "^serial@[0-9a-f]+$":
+    description: See atmel-usart.txt for details of USART bindings.
+    type: object
+
+  "^spi@[0-9a-f]+$":
+    description: See ../spi/spi_atmel.txt for details of SPI bindings.
+    type: object
+
+  "^i2c@[0-9a-f]+$":
+    description: See ../i2c/i2c-at91.txt for details of I2C bindings.
+    type: object
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - "#address-cells"
+  - "#size-cells"
+  - ranges
+  - atmel,flexcom-mode
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
+
+          spi0: spi@400 {
+                compatible = "atmel,at91rm9200-spi";
+                reg = <0x400 0x200>;
+                interrupts = <19 4 7>;
+                pinctrl-names = "default";
+                pinctrl-0 = <&pinctrl_flx0_default>;
+                #address-cells = <1>;
+                #size-cells = <0>;
+                clocks = <&flx0_clk>;
+                clock-names = "spi_clk";
+                atmel,fifo-size = <32>;
+          };
+    };
+...
diff --git a/Documentation/devicetree/bindings/mfd/atmel-flexcom.txt b/Documentation/devicetree/bindings/mfd/atmel-flexcom.txt
deleted file mode 100644
index 9d837535637b..000000000000
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
-		flash@0 {
-			compatible = "atmel,at25f512b";
-			reg = <0>;
-			spi-max-frequency = <20000000>;
-		};
-	};
-};
-- 
2.17.1

