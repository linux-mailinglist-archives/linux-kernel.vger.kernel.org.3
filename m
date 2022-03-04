Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 648384CD8BD
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 17:12:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240641AbiCDQNc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 11:13:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240626AbiCDQNY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 11:13:24 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4766562D9;
        Fri,  4 Mar 2022 08:12:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1646410355; x=1677946355;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3twr+wH4YG8dvr+phLPiUgUe0mcYyxeg6BWSNTEIEoc=;
  b=wdaTBGjqbQjrPbL0ZX8W902GA9CddgaXkXJAz7CCvUIHGhS5ThFTUMUS
   CfqXDeEvXPlrit+plAmRxc62a8WNZEPJNQxpJuWqG64KC0PTrC/4m1dlv
   uCwHhTNN2C4IJSnCvD5vJRebPWreVfTb+ebC8h5cIzpYoG0WrJyP7r5A3
   J5LbCsEgCpW5wnfQ5cn9b1+wXWXSLpHtBryosVla3XK6FaRN+Jpiu9PRa
   pbIk2BGZO1cK9urqyZ9urPIPogSUrfTY3Mu1cezcH74D7M3ADXRzFPKc5
   8Oo+Pep35wtF9mbxGsdm4O/K5EZNc5HsUzmQfnNDDMHVQhLjPou5vG0C7
   w==;
X-IronPort-AV: E=Sophos;i="5.90,155,1643698800"; 
   d="scan'208";a="155743595"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 04 Mar 2022 09:12:29 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 4 Mar 2022 09:12:30 -0700
Received: from ROB-ULT-M68701.amer.actel.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Fri, 4 Mar 2022 09:12:26 -0700
From:   Sergiu Moga <sergiu.moga@microchip.com>
To:     <a.zummo@towertech.it>, <alexandre.belloni@bootlin.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski@canonical.com>,
        <nicolas.ferre@microchip.com>, <claudiu.beznea@microchip.com>
CC:     <linux-rtc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Sergiu Moga <sergiu.moga@microchip.com>
Subject: [PATCH v4 3/4] dt-bindings: rtc: convert at91sam9 bindings to json-schema
Date:   Fri, 4 Mar 2022 18:11:58 +0200
Message-ID: <20220304161159.147784-4-sergiu.moga@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220304161159.147784-1-sergiu.moga@microchip.com>
References: <20220304161159.147784-1-sergiu.moga@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert RTC binding for Atmel/Microchip SoCs to Device Tree Schema
format.

Signed-off-by: Sergiu Moga <sergiu.moga@microchip.com>
---
 .../bindings/rtc/atmel,at91sam9-rtc.txt       | 25 -------
 .../bindings/rtc/atmel,at91sam9-rtc.yaml      | 65 +++++++++++++++++++
 2 files changed, 65 insertions(+), 25 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/rtc/atmel,at91sam9-rtc.txt
 create mode 100644 Documentation/devicetree/bindings/rtc/atmel,at91sam9-rtc.yaml

diff --git a/Documentation/devicetree/bindings/rtc/atmel,at91sam9-rtc.txt b/Documentation/devicetree/bindings/rtc/atmel,at91sam9-rtc.txt
deleted file mode 100644
index 3f0e2a5950eb..000000000000
--- a/Documentation/devicetree/bindings/rtc/atmel,at91sam9-rtc.txt
+++ /dev/null
@@ -1,25 +0,0 @@
-Atmel AT91SAM9260 Real Time Timer
-
-Required properties:
-- compatible: should be one of the following:
-	- "atmel,at91sam9260-rtt"
-	- "microchip,sam9x60-rtt", "atmel,at91sam9260-rtt"
-- reg: should encode the memory region of the RTT controller
-- interrupts: rtt alarm/event interrupt
-- clocks: should contain the 32 KHz slow clk that will drive the RTT block.
-- atmel,rtt-rtc-time-reg: should encode the GPBR register used to store
-	the time base when the RTT is used as an RTC.
-	The first cell should point to the GPBR node and the second one
-	encode the offset within the GPBR block (or in other words, the
-	GPBR register used to store the time base).
-
-
-Example:
-
-rtt@fffffd20 {
-	compatible = "atmel,at91sam9260-rtt";
-	reg = <0xfffffd20 0x10>;
-	interrupts = <1 4 7>;
-	clocks = <&clk32k>;
-	atmel,rtt-rtc-time-reg = <&gpbr 0x0>;
-};
diff --git a/Documentation/devicetree/bindings/rtc/atmel,at91sam9-rtc.yaml b/Documentation/devicetree/bindings/rtc/atmel,at91sam9-rtc.yaml
new file mode 100644
index 000000000000..d2452067bfe4
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/atmel,at91sam9-rtc.yaml
@@ -0,0 +1,65 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (C) 2022 Microchip Technology, Inc. and its subsidiaries
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/rtc/atmel,at91sam9-rtc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Atmel AT91 RTT Device Tree Bindings
+
+allOf:
+  - $ref: "rtc.yaml#"
+
+maintainers:
+  - Alexandre Belloni <alexandre.belloni@bootlin.com>
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - const: atmel,at91sam9260-rtt
+      - items:
+          - const: microchip,sam9x60-rtt
+          - const: atmel,at91sam9260-rtt
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  atmel,rtt-rtc-time-reg:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    items:
+      - items:
+          - description: Phandle to the GPBR node.
+          - description: Offset within the GPBR block.
+    description:
+      Should encode the GPBR register used to store the time base when the
+      RTT is used as an RTC. The first cell should point to the GPBR node
+      and the second one encodes the offset within the GPBR block (or in
+      other words, the GPBR register used to store the time base).
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - atmel,rtt-rtc-time-reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    rtc@fffffd20 {
+        compatible = "atmel,at91sam9260-rtt";
+        reg = <0xfffffd20 0x10>;
+        interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
+        clocks = <&clk32k>;
+        atmel,rtt-rtc-time-reg = <&gpbr 0x0>;
+    };
-- 
2.25.1

