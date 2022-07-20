Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 887A057B560
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 13:27:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239906AbiGTL1i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 07:27:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238788AbiGTL1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 07:27:34 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C27445051
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 04:27:32 -0700 (PDT)
Date:   Wed, 20 Jul 2022 11:27:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1658316451;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/mziYM0RmPOikj7SNFy3HaYqZOOL1D9TRnRY2OYk+Jo=;
        b=J/Yf0WCrAYaG4xF3QP97ZZHm0BfizWAhmu5MmZVi1Y4rSJhGctEajt8oXlaFXJiepMhX8q
        N/3mzdRafkVvJCipU6vbDmKIGF2ySUwqxb75FwTFJSUHxJw8YVz5t/BAa190BBIzde7E1D
        AYEoI4pbio0jMLsVkg8lQmOtxWvfGY1G061puM6JqC8qez4jF9Od85owLr7CmFBmukTg4M
        gQNamUicNhnxityAQaPgKSyPS/Ua4m0qyGA3bTI9sDpcFWzW4Aw3ykIc5cKqgKpQm9fEdX
        IQODlKGoe9TR/qGTkp/2iogeTLQIzQjj5QzAw4RHcW5wG6RC2O2nF562bLPt5g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1658316451;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/mziYM0RmPOikj7SNFy3HaYqZOOL1D9TRnRY2OYk+Jo=;
        b=QyLS/5kqhjDGaTDIEJlLe3UPXOzrXEOBTEBlVNhbaWp0BYzrzqYc0WHb50hIJ/mDS8eEL0
        FE+Z53ONFLlhx7Cw==
From:   "irqchip-bot for Huacai Chen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip: Add LoongArch CPU interrupt
 controller support
Cc:     Jianmin Lv <lvjianmin@loongson.cn>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <1658314292-35346-13-git-send-email-lvjianmin@loongson.cn>
References: <1658314292-35346-13-git-send-email-lvjianmin@loongson.cn>
MIME-Version: 1.0
Message-ID: <165831644986.15455.16517433471796982624.tip-bot2@tip-bot2>
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

Commit-ID:     b2d3e3354e2a0d0e912308618ea33d0337f405c3
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/b2d3e3354e2a0d0e912308618ea33d0337f405c3
Author:        Huacai Chen <chenhuacai@loongson.cn>
AuthorDate:    Wed, 20 Jul 2022 18:51:31 +08:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Wed, 20 Jul 2022 12:09:21 +01:00

irqchip: Add LoongArch CPU interrupt controller support

LoongArch CPUINTC stands for CSR.ECFG/CSR.ESTAT and related interrupt
controller that described in Section 7.4 of "LoongArch Reference Manual,
Vol 1". For more information please refer Documentation/loongarch/irq-
chip-model.rst.

LoongArch CPUINTC has 13 interrupt sources: SWI0~1, HWI0~7, IPI, TI
(Timer) and PCOV (PMC). IRQ mappings of HWI0~7 are configurable (can be
created from DT/ACPI), but IPI, TI (Timer) and PCOV (PMC) are hardcoded
bits, so we expose the fwnode_handle to map them, and get mapped irq
by irq_create_mapping when using them.

Co-developed-by: Jianmin Lv <lvjianmin@loongson.cn>
Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/1658314292-35346-13-git-send-email-lvjianmin@loongson.cn
---
 arch/loongarch/include/asm/irq.h    |   7 +--
 arch/loongarch/kernel/irq.c         |  16 +++-
 arch/loongarch/kernel/time.c        |  14 ++-
 drivers/irqchip/Kconfig             |  10 ++-
 drivers/irqchip/Makefile            |   1 +-
 drivers/irqchip/irq-loongarch-cpu.c | 111 +++++++++++++++++++++++++++-
 6 files changed, 149 insertions(+), 10 deletions(-)
 create mode 100644 drivers/irqchip/irq-loongarch-cpu.c

diff --git a/arch/loongarch/include/asm/irq.h b/arch/loongarch/include/asm/irq.h
index 67ebcc5..149b212 100644
--- a/arch/loongarch/include/asm/irq.h
+++ b/arch/loongarch/include/asm/irq.h
@@ -35,9 +35,6 @@ static inline bool on_irq_stack(int cpu, unsigned long sp)
 	return (low <= sp && sp <= high);
 }
 
-int get_ipi_irq(void);
-int get_pmc_irq(void);
-int get_timer_irq(void);
 void spurious_interrupt(void);
 
 #define NR_IRQS_LEGACY 16
@@ -94,8 +91,6 @@ struct acpi_madt_bio_pic;
 struct acpi_madt_msi_pic;
 struct acpi_madt_lpc_pic;
 
