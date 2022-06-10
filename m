Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CB7E5461F9
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 11:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349077AbiFJJYh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 05:24:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349665AbiFJJYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 05:24:10 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74DD813C4F5;
        Fri, 10 Jun 2022 02:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1654852951; x=1686388951;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pW3FSQGIDTfSnLPnhufJ8V9RbufjCJBXkfyPvNp1q1M=;
  b=J26DiFt2xh7JxcQ8V4UEo85mdofjEEBOlJ/aGqw5JGzCn+IuCKo6Zdkg
   SBsBCYsNC/JLZWMsPwZCyLUNnP+LsUkdnxY0Ee6oiRj7r9YBzxxjGrboB
   99AJgyyUvXg/y2SfIArWm/U8qSzckT/RSiX/i5AiXT4HQkB668CrGG01D
   4uDz0diTtJ/9wV50WGFedlHqtIva0tMthA4u+iyzt/8CaxkKZxBQJIFFi
   TdK3vVglNybFMdGJY0uQsh5cl2db8rQn6ps6BLO34uXN9+u74J1Rf/uM+
   SKLrDYDFQ0QGxYncdQwRTGfP8Fsg6Vbn/QIOS7TKTwuYFi1v9vpvuT5uY
   Q==;
X-IronPort-AV: E=Sophos;i="5.91,288,1647327600"; 
   d="scan'208";a="159728328"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 10 Jun 2022 02:22:30 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 10 Jun 2022 02:22:29 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Fri, 10 Jun 2022 02:22:25 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <p.zabel@pengutronix.de>, <sre@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v5 3/9] dt-bindings: reset: atmel,at91sam9260-reset: add sama7g5 bindings
Date:   Fri, 10 Jun 2022 12:24:08 +0300
Message-ID: <20220610092414.1816571-4-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220610092414.1816571-1-claudiu.beznea@microchip.com>
References: <20220610092414.1816571-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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
2.34.1

