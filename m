Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F8C5477F72
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 22:43:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242489AbhLPVnQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 16:43:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242246AbhLPVla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 16:41:30 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D713DC0613B1;
        Thu, 16 Dec 2021 13:40:58 -0800 (PST)
Date:   Thu, 16 Dec 2021 21:40:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639690857;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LY8gzc1j9HWrNOCYoO+aquHxY36oRS82WFlz0wgMlq8=;
        b=I+mubupAVfdc7BJHtH7PP8NgiJqvWWtqKfcL7alpMTlD/1AHRS8uaihIY3CX3ZxDyUYSuu
        osfANu/eFkgY5/La1a1BMOgAu5bEVGRrISQ6yKyx9uvzpJLCdwHwWaXbleabRZ8oh3ClRo
        Y8WorFhs7gbQDlgNWW6fu7ly0uyiPr/oe+tt9dhR7iHEJt9WS4cBui2P4CvwA8W8QbK56A
        qc9m1EleJ4tT3HnsjWNsOD2n6EvoOEpvdxU26qyYIycJZspYjqj5VQguH+iTQPFkMz3kPS
        7OKAEcsta7aUn0/t2bbellpy2PZv8Ea3redgdWycJI3Z5ajZwARmoIXm/swy8Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639690857;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LY8gzc1j9HWrNOCYoO+aquHxY36oRS82WFlz0wgMlq8=;
        b=tE4SQOJDBDK3BvY6vuK0++9xgAeA22iNRcEFEMcv+Y0WtVh8UWJr5RqArDnDUOaGV60mY7
        SPUHj8PmuyRTaZCg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/msi] soc: ti: ti_sci_inta_msi: Use msi_desc::msi_index
Cc:     Thomas Gleixner <tglx@linutronix.de>, Nishanth Menon <nm@ti.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@nvidia.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211210221814.540704224@linutronix.de>
References: <20211210221814.540704224@linutronix.de>
MIME-Version: 1.0
Message-ID: <163969085651.23020.10250012769284482676.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     0f18095871fc59c89a281caf6f18538cf9e50fbf
Gitweb:        https://git.kernel.org/tip/0f18095871fc59c89a281caf6f18538cf9e50fbf
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 10 Dec 2021 23:19:17 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 16 Dec 2021 22:16:40 +01:00

soc: ti: ti_sci_inta_msi: Use msi_desc::msi_index

Use the common msi_index member and get rid of the pointless wrapper struct.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Nishanth Menon <nm@ti.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Acked-by: Nishanth Menon <nm@ti.com>
Link: https://lore.kernel.org/r/20211210221814.540704224@linutronix.de

---
 drivers/irqchip/irq-ti-sci-inta.c |  2 +-
 drivers/soc/ti/ti_sci_inta_msi.c  |  6 +++---
 include/linux/msi.h               | 16 ++--------------
 3 files changed, 6 insertions(+), 18 deletions(-)

diff --git a/drivers/irqchip/irq-ti-sci-inta.c b/drivers/irqchip/irq-ti-sci-inta.c
index 8eba08d..5fdbb43 100644
--- a/drivers/irqchip/irq-ti-sci-inta.c
+++ b/drivers/irqchip/irq-ti-sci-inta.c
@@ -595,7 +595,7 @@ static void ti_sci_inta_msi_set_desc(msi_alloc_info_t *arg,
 	struct platform_device *pdev = to_platform_device(desc->dev);
 
 	arg->desc = desc;
-	arg->hwirq = TO_HWIRQ(pdev->id, desc->inta.dev_index);
+	arg->hwirq = TO_HWIRQ(pdev->id, desc->msi_index);
 }
 
 static struct msi_domain_ops ti_sci_inta_msi_ops = {
diff --git a/drivers/soc/ti/ti_sci_inta_msi.c b/drivers/soc/ti/ti_sci_inta_msi.c
index a89bcbc..9d23daa 100644
--- a/drivers/soc/ti/ti_sci_inta_msi.c
+++ b/drivers/soc/ti/ti_sci_inta_msi.c
@@ -84,7 +84,7 @@ static int ti_sci_inta_msi_alloc_descs(struct device *dev,
 				return -ENOMEM;
 			}
 
-			msi_desc->inta.dev_index = res->desc[set].start + i;
+			msi_desc->msi_index = res->desc[set].start + i;
 			INIT_LIST_HEAD(&msi_desc->list);
 			list_add_tail(&msi_desc->list, dev_to_msi_list(dev));
 			count++;
@@ -96,7 +96,7 @@ static int ti_sci_inta_msi_alloc_descs(struct device *dev,
 				return -ENOMEM;
 			}
 
-			msi_desc->inta.dev_index = res->desc[set].start_sec + i;
+			msi_desc->msi_index = res->desc[set].start_sec + i;
 			INIT_LIST_HEAD(&msi_desc->list);
 			list_add_tail(&msi_desc->list, dev_to_msi_list(dev));
 			count++;
@@ -154,7 +154,7 @@ unsigned int ti_sci_inta_msi_get_virq(struct device *dev, u32 dev_index)
 	struct msi_desc *desc;
 
 	for_each_msi_entry(desc, dev)
-		if (desc->inta.dev_index == dev_index)
+		if (desc->msi_index == dev_index)
 			return desc->irq;
 
 	return -ENODEV;
diff --git a/include/linux/msi.h b/include/linux/msi.h
index 25edf83..45ec5d0 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -107,14 +107,6 @@ struct pci_msi_desc {
 };
 
 /**
- * ti_sci_inta_msi_desc - TISCI based INTA specific msi descriptor data
- * @dev_index: TISCI device index
- */
-struct ti_sci_inta_msi_desc {
-	u16	dev_index;
-};
-
-/**
  * struct msi_desc - Descriptor structure for MSI based interrupts
  * @list:	List head for management
  * @irq:	The base interrupt number
@@ -128,8 +120,7 @@ struct ti_sci_inta_msi_desc {
  * @write_msi_msg_data:	Data parameter for the callback.
  *
  * @msi_index:	Index of the msi descriptor
- * @pci:	[PCI]	    PCI speficic msi descriptor data
- * @inta:	[INTA]	    TISCI based INTA specific msi descriptor data
+ * @pci:	PCI specific msi descriptor data
  */
 struct msi_desc {
 	/* Shared device/bus type independent data */
@@ -147,10 +138,7 @@ struct msi_desc {
 	void *write_msi_msg_data;
 
 	u16				msi_index;
-	union {
-		struct pci_msi_desc		pci;
-		struct ti_sci_inta_msi_desc	inta;
-	};
+	struct pci_msi_desc		pci;
 };
 
 /**
