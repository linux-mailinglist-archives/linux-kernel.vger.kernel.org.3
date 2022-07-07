Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A15A569D3B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 10:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235315AbiGGISQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 04:18:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235472AbiGGIRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 04:17:38 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F96C4F184
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 01:15:53 -0700 (PDT)
Date:   Thu, 07 Jul 2022 08:15:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1657181751;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zOjbE42rCqNNQLultXJq2+U98Tm8CUZFvwSacMjZlO8=;
        b=cvto/H8lHvgRFf7jK48uRN3i6AbUdAhbNp7YiG5NhHJVCk5t6et4SNQoxN7wq2MPfRygb0
        ImC1E4jnUDs8gxkZHXWKs2ZpmdPVix5csnusUpzWf836p/bE9ZF5251c62ITj+LMmbz+85
        G950aO5372rRZGgY7gQ2oRd2KsPTLZWq7rbjCklEEJigyIMqfLuJi9n6wVGo5CEYWN4bCq
        EoqLdygpQkI5ZUJBh7kUpKTCefG3QL70yFmzEAk4+Y09ggKnLzgLVfrgzRhuT76xZdrHEo
        Cnau2WlyWoXdwDQWD9dP7ZSDaLTRQ85sgPKZWW+sD3l2p8pAFJp/+XxHPXcD8g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1657181751;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zOjbE42rCqNNQLultXJq2+U98Tm8CUZFvwSacMjZlO8=;
        b=PprxF8XrT6sVPXSHuilC/cHWIFsDs5VaxZRxl/iC6eBsAk68nLUBGouc5DZtCbVyVW5KQa
        hfkI4cZo/jHFDzAQ==
From:   "irqchip-bot for Antonio Borneo" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/stm32-exti: Simplify irq
 description table
Cc:     Antonio Borneo <antonio.borneo@foss.st.com>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20220606162757.415354-7-antonio.borneo@foss.st.com>
References: <20220606162757.415354-7-antonio.borneo@foss.st.com>
MIME-Version: 1.0
Message-ID: <165718174766.15455.9980147029659469480.tip-bot2@tip-bot2>
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

Commit-ID:     c297493336b7bc0c12ced484a9e61d04ec2d9403
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/c297493336b7bc0c12ced484a9e61d04ec2d9403
Author:        Antonio Borneo <antonio.borneo@foss.st.com>
AuthorDate:    Mon, 06 Jun 2022 18:27:57 +02:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Thu, 07 Jul 2022 09:07:44 +01:00

irqchip/stm32-exti: Simplify irq description table

Having removed the event trigger type from struct stm32_desc_irq
makes worthless keep using a struct.

Replace the struct by a single dimension array and use 8 bit type
to reduce the overal memory footprint.
On armv7a this patch reduces by 7% the size of the driver, from
   text    data     bss     dec     hex filename
   6977     424       4    7405    1ced irq-stm32-exti.o
to
   6449     424       4    6877    1add irq-stm32-exti.o

Signed-off-by: Antonio Borneo <antonio.borneo@foss.st.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20220606162757.415354-7-antonio.borneo@foss.st.com
---
 drivers/irqchip/irq-stm32-exti.c | 220 +++++++++++++-----------------
 1 file changed, 101 insertions(+), 119 deletions(-)

