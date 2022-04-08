Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A82FD4F9006
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 09:58:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbiDHIAl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 04:00:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbiDHIA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 04:00:27 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC461169797;
        Fri,  8 Apr 2022 00:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1649404705; x=1680940705;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WJKyd+Fl6YLBO12mh2a443xCDWtg4F7sbnlIRNccMxc=;
  b=h4up6pMraM4eGneg+TxCKOg+pCZdjdfZ3yJWSQ89acXyS0k7QixUzLSH
   P+oMV1YohwjRbhAjf8iv3PB7W+JoTmSlZoATFwU2hSMg71rDdvb7sP9Ip
   KT61+55bWlqUUCUPRTqdVEGSlVCzJgugk+g+hli7VIGSs4bWhJsoK2VTT
   2uYI25pUUCxZ/hXcJthq64/ES2+k9DivEzBVcp2NHW8PyAszrFCqcJXeP
   tICQiv1dz5IDQRhu2KTtL1Holo8pdSyhW6hv5wta5J3lFg3ZwFtKeLEy5
   3ADv1Q+6E7Wbd3H2ZjMbwPiEMcRa1/WySbp4SxN+ryRmHKnds1+HlSOlx
   g==;
X-IronPort-AV: E=Sophos;i="5.90,244,1643698800"; 
   d="scan'208";a="151988423"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 Apr 2022 00:58:24 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 8 Apr 2022 00:58:23 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Fri, 8 Apr 2022 00:58:19 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <robh+dt@kernel.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <p.zabel@pengutronix.de>,
        <linux@armlinux.org.uk>, <sre@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <cristian.birsan@microchip.com>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v3 02/10] dt-bindings: reset: convert Atmel/Microchip reset controller to YAML
Date:   Fri, 8 Apr 2022 11:00:23 +0300
Message-ID: <20220408080031.2527232-3-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220408080031.2527232-1-claudiu.beznea@microchip.com>
References: <20220408080031.2527232-1-claudiu.beznea@microchip.com>
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

