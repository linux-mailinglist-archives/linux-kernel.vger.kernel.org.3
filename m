Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BCA0596ABF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 10:04:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233912AbiHQIDg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 04:03:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233768AbiHQIDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 04:03:21 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A00FF13E06;
        Wed, 17 Aug 2022 01:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1660723401; x=1692259401;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5buFzwPMC/DKOL4yIcX4XKWfDIQhrT8qWoyq3H5eISU=;
  b=uXonc+CGCy8tJnh5prUS1f2BjqsHLPD9Ya6Ux1JiYeBTzTPrdO7WmY/V
   1KsLa911n5yTGmU0Kk4FvKVO5ZdV/fsgkmkrU5DMFVFqkPaTy/x6izaod
   JuJYHImplUWEHajmoB7t6Lx9Yk9Xc2vZRonUreRuaFonRAlP42IMFbac+
   p91bMtZb77bMZVVtPpjGSJhpyeNPZb7t/H1kgMO3C64oDaxf35dztjquy
   5RWqOdYaa0qwlYF/IKDRvI3S3E78/fRH2/yEniKV+jXjUHTlqrwi12Jsq
   njWr9ju3xsOdOZFrnCu3cfAVR1Do1P2k+DpLVe1IbBNxYh/Ys6fIcBLr1
   g==;
X-IronPort-AV: E=Sophos;i="5.93,242,1654585200"; 
   d="scan'208";a="169648943"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 Aug 2022 01:03:20 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Wed, 17 Aug 2022 01:03:18 -0700
Received: from ROB-ULT-M68701.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Wed, 17 Aug 2022 01:03:13 -0700
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
Subject: [PATCH 3/5] dt-bindings: mfd: atmel,sama5d2-flexcom: Add USART child node ref binding
Date:   Wed, 17 Aug 2022 10:55:16 +0300
Message-ID: <20220817075517.49575-4-sergiu.moga@microchip.com>
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

FLEXCOM, among other functionalities, has the ability to offer the USART
serial communication protocol. To have the FLEXCOM binding properly
validate its USART children nodes, we must reference the correct binding.
To differentiate between the SPI of FLEXCOM and the SPI of USART in SPI
mode, use the clock-names property, since the latter's respective
property is supposed to contain the "usart" string.

Signed-off-by: Sergiu Moga <sergiu.moga@microchip.com>
---
 .../bindings/mfd/atmel,sama5d2-flexcom.yaml       | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/atmel,sama5d2-flexcom.yaml b/Documentation/devicetree/bindings/mfd/atmel,sama5d2-flexcom.yaml
index e158af47c326..617331a5e66e 100644
--- a/Documentation/devicetree/bindings/mfd/atmel,sama5d2-flexcom.yaml
+++ b/Documentation/devicetree/bindings/mfd/atmel,sama5d2-flexcom.yaml
@@ -72,13 +72,20 @@ properties:
 
 patternProperties:
   "^serial@[0-9a-f]+$":
-    type: object
+    $ref: atmel,at91-usart.yaml
     description:
-      Child node describing USART. See atmel-usart.txt for details
-      of USART bindings.
+      Child node describing USART.
 
   "^spi@[0-9a-f]+$":
-    $ref: ../spi/atmel,at91rm9200-spi.yaml
+    if:
+      properties:
+        clock-names:
+          contains:
+            const: usart
+    then:
+      $ref: atmel,at91-usart.yaml
+    else:
+      $ref: ../spi/atmel,at91rm9200-spi.yaml
     description:
       Child node describing SPI.
 
-- 
2.25.1

