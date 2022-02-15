Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC52C4B6BE4
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 13:20:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237594AbiBOMUN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 07:20:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232311AbiBOMUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 07:20:09 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F30311074E9
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 04:19:59 -0800 (PST)
Date:   Tue, 15 Feb 2022 12:19:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1644927597;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HJXSiMbeWCG4en7Oq51qjbMSGIO8Y7CH8SdPMxV821k=;
        b=hNp9eQruLBn5CFKYYfHot+SWh+3raGRksgyl1LdIFbW/YZf9enwzCG6QxJkyaccdVW4siH
        w1OGGNu9y2XaK4wTpjMI3fck6WzpeTENBnNKTmeTAikVe/V2Ujgm2atzEnr5YLZT92QKou
        Z2UIIuxL+4r2trFxHCYRffzcg2/J1AKoql0oTCprwCIjW2CDe0ArpNfNVhiFGlMwQuucgD
        ZNf/Wn8kUtRW7xvkynVjZTU56i2GrhBMBro8M3ozVjRrisXyZgnym3PODQXVBJeebX1gPM
        H43TEeSDcbMwjxYw+FAP3O4LwQFGNw8Rru071XV1xC1pa5Cv4qgm5llOB7iNeA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1644927597;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HJXSiMbeWCG4en7Oq51qjbMSGIO8Y7CH8SdPMxV821k=;
        b=UwIizyf03WJWnbSC40hh5VJp8LfQUyHpyex2HVAQyPGGqxcCkrMaHGxawpZIHv+DFys3rl
        qYArR89dTGDx5lBA==
From:   "irqchip-bot for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/ts4800: Switch to dynamic chip
 name output
Cc:     Marc Zyngier <maz@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>, tglx@linutronix.de
In-Reply-To: <20220209162607.1118325-7-maz@kernel.org>
References: <20220209162607.1118325-7-maz@kernel.org>
MIME-Version: 1.0
Message-ID: <164492759640.16921.2490149451504400965.tip-bot2@tip-bot2>
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

Commit-ID:     3344265a2692414831c15964dd27a5b4adc4ed83
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/3344265a2692414831c15964dd27a5b4adc4ed83
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Wed, 09 Feb 2022 16:26:03 
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Tue, 15 Feb 2022 11:25:46 

irqchip/ts4800: Switch to dynamic chip name output

Signed-off-by: Marc Zyngier <maz@kernel.org>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Link: https://lore.kernel.org/r/20220209162607.1118325-7-maz@kernel.org
---
 drivers/irqchip/irq-ts4800.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/irqchip/irq-ts4800.c b/drivers/irqchip/irq-ts4800.c
index f032db2..b2d61d4 100644
--- a/drivers/irqchip/irq-ts4800.c
+++ b/drivers/irqchip/irq-ts4800.c
@@ -19,14 +19,15 @@
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
 #include <linux/platform_device.h>
+#include <linux/seq_file.h>
 
 #define IRQ_MASK        0x4
 #define IRQ_STATUS      0x8
 
 struct ts4800_irq_data {
 	void __iomem            *base;
+	struct platform_device	*pdev;
 	struct irq_domain       *domain;
-	struct irq_chip         irq_chip;
 };
 
 static void ts4800_irq_mask(struct irq_data *d)
@@ -47,12 +48,25 @@ static void ts4800_irq_unmask(struct irq_data *d)
 	writew(reg & ~mask, data->base + IRQ_MASK);
 }
 
+static void ts4800_irq_print_chip(struct irq_data *d, struct seq_file *p)
+{
+	struct ts4800_irq_data *data = irq_data_get_irq_chip_data(d);
+
+	seq_printf(p, "%s", dev_name(&data->pdev->dev));
+}
+
+static const struct irq_chip ts4800_chip = {
+	.irq_mask	= ts4800_irq_mask,
+	.irq_unmask	= ts4800_irq_unmask,
+	.irq_print_chip	= ts4800_irq_print_chip,
+};
+
 static int ts4800_irqdomain_map(struct irq_domain *d, unsigned int irq,
 				irq_hw_number_t hwirq)
 {
 	struct ts4800_irq_data *data = d->host_data;
 
-	irq_set_chip_and_handler(irq, &data->irq_chip, handle_simple_irq);
+	irq_set_chip_and_handler(irq, &ts4800_chip, handle_simple_irq);
 	irq_set_chip_data(irq, data);
 	irq_set_noprobe(irq);
 
@@ -92,13 +106,13 @@ static int ts4800_ic_probe(struct platform_device *pdev)
 {
 	struct device_node *node = pdev->dev.of_node;
 	struct ts4800_irq_data *data;
-	struct irq_chip *irq_chip;
 	int parent_irq;
 
 	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 
+	data->pdev = pdev;
 	data->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(data->base))
 		return PTR_ERR(data->base);
@@ -111,11 +125,6 @@ static int ts4800_ic_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	irq_chip = &data->irq_chip;
-	irq_chip->name = dev_name(&pdev->dev);
-	irq_chip->irq_mask = ts4800_irq_mask;
-	irq_chip->irq_unmask = ts4800_irq_unmask;
-
 	data->domain = irq_domain_add_linear(node, 8, &ts4800_ic_ops, data);
 	if (!data->domain) {
 		dev_err(&pdev->dev, "cannot add IRQ domain\n");
