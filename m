Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00EB347395A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 01:09:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244422AbhLNAJa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 19:09:30 -0500
Received: from sonic315-27.consmr.mail.ne1.yahoo.com ([66.163.190.153]:38556
        "EHLO sonic315-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244415AbhLNAJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 19:09:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1639440566; bh=uFU9LFaVlOFrCfZBEG93kfPxZnexKoaHxwZJO9SgGwQ=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=RlBJp6ayRpRF+7dmmZa6xcRFJoVj3wAxQQ8XYnyf/bvGaOHcONG1Yw6PWcj9rSH40WfXuzVlhVt7c+WX7yntiW/3t622hYLKmrOHcBILBStZS0fpCYfXIOkjPpyw5goZwXqCX5OxuBxeJz03Ate2s2wgVhr/EQhHx1Sr6xiCXVgxxlsk5I6HV9+a2WC1zwMTsjUMRtvDGfp4DxuC+1iK/wp73tcdS//SIGoKTALqcjjKj5d4TvIu4jNW2b9CWx/726FbjGGdnKf1lzrMvUCc9oaqfNYW/rg6ntpiLTruWARtbtnbVwA/hnPL0wLq/Kg+1HMjtaeY7EIvO7ku+HdFSw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1639440566; bh=VKm9JCdRgQF4+yN2+vokgiW19m5aXZFB7FA7KVV2C4Z=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=hn4OttrftXUr/HflJT5SMmAxF2EF0enZTF6es5rae6WUi47OGXtOC9cKzpDvBk+Fbsu7kJefRERB2532DvNLH1CjtHRIuixvlyjMpk4EIFgN42PDm1w6q16sYnhplzhs2T4rqk756ccGDijIKMcvJeGMNjF8KFuw94xKu7KEdWHX7B9fRmeRGhuT0C3WfuiRbeg88whXXkVAViP9cJVc/WFrIqvrYLInMbXM9Msh6sFPwMSLBpOXrpd9vMJ5psjtA8PzJgrGvncJT1qr2MwouhMalkMR8LC9wtu6F6kiH+9OuSc10b1+udQ4/3QdjC+vDqzh5bAEcnYIbsLHSFS0IQ==
X-YMail-OSG: X6evFLcVM1koaQ5pRoVDuJMci3Sk2nPILFgSFewVcYtfNrlB5VVtHcu9gTscIB3
 IKEgsRGzRC9WxO3To9sH4Su2pQ6CrlUGMSA043hVrXTWR9zcFAmwmp34WVbkIlKQAGVu.fH4Gx3G
 HCQzMkvmmgPLEDqEYAyV41ilI876vWwRs1ZdPlTycNFw2H2kPKVHw08C843PaHvuxpV20OwhDXtW
 luLqjXB6_grYbVsMiTRzLqYmEV8hsigfQRp6JyFm09zUhwPJzyCWb3MP41LHQBxwYuOMgr_cPQq8
 VSjpdo7tZtNri7tcRnEx5GVViND8pp45P084VVsnDtBLko5MmcNq3JJ._cZITXhrUL6qmwZkz6WO
 cS4POyEe90.K02oWDIs5n5Sx3Ulg67_uxe.afRFTniAt.dqeE2tBsKcngEfcVmdbNvugOrHhq2qM
 dr98G9wnKjYujZC6v7_bFpEvKpTkleWRHhjZ5UDQ1e.9w70NFembb06jGgL4sybQ_Zb_cbUNAN1a
 08cy5pK2.794nZ9d2rwXNHGbgCiphzU53guxlrehgZGVbcecFfh8qoors39XJcgxXD4M_zGihLEZ
 lVGt1SjTsFZIhYFXWTzRq.cR3wv1hgziQCjfRqTqDfX_NAbCRmJxFnzhvp5SFWfQzqa_ALX5gaE4
 JlygaD4H6XM_QwynjIyw1lf2ZMO.WBrFk5FTtUHRyVKt6u7u79HBxREvAU9jlXq_x1vA_f.r32ZI
 Rn5P9kQjXHTduIcrFs9oCBRS67FCNGGWGzzGgMd0NqcvnaILtZiga4TTcsTldm87YxbkncjjqcTb
 lY55B1PimQUvkypY3crJy2H5GuYorcbuFsVBs0DBTjcPHlA8RKHGHBn78rHYdBDoum8yehbfTf6.
 TvpNw4qFzSCkGRa_KcuySj2rJwcVNHPsANenSaS8erd4xZIiQ5.5Pv5z6RzK3KfqaF0JQygVHGIh
 KNQceebGQT1PFqo5Z42y.r0Y3p5IB3v8BaE_eTfcAoBxZcWlP6VnuoqhB8w9W2glNWOLJcXdcM_H
 NehVY7gpYRvMvkA8zMkfDxheqj5nqEgkIzd6zxyleR79Tu.PeAfxz7DTOKDhsPZAoh42wvR5Np1j
 aEpRQbjSQo9qqArwpAvlKhngUhOyPIOLiiiRhelv_RvKgiAYHejQIMJyt2XaGGAXt8kQme1kT0ZR
 vbw2Nxbu.GZUPUiE18HAZaJVzhBbRVHQZZF2g6rmYa4yGOUlTjseCZc_suBSpxCQmmC1Cq5Egu.h
 StmofkUopREHSwpC_6Ri12cZn_V2wrUuuUDcmjjuT4EJBREH4qoxM3qASvQGeMM7w9Zx7KIsxwZb
 RswlVjI6wzq5P3ZVhdiwamd1ksET4crdYIGFZ2zf69RHJC.cWxONVNM7us4wPjq85.y_t3uVd.ei
 IRaV8jK3653leGIXgMXPwT6uPxLqI8J54ucrX3g39iVYwroyUp4UVuo7do63DcXsaIoGjsSMxFtN
 BAgAf6bK6L71z1s0qsO05.KCnIOpFkLT02APaK5_W3IvFIPP_LSMtpeDvIYl_BN8nji5p6vN8ZBF
 GLroZZTQCgjBpHhLOzm2xLXerZXwmWabxgFHggqhUdabmXDuoi61BxEgu95SeoaQXuu0opt4Nb_P
 PUFdAWBhBI9Dncb4U.DZ1vR7A6WCu5E60Q9SvBoahXSUU.M.mT8qAEjS.bqCS1RI5VVFvibOTFZr
 YsWFF.sb55jkvhAkQOt62JG7MyF097eQVERkJuF7lviZJZP1xkc1bn0LwD9xMantRS0Y90E6nCFS
 g1ah54u37qQlidP8l4JTo8b2uXI.QHExVOmwKj.GEO2E.A3yjEcuHYFyhp32np884P1KS5f_9NSW
 A3_p4doD0oyiJr9rYCvYw2wIJDbLm4Xan_lmzVpmt2QNjuMo1q2CwnNnhkwZyxNEt7nHam26vFEc
 NLN_6rKkZT03DaBAbtdKx0pGGRByzoBdSxy7ZwgVhO.I2ued.uLAYUP0LQ776gYTPwF_wHAtNrHz
 fAK3Ro1kZb.9aoNBVar1EWEPufkp8bbYM1GVef7UfeowyQ1BosRWdagPO8FsckMmOHsf45LqiN7n
 fDziM0fYguVHZu6yHfSFlbOUlo883mT5UU.TN.zIuGEdwAxd7UdeF.baRjWZENRLCodiTtIQY_NL
 jpLrhZLKmScz_LVTJchEVj6TuZj_l6YVXG0TP_AE1RG6px6V7jIsbA_z_KPeDhHcQjRDaeD4C3At
 K3_g4AS4Qwet9zn.M6G9wJJ.JihKGTAKs6jgS0ljiqs2to7oV1sW1AgyRPLhc17rcU9E049ofuhd
 kXuiy.IbnWWjqFm9yuPVt
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.ne1.yahoo.com with HTTP; Tue, 14 Dec 2021 00:09:26 +0000
Received: by kubenode516.mail-prod1.omega.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 24f1276e7a38c2430cd93af6fd730220;
          Tue, 14 Dec 2021 00:09:21 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org
Subject: [PATCH v31 26/28] Audit: Add record for multiple object security  contexts
Date:   Mon, 13 Dec 2021 15:40:32 -0800
Message-Id: <20211213234034.111891-27-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211213234034.111891-1-casey@schaufler-ca.com>
References: <20211213234034.111891-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create a new audit record AUDIT_MAC_OBJ_CONTEXTS.
An example of the MAC_OBJ_CONTEXTS (1421) record is:

    type=MAC_OBJ_CONTEXTS[1421]
    msg=audit(1601152467.009:1050):
    obj_selinux=unconfined_u:object_r:user_home_t:s0

When an audit event includes a AUDIT_MAC_OBJ_CONTEXTS record
the "obj=" field in other records in the event will be "obj=?".
An AUDIT_MAC_OBJ_CONTEXTS record is supplied when the system has
multiple security modules that may make access decisions based
on an object security context.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/audit.h      |  5 ++++
 include/uapi/linux/audit.h |  1 +
 kernel/audit.c             | 59 ++++++++++++++++++++++++++++++++++++++
 kernel/auditsc.c           | 37 ++++--------------------
 4 files changed, 70 insertions(+), 32 deletions(-)

diff --git a/include/linux/audit.h b/include/linux/audit.h
index 14849d5f84b4..94c87ec043c7 100644
--- a/include/linux/audit.h
+++ b/include/linux/audit.h
@@ -192,6 +192,8 @@ extern void		    audit_log_path_denied(int type,
 extern void		    audit_log_lost(const char *message);
 
 extern int audit_log_task_context(struct audit_buffer *ab);
+extern void audit_log_object_context(struct audit_buffer *ab,
+				     struct lsmblob *blob);
 extern void audit_log_task_info(struct audit_buffer *ab);
 
 extern int		    audit_update_lsm_rules(void);
@@ -255,6 +257,9 @@ static inline int audit_log_task_context(struct audit_buffer *ab)
 {
 	return 0;
 }
+static inline void audit_log_object_context(struct audit_buffer *ab,
+					    struct lsmblob *blob);
+{ }
 static inline void audit_log_task_info(struct audit_buffer *ab)
 { }
 
diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
index 86ad3da4f0d4..116566d0fc03 100644
--- a/include/uapi/linux/audit.h
+++ b/include/uapi/linux/audit.h
@@ -144,6 +144,7 @@
 #define AUDIT_MAC_CALIPSO_ADD	1418	/* NetLabel: add CALIPSO DOI entry */
 #define AUDIT_MAC_CALIPSO_DEL	1419	/* NetLabel: del CALIPSO DOI entry */
 #define AUDIT_MAC_TASK_CONTEXTS	1420	/* Multiple LSM task contexts */
+#define AUDIT_MAC_OBJ_CONTEXTS	1421	/* Multiple LSM objext contexts */
 
 #define AUDIT_FIRST_KERN_ANOM_MSG   1700
 #define AUDIT_LAST_KERN_ANOM_MSG    1799
diff --git a/kernel/audit.c b/kernel/audit.c
index 4ee2bf620df7..85f278c21d4d 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -199,6 +199,7 @@ struct audit_context_entry {
 	int			type;	/* Audit record type */
 	union {
 		struct lsmblob	lsm_subjs;
+		struct lsmblob	lsm_objs;
 	};
 };
 
@@ -2184,6 +2185,43 @@ int audit_log_task_context(struct audit_buffer *ab)
 }
 EXPORT_SYMBOL(audit_log_task_context);
 
+void audit_log_object_context(struct audit_buffer *ab, struct lsmblob *blob)
+{
+	struct audit_context_entry *ace;
+	struct lsmcontext context;
+	int error;
+
+	if (!lsm_multiple_contexts()) {
+		error = security_secid_to_secctx(blob, &context, LSMBLOB_FIRST);
+		if (error) {
+			if (error != -EINVAL)
+				goto error_path;
+			return;
+		}
+		audit_log_format(ab, " obj=%s", context.context);
+		security_release_secctx(&context);
+	} else {
+		/*
+		 * If there is more than one security module that has a
+		 * object "context" it's necessary to put the object data
+		 * into a separate record to maintain compatibility.
+		 */
+		audit_log_format(ab, " obj=?");
+		ace = kzalloc(sizeof(*ace), ab->gfp_mask);
+		if (!ace)
+			goto error_path;
+		INIT_LIST_HEAD(&ace->list);
+		ace->type = AUDIT_MAC_OBJ_CONTEXTS;
+		ace->lsm_objs = *blob;
+		list_add(&ace->list, &ab->aux_records);
+	}
+	return;
+
+error_path:
+	audit_panic("error in audit_log_object_context");
+}
+EXPORT_SYMBOL(audit_log_object_context);
+
 void audit_log_d_path_exe(struct audit_buffer *ab,
 			  struct mm_struct *mm)
 {
@@ -2490,6 +2528,27 @@ void audit_log_end(struct audit_buffer *ab)
 				}
 			}
 			break;
