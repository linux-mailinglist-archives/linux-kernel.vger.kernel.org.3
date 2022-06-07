Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 766A25401BC
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 16:48:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343551AbiFGOsR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 10:48:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343528AbiFGOsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 10:48:03 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45DADE13;
        Tue,  7 Jun 2022 07:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1654613281; x=1686149281;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=BumBO/IsRtrUbJDzsCtef24MGXE+RwhQ8uH1bDcJSgY=;
  b=y6BvbSciNzjeY1Bwl0Dbu0x4CpTsU+0d7I+68XzLiRdNU90LOmxT22Ba
   kEXnYRvk5aNXGVSYCjch/5ivpzJOaNur5j/Fu502DP98F5Iu/R4bllgVF
   u4xLiONJOeVMB+xYAXmNM51blTM4LEskCRl1ex0rxh78L6QYmwRqo4HIW
   vMhTz/gL/T8sQAARDwKXTQBoMGGqj0MGP0n2dCXH/n1AbpXT6RnMMMIsF
   E5GW/ybtICl7RFkME0sOrsVS9zSe6iKvGQNL3Z8GbL4N0Q4B9Ytn6zCLx
   JiCBxk4fGffkx2dN2kUwG/7mv11jNInzullJP6tmMJZoZxRGNXk7SaY3Q
   A==;
X-IronPort-AV: E=Sophos;i="5.91,284,1647327600"; 
   d="scan'208";a="162250862"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Jun 2022 07:48:00 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 7 Jun 2022 07:47:59 -0700
Received: from kavya-HP-Compaq-6000-Pro-SFF-PC.microchip.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Tue, 7 Jun 2022 07:47:56 -0700
From:   Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
To:     <krzysztof.kozlowski+dt@linaro.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <claudiu.beznea@microchip.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kavyasree.kotagiri@microchip.com>,
        <UNGLinuxDriver@microchip.com>
Subject: [PATCH v2 2/3] dt-bindings: mfd: atmel,flexcom: Add new compatible string for lan966x
Date:   Tue, 7 Jun 2022 20:17:39 +0530
Message-ID: <20220607144740.14937-3-kavyasree.kotagiri@microchip.com>
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

LAN966x SoC flexcoms has two optional I/O lines. Namely, CS0 and CS1
in flexcom SPI mode. CTS and RTS in flexcom USART mode. These pins
can be mapped to lan966x FLEXCOM_SHARED[0-20] pins and usage depends on
functions being configured.

Signed-off-by: Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
---
v1 -> v2:
 - Use allOf:if:then for lan966x dt properties

 .../bindings/mfd/atmel,flexcom.yaml           | 39 ++++++++++++++++++-
 1 file changed, 38 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mfd/atmel,flexcom.yaml b/Documentation/devicetree/bindings/mfd/atmel,flexcom.yaml
index 05cb6ebb4b2a..2d357217fe22 100644
--- a/Documentation/devicetree/bindings/mfd/atmel,flexcom.yaml
+++ b/Documentation/devicetree/bindings/mfd/atmel,flexcom.yaml
@@ -16,7 +16,9 @@ description:
 
 properties:
   compatible:
-    const: atmel,sama5d2-flexcom
+    enum:
+      - atmel,sama5d2-flexcom
+      - microchip,lan966x-flexcom
 
   reg:
     maxItems: 1
@@ -46,6 +48,27 @@ properties:
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
@@ -68,6 +91,18 @@ required:
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
+      required:
+        - microchip,flx-shrd-pins
+        - microchip,flx-cs
+
 additionalProperties: false
 
 examples:
@@ -80,6 +115,8 @@ examples:
           #size-cells = <1>;
           ranges = <0x0 0xf8034000 0x800>;
           atmel,flexcom-mode = <2>;
+          microchip,flx-shrd-pins = <9>;
+          microchip,flx-cs = <0>;
 
           spi0: spi@400 {
                 compatible = "atmel,at91rm9200-spi";
-- 
2.17.1

