Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9D0653C9DB
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 14:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244305AbiFCMTT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 08:19:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbiFCMTP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 08:19:15 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EACD26AE1;
        Fri,  3 Jun 2022 05:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1654258756; x=1685794756;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=uYE4zsL0RT5NW/SsDoQ5iLL0iUpJOYqdz3oM4lE7dQA=;
  b=q23d1uetmrVv7hOmocTrRZLFcQvJA+IpFc/t0ODFZyJq/pCzetJIjP2d
   byChKX/JG16h+1qcZxUHFNI0fbprgp70OcJ+4+jmgW0WWHxKSa+bVCTDz
   yI3W+Jm933U6icyfBkAIv/NIrt/6tgpcSGCTuQvWIQxsnuIHPRD1gqexl
   E2X3jl//oYl8Mz8uciwG6m36bV0Bzo6UqIbm/rZ8DVO5uj8/6FNolRedR
   bg2/JsgRapEOAMXHi2oQSBtEhewwWnxe8BfEG2WP6BfZgpqf74BnCwieA
   Oi29pamaa+8hU7ZzYndNaf3JAQNc51lGj/03UxfctLzTHq8z2Q6C61isl
   g==;
X-IronPort-AV: E=Sophos;i="5.91,274,1647327600"; 
   d="scan'208";a="166634006"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 03 Jun 2022 05:19:15 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 3 Jun 2022 05:19:14 -0700
Received: from kavya-HP-Compaq-6000-Pro-SFF-PC.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Fri, 3 Jun 2022 05:19:11 -0700
From:   Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
To:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <claudiu.beznea@microchip.com>, <UNGLinuxDriver@microchip.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Kavyasree.Kotagiri@microchip.com>
Subject: [PATCH 2/3] dt-bindings: mfd: atmel,flexcom: Add new compatible string for lan966x
Date:   Fri, 3 Jun 2022 17:48:01 +0530
Message-ID: <20220603121802.30320-3-kavyasree.kotagiri@microchip.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220603121802.30320-1-kavyasree.kotagiri@microchip.com>
References: <20220603121802.30320-1-kavyasree.kotagiri@microchip.com>
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

LAN966x SoC flexcoms has two optional I/O lines. Namely, CS0 and CS1 in
flexcom SPI mode. CTS and RTS in flexcom USART mode. These pins
can be mapped to lan966x FLEXCOM_SHARED[0-20] pins and usage depends on
functions being configured.

Signed-off-by: Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
---
 .../bindings/mfd/atmel,flexcom.yaml           | 21 ++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mfd/atmel,flexcom.yaml b/Documentation/devicetree/bindings/mfd/atmel,flexcom.yaml
index 221bd840b49e..6050482ad8ef 100644
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
@@ -46,6 +48,21 @@ properties:
     $ref: /schemas/types.yaml#/definitions/uint32
     enum: [1, 2, 3]
 
+  microchip,flx-shrd-pins:
+    description: Specify the Flexcom shared pins to be used for flexcom
+      chip-selects.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0
+    maximum: 20
+
+  microchip,flx-cs-names:
+    description: Chip select names. "cts", "rts" for flexcom USART "CTS" and
+      "RTS" lines. "cs0", "cs1" for flexcom SPI chip-select lines.
+    items:
+      enum: [ cs0, cs1, cts, rts ]
+    minItems: 1
+    maxItems: 2
+
 patternProperties:
   "^serial@[0-9a-f]+$":
     description: See atmel-usart.txt for details of USART bindings.
@@ -80,6 +97,8 @@ examples:
           #size-cells = <1>;
           ranges = <0x0 0xf8034000 0x800>;
           atmel,flexcom-mode = <2>;
+          microchip,flx-shrd-pins = <9>;
+          microchip,flx-cs-names = "cs0";
 
           spi0: spi@400 {
                 compatible = "atmel,at91rm9200-spi";
-- 
2.17.1

