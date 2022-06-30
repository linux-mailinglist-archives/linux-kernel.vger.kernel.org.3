Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9337B56172E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 12:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234688AbiF3KDA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 06:03:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233737AbiF3KCs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 06:02:48 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9059843ED6;
        Thu, 30 Jun 2022 03:02:47 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id F3CEE5C01F4;
        Thu, 30 Jun 2022 06:02:46 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 30 Jun 2022 06:02:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1656583366; x=1656669766; bh=US
        XwQha+QBnfM1Fl9ZZwnvSmTAXqjsiFPn241fwtTZo=; b=Ie/JCDy1b7M4it9W6y
        J6ueYIYmmE9LgQ5IZZSekViY0DzfPNzrziv3TlvilS6WVUw5/EMWjJhJLzUY3flB
        /lySGk6KXyP4QtQYDhajiOPe1ClmCrgvNEk07a/gUPczLpCmBtQztj9yUhdntHGs
        KZM02gz57I69BtUfS++fEFsKrx0eznHjsCWVJL3jBFCR2IK57FnwC/edID+VAZb0
        2SdRlReRM9YbtoScW3VOhZro7oWBXFQ7XGayPRktXnrHmJdK9Nv39O50pN+dKxHv
        z+W4gAUCzFI1KOScQ9hU1sS6n3iCnCHEAlfp4wvJKg0X90LODq5lUMWuKYrqpYOF
        IFFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1656583366; x=1656669766; bh=USXwQha+QBnfM
        1Fl9ZZwnvSmTAXqjsiFPn241fwtTZo=; b=lSKLQ6Dg6SVJcdW0Dy/46aBAnCTEp
        xPKHrO/eJ5ZL9CvKyuSWdPHQWrpVu4fTSsXiQBSd5S3DjHAizqNg1GZeG9aoLeZg
        q56zBVuI070aNztSP6t1pUqsfOn8F0thvbk0aQSiysYF7A6K8GTs299tHRD+vMXH
        B5p33kVmLDRpn9+yvOT5t9/gdQRQ7ZjJKQkvsrniKviyafBKyDMu9OJ/1o1H2FSj
        k0JtyTfb6pwDeVUtIuA8emIHneyqkCneRhtBiUinsnDp+8KW07tkBkKz0ScrI/fo
        HjLio7+9EpWDGaP5j5cSQ2mRArt1s98GpPf3oZrC33VAozC5Nph1902Ig==
X-ME-Sender: <xms:xnS9Yn5qsP8aGTlV3r7EIkhAQWUOGbVpUq6F0AY5MibVHZ9F98fo_Q>
    <xme:xnS9Ys6n6BUnhnT-gWyhkEf5h5tcmEmMsoVggd8fAlqfFtEJ2R5o0Tx7ong2TOrMb
    cfMkF00I8CYYkMe7Q>
X-ME-Received: <xmr:xnS9YufeGqh84dVwo95Y_n3utFIYCRUGGwnsUzehWPNMAdBV5iHCpF-l22XRd4rtSfQhRtTBHPHIUgfatllU4E7R5K59gpWn2ySRamC9iQ3a3t1fuCJjSYrWt_nsEuayqmhdtQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudehuddgvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepudekteeuudehtdelteevgfduvddvjefhfedulefgudevgeeghefg
    udefiedtveetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:xnS9YoLei8vgjCPk91q6bFrZCqlCLyuernU_-U_0wpDfcE88_G3XPA>
    <xmx:xnS9YrJNkmzGfGGzNJxEv1Ns4ZF9j-A5rz9AxR4e4Jr2yuo26svSpg>
    <xmx:xnS9YhydFynDr-j6OsJoTo9UHP2Fb4jsC61aQbe5QNsVFP-cK38b7Q>
    <xmx:xnS9Ys60oC2ollD8JbhSJ08Oc8aEV90bcrqxs2Doq4A9sgrPZ0QhPw>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Jun 2022 06:02:45 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        Sagar Kadam <sagar.kadam@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Guo Ren <guoren@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-renesas-soc@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Samuel Holland <samuel@sholland.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: [PATCH v3 2/4] irqchip/sifive-plic: Add support for Renesas RZ/Five SoC
