Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C1B55A4367
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 08:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbiH2GxL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 02:53:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiH2GxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 02:53:09 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E21541D30;
        Sun, 28 Aug 2022 23:53:08 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id f4so6868235pgc.12;
        Sun, 28 Aug 2022 23:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc;
        bh=NIKx4BlW3poTb1c1nuidDiosjytUPN6DWa0m2PltNEo=;
        b=QhfKP+iwo5KUARlBf7/r/Nh9jGn/1pOCGSMl1i6kY9F03IYxF1BOHQojLWStKplsx8
         lwT1q62fDRSrsLoxsKpVHHQ067165VLgCNESmAumZh52aWUpkNWL6kq1F5p3XFEUG9pd
         p9uk1ix8Gyi7gxynHeEdkaVLqqBLUE7Yt/uWWOJz+BXCj+tz5TBnqmrtJpuhHWgnIeZ0
         BZDp0owBN/5bnfukACZ+4z+CWzAROUDwmUOU8HsZHn11PZg5PVC6KAci0zAylin69WWR
         4qbSmZ0MQrjwbNucHeGZQOEHVHpWkQUfZPclYcNKGOEpzloZAV5LUH/F3OBsoYL2HV8l
         7qsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=NIKx4BlW3poTb1c1nuidDiosjytUPN6DWa0m2PltNEo=;
        b=xcGPyKUWiO637prqkZeBAAHU+uEHd91QdM6T/UR1ryBY1yHfS1EO3yi1f/uaLQ1lda
         kHSPFFL2tDywLe3uemOq6V0pt2x7syU2l1DvvI1sYNWZ+vrG7d7BJG5fv403yZJRRSJw
         X+uUO2S5QyKLZREwm27dWoq7ThxCVyEk5nP40tKLTgp0kft7coz3tcvPL43DKfpn7A4D
         /i72gLLj/XYcVRiD9ter2S9u675DE7OEVWhc4yvoJh2TcmrC8ctQb4B/J5SeK9jcspf7
         dH229YmquInjK3Uh8CryGgT92VQfOqcmcQnsuJU6SRzmfyfcvsulquO8i4fv2tSCwz46
         Sd8w==
X-Gm-Message-State: ACgBeo0NUK8DnKarEP8zb6ToVdeXcT0HUbZi5XKcUk6lI/s7mcC3h+0L
        OCw7I59zgaHTUEHo+fc0qCSkkxdVfqspVA==
X-Google-Smtp-Source: AA6agR5wz6yGGgQirk7c7Z3zvxorsOjoG00036mXjmBX/bKFHcDaf6ZZnVkpmoWmaquIEax6whalAw==
X-Received: by 2002:a65:6bc4:0:b0:3c2:2f7c:cc74 with SMTP id e4-20020a656bc4000000b003c22f7ccc74mr12625103pgw.307.1661755988083;
        Sun, 28 Aug 2022 23:53:08 -0700 (PDT)
Received: from localhost.localdomain ([103.151.209.218])
        by smtp.gmail.com with ESMTPSA id z15-20020a170902cccf00b0016c0eb202a5sm6574242ple.225.2022.08.28.23.53.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Aug 2022 23:53:07 -0700 (PDT)
From:   Akhil Raj <lf32.dev@gmail.com>
To:     corbet@lwn.net, skhan@linuxfoundation.org
Cc:     Akhil Raj <lf32.dev@gmail.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Delete duplicate words from kernel docs
Date:   Mon, 29 Aug 2022 12:22:39 +0530
Message-Id: <20220829065239.4531-1-lf32.dev@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I have deleted duplicate words like

to, guest, trace, when, we

Signed-off-by: Akhil Raj <lf32.dev@gmail.com>
---
 Documentation/RCU/checklist.rst         | 2 +-
 Documentation/RCU/lockdep.rst           | 2 +-
 Documentation/bpf/instruction-set.rst   | 2 +-
 Documentation/trace/histogram.rst       | 2 +-
 Documentation/trace/timerlat-tracer.rst | 2 +-
 Documentation/virt/kvm/x86/mmu.rst      | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/RCU/checklist.rst b/Documentation/RCU/checklist.rst
