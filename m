Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ACF1598091
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 11:11:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243886AbiHRJKx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 05:10:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236969AbiHRJKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 05:10:50 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93289B0B14
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 02:10:48 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id z25so1351308lfr.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 02:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz-org.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc;
        bh=kY0MMevg40jim6mAL9TDwvOzR5lSB6bqOjTnccKKtxg=;
        b=zOppZpCO2j6y6MCNiWAOq9c+lKr6BRYOJSK4LFSz4GCzTcXo+eaPfQqP/OtzJzotUr
         MRQdS9YH+Hd1kxK0YFJMs3zUl1SSyBTllhrzjwi6j5X+z0gcnl+vPOl+5fYkeQYqfpV9
         3W42BXA+ZLX7qDjA4Z2Y1IK5QEuQRQBzb5cmfNOC/I0mTnXSqq5cXXly84EQWvVyHiqe
         JlhzRl5wtwJTI5/JvhcHfdR3ZL1cpZguIZHCnu0W0Kyt6zcIbtAU9Gda99SN3mfeX+Fq
         akR5g96/OWhsT+mgZ+rn5Iq6rYTPRH4x1xJ+ReSqWFVIjEM2wAMxk5kNQ+u4/xv82Z9G
         a6hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=kY0MMevg40jim6mAL9TDwvOzR5lSB6bqOjTnccKKtxg=;
        b=XD/iFLGqzslCOMk55Ly7VEi0pZILvUl9dIU2l+XKkFtnz/EB4X9sZvLRKvBSMR6RvG
         Z+M3ae5agwbquSFHj5KMY1H40PGmqUKBC7BIUgpDhSdEs3k6UTICaJ9En1q7pP4pADv4
         Kj4097LL7RrYrwHkBaYDqc2VKmLTB0YE5jbm/WlBySjyf0yM/X+hhIlmYW1o08mU76sX
         ybUAeJS8k2oUCzVXPBbFQo9dancTieKg5288RHJzGepEc5N3ePLUb6qWbZd5ROuNM1FO
         fTv6KrAkOD7eg2Q+cCOX8Uji9mBQecAqLHDGGygxP1nReFwDfpkFEEPjHqdKw0VoQXAC
         WXpQ==
X-Gm-Message-State: ACgBeo3tmnQ760QRs248iY6VNJLR/KfxXXmMgk+U/4EY8Lw0eKt54zg5
        oCB0AmULfYLGm+iYXq6kXfYSIzXN4aun4w==
X-Google-Smtp-Source: AA6agR4P+EXG7C9RxTL+4JeR8q6biSKTwCART0mW/4IGRfq6suMaZ9ZdnZGQ9fJSl1RyK9jeDZwbug==
X-Received: by 2002:a19:9101:0:b0:48a:f4ad:758d with SMTP id t1-20020a199101000000b0048af4ad758dmr636632lfd.181.1660813846929;
        Thu, 18 Aug 2022 02:10:46 -0700 (PDT)
Received: from [192.168.1.65] ([46.188.121.143])
        by smtp.gmail.com with ESMTPSA id a23-20020ac25e77000000b0048b97c7260csm144530lfr.222.2022.08.18.02.10.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Aug 2022 02:10:46 -0700 (PDT)
Message-ID: <f58bd7c8-0053-316c-db06-ced13ffcf867@openvz.org>
Date:   Thu, 18 Aug 2022 12:10:45 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
From:   Vasily Averin <vvs@openvz.org>
Subject: [RFC PATCH] memcg: adjust memcg used to charge for new simple_xattrs
 objects
To:     Roman Gushchin <roman.gushchin@linux.dev>, mkoutny@suse.com,
        tj@kernel.org
Cc:     gregkh@linuxfoundation.org, hannes@cmpxchg.org, kernel@openvz.org,
        linux-kernel@vger.kernel.org, mhocko@suse.com, shakeelb@google.com,
        songmuchun@bytedance.com, viro@zeniv.linux.org.uk,
        Christian Brauner <brauner@kernel.org>
References: <62188f37-f816-08e9-cdd5-8df23131746d@openvz.org>
Content-Language: en-US
In-Reply-To: <62188f37-f816-08e9-cdd5-8df23131746d@openvz.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch was announced here:
https://lore.kernel.org/all/62188f37-f816-08e9-cdd5-8df23131746d@openvz.org/
"3) adjust active memcg for simple_xattr accounting
  sysfs and tmpfs are in-memory file system, 
  for extended attributes they uses simple_xattr infrastructure.
  The patch forces sys_set[f]xattr calls to account xattr object
  to predictable memcg: for kernfs memcg will be taken from kernfs node,
  for shmem -- from shmem_info.
  Like 1) case, this allows to understand which memcg should be used
  for object accounting and simplify debugging of possible troubles."

