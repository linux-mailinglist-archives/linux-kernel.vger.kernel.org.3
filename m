Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC6A54D9656
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 09:33:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346029AbiCOIdm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 04:33:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345983AbiCOIcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 04:32:20 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F12484C420;
        Tue, 15 Mar 2022 01:31:04 -0700 (PDT)
Date:   Tue, 15 Mar 2022 08:31:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1647333063;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=SYD7zjZDtfZ5BuQ5NJRiVy6wFgJXXo5h1G9nvMVNt4Q=;
        b=N5UB0rKpOARt1VEYVd2Tb5hor/xJf+Xwd2396Wsa+p7dZ8FLxH8IFsPuSb9ZsP28gRT5d9
        vOduPgha/oIKDzKKgcUPA4y4jSsPFbW1/V57JuCDUwluifbV83VLRgx31PPuMkOYzDKqFG
        i5Hhn5wRy9PRsSnQtqjOJM6n7Odv11VDWX+2biQukirTlim8pu27CJsImy4Cyr5cFYV0vY
        aIQgmo/uFVoitm8yjzCarBQSHs3Kk/4j6HZ0xZP6zUyCLrRPxn2rPrsHLGJ//bjuFCKYRA
        zDnFUuW+1C0RTLqNP5YNmf1CmKof9xpyhf6rX2viXk61paHzxv6M545/owY2HA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1647333063;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=SYD7zjZDtfZ5BuQ5NJRiVy6wFgJXXo5h1G9nvMVNt4Q=;
        b=sb3Ubc/MRp7VM65OZiwEkzCX1+uUqrpHr4peENR5CVKwoqdphZnwjr4gknspTcHAsCHhse
        RqPwiGQWoomz7LDA==
From:   "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/headers: Add initial new headers as identity mappings
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <164733306259.16921.13780763615278410417.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     669f45f19cf7feea7066dce86a0ce89dfc8a2065
Gitweb:        https://git.kernel.org/tip/669f45f19cf7feea7066dce86a0ce89dfc8a2065
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Tue, 22 Feb 2022 13:23:59 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 23 Feb 2022 10:58:28 +01:00

sched/headers: Add initial new headers as identity mappings

