Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47D264F7723
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 09:17:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241660AbiDGHR0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 03:17:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241592AbiDGHRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 03:17:13 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9363513CCE0;
        Thu,  7 Apr 2022 00:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1649315707; x=1680851707;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WJKyd+Fl6YLBO12mh2a443xCDWtg4F7sbnlIRNccMxc=;
  b=QztF9g1o4xmnxnWnRIDq3QjZkCBqfgCq2vE+DNQlf1igqJALyA81sJ5G
   h3o+vMYVv+bEPKwLnSul63+eH8+qSKUFqFVS00wwXseKOHqISOdgHtKG3
   vt4c3mpzCQdIwWZfRDK/U2Jg/7q2O1EPhlf4ax78YejM1B9YV3oDDu24a
   kxIS09W5ma4Gcp70T24Id6bnCa19fBrZErfOkOXzT2uaVlZCSZzzUleqJ
   j9L5BO/7L1iPQuUcFZUq/QY0wwvg7MyRp7DsDQLjvwOsLS54BZ26QAdwK
   uP7467n1unC2j0uWHeBhdl5VpdmMbQ7WuA3/luBsKIHuyZd2DKWX+PJT5
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,241,1643698800"; 
   d="scan'208";a="151841342"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Apr 2022 00:15:07 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 7 Apr 2022 00:15:05 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Thu, 7 Apr 2022 00:15:02 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <robh+dt@kernel.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <p.zabel@pengutronix.de>,
        <linux@armlinux.org.uk>, <sre@kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v2 02/10] dt-bindings: reset: convert Atmel/Microchip reset controller to YAML
Date:   Thu, 7 Apr 2022 10:17:00 +0300
Message-ID: <20220407071708.3848812-3-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220407071708.3848812-1-claudiu.beznea@microchip.com>
References: <20220407071708.3848812-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert Atmel/Microchip reset controller to YAML.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
Reviewed-by: Rob Herring <robh@kernel.org>
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
index 000000000000..34c40b875e20
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
+  - Claudiu Beznea <claudiu.beznea@microchip.com>
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

