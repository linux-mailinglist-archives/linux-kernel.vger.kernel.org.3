Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 589EB55CA8F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:58:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242946AbiF1BMQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 21:12:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242914AbiF1BML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 21:12:11 -0400
Received: from sonic304-28.consmr.mail.ne1.yahoo.com (sonic304-28.consmr.mail.ne1.yahoo.com [66.163.191.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACC9823157
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 18:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1656378729; bh=InEC/Dlj45Rmt1XgQ4CVXncaUv/yIXFfOXA+eTyZaUQ=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=ZMOq+jHSUdRNYds2/BA5q5obYOGJAreOTi/LuFy5W4VM+SfsTIwx1+HSJK5Z3ULKIoh5Kfj7mDJis/LVog4IYKgawfKeaC6eVmt/9iT64k8zHiDbps1af3YoDKP4VSx5Kn6YYHkqSmTP/ou7xeIbvYsR+dvGVSj0V2herWlKVTdTStqeAfczuyTFxILu0lYaleATsaKfMZO8Abdn2D5ea650RiaBYUIOHYo5//vO/M6qMFMPykslXJ7VpddaDjHaPxxEj+Rat5hk32S55f/aGFkG5oqPgGRWzaAfTJIu6DJMvlXRChjbShkUcoIDLwdU2lWgpnZ33iVHJrI5g5CGkg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1656378730; bh=CMbH4bupjS3KFjR/bKuDxNAngRvRhOLHNzqnfa84occ=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=CYUNHFN38GB4znmab+qxSG7uNlV3xaXRB8RJddxD0Ps3bp208IeR0AvlR4TIRDNWZ2X+6JDyGo7wOI9eYoi8CJSiELGQKpeI1mt0HLPJEtnCwUFGJ/J51QyUsu0Yi84olafHQbG9VfnhbfCRC4sgDl8MshCcRJSrAbgvsJ+cxuKArVO8Li/sk/k5fxcO8kHoOe373z9keo5LpQmsKUQcJRaeyIx79Qm3rglK1KdNKYAGV/L9+XWOVJ+0D9gp0QqqA7s+4+JpLF2LRYqyqZPd3I/IcO69xAjEDW7rA/UYZdGnK4RAAuoXddWBZu313o5ncS/LdhZmnNa+Jvq/uwibNg==
X-YMail-OSG: 2ZZFllAVM1naRVlhfjcm3GF6Sbx9OPnb68kixcLfB8gXMxaMxbY6jVHxqgaOpYZ
 b9nN31DNxYx6eu8PjcAj3vjhbdZ2nzMnUC_2TvfoovV5OOI4pR.jMSi2rOtSd.ll.MVR1RhZdYm5
 ruFjhwPzIfu2z__MVoy2WZtNP1tePEVnym6n1uZ3IiinjRIOWSkwjV2q563Cs9Zo6I6xC7uLA0Yy
 m_Kvw0NXf_9u9SxjfE6eJCO5h0jFBCDNm4dJuQkq.gmrNCnm_XgVnqGPCEEIWPTY7KyC_kF8NogG
 nEMX6a1IUPA2LBFGMTwT1SOKAl9vzLKn37ERh3N7lCO97aLWAKOy_b7VhbSV3TTU9f0F_5IJll0C
 w4ZzbVlB78_l9lSZll9bxr3SyhCIRdiDMsWNh_nszM_OhZqoad9ymKTEzUjYxjReTCSLahhfXCxv
 jJ_8tiRY2_Njh4lTlgQyyrUZtP12gI7cZLfLpfqD7Ny.LHKnOmO6DHKzp.PrtQ61nQocF0LWmSCD
 tBhCXDQM2YEk1pejzxOHw0k1bN3CQ5fH749o3BRmhBg3sQnbvIiaix6ILo5MAXFm.hnPynRENeZ5
 9CcHvPQCz2j6roZFJZuQpjWXBx7Eu9QiyIb9PjyudkSAnu93l7hIel9WFX7AgnPuxkC1ijAgzpUr
 S1ntY2v0q2nfqO1iZ3n8Bi0BZAvZpESE.J3kpEsK73Gboqkccbjc3b_KzHkU9fHTMydUS8izc0WB
 FpyNbJTacPBRaE62rFzvu7sXfQN60ttz4NLUowV4KevzjrbQxyGzpYwsNi06uN_TYn6vvVZB8Lx3
 IX5kGjM2zKAQvko5Aueel0Q.2S5lCgfJ.3bFdiKJpkcktS2Nf_7C7KLin2rfEoi7KkqMBxbJO9Yt
 boxMptRChTuQ99Oac5xUAV_YEI0PhQ2b2kf4.sS17Wt33sdW2LkknWaGR6idMSLlhuDCiQ9SBA1e
 DK2DQ50uaw0dKKC0UZs70XXGQiQomKOSZ4P.ul5iOIWOLH6zAaovOFJSqSAacsPmljy1i5SAhQqn
 dhSIskyhaWlG2VSXaDD3tWWrrMDJpGd.2bYl2ik0cdcf57PHpfYba9plaKN5vOduuOugB8R5oP2W
 jTF7yAQx8yOg60HOMPamIsNDeXlKFaLHjVyfYdRiA2NYj3loi14E2jqR3lEDB7djGAgihuiJ.Xgs
 snQcM9EPlG6BgLGUajKUByRGGj8ZuXraVSjfWDJbsotV._jY3fDpZj3UK0XTKuryIILajkT15zpN
 e7fIF7xTz1JA5UHSnLFiPBRl6FvOFytp4KycGxLDyFd.kzeehTNsdtn4H5ZXu2NJYeR_oNBoNAAq
 c_31VsM.4XL9JVEY6e1d0CKLlFeJpk1CpCPaZ33PaZovgFaExOlS9wvFjO9Dlw0DZWivILdvN6y7
 j6CBRi_GAibSAnRSDVQvdUvTRHSPbSKJf7.mTB5QUjCHGzAFIaLZ.PpF17KN8mioE_CH5cZ4HrPE
 .BtRQRJRtHcg2lPE7iNagGGiyCGmiaBO.F38I7hRt6FZjZNHiIM3MOMcUaOXA2hS6Ot4xIIVnAeE
 Jcvt.R2aE4tIfR2Kf2RAKXZcbrVqcC6n.I19bK7VZ5FJ7CRuVQgVcP8y7kTTgfRGdQAe896Rdid_
 aAhlS8JXrY0rk_FRvqvgKHxaM8OcgscyrifccgzKNOWqX1_nWdMY7XntFuxZQ0gSrVYhPmMLLHZv
 IP3mjC5V_ZtyNXqcOO4RQvuMHi7viR9yV5TRz3xoKIJDUXlz0LZADrWPRP_XaSi4Csv8zBo.jd4H
 cOUgfMM82RHcdhXgQ26KgF3ZA10zTWbctET5UaKAo4O.65PlLVfCUbodLBLwd2mrZwiDRzR4K5v4
 srUD702.dQe8aKXugFiOmX4BkuhhUm5jiwp4C2OTQ8XqoT8OP8LDpLW60_8.oXW9NLwYOFYR3MiI
 h71qCrrk4q4fg.Wj3hoofHGOeiHMn4fEqoLlLSjnuqzQq4uex9VgXn913VMasvvFJHBY_vA6hoOw
 2Bct90NP7au.RMp6OtEfXFgyQPODiAWvRS4EnqDsTcnuMdFMfDmWm.TQLZxhQnsvszbNA0zqWaOz
 TEk14gOGs7fHBaAY1hQksqNXACKmVfWUtQpl1PB_Rs3_0k6g9DX5vBV5Eqf7fRb4IgnP_FdSeQiO
 qIi_JAWw.e5Rg7U77JqYpcKR.A6zgDkggZslFHpztoiVqGCjeaqtYZE0Py93w86GZlVWGD58C6r8
 1C5Ac7lTgAQUoo8RilOCKHKOVWUe58eTityeYpcptVTf2Ah8KRPpMU17yew--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ne1.yahoo.com with HTTP; Tue, 28 Jun 2022 01:12:09 +0000
Received: by hermes--production-bf1-7f5f59bd5b-zv7ms (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID f1d422e5118ed4ad306a52cf19212beb;
          Tue, 28 Jun 2022 01:12:07 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH v37 24/33] Audit: Create audit_stamp structure
Date:   Mon, 27 Jun 2022 17:56:02 -0700
Message-Id: <20220628005611.13106-25-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220628005611.13106-1-casey@schaufler-ca.com>
References: <20220628005611.13106-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the timestamp and serial number pair used in audit records
with a structure containing the two elements.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Acked-by: Paul Moore <paul@paul-moore.com>
---
 kernel/audit.c   | 17 +++++++++--------
 kernel/audit.h   | 13 +++++++++----
 kernel/auditsc.c | 22 +++++++++-------------
 3 files changed, 27 insertions(+), 25 deletions(-)

diff --git a/kernel/audit.c b/kernel/audit.c
index 99439dcc75fc..e4ee8ee63484 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -1822,11 +1822,11 @@ unsigned int audit_serial(void)
 }
 
 static inline void audit_get_stamp(struct audit_context *ctx,
-				   struct timespec64 *t, unsigned int *serial)
+				   struct audit_stamp *stamp)
 {
-	if (!ctx || !auditsc_get_stamp(ctx, t, serial)) {
-		ktime_get_coarse_real_ts64(t);
-		*serial = audit_serial();
+	if (!ctx || !auditsc_get_stamp(ctx, stamp)) {
+		ktime_get_coarse_real_ts64(&stamp->ctime);
+		stamp->serial = audit_serial();
 	}
 }
 
@@ -1849,8 +1849,7 @@ struct audit_buffer *audit_log_start(struct audit_context *ctx, gfp_t gfp_mask,
 				     int type)
 {
 	struct audit_buffer *ab;
-	struct timespec64 t;
-	unsigned int serial;
+	struct audit_stamp stamp;
 
 	if (audit_initialized != AUDIT_INITIALIZED)
 		return NULL;
@@ -1905,12 +1904,14 @@ struct audit_buffer *audit_log_start(struct audit_context *ctx, gfp_t gfp_mask,
 		return NULL;
 	}
 
-	audit_get_stamp(ab->ctx, &t, &serial);
+	audit_get_stamp(ab->ctx, &stamp);
 	/* cancel dummy context to enable supporting records */
 	if (ctx)
 		ctx->dummy = 0;
 	audit_log_format(ab, "audit(%llu.%03lu:%u): ",
-			 (unsigned long long)t.tv_sec, t.tv_nsec/1000000, serial);
+			 (unsigned long long)stamp.ctime.tv_sec,
+			 stamp.ctime.tv_nsec/1000000,
+			 stamp.serial);
 
 	return ab;
 }
