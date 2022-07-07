Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1966569D62
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 10:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235260AbiGGISG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 04:18:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235462AbiGGIRh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 04:17:37 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 905A74D4F5
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 01:15:53 -0700 (PDT)
Date:   Thu, 07 Jul 2022 08:15:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1657181752;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KdFS58JL6opDTUu/8aQCl7c9d8q/4mTc3r99hqj5u78=;
        b=NqCx0D+gE08W7cxmrUfe+Gntx+UVItEGQrH6+PGJqutm6+bjs2rB5JkvUfpNsjBcuDwzRo
        8n2ZrxHZPx/wkpWQC06Ekw6anJBCCrcAzJ8zOLlTntKFSn+VjivXPj+fUsMw1/pzTT7Opg
        g3DSW2XqGpGu50a7Pe5HU8DdkgZD/vf155qPFYP7ah0IIjnneHxvkhF3fZJHvnh5xcityP
        sxBXTkTxg/2hYUG1zQt3lz/jQHhVuAbVNS5odUGhj1PoVHQsFmtElwkwPnSG2Elpi7C6av
        n1xEgTIoVv2AgThAkNNxkFgZdkEskWfEVmA5ghHq2CUyrjw8KfQS0a/RAUG3Lg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1657181752;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KdFS58JL6opDTUu/8aQCl7c9d8q/4mTc3r99hqj5u78=;
        b=iG2Dy/oMN9tMHa7uU0ULij+CRtpDVVYru+kGk8UqsWVfcPS2tC1i/EgHaRL5Pt2ja0y7nG
        zm0LHsTYVAVgtIAA==
From:   "irqchip-bot for Alexandre Torgue" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/stm32-exti: Tag emr register as
 undefined for stm32mp15
Cc:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Antonio Borneo <antonio.borneo@foss.st.com>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20220606162757.415354-5-antonio.borneo@foss.st.com>
References: <20220606162757.415354-5-antonio.borneo@foss.st.com>
MIME-Version: 1.0
Message-ID: <165718175115.15455.1124991171251735730.tip-bot2@tip-bot2>
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

Commit-ID:     b38040f0167d25092e813c8d1a70cf2708c1720b
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/b38040f0167d25092e813c8d1a70cf2708c1720b
Author:        Alexandre Torgue <alexandre.torgue@foss.st.com>
AuthorDate:    Mon, 06 Jun 2022 18:27:55 +02:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Thu, 07 Jul 2022 09:07:44 +01:00

irqchip/stm32-exti: Tag emr register as undefined for stm32mp15

The reference manual RM0436 of stm32mp15 till version v4.0 was
erroneously reporting the Event Mask Registers (EMR) for the
Cortex-A CPUs.
These registers have been removed from v5.0 of the manual and the
corresponding offsets have been marked as 'Reserved'.

Prevent accessing these reserved addresses by tagging the EMR
offsets as UNDEF_REG and modifying the code to handle this case.

Signed-off-by: Alexandre Torgue <alexandre.torgue@foss.st.com>
Signed-off-by: Antonio Borneo <antonio.borneo@foss.st.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20220606162757.415354-5-antonio.borneo@foss.st.com
---
 drivers/irqchip/irq-stm32-exti.c |  9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-stm32-exti.c b/drivers/irqchip/irq-stm32-exti.c
index e2722e4..e8fa91b 100644
--- a/drivers/irqchip/irq-stm32-exti.c
+++ b/drivers/irqchip/irq-stm32-exti.c
@@ -132,7 +132,7 @@ static const struct stm32_exti_drv_data stm32h7xx_drv_data = {
 
 static const struct stm32_exti_bank stm32mp1_exti_b1 = {
 	.imr_ofst	= 0x80,
-	.emr_ofst	= 0x84,
+	.emr_ofst	= UNDEF_REG,
 	.rtsr_ofst	= 0x00,
 	.ftsr_ofst	= 0x04,
 	.swier_ofst	= 0x08,
@@ -142,7 +142,7 @@ static const struct stm32_exti_bank stm32mp1_exti_b1 = {
 
 static const struct stm32_exti_bank stm32mp1_exti_b2 = {
 	.imr_ofst	= 0x90,
-	.emr_ofst	= 0x94,
+	.emr_ofst	= UNDEF_REG,
 	.rtsr_ofst	= 0x20,
 	.ftsr_ofst	= 0x24,
 	.swier_ofst	= 0x28,
@@ -152,7 +152,7 @@ static const struct stm32_exti_bank stm32mp1_exti_b2 = {
 
 static const struct stm32_exti_bank stm32mp1_exti_b3 = {
 	.imr_ofst	= 0xA0,
-	.emr_ofst	= 0xA4,
+	.emr_ofst	= UNDEF_REG,
 	.rtsr_ofst	= 0x40,
 	.ftsr_ofst	= 0x44,
 	.swier_ofst	= 0x48,
@@ -795,7 +795,8 @@ stm32_exti_chip_data *stm32_exti_chip_init(struct stm32_exti_host_data *h_data,
 	 * clear registers to avoid residue
 	 */
 	writel_relaxed(0, base + stm32_bank->imr_ofst);
-	writel_relaxed(0, base + stm32_bank->emr_ofst);
+	if (stm32_bank->emr_ofst != UNDEF_REG)
+		writel_relaxed(0, base + stm32_bank->emr_ofst);
 
 	pr_info("%pOF: bank%d\n", node, bank_idx);
 
