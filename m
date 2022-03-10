Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F08554D562A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 00:58:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345095AbiCJX7Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 18:59:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345055AbiCJX7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 18:59:05 -0500
Received: from sonic315-27.consmr.mail.ne1.yahoo.com (sonic315-27.consmr.mail.ne1.yahoo.com [66.163.190.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBCACA9958
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 15:58:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1646956683; bh=dTXhzuopyuHsOK2uVsPAMqd3JMR3iQuSAYWnNMHmUjA=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=LU9lCSiGBlXOjpNLEOjF5zNCVpAGnmQYmCIlfJNlZqYjxoJbV17jGVXfJnxKTT8A6dAj3ooJgArixb5o0juMjkgZHOuN5t5Ac5J11xholuaBY2MjG+EIRIvwQOEAYxYqESYjHtVLIVWkBUVpPaZZLOpolAGsuG9NLuR+PfmSyzcZy51buYxT+E4KJB5C/raZgizMzWifmxlnX1svCyl2D0BtAFklOswS3fqhOsdUzCDYuMLiKmIvu1Wa0JTNfWvfEquERvJw7SXMorQstTQTH7WqPoOCqqZklKmEoSoMhfSxMpAgDfBcCGMoIyDVMQlEZXrFYIqdC6P8EVtq4F09uw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1646956683; bh=KdQ4NRGiTU0mP8SCXYLvARfZvH5ABEc2KKHnvBwJdZG=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=RxVoBkTCpYPgyt/juLDNwTXHRr0aWppoY8q3N8wa9WsMBORp6yGyu91037hMhNFRtKGGOgeNl8bYYK8xHTYxc52otju2tC+fUvP3YOtu0CdWa1zEhI5mnKntmmihfhWYb623NUq5043rI72qFFDpnFnyoIGP/Gwi+NPY1eb9mLHnXsOY64UVIobFHiWPrW+a5ZMc4NSoNj/xFX5wwxpQTk/+0FAsESA3iyKACBhPX6IYyzNGd3pmgmkSFlAtW32ZTrgGNTluFrStjlRUvtHbVkaZo1Kzi6OKBnSkXs6fTDDT6x91MEzRsfRL7CXqTQcJS1xJCsxsP36+KwVzj/VRdQ==
X-YMail-OSG: PzsXQ7MVM1nmH3DF3DXd9W5I.OUbt2BFDq3N0M0eaRavqfsB9l1ltNBOuoRdfOq
 d8iVUBNNSfsvPciaX7HbSHw3nzTtVGjNCEDRCRcLrCnV4Bt1QIXHVoNCDGww9blsWU.j4iL8FERt
 sDCxG0mZ1jZUh7dPDorCcoYgo4zrooGjDkdtXS0YOTCz6GpjIJZVXAYZLvo9wBwsn249BeXXLR9v
 FC7gbo.p6lqQUe0MdjxKT8sOhHAEmKS0D_0sn7nUOXupS07H5bEuiy2EwJ1vKmNEzz0uL81rcZM3
 uInLVXDHG6yX3dOlH6_h5hHWZybDP.UhXuwWy9qDh4yrJ.PlvFrYdXFuL0irqOZNtApG8sdEtdNo
 XWXZU0A0P0y1hCXSsxXvoZkm3ipgZOvEtY4rG8.M2ZQ3RutxnPm17R3AA8Ml6vWkBMBqcbBUy2it
 f5a9b5nk9l.siR_7EE43f28tRmq743XI.XbdqDYUfCFQX1eat4FMMMTka5WMX5lrfxs65gB0o4Uw
 jJ7HRbGwTUKFaOOc0IQT6vlx3KznG9MWcPSGrRWaz8x5c74PXKlYOBMOXgqVtIB14ZLz68Ifxo1N
 9EQpUykd8FLUmeAFyrXEf4GOcd1FaneR3gFBrF7WQNOAH70Ch.tqVHeXUV7WckqXO4WoD4h6mcCP
 H_qv0kX4D0HTlGng69cYJUDCdsWXpylo.iOu.680OpKUIobmW.MHCNGu3t3ZTsFOx3j2f1yWts3d
 0p5EzUid3eEKtkuDwoZzkR7YHcoj6z8ztXQRBttEMChu.zPXPmMAj2iQ7Cr2NfPHcuMX_SbCVzAz
 8r7lkGBRQxaEaQ0Ftsv99HzL0ABTx4GFEGTg2TbdLyiyJ_B1nvYSizTCMSoce8zbgl3khWeDYbpc
 KjgQoc142gz4nDCgcp58dUDG2HvmpOfrYFrqOnVKVbX_5g0e0KNoV6ohR66B.qx8KbzBVlkrGMbj
 VXmVLPvZGqQq3iOoBn28mKppAA03PEfe3AEFiOs94ligC4.taQHD1Il.fhjNDDArKPLL1NyJ9uRj
 28t0UInzC8JmFunITfQmZpkbca63U3i3ug5rFHUmFEMVdtt_apczSK8HS4amC4mUSuNRCEkUqdU6
 9RUINlgr8qHRXQPnyVWqfV2UMWDMbBrSOLzUP6UWm4VAvT4YLTArcszOiu1A3ncli4RdFV6T1Lln
 k9C7TxI2fxvudc7dChDzFsGkeUBy4973SF_0dfQI466aslGNqJ6fLpuyMAWKSNJG5aH8HsGuT9mW
 f2YbxDFr4NAYQBrW7siS8n26qcWTI91y0.ayUWXts6vprXzTxPWVh.WCmxOUekd46BTHMCOid6ah
 _r9XgFnYZbXwlTpRa2GxuM_4iu3Rne9Lj5WvT9Np5_uaZ.96VSRX9xjyKWi47DcLcUYglBDybJ3C
 BqPMkk854mvSQG6y3c5Pz6rHPUHHXSX3VpWVutZPbAC_cCyMgMXgDAmjFASQc1MHsFru57xXiZZc
 ta84N3Uy2p8Doxm04El4vPbEDIrKVnFXpW.uI3VfszQQ34Ttaj9Zhc1.XeNlSN04JghnLaLuS.gu
 zQd9BkLctkJ5VGG4Q3voCBNd6UoOIDXOJ9C7rTre80l4Vfmk26Szt8OE2m93TASx8pwzGuB2PITM
 aEL2XHBdSx6a.HGYeasG4_LIe0OlP1HXLPBLCaGlV9PC2rUnEhDHnE6OX_6zOPi8vKRf2A6d2khc
 AS8BY1sRzlU80Uy_sjRwPD5AdH1QZ05IjlBJp.ET5MTp0tS8FdSu1do06iHJ7Cuzd9HTw94_hcYZ
 OSJygy.AM37rzT.K_ge0ijpgNQt2aNzExJJ_uFrqhqYsO2MCPGO_rlTikvdzl7lajmyhJcJt2I0R
 Qxtr7jdhdHKZq3V72ngfTkkDXDnA1dCK9dsNkuVV8OF8.d3knhvCoGnvERYxLs.DRFnAIRF5IPSN
 xVXM.mTSOH8qvn8OTBs2Ktz6K7BJ5V6yQzOgOJ8eRVfNJK48rSwEaeSIcTY9UOkb085bfkfWYtsl
 YMxZEYD6gdWBU7gWepoCIejH6Ykj7P_Cc8gWd4EoFSq7fADc_rISkpGONW8kbULwkFLtiu30JvTs
 5Ij_DLfqxjYAccQuzVJWVxActyw734wZg.QjKM28CMjI8Ok2FITutYvVN6fUUYNVaNhHicvFhBEQ
 Nox4Nys0miyx5iHJIcQF6u11DCfauhIdPqHMtmeaFvbwnRQFZkKPBN5lH8coYHd3AoHwzk292G0l
 ylrXS47HeiBv3TbG6.8_UhzSK7c8KTVzgACGqWs6MnC7Ld_NqIVE-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.ne1.yahoo.com with HTTP; Thu, 10 Mar 2022 23:58:03 +0000
Received: by kubenode526.mail-prod1.omega.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 075078af6eda9fc0a8c4174c138d83b1;
          Thu, 10 Mar 2022 23:57:59 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH v33 23/29] Audit: Create audit_stamp structure
Date:   Thu, 10 Mar 2022 15:46:26 -0800
Message-Id: <20220310234632.16194-24-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220310234632.16194-1-casey@schaufler-ca.com>
References: <20220310234632.16194-1-casey@schaufler-ca.com>
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

