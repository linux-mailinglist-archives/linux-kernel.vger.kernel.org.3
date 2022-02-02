Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44E1A4A6F39
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 11:55:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343558AbiBBKxT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 05:53:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245709AbiBBKxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 05:53:15 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B91FC061714
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 02:53:14 -0800 (PST)
Date:   Wed, 02 Feb 2022 10:53:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1643799193;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q+pYdL8GgbTSFRMCnYz1Eu7aFcukfwsJ3mc97NcLmm0=;
        b=2urrzPaDlWxKahSjUkh1bsdYRfMUOK9PPHrIUhuwKzZPYlukr3WRgZHBCiid8Xrm3pff0g
        +jqxqqrQkKDkwOSl1CJo+A3WZfxTid3Zoz6sU2IZoAxDn8N01x5kGq6LWjT8506BXI35Zi
        j8XxJDPzojkEH520eNQbwSWoXX+91vp5N76GcqIkzwegT6Styo/3aXLTM0u2T0NtAAVpoo
        Y/xe6li5nFbBu+cCpaIcjmWJoaOqg9sC/otx+BzDt/Yj79yeujnmRl4fXWrzGWoSqF7o5d
        vM8onZKiA9XqqKgZYw3xhCLevAGBnAPa6juFi9E43WWE8IjoRWEm8DKKSe6R/g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1643799193;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q+pYdL8GgbTSFRMCnYz1Eu7aFcukfwsJ3mc97NcLmm0=;
        b=OWZ8YBjzzOlpFPOC1aVBdYN+GGzdH7CxxfZKgcbabUlv7PmfUZV95acmqLmUd7wQ6p5pAr
        56rCSu5/rVhUAkCA==
From:   "irqchip-bot for Guo Ren" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-fixes] dt-bindings: update riscv plic compatible string
Cc:     Guo Ren <guoren@linux.alibaba.com>,
        Anup Patel <anup@brainfault.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Rob Herring <robh@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Samuel Holland <samuel@sholland.org>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20220130135634.1213301-2-guoren@kernel.org>
References: <20220130135634.1213301-2-guoren@kernel.org>
MIME-Version: 1.0
Message-ID: <164379919219.16921.17083588550151120882.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-fixes branch of irqchip:

Commit-ID:     321a8be37e1a93cefeae990107533142c8515933
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/321a8be37e1a93cefeae990107533142c8515933
Author:        Guo Ren <guoren@linux.alibaba.com>
AuthorDate:    Sun, 30 Jan 2022 21:56:33 +08:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Wed, 02 Feb 2022 10:48:50 

dt-bindings: update riscv plic compatible string

Add the compatible string "thead,c900-plic" to the riscv plic
bindings to support allwinner d1 SOC which contains c906 core.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Cc: Anup Patel <anup@brainfault.org>
Cc: Heiko Stuebner <heiko@sntech.de>
Cc: Rob Herring <robh@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Samuel Holland <samuel@sholland.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20220130135634.1213301-2-guoren@kernel.org
---
 Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
index 0dfa6b2..27092c6 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
@@ -35,6 +35,10 @@ description:
   contains a specific memory layout, which is documented in chapter 8 of the
   SiFive U5 Coreplex Series Manual <https://static.dev.sifive.com/U54-MC-RVCoreIP.pdf>.
 
+  The thead,c900-plic is different from sifive,plic-1.0.0 in opensbi, the
+  T-HEAD PLIC implementation requires setting a delegation bit to allow access
+  from S-mode. So add thead,c900-plic to distinguish them.
+
 maintainers:
   - Sagar Kadam <sagar.kadam@sifive.com>
   - Paul Walmsley  <paul.walmsley@sifive.com>
@@ -42,12 +46,17 @@ maintainers:
 
 properties:
   compatible:
-    items:
-      - enum:
-          - sifive,fu540-c000-plic
-          - starfive,jh7100-plic
-          - canaan,k210-plic
-      - const: sifive,plic-1.0.0
+    oneOf:
+      - items:
+          - enum:
+              - sifive,fu540-c000-plic
+              - starfive,jh7100-plic
+              - canaan,k210-plic
+          - const: sifive,plic-1.0.0
+      - items:
+          - enum:
+              - allwinner,sun20i-d1-plic
+          - const: thead,c900-plic
 
   reg:
     maxItems: 1
