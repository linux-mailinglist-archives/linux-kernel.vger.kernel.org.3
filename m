Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DC7A5031A4
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 01:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355977AbiDOVcf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 17:32:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355296AbiDOVcT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 17:32:19 -0400
Received: from sonic305-28.consmr.mail.ne1.yahoo.com (sonic305-28.consmr.mail.ne1.yahoo.com [66.163.185.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7D94488A7
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 14:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1650058185; bh=SEZ5yGN4WuR3EQqQcVrWwReXijssZ/504JFMBxTlkAE=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=un0XYbma2+EWOWsQWxw2obl+CSp3aRJUKT0NN+1CVF4y0rtapjQR9xTUDUe1v5PUBFq7e87PzALfR8czHy+KPFKXYScEBhhzpwRfsTYrCckQHj2hC6mYjXJ+j+IiDlEgX3af0YsMVeDfMU4KYjeU88Tj4E5B72J4E9kG+b+ErUE72uziyDBs9EAXJskC8EolgNM4I4WAFNtE55YxP3+FXbpc0BM5UdwIsI/tQS+Yi28uKSAVDrlmglsXe6d97Q1T0mIbA4zFhHFuMDRxqVMVr32K8+vi2qHoFMUEGgMvjw0l2c9UGAWVMKT1t7nbk9d6ljbsLT0sihM9WUHX5CEV4g==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1650058185; bh=5ZlVvUuypkYr6IVGdpikvxe4G5Xt+0sd19LuPAGx2is=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=ezCxJvnHvKdgQ4Lf717MZ8E4tfTO4NjugCI1XOSa3cFPZn2btyT19eYyQqLXDOu7vCvi9DWFtDvL3+kGNuzBBp4gAUuMOKLsGzJeaFdbiee1+7QOS4G6y5GXw1BNTOVv4/Aur9gqjHGKGXPR0vF/jVUW/9+POEXPZhi9Ntxqxeo2kLnfxYi/+qtYjo4cvUFmyUpKvpdZqR3Zt5NRjZxj1N7FoJdV5VuqKq/wYeE1m2w8AWdSdfibyQEqMcS1JcX4Op7UkH56ktoA8Q2RKhE/SywtKULbemtOtPtgU/OAgFGz7umvqYgRdNCT0ydqqOHFPI+lZdXzpmdrTr7tZWs4IQ==
X-YMail-OSG: vrp9D2QVM1lnuMYxUBC0vSTAzzNcwxIkI.dy79UUfMoew9tO_OXplm9oNLMD.wL
 wkNCHRnwTr_JVkRi2Npa78fNa4hVSB4gAUk598rzmBDtyFZUKpJsTaGn0Vxd4ZYdgMFNeg5j21dQ
 n5RGUUk65Oyg9Tu_5TNGhpZ1yFViJXaXow2buX6c2CMIWddupIxOYd.mTGifep.URTKw_fEmiaVT
 Uu3nyC0Fey_6A20olZZislul0GpK26mRvTcjs0eZNPIdxMokM49qp.amoJoIbI3QaLm6K7Q2ZQOF
 xF3_rKfMNIXOq45kOn6my3s0keBgl96Mcfwxe6GozlfslWA0xwhDJqpdrZFvlraHkIBLUbLAkG6A
 3OWSNijvyVmZPkbhjsmd45hK8vE7BrAkUgMSoV89KYEA7jo81tXg2lnIZmewQtxDYtfPR.SmNbsZ
 qP8IcxBd.1Ac23_DSkKHWIRmi_ZhjE1AKuxbhY1pd6c52lqgO4ACPwi50At0cGjIIzYe3034nS46
 MQHK7QnFt10XPWc7qWs62cfuKOs5MK_jkbHQBzvfzc1_XyRM8yLpTfJpfV5P3SvfmzSUuLt4QXKq
 XlY0hQHEPfamO1Bwbj4M1ex_gZUr57vtfv_xyzzvHEskBrClyUplXwf8dqCeTnaM.37gUJ..FazL
 WyJ7y.4HJAHZxsGwZpfGdQvl9CScAdG1bPZkw1I8blqCTtKFVP6P5yvjQYL4JR4cOujLIesm3BOE
 N9XDL58EmhalvgbjsxE_Qpn6TJdtcOauV41Y3ZkeHVvt8e581Pd2MciLq7iwidaLFyFs_njTEZWr
 hyh6YZwIhMoVsgWv3R2DjpDQZNz8VLM2rFJBGw3pHmul3EBkmPgCtv21ye_iVZn651D9MgMsC0xu
 6CWHYua6emAkP77uS6DWX6_mfyEbWlT9AndGY7mqDit_V7rL95HnVeFjZovNKrBl_.56Cdx_k.bz
 dLEz8B9SP4lZeLOAxa6tDdRvanKRGmw178pmLv9w9IrkQasUDB3h4uEwBnCxXK.hlyL3fhY_CXUS
 Hq2dXWnEWKQnCkZrgEs8j1CalS6ZKTAti30H72XF51Y5QhDsFzvwpMSp7q6fiFoWsk_wIUnIFZM3
 LV3DJ4wkh3lxGqYrbBRBy7Mcm_MyG_6DyXLWi.o_R8gncTEyiRmM38mibl103veGXUwntCp0E5aF
 pi_1KNS8cGxe8xyVNcjSPUdYI06jMLCN8.YNrjRWOCzOLqQGEkcBJU_hbcqY8adIaTmM8Ouyyvxw
 NEB0pJczFDP.mHU1DZ4m8oupQaaDi9H4RYKpWQtKqIiRDE35uH3xn9cBjN4po8mgWg0uzUoEV8vt
 fk6J9agxUcTpIFwr.6b8x9150OF.bvr8TzUkXKwGL1oHm2OO0BvYYZhsWl53yBMtuW.R3C7pXBl9
 AWqqfnsf04djojtdAhX7COQB2RXNdFGULLRpTVh04rXVTeVSThBpH9PBuZK2AN0Juua1Tmdnrk2R
 fjH8MQmCZVE7mkazYnh7GF6IONgkR1gy7Dy7vao8S2h1JAnzdbEqoQm5lSJbd6BBspcb5FUJYzBv
 jEQIpqet2f6tI6BlPIbwMelbvYtx2lMZXR0r4k1pKc5uhDeHjQOhrkZ0tvma6ySWIMqVhjs1SVtF
 KuliScKVZzsNOdOGzUxlqDBvkyLLXS6eE0OC.zpqyqacSjWCoat3dG8PhOzL4a63_mkB4GWwL.qw
 sMDCb.IwdZLbw99eZW2GtD8WnGsAK75HPphJERPhuZj8QnvoIzmP7AfY_cSSWgAVNg39MQfrZwTP
 xhCZSc8nLiStH2Swq152diDibd3NEDTPAuQ6zv31f5Es2jKFLmOXuScU6j4FTLVp2q_WY3JGtyTB
 vGOdjUQWGsIhejMz6yda0_Q_rtSGnz94.Gvu_0BueSeW1MpgBXPpzEdc71z7.YuHRBWOeMeMvnj7
 cjXaT1.GRCZSG.jjO6OdItpIo3fPuMuv04AsDtMVxq6DM8RADPM49KLCiwCSvDc8RaxGWFqCuaGH
 q9xk_VitQ4jNUouZ68yaesmjQs2xlvLpYiB9n7.TR9FsbPXSEJWqTuCGhp01HpgcYtA..x3fWDi5
 RcLQbxvEtxabJWWEKrMWykMIzx6ifyBAuGnjasiOHqZJiFkZ8tXT.EDEzaE.9a5.0APkp_VpVePR
 0R0fipQUsXncBVuetn_ISzZ4beIADShZ0WeVXzOCm6jNt8z37vbt3eFw5ZML6u53izwIbIFGn1v4
 BtSxNk5OfFz2f9yUVHDp6XWZJbmImQDFocvyBqVR.yCerxJ8Wnpl8ebjzDX9pSBqvljWUjIAsmr8
 qDLU3
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.ne1.yahoo.com with HTTP; Fri, 15 Apr 2022 21:29:45 +0000
Received: by hermes--canary-production-gq1-665697845d-l9qwj (VZM Hermes SMTP Server) with ESMTPA ID e13e266d8c7792b63d16d18d4175b5aa;
          Fri, 15 Apr 2022 21:29:41 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH v34 23/29] Audit: Create audit_stamp structure
Date:   Fri, 15 Apr 2022 14:17:55 -0700
Message-Id: <20220415211801.12667-24-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220415211801.12667-1-casey@schaufler-ca.com>
References: <20220415211801.12667-1-casey@schaufler-ca.com>
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

