Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 085A04AED73
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 10:02:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239095AbiBIJCM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 04:02:12 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:48722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238865AbiBIJBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 04:01:55 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49C2EE0650B1
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 01:01:52 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id e3so2884950wra.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Feb 2022 01:01:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qL3NqM+YbQIYfajnWqdAMTOFk/R3y/d271/TpavWvJs=;
        b=cWcmdSqZzBHhEeK/HhJdL1oQ/0xwa+nihw3HfzxOyvcP6w5QtEW9ab/xcpuJtcUTd5
         rFMsOWkh+LdgqqInOEompniBZ4liL3UyMBYyGS9ZDig9TFUpM8XBJOFXb1vMCWbCiRce
         3AvCd9kjluiScLlAawmgWtMsvtxoEiOhDVq87jMPWh7uKorzqSEtTeRxYLvhwhT1FfiB
         yGXcaGEtoudD+FTgMJ0hEFWtHEKI2gWm9/+cG84MUVypjz1jCZ8XW3qEjBLUydEO/PjH
         NlbxqDKA2ZPthnn3ItiYWpV8TOXxeCa2H056epDYRe/G/xURl0O++5l604TLdq+l5/wf
         hezA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qL3NqM+YbQIYfajnWqdAMTOFk/R3y/d271/TpavWvJs=;
        b=6cRgIEyUbcEl27KKQWcrhxm1tdWgh6CHB8RHTEegTSftutgZabNSo0YYKBotE0nPAB
         TZuB1gIE9Rt2oQCMJ6uRDgWnIXLXprtplJv19xI0Z+C2OFJ9WpEt8E03JYLrAcTGYA+Q
         Cy9iHEFeJ0GvEi1n3JUfrN27QKX87IpAWCrwC53Q5WouThsfQMCu9PIPF2ANQT5Elomn
         b9SOcGfCpPG38k7IpV4nGZBs4kUGasscZS27sAMolBikGkGT4yUxOll56VId2NVKwKZ2
         JaBYAVt/MNAZkyGtlOqM87/eaPH4fAvOVdhoQfrZgM5rI+Jh7CCp7+GrwfpZulBXffaO
         xVIg==
X-Gm-Message-State: AOAM531OFn9Pb8/3EBSYK6Y7PH0agQYL6OKEIMB6CqyxmbpyqYpX2fZ6
        SI7PVJfK0SAbKexVxATbz8KcU8cbvv4Ipg==
X-Google-Smtp-Source: ABdhPJzPXo/QUZdbpnMhE2wnY2Teo9XJ3k3osIirVhe7Y7kznHhqEiGqH63phDsN/wePYOe0xiaG5w==
X-Received: by 2002:a5d:588d:: with SMTP id n13mr1229823wrf.690.1644397263979;
        Wed, 09 Feb 2022 01:01:03 -0800 (PST)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id g4sm17436641wrd.111.2022.02.09.01.01.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 01:01:03 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     daniel.lezcano@linaro.org, krzysztof.kozlowski@canonical.com,
        robh+dt@kernel.org, tglx@linutronix.de
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v3] dt-bindings: timer: Convert faraday,fttmr010 to yaml
Date:   Wed,  9 Feb 2022 09:00:58 +0000
Message-Id: <20220209090058.1472964-1-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Converts timer/faraday,fttmr010.txt to yaml.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
Changes since v1:
- added moxart example
- relaxed some contraints as driver only support one clock and one
  interrupt (as used by moxa,moxart-timer)
Changes since v2:
- increased max size of interrupts
- fixed all issues reported by Rob https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20220126160021.3537591-1-clabbe@baylibre.com

All aspeed-bmc-vegman*dts are expected to fail and will be fixed via:
https://patchwork.ozlabs.org/project/linux-aspeed/patch/20220127141604.1163-1-a.kartashev@yadro.com/

 .../bindings/timer/faraday,fttmr010.txt       |  38 ------
 .../bindings/timer/faraday,fttmr010.yaml      | 108 ++++++++++++++++++
 2 files changed, 108 insertions(+), 38 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/timer/faraday,fttmr010.txt
 create mode 100644 Documentation/devicetree/bindings/timer/faraday,fttmr010.yaml

