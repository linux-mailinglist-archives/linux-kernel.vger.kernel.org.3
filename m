Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61C3C4D031D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 16:41:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240966AbiCGPmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 10:42:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238992AbiCGPmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 10:42:12 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63AAB70CDD;
        Mon,  7 Mar 2022 07:41:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1646667679; x=1678203679;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mioa+0AcFi7RUiE1sd9S3b86lyFH/hkp4oUFZCdql78=;
  b=Y3lBRMvknMqqqT1XSaTLZ8r2mPiWoNMhv/0NQUUdq5d/u1UPmccU15OU
   1/lqyAhLOqbWfifxWv3KszH0/2ZbhCo0O8CiYgSgH6Fh6yuJJLGhSeCCv
   QgUBGGp/cYsk+whdcsEGkR6KDDQhq2rP7mnK2d95Kl8HObeSnem0FPb1f
   x+axzbDNek4LyK7H+1qlau2lPGLmhzBAidYOg6AICbQBjOTS1yOE6MO1u
   tubWagbZzes5QpNqll9xvAt/DkhR6NiEmFxoB2gaZBHc26fPlsW2H3hoZ
   8VDsTnSg8BwZyFBpsFaYCiYpCyqgdzcM0CfBxWd8rWmpZzaQxJkUXDe8X
   g==;
X-IronPort-AV: E=Sophos;i="5.90,162,1643698800"; 
   d="scan'208";a="155514428"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Mar 2022 08:41:19 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 7 Mar 2022 08:41:17 -0700
Received: from ROB-ULT-M68701.amer.actel.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Mon, 7 Mar 2022 08:41:12 -0700
From:   Sergiu Moga <sergiu.moga@microchip.com>
To:     <claudiu.beznea@microchip.com>, <thierry.reding@gmail.com>,
        <u.kleine-koenig@pengutronix.de>, <lee.jones@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski@canonical.com>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-pwm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Sergiu Moga <sergiu.moga@microchip.com>
Subject: [PATCH v3 1/2] dt-bindings: pwm: convert atmel pwm to json-schema
Date:   Mon, 7 Mar 2022 17:36:55 +0200
Message-ID: <20220307153656.177589-2-sergiu.moga@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220307153656.177589-1-sergiu.moga@microchip.com>
References: <20220307153656.177589-1-sergiu.moga@microchip.com>
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
 .../bindings/pwm/atmel,at91sam-pwm.yaml       | 42 +++++++++++++++++++
 .../devicetree/bindings/pwm/atmel-pwm.txt     | 35 ----------------
 MAINTAINERS                                   |  2 +-
 3 files changed, 43 insertions(+), 36 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pwm/atmel,at91sam-pwm.yaml
 delete mode 100644 Documentation/devicetree/bindings/pwm/atmel-pwm.txt

diff --git a/Documentation/devicetree/bindings/pwm/atmel,at91sam-pwm.yaml b/Documentation/devicetree/bindings/pwm/atmel,at91sam-pwm.yaml
new file mode 100644
index 000000000000..5e8bb5a8095d
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/atmel,at91sam-pwm.yaml
@@ -0,0 +1,42 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (C) 2022 Microchip Technology, Inc. and its subsidiaries
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pwm/atmel,at91sam-pwm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Atmel/Microchip PWM controller
+
+maintainers:
+  - Claudiu Beznea <claudiu.beznea@microchip.com>
+
+allOf:
+  - $ref: "pwm.yaml#"
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
+    maxItems: 1
+
+  "#pwm-cells":
+    const: 3
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    pwm0: pwm@f8034000 {
+        compatible = "atmel,at91sam9rl-pwm";
+        reg = <0xf8034000 0x400>;
+        #pwm-cells = <3>;
+    };
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
diff --git a/MAINTAINERS b/MAINTAINERS
index a35eef379db0..f8b27ac0572d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12903,7 +12903,7 @@ M:	Claudiu Beznea <claudiu.beznea@microchip.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 L:	linux-pwm@vger.kernel.org
 S:	Supported
-F:	Documentation/devicetree/bindings/pwm/atmel-pwm.txt
+F:	Documentation/devicetree/bindings/pwm/atmel,at91sam-pwm.yaml
 F:	drivers/pwm/pwm-atmel.c
 
 MICROCHIP SAMA5D2-COMPATIBLE ADC DRIVER
-- 
2.25.1

