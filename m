Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 217AF5139A5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 18:22:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349912AbiD1QZY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 12:25:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231805AbiD1QZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 12:25:16 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DAFE5E152
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 09:22:01 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1651162917;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ScfRiX1QGknyiNAjIBYqs4VvQ59BCXbjYO7mgxh1RLQ=;
        b=Ljf+8djCHvl0bjxq+iIreKVSb56/xRs6kVfEazeA8DB1DrDEp2FenrJJHhl8TxQFCjJu5r
        3IMOpW1287MbIGCRAPir7Aw+6ngEfiDS6mo1b6hyD/rS2TWVJ2Cy4KHG70EkCEdpKAXiS9
        C457Ica9DFy6TlWCdWlC0+hhySpSBOI=
From:   andrey.konovalov@linux.dev
To:     Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH 2/3] kasan: use tabs to align shadow values
Date:   Thu, 28 Apr 2022 18:21:51 +0200
Message-Id: <91a979ef1eb9aa68d820234663ad797b4818e098.1651162840.git.andreyknvl@google.com>
In-Reply-To: <3167cbec7a82704c1ed2c6bfe85b77534a836fdc.1651162840.git.andreyknvl@google.com>
References: <3167cbec7a82704c1ed2c6bfe85b77534a836fdc.1651162840.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Konovalov <andreyknvl@google.com>

Consistently use tabs instead of spaces to shadow value definitions.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 mm/kasan/kasan.h | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index 13681516dc08..06fdea41ca4a 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -74,29 +74,29 @@ static inline bool kasan_sync_fault_possible(void)
 #define KASAN_MEMORY_PER_SHADOW_PAGE	(KASAN_GRANULE_SIZE << PAGE_SHIFT)
 
 #ifdef CONFIG_KASAN_GENERIC
-#define KASAN_FREE_PAGE         0xFF  /* freed page */
-#define KASAN_PAGE_REDZONE      0xFE  /* redzone for kmalloc_large allocation */
-#define KASAN_KMALLOC_REDZONE   0xFC  /* redzone for slab object */
-#define KASAN_KMALLOC_FREE      0xFB  /* freed slab object */
-#define KASAN_VMALLOC_INVALID   0xF8  /* inaccessible space in vmap area */
+#define KASAN_FREE_PAGE		0xFF  /* freed page */
+#define KASAN_PAGE_REDZONE	0xFE  /* redzone for kmalloc_large allocation */
+#define KASAN_KMALLOC_REDZONE	0xFC  /* redzone for slab object */
+#define KASAN_KMALLOC_FREE	0xFB  /* freed slab object */
+#define KASAN_VMALLOC_INVALID	0xF8  /* inaccessible space in vmap area */
 #else
-#define KASAN_FREE_PAGE         KASAN_TAG_INVALID
-#define KASAN_PAGE_REDZONE      KASAN_TAG_INVALID
-#define KASAN_KMALLOC_REDZONE   KASAN_TAG_INVALID
-#define KASAN_KMALLOC_FREE      KASAN_TAG_INVALID
-#define KASAN_VMALLOC_INVALID   KASAN_TAG_INVALID /* only used for SW_TAGS */
+#define KASAN_FREE_PAGE		KASAN_TAG_INVALID
+#define KASAN_PAGE_REDZONE	KASAN_TAG_INVALID
+#define KASAN_KMALLOC_REDZONE	KASAN_TAG_INVALID
+#define KASAN_KMALLOC_FREE	KASAN_TAG_INVALID
+#define KASAN_VMALLOC_INVALID	KASAN_TAG_INVALID /* only used for SW_TAGS */
 #endif
 
 #ifdef CONFIG_KASAN_GENERIC
 
-#define KASAN_KMALLOC_FREETRACK 0xFA  /* freed slab object with free track */
-#define KASAN_GLOBAL_REDZONE    0xF9  /* redzone for global variable */
+#define KASAN_KMALLOC_FREETRACK	0xFA  /* freed slab object with free track */
+#define KASAN_GLOBAL_REDZONE	0xF9  /* redzone for global variable */
 
 /* Stack redzone shadow values. Compiler's ABI, do not change. */
-#define KASAN_STACK_LEFT        0xF1
-#define KASAN_STACK_MID         0xF2
-#define KASAN_STACK_RIGHT       0xF3
-#define KASAN_STACK_PARTIAL     0xF4
+#define KASAN_STACK_LEFT	0xF1
+#define KASAN_STACK_MID		0xF2
+#define KASAN_STACK_RIGHT	0xF3
+#define KASAN_STACK_PARTIAL	0xF4
 
 /* alloca redzone shadow values. */
 #define KASAN_ALLOCA_LEFT	0xCA
-- 
2.25.1

