Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BDD3596AC5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 10:04:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233820AbiHQIDb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 04:03:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233687AbiHQIDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 04:03:19 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3120E0D0;
        Wed, 17 Aug 2022 01:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1660723397; x=1692259397;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fqZU+lOemIX/omn3Ka+GnYknomKYKw8v51G1/iVYc+4=;
  b=Kp4YolbYW+0PEW8M2wHr7hMLWfS8h6rzvqiCuGMiEdEDJnWVoQMLCFr0
   r+1mJId4eoyRYL4XpiR00KN+T3TARVkCiCyuUHgrbR99gML4o+Rvli3/6
   8Wwxnj2/JjyvlFPIxYdJ+hcpAhJ77oC072iyvogkamS1f+weDnLqxK7DE
   8s9t9jHVAub0QqfSk4z2KboZI98eSd1F4Zndlxjiqq/qgc0lhMHyxJJ8R
   w0c8eKBMs/78vQ1scY44W2wb7YjW8me5n/760Sq+GnS2w/V8VDsAWcQyb
   Y5jq+N8n0KExsi11BIRayyLNaEmg06WEv55XDiesXJPdWyN+cBhRFWPu7
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,242,1654585200"; 
   d="scan'208";a="109399576"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 Aug 2022 01:03:13 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Wed, 17 Aug 2022 01:03:13 -0700
Received: from ROB-ULT-M68701.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Wed, 17 Aug 2022 01:03:08 -0700
From:   Sergiu Moga <sergiu.moga@microchip.com>
To:     <lee@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <claudiu.beznea@microchip.com>,
        <radu_nicolae.pirea@upb.ro>, <richard.genoud@gmail.com>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
        <admin@hifiphile.com>, <kavyasree.kotagiri@microchip.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        Sergiu Moga <sergiu.moga@microchip.com>
Subject: [PATCH 2/5] dt-bindings: mfd: atmel,at91-usart: convert to json-schema
Date:   Wed, 17 Aug 2022 10:55:15 +0300
Message-ID: <20220817075517.49575-3-sergiu.moga@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220817075517.49575-1-sergiu.moga@microchip.com>
References: <20220817075517.49575-1-sergiu.moga@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert at91 USART DT Binding for Atmel/Microchip SoCs to
json-schema format.

Signed-off-by: Sergiu Moga <sergiu.moga@microchip.com>
---
 .../bindings/mfd/atmel,at91-usart.yaml        | 190 ++++++++++++++++++
 .../devicetree/bindings/mfd/atmel-usart.txt   |  98 ---------
 2 files changed, 190 insertions(+), 98 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/atmel,at91-usart.yaml
 delete mode 100644 Documentation/devicetree/bindings/mfd/atmel-usart.txt

