Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A6BC51A380
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 17:15:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352084AbiEDPTW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 11:19:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351868AbiEDPTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 11:19:12 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6B3E2228E
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 08:15:36 -0700 (PDT)
Date:   Wed, 04 May 2022 15:15:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651677335;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pzyZzBGugltXzd+rtqnKrQcgpmKWUQxjUBUOBkblgtA=;
        b=H1+O79jPDLAS8HgqqLmOutoPUgkQGPc9jvw0AjIzO1XKoZj/NZzjsYxFatYunPcEJA9LzF
        al7U6o+zq1anAENGWb8FqKR/lAAylmHtaDQtKC2GLICVHsoRCw20seuTuzbJshXj6vAu1P
        veH2aeGdhKNFX3rglaoepmWLFOWAAJS59UQXDN6e/tTSjVJPGPy0rnPYDRjtzBjlsJ843d
        GsWBzAR6Ek5i5mEJLnTZeh0TKgHfedo3hQbYA4ILBrbVrZiFf18qpOazMEktfWHIdJ+3Ey
        Lx2ttVGYfGiuuwjKnzOPz7Mk+RfahBntjgVEmEGWvjbN4F/mcpo7c3vB0meqCA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651677335;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pzyZzBGugltXzd+rtqnKrQcgpmKWUQxjUBUOBkblgtA=;
        b=RDjmAQkvFrAk1JCb2nEYOUSn8mzFgmbEnZZ6kfM9si5mxXC8SYvwZx7Romux00wZEouseS
        zErD4jeC6gdwiVAQ==
From:   "irqchip-bot for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] dt-bindings: interrupt-controller:
 arm,gic-v3: Make the v2 compat requirements explicit
Cc:     Marc Zyngier <maz@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        tglx@linutronix.de
In-Reply-To: <20220409101617.268796-1-maz@kernel.org>
References: <20220409101617.268796-1-maz@kernel.org>
MIME-Version: 1.0
Message-ID: <165167733426.4207.15524217061479058702.tip-bot2@tip-bot2>
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

Commit-ID:     4053b6b43fae126bea0654493fe512d364ee9fc1
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/4053b6b43fae126bea0654493fe512d364ee9fc1
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Sat, 09 Apr 2022 11:16:17 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Wed, 04 May 2022 15:43:12 +01:00

dt-bindings: interrupt-controller: arm,gic-v3: Make the v2 compat requirements explicit

A common mistake when writing a device tree for a platform that is using
GICv3 with ancient CPUs is to overlook the MMIO frames that implement
the GICv2 compatibility feature, because this feature is implemented by
the CPUs and not by the GIC itself.

The compatibility feature itself is optional (all the modern
implementations have dropped it), but is present in all the ARM Ltd
implementations of the ARMv8.0 architecture (A3x, A53, A57, A72, A73),
and many others from various implementers.

Make it explicit that GICC, GICH and GICV are required for these CPUs.
Also take this opportunity to update my email address, as people keep
sending them to the wrong place...

Signed-off-by: Marc Zyngier <maz@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://lore.kernel.org/r/20220409101617.268796-1-maz@kernel.org
---
 Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.yaml | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.yaml b/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.yaml
index b7197f7..3912a89 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: ARM Generic Interrupt Controller, version 3
 
 maintainers:
-  - Marc Zyngier <marc.zyngier@arm.com>
+  - Marc Zyngier <maz@kernel.org>
 
 description: |
   AArch64 SMP cores are often associated with a GICv3, providing Private
@@ -78,7 +78,11 @@ properties:
       - GIC Hypervisor interface (GICH)
       - GIC Virtual CPU interface (GICV)
 
-      GICC, GICH and GICV are optional.
+      GICC, GICH and GICV are optional, but must be described if the CPUs
+      support them. Examples of such CPUs are ARM's implementations of the
+      ARMv8.0 architecture such as Cortex-A32, A34, A35, A53, A57, A72 and
+      A73 (this list is not exhaustive).
+
     minItems: 2
     maxItems: 4096   # Should be enough?
 
