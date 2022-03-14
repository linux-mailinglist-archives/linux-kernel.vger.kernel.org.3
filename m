Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 952B54D7E92
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 10:29:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237946AbiCNJaH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 05:30:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237987AbiCNJ3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 05:29:34 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFAA243ED7;
        Mon, 14 Mar 2022 02:28:24 -0700 (PDT)
Date:   Mon, 14 Mar 2022 09:28:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1647250103;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aJhtiVGKzrHnPvyK4Q81jHNQ/U9bQXq67skO1Yw1qRE=;
        b=EszFjVatHV+e8uJg4Af3ocn/4A7afMwZsGoj2uXq0Mqtnu/FouQLPohAVWBDZ7ZY7geMtn
        sVgEl2bjJshEihTgPVyivuDUB44YpMcH7S6uG7TBBTaBtGaJnZSBNNWM17tR31CN6Cw/ov
        CYV07KPJadu8MB59JPauNcYrkY13+oE1FROILKHDtoeFyUPLNnfPYw3edHrVuZxQ4W1LWG
        J1oEiwwZ67wXVoxON+JSL/Wh/veoCp9ocQq4M0GrJFLb7P/TKbB9C8A3jFdpZAYvYT1dBU
        ql3A2dPtAgvqNBdwtqVUUgd9IGQ3Md84JQtjX/ML/6RytTJJKV8oQ31u23imcw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1647250103;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aJhtiVGKzrHnPvyK4Q81jHNQ/U9bQXq67skO1Yw1qRE=;
        b=HqY5ZpRrlwMFmHpZKTBLAoXFuKUHDMeL8XGbj1ZdaiNschKOEmRGx79j+cr2oVIqi9ZHIo
        LEkDVxjrPyfT51Ag==
From:   "tip-bot2 for David Heidelberg" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] dt-bindings: timer: Tegra: Convert text bindings to yaml
Cc:     Rob Herring <robh@kernel.org>, David Heidelberg <david@ixit.cz>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220303233307.61753-1-david@ixit.cz>
References: <20220303233307.61753-1-david@ixit.cz>
MIME-Version: 1.0
Message-ID: <164725010241.16921.1211798490133176709.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     cea9ffe0094d468b17814056fcebe7b3840af5f0
Gitweb:        https://git.kernel.org/tip/cea9ffe0094d468b17814056fcebe7b3840af5f0
Author:        David Heidelberg <david@ixit.cz>
AuthorDate:    Fri, 04 Mar 2022 00:33:06 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Mon, 07 Mar 2022 18:27:22 +01:00

dt-bindings: timer: Tegra: Convert text bindings to yaml

Convert Tegra timer binding into yaml format.

This commit also merge 3 text bindings with almost
identical content (differens in number of registers).

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: David Heidelberg <david@ixit.cz>
Link: https://lore.kernel.org/r/20220303233307.61753-1-david@ixit.cz
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 Documentation/devicetree/bindings/timer/nvidia,tegra-timer.yaml   | 150 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 Documentation/devicetree/bindings/timer/nvidia,tegra20-timer.txt  |  24 +-----------
 Documentation/devicetree/bindings/timer/nvidia,tegra210-timer.txt |  36 +-----------------
 Documentation/devicetree/bindings/timer/nvidia,tegra30-timer.txt  |  28 +-------------
 4 files changed, 150 insertions(+), 88 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/timer/nvidia,tegra-timer.yaml
 delete mode 100644 Documentation/devicetree/bindings/timer/nvidia,tegra20-timer.txt
 delete mode 100644 Documentation/devicetree/bindings/timer/nvidia,tegra210-timer.txt
 delete mode 100644 Documentation/devicetree/bindings/timer/nvidia,tegra30-timer.txt

