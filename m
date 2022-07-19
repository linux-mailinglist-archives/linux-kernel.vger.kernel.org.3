Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C73357982E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 13:07:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237420AbiGSLHe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 07:07:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbiGSLHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 07:07:31 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BBD72F02C
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 04:07:30 -0700 (PDT)
Date:   Tue, 19 Jul 2022 11:07:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1658228848;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2WSG/pyZMGCHztNuz9k5QlQcA5AS5ed3fLm1aMoY9eo=;
        b=JFItsUU4e0jHQ7O1CjiRVs+oOxxlJ+LXeO3H1Gl0BEKPdlu/p2TsfEYZtmFdOa2uFOn3iv
        K848C5Ori7zVqIhfEoOWlUo1sEpkxgjBJRG91fhTJlNJnxZSbgT9MCu7gsExTNnOrBq2ZY
        ZCe0mAaMlCGEj4K/oa0CVEum/0wvDOLDllsGvDGsshQXaZqNQWi6Mqr9MTWmMaNxSgYnc3
        UcpLgc5dau7XCcXVLtdymJf/XetvqmBuyIQzWPN1UTaF/z7F7rXH3Va+QjftD+SKPnhx82
        Kf980PNHXU95xFPTFhgjeWqtvP0hmf7R1ePB/hBY0qqeQkx7FpSeIxOJ46xyNA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1658228848;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2WSG/pyZMGCHztNuz9k5QlQcA5AS5ed3fLm1aMoY9eo=;
        b=p2Qs6IWcXB1QmUb1HtkzH7vjoMv1lLYM3VmZrXCs1i1g9dj50MQjE+EDK1DeG1ZJbA9KpJ
        ct3tbD6AP4sgMOCQ==
From:   "irqchip-bot for Lad Prabhakar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] dt-bindings: interrupt-controller:
 renesas,rzg2l-irqc: Document RZ/V2L SoC
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20220718193745.7472-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220718193745.7472-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Message-ID: <165822884740.15455.18037203729518776657.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     8cfc90ecd33e73f4a30207b316bc6886e3c3a166
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/8cfc90ecd33e73f4a30207b316bc6886e3c3a166
Author:        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
AuthorDate:    Mon, 18 Jul 2022 20:37:45 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Tue, 19 Jul 2022 12:00:10 +01:00

dt-bindings: interrupt-controller: renesas,rzg2l-irqc: Document RZ/V2L SoC

Document RZ/V2L (R9A07G054) IRQC bindings. The RZ/V2L IRQC block is
identical to one found on the RZ/G2L SoC. No driver changes are
required as generic compatible string "renesas,rzg2l-irqc" will be
used as a fallback.

While at it, update the comment "# RZ/G2L" to "# RZ/G2{L,LC}" for
"renesas,r9a07g044-irqc" compatible string as both RZ/G2L and
RZ/G2LC SoC's use the common SoC DTSI and have the same IRQC block.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20220718193745.7472-1-prabhakar.mahadev-lad.rj@bp.renesas.com
---
 Documentation/devicetree/bindings/interrupt-controller/renesas,rzg2l-irqc.yaml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/renesas,rzg2l-irqc.yaml b/Documentation/devicetree/bindings/interrupt-controller/renesas,rzg2l-irqc.yaml
index ffbb4ab..33b90e9 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/renesas,rzg2l-irqc.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/renesas,rzg2l-irqc.yaml
@@ -26,7 +26,8 @@ properties:
   compatible:
     items:
       - enum:
-          - renesas,r9a07g044-irqc    # RZ/G2L
+          - renesas,r9a07g044-irqc    # RZ/G2{L,LC}
+          - renesas,r9a07g054-irqc    # RZ/V2L
       - const: renesas,rzg2l-irqc
 
   '#interrupt-cells':
