Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E93E49B210
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 11:46:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242376AbiAYKfm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 05:35:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358711AbiAYKd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 05:33:26 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6011CC06173B
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 02:33:24 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id v13so18945231wrv.10
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 02:33:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HxZB1rDCcbiFgoQa3s9Q8OYBgnWTilO8vzCCjCPAfkE=;
        b=Ma4erwKFcYNn647pr4jGLSuthd4MeBG1ha/VY1WHUsn/F8mEVm6xp2vmS8Mgqyp6Om
         CDgY0KmwFWWRjUCKOU5sJixylo/8MJ8wT+Yj/P467H0fsBI4mBCiqHwjFWergcLtbRyl
         SyDtWBbXYZqzFYsPP1i2AyZsDgXg1NA41Rax3lCVeZwLcQ8xLttumVHWUIXTdD0HwMuE
         aGBeHilhAhG4fLkVVqe0bcbKbUK61P8pMZIqDbjeGMg5ZDkIVmtQV+y4v4YLKo6RO5Fh
         DylefD7KaeFgJskuPtxTJ66AxHjLpeOGWo9916yPDYafmHygGN0k5JuaPjLtThGYa/sO
         tayQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HxZB1rDCcbiFgoQa3s9Q8OYBgnWTilO8vzCCjCPAfkE=;
        b=vVRroqH8bTm7dk5dcdVR7gVXoSeY08LX0mDvRr/9wPbn81jWBmFNl0mAQkr6CHscGQ
         bSN4jnG2wrVT1KKe8wnxQv1+gSocnn0AUaVHoAennWuKVfrVqsbJJ7xKyluxrrX9GOiP
         HEWQQSndslZeB4t6YBCOVTMFPZv8U/pipX6JaQZOUiLfYIK/IfjRDW8yewylVze84BCJ
         82Y98ATbVI1/DFt9nLdipEkxACTWjTMdl1f0DWT81yCkIR7exUbFwe1ymzvN1NrMkfZG
         KdSGKXfhvc4InmINEtwNYWWRqEt8bILoVB0qyYzkYfGGqk/1vDaUilAsbTP9rZHJaRWT
         aClw==
X-Gm-Message-State: AOAM530VvnZHqL6083YLoO0Qra7fWw0fQ425ZTTgm2SDHWpP1EF3EV3h
        XlQArFGXIrSRFQIF9X4Ahu/LJg7cPduRXQ==
X-Google-Smtp-Source: ABdhPJx98I0SdrdO2o5s84RptFRmsy5VqBgUu19WB+k6qUrLB8K5sUmjqihBh5EcPQ7C1pznNONGHw==
X-Received: by 2002:a05:6000:18a1:: with SMTP id b1mr9879642wri.608.1643106802724;
        Tue, 25 Jan 2022 02:33:22 -0800 (PST)
Received: from localhost (cable-89-216-134-246.dynamic.sbb.rs. [89.216.134.246])
        by smtp.gmail.com with ESMTPSA id r2sm24656946wrz.99.2022.01.25.02.33.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 02:33:22 -0800 (PST)
From:   =?UTF-8?q?Aleksa=20Vu=C4=8Dkovi=C4=87?= <aleksav013@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?Aleksa=20Vu=C4=8Dkovi=C4=87?= <aleksav013@gmail.com>
Subject: [PATCH 1/4] drivers: dio: fixed spaces to tabs coding style issue
Date:   Tue, 25 Jan 2022 11:33:07 +0100
Message-Id: <20220125103310.13893-1-aleksav013@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Converting spaces to tabs.

Signed-off-by: Aleksa Vučković <aleksav013@gmail.com>
---
 drivers/dio/dio.c | 120 +++++++++++++++++++++++-----------------------
 1 file changed, 60 insertions(+), 60 deletions(-)

