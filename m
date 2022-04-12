Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E68A24FE176
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 15:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355121AbiDLNCS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 09:02:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351833AbiDLNCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 09:02:09 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 528466007E;
        Tue, 12 Apr 2022 05:40:09 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id l7so31625313ejn.2;
        Tue, 12 Apr 2022 05:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lAPe5KLDjByGGButyDlRAtwWbq0RQOm3lpOxpFEkjZM=;
        b=kKKwpQym3uM9gA+kAZ3Q2JSdsU6Fj13jhXXwUYhelJ5h/YQZEprLlEo+NFEtbmiZmb
         y7FUXefqMvevdwxFGVjdfb6xAp/KmwM4zkuCD+WMSH/r1TnwetcGp1wAxzmEW2/kvOSv
         Y1pZwhX+4+kI83Wy7JLpCIuhjZSaxu+C6fuZoxFVUzNp0rD6ScFbKUtjrLTQJjmhAWiY
         WDRZuF9Q5s2UhZu8takRrpu9uZvmzbnSm/IiO7OiTFzBtmAFGclpbZkO2DjEtwy5jogu
         e5lwEvNvy4Vl3vR5hTgFANtMltR9b75mDMSeJIsBdi79bLQ/vpTOZBB+kpEHQhVeiXk0
         GLlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lAPe5KLDjByGGButyDlRAtwWbq0RQOm3lpOxpFEkjZM=;
        b=XB+UfidMhpcMlAxRAOIB/sAB30uZDZ0/s9ULG3IIP8RaMLPu5h+RzJxMhhxSJe++Lz
         Y7SETiJHQMymZa4VS9CvBb+ouqv79hskcgTpEjr/Rtm/Xid035ni56JbQNnp1yIcYnOT
         ooMiAih+HIXj03td/yP+h90hosrdq3pFBjYoq567ZyB5OVt3zGfUCKrxwP9q/qJHLVfR
         SVP2Uw7AXTX+qPn0/KTuk5k0AOPO2anDo8WY7pnSFopigI89vUS4pdFd9QaiHT1B80EH
         72DjZiYayP6PSzwSLtqMLtryQzNU1E8bUbwOeZ6HP3bQiagRc1dL68hBLO6Nj97gG7Zi
         jVEA==
X-Gm-Message-State: AOAM532AA/KP/2BcacQIKsETUdDt0O/H6soCn1CAAeQ8a8o2sJoriOWp
        9Xh5LkIYjIGPjuDKrOhzbDI=
X-Google-Smtp-Source: ABdhPJw3sN0aGYU973pQYZXJ+Nb9hMtQkycLysUpJUaV6hrNy+Bnjgkud/YC0BhJwZzJKUgmkOz3fA==
X-Received: by 2002:a17:907:160a:b0:6e8:3c5d:9ce5 with SMTP id hb10-20020a170907160a00b006e83c5d9ce5mr23576285ejc.606.1649767207759;
        Tue, 12 Apr 2022 05:40:07 -0700 (PDT)
Received: from localhost.localdomain (host-82-60-208-254.retail.telecomitalia.it. [82.60.208.254])
        by smtp.gmail.com with ESMTPSA id kv22-20020a17090778d600b006e8a072fb1dsm1670417ejc.172.2022.04.12.05.40.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 05:40:06 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        SeongJae Park <sj@kernel.org>,
        Jiajian Ye <yejiajian2018@email.szu.edu.cn>,
        Alistair Popple <apopple@nvidia.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ira Weiny <ira.weiny@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v2] Documentation/vm: Extend "Temporary Virtual Mappings" section in highmem.rst
Date:   Tue, 12 Apr 2022 14:40:03 +0200
Message-Id: <20220412124003.10736-1-fmdefrancesco@gmail.com>
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
documentation.

Do a partial rework of the paragraph related to kmap() and add a new paragraph
in order to document the set of kmap_local_*() functions. Re-order paragraphs
in decreasing order of preference of usage.

Despite the local kmaps were introduced by Thomas Gleixner in October 2020,
documentation was still missing information about them. These additions rely
largely on Gleixner's patches, Jonathan Corbet's LWN articles, comments by
Ira Weiny and Matthew Wilcox, and in-code comments from
./include/linux/highmem.h.

Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ira Weiny <ira.weiny@intel.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---

