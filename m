Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12ED546C6A7
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 22:23:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241863AbhLGV1E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 16:27:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241837AbhLGV1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 16:27:02 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5D6FC061748;
        Tue,  7 Dec 2021 13:23:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AC0BCB81E83;
        Tue,  7 Dec 2021 21:23:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8641AC341C1;
        Tue,  7 Dec 2021 21:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638912209;
        bh=x/FtiKG2/fyk3vUZ2GR+F7442AhVtMxWlqWiV9pE4r8=;
        h=Subject:From:To:Date:From;
        b=RJq/6W+dNW4H4AGu2SV1rFaPv2KriHt8yd0bzbrgGtnkSPfhV8jndBtS5PgVt6gCN
         5ZaN4bMcpf8c+0acCY8ouAaddv99pFYIng8Idb+Go5f0X7l7M4a/tk7f0+2KaCh+c2
         XA1+m87lk4yEoe7LVlGGdzNXzqRfoh+8ypVt44bMtcGzZxf1mOkSCZyOEV3mt8NS35
         99aovtMP0H2qWAkPxc2jXknk8Z0lRHOZ71eVReo2OZK+A26SNqwNqmrer1CwjHLVcY
         LecdPR4NFq98X26Tcqhp/g1xE36JidZ/R2yTU6nKh4AnwwAni8AN3i5tRxA9xTcp8V
         uMvW56/XsP5Dw==
Message-ID: <db13c58e64acbb46909af026a69ec2115df1562e.camel@kernel.org>
Subject: [ANNOUNCE] 5.4.161-rt67
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
Date:   Tue, 07 Dec 2021 15:23:26 -0600
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello RT Folks!

I'm pleased to announce the 5.4.161-rt67 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.4-rt
  Head SHA1: 923e4eb72f84d05ad78d7e2fd2f2c779e7ef9655

Or to build 5.4.161-rt67 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.4.tar.xz

  https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.4.161.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.4/patch-5.4.161-rt67.patch.xz

You can also build from 5.4.161-rt66 by applying the incremental patch:

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.4/incr/patch-5.4.161-rt66-rt67.patch.xz

Enjoy!

   Tom

Changes from v5.4.161-rt66:
---

Mike Galbraith (1):
      mm, zsmalloc: Convert zsmalloc_handle.lock to spinlock_t

Sebastian Andrzej Siewior (6):
      sched: Switch wait_task_inactive to HRTIMER_MODE_REL_HARD
      preempt: Move preempt_enable_no_resched() to the RT block
      mm: Disable NUMA_BALANCING_DEFAULT_ENABLED and TRANSPARENT_HUGEPAGE on PREEMPT_RT
      fscache: Use only one fscache_object_cong_wait.
      fscache: Use only one fscache_object_cong_wait.
      locking: Drop might_resched() from might_sleep_no_state_check()

Tom Zanussi (1):
      Linux 5.4.161-rt67
---
fs/fscache/internal.h   |  1 -
 fs/fscache/main.c       |  6 ------
 fs/fscache/object.c     | 13 +++++--------
 include/linux/kernel.h  |  2 +-
 include/linux/preempt.h |  6 +++---
 init/Kconfig            |  2 +-
 kernel/sched/core.c     |  2 +-
 localversion-rt         |  2 +-
 mm/zsmalloc.c           | 12 ++++++------
 9 files changed, 18 insertions(+), 28 deletions(-)
---
diff --git a/fs/fscache/internal.h b/fs/fscache/internal.h
index d09d4e69c818..b557eb2263d2 100644
--- a/fs/fscache/internal.h
+++ b/fs/fscache/internal.h
@@ -95,7 +95,6 @@ extern unsigned fscache_debug;
 extern struct kobject *fscache_root;
 extern struct workqueue_struct *fscache_object_wq;
 extern struct workqueue_struct *fscache_op_wq;
-DECLARE_PER_CPU(wait_queue_head_t, fscache_object_cong_wait);
 
 extern unsigned int fscache_hash(unsigned int salt, unsigned int *data, unsigned int n);
 