-struct irq_domain *loongarch_cpu_irq_init(void);
-
 int liointc_acpi_init(struct irq_domain *parent,
 					struct acpi_madt_lio_pic *acpi_liointc);
 int eiointc_acpi_init(struct irq_domain *parent,
@@ -128,7 +123,7 @@ extern struct acpi_madt_lpc_pic *acpi_pchlpc;
 extern struct acpi_madt_msi_pic *acpi_pchmsi[MAX_IO_PICS];
 extern struct acpi_madt_bio_pic *acpi_pchpic[MAX_IO_PICS];
 
-extern struct irq_domain *cpu_domain;
+extern struct fwnode_handle *cpuintc_handle;
 extern struct fwnode_handle *liointc_handle;
 extern struct fwnode_handle *pch_lpc_handle;
 extern struct fwnode_handle *pch_pic_handle[MAX_IO_PICS];
diff --git a/arch/loongarch/kernel/irq.c b/arch/loongarch/kernel/irq.c
index da131f5..1ba19c7 100644
--- a/arch/loongarch/kernel/irq.c
+++ b/arch/loongarch/kernel/irq.c
@@ -25,8 +25,6 @@ DEFINE_PER_CPU(unsigned long, irq_stack);
 DEFINE_PER_CPU_SHARED_ALIGNED(irq_cpustat_t, irq_stat);
 EXPORT_PER_CPU_SYMBOL(irq_stat);
 
-struct irq_domain *cpu_domain;
-
 struct acpi_vector_group pch_group[MAX_IO_PICS];
 struct acpi_vector_group msi_group[MAX_IO_PICS];
 /*
@@ -89,6 +87,16 @@ static void __init init_vec_parent_group(void)
 	acpi_table_parse(ACPI_SIG_MCFG, early_pci_mcfg_parse);
 }
 
+static int __init get_ipi_irq(void)
+{
+	struct irq_domain *d = irq_find_matching_fwnode(cpuintc_handle, DOMAIN_BUS_ANY);
+
+	if (d)
+		return irq_create_mapping(d, EXCCODE_IPI - EXCCODE_INT_START);
+
+	return -EINVAL;
+}
+
 void __init init_IRQ(void)
 {
 	int i;
@@ -105,7 +113,9 @@ void __init init_IRQ(void)
 	init_vec_parent_group();
 	irqchip_init();
 #ifdef CONFIG_SMP
-	ipi_irq = EXCCODE_IPI - EXCCODE_INT_START;
+	ipi_irq = get_ipi_irq();
+	if (ipi_irq < 0)
+		panic("IPI IRQ mapping failed\n");
 	irq_set_percpu_devid(ipi_irq);
 	r = request_percpu_irq(ipi_irq, loongson3_ipi_interrupt, "IPI", &ipi_dummy_dev);
 	if (r < 0)
diff --git a/arch/loongarch/kernel/time.c b/arch/loongarch/kernel/time.c
index fe68238..79dc5ed 100644
--- a/arch/loongarch/kernel/time.c
+++ b/arch/loongarch/kernel/time.c
@@ -123,6 +123,16 @@ void sync_counter(void)
 	csr_write64(-init_timeval, LOONGARCH_CSR_CNTC);
 }
 
+static int get_timer_irq(void)
+{
+	struct irq_domain *d = irq_find_matching_fwnode(cpuintc_handle, DOMAIN_BUS_ANY);
+
+	if (d)
+		return irq_create_mapping(d, EXCCODE_TIMER - EXCCODE_INT_START);
+
+	return -EINVAL;
+}
+
 int constant_clockevent_init(void)
 {
 	unsigned int irq;
@@ -132,7 +142,9 @@ int constant_clockevent_init(void)
 	struct clock_event_device *cd;
 	static int timer_irq_installed = 0;
 
-	irq = EXCCODE_TIMER - EXCCODE_INT_START;
+	irq = get_timer_irq();
+	if (irq < 0)
+		pr_err("Failed to map irq %d (timer)\n", irq);
 
 	cd = &per_cpu(constant_clockevent_device, cpu);
 
diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 8f077d3..f53164c 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -546,6 +546,16 @@ config EXYNOS_IRQ_COMBINER
 	  Say yes here to add support for the IRQ combiner devices embedded
 	  in Samsung Exynos chips.
 
+config IRQ_LOONGARCH_CPU
+	bool
+	select GENERIC_IRQ_CHIP
+	select IRQ_DOMAIN
+	select GENERIC_IRQ_EFFECTIVE_AFF_MASK
+	help
+	  Support for the LoongArch CPU Interrupt Controller. For details of
+	  irq chip hierarchy on LoongArch platforms please read the document
+	  Documentation/loongarch/irq-chip-model.rst.
+
 config LOONGSON_LIOINTC
 	bool "Loongson Local I/O Interrupt Controller"
 	depends on MACH_LOONGSON64
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index 0cfd4f0..e559007 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -103,6 +103,7 @@ obj-$(CONFIG_LS1X_IRQ)			+= irq-ls1x.o
 obj-$(CONFIG_TI_SCI_INTR_IRQCHIP)	+= irq-ti-sci-intr.o
 obj-$(CONFIG_TI_SCI_INTA_IRQCHIP)	+= irq-ti-sci-inta.o
 obj-$(CONFIG_TI_PRUSS_INTC)		+= irq-pruss-intc.o
+obj-$(CONFIG_IRQ_LOONGARCH_CPU)		+= irq-loongarch-cpu.o
 obj-$(CONFIG_LOONGSON_LIOINTC)		+= irq-loongson-liointc.o
 obj-$(CONFIG_LOONGSON_EIOINTC)		+= irq-loongson-eiointc.o
 obj-$(CONFIG_LOONGSON_HTPIC)		+= irq-loongson-htpic.o
diff --git a/drivers/irqchip/irq-loongarch-cpu.c b/drivers/irqchip/irq-loongarch-cpu.c
new file mode 100644
index 0000000..28ddc60
--- /dev/null
+++ b/drivers/irqchip/irq-loongarch-cpu.c
@@ -0,0 +1,111 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
+ */
+
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/irqchip.h>
+#include <linux/irqdomain.h>
+
+#include <asm/loongarch.h>
+#include <asm/setup.h>
+
+static struct irq_domain *irq_domain;
+struct fwnode_handle *cpuintc_handle;
+
+static void mask_loongarch_irq(struct irq_data *d)
+{
+	clear_csr_ecfg(ECFGF(d->hwirq));
+}
+
+static void unmask_loongarch_irq(struct irq_data *d)
+{
+	set_csr_ecfg(ECFGF(d->hwirq));
+}
+
+static struct irq_chip cpu_irq_controller = {
+	.name		= "CPUINTC",
+	.irq_mask	= mask_loongarch_irq,
+	.irq_unmask	= unmask_loongarch_irq,
+};
+
+static void handle_cpu_irq(struct pt_regs *regs)
+{
+	int hwirq;
+	unsigned int estat = read_csr_estat() & CSR_ESTAT_IS;
+
+	while ((hwirq = ffs(estat))) {
+		estat &= ~BIT(hwirq - 1);
+		generic_handle_domain_irq(irq_domain, hwirq - 1);
+	}
+}
+
+static int loongarch_cpu_intc_map(struct irq_domain *d, unsigned int irq,
+			     irq_hw_number_t hwirq)
+{
+	irq_set_noprobe(irq);
+	irq_set_chip_and_handler(irq, &cpu_irq_controller, handle_percpu_irq);
+
+	return 0;
+}
+
+static const struct irq_domain_ops loongarch_cpu_intc_irq_domain_ops = {
+	.map = loongarch_cpu_intc_map,
+	.xlate = irq_domain_xlate_onecell,
+};
+
+static int __init
+liointc_parse_madt(union acpi_subtable_headers *header,
+		       const unsigned long end)
+{
+	struct acpi_madt_lio_pic *liointc_entry = (struct acpi_madt_lio_pic *)header;
+
+	return liointc_acpi_init(irq_domain, liointc_entry);
+}
+
+static int __init
+eiointc_parse_madt(union acpi_subtable_headers *header,
+		       const unsigned long end)
+{
+	struct acpi_madt_eio_pic *eiointc_entry = (struct acpi_madt_eio_pic *)header;
+
+	return eiointc_acpi_init(irq_domain, eiointc_entry);
+}
+
+static int __init acpi_cascade_irqdomain_init(void)
+{
+	acpi_table_parse_madt(ACPI_MADT_TYPE_LIO_PIC,
+			      liointc_parse_madt, 0);
+	acpi_table_parse_madt(ACPI_MADT_TYPE_EIO_PIC,
+			      eiointc_parse_madt, 0);
+	return 0;
+}
+
+static int __init cpuintc_acpi_init(union acpi_subtable_headers *header,
+				   const unsigned long end)
+{
+	if (irq_domain)
+		return 0;
+
+	/* Mask interrupts. */
+	clear_csr_ecfg(ECFG0_IM);
+	clear_csr_estat(ESTATF_IP);
+
+	cpuintc_handle = irq_domain_alloc_fwnode(NULL);
+	irq_domain = irq_domain_create_linear(cpuintc_handle, EXCCODE_INT_NUM,
+					&loongarch_cpu_intc_irq_domain_ops, NULL);
+
+	if (!irq_domain)
+		panic("Failed to add irqdomain for LoongArch CPU");
+
+	set_handle_irq(&handle_cpu_irq);
+	acpi_cascade_irqdomain_init();
+
+	return 0;
+}
+
+IRQCHIP_ACPI_DECLARE(cpuintc_v1, ACPI_MADT_TYPE_CORE_PIC,
+		NULL, ACPI_MADT_CORE_PIC_VERSION_V1, cpuintc_acpi_init);
