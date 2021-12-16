Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADB08477F38
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 22:41:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242345AbhLPVlk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 16:41:40 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:57224 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241903AbhLPVks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 16:40:48 -0500
Date:   Thu, 16 Dec 2021 21:40:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639690847;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hyJg5R4KpwxnIS6V53onT/5LUh7mt30WkL5XaKlsqSQ=;
        b=oStB2dwPZU6N0OGBXaTqp2PJroDkOKXGunJm2BGXI6dOVK9XorAdl5Qj4Kp5BZaV1c3/Bi
        COOcknRPWDx3HBC6PQM9hyUlTzN+px/wGFk0onuH/BJvzB4gMEQyYgBvDOcfuT21ZoyFH+
        eKOVNtYixMhWLVgyyczGZDMt5WQTSLN1OvB03WC81WhdxjCl9DHZoHH+dIJtEORrn8xnQp
        o2pYMUvr0ExlevCrUOgcAeVR34NgTkTW8xm+mIHJ2c9PTLELAof/ggtf4XWZ4w5WhwdpEG
        nHF4LZAnv7bEhAI6JyJPowxgCeKeUh0kDTyxEPvfVwHCSMd5Yqkr+5k2m1aKTg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639690847;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hyJg5R4KpwxnIS6V53onT/5LUh7mt30WkL5XaKlsqSQ=;
        b=jvDLvvvvqyZtUYOqNt0/DKJYUA4pJa0iA0caakaZiS3EPHYGn6c+3VCSS+SJm8IbaHGX3F
        pqlhQSbNwNQvH4Dw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/msi] soc: ti: ti_sci_inta_msi: Get rid of
 ti_sci_inta_msi_get_virq()
Cc:     Thomas Gleixner <tglx@linutronix.de>, Nishanth Menon <nm@ti.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Arnd Bergmann <arnd@arndb.de>, Vinod Koul <vkoul@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20211210221815.269468319@linutronix.de>
References: <20211210221815.269468319@linutronix.de>
MIME-Version: 1.0
Message-ID: <163969084629.23020.15153753758841672055.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     89e0032ec201f76c86d6e3e6f94574dfb8e39b71
Gitweb:        https://git.kernel.org/tip/89e0032ec201f76c86d6e3e6f94574dfb8e39b71
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 10 Dec 2021 23:19:35 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 16 Dec 2021 22:16:41 +01:00

soc: ti: ti_sci_inta_msi: Get rid of ti_sci_inta_msi_get_virq()

Just use the core function msi_get_virq().

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Nishanth Menon <nm@ti.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Vinod Koul <vkoul@kernel.org>
Acked-by: Nishanth Menon <nm@ti.com>
Link: https://lore.kernel.org/r/20211210221815.269468319@linutronix.de

---
 drivers/dma/ti/k3-udma-private.c       |  6 ++----
 drivers/dma/ti/k3-udma.c               | 10 ++++------
 drivers/soc/ti/k3-ringacc.c            |  2 +-
 drivers/soc/ti/ti_sci_inta_msi.c       | 12 ------------
 include/linux/soc/ti/ti_sci_inta_msi.h |  1 -
 5 files changed, 7 insertions(+), 24 deletions(-)

diff --git a/drivers/dma/ti/k3-udma-private.c b/drivers/dma/ti/k3-udma-private.c
index aada84f..d4f1e4e 100644
--- a/drivers/dma/ti/k3-udma-private.c
+++ b/drivers/dma/ti/k3-udma-private.c
@@ -168,8 +168,7 @@ int xudma_pktdma_tflow_get_irq(struct udma_dev *ud, int udma_tflow_id)
 {
 	const struct udma_oes_offsets *oes = &ud->soc_data->oes;
 
-	return ti_sci_inta_msi_get_virq(ud->dev, udma_tflow_id +
-					oes->pktdma_tchan_flow);
+	return msi_get_virq(ud->dev, udma_tflow_id + oes->pktdma_tchan_flow);
 }
 EXPORT_SYMBOL(xudma_pktdma_tflow_get_irq);
 
@@ -177,7 +176,6 @@ int xudma_pktdma_rflow_get_irq(struct udma_dev *ud, int udma_rflow_id)
 {
 	const struct udma_oes_offsets *oes = &ud->soc_data->oes;
 
-	return ti_sci_inta_msi_get_virq(ud->dev, udma_rflow_id +
-					oes->pktdma_rchan_flow);
+	return msi_get_virq(ud->dev, udma_rflow_id + oes->pktdma_rchan_flow);
 }
 EXPORT_SYMBOL(xudma_pktdma_rflow_get_irq);
diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index 20edd0b..86f7a0a 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -2313,8 +2313,7 @@ static int udma_alloc_chan_resources(struct dma_chan *chan)
 
 	/* Event from UDMA (TR events) only needed for slave TR mode channels */
 	if (is_slave_direction(uc->config.dir) && !uc->config.pkt_mode) {
-		uc->irq_num_udma = ti_sci_inta_msi_get_virq(ud->dev,
-							    irq_udma_idx);
+		uc->irq_num_udma = msi_get_virq(ud->dev, irq_udma_idx);
 		if (uc->irq_num_udma <= 0) {
 			dev_err(ud->dev, "Failed to get udma irq (index: %u)\n",
 				irq_udma_idx);
@@ -2486,7 +2485,7 @@ static int bcdma_alloc_chan_resources(struct dma_chan *chan)
 		uc->psil_paired = true;
 	}
 
-	uc->irq_num_ring = ti_sci_inta_msi_get_virq(ud->dev, irq_ring_idx);
+	uc->irq_num_ring = msi_get_virq(ud->dev, irq_ring_idx);
 	if (uc->irq_num_ring <= 0) {
 		dev_err(ud->dev, "Failed to get ring irq (index: %u)\n",
 			irq_ring_idx);
@@ -2503,8 +2502,7 @@ static int bcdma_alloc_chan_resources(struct dma_chan *chan)
 
 	/* Event from BCDMA (TR events) only needed for slave channels */
 	if (is_slave_direction(uc->config.dir)) {
-		uc->irq_num_udma = ti_sci_inta_msi_get_virq(ud->dev,
-							    irq_udma_idx);
+		uc->irq_num_udma = msi_get_virq(ud->dev, irq_udma_idx);
 		if (uc->irq_num_udma <= 0) {
 			dev_err(ud->dev, "Failed to get bcdma irq (index: %u)\n",
 				irq_udma_idx);
@@ -2672,7 +2670,7 @@ static int pktdma_alloc_chan_resources(struct dma_chan *chan)
 
 	uc->psil_paired = true;
 
-	uc->irq_num_ring = ti_sci_inta_msi_get_virq(ud->dev, irq_ring_idx);
+	uc->irq_num_ring = msi_get_virq(ud->dev, irq_ring_idx);
 	if (uc->irq_num_ring <= 0) {
 		dev_err(ud->dev, "Failed to get ring irq (index: %u)\n",
 			irq_ring_idx);
diff --git a/drivers/soc/ti/k3-ringacc.c b/drivers/soc/ti/k3-ringacc.c
index 26159a5..56be391 100644
--- a/drivers/soc/ti/k3-ringacc.c
+++ b/drivers/soc/ti/k3-ringacc.c
@@ -647,7 +647,7 @@ int k3_ringacc_get_ring_irq_num(struct k3_ring *ring)
 	if (!ring)
 		return -EINVAL;
 
-	irq_num = ti_sci_inta_msi_get_virq(ring->parent->dev, ring->ring_id);
+	irq_num = msi_get_virq(ring->parent->dev, ring->ring_id);
 	if (irq_num <= 0)
 		irq_num = -EINVAL;
 	return irq_num;
diff --git a/drivers/soc/ti/ti_sci_inta_msi.c b/drivers/soc/ti/ti_sci_inta_msi.c
index 9d23daa..b68cc6d 100644
--- a/drivers/soc/ti/ti_sci_inta_msi.c
+++ b/drivers/soc/ti/ti_sci_inta_msi.c
@@ -148,15 +148,3 @@ void ti_sci_inta_msi_domain_free_irqs(struct device *dev)
 	ti_sci_inta_msi_free_descs(dev);
 }
 EXPORT_SYMBOL_GPL(ti_sci_inta_msi_domain_free_irqs);
-
-unsigned int ti_sci_inta_msi_get_virq(struct device *dev, u32 dev_index)
-{
-	struct msi_desc *desc;
-
-	for_each_msi_entry(desc, dev)
-		if (desc->msi_index == dev_index)
-			return desc->irq;
-
-	return -ENODEV;
-}
-EXPORT_SYMBOL_GPL(ti_sci_inta_msi_get_virq);
diff --git a/include/linux/soc/ti/ti_sci_inta_msi.h b/include/linux/soc/ti/ti_sci_inta_msi.h
index e3aa8b1..25ea78a 100644
--- a/include/linux/soc/ti/ti_sci_inta_msi.h
+++ b/include/linux/soc/ti/ti_sci_inta_msi.h
@@ -18,6 +18,5 @@ struct irq_domain
 				   struct irq_domain *parent);
 int ti_sci_inta_msi_domain_alloc_irqs(struct device *dev,
 				      struct ti_sci_resource *res);
-unsigned int ti_sci_inta_msi_get_virq(struct device *dev, u32 index);
 void ti_sci_inta_msi_domain_free_irqs(struct device *dev);
 #endif /* __INCLUDE_LINUX_IRQCHIP_TI_SCI_INTA_H */
