Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4656655B6E1
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Jun 2022 07:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232261AbiF0FNV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 01:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231834AbiF0FNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 01:13:04 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3A592BFB;
        Sun, 26 Jun 2022 22:13:03 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 6232E5C00FC;
        Mon, 27 Jun 2022 01:13:03 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 27 Jun 2022 01:13:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1656306783; x=1656393183; bh=wU
        N1+m3amFs/T9ggw9lR4TovIgER88ljJACClYd7QvQ=; b=sCz5atL50hK3HMkou7
        /8S5XZ9Lxxjv7Xamb+JGuNJx/yoLPAerpL4OMbtCSlDjvR8GIFxWGxW/ibKnH7nt
        CqgYU/iBARbAbYB2gvxtZ2q+3tYiwMTE+DGTN8aWeXOq9dfnekeuXk4F+gQ8eDAe
        y41PjBKNPAWNvjMJp5uzC4p7CNccoCQtkOesbQqYz7FPa3hh+Jid9V58eV+4B1yo
        fWLjDkNmTcmQCTCXflGeTceUvQhp90xIFrGzdDD9Jc3tt4b5WH5lGKYb1Pi4yCj1
        /B9p8Xlvtp8ZnIXw9g12PKvaBdhrfX26ZVZSXQnEzXmo1Ms1nZ32HNjgYOMm4s4l
        aoLA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1656306783; x=1656393183; bh=wUN1+m3amFs/T
        9ggw9lR4TovIgER88ljJACClYd7QvQ=; b=qR2M9a1en554dFn8nonZS6Q8PRYA3
        lDRpt59G8c5nTn/RgNKquOYVqcEZbTLrkbZrm6BRaaxrByWBbKnmnj5WJq+D+jLj
        kdr5jskydzlbnE1naKVjy8U/u7bFm7SlIcwRq4G12k8ej3eoLVIjLa2Y3qqMFDlM
        wYETmzNh6I9EfwHdD6rM4Dqh8GCUmTYhbtPMQ2ezY52HLsJqqDxPfxQwfytRUxuQ
        WAzc1aKVeKAfQ1i3shKOIFFIscfWzcGoVD3bD0qDNzmixco1axgdaxmL5ItIMW8D
        ZoSjs0ynNG7IcItT6yNk1P+o4xZgbhX2M73/Q6ILCPqIaZ0xJ9uLpREHQ==
X-ME-Sender: <xms:Xzy5YleNkYoKiRSozwa4i24EBv-V-j27r8ULCHCyiw62wN64ziEapQ>
    <xme:Xzy5YjN0H8v5EUdcqGyd2l7826gXWTfgmUOKZTSHGoF0xusNqabJNnP7N8vA4CALv
    JrQR_ciGODwFjOgrg>
X-ME-Received: <xmr:Xzy5YuijLg_ak4xO6Dyy6wm2QG2m_PNcoqgCQdG_dkMGiLOseIAHvpflXRLl9I1O9emse5ojAt6UZEhN7eif78IeMxvNNDCWoLwTjg4T0IsCgUUqkIu__nxbDRxq3l2y-m1HFQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudeggedgkeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepudekteeuudehtdelteevgfduvddvjefhfedulefgudevgeeghefg
    udefiedtveetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:Xzy5Yu-l4ex7Ky516vw9ym6nrcFOcGvUZqfVCpMNYl5uxB65aR_qRg>
    <xmx:Xzy5YhslwA0Yr5BQvvH0sKoMmdWqU3O3iIoThyGWi9K1V9Ssr9vC8w>
    <xmx:Xzy5YtGq8Jssty752eTUg9ajNL0jhImgz8u-c2WcjPQvPalYqPv0jQ>
    <xmx:Xzy5Yq8eP8oSVzxEdBcrqM4Pq_tyTqnmBRhbF7Kokgj8kk17-rZTgg>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Jun 2022 01:13:02 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        Sagar Kadam <sagar.kadam@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>
Cc:     linux-renesas-soc@vger.kernel.org, Guo Ren <guoren@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Thomas Gleixner <tglx@linutronix.de>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Samuel Holland <samuel@sholland.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: [PATCH v1 3/3] irqchip/sifive-plic: Fix T-HEAD PLIC edge trigger handling
Date:   Mon, 27 Jun 2022 00:12:57 -0500
Message-Id: <20220627051257.38543-4-samuel@sholland.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220627051257.38543-1-samuel@sholland.org>
References: <20220627051257.38543-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The T-HEAD PLIC ignores additional edges seen while an edge-triggered
interrupt is being handled. Because of this behavior, the driver needs
to complete edge-triggered interrupts in the .irq_ack callback before
handling them, instead of in the .irq_eoi callback afterward. Otherwise,
it could miss some interrupts.

Co-developed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Signed-off-by: Samuel Holland <samuel@sholland.org>
---

Changes in v1:
 - Use a flag for enabling the changes instead of a variant ID
 - Use handle_edge_irq instead of handle_fasteoi_ack_irq
 - Do not set the handler name, as RISC-V selects GENERIC_IRQ_SHOW_LEVEL

 drivers/irqchip/irq-sifive-plic.c | 76 +++++++++++++++++++++++++++++--
 1 file changed, 71 insertions(+), 5 deletions(-)

diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index 90515865af08..462a93b4b088 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -69,6 +69,7 @@ struct plic_priv {
 	struct cpumask lmask;
 	struct irq_domain *irqdomain;
 	void __iomem *regs;
+	bool needs_edge_handling;
 };
 
 struct plic_handler {
@@ -86,6 +87,9 @@ static int plic_parent_irq __ro_after_init;
 static bool plic_cpuhp_setup_done __ro_after_init;
 static DEFINE_PER_CPU(struct plic_handler, plic_handlers);
 
+static struct irq_chip plic_edge_chip;
+static struct irq_chip plic_chip;
+
 static void __plic_toggle(void __iomem *enable_base, int hwirq, int enable)
 {
 	u32 __iomem *reg = enable_base + (hwirq / 32) * sizeof(u32);
@@ -181,6 +185,40 @@ static void plic_irq_eoi(struct irq_data *d)
 	}
 }
 
+static int plic_irq_set_type(struct irq_data *d, unsigned int flow_type)
+{
+	struct plic_priv *priv = irq_data_get_irq_chip_data(d);
+
+	if (!priv->needs_edge_handling)
+		return IRQ_SET_MASK_OK_NOCOPY;
+
+	switch (flow_type) {
+	case IRQ_TYPE_EDGE_RISING:
+		irq_set_chip_handler_name_locked(d, &plic_edge_chip,
+						 handle_edge_irq, NULL);
+		break;
+	case IRQ_TYPE_LEVEL_HIGH:
+		irq_set_chip_handler_name_locked(d, &plic_chip,
+						 handle_fasteoi_irq, NULL);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return IRQ_SET_MASK_OK;
+}
+
+static struct irq_chip plic_edge_chip = {
+	.name			= "PLIC",
+	.irq_ack		= plic_irq_eoi,
+	.irq_mask		= plic_irq_mask,
+	.irq_unmask		= plic_irq_unmask,
+#ifdef CONFIG_SMP
+	.irq_set_affinity	= plic_set_affinity,
+#endif
+	.irq_set_type		= plic_irq_set_type,
+};
+
 static struct irq_chip plic_chip = {
 	.name			= "PLIC",
 	.irq_mask		= plic_irq_mask,
@@ -189,8 +227,22 @@ static struct irq_chip plic_chip = {
 #ifdef CONFIG_SMP
 	.irq_set_affinity	= plic_set_affinity,
 #endif
+	.irq_set_type		= plic_irq_set_type,
 };
 
+static int plic_irq_domain_translate(struct irq_domain *d,
+				     struct irq_fwspec *fwspec,
+				     unsigned long *hwirq,
+				     unsigned int *type)
+{
+	struct plic_priv *priv = d->host_data;
+
+	if (priv->needs_edge_handling)
+		return irq_domain_translate_twocell(d, fwspec, hwirq, type);
+	else
+		return irq_domain_translate_onecell(d, fwspec, hwirq, type);
+}
+
 static int plic_irqdomain_map(struct irq_domain *d, unsigned int irq,
 			      irq_hw_number_t hwirq)
 {
@@ -211,7 +263,7 @@ static int plic_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
 	unsigned int type;
 	struct irq_fwspec *fwspec = arg;
 
-	ret = irq_domain_translate_onecell(domain, fwspec, &hwirq, &type);
+	ret = plic_irq_domain_translate(domain, fwspec, &hwirq, &type);
 	if (ret)
 		return ret;
 
@@ -225,7 +277,7 @@ static int plic_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
 }
 
 static const struct irq_domain_ops plic_irqdomain_ops = {
-	.translate	= irq_domain_translate_onecell,
+	.translate	= plic_irq_domain_translate,
 	.alloc		= plic_irq_domain_alloc,
 	.free		= irq_domain_free_irqs_top,
 };
@@ -286,8 +338,9 @@ static int plic_starting_cpu(unsigned int cpu)
 	return 0;
 }
 
-static int __init plic_init(struct device_node *node,
-		struct device_node *parent)
+static int __init __plic_init(struct device_node *node,
+			      struct device_node *parent,
+			      bool needs_edge_handling)
 {
 	int error = 0, nr_contexts, nr_handlers = 0, i;
 	u32 nr_irqs;
@@ -298,6 +351,8 @@ static int __init plic_init(struct device_node *node,
 	if (!priv)
 		return -ENOMEM;
 
+	priv->needs_edge_handling = needs_edge_handling;
+
 	priv->regs = of_iomap(node, 0);
 	if (WARN_ON(!priv->regs)) {
 		error = -EIO;
@@ -415,6 +470,17 @@ static int __init plic_init(struct device_node *node,
 	return error;
 }
 
+static int __init plic_init(struct device_node *node,
+			    struct device_node *parent)
+{
+	return __plic_init(node, parent, false);
+}
 IRQCHIP_DECLARE(sifive_plic, "sifive,plic-1.0.0", plic_init);
 IRQCHIP_DECLARE(riscv_plic0, "riscv,plic0", plic_init); /* for legacy systems */
-IRQCHIP_DECLARE(thead_c900_plic, "thead,c900-plic", plic_init); /* for firmware driver */
+
+static int __init plic_edge_init(struct device_node *node,
+				     struct device_node *parent)
+{
+	return __plic_init(node, parent, true);
+}
+IRQCHIP_DECLARE(thead_c900_plic, "thead,c900-plic", plic_edge_init);
-- 
2.35.1