diff --git a/Documentation/devicetree/bindings/mfd/atmel,at91-usart.yaml b/Documentation/devicetree/bindings/mfd/atmel,at91-usart.yaml
new file mode 100644
index 000000000000..cf15d73fa1e8
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/atmel,at91-usart.yaml
@@ -0,0 +1,190 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (C) 2022 Microchip Technology, Inc. and its subsidiaries
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/atmel,at91-usart.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Atmel Universal Synchronous Asynchronous Receiver/Transmitter (USART)
+
+maintainers:
+  - Richard Genoud <richard.genoud@gmail.com>
+
+properties:
+  compatible:
+    oneOf:
+      - const: atmel,at91rm9200-usart
+      - const: atmel,at91sam9260-usart
+      - const: microchip,sam9x60-usart
+      - items:
+          - const: atmel,at91rm9200-dbgu
+          - const: atmel,at91rm9200-usart
+      - items:
+          - const: atmel,at91sam9260-dbgu
+          - const: atmel,at91sam9260-usart
+      - items:
+          - const: microchip,sam9x60-dbgu
+          - const: microchip,sam9x60-usart
+      - items:
+          - const: microchip,sam9x60-usart
+          - const: atmel,at91sam9260-usart
+      - items:
+          - const: microchip,sam9x60-dbgu
+          - const: microchip,sam9x60-usart
+          - const: atmel,at91sam9260-dbgu
+          - const: atmel,at91sam9260-usart
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clock-names:
+    contains:
+      const: usart
+
+  clocks:
+    minItems: 1
+    maxItems: 2
+
+  dmas:
+    items:
+      - description: TX DMA Channel
+      - description: RX DMA Channel
+
+  dma-names:
+    items:
+      - const: tx
+      - const: rx
+
+  atmel,usart-mode:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Must be either 1 for SPI or 0 for USART.
+    enum: [ 0, 1 ]
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clock-names
+  - clocks
+
+if:
+  properties:
+    $nodename:
+      pattern: "^serial@[0-9a-f]+$"
+then:
+  allOf:
+    - $ref: /schemas/serial/serial.yaml#
+    - $ref: /schemas/serial/rs485.yaml#
+
+  properties:
+    atmel,use-dma-rx:
+      type: boolean
+      description: use of PDC or DMA for receiving data
+
+    atmel,use-dma-tx:
+      type: boolean
+      description: use of PDC or DMA for transmitting data
+
+    atmel,fifo-size:
+      $ref: /schemas/types.yaml#/definitions/uint32
+      description: |
+        Maximum number of data the RX and TX FIFOs can store for FIFO
+        capable USARTS.
+      enum: [ 16, 32 ]
+
+else:
+  if:
+    properties:
+      $nodename:
+        pattern: "^spi@[0-9a-f]+$"
+  then:
+    allOf:
+      - $ref: /schemas/spi/spi-controller.yaml#
+
+    properties:
+      atmel,usart-mode:
+        const: 1
+
+      "#size-cells":
+        const: 0
+
+      "#address-cells":
+        const: 1
+
+    required:
+      - atmel,usart-mode
+      - "#size-cells"
+      - "#address-cells"
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/mfd/at91-usart.h>
+    #include <dt-bindings/dma/at91.h>
+
+    /* use PDC */
+    usart0: serial@fff8c000 {
+        compatible = "atmel,at91sam9260-usart";
+        reg = <0xfff8c000 0x4000>;
+        interrupts = <7>;
+        clocks = <&usart0_clk>;
+        clock-names = "usart";
+        atmel,use-dma-rx;
+        atmel,use-dma-tx;
+        rts-gpios = <&pioD 15 GPIO_ACTIVE_LOW>;
+        cts-gpios = <&pioD 16 GPIO_ACTIVE_LOW>;
+        dtr-gpios = <&pioD 17 GPIO_ACTIVE_LOW>;
+        dsr-gpios = <&pioD 18 GPIO_ACTIVE_LOW>;
+        dcd-gpios = <&pioD 20 GPIO_ACTIVE_LOW>;
+        rng-gpios = <&pioD 19 GPIO_ACTIVE_LOW>;
+    };
+
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/mfd/at91-usart.h>
+    #include <dt-bindings/dma/at91.h>
+
+    /* use DMA */
+    usart1: serial@f001c000 {
+        compatible = "atmel,at91sam9260-usart";
+        reg = <0xf001c000 0x100>;
+        interrupts = <12 IRQ_TYPE_LEVEL_HIGH 5>;
+        clocks = <&usart0_clk>;
+        clock-names = "usart";
+        atmel,use-dma-rx;
+        atmel,use-dma-tx;
+        dmas = <&dma0 2 AT91_DMA_CFG_PER_ID(3)>,
+               <&dma0 2 (AT91_DMA_CFG_PER_ID(4) | AT91_DMA_CFG_FIFOCFG_ASAP)>;
+        dma-names = "tx", "rx";
+        atmel,fifo-size = <32>;
+    };
+
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/mfd/at91-usart.h>
+    #include <dt-bindings/dma/at91.h>
+
+    /* SPI mode */
+    spi0: spi@f001c000 {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        compatible = "atmel,at91sam9260-usart";
+        atmel,usart-mode = <AT91_USART_MODE_SPI>;
+        reg = <0xf001c000 0x100>;
+        interrupts = <12 IRQ_TYPE_LEVEL_HIGH 5>;
+        clocks = <&usart0_clk>;
+        clock-names = "usart";
+        dmas = <&dma0 2 AT91_DMA_CFG_PER_ID(3)>,
+               <&dma0 2 (AT91_DMA_CFG_PER_ID(4) | AT91_DMA_CFG_FIFOCFG_ASAP)>;
+        dma-names = "tx", "rx";
+        cs-gpios = <&pioB 3 GPIO_ACTIVE_HIGH>;
+    };
diff --git a/Documentation/devicetree/bindings/mfd/atmel-usart.txt b/Documentation/devicetree/bindings/mfd/atmel-usart.txt
deleted file mode 100644
index a09133066aff..000000000000
--- a/Documentation/devicetree/bindings/mfd/atmel-usart.txt
+++ /dev/null
@@ -1,98 +0,0 @@
-* Atmel Universal Synchronous Asynchronous Receiver/Transmitter (USART)
-
-Required properties for USART:
-- compatible: Should be one of the following:
-	- "atmel,at91rm9200-usart"
-	- "atmel,at91sam9260-usart"
-	- "microchip,sam9x60-usart"
-	- "atmel,at91rm9200-dbgu", "atmel,at91rm9200-usart"
-	- "atmel,at91sam9260-dbgu", "atmel,at91sam9260-usart"
-	- "microchip,sam9x60-dbgu", "microchip,sam9x60-usart"
-- reg: Should contain registers location and length
-- interrupts: Should contain interrupt
-- clock-names: tuple listing input clock names.
-	Required elements: "usart"
-- clocks: phandles to input clocks.
-
-Required properties for USART in SPI mode:
-- #size-cells      : Must be <0>
-- #address-cells   : Must be <1>
-- cs-gpios: chipselects (internal cs not supported)
-- atmel,usart-mode : Must be <AT91_USART_MODE_SPI> (found in dt-bindings/mfd/at91-usart.h)
-
-Optional properties in serial and SPI mode:
-- dma bindings for dma transfer:
-	- dmas: DMA specifier, consisting of a phandle to DMA controller node,
-		memory peripheral interface and USART DMA channel ID, FIFO configuration.
-		The order of DMA channels is fixed. The first DMA channel must be TX
-		associated channel and the second one must be RX associated channel.
-		Refer to dma.txt and atmel-dma.txt for details.
-	- dma-names: "tx" for TX channel.
-		     "rx" for RX channel.
-		     The order of dma-names is also fixed. The first name must be "tx"
-		     and the second one must be "rx" as in the examples below.
-
-Optional properties in serial mode:
-- atmel,use-dma-rx: use of PDC or DMA for receiving data
-- atmel,use-dma-tx: use of PDC or DMA for transmitting data
-- {rts,cts,dtr,dsr,rng,dcd}-gpios: specify a GPIO for RTS/CTS/DTR/DSR/RI/DCD line respectively.
-  It will use specified PIO instead of the peripheral function pin for the USART feature.
-  If unsure, don't specify this property.
-- atmel,fifo-size: maximum number of data the RX and TX FIFOs can store for FIFO
-  capable USARTs.
-- rs485-rts-delay, rs485-rx-during-tx, linux,rs485-enabled-at-boot-time: see rs485.txt
-
-<chip> compatible description:
-- at91rm9200:  legacy USART support
-- at91sam9260: generic USART implementation for SAM9 SoCs
-
-Example:
-- use PDC:
-	usart0: serial@fff8c000 {
-		compatible = "atmel,at91sam9260-usart";
-		reg = <0xfff8c000 0x4000>;
-		interrupts = <7>;
-		clocks = <&usart0_clk>;
-		clock-names = "usart";
-		atmel,use-dma-rx;
-		atmel,use-dma-tx;
-		rts-gpios = <&pioD 15 GPIO_ACTIVE_LOW>;
-		cts-gpios = <&pioD 16 GPIO_ACTIVE_LOW>;
-		dtr-gpios = <&pioD 17 GPIO_ACTIVE_LOW>;
-		dsr-gpios = <&pioD 18 GPIO_ACTIVE_LOW>;
-		dcd-gpios = <&pioD 20 GPIO_ACTIVE_LOW>;
-		rng-gpios = <&pioD 19 GPIO_ACTIVE_LOW>;
-	};
-
-- use DMA:
-	usart0: serial@f001c000 {
-		compatible = "atmel,at91sam9260-usart";
-		reg = <0xf001c000 0x100>;
-		interrupts = <12 4 5>;
-		clocks = <&usart0_clk>;
-		clock-names = "usart";
-		atmel,use-dma-rx;
-		atmel,use-dma-tx;
-		dmas = <&dma0 2 0x3>,
-		       <&dma0 2 0x204>;
-		dma-names = "tx", "rx";
-		atmel,fifo-size = <32>;
-	};
-
-- SPI mode:
-	#include <dt-bindings/mfd/at91-usart.h>
-
-	spi0: spi@f001c000 {
-		#address-cells = <1>;
-		#size-cells = <0>;
-		compatible = "atmel,at91rm9200-usart", "atmel,at91sam9260-usart";
-		atmel,usart-mode = <AT91_USART_MODE_SPI>;
-		reg = <0xf001c000 0x100>;
-		interrupts = <12 IRQ_TYPE_LEVEL_HIGH 5>;
-		clocks = <&usart0_clk>;
-		clock-names = "usart";
-		dmas = <&dma0 2 AT91_DMA_CFG_PER_ID(3)>,
-		       <&dma0 2 (AT91_DMA_CFG_PER_ID(4) | AT91_DMA_CFG_FIFOCFG_ASAP)>;
-		dma-names = "tx", "rx";
-		cs-gpios = <&pioB 3 0>;
-	};
-- 
2.25.1

