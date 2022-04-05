Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 393264F5171
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 04:39:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1846314AbiDFCDt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 22:03:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382383AbiDEMPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 08:15:04 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C39A4ADD50;
        Tue,  5 Apr 2022 04:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1649157928; x=1680693928;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tOaUSriU1H57ESN51UJOQjh5HKEr6uJn/O7752Nx9Qo=;
  b=M6SmSHtyOvJgVcen46RLQwrN2+7RxhgBkdWmj3EJcbyuT8srFPD2jpNx
   epJoOP0mZp+MThRbEtcuuq0lpOvM15z9EYqrOZkk98QWg3hioj5E0n+G4
   LcSMnViZkDXRAAIj8eeoo1vvRhcuufVSKJ0JPt2ehz0EGAojtbfJ6woU2
   HI38I6H2Re4alqgW3e0QfFnpjgnDYFYTQyDYZBpIbuy1tjsdD/PzYzqqL
   uALj/3rd7NS6Km/Cai6tZ67AOGeEBFZgBZsDYXb+5NmeEEAqWSUXYeTFx
   Ne6JvjxUxTDq2W8wkPLClgX3JzHSS1QuutjQdLaaTIa9sDags8bq/D/N/
   g==;
X-IronPort-AV: E=Sophos;i="5.90,236,1643698800"; 
   d="scan'208";a="168400151"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 05 Apr 2022 04:25:27 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 5 Apr 2022 04:25:27 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Tue, 5 Apr 2022 04:25:25 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <robh+dt@kernel.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <p.zabel@pengutronix.de>,
        <sre@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 2/8] dt-bindings: reset: convert Atmel/Microchip reset controller to YAML
Date:   Tue, 5 Apr 2022 14:27:18 +0300
Message-ID: <20220405112724.2760905-3-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220405112724.2760905-1-claudiu.beznea@microchip.com>
References: <20220405112724.2760905-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert Atmel/Microchip reset controller to YAML.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 .../devicetree/bindings/arm/atmel-sysregs.txt | 15 ------
 .../reset/atmel,at91sam9260-reset.yaml        | 49 +++++++++++++++++++
 2 files changed, 49 insertions(+), 15 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/reset/atmel,at91sam9260-reset.yaml

diff --git a/Documentation/devicetree/bindings/arm/atmel-sysregs.txt b/Documentation/devicetree/bindings/arm/atmel-sysregs.txt
index 16eef600d599..ab1b352344ae 100644
--- a/Documentation/devicetree/bindings/arm/atmel-sysregs.txt
+++ b/Documentation/devicetree/bindings/arm/atmel-sysregs.txt
@@ -25,21 +25,6 @@ System Timer (ST) required properties:
 Its subnodes can be:
 - watchdog: compatible should be "atmel,at91rm9200-wdt"
 
-RSTC Reset Controller required properties:
-- compatible: Should be "atmel,<chip>-rstc".
-  <chip> can be "at91sam9260", "at91sam9g45", "sama5d3" or "samx7"
-  it also can be "microchip,sam9x60-rstc"
-- reg: Should contain registers location and length
-- clocks: phandle to input clock.
-
-Example:
-
-	rstc@fffffd00 {
-		compatible = "atmel,at91sam9260-rstc";
-		reg = <0xfffffd00 0x10>;
-		clocks = <&clk32k>;
-	};
-
 RAMC SDRAM/DDR Controller required properties:
 - compatible: Should be "atmel,at91rm9200-sdramc", "syscon"
 			"atmel,at91sam9260-sdramc",
diff --git a/Documentation/devicetree/bindings/reset/atmel,at91sam9260-reset.yaml b/Documentation/devicetree/bindings/reset/atmel,at91sam9260-reset.yaml
new file mode 100644
index 000000000000..92936c987c9a
--- /dev/null
+++ b/Documentation/devicetree/bindings/reset/atmel,at91sam9260-reset.yaml
@@ -0,0 +1,49 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/reset/atmel,at91sam9260-reset.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Atmel/Microchip System Reset Controller
+
+maintainers:
+  - Claudiu Beznea <claudiu.beznea@gmail.com>
+
+description: |
+  The system reset controller can be used to reset the CPU.
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - atmel,at91sam9260-rstc
+              - atmel,at91sam9g45-rstc
+              - atmel,sama5d3-rstc
+              - microchip,sam9x60-rstc
+      - items:
+          - const: atmel,sama5d3-rstc
+          - const: atmel,at91sam9g45-rstc
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/at91.h>
+
+    reset-controller@fffffd00 {
+        compatible = "atmel,at91sam9260-rstc";
+        reg = <0xfffffd00 0x10>;
+        clocks = <&pmc PMC_TYPE_CORE PMC_SLOW>;
+    };
-- 
2.32.0

