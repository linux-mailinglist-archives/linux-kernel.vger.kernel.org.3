Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 621D14D6A95
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 00:26:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbiCKWrz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 17:47:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbiCKWrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 17:47:37 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A905298F33;
        Fri, 11 Mar 2022 14:22:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A3A00B82D7E;
        Fri, 11 Mar 2022 21:46:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A1EAC340E9;
        Fri, 11 Mar 2022 21:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647035186;
        bh=iXp2TGfLwLiTBFPs1pvk41RMObc7ZpenPk6oFMs3zGo=;
        h=Subject:From:To:Date:From;
        b=KyPuszPcw09aw7u5sDlCpBl3H7Su2CmudLK+mrTbuYPUXf11fpQFjTRN7iVlf3oN+
         0TlC9FvN8kK9TC1yd2rF5hC7/NYn/gcED6bkBO60bEDjRFAbwyXT2wCvN0aeSVkXRk
         PqpAysjHEx6qyly6XaFatX+CiWzEXiZe31PsXHLu/bHWU6vz4GpK6XrxVVNRRQPDik
         uljSF5Ob+4a8Xv3hmnsiytjR9gXBPIZEIU5+uEcB4pjO69po5PXlNaHayFs4pYs+7P
         pI0q1krEQWTc94D0U8FzBrRSeoeSyqm4sqjEmbO7WUqwvNYjuLafxYmyX2RHH/WllK
         KquAhIuKakmEA==
Message-ID: <0af02f70d3a0b3653bb3079266878f13e6682a69.camel@kernel.org>
Subject: [ANNOUNCE] 5.4.182-rt71
From:   Tom Zanussi <zanussi@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <wagi@monom.org>,
        Clark Williams <williams@redhat.com>,
        "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
        Tom Zanussi <zanussi@kernel.org>
Date:   Fri, 11 Mar 2022 15:46:23 -0600
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello RT Folks!

I'm pleased to announce the 5.4.182-rt71 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.4-rt
  Head SHA1: 8f83fc7941f704f55939adaa778afd8ae76662e4

Or to build 5.4.182-rt71 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.4.tar.xz

  https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.4.182.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.4/patch-5.4.182-rt71.patch.xz


You can also build from 5.4.182-rt70 by applying the incremental patch:

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.4/incr/patch-5.4.182-rt70-rt71.patch.xz

Enjoy!

   Tom

Changes from v5.4.182-rt70:
---

Thomas Gleixner (1):
      eventfd: Make signal recursion protection a task bit

Tom Zanussi (1):
      Linux 5.4.182-rt71

Xie Yongji (1):
      aio: Fix incorrect usage of eventfd_signal_allowed()
---
fs/aio.c                |  2 +-
 fs/eventfd.c            | 12 +++++-------
 include/linux/eventfd.h | 11 +++++------
 include/linux/sched.h   | 12 ++++++++++++
 localversion-rt         |  2 +-
 5 files changed, 24 insertions(+), 15 deletions(-)