Date:   Thu, 30 Jun 2022 05:02:39 -0500
Message-Id: <20220630100241.35233-3-samuel@sholland.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220630100241.35233-1-samuel@sholland.org>
References: <20220630100241.35233-1-samuel@sholland.org>
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

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

The Renesas RZ/Five SoC has a RISC-V AX45MP AndesCore with NCEPLIC100. The
NCEPLIC100 supports both edge-triggered and level-triggered interrupts. In
case of edge-triggered interrupts NCEPLIC100 ignores the next interrupt
edge until the previous completion message has been received and
NCEPLIC100 doesn't support pending interrupt counter, hence losing the
interrupts if not acknowledged in time.

So the workaround for edge-triggered interrupts to be handled correctly
and without losing is that it needs to be acknowledged first and then
handler must be run so that we don't miss on the next edge-triggered
interrupt.

This patch adds a new compatible string for NCEPLIC100 (from Andes
Technology) interrupt controller found on Renesas RZ/Five SoC and adds
quirk bits to priv structure and implements PLIC_QUIRK_EDGE_INTERRUPT
quirk to change the interrupt flow.

Suggested-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Signed-off-by: Samuel Holland <samuel@sholland.org>
---

Changes in v3:
 - Use a quirk bit for selecting the flow instead of a variant ID
 - Use the andestech,nceplic100 compatible to select the new behavior
 - Use handle_edge_irq instead of handle_fasteoi_ack_irq so .irq_ack
   always gets called
 - Do not set the handler name, as RISC-V selects GENERIC_IRQ_SHOW_LEVEL
 - Use the same name for plic_edge_chip as plic_chip

Changes in v2:
 - Fixed review comments pointed by Marc and Krzysztof.

Changes in v1:
 - Fixed review comments pointed by Rob and Geert.
 - Changed implementation for EDGE interrupt handling on Renesas RZ/Five
   SoC.

 drivers/irqchip/irq-sifive-plic.c | 78 +++++++++++++++++++++++++++++--
 1 file changed, 74 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index bb87e4c3b88e..90e44367bee9 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -60,10 +60,13 @@
 #define	PLIC_DISABLE_THRESHOLD		0x7
 #define	PLIC_ENABLE_THRESHOLD		0
 
+#define PLIC_QUIRK_EDGE_INTERRUPT	0
+
 struct plic_priv {
 	struct cpumask lmask;
 	struct irq_domain *irqdomain;
 	void __iomem *regs;
+	unsigned long plic_quirks;
 };
 
 struct plic_handler {
@@ -81,6 +84,8 @@ static int plic_parent_irq __ro_after_init;
 static bool plic_cpuhp_setup_done __ro_after_init;
 static DEFINE_PER_CPU(struct plic_handler, plic_handlers);
 
+static int plic_irq_set_type(struct irq_data *d, unsigned int type);
+
 static void __plic_toggle(void __iomem *enable_base, int hwirq, int enable)
 {
 	u32 __iomem *reg = enable_base + (hwirq / 32) * sizeof(u32);
@@ -176,6 +181,17 @@ static void plic_irq_eoi(struct irq_data *d)
 	}
 }
 