diff --git a/drivers/dio/dio.c b/drivers/dio/dio.c
index 4c06c93c93d3..f1772975bf9d 100644
--- a/drivers/dio/dio.c
+++ b/drivers/dio/dio.c
@@ -59,8 +59,8 @@ struct dio_bus dio_bus = {
  */
 struct dioname
 {
-        int id;
-        const char *name;
+	int id;
+	const char *name;
 };
 
 /* useful macro */
@@ -69,21 +69,21 @@ struct dioname
 
 static struct dioname names[] = 
 {
-        DIONAME(DCA0), DIONAME(DCA0REM), DIONAME(DCA1), DIONAME(DCA1REM),
-        DIONAME(DCM), DIONAME(DCMREM),
-        DIONAME(LAN),
-        DIONAME(FHPIB), DIONAME(NHPIB),
-        DIONAME(SCSI0), DIONAME(SCSI1), DIONAME(SCSI2), DIONAME(SCSI3),
-        DIONAME(FBUFFER),
-        DIONAME(PARALLEL), DIONAME(VME), DIONAME(DCL), DIONAME(DCLREM),
-        DIONAME(MISC0), DIONAME(MISC1), DIONAME(MISC2), DIONAME(MISC3),
-        DIONAME(MISC4), DIONAME(MISC5), DIONAME(MISC6), DIONAME(MISC7),
-        DIONAME(MISC8), DIONAME(MISC9), DIONAME(MISC10), DIONAME(MISC11), 
-        DIONAME(MISC12), DIONAME(MISC13),
-        DIOFBNAME(GATORBOX), DIOFBNAME(TOPCAT), DIOFBNAME(RENAISSANCE),
-        DIOFBNAME(LRCATSEYE), DIOFBNAME(HRCCATSEYE), DIOFBNAME(HRMCATSEYE),
-        DIOFBNAME(DAVINCI), DIOFBNAME(XXXCATSEYE), DIOFBNAME(HYPERION),
-        DIOFBNAME(XGENESIS), DIOFBNAME(TIGER), DIOFBNAME(YGENESIS)   
+	DIONAME(DCA0), DIONAME(DCA0REM), DIONAME(DCA1), DIONAME(DCA1REM),
+	DIONAME(DCM), DIONAME(DCMREM),
+	DIONAME(LAN),
+	DIONAME(FHPIB), DIONAME(NHPIB),
+	DIONAME(SCSI0), DIONAME(SCSI1), DIONAME(SCSI2), DIONAME(SCSI3),
+	DIONAME(FBUFFER),
+	DIONAME(PARALLEL), DIONAME(VME), DIONAME(DCL), DIONAME(DCLREM),
+	DIONAME(MISC0), DIONAME(MISC1), DIONAME(MISC2), DIONAME(MISC3),
+	DIONAME(MISC4), DIONAME(MISC5), DIONAME(MISC6), DIONAME(MISC7),
+	DIONAME(MISC8), DIONAME(MISC9), DIONAME(MISC10), DIONAME(MISC11), 
+	DIONAME(MISC12), DIONAME(MISC13),
+	DIOFBNAME(GATORBOX), DIOFBNAME(TOPCAT), DIOFBNAME(RENAISSANCE),
+	DIOFBNAME(LRCATSEYE), DIOFBNAME(HRCCATSEYE), DIOFBNAME(HRMCATSEYE),
+	DIOFBNAME(DAVINCI), DIOFBNAME(XXXCATSEYE), DIOFBNAME(HYPERION),
+	DIOFBNAME(XGENESIS), DIOFBNAME(TIGER), DIOFBNAME(YGENESIS)   
 };
 
 #undef DIONAME
@@ -94,13 +94,13 @@ static const char unknowndioname[]
 
 static const char *dio_getname(int id)
 {
-        /* return pointer to a constant string describing the board with given ID */
+	/* return pointer to a constant string describing the board with given ID */
 	unsigned int i;
 	for (i = 0; i < ARRAY_SIZE(names); i++)
-                if (names[i].id == id) 
-                        return names[i].name;
+		if (names[i].id == id) 
+			return names[i].name;
 
-        return unknowndioname;
+	return unknowndioname;
 }
 
 #else
@@ -122,10 +122,10 @@ int __init dio_find(int deviceid)
 		void *va;
 		unsigned long pa;
 
-                if (DIO_SCINHOLE(scode))
-                        continue;
+		if (DIO_SCINHOLE(scode))
+			continue;
 
-                pa = dio_scodetophysaddr(scode);
+		pa = dio_scodetophysaddr(scode);
 
 		if (!pa)
 			continue;
@@ -139,15 +139,15 @@ int __init dio_find(int deviceid)
 				(unsigned char *)va + DIO_IDOFF, 1)) {
 			if (scode >= DIOII_SCBASE)
 				iounmap(va);
-                        continue;             /* no board present at that select code */
+			continue;	     /* no board present at that select code */
 		}
 
 		prid = DIO_ID(va);
 
