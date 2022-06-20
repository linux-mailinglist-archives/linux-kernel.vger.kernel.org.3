Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25C8B55274F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 00:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345073AbiFTW4f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 18:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344841AbiFTWy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 18:54:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B470B1F624;
        Mon, 20 Jun 2022 15:54:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6E17EB81668;
        Mon, 20 Jun 2022 22:54:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43F53C53FBF;
        Mon, 20 Jun 2022 22:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655765654;
        bh=tWLjJm34CWhJNt/roMDrfQDWu0Ge4LCRV+6Mh69Ohc8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ssqUD5nzbdF6enc4/LSd+Kn1yrkdxj1+t9aSMRh2AmzBeJ6JuDlRdH8kacC5hKj6P
         u+FW6D6k1ZoitLPr9+qw5XOCl8HiyH1mtOfq72T73zZJiWhRJGP1X6cnUUBLvysIft
         7+El5UZ1isbEehP0hFnbzrsPzVdThvp6cfYeXH3R8P8ieO2VdKU6avd1pqQ0f1nEHe
         C5pa36C6ohXBzsrw5qFIi5lUvLfR2PH/nQZTv6uEOxYMeLTGWvX2iE4RhipXaKnuQB
         XhUcmsPkVKLIJAGUAVi4xjgiQqIMsJ/aUfN5ez2eOFCFAgdRJ7/ep5/mH2/ERgYWF8
         WPil0MNgCP1Sg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 61CD45C2AE4; Mon, 20 Jun 2022 15:54:13 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Eric Dumazet <edumazet@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        KP Singh <kpsingh@kernel.org>
Subject: [PATCH rcu 30/32] rcu-tasks: Update comments
Date:   Mon, 20 Jun 2022 15:54:09 -0700
Message-Id: <20220620225411.3842519-30-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220620225402.GA3842369@paulmck-ThinkPad-P17-Gen-1>
References: <20220620225402.GA3842369@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit updates comments to reflect the changes in the series
of commits that eliminated the full task-list scan.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Neeraj Upadhyay <quic_neeraju@quicinc.com>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <kafai@fb.com>
Cc: KP Singh <kpsingh@kernel.org>
---
 kernel/rcu/tasks.h | 71 +++++++++++++++++++++-------------------------
 1 file changed, 33 insertions(+), 38 deletions(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index bf9cc5bc4ae52..df6b2cb2f205d 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -1138,11 +1138,10 @@ EXPORT_SYMBOL_GPL(show_rcu_tasks_rude_gp_kthread);
 // 3.	Avoids expensive read-side instructions, having overhead similar
 //	to that of Preemptible RCU.
 //
-// There are of course downsides.  The grace-period code can send IPIs to
-// CPUs, even when those CPUs are in the idle loop or in nohz_full userspace.
-// It is necessary to scan the full tasklist, much as for Tasks RCU.  There
-// is a single callback queue guarded by a single lock, again, much as for
-// Tasks RCU.  If needed, these downsides can be at least partially remedied.
+// There are of course downsides.  For example, the grace-period code
+// can send IPIs to CPUs, even when those CPUs are in the idle loop or
+// in nohz_full userspace.  If needed, these downsides can be at least
+// partially remedied.
 //
 // Perhaps most important, this variant of RCU does not affect the vanilla
 // flavors, rcu_preempt and rcu_sched.  The fact that RCU Tasks Trace
@@ -1155,38 +1154,30 @@ EXPORT_SYMBOL_GPL(show_rcu_tasks_rude_gp_kthread);
 // invokes these functions in this order:
 //
 // rcu_tasks_trace_pregp_step():
-//	Initialize the count of readers and block CPU-hotplug operations.
-// rcu_tasks_trace_pertask(), invoked on every non-idle task:
-//	Initialize per-task state and attempt to identify an immediate
-//	quiescent state for that task, or, failing that, attempt to
-//	set that task's .need_qs flag so that task's next outermost
-//	rcu_read_unlock_trace() will report the quiescent state (in which
-//	case the count of readers is incremented).  If both attempts fail,
-//	the task is added to a "holdout" list.  Note that IPIs are used
-//	to invoke trc_read_check_handler() in the context of running tasks
-//	in order to avoid ordering overhead on common-case shared-variable
-//	accessses.
+//	Disables CPU hotplug, adds all currently executing tasks to the
+//	holdout list, then checks the state of all tasks that blocked
+//	or were preempted within their current RCU Tasks Trace read-side
+//	critical section, adding them to the holdout list if appropriate.
+//	Finally, this function re-enables CPU hotplug.
+// The ->pertask_func() pointer is NULL, so there is no per-task processing.
 // rcu_tasks_trace_postscan():
-//	Initialize state and attempt to identify an immediate quiescent
-//	state as above (but only for idle tasks), unblock CPU-hotplug
-//	operations, and wait for an RCU grace period to avoid races with
-//	tasks that are in the process of exiting.
+//	Invokes synchronize_rcu() to wait for late-stage exiting tasks
+//	to finish exiting.
 // check_all_holdout_tasks_trace(), repeatedly until holdout list is empty:
 //	Scans the holdout list, attempting to identify a quiescent state
 //	for each task on the list.  If there is a quiescent state, the
-//	corresponding task is removed from the holdout list.
+//	corresponding task is removed from the holdout list.  Once this
+//	list is empty, the grace period has completed.
 // rcu_tasks_trace_postgp():
-//	Wait for the count of readers do drop to zero, reporting any stalls.
-//	Also execute full memory barriers to maintain ordering with code
-//	executing after the grace period.
+//	Provides the needed full memory barrier and does debug checks.
 //
 // The exit_tasks_rcu_finish_trace() synchronizes with exiting tasks.
 //
-// Pre-grace-period update-side code is ordered before the grace
-// period via the ->cbs_lock and barriers in rcu_tasks_kthread().
-// Pre-grace-period read-side code is ordered before the grace period by
-// atomic_dec_and_test() of the count of readers (for IPIed readers) and by
-// scheduler context-switch ordering (for locked-down non-running readers).
+// Pre-grace-period update-side code is ordered before the grace period
+// via the ->cbs_lock and barriers in rcu_tasks_kthread().  Pre-grace-period
+// read-side code is ordered before the grace period by atomic operations
+// on .b.need_qs flag of each task involved in this process, or by scheduler
+// context-switch ordering (for locked-down non-running readers).
 
 // The lockdep state must be outside of #ifdef to be useful.
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
@@ -1245,7 +1236,10 @@ u8 rcu_trc_cmpxchg_need_qs(struct task_struct *t, u8 old, u8 new)
 }
 EXPORT_SYMBOL_GPL(rcu_trc_cmpxchg_need_qs);
 