diff --git a/fs/fscache/main.c b/fs/fscache/main.c
index e1f1083b61a5..00367233ef8a 100644
--- a/fs/fscache/main.c
+++ b/fs/fscache/main.c
@@ -41,8 +41,6 @@ struct kobject *fscache_root;
 struct workqueue_struct *fscache_object_wq;
 struct workqueue_struct *fscache_op_wq;
 
-DEFINE_PER_CPU(wait_queue_head_t, fscache_object_cong_wait);
-
 /* these values serve as lower bounds, will be adjusted in fscache_init() */
 static unsigned fscache_object_max_active = 4;
 static unsigned fscache_op_max_active = 2;
@@ -139,7 +137,6 @@ unsigned int fscache_hash(unsigned int salt, unsigned int *data, unsigned int n)
 static int __init fscache_init(void)
 {
 	unsigned int nr_cpus = num_possible_cpus();
-	unsigned int cpu;
 	int ret;
 
 	fscache_object_max_active =
@@ -162,9 +159,6 @@ static int __init fscache_init(void)
 	if (!fscache_op_wq)
 		goto error_op_wq;
 
-	for_each_possible_cpu(cpu)
-		init_waitqueue_head(&per_cpu(fscache_object_cong_wait, cpu));
-
 	ret = fscache_proc_init();
 	if (ret < 0)
 		goto error_proc;
diff --git a/fs/fscache/object.c b/fs/fscache/object.c
index cfeba839a0f2..959384c91f79 100644
--- a/fs/fscache/object.c
+++ b/fs/fscache/object.c
@@ -807,6 +807,8 @@ void fscache_object_destroy(struct fscache_object *object)
 }
 EXPORT_SYMBOL(fscache_object_destroy);
 
+static DECLARE_WAIT_QUEUE_HEAD(fscache_object_cong_wait);
+
 /*
  * enqueue an object for metadata-type processing
  */
@@ -815,16 +817,12 @@ void fscache_enqueue_object(struct fscache_object *object)
 	_enter("{OBJ%x}", object->debug_id);
 
 	if (fscache_get_object(object, fscache_obj_get_queue) >= 0) {
-		wait_queue_head_t *cong_wq =
-			&get_cpu_var(fscache_object_cong_wait);
 
 		if (queue_work(fscache_object_wq, &object->work)) {
 			if (fscache_object_congested())
-				wake_up(cong_wq);
+				wake_up(&fscache_object_cong_wait);
 		} else
 			fscache_put_object(object, fscache_obj_put_queue);
-
-		put_cpu_var(fscache_object_cong_wait);
 	}
 }
 
@@ -842,16 +840,15 @@ void fscache_enqueue_object(struct fscache_object *object)
  */
 bool fscache_object_sleep_till_congested(signed long *timeoutp)
 {
-	wait_queue_head_t *cong_wq = this_cpu_ptr(&fscache_object_cong_wait);
 	DEFINE_WAIT(wait);
 
 	if (fscache_object_congested())
 		return true;
 
-	add_wait_queue_exclusive(cong_wq, &wait);
+	add_wait_queue_exclusive(&fscache_object_cong_wait, &wait);
 	if (!fscache_object_congested())
 		*timeoutp = schedule_timeout(*timeoutp);
-	finish_wait(cong_wq, &wait);
+	finish_wait(&fscache_object_cong_wait, &wait);
 
 	return fscache_object_congested();
 }
diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index f5ec1ddbfe07..fac917085516 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -229,7 +229,7 @@ extern void __cant_sleep(const char *file, int line, int preempt_offset);
 	do { __might_sleep(__FILE__, __LINE__, 0); might_resched(); } while (0)
 
 # define might_sleep_no_state_check() \
