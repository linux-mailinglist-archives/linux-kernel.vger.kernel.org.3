Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A3C35AEDA1
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 16:50:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234762AbiIFOrI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 10:47:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231342AbiIFOqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 10:46:42 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65DDD98A51;
        Tue,  6 Sep 2022 07:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1662473126; x=1694009126;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sPvmXHZOZTxiNsV8wQo2cqTLQ91qkb2yzTXY3QfEQ3U=;
  b=ljYQYc+SvScQBoglQ4NCQuG93fnqmL48wjxSOWHlyPfKS7AqkIcurUCh
   rndVYmIgq0XaOr+zZBRb/nkXlxvmUEnZFHhFC0hNkjFfOe4AwvwEs0De1
   8HcmqYjkbx5+rSLf95WC7hWwsug8Xjlim4IbRn/1q/qfsWkQPhRpd0drP
   r265D/Y1cewcqSpSadrUbPe5DGANh7wCgCGcPN4ozA2fZXs4IqvkcNW8n
   6xumx27Pg//QXzW8zJNWKB9D/LHTXXRQCWy9OL3Uapr9ffXS4do2UFxpb
   +uzYFL4U5fcHUZalFHk8BQAu7qTGlIHKnTyBSXLWXIaZIDpn2Hpaqn0dS
   w==;
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="179223615"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 Sep 2022 06:57:12 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Tue, 6 Sep 2022 06:57:10 -0700
Received: from ROB-ULT-M68701.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Tue, 6 Sep 2022 06:57:05 -0700
From:   Sergiu Moga <sergiu.moga@microchip.com>
To:     <lee@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <claudiu.beznea@microchip.com>,
        <richard.genoud@gmail.com>, <radu_nicolae.pirea@upb.ro>,
        <gregkh@linuxfoundation.org>, <broonie@kernel.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <jirislaby@kernel.org>, <admin@hifiphile.com>,
        <sergiu.moga@microchip.com>, <kavyasree.kotagiri@microchip.com>,
        <tudor.ambarus@microchip.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-serial@vger.kernel.org>, <linux-clk@vger.kernel.org>
Subject: [PATCH v2 07/13] dt-bindings: mfd: atmel,sama5d2-flexcom: Add USART child node ref binding
Date:   Tue, 6 Sep 2022 16:55:06 +0300
Message-ID: <20220906135511.144725-8-sergiu.moga@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220906135511.144725-1-sergiu.moga@microchip.com>
References: <20220906135511.144725-1-sergiu.moga@microchip.com>
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

FLEXCOM, among other functionalities, has the ability to offer the USART
serial communication protocol. To have the FLEXCOM binding properly
validate its USART children nodes, we must reference the correct binding.
To differentiate between the SPI of FLEXCOM and the SPI of USART in SPI
mode, use the clock-names property, since the latter's respective
property is supposed to contain the "usart" string.

Signed-off-by: Sergiu Moga <sergiu.moga@microchip.com>
---


v1 -> v2:
- Nothing



 .../bindings/mfd/atmel,sama5d2-flexcom.yaml      | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/atmel,sama5d2-flexcom.yaml b/Documentation/devicetree/bindings/mfd/atmel,sama5d2-flexcom.yaml
index 0db0f2728b65..b5fb509f07ec 100644
--- a/Documentation/devicetree/bindings/mfd/atmel,sama5d2-flexcom.yaml
+++ b/Documentation/devicetree/bindings/mfd/atmel,sama5d2-flexcom.yaml
@@ -72,13 +72,21 @@ properties:
 
 patternProperties:
   "^serial@[0-9a-f]+$":
-    type: object
+    $ref: /schemas/serial/atmel,at91-usart.yaml
     description:
-      Child node describing USART. See atmel-usart.txt for details
-      of USART bindings.
+      Child node describing USART.
 
   "^spi@[0-9a-f]+$":
-    $ref: /schemas/spi/atmel,at91rm9200-spi.yaml
+    allOf:
+      - if:
+          properties:
+            clock-names:
+              contains:
+                const: usart
+        then:
+          $ref: /schemas/serial/atmel,at91-usart.yaml
+        else:
+          $ref: /schemas/spi/atmel,at91rm9200-spi.yaml
     description:
       Child node describing SPI.
 
-- 
2.25.1

