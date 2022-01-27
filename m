Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B57349E3DD
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 14:51:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238954AbiA0Nvz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 08:51:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239471AbiA0Nvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 08:51:50 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80D4DC06173B
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 05:51:50 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id m4so5929849ejb.9
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 05:51:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IzpEVVbAnWkumnCEQ1MeiSbs/bCRP7m3NQT9jgikoUM=;
        b=VPn+WSi3Q1kdltV71EjLNp1mkxhyEzxJ1elvK2LtHbrspRFJjqf/22itcgxjxiNuT6
         peVlrKviOIVrEIz/WY5J0t9aOfPjVGmqe/tsnrFyZ51WEja82qoIcFeptJf1E49qeE11
         MTqb3sVBi5iKcmgWFK//nMQRWinwGv4C6Nbg3YXzziozBi+IAwVcovCdtIzcfwnqdv2x
         +bYFp3DKJRHuj2bwn8oFuhveP86UXsakb167wQqBKe6pwQtHZERLpXLPLiH2UpwIpRPe
         6jdoqoJerQvAR3Y8+adUnbrI2CN/0NKyFWIz+sh/nU2kMtkGVBpBh6nH9nl6ugsjB0XZ
         54iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IzpEVVbAnWkumnCEQ1MeiSbs/bCRP7m3NQT9jgikoUM=;
        b=DLCE6Rx/PeOi4pH9rgFtKqPqiO5CX+mUC4R/rJdbg0pVuw1R41ZiSLICmsO40CrmQy
         qknccZGboyIuEjpOnB5Jpdq43ZIOg4mPlev/1ScIYUBGMipZKpyMFSWYKLlrExeLNdS+
         QRX4cO0POX6/+bcXUmqqejbHzE11In/mMaulRc2j5IG+tuZAnH9Xo9CQIjg6JrW6eOuJ
         OfvhOxDWrbeq8m2ojDpY+bHVmrSp52do9VQoflYxBPmlXXPGY8tMwRkzCw5rmUEhJ6qZ
         fuNkz6wxNUQvdeTYDq7n3m1HnXkRz9nDS8V/CkI7BdeXQPXFC8z5iau08mE6QZQeg2gY
         zvEQ==
X-Gm-Message-State: AOAM530EQYdySc8Y/I6Hr+sOhy5PFun8+PZDeJbbibBM7WiQ1NCOC2R/
        LLDSaRhMuFWyiJQODZrCxSg6P3cJb7f+jg==
X-Google-Smtp-Source: ABdhPJz9LxpZGDWmJpfx9T78Wz3GbpF2rgSQeY1Dw5QRv9oePns+RazzL0uzFzr37hDyUB55SMYtMg==
X-Received: by 2002:a17:907:6d82:: with SMTP id sb2mr3005802ejc.3.1643291508990;
        Thu, 27 Jan 2022 05:51:48 -0800 (PST)
Received: from localhost (cable-89-216-134-246.dynamic.sbb.rs. [89.216.134.246])
        by smtp.gmail.com with ESMTPSA id c2sm11405020edj.24.2022.01.27.05.51.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 05:51:48 -0800 (PST)
From:   =?UTF-8?q?Aleksa=20Vu=C4=8Dkovi=C4=87?= <aleksav013@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     salah.triki@gmail.com, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Aleksa=20Vu=C4=8Dkovi=C4=87?= <aleksav013@gmail.com>
Subject: [PATCH 6/7] drivers: dio: code indent should use tabs
Date:   Thu, 27 Jan 2022 14:50:53 +0100
Message-Id: <20220127135054.27281-6-aleksav013@gmail.com>
X-Mailer: git-send-email 2.35.0
In-Reply-To: <20220127135054.27281-1-aleksav013@gmail.com>
References: <20220127135054.27281-1-aleksav013@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the checkpatch.pl error:

< ERROR: code indent should use tabs where possible
< #61: FILE: drivers/dio/dio.c:61:
< +        int id;$
<
< WARNING: please, no spaces at the start of a line
< #61: FILE: drivers/dio/dio.c:61:
< +        int id;$
<
< ERROR: code indent should use tabs where possible
< #62: FILE: drivers/dio/dio.c:62:
< +        const char *name;$
<
< WARNING: please, no spaces at the start of a line
< #62: FILE: drivers/dio/dio.c:62:
< +        const char *name;$

+ 44 more errors of type "code indent should use tabs where
possible"
+ 41 more warnings of type "please, no spaces at the start of a
line"

Signed-off-by: Aleksa Vučković <aleksav013@gmail.com>
---
 drivers/dio/dio.c | 92 +++++++++++++++++++++++------------------------
 1 file changed, 46 insertions(+), 46 deletions(-)