diff --git a/kernel/audit.h b/kernel/audit.h
index 4af63e7dde17..44cabf7ea660 100644
--- a/kernel/audit.h
+++ b/kernel/audit.h
@@ -99,6 +99,12 @@ struct audit_proctitle {
 	char	*value;	/* the cmdline field */
 };
 
+/* A timestamp/serial pair to identify an event */
+struct audit_stamp {
+	struct timespec64	ctime;	/* time of syscall entry */
+	unsigned int		serial;	/* serial number for record */
+};
+
 /* The per-task audit context. */
 struct audit_context {
 	int		    dummy;	/* must be the first element */
@@ -108,10 +114,9 @@ struct audit_context {
 		AUDIT_CTX_URING,	/* in use by io_uring */
 	} context;
 	enum audit_state    state, current_state;
-	unsigned int	    serial;     /* serial number for record */
+	struct audit_stamp  stamp;	/* event identifier */
 	int		    major;      /* syscall number */
 	int		    uring_op;   /* uring operation */
-	struct timespec64   ctime;      /* time of syscall entry */
 	unsigned long	    argv[4];    /* syscall arguments */
 	long		    return_code;/* syscall return code */
 	u64		    prio;
@@ -265,7 +270,7 @@ extern void audit_put_tty(struct tty_struct *tty);
 #ifdef CONFIG_AUDITSYSCALL
 extern unsigned int audit_serial(void);
 extern int auditsc_get_stamp(struct audit_context *ctx,
-			      struct timespec64 *t, unsigned int *serial);
+			     struct audit_stamp *stamp);
 
 extern void audit_put_watch(struct audit_watch *watch);
 extern void audit_get_watch(struct audit_watch *watch);
