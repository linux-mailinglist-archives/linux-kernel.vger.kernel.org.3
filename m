Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F8ED551FC8
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 17:08:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242481AbiFTPH7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 11:07:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242843AbiFTPHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 11:07:31 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB4E02CDF6;
        Mon, 20 Jun 2022 07:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1655736412; x=1687272412;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=Ztl+/pAQ+ikjdJod2vaRhfIL+QLqoqn75Iz55UJscWY=;
  b=bVNEL1yVBSqqSvnYxfhGBzc+3t/xbF4i5r2kUqCQqgC8Hsudmm02Y8R7
   zDWvqd2Y758VTE1WENouJ/paCRhLMYV4lZgbfaI61QdVclTVTuai3S76R
   LPkK6L68q8DSB1YFo7/nOkehqEnFsZixWxsQsATOyESnTkjW91RKcNRSu
   BB9sPCzIsCoMykOHmr6P0kznouMI/F7sJtcn3umoYRka+2vHiIk4mudPf
   As6acevgQ6FEjKA+JRFcp/CmV6RV1LImwPGWU5z1L4S5i2h+N5/+Y5mcb
   5lDStx++CEEewmbD2PJltwSgUt5SQ8KKEN+U/vmJShXQ7/RJ7nBNMM7Zc
   A==;
X-IronPort-AV: E=Sophos;i="5.92,207,1650956400"; 
   d="scan'208";a="164185817"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 Jun 2022 07:46:52 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 20 Jun 2022 07:46:51 -0700
Received: from kavya-HP-Compaq-6000-Pro-SFF-PC.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Mon, 20 Jun 2022 07:46:47 -0700
From:   Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
To:     <krzysztof.kozlowski@linaro.org>, <robh+dt@kernel.org>,
        <Nicolas.Ferre@microchip.com>, <Claudiu.Beznea@microchip.com>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <UNGLinuxDriver@microchip.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 2/3] dt-bindings: mfd: atmel,flexcom: Add new compatible string for lan966x
Date:   Mon, 20 Jun 2022 20:16:33 +0530
Message-ID: <20220620144634.25464-3-kavyasree.kotagiri@microchip.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220620144634.25464-1-kavyasree.kotagiri@microchip.com>
References: <20220620144634.25464-1-kavyasree.kotagiri@microchip.com>
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

LAN966x SoC flexcoms has two optional I/O lines. Namely, CS0 and CS1
in flexcom SPI mode. CTS and RTS in flexcom USART mode. These pins
can be mapped to lan966x FLEXCOM_SHARED[0-20] pins and usage depends on
functions being configured.

Signed-off-by: Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
---
v4 -> v5:
 - Fixed indentations and dt-schema errors.
 - No errors seen with 'make dt_binding_check'.

v3 -> v4:
 - Added else condition to allOf:if:then.

v2 -> v3:
 - Add reg property of lan966x missed in v2.

v1 -> v2:
 - Use allOf:if:then for lan966x dt properties

 .../bindings/mfd/atmel,flexcom.yaml           | 78 ++++++++++++++++++-
 1 file changed, 77 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mfd/atmel,flexcom.yaml b/Documentation/devicetree/bindings/mfd/atmel,flexcom.yaml
index fc5af946b568..216d08b44bb3 100644
--- a/Documentation/devicetree/bindings/mfd/atmel,flexcom.yaml
+++ b/Documentation/devicetree/bindings/mfd/atmel,flexcom.yaml
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
 patternProperties:
   "^serial@[0-9a-f]+$":
     description: See atmel-usart.txt for details of USART bindings.
@@ -73,6 +96,31 @@ required:
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
@@ -101,4 +149,32 @@ examples:
             atmel,fifo-size = <32>;
         };
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
+
+        spi3: spi@400 {
+            compatible = "atmel,at91rm9200-spi";
+            reg = <0x400 0x200>;
+            interrupts = <GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH>;
+            pinctrl-names = "default";
+            pinctrl-0 = <&pinctrl_flx3_default>;
+            #address-cells = <1>;
+            #size-cells = <0>;
+            clocks = <&nic_clk>;
+            clock-names = "spi_clk";
+            atmel,fifo-size = <32>;
+        };
+    };
 ...
-- 
2.17.1

