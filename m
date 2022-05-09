Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54A1E51F771
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 11:12:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235599AbiEII5O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 04:57:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232093AbiEIIxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 04:53:47 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F6DA248E0;
        Mon,  9 May 2022 01:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1652086195; x=1683622195;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=n8bFpjbKPYvw3e9bni1/T6bQ+4R6TyrCTJBZUgNett4=;
  b=DJbo119jsIT9ILlPUqLtxyaharrZlZM9b82hjGBbBVXKRmCAVkKigxKq
   PrG894/dqrNNZq+kImyQ0sDZnEj/GeDqVSZ0LaPbzCrnsdobYaQ6v2aWs
   84spgHeaowncODVVSjnoj847puOk1cQKcJepr0T4FAZTtCZH8mTrlic1W
   SEVxG9S4I0f2Rtvtt431cB/Xonjv2ZHJYttzSE4FfPwZpcOgPe5cD+n1k
   M3L/42eFa868U5udhPKj66WRZ7bnhOk91IcXDwW65TzBECTzbnpzOVdtp
   9GEwLWVO5R1/odEzJGDJWUax8kvZuNfhJ8yWPa6wBFuOBztxq1tOFKDSo
   g==;
X-IronPort-AV: E=Sophos;i="5.91,210,1647327600"; 
   d="scan'208";a="162812532"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 May 2022 01:49:44 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 9 May 2022 01:49:42 -0700
Received: from kavya-HP-Compaq-6000-Pro-SFF-PC.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Mon, 9 May 2022 01:49:37 -0700
From:   Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
To:     <krzysztof.kozlowski+dt@linaro.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <claudiu.beznea@microchip.com>,
        <peda@axentia.se>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <lee.jones@linaro.org>,
        <linux@armlinux.org.uk>, <Manohar.Puri@microchip.com>,
        <Kavyasree.Kotagiri@microchip.com>, <UNGLinuxDriver@microchip.com>
Subject: [PATCH v2 2/4] dt-bindings: mfd: atmel,flexcom: Add lan966 compatible string and mux properties
Date:   Mon, 9 May 2022 14:19:18 +0530
Message-ID: <20220509084920.14529-3-kavyasree.kotagiri@microchip.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220509084920.14529-1-kavyasree.kotagiri@microchip.com>
References: <20220509084920.14529-1-kavyasree.kotagiri@microchip.com>
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

Add lan966 flexcom compatible string and flexcom mux
device tree properties.

Signed-off-by: Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
---
 .../bindings/mfd/atmel,flexcom.yaml           | 52 ++++++++++++++++++-
 1 file changed, 51 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mfd/atmel,flexcom.yaml b/Documentation/devicetree/bindings/mfd/atmel,flexcom.yaml
index 79ec7ebc7055..228c095c84ca 100644
--- a/Documentation/devicetree/bindings/mfd/atmel,flexcom.yaml
+++ b/Documentation/devicetree/bindings/mfd/atmel,flexcom.yaml
@@ -16,7 +16,9 @@ description:
 
 properties:
   compatible:
-    const: atmel,sama5d2-flexcom
+    enum:
+      - atmel,sama5d2-flexcom
+      - microchip,lan966-flexcom
 
   reg:
     maxItems: 1
@@ -57,6 +59,27 @@ required:
 
 additionalProperties: false
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: microchip,lan966-flexcom
+
+    then:
+      properties:
+        mux-controls:
+          minItems: 1
+          maxItems: 2
+          $ref: /schemas/types.yaml#/definitions/phandle-array
+
+        mux-control-names:
+          minItems: 1
+          $ref: ../mux/mux-consumer.yaml
+          items:
+            - const: cs0
+            - const: cs1
+
 patternProperties:
   "^serial@[0-9a-f]+$":
     description: See atmel-usart.txt for details of USART bindings.
@@ -89,4 +112,31 @@ examples:
                 atmel,fifo-size = <32>;
           };
     };
+
+  - |
+    flx3: flexcom@e0064000 {
+          compatible = "microchip,lan966-flexcom";
+          reg = <0xe0064000 0x100>;
+          clocks = <&fabric_clk>;
+          #address-cells = <1>;
+          #size-cells = <1>;
+          ranges = <0x0 0xe0064000 0x800>;
+          atmel,flexcom-mode = <2>;
+          mux-controls = <&mux 0>;
+          mux-control-names = "cs0";
+
+          spi3: spi@400 {
+                compatible = "atmel,at91rm9200-spi";
+                reg = <0x400 0x200>;
+                interrupts = <0 51 4>;
+                #address-cells = <1>;
+                #size-cells = <0>;
+                clocks = <&fabric_clk>;
+                clock-names = "spi_clk";
+                pinctrl-0 = <&fc3_b_sck_pins>, <&fc3_b_rxd_pins>,
+                            <&fc3_b_txd_pins>, <&fc_shrd9_pins>;
+                pinctrl-names = "default";
+                atmel,fifo-size = <32>;
+          };
+    };
 ...
-- 
2.17.1

