Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E5F749B211
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 11:46:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243355AbiAYKgP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 05:36:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358768AbiAYKdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 05:33:32 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E4EAC061744
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 02:33:32 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id l25so18940247wrb.13
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 02:33:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HKmB0WnD95we+nYv5Lf5hKGk4udGQMGznAa0meSenNE=;
        b=aRZ3EMi3MVJvN3Z2hlWYk2nlUiGg0lck95fhMFyvC4tToOzZrkPdieA1idHZ5aZZP6
         Q2jBUOUnj0wMCp0zbQWj1CDElxw+lBX8U7wk6C0t8TPOzMAg53udxrR8SetAptUIf7OX
         zcnaAnUJvskinlIk+LQv7hJMN1RkMzEqjZ3J6J17uEs9RF8alLioU6ro1QIIQTaSQPzn
         d4aUh3hnkqcXslSDQUimYd/jAhVzsYHv9RvGatP51Db8x3L3YQr3BX1SZ03JKKQUWPwB
         7f7MFD4cT+a4Q90SqPhCojoOHzEkkEWWuFijkNFKlPx5wp1CLLJBvCc8hxDPIlCb4yM2
         lYCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HKmB0WnD95we+nYv5Lf5hKGk4udGQMGznAa0meSenNE=;
        b=8IBuhyk3QO34ZhfB9KO/KvqkAQBl5I7lS7GPNFhVFINti+Ce6D7FDDGCOxB7E6yE++
         /JlVaJ5nxihEhGYVmg/42KfgBIsRFl1Rdr7BIIa8OKl4BD/lh3Sh9rGIrjsHr1rLHfqn
         RRxzxrLwrtw5UqoBMXAxpQuR7ha0EeFFyqIzGfYGXUl5j4KUsTI5Jn1gh+KElL7hPE52
         vU3bZpteAZQhtClqLcihdJVqohSfv9+s6auipZmAwyfdUpVZjREND3eceHPFUG/AWLoK
         ZmxeaMEMmaAzhOVzdMCGOW8yzebi24TjZea8khpAwfe8RbeO+lKX9v/Tj+gQDfWf1CCe
         S6wQ==
X-Gm-Message-State: AOAM5315hQ+JFwdyEUbrXqun9QWObg4dZ+81KIesGZYiSO7bHx3wY5Q9
        FhsZyVIDEE9UxaFYsvSecXT8/PVmSOPaog==
X-Google-Smtp-Source: ABdhPJyz+hpwgnmS6vF+cFqljL7qNp2mmjZL9diVXzyL2WoxLhvCp3r07PehJ2JIXBpmQmdK5gMriA==
X-Received: by 2002:a5d:64a5:: with SMTP id m5mr9375014wrp.596.1643106810651;
        Tue, 25 Jan 2022 02:33:30 -0800 (PST)
Received: from localhost (cable-89-216-134-246.dynamic.sbb.rs. [89.216.134.246])
        by smtp.gmail.com with ESMTPSA id h18sm1579636wro.9.2022.01.25.02.33.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 02:33:30 -0800 (PST)
From:   =?UTF-8?q?Aleksa=20Vu=C4=8Dkovi=C4=87?= <aleksav013@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?Aleksa=20Vu=C4=8Dkovi=C4=87?= <aleksav013@gmail.com>
Subject: [PATCH 2/4] drivers: dio: Fixed unwanted spaces coding style issue
Date:   Tue, 25 Jan 2022 11:33:08 +0100
Message-Id: <20220125103310.13893-2-aleksav013@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220125103310.13893-1-aleksav013@gmail.com>
References: <20220125103310.13893-1-aleksav013@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removing spaces at the end of the lines.

Signed-off-by: Aleksa Vučković <aleksav013@gmail.com>
---
 drivers/dio/dio.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/dio/dio.c b/drivers/dio/dio.c
index f1772975bf9d..d2d3028df93f 100644
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
@@ -52,9 +52,9 @@ struct dio_bus dio_bus = {
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
 struct dioname
@@ -67,7 +67,7 @@ struct dioname
 #define DIONAME(x) { DIO_ID_##x, DIO_DESC_##x }
 #define DIOFBNAME(x) { DIO_ENCODE_ID( DIO_ID_FBUFFER, DIO_ID2_##x), DIO_DESC2_##x }
 
-static struct dioname names[] = 
+static struct dioname names[] =
 {
 	DIONAME(DCA0), DIONAME(DCA0REM), DIONAME(DCA1), DIONAME(DCA1REM),
 	DIONAME(DCM), DIONAME(DCMREM),
@@ -78,12 +78,12 @@ static struct dioname names[] =
 	DIONAME(PARALLEL), DIONAME(VME), DIONAME(DCL), DIONAME(DCLREM),
 	DIONAME(MISC0), DIONAME(MISC1), DIONAME(MISC2), DIONAME(MISC3),
 	DIONAME(MISC4), DIONAME(MISC5), DIONAME(MISC6), DIONAME(MISC7),
-	DIONAME(MISC8), DIONAME(MISC9), DIONAME(MISC10), DIONAME(MISC11), 
+	DIONAME(MISC8), DIONAME(MISC9), DIONAME(MISC10), DIONAME(MISC11),
 	DIONAME(MISC12), DIONAME(MISC13),
 	DIOFBNAME(GATORBOX), DIOFBNAME(TOPCAT), DIOFBNAME(RENAISSANCE),
 	DIOFBNAME(LRCATSEYE), DIOFBNAME(HRCCATSEYE), DIOFBNAME(HRMCATSEYE),
 	DIOFBNAME(DAVINCI), DIOFBNAME(XXXCATSEYE), DIOFBNAME(HYPERION),
-	DIOFBNAME(XGENESIS), DIOFBNAME(TIGER), DIOFBNAME(YGENESIS)   
+	DIOFBNAME(XGENESIS), DIOFBNAME(TIGER), DIOFBNAME(YGENESIS)
 };
 
 #undef DIONAME
@@ -97,7 +97,7 @@ static const char *dio_getname(int id)
 	/* return pointer to a constant string describing the board with given ID */
 	unsigned int i;
 	for (i = 0; i < ARRAY_SIZE(names); i++)
-		if (names[i].id == id) 
+		if (names[i].id == id)
 			return names[i].name;
 
 	return unknowndioname;
@@ -175,7 +175,7 @@ static int __init dio_init(void)
 
 	printk(KERN_INFO "Scanning for DIO devices...\n");
 
-	/* Initialize the DIO bus */ 
+	/* Initialize the DIO bus */
 	INIT_LIST_HEAD(&dio_bus.devices);
 	dev_set_name(&dio_bus.dev, "dio");
 	error = device_register(&dio_bus.dev);
@@ -195,7 +195,7 @@ static int __init dio_init(void)
 		u_char prid, secid = 0;	/* primary, secondary ID bytes */
 		u_char *va;
 		unsigned long pa;
-		
+
 		if (DIO_SCINHOLE(scode))
 			continue;
 
-- 
2.34.1

