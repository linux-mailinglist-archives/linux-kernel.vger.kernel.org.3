Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73F3857B569
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 13:28:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240729AbiGTL21 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 07:28:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240166AbiGTL1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 07:27:41 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBD9653D3A
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 04:27:39 -0700 (PDT)
Date:   Wed, 20 Jul 2022 11:27:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1658316458;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xJvpepCvNN2iEUapvLmvOigGRQzpthsD9JKRoBtZrAA=;
        b=Xyph+nai7hWr3aEqEgCP4ctumiWPNymfqoMmccwFf3TsMd6wLo2Ac/gTVefR0OZ3wVFwVV
        IbU2lgBmEtr0+TukUXY3FC2Fmrc2Qxhz/OzbTFf14PLusEWSEhDIiENcSGEOYBpGRFjfWb
        dDj2nh1U2gMfUUGvRkErf+tuUBLmEyYdnDSD8s/7UZpFYfMrH/+IhUDqhBK2vtgJLpoCQN
        yyuLeICVQicxlRj5KEprNlzY0OCFS8DhahmYTWnJOkiZJSgRtWQshlsROfo4AY3hRIra8C
        hOQ20lNZjw7oXYDQmA81yUxC5Br43eDrKOY7vrNFKJX3ETzilWvk8a8vErsnRA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1658316458;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xJvpepCvNN2iEUapvLmvOigGRQzpthsD9JKRoBtZrAA=;
        b=eJYx+JkLQEwJmz3v7jDsL8S45jjiH9q6tSOll1+Fxv+FWkAoLUIVhemDOWql9A8DAI8JF9
        lZsMnqakxJIL/LBw==
From:   "irqchip-bot for Jianmin Lv" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] genirq/generic_chip: Export
 irq_unmap_generic_chip
Cc:     Jianmin Lv <lvjianmin@loongson.cn>, Marc Zyngier <maz@kernel.org>,
        tglx@linutronix.de
In-Reply-To: <1658314292-35346-5-git-send-email-lvjianmin@loongson.cn>
References: <1658314292-35346-5-git-send-email-lvjianmin@loongson.cn>
MIME-Version: 1.0
Message-ID: <165831645741.15455.9752777749461101442.tip-bot2@tip-bot2>
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

Commit-ID:     d319a299f4066685a787cfb89ad36fd78bb830ed
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/d319a299f4066685a787cfb89ad36fd78bb830ed
Author:        Jianmin Lv <lvjianmin@loongson.cn>
AuthorDate:    Wed, 20 Jul 2022 18:51:23 +08:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Wed, 20 Jul 2022 12:05:55 +01:00

genirq/generic_chip: Export irq_unmap_generic_chip

Some irq controllers have to re-implement a private version for
irq_generic_chip_ops, because they have a different xlate to translate
hwirq. Export irq_unmap_generic_chip to allow reusing in drivers.

Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/1658314292-35346-5-git-send-email-lvjianmin@loongson.cn
---
 include/linux/irq.h       | 1 +
 kernel/irq/generic-chip.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index 5053082..83a4574 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -1121,6 +1121,7 @@ int irq_gc_set_wake(struct irq_data *d, unsigned int on);
 /* Setup functions for irq_chip_generic */
 int irq_map_generic_chip(struct irq_domain *d, unsigned int virq,
 			 irq_hw_number_t hw_irq);
+void irq_unmap_generic_chip(struct irq_domain *d, unsigned int virq);
 struct irq_chip_generic *
 irq_alloc_generic_chip(const char *name, int nr_ct, unsigned int irq_base,
 		       void __iomem *reg_base, irq_flow_handler_t handler);
diff --git a/kernel/irq/generic-chip.c b/kernel/irq/generic-chip.c
index f0862eb..c653cd3 100644
--- a/kernel/irq/generic-chip.c
+++ b/kernel/irq/generic-chip.c
@@ -431,7 +431,7 @@ int irq_map_generic_chip(struct irq_domain *d, unsigned int virq,
 	return 0;
 }
 
-static void irq_unmap_generic_chip(struct irq_domain *d, unsigned int virq)
+void irq_unmap_generic_chip(struct irq_domain *d, unsigned int virq)
 {
 	struct irq_data *data = irq_domain_get_irq_data(d, virq);
 	struct irq_domain_chip_generic *dgc = d->gc;
