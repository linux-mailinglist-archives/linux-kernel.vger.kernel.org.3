Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 369CD49A6AE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 03:28:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S3420049AbiAYCWX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 21:22:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237867AbiAXTJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 14:09:16 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A785C08C5DA
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 11:02:14 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id n12-20020a05600c3b8c00b0034eb13edb8eso267084wms.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 11:02:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3Qm9PL5QLT29CmW7VrLWEMoME0NYrJKZF2FZNBlbz70=;
        b=eZzZHmtni0k6ax2xvSvztj/njqN+qKbXqwKyRPyDmAbo9OWX9hBbp3qHa6EnWPSuU0
         N9pKHbsw+ejvyvGSK5rnOBnmn7VNtd49xJxDhHpwj7kU8mGGgRIgzsNfYXvNvc2wlWQ+
         ziVz3YFsdoN+tDZBje2e63spZfJUIuI+4Rol0Lc+dElGGLJ20gMJoR4y8jix/yLNdh29
         NxRcY8jOO9MQfGTZ4vTO2JKaWvjULsnetvuGUxltH+8Iro8mu7JHsecVjGXUjQhiGaFa
         hKrkNGwzXHE7F4kE5j61Pdg9h3z3bg1npNWieFL0MZQdHV83kpUeX9rilTC9kGUFI8oZ
         LCOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3Qm9PL5QLT29CmW7VrLWEMoME0NYrJKZF2FZNBlbz70=;
        b=JThsxPnLfD7Km9n5q/qB6hM5pIkA4O9XzVJoErIrE0qyZlhNMSOdRzR8IXZIyOz+LI
         MCedZHBXqC4oFmeq0UtgIvB72I5H1fnptnLsCrb82KSFW+bVO9s8Qnqbd3ZkHCUtWfka
         csuu48oztQWc9v/Gj/pC28EysOG5qZb2volgF+BAD0YQXCruAfGkMJka83xuEmf1NcHB
         NFdfCW5Bme2Hn0XmHGI4uMIytohemntwEf2flQykGuE9LGKx9eqhn7Xf+4wnGuV1QaRx
         GrpY4CqOkS2Pd9pGEQUtuArhkEz+zgUWWMupDa68hCTrwtFgHRgYuu07XOPC8RPGByEY
         74ag==
X-Gm-Message-State: AOAM532dW5xt1t8fDH+xOtXxouG08PAccYNxWxSoDHa6XYxM8Hiur0Zw
        AZuUUQD0RSwup4P8PeRo3SlE9JpOqJUBQw==
X-Google-Smtp-Source: ABdhPJxjzgjcEj5hSuYDoscixFPVPxvNMY8PPTCh73mrsCDeP8PKU06OjiRumO24hqIXnGmP0X/Mww==
X-Received: by 2002:a05:600c:5028:: with SMTP id n40mr2936954wmr.10.1643050932609;
        Mon, 24 Jan 2022 11:02:12 -0800 (PST)
Received: from localhost (cable-89-216-134-246.dynamic.sbb.rs. [89.216.134.246])
        by smtp.gmail.com with ESMTPSA id w8sm15333381wrq.3.2022.01.24.11.02.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 11:02:12 -0800 (PST)
From:   =?UTF-8?q?Aleksa=20Vu=C4=8Dkovi=C4=87?= <aleksav013@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?Aleksa=20Vu=C4=8Dkovi=C4=87?= <aleksav013@gmail.com>
Subject: [PATCH] drivers: dio: fixed coding style issues
Date:   Mon, 24 Jan 2022 20:02:01 +0100
Message-Id: <20220124190201.26741-1-aleksav013@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed multiple coding style issues:
Converting spaces to tabs and moving braces.

Signed-off-by: Aleksa Vučković <aleksav013@gmail.com>
---
 drivers/dio/dio.c | 150 +++++++++++++++++++++++-----------------------
 1 file changed, 74 insertions(+), 76 deletions(-)

diff --git a/drivers/dio/dio.c b/drivers/dio/dio.c
index 4c06c93c93d3..28ae8596b0ea 100644
--- a/drivers/dio/dio.c
+++ b/drivers/dio/dio.c
@@ -2,27 +2,27 @@
 /* Code to support devices on the DIO and DIO-II bus
  * Copyright (C) 05/1998 Peter Maydell <pmaydell@chiark.greenend.org.uk>
  * Copyright (C) 2004 Jochen Friedrich <jochen@scram.de>
- * 
+ *
  * This code has basically these routines at the moment:
  * int dio_find(u_int deviceid)
  *    Search the list of DIO devices and return the select code
  *    of the next unconfigured device found that matches the given device ID.
  *    Note that the deviceid parameter should be the encoded ID.
- *    This means that framebuffers should pass it as 
+ *    This means that framebuffers should pass it as
  *    DIO_ENCODE_ID(DIO_ID_FBUFFER,DIO_ID2_TOPCAT)
  *    (or whatever); everybody else just uses DIO_ID_FOOBAR.
  * unsigned long dio_scodetophysaddr(int scode)
  *    Return the physical address corresponding to the given select code.
  * int dio_scodetoipl(int scode)
- *    Every DIO card has a fixed interrupt priority level. This function 
+ *    Every DIO card has a fixed interrupt priority level. This function
  *    returns it, whatever it is.
  * const char *dio_scodetoname(int scode)
- *    Return a character string describing this board [might be "" if 
+ *    Return a character string describing this board [might be "" if
  *    not CONFIG_DIO_CONSTANTS]
  * void dio_config_board(int scode)     mark board as configured in the list
  * void dio_unconfig_board(int scode)   mark board as no longer configured
  *
- * This file is based on the way the Amiga port handles Zorro II cards, 
+ * This file is based on the way the Amiga port handles Zorro II cards,
  * although we aren't so complicated...
  */
 #include <linux/module.h>
