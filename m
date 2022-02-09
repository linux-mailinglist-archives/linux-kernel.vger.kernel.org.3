Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CA7A4AF658
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 17:18:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236265AbiBIQRz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 11:17:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232050AbiBIQRt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 11:17:49 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3875AC061355
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 08:17:52 -0800 (PST)
Date:   Wed, 09 Feb 2022 16:17:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1644423470;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MIAzogYAv6v+6hICEIrQlX4VcOOC/GW4tmJ2nBSpYHg=;
        b=rrIcW3a94AbAAGtf2iHrRM2oIK5LYLBIoMNGlY/QruGUfwo5xGBi9aywBcZ+2ZCx/1dsy5
        uirpm685yYgMe3NOz8nuM3+mG3TlA6uAzLZoHNTU2B8rWLQCsuqJALc+iYGljVZ1ggZrvU
        QC5rWJAr1A0jlErQTuZ4eQWKZSPdxh/eLLaxaTCmozM3Zxg1DqXWoevBjiQ27MkqF9F/4j
        N81KHb3KxVOs8MKMi7qEM5PvH3LW+OXFxQxK/DEpd1vALWN06nzgbIoFYoa2z5Lqk4FvpO
        HD1DNfMJ6YFs8h7/0zAk1WPhpOPANp2x/hf2Gccpe4QvUMYvMfpGX1Z7cpyO+A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1644423470;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MIAzogYAv6v+6hICEIrQlX4VcOOC/GW4tmJ2nBSpYHg=;
        b=05bXof0fc38lSmJ2eCSx0PhbwZtvMsfTeP/hNd+2MLZYMutHLAi253uPIOR784KaQ7sLCy
        4ZDFl2Bri317CAAw==
From:   "irqchip-bot for Alexandre Torgue" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/stm32-exti: Add STM32MP13 support
Cc:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20220202140005.860-3-alexandre.torgue@foss.st.com>
References: <20220202140005.860-3-alexandre.torgue@foss.st.com>
MIME-Version: 1.0
Message-ID: <164442346932.16921.10963525223069470489.tip-bot2@tip-bot2>
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

Commit-ID:     04133bb1e710bc3d5532694999fbb3d0f1421724
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/04133bb1e710bc3d5532694999fbb3d0f1421724
Author:        Alexandre Torgue <alexandre.torgue@foss.st.com>
AuthorDate:    Wed, 02 Feb 2022 15:00:04 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Wed, 09 Feb 2022 13:43:07 

irqchip/stm32-exti: Add STM32MP13 support

Enhance stm32-exti driver to support STM32MP13 SoC. This SoC uses the same
hardware version than STM32MP15. Only EXTI line mapping is changed and
following EXTI lines are supported: GPIO, RTC, I2C[1-5], UxART[1-8],
USBH_EHCI, USBH_OHCI, USB_OTG, LPTIM[1-5], ETH[1-2].

Signed-off-by: Alexandre Torgue <alexandre.torgue@foss.st.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20220202140005.860-3-alexandre.torgue@foss.st.com
---
 drivers/irqchip/irq-stm32-exti.c | 50 +++++++++++++++++++++++++++++++-
 1 file changed, 50 insertions(+)

diff --git a/drivers/irqchip/irq-stm32-exti.c b/drivers/irqchip/irq-stm32-exti.c
index b7cb2da..9d18f47 100644
--- a/drivers/irqchip/irq-stm32-exti.c
+++ b/drivers/irqchip/irq-stm32-exti.c
@@ -214,6 +214,48 @@ static const struct stm32_desc_irq stm32mp1_desc_irq[] = {
 	{ .exti = 73, .irq_parent = 129, .chip = &stm32_exti_h_chip },
 };
 
