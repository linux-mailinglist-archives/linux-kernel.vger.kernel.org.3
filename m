Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CECC44B28BE
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 16:08:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351253AbiBKPIi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 10:08:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348850AbiBKPIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 10:08:36 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 90C94307
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 07:08:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644592113;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=kC0WcDsVCz+dXfMK9DX2xP97JJ0YrgpwqjbVOhyQH4w=;
        b=Y0XUXTzOBc8lCavjhTlFbD53S312I0AhdIqYvum+MqXPlokTx4qp+F3nDJvDicD0HrQNPD
        yQxNBDp9xeIOwYNA6uDP4i5IJBHnxpijOqmXRanDCDexnKgPf/9ZKmBrjqEprIsdn+bez6
        sRUbyKSg943Ny/iJAf/9h+4sktEHHOU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-132-seNhwD-lM4GBGbNS_XGhKQ-1; Fri, 11 Feb 2022 10:08:28 -0500
X-MC-Unique: seNhwD-lM4GBGbNS_XGhKQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 10E051091DA3;
        Fri, 11 Feb 2022 15:08:26 +0000 (UTC)
Received: from localhost (unknown [10.22.17.50])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C79BD45C84;
        Fri, 11 Feb 2022 15:08:24 +0000 (UTC)
Date:   Fri, 11 Feb 2022 12:08:23 -0300
From:   "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        stable-rt <stable-rt@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <daniel.wagner@suse.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Pavel Machek <pavel@denx.de>,
        Jeff Brady <jeffreyjbrady@gmail.com>,
        Luis Goncalves <lgoncalv@redhat.com>
Subject: [ANNOUNCE] 5.10.90-rt61
Message-ID: <YgZ75zvhmEzNV4PV@uudg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello RT-list!

I'm pleased to announce the 5.10.90-rt61 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.10-rt
  Head SHA1: 8bff2d3a6cbc31ef22f1f24ec4f76ddb48892503

Or to build 5.10.90-rt61 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.10.tar.xz

  https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.10.90.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.10/patch-5.10.90-rt61.patch.xz


All keys used for the uploads can be found on the following git repository:

   git://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git


Enjoy!
Luis

Changes from v5.10.90-rt60:
---

Luis Claudio R. Goncalves (1):
      Linux 5.10.90-rt61

Sebastian Andrzej Siewior (1):
      stop_machine: Remove this_cpu_ptr() from print_stop_info().

Thomas Gleixner (1):
      eventfd: Make signal recursion protection a task bit

Xie Yongji (1):
      aio: Fix incorrect usage of eventfd_signal_allowed()
---
fs/aio.c                |  2 +-
 fs/eventfd.c            | 12 +++++-------
 include/linux/eventfd.h | 11 +++++------
 include/linux/sched.h   |  4 ++++
 kernel/stop_machine.c   |  6 +++++-
 localversion-rt         |  2 +-
 6 files changed, 21 insertions(+), 16 deletions(-)
---
diff --git a/fs/aio.c b/fs/aio.c
index c72b2c51b446c..1a78979663dca 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -1761,7 +1761,7 @@ static int aio_poll_wake(struct wait_queue_entry *wait, unsigned mode, int sync,
 		list_del_init(&req->wait.entry);
 		list_del(&iocb->ki_list);
 		iocb->ki_res.res = mangle_poll(mask);
-		if (iocb->ki_eventfd && eventfd_signal_count()) {
+		if (iocb->ki_eventfd && !eventfd_signal_allowed()) {
 			iocb = NULL;
 			INIT_WORK(&req->work, aio_poll_put_work);
 			schedule_work(&req->work);
diff --git a/fs/eventfd.c b/fs/eventfd.c
index df466ef81dddf..9035ca60bfcf3 100644
--- a/fs/eventfd.c
+++ b/fs/eventfd.c
@@ -25,8 +25,6 @@
 #include <linux/idr.h>
 #include <linux/uio.h>
 
-DEFINE_PER_CPU(int, eventfd_wake_count);
-
 static DEFINE_IDA(eventfd_ida);
 
 struct eventfd_ctx {
@@ -67,21 +65,21 @@ __u64 eventfd_signal(struct eventfd_ctx *ctx, __u64 n)
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
index dc4fd8a6644dd..836b4c021a0a4 100644
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
index 409a24036952c..29e6ff1af1df9 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -852,6 +852,10 @@ struct task_struct {
 	/* Stalled due to lack of memory */
 	unsigned			in_memstall:1;
 #endif
+#ifdef CONFIG_EVENTFD
+	/* Recursion prevention for eventfd_signal() */
+	unsigned			in_eventfd_signal:1;
+#endif
 
 	unsigned long			atomic_flags; /* Flags requiring atomic access. */
 
diff --git a/kernel/stop_machine.c b/kernel/stop_machine.c
index dbf585cf4b9f8..971d8acceaecb 100644
--- a/kernel/stop_machine.c
+++ b/kernel/stop_machine.c
@@ -51,7 +51,11 @@ static bool stop_machine_initialized = false;
 
 void print_stop_info(const char *log_lvl, struct task_struct *task)
 {
-	struct cpu_stopper *stopper = this_cpu_ptr(&cpu_stopper);
+	/*
+	 * If @task is a stopper task, it cannot migrate and task_cpu() is
+	 * stable.
+	 */
+	struct cpu_stopper *stopper = per_cpu_ptr(&cpu_stopper, task_cpu(task));
 
 	if (task != stopper->thread)
 		return;
diff --git a/localversion-rt b/localversion-rt
index 66fa05e70f292..9b7de9345ef4c 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt60
+-rt61

