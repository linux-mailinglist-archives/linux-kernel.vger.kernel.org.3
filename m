Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74C894A7CC1
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 01:23:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348494AbiBCAXE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 19:23:04 -0500
Received: from sonic307-16.consmr.mail.ne1.yahoo.com ([66.163.190.39]:40705
        "EHLO sonic307-16.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232395AbiBCAW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 19:22:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1643847779; bh=fz7Hyq0u0gDBG0Z2rrCwOkB5zs8CxAU7YkzpN66/55M=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=JebglNjBLbVHK1+AZTwo8Ev/Ba7cpyNnwyxTDHXTfZy+B6ke2jgxpplvBVrAXU80Qo46zUM7vQFzC4U/ErZqYqjm4Do2Kqu6YnuhgzzScXHUjrh3T46rCKdctFlj/O4hvhBUnZQWM+1snM+AQuvuMdxyus1JamdoUovdnbSB04I4rgAvGrOw5eW6rc+Q7o9ZDaP1Pa87g3uyZO0QSojh4X5n2HwSIPDnT51ddfWWG8IsZj+iegfh9qtVKRPrs7ojvRQPMrN47lxGSWEegsi9GTcrYpMeYMenfMI3Ppd4nDf8kfZp55/eNfqr8U6tgncSoq1MZ6OPSFZzU9go6JpqHw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1643847779; bh=1hrh7/QyGiFHR8sMoH6XCsaYLVQmysBsimoIgTb+XPT=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=BqmKCj74G++/E46xPPdzPX9hJ4KEpcIKKOSxPt53ziiP2NdC01QBaUXWeoqQF+nud5BxZlqrncE7UCKex+ijfNm4lFp4V4MqbBDOZaaPskQKzMkeZd6Zx4AGO/IREW7YY0y8ZMsWigz0YZKIBTEFfdO6Gs0c4DB4HCPlDHksuBu/7r1Od68jwDO1/oBfvy1gVyi45Y6tiUvHqNxCxbKKX8HEVapTSRN9o7VZxiwXc6ZEyObZzVaf75nWZrt+lFkLbocewfMpTN83kcZl+ot+gJ/E0GjIO9OEirrSrmlBygbhzFc6yddJ5Qh3PGZSOrHBmEGgfOxABCBi+tt6mDf+UA==
X-YMail-OSG: 8PSwn6AVM1lgyBD6eN1qZJ.3wobOO.7bYW4PhLzmDxD06N6j2SCPohcqt0CcaBI
 RJHCvhdIcVNdTaAwTfEHgQAgwSj8.HLe5tLSVLgCmGKn3lxFato7ohhjUZKz08j.bcmek2XUbtdm
 OoXrj5FZMEz2XX2slyO4HHPhmwtxny4leDoIafw.ZZwOWjlEpR08nq7CKxlSAZy5nkYt_t_GFwIc
 Gxw7l.1MDsxpelrPUmtPYBp2tHHhrnWqnwLzf3RJSRYSCgp8JRF3YWjt0C064OqtrGY6BFnmlOE9
 GOFQ8NA_9vqGLs.qQ9HrXGP8SA7Bu8Dxu._2jCesU2vEFpWDZwjwrB2RWyLsiSeWLEnFFGtJR5hK
 NmWReY3uCAuEnOW9XxmErV.TDnll.1BswzgPWyXM8olGXvz3jKDOZU_bdo6OBjGt2O8UH8qSJrsR
 VTWo9VdK6CgKfuWCPpgBXp0ZX6sENDB9pA_StzszMDR8jnP8puQNVAQVUqSEF9RQgUBpkygm4_KL
 r4P3Uz2qm_19ln_QQxu1JIk4ywRwyQHc5EBPqNkFF0TXizCW.oDOHyzAzFZcIWvcAAp8PM5hqCWG
 IKRs4XzvukaTSHRnsQUQ8G3WEYFwzigOLM0x7kok3GLKZwiVyYt0Le.aCQ6yfP6i6c.c0jlMZdUh
 P7vjobxPGNqgORcpCxhxzPN72Ppqx74HBADh1YU6vTVjUKElrPDZZ6iMEOUi0wAOdXTXzLnOeSBh
 Ulnh_yoIHyUdDxmjFlMvENdNTw7wKVAxO8a90kB86eivZ7YEHiA3wAzMyBo7yNCieCXgrYywfLyg
 gWQRq949c_55LRhCjHZbM2y6aWXVpqCtJlUX.LVjDcCEDTLlQg90Gxa.OCVcFsyOZ0bmVnivElAm
 821iK9K5SNDTaOs9jC39jDFwQL_3d0w0GeOKT7c6TjcaxpkAcRf3lipBLrzEyjIYiPqNY2Adbduo
 RsXvig0GU6YTjZeCiSteC8vxOTSQllHzOSJrdcStZEc6f32.MO6R4DBahDSEUPbzO5qGy7phMwKL
 2nz4LnV4rve.Qrxwk5R2gflWmKy8o05TK77C_cXKG9v.II2BQt9Dx0j.s0oYuPHRt7Y.G0ixsi1m
 APrQBjuLTXkk82A0hBYnTYTcO.ZMYqLmfv.GV08gtjUWhfn7OScKv7xTPtOqFdhdVkij.gvw6zqm
 NxcQ1fk8_XPfDCgTn2pjZ8Vl_AIr7xLc3ZUFssmSg4efm7odSaYhkh2HZJCbkdorMwBNadNOccb3
 7t9n_wWOMnZSMEWedhnsm6Dblzh5yrZ2v5ykUQLhot61ie01Wq4jPBUmQgqmBUH0NTd01PXygsqo
 lIZD.U0yExKlIeEbOcZ6MrSnQvndte3x55GsH_4LR87wsmc1ZwhtpXUw3PcxHfUAEpr_R85NjhPk
 bSGnOcZ5L8HJo1ZKxg5MZ7l379dNmnLHehQ0zYm8Qka0De0JuG5CgHvNjwKuehHLKtSt1xu9wlOH
 WOYi21EXLd4XGDBGO3KJXu_pw2iQgxzdgLAqdR5BIpkvatMRnkPznie6PNW51wDtZLvrOBUkHnoo
 lXlZ6bt9vZjvdo8R2GPl6mm8nt.WVtGnEdPfP1H7LDzH7bpiaTQspge6ZZ2RbgMqfRuGAH5AYPal
 5JaFMPo1UEnmR4ujD.b41x7kPSwrXFPtHMq.X9esnS5umhCyzUfs4WcCyPY79F9jL0.lUFtcbFk0
 fNvOdpvvWnhBss6roCIQpWmpOkYSfE1qPfr52YtzD9Ue2n5FMEFWwNGx0YNrwfVlliQ6YaaVA14A
 SUEMsAsgdNbNjuECXtjB79KbHVIbFu2TcmJFZBKugEK_byAtZMDzWjlfmk5pmHcMeCvm2g.sUVKm
 9IqX9plumPCeNG00pzAzZzzkASzNTLKI.2W4maax6Uq5rR35iHPjHUssPfEuZkF5akTewssFb_px
 VI4v3No_bDQdkz890r_A.EhoT0F3SZAe55HXJJggkDiplA5Zd1lfChLEWqtbUfNT0dVNxeXo54Jj
 5ZQuRcqHLHI1Lqm5YT5TabZmZrwEz0g6Z4Qe3aQLqay.nqo2zsTBsv99v4Tnlfpq4Cmcf97PJyaS
 fYnHedRIXF6BQvkHXi_EyDR6VHwMhA0dSmLKbgJXBd5ychLrJChGQcTinfYYOmUwUUYoEiJyEVHy
 Zi_dsyTiHs0mnA0b5zGcImBO8ykK9hXPoCdyV5kYZLnSZKBFwC7SxtzbEh5x318vRD3.gowFJP1R
 2MHM4OYZ1cwwhF68iMib3I2q1hFw4MQsZpQeGrsywyv6E4XwkJTO2MrTk_nr6kMaODmcur4BKJd7
 Cg483WqcTbTzLWgeRnYMotEKH92mqHaU-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.ne1.yahoo.com with HTTP; Thu, 3 Feb 2022 00:22:59 +0000
Received: by kubenode527.mail-prod1.omega.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 02a9a4d42f588e0ef94355ca83943995;
          Thu, 03 Feb 2022 00:22:57 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org
Subject: [PATCH v32 26/28] Audit: Add record for multiple object security contexts
Date:   Wed,  2 Feb 2022 15:53:21 -0800
Message-Id: <20220202235323.23929-27-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220202235323.23929-1-casey@schaufler-ca.com>
References: <20220202235323.23929-1-casey@schaufler-ca.com>
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
index af0aaccfaf57..d25d76b29e3c 100644
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
index e8744e80ef21..3b9ce617b150 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -199,6 +199,7 @@ struct audit_context_entry {
 	int			type;	/* Audit record type */
 	union {
 		struct lsmblob	lsm_subjs;
+		struct lsmblob	lsm_objs;
 	};
 };
 
@@ -2199,6 +2200,43 @@ int audit_log_task_context(struct audit_buffer *ab)
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
@@ -2505,6 +2543,27 @@ void audit_log_end(struct audit_buffer *ab)
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
index 7848e7351cf9..41111b607c78 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -1120,7 +1120,6 @@ static int audit_log_pid_context(struct audit_context *context, pid_t pid,
 				 struct lsmblob *blob, char *comm)
 {
 	struct audit_buffer *ab;
-	struct lsmcontext lsmctx;
 	int rc = 0;
 
 	ab = audit_log_start(context, GFP_KERNEL, AUDIT_OBJ_PID);
@@ -1130,15 +1129,8 @@ static int audit_log_pid_context(struct audit_context *context, pid_t pid,
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
@@ -1373,18 +1365,10 @@ static void show_special(struct audit_context *context, int *call_panic)
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
@@ -1536,19 +1520,8 @@ static void audit_log_name(struct audit_context *context, struct audit_names *n,
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

