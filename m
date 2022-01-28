Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEEDE49FF8F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 18:30:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243513AbiA1R3w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 12:29:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240140AbiA1R3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 12:29:51 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 693B1C061714
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 09:29:51 -0800 (PST)
Date:   Fri, 28 Jan 2022 17:29:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1643390988;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3G8BUPQs6e9eWYZzdDzC3m5+zZhHz+4EO4BYO9m0oUQ=;
        b=pKvRVIVY2SWHPqCmkW1MwWWZ01lJD+BG5vmwuBxxOmYQ79NndIQ4ZM4WptPXYOXIih3oRJ
        c3SP6AzLTjV+iUscvBZhv8N7zENsOnXbjLxH4+vgmMqelsrHvLtsle91PsvSdDRqwbPkhk
        wvR/9S0SahLdsursIKfkqZy/+Shgtt40/WW9k8BDJInJXf/8WqBhjHgrlVv0dUVwhNShII
        T+6+aRjvViTT3g2bguxr7bTcawQvDGqENqpjwL+5LAUdE7DI6xFNF/DKpanXlB3eXi6IZ5
        +fnZxfmR0cfay8BIIhGSgbJ5oHQ5snHYTwgWZ87fNSdMJvOkVhhQNAV+tdeBpw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1643390988;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3G8BUPQs6e9eWYZzdDzC3m5+zZhHz+4EO4BYO9m0oUQ=;
        b=k1C2Odu0eZM30CEueEdJgzPqBOOykx7kJ4wCyEqgv8Hk13JeZLvyo1jtSSq0gfY321Sz21
        ETkUDgWHK6fJRVBA==
From:   "irqchip-bot for Geert Uytterhoeven" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-fixes] dt-bindings: interrupt-controller:
 sifive,plic: Group interrupt tuples
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Rob Herring <robh@kernel.org>,
        Anup Patel <anup@brainfault.org>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: =?utf-8?q?=3C211705e74a2ce77de43d036c5dea032484119bf7=2E16433?=
 =?utf-8?q?60419=2Egit=2Egeert=40linux-m68k=2Eorg=3E?=
References: =?utf-8?q?=3C211705e74a2ce77de43d036c5dea032484119bf7=2E164336?=
 =?utf-8?q?0419=2Egit=2Egeert=40linux-m68k=2Eorg=3E?=
MIME-Version: 1.0
Message-ID: <164339098727.16921.6776730133368207138.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-fixes branch of irqchip:

Commit-ID:     c89e5eb7dcf1519e5e084ee82e0d29d4e751ddb7
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/c89e5eb7dcf1519e5e084ee82e0d29d4e751ddb7
Author:        Geert Uytterhoeven <geert@linux-m68k.org>
AuthorDate:    Fri, 28 Jan 2022 10:03:58 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Fri, 28 Jan 2022 17:27:26 

dt-bindings: interrupt-controller: sifive,plic: Group interrupt tuples

To improve human readability and enable automatic validation, the tuples
in "interrupts-extended" properties should be grouped using angle
brackets.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Anup Patel <anup@brainfault.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/211705e74a2ce77de43d036c5dea032484119bf7.1643360419.git.geert@linux-m68k.org
---
 Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
index 5edaa08..058997c 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
@@ -90,12 +90,11 @@ examples:
       #interrupt-cells = <1>;
       compatible = "sifive,fu540-c000-plic", "sifive,plic-1.0.0";
       interrupt-controller;
-      interrupts-extended = <
-        &cpu0_intc 11
-        &cpu1_intc 11 &cpu1_intc 9
-        &cpu2_intc 11 &cpu2_intc 9
-        &cpu3_intc 11 &cpu3_intc 9
-        &cpu4_intc 11 &cpu4_intc 9>;
+      interrupts-extended = <&cpu0_intc 11>,
+                            <&cpu1_intc 11>, <&cpu1_intc 9>,
+                            <&cpu2_intc 11>, <&cpu2_intc 9>,
+                            <&cpu3_intc 11>, <&cpu3_intc 9>,
+                            <&cpu4_intc 11>, <&cpu4_intc 9>;
       reg = <0xc000000 0x4000000>;
       riscv,ndev = <10>;
     };
