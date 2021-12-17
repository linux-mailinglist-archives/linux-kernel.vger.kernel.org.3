Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3B8647839E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 04:22:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232392AbhLQDWW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 22:22:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231280AbhLQDWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 22:22:21 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1061C061574
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 19:22:20 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id z26so1122168iod.10
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 19:22:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ixP6AVqrvpXuXpeKKxuF1taBLb2FMpge0zvIr1X64dw=;
        b=I1vlKJge6e6iGf+4xrBh5bSqt965TDMNxHNV5kWPqw4tWacWw2PWUPZ+tI65Z6CQDd
         +oobpsoTtAaSwyRi0cdAlT8zGVS8HeFW/4ptCDVFWppUM5Nzf6mebas7HbqBBJfQD1m5
         zipcUhsRXyL9vyOEHKb+joXgMtEKvpOW5VWto=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ixP6AVqrvpXuXpeKKxuF1taBLb2FMpge0zvIr1X64dw=;
        b=Ei7+I1wVxRy00H2uH8gK34LscHJH+BcW6ghx4K0S9MvFYodnm8DFNuSkj3YSTaNwkS
         swwRmJjXc0UYWuWsjLnmqp0yPYCXh2F/ZEInVmpMKvKgCOq6liU8SmWQcXmo81VdCyXN
         zfYEK1yLsIlvrKVvWBNYR4J+hzA6BHrNvwiCI6Lu7m2o/ih/0IswIvSn1FwoEIJAdKmO
         Xn7rVaXfcfUV1KQX2+rxZinTr9mTN2230GKScgvCszEIHg/Harz9hDxc7IqomNX7SBGC
         /KldRl60e0lPFDCUgDUlVPpc+m7+4qwN3wkUOwz4tJ8Nr9jO3rbEviJxQF29FhOupADk
         /6dw==
X-Gm-Message-State: AOAM532VPIzDO3Rf4hayuzfwlABJLcDpIxxEfgpBmZi1r+aT3hFYMeao
        8qnn61CAdPfmTYDZCnTLV9TkUg==
X-Google-Smtp-Source: ABdhPJzbkBBgw32EwS/GK0jn7q/dyAo+ATvN4k0zNDuXw1Bf74wmbjya2M5qjU/PfqMkIRKfBmoI6g==
X-Received: by 2002:a05:6638:24cd:: with SMTP id y13mr610269jat.247.1639711340073;
        Thu, 16 Dec 2021 19:22:20 -0800 (PST)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id e9sm3411334ilm.44.2021.12.16.19.22.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 19:22:19 -0800 (PST)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     corbet@lwn.net, akpm@linux-foundation.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] docs/vm: update page owner doc with additional information
Date:   Thu, 16 Dec 2021 20:22:18 -0700
Message-Id: <20211217032218.66631-1-skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update page owner doc with additional information such as example
output, implementation and usages details. Made changes for clarity
and fix spelling errors.

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 Documentation/vm/page_owner.rst | 130 +++++++++++++++++++++-----------
 1 file changed, 86 insertions(+), 44 deletions(-)

diff --git a/Documentation/vm/page_owner.rst b/Documentation/vm/page_owner.rst
index 9a3af6aafa09..af270102b2c6 100644
--- a/Documentation/vm/page_owner.rst
+++ b/Documentation/vm/page_owner.rst
@@ -1,38 +1,42 @@
+.. SPDX-License-Identifier: GPL-2.0
 .. _page_owner:
 
-==================================================
-page owner: Tracking about who allocated each page
-==================================================
+============================================
+page owner: Tracking who allocated each page
+============================================
 
 Introduction
-============
+------------
 
-page owner is for the tracking about who allocated each page.
-It can be used to debug memory leak or to find a memory hogger.
-When allocation happens, information about allocation such as call stack
-and order of pages is stored into certain storage for each page.
-When we need to know about status of all pages, we can get and analyze
-this information.
+Kernel debug page owner feature is for the tracking who allocated each
+page. It can be used to debug memory leaks or to find a memory hogger.
+When page allocation happens, information about allocation such as
+call stack and order of pages is stored into certain storage for
+each page. When we need to know about status of all pages, we can
+get and analyze this information.
 
 Although we already have tracepoint for tracing page allocation/free,
-using it for analyzing who allocate each page is rather complex. We need
-to enlarge the trace buffer for preventing overlapping until userspace
-program launched. And, launched program continually dump out the trace
-buffer for later analysis and it would change system behaviour with more
-possibility rather than just keeping it in memory, so bad for debugging.
+using it for analyzing who allocated each page is rather complex. We
+need to enlarge the trace buffer for preventing overlapping until
+userspace program launched. And, launched program continually dump out
+the trace buffer for later analysis and it would change system behaviour
+with more possibility rather than just keeping it in memory, so bad for
+debugging.
 
 page owner can also be used for various purposes. For example, accurate
 fragmentation statistics can be obtained through gfp flag information of
 each page. It is already implemented and activated if page owner is
 enabled. Other usages are more than welcome.
 
