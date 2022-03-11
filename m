Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6F8C4D5E4A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 10:21:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347411AbiCKJV6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 04:21:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347396AbiCKJVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 04:21:45 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41FFC1BD05D
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 01:20:42 -0800 (PST)
Date:   Fri, 11 Mar 2022 09:20:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1646990440;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VTBxIhlZUfsoX4c6mMezxGSXt9jd9PN3MbMHTLVSixE=;
        b=H7AjKYlzEkKdUYOkfT5yLH78lmMNK7h9RHeLqg4Qr2xk4vXDF7iJujGHSWyolTjEhNKx+5
        UR9ObYCV0buNb1W9dLGlD8jjq3RacC31wwY6rpHAdENn3VobIIqaSV+bxN9cDTadxDIQmd
        LCUUNbh5uXFIhPcNvfK4yHg2vFI0JfwbVWK9xZ2UoKhgsHB3RN6Y88JIyIBz5wsfiX2bS/
        sCzYBUs4MQ+g8EnWNVZExze6VnyfLXHkWxWPtpUZqujq4XyPBsqo0SPUlGIPgeXjuIlJFU
        YI4YmAlVR1+zNfbuNDNUl4WFZKpNcFciRfPNTpffwHViAV6z2FPi9X1TaEYBBw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1646990440;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VTBxIhlZUfsoX4c6mMezxGSXt9jd9PN3MbMHTLVSixE=;
        b=KfLUIl3igAULIEeGlGc33934MEjgjLaKQvu03V3pqQDon9dTLDAOgxjpXLxwhbZMutTT8C
        zLh67jCNOPoeGEDA==
From:   "irqchip-bot for Hector Martin" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] dt-bindings: interrupt-controller:
 apple,aic2: New binding for AICv2
Cc:     Rob Herring <robh@kernel.org>, Hector Martin <marcan@marcan.st>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20220309192123.152028-3-marcan@marcan.st>
References: <20220309192123.152028-3-marcan@marcan.st>
MIME-Version: 1.0
Message-ID: <164699043956.16921.5388075787173970256.tip-bot2@tip-bot2>
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

Commit-ID:     ab1fd5abb75001d37e1fef5f310951b56f41ad58
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/ab1fd5abb75001d37e1fef5f310951b56f41ad58
Author:        Hector Martin <marcan@marcan.st>
AuthorDate:    Thu, 10 Mar 2022 04:21:18 +09:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Fri, 11 Mar 2022 08:59:00 

dt-bindings: interrupt-controller: apple,aic2: New binding for AICv2

This new incompatible revision of the AIC peripheral introduces
multi-die support. This binding is based on apple,aic, but
changes interrupt-cells to add a new die argument.

Also adds a second reg entry to specify the offset of the event
register. Inexplicably, the capability registers allow us to compute
other register offsets, but not this one. This allows us to keep
forward-compatibility with future SoCs that will likely implement
different die counts, thus shifting the event register. Apple also
specify the offset explicitly in their device tree...

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Hector Martin <marcan@marcan.st>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20220309192123.152028-3-marcan@marcan.st
---
 Documentation/devicetree/bindings/interrupt-controller/apple,aic2.yaml | 98 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 MAINTAINERS                                                            |  2 +-
 2 files changed, 99 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/apple,aic2.yaml

diff --git a/Documentation/devicetree/bindings/interrupt-controller/apple,aic2.yaml b/Documentation/devicetree/bindings/interrupt-controller/apple,aic2.yaml
new file mode 100644
index 0000000..47a78a1
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/apple,aic2.yaml
@@ -0,0 +1,98 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interrupt-controller/apple,aic2.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Apple Interrupt Controller 2
+
+maintainers:
+  - Hector Martin <marcan@marcan.st>
+
+description: |
+  The Apple Interrupt Controller 2 is a simple interrupt controller present on
+  Apple ARM SoC platforms starting with t600x (M1 Pro and Max).
+
+  It provides the following features:
+
+  - Level-triggered hardware IRQs wired to SoC blocks
+    - Single mask bit per IRQ
+    - Automatic masking on event delivery (auto-ack)
+    - Software triggering (ORed with hw line)
+  - Automatic prioritization (single event/ack register per CPU, lower IRQs =
+    higher priority)
+  - Automatic masking on ack
+  - Support for multiple dies
+
+  This device also represents the FIQ interrupt sources on platforms using AIC,
+  which do not go through a discrete interrupt controller. It also handles
+  FIQ-based Fast IPIs.
+
+properties:
+  compatible:
+    items:
+      - const: apple,t6000-aic
+      - const: apple,aic2
+
+  interrupt-controller: true
+
+  '#interrupt-cells':
+    const: 4
+    description: |
+      The 1st cell contains the interrupt type:
+        - 0: Hardware IRQ
+        - 1: FIQ
+
+      The 2nd cell contains the die ID.
+
+      The next cell contains the interrupt number.
+        - HW IRQs: interrupt number
+        - FIQs:
+          - 0: physical HV timer
+          - 1: virtual HV timer
+          - 2: physical guest timer
+          - 3: virtual guest timer
+
+      The last cell contains the interrupt flags. This is normally
+      IRQ_TYPE_LEVEL_HIGH (4).
+
+  reg:
+    items:
+      - description: Address and size of the main AIC2 registers.
+      - description: Address and size of the AIC2 Event register.
+
+  reg-names:
+    items:
+      - const: core
+      - const: event
+
+  power-domains:
+    maxItems: 1
+
+required:
+  - compatible
+  - '#interrupt-cells'
+  - interrupt-controller
+  - reg
+  - reg-names
+
+additionalProperties: false
+
+allOf:
+  - $ref: /schemas/interrupt-controller.yaml#
+
+examples:
+  - |
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        aic: interrupt-controller@28e100000 {
+            compatible = "apple,t6000-aic", "apple,aic2";
+            #interrupt-cells = <4>;
+            interrupt-controller;
+            reg = <0x2 0x8e100000 0x0 0xc000>,
+                  <0x2 0x8e10c000 0x0 0x4>;
+            reg-names = "core", "event";
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 69a2935..7a920a2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1767,7 +1767,7 @@ T:	git https://github.com/AsahiLinux/linux.git
 F:	Documentation/devicetree/bindings/arm/apple.yaml
 F:	Documentation/devicetree/bindings/arm/apple/*
 F:	Documentation/devicetree/bindings/i2c/apple,i2c.yaml
-F:	Documentation/devicetree/bindings/interrupt-controller/apple,aic.yaml
+F:	Documentation/devicetree/bindings/interrupt-controller/apple,*
 F:	Documentation/devicetree/bindings/mailbox/apple,mailbox.yaml
 F:	Documentation/devicetree/bindings/pci/apple,pcie.yaml
 F:	Documentation/devicetree/bindings/pinctrl/apple,pinctrl.yaml