index 42cc5d891bd2..7b1c85a16dc3 100644
--- a/Documentation/RCU/checklist.rst
+++ b/Documentation/RCU/checklist.rst
@@ -477,6 +477,6 @@ over a rather long period of time, but improvements are always welcome!
 	So if you need to wait for both an RCU grace period and for
 	all pre-existing call_rcu() callbacks, you will need to execute
 	both rcu_barrier() and synchronize_rcu(), if necessary, using
-	something like workqueues to to execute them concurrently.
+	something like workqueues to execute them concurrently.
 
 	See rcubarrier.rst for more information.
diff --git a/Documentation/RCU/lockdep.rst b/Documentation/RCU/lockdep.rst
index cc860a0c296b..a94f55991a71 100644
--- a/Documentation/RCU/lockdep.rst
+++ b/Documentation/RCU/lockdep.rst
@@ -61,7 +61,7 @@ checking of rcu_dereference() primitives:
 	rcu_access_pointer(p):
 		Return the value of the pointer and omit all barriers,
 		but retain the compiler constraints that prevent duplicating
-		or coalescsing.  This is useful when when testing the
+		or coalescsing.  This is useful when testing the
 		value of the pointer itself, for example, against NULL.
 
 The rcu_dereference_check() check expression can be any boolean
diff --git a/Documentation/bpf/instruction-set.rst b/Documentation/bpf/instruction-set.rst
index 1b0e6711dec9..0ac7ae40be37 100644
--- a/Documentation/bpf/instruction-set.rst
+++ b/Documentation/bpf/instruction-set.rst
@@ -133,7 +133,7 @@ code field of ``BPF_END``.
 The byte swap instructions operate on the destination register
 only and do not use a separate source register or immediate value.
 
-The 1-bit source operand field in the opcode is used to to select what byte
+The 1-bit source operand field in the opcode is used to select what byte
 order the operation convert from or to:
 
   =========  =====  =================================================
diff --git a/Documentation/trace/histogram.rst b/Documentation/trace/histogram.rst
index 859fd1b76c63..c1b685a38f6b 100644
--- a/Documentation/trace/histogram.rst
+++ b/Documentation/trace/histogram.rst
@@ -412,7 +412,7 @@ Extended error information
   Because the default sort key above is 'hitcount', the above shows a
   the list of call_sites by increasing hitcount, so that at the bottom
   we see the functions that made the most kmalloc calls during the
-  run.  If instead we we wanted to see the top kmalloc callers in
+  run.  If instead we wanted to see the top kmalloc callers in
   terms of the number of bytes requested rather than the number of
   calls, and we wanted the top caller to appear at the top, we can use
   the 'sort' parameter, along with the 'descending' modifier::
diff --git a/Documentation/trace/timerlat-tracer.rst b/Documentation/trace/timerlat-tracer.rst
index d643c95c01eb..db17df312bc8 100644
--- a/Documentation/trace/timerlat-tracer.rst
+++ b/Documentation/trace/timerlat-tracer.rst
@@ -20,7 +20,7 @@ For example::
         [root@f32 ~]# cd /sys/kernel/tracing/
         [root@f32 tracing]# echo timerlat > current_tracer
 
-It is possible to follow the trace by reading the trace trace file::
+It is possible to follow the trace by reading the trace file::
 
   [root@f32 tracing]# cat trace
   # tracer: timerlat
diff --git a/Documentation/virt/kvm/x86/mmu.rst b/Documentation/virt/kvm/x86/mmu.rst
index 8739120f4300..8364afa228ec 100644
--- a/Documentation/virt/kvm/x86/mmu.rst
+++ b/Documentation/virt/kvm/x86/mmu.rst
@@ -377,7 +377,7 @@ Emulating cr0.wp
 ================
 
 If tdp is not enabled, the host must keep cr0.wp=1 so page write protection
-works for the guest kernel, not guest guest userspace.  When the guest
+works for the guest kernel, not guest userspace.  When the guest
 cr0.wp=1, this does not present a problem.  However when the guest cr0.wp=0,
 we cannot map the permissions for gpte.u=1, gpte.w=0 to any spte (the
 semantics require allowing any guest kernel access plus user read access).
-- 
2.17.1