-page owner is disabled in default. So, if you'd like to use it, you need
-to add "page_owner=on" into your boot cmdline. If the kernel is built
-with page owner and page owner is disabled in runtime due to no enabling
-boot option, runtime overhead is marginal. If disabled in runtime, it
-doesn't require memory to store owner information, so there is no runtime
-memory overhead. And, page owner inserts just two unlikely branches into
-the page allocator hotpath and if not enabled, then allocation is done
+page owner is disabled by default. So, if you'd like to use it, you need
+to enable **CONFIG_PAGE_OWNER** configuration option and boot the kernel
+with "**page_owner=on**" boot parameter to enable page owner at run-time.
+
+If the kernel is built with page owner and page owner is disabled in runtime
+due to no enabling boot option, runtime overhead is marginal. If disabled in
+runtime, it doesn't require memory to store owner information, so there is no
+runtime memory overhead. And, page owner inserts just two unlikely branches
+into the page allocator hot-path and if not enabled, then allocation is done
 like as the kernel without page owner. These two unlikely branches should
 not affect to allocation performance, especially if the static keys jump
 label patching functionality is available. Following is the kernel's code
@@ -51,7 +55,7 @@ size change due to this facility.
    1025       8       8    1041     411 mm/page_ext.o
 
 Although, roughly, 8 KB code is added in total, page_alloc.o increase by
-520 bytes and less than half of it is in hotpath. Building the kernel with
+520 bytes and less than half of it is in hot-path. Building the kernel with
 page owner and turning it on if needed would be great option to debug
 kernel memory problem.
 
@@ -64,47 +68,85 @@ pages are investigated and marked as allocated in initialization phase.
 Although it doesn't mean that they have the right owner information,
 at least, we can tell whether the page is allocated or not,
 more accurately. On 2GB memory x86-64 VM box, 13343 early allocated pages
-are catched and marked, although they are mostly allocated from struct
+are cached and marked, although they are mostly allocated from struct
 page extension feature. Anyway, after that, no page is left in
 un-tracking state.
 
 Usage
-=====
+-----
 
-1) Build user-space helper::
+**Build user-space helper**::
 
 	cd tools/vm
 	make page_owner_sort
 
-2) Enable page owner: add "page_owner=on" to boot cmdline.
+**Enable page owner config option**::
+
+        CONFIG_PAGE_OWNER=y
 
-3) Do the job what you want to debug
+**Enable page owner run-time: pass "page_owner=on" to boot parameter**::
 
-4) Analyze information from page owner::
+        cat /proc/cmdline
+        BOOT_IMAGE=/boot/vmlinuz-5.16.0-rc5+ root=UUID=---- page_owner=on
+
+**Analyze information from page owner**::
 
 	cat /sys/kernel/debug/page_owner > page_owner_full.txt
 	./page_owner_sort page_owner_full.txt sorted_page_owner.txt
 
-   The general output of ``page_owner_full.txt`` is as follows:
+- The general output of ``page_owner_full.txt`` is as follows::
 
-	Page allocated via order XXX, ...
-	PFN XXX ...
-	// Detailed stack
+	        Page allocated via order XXX, ...
+	        PFN XXX ...
+	        Detailed stack
 
-	Page allocated via order XXX, ...
-	PFN XXX ...
-	// Detailed stack
+- Example output::
+
+                Page allocated via order 0, mask 0x0(), pid 1, ts 357726668 ns, free_ts 0 ns
+                PFN 5124 type Unmovable Block 10 type Unmovable Flags 0xfffffc0000000(node=0|zone=1|lastcpupid=0x1fffff)
+                register_early_stack+0x6d/0xc0
+                init_page_owner+0x3c/0x370
+                page_ext_init+0x252/0x26d
+                kernel_init_freeable+0x2cc/0x495
 
-   The ``page_owner_sort`` tool ignores ``PFN`` rows, puts the remaining rows
-   in buf, uses regexp to extract the page order value, counts the times
-   and pages of buf, and finally sorts them according to the times.
+The ``page_owner_sort`` tool ignores ``PFN`` rows, puts the remaining rows
+in buf, uses regexp to extract the page order value, counts the times
+and pages of buf, and finally sorts them according to the times.
 
-   See the result about who allocated each page
-   in the ``sorted_page_owner.txt``. General output:
+- The general output of ``sorted_page_owner.txt`` is as follows::
 
 	XXX times, XXX pages:
 	Page allocated via order XXX, ...
-	// Detailed stack
+	Detailed stack
+
+- Example output::
+
+        1 times, 1 pages:
+        Page allocated via order 0, mask 0x12a20(GFP_ATOMIC|__GFP_NOWARN|__GFP_NORETRY), pid 1159, ts 57047661660 ns, free_ts 57035322260 ns
+        register_dummy_stack+0x6d/0xc0
+        init_page_owner+0x32/0x370
+        page_ext_init+0x252/0x26d
+        kernel_init_freeable+0x2cc/0x495
+
+By default, ``page_owner_sort`` is sorted according to the times of buf.
+If you want to sort by the pages nums of buf, use the ``-m`` parameter.
+
+Additional Imformation
+----------------------
+
+A few important details to know about this feature:
+
+- PAGE_OWNER_STACK_DEPTH is 16
+
+- Bulk allocator impact: PAGE_OWNER may recurse into the allocator to
+  allocate space to save the stack with pagesets.lock held. Releasing
+  and reacquiring removes much of the performance benefit of bulk
+  allocation. Hence ``__alloc_pages_bulk()`` forces the caller to allocate
+  one page at a time when if page_owner_inited is enabled. The reason
+  being, it'll have similar performance to added complexity to the bulk
+  allocator.
+
+- Eats a fair amount of memory if enabled.
 
-   By default, ``page_owner_sort`` is sorted according to the times of buf.
-   If you want to sort by the pages nums of buf, use the ``-m`` parameter.
+- KASAN usage: Enable Page owner (CONFIG_PAGE_OWNER and page_owner=on) to
+  get include alloc and free stack traces of affected physical pages
-- 
2.32.0

