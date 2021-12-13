Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6FFF473947
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 01:06:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242240AbhLNAGI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 19:06:08 -0500
Received: from sonic301-36.consmr.mail.ne1.yahoo.com ([66.163.184.205]:36640
        "EHLO sonic301-36.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232817AbhLNAGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 19:06:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1639440366; bh=4mvg7Rjk4Ibg4L1ov7BoS5y61Y1g9bKqY43cFqldVy0=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=oxXeYIoWifqcttMDNRDaXGDTfzq7qWxdkZw4++8TW+zvT3eHda7Z1VAJg0u5nJO7a2TSHFhMjXT66bwWj/XuMyF4WVjMDadeB9DlNQOSezy/SuvxaoEsVxmULWn8ooaoI7qF4fHHeh6SvS4tVnveG0w/+wFBq0SbS3/TtP/qOuQcDJIq8bnMhEGeiwcfGOd9zMhfeVV8hA8DO4okhMj9SwiyigGRVw7eK6mljNicDaVTIPqXWvnJGHepiOfXxklTdmS/qU94YGAZbf/9rvDsBhGgAyEdpZIsDqu/1qDv0c/qan/0WUZq3Fjbh8Epd07gMNpwYK3tm1qDiMBpY9Xwqw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1639440366; bh=03kpnv+mxwiHlvUCxlUlDHsopy3/CccvSy7/qz0V61P=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=shj6+oL8LYGM8vykr1c+xq39GwL64JIhpU0cRVbGMvb52DjNfiLtHEsEaCENyLJfKmeMqFxHKxfNOs/QUElBKr2qNcsCB5JTAmJ7FwEg9YOrvlYBwr36nK92kGfRaXQrhjBKxnTt9wp7dZ5GCzr/G1gXcasX6jJH2vini7TG8tG/MccKRgpRSMmCl+EPEsRIOAvQtwEjUK4dmHSPNnWqaTWWQs9zmcppVDeTPDZ2wL9bOpmDQUzE+K6/vxG1WhtjrIrU/7yZXmqqBJEz34YfpIyVTlxHPDVKH38d5x8eFr/XrVTAG5VoScoUQMF2H4o1hM1SZ2no+pt0tF9PmM93cA==
X-YMail-OSG: CaIX9akVM1mVFs4ZCJVLZ0sBOYwLL8PFJEeP4OHGJe6p5JJwY2VxDOmBT977skt
 Se3yyAJrsRr4YOEIawFe2iEbsKa58FzMBXYixVX_KGRlVzZyukiwTR.4LUNpqvL0GXRsT1GG9zfX
 bPiw.xAsX2VDuboR75zPKsu8zV5mZBQX26MO0X1j0F1QcZQFjAmdzyNDxK4YY9sxSPw_DvqUNIqS
 zbRajpO8JV0PRRfB0qsGJmIIoaiGqGr1NjblPZ5UBmYLAkqUROtD3MGOShs3xhIC_a5yqaPHSM6P
 H9z8WBINTKDI0j9k5WSMNhfaDPeaEEZtQjLSb_8DAdSLQIwUf9bnh1AsGZ7zyBfvblaOtP7rw1_6
 27qf0JEhDlyNmA3ncmlA9Q5xPmg.XntLq5P1Ue9XPO8_1iFQinQG6k17Q6vU_8ziIJ6F9iOTG5RN
 LFMw0yRGxjqqhV0X6AtnzA4YFlmYrYBJ8giNva711B1M77jGIh1UnL3i0K8y6KkW4qmkV8a.xiiF
 ySJa9cFFzbSB.YJlncnMt8JcuWIrUi2WZDwkc2VcteYgduVPCWQGc2D9iDztRnmQFx7m3RLutRju
 ut7CdKHW_rC7aiREPr_uEEYklM5ay3GyKEVZG.1FUBJBZyCoKHFgn4c7ehigsSUTDk3Y.nkKXTSv
 Csn6qwM7ERB2jBbgO23BwadjWsd1HBSzBJcNI3MD8026gV7QCQgIUw5TzD9wzqs3l0siOvUpXH4g
 t2X4O7p0L0.0eGUvsuDYlAMZLRKtGYXMb0QzRYkHozebrEpndKwpPkMBG6C1AB5QmSN9jBry8CPm
 SUX_iHEBw_InjBvQ_Tdd2O_9pXnP7nr3Nz28rBZZ3Lf3AMBO6wGznGqdTeO7AU4_amPWU8ctjfam
 AYMjt3TbOAVS71AHrPMdU2f.QLfV1ORNfJglz8kkqKtnhSTE037xIRN_IzJb0HcGLZPY1b4gFo6i
 zCNuPcif5b0MaN1rHe1KksGjD3uhpPEzFC2KMYm6OM6WqfPsI8sDf36psALgolT4fuY8JpGktWZ5
 PZe68RSqQIK5rz0iRyUWuoouDAYzCEFLVEbzfrw6.dJ3CFPbBR1Gyywgub10FtD.kU87HcMJ9wbA
 TvIth4kM9ZMz9Gvu5lj2gSnD8DWY464HvwD7dArMokxm2vE3Pftf7YAKbdx98VuG5G4axFjQILEk
 JiKtvQ0DlaiiNcdqot5rvOXF7vOT2xmU5U__BuiOBbfqe3zJjiuKSYeqPfqQgTDFP73_7fF0cBM8
 NSd.IWfuZ12AqKx4WXv2tVY0f8YULV72kbP3dNNCNjPfvrErnNUVV6vjWK8UEDa1qnA8Jm1qkvCB
 An8WgnIVJHmrWijfoAWnBPfqW1A4QivJkCRf281XorTuQH9.flYWMBWTjS2xwggZIWoizDm8mVQD
 VddPDq1MxnlvyzPRT27KAA_9nc9xu.ehPBgN5ivCLWu5pD4UXZZFyG6EE1z3t6T5WIM_u6AtAaLZ
 tas89jgDu9S6TZtjPbb8UezEzOq1cVKh.P8TB9GDilatKm4Ru.xIsF1QUJaaevYAJjftJpLeycFz
 w75KlYCvrNSM.hdTR_4FRTIG8NEZCLKccwfLQO6BB0C.mi4Zj13YgPcn1y9GXgZ71gabY2QUZo1O
 UpvP8l3eSq.hdiKDk0UqoXZeuwwahZu348qk0DY_VOf8FXdq_IaOZUwqDaxt2Pr6vrPp30swTfSh
 SQ5izGNJCrnuWxW5CfBNND63vHBPWcoreOF.t27gjT4OffiFdCrOpEpUHuf7bDD.uEzawB4Yms.Z
 8HXzYieAAzV.ct85PlJLJhe2jBxaSbjh2zOq5DC1jAD6osIPGs.Li.ixIXJ.Z1lkPcyArF.DUipJ
 S6hTceTq_YRImZC_NkWuopcCGBcK4PUZIQfhYFFSYJgf5dSqhXxLqPieouGbn71E02bLp67csRRd
 EZzpXijyeClkqZEuUZ7wLGjAihQrD20yhPj8RljwC1210jEYJ4KaFilgJYs_Lvfkx9_9abbbwIfM
 D6aDYlpYJ9PjlNJic6V8HvawkHQbuYLIcpKZIVZ82TZt2nCfHkVnrcGrj6h8rOXeG8LHstcpUd3b
 5Asb8j6TJoVG4WDYyWqhM26cur5cKorsQVrA0FL3cpEgzOfkeqSMe9VeqByVguXm7rtAGpNqwndK
 kixhR09YV9vWSyIWuIBlz8Q0m_W7OSIH36CbjX8VbnjbbVgC.Sv8slBs2mIpC24hsWr1IMROKs_B
 r0zi6g1Vcb17J9fJtK_H6bCF3MdWFfVHmWr4QeUmuWtw-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ne1.yahoo.com with HTTP; Tue, 14 Dec 2021 00:06:06 +0000
Received: by kubenode541.mail-prod1.omega.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 9e4b96ad20c974ca8a3eb449af84f999;
          Tue, 14 Dec 2021 00:06:02 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org
Subject: [PATCH v31 23/28] Audit: Create audit_stamp structure
Date:   Mon, 13 Dec 2021 15:40:29 -0800
Message-Id: <20211213234034.111891-24-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211213234034.111891-1-casey@schaufler-ca.com>
References: <20211213234034.111891-1-casey@schaufler-ca.com>
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
index 3c6e88a9ff62..069cd4c81a61 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -1786,11 +1786,11 @@ unsigned int audit_serial(void)
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
 
@@ -1813,8 +1813,7 @@ struct audit_buffer *audit_log_start(struct audit_context *ctx, gfp_t gfp_mask,
 				     int type)
 {
 	struct audit_buffer *ab;
-	struct timespec64 t;
-	unsigned int serial;
+	struct audit_stamp stamp;
 
 	if (audit_initialized != AUDIT_INITIALIZED)
 		return NULL;
@@ -1867,12 +1866,14 @@ struct audit_buffer *audit_log_start(struct audit_context *ctx, gfp_t gfp_mask,
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
index d373b4d8eb34..68a582fa87e6 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -983,10 +983,10 @@ static void audit_reset_context(struct audit_context *ctx)
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
@@ -1889,7 +1889,7 @@ void __audit_uring_entry(u8 op)
 
 	ctx->context = AUDIT_CTX_URING;
 	ctx->current_state = ctx->state;
-	ktime_get_coarse_real_ts64(&ctx->ctime);
+	ktime_get_coarse_real_ts64(&ctx->stamp.ctime);
 }
 
 /**
@@ -2005,7 +2005,7 @@ void __audit_syscall_entry(int major, unsigned long a1, unsigned long a2,
 	context->argv[3]    = a4;
 	context->context = AUDIT_CTX_SYSCALL;
 	context->current_state  = state;
-	ktime_get_coarse_real_ts64(&context->ctime);
+	ktime_get_coarse_real_ts64(&context->stamp.ctime);
 }
 
 /**
@@ -2474,21 +2474,17 @@ EXPORT_SYMBOL_GPL(__audit_inode_child);
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

