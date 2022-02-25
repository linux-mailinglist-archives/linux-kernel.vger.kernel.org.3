Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 761794C46E8
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 14:51:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234461AbiBYNvG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 08:51:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233729AbiBYNvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 08:51:03 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB44B1DA440
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 05:50:30 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id u1so4600717wrg.11
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 05:50:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20210112.gappssmtp.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9w9MNHceM5e/CbwY1+dyQPCC98anFtCZUOG8qqhTmyk=;
        b=l0hKYKeJwsyR+c3rmZxWRXHiQXcj3S1dJf+VlCLB7EOkb6WzBZ9QCJueUpJ0Ce7Jq+
         3QymsCM9QeJ/pcUwZ1idEJHRyJRPpDh0oKMOYuHEkU6TeQZasgkIM34+7OXz/4DCLBv8
         8cubRbLob9HNJ6BCPAYGhrqZU3J7FHtwpD8e5zgDQsW/972C+M0zrMn3mOIj83gE1sI3
         VssE6QdPEzVnJHPPjrHMc6EK58Tk7whTdLnROFly7itDCloHoY5pQqUbFw1saHZE3E+O
         7n+YJjCQ4cZEqvZ4sO5icKUY5Q784PGd73STmsuiv5AngnEdbMRisUo6UhkiCXzyS4Ib
         O4RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=9w9MNHceM5e/CbwY1+dyQPCC98anFtCZUOG8qqhTmyk=;
        b=NaMlJ71pjDLECa/fOnxgH7z33/sQyDS0V93vXPVtIAgrBP6eo1heJ8gOU11zDnlDUE
         aWS0/bHiSowQ/TRGpILZ1HIeYslNC3NNd5vSZZ/bBMSVRk5dzzzHZzoxnUPOJEn1rKM7
         PN4mGRPV1qLOTh2kieGBnYNxwdEghedvNK4iQS3xAiv3eBbcmc0pFqTDeaYOnC+bx69K
         DdMDh/REIoCCKAqnUAMNJE1YXB3f4SNCZFWtQk3LqaFIIgEUpqLu3z7uCEDBVIoIYaT+
         9WnEK3xD7TNipgQJSJ5EUz8wdJEju67Rxl5vC7u7oUPucnAgnkQ1f3P2i7yJ7ZOILm1c
         oEfA==
X-Gm-Message-State: AOAM530bTTRwdGgi7bF5tNkPR1U4ZiIcAMHhkw4gQ88Qahia9dHqqVQh
        79qYtjYPIEEXNu6EGBhUwLPa4+aHtNUYlQ==
X-Google-Smtp-Source: ABdhPJwNILx7Y3vqGmnf45KsaAhEwi7FjG9vOoWlbsOgEezNhsWb6i1JReFRh8OcKihQygaPpIuWgQ==
X-Received: by 2002:a5d:6b0b:0:b0:1e3:1c27:5141 with SMTP id v11-20020a5d6b0b000000b001e31c275141mr6416258wrw.321.1645797029165;
        Fri, 25 Feb 2022 05:50:29 -0800 (PST)
Received: from localhost ([2a02:768:2307:40d6::f9e])
        by smtp.gmail.com with ESMTPSA id k19-20020a05600c479300b00380e461a4d2sm7344566wmo.0.2022.02.25.05.50.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 25 Feb 2022 05:50:28 -0800 (PST)
