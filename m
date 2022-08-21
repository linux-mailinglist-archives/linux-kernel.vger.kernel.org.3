Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FEEC59B667
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 23:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231654AbiHUVKP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 17:10:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231329AbiHUVKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 17:10:12 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC64119026
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 14:10:10 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id h22so7543869ejk.4
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 14:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc;
        bh=CyCS4TVxsljtU0FyIHweUhtrdXZeoLMc/ScgqEGsPWM=;
        b=kdSwy5D8CgjFdnu8YjFGeVKLXA6BoBfW+F1d84tOGcBO0y4XhdMNmCWqUgg/8ws+Qy
         JNTKcuUiDQV0NfeBIW2AVqdzN2HjvLHcMZjU92kY45ZCJ9R8EbVG2ro1/lqbPvBXVhAo
         0oQLTGaouSWwTxCYx1Id2+7HpMsn+NbPF8wtY5HS51unpdklUMuerJXOW3Ngm/P3AUyA
         05Xt9L6ak7k5KJ2fxEh4cTjKzvlidtqj/u+skqIcJJyr2OkiXde6bHtg3on9ExjyujbM
         JxIqvg7InCs19+CzaFTLW02HFNoQTUpiyS9nV41v1hZY2ziW7/VQf4JQOpU3RxYAj9ZR
         CC3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc;
        bh=CyCS4TVxsljtU0FyIHweUhtrdXZeoLMc/ScgqEGsPWM=;
        b=oYQJEdSKcoxdiUMC0tpw8gCgZzqJ0f4U7CFL+WEuMN+70jRk1haUndD210Aonl19mh
         cuSZ08n2VUaz5A9rlGF9WNk0m8y0vWQGwEtzz1gSRyNi+eCV/vaHTNmeQjuZGbRzNezf
         it2GZBiIzRfeScOL3/9lmCg/oRJCfQiCIMXH00LIBqRV9s+uAryfjANXxFrv2xBD63vb
         akFuHICWVFs/DGAyFS3Rue74ye9LBolhM5JCZHWN2apNpRdPRaQzNBEm8lrYgPDmxMj+
         oHllmRC0TdWPYUOj9SIAh0V/1sGDrjlR762bwiJX3PGJ7ZB0gcj3cGe2+IGptUihbTwB
         zGTA==
X-Gm-Message-State: ACgBeo0fmHyaF2+5Iv41kMSQTfXiv79qhcPrtc16FUClthfneyJ0vWaA
        CWYJAsMf0Mf1fC+b1faBmdRo4yAoO2s=
X-Google-Smtp-Source: AA6agR7zkdOYsT1NnnFLzlNeTYvOfNRuctkbcP8ahvhJphn3c2fbzENJkWM6CKWCOBeJeqM1zrFCsg==
X-Received: by 2002:a17:907:80d:b0:73d:1e3f:3d83 with SMTP id wv13-20020a170907080d00b0073d1e3f3d83mr7676383ejb.372.1661116209298;
        Sun, 21 Aug 2022 14:10:09 -0700 (PDT)
Received: from gmail.com (195-38-113-151.pool.digikabel.hu. [195.38.113.151])
        by smtp.gmail.com with ESMTPSA id p2-20020a170906604200b0072b1cb2818csm5291203ejj.158.2022.08.21.14.10.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Aug 2022 14:10:08 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Sun, 21 Aug 2022 23:10:06 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Marc Zyngier <maz@kernel.org>
Subject: [GIT PULL] IRQ fixes
Message-ID: <YwKfLrZvzIWmvYBL@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest irq/urgent git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-urgent-2022-08-21

   # HEAD: 57646d6769f13f9484ffc6869c493e25a6568073 Merge tag 'irqchip-fixes-6.0-1' of git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms into irq/urgent

Misc irqchip fixes: LoongArch driver fixes and a Hyper-V IOMMU  fix.

 Thanks,

	Ingo

------------------>
Christophe JAILLET (1):
      irqchip/loongson-liointc: Fix an error handling path in liointc_init()

Huacai Chen (3):
      irqchip/loongson-eiointc: Fix irq affinity setting
      irqchip/loongson-eiointc: Fix a build warning
      irqchip/loongson-pch-pic: Move find_pch_pic() into CONFIG_ACPI

Marc Zyngier (1):
      irqchip/loongarch: Fix irq_domain_alloc_fwnode() abuse

Michael Kelley (1):
      iommu/hyper-v: Use helper instead of directly accessing affinity


 arch/loongarch/include/asm/irq.h       |  1 -
 drivers/iommu/hyperv-iommu.c           |  4 +---
 drivers/irqchip/irq-loongarch-cpu.c    |  2 +-
 drivers/irqchip/irq-loongson-eiointc.c | 13 +++++++----
 drivers/irqchip/irq-loongson-liointc.c |  4 ++--
 drivers/irqchip/irq-loongson-pch-msi.c |  2 +-
 drivers/irqchip/irq-loongson-pch-pic.c | 40 +++++++++++++++++-----------------
 7 files changed, 34 insertions(+), 32 deletions(-)

