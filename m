Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D33D5584DA7
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 10:49:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235166AbiG2Is5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 04:48:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234622AbiG2Isw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 04:48:52 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18F0080F47
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 01:48:51 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id q16so3516293pgq.6
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 01:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wgsqotyBOfZqy1W9KnKshpP046wKgYKrPJ2KCRawRzE=;
        b=eGPLof6qAfDzxFOJCPcERm02FQ+hj43MXgSOA6Ib/cVIE6lu6+uuejwvmd+uTGGMaI
         NXP29LbjnKT6uafpFas6wGtB6lOj9E1GTWjcrsoQhNNNboO/uiZcxyundIAZuqvmuDr1
         lxHuk00U8pogYQYNq5AJUiwFuKah5ptzPaFLukmGtzBJQxTPQMyJUuhoBMnCDDUTYK1V
         28ncmf/J4Y24KtF0XNMFwq9JPU/7JKTtMUyaaITcXMCD/1X4DnJ4+BfqJSn7o+SN0e7x
         36GxhqbdLI9dLoSlUqIBlY0Gf9gIj4ZkEtzDMfVQ2VprMmKrI/zsNSoa39htsm9RyQl3
         XAbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wgsqotyBOfZqy1W9KnKshpP046wKgYKrPJ2KCRawRzE=;
        b=dn6burl6ggnTd6Dv7Smcq2SiYUT0mDCcp+do6LOaJzvHLuY7vCMmTB0wnjPf5v6BhZ
         XuLbzweKSlo8eVgTwU//FEd06RMSAhE+l8NQN9kkndlMjOruv+YV78M2sTjmls0I+v92
         iqgH2CT1qsAQriWBpwcrru4cSlGMzobFecnFS0F9dgFdEgmUwN+QE51+YfcfT6b5uvuG
         pjRW9tdKwPW3ZjcAZ2TsJQAZylkS3qNBz45oXunDjGS89QvEZYXGk/d2y2hzwumz3d0R
         wVu0unFgh272OOg3oFHkbz0u5zhTPzHad7mpG7kGf2wqHmzEka6XaPPWOcZX54j92iR5
         KgXg==
X-Gm-Message-State: AJIora/iN7Vph66km/XWQLmZBa/5k7gT6qq2EaV3DjZZ2iR5sw3GNx81
        j08zeyTd7y75/0a8VSXW4FpZ0Ywm4LEi
X-Google-Smtp-Source: AGRyM1tBddUjXNgNbie6OEGtgEB6z3OWa8S/Kr55dyHPzFPfG534mZPHiB4LDG2Y83J+mxIXAPujrw==
X-Received: by 2002:a63:d14b:0:b0:419:57b9:d444 with SMTP id c11-20020a63d14b000000b0041957b9d444mr2129847pgj.619.1659084530521;
        Fri, 29 Jul 2022 01:48:50 -0700 (PDT)
Received: from localhost.localdomain ([120.239.75.76])
        by smtp.gmail.com with ESMTPSA id w13-20020aa79a0d000000b0052b36de51cdsm2231977pfj.111.2022.07.29.01.48.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jul 2022 01:48:50 -0700 (PDT)
From:   Mingyi Kang <jerrykang026@gmail.com>
To:     gregkh@linuxfoundation.org, martyn@welchs.me.uk,
        manohar.vanga@gmail.com, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Cc:     Mingyi Kang <jerrykang026@gmail.com>
Subject: [PATCH] staging: vme_user: Put quoted string in a single line
Date:   Fri, 29 Jul 2022 16:48:06 +0800
Message-Id: <20220729084806.22479-1-jerrykang026@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch resolves the follwing checkpatch warnings:

WARNING: quoted string split across lines
+			dev_err(tsi148_bridge->parent, "VME Mailbox %d received"
+				": 0x%x\n", i, val);