-	do { ___might_sleep(__FILE__, __LINE__, 0); might_resched(); } while (0)
+	do { ___might_sleep(__FILE__, __LINE__, 0); } while (0)
 
 /**
  * cant_sleep - annotation for functions that cannot sleep
diff --git a/include/linux/preempt.h b/include/linux/preempt.h
index adb085fe31e4..bbc3592b6f04 100644
--- a/include/linux/preempt.h
+++ b/include/linux/preempt.h
@@ -211,12 +211,12 @@ do { \
 	preempt_count_dec(); \
 } while (0)
 
-#ifdef CONFIG_PREEMPT_RT
+#ifndef CONFIG_PREEMPT_RT
 # define preempt_enable_no_resched() sched_preempt_enable_no_resched()
-# define preempt_check_resched_rt() preempt_check_resched()
+# define preempt_check_resched_rt() barrier();
 #else
 # define preempt_enable_no_resched() preempt_enable()
-# define preempt_check_resched_rt() barrier();
+# define preempt_check_resched_rt() preempt_check_resched()
 #endif
 
 #define preemptible()	(preempt_count() == 0 && !irqs_disabled())
diff --git a/init/Kconfig b/init/Kconfig
index 266802704c06..c733392fe237 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -769,7 +769,7 @@ config NUMA_BALANCING
 	bool "Memory placement aware NUMA scheduler"
 	depends on ARCH_SUPPORTS_NUMA_BALANCING
 	depends on !ARCH_WANT_NUMA_VARIABLE_LOCALITY
-	depends on SMP && NUMA && MIGRATION
+	depends on SMP && NUMA && MIGRATION && !PREEMPT_RT
 	help
 	  This option adds support for automatic NUMA aware memory/task placement.
 	  The mechanism is quite primitive and is based on migrating memory when
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 9b32fbded588..022c7b78642d 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2158,7 +2158,7 @@ unsigned long wait_task_inactive(struct task_struct *p, long match_state)
 			ktime_t to = NSEC_PER_SEC / HZ;
 
 			set_current_state(TASK_UNINTERRUPTIBLE);
-			schedule_hrtimeout(&to, HRTIMER_MODE_REL);
+			schedule_hrtimeout(&to, HRTIMER_MODE_REL_HARD);
 			continue;
 		}
 
diff --git a/localversion-rt b/localversion-rt
index d42c0971b041..5513b842ced2 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt66
+-rt67
diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index e64eca4b0601..9fc494fe70ea 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -81,7 +81,7 @@
 
 struct zsmalloc_handle {
 	unsigned long addr;
-	struct mutex lock;
+	spinlock_t lock;
 };
 
 #define ZS_HANDLE_ALLOC_SIZE (sizeof(struct zsmalloc_handle))
@@ -368,7 +368,7 @@ static unsigned long cache_alloc_handle(struct zs_pool *pool, gfp_t gfp)
 	if (p) {
 		struct zsmalloc_handle *zh = p;
 
-		mutex_init(&zh->lock);
+		spin_lock_init(&zh->lock);
 	}
 #endif
 	return (unsigned long)p;
@@ -926,7 +926,7 @@ static inline int testpin_tag(unsigned long handle)
 #ifdef CONFIG_PREEMPT_RT
 	struct zsmalloc_handle *zh = zs_get_pure_handle(handle);
 
-	return mutex_is_locked(&zh->lock);
+	return spin_is_locked(&zh->lock);
 #else
 	return bit_spin_is_locked(HANDLE_PIN_BIT, (unsigned long *)handle);
 #endif
@@ -937,7 +937,7 @@ static inline int trypin_tag(unsigned long handle)
 #ifdef CONFIG_PREEMPT_RT
 	struct zsmalloc_handle *zh = zs_get_pure_handle(handle);
 
-	return mutex_trylock(&zh->lock);
+	return spin_trylock(&zh->lock);
 #else
 	return bit_spin_trylock(HANDLE_PIN_BIT, (unsigned long *)handle);
 #endif
@@ -948,7 +948,7 @@ static void pin_tag(unsigned long handle)
 #ifdef CONFIG_PREEMPT_RT
 	struct zsmalloc_handle *zh = zs_get_pure_handle(handle);
 
-	return mutex_lock(&zh->lock);
+	return spin_lock(&zh->lock);
 #else
 	bit_spin_lock(HANDLE_PIN_BIT, (unsigned long *)handle);
 #endif
@@ -959,7 +959,7 @@ static void unpin_tag(unsigned long handle)
 #ifdef CONFIG_PREEMPT_RT
 	struct zsmalloc_handle *zh = zs_get_pure_handle(handle);
 
-	return mutex_unlock(&zh->lock);
+	return spin_unlock(&zh->lock);
 #else
 	bit_spin_unlock(HANDLE_PIN_BIT, (unsigned long *)handle);
 #endif

