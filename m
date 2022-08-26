Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38A2E5A2570
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 12:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244973AbiHZKG6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 06:06:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbiHZKGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 06:06:33 -0400
Received: from smtpout140.security-mail.net (smtpout140.security-mail.net [85.31.212.148])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70432C5795
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 03:05:11 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by fx408.security-mail.net (Postfix) with ESMTP id BEF6C1B7B253
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 11:59:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalray.eu;
        s=sec-sig-email; t=1661507948;
        bh=vr4cwxCfoWqejiHD6pQ9HxA413Tn6PkujH2uBT6h5Og=;
        h=From:To:Cc:Subject:Date;
        b=2t7R5pzCxt3rCZOsb0JtJB++PS9qt+DDhfsqBA2TaICtkpno+BofifFwQBYg775n/
         p9Yfn200DfZXmGkP1OKx15tPCo/TqAaH3eFEhYiQS/OLQVgmvmH1Jt+MUUJzfWyPtd
         FZrEUOlFjh3tCGy9CzeuXvH7EnpqSS86SxnK9Gs8=
Received: from fx408 (localhost [127.0.0.1])
        by fx408.security-mail.net (Postfix) with ESMTP id 6D8BC1B7B2CB;
        Fri, 26 Aug 2022 11:59:08 +0200 (CEST)
X-Virus-Scanned: E-securemail
Secumail-id: <b9e4.6308996b.b4e15.0>
Received: from zimbra2.kalray.eu (unknown [217.181.231.53])
        by fx408.security-mail.net (Postfix) with ESMTPS id E69D91B7B20A;
        Fri, 26 Aug 2022 11:59:07 +0200 (CEST)
Received: from zimbra2.kalray.eu (localhost [127.0.0.1])
        by zimbra2.kalray.eu (Postfix) with ESMTPS id 9A86227E0396;
        Fri, 26 Aug 2022 11:59:07 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra2.kalray.eu (Postfix) with ESMTP id 81FC327E0392;
        Fri, 26 Aug 2022 11:59:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra2.kalray.eu 81FC327E0392
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalray.eu;
        s=32AE1B44-9502-11E5-BA35-3734643DEF29; t=1661507947;
        bh=F197CH4uD1oBPgpHmr8mAOcTlfh38jb9bV8sTFUab+c=;
        h=From:To:Date:Message-Id;
        b=XHVp0saWOK1pCEV0Jm6iekB/2+WhWD32Kls4i3iGz0fqN95zlbbTNZvuv0nD/eQE9
         m1tDmi/c2AH76xHuYVDFTrKDYdxtnKz1cT0p0qBPP1VahjSkUaSn5XgsZltJFBjOuV
         gtf1cvxnwALosx9bELoSpmpooTusP7bB0KdSw6Qo=
Received: from zimbra2.kalray.eu ([127.0.0.1])
        by localhost (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id tcfx7MeVfYmr; Fri, 26 Aug 2022 11:59:07 +0200 (CEST)
Received: from tellis.lin.mbt.kalray.eu (unknown [192.168.36.206])
        by zimbra2.kalray.eu (Postfix) with ESMTPSA id 69C5927E02FA;
        Fri, 26 Aug 2022 11:59:07 +0200 (CEST)
From:   Jules Maselbas <jmaselbas@kalray.eu>
To:     linux-kernel@vger.kernel.org
Cc:     Jules Maselbas <jmaselbas@kalray.eu>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: [PATCH] Documentation: Fix repeated words in documentation
Date:   Fri, 26 Aug 2022 11:52:58 +0200
Message-Id: <20220826095321.21548-1-jmaselbas@kalray.eu>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: by Secumail
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove redundant word `the`.

CC: Jonathan Corbet <corbet@lwn.net>
CC: linux-doc@vger.kernel.org
Signed-off-by: Jules Maselbas <jmaselbas@kalray.eu>
---
 Documentation/admin-guide/kdump/vmcoreinfo.rst    | 2 +-
 Documentation/bpf/map_cgroup_storage.rst          | 4 ++--
 Documentation/core-api/cpu_hotplug.rst            | 2 +-
 Documentation/driver-api/isa.rst                  | 2 +-
 Documentation/filesystems/caching/backend-api.rst | 2 +-
 Documentation/locking/seqlock.rst                 | 2 +-
 Documentation/sphinx/cdomain.py                   | 2 +-
 7 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/admin-guide/kdump/vmcoreinfo.rst b/Documentation/admin-guide/kdump/vmcoreinfo.rst
index 8419019b6a88..6726f439958c 100644
--- a/Documentation/admin-guide/kdump/vmcoreinfo.rst
+++ b/Documentation/admin-guide/kdump/vmcoreinfo.rst
@@ -200,7 +200,7 @@ prb
 
 A pointer to the printk ringbuffer (struct printk_ringbuffer). This
 may be pointing to the static boot ringbuffer or the dynamically
-allocated ringbuffer, depending on when the the core dump occurred.
+allocated ringbuffer, depending on when the core dump occurred.
 Used by user-space tools to read the active kernel log buffer.
 
 printk_rb_static
diff --git a/Documentation/bpf/map_cgroup_storage.rst b/Documentation/bpf/map_cgroup_storage.rst
index cab9543017bf..8e5fe532c07e 100644
--- a/Documentation/bpf/map_cgroup_storage.rst
+++ b/Documentation/bpf/map_cgroup_storage.rst
@@ -31,7 +31,7 @@ The map uses key of type of either ``__u64 cgroup_inode_id`` or
     };
 
 ``cgroup_inode_id`` is the inode id of the cgroup directory.