diff --git a/Documentation/devicetree/bindings/timer/nvidia,tegra-timer.yaml b/Documentation/devicetree/bindings/timer/nvidia,tegra-timer.yaml
new file mode 100644
index 0000000..b78209c
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/nvidia,tegra-timer.yaml
@@ -0,0 +1,150 @@
+# SPDX-License-Identifier: GPL-2.0-only
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/timer/nvidia,tegra-timer.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: NVIDIA Tegra timer
+
+maintainers:
+  - Stephen Warren <swarren@nvidia.com>
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: nvidia,tegra210-timer
+    then:
+      properties:
+        interrupts:
+          # Either a single combined interrupt or up to 14 individual interrupts
+          minItems: 1
+          maxItems: 14
+          description: >
+            A list of 14 interrupts; one per each timer channels 0 through 13
+
+  - if:
+      properties:
+        compatible:
+          oneOf:
+            - items:
+                - enum:
+                    - nvidia,tegra114-timer
+                    - nvidia,tegra124-timer
+                    - nvidia,tegra132-timer
+                - const: nvidia,tegra30-timer
+            - items:
+                - const: nvidia,tegra30-timer
+                - const: nvidia,tegra20-timer
+    then:
+      properties:
+        interrupts:
+          # Either a single combined interrupt or up to 6 individual interrupts
+          minItems: 1
+          maxItems: 6
+          description: >
+            A list of 6 interrupts; one per each of timer channels 1 through 5,
+            and one for the shared interrupt for the remaining channels.
+
+  - if:
+      properties:
+        compatible:
+          const: nvidia,tegra20-timer
+    then:
+      properties:
+        interrupts:
+          # Either a single combined interrupt or up to 4 individual interrupts
+          minItems: 1
+          maxItems: 4
+          description: |
+            A list of 4 interrupts; one per timer channel.
+
+properties:
+  compatible:
+    oneOf:
+      - const: nvidia,tegra210-timer
+        description: >
+          The Tegra210 timer provides fourteen 29-bit timer counters and one 32-bit
+          timestamp counter. The TMRs run at either a fixed 1 MHz clock rate derived
+          from the oscillator clock (TMR0-TMR9) or directly at the oscillator clock
+          (TMR10-TMR13). Each TMR can be programmed to generate one-shot, periodic,
+          or watchdog interrupts.
+      - items:
+          - enum:
+              - nvidia,tegra114-timer
+              - nvidia,tegra124-timer
+              - nvidia,tegra132-timer
+          - const: nvidia,tegra30-timer
+      - items:
+          - const: nvidia,tegra30-timer
+          - const: nvidia,tegra20-timer
+        description: >
+          The Tegra30 timer provides ten 29-bit timer channels, a single 32-bit free
+          running counter, and 5 watchdog modules. The first two channels may also
+          trigger a legacy watchdog reset.
+      - const: nvidia,tegra20-timer
+        description: >
+          The Tegra20 timer provides four 29-bit timer channels and a single 32-bit free
+          running counter. The first two channels may also trigger a watchdog reset.
+
+  reg:
+    maxItems: 1
+
+  interrupts: true
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    items:
+      - const: timer
+
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    timer@60005000 {
+        compatible = "nvidia,tegra30-timer", "nvidia,tegra20-timer";
+        reg = <0x60005000 0x400>;
+        interrupts = <0 0 IRQ_TYPE_LEVEL_HIGH>,
+                     <0 1 IRQ_TYPE_LEVEL_HIGH>,
+                     <0 41 IRQ_TYPE_LEVEL_HIGH>,
+                     <0 42 IRQ_TYPE_LEVEL_HIGH>,
+                     <0 121 IRQ_TYPE_LEVEL_HIGH>,
+                     <0 122 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&tegra_car 214>;
+    };
+  - |
+    #include <dt-bindings/clock/tegra210-car.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    timer@60005000 {
+        compatible = "nvidia,tegra210-timer";
+        reg = <0x60005000 0x400>;
+        interrupts = <GIC_SPI 156 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 152 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 154 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 176 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 177 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 178 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 179 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&tegra_car TEGRA210_CLK_TIMER>;
+        clock-names = "timer";
+    };
diff --git a/Documentation/devicetree/bindings/timer/nvidia,tegra20-timer.txt b/Documentation/devicetree/bindings/timer/nvidia,tegra20-timer.txt
deleted file mode 100644
index 4a864bd..0000000
--- a/Documentation/devicetree/bindings/timer/nvidia,tegra20-timer.txt
+++ /dev/null
@@ -1,24 +0,0 @@
-NVIDIA Tegra20 timer
-
-The Tegra20 timer provides four 29-bit timer channels and a single 32-bit free
-running counter. The first two channels may also trigger a watchdog reset.
-
-Required properties:
-
-- compatible : should be "nvidia,tegra20-timer".
-- reg : Specifies base physical address and size of the registers.
-- interrupts : A list of 4 interrupts; one per timer channel.
-- clocks : Must contain one entry, for the module clock.
-  See ../clocks/clock-bindings.txt for details.
-
-Example:
-
-timer {
-	compatible = "nvidia,tegra20-timer";
-	reg = <0x60005000 0x60>;
-	interrupts = <0 0 0x04
-			0 1 0x04
-			0 41 0x04
-			0 42 0x04>;
-	clocks = <&tegra_car 132>;
-};
diff --git a/Documentation/devicetree/bindings/timer/nvidia,tegra210-timer.txt b/Documentation/devicetree/bindings/timer/nvidia,tegra210-timer.txt
deleted file mode 100644
index 032cda9..0000000
--- a/Documentation/devicetree/bindings/timer/nvidia,tegra210-timer.txt
+++ /dev/null
@@ -1,36 +0,0 @@
-NVIDIA Tegra210 timer
-
-The Tegra210 timer provides fourteen 29-bit timer counters and one 32-bit
-timestamp counter. The TMRs run at either a fixed 1 MHz clock rate derived
-from the oscillator clock (TMR0-TMR9) or directly at the oscillator clock
-(TMR10-TMR13). Each TMR can be programmed to generate one-shot, periodic,
-or watchdog interrupts.
-
-Required properties:
-- compatible : "nvidia,tegra210-timer".
-- reg : Specifies base physical address and size of the registers.
-- interrupts : A list of 14 interrupts; one per each timer channels 0 through
-  13.
-- clocks : Must contain one entry, for the module clock.
-  See ../clocks/clock-bindings.txt for details.
-
-timer@60005000 {
-	compatible = "nvidia,tegra210-timer";
-	reg = <0x0 0x60005000 0x0 0x400>;
-	interrupts = <GIC_SPI 156 IRQ_TYPE_LEVEL_HIGH>,
-		     <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
-		     <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>,
-		     <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>,
-		     <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>,
-		     <GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>,
-		     <GIC_SPI 152 IRQ_TYPE_LEVEL_HIGH>,
-		     <GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>,
-		     <GIC_SPI 154 IRQ_TYPE_LEVEL_HIGH>,
-		     <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>,
-		     <GIC_SPI 176 IRQ_TYPE_LEVEL_HIGH>,
-		     <GIC_SPI 177 IRQ_TYPE_LEVEL_HIGH>,
-		     <GIC_SPI 178 IRQ_TYPE_LEVEL_HIGH>,
-		     <GIC_SPI 179 IRQ_TYPE_LEVEL_HIGH>;
-	clocks = <&tegra_car TEGRA210_CLK_TIMER>;
-	clock-names = "timer";
-};
diff --git a/Documentation/devicetree/bindings/timer/nvidia,tegra30-timer.txt b/Documentation/devicetree/bindings/timer/nvidia,tegra30-timer.txt
deleted file mode 100644
index 1761f53..0000000
--- a/Documentation/devicetree/bindings/timer/nvidia,tegra30-timer.txt
+++ /dev/null
@@ -1,28 +0,0 @@
-NVIDIA Tegra30 timer
-
-The Tegra30 timer provides ten 29-bit timer channels, a single 32-bit free
-running counter, and 5 watchdog modules. The first two channels may also
-trigger a legacy watchdog reset.
-
-Required properties:
-
-- compatible : For Tegra30, must contain "nvidia,tegra30-timer".  Otherwise,
-  must contain '"nvidia,<chip>-timer", "nvidia,tegra30-timer"' where
-  <chip> is tegra124 or tegra132.
-- reg : Specifies base physical address and size of the registers.
-- interrupts : A list of 6 interrupts; one per each of timer channels 1
-    through 5, and one for the shared interrupt for the remaining channels.
-- clocks : Must contain one entry, for the module clock.
-  See ../clocks/clock-bindings.txt for details.
-
-timer {
-	compatible = "nvidia,tegra30-timer", "nvidia,tegra20-timer";
-	reg = <0x60005000 0x400>;
-	interrupts = <0 0 0x04
-		      0 1 0x04
-		      0 41 0x04
-		      0 42 0x04
-		      0 121 0x04
-		      0 122 0x04>;
-	clocks = <&tegra_car 214>;
-};
