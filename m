Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 475B85635FE
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 16:42:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233510AbiGAOkK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 10:40:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbiGAOjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 10:39:44 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 997964579E
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 07:37:39 -0700 (PDT)
Date:   Fri, 01 Jul 2022 14:37:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1656686258;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jdoUxkhsyHCyU+e6iIKZT+DJuo6AyozmWw1sPzMPBrk=;
        b=zxOksHOpQBI1rBMyPD/Uzeh/OexQNWQRnLAzHrWDg5jXXMAOy33LmIFE2TV2jyASRWLAA7
        LsyKsJKIUekM1VwC/ljF/Mlc04aSFEwUtPNEitNYEFh/xb0janUTVB9oloNXC333PCkbb0
        TteiXBX3lFoOAUGmuTV6fl5UP6BfSxNfiGVUa2/XY7ieTreUicrvBy0rmiDYsqz8ndEOCW
        Bj+585QjbX8vAgi9usF/w+bISge88u497DQ+pMQQAtrRzLjWK7IAqOwXEFdaqEEXoKLGb/
        8fAETnbzy6+AWdN5bCkM2+1q1oF61eIoYIwA2hSBNEQCPux4NOLkWmhkqUJy6g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1656686258;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jdoUxkhsyHCyU+e6iIKZT+DJuo6AyozmWw1sPzMPBrk=;
        b=+SyaY7DHmwisFTVyLtmUP85H+CiIAncmejgUEo78kHXAY4I58ZIxfcmoeP6eQdA3MZYCC3
        QpoO11lOFk1lsUAQ==
From:   "irqchip-bot for Lad Prabhakar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] dt-bindings: interrupt-controller:
 sifive,plic: Document Renesas RZ/Five SoC
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Samuel Holland <samuel@sholland.org>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20220630100241.35233-2-samuel@sholland.org>
References: <20220630100241.35233-2-samuel@sholland.org>
MIME-Version: 1.0
Message-ID: <165668625702.15455.4937071980883554591.tip-bot2@tip-bot2>
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

Commit-ID:     1267d983117178b507b40c516cdcc5cceec553f9
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/1267d983117178b507b40c516cdcc5cceec553f9
Author:        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
AuthorDate:    Thu, 30 Jun 2022 05:02:38 -05:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Fri, 01 Jul 2022 15:27:23 +01:00

dt-bindings: interrupt-controller: sifive,plic: Document Renesas RZ/Five SoC

Renesas RZ/Five (R9A07G043) SoC is equipped with NCEPLIC100 RISC-V
platform level interrupt controller from Andes Technology. NCEPLIC100
ignores subsequent EDGE interrupts until the previous EDGE interrupt is
completed, due to this issue we have to follow different interrupt flow
for EDGE and LEVEL interrupts.

This patch documents Renesas RZ/Five (R9A07G043) SoC.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Signed-off-by: Samuel Holland <samuel@sholland.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20220630100241.35233-2-samuel@sholland.org
---
 Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml | 64 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 59 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
index 27092c6..cd2b8bc 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
@@ -26,9 +26,14 @@ description:
   with priority below this threshold will not cause the PLIC to raise its
   interrupt line leading to the context.
 
-  While the PLIC supports both edge-triggered and level-triggered interrupts,
-  interrupt handlers are oblivious to this distinction and therefore it is not
-  specified in the PLIC device-tree binding.
+  The PLIC supports both edge-triggered and level-triggered interrupts. For
+  edge-triggered interrupts, the RISC-V PLIC spec allows two responses to edges
+  seen while an interrupt handler is active; the PLIC may either queue them or
+  ignore them. In the first case, handlers are oblivious to the trigger type, so
+  it is not included in the interrupt specifier. In the second case, software
+  needs to know the trigger type, so it can reorder the interrupt flow to avoid
+  missing interrupts. This special handling is needed by at least the Renesas
+  RZ/Five SoC (AX45MP AndesCore with a NCEPLIC100).
 
   While the RISC-V ISA doesn't specify a memory layout for the PLIC, the
   "sifive,plic-1.0.0" device is a concrete implementation of the PLIC that
@@ -49,6 +54,10 @@ properties:
     oneOf:
       - items:
           - enum:
+              - renesas,r9a07g043-plic
+          - const: andestech,nceplic100
+      - items:
+          - enum:
               - sifive,fu540-c000-plic
               - starfive,jh7100-plic
               - canaan,k210-plic
@@ -64,8 +73,7 @@ properties:
   '#address-cells':
     const: 0
 
-  '#interrupt-cells':
-    const: 1
+  '#interrupt-cells': true
 
   interrupt-controller: true
 
@@ -82,6 +90,12 @@ properties:
     description:
       Specifies how many external interrupts are supported by this controller.
 
+  clocks: true
+
+  power-domains: true
+
+  resets: true
+
 required:
   - compatible
   - '#address-cells'
@@ -91,6 +105,46 @@ required:
   - interrupts-extended
   - riscv,ndev
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - andestech,nceplic100
+
+    then:
+      properties:
+        '#interrupt-cells':
+          const: 2
+
+    else:
+      properties:
+        '#interrupt-cells':
+          const: 1
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: renesas,r9a07g043-plic
+
+    then:
+      properties:
+        clocks:
+          maxItems: 1
+
+        power-domains:
+          maxItems: 1
+
+        resets:
+          maxItems: 1
+
+      required:
+        - clocks
+        - power-domains
+        - resets
+
 additionalProperties: false
 
 examples:
