Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1C584FAA6F
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 20:49:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238385AbiDISvX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 14:51:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231682AbiDISvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 14:51:21 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3DC558811;
        Sat,  9 Apr 2022 11:49:12 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id u18so2918356eda.3;
        Sat, 09 Apr 2022 11:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ByRdUYwsUrRmXZCxQJJZezHsqvrPoLpkrEGfURfn69A=;
        b=G1zqJXHzmARcE8RwkpRebw9HiuiJnk+wy1TeLiFH/oymM4GpsheLe93aOhZzPnGyuA
         rYJaDdf0P+wa/JgrYcRkvwkS+W+vkHx9d/KowIe+4Jd1rlR/a09qIKLvzusGWjLoUL/d
         FcXGq3fqW5hraeucZaucbHVaj0jNhtViQI/urOCDcQcdyjnIuSKt4Ae4Y2RAuZK4ZBbR
         hQjUdP0o+07bw0755waLD80g8ZzpPouIFWsi0tHyyDSnZsVxG8vR6LVoXVSqgo3XeQ0C
         dZongh3GMC6iOBu+dnYhblN35JazJzzy6FDDEt6UJLiNFi6ifuyaOsixVB9L1g+2tO4h
         Djcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ByRdUYwsUrRmXZCxQJJZezHsqvrPoLpkrEGfURfn69A=;
        b=wv7zoeWLGyXBsp7LIUBCGV4096+pUOUHHGpu9dASyMbC7OBUXM8DQs1g+zQ6bRhqlV
         H+XTgIDRCbRT6uTAKvEo74Ykj8efh/s4q95R63ZxyIVuaWgomhxBQln9pBtc+LyJSQnO
         OzT4CzgRkep7RXf26mBKfwfnu1AdOHTph/bs7DATuzW+XS9phfS9c16MGBhFNRHx6KIo
         6mmMSVdmj8FvmOfosam7Vavzv3PKbjYMFT2eafeCg0m8fHePnUA5UchMXrLVpu1zx6YB
         aZnEhmJlSAUC3HB68mL7wxriVRREJZ9YQVjBC2zg1tcbZ6Q5HXqNGXuPlyWA9gO2+eah
         KgIw==
X-Gm-Message-State: AOAM531QCO5t84ucznRPFUZN/vUT2e4EMIg83wttVY5zeqEGruRkh1gQ
        Ha/WPd2CrsDpro+4AHOC6bs=
X-Google-Smtp-Source: ABdhPJy/tO1kNj6LvFIPnvkC51mI4M2wbDTrdobm/Dh1giwOXIALwck13enZlTBNtkD4HH8vQPTEJQ==
X-Received: by 2002:a05:6402:3554:b0:419:402f:f632 with SMTP id f20-20020a056402355400b00419402ff632mr24866670edd.1.1649530151322;
        Sat, 09 Apr 2022 11:49:11 -0700 (PDT)
Received: from localhost.localdomain (host-87-4-4-217.retail.telecomitalia.it. [87.4.4.217])
        by smtp.gmail.com with ESMTPSA id u6-20020a17090626c600b006e74ef7f092sm8143843ejc.176.2022.04.09.11.49.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Apr 2022 11:49:09 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH] Documentation/vm: Extend "Temporary Virtual Mappings" in highmem.rst
Date:   Sat,  9 Apr 2022 20:49:07 +0200
Message-Id: <20220409184907.25122-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extend and rework the "Temporary Virtual Mappings" section of the highmem.rst
documentation. Do a partial rework of the paragraph related to kmap() and
add a new paragraph in order to document the set of kmap_local_*() functions.
Despite the local kmaps were introduced by Thomas Gleixner in October 2020,
documentation was still missing information about them. These additions rely
largely on Gleixner's patches, Jonathan Corbet's LWN articles and in-code
comments from ./include/linux/highmem.h.

Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 Documentation/vm/highmem.rst | 68 ++++++++++++++++++++++++++++--------
 1 file changed, 54 insertions(+), 14 deletions(-)

diff --git a/Documentation/vm/highmem.rst b/Documentation/vm/highmem.rst
index 0f69a9fec34d..d9ec26d921c8 100644
--- a/Documentation/vm/highmem.rst
+++ b/Documentation/vm/highmem.rst
@@ -52,25 +52,65 @@ Temporary Virtual Mappings
 
 The kernel contains several ways of creating temporary mappings:
 
-* vmap().  This can be used to make a long duration mapping of multiple
-  physical pages into a contiguous virtual space.  It needs global
-  synchronization to unmap.
+* vmap().  This can be used to make a long duration mapping of multiple physical
+  pages into a contiguous virtual space. It needs global synchronization to unmap.
 
-* kmap().  This permits a short duration mapping of a single page.  It needs
-  global synchronization, but is amortized somewhat.  It is also prone to
-  deadlocks when using in a nested fashion, and so it is not recommended for
-  new code.
+* kmap().  This can be used to make long duration mapping of a single page with
+  no restrictions on preemption or migration. It comes with an overhead as mapping
+  space is restricted and protected by a global lock for synchronization. When
+  mapping is no more needed, page must be released with kunmap().
 
-* kmap_atomic().  This permits a very short duration mapping of a single
-  page.  Since the mapping is restricted to the CPU that issued it, it
-  performs well, but the issuing task is therefore required to stay on that
-  CPU until it has finished, lest some other task displace its mappings.
+  Mapping changes must be propagated across all the CPUs. kmap() also requires
+  global TLB invalidation when the kmap's pool wraps and it might block when the
+  mapping space is fully utilized until a slot becomes available. Therefore,
+  kmap() is only callable from preemptible context.
 
-  kmap_atomic() may also be used by interrupt contexts, since it is does not
-  sleep and the caller may not sleep until after kunmap_atomic() is called.
+  All the above work is necessary if a mapping must last for a relatively long
+  time but the bulk of high-memory mappings in the kernel are short-lived and
+  only used in one place.
+
+  This means that the cost of kmap() is mostly wasted in such cases; therefore,
+  newer code is discouraged from using kmap().
 
-  It may be assumed that k[un]map_atomic() won't fail.
+* kmap_atomic().  This permits a very short duration mapping of a single page.
+  Since the mapping is restricted to the CPU that issued it, it performs well,
+  but the issuing task is therefore required to stay on that CPU until it has
+  finished, lest some other task displace its mappings.
 
+  kmap_atomic() may also be used by interrupt contexts, since it is does not
+  sleep and the caller too can not sleep until after kunmap_atomic() is called.
+  Each call of kmap_atomic() in the kernel creates a non-preemptible section and
+  disable pagefaults.
+
+  This could be a source of unwanted latency, so it should be only used if it is
+  absolutely required, otherwise the corresponding kmap_local_*() variant should
+  be used if it is feasible (see below).
+
+  On 64-bit systems, calls to kmap() and kmap_atomic() have no real work to do
+  because a 64-bit address space is more than sufficient to address all the
+  physical memory, so all of physical memory appears in the direct mapping.
+
+  It is assumed that k[un]map_atomic() won't fail.
+
+* kmap_local_*().  These provide a set of functions similar to kmap_atomic() and
+  are used to require short term mappings. They can be invoked from any context
+  (including interrupts).
+
+  The mapping can only be used in the context which acquired it, it is per thread,
+  CPU local (i.e., migration from one CPU to another is disabled - this is why
+  they are called "local"), but they don't disable preemption. It's valid to take
+  pagefaults in a local kmap region, unless the context in which the local mapping
+  is acquired does not allow it for other reasons.
+
+  If a task holding local kmaps is preempted, the maps are removed on context
+  switch and restored when the task comes back on the CPU. As the maps are strictly
+  CPU local, it is guaranteed that the task stays on the CPU and that the CPU
+  cannot be unplugged until the local kmaps are released.
+
+  Nesting kmap_local.*() and kmap_atomic.*() mappings is allowed to a certain
+  extent (up to KMAP_TYPE_NR). Nested kmap_local.*() and kunmap_local.*()
+  invocations have to be strictly ordered because the map implementation is stack
+  based.
 
 Using kmap_atomic
 =================
-- 
2.34.1

