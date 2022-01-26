Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B37249D2D5
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 20:54:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234275AbiAZTyP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 14:54:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231679AbiAZTyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 14:54:14 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4125C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 11:54:13 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id o30-20020a05600c511e00b0034f4c3186f4so4447090wms.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 11:54:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SM+cytAbuZ2zSJOkGpSMAp1kXekYMyxm2duzuL6HnO4=;
        b=douxuwY2sSfRQCWJc9QrhpoPDg7wL1utZI2Of56JxJ6L/9S4fednjSPhdz3WSUYemG
         4zeig2eNV4keVPmHSADyexp7heXbGO3ux1/wV4igcdyUuK0aPdTE5FY5LQ1pVCjSiuFm
         Lt/7M3VqZUonCRivHG48Qxy4HhxE5wSkhr4ZqZ4Z0vrE7fAAObDG0sBK6g0Brb3i9neK
         ANH34Y6GBGjTdFiGYb9NnzdVPSxHOFEuoTAT06EpaJZgre2xfRgOHTHfa+SJYkoHwZtU
         yK1Q5dd3gK+p77EHWT5m51m03Yk5fMpOLtIwf/4PaaSMChapCrZp5ltMn0KzOxpdbmoT
         iviw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SM+cytAbuZ2zSJOkGpSMAp1kXekYMyxm2duzuL6HnO4=;
        b=AleVmCYWaXcyiQlvbOzFR1DLKParhm0VHv7Nr4LDeVLjqLS6cxK4Bpm0RAZPlA9J4w
         rcMiQk/ECDCNXs5KuhYnALJPoUJm+Vy0PBJbXXPKMA88zY9nzDvJ8mq5KOAkKiWYj41M
         7lOCcSlDEVA1YnHrySiwao184uwPHJ+He+yysaM9RrzoaWTMPF3EUgjLJOg9UT8m3TV9
         YdwzfsxPPZS3cbtEGelDpqZA3OAE/1p+P4rT8HiK7pRIXqrShaVhBZF58hyct4/QkJtz
         9r9i0d4cpO5/piw92CksBzfT0DZtQ0O3ILIm3bV1cZIFPTH8iiTsQmOda6CpFpDEPzb5
         J6dA==
X-Gm-Message-State: AOAM531xYumtGKkLId6CleketvKHuDDGjWnelQ3TApT9kTPm+fJpsO6d
        HoGNyNoYiayYS5MsY0Wza4eSoGGZcMFJ/RDJ
X-Google-Smtp-Source: ABdhPJy3ms2DUCy4sHP64GKK/kWYW6+kkv3sas8Yg6ZNhA+ktBeS8jdacJ/I1/2G2e4KNpuhkruVlw==
X-Received: by 2002:a05:600c:1d85:: with SMTP id p5mr271220wms.36.1643226852074;
        Wed, 26 Jan 2022 11:54:12 -0800 (PST)
Received: from localhost (cable-89-216-134-246.dynamic.sbb.rs. [89.216.134.246])
        by smtp.gmail.com with ESMTPSA id r2sm256064wrz.99.2022.01.26.11.54.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 11:54:11 -0800 (PST)
From:   =?UTF-8?q?Aleksa=20Vu=C4=8Dkovi=C4=87?= <aleksav013@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     salah.triki@gmail.com, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Aleksa=20Vu=C4=8Dkovi=C4=87?= <aleksav013@gmail.com>
Subject: [PATCH] drivers: dio: Fixed coding style issues
Date:   Wed, 26 Jan 2022 20:53:41 +0100
Message-Id: <20220126195341.5154-1-aleksav013@gmail.com>
X-Mailer: git-send-email 2.35.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Converting tabs to spaces, placing braces on the appropriate lines.
Deleting unwanted spaces at the end of the lines.

Signed-off-by: Aleksa Vučković <aleksav013@gmail.com>
---
 drivers/dio/dio.c | 137 +++++++++++++++++++++++-----------------------
 1 file changed, 67 insertions(+), 70 deletions(-)

diff --git a/drivers/dio/dio.c b/drivers/dio/dio.c
index 4c06c93c93d3..e693612b305c 100644
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
@@ -94,13 +92,13 @@ static const char unknowndioname[]
 
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
@@ -122,10 +120,10 @@ int __init dio_find(int deviceid)
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
@@ -139,15 +137,15 @@ int __init dio_find(int deviceid)
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
@@ -175,7 +173,7 @@ static int __init dio_init(void)
 
         printk(KERN_INFO "Scanning for DIO devices...\n");
 
-	/* Initialize the DIO bus */ 
+	/* Initialize the DIO bus */
 	INIT_LIST_HEAD(&dio_bus.devices);
 	dev_set_name(&dio_bus.dev, "dio");
 	error = device_register(&dio_bus.dev);
@@ -190,14 +188,13 @@ static int __init dio_init(void)
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
 
@@ -213,10 +210,10 @@ static int __init dio_init(void)
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
@@ -229,19 +226,19 @@ static int __init dio_init(void)
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
+		dev->ipl = DIO_IPL(va);
+		strcpy(dev->name, dio_getname(dev->id));
                 printk(KERN_INFO "select code %3d: ipl %d: ID %02X", dev->scode, dev->ipl, prid);
-                if (DIO_NEEDSSECID(prid))
+		if (DIO_NEEDSSECID(prid))
                         printk(":%02X", secid);
                 printk(": %s\n", dev->name);
 
@@ -256,7 +253,7 @@ static int __init dio_init(void)
 		error = dio_create_sysfs_dev_files(dev);
 		if (error)
 			dev_err(&dev->dev, "Error creating sysfs files\n");
-        }
+	}
 	return 0;
 }
 
@@ -267,12 +264,12 @@ subsys_initcall(dio_init);
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
2.35.0

