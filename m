Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6C97547AC5
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jun 2022 17:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237570AbiFLP0c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 11:26:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237555AbiFLP0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 11:26:22 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6797DE0DF;
        Sun, 12 Jun 2022 08:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1655047582; x=1686583582;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=Zkqs4nZV/opK25X0cSY/Ga5lQbJgFmvdroI46LZ6xhc=;
  b=2EWjaKATO70ReAKp4WjN9ILkwNhxFvPwr6udT3QJxF4pytHIktWFdWT6
   C5pvO0xn/nKHUerIYDevQtyy5WqtdZ9xBqj/dbvqbb4ZCQOjlrImROsqL
   gXbsFCyMUE3a8QMqs07DbypIVBXg1xrM5ZQ6VdYdLjip+TsUaLZDu+UeR
   jc4PqqH14PvZPpRJDC6M9q1tQwvtr2+4QMqbJAwYAIKEfRHjR3vX6Fq+9
   bxutjLaVarn2JpWuBFwiKpmTpyhkmXCfEwpr8d0V7z0dxfc1E/3nX0nCa
   iJzDo+Bbztb7lBVPkr9AfzWJuqtFc2L5lYD7Aa7cPSaI4OOLaEvtx7SOe
   A==;
X-IronPort-AV: E=Sophos;i="5.91,294,1647327600"; 
   d="scan'208";a="159941870"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 12 Jun 2022 08:26:22 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Sun, 12 Jun 2022 08:26:20 -0700
Received: from kavya-HP-Compaq-6000-Pro-SFF-PC.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Sun, 12 Jun 2022 08:26:17 -0700
From:   Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
To:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <claudiu.beznea@microchip.com>, <UNGLinuxDriver@microchip.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Kavyasree.Kotagiri@microchip.com>
Subject: [PATCH v3 2/3] dt-bindings: mfd: atmel,flexcom: Add new compatible string for lan966x
Date:   Sun, 12 Jun 2022 20:56:03 +0530
Message-ID: <20220612152604.24280-3-kavyasree.kotagiri@microchip.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220612152604.24280-1-kavyasree.kotagiri@microchip.com>
References: <20220612152604.24280-1-kavyasree.kotagiri@microchip.com>
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

LAN966x SoC flexcoms has two optional I/O lines. Namely, CS0 and CS1
in flexcom SPI mode. CTS and RTS in flexcom USART mode. These pins
can be mapped to lan966x FLEXCOM_SHARED[0-20] pins and usage depends on
functions being configured.

Signed-off-by: Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
---
v2 -> v3:
 - Add reg property of lan966x missed in v2.

v1 -> v2:
 - Use allOf:if:then for lan966x dt properties

 .../bindings/mfd/atmel,flexcom.yaml           | 75 ++++++++++++++++++-
 1 file changed, 73 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/atmel,flexcom.yaml b/Documentation/devicetree/bindings/mfd/atmel,flexcom.yaml
index cee9c93ce4b9..d9b0fe2b0211 100644
--- a/Documentation/devicetree/bindings/mfd/atmel,flexcom.yaml
+++ b/Documentation/devicetree/bindings/mfd/atmel,flexcom.yaml
@@ -16,10 +16,13 @@ description:
 
 properties:
   compatible:
-    enum: atmel,sama5d2-flexcom
+    enum:
+      - atmel,sama5d2-flexcom
+      - microchip,lan966x-flexcom
 
   reg:
-    maxItems: 1
+    minItems: 1
+    maxItems: 2
 
   clocks:
     maxItems: 1
@@ -46,6 +49,27 @@ properties:
     $ref: /schemas/types.yaml#/definitions/uint32
     enum: [1, 2, 3]
 
+  microchip,flx-shrd-pins:
+    description: Specify the Flexcom shared pins to be used for flexcom
+      chip-selects.
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 1
+    maxItems: 2
+    items:
+      minimum: 0
+      maximum: 20
+
+  microchip,flx-cs:
+    description: Flexcom chip selects. Here, value of '0' represents "cts" line
+      of flexcom USART or "cs0" line of flexcom SPI and value of '1' represents
+      "rts" line of flexcom USART or "cs1" line of flexcom SPI.
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 1
+    maxItems: 2
+    items:
+      minimum: 0
+      maximum: 1
+
 patternProperties:
   "^serial@[0-9a-f]+$":
     description: See atmel-usart.txt for details of USART bindings.
@@ -72,6 +96,25 @@ required:
   - ranges
   - atmel,flexcom-mode
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: microchip,lan966x-flexcom
+
+    then:
+      properties:
+        reg:
+          minItems: 2
+          maxItems: 2
+          items:
+            - description: Flexcom base regsiters map
+            - description: Flexcom shared registers map
+      required:
+        - microchip,flx-shrd-pins
+        - microchip,flx-cs
+
 additionalProperties: false
 
 examples:
@@ -100,4 +143,32 @@ examples:
                 atmel,fifo-size = <32>;
           };
     };
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    flx3: flexcom@e0064000 {
+          compatible = "microchip,lan966x-flexcom";
+          reg = <0xe0064000 0x100>,
+                <0xe2004180 0x8>;
+          clocks = <&flx0_clk>;
+          #address-cells = <1>;
+          #size-cells = <1>;
+          ranges = <0x0 0xe0040000 0x800>;
+          atmel,flexcom-mode = <2>;
+          microchip,flx-shrd-pins = <9>;
+          microchip,flx-cs = <0>;
+
+          spi3: spi@400 {
+                compatible = "atmel,at91rm9200-spi";
+                reg = <0x400 0x200>;
+                interrupts = <GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH>;
+                pinctrl-names = "default";
+                pinctrl-0 = <&pinctrl_flx3_default>;
+                #address-cells = <1>;
+                #size-cells = <0>;
+                clocks = <&nic_clk>;
+                clock-names = "spi_clk";
+                atmel,fifo-size = <32>;
+          };
+    };
 ...
-- 
2.17.1