Sender: Michal Simek <monstr@monstr.eu>
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com
Cc:     Mahesh Bodapati <mbodapat@xilinx.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH 1/1] microblaze: Use simple memmove/memcpy implementation from lib/string.c
Date:   Fri, 25 Feb 2022 14:50:25 +0100
Message-Id: <e31a03a5bb343d1c13b50e29dce42fb0681c5106.1645797022.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1645797022.git.michal.simek@xilinx.com>
References: <cover.1645797022.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is based on previous commit ("microblaze: Use simple memset
implementation from lib/string.c") where generic memset implementation is
used when OPT_LIB_FUNCTION is not defined. The same change can be done for
memset/memcpy implementation where doesn't make sense to have generic
implementation in architecture code.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 arch/microblaze/include/asm/string.h |  2 +-
 arch/microblaze/lib/memcpy.c         | 18 ++---------------
 arch/microblaze/lib/memmove.c        | 29 ++--------------------------
 3 files changed, 5 insertions(+), 44 deletions(-)

diff --git a/arch/microblaze/include/asm/string.h b/arch/microblaze/include/asm/string.h
index dbdb9eb4a733..8798ad2c132a 100644
--- a/arch/microblaze/include/asm/string.h
+++ b/arch/microblaze/include/asm/string.h
@@ -10,13 +10,13 @@
 
 #ifdef CONFIG_OPT_LIB_FUNCTION
 #define __HAVE_ARCH_MEMSET
-#endif
 #define __HAVE_ARCH_MEMCPY
 #define __HAVE_ARCH_MEMMOVE
 
 extern void *memset(void *, int, __kernel_size_t);
 extern void *memcpy(void *, const void *, __kernel_size_t);
 extern void *memmove(void *, const void *, __kernel_size_t);
+#endif
 
 #endif /* __KERNEL__ */
 
diff --git a/arch/microblaze/lib/memcpy.c b/arch/microblaze/lib/memcpy.c
index 63041fdf916d..9966dce55619 100644
--- a/arch/microblaze/lib/memcpy.c
+++ b/arch/microblaze/lib/memcpy.c
@@ -31,20 +31,7 @@
 
 #include <linux/string.h>
 
-#ifdef __HAVE_ARCH_MEMCPY
-#ifndef CONFIG_OPT_LIB_FUNCTION
-void *memcpy(void *v_dst, const void *v_src, __kernel_size_t c)
-{
-	const char *src = v_src;
-	char *dst = v_dst;
-
-	/* Simple, byte oriented memcpy. */
-	while (c--)
-		*dst++ = *src++;
-
-	return v_dst;
-}
-#else /* CONFIG_OPT_LIB_FUNCTION */
+#ifdef CONFIG_OPT_LIB_FUNCTION
 void *memcpy(void *v_dst, const void *v_src, __kernel_size_t c)
 {
 	const char *src = v_src;
@@ -188,6 +175,5 @@ void *memcpy(void *v_dst, const void *v_src, __kernel_size_t c)
 
 	return v_dst;
 }
-#endif /* CONFIG_OPT_LIB_FUNCTION */
 EXPORT_SYMBOL(memcpy);
-#endif /* __HAVE_ARCH_MEMCPY */
+#endif /* CONFIG_OPT_LIB_FUNCTION */
diff --git a/arch/microblaze/lib/memmove.c b/arch/microblaze/lib/memmove.c
index 9862f6b1e59d..2e49d0ef1e07 100644
--- a/arch/microblaze/lib/memmove.c
+++ b/arch/microblaze/lib/memmove.c
@@ -30,31 +30,7 @@
 #include <linux/compiler.h>
 #include <linux/string.h>
 
-#ifdef __HAVE_ARCH_MEMMOVE
-#ifndef CONFIG_OPT_LIB_FUNCTION
-void *memmove(void *v_dst, const void *v_src, __kernel_size_t c)
-{
-	const char *src = v_src;
-	char *dst = v_dst;
-
-	if (!c)
-		return v_dst;
-
-	/* Use memcpy when source is higher than dest */
-	if (v_dst <= v_src)
-		return memcpy(v_dst, v_src, c);
-
-	/* copy backwards, from end to beginning */
-	src += c;
-	dst += c;
-
-	/* Simple, byte oriented memmove. */
-	while (c--)
-		*--dst = *--src;
-
-	return v_dst;
-}
-#else /* CONFIG_OPT_LIB_FUNCTION */
+#ifdef CONFIG_OPT_LIB_FUNCTION
 void *memmove(void *v_dst, const void *v_src, __kernel_size_t c)
 {
 	const char *src = v_src;
@@ -215,6 +191,5 @@ void *memmove(void *v_dst, const void *v_src, __kernel_size_t c)
 	}
 	return v_dst;
 }
-#endif /* CONFIG_OPT_LIB_FUNCTION */
 EXPORT_SYMBOL(memmove);
-#endif /* __HAVE_ARCH_MEMMOVE */
+#endif /* CONFIG_OPT_LIB_FUNCTION */
-- 
2.35.1

