Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 708CD509E2E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 13:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388652AbiDULEl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 07:04:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242691AbiDULEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 07:04:37 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A35381582C;
        Thu, 21 Apr 2022 04:01:47 -0700 (PDT)
Date:   Thu, 21 Apr 2022 11:01:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1650538905;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IrLuh2cd/luQrDrFKDrpRNYBe3E4QlYKgrOQIligRZg=;
        b=q5DTMZhaGDArMaK9tXYYuI28yjLAY8v2xZVyTK00DX98vdyjcKDBV/xZ5fCzwzq2i2fGwK
        /MXZ63LZ1Nk7vbFVNUef5cJCiuMA1caZOofxfR1o4f/+rOAG56GdArAv4MQLGMBIGpgAgv
        cY424j2gx9EdZOREHYzy2W3OUCFfJvLo1G+hCkjQLtig6uc7tS5T+ML3mcVzfi1W2d2fkP
        d6yl3P7hjovYuYMCMn/5OD/vH36bskH3aTNtDoGMAHcaQ8YTMgt2pyGEaVp2oOyTetAtfn
        /i35xx22xevr5b7zTKcKlt8EFRdhl0d9YrG9SzLdjcr2aDsFUFgfzkIIlyd7PQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1650538905;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IrLuh2cd/luQrDrFKDrpRNYBe3E4QlYKgrOQIligRZg=;
        b=2F5jp9XL2B9c2HFQK48YwimnO4IER6sBSg+47S6agiLek753jPxthD6gJaADG7yppRCGRB
        unxcxhto7DK+I7Cg==
From:   "tip-bot2 for Tom Lendacky" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sev] virt: sevguest: Change driver name to reflect generic
 SEV support
Cc:     Tom Lendacky <thomas.lendacky@amd.com>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C307710bb5515c9088a19fd0b930268c7300479b2=2E16504?=
 =?utf-8?q?64054=2Egit=2Ethomas=2Elendacky=40amd=2Ecom=3E?=
References: =?utf-8?q?=3C307710bb5515c9088a19fd0b930268c7300479b2=2E165046?=
 =?utf-8?q?4054=2Egit=2Ethomas=2Elendacky=40amd=2Ecom=3E?=
MIME-Version: 1.0
Message-ID: <165053890396.4207.14334829085990369807.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     2bf93ffbb97e0614cfc431d2ea33b7eae7481eb2
Gitweb:        https://git.kernel.org/tip/2bf93ffbb97e0614cfc431d2ea33b7eae7481eb2
Author:        Tom Lendacky <thomas.lendacky@amd.com>
AuthorDate:    Wed, 20 Apr 2022 09:14:13 -05:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 21 Apr 2022 11:48:24 +02:00

virt: sevguest: Change driver name to reflect generic SEV support

During patch review, it was decided the SNP guest driver name should not
be SEV-SNP specific, but should be generic for use with anything SEV.
However, this feedback was missed and the driver name, and many of the
driver functions and structures, are SEV-SNP name specific. Rename the
driver to "sev-guest" (to match the misc device that is created) and
update some of the function and structure names, too.

While in the file, adjust the one pr_err() message to be a dev_err()
message so that the message, if issued, uses the driver name.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/307710bb5515c9088a19fd0b930268c7300479b2.1650464054.git.thomas.lendacky@amd.com
---
 arch/x86/include/asm/sev.h            |  2 +-
 arch/x86/kernel/sev.c                 | 10 +++----
 drivers/virt/coco/sevguest/sevguest.c | 39 ++++++++++++++------------
 3 files changed, 27 insertions(+), 24 deletions(-)

diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index 9c2d33f..6e3dda4 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -95,7 +95,7 @@ struct snp_req_data {
 	unsigned int data_npages;
 };
 
-struct snp_guest_platform_data {
+struct sev_guest_platform_data {
 	u64 secrets_gpa;
 };
 
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index f01f455..2fa87a0 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -2166,8 +2166,8 @@ e_restore_irq:
 }
 EXPORT_SYMBOL_GPL(snp_issue_guest_request);
 