WARNING: quoted string split across lines
+	dev_err(tsi148_bridge->parent, "PCI Exception at address: 0x%08x:%08x, "
+		"attributes: %08x\n",

WARNING: quoted string split across lines
+	dev_err(tsi148_bridge->parent, "PCI-X attribute reg: %08x, PCI-X split "
+		"completion reg: %08x\n",

WARNING: quoted string split across lines
+		dev_err(tsi148_bridge->parent, "VME Bus Exception Overflow "
+			"Occurred\n");

WARNING: quoted string split across lines
+		dev_err(tsi148_bridge->parent, "Can't get assigned pci irq "
+			"vector %02X\n", pdev->irq);

WARNING: quoted string split across lines
+		dev_err(tsi148_bridge->parent, "Failed to allocate mem "
+			"resource for window %d size 0x%lx start 0x%lx\n",

WARNING: quoted string split across lines
+		dev_err(tsi148_bridge->parent, "Invalid VME Window "
+			"alignment\n");
WARNING: quoted string split across lines
+		dev_err(tsi148_bridge->parent, "Size must be non-zero for "
+			"enabled windows\n");

WARNING: quoted string split across lines
+		dev_err(tsi148_bridge->parent, "Unable to allocate memory for "
+			"resource\n");

WARNING: quoted string split across lines
+		dev_err(tsi148_bridge->parent, "Invalid VME Offset "
+			"alignment\n");

WARNING: quoted string split across lines
+		dev_warn(tsi148_bridge->parent, "Currently not setting "
+			"Broadcast Select Registers\n");

WARNING: quoted string split across lines
+		dev_err(dev, "Currently not setting Broadcast Select "
+			"Registers\n");

WARNING: quoted string split across lines
+		dev_err(dev, "Currently not setting Broadcast Select "
+			"Registers\n");

WARNING: quoted string split across lines
+		dev_err(tsi148_bridge->parent, "Descriptor not aligned to 8 "
+			"byte boundary as required: %p\n",

warning: quoted string split across lines
+			dev_err(tsi148_bridge->parent, "location monitor "
+				"callback attached, can't reset\n");

WARNING: quoted string split across lines
+		dev_err(tsi148_bridge->parent, "Location monitor not properly "
+			"configured\n");

WARNING: quoted string split across lines
+		dev_err(tsi148_bridge->parent, "Failed to allocate memory for "
+			"CR/CSR image\n");

WARNING: quoted string split across lines
+			dev_err(tsi148_bridge->parent, "Configuring flush image"
+				" failed\n");

Signed-off-by: Mingyi Kang <jerrykang026@gmail.com>
---
 drivers/staging/vme_user/vme_tsi148.c | 57 +++++++++------------------
 1 file changed, 19 insertions(+), 38 deletions(-)

diff --git a/drivers/staging/vme_user/vme_tsi148.c b/drivers/staging/vme_user/vme_tsi148.c
index 956476213241..40bb432861c8 100644
--- a/drivers/staging/vme_user/vme_tsi148.c
+++ b/drivers/staging/vme_user/vme_tsi148.c
@@ -125,8 +125,7 @@ static u32 tsi148_MB_irqhandler(struct vme_bridge *tsi148_bridge, u32 stat)
 	for (i = 0; i < 4; i++) {
 		if (stat & TSI148_LCSR_INTS_MBS[i]) {
 			val = ioread32be(bridge->base +	TSI148_GCSR_MBOX[i]);
-			dev_err(tsi148_bridge->parent, "VME Mailbox %d received"
-				": 0x%x\n", i, val);
+			dev_err(tsi148_bridge->parent, "VME Mailbox %d received: 0x%x\n", i, val);
 			serviced |= TSI148_LCSR_INTC_MBC[i];
 		}
 	}
@@ -143,14 +142,12 @@ static u32 tsi148_PERR_irqhandler(struct vme_bridge *tsi148_bridge)
 
 	bridge = tsi148_bridge->driver_priv;
 
-	dev_err(tsi148_bridge->parent, "PCI Exception at address: 0x%08x:%08x, "
-		"attributes: %08x\n",
+	dev_err(tsi148_bridge->parent, "PCI Exception at address: 0x%08x:%08x, attributes: %08x\n",
 		ioread32be(bridge->base + TSI148_LCSR_EDPAU),
 		ioread32be(bridge->base + TSI148_LCSR_EDPAL),
 		ioread32be(bridge->base + TSI148_LCSR_EDPAT));
 
-	dev_err(tsi148_bridge->parent, "PCI-X attribute reg: %08x, PCI-X split "
-		"completion reg: %08x\n",
+	dev_err(tsi148_bridge->parent, "PCI-X attribute reg: %08x, PCI-X split completion reg: %08x\n",
 		ioread32be(bridge->base + TSI148_LCSR_EDPXA),
 		ioread32be(bridge->base + TSI148_LCSR_EDPXS));
 
@@ -181,8 +178,7 @@ static u32 tsi148_VERR_irqhandler(struct vme_bridge *tsi148_bridge)
 
 	/* Check for exception register overflow (we have lost error data) */
 	if (error_attrib & TSI148_LCSR_VEAT_VEOF) {
-		dev_err(tsi148_bridge->parent, "VME Bus Exception Overflow "
-			"Occurred\n");
+		dev_err(tsi148_bridge->parent, "VME Bus Exception Overflow Occurred\n");
 	}
 
 	if (err_chk)
@@ -317,8 +313,7 @@ static int tsi148_irq_init(struct vme_bridge *tsi148_bridge)
 			     IRQF_SHARED,
 			     driver_name, tsi148_bridge);
 	if (result) {
-		dev_err(tsi148_bridge->parent, "Can't get assigned pci irq "
-			"vector %02X\n", pdev->irq);
+		dev_err(tsi148_bridge->parent, "Can't get assigned pci irq vector %02X\n", pdev->irq);
 		return result;
 	}
 
@@ -529,8 +524,7 @@ static int tsi148_slave_set(struct vme_slave_resource *image, int enabled,
 		return -EINVAL;
 	}
 	if (pci_offset_low & (granularity - 1)) {
-		dev_err(tsi148_bridge->parent, "Invalid PCI Offset "
-			"alignment\n");
+		dev_err(tsi148_bridge->parent, "Invalid PCI Offset alignment\n");
 		return -EINVAL;
 	}
 
@@ -762,8 +756,7 @@ static int tsi148_alloc_resource(struct vme_master_resource *image,
 		&image->bus_resource, size, 0x10000, PCIBIOS_MIN_MEM,
 		0, NULL, NULL);
 	if (retval) {
-		dev_err(tsi148_bridge->parent, "Failed to allocate mem "
-			"resource for window %d size 0x%lx start 0x%lx\n",
+		dev_err(tsi148_bridge->parent, "Failed to allocate mem resource for window %d size 0x%lx start 0x%lx\n",
 			image->number, (unsigned long)size,
 			(unsigned long)image->bus_resource.start);
 		goto err_resource;
@@ -827,15 +820,13 @@ static int tsi148_master_set(struct vme_master_resource *image, int enabled,
 
 	/* Verify input data */
 	if (vme_base & 0xFFFF) {
-		dev_err(tsi148_bridge->parent, "Invalid VME Window "
-			"alignment\n");
+		dev_err(tsi148_bridge->parent, "Invalid VME Window alignment\n");
 		retval = -EINVAL;
 		goto err_window;
 	}
 
 	if ((size == 0) && (enabled != 0)) {
-		dev_err(tsi148_bridge->parent, "Size must be non-zero for "
-			"enabled windows\n");
+		dev_err(tsi148_bridge->parent, "Size must be non-zero for enabled windows\n");
 		retval = -EINVAL;
 		goto err_window;
 	}
@@ -849,8 +840,7 @@ static int tsi148_master_set(struct vme_master_resource *image, int enabled,
 	retval = tsi148_alloc_resource(image, size);
 	if (retval) {
 		spin_unlock(&image->lock);
-		dev_err(tsi148_bridge->parent, "Unable to allocate memory for "
-			"resource\n");
+		dev_err(tsi148_bridge->parent, "Unable to allocate memory for resource\n");
 		goto err_res;
 	}
 
@@ -890,8 +880,7 @@ static int tsi148_master_set(struct vme_master_resource *image, int enabled,
 	}
 	if (vme_offset_low & 0xFFFF) {
 		spin_unlock(&image->lock);
-		dev_err(tsi148_bridge->parent, "Invalid VME Offset "
-			"alignment\n");
+		dev_err(tsi148_bridge->parent, "Invalid VME Offset alignment\n");
 		retval = -EINVAL;
 		goto err_gran;
 	}
@@ -937,8 +926,7 @@ static int tsi148_master_set(struct vme_master_resource *image, int enabled,
 		temp_ctl |= TSI148_LCSR_OTAT_TM_2eSST;
 	}
 	if (cycle & VME_2eSSTB) {
-		dev_warn(tsi148_bridge->parent, "Currently not setting "
-			"Broadcast Select Registers\n");
+		dev_warn(tsi148_bridge->parent, "Currently not setting Broadcast Select Registers\n");
 		temp_ctl &= ~TSI148_LCSR_OTAT_TM_M;
 		temp_ctl |= TSI148_LCSR_OTAT_TM_2eSSTB;
 	}
@@ -1451,8 +1439,7 @@ static int tsi148_dma_set_vme_src_attributes(struct device *dev, __be32 *attr,
 		val |= TSI148_LCSR_DSAT_TM_2eSST;
 
 	if (cycle & VME_2eSSTB) {
-		dev_err(dev, "Currently not setting Broadcast Select "
-			"Registers\n");
+		dev_err(dev, "Currently not setting Broadcast Select Registers\n");
 		val |= TSI148_LCSR_DSAT_TM_2eSSTB;
 	}
 
@@ -1550,8 +1537,7 @@ static int tsi148_dma_set_vme_dest_attributes(struct device *dev, __be32 *attr,
 		val |= TSI148_LCSR_DDAT_TM_2eSST;
 
 	if (cycle & VME_2eSSTB) {
-		dev_err(dev, "Currently not setting Broadcast Select "
-			"Registers\n");
+		dev_err(dev, "Currently not setting Broadcast Select Registers\n");
 		val |= TSI148_LCSR_DDAT_TM_2eSSTB;
 	}
 
@@ -1639,8 +1625,7 @@ static int tsi148_dma_list_add(struct vme_dma_list *list,
 
 	/* Test descriptor alignment */
 	if ((unsigned long)&entry->descriptor & 0x7) {
-		dev_err(tsi148_bridge->parent, "Descriptor not aligned to 8 "
-			"byte boundary as required: %p\n",
+		dev_err(tsi148_bridge->parent, "Descriptor not aligned to 8 byte boundary as required: %p\n",
 			&entry->descriptor);
 		retval = -EINVAL;
 		goto err_align;
@@ -1935,8 +1920,7 @@ static int tsi148_lm_set(struct vme_lm_resource *lm, unsigned long long lm_base,
 	for (i = 0; i < lm->monitors; i++) {
 		if (bridge->lm_callback[i]) {
 			mutex_unlock(&lm->mtx);
-			dev_err(tsi148_bridge->parent, "Location monitor "
-				"callback attached, can't reset\n");
+			dev_err(tsi148_bridge->parent, "Location monitor callback attached, can't reset\n");
 			return -EBUSY;
 		}
 	}
@@ -2051,8 +2035,7 @@ static int tsi148_lm_attach(struct vme_lm_resource *lm, int monitor,
 	lm_ctl = ioread32be(bridge->base + TSI148_LCSR_LMAT);
 	if ((lm_ctl & (TSI148_LCSR_LMAT_PGM | TSI148_LCSR_LMAT_DATA)) == 0) {
 		mutex_unlock(&lm->mtx);
-		dev_err(tsi148_bridge->parent, "Location monitor not properly "
-			"configured\n");
+		dev_err(tsi148_bridge->parent, "Location monitor not properly configured\n");
 		return -EINVAL;
 	}
 
@@ -2196,8 +2179,7 @@ static int tsi148_crcsr_init(struct vme_bridge *tsi148_bridge,
 						  VME_CRCSR_BUF_SIZE,
 						  &bridge->crcsr_bus, GFP_KERNEL);
 	if (!bridge->crcsr_kernel) {
-		dev_err(tsi148_bridge->parent, "Failed to allocate memory for "
-			"CR/CSR image\n");
+		dev_err(tsi148_bridge->parent, "Failed to allocate memory for CR/CSR image\n");
 		return -ENOMEM;
 	}
 
@@ -2237,8 +2219,7 @@ static int tsi148_crcsr_init(struct vme_bridge *tsi148_bridge,
 			(vstat * 0x80000), 0x80000, VME_CRCSR, VME_SCT,
 			VME_D16);
 		if (retval)
-			dev_err(tsi148_bridge->parent, "Configuring flush image"
-				" failed\n");
+			dev_err(tsi148_bridge->parent, "Configuring flush image failed\n");
 	}
 
 	return 0;
-- 
2.25.1

