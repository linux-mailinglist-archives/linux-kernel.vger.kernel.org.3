Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08E3A5858A9
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jul 2022 06:58:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230394AbiG3E5l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jul 2022 00:57:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbiG3E5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jul 2022 00:57:38 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 958A02F67C
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 21:57:37 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id y15so6194439plp.10
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 21:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Cx1gZ2ooQTYsth+yQ703eP4+ThWjOqWP1XjCxbfhTSE=;
        b=YmMxovA4tQuEsG0Ybkh69WzIZTusm+EvLbAPKcAJjxyRInBc60Zi5Z0J/Apots4yWQ
         tNqBmD+tb0ptWZsmYuo76BpzVCo36EvfLbMWHLZgfwztbZdDq2hYKQ6Ff2RqpNc+ORPf
         hQuywQ3a96db/OuOs9Eg8rP6L8YtayrtTAH7Xqyb54YMpQUWyy04WGFXtbb7p/XfICdE
         I9pu3J6qollZ1dke4zNSI7BbBF26/IysWCI0UrpqZ3IaoPr99+/GOsNG35OaP5ZSWhGP
         uex92j53Al4tL8hV/eORfzx978jKSycL4C/6atKEcXNbo0Iw+RrL0o2wTF8dhcCRqse8
         8H1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Cx1gZ2ooQTYsth+yQ703eP4+ThWjOqWP1XjCxbfhTSE=;
        b=NM825CdULanbrgsMCvy3bZ/DcuIo9bobkhkgrp07q/3IVhG4J8BiOvKdRVvlbIhUDs
         crNrRBTFiy0zbur+jIuHZbvJAMB5+sp3fIFC9I+fkF4QK5lrKiPRrSRJmB3y+mY8GnIZ
         odkeNq0IshBgg71s9nmH50kTtMuhBULKfeleRNC3FdRJOlklDLjg3s2gyZt0tVYUMvIn
         CgzgfH83GLJz7oKIhEk5wLXsTKZyLmGv/5zUJpWPqgO/AWLWiiQ8C3BbF7DZZ5M+9JS1
         /vfkIbIxCr18/UGQGmNbUwgfs3GswSP/rXlg+Nj3URebT5F9L8iXa2sayJuqXr8xwB3v
         noHw==
X-Gm-Message-State: ACgBeo2wQ1SNuQIxZ9EEXCH31w7ZfgfdSnzWtanwPoulPGRD4gxdDUAx
        LxubXkkSeNLBgtfp4zsTzQ==
X-Google-Smtp-Source: AA6agR60d2YidCK8RqqNtfEkQ5jXhJyoAFFKp0y7+M8ecaaqH+HMi5+hHZroDAO22NN/UcKymciP7Q==
X-Received: by 2002:a17:90a:fe07:b0:1f4:203d:d192 with SMTP id ck7-20020a17090afe0700b001f4203dd192mr4109178pjb.145.1659157057127;
        Fri, 29 Jul 2022 21:57:37 -0700 (PDT)
Received: from localhost.localdomain ([120.239.75.76])
        by smtp.gmail.com with ESMTPSA id j19-20020a634a53000000b0041983a8d8c2sm3526688pgl.39.2022.07.29.21.57.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jul 2022 21:57:36 -0700 (PDT)
From:   Mingyi Kang <jerrykang026@gmail.com>
To:     gregkh@linuxfoundation.org, martyn@welchs.me.uk,
        manohar.vanga@gmail.com, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Cc:     Mingyi Kang <jerrykang026@gmail.com>
Subject: [PATCH] staging: vme_user: Fix checkpatch warnings in vme_tsi148.c
Date:   Sat, 30 Jul 2022 12:57:26 +0800
Message-Id: <20220730045726.55452-1-jerrykang026@gmail.com>
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