This allows code sharing between fast-headers tree and the vanilla
scheduler tree.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Peter Zijlstra <peterz@infradead.org>
---
 arch/arm64/include/asm/paravirt_api_clock.h | 1 +
 arch/x86/include/asm/paravirt_api_clock.h   | 1 +
 include/linux/cgroup_api.h                  | 1 +
 include/linux/cpumask_api.h                 | 1 +
 include/linux/fs_api.h                      | 1 +
 include/linux/gfp_api.h                     | 1 +
 include/linux/hashtable_api.h               | 1 +
 include/linux/hrtimer_api.h                 | 1 +
 include/linux/kobject_api.h                 | 1 +
 include/linux/kref_api.h                    | 1 +
 include/linux/ktime_api.h                   | 1 +
 include/linux/llist_api.h                   | 1 +
 include/linux/lockdep_api.h                 | 1 +
 include/linux/mm_api.h                      | 1 +
 include/linux/mutex_api.h                   | 1 +
 include/linux/perf_event_api.h              | 1 +
 include/linux/pgtable_api.h                 | 1 +
 include/linux/ptrace_api.h                  | 1 +
 include/linux/rcuwait_api.h                 | 1 +
 include/linux/refcount_api.h                | 1 +
 include/linux/sched/affinity.h              | 1 +
 include/linux/sched/cond_resched.h          | 1 +
 include/linux/sched/posix-timers.h          | 1 +
 include/linux/sched/rseq_api.h              | 1 +
 include/linux/sched/task_flags.h            | 1 +
 include/linux/sched/thread_info_api.h       | 1 +
 include/linux/seqlock_api.h                 | 1 +
 include/linux/softirq.h                     | 1 +
 include/linux/spinlock_api.h                | 1 +
 include/linux/swait_api.h                   | 1 +
 include/linux/syscalls_api.h                | 1 +
 include/linux/u64_stats_sync_api.h          | 1 +
 include/linux/wait_api.h                    | 1 +
 include/linux/workqueue_api.h               | 1 +
 34 files changed, 34 insertions(+)
 create mode 100644 arch/arm64/include/asm/paravirt_api_clock.h
 create mode 100644 arch/x86/include/asm/paravirt_api_clock.h
 create mode 100644 include/linux/cgroup_api.h
 create mode 100644 include/linux/cpumask_api.h
 create mode 100644 include/linux/fs_api.h
 create mode 100644 include/linux/gfp_api.h
 create mode 100644 include/linux/hashtable_api.h
 create mode 100644 include/linux/hrtimer_api.h
 create mode 100644 include/linux/kobject_api.h
 create mode 100644 include/linux/kref_api.h
 create mode 100644 include/linux/ktime_api.h
 create mode 100644 include/linux/llist_api.h
 create mode 100644 include/linux/lockdep_api.h
 create mode 100644 include/linux/mm_api.h
 create mode 100644 include/linux/mutex_api.h
 create mode 100644 include/linux/perf_event_api.h
 create mode 100644 include/linux/pgtable_api.h
 create mode 100644 include/linux/ptrace_api.h
 create mode 100644 include/linux/rcuwait_api.h
 create mode 100644 include/linux/refcount_api.h
 create mode 100644 include/linux/sched/affinity.h
 create mode 100644 include/linux/sched/cond_resched.h
 create mode 100644 include/linux/sched/posix-timers.h
 create mode 100644 include/linux/sched/rseq_api.h
 create mode 100644 include/linux/sched/task_flags.h
 create mode 100644 include/linux/sched/thread_info_api.h
 create mode 100644 include/linux/seqlock_api.h
 create mode 100644 include/linux/softirq.h
 create mode 100644 include/linux/spinlock_api.h
 create mode 100644 include/linux/swait_api.h
 create mode 100644 include/linux/syscalls_api.h
 create mode 100644 include/linux/u64_stats_sync_api.h
 create mode 100644 include/linux/wait_api.h
 create mode 100644 include/linux/workqueue_api.h

