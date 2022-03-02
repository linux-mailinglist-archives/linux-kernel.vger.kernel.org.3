Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 587594CA62D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 14:41:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242308AbiCBNlm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 08:41:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242294AbiCBNli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 08:41:38 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F9E53B031
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 05:40:55 -0800 (PST)
Date:   Wed, 02 Mar 2022 13:40:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1646228453;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tPJ4/hguBFMmNTO6QHA0goQYGLlF7DAvZPqyZYsQv/o=;
        b=kmtUmjo9e8PkaZU3HrRtyNxsJuLVHbTYmlEns4VYyD8FPliUhIzE91rhR+ds47HqGQWEN8
        r+d1gUlPLDsb2jK7jnBYPmBGe4FjjUz4eWKBNDxGTbtVMfDQYYn5xQHohZW65QplApIYPY
        IFQsLoEMs3CFJ8pATSpit5WCGtGFEhXfRKa19j8vfFHpkTImDZc9VO+wOQv9QYtyOD7DAM
        UduH8hyaCJ0jWLXagcYj14axrQ7y/1LIyOmxpeLReBt6oMP5fPoX+57ZFc/cbaEPMSgTSW
        FrBmdqFHD6JIIpj2mvO3bwBCWA6GA+I7/+Cxr8GIpSpUqVqGgKCLUhlPAIxpRQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1646228453;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tPJ4/hguBFMmNTO6QHA0goQYGLlF7DAvZPqyZYsQv/o=;
        b=nG+7XscATcU2dF2Oww4bH6MwC8jJNPoJxEZROKyiOGuN2f7sPLfSZlVAfsUtaet5lX1Baq
        Ba84MiWfULI2D4AQ==
From:   "irqchip-bot for Niklas Cassel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/sifive-plic: Improve naming
 scheme for per context offsets
Cc:     Niklas Cassel <niklas.cassel@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20220302131544.3166154-2-Niklas.Cassel@wdc.com>
References: <20220302131544.3166154-2-Niklas.Cassel@wdc.com>
MIME-Version: 1.0
Message-ID: <164622845252.16921.8921377772859964481.tip-bot2@tip-bot2>
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

Commit-ID:     0d3616bbd03cdfaa8a5fdf38e0fec2b1ef6ec0a0
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/0d3616bbd03cdfaa8a5fdf38e0fec2b1ef6ec0a0
Author:        Niklas Cassel <niklas.cassel@wdc.com>
AuthorDate:    Wed, 02 Mar 2022 13:15:52 
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Wed, 02 Mar 2022 13:30:50 

irqchip/sifive-plic: Improve naming scheme for per context offsets

The PLIC supports a fixed number of contexts (15872).
Each context has fixed register offsets in PLIC.

The number of contexts that we need to initialize depends on the privilege
modes supported by each hart. Therefore, this mapping between PLIC context
registers to hart privilege modes is platform specific, and is currently
supplied via device tree.

For example, canaan,k210 has the following mapping:
Context0: hart0 M-mode
Context1: hart0 S-mode
Context2: hart1 M-mode
Context3: hart1 S-mode

While sifive,fu540 has the following mapping:
Context0: hart0 M-mode
Context1: hart1 M-mode
Context2: hart1 S-mode

Because the number of contexts per hart is not fixed, the names
ENABLE_PER_HART and CONTEXT_PER_HART for the register offsets are quite
confusing and might mislead the reader to think that these are fixed
register offsets per hart.

Rename the offsets to more clearly highlight that these are per PLIC
context and not per hart.

Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
Reviewed-by: Anup Patel <anup@brainfault.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20220302131544.3166154-2-Niklas.Cassel@wdc.com
---
 drivers/irqchip/irq-sifive-plic.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index 259065d..28b86cd 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -44,8 +44,8 @@
  * Each hart context has a vector of interrupt enable bits associated with it.
  * There's one bit for each interrupt source.
  */
-#define ENABLE_BASE			0x2000
-#define     ENABLE_PER_HART		0x80
+#define CONTEXT_ENABLE_BASE		0x2000
+#define     CONTEXT_ENABLE_SIZE		0x80
 
 /*
  * Each hart context has a set of control registers associated with it.  Right
@@ -53,7 +53,7 @@
  * take an interrupt, and a register to claim interrupts.
  */
 #define CONTEXT_BASE			0x200000
-#define     CONTEXT_PER_HART		0x1000
+#define     CONTEXT_SIZE		0x1000
 #define     CONTEXT_THRESHOLD		0x00
 #define     CONTEXT_CLAIM		0x04
 
@@ -361,11 +361,11 @@ static int __init plic_init(struct device_node *node,
 
 		cpumask_set_cpu(cpu, &priv->lmask);
 		handler->present = true;
-		handler->hart_base =
-			priv->regs + CONTEXT_BASE + i * CONTEXT_PER_HART;
+		handler->hart_base = priv->regs + CONTEXT_BASE +
+			i * CONTEXT_SIZE;
 		raw_spin_lock_init(&handler->enable_lock);
-		handler->enable_base =
-			priv->regs + ENABLE_BASE + i * ENABLE_PER_HART;
+		handler->enable_base = priv->regs + CONTEXT_ENABLE_BASE +
+			i * CONTEXT_ENABLE_SIZE;
 		handler->priv = priv;
 done:
 		for (hwirq = 1; hwirq <= nr_irqs; hwirq++)
