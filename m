Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 093EA56CE05
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 10:42:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229654AbiGJImS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 04:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbiGJImI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 04:42:08 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6D9918E06
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 01:42:07 -0700 (PDT)
Date:   Sun, 10 Jul 2022 08:42:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1657442526;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0EOtz7vpgUTS4304ddQGPp+IZwuOOLtohDNYIOhYj+U=;
        b=g/7MARbrpRXchHYBoq36AxgChYZxI1lv4dxDJ1mdEy+iBEsGXQA8pl0blI3FIlu/igmY7j
        F1l4OCEDW7Hn4nOLHnBdo35EluAgKje7PtQO6doEfAEzzQlRgmi672CHjzOJHZ8wDIwMKw
        q8YRt/d8jYPnf2AKcdykKdL51IFq9Dn51d9K42Y9XmAxaKmO+kRhMRN7kTZ1HrGzq0GDlh
        xiFnfWbtxaqUJq/4+jfyEjzUeq84B8jWBO2U90BKB+rSr2adnAMDQNXzYw1bkmyKxpq6rI
        1WvIw9HbTHIdZepnBgaZx4Sf+yFAjHEJEOhE4vZs3xZtWhXuCMPDvNJ6zQVdsw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1657442526;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0EOtz7vpgUTS4304ddQGPp+IZwuOOLtohDNYIOhYj+U=;
        b=uRHtIZpHjOGUlQYAUTFH+6polTOGkYi70bkSSC0Tj8mPRNKAWx7JTP25x0wB36KrXEI5au
        6+RyUA7dMvygZyCQ==
From:   "irqchip-bot for Lad Prabhakar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] dt-bindings: interrupt-controller: Add
 Renesas RZ/G2L Interrupt Controller
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Rob Herring <robh@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20220707182314.66610-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220707182314.66610-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Message-ID: <165744252532.15455.8001294897666223117.tip-bot2@tip-bot2>
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

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     96fed779d3d4cb3c221bb70e94de59b8dec0abfc
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/96fed779d3d4cb3c221bb70e94de59b8dec0abfc
Author:        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
AuthorDate:    Thu, 07 Jul 2022 19:23:10 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Sun, 10 Jul 2022 09:30:00 +01:00

dt-bindings: interrupt-controller: Add Renesas RZ/G2L Interrupt Controller

Add DT bindings for the Renesas RZ/G2L Interrupt Controller.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20220707182314.66610-3-prabhakar.mahadev-lad.rj@bp.renesas.com
---
 Documentation/devicetree/bindings/interrupt-controller/renesas,rzg2l-irqc.yaml | 133 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 133 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/renesas,rzg2l-irqc.yaml

diff --git a/Documentation/devicetree/bindings/interrupt-controller/renesas,rzg2l-irqc.yaml b/Documentation/devicetree/bindings/interrupt-controller/renesas,rzg2l-irqc.yaml
new file mode 100644
index 0000000..ffbb4ab
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/renesas,rzg2l-irqc.yaml
@@ -0,0 +1,133 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interrupt-controller/renesas,rzg2l-irqc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Renesas RZ/G2L (and alike SoC's) Interrupt Controller (IA55)
+
+maintainers:
+  - Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
+  - Geert Uytterhoeven <geert+renesas@glider.be>
+
+description: |
+  IA55 performs various interrupt controls including synchronization for the external
+  interrupts of NMI, IRQ, and GPIOINT and the interrupts of the built-in peripheral
+  interrupts output by each IP. And it notifies the interrupt to the GIC
+    - IRQ sense select for 8 external interrupts, mapped to 8 GIC SPI interrupts
+    - GPIO pins used as external interrupt input pins, mapped to 32 GIC SPI interrupts
+    - NMI edge select (NMI is not treated as NMI exception and supports fall edge and
+      stand-up edge detection interrupts)
+
+allOf:
+  - $ref: /schemas/interrupt-controller.yaml#
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - renesas,r9a07g044-irqc    # RZ/G2L
+      - const: renesas,rzg2l-irqc
+
+  '#interrupt-cells':
+    description: The first cell should contain external interrupt number (IRQ0-7) and the
+                 second cell is used to specify the flag.
+    const: 2
+
+  '#address-cells':
+    const: 0
+
+  interrupt-controller: true
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 41
+
+  clocks:
+    maxItems: 2
+
+  clock-names:
+    items:
+      - const: clk
+      - const: pclk
+
+  power-domains:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+required:
+  - compatible
+  - '#interrupt-cells'
+  - '#address-cells'
+  - interrupt-controller
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - power-domains
+  - resets
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/r9a07g044-cpg.h>
+
+    irqc: interrupt-controller@110a0000 {
+            compatible = "renesas,r9a07g044-irqc", "renesas,rzg2l-irqc";
+            reg = <0x110a0000 0x10000>;
+            #interrupt-cells = <2>;
+            #address-cells = <0>;
+            interrupt-controller;
+            interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 444 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 445 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 446 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 447 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 448 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 449 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 450 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 451 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 452 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 453 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 454 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 455 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 456 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 457 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 458 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 459 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 460 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 461 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 462 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 463 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 464 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 465 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 466 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 467 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 468 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 469 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 470 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 471 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 472 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 473 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 474 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 475 IRQ_TYPE_LEVEL_HIGH>;
+            clocks = <&cpg CPG_MOD R9A07G044_IA55_CLK>,
+                     <&cpg CPG_MOD R9A07G044_IA55_PCLK>;
+            clock-names = "clk", "pclk";
+            power-domains = <&cpg>;
+            resets = <&cpg R9A07G044_IA55_RESETN>;
+    };
