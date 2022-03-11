Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D61814D690F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 20:23:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351095AbiCKTYo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 14:24:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244959AbiCKTYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 14:24:43 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A3C415678D
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 11:23:39 -0800 (PST)
Date:   Fri, 11 Mar 2022 19:23:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1647026617;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Let7Nh+ltC0KXlPPwZd2diqdiEOdOliFXHGRWb5ONOs=;
        b=BKw1DKwB9CXTkov02MsEiAKqqrvT5stroVNK3P2b0cCBn2t8QAY/QSFclu2VOUIDUvs/Ij
        YPc6T9HhvoPNq6vNiYNjiAvdupYT7tsJpeHyZ5looz02qO7SQQrLgGrSj2C1C6CLr2kp9A
        TFzqrtcuZQrB5KOnKZ2cU6texdnaCHfQ/LtWyTarvm+WJwGulhzVzhzue4cg2poLUBl43Y
        kRQHg0qWBc9Rt4BdL20a/iVenJf4MYYY5bAfF9TyDMnc+3ltP9iwmcXB44pGoDPoiXp0Fz
        szHynP4M51NEn386Anh0g7qFcsJZfckgEqEwjOtFw/QtiXH0pyOOEN6exhvd4A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1647026617;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Let7Nh+ltC0KXlPPwZd2diqdiEOdOliFXHGRWb5ONOs=;
        b=zff39u6sNk+dzBr3876d1BBibSwtb0FEi+4TWMPIkMkFyf09ELBzMRB8BxOF1sus/r8bVX
        PMU7F6qo/NS5jJCw==
From:   "irqchip-bot for Shawn Guo" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] dt-bindings: interrupt-controller: Add
 Qualcomm MPM support
Cc:     Rob Herring <robh@kernel.org>, Shawn Guo <shawn.guo@linaro.org>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20220308080534.3384532-2-shawn.guo@linaro.org>
References: <20220308080534.3384532-2-shawn.guo@linaro.org>
MIME-Version: 1.0
Message-ID: <164702661667.16921.14374603598422037142.tip-bot2@tip-bot2>
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

Commit-ID:     54fc9851c0e0bec8012deaa87fe540d6e1739ac2
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/54fc9851c0e0bec8012deaa87fe540d6e1739ac2
Author:        Shawn Guo <shawn.guo@linaro.org>
AuthorDate:    Tue, 08 Mar 2022 16:05:33 +08:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Fri, 11 Mar 2022 19:19:46 

dt-bindings: interrupt-controller: Add Qualcomm MPM support

It adds DT binding support for Qualcomm MPM interrupt controller.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20220308080534.3384532-2-shawn.guo@linaro.org
---
 Documentation/devicetree/bindings/interrupt-controller/qcom,mpm.yaml | 96 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 96 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/qcom,mpm.yaml

diff --git a/Documentation/devicetree/bindings/interrupt-controller/qcom,mpm.yaml b/Documentation/devicetree/bindings/interrupt-controller/qcom,mpm.yaml
new file mode 100644
index 0000000..509d20c
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/qcom,mpm.yaml
@@ -0,0 +1,96 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interrupt-controller/qcom,mpm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcom MPM Interrupt Controller
+
+maintainers:
+  - Shawn Guo <shawn.guo@linaro.org>
+
+description:
+  Qualcomm Technologies Inc. SoCs based on the RPM architecture have a
+  MSM Power Manager (MPM) that is in always-on domain. In addition to managing
+  resources during sleep, the hardware also has an interrupt controller that
+  monitors the interrupts when the system is asleep, wakes up the APSS when
+  one of these interrupts occur and replays it to GIC interrupt controller
+  after GIC becomes operational.
+
+allOf:
+  - $ref: /schemas/interrupt-controller.yaml#
+
+properties:
+  compatible:
+    items:
+      - const: qcom,mpm
+
+  reg:
+    maxItems: 1
+    description:
+      Specifies the base address and size of vMPM registers in RPM MSG RAM.
+
+  interrupts:
+    maxItems: 1
+    description:
+      Specify the IRQ used by RPM to wakeup APSS.
+
+  mboxes:
+    maxItems: 1
+    description:
+      Specify the mailbox used to notify RPM for writing vMPM registers.
+
+  interrupt-controller: true
+
+  '#interrupt-cells':
+    const: 2
+    description:
+      The first cell is the MPM pin number for the interrupt, and the second
+      is the trigger type.
+
+  qcom,mpm-pin-count:
+    description:
+      Specify the total MPM pin count that a SoC supports.
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  qcom,mpm-pin-map:
+    description:
+      A set of MPM pin numbers and the corresponding GIC SPIs.
+    $ref: /schemas/types.yaml#/definitions/uint32-matrix
+    items:
+      items:
+        - description: MPM pin number
+        - description: GIC SPI number for the MPM pin
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - mboxes
+  - interrupt-controller
+  - '#interrupt-cells'
+  - qcom,mpm-pin-count
+  - qcom,mpm-pin-map
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    mpm: interrupt-controller@45f01b8 {
+        compatible = "qcom,mpm";
+        interrupts = <GIC_SPI 197 IRQ_TYPE_EDGE_RISING>;
+        reg = <0x45f01b8 0x1000>;
+        mboxes = <&apcs_glb 1>;
+        interrupt-controller;
+        #interrupt-cells = <2>;
+        interrupt-parent = <&intc>;
+        qcom,mpm-pin-count = <96>;
+        qcom,mpm-pin-map = <2 275>,
+                           <5 296>,
+                           <12 422>,
+                           <24 79>,
+                           <86 183>,
+                           <90 260>,
+                           <91 260>;
+    };