@@ -306,7 +311,7 @@ extern void audit_filter_inodes(struct task_struct *tsk,
 				struct audit_context *ctx);
 extern struct list_head *audit_killed_trees(void);
 #else /* CONFIG_AUDITSYSCALL */
-#define auditsc_get_stamp(c, t, s) 0
+#define auditsc_get_stamp(c, s) 0
 #define audit_put_watch(w) do { } while (0)
 #define audit_get_watch(w) do { } while (0)
 #define audit_to_watch(k, p, l, o) (-EINVAL)
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 4f141655ac0b..539469bf1aa3 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -992,10 +992,10 @@ static void audit_reset_context(struct audit_context *ctx)
 	 */
 
 	ctx->current_state = ctx->state;
-	ctx->serial = 0;
+	ctx->stamp.serial = 0;
 	ctx->major = 0;
 	ctx->uring_op = 0;
-	ctx->ctime = (struct timespec64){ .tv_sec = 0, .tv_nsec = 0 };
+	ctx->stamp.ctime = (struct timespec64){ .tv_sec = 0, .tv_nsec = 0 };
 	memset(ctx->argv, 0, sizeof(ctx->argv));
 	ctx->return_code = 0;
 	ctx->prio = (ctx->state == AUDIT_STATE_RECORD ? ~0ULL : 0);