+		case AUDIT_MAC_OBJ_CONTEXTS:
+			for (i = 0; i < LSMBLOB_ENTRIES; i++) {
+				if (entry->lsm_objs.secid[i] == 0)
+					continue;
+				rc = security_secid_to_secctx(&entry->lsm_objs,
+							      &lcontext, i);
+				if (rc) {
+					if (rc != -EINVAL)
+						audit_panic("error in audit_log_end");
+					audit_log_format(mab, "%sobj_%s=?",
+							 i ? " " : "",
+							 lsm_slot_to_name(i));
+				} else {
+					audit_log_format(mab, "%sobj_%s=%s",
+							 i ? " " : "",
+							 lsm_slot_to_name(i),
+							 lcontext.context);
+					security_release_secctx(&lcontext);
+				}
+			}
+			break;
 		default:
 			audit_panic("Unknown type in audit_log_end");
 			break;
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 68a582fa87e6..60b77e37ae83 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -1111,7 +1111,6 @@ static int audit_log_pid_context(struct audit_context *context, pid_t pid,
 				 struct lsmblob *blob, char *comm)
 {
 	struct audit_buffer *ab;
-	struct lsmcontext lsmctx;
 	int rc = 0;
 
 	ab = audit_log_start(context, GFP_KERNEL, AUDIT_OBJ_PID);
@@ -1121,15 +1120,8 @@ static int audit_log_pid_context(struct audit_context *context, pid_t pid,
 	audit_log_format(ab, "opid=%d oauid=%d ouid=%d oses=%d", pid,
 			 from_kuid(&init_user_ns, auid),
 			 from_kuid(&init_user_ns, uid), sessionid);
-	if (lsmblob_is_set(blob)) {
-		if (security_secid_to_secctx(blob, &lsmctx, LSMBLOB_FIRST)) {
-			audit_log_format(ab, " obj=(none)");
-			rc = 1;
-		} else {
-			audit_log_format(ab, " obj=%s", lsmctx.context);
-			security_release_secctx(&lsmctx);
-		}
-	}
+	if (lsmblob_is_set(blob))
+		audit_log_object_context(ab, blob);
 	audit_log_format(ab, " ocomm=");
 	audit_log_untrustedstring(ab, comm);
 	audit_log_end(ab);
@@ -1364,18 +1356,10 @@ static void show_special(struct audit_context *context, int *call_panic)
 				 from_kgid(&init_user_ns, context->ipc.gid),
 				 context->ipc.mode);
 		if (osid) {
-			struct lsmcontext lsmcxt;
 			struct lsmblob blob;
 
 			lsmblob_init(&blob, osid);
-			if (security_secid_to_secctx(&blob, &lsmcxt,
-						     LSMBLOB_FIRST)) {
-				audit_log_format(ab, " osid=%u", osid);
-				*call_panic = 1;
-			} else {
-				audit_log_format(ab, " obj=%s", lsmcxt.context);
-				security_release_secctx(&lsmcxt);
-			}
+			audit_log_object_context(ab, &blob);
 		}
 		if (context->ipc.has_perm) {
 			audit_log_end(ab);
@@ -1527,19 +1511,8 @@ static void audit_log_name(struct audit_context *context, struct audit_names *n,
 				 from_kgid(&init_user_ns, n->gid),
 				 MAJOR(n->rdev),
 				 MINOR(n->rdev));
-	if (lsmblob_is_set(&n->lsmblob)) {
-		struct lsmcontext lsmctx;
-
-		if (security_secid_to_secctx(&n->lsmblob, &lsmctx,
-					     LSMBLOB_FIRST)) {
-			audit_log_format(ab, " osid=?");
-			if (call_panic)
-				*call_panic = 2;
-		} else {
-			audit_log_format(ab, " obj=%s", lsmctx.context);
-			security_release_secctx(&lsmctx);
-		}
-	}
+	if (lsmblob_is_set(&n->lsmblob))
+		audit_log_object_context(ab, &n->lsmblob);
 
 	/* log the audit_names record type */
 	switch (n->type) {
-- 
2.31.1

