Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D65DF4B7092
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 17:39:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239452AbiBOOwe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 09:52:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239239AbiBOOvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 09:51:52 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16B0A104A59;
        Tue, 15 Feb 2022 06:50:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1644936635; x=1676472635;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Warxi8oODvNtldPlORcvEwIKu5YQQtPRxV9eIjZBPG0=;
  b=O86cAGBjczuZ+icNmbvbmTbmw5a8WYyewFgUdhGU5N7vNGKTZxPE8dUV
   0gQE2ueKcXCHKdqcHNTTul4pAF/qUANkTohXrz31/hFNIj8mrsHvAk2U+
   f1xghrslK7v7EnDMbEqieoZibrtJ4gTqvbKMbXS5ibRKxjTF5ms7GfMG+
   K0h4zI0xcervrNeR3SikEo4uS4TF2eVhAmXMBZ0+x5/OfAdaPvKC2tbe6
   H6x65NZSCAC0+oRRu2tug4I/gAYSB1ykijP2lFh6X1PwEE+XL2m/7LE9H
   tg1Xs9yR15icVJwcVXLKekZ5ZMzUs9xdRrRAvVk96Ms4seUPGefIpIyUV
   w==;
IronPort-SDR: +aRwZPFln39QE8nwEv4LFZnexjfzurE7rBnnykNE5y5h2bnAem8d0J/3yQo/igJF7bmN8spzUO
 byB7BvUNdNq91Gl3XHFq6a5zzlA8j3srpbcF2xMvc/GzDBIauc196yFW/UVY4dsAH7VAgqe3Tt
 I98Ft8tILfYYL84LpKIn5xAmvE3DcDc4WSGIfKWzcUB1JA6tWypFLVoADqnjMwtxJzTBtDHBTD
 NuyDk9R5gdjQ4f8HUGJUaus5TG0+bCTSiqsaWCObpXM00s9UCjkSXDmqRYBeTBoMF6UI7H9T+7
 GNZLkO6joYrydKF/m8Kjev1q
X-IronPort-AV: E=Sophos;i="5.88,371,1635231600"; 
   d="scan'208";a="153664207"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Feb 2022 07:50:33 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 15 Feb 2022 07:50:32 -0700
Received: from ROB-ULT-M68701.amer.actel.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Tue, 15 Feb 2022 07:50:28 -0700
From:   Sergiu Moga <sergiu.moga@microchip.com>
To:     <a.zummo@towertech.it>, <alexandre.belloni@bootlin.com>,
        <robh+dt@kernel.org>, <nicolas.ferre@microchip.com>,
        <ludovic.desroches@microchip.com>
CC:     <linux-rtc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Sergiu Moga <sergiu.moga@microchip.com>
Subject: [PATCH] dt-bindings: rtc: convert at91sam9 bindings to json-schema
Date:   Tue, 15 Feb 2022 16:46:49 +0200
Message-ID: <20220215144649.14378-1-sergiu.moga@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert RTC binding for Atmel/Microchip SoCs to Device Tree Schema
format.

Signed-off-by: Sergiu Moga <sergiu.moga@microchip.com>
---
 .../bindings/rtc/atmel,at91sam9-rtc.txt       | 25 --------
 .../bindings/rtc/atmel,at91sam9-rtc.yaml      | 61 +++++++++++++++++++
 2 files changed, 61 insertions(+), 25 deletions(-)
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
index 000000000000..c78a8c1c9314
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/atmel,at91sam9-rtc.yaml
@@ -0,0 +1,61 @@
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
+        - const: atmel,at91sam9260-rtt
+      - items:
+        - const: microchip,sam9x60-rtt
+        - const: atmel,at91sam9260-rtt
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
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    description: |
+      Should encode the GPBR register used to store the time base when the
+      RTT is used as an RTC. The first cell should point to the GPBR node
+      and the second one encodes the offset within the GPBR block (or in
+      other words, the GPBR register used to store the time base).
+    items:
+      maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - atmel,rtt-rtc-time-reg
+
+additionalProperties: false
+
+examples:
+  - |
+    rtt@fffffd20 {
+        compatible = "atmel,at91sam9260-rtt";
+        reg = <0xfffffd20 0x10>;
+        interrupts = <1 4 7>;
+        clocks = <&clk32k>;
+        atmel,rtt-rtc-time-reg = <&gpbr 0x0>;
+    };
-- 
2.25.1

