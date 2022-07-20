Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB93057B564
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 13:28:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239216AbiGTL2M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 07:28:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238788AbiGTL1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 07:27:38 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E14A4506F
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 04:27:37 -0700 (PDT)
Date:   Wed, 20 Jul 2022 11:27:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1658316455;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7XZa0RyiY7SZwAafJIYZEpbvpFQwFvLmqLWp1UTAhF4=;
        b=40tWZ7owo1JdZ3DNk+Ikeck99JGi9vF1mWwz8JPwRi/Mzco1Lp1O0CbdNE8PiuKqzX9NnF
        VaBAYlKEDTaK20H1HTrAY2XhTBFSpzcsZFZ/kdmorV9ZHiDd3GAtX1kJoUUk0FEkvrEIFw
        mCLdSCjtclCtu9am7F28opUr7guGw4C5sYNUbgpUAZQZlFaJxv357W7vmx4yFSfcoCtrMp
        tihN3hWROOsp6WKXsHbeHrMU9PW7o+/UkywFAXoN7rGlPa0IEFsklpffuif/1sG9Z2uOcg
        G7V0WXaVdR2udAboMpBk3ufqXeMCfnChR6ITkU17BG9urHyT7qXSTpprakIrXg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1658316455;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7XZa0RyiY7SZwAafJIYZEpbvpFQwFvLmqLWp1UTAhF4=;
        b=YVSTeLFeI11KTZONwEre2GgDCj1mQaKgq+n9f0Zwc2OMw6/+Yc/mIovTn/7hsXv35Mj6S1
        xX7NSdbFy2iQzRAg==
From:   "irqchip-bot for Huacai Chen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip: Add Loongson PCH LPC controller support
Cc:     Jianmin Lv <lvjianmin@loongson.cn>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <1658314292-35346-8-git-send-email-lvjianmin@loongson.cn>
References: <1658314292-35346-8-git-send-email-lvjianmin@loongson.cn>
MIME-Version: 1.0
Message-ID: <165831645458.15455.12098524353617708553.tip-bot2@tip-bot2>
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

Commit-ID:     ee73f14ee9eb7e1a04051b303b56130c4dd6e048
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/ee73f14ee9eb7e1a04051b303b56130c4dd6e048
Author:        Huacai Chen <chenhuacai@loongson.cn>
AuthorDate:    Wed, 20 Jul 2022 18:51:26 +08:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Wed, 20 Jul 2022 12:09:20 +01:00

irqchip: Add Loongson PCH LPC controller support

PCH-LPC stands for "LPC Interrupts" that described in Section 24.3 of
"Loongson 7A1000 Bridge User Manual". For more information please refer
Documentation/loongarch/irq-chip-model.rst.

Co-developed-by: Jianmin Lv <lvjianmin@loongson.cn>
Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/1658314292-35346-8-git-send-email-lvjianmin@loongson.cn
---
 arch/loongarch/include/asm/irq.h       |   4 +-
 arch/loongarch/kernel/irq.c            |   1 +-
 drivers/irqchip/Kconfig                |   8 +-
 drivers/irqchip/Makefile               |   1 +-
 drivers/irqchip/irq-loongson-pch-lpc.c | 205 ++++++++++++++++++++++++-
 5 files changed, 216 insertions(+), 3 deletions(-)
 create mode 100644 drivers/irqchip/irq-loongson-pch-lpc.c