-                if (DIO_NEEDSSECID(prid)) {
-                        secid = DIO_SECID(va);
-                        id = DIO_ENCODE_ID(prid, secid);
-                } else
+		if (DIO_NEEDSSECID(prid)) {
+			secid = DIO_SECID(va);
+			id = DIO_ENCODE_ID(prid, secid);
+		} else
 			id = prid;
 
 		if (id == deviceid) {
@@ -173,7 +173,7 @@ static int __init dio_init(void)
 	if (!MACH_IS_HP300)
 		return 0;
 
-        printk(KERN_INFO "Scanning for DIO devices...\n");
+	printk(KERN_INFO "Scanning for DIO devices...\n");
 
 	/* Initialize the DIO bus */ 
 	INIT_LIST_HEAD(&dio_bus.devices);
@@ -190,14 +190,14 @@ static int __init dio_init(void)
 		request_resource(&iomem_resource, &dio_bus.resources[i]);
 
 	/* Register all devices */
-        for (scode = 0; scode < DIO_SCMAX; ++scode)
-        {
-                u_char prid, secid = 0;        /* primary, secondary ID bytes */
-                u_char *va;
+	for (scode = 0; scode < DIO_SCMAX; ++scode)
+	{
+		u_char prid, secid = 0;	/* primary, secondary ID bytes */
+		u_char *va;
 		unsigned long pa;
-                
-                if (DIO_SCINHOLE(scode))
-                        continue;
+		
+		if (DIO_SCINHOLE(scode))
+			continue;
 
 		pa = dio_scodetophysaddr(scode);
 
@@ -213,10 +213,10 @@ static int __init dio_init(void)
 				(unsigned char *)va + DIO_IDOFF, 1)) {
 			if (scode >= DIOII_SCBASE)
 				iounmap(va);
-                        continue;              /* no board present at that select code */
+			continue;	      /* no board present at that select code */
 		}
 
-                /* Found a board, allocate it an entry in the list */
+		/* Found a board, allocate it an entry in the list */
 		dev = kzalloc(sizeof(struct dio_dev), GFP_KERNEL);
 		if (!dev)
 			return -ENOMEM;
@@ -229,21 +229,21 @@ static int __init dio_init(void)
 		dev->resource.end = pa + DIO_SIZE(scode, va);
 		dev_set_name(&dev->dev, "%02x", scode);
 
-                /* read the ID byte(s) and encode if necessary. */
+		/* read the ID byte(s) and encode if necessary. */
 		prid = DIO_ID(va);
 
-                if (DIO_NEEDSSECID(prid)) {
-                        secid = DIO_SECID(va);
-                        dev->id = DIO_ENCODE_ID(prid, secid);
-                } else
-                        dev->id = prid;
+		if (DIO_NEEDSSECID(prid)) {
+			secid = DIO_SECID(va);
+			dev->id = DIO_ENCODE_ID(prid, secid);
+		} else
+			dev->id = prid;
 
-                dev->ipl = DIO_IPL(va);
-                strcpy(dev->name,dio_getname(dev->id));
-                printk(KERN_INFO "select code %3d: ipl %d: ID %02X", dev->scode, dev->ipl, prid);
-                if (DIO_NEEDSSECID(prid))
-                        printk(":%02X", secid);
-                printk(": %s\n", dev->name);
+		dev->ipl = DIO_IPL(va);
+		strcpy(dev->name,dio_getname(dev->id));
+		printk(KERN_INFO "select code %3d: ipl %d: ID %02X", dev->scode, dev->ipl, prid);
+		if (DIO_NEEDSSECID(prid))
+			printk(":%02X", secid);
+		printk(": %s\n", dev->name);
 
 		if (scode >= DIOII_SCBASE)
 			iounmap(va);
@@ -256,7 +256,7 @@ static int __init dio_init(void)
 		error = dio_create_sysfs_dev_files(dev);
 		if (error)
 			dev_err(&dev->dev, "Error creating sysfs files\n");
-        }
+	}
 	return 0;
 }
 
@@ -267,12 +267,12 @@ subsys_initcall(dio_init);
  */
 unsigned long dio_scodetophysaddr(int scode)
 {
-        if (scode >= DIOII_SCBASE) {
-                return (DIOII_BASE + (scode - 132) * DIOII_DEVSIZE);
-        } else if (scode > DIO_SCMAX || scode < 0)
-                return 0;
-        else if (DIO_SCINHOLE(scode))
-                return 0;
-
-        return (DIO_BASE + scode * DIO_DEVSIZE);
+	if (scode >= DIOII_SCBASE) {
+		return (DIOII_BASE + (scode - 132) * DIOII_DEVSIZE);
+	} else if (scode > DIO_SCMAX || scode < 0)
+		return 0;
+	else if (DIO_SCINHOLE(scode))
+		return 0;
+
+	return (DIO_BASE + scode * DIO_DEVSIZE);
 }
-- 
2.34.1

