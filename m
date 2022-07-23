Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA7F357F08C
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 19:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233569AbiGWRJP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 13:09:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbiGWRJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 13:09:12 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 870FA1AF3B
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jul 2022 10:09:11 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id j29-20020a05600c1c1d00b003a2fdafdefbso4058389wms.2
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jul 2022 10:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=Y7ZqwMVhk6uhW6xJIvqgyOPbhPMnvmuRvGWiz4Y3kyE=;
        b=cMnIoDG06+wr21BHRR9LmOAUyInY91X/pcfEbWeEU8+HvAxZjYiKfAcDfLMgY700mA
         8teXBw+R2hcylhRD/DvieQ/sPg/YBeezCoIfvWnzAGC3hWJvUGHqH1bEzf4U6OUg9mZh
         PbbPRJ/nRKtxIYu5mVgDwJaH7D1vyw35cG66+3hKrXvH2lPWOi2KZSDD6YD5ykONDMWQ
         IhbhMyN6Soof11F/UCXYrLGcU2V1r14T/jO2vUWDlRXOc28JS5tklAMfXyA025pYbujS
         FleQMeHs7hbWQY4HuNT4kn/yu30c4nBX9HLtfB9o+h1RCm13fdGWr2sc+DSJhgssr3o7
         4EAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=Y7ZqwMVhk6uhW6xJIvqgyOPbhPMnvmuRvGWiz4Y3kyE=;
        b=Uff0lydX0EhxO5aRUFzwI2jCO99zI8IONO188aQS3txbokHFBJv6bq2jlbwN2+naLg
         zqsGs06IyoIk64J1F8o80o+rZz6ITr5PiSKnUPCcB66WUOoOq5zxIs6YRDRVWFkLJZTY
         hp2zkvK3JDWjU+ZzXWkJsVIAjEE4qfVMZTYZAvkQG/f8gatq01fv8N0TTClUd7afw8Q5
         V64dhazdQ22crMdwyiVJ/zoWb8Ko2JkurCH55z0K/HZnq0kVHkjKI31WOFB4B/8VOo7m
         W3/QiW4C3AhEW0B7+IOCisbr7NocNgZMYUVExnZJbdDtP5qx3nsvf7E9m/M0eMFvoivV
         taZw==
X-Gm-Message-State: AJIora+gYuAOzkggk4yz8LqN4Am3kUeBukuELSAJDaSAHXSE1MbvrSow
        kJm2e3xvmyschXqv8++IzMIG+h2FLQ==
X-Google-Smtp-Source: AGRyM1vd3A51S1WgXlYzrZI80Vy8rYxOhMoISNOYC5QfzEbgZH08b88ZgYa7ghIfKOX3VRvEYprhYA==
X-Received: by 2002:a05:600c:1da2:b0:3a3:10ed:43ce with SMTP id p34-20020a05600c1da200b003a310ed43cemr3399539wms.136.1658596149890;
        Sat, 23 Jul 2022 10:09:09 -0700 (PDT)
Received: from localhost.localdomain ([46.53.248.166])
        by smtp.gmail.com with ESMTPSA id u16-20020a05600c00d000b003a31c4f6f74sm14686083wmm.32.2022.07.23.10.09.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Jul 2022 10:09:09 -0700 (PDT)
Date:   Sat, 23 Jul 2022 20:09:07 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] proc: add some (hopefully) insightful comments
Message-ID: <YtwrM6sDC0OQ53YB@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* /proc/${pid}/net status
* removing PDE vs last close stuff (again!)
* random small stuff

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 fs/proc/array.c    |    4 ++++
 fs/proc/inode.c    |   17 ++++++++++++-----
 fs/proc/proc_net.c |    6 ++++++
 fs/proc/root.c     |    5 +++++
 4 files changed, 27 insertions(+), 5 deletions(-)

--- a/fs/proc/array.c
+++ b/fs/proc/array.c
@@ -99,6 +99,10 @@ void proc_task_name(struct seq_file *m, struct task_struct *p, bool escape)
 {
 	char tcomm[64];
 
+	/*
+	 * Test before PF_KTHREAD because all workqueue worker threads are
+	 * kernel threads.
+	 */
 	if (p->flags & PF_WQ_WORKER)
 		wq_worker_comm(tcomm, sizeof(tcomm), p);
 	else if (p->flags & PF_KTHREAD)
--- a/fs/proc/inode.c
+++ b/fs/proc/inode.c
@@ -212,7 +212,15 @@ static void unuse_pde(struct proc_dir_entry *pde)
 		complete(pde->pde_unload_completion);
 }
 
-/* pde is locked on entry, unlocked on exit */
+/*
+ * At most 2 contexts can enter this function: the one doing the last
+ * close on the descriptor and whoever is deleting PDE itself.
+ *
+ * First to enter calls ->proc_release hook and signals its completion
+ * to the second one which waits and then does nothing.
+ *
+ * PDE is locked on entry, unlocked on exit.
+ */
 static void close_pdeo(struct proc_dir_entry *pde, struct pde_opener *pdeo)
 	__releases(&pde->pde_unload_lock)
 {
@@ -222,9 +230,6 @@ static void close_pdeo(struct proc_dir_entry *pde, struct pde_opener *pdeo)
 	 *
 	 * rmmod (remove_proc_entry() et al) can't delete an entry and proceed:
 	 * "struct file" needs to be available at the right moment.
-	 *
-	 * Therefore, first process to enter this function does ->release() and
-	 * signals its completion to the other process which does nothing.
 	 */
 	if (pdeo->closing) {
 		/* somebody else is doing that, just wait */
@@ -238,10 +243,12 @@ static void close_pdeo(struct proc_dir_entry *pde, struct pde_opener *pdeo)
 
 		pdeo->closing = true;
 		spin_unlock(&pde->pde_unload_lock);
+
 		file = pdeo->file;
 		pde->proc_ops->proc_release(file_inode(file), file);
+
 		spin_lock(&pde->pde_unload_lock);
-		/* After ->release. */
+		/* Strictly after ->proc_release, see above. */
 		list_del(&pdeo->lh);
 		c = pdeo->c;
 		spin_unlock(&pde->pde_unload_lock);
--- a/fs/proc/proc_net.c
+++ b/fs/proc/proc_net.c
@@ -350,6 +350,12 @@ static __net_init int proc_net_ns_init(struct net *net)
 	kgid_t gid;
 	int err;
 
+	/*
+	 * This PDE acts only as an anchor for /proc/${pid}/net hierarchy.
+	 * Corresponding inode (PDE(inode) == net->proc_net) is never
+	 * instantiated therefore blanket zeroing is fine.
+	 * net->proc_net_stat inode is instantiated normally.
+	 */
 	err = -ENOMEM;
 	netd = kmem_cache_zalloc(proc_dir_entry_cache, GFP_KERNEL);
 	if (!netd)
--- a/fs/proc/root.c
+++ b/fs/proc/root.c
@@ -302,6 +302,11 @@ void __init proc_root_init(void)
 	proc_mkdir("bus", NULL);
 	proc_sys_init();
 
+	/*
+	 * Last things last. It is not like userspace processes eager
+	 * to open /proc files exist at this point but register last
+	 * anyway.
+	 */
 	register_filesystem(&proc_fs_type);
 }
 
