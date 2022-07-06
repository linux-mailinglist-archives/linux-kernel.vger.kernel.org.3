Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDE2656865D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 13:07:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232755AbiGFLHJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 07:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232468AbiGFLHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 07:07:07 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87A2624BFA;
        Wed,  6 Jul 2022 04:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1657105626; x=1688641626;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=d6++wd2M1ULC9f+tZJMZhP48bnLFY5Pba7B8hjFDzyc=;
  b=mOUATT2Y48rSXCW9v4bwUghZbRZS9j6knTKHDtA7ayZ/S7cv7KDw/fev
   lt16s6Ou86Y2/3O8DgwTcmYGq8NyF4RJexZdqwPXgvBjeNAAwWfZkEqlk
   g/SkJkny5LOyk2U1Q/9yxnlVS0HQWbdB7dUYx1hkHLUTD1Gohlg3rWQ63
   W2Pi8ndoPWgDsli1umhIvOFprByQM+SwQJVW0S5r+x8nWKePcHzG6Ua2f
   Jp5cHuQSX2q10LKOBMxELXsJs7OBAd5mrLA8lyMnUHDnIHz36wSJu6Eyy
   2Hlu/7X42ZQapmrsi8gd5a5x7O4kxxYFQ+znhXHov7e2qb1wvXQ1A4Ra5
   Q==;
X-IronPort-AV: E=Sophos;i="5.92,249,1650956400"; 
   d="scan'208";a="103261638"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 Jul 2022 04:06:55 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 6 Jul 2022 04:06:54 -0700
Received: from kavya.microchip.com (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Wed, 6 Jul 2022 04:06:50 -0700
From:   Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
To:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <claudiu.beznea@microchip.com>, <UNGLinuxDriver@microchip.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Kavyasree.Kotagiri@microchip.com>
Subject: [PATCH v7 2/3] dt-bindings: mfd: atmel,sama5d2-flexcom: Add new compatible string for lan966x
Date:   Wed, 6 Jul 2022 09:06:18 -0200
Message-ID: <20220706110619.71729-3-kavyasree.kotagiri@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220706110619.71729-1-kavyasree.kotagiri@microchip.com>
References: <20220706110619.71729-1-kavyasree.kotagiri@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
index 864f490ffb83..b4b47accab49 100644
--- a/Documentation/devicetree/bindings/mfd/atmel,sama5d2-flexcom.yaml
+++ b/Documentation/devicetree/bindings/mfd/atmel,sama5d2-flexcom.yaml
@@ -18,9 +18,11 @@ properties:
   compatible:
     enum:
       - atmel,sama5d2-flexcom
+      - microchip,lan966x-flexcom
 
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
 required:
   - compatible
   - reg
@@ -56,6 +79,31 @@ required:
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
@@ -71,4 +119,19 @@ examples:
         ranges = <0x0 0xf8034000 0x800>;
         atmel,flexcom-mode = <2>;
     };
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    flx3: flexcom@e0064000 {
+        compatible = "microchip,lan966x-flexcom";
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