diff --git a/drivers/dio/dio.c b/drivers/dio/dio.c
index 2b2600c20ffb..36ffa3c839f5 100644
--- a/drivers/dio/dio.c
+++ b/drivers/dio/dio.c
@@ -58,8 +58,8 @@ struct dio_bus dio_bus = {
  * marking the names[] array as .initdata ?
  */
 struct dioname {
-        int id;
-        const char *name;
+	int id;
+	const char *name;
 };
 
 /* useful macro */
@@ -67,20 +67,20 @@ struct dioname {
 #define DIOFBNAME(x) { DIO_ENCODE_ID(DIO_ID_FBUFFER, DIO_ID2_##x), DIO_DESC2_##x }
 
 static struct dioname names[] = {
-        DIONAME(DCA0), DIONAME(DCA0REM), DIONAME(DCA1), DIONAME(DCA1REM),
-        DIONAME(DCM), DIONAME(DCMREM),
-        DIONAME(LAN),
-        DIONAME(FHPIB), DIONAME(NHPIB),
-        DIONAME(SCSI0), DIONAME(SCSI1), DIONAME(SCSI2), DIONAME(SCSI3),
-        DIONAME(FBUFFER),
-        DIONAME(PARALLEL), DIONAME(VME), DIONAME(DCL), DIONAME(DCLREM),
-        DIONAME(MISC0), DIONAME(MISC1), DIONAME(MISC2), DIONAME(MISC3),
-        DIONAME(MISC4), DIONAME(MISC5), DIONAME(MISC6), DIONAME(MISC7),
+	DIONAME(DCA0), DIONAME(DCA0REM), DIONAME(DCA1), DIONAME(DCA1REM),
+	DIONAME(DCM), DIONAME(DCMREM),
+	DIONAME(LAN),
+	DIONAME(FHPIB), DIONAME(NHPIB),
+	DIONAME(SCSI0), DIONAME(SCSI1), DIONAME(SCSI2), DIONAME(SCSI3),
+	DIONAME(FBUFFER),
+	DIONAME(PARALLEL), DIONAME(VME), DIONAME(DCL), DIONAME(DCLREM),
+	DIONAME(MISC0), DIONAME(MISC1), DIONAME(MISC2), DIONAME(MISC3),
+	DIONAME(MISC4), DIONAME(MISC5), DIONAME(MISC6), DIONAME(MISC7),
 	DIONAME(MISC8), DIONAME(MISC9), DIONAME(MISC10), DIONAME(MISC11),
-        DIONAME(MISC12), DIONAME(MISC13),
-        DIOFBNAME(GATORBOX), DIOFBNAME(TOPCAT), DIOFBNAME(RENAISSANCE),
-        DIOFBNAME(LRCATSEYE), DIOFBNAME(HRCCATSEYE), DIOFBNAME(HRMCATSEYE),
-        DIOFBNAME(DAVINCI), DIOFBNAME(XXXCATSEYE), DIOFBNAME(HYPERION),
+	DIONAME(MISC12), DIONAME(MISC13),
+	DIOFBNAME(GATORBOX), DIOFBNAME(TOPCAT), DIOFBNAME(RENAISSANCE),
+	DIOFBNAME(LRCATSEYE), DIOFBNAME(HRCCATSEYE), DIOFBNAME(HRMCATSEYE),
+	DIOFBNAME(DAVINCI), DIOFBNAME(XXXCATSEYE), DIOFBNAME(HYPERION),
 	DIOFBNAME(XGENESIS), DIOFBNAME(TIGER), DIOFBNAME(YGENESIS)
 };
 
@@ -92,13 +92,13 @@ static const char unknowndioname[]
 
 static const char *dio_getname(int id)
 {
-        /* return pointer to a constant string describing the board with given ID */
+	/* return pointer to a constant string describing the board with given ID */
 	unsigned int i;
 	for (i = 0; i < ARRAY_SIZE(names); i++)
 		if (names[i].id == id)
-                        return names[i].name;
+			return names[i].name;
 
-        return unknowndioname;
+	return unknowndioname;
 }
 
 #else
@@ -120,10 +120,10 @@ int __init dio_find(int deviceid)
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
@@ -137,15 +137,15 @@ int __init dio_find(int deviceid)
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
@@ -189,12 +189,12 @@ static int __init dio_init(void)
 
 	/* Register all devices */
 	for (scode = 0; scode < DIO_SCMAX; ++scode) {
-                u_char prid, secid = 0;        /* primary, secondary ID bytes */
-                u_char *va;
+		u_char prid, secid = 0;	/* primary, secondary ID bytes */
+		u_char *va;
 		unsigned long pa;
 
-                if (DIO_SCINHOLE(scode))
-                        continue;
+		if (DIO_SCINHOLE(scode))
+			continue;
 
 		pa = dio_scodetophysaddr(scode);
 
@@ -210,10 +210,10 @@ static int __init dio_init(void)
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
@@ -226,19 +226,19 @@ static int __init dio_init(void)
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
+		dev->ipl = DIO_IPL(va);
 		strcpy(dev->name, dio_getname(dev->id));
                 printk(KERN_INFO "select code %3d: ipl %d: ID %02X", dev->scode, dev->ipl, prid);
-                if (DIO_NEEDSSECID(prid))
+		if (DIO_NEEDSSECID(prid))
                         printk(":%02X", secid);
                 printk(": %s\n", dev->name);
 
@@ -253,7 +253,7 @@ static int __init dio_init(void)
 		error = dio_create_sysfs_dev_files(dev);
 		if (error)
 			dev_err(&dev->dev, "Error creating sysfs files\n");
-        }
+	}
 	return 0;
 }
 
@@ -265,11 +265,11 @@ subsys_initcall(dio_init);
 unsigned long dio_scodetophysaddr(int scode)
 {
 	if (scode >= DIOII_SCBASE)
-                return (DIOII_BASE + (scode - 132) * DIOII_DEVSIZE);
+		return (DIOII_BASE + (scode - 132) * DIOII_DEVSIZE);
 	else if (scode > DIO_SCMAX || scode < 0)
-                return 0;
-        else if (DIO_SCINHOLE(scode))
-                return 0;
+		return 0;
+	else if (DIO_SCINHOLE(scode))
+		return 0;
 
-        return (DIO_BASE + scode * DIO_DEVSIZE);
+	return (DIO_BASE + scode * DIO_DEVSIZE);
 }
-- 
2.35.0