diff --git a/arch/loongarch/include/asm/irq.h b/arch/loongarch/include/asm/irq.h
index 4b130199ceae..d06d4542b634 100644
--- a/arch/loongarch/include/asm/irq.h
+++ b/arch/loongarch/include/asm/irq.h
@@ -81,7 +81,6 @@ extern struct acpi_vector_group msi_group[MAX_IO_PICS];
 #define GSI_MIN_PCH_IRQ		LOONGSON_PCH_IRQ_BASE
 #define GSI_MAX_PCH_IRQ		(LOONGSON_PCH_IRQ_BASE + 256 - 1)
 
-extern int find_pch_pic(u32 gsi);
 struct acpi_madt_lio_pic;
 struct acpi_madt_eio_pic;
 struct acpi_madt_ht_pic;
diff --git a/drivers/iommu/hyperv-iommu.c b/drivers/iommu/hyperv-iommu.c
index 51bd66a45a11..e190bb8c225c 100644
--- a/drivers/iommu/hyperv-iommu.c
+++ b/drivers/iommu/hyperv-iommu.c
@@ -68,7 +68,6 @@ static int hyperv_irq_remapping_alloc(struct irq_domain *domain,
 {
 	struct irq_alloc_info *info = arg;
 	struct irq_data *irq_data;
-	struct irq_desc *desc;
 	int ret = 0;
 
 	if (!info || info->type != X86_IRQ_ALLOC_TYPE_IOAPIC || nr_irqs > 1)
@@ -90,8 +89,7 @@ static int hyperv_irq_remapping_alloc(struct irq_domain *domain,
 	 * Hypver-V IO APIC irq affinity should be in the scope of
 	 * ioapic_max_cpumask because no irq remapping support.
 	 */
-	desc = irq_data_to_desc(irq_data);
-	cpumask_copy(desc->irq_common_data.affinity, &ioapic_max_cpumask);
+	irq_data_update_affinity(irq_data, &ioapic_max_cpumask);
 
 	return 0;
 }
diff --git a/drivers/irqchip/irq-loongarch-cpu.c b/drivers/irqchip/irq-loongarch-cpu.c
index 327f3ab62c03..741612ba6a52 100644
--- a/drivers/irqchip/irq-loongarch-cpu.c
+++ b/drivers/irqchip/irq-loongarch-cpu.c
@@ -129,7 +129,7 @@ static int __init cpuintc_acpi_init(union acpi_subtable_headers *header,
 	clear_csr_ecfg(ECFG0_IM);
 	clear_csr_estat(ESTATF_IP);
 
-	cpuintc_handle = irq_domain_alloc_fwnode(NULL);
+	cpuintc_handle = irq_domain_alloc_named_fwnode("CPUINTC");
 	irq_domain = irq_domain_create_linear(cpuintc_handle, EXCCODE_INT_NUM,
 					&loongarch_cpu_intc_irq_domain_ops, NULL);
 
diff --git a/drivers/irqchip/irq-loongson-eiointc.c b/drivers/irqchip/irq-loongson-eiointc.c
index 80d8ca6f2d46..16e9af8d8b1e 100644
--- a/drivers/irqchip/irq-loongson-eiointc.c
+++ b/drivers/irqchip/irq-loongson-eiointc.c
@@ -111,11 +111,15 @@ static int eiointc_set_irq_affinity(struct irq_data *d, const struct cpumask *af
 	regaddr = EIOINTC_REG_ENABLE + ((vector >> 5) << 2);
 
 	/* Mask target vector */
-	csr_any_send(regaddr, EIOINTC_ALL_ENABLE & (~BIT(vector & 0x1F)), 0x0, 0);
+	csr_any_send(regaddr, EIOINTC_ALL_ENABLE & (~BIT(vector & 0x1F)),
+			0x0, priv->node * CORES_PER_EIO_NODE);
+
 	/* Set route for target vector */
 	eiointc_set_irq_route(vector, cpu, priv->node, &priv->node_map);
+
 	/* Unmask target vector */
-	csr_any_send(regaddr, EIOINTC_ALL_ENABLE, 0x0, 0);
+	csr_any_send(regaddr, EIOINTC_ALL_ENABLE,
+			0x0, priv->node * CORES_PER_EIO_NODE);
 
 	irq_data_update_effective_affinity(d, cpumask_of(cpu));
 
@@ -286,7 +290,7 @@ static void acpi_set_vec_parent(int node, struct irq_domain *parent, struct acpi
 	}
 }
 
-struct irq_domain *acpi_get_vec_parent(int node, struct acpi_vector_group *vec_group)
+static struct irq_domain *acpi_get_vec_parent(int node, struct acpi_vector_group *vec_group)
 {
 	int i;
 
@@ -344,7 +348,8 @@ int __init eiointc_acpi_init(struct irq_domain *parent,
 	if (!priv)
 		return -ENOMEM;
 
-	priv->domain_handle = irq_domain_alloc_fwnode((phys_addr_t *)acpi_eiointc);
+	priv->domain_handle = irq_domain_alloc_named_id_fwnode("EIOPIC",
+							       acpi_eiointc->node);
 	if (!priv->domain_handle) {
 		pr_err("Unable to allocate domain handle\n");
 		goto out_free_priv;
diff --git a/drivers/irqchip/irq-loongson-liointc.c b/drivers/irqchip/irq-loongson-liointc.c
index c4f3c886ad61..0da8716f8f24 100644
--- a/drivers/irqchip/irq-loongson-liointc.c
+++ b/drivers/irqchip/irq-loongson-liointc.c
@@ -207,7 +207,7 @@ static int liointc_init(phys_addr_t addr, unsigned long size, int revision,
 					"reg-names", core_reg_names[i]);
 
 			if (index < 0)
-				return -EINVAL;
+				goto out_iounmap;
 
 			priv->core_isr[i] = of_iomap(node, index);
 		}
@@ -360,7 +360,7 @@ int __init liointc_acpi_init(struct irq_domain *parent, struct acpi_madt_lio_pic
 	parent_irq[0] = irq_create_mapping(parent, acpi_liointc->cascade[0]);
 	parent_irq[1] = irq_create_mapping(parent, acpi_liointc->cascade[1]);
 
-	domain_handle = irq_domain_alloc_fwnode((phys_addr_t *)acpi_liointc);
+	domain_handle = irq_domain_alloc_fwnode(&acpi_liointc->address);
 	if (!domain_handle) {
 		pr_err("Unable to allocate domain handle\n");
 		return -ENOMEM;
diff --git a/drivers/irqchip/irq-loongson-pch-msi.c b/drivers/irqchip/irq-loongson-pch-msi.c
index d0e8551bebfa..a72ede90ffc6 100644
--- a/drivers/irqchip/irq-loongson-pch-msi.c
+++ b/drivers/irqchip/irq-loongson-pch-msi.c
@@ -282,7 +282,7 @@ int __init pch_msi_acpi_init(struct irq_domain *parent,
 	int ret;
 	struct fwnode_handle *domain_handle;
 
-	domain_handle = irq_domain_alloc_fwnode((phys_addr_t *)acpi_pchmsi);
+	domain_handle = irq_domain_alloc_fwnode(&acpi_pchmsi->msg_address);
 	ret = pch_msi_init(acpi_pchmsi->msg_address, acpi_pchmsi->start,
 				acpi_pchmsi->count, parent, domain_handle);
 	if (ret < 0)
diff --git a/drivers/irqchip/irq-loongson-pch-pic.c b/drivers/irqchip/irq-loongson-pch-pic.c
index b6f1392964b1..c01b9c257005 100644
--- a/drivers/irqchip/irq-loongson-pch-pic.c
+++ b/drivers/irqchip/irq-loongson-pch-pic.c
@@ -48,25 +48,6 @@ static struct pch_pic *pch_pic_priv[MAX_IO_PICS];
 
 struct fwnode_handle *pch_pic_handle[MAX_IO_PICS];
 
-int find_pch_pic(u32 gsi)
-{
-	int i;
-
-	/* Find the PCH_PIC that manages this GSI. */
-	for (i = 0; i < MAX_IO_PICS; i++) {
-		struct pch_pic *priv = pch_pic_priv[i];
-
-		if (!priv)
-			return -1;
-
-		if (gsi >= priv->gsi_base && gsi < (priv->gsi_base + priv->vec_count))
-			return i;
-	}
-
-	pr_err("ERROR: Unable to locate PCH_PIC for GSI %d\n", gsi);
-	return -1;
-}
-
 static void pch_pic_bitset(struct pch_pic *priv, int offset, int bit)
 {
 	u32 reg;
@@ -325,6 +306,25 @@ IRQCHIP_DECLARE(pch_pic, "loongson,pch-pic-1.0", pch_pic_of_init);
 #endif
 
 #ifdef CONFIG_ACPI
+int find_pch_pic(u32 gsi)
+{
+	int i;
+
+	/* Find the PCH_PIC that manages this GSI. */
+	for (i = 0; i < MAX_IO_PICS; i++) {
+		struct pch_pic *priv = pch_pic_priv[i];
+
+		if (!priv)
+			return -1;
+
+		if (gsi >= priv->gsi_base && gsi < (priv->gsi_base + priv->vec_count))
+			return i;
+	}
+
+	pr_err("ERROR: Unable to locate PCH_PIC for GSI %d\n", gsi);
+	return -1;
+}
+
 static int __init
 pch_lpc_parse_madt(union acpi_subtable_headers *header,
 		       const unsigned long end)
@@ -349,7 +349,7 @@ int __init pch_pic_acpi_init(struct irq_domain *parent,
 
 	vec_base = acpi_pchpic->gsi_base - GSI_MIN_PCH_IRQ;
 
-	domain_handle = irq_domain_alloc_fwnode((phys_addr_t *)acpi_pchpic);
+	domain_handle = irq_domain_alloc_fwnode(&acpi_pchpic->address);
 	if (!domain_handle) {
 		pr_err("Unable to allocate domain handle\n");
 		return -ENOMEM;
