Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4108257B55D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 13:27:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239321AbiGTL1g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 07:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230405AbiGTL1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 07:27:33 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44C8325C5C
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 04:27:32 -0700 (PDT)
Date:   Wed, 20 Jul 2022 11:27:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1658316450;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jg/pTKpxrrlRN0SDUHe441LGGtTx0BDehbloSQRBoa0=;
        b=xwzgvd4omqEp0A44p69m0Puw+YXsaOPlydUidv10TAG9EcmHtGqJFFGVoNAnpJ2m6zrvb+
        NL1TJRaQE7MJ0Il3CN1NyN3UYRQMg55REV1nDCOSOwvgSTQYFFmV73dEYM9jWu6FbM0fxE
        F9kOZOtDs1T/Q7yAtutAQNVO6VmILOgeq0bUYN5rxNl+1dXNvdhnOs517adtA4yZHhC/OX
        OIOXmUqjlaGBseKTyqPg3UVIoU7B7F7J2vaA7ILZ7dc0z+xK5PWOkGaMiLIay4rNyW43MV
        LJ2Q25OQhNnWtAEXaOhxNEtQ6NSoUbfEome3KmTFLQkc0aiKnshzHVAhXwVClg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1658316450;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jg/pTKpxrrlRN0SDUHe441LGGtTx0BDehbloSQRBoa0=;
        b=343I+rUsEEgsVEcHfVICxViWXEUCDk3wl0yTgK4zhcjIRGGfZOzAdvvjfk2rXjaCJ82E/x
        ZSS9FLNxpMzsyGCw==
From:   "irqchip-bot for Jianmin Lv" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip / ACPI: Introduce
 ACPI_IRQ_MODEL_LPIC for LoongArch
Cc:     Jianmin Lv <lvjianmin@loongson.cn>, Marc Zyngier <maz@kernel.org>,
        tglx@linutronix.de
In-Reply-To: <1658314292-35346-14-git-send-email-lvjianmin@loongson.cn>
References: <1658314292-35346-14-git-send-email-lvjianmin@loongson.cn>
MIME-Version: 1.0
Message-ID: <165831644861.15455.676425418656075059.tip-bot2@tip-bot2>
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

Commit-ID:     e8bba72b396cef7c919c73710f3c5884521adb4e
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/e8bba72b396cef7c919c73710f3c5884521adb4e
Author:        Jianmin Lv <lvjianmin@loongson.cn>
AuthorDate:    Wed, 20 Jul 2022 18:51:32 +08:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Wed, 20 Jul 2022 12:09:21 +01:00

irqchip / ACPI: Introduce ACPI_IRQ_MODEL_LPIC for LoongArch

For LoongArch, ACPI_IRQ_MODEL_LPIC is introduced, and then the
callback acpi_get_gsi_domain_id and acpi_gsi_to_irq_fallback are
implemented.

The acpi_get_gsi_domain_id callback returns related fwnode handle
of irqdomain for different GSI range.

The acpi_gsi_to_irq_fallback will create new mapping for gsi when
the mapping of it is not found.

Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/1658314292-35346-14-git-send-email-lvjianmin@loongson.cn
---
 drivers/acpi/bus.c                  |  3 ++-
 drivers/irqchip/irq-loongarch-cpu.c | 37 ++++++++++++++++++++++++++++-
 include/linux/acpi.h                |  1 +-
 3 files changed, 41 insertions(+)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 86fa61a..63fbf00 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -1145,6 +1145,9 @@ static int __init acpi_bus_init_irq(void)
 	case ACPI_IRQ_MODEL_PLATFORM:
 		message = "platform specific model";
 		break;
+	case ACPI_IRQ_MODEL_LPIC:
+		message = "LPIC";
+		break;
 	default:
 		pr_info("Unknown interrupt routing model\n");
 		return -ENODEV;
diff --git a/drivers/irqchip/irq-loongarch-cpu.c b/drivers/irqchip/irq-loongarch-cpu.c
index 28ddc60..327f3ab 100644
--- a/drivers/irqchip/irq-loongarch-cpu.c
+++ b/drivers/irqchip/irq-loongarch-cpu.c
@@ -16,6 +16,41 @@
 static struct irq_domain *irq_domain;
 struct fwnode_handle *cpuintc_handle;
 
+static u32 lpic_gsi_to_irq(u32 gsi)
+{
+	/* Only pch irqdomain transferring is required for LoongArch. */
+	if (gsi >= GSI_MIN_PCH_IRQ && gsi <= GSI_MAX_PCH_IRQ)
+		return acpi_register_gsi(NULL, gsi, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_HIGH);
+
+	return 0;
+}
+
+static struct fwnode_handle *lpic_get_gsi_domain_id(u32 gsi)
+{
+	int id;
+	struct fwnode_handle *domain_handle = NULL;
+
+	switch (gsi) {
+	case GSI_MIN_CPU_IRQ ... GSI_MAX_CPU_IRQ:
+		if (liointc_handle)
+			domain_handle = liointc_handle;
+		break;
+
+	case GSI_MIN_LPC_IRQ ... GSI_MAX_LPC_IRQ:
+		if (pch_lpc_handle)
+			domain_handle = pch_lpc_handle;
+		break;
+
+	case GSI_MIN_PCH_IRQ ... GSI_MAX_PCH_IRQ:
+		id = find_pch_pic(gsi);
+		if (id >= 0 && pch_pic_handle[id])
+			domain_handle = pch_pic_handle[id];
+		break;
+	}
+
+	return domain_handle;
+}
+
 static void mask_loongarch_irq(struct irq_data *d)
 {
 	clear_csr_ecfg(ECFGF(d->hwirq));
@@ -102,6 +137,8 @@ static int __init cpuintc_acpi_init(union acpi_subtable_headers *header,
 		panic("Failed to add irqdomain for LoongArch CPU");
 
 	set_handle_irq(&handle_cpu_irq);
+	acpi_set_irq_model(ACPI_IRQ_MODEL_LPIC, lpic_get_gsi_domain_id);
+	acpi_set_gsi_to_irq_fallback(lpic_gsi_to_irq);
 	acpi_cascade_irqdomain_init();
 
 	return 0;
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index e2b60d5..76520f3 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -105,6 +105,7 @@ enum acpi_irq_model_id {
 	ACPI_IRQ_MODEL_IOSAPIC,
 	ACPI_IRQ_MODEL_PLATFORM,
 	ACPI_IRQ_MODEL_GIC,
+	ACPI_IRQ_MODEL_LPIC,
 	ACPI_IRQ_MODEL_COUNT
 };
 