It was compiled but was not tested yet.
---
sys_set[f]xattr uses simple_xattr infrastructure to create a new
extended attribute for in-memory file systems like sysfs and tmpfs.
Number and size of allocated objects are controlled by user space,
they are always living in memory and its lifetime is indefinitely long.
Therefore this memory should be properly accounted.

By default new memory is accounted to memcg of creator process.
As a result, neighboring xattrs of the same inode can be charged to
different memcgs. This looks unexpected and makes hard the
investigation of the memcg accounting issues.

This patch adjust memcg used for such allocations. For kernfs
it gives memcg from kernfs node, for shmem -- from shmem_info.
This allows to cahrge all inode-sepcific objects to the same
memory cgroup.

Signed-off-by: Vasily Averin <vvs@openvz.org>
---
 fs/kernfs/inode.c | 31 ++++++++++++++++++++++++-------
 mm/shmem.c        | 10 +++++++++-
 2 files changed, 33 insertions(+), 8 deletions(-)

diff --git a/fs/kernfs/inode.c b/fs/kernfs/inode.c
index 3d783d80f5da..975532b32e7c 100644
--- a/fs/kernfs/inode.c
+++ b/fs/kernfs/inode.c
@@ -14,6 +14,7 @@
 #include <linux/slab.h>
 #include <linux/xattr.h>
 #include <linux/security.h>
+#include <linux/memcontrol.h>
 
 #include "kernfs-internal.h"
 
@@ -335,8 +336,16 @@ static int kernfs_vfs_xattr_set(const struct xattr_handler *handler,
 {
 	const char *name = xattr_full_name(handler, suffix);
 	struct kernfs_node *kn = inode->i_private;
+	struct mem_cgroup *old, *memcg;
+	int ret;
+
+	memcg = mem_cgroup_or_root(get_mem_cgroup_from_obj(kn));
+	old = set_active_memcg(memcg);
 
-	return kernfs_xattr_set(kn, name, value, size, flags);
+	ret = kernfs_xattr_set(kn, name, value, size, flags);
+	set_active_memcg(old);
+	mem_cgroup_put(memcg);
+	return ret;
 }
 
 static int kernfs_vfs_user_xattr_add(struct kernfs_node *kn,
@@ -403,21 +412,29 @@ static int kernfs_vfs_user_xattr_set(const struct xattr_handler *handler,
 	const char *full_name = xattr_full_name(handler, suffix);
 	struct kernfs_node *kn = inode->i_private;
 	struct kernfs_iattrs *attrs;
+	struct mem_cgroup *old, *memcg;
+	int ret = -ENOMEM;
 
 	if (!(kernfs_root(kn)->flags & KERNFS_ROOT_SUPPORT_USER_XATTR))
 		return -EOPNOTSUPP;
 
+	memcg = mem_cgroup_or_root(get_mem_cgroup_from_obj(kn));
+	old = set_active_memcg(memcg);
+
 	attrs = kernfs_iattrs(kn);
 	if (!attrs)
-		return -ENOMEM;
+		goto out;
 
 	if (value)
-		return kernfs_vfs_user_xattr_add(kn, full_name, &attrs->xattrs,
-						 value, size, flags);
-	else
-		return kernfs_vfs_user_xattr_rm(kn, full_name, &attrs->xattrs,
+		ret = kernfs_vfs_user_xattr_add(kn, full_name, &attrs->xattrs,
 						value, size, flags);
-
+	else
+		ret = kernfs_vfs_user_xattr_rm(kn, full_name, &attrs->xattrs,
+					       value, size, flags);
+out:
+	set_active_memcg(old);
+	mem_cgroup_put(memcg);
+	return ret;
 }
 
 static const struct xattr_handler kernfs_trusted_xattr_handler = {
diff --git a/mm/shmem.c b/mm/shmem.c
index 5783f11351bb..291c15774340 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -3255,9 +3255,17 @@ static int shmem_xattr_handler_set(const struct xattr_handler *handler,
 				   size_t size, int flags)
 {
 	struct shmem_inode_info *info = SHMEM_I(inode);
+	struct mem_cgroup *old, *memcg;
+	int ret;
+
+	memcg = mem_cgroup_or_root(get_mem_cgroup_from_obj(info));
+	old = set_active_memcg(memcg);
 
 	name = xattr_full_name(handler, name);
-	return simple_xattr_set(&info->xattrs, name, value, size, flags, NULL);
+	ret = simple_xattr_set(&info->xattrs, name, value, size, flags, NULL);
+	set_active_memcg(old);
+	mem_cgroup_put(memcg);
+	return ret;
 }
 
 static const struct xattr_handler shmem_security_xattr_handler = {
-- 
2.34.1

