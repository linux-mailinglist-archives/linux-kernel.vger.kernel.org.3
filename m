Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90AB74CFF80
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 14:04:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242737AbiCGNFD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 08:05:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242723AbiCGNE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 08:04:59 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E6108AE66;
        Mon,  7 Mar 2022 05:04:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1646658245; x=1678194245;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mE/f5w6hI3/UFX9x5xjoLAnGuFnfdoILziLi45/dW+s=;
  b=Eh9i8vg9O5w4fMnQgcsdwwrPWM8t6iyOULCfRoUQyJLtU05h7df4zDgX
   +b71xqsyQaSO1N8k6dLQQzPLb/dKp+j11kvBYajFlxjXKb9h+aak2Ck9e
   FpXCWR22lBH30GWHkPXAvCn+6S02KbSn/8Q3X0ugHeniByC9j1ZEU/jfu
   axitgSdlEN62EyCN7qomk2PETlRx9MH/LbGNrmHfjEpGgs3Qiamia7GeU
   R8bGf0b/WTVnxMa/a7brTcR3rnv0GT41Ib8b7OrMW9mVT9AUt8BrMlKx9
   zJ2QmbfNjosdpFPiUTrIiG6NZlby/r7oSxoLu2M1yexKW/E3hqAG/8mMu
   A==;
X-IronPort-AV: E=Sophos;i="5.90,162,1643698800"; 
   d="scan'208";a="155492401"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Mar 2022 06:04:04 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 7 Mar 2022 06:04:03 -0700
Received: from ROB-ULT-M68701.amer.actel.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Mon, 7 Mar 2022 06:03:56 -0700
From:   Sergiu Moga <sergiu.moga@microchip.com>
To:     <claudiu.beznea@microchip.com>, <thierry.reding@gmail.com>,
        <u.kleine-koenig@pengutronix.de>, <lee.jones@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski@canonical.com>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-pwm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Sergiu Moga <sergiu.moga@microchip.com>
Subject: [PATCH 1/2] dt-bindings: pwm: convert atmel pwm to json-schema
Date:   Mon, 7 Mar 2022 15:03:06 +0200
Message-ID: <20220307130307.106102-2-sergiu.moga@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220307130307.106102-1-sergiu.moga@microchip.com>
References: <20220307130307.106102-1-sergiu.moga@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert PWM binding for Atmel/Microchip SoCs to Device Tree Schema
format.

Signed-off-by: Sergiu Moga <sergiu.moga@microchip.com>
---
 .../devicetree/bindings/pwm/atmel-pwm.txt     | 35 -----------
 .../devicetree/bindings/pwm/atmel-pwm.yaml    | 62 +++++++++++++++++++
 2 files changed, 62 insertions(+), 35 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/pwm/atmel-pwm.txt
 create mode 100644 Documentation/devicetree/bindings/pwm/atmel-pwm.yaml

diff --git a/Documentation/devicetree/bindings/pwm/atmel-pwm.txt b/Documentation/devicetree/bindings/pwm/atmel-pwm.txt
deleted file mode 100644
index fbb5325be1f0..000000000000
--- a/Documentation/devicetree/bindings/pwm/atmel-pwm.txt
+++ /dev/null
@@ -1,35 +0,0 @@
-Atmel PWM controller
-
-Required properties:
-  - compatible: should be one of:
-    - "atmel,at91sam9rl-pwm"
-    - "atmel,sama5d3-pwm"
-    - "atmel,sama5d2-pwm"
-    - "microchip,sam9x60-pwm"
-  - reg: physical base address and length of the controller's registers
-  - #pwm-cells: Should be 3. See pwm.yaml in this directory for a
-    description of the cells format.
-
-Example:
-
-	pwm0: pwm@f8034000 {
-		compatible = "atmel,at91sam9rl-pwm";
-		reg = <0xf8034000 0x400>;
-		#pwm-cells = <3>;
-	};
-
-	pwmleds {
-		compatible = "pwm-leds";
-
-		d1 {
-			label = "d1";
-			pwms = <&pwm0 3 5000 0>
-			max-brightness = <255>;
-		};
-
-		d2 {
-			label = "d2";
-			pwms = <&pwm0 1 5000 1>
-			max-brightness = <255>;
-		};
-	};
diff --git a/Documentation/devicetree/bindings/pwm/atmel-pwm.yaml b/Documentation/devicetree/bindings/pwm/atmel-pwm.yaml
new file mode 100644
index 000000000000..f5378a2226bd
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/atmel-pwm.yaml
@@ -0,0 +1,62 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (C) 2022 Microchip Technology, Inc. and its subsidiaries
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pwm/atmel-pwm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Atmel PWM controller
+
+maintainers:
+  - Claudiu Beznea <claudiu.beznea@microchip.com>
+
+properties:
+  compatible:
+    enum:
+      - atmel,at91sam9rl-pwm
+      - atmel,sama5d3-pwm
+      - atmel,sama5d2-pwm
+      - microchip,sam9x60-pwm
+
+  reg:
+    description: |
+      Physical base address and length of the controller's
+      registers
+    maxItems: 1
+
+  "#pwm-cells":
+    description: |
+      Should be 3. See pwm.yaml in this directory for a
+      description of the cells format.
+    const: 3
+
+required:
+  - compatible
+  - reg
+  - "#pwm-cells"
+
+additionalProperties: true
+
+examples:
+  - |
+        pwm0: pwm@f8034000 {
+                compatible = "atmel,at91sam9rl-pwm";
+                reg = <0xf8034000 0x400>;
+                #pwm-cells = <3>;
+        };
+
+        pwmleds {
+                compatible = "pwm-leds";
+
+                led-1 {
+                        label = "led-1";
+                        pwms = <&pwm0 3 5000 0>;
+                        max-brightness = <255>;
+                };
+
+                led-2 {
+                        label = "led-2";
+                        pwms = <&pwm0 1 5000 1>;
+                        max-brightness = <255>;
+                };
+        };
-- 
2.25.1

