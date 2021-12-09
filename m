Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7384A46ECB5
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 17:08:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236947AbhLIQLO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 11:11:14 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:40098 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240899AbhLIQKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 11:10:44 -0500
Date:   Thu, 09 Dec 2021 16:07:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639066030;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RKqBu5KD0X5AJyZflcem/E0kKVFhL2g3JJ35BtBzALc=;
        b=4DYIIiq91Gq8agdNq0G5KZuHZHxIJzXDxiKjV+9U+jjlQQVxIpmSx0Atoocr/3TT3abHRI
        HL+mmgBqnUnv9jcycA2GeeAX/naS6SZZ8kwSNRi5nD1WU2XOQrOGchx5npDwhJlnHpQTk8
        JzFMOKc2es/cjRr3aoP3vKHtDRLXpBO43AI09K2qpERnP6Q7EnyihH7QT3mCg7tEmVpVt5
        5nzGRYPox9vnvMgM63AXFG+IeNd64yCNngC+mEXyhKevsMR+CSPpjaCvEZJcJnOOxxP8Op
        k39G0TZRdJbX2qaAfDmTsQiTwlHkreJ4q1remmGy4T9KTXiU3H6YL4h0CwAVHg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639066030;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RKqBu5KD0X5AJyZflcem/E0kKVFhL2g3JJ35BtBzALc=;
        b=Bj04M8QMTn/tV2E2w5DAnTe+D33NP+fxMPQucdWMzYsm5a+MHFHyhEkGyVFNmvjwFQ5+S2
        D0Vj8J9qX68CraCw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/msi] PCI/MSI: Remove msi_desc_to_pci_sysdata()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Juergen Gross <jgross@suse.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Bjorn Helgaas <bhelgaas@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211206210224.210768199@linutronix.de>
References: <20211206210224.210768199@linutronix.de>
MIME-Version: 1.0
Message-ID: <163906602922.11128.8909973797028580799.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     ade044a3d0f0389e4f916337c505550acc3fd011
Gitweb:        https://git.kernel.org/tip/ade044a3d0f0389e4f916337c505550acc3fd011
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 06 Dec 2021 23:27:34 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 09 Dec 2021 11:52:21 +01:00

PCI/MSI: Remove msi_desc_to_pci_sysdata()

Last user is gone long ago.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Juergen Gross <jgross@suse.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Link: https://lore.kernel.org/r/20211206210224.210768199@linutronix.de

---
 drivers/pci/msi.c   | 8 --------
 include/linux/msi.h | 5 -----
 2 files changed, 13 deletions(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index afa8ba2..e1aecd9 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -1267,14 +1267,6 @@ struct pci_dev *msi_desc_to_pci_dev(struct msi_desc *desc)
 }
 EXPORT_SYMBOL(msi_desc_to_pci_dev);
 
-void *msi_desc_to_pci_sysdata(struct msi_desc *desc)
-{
-	struct pci_dev *dev = msi_desc_to_pci_dev(desc);
-
-	return dev->bus->sysdata;
-}
-EXPORT_SYMBOL_GPL(msi_desc_to_pci_sysdata);
-
 #ifdef CONFIG_PCI_MSI_IRQ_DOMAIN
 /**
  * pci_msi_domain_write_msg - Helper to write MSI message to PCI config space
diff --git a/include/linux/msi.h b/include/linux/msi.h
index d7b143a..ac6fec1 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -218,13 +218,8 @@ static inline void msi_desc_set_iommu_cookie(struct msi_desc *desc,
 	for_each_msi_entry((desc), &(pdev)->dev)
 
 struct pci_dev *msi_desc_to_pci_dev(struct msi_desc *desc);
-void *msi_desc_to_pci_sysdata(struct msi_desc *desc);
 void pci_write_msi_msg(unsigned int irq, struct msi_msg *msg);
 #else /* CONFIG_PCI_MSI */
-static inline void *msi_desc_to_pci_sysdata(struct msi_desc *desc)
-{
-	return NULL;
-}
 static inline void pci_write_msi_msg(unsigned int irq, struct msi_msg *msg)
 {
 }
