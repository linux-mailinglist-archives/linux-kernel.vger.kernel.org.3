Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B5284A7CAD
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 01:19:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237799AbiBCATo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 19:19:44 -0500
Received: from sonic311-31.consmr.mail.ne1.yahoo.com ([66.163.188.212]:41715
        "EHLO sonic311-31.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231140AbiBCATn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 19:19:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1643847583; bh=dTXhzuopyuHsOK2uVsPAMqd3JMR3iQuSAYWnNMHmUjA=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=C8WFVKWM6f5ndaMWK/xGSzm9YZicZLxsQy1dU+DJ7ziYo6x/GKGdwquMa5kkg2DOr2Hkw97f4hJiB/8LfOJmvEDu6DQ6eDsY1A/DBC3zSmas5mIVfuN1pHvIrr77K6PGRXOuwidRB6BTyp5dENDQTS9sRc6vSpJ1NQFfn3eZZjlk9pC3nC3Qc60hKvo1ZQj59nZGV2vcdtVFUfqIED94EdNDT/Z9iYLa5QH3VDaU+nspsT51iyaVuGSyGeGICkQUt4Iq8u1bijwP1ohwl5rItlBgOb7xF8qtbmmu9VXaQsNuwWeEHtjncF69wDCiYwmCo0B2RYnSnCXaMNT17/5sHw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1643847583; bh=GUdEHeKQnehuObU/+xRpT++4GRAaJw0MtJrMdOM1rWB=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=jKJkiX3IK/71pvdQB0HfHtNwvP3rKa8jkwrgxnCrnUbd0xlLcdfJsLctJ0h6ZTQH2HGhBYaRmoBpbS2aXLNXs4emXmkRtYdGxPefZvlq4TKs+RP2HmB9bGDNfpOXP0JYuoPVJM9KpW9DM77wCGKXQeG5+/Wt2zeenYB0s1wqstmgv2ZYhOnEUEbFGkGshtdWjVe1bXpr3yk7uhBHpwu/ea3wK5g1tNXePcNC2EltZdxHgmVaufkQa5sZNjgcdijiwqaRD+pun7Hc2whYgei4FUWzXwhMxE92Gi1Ro8zqj/tdVVmLTClEjTapQwER6kEBXZl5WWb4ahnJLG82a9CgwQ==
X-YMail-OSG: uaWPX.MVM1lKC0x6uDxJ8xMXL.QTVudtUa67rnuVjdxQ8m3D4h45PnV59YSWp_m
 EBCUp3jsZRYevzOtyjRVHpkouXnoWPGm7402YoonNlHE40KdzS6.d1QnF.WpLCaC0h2stU1VRhlq
 HM5GYNk5fJNP8Su1fo69jdwYlk_OrLMlLPWOxFOkQ7emtNWdnpOM2gBdnQ8LTNlEwpdsboqp4gaJ
 .Znpk8ECwyPT4w6axBZ2Htc_fLVIjBOho3Q_psQ9ZLP2YlpGwUPXzwY4fRjnn615.h6CXFCBnkvd
 cGzdK3GLRgU4mCasLrvDwQ4PC8tyAwM3p0vBLWVtS6n4dTbxIi..44QOIdqHfU6y6JB8aWwoSp6c
 pvVVIY7RPevMXrTEtdJnx2agfC7X3DAnp9xAbYcWkqH8UQYecIj5511fTZLdKmbu8XVdci14HzIo
 XoHCnBtNNWlN3fuwyqcafyhZUoopyaE7hJ2nboer5zCps6PbNF1nl4qVBOgJ9.VbFqJxpXrTxDIj
 c7ZCZLXHq55GIJwPmIlfTW5nmVnVauCfTDwhFGx62wJS.JxhQOatJtny6PnMu2HiGEKMJg53rJ9D
 agdBsdCGPU9fTS1KH2NGuoT50m_nO_eon_CVynUT7Ko9wCrHvFCPy8l68fLF6G7G8CtnIZhReec.
 1Mno9z3WRmeUKznv1pOyyrd5HPUpaua1e4NMxu005vumcNUezl4LuteibJJVXdcR9CQdrea58n1G
 z307Zym_CWRWkKXgWue8Sdo39Ke8SzoGbQVLeT4jBNspkWWK5fT7fN2IEDFpcTyPB32dotwv9I2I
 NzWjOwp9vuOsY6bb7O.shrWz9DY.p8.BeEb8okX8QhU1sjrhNw_CCe1iWnxjcHJHPD5L94I_z.hy
 OEfBaE8A8ntOCzNUtzxsvPTkNqwxKXLobFDBQPzwFNchtNfMWalH4y4kP7AXr2qD3J8oEQ956CkO
 lVwTwTbMbDbbfrQ4UOfXxjSHyyrtqZpVj7uAyD2XTC59tAuBdwDOGzAYTHTVYLB1aFCPvola25qQ
 S6sE0NuYrQJsbB3xhXdgDb2hoMgpaetioVCS0t8V74IdURol4fYxfxkmVWQ2PLE03S7y38JzxwA4
 U6d893PhmGnTTwgTyiPbU8qbtWraEbLKKSyi6TXBSSOeSq4YTpkIa0wYp76ryIpYEUnfuSWptmnR
 _dLxMauniqar2lLXyQrE3ncycKXBb3Lb9SCOZ5pA2PNbvNSKr.Abjkpa9uVi8KSjTk1fm4zdby1G
 kd8BpFhdeLfS8q9Ovau0UUenMHaMFPPea8W55stQqkRJP.j0rBy4eaH0BAr0FQp1DnwwuIZjacLF
 cbzPfy7ixKAhn25efXWsH.nCib2Af7jg3dohWoGjGEMlRb2yQTAKlyu1ao.28xzZgqMauNcXw5RA
 1iXYhmdiTDQqmf0hmPArB._6p9rIrVG51llShw8zsJ7J0ywppscQA9yt1E18wkZGc.zWzew4jysr
 VElEa.OVJF2JQ58pHwXPDYJVUo489IBAIaOGwsw3iP80L9s.Z01aGt3D5kCet0Mzp8lKbNmbFqlk
 JM8D6dTJskV8ezvWXcDtfX2cY7mqZKCenjxyWW3biP1CHXEen1XvbGifwxCUNDIYlTK1GvJonbfv
 OLvsbv8ije6aXnnJQCo1mCFIuSmY2WycY229XJFqFm1Q1tGdGipka4spvMjyKlNYllJrjQmE028x
 wfaET7wGcPMrRvZzBxuWvDB_18c.6rYxQGhMk5vu.6PG3iYBQNwnIaY9Sh_SbvgeuH3_r2OlNa3v
 8c4cJ1PSWjKpJi2HjWpvs4lWvHi_nOuOQw2CDm6BUffE91TuDuxgiP1XUu3jPEHS7kQO3M8fvdt9
 SPy1DiUL5GoM9PeV__xxI.BeqZJo7n4fwJTpWzieKqBiij_.LXLgVVhl0h3LWjjVjuwXV30k2piJ
 hdlvV8PZHCEdzMENe1r352fD7GFWk3n5AKi0H_WasX49AHVYU2LLAINcvZJkSSnKRzhpMPOsKscG
 NHkkV.byROjBJXzE03J12AVQGDw9XYVTVFqeKVQnPJsKnnSQPg6W5X0U.nBrveYQj3VodaNHRsRI
 emx1p_q_aDFobAjW9MzWD.SWqI4LhiaJtosJetJVQtAOixn5EX9z0wVPDcZvklXiVT9I6i.BMp4e
 tafwIaV2ALNC7zZ6ZzGFAdFqagKXC3q3oni5il9QPuzlI4Bz57vmTp7Tup3gTPSd4J0AyJZ4omVu
 lIm0CjTzrnS7w5uRWnFw8ZDLbhaqhMZV7q6pPO9udhz4LuskZ.Q--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Thu, 3 Feb 2022 00:19:43 +0000
Received: by kubenode520.mail-prod1.omega.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 1688eb5d75ed6a9f47d4047264beb981;
          Thu, 03 Feb 2022 00:19:39 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org
Subject: [PATCH v32 23/28] Audit: Create audit_stamp structure
Date:   Wed,  2 Feb 2022 15:53:18 -0800
Message-Id: <20220202235323.23929-24-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220202235323.23929-1-casey@schaufler-ca.com>
References: <20220202235323.23929-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the timestamp and serial number pair used in audit records
with a structure containing the two elements.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Acked-by: Paul Moore <paul@paul-moore.com>
---
 kernel/audit.c   | 17 +++++++++--------
 kernel/audit.h   | 12 +++++++++---
 kernel/auditsc.c | 22 +++++++++-------------
 3 files changed, 27 insertions(+), 24 deletions(-)

diff --git a/kernel/audit.c b/kernel/audit.c
index 0fad7317cb09..f012c3786264 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -1798,11 +1798,11 @@ unsigned int audit_serial(void)
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
 
@@ -1825,8 +1825,7 @@ struct audit_buffer *audit_log_start(struct audit_context *ctx, gfp_t gfp_mask,
 				     int type)
 {
 	struct audit_buffer *ab;
-	struct timespec64 t;
-	unsigned int serial;
+	struct audit_stamp stamp;
 
 	if (audit_initialized != AUDIT_INITIALIZED)
 		return NULL;
@@ -1881,12 +1880,14 @@ struct audit_buffer *audit_log_start(struct audit_context *ctx, gfp_t gfp_mask,
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
index a2fca1134519..56560846f3b0 100644
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
@@ -108,10 +114,10 @@ struct audit_context {
 		AUDIT_CTX_URING,	/* in use by io_uring */
 	} context;
 	enum audit_state    state, current_state;
+	struct audit_stamp  stamp;	/* event identifier */
 	unsigned int	    serial;     /* serial number for record */
 	int		    major;      /* syscall number */
 	int		    uring_op;   /* uring operation */
-	struct timespec64   ctime;      /* time of syscall entry */
 	unsigned long	    argv[4];    /* syscall arguments */
 	long		    return_code;/* syscall return code */
 	u64		    prio;
@@ -261,7 +267,7 @@ extern void audit_put_tty(struct tty_struct *tty);
 #ifdef CONFIG_AUDITSYSCALL
 extern unsigned int audit_serial(void);
 extern int auditsc_get_stamp(struct audit_context *ctx,
-			      struct timespec64 *t, unsigned int *serial);
+			     struct audit_stamp *stamp);
 
 extern void audit_put_watch(struct audit_watch *watch);
 extern void audit_get_watch(struct audit_watch *watch);
@@ -302,7 +308,7 @@ extern void audit_filter_inodes(struct task_struct *tsk,
 				struct audit_context *ctx);
 extern struct list_head *audit_killed_trees(void);
 #else /* CONFIG_AUDITSYSCALL */
-#define auditsc_get_stamp(c, t, s) 0
+#define auditsc_get_stamp(c, s) 0
 #define audit_put_watch(w) do { } while (0)
 #define audit_get_watch(w) do { } while (0)
 #define audit_to_watch(k, p, l, o) (-EINVAL)
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 47d34433b91e..7848e7351cf9 100644
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
@@ -1898,7 +1898,7 @@ void __audit_uring_entry(u8 op)
 
 	ctx->context = AUDIT_CTX_URING;
 	ctx->current_state = ctx->state;
-	ktime_get_coarse_real_ts64(&ctx->ctime);
+	ktime_get_coarse_real_ts64(&ctx->stamp.ctime);
 }
 
 /**
@@ -2014,7 +2014,7 @@ void __audit_syscall_entry(int major, unsigned long a1, unsigned long a2,
 	context->argv[3]    = a4;
 	context->context = AUDIT_CTX_SYSCALL;
 	context->current_state  = state;
-	ktime_get_coarse_real_ts64(&context->ctime);
+	ktime_get_coarse_real_ts64(&context->stamp.ctime);
 }
 
 /**
@@ -2483,21 +2483,17 @@ EXPORT_SYMBOL_GPL(__audit_inode_child);
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
2.31.1