+static const struct stm32_desc_irq stm32mp13_desc_irq[] = {
+	{ .exti = 0, .irq_parent = 6, .chip = &stm32_exti_h_chip },
+	{ .exti = 1, .irq_parent = 7, .chip = &stm32_exti_h_chip },
+	{ .exti = 2, .irq_parent = 8, .chip = &stm32_exti_h_chip },
+	{ .exti = 3, .irq_parent = 9, .chip = &stm32_exti_h_chip },
+	{ .exti = 4, .irq_parent = 10, .chip = &stm32_exti_h_chip },
+	{ .exti = 5, .irq_parent = 24, .chip = &stm32_exti_h_chip },
+	{ .exti = 6, .irq_parent = 65, .chip = &stm32_exti_h_chip },
+	{ .exti = 7, .irq_parent = 66, .chip = &stm32_exti_h_chip },
+	{ .exti = 8, .irq_parent = 67, .chip = &stm32_exti_h_chip },
+	{ .exti = 9, .irq_parent = 68, .chip = &stm32_exti_h_chip },
+	{ .exti = 10, .irq_parent = 41, .chip = &stm32_exti_h_chip },
+	{ .exti = 11, .irq_parent = 43, .chip = &stm32_exti_h_chip },
+	{ .exti = 12, .irq_parent = 77, .chip = &stm32_exti_h_chip },
+	{ .exti = 13, .irq_parent = 78, .chip = &stm32_exti_h_chip },
+	{ .exti = 14, .irq_parent = 106, .chip = &stm32_exti_h_chip },
+	{ .exti = 15, .irq_parent = 109, .chip = &stm32_exti_h_chip },
+	{ .exti = 16, .irq_parent = 1, .chip = &stm32_exti_h_chip },
+	{ .exti = 19, .irq_parent = 3, .chip = &stm32_exti_h_chip_direct },
+	{ .exti = 21, .irq_parent = 32, .chip = &stm32_exti_h_chip_direct },
+	{ .exti = 22, .irq_parent = 34, .chip = &stm32_exti_h_chip_direct },
+	{ .exti = 23, .irq_parent = 73, .chip = &stm32_exti_h_chip_direct },
+	{ .exti = 24, .irq_parent = 93, .chip = &stm32_exti_h_chip_direct },
+	{ .exti = 25, .irq_parent = 114, .chip = &stm32_exti_h_chip_direct },
+	{ .exti = 26, .irq_parent = 38, .chip = &stm32_exti_h_chip_direct },
+	{ .exti = 27, .irq_parent = 39, .chip = &stm32_exti_h_chip_direct },
+	{ .exti = 28, .irq_parent = 40, .chip = &stm32_exti_h_chip_direct },
+	{ .exti = 29, .irq_parent = 72, .chip = &stm32_exti_h_chip_direct },
+	{ .exti = 30, .irq_parent = 53, .chip = &stm32_exti_h_chip_direct },
+	{ .exti = 31, .irq_parent = 54, .chip = &stm32_exti_h_chip_direct },
+	{ .exti = 32, .irq_parent = 83, .chip = &stm32_exti_h_chip_direct },
+	{ .exti = 33, .irq_parent = 84, .chip = &stm32_exti_h_chip_direct },
+	{ .exti = 44, .irq_parent = 96, .chip = &stm32_exti_h_chip_direct },
+	{ .exti = 47, .irq_parent = 92, .chip = &stm32_exti_h_chip_direct },
+	{ .exti = 48, .irq_parent = 116, .chip = &stm32_exti_h_chip_direct },
+	{ .exti = 50, .irq_parent = 117, .chip = &stm32_exti_h_chip_direct },
+	{ .exti = 52, .irq_parent = 118, .chip = &stm32_exti_h_chip_direct },
+	{ .exti = 53, .irq_parent = 119, .chip = &stm32_exti_h_chip_direct },
+	{ .exti = 68, .irq_parent = 63, .chip = &stm32_exti_h_chip_direct },
+	{ .exti = 70, .irq_parent = 98, .chip = &stm32_exti_h_chip_direct },
+};
+
 static const struct stm32_exti_drv_data stm32mp1_drv_data = {
 	.exti_banks = stm32mp1_exti_banks,
 	.bank_nr = ARRAY_SIZE(stm32mp1_exti_banks),
@@ -221,6 +263,13 @@ static const struct stm32_exti_drv_data stm32mp1_drv_data = {
 	.irq_nr = ARRAY_SIZE(stm32mp1_desc_irq),
 };
 
+static const struct stm32_exti_drv_data stm32mp13_drv_data = {
+	.exti_banks = stm32mp1_exti_banks,
+	.bank_nr = ARRAY_SIZE(stm32mp1_exti_banks),
+	.desc_irqs = stm32mp13_desc_irq,
+	.irq_nr = ARRAY_SIZE(stm32mp13_desc_irq),
+};
+
 static const struct
 stm32_desc_irq *stm32_exti_get_desc(const struct stm32_exti_drv_data *drv_data,
 				    irq_hw_number_t hwirq)
@@ -922,6 +971,7 @@ static int stm32_exti_probe(struct platform_device *pdev)
 /* platform driver only for MP1 */
 static const struct of_device_id stm32_exti_ids[] = {
 	{ .compatible = "st,stm32mp1-exti", .data = &stm32mp1_drv_data},
+	{ .compatible = "st,stm32mp13-exti", .data = &stm32mp13_drv_data},
 	{},
 };
 MODULE_DEVICE_TABLE(of, stm32_exti_ids);
