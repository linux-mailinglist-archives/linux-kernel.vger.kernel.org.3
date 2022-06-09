Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F6D5545840
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 01:15:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345568AbiFIXPA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 19:15:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231691AbiFIXO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 19:14:57 -0400
Received: from sonic304-28.consmr.mail.ne1.yahoo.com (sonic304-28.consmr.mail.ne1.yahoo.com [66.163.191.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC32456C17
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 16:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1654816495; bh=kVIMwiF1khorR4kRvqOXL0yHkF2sDWt4GPej07DKKb4=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=i5zY8xToEOBZ0IgTD2swjT8UrWtAsxdj3BPH6yuZ9l89cdweZKKvsDlalWw1uc+dHku2wtyJ+PHtC/O4TX+zyMCAVr/6lgkdbqEni30yCUkgIXVsbk+O8qyprfy+sOqUNXn7uvhbB2OSV4bAr/RuYUNrfl9CcmhvkG9oi4BR7uLFQq8lqf0wugkOOo5Ap+BmxFO9jdu++9YCsWdE2S4eiM3hLFQXKNfFMCCIVW+BT8vuaXqkaZlpaahk+Q64FtU+DTFb7IlhLCWE7BOKQPDtK8WO5BMc1t8Ur65ZjtxtCLNfNjB1DrthfQUdrC+xaVviHfW77i9T5m1awNMEdX52KQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1654816495; bh=IwrRSV9ju0SE7jXH+7iUs4+w5hhr0gwtQ18RJfmO/Ju=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=RfROpbi8lw8yOwTKLQIHH9nQ4MDnb1764H7INAtG9ZYx/wHLCn+D2VffgufTpRYEjftKv5/vVCIO3UUVkbwdoe0gh+yVGLi5hE0O0Fdng5NZwigZMgpCt9Iz3aATHz5EnV6CH1R5GfvnygJ/E/f1jcFKh7f6QB0zfcFq2++ja3B0lt9MMo5pCafL5T62wkd7ki39TOy331eQzBQh1HRo+CL+iCek/bvHkZ8ZLcD66/XHd2iwOWkT2z3M8FP+2+MPR1N4/5RuUFGdo1u3rk+/MFlaVnjU4BxXJ4aTfAh5dMFsxPQ/MX84VucWoHjaEi3OWIlrb2DKgvj7i754aE/QQQ==
X-YMail-OSG: 6l5iFgIVM1kCfqwycL1J85e0G.j7Zo0djZfQ8hGQZqPKvgNosXti4UmQYRidepx
 _fwuAF_jFFSOZaGvRIeGmN.uh9ftgv6g12Wbsj_0Q0MItBc5V.0qyW5HKzcRC_MAv7et9KJFWb.N
 AlXZjtp6dqPPbbFjPoa5UeM50tBBsgxmWzqShycfvm_.DYopOCT6aQUQc.AnzALoZXbFbpn48VD0
 nl7Lp_C21eNbWF.X9svO.z8kqNFI6mif5thrT3yMkOIS4d1AryNCywPQvhRauBWsf381lhKFoZdg
 n7NkD5Dn6fseu.xkwrMQmbT7AO8fmMPkH_BcVQEmqL6RETyo1Vk86DGtp7drhnJqOXbBuawOZVq3
 tWGDDn7hmMwG.y2ISBw7pcIJJ5woF9H1ZthuV0_bYkEBkRPebuNXq_Vs7S4p3yylMy24R7makN44
 Q00DnS69my3Upu5SuvHQjV8j_wjbVujlpGZLHBNltvWt7b.MKvo6r7v6jW.aPzhHYDQyN_sD1iZ9
 DAB.K7vLLUwlRI4iWZFk7Fp7fhABrubKRAR1TMwP.Px3u4FKsxwWWgvWE7s_wjbDvIMWlG4nC1eI
 h8p6BhilMCFdfZtM_CIpT3nYOeiFouEVBudlZLDUubC4nYlC6F74o1jZCsNLNWJt5xOBkfrbMuXn
 uXVSxHiKNdAIWXOUrr5MN4Y49Ymdqrb96_2upGhxwclAJb2LDJSYd0X_If5k5VTIEszEDMUhchK4
 Kt0j1dRV_9Eh.aChtOD_XQvno_CamB2oRZ8wjtPsENxQosI3ynxdKWalsND2CeoTJzED8VNbD3y2
 OchiuihRpPoV6UC.RQsIh_lARB6knmsZA6KChj_IUP2fglukevxKLAxm0hYvqxg.IBP12EfbQl49
 93fZJsjLW5p7zcDM6u0daAJwCDSvu4GS_bpPgSyzLkJBKApn2QgspPkMd0IxIN9PWmnuNAwTDV48
 8kRjVPcKmGhUuTIS_2sI_xLn60ygUaTD_RdPjq6zyyHVkHwsxWcdQ2LKgC9WSZagVdtCcK35dNYt
 SOaLwekzrwBuDxmE14gwvbpRyh5pEMse4bibVJI6Se3M00FXsx_yv7MfQBk2aYAMFsMWOfrJCJC2
 BkcDjuPBCXFHnzBMZspMkkh9tLx8Luc5mzB.QUA_CKWd3O5VggdhiODQn9xD3PrYkwygu21cn9uV
 SAlW0sjWMedtXHRbvHqMDAaxQa2_LXDR7NN3eUXNmrSFnOsJsVMs7l2TgmNRjv0_9crMZw28SyWb
 Ozf4H8qb_W0BPBK6dFtKdaPaz1LzvU75UfZ9V1lzHN3ULd123pqAp0oNJgH_.uDtApL7c5zdeinz
 1O7yc8mtXVj4rqgDfjAGqffzE64B4LTGkFqHa.OajQHcU35LJCbfqv4rkCMaPI_bNy.qzrEPeaxi
 uK2Tuk_9WwjuAhl2IsPvCe12Uh2BKL7V.5gO.8EOg7oWKNf5NXeiKbVQOAbhCq9lCiDYUrh_ZCSZ
 1cEceVMJoMKo62RHuKVZQ3hEe_2viMEUPaYm2SPKH_hvZBrHYRRqJEhRUCTF3BeuXVI9jUQcIx1W
 .3_1.nSUw9T1FMAQHgLun3Tf3soGwB5evYKk4obT9AVUqNMdwlf_lxvApHoO.b6SC3gBLXiC349w
 4fabbxjGR1za.i29RUO.Q6lavM7Et7bUO14X8dOk1P6k6LXr3yZak0NNgxORFJiomQtbr6qzu.pz
 pE51dUqo1349YjS5rQ7ygW5l2pe0rWTcu2fC4hGgttUQ44WEaeiuax_NdM0eLnu1TrCrG2W4snYi
 6Nc8veMfEPyo4tofjsMiQPePumHCWFFUdlU13KL3s8npkMnxEiXXZdXMn_34AIqxJBAJenuKSYHy
 DIOIRhfdlYXh1ufXNJXaMCof_pDq.wjQjnQx8MnMq_6teNXhf.cRZdqOWjxFnYflGmhEC.Rx2Uak
 QrgINmCT5O26qTUA.ahUDeABlc15H.cbDQ9gDKIqjYOnoWUcGkPu0QnGrEXjP_JpYoEOCvZa_HqK
 EW0O6pq7gSxP4q7jVtynVhSqT_IDQAEzI8dg3Ba9sMxBlwS9LRz3zhS_553CqtymQ1qbztq3Eaxc
 s_4TFkYd5BBdmGVv7OYi18XS4crcVqpNIgHJbFF51Fx68rF09POerRahTaihgeVwUn45QdKqHZ_3
 5V5._AJQWA90Wso2skkyUGHLHutFSmcb1irBQbj7OLzJd94cZYtOS7ROdFsSrraT9lWnlyX9W49M
 qP_c6FbHsSPLjkVEWXa2gBGFt8U5.mcyHfgPBhJBkXmioCg9YtH2hB3_3U0YyMFg0LZQw4J3fKVi
 Dkg--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ne1.yahoo.com with HTTP; Thu, 9 Jun 2022 23:14:55 +0000
Received: by hermes--canary-production-gq1-54945cc758-dgl4g (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 8f2f82ea5c9f338d52d2410bae995cf8;
          Thu, 09 Jun 2022 23:14:51 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH v36 24/33] Audit: Create audit_stamp structure
Date:   Thu,  9 Jun 2022 16:01:37 -0700
Message-Id: <20220609230146.319210-25-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220609230146.319210-1-casey@schaufler-ca.com>
References: <20220609230146.319210-1-casey@schaufler-ca.com>
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
 kernel/audit.h   | 13 +++++++++----
 kernel/auditsc.c | 22 +++++++++-------------
 3 files changed, 27 insertions(+), 25 deletions(-)

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
index c9e87ff4c396..be2811d21ba8 100644
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
2.35.1

