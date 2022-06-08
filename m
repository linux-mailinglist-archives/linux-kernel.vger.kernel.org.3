Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A0BB542B27
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 11:17:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234339AbiFHJP5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 05:15:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235331AbiFHJOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 05:14:54 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CC3211CA3B;
        Wed,  8 Jun 2022 01:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1654677473; x=1686213473;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Kev+P78paN9tbrXLIiqlQVD/P4abR7ZSSL4PUqdVGDY=;
  b=ZB2Z0owi2Q7u4CUOVujJe5yHP57QixwNPn2y0iswkLtNYpkUxfAYj5SD
   aVjcdefuRbZseEdKsx/w6n3hX6cRoF3rJV8APWTjD4zfOH1qpk33XydF/
   CEaiDv9IbFPmTTJ2yu4mltTy26dUF26AoTj90tC9Op8jY7FXQdrL24US8
   Dedi6MLQ02iQ0nwCyw+bwUk2rq/pHttQQmzWC5ATn9nlD4zGCG7vwuzoY
   V91dF4oRwfjlB7wiUP3T2LBrJtJv5a8/1wTf96WAJVX0Dvc4VYFWcqWA6
   yHY7gkGcmmdbC4rB3XBQnxXmVe3do1OwAVJ9ydh1zeB5j3koBkPYazW7U
   g==;
X-IronPort-AV: E=Sophos;i="5.91,285,1647327600"; 
   d="scan'208";a="167235520"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 Jun 2022 01:37:53 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 8 Jun 2022 01:37:43 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Wed, 8 Jun 2022 01:37:40 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <p.zabel@pengutronix.de>, <sre@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v4 3/9] dt-bindings: reset: atmel,at91sam9260-reset: add sama7g5 bindings
Date:   Wed, 8 Jun 2022 11:39:36 +0300
Message-ID: <20220608083942.1584087-4-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220608083942.1584087-1-claudiu.beznea@microchip.com>
References: <20220608083942.1584087-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Add documentation for SAMA7G5 reset controller. Compared with previous
versions of reset controllers this one contains support for resetting
in SoC devices (e.g. USB PHYs).

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../reset/atmel,at91sam9260-reset.yaml        | 23 +++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/reset/atmel,at91sam9260-reset.yaml b/Documentation/devicetree/bindings/reset/atmel,at91sam9260-reset.yaml
index 34c40b875e20..98465d26949e 100644
--- a/Documentation/devicetree/bindings/reset/atmel,at91sam9260-reset.yaml
+++ b/Documentation/devicetree/bindings/reset/atmel,at91sam9260-reset.yaml
@@ -10,7 +10,8 @@ maintainers:
   - Claudiu Beznea <claudiu.beznea@microchip.com>
 
 description: |
-  The system reset controller can be used to reset the CPU.
+  The system reset controller can be used to reset the CPU. In case of
+  SAMA7G5 it can also reset some devices (e.g. USB PHYs).
 
 properties:
   compatible:
@@ -21,21 +22,39 @@ properties:
               - atmel,at91sam9g45-rstc
               - atmel,sama5d3-rstc
               - microchip,sam9x60-rstc
+              - microchip,sama7g5-rstc
       - items:
           - const: atmel,sama5d3-rstc
           - const: atmel,at91sam9g45-rstc
 
   reg:
-    maxItems: 1
+    minItems: 1
+    items:
+      - description: base registers for system reset control
+      - description: registers for device specific reset control
 
   clocks:
     maxItems: 1
 
+  "#reset-cells":
+    const: 1
+
 required:
   - compatible
   - reg
   - clocks
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - microchip,sama7g5-rstc
+    then:
+      required:
+        - "#reset-cells"
+
 additionalProperties: false
 
 examples:
-- 
2.33.0

