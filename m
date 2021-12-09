Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A184B46ECB0
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 17:07:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241012AbhLIQK5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 11:10:57 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:40094 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240831AbhLIQKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 11:10:40 -0500
Date:   Thu, 09 Dec 2021 16:07:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639066025;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iWvxX7TdK56u7tL9I/yYMlaUUDCtn/cWEXSuc2tGEYk=;
        b=GtZqi1/TS6PIXuO8/D+01bcQkLDK03JtrBm6Vint6ZFioV/wdFvB8sGc5Yazbljc7wkzZJ
        j/9jTfUDQTEdekHYhUktrKN2YsWqCsNPc/BcmrpBTSnGhkg72XKuSWhun8W/HrCQPxcJF2
        UDQH+uHBQLEGMvaKvhxZGumqcGTiz02HmCVBM28cuqt4JXaz2Q8ceP7digJb+xo81muTSp
        NI4Yu4RIntQSTquAPtU2Yrr2EUoF8hM6dO3dsKW5GiVrxoIGiEvlzf/Pv6ESBH3fQg1vVm
        xF2IihHLoFtX9GfLbajOgt97ms/vhIhVL06Ym8s4ZYS+kcwC+X1dirfXALNfPQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639066025;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iWvxX7TdK56u7tL9I/yYMlaUUDCtn/cWEXSuc2tGEYk=;
        b=wQVdlqYFmz29lPxxr6nhB593Xni6Lc2UXUXAYDsp8x+9jDb87yGgl1ACmt1IdG+iRVuqP8
        3ZgxPDkNToCiHlCw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/msi] PCI/MSI: Cleanup include zoo
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Juergen Gross <jgross@suse.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Bjorn Helgaas <bhelgaas@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211206210224.539281124@linutronix.de>
References: <20211206210224.539281124@linutronix.de>
MIME-Version: 1.0
Message-ID: <163906602485.11128.13473051346006830522.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     29a03ada4a007067d5427a6a1b7ba1dc7566ea2e
Gitweb:        https://git.kernel.org/tip/29a03ada4a007067d5427a6a1b7ba1dc7566ea2e
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 06 Dec 2021 23:27:44 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 09 Dec 2021 11:52:21 +01:00

PCI/MSI: Cleanup include zoo

Get rid of the pile of unneeded includes which accumulated over time.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Juergen Gross <jgross@suse.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Link: https://lore.kernel.org/r/20211206210224.539281124@linutronix.de

---
 drivers/pci/msi.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 8260b06..a76fcf4 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -7,22 +7,14 @@
  * Copyright (C) 2016 Christoph Hellwig.
  */
 
+#include <linux/acpi_iort.h>
 #include <linux/err.h>
-#include <linux/mm.h>
-#include <linux/irq.h>
-#include <linux/interrupt.h>
 #include <linux/export.h>
-#include <linux/ioport.h>
-#include <linux/pci.h>
-#include <linux/proc_fs.h>
-#include <linux/msi.h>
-#include <linux/smp.h>
-#include <linux/errno.h>
-#include <linux/io.h>
-#include <linux/acpi_iort.h>
-#include <linux/slab.h>
+#include <linux/irq.h>
 #include <linux/irqdomain.h>
+#include <linux/msi.h>
 #include <linux/of_irq.h>
+#include <linux/pci.h>
 
 #include "pci.h"
 