diff --git a/arch/loongarch/include/asm/irq.h b/arch/loongarch/include/asm/irq.h
index a2540d7..76a7b36 100644
--- a/arch/loongarch/include/asm/irq.h
+++ b/arch/loongarch/include/asm/irq.h
@@ -112,7 +112,7 @@ struct irq_domain *eiointc_acpi_init(struct irq_domain *parent,
 
 struct irq_domain *htvec_acpi_init(struct irq_domain *parent,
 					struct acpi_madt_ht_pic *acpi_htvec);
-struct irq_domain *pch_lpc_acpi_init(struct irq_domain *parent,
+int pch_lpc_acpi_init(struct irq_domain *parent,
 					struct acpi_madt_lpc_pic *acpi_pchlpc);
 struct irq_domain *pch_msi_acpi_init(struct irq_domain *parent,
 					struct acpi_madt_msi_pic *acpi_pchmsi);
@@ -129,7 +129,7 @@ extern struct acpi_madt_bio_pic *acpi_pchpic[MAX_IO_PICS];
 
 extern struct irq_domain *cpu_domain;
 extern struct irq_domain *liointc_domain;
-extern struct irq_domain *pch_lpc_domain;
+extern struct fwnode_handle *pch_lpc_handle;
 extern struct irq_domain *pch_msi_domain[MAX_IO_PICS];
 extern struct irq_domain *pch_pic_domain[MAX_IO_PICS];
 
diff --git a/arch/loongarch/kernel/irq.c b/arch/loongarch/kernel/irq.c
index 37dd2dc..181504b 100644
--- a/arch/loongarch/kernel/irq.c
+++ b/arch/loongarch/kernel/irq.c
@@ -27,7 +27,6 @@ EXPORT_PER_CPU_SYMBOL(irq_stat);
 
 struct irq_domain *cpu_domain;
 struct irq_domain *liointc_domain;
-struct irq_domain *pch_lpc_domain;
 struct irq_domain *pch_msi_domain[MAX_IO_PICS];
 struct irq_domain *pch_pic_domain[MAX_IO_PICS];
 
diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 1f23a6b..c1d527f 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -591,6 +591,14 @@ config LOONGSON_PCH_MSI
 	help
 	  Support for the Loongson PCH MSI Controller.
 
+config LOONGSON_PCH_LPC
+	bool "Loongson PCH LPC Controller"
+	depends on MACH_LOONGSON64
+	default (MACH_LOONGSON64 && LOONGARCH)
+	select IRQ_DOMAIN_HIERARCHY
+	help
+	  Support for the Loongson PCH LPC Controller.
+
 config MST_IRQ
 	bool "MStar Interrupt Controller"
 	depends on ARCH_MEDIATEK || ARCH_MSTARV7 || COMPILE_TEST
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index 5b67450..242b8b3 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -108,6 +108,7 @@ obj-$(CONFIG_LOONGSON_HTPIC)		+= irq-loongson-htpic.o
 obj-$(CONFIG_LOONGSON_HTVEC)		+= irq-loongson-htvec.o
 obj-$(CONFIG_LOONGSON_PCH_PIC)		+= irq-loongson-pch-pic.o
 obj-$(CONFIG_LOONGSON_PCH_MSI)		+= irq-loongson-pch-msi.o
+obj-$(CONFIG_LOONGSON_PCH_LPC)		+= irq-loongson-pch-lpc.o
 obj-$(CONFIG_MST_IRQ)			+= irq-mst-intc.o
 obj-$(CONFIG_SL28CPLD_INTC)		+= irq-sl28cpld.o
 obj-$(CONFIG_MACH_REALTEK_RTL)		+= irq-realtek-rtl.o
diff --git a/drivers/irqchip/irq-loongson-pch-lpc.c b/drivers/irqchip/irq-loongson-pch-lpc.c
new file mode 100644
index 0000000..bf23249
--- /dev/null
+++ b/drivers/irqchip/irq-loongson-pch-lpc.c
@@ -0,0 +1,205 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Loongson LPC Interrupt Controller support
+ *
+ * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
+ */
+
+#define pr_fmt(fmt) "lpc: " fmt
+
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/irqchip.h>
+#include <linux/irqchip/chained_irq.h>
+#include <linux/irqdomain.h>
+#include <linux/kernel.h>
+
+/* Registers */
+#define LPC_INT_CTL		0x00
+#define LPC_INT_ENA		0x04
+#define LPC_INT_STS		0x08
+#define LPC_INT_CLR		0x0c
+#define LPC_INT_POL		0x10
+#define LPC_COUNT		16
+
+/* LPC_INT_CTL */
+#define LPC_INT_CTL_EN		BIT(31)
+
+struct pch_lpc {
+	void __iomem		*base;
+	struct irq_domain	*lpc_domain;
+	raw_spinlock_t		lpc_lock;
+	u32			saved_reg_ctl;
+	u32			saved_reg_ena;
+	u32			saved_reg_pol;
+};
+
+struct fwnode_handle *pch_lpc_handle;
+
+static void lpc_irq_ack(struct irq_data *d)
+{
+	unsigned long flags;
+	struct pch_lpc *priv = d->domain->host_data;
+
+	raw_spin_lock_irqsave(&priv->lpc_lock, flags);
+	writel(0x1 << d->hwirq, priv->base + LPC_INT_CLR);
+	raw_spin_unlock_irqrestore(&priv->lpc_lock, flags);
+}
+
+static void lpc_irq_mask(struct irq_data *d)
+{
+	unsigned long flags;
+	struct pch_lpc *priv = d->domain->host_data;
+
+	raw_spin_lock_irqsave(&priv->lpc_lock, flags);
+	writel(readl(priv->base + LPC_INT_ENA) & (~(0x1 << (d->hwirq))),
+			priv->base + LPC_INT_ENA);
+	raw_spin_unlock_irqrestore(&priv->lpc_lock, flags);
+}
+
+static void lpc_irq_unmask(struct irq_data *d)
+{
+	unsigned long flags;
+	struct pch_lpc *priv = d->domain->host_data;
+
+	raw_spin_lock_irqsave(&priv->lpc_lock, flags);
+	writel(readl(priv->base + LPC_INT_ENA) | (0x1 << (d->hwirq)),
+			priv->base + LPC_INT_ENA);
+	raw_spin_unlock_irqrestore(&priv->lpc_lock, flags);
+}
+
+static int lpc_irq_set_type(struct irq_data *d, unsigned int type)
+{
+	u32 val;
+	u32 mask = 0x1 << (d->hwirq);
+	struct pch_lpc *priv = d->domain->host_data;
+
+	if (!(type & IRQ_TYPE_LEVEL_MASK))
+		return 0;
+
+	val = readl(priv->base + LPC_INT_POL);
+
+	if (type == IRQ_TYPE_LEVEL_HIGH)
+		val |= mask;
+	else
+		val &= ~mask;
+
+	writel(val, priv->base + LPC_INT_POL);
+
+	return 0;
+}
+
+static const struct irq_chip pch_lpc_irq_chip = {
+	.name			= "PCH LPC",
+	.irq_mask		= lpc_irq_mask,
+	.irq_unmask		= lpc_irq_unmask,
+	.irq_ack		= lpc_irq_ack,
+	.irq_set_type		= lpc_irq_set_type,
+	.flags			= IRQCHIP_SKIP_SET_WAKE,
+};
+
+static void lpc_irq_dispatch(struct irq_desc *desc)
+{
+	u32 pending, bit;
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+	struct pch_lpc *priv = irq_desc_get_handler_data(desc);
+
+	chained_irq_enter(chip, desc);
+
+	pending = readl(priv->base + LPC_INT_ENA);
+	pending &= readl(priv->base + LPC_INT_STS);
+	if (!pending)
+		spurious_interrupt();
+
+	while (pending) {
+		bit = __ffs(pending);
+
+		generic_handle_domain_irq(priv->lpc_domain, bit);
+		pending &= ~BIT(bit);
+	}
+	chained_irq_exit(chip, desc);
+}
+
+static int pch_lpc_map(struct irq_domain *d, unsigned int irq,
+			irq_hw_number_t hw)
+{
+	irq_set_chip_and_handler(irq, &pch_lpc_irq_chip, handle_level_irq);
+	return 0;
+}
+
+static const struct irq_domain_ops pch_lpc_domain_ops = {
+	.map 		= pch_lpc_map,
+	.translate	= irq_domain_translate_twocell,
+};
+
+static void pch_lpc_reset(struct pch_lpc *priv)
+{
+	/* Enable the LPC interrupt, bit31: en  bit30: edge */
+	writel(LPC_INT_CTL_EN, priv->base + LPC_INT_CTL);
+	writel(0, priv->base + LPC_INT_ENA);
+	/* Clear all 18-bit interrpt bit */
+	writel(GENMASK(17, 0), priv->base + LPC_INT_CLR);
+}
+
+static int pch_lpc_disabled(struct pch_lpc *priv)
+{
+	return (readl(priv->base + LPC_INT_ENA) == 0xffffffff) &&
+			(readl(priv->base + LPC_INT_STS) == 0xffffffff);
+}
+
+int __init pch_lpc_acpi_init(struct irq_domain *parent,
+					struct acpi_madt_lpc_pic *acpi_pchlpc)
+{
+	int parent_irq;
+	struct pch_lpc *priv;
+	struct irq_fwspec fwspec;
+	struct fwnode_handle *irq_handle;
+
+	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	raw_spin_lock_init(&priv->lpc_lock);
+
+	priv->base = ioremap(acpi_pchlpc->address, acpi_pchlpc->size);
+	if (!priv->base)
+		goto free_priv;
+
+	if (pch_lpc_disabled(priv)) {
+		pr_err("Failed to get LPC status\n");
+		goto iounmap_base;
+	}
+
+	irq_handle = irq_domain_alloc_named_fwnode("lpcintc");
+	if (!irq_handle) {
+		pr_err("Unable to allocate domain handle\n");
+		goto iounmap_base;
+	}
+
+	priv->lpc_domain = irq_domain_create_linear(irq_handle, LPC_COUNT,
+					&pch_lpc_domain_ops, priv);
+	if (!priv->lpc_domain) {
+		pr_err("Failed to create IRQ domain\n");
+		goto free_irq_handle;
+	}
+	pch_lpc_reset(priv);
+
+	fwspec.fwnode = parent->fwnode;
+	fwspec.param[0] = acpi_pchlpc->cascade + GSI_MIN_PCH_IRQ;
+	fwspec.param[1] = IRQ_TYPE_LEVEL_HIGH;
+	fwspec.param_count = 2;
+	parent_irq = irq_create_fwspec_mapping(&fwspec);
+	irq_set_chained_handler_and_data(parent_irq, lpc_irq_dispatch, priv);
+
+	pch_lpc_handle = irq_handle;
+	return 0;
+
+free_irq_handle:
+	irq_domain_free_fwnode(irq_handle);
+iounmap_base:
+	iounmap(priv->base);
+free_priv:
+	kfree(priv);
+
+	return -ENOMEM;
+}
