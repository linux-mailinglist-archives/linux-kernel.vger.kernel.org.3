Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1842B49E3DA
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 14:51:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238592AbiA0Nvt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 08:51:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237115AbiA0Nvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 08:51:46 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C4C5C06173B
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 05:51:45 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id c24so3760660edy.4
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 05:51:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5Ux7v2cqIndHUlhOJZ0z4xi48dTACCOgYk13ORx8KFs=;
        b=i1ghC5Wqg9v5Ko8IAxjE2aGHfkiNzTcL/aBtSHjG+gLq2qQpEavh+9nffGC8W5zLDZ
         1KatXBpjngr+KnAix6vq76E/+V7+KJ0k4XRZVU0Hb67IXmzhOu+OFPhXH6gMIX2NUda7
         2SfpEBKlxVTWPIZEYx4Yq//NvwilhxaGywM0wIQhzT9XbNJj+7lvlPoHjmV/1dA/496v
         oSNZpuyX3TzuHTtYlPsFYSvp/7PSS9VboIuhBhYK/bIusd530lOL5KYL/32LIaWfuYww
         pUhzfzS8R85DZsXLQSITY0V1qRsY5M+VLb6L7xXljOIiU5jD0UtAm3bSjCVq9oE6ZTeR
         IhIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5Ux7v2cqIndHUlhOJZ0z4xi48dTACCOgYk13ORx8KFs=;
        b=khud8jmSl/OPc3InA7RZKSC1xdUeyv3NeI3iavh4fcJpFer/4xdK/l37CSGZhX0mln
         iKFFFnhriL2CqkXGfh/Lg3r6FwcwGYQigXjXjaO6Qkz12mkJbNQU3QqIZbUe0gUqTCOn
         NbpWTxVL8hmsfv3Vd/+jFPHi1yRCwsqkqhnh7j/uNvCKDaLvwWWboCezRvhIPjEnRXlD
         VA2Gzrg22MX/teLFQdSyItwxmcUwjgoOEu8/o7HJYNkdZBpCDy4BRUf3p0DhN5DsSX77
         tuW4nTLHkayMqvkgEbzOPeP/P1sfngbpoUTXKKIfNmEp3Uc3/6rD7cXNGEYHo6lcEp2H
         3W+Q==
X-Gm-Message-State: AOAM533Y0a7aRZWeviFzbwR0Xrzp1ymLzvgyzWv2RL8FBe8sEbOLQBqP
        WuqeQLaOxAZIl1ftsOST8cU=
X-Google-Smtp-Source: ABdhPJy/f6fsdinaebvLj8opK0PMUD6aDSbFnLfcUyuy9jax/YDMZAnBgLvwb0u/PLDbPnGnVJ7n4g==
X-Received: by 2002:a05:6402:2707:: with SMTP id y7mr3777974edd.294.1643291504152;
        Thu, 27 Jan 2022 05:51:44 -0800 (PST)
Received: from localhost (cable-89-216-134-246.dynamic.sbb.rs. [89.216.134.246])
        by smtp.gmail.com with ESMTPSA id c8sm11362479edr.70.2022.01.27.05.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 05:51:43 -0800 (PST)
From:   =?UTF-8?q?Aleksa=20Vu=C4=8Dkovi=C4=87?= <aleksav013@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     salah.triki@gmail.com, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Aleksa=20Vu=C4=8Dkovi=C4=87?= <aleksav013@gmail.com>
Subject: [PATCH 3/7] drivers: dio: trailing whitespace
Date:   Thu, 27 Jan 2022 14:50:50 +0100
Message-Id: <20220127135054.27281-3-aleksav013@gmail.com>
X-Mailer: git-send-email 2.35.0
In-Reply-To: <20220127135054.27281-1-aleksav013@gmail.com>
References: <20220127135054.27281-1-aleksav013@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the checkpatch.pl errors and warnings:

< ERROR: trailing whitespace
< #5: FILE: drivers/dio/dio.c:5:
< + * $
<
< ERROR: trailing whitespace
< #11: FILE: drivers/dio/dio.c:11:
< + *    This means that framebuffers should pass it as $
<
< ERROR: trailing whitespace
< #17: FILE: drivers/dio/dio.c:17:
< + *    Every DIO card has a fixed interrupt priority level. This
function $
<
< ERROR: trailing whitespace
< #20: FILE: drivers/dio/dio.c:20:
< + *    Return a character string describing this board [might be "" if
$
<
< ERROR: trailing whitespace
< #25: FILE: drivers/dio/dio.c:25:
< + * This file is based on the way the Amiga port handles Zorro II
cards, $

+ 15 more errors and warnings of type "trailing whitespace"

Signed-off-by: Aleksa Vučković <aleksav013@gmail.com>
---
 drivers/dio/dio.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/dio/dio.c b/drivers/dio/dio.c
index 4a35ca2d0849..06e248933dde 100644
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
 struct dioname {
@@ -76,12 +76,12 @@ static struct dioname names[] = {
         DIONAME(PARALLEL), DIONAME(VME), DIONAME(DCL), DIONAME(DCLREM),
         DIONAME(MISC0), DIONAME(MISC1), DIONAME(MISC2), DIONAME(MISC3),
         DIONAME(MISC4), DIONAME(MISC5), DIONAME(MISC6), DIONAME(MISC7),
-        DIONAME(MISC8), DIONAME(MISC9), DIONAME(MISC10), DIONAME(MISC11), 
+	DIONAME(MISC8), DIONAME(MISC9), DIONAME(MISC10), DIONAME(MISC11),
         DIONAME(MISC12), DIONAME(MISC13),
         DIOFBNAME(GATORBOX), DIOFBNAME(TOPCAT), DIOFBNAME(RENAISSANCE),
         DIOFBNAME(LRCATSEYE), DIOFBNAME(HRCCATSEYE), DIOFBNAME(HRMCATSEYE),
         DIOFBNAME(DAVINCI), DIOFBNAME(XXXCATSEYE), DIOFBNAME(HYPERION),
-        DIOFBNAME(XGENESIS), DIOFBNAME(TIGER), DIOFBNAME(YGENESIS)   
+	DIOFBNAME(XGENESIS), DIOFBNAME(TIGER), DIOFBNAME(YGENESIS)
 };
 
 #undef DIONAME
@@ -95,7 +95,7 @@ static const char *dio_getname(int id)
         /* return pointer to a constant string describing the board with given ID */
 	unsigned int i;
 	for (i = 0; i < ARRAY_SIZE(names); i++)
-                if (names[i].id == id) 
+		if (names[i].id == id)
                         return names[i].name;
 
         return unknowndioname;
@@ -173,7 +173,7 @@ static int __init dio_init(void)
 
         printk(KERN_INFO "Scanning for DIO devices...\n");
 
-	/* Initialize the DIO bus */ 
+	/* Initialize the DIO bus */
 	INIT_LIST_HEAD(&dio_bus.devices);
 	dev_set_name(&dio_bus.dev, "dio");
 	error = device_register(&dio_bus.dev);
@@ -192,7 +192,7 @@ static int __init dio_init(void)
                 u_char prid, secid = 0;        /* primary, secondary ID bytes */
                 u_char *va;
 		unsigned long pa;
-                
+
                 if (DIO_SCINHOLE(scode))
                         continue;
 
-- 
2.35.0