This patch fix the follwing checkpatch warnings:

	WARNING: quoted string split across lines
	#129: FILE: drivers/staging/vme_user/vme_tsi148.c:129:
	+			dev_err(tsi148_bridge->parent, "VME Mailbox %d received"
	+				": 0x%x\n", i, val);

	WARNING: quoted string split across lines
	#147: FILE: drivers/staging/vme_user/vme_tsi148.c:147:
	+	dev_err(tsi148_bridge->parent, "PCI Exception at address: 0x%08x:%08x, "
	+		"attributes: %08x\n",

	WARNING: quoted string split across lines
	#153: FILE: drivers/staging/vme_user/vme_tsi148.c:153:
	+	dev_err(tsi148_bridge->parent, "PCI-X attribute reg: %08x, PCI-X split "
	+		"completion reg: %08x\n",

	WARNING: quoted string split across lines
	#185: FILE: drivers/staging/vme_user/vme_tsi148.c:185:
	+		dev_err(tsi148_bridge->parent, "VME Bus Exception Overflow "
	+			"Occurred\n");

	WARNING: quoted string split across lines
	#321: FILE: drivers/staging/vme_user/vme_tsi148.c:321:
	+		dev_err(tsi148_bridge->parent, "Can't get assigned pci irq "
	+			"vector %02X\n", pdev->irq);

	WARNING: quoted string split across lines
	#533: FILE: drivers/staging/vme_user/vme_tsi148.c:533:
	+		dev_err(tsi148_bridge->parent, "Invalid PCI Offset "
	+			"alignment\n");

	WARNING: space prohibited before semicolon
	#591: FILE: drivers/staging/vme_user/vme_tsi148.c:591:
	+		temp_ctl |= TSI148_LCSR_ITAT_SUPR ;

	WARNING: quoted string split across lines
	#766: FILE: drivers/staging/vme_user/vme_tsi148.c:766:
	+		dev_err(tsi148_bridge->parent, "Failed to allocate mem "
	+			"resource for window %d size 0x%lx start 0x%lx\n",

	WARNING: quoted string split across lines
	#831: FILE: drivers/staging/vme_user/vme_tsi148.c:831:
	+		dev_err(tsi148_bridge->parent, "Invalid VME Window "
	+			"alignment\n");
	WARNING: quoted string split across lines
	#838: FILE: drivers/staging/vme_user/vme_tsi148.c:838:
	+		dev_err(tsi148_bridge->parent, "Size must be non-zero for "
	+			"enabled windows\n");

	WARNING: quoted string split across lines
	#853: FILE: drivers/staging/vme_user/vme_tsi148.c:853:
	+		dev_err(tsi148_bridge->parent, "Unable to allocate memory for "
	+			"resource\n");

	WARNING: quoted string split across lines
	#894: FILE: drivers/staging/vme_user/vme_tsi148.c:894:
	+		dev_err(tsi148_bridge->parent, "Invalid VME Offset "
	+			"alignment\n");

	WARNING: quoted string split across lines
	#941: FILE: drivers/staging/vme_user/vme_tsi148.c:941:
	+		dev_warn(tsi148_bridge->parent, "Currently not setting "
	+			"Broadcast Select Registers\n");

	WARNING: quoted string split across lines
	#1455: FILE: drivers/staging/vme_user/vme_tsi148.c:1455:
	+		dev_err(dev, "Currently not setting Broadcast Select "
	+			"Registers\n");

	WARNING: quoted string split across lines
	#1554: FILE: drivers/staging/vme_user/vme_tsi148.c:1554:
	+		dev_err(dev, "Currently not setting Broadcast Select "
	+			"Registers\n");

	WARNING: quoted string split across lines
	#1643: FILE: drivers/staging/vme_user/vme_tsi148.c:1643:
	+		dev_err(tsi148_bridge->parent, "Descriptor not aligned to 8 "
	+			"byte boundary as required: %p\n",

	WARNING: else is not generally useful after a break or return
	#1830: FILE: drivers/staging/vme_user/vme_tsi148.c:1830:
	+		return -EBUSY;
	+	} else {

	warning: quoted string split across lines
	#1939: file: drivers/staging/vme_user/vme_tsi148.c:1939:
	+			dev_err(tsi148_bridge->parent, "location monitor "
	+				"callback attached, can't reset\n");

	WARNING: space prohibited before semicolon
	#1964: FILE: drivers/staging/vme_user/vme_tsi148.c:1964:
	+		lm_ctl |= TSI148_LCSR_LMAT_SUPR ;

	WARNING: quoted string split across lines
	#2055: FILE: drivers/staging/vme_user/vme_tsi148.c:2055:
	+		dev_err(tsi148_bridge->parent, "Location monitor not properly "
	+			"configured\n");

	WARNING: quoted string split across lines
	#2200: FILE: drivers/staging/vme_user/vme_tsi148.c:2200:
	+		dev_err(tsi148_bridge->parent, "Failed to allocate memory for "
	+			"CR/CSR image\n");

	WARNING: quoted string split across lines
	#2241: FILE: drivers/staging/vme_user/vme_tsi148.c:2241:
	+			dev_err(tsi148_bridge->parent, "Configuring flush image"
	+				" failed\n");

Signed-off-by: Mingyi Kang <jerrykang026@gmail.com>
---
 drivers/staging/vme_user/vme_tsi148.c | 70 ++++++++++-----------------
 1 file changed, 26 insertions(+), 44 deletions(-)

diff --git a/drivers/staging/vme_user/vme_tsi148.c b/drivers/staging/vme_user/vme_tsi148.c
index 956476213241..020e0b3bce64 100644
--- a/drivers/staging/vme_user/vme_tsi148.c
+++ b/drivers/staging/vme_user/vme_tsi148.c
@@ -125,8 +125,8 @@ static u32 tsi148_MB_irqhandler(struct vme_bridge *tsi148_bridge, u32 stat)
 	for (i = 0; i < 4; i++) {
 		if (stat & TSI148_LCSR_INTS_MBS[i]) {
 			val = ioread32be(bridge->base +	TSI148_GCSR_MBOX[i]);
-			dev_err(tsi148_bridge->parent, "VME Mailbox %d received"
-				": 0x%x\n", i, val);
+			dev_err(tsi148_bridge->parent, "VME Mailbox %d received: 0x%x\n",
+				i, val);
 			serviced |= TSI148_LCSR_INTC_MBC[i];
 		}
 	}
@@ -143,14 +143,12 @@ static u32 tsi148_PERR_irqhandler(struct vme_bridge *tsi148_bridge)
 
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
 
@@ -180,10 +178,8 @@ static u32 tsi148_VERR_irqhandler(struct vme_bridge *tsi148_bridge)
 	reg_join(error_addr_high, error_addr_low, &error_addr);
 
 	/* Check for exception register overflow (we have lost error data) */
-	if (error_attrib & TSI148_LCSR_VEAT_VEOF) {
-		dev_err(tsi148_bridge->parent, "VME Bus Exception Overflow "
-			"Occurred\n");
-	}
+	if (error_attrib & TSI148_LCSR_VEAT_VEOF)
+		dev_err(tsi148_bridge->parent, "VME Bus Exception Overflow Occurred\n");
 
 	if (err_chk)
 		vme_bus_error_handler(tsi148_bridge, error_addr, error_am);
@@ -317,8 +313,8 @@ static int tsi148_irq_init(struct vme_bridge *tsi148_bridge)
 			     IRQF_SHARED,
 			     driver_name, tsi148_bridge);
 	if (result) {
-		dev_err(tsi148_bridge->parent, "Can't get assigned pci irq "
-			"vector %02X\n", pdev->irq);
+		dev_err(tsi148_bridge->parent, "Can't get assigned pci irq vector %02X\n",
+			pdev->irq);
 		return result;
 	}
 
@@ -529,8 +525,7 @@ static int tsi148_slave_set(struct vme_slave_resource *image, int enabled,
 		return -EINVAL;
 	}
 	if (pci_offset_low & (granularity - 1)) {
-		dev_err(tsi148_bridge->parent, "Invalid PCI Offset "
-			"alignment\n");
+		dev_err(tsi148_bridge->parent, "Invalid PCI Offset alignment\n");
 		return -EINVAL;
 	}
 
@@ -588,7 +583,7 @@ static int tsi148_slave_set(struct vme_slave_resource *image, int enabled,
 
 	temp_ctl &= ~0xF;
 	if (cycle & VME_SUPER)
-		temp_ctl |= TSI148_LCSR_ITAT_SUPR ;
+		temp_ctl |= TSI148_LCSR_ITAT_SUPR;
 	if (cycle & VME_USER)
 		temp_ctl |= TSI148_LCSR_ITAT_NPRIV;
 	if (cycle & VME_PROG)
@@ -762,8 +757,7 @@ static int tsi148_alloc_resource(struct vme_master_resource *image,
 		&image->bus_resource, size, 0x10000, PCIBIOS_MIN_MEM,
 		0, NULL, NULL);
 	if (retval) {
-		dev_err(tsi148_bridge->parent, "Failed to allocate mem "
-			"resource for window %d size 0x%lx start 0x%lx\n",
+		dev_err(tsi148_bridge->parent, "Failed to allocate mem resource for window %d size 0x%lx start 0x%lx\n",
 			image->number, (unsigned long)size,
 			(unsigned long)image->bus_resource.start);
 		goto err_resource;
@@ -827,15 +821,13 @@ static int tsi148_master_set(struct vme_master_resource *image, int enabled,
 
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
@@ -849,8 +841,7 @@ static int tsi148_master_set(struct vme_master_resource *image, int enabled,
 	retval = tsi148_alloc_resource(image, size);
 	if (retval) {
 		spin_unlock(&image->lock);
-		dev_err(tsi148_bridge->parent, "Unable to allocate memory for "
-			"resource\n");
+		dev_err(tsi148_bridge->parent, "Unable to allocate memory for resource\n");
 		goto err_res;
 	}
 
@@ -890,8 +881,7 @@ static int tsi148_master_set(struct vme_master_resource *image, int enabled,
 	}
 	if (vme_offset_low & 0xFFFF) {
 		spin_unlock(&image->lock);
-		dev_err(tsi148_bridge->parent, "Invalid VME Offset "
-			"alignment\n");
+		dev_err(tsi148_bridge->parent, "Invalid VME Offset alignment\n");
 		retval = -EINVAL;
 		goto err_gran;
 	}
@@ -937,8 +927,7 @@ static int tsi148_master_set(struct vme_master_resource *image, int enabled,
 		temp_ctl |= TSI148_LCSR_OTAT_TM_2eSST;
 	}
 	if (cycle & VME_2eSSTB) {
-		dev_warn(tsi148_bridge->parent, "Currently not setting "
-			"Broadcast Select Registers\n");
+		dev_warn(tsi148_bridge->parent, "Currently not setting Broadcast Select Registers\n");
 		temp_ctl &= ~TSI148_LCSR_OTAT_TM_M;
 		temp_ctl |= TSI148_LCSR_OTAT_TM_2eSSTB;
 	}
@@ -1451,8 +1440,7 @@ static int tsi148_dma_set_vme_src_attributes(struct device *dev, __be32 *attr,
 		val |= TSI148_LCSR_DSAT_TM_2eSST;
 
 	if (cycle & VME_2eSSTB) {
-		dev_err(dev, "Currently not setting Broadcast Select "
-			"Registers\n");
+		dev_err(dev, "Currently not setting Broadcast Select Registers\n");
 		val |= TSI148_LCSR_DSAT_TM_2eSSTB;
 	}
 
@@ -1550,8 +1538,7 @@ static int tsi148_dma_set_vme_dest_attributes(struct device *dev, __be32 *attr,
 		val |= TSI148_LCSR_DDAT_TM_2eSST;
 
 	if (cycle & VME_2eSSTB) {
-		dev_err(dev, "Currently not setting Broadcast Select "
-			"Registers\n");
+		dev_err(dev, "Currently not setting Broadcast Select Registers\n");
 		val |= TSI148_LCSR_DDAT_TM_2eSSTB;
 	}
 
@@ -1639,8 +1626,7 @@ static int tsi148_dma_list_add(struct vme_dma_list *list,
 
 	/* Test descriptor alignment */
 	if ((unsigned long)&entry->descriptor & 0x7) {
-		dev_err(tsi148_bridge->parent, "Descriptor not aligned to 8 "
-			"byte boundary as required: %p\n",
+		dev_err(tsi148_bridge->parent, "Descriptor not aligned to 8 byte boundary as required: %p\n",
 			&entry->descriptor);
 		retval = -EINVAL;
 		goto err_align;
@@ -1827,10 +1813,10 @@ static int tsi148_dma_list_exec(struct vme_dma_list *list)
 		/* Need to add to pending here */
 		mutex_unlock(&ctrlr->mtx);
 		return -EBUSY;
-	} else {
-		list_add(&list->list, &ctrlr->running);
 	}
 
+	list_add(&list->list, &ctrlr->running);
+
 	/* Get first bus address and write into registers */
 	entry = list_first_entry(&list->entries, struct tsi148_dma_entry,
 		list);
@@ -1935,8 +1921,7 @@ static int tsi148_lm_set(struct vme_lm_resource *lm, unsigned long long lm_base,
 	for (i = 0; i < lm->monitors; i++) {
 		if (bridge->lm_callback[i]) {
 			mutex_unlock(&lm->mtx);
-			dev_err(tsi148_bridge->parent, "Location monitor "
-				"callback attached, can't reset\n");
+			dev_err(tsi148_bridge->parent, "Location monitor callback attached, can't reset\n");
 			return -EBUSY;
 		}
 	}
@@ -1961,7 +1946,7 @@ static int tsi148_lm_set(struct vme_lm_resource *lm, unsigned long long lm_base,
 	}
 
 	if (cycle & VME_SUPER)
-		lm_ctl |= TSI148_LCSR_LMAT_SUPR ;
+		lm_ctl |= TSI148_LCSR_LMAT_SUPR;
 	if (cycle & VME_USER)
 		lm_ctl |= TSI148_LCSR_LMAT_NPRIV;
 	if (cycle & VME_PROG)
@@ -2051,8 +2036,7 @@ static int tsi148_lm_attach(struct vme_lm_resource *lm, int monitor,
 	lm_ctl = ioread32be(bridge->base + TSI148_LCSR_LMAT);
 	if ((lm_ctl & (TSI148_LCSR_LMAT_PGM | TSI148_LCSR_LMAT_DATA)) == 0) {
 		mutex_unlock(&lm->mtx);
-		dev_err(tsi148_bridge->parent, "Location monitor not properly "
-			"configured\n");
+		dev_err(tsi148_bridge->parent, "Location monitor not properly configured\n");
 		return -EINVAL;
 	}
 
@@ -2196,8 +2180,7 @@ static int tsi148_crcsr_init(struct vme_bridge *tsi148_bridge,
 						  VME_CRCSR_BUF_SIZE,
 						  &bridge->crcsr_bus, GFP_KERNEL);
 	if (!bridge->crcsr_kernel) {
-		dev_err(tsi148_bridge->parent, "Failed to allocate memory for "
-			"CR/CSR image\n");
+		dev_err(tsi148_bridge->parent, "Failed to allocate memory for CR/CSR image\n");
 		return -ENOMEM;
 	}
 
@@ -2237,8 +2220,7 @@ static int tsi148_crcsr_init(struct vme_bridge *tsi148_bridge,
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

