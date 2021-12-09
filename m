Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B45C46EC96
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 17:07:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240847AbhLIQKk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 11:10:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240779AbhLIQKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 11:10:34 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1558C0617A1;
        Thu,  9 Dec 2021 08:07:00 -0800 (PST)
Date:   Thu, 09 Dec 2021 16:06:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639066019;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DL5aNwCL8SU6/0MFOiWxUekz5vA48Pvp+L8xH6Q5kMM=;
        b=352K4lGyAw94fZPw7j+tMy9ASUhV+kQ09vwdrhXe9xseXRxf6Mp21LP2tkEGAw0LRq+64s
        TDlRubRstf1Rs2o1vFv/XdDeKn5dBox+HrUA7o7gWcj+2wja+0iuz63R7CqO0l39OVlrd/
        v0lGfQReSHZaDtml7RnAVDa5J7AH+sVJmoXiO1djUQ6Wn/0Fhq5RrMQQreDyx2ukxDZfvS
        APcNVmYCtfA4+UUyhLv2MTtHSbLPKnTR8tbcevhU2opRo+s73XkVnf5wTZszoMY2EBERVr
        qx+HsRUuQsJ0hDxY0t8g/6i+zf1ynTMS7gsSXs2XWg8RiShqh/FMWxBwEgdygg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639066019;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DL5aNwCL8SU6/0MFOiWxUekz5vA48Pvp+L8xH6Q5kMM=;
        b=sWjvVDu7VMUrpPvAkxDWc4d1LQW0aIjfcensAwnRbcgi7REeskR4/U3S1KpPybPOKiO/pY
        xzV/864Y8Vm6LsCg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/msi] PCI/MSI: Make pci_msi_domain_check_cap() static
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Juergen Gross <jgross@suse.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211206210224.980989243@linutronix.de>
References: <20211206210224.980989243@linutronix.de>
MIME-Version: 1.0
Message-ID: <163906601852.11128.4818897968892458783.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     57ce3a3c99b21e9c4f951ef01e0a3603c987c259
Gitweb:        https://git.kernel.org/tip/57ce3a3c99b21e9c4f951ef01e0a3603c987c259
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 06 Dec 2021 23:27:57 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 09 Dec 2021 11:52:22 +01:00

PCI/MSI: Make pci_msi_domain_check_cap() static

No users outside of that file.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Juergen Gross <jgross@suse.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Link: https://lore.kernel.org/r/20211206210224.980989243@linutronix.de

---
 drivers/pci/msi/irqdomain.c | 5 +++--
 include/linux/msi.h         | 2 --
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/msi/irqdomain.c b/drivers/pci/msi/irqdomain.c
index 123450e..6abd8af 100644
--- a/drivers/pci/msi/irqdomain.c
+++ b/drivers/pci/msi/irqdomain.c
@@ -79,8 +79,9 @@ static inline bool pci_msi_desc_is_multi_msi(struct msi_desc *desc)
  *  1 if Multi MSI is requested, but the domain does not support it
  *  -ENOTSUPP otherwise
  */
-int pci_msi_domain_check_cap(struct irq_domain *domain,
-			     struct msi_domain_info *info, struct device *dev)
+static int pci_msi_domain_check_cap(struct irq_domain *domain,
+				    struct msi_domain_info *info,
+				    struct device *dev)
 {
 	struct msi_desc *desc = first_pci_msi_entry(to_pci_dev(dev));
 
diff --git a/include/linux/msi.h b/include/linux/msi.h
index 7ff7cf2..5248678 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -439,8 +439,6 @@ void *platform_msi_get_host_data(struct irq_domain *domain);
 struct irq_domain *pci_msi_create_irq_domain(struct fwnode_handle *fwnode,
 					     struct msi_domain_info *info,
 					     struct irq_domain *parent);
-int pci_msi_domain_check_cap(struct irq_domain *domain,
-			     struct msi_domain_info *info, struct device *dev);
 u32 pci_msi_domain_get_msi_rid(struct irq_domain *domain, struct pci_dev *pdev);
 struct irq_domain *pci_msi_get_device_domain(struct pci_dev *pdev);
 bool pci_dev_has_special_msi_domain(struct pci_dev *pdev);