-static struct platform_device guest_req_device = {
-	.name		= "snp-guest",
+static struct platform_device sev_guest_device = {
+	.name		= "sev-guest",
 	.id		= -1,
 };
 
@@ -2197,7 +2197,7 @@ static u64 get_secrets_page(void)
 
 static int __init snp_init_platform_device(void)
 {
-	struct snp_guest_platform_data data;
+	struct sev_guest_platform_data data;
 	u64 gpa;
 
 	if (!cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
@@ -2208,10 +2208,10 @@ static int __init snp_init_platform_device(void)
 		return -ENODEV;
 
 	data.secrets_gpa = gpa;
-	if (platform_device_add_data(&guest_req_device, &data, sizeof(data)))
+	if (platform_device_add_data(&sev_guest_device, &data, sizeof(data)))
 		return -ENODEV;
 
-	if (platform_device_register(&guest_req_device))
+	if (platform_device_register(&sev_guest_device))
 		return -ENODEV;
 
 	pr_info("SNP guest platform device initialized.\n");
diff --git a/drivers/virt/coco/sevguest/sevguest.c b/drivers/virt/coco/sevguest/sevguest.c
index 15f069e..18c3231 100644
--- a/drivers/virt/coco/sevguest/sevguest.c
+++ b/drivers/virt/coco/sevguest/sevguest.c
@@ -1,14 +1,12 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * AMD Secure Encrypted Virtualization Nested Paging (SEV-SNP) guest request interface
+ * AMD Secure Encrypted Virtualization (SEV) guest driver interface
  *
  * Copyright (C) 2021 Advanced Micro Devices, Inc.
  *
  * Author: Brijesh Singh <brijesh.singh@amd.com>
  */
 
-#define pr_fmt(fmt) "SNP: GUEST: " fmt
-
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/types.h>
@@ -574,7 +572,7 @@ static void free_shared_pages(void *buf, size_t sz)
 	__free_pages(virt_to_page(buf), get_order(sz));
 }
 
-static void *alloc_shared_pages(size_t sz)
+static void *alloc_shared_pages(struct device *dev, size_t sz)
 {
 	unsigned int npages = PAGE_ALIGN(sz) >> PAGE_SHIFT;
 	struct page *page;
@@ -586,7 +584,7 @@ static void *alloc_shared_pages(size_t sz)
 
 	ret = set_memory_decrypted((unsigned long)page_address(page), npages);
 	if (ret) {
-		pr_err("failed to mark page shared, ret=%d\n", ret);
+		dev_err(dev, "failed to mark page shared, ret=%d\n", ret);
 		__free_pages(page, get_order(sz));
 		return NULL;
 	}
@@ -627,10 +625,10 @@ static u8 *get_vmpck(int id, struct snp_secrets_page_layout *layout, u32 **seqno
 	return key;
 }
 
-static int __init snp_guest_probe(struct platform_device *pdev)
+static int __init sev_guest_probe(struct platform_device *pdev)
 {
 	struct snp_secrets_page_layout *layout;
-	struct snp_guest_platform_data *data;
+	struct sev_guest_platform_data *data;
 	struct device *dev = &pdev->dev;
 	struct snp_guest_dev *snp_dev;
 	struct miscdevice *misc;
@@ -639,7 +637,7 @@ static int __init snp_guest_probe(struct platform_device *pdev)
 	if (!dev->platform_data)
 		return -ENODEV;
 
-	data = (struct snp_guest_platform_data *)dev->platform_data;
+	data = (struct sev_guest_platform_data *)dev->platform_data;
 	layout = (__force void *)ioremap_encrypted(data->secrets_gpa, PAGE_SIZE);
 	if (!layout)
 		return -ENODEV;
@@ -667,15 +665,15 @@ static int __init snp_guest_probe(struct platform_device *pdev)
 	snp_dev->layout = layout;
 
 	/* Allocate the shared page used for the request and response message. */
-	snp_dev->request = alloc_shared_pages(sizeof(struct snp_guest_msg));
+	snp_dev->request = alloc_shared_pages(dev, sizeof(struct snp_guest_msg));
 	if (!snp_dev->request)
 		goto e_unmap;
 
-	snp_dev->response = alloc_shared_pages(sizeof(struct snp_guest_msg));
+	snp_dev->response = alloc_shared_pages(dev, sizeof(struct snp_guest_msg));
 	if (!snp_dev->response)
 		goto e_free_request;
 
-	snp_dev->certs_data = alloc_shared_pages(SEV_FW_BLOB_MAX_SIZE);
+	snp_dev->certs_data = alloc_shared_pages(dev, SEV_FW_BLOB_MAX_SIZE);
 	if (!snp_dev->certs_data)
 		goto e_free_response;
 
@@ -698,7 +696,7 @@ static int __init snp_guest_probe(struct platform_device *pdev)
 	if (ret)
 		goto e_free_cert_data;
 
-	dev_info(dev, "Initialized SNP guest driver (using vmpck_id %d)\n", vmpck_id);
+	dev_info(dev, "Initialized SEV guest driver (using vmpck_id %d)\n", vmpck_id);
 	return 0;
 
 e_free_cert_data:
@@ -712,7 +710,7 @@ e_unmap:
 	return ret;
 }
 
-static int __exit snp_guest_remove(struct platform_device *pdev)
+static int __exit sev_guest_remove(struct platform_device *pdev)
 {
 	struct snp_guest_dev *snp_dev = platform_get_drvdata(pdev);
 
@@ -725,16 +723,21 @@ static int __exit snp_guest_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static struct platform_driver snp_guest_driver = {
-	.remove		= __exit_p(snp_guest_remove),
+/*
+ * This driver is a common SEV guest interface driver and meant to support
+ * any SEV guest API. As such, even though it has been introduced along with
+ * the SEV-SNP support, it is named "sev-guest".
+ */
+static struct platform_driver sev_guest_driver = {
+	.remove		= __exit_p(sev_guest_remove),
 	.driver		= {
-		.name = "snp-guest",
+		.name = "sev-guest",
 	},
 };
 
-module_platform_driver_probe(snp_guest_driver, snp_guest_probe);
+module_platform_driver_probe(sev_guest_driver, sev_guest_probe);
 
 MODULE_AUTHOR("Brijesh Singh <brijesh.singh@amd.com>");
 MODULE_LICENSE("GPL");
 MODULE_VERSION("1.0.0");
-MODULE_DESCRIPTION("AMD SNP Guest Driver");
+MODULE_DESCRIPTION("AMD SEV Guest Driver");
