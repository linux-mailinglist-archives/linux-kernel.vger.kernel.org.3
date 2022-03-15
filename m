Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F3A74DA635
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 00:22:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344584AbiCOXXY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 19:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236358AbiCOXXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 19:23:22 -0400
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98FB82B1AD;
        Tue, 15 Mar 2022 16:22:09 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:52822)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nUGUS-005BCm-MN; Tue, 15 Mar 2022 17:22:08 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:37860 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nUGUQ-009ET2-FY; Tue, 15 Mar 2022 17:22:08 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     <linux-kernel@vger.kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Alexey Gladkov <legion@kernel.org>,
        Kyle Huey <me@kylehuey.com>, Oleg Nesterov <oleg@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Al Viro <viro@ZenIV.linux.org.uk>, <linux-api@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
References: <87a6ha4zsd.fsf@email.froward.int.ebiederm.org>
        <87bl1kunjj.fsf@email.froward.int.ebiederm.org>
        <87r19opkx1.fsf_-_@email.froward.int.ebiederm.org>
        <87o82gdlu9.fsf_-_@email.froward.int.ebiederm.org>
        <87tubyx0rg.fsf_-_@email.froward.int.ebiederm.org>
Date:   Tue, 15 Mar 2022 18:21:08 -0500
In-Reply-To: <87tubyx0rg.fsf_-_@email.froward.int.ebiederm.org> (Eric
        W. Biederman's message of "Tue, 15 Mar 2022 18:18:59 -0500")
Message-ID: <87bky67qfv.fsf_-_@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1nUGUQ-009ET2-FY;;;mid=<87bky67qfv.fsf_-_@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18ENc95f7uuEALRb2HBI4YzCX++Cz4s214=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;<linux-kernel@vger.kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1618 ms - load_scoreonly_sql: 0.08 (0.0%),
        signal_user_changed: 12 (0.7%), b_tie_ro: 10 (0.6%), parse: 1.24
        (0.1%), extract_message_metadata: 15 (0.9%), get_uri_detail_list: 3.1
        (0.2%), tests_pri_-1000: 17 (1.1%), tests_pri_-950: 1.31 (0.1%),
        tests_pri_-900: 1.10 (0.1%), tests_pri_-90: 78 (4.8%), check_bayes: 76
        (4.7%), b_tokenize: 14 (0.9%), b_tok_get_all: 11 (0.7%), b_comp_prob:
        3.4 (0.2%), b_tok_touch_all: 43 (2.6%), b_finish: 1.08 (0.1%),
        tests_pri_0: 1477 (91.3%), check_dkim_signature: 0.98 (0.1%),
        check_dkim_adsp: 3.7 (0.2%), poll_dns_idle: 1.27 (0.1%), tests_pri_10:
        3.0 (0.2%), tests_pri_500: 8 (0.5%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 1/2] ptrace: Move setting/clearing ptrace_message into
 ptrace_stop
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Today ptrace_message is easy to overlook as it not a core part of
ptrace_stop.  It has been overlooked so much that there are places
that set ptrace_message and don't clear it, and places that never set
it.  So if you get an unlucky sequence of events the ptracer may be
able to read a ptrace_message that does not apply to the current
ptrace stop.

Move setting of ptrace_message into ptrace_stop so that it always gets
set before the stop, and always gets cleared after the stop.  This
prevents non-sense from being reported to userspace and makes
ptrace_message more visible in the ptrace helper functions so that
kernel developers can see it.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 include/linux/ptrace.h      |  9 +++------
 include/uapi/linux/ptrace.h |  2 +-
 kernel/signal.c             | 21 ++++++++++++---------
 3 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/include/linux/ptrace.h b/include/linux/ptrace.h
index 5310f43e4762..3e6b46e2b7be 100644
--- a/include/linux/ptrace.h
+++ b/include/linux/ptrace.h
@@ -60,7 +60,7 @@ extern int ptrace_writedata(struct task_struct *tsk, char __user *src, unsigned
 extern void ptrace_disable(struct task_struct *);
 extern int ptrace_request(struct task_struct *child, long request,
 			  unsigned long addr, unsigned long data);
-extern void ptrace_notify(int exit_code);
+extern void ptrace_notify(int exit_code, unsigned long message);
 extern void __ptrace_link(struct task_struct *child,
 			  struct task_struct *new_parent,
 			  const struct cred *ptracer_cred);
@@ -155,8 +155,7 @@ static inline bool ptrace_event_enabled(struct task_struct *task, int event)
 static inline void ptrace_event(int event, unsigned long message)
 {
 	if (unlikely(ptrace_event_enabled(current, event))) {
-		current->ptrace_message = message;
-		ptrace_notify((event << 8) | SIGTRAP);
+		ptrace_notify((event << 8) | SIGTRAP, message);
 	} else if (event == PTRACE_EVENT_EXEC) {
 		/* legacy EXEC report via SIGTRAP */
 		if ((current->ptrace & (PT_PTRACED|PT_SEIZED)) == PT_PTRACED)
@@ -424,8 +423,7 @@ static inline int ptrace_report_syscall(unsigned long message)
 	if (!(ptrace & PT_PTRACED))
 		return 0;
 
-	current->ptrace_message = message;
-	ptrace_notify(SIGTRAP | ((ptrace & PT_TRACESYSGOOD) ? 0x80 : 0));
+	ptrace_notify(SIGTRAP | ((ptrace & PT_TRACESYSGOOD) ? 0x80 : 0), message);
 
 	/*
 	 * this isn't the same as continuing with a signal, but it will do
@@ -437,7 +435,6 @@ static inline int ptrace_report_syscall(unsigned long message)
 		current->exit_code = 0;
 	}
 
-	current->ptrace_message = 0;
 	return fatal_signal_pending(current);
 }
 
diff --git a/include/uapi/linux/ptrace.h b/include/uapi/linux/ptrace.h
index b7af92e07d1f..195ae64a8c87 100644
--- a/include/uapi/linux/ptrace.h
+++ b/include/uapi/linux/ptrace.h
@@ -114,7 +114,7 @@ struct ptrace_rseq_configuration {
 
 /*
  * These values are stored in task->ptrace_message
- * by ptrace_report_syscall_* to describe the current syscall-stop.
+ * by ptrace_stop to describe the current syscall-stop.
  */
 #define PTRACE_EVENTMSG_SYSCALL_ENTRY	1
 #define PTRACE_EVENTMSG_SYSCALL_EXIT	2
diff --git a/kernel/signal.c b/kernel/signal.c
index c2dee5420567..a49ac7149256 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2191,7 +2191,8 @@ static void do_notify_parent_cldstop(struct task_struct *tsk,
  * If we actually decide not to stop at all because the tracer
  * is gone, we keep current->exit_code unless clear_code.
  */
-static void ptrace_stop(int exit_code, int why, int clear_code, kernel_siginfo_t *info)
+static void ptrace_stop(int exit_code, int why, int clear_code,
+			unsigned long message, kernel_siginfo_t *info)
 	__releases(&current->sighand->siglock)
 	__acquires(&current->sighand->siglock)
 {
@@ -2237,6 +2238,7 @@ static void ptrace_stop(int exit_code, int why, int clear_code, kernel_siginfo_t
 	 */
 	smp_wmb();
 
+	current->ptrace_message = message;
 	current->last_siginfo = info;
 	current->exit_code = exit_code;
 
@@ -2315,6 +2317,7 @@ static void ptrace_stop(int exit_code, int why, int clear_code, kernel_siginfo_t
 	 */
 	spin_lock_irq(&current->sighand->siglock);
 	current->last_siginfo = NULL;
+	current->ptrace_message = 0;
 
 	/* LISTENING can be set only during STOP traps, clear it */
 	current->jobctl &= ~JOBCTL_LISTENING;
@@ -2327,7 +2330,7 @@ static void ptrace_stop(int exit_code, int why, int clear_code, kernel_siginfo_t
 	recalc_sigpending_tsk(current);
 }
 
-static void ptrace_do_notify(int signr, int exit_code, int why)
+static void ptrace_do_notify(int signr, int exit_code, int why, unsigned long message)
 {
 	kernel_siginfo_t info;
 
@@ -2338,17 +2341,17 @@ static void ptrace_do_notify(int signr, int exit_code, int why)
 	info.si_uid = from_kuid_munged(current_user_ns(), current_uid());
 
 	/* Let the debugger run.  */
-	ptrace_stop(exit_code, why, 1, &info);
+	ptrace_stop(exit_code, why, 1, message, &info);
 }
 
-void ptrace_notify(int exit_code)
+void ptrace_notify(int exit_code, unsigned long message)
 {
 	BUG_ON((exit_code & (0x7f | ~0xffff)) != SIGTRAP);
 	if (unlikely(task_work_pending(current)))
 		task_work_run();
 
 	spin_lock_irq(&current->sighand->siglock);
-	ptrace_do_notify(SIGTRAP, exit_code, CLD_TRAPPED);
+	ptrace_do_notify(SIGTRAP, exit_code, CLD_TRAPPED, message);
 	spin_unlock_irq(&current->sighand->siglock);
 }
 
@@ -2504,10 +2507,10 @@ static void do_jobctl_trap(void)
 			signr = SIGTRAP;
 		WARN_ON_ONCE(!signr);
 		ptrace_do_notify(signr, signr | (PTRACE_EVENT_STOP << 8),
-				 CLD_STOPPED);
+				 CLD_STOPPED, 0);
 	} else {
 		WARN_ON_ONCE(!signr);
-		ptrace_stop(signr, CLD_STOPPED, 0, NULL);
+		ptrace_stop(signr, CLD_STOPPED, 0, 0, NULL);
 		current->exit_code = 0;
 	}
 }
@@ -2561,7 +2564,7 @@ static int ptrace_signal(int signr, kernel_siginfo_t *info, enum pid_type type)
 	 * comment in dequeue_signal().
 	 */
 	current->jobctl |= JOBCTL_STOP_DEQUEUED;
-	ptrace_stop(signr, CLD_TRAPPED, 0, info);
+	ptrace_stop(signr, CLD_TRAPPED, 0, 0, info);
 
 	/* We're back.  Did the debugger cancel the sig?  */
 	signr = current->exit_code;
@@ -2891,7 +2894,7 @@ static void signal_delivered(struct ksignal *ksig, int stepping)
 	if (current->sas_ss_flags & SS_AUTODISARM)
 		sas_ss_reset(current);
 	if (stepping)
-		ptrace_notify(SIGTRAP);
+		ptrace_notify(SIGTRAP, 0);
 }
 
 void signal_setup_done(int failed, struct ksignal *ksig, int stepping)
-- 
2.29.2

