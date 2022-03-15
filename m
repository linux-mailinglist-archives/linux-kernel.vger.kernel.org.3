Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90CFD4D9291
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 03:27:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344405AbiCOC24 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 22:28:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236325AbiCOC2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 22:28:54 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D25B3A1B1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 19:27:43 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id g8so10933510qke.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 19:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=northvilleschools.net; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=PuIMjui1Ge4EhyWDZpr9OGS4dz+9ZtjP0SsU+pEdP2g=;
        b=VjJPcNPhiccH4ZpCpc7PtlucjeS4mTJpt18MJMmQnKeA/OPiovxPM5aoxlvJ8UJzxl
         h9RFhSBjBTzcQu7XnVER0sFiF75DIgyTh5/Xdq2O4HnY0jVa8c1H6db6z25KDCNIj/h5
         9ZDJunhwi/vD/So39vqrsE359J8jUsMjFrUrBW5CrdHPB2ObQ0tcn2G5gdgm8ZonC9g4
         WCxpxzLJDs03WD5MPITF9a06YG2HZIIfa9Au1yPlL27l49TLCnzmBEU4ix6lBuSzG8U+
         tsyGDR+1zt6C2WM6yeMonqSDCWSZeduM7FBLvyZedB/693oHamr3ho89Hw4B18gNYm+w
         +DRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=PuIMjui1Ge4EhyWDZpr9OGS4dz+9ZtjP0SsU+pEdP2g=;
        b=6oO6lPQpjz6PSRS/VYgpJe/jLOnUzI/wTSvAdvH29KYYbqRy6JbZSh8zKYWvZCFQRd
         G/OGG+kSS4UBxGO8G9a4clxylWMpHIljnrUGJweTOAONU33leNN4ufmdWIZG3N2cLqF/
         kWMcBeLOsWzeNwQLph/8wHPUxoCeiCIdYw+J2OLDOii6NM/iebeKYTfiVXBNhu0OY/6g
         qVmGvAP/z9payhRBF/k9vrN8wqWRNYg87oK4fxu8RQxrByo3tudQ5L/lxPV/vXD3ijbw
         XXvB1442Gdjdi/POKH5wX8v3+jqzbpyKiPrgEHQDrYu5MBxz016w32VPW3VS38R1sYbc
         GPng==
X-Gm-Message-State: AOAM531amGuMJhkz33Fh8uBkKWYopZ78E4E8b8WW5lnC5iK7ka0dMWx6
        ZBcFw60fuZzS8KX7dszBD9JsKFNrD3AuyZ3HEAg=
X-Google-Smtp-Source: ABdhPJxPy8lQkCERhKpA7+QhUzhl7HtMqbu8E8la6bO1tyWBGiKtvivXkMnA6YZXbpiT6S9/J5FKww==
X-Received: by 2002:a05:620a:f14:b0:67d:1b1c:cf34 with SMTP id v20-20020a05620a0f1400b0067d1b1ccf34mr16788449qkl.479.1647311262143;
        Mon, 14 Mar 2022 19:27:42 -0700 (PDT)
Received: from sckzor-linux (d4-50-247-168.col.wideopenwest.com. [50.4.168.247])
        by smtp.gmail.com with ESMTPSA id p13-20020a05622a048d00b002e1ce0c627csm4222518qtx.58.2022.03.14.19.27.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Mar 2022 19:27:41 -0700 (PDT)
Date:   Mon, 14 Mar 2022 22:27:40 -0400
From:   Charlie Sands <sandsch@northvilleschools.net>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rts5208: Resolve checkpath.pl issues.
Message-ID: <Yi/5nEXVmzZrbfbz@sckzor-linux.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch remedies the following checkpath.pl issues:

WARNING: Unnecessary ftrace-like logging - prefer using ftrace
+ dev_info(&dev->pci->dev, "%s called\n", __func__);

WARNING: Unnecessary ftrace-like logging - prefer using ftrace
+ dev_info(&dev->pci->dev, "%s called\n", __func__);

WARNING: Unnecessary ftrace-like logging - prefer using ftrace
+ dev_info(&pci->dev, "%s called\n", __func__);

Signed-off-by: Charlie Sands <sandsch@northvilleschools.net>
---
 drivers/staging/rts5208/rtsx.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/staging/rts5208/rtsx.c b/drivers/staging/rts5208/rtsx.c
index 5a58dac76c88..643d33b9a239 100644
--- a/drivers/staging/rts5208/rtsx.c
+++ b/drivers/staging/rts5208/rtsx.c
@@ -159,8 +159,6 @@ static int command_abort(struct scsi_cmnd *srb)
 	struct rtsx_dev *dev = host_to_rtsx(host);
 	struct rtsx_chip *chip = dev->chip;
 
-	dev_info(&dev->pci->dev, "%s called\n", __func__);
-
 	scsi_lock(host);
 
 	/* Is this command still active? */
@@ -188,8 +186,6 @@ static int device_reset(struct scsi_cmnd *srb)
 {
 	struct rtsx_dev *dev = host_to_rtsx(srb->device->host);
 
-	dev_info(&dev->pci->dev, "%s called\n", __func__);
-
 	return SUCCESS;
 }
 
@@ -968,8 +964,6 @@ static void rtsx_remove(struct pci_dev *pci)
 {
 	struct rtsx_dev *dev = pci_get_drvdata(pci);
 
-	dev_info(&pci->dev, "%s called\n", __func__);
-
 	quiesce_and_remove_host(dev);
 	release_everything(dev);
 	pci_release_regions(pci);
-- 
2.35.1