diff --git a/arch/arm64/include/asm/paravirt_api_clock.h b/arch/arm64/include/asm/paravirt_api_clock.h
new file mode 100644
index 0000000..65ac7ce
--- /dev/null
+++ b/arch/arm64/include/asm/paravirt_api_clock.h
@@ -0,0 +1 @@
+#include <asm/paravirt.h>
diff --git a/arch/x86/include/asm/paravirt_api_clock.h b/arch/x86/include/asm/paravirt_api_clock.h
new file mode 100644
index 0000000..65ac7ce
--- /dev/null
+++ b/arch/x86/include/asm/paravirt_api_clock.h
@@ -0,0 +1 @@
+#include <asm/paravirt.h>
diff --git a/include/linux/cgroup_api.h b/include/linux/cgroup_api.h
new file mode 100644
index 0000000..d0cfe80
--- /dev/null
+++ b/include/linux/cgroup_api.h
@@ -0,0 +1 @@
+#include <linux/cgroup.h>
diff --git a/include/linux/cpumask_api.h b/include/linux/cpumask_api.h
new file mode 100644
index 0000000..83bd3eb
--- /dev/null
+++ b/include/linux/cpumask_api.h
@@ -0,0 +1 @@
+#include <linux/cpumask.h>
diff --git a/include/linux/fs_api.h b/include/linux/fs_api.h
new file mode 100644
index 0000000..83be38d
--- /dev/null
+++ b/include/linux/fs_api.h
@@ -0,0 +1 @@
+#include <linux/fs.h>
diff --git a/include/linux/gfp_api.h b/include/linux/gfp_api.h
new file mode 100644
index 0000000..5a05a27
--- /dev/null
+++ b/include/linux/gfp_api.h
@@ -0,0 +1 @@
+#include <linux/gfp.h>
diff --git a/include/linux/hashtable_api.h b/include/linux/hashtable_api.h
new file mode 100644
index 0000000..c268ac2
--- /dev/null
+++ b/include/linux/hashtable_api.h
@@ -0,0 +1 @@
+#include <linux/hashtable.h>
diff --git a/include/linux/hrtimer_api.h b/include/linux/hrtimer_api.h
new file mode 100644
index 0000000..8d97008
--- /dev/null
+++ b/include/linux/hrtimer_api.h
@@ -0,0 +1 @@
+#include <linux/hrtimer.h>
diff --git a/include/linux/kobject_api.h b/include/linux/kobject_api.h
new file mode 100644
index 0000000..6e36a05
--- /dev/null
+++ b/include/linux/kobject_api.h
@@ -0,0 +1 @@
+#include <linux/kobject.h>
diff --git a/include/linux/kref_api.h b/include/linux/kref_api.h
new file mode 100644
index 0000000..d67e554
--- /dev/null
+++ b/include/linux/kref_api.h
@@ -0,0 +1 @@
+#include <linux/kref.h>
diff --git a/include/linux/ktime_api.h b/include/linux/ktime_api.h
new file mode 100644
index 0000000..f697d49
--- /dev/null
+++ b/include/linux/ktime_api.h
@@ -0,0 +1 @@
+#include <linux/ktime.h>
diff --git a/include/linux/llist_api.h b/include/linux/llist_api.h
new file mode 100644
index 0000000..625bec0
--- /dev/null
+++ b/include/linux/llist_api.h
@@ -0,0 +1 @@
+#include <linux/llist.h>
diff --git a/include/linux/lockdep_api.h b/include/linux/lockdep_api.h
new file mode 100644
index 0000000..907e669
--- /dev/null
+++ b/include/linux/lockdep_api.h
@@ -0,0 +1 @@
+#include <linux/lockdep.h>
diff --git a/include/linux/mm_api.h b/include/linux/mm_api.h
new file mode 100644
index 0000000..a5ace2b
--- /dev/null
+++ b/include/linux/mm_api.h
@@ -0,0 +1 @@
+#include <linux/mm.h>
diff --git a/include/linux/mutex_api.h b/include/linux/mutex_api.h
new file mode 100644
index 0000000..85ab949
--- /dev/null
+++ b/include/linux/mutex_api.h
@@ -0,0 +1 @@
+#include <linux/mutex.h>
diff --git a/include/linux/perf_event_api.h b/include/linux/perf_event_api.h
new file mode 100644
index 0000000..c2fd604
--- /dev/null
+++ b/include/linux/perf_event_api.h
@@ -0,0 +1 @@
+#include <linux/perf_event.h>
diff --git a/include/linux/pgtable_api.h b/include/linux/pgtable_api.h
new file mode 100644
index 0000000..ff367a4
--- /dev/null
+++ b/include/linux/pgtable_api.h
@@ -0,0 +1 @@
+#include <linux/pgtable.h>
diff --git a/include/linux/ptrace_api.h b/include/linux/ptrace_api.h
new file mode 100644
index 0000000..26e7d27
--- /dev/null
+++ b/include/linux/ptrace_api.h
@@ -0,0 +1 @@
+#include <linux/ptrace.h>
diff --git a/include/linux/rcuwait_api.h b/include/linux/rcuwait_api.h
new file mode 100644
index 0000000..f962e28
--- /dev/null
+++ b/include/linux/rcuwait_api.h
@@ -0,0 +1 @@
+#include <linux/rcuwait.h>
diff --git a/include/linux/refcount_api.h b/include/linux/refcount_api.h
new file mode 100644
index 0000000..5f03258
--- /dev/null
+++ b/include/linux/refcount_api.h
@@ -0,0 +1 @@
+#include <linux/refcount.h>
diff --git a/include/linux/sched/affinity.h b/include/linux/sched/affinity.h
new file mode 100644
index 0000000..227f5be
--- /dev/null
+++ b/include/linux/sched/affinity.h
@@ -0,0 +1 @@
+#include <linux/sched.h>
diff --git a/include/linux/sched/cond_resched.h b/include/linux/sched/cond_resched.h
new file mode 100644
index 0000000..227f5be
--- /dev/null
+++ b/include/linux/sched/cond_resched.h
@@ -0,0 +1 @@
+#include <linux/sched.h>
diff --git a/include/linux/sched/posix-timers.h b/include/linux/sched/posix-timers.h
new file mode 100644
index 0000000..523a381
--- /dev/null
+++ b/include/linux/sched/posix-timers.h
@@ -0,0 +1 @@
+#include <linux/posix-timers.h>
diff --git a/include/linux/sched/rseq_api.h b/include/linux/sched/rseq_api.h
new file mode 100644
index 0000000..cf2af72
--- /dev/null
+++ b/include/linux/sched/rseq_api.h
@@ -0,0 +1 @@
+#include <linux/rseq.h>
diff --git a/include/linux/sched/task_flags.h b/include/linux/sched/task_flags.h
new file mode 100644
index 0000000..227f5be
--- /dev/null
+++ b/include/linux/sched/task_flags.h
@@ -0,0 +1 @@
+#include <linux/sched.h>
diff --git a/include/linux/sched/thread_info_api.h b/include/linux/sched/thread_info_api.h
new file mode 100644
index 0000000..2c60fbc
--- /dev/null
+++ b/include/linux/sched/thread_info_api.h
@@ -0,0 +1 @@
+#include <linux/thread_info.h>
diff --git a/include/linux/seqlock_api.h b/include/linux/seqlock_api.h
new file mode 100644
index 0000000..be91e7d
--- /dev/null
+++ b/include/linux/seqlock_api.h
@@ -0,0 +1 @@
+#include <linux/seqlock.h>
diff --git a/include/linux/softirq.h b/include/linux/softirq.h
new file mode 100644
index 0000000..c73d7dc
--- /dev/null
+++ b/include/linux/softirq.h
@@ -0,0 +1 @@
+#include <linux/interrupt.h>
diff --git a/include/linux/spinlock_api.h b/include/linux/spinlock_api.h
new file mode 100644
index 0000000..6338b27
--- /dev/null
+++ b/include/linux/spinlock_api.h
@@ -0,0 +1 @@
+#include <linux/spinlock.h>
diff --git a/include/linux/swait_api.h b/include/linux/swait_api.h
new file mode 100644
index 0000000..1eeaaaa
--- /dev/null
+++ b/include/linux/swait_api.h
@@ -0,0 +1 @@
+#include <linux/swait.h>
diff --git a/include/linux/syscalls_api.h b/include/linux/syscalls_api.h
new file mode 100644
index 0000000..23e012b
--- /dev/null
+++ b/include/linux/syscalls_api.h
@@ -0,0 +1 @@
+#include <linux/syscalls.h>
diff --git a/include/linux/u64_stats_sync_api.h b/include/linux/u64_stats_sync_api.h
new file mode 100644
index 0000000..c72ca63
--- /dev/null
+++ b/include/linux/u64_stats_sync_api.h
@@ -0,0 +1 @@
+#include <linux/u64_stats_sync.h>
diff --git a/include/linux/wait_api.h b/include/linux/wait_api.h
new file mode 100644
index 0000000..4e93054
--- /dev/null
+++ b/include/linux/wait_api.h
@@ -0,0 +1 @@
+#include <linux/wait.h>
diff --git a/include/linux/workqueue_api.h b/include/linux/workqueue_api.h
new file mode 100644
index 0000000..77debb5
--- /dev/null
+++ b/include/linux/workqueue_api.h
@@ -0,0 +1 @@
+#include <linux/workqueue.h>