@@ -1950,7 +1950,7 @@ void __audit_uring_entry(u8 op)
 
 	ctx->context = AUDIT_CTX_URING;
 	ctx->current_state = ctx->state;
-	ktime_get_coarse_real_ts64(&ctx->ctime);
+	ktime_get_coarse_real_ts64(&ctx->stamp.ctime);
 }
 
 /**
@@ -2072,7 +2072,7 @@ void __audit_syscall_entry(int major, unsigned long a1, unsigned long a2,
 	context->argv[3]    = a4;
 	context->context = AUDIT_CTX_SYSCALL;
 	context->current_state  = state;
-	ktime_get_coarse_real_ts64(&context->ctime);
+	ktime_get_coarse_real_ts64(&context->stamp.ctime);
 }
 
 /**
@@ -2541,21 +2541,17 @@ EXPORT_SYMBOL_GPL(__audit_inode_child);
 /**
  * auditsc_get_stamp - get local copies of audit_context values
  * @ctx: audit_context for the task
- * @t: timespec64 to store time recorded in the audit_context
- * @serial: serial value that is recorded in the audit_context
+ * @stamp: timestamp to record
  *
  * Also sets the context as auditable.
  */
-int auditsc_get_stamp(struct audit_context *ctx,
-		       struct timespec64 *t, unsigned int *serial)
+int auditsc_get_stamp(struct audit_context *ctx, struct audit_stamp *stamp)
 {
 	if (ctx->context == AUDIT_CTX_UNUSED)
 		return 0;
-	if (!ctx->serial)
-		ctx->serial = audit_serial();
-	t->tv_sec  = ctx->ctime.tv_sec;
-	t->tv_nsec = ctx->ctime.tv_nsec;
-	*serial    = ctx->serial;
+	if (!ctx->stamp.serial)
+		ctx->stamp.serial = audit_serial();
+	*stamp = ctx->stamp;
 	if (!ctx->prio) {
 		ctx->prio = 1;
 		ctx->current_state = AUDIT_STATE_RECORD;
-- 
2.36.1

