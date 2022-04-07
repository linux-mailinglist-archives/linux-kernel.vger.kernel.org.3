Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA9E34F891C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 00:14:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231739AbiDGVgZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 17:36:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231700AbiDGVgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 17:36:16 -0400
Received: from sonic313-15.consmr.mail.ne1.yahoo.com (sonic313-15.consmr.mail.ne1.yahoo.com [66.163.185.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ABEA1689D8
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 14:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1649367254; bh=SEZ5yGN4WuR3EQqQcVrWwReXijssZ/504JFMBxTlkAE=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=OxjFgO5FNu7HGPmWDjVdGLo1IbQZWDiRhYY9gAIZobIr//qTbDkYf3mXHqF13b3henCB4KmGyrxCnWnLOE5oKH/WUtj8GaFRJrnlqM/A9eLgpytWmp4XWjrvdDhXU3P0Eip5g553xXRzB7b8MhsTzE7OW0YG1jUM1tC2/X27IUkGiwsyMRvI8wMn4X/aKai+BK9yKdjT1SFMVBJAY4jEIpsOcTiXW7lFzoZ4vuSjRq7qctaTV6ZhV5egOg2dU9ud64naIhbiApaSjCkCI/+lHsNyHYVHSdmGrNQfB0VqAPl0uI2F1Wr1Wn3GSNYwm3er4/PEnxaNskX8aEOEG+NNdA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1649367254; bh=gyoGcpqhfUaUn3DouNq/+OpFsIwiNpCGGOR8up2BNDC=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=SSLHvZ50Zl+SLJVStEUGJqcuTqgKUA1UC9O45VVKcOBJFiSk8b8lmnEUDF9PlSRbRqmvPCQkvyIdgmjgZsCObxWlJ6toZXrhUTJFKTxftqdUbqvuJKQM9lGsv+k+VnU1mHaZOd1aSr6Xdm4m8F8rNVxtDf4XoY8LRtkZhetY+E/TC3yvcjBYMb8uALQpVEgPwiPv7+F0wE2VvbJVOujA4TumASJ8A23uupnvUpdQaouwbPsME7s8euQr+CEi2WZIPqSMC3ouwwyBivBPj6v9z/Ofy5+OH5kUmGiGdu1ZyQGfUFTuOO2CZ0Usfwp02fmLBRIxwwWqb34XpHRiVuOfNA==
X-YMail-OSG: h3YV5JMVM1mIqYMGOWRra7lEwwnl9olEfqfZq2cfT8Wg4b2TQWqkdfUB_Z6ajmn
 ALHxcx.d3Km1.6hVTJCV0Bhd6WunYEw8k78VMgq7pW.QyxvqWFln.hJcyxjaUm00bLnKx9Zwhysv
 wTB_kN2C3pCpyYudwTN8nnwnSManTHqcKjSd0hw.HyDQtyU_q3Ln5dz_wMUlRm.gQjvYlPf9y6PN
 3yp3Lvlb9tka9FiKlls16YaJZ3pAuLTxd7R7cXv7eJyeu_okX0kn27f7dUjJX8TfhF.EmKHgZE4Q
 bCOhVqQhFqw7wcQHKYSgEm9ev7YwbqcMSoPkwLkfEqieeMk6EhYE0HWlNgEUotaQBkonDX0jrMBP
 ujH4ZFBBJe5NBXdtx47WzpJgoQiOxf3mE2VnvI5FlwPcwLcvyziBpOzaISRoCYKdsbGpNHgERwEh
 5RhlwtS5h96ZtEIKpynfhwcQk67IAgXjUp7xhvqgaSUnfuteF4Rzjum4PvzhilmsWeDABt7Qd4fd
 YqeaWYJQimk86KFb20qLu6U_yf7LJU8Xl.SIIdpm_zD8B6GZFqCAhghUW8H_uLh94.R1Uk6nkCp8
 0cbeHWz88_IeGxvsiaQx1XlvhyZg95dlYi3.QkKzHaC.SNrZW8RprozIDt6JEyHrjTx0Ky7kiXRp
 CYAE7Us7BvnsIkrO34QyC3XH8eX3BOx6ljE270LD0ZBH9E301srWuZX0gCxt3sUG4LK0f9madz5R
 cjC5MkZofkzdt4kG_7U3L.S7gDLq3ihvMq4FHUamx_x0B9c6KcZl4At13dV7u_5PpigpWflC9phq
 nvUZra.fKksgsUtsPVFTFobmceyejTywR_41hOV6ou_3_bsrggijOEr3b1pSi16J4mHVA8BYFUyJ
 SZK5mpxt2CRrGrDTuRQdr2PnVfd_vzqJNOA3VdrejUmbxSpWtmMSUHy29zmsMVpJmRjfcKNCNRxL
 tuvFQAuK_x2r.LgUPHi4MJoyTXWebipBntf9nAjKXkJGOUYELjWYvwdOEQzdHid04D5NWPR4PKS3
 bS1Lw1iopeml8olmxhRwVSE2U9geAXfNgtqSorXh5B9kDGAXKwBQ7jdzJ59LV8C_XIoMCTq.Ik8Y
 eRCj2TVfDJzAu9VSnnDNWNYneNjTk5xjY_XTeNqSEOf6MUvjOZ0tWM27.spnqF0dkr5pLRxBUxuk
 cJVg3FEpGdgrC4qNTRl4zQmI29GYd2W3vhcDrkCNmvP4CG6Vc.vc20EWPOwTsDIitsL.MyI9kdSp
 OQ5_PVSexnrCXEVYxaPJM6QOJG5f93wlJ8ctn.CAp9oL_WdlJ4B3BmnLy62a9zFHh9vYBZ.U1WIO
 w7.z9.5EW9hLv3Rc2MP94CtraCIQp7d5hLkYgjoKv0iuYQNybWxYrM_OwQnGpEyCMloeEbt7xmBP
 YnP62sP8IPi.zr8LE54cauVxtAbCf0nMZV3Su2nMaBQfB.ucwStSWXxdjf.lQKFV1aJWVCcTtCQX
 o9KK.pPibQjBCODG2oq8FrWwgHOvrXL8Q2.wrF0YYM_ao.i4wQp9InZFmv8iclttcPhLLZ5s6d63
 yKNrPBrq6PCuRVBKJt2.b7JXzpEPgl_ApKotXz2.Zej_vpLLGNNoSyIwSDEe7d6ZNr1DGt2yHNKf
 PCGGTuWZdtWsTeGdP3ftBKVyosyLTb95iImnxyfT26RMOeo5PAG5NmGF2srQnSz2I6KwhjLWk.Oo
 c1nyvFyTWpBxKCGTxEKzxNriIyhpohjikUMTpWnxskylgNC7Ejlzq5JD3l5RFxh9t2R4mqHJi.I3
 QLJe0TEnq3yqxZyvtmt7YuhxlSdvxV1K_JBo.T1mkulmZWmWfJYG8JGf6E.g7bUFe7XplEH5S3mw
 9Nww65KwFus8i9BEN8HtndCjEur8dwrK5kJLsR4owA3M7ig5Z7ojHhluIDhKlAvFYtSyTOF3wZcB
 3jkSAsTdvqlGUHQQmd8zg0jYong4eUf1Kik.tiPNTajsijnT7NYXwJ_nd73ViOrO8olmmtszOK.9
 wsUrXjRgnZAefPXp9X8k8b5iruByJxh.Y4.skNcIj.GdO2XRy9S0WO_mNU6JPfqEawquX7OM8M5I
 DYcCk1kdVaSVpE.NU1A8BKr9uflxAqnsTaG6t8htYwtjoNms9S78W2lu2A.JQMrf52K.iOsjDGA2
 Jq2Zt6WbXW9kw34MfxjGFTOe1_wIZNa1El6SdiqaTlmbiCfzoBf_UBBOh9f7aRwfXuxIs4Ydb_Ev
 pYgUhuSQezN6W44ibUIJH9UPv5R13q7GqrDtH7TpYK6VEGuGa680-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Thu, 7 Apr 2022 21:34:14 +0000
Received: by kubenode510.mail-prod1.omega.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 6ea890d0479c56b8723f536561e1f9ea;
          Thu, 07 Apr 2022 21:34:09 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH v34 23/29] Audit: Create audit_stamp structure
Date:   Thu,  7 Apr 2022 14:22:24 -0700
Message-Id: <20220407212230.12893-24-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220407212230.12893-1-casey@schaufler-ca.com>
References: <20220407212230.12893-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
 kernel/audit.h   | 12 +++++++++---
 kernel/auditsc.c | 22 +++++++++-------------
 3 files changed, 27 insertions(+), 24 deletions(-)

diff --git a/kernel/audit.c b/kernel/audit.c
index 28ff7a5f90bd..6b6c089512f7 100644
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
index 4af63e7dde17..260dab6e0e15 100644
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
@@ -265,7 +271,7 @@ extern void audit_put_tty(struct tty_struct *tty);
 #ifdef CONFIG_AUDITSYSCALL
 extern unsigned int audit_serial(void);
 extern int auditsc_get_stamp(struct audit_context *ctx,
-			      struct timespec64 *t, unsigned int *serial);
+			     struct audit_stamp *stamp);
 
 extern void audit_put_watch(struct audit_watch *watch);
 extern void audit_get_watch(struct audit_watch *watch);
@@ -306,7 +312,7 @@ extern void audit_filter_inodes(struct task_struct *tsk,
 				struct audit_context *ctx);
 extern struct list_head *audit_killed_trees(void);
 #else /* CONFIG_AUDITSYSCALL */
-#define auditsc_get_stamp(c, t, s) 0
+#define auditsc_get_stamp(c, s) 0
 #define audit_put_watch(w) do { } while (0)
 #define audit_get_watch(w) do { } while (0)
 #define audit_to_watch(k, p, l, o) (-EINVAL)
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 6fe9f2525fc1..557713954a69 100644
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
@@ -2066,7 +2066,7 @@ void __audit_syscall_entry(int major, unsigned long a1, unsigned long a2,
 	context->argv[3]    = a4;
 	context->context = AUDIT_CTX_SYSCALL;
 	context->current_state  = state;
-	ktime_get_coarse_real_ts64(&context->ctime);
+	ktime_get_coarse_real_ts64(&context->stamp.ctime);
 }
 
 /**
@@ -2535,21 +2535,17 @@ EXPORT_SYMBOL_GPL(__audit_inode_child);
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
2.35.1

