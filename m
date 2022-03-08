Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C76304D1E03
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 17:57:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348631AbiCHQ6V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 11:58:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343921AbiCHQ5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 11:57:44 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 492FC52B28
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 08:56:47 -0800 (PST)
Date:   Tue, 08 Mar 2022 16:56:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1646758606;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=0qocFDQkih4E/aDjm6F+QxdWrYOIo51NwAdD8p5AqxA=;
        b=4qsFRlHTPE7q2liDn2wphh5ggvrpfkX7h5I5tdom0wxX4H5VyXwNsJSYMQlTtWtDD42dXJ
        40uFiblKpTLmwBSj56kPYScXIsV5ZmIMAnjuKeiip0SE/7KtHvN6U4c2zA2SEJORSk7YTe
        TYYFu0DaA+43tzdYclg765G9Bn9fwG1hJ8rdz/pFziU4nBUp4xIQTqye/CwKZNKf7p/a3Z
        T8ZsRzG/Ra83Hrhh8omBcpdzaXhE1kFmvShqYnCPXFH9Ea/HjRJgLTwx8QMPGhaVeafiqE
        1AnbezEXOgCgZVAbiqQk905r7EtQfdMi3K2OEZioWCCR3lNQdF+Su2EwYrIE+Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1646758606;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=0qocFDQkih4E/aDjm6F+QxdWrYOIo51NwAdD8p5AqxA=;
        b=fySJXBjFSjqFXpXNqyIX73h+5AlMQC3WxRV96w4jwEEAsXKrxEXx3pydmzfYRUQ3mw0GNn
        LafV1Z0v396XKODw==
From:   "irqchip-bot for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] dt-bindings: apple,aic: Add affinity
 description for per-cpu pseudo-interrupts
Cc:     Rob Herring <robh@kernel.org>, Marc Zyngier <maz@kernel.org>,
        tglx@linutronix.de
MIME-Version: 1.0
Message-ID: <164675860502.16921.10151509944058820925.tip-bot2@tip-bot2>
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

Commit-ID:     dba07ad11384d6a4ece4acda1fbe726222ca7ad0
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/dba07ad11384d6a4ece4acda1fbe726222ca7ad0
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Tue, 14 Dec 2021 16:49:04 
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Mon, 07 Feb 2022 16:00:42 

dt-bindings: apple,aic: Add affinity description for per-cpu pseudo-interrupts

Some of the FIQ per-cpu pseudo-interrupts are better described with
a specific affinity, the most obvious candidate being the CPU PMUs.

Augment the AIC binding to be able to specify that affinity in the
interrupt controller node.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 Documentation/devicetree/bindings/interrupt-controller/apple,aic.yaml | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/apple,aic.yaml b/Documentation/devicetree/bindings/interrupt-controller/apple,aic.yaml
index c7577d4..85c85b6 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/apple,aic.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/apple,aic.yaml
@@ -70,6 +70,35 @@ properties:
   power-domains:
     maxItems: 1
 
+  affinities:
+    type: object
+    additionalProperties: false
+    description:
+      FIQ affinity can be expressed as a single "affinities" node,
+      containing a set of sub-nodes, one per FIQ with a non-default
+      affinity.
+    patternProperties:
+      "^.+-affinity$":
+        type: object
+        additionalProperties: false
+        properties:
+          apple,fiq-index:
+            description:
+              The interrupt number specified as a FIQ, and for which
+              the affinity is not the default.
+            $ref: /schemas/types.yaml#/definitions/uint32
+            maximum: 5
+
+          cpus:
+            $ref: /schemas/types.yaml#/definitions/phandle-array
+            description:
+              Should be a list of phandles to CPU nodes (as described in
+              Documentation/devicetree/bindings/arm/cpus.yaml).
+
+        required:
+          - fiq-index
+          - cpus
+
 required:
   - compatible
   - '#interrupt-cells'