@@ -31,9 +31,9 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/dio.h>
-#include <linux/slab.h>                         /* kmalloc() */
+#include <linux/slab.h>			/* kmalloc() */
 #include <linux/uaccess.h>
-#include <asm/io.h>                             /* readb() */
+#include <linux/io.h>			/* readb() */
 
 struct dio_bus dio_bus = {
 	.resources = {
@@ -52,38 +52,36 @@ struct dio_bus dio_bus = {
 /* We associate each numeric ID with an appropriate descriptive string
  * using a constant array of these structs.
  * FIXME: we should be able to arrange to throw away most of the strings
- * using the initdata stuff. Then we wouldn't need to worry about 
+ * using the initdata stuff. Then we wouldn't need to worry about
  * carrying them around...
- * I think we do this by copying them into newly kmalloc()ed memory and 
+ * I think we do this by copying them into newly kmalloc()ed memory and
  * marking the names[] array as .initdata ?
  */
-struct dioname
-{
-        int id;
-        const char *name;
+struct dioname {
+	int id;
+	const char *name;
 };
 
 /* useful macro */
 #define DIONAME(x) { DIO_ID_##x, DIO_DESC_##x }
-#define DIOFBNAME(x) { DIO_ENCODE_ID( DIO_ID_FBUFFER, DIO_ID2_##x), DIO_DESC2_##x }
-
-static struct dioname names[] = 
-{
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
+#define DIOFBNAME(x) { DIO_ENCODE_ID(DIO_ID_FBUFFER, DIO_ID2_##x), DIO_DESC2_##x }
+
+static struct dioname names[] = {
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
@@ -94,13 +92,14 @@ static const char unknowndioname[]
 
 static const char *dio_getname(int id)
 {
-        /* return pointer to a constant string describing the board with given ID */
+	/* return pointer to a constant string describing the board with given ID */
 	unsigned int i;
+
 	for (i = 0; i < ARRAY_SIZE(names); i++)
-                if (names[i].id == id) 
-                        return names[i].name;
+		if (names[i].id == id)
+			return names[i].name;
 
-        return unknowndioname;
+	return unknowndioname;
 }
 
 #else
@@ -122,10 +121,10 @@ int __init dio_find(int deviceid)
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
@@ -139,15 +138,15 @@ int __init dio_find(int deviceid)
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
@@ -173,9 +172,9 @@ static int __init dio_init(void)
 	if (!MACH_IS_HP300)
 		return 0;
 
-        printk(KERN_INFO "Scanning for DIO devices...\n");
+	printk(KERN_INFO "Scanning for DIO devices...\n");
 
-	/* Initialize the DIO bus */ 
+	/* Initialize the DIO bus */
 	INIT_LIST_HEAD(&dio_bus.devices);
 	dev_set_name(&dio_bus.dev, "dio");
 	error = device_register(&dio_bus.dev);
@@ -190,14 +189,13 @@ static int __init dio_init(void)
 		request_resource(&iomem_resource, &dio_bus.resources[i]);
 
 	/* Register all devices */
-        for (scode = 0; scode < DIO_SCMAX; ++scode)
-        {
-                u_char prid, secid = 0;        /* primary, secondary ID bytes */
-                u_char *va;
+	for (scode = 0; scode < DIO_SCMAX; ++scode) {
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
 
@@ -213,10 +211,10 @@ static int __init dio_init(void)
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
@@ -229,21 +227,21 @@ static int __init dio_init(void)
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
+		strcpy(dev->name, dio_getname(dev->id));
+		printk(KERN_INFO "select code %3d: ipl %d: ID %02X", dev->scode, dev->ipl, prid);
+		if (DIO_NEEDSSECID(prid))
+			printk(":%02X", secid);
+		printk(": %s\n", dev->name);
 
 		if (scode >= DIOII_SCBASE)
 			iounmap(va);
@@ -256,7 +254,7 @@ static int __init dio_init(void)
 		error = dio_create_sysfs_dev_files(dev);
 		if (error)
 			dev_err(&dev->dev, "Error creating sysfs files\n");
-        }
+	}
 	return 0;
 }
 
@@ -267,12 +265,12 @@ subsys_initcall(dio_init);
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
+	if (scode >= DIOII_SCBASE)
+		return (DIOII_BASE + (scode - 132) * DIOII_DEVSIZE);
+	else if (scode > DIO_SCMAX || scode < 0)
+		return 0;
+	else if (DIO_SCINHOLE(scode))
+		return 0;
+
+	return (DIO_BASE + scode * DIO_DEVSIZE);
 }
-- 
2.34.1