+static struct irq_chip plic_edge_chip = {
+	.name		= "SiFive PLIC",
+	.irq_ack	= plic_irq_eoi,
+	.irq_mask	= plic_irq_mask,
+	.irq_unmask	= plic_irq_unmask,
+#ifdef CONFIG_SMP
+	.irq_set_affinity = plic_set_affinity,
+#endif
+	.irq_set_type	= plic_irq_set_type,
+};
+
 static struct irq_chip plic_chip = {
 	.name		= "SiFive PLIC",
 	.irq_mask	= plic_irq_mask,
@@ -184,8 +200,32 @@ static struct irq_chip plic_chip = {
 #ifdef CONFIG_SMP
 	.irq_set_affinity = plic_set_affinity,
 #endif
+	.irq_set_type	= plic_irq_set_type,
 };
 
+static int plic_irq_set_type(struct irq_data *d, unsigned int type)
+{
+	struct plic_priv *priv = irq_data_get_irq_chip_data(d);
+
+	if (!test_bit(PLIC_QUIRK_EDGE_INTERRUPT, &priv->plic_quirks))
+		return IRQ_SET_MASK_OK_NOCOPY;
+
+	switch (type) {
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
 static int plic_irqdomain_map(struct irq_domain *d, unsigned int irq,
 			      irq_hw_number_t hwirq)
 {
@@ -198,6 +238,19 @@ static int plic_irqdomain_map(struct irq_domain *d, unsigned int irq,
 	return 0;
 }
 
+static int plic_irq_domain_translate(struct irq_domain *d,
+				     struct irq_fwspec *fwspec,
+				     unsigned long *hwirq,
+				     unsigned int *type)
+{
+	struct plic_priv *priv = d->host_data;
+
+	if (test_bit(PLIC_QUIRK_EDGE_INTERRUPT, &priv->plic_quirks))
+		return irq_domain_translate_twocell(d, fwspec, hwirq, type);
+
+	return irq_domain_translate_onecell(d, fwspec, hwirq, type);
+}
+
 static int plic_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
 				 unsigned int nr_irqs, void *arg)
 {
@@ -206,7 +259,7 @@ static int plic_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
 	unsigned int type;
 	struct irq_fwspec *fwspec = arg;
 
-	ret = irq_domain_translate_onecell(domain, fwspec, &hwirq, &type);
+	ret = plic_irq_domain_translate(domain, fwspec, &hwirq, &type);
 	if (ret)
 		return ret;
 
@@ -220,7 +273,7 @@ static int plic_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
 }
 
 static const struct irq_domain_ops plic_irqdomain_ops = {
-	.translate	= irq_domain_translate_onecell,
+	.translate	= plic_irq_domain_translate,
 	.alloc		= plic_irq_domain_alloc,
 	.free		= irq_domain_free_irqs_top,
 };
@@ -281,8 +334,9 @@ static int plic_starting_cpu(unsigned int cpu)
 	return 0;
 }
 
-static int __init plic_init(struct device_node *node,
-		struct device_node *parent)
+static int __init __plic_init(struct device_node *node,
+			      struct device_node *parent,
+			      unsigned long plic_quirks)
 {
 	int error = 0, nr_contexts, nr_handlers = 0, i;
 	u32 nr_irqs;
@@ -293,6 +347,8 @@ static int __init plic_init(struct device_node *node,
 	if (!priv)
 		return -ENOMEM;
 
+	priv->plic_quirks = plic_quirks;
+
 	priv->regs = of_iomap(node, 0);
 	if (WARN_ON(!priv->regs)) {
 		error = -EIO;
@@ -410,6 +466,20 @@ static int __init plic_init(struct device_node *node,
 	return error;
 }
 
+static int __init plic_init(struct device_node *node,
+			    struct device_node *parent)
+{
+	return __plic_init(node, parent, 0);
+}
+
 IRQCHIP_DECLARE(sifive_plic, "sifive,plic-1.0.0", plic_init);
 IRQCHIP_DECLARE(riscv_plic0, "riscv,plic0", plic_init); /* for legacy systems */
 IRQCHIP_DECLARE(thead_c900_plic, "thead,c900-plic", plic_init); /* for firmware driver */
+
+static int __init plic_edge_init(struct device_node *node,
+				 struct device_node *parent)
+{
+	return __plic_init(node, parent, BIT(PLIC_QUIRK_EDGE_INTERRUPT));
+}
+
+IRQCHIP_DECLARE(andestech_nceplic100, "andestech,nceplic100", plic_edge_init);
-- 
2.35.1

