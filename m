Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FC7F5A3834
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 16:54:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232724AbiH0OyZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Aug 2022 10:54:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbiH0OyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Aug 2022 10:54:22 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C64823148;
        Sat, 27 Aug 2022 07:54:21 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id x26so4226452pfo.8;
        Sat, 27 Aug 2022 07:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc;
        bh=mTg6igDbv2x2nhOY72675weNCEeFIiVAx94G86DkrY4=;
        b=BZtLxq5oKbaMB+K8rQ7cur4RAXqDMrrK/ymvF7kCgrzcJcGpliDM0vvwh0jITbTLvv
         8hR0dK4sEgCUBKUvzX1gDmycnRiG/Lk/jGsm+F7G9WRcgURWQwD8AGKmKoxGwDP597k/
         /OheIqMGeBgDZ2pwYaaLj8aIzU+z+Edm6NgiDMlqB9C/v52wmQ6haSsiI0IFrUflWxW5
         ApISflfg6ohCpdl8/ULHC5zp+F55FgMvnqCFg4LRF2KeXqZ+XD6HD9zKv3CQmqDn7GCc
         Fl3cNds/nqVSHYk1Kdb8A43q+4/PxgYIbs1qY6cJoL5qmpe0Vl7ncqePhpdERx+/8vEW
         dQeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=mTg6igDbv2x2nhOY72675weNCEeFIiVAx94G86DkrY4=;
        b=UfsABzTHVMtP4tbf9hP50wT3j2fj/iYJUoJjufqKIcOQNwoqyDhtpX5kCRUDzNmW0G
         22J7I+qTcG8jX3zCtCF61c8fted6QNaY/eZK5KqniQ3IRYmHCzRyGXoo8b9w0/PEI8HT
         Qbw6IDIogip1/c+6mwpHhdk8vmvyEuppLjBKNV3YtcoJeaqkZo76gc4qY6LlB8bSGcda
         CokPoD0S9Wk1PMf8HIWqWjcXzqTKtYoNFzwf7NyHENWiVmuXWbec+wcsSmIlZ7fFleSW
         YEWUQHHasFcvYA56PNi9SogR0vkPw0QlHnziNtZKJLY7ykiIWxqXwQqr/DrWPjnB7lpU
         XtiQ==
X-Gm-Message-State: ACgBeo0p2MTSjsfplwff1WvVd+ATE0H7yM9UcrvXKtZCYUlQ2nO89+U4
        rd4lEjYTU4LCzd67LQagSG8=
X-Google-Smtp-Source: AA6agR6JOtuJOZf++Tc0vYHRY8++88ZwrNZSgMiFzy1Hb6UnMQTTusFJsuquMQy1QNcqVkCfLEqk9g==
X-Received: by 2002:a05:6a00:ac4:b0:535:c08:2da7 with SMTP id c4-20020a056a000ac400b005350c082da7mr8810382pfl.69.1661612060972;
        Sat, 27 Aug 2022 07:54:20 -0700 (PDT)
Received: from localhost.localdomain ([103.151.209.218])
        by smtp.gmail.com with ESMTPSA id n16-20020a170902d2d000b0016c29dcf1f7sm3815720plc.122.2022.08.27.07.54.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Aug 2022 07:54:20 -0700 (PDT)
From:   Akhil Raj <lf32.dev@gmail.com>
To:     Shuah Khan <skhan@linuxfoundation.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net
Cc:     Akhil Raj <lf32.dev@gmail.com>
Subject: [PATCH] Remove duplicate words inside documentation
Date:   Sat, 27 Aug 2022 20:23:59 +0530
Message-Id: <20220827145359.32599-1-lf32.dev@gmail.com>
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

I have removed repeated `the` inside the documentation

Signed-off-by: Akhil Raj <lf32.dev@gmail.com>
---
 Documentation/admin-guide/kdump/vmcoreinfo.rst    | 2 +-
 Documentation/bpf/map_cgroup_storage.rst          | 4 ++--
 Documentation/core-api/cpu_hotplug.rst            | 2 +-
 Documentation/driver-api/isa.rst                  | 2 +-
 Documentation/filesystems/caching/backend-api.rst | 2 +-
 Documentation/locking/seqlock.rst                 | 2 +-
 6 files changed, 7 insertions(+), 7 deletions(-)

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
 
-- 
2.17.1

