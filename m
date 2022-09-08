Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA1815B2193
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 17:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232820AbiIHPHt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 11:07:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232827AbiIHPHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 11:07:44 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 401ADE7FAF;
        Thu,  8 Sep 2022 08:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1662649664; x=1694185664;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wcMp5G/5WwDZAxR6f5X4zZUNJBLSLYT1KZbBKjlrX14=;
  b=DHjxFx6CK/6i86WNzR5lOXmOA2c6IvseK1wd081gYy6Btj2kQC2SczOm
   619SNpysoWmkr70DWkbRKX1dluEYZgAi+GitkstmtzlHyzzk66TLyZuKw
   0VXFMIfxW/s8oZLPoDjxMkVpGd6H4npnfeBEm52p483fKpsd7jAhpo75Z
   1hZK0gWHG0552JSXcUXz+LEG9jI9gqnYUqA22P7LozQh4RDow7TjcxkpI
   A1BxOK/5U+mgPO1QKlHzUr1IDHp4NS68fJt5usZv3WxqoDS/sE36VN02V
   rxGkHgVMIe965OqiX9CkyvdsEdiL9WeIRoA+73DhEcTNgIWn1sfXbq0lz
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,300,1654585200"; 
   d="scan'208";a="179588439"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 Sep 2022 08:07:44 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Thu, 8 Sep 2022 08:07:27 -0700
Received: from kavya.microchip.com (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.12 via Frontend
 Transport; Thu, 8 Sep 2022 08:07:24 -0700
From:   Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
To:     <lee@kernel.org>
CC:     <nicolas.ferre@microchip.com>, <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <UNGLinuxDriver@microchip.com>,
        <krzysztof.kozlowski+dt@linaro.org>, <claudiu.beznea@microchip.com>
Subject: [RESEND PATCH v9 2/3] dt-bindings: mfd: atmel,sama5d2-flexcom: Add new compatible string for lan966x
Date:   Thu, 8 Sep 2022 13:06:57 -0200
Message-ID: <20220908150658.1839520-3-kavyasree.kotagiri@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220908150658.1839520-1-kavyasree.kotagiri@microchip.com>
References: <20220908150658.1839520-1-kavyasree.kotagiri@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
v8 -> v9:
 - No changes.

v7 -> v8:
 - Changed compatible string to microchip,lan9668-flexcom.

v6 -> v7:
 - Add #address-cells, #size-cells to flx3 example.

v5 -> v6:
 - Removed spi node from flx3 example.

v4 -> v5:
 - Fixed indentations and dt-schema errors.
 - No errors seen with 'make dt_binding_check'.

v3 -> v4:
 - Added else condition to allOf:if:then.

v2 -> v3:
 - Add reg property of lan966x missed in v2.

v1 -> v2:
 - Use allOf:if:then for lan966x dt properties

 .../bindings/mfd/atmel,sama5d2-flexcom.yaml   | 65 ++++++++++++++++++-
 1 file changed, 64 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mfd/atmel,sama5d2-flexcom.yaml b/Documentation/devicetree/bindings/mfd/atmel,sama5d2-flexcom.yaml
index 63849dacefb8..e158af47c326 100644
--- a/Documentation/devicetree/bindings/mfd/atmel,sama5d2-flexcom.yaml
+++ b/Documentation/devicetree/bindings/mfd/atmel,sama5d2-flexcom.yaml
@@ -18,9 +18,11 @@ properties:
   compatible:
     enum:
       - atmel,sama5d2-flexcom
+      - microchip,lan9668-flexcom
 
   reg:
-    maxItems: 1
+    minItems: 1
+    maxItems: 2
 
   clocks:
     maxItems: 1
@@ -47,6 +49,27 @@ properties:
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
     type: object
@@ -73,6 +96,31 @@ required:
   - ranges
   - atmel,flexcom-mode
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: microchip,lan9668-flexcom
+
+    then:
+      properties:
+        reg:
+          items:
+            - description: Flexcom base registers map
+            - description: Flexcom shared registers map
+      required:
+        - microchip,flx-shrd-pins
+        - microchip,flx-cs
+
+    else:
+      properties:
+        reg:
+          items:
+            - description: Flexcom base registers map
+        microchip,flx-shrd-pins: false
+        microchip,flx-cs: false
+
 additionalProperties: false
 
 examples:
@@ -88,4 +136,19 @@ examples:
         ranges = <0x0 0xf8034000 0x800>;
         atmel,flexcom-mode = <2>;
     };
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    flx3: flexcom@e0064000 {
+        compatible = "microchip,lan9668-flexcom";
+        reg = <0xe0064000 0x100>,
+              <0xe2004180 0x8>;
+        clocks = <&flx0_clk>;
+        #address-cells = <1>;
+        #size-cells = <1>;
+        ranges = <0x0 0xe0040000 0x800>;
+        atmel,flexcom-mode = <2>;
+        microchip,flx-shrd-pins = <9>;
+        microchip,flx-cs = <0>;
+    };
 ...
-- 
2.25.1