-/* If we are the last reader, wake up the grace-period kthread. */
+/*
+ * If we are the last reader, signal the grace-period kthread.
+ * Also remove from the per-CPU list of blocked tasks.
+ */
 void rcu_read_unlock_trace_special(struct task_struct *t)
 {
 	unsigned long flags;
@@ -1336,9 +1330,9 @@ static void trc_read_check_handler(void *t_in)
 	if (unlikely(nesting < 0))
 		goto reset_ipi;
 
-	// Get here if the task is in a read-side critical section.  Set
-	// its state so that it will awaken the grace-period kthread upon
-	// exit from that critical section.
+	// Get here if the task is in a read-side critical section.
+	// Set its state so that it will update state for the grace-period
+	// kthread upon exit from that critical section.
 	rcu_trc_cmpxchg_need_qs(t, 0, TRC_NEED_QS | TRC_NEED_QS_CHECKED);
 
 reset_ipi:
@@ -1387,7 +1381,7 @@ static int trc_inspect_reader(struct task_struct *t, void *bhp_in)
 		return 0;  // In QS, so done.
 	}
 	if (nesting < 0)
-		return -EINVAL; //  QS transitioning, try again later.
+		return -EINVAL; // Reader transitioning, try again later.
 
 	// The task is in a read-side critical section, so set up its
 	// state so that it will update state upon exit from that critical
@@ -1492,11 +1486,12 @@ static void rcu_tasks_trace_pregp_step(struct list_head *hop)
 	for_each_possible_cpu(cpu)
 		WARN_ON_ONCE(per_cpu(trc_ipi_to_cpu, cpu));
 
-	// Disable CPU hotplug across the CPU scan.
-	// This also waits for all readers in CPU-hotplug code paths.
+	// Disable CPU hotplug across the CPU scan for the benefit of
+	// any IPIs that might be needed.  This also waits for all readers
+	// in CPU-hotplug code paths.
 	cpus_read_lock();
 
-	// These smp_call_function_single() calls are serialized to
+	// These rcu_tasks_trace_pertask_prep() calls are serialized to
 	// allow safe access to the hop list.
 	for_each_online_cpu(cpu) {
 		rcu_read_lock();
@@ -1608,7 +1603,7 @@ static void check_all_holdout_tasks_trace(struct list_head *hop,
 {
 	struct task_struct *g, *t;
 
-	// Disable CPU hotplug across the holdout list scan.
+	// Disable CPU hotplug across the holdout list scan for IPIs.
 	cpus_read_lock();
 
 	list_for_each_entry_safe(t, g, hop, trc_holdout_list) {
-- 
2.31.1.189.g2e36527f23