diff --git a/drivers/irqchip/irq-stm32-exti.c b/drivers/irqchip/irq-stm32-exti.c
index 0455896..a73763d 100644
--- a/drivers/irqchip/irq-stm32-exti.c
+++ b/drivers/irqchip/irq-stm32-exti.c
@@ -39,16 +39,10 @@ struct stm32_exti_bank {
 
 #define UNDEF_REG ~0
 
-struct stm32_desc_irq {
-	u32 exti;
-	u32 irq_parent;
-};
-
 struct stm32_exti_drv_data {
 	const struct stm32_exti_bank **exti_banks;
-	const struct stm32_desc_irq *desc_irqs;
+	const u8 *desc_irqs;
 	u32 bank_nr;
-	u32 irq_nr;
 };
 
 struct stm32_exti_chip_data {
@@ -176,126 +170,114 @@ static const struct stm32_exti_bank *stm32mp1_exti_banks[] = {
 static struct irq_chip stm32_exti_h_chip;
 static struct irq_chip stm32_exti_h_chip_direct;
 
-static const struct stm32_desc_irq stm32mp1_desc_irq[] = {
-	{ .exti = 0, .irq_parent = 6 },
-	{ .exti = 1, .irq_parent = 7 },
-	{ .exti = 2, .irq_parent = 8 },
-	{ .exti = 3, .irq_parent = 9 },
-	{ .exti = 4, .irq_parent = 10 },
-	{ .exti = 5, .irq_parent = 23 },
-	{ .exti = 6, .irq_parent = 64 },
-	{ .exti = 7, .irq_parent = 65 },
-	{ .exti = 8, .irq_parent = 66 },
-	{ .exti = 9, .irq_parent = 67 },
-	{ .exti = 10, .irq_parent = 40 },
-	{ .exti = 11, .irq_parent = 42 },
-	{ .exti = 12, .irq_parent = 76 },
-	{ .exti = 13, .irq_parent = 77 },
-	{ .exti = 14, .irq_parent = 121 },
-	{ .exti = 15, .irq_parent = 127 },
-	{ .exti = 16, .irq_parent = 1 },
-	{ .exti = 19, .irq_parent = 3 },
-	{ .exti = 21, .irq_parent = 31 },
-	{ .exti = 22, .irq_parent = 33 },
-	{ .exti = 23, .irq_parent = 72 },
-	{ .exti = 24, .irq_parent = 95 },
-	{ .exti = 25, .irq_parent = 107 },
-	{ .exti = 26, .irq_parent = 37 },
-	{ .exti = 27, .irq_parent = 38 },
-	{ .exti = 28, .irq_parent = 39 },
-	{ .exti = 29, .irq_parent = 71 },
-	{ .exti = 30, .irq_parent = 52 },
-	{ .exti = 31, .irq_parent = 53 },
-	{ .exti = 32, .irq_parent = 82 },
-	{ .exti = 33, .irq_parent = 83 },
-	{ .exti = 47, .irq_parent = 93 },
-	{ .exti = 48, .irq_parent = 138 },
-	{ .exti = 50, .irq_parent = 139 },
-	{ .exti = 52, .irq_parent = 140 },
-	{ .exti = 53, .irq_parent = 141 },
-	{ .exti = 54, .irq_parent = 135 },
-	{ .exti = 61, .irq_parent = 100 },
-	{ .exti = 65, .irq_parent = 144 },
-	{ .exti = 68, .irq_parent = 143 },
-	{ .exti = 70, .irq_parent = 62 },
-	{ .exti = 73, .irq_parent = 129 },
+#define EXTI_INVALID_IRQ       U8_MAX
+#define STM32MP1_DESC_IRQ_SIZE (ARRAY_SIZE(stm32mp1_exti_banks) * IRQS_PER_BANK)
+
+static const u8 stm32mp1_desc_irq[] = {
+	/* default value */
+	[0 ... (STM32MP1_DESC_IRQ_SIZE - 1)] = EXTI_INVALID_IRQ,
+
+	[0] = 6,
+	[1] = 7,
+	[2] = 8,
+	[3] = 9,
+	[4] = 10,
+	[5] = 23,
+	[6] = 64,
+	[7] = 65,
+	[8] = 66,
+	[9] = 67,
+	[10] = 40,
+	[11] = 42,
+	[12] = 76,
+	[13] = 77,
+	[14] = 121,
+	[15] = 127,
+	[16] = 1,
+	[19] = 3,
+	[21] = 31,
+	[22] = 33,
+	[23] = 72,
+	[24] = 95,
+	[25] = 107,
+	[26] = 37,
+	[27] = 38,
+	[28] = 39,
+	[29] = 71,
+	[30] = 52,
+	[31] = 53,
+	[32] = 82,
+	[33] = 83,
+	[47] = 93,
+	[48] = 138,
+	[50] = 139,
+	[52] = 140,
+	[53] = 141,
+	[54] = 135,
+	[61] = 100,
+	[65] = 144,
+	[68] = 143,
+	[70] = 62,
+	[73] = 129,
 };
 
-static const struct stm32_desc_irq stm32mp13_desc_irq[] = {
-	{ .exti = 0, .irq_parent = 6 },
-	{ .exti = 1, .irq_parent = 7 },
-	{ .exti = 2, .irq_parent = 8 },
-	{ .exti = 3, .irq_parent = 9 },
-	{ .exti = 4, .irq_parent = 10 },
-	{ .exti = 5, .irq_parent = 24 },
-	{ .exti = 6, .irq_parent = 65 },
-	{ .exti = 7, .irq_parent = 66 },
-	{ .exti = 8, .irq_parent = 67 },
-	{ .exti = 9, .irq_parent = 68 },
-	{ .exti = 10, .irq_parent = 41 },
-	{ .exti = 11, .irq_parent = 43 },
-	{ .exti = 12, .irq_parent = 77 },
-	{ .exti = 13, .irq_parent = 78 },
-	{ .exti = 14, .irq_parent = 106 },
-	{ .exti = 15, .irq_parent = 109 },
-	{ .exti = 16, .irq_parent = 1 },
-	{ .exti = 19, .irq_parent = 3 },
-	{ .exti = 21, .irq_parent = 32 },
-	{ .exti = 22, .irq_parent = 34 },
-	{ .exti = 23, .irq_parent = 73 },
-	{ .exti = 24, .irq_parent = 93 },
-	{ .exti = 25, .irq_parent = 114 },
-	{ .exti = 26, .irq_parent = 38 },
-	{ .exti = 27, .irq_parent = 39 },
-	{ .exti = 28, .irq_parent = 40 },
-	{ .exti = 29, .irq_parent = 72 },
-	{ .exti = 30, .irq_parent = 53 },
-	{ .exti = 31, .irq_parent = 54 },
-	{ .exti = 32, .irq_parent = 83 },
-	{ .exti = 33, .irq_parent = 84 },
-	{ .exti = 44, .irq_parent = 96 },
-	{ .exti = 47, .irq_parent = 92 },
-	{ .exti = 48, .irq_parent = 116 },
-	{ .exti = 50, .irq_parent = 117 },
-	{ .exti = 52, .irq_parent = 118 },
-	{ .exti = 53, .irq_parent = 119 },
-	{ .exti = 68, .irq_parent = 63 },
-	{ .exti = 70, .irq_parent = 98 },
+static const u8 stm32mp13_desc_irq[] = {
+	/* default value */
+	[0 ... (STM32MP1_DESC_IRQ_SIZE - 1)] = EXTI_INVALID_IRQ,
+
+	[0] = 6,
+	[1] = 7,
+	[2] = 8,
+	[3] = 9,
+	[4] = 10,
+	[5] = 24,
+	[6] = 65,
+	[7] = 66,
+	[8] = 67,
+	[9] = 68,
+	[10] = 41,
+	[11] = 43,
+	[12] = 77,
+	[13] = 78,
+	[14] = 106,
+	[15] = 109,
+	[16] = 1,
+	[19] = 3,
+	[21] = 32,
+	[22] = 34,
+	[23] = 73,
+	[24] = 93,
+	[25] = 114,
+	[26] = 38,
+	[27] = 39,
+	[28] = 40,
+	[29] = 72,
+	[30] = 53,
+	[31] = 54,
+	[32] = 83,
+	[33] = 84,
+	[44] = 96,
+	[47] = 92,
+	[48] = 116,
+	[50] = 117,
+	[52] = 118,
+	[53] = 119,
+	[68] = 63,
+	[70] = 98,
 };
 
 static const struct stm32_exti_drv_data stm32mp1_drv_data = {
 	.exti_banks = stm32mp1_exti_banks,
 	.bank_nr = ARRAY_SIZE(stm32mp1_exti_banks),
 	.desc_irqs = stm32mp1_desc_irq,
-	.irq_nr = ARRAY_SIZE(stm32mp1_desc_irq),
 };
 
 static const struct stm32_exti_drv_data stm32mp13_drv_data = {
 	.exti_banks = stm32mp1_exti_banks,
 	.bank_nr = ARRAY_SIZE(stm32mp1_exti_banks),
 	.desc_irqs = stm32mp13_desc_irq,
-	.irq_nr = ARRAY_SIZE(stm32mp13_desc_irq),
 };
 
-static const struct
-stm32_desc_irq *stm32_exti_get_desc(const struct stm32_exti_drv_data *drv_data,
-				    irq_hw_number_t hwirq)
-{
-	const struct stm32_desc_irq *desc = NULL;
-	int i;
-
-	if (!drv_data->desc_irqs)
-		return NULL;
-
-	for (i = 0; i < drv_data->irq_nr; i++) {
-		desc = &drv_data->desc_irqs[i];
-		if (desc->exti == hwirq)
-			break;
-	}
-
-	return desc;
-}
-
 static unsigned long stm32_exti_pending(struct irq_chip_generic *gc)
 {
 	struct stm32_exti_chip_data *chip_data = gc->private;
@@ -713,7 +695,7 @@ static int stm32_exti_h_domain_alloc(struct irq_domain *dm,
 {
 	struct stm32_exti_host_data *host_data = dm->host_data;
 	struct stm32_exti_chip_data *chip_data;
-	const struct stm32_desc_irq *desc;
+	u8 desc_irq;
 	struct irq_fwspec *fwspec = data;
 	struct irq_fwspec p_fwspec;
 	irq_hw_number_t hwirq;
@@ -728,21 +710,21 @@ static int stm32_exti_h_domain_alloc(struct irq_domain *dm,
 	bank  = hwirq / IRQS_PER_BANK;
 	chip_data = &host_data->chips_data[bank];
 
-
-	desc = stm32_exti_get_desc(host_data->drv_data, hwirq);
-	if (!desc)
-		return -EINVAL;
-
 	event_trg = readl_relaxed(host_data->base + chip_data->reg_bank->trg_ofst);
 	chip = (event_trg & BIT(hwirq % IRQS_PER_BANK)) ?
 	       &stm32_exti_h_chip : &stm32_exti_h_chip_direct;
 
 	irq_domain_set_hwirq_and_chip(dm, virq, hwirq, chip, chip_data);
-	if (desc->irq_parent) {
+
+	if (!host_data->drv_data || !host_data->drv_data->desc_irqs)
+		return -EINVAL;
+
+	desc_irq = host_data->drv_data->desc_irqs[hwirq];
+	if (desc_irq != EXTI_INVALID_IRQ) {
 		p_fwspec.fwnode = dm->parent->fwnode;
 		p_fwspec.param_count = 3;
 		p_fwspec.param[0] = GIC_SPI;
-		p_fwspec.param[1] = desc->irq_parent;
+		p_fwspec.param[1] = desc_irq;
 		p_fwspec.param[2] = IRQ_TYPE_LEVEL_HIGH;
 
 		return irq_domain_alloc_irqs_parent(dm, virq, 1, &p_fwspec);