diff --git a/Documentation/devicetree/bindings/timer/faraday,fttmr010.txt b/Documentation/devicetree/bindings/timer/faraday,fttmr010.txt
deleted file mode 100644
index 3cb2f4c98d64..000000000000
--- a/Documentation/devicetree/bindings/timer/faraday,fttmr010.txt
+++ /dev/null
@@ -1,38 +0,0 @@
-Faraday Technology timer
-
-This timer is a generic IP block from Faraday Technology, embedded in the
-Cortina Systems Gemini SoCs and other designs.
-
-Required properties:
-
-- compatible : Must be one of
-  "faraday,fttmr010"
-  "cortina,gemini-timer", "faraday,fttmr010"
-  "moxa,moxart-timer", "faraday,fttmr010"
-  "aspeed,ast2400-timer"
-  "aspeed,ast2500-timer"
-  "aspeed,ast2600-timer"
-
-- reg : Should contain registers location and length
-- interrupts : Should contain the three timer interrupts usually with
-  flags for falling edge
-
-Optionally required properties:
-
-- clocks : a clock to provide the tick rate for "faraday,fttmr010"
-- clock-names : should be "EXTCLK" and "PCLK" for the external tick timer
-  and peripheral clock respectively, for "faraday,fttmr010"
-- syscon : a phandle to the global Gemini system controller if the compatible
-  type is "cortina,gemini-timer"
-
-Example:
-
-timer@43000000 {
-	compatible = "faraday,fttmr010";
-	reg = <0x43000000 0x1000>;
-	interrupts = <14 IRQ_TYPE_EDGE_FALLING>, /* Timer 1 */
-		   <15 IRQ_TYPE_EDGE_FALLING>, /* Timer 2 */
-		   <16 IRQ_TYPE_EDGE_FALLING>; /* Timer 3 */
-	clocks = <&extclk>, <&pclk>;
-	clock-names = "EXTCLK", "PCLK";
-};
diff --git a/Documentation/devicetree/bindings/timer/faraday,fttmr010.yaml b/Documentation/devicetree/bindings/timer/faraday,fttmr010.yaml
new file mode 100644
index 000000000000..02d842b827ce
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/faraday,fttmr010.yaml
@@ -0,0 +1,108 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/timer/faraday,fttmr010.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Faraday Technology timer
+
+maintainers:
+  - Linus Walleij <linus.walleij@linaro.org>
+
+description:
+  This timer is a generic IP block from Faraday Technology, embedded in the
+  Cortina Systems Gemini SoCs and other designs.
+
+properties:
+  compatible:
+    oneOf:
+      - const: faraday,fttmr010
+      - items:
+          - const: cortina,gemini-timer
+          - const: faraday,fttmr010
+      - items:
+          - const: moxa,moxart-timer
+          - const: faraday,fttmr010
+      - const: aspeed,ast2400-timer
+      - const: aspeed,ast2500-timer
+      - const: aspeed,ast2600-timer
+
+  reg:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+  interrupts:
+    minItems: 1
+    maxItems: 10
+    description: Should contain the three timer interrupts usually with flags for falling edge
+
+  clocks:
+    minItems: 1
+    maxItems: 2
+
+  clock-names:
+    minItems: 1
+    items:
+      - const: PCLK
+      - const: EXTCLK
+
+  syscon:
+    $ref: /schemas/types.yaml#/definitions/phandle
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+
+additionalProperties: true
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    timer@43000000 {
+      compatible = "faraday,fttmr010";
+      reg = <0x43000000 0x1000>;
+      interrupts = <14 IRQ_TYPE_EDGE_FALLING>, /* Timer 1 */
+                   <15 IRQ_TYPE_EDGE_FALLING>, /* Timer 2 */
+                   <16 IRQ_TYPE_EDGE_FALLING>; /* Timer 3 */
+      clocks = <&extclk>, <&pclk>;
+      clock-names = "PCLK", "EXTCLK";
+      syscon = <&syscon>;
+    };
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    timer@98400000 {
+      compatible = "moxa,moxart-timer", "faraday,fttmr010";
+      reg = <0x98400000 0x42>;
+      interrupts = <19 IRQ_TYPE_EDGE_FALLING>;
+      clocks = <&clk_apb>;
+      clock-names = "PCLK";
+    };
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/ast2600-clock.h>
+    /* taken from arch/arm/boot/dts/aspeed-bmc-vegman.dtsi */
+    timer@1e782000 {
+      compatible = "aspeed,ast2600-timer";
+      reg = <0x1e782000 0x90>;
+      interrupts-extended = <&gic  GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>,
+                            <&gic  GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>,
+                            <&gic  GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>,
+                            <&gic  GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>,
+                            <&gic  GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>,
+                            <&gic  GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>,
+                            <&gic  GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>,
+                            <&gic  GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
+      clocks = <&syscon ASPEED_CLK_APB1>;
+      clock-names = "PCLK";
+      /* fttmr010,pwm-outputs = <5>; */
+      pinctrl-names = "default";
+      pinctrl-0 = <&pinctrl_timer5_default>;
+      #pwm-cells = <3>;
+    };
+...
-- 
2.34.1