-``attach_type`` is the the program's attach type.
+``attach_type`` is the program's attach type.
 
 Linux 5.9 added support for type ``__u64 cgroup_inode_id`` as the key type.
 When this key type is used, then all attach types of the particular cgroup and
@@ -155,7 +155,7 @@ However, the BPF program can still only associate with one map of each type
 ``BPF_MAP_TYPE_CGROUP_STORAGE`` or more than one
 ``BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE``.
 
-In all versions, userspace may use the the attach parameters of cgroup and
+In all versions, userspace may use the attach parameters of cgroup and
 attach type pair in ``struct bpf_cgroup_storage_key`` as the key to the BPF map
 APIs to read or update the storage for a given attachment. For Linux 5.9
 attach type shared storages, only the first value in the struct, cgroup inode
diff --git a/Documentation/core-api/cpu_hotplug.rst b/Documentation/core-api/cpu_hotplug.rst
index c6f4ba2fb32d..f75778d37488 100644
--- a/Documentation/core-api/cpu_hotplug.rst
+++ b/Documentation/core-api/cpu_hotplug.rst
@@ -560,7 +560,7 @@ available:
   * cpuhp_state_remove_instance(state, node)
   * cpuhp_state_remove_instance_nocalls(state, node)
 
-The arguments are the same as for the the cpuhp_state_add_instance*()
+The arguments are the same as for the cpuhp_state_add_instance*()
 variants above.
 
 The functions differ in the way how the installed callbacks are treated:
diff --git a/Documentation/driver-api/isa.rst b/Documentation/driver-api/isa.rst
index def4a7b690b5..3df1b1696524 100644
--- a/Documentation/driver-api/isa.rst
+++ b/Documentation/driver-api/isa.rst
@@ -100,7 +100,7 @@ I believe platform_data is available for this, but if rather not, moving
 the isa_driver pointer to the private struct isa_dev is ofcourse fine as
 well.
 
-Then, if the the driver did not provide a .match, it matches. If it did,
+Then, if the driver did not provide a .match, it matches. If it did,
 the driver match() method is called to determine a match.
 
 If it did **not** match, dev->platform_data is reset to indicate this to
diff --git a/Documentation/filesystems/caching/backend-api.rst b/Documentation/filesystems/caching/backend-api.rst
index d7507becf674..3a199fc50828 100644
--- a/Documentation/filesystems/caching/backend-api.rst
+++ b/Documentation/filesystems/caching/backend-api.rst
@@ -122,7 +122,7 @@ volumes, calling::
 to tell fscache that a volume has been withdrawn.  This waits for all
 outstanding accesses on the volume to complete before returning.
 
-When the the cache is completely withdrawn, fscache should be notified by
+When the cache is completely withdrawn, fscache should be notified by
 calling::
 
 	void fscache_relinquish_cache(struct fscache_cache *cache);
diff --git a/Documentation/locking/seqlock.rst b/Documentation/locking/seqlock.rst
index 64405e5da63e..bfda1a5fecad 100644
--- a/Documentation/locking/seqlock.rst
+++ b/Documentation/locking/seqlock.rst
@@ -39,7 +39,7 @@ as the writer can invalidate a pointer that the reader is following.
 Sequence counters (``seqcount_t``)
 ==================================
 
-This is the the raw counting mechanism, which does not protect against
+This is the raw counting mechanism, which does not protect against
 multiple writers.  Write side critical sections must thus be serialized
 by an external lock.
 
diff --git a/Documentation/sphinx/cdomain.py b/Documentation/sphinx/cdomain.py
index ca8ac9e59ded..a7d1866e72ff 100644
--- a/Documentation/sphinx/cdomain.py
+++ b/Documentation/sphinx/cdomain.py
@@ -151,7 +151,7 @@ class CObject(Base_CObject):
     def handle_func_like_macro(self, sig, signode):
         u"""Handles signatures of function-like macros.
 
-        If the objtype is 'function' and the the signature ``sig`` is a
+        If the objtype is 'function' and the signature ``sig`` is a
         function-like macro, the name of the macro is returned. Otherwise
         ``False`` is returned.  """
 
-- 
2.17.1