---
diff --git a/fs/aio.c b/fs/aio.c
index fb92c32a6f1e..0bb9abf39065 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -1767,7 +1767,7 @@ static int aio_poll_wake(struct wait_queue_entry *wait, unsigned mode, int sync,
 		list_del_init(&req->wait.entry);
 		list_del(&iocb->ki_list);
 		iocb->ki_res.res = mangle_poll(mask);
-		if (iocb->ki_eventfd && eventfd_signal_count()) {
+		if (iocb->ki_eventfd && !eventfd_signal_allowed()) {
 			iocb = NULL;
 			INIT_WORK(&req->work, aio_poll_put_work);
 			schedule_work(&req->work);
diff --git a/fs/eventfd.c b/fs/eventfd.c
index 78e41c7c3d05..661ccc45852b 100644
--- a/fs/eventfd.c
+++ b/fs/eventfd.c
@@ -24,8 +24,6 @@
 #include <linux/seq_file.h>
 #include <linux/idr.h>
 
-DEFINE_PER_CPU(int, eventfd_wake_count);
-
 static DEFINE_IDA(eventfd_ida);
 
 struct eventfd_ctx {
@@ -66,21 +64,21 @@ __u64 eventfd_signal(struct eventfd_ctx *ctx, __u64 n)
 	 * Deadlock or stack overflow issues can happen if we recurse here
 	 * through waitqueue wakeup handlers. If the caller users potentially
 	 * nested waitqueues with custom wakeup handlers, then it should
-	 * check eventfd_signal_count() before calling this function. If
-	 * it returns true, the eventfd_signal() call should be deferred to a
+	 * check eventfd_signal_allowed() before calling this function. If
+	 * it returns false, the eventfd_signal() call should be deferred to a
 	 * safe context.
 	 */
-	if (WARN_ON_ONCE(this_cpu_read(eventfd_wake_count)))
+	if (WARN_ON_ONCE(current->in_eventfd_signal))
 		return 0;
 
 	spin_lock_irqsave(&ctx->wqh.lock, flags);
-	this_cpu_inc(eventfd_wake_count);
+	current->in_eventfd_signal = 1;
 	if (ULLONG_MAX - ctx->count < n)
 		n = ULLONG_MAX - ctx->count;
 	ctx->count += n;
 	if (waitqueue_active(&ctx->wqh))
 		wake_up_locked_poll(&ctx->wqh, EPOLLIN);
-	this_cpu_dec(eventfd_wake_count);
+	current->in_eventfd_signal = 0;
 	spin_unlock_irqrestore(&ctx->wqh.lock, flags);
 
 	return n;
diff --git a/include/linux/eventfd.h b/include/linux/eventfd.h
index dc4fd8a6644d..836b4c021a0a 100644
--- a/include/linux/eventfd.h
+++ b/include/linux/eventfd.h
@@ -14,6 +14,7 @@
 #include <linux/err.h>
 #include <linux/percpu-defs.h>
 #include <linux/percpu.h>
+#include <linux/sched.h>
 
 /*
  * CAREFUL: Check include/uapi/asm-generic/fcntl.h when defining
@@ -42,11 +43,9 @@ __u64 eventfd_signal(struct eventfd_ctx *ctx, __u64 n);
 int eventfd_ctx_remove_wait_queue(struct eventfd_ctx *ctx, wait_queue_entry_t *wait,
 				  __u64 *cnt);
 
-DECLARE_PER_CPU(int, eventfd_wake_count);
-
-static inline bool eventfd_signal_count(void)
+static inline bool eventfd_signal_allowed(void)
 {
-	return this_cpu_read(eventfd_wake_count);
+	return !current->in_eventfd_signal;
 }
 
 #else /* CONFIG_EVENTFD */
@@ -77,9 +76,9 @@ static inline int eventfd_ctx_remove_wait_queue(struct eventfd_ctx *ctx,
 	return -ENOSYS;
 }
 
-static inline bool eventfd_signal_count(void)
+static inline bool eventfd_signal_allowed(void)
 {
-	return false;
+	return true;
 }
 
 #endif
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 79e34e98f812..e1dfb01f4623 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -802,6 +802,18 @@ struct task_struct {
 	/* to be used once the psi infrastructure lands upstream. */
 	unsigned			use_memdelay:1;
 #endif
+#ifdef CONFIG_PSI
+	/* Stalled due to lack of memory */
+	unsigned			in_memstall:1;
+#endif
+#ifdef CONFIG_PAGE_OWNER
+	/* Used by page_owner=on to detect recursion in page tracking. */
+	unsigned			in_page_owner:1;
+#endif
+#ifdef CONFIG_EVENTFD
+	/* Recursion prevention for eventfd_signal() */
+	unsigned			in_eventfd_signal:1;
+#endif
 
 	unsigned long			atomic_flags; /* Flags requiring atomic access. */
 
diff --git a/localversion-rt b/localversion-rt
index f36b5d418dd8..f38a3cc7f310 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt70
+-rt71

