Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F3EC56CE01
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 10:42:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbiGJImI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 04:42:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiGJImG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 04:42:06 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 521CE18E13
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 01:42:05 -0700 (PDT)
Date:   Sun, 10 Jul 2022 08:42:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1657442523;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Kuj9+uK8+oEXBlpOpZP+PLNEOeOuptazmGiCRlsXMwY=;
        b=bCtcYln1JOkcoR/5Yybz99Ganerozh3Ey60b1s4WdCJxnV7seLwuD54R50PmFuhnO/a6va
        Se104Y4tWyTP3WzerBUU7cFyUK+z9bWRoTsqmI/evvatFPwWgcKaX8uPHwhYrAWmsmD+h3
        Js1H44Rhsq2k4ucUsso29BsbsnVnC/IZ40TAFx/iqtIQy/zNaovZBCugpxx+cgmcY3dpGu
        JO+wXevYmzbPOPHctCXvBNdK2/33Te5h7ri1hhhWXyP+vs1kqXt+3bJJ0zFDCaO29qChXo
        BX94WvbwfcWLUBVDsaS0GuRHbB6l6fDOuQc4osnHwA7HmENriy4xJpXlZ433zw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1657442523;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Kuj9+uK8+oEXBlpOpZP+PLNEOeOuptazmGiCRlsXMwY=;
        b=93ckst3CXbI4qSM3qEhPE5k4oZwOcPgflHvGBC6GXGePN2dLKHCyVSSp5GXskHDVbWaEdc
        fgKtr0nzCdXXGIAg==
From:   "irqchip-bot for Lad Prabhakar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] dt-bindings: pinctrl:
 renesas,rzg2l-pinctrl: Document the properties to handle GPIO IRQ
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Rob Herring <robh@kernel.org>, Marc Zyngier <maz@kernel.org>,
        tglx@linutronix.de
In-Reply-To: <20220707182314.66610-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220707182314.66610-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Message-ID: <165744252232.15455.3508408173355052319.tip-bot2@tip-bot2>
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

Commit-ID:     35c37efd12733d8ddbdc11ab9c8dbcee472a487f
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/35c37efd12733d8ddbdc11ab9c8dbcee472a487f
Author:        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
AuthorDate:    Thu, 07 Jul 2022 19:23:13 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Sun, 10 Jul 2022 09:30:00 +01:00

dt-bindings: pinctrl: renesas,rzg2l-pinctrl: Document the properties to handle GPIO IRQ

Document the required properties to handle GPIO IRQ.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20220707182314.66610-6-prabhakar.mahadev-lad.rj@bp.renesas.com
---
 Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml
index 52df1b1..997b746 100644
--- a/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml
@@ -47,6 +47,17 @@ properties:
   gpio-ranges:
     maxItems: 1
 
+  interrupt-controller: true
+
+  '#interrupt-cells':
+    const: 2
+    description:
+      The first cell contains the global GPIO port index, constructed using the
+      RZG2L_GPIO() helper macro in <dt-bindings/pinctrl/rzg2l-pinctrl.h> and the
+      second cell is used to specify the flag.
+      E.g. "interrupts = <RZG2L_GPIO(43, 0) IRQ_TYPE_EDGE_FALLING>;" if P43_0 is
+      being used as an interrupt.
+
   clocks:
     maxItems: 1
 
@@ -110,6 +121,8 @@ required:
   - gpio-controller
   - '#gpio-cells'
   - gpio-ranges
+  - interrupt-controller
+  - '#interrupt-cells'
   - clocks
   - power-domains
   - resets
@@ -126,6 +139,8 @@ examples:
             gpio-controller;
             #gpio-cells = <2>;
             gpio-ranges = <&pinctrl 0 0 392>;
+            interrupt-controller;
+            #interrupt-cells = <2>;
             clocks = <&cpg CPG_MOD R9A07G044_GPIO_HCLK>;
             resets = <&cpg R9A07G044_GPIO_RSTN>,
                      <&cpg R9A07G044_GPIO_PORT_RESETN>,