v1->v2: According to comments on v1 by Mattew Wilcox and Ira Weiny,
correct a mistake in text, format paragraphs to stay within the 75
characters limit, re-order the flow of the same paragraphs in decreasing
order of preference of usage.

 Documentation/vm/highmem.rst | 67 ++++++++++++++++++++++++++++++------
 1 file changed, 56 insertions(+), 11 deletions(-)

diff --git a/Documentation/vm/highmem.rst b/Documentation/vm/highmem.rst
index 0f69a9fec34d..12dcfbee094d 100644
--- a/Documentation/vm/highmem.rst
+++ b/Documentation/vm/highmem.rst
@@ -52,24 +52,69 @@ Temporary Virtual Mappings
 
 The kernel contains several ways of creating temporary mappings:
 
-* vmap().  This can be used to make a long duration mapping of multiple
-  physical pages into a contiguous virtual space.  It needs global
-  synchronization to unmap.
-
-* kmap().  This permits a short duration mapping of a single page.  It needs
-  global synchronization, but is amortized somewhat.  It is also prone to
-  deadlocks when using in a nested fashion, and so it is not recommended for
-  new code.
+* kmap_local_*().  These provide a set of functions that are used to require
+  short term mappings. They can be invoked from any context (including
+  interrupts) but the mappings can only be used in the context which acquired
+  it.
+
+  These mappings are per thread, CPU local (i.e., migration from one CPU to
+  another is disabled - this is why they are called "local"), but they don't
+  disable preemption. It's valid to take pagefaults in a local kmap region,
+  unless the context in which the local mapping is acquired does not allow
+  it for other reasons.
+
+  If a task holding local kmaps is preempted, the maps are removed on context
+  switch and restored when the task comes back on the CPU. As the maps are
+  strictly CPU local, it is guaranteed that the task stays on the CPU and
+  that the CPU cannot be unplugged until the local kmaps are released.
+
+  Nesting kmap_local.*() and kmap_atomic.*() mappings is allowed to a certain
+  extent (up to KMAP_TYPE_NR). Nested kmap_local.*() and kunmap_local.*()
+  invocations have to be strictly ordered because the map implementation is
+  stack based.
 
 * kmap_atomic().  This permits a very short duration mapping of a single
   page.  Since the mapping is restricted to the CPU that issued it, it
   performs well, but the issuing task is therefore required to stay on that
   CPU until it has finished, lest some other task displace its mappings.
 
-  kmap_atomic() may also be used by interrupt contexts, since it is does not
-  sleep and the caller may not sleep until after kunmap_atomic() is called.
+  kmap_atomic() may also be used by interrupt contexts, since it does not
+  sleep and the caller too can not sleep until after kunmap_atomic() is called.
+  Each call of kmap_atomic() in the kernel creates a non-preemptible section and
+  disable pagefaults.
+
+  This could be a source of unwanted latency, so it should be only used if it is
+  absolutely required, otherwise the corresponding kmap_local_*() variant should
+  be used if it is feasible.
+
+  On 64-bit systems, calls to kmap() and kmap_atomic() have no real work to do
+  because a 64-bit address space is more than sufficient to address all the
+  physical memory, so all of physical memory appears in the direct mapping.
+
+  It is assumed that k[un]map_atomic() won't fail.
 
-  It may be assumed that k[un]map_atomic() won't fail.
+* kmap().  This should be used to make short duration mapping of a single
+  page with no restrictions on preemption or migration. It comes with an
+  overhead as mapping space is restricted and protected by a global lock
+  for synchronization. When mapping is no more needed, the address that
+  the page was mapped to must be released with kunmap().
+
+  Mapping changes must be propagated across all the CPUs. kmap() also
+  requires global TLB invalidation when the kmap's pool wraps and it might
+  block when the mapping space is fully utilized until a slot becomes
+  available. Therefore, kmap() is only callable from preemptible context.
+
+  All the above work is necessary if a mapping must last for a relatively
+  long time but the bulk of high-memory mappings in the kernel are
+  short-lived and only used in one place. This means that the cost of
+  kmap() is mostly wasted in such cases. kmap() was not intended for long
+  term mappings but it has morphed in that direction and its use is
+  strongly discouraged in newer code and the set of the preceding functions
+  should be preferred.
+
+* vmap().  This can be used to make a long duration mapping of multiple
+  physical pages into a contiguous virtual space.  It needs global
+  synchronization to unmap.
 
 
 Using kmap_atomic
-- 
2.34.1

