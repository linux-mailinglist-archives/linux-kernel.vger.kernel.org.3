Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E686D4F8958
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 00:14:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231752AbiDGVjq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 17:39:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231770AbiDGVjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 17:39:42 -0400
Received: from sonic311-30.consmr.mail.ne1.yahoo.com (sonic311-30.consmr.mail.ne1.yahoo.com [66.163.188.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 248651CA39E
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 14:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1649367449; bh=THSmMt/jYH/D+Iz/LfOdT6bexzTnjyuZsXLDVPKXVx8=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=mgFC+7RkyAHFcSn69qtU64CH3WLetRXSO7q9ht8mGWoOUEqYhttEvyUrUvRDAX/DcYSuYByOt62fmijn/0WFXrw4aDPSKm/suwTCMEvrwOKk/SYG5UysXtyJCsH/sfICADjcjZecpzUDKPKkLBD9kr48fcd0206eYwoiyaXbCJmZxmWsnWj8+R01Yka/lFwMfqsw2UtK/gxr6kIxEjn/XgxjKvnCL71qg4/odVrd6zD6N22wIRcqQM0THlpYqFB+Ad4L7B2VqlNe8Q3hHj9okT6ELWoP4f7P0BXEWg0nk1R2TjOHQy1lqaFFKegVg1LbGZ93oUnvnO12kML96bgyRQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1649367449; bh=DQj6QjIvMT0/lRWCu0+WMx1xgWYilDlWZcV9q3bdqJa=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=lF2z3WUVtmCz43thqnfJNqEESuVmHbGQKpvAns8gZLdsKF/Sa+gwa8gNM+62St3hvRhVA/qLsAS2uwztB4Zukm4KFlg5bl4RhhK9dqEO6k52hf5kpRTkdhi8OeCzVS64LIUvCyZFfa4kS1JbVFUQZvVMuV5sXbY1DhzNGqUhk5MrqBWKmRXQfl5sLvNi3r+og9GIROB+4BPnG72XZDiwc9c5gwyys4vgwD9of2b1O0bmiEF5y69f/GXWPWFG06CRgorZzIGdaXlIXYVx6jDtR9zm9HyG+qgsDcnkWFj8lvY5S3GgJST6E+OMpbhnv58wldjCOOKV+0JQFkb6A9vntw==
X-YMail-OSG: cx0zfAQVM1ljcm3nab.djIBv4OuQsM3Is6GH2O81dA_1oTSejYS0NH8WbKIkyoA
 kL_VyFk8UW2s2NS37WtulPaV99hx3zQi0JhIb8wOBKIMLZxufdbAv2cb3CuDTSOiZ9XAWgNkdNvD
 W8OzEqZ9DhE2B6i9drdaw4Y1rmMeR31Qmvz0rZkB.lsOTisNzR8vbwnMPs2jSTz7G_Wpgnpk8V1b
 tVSOzUPBaWcDUFxKHj.vm5E7W7UVINNfO6Ga3W3q05L5efbzoJaAEZQugLRM1sENmrG0.lbBTAeL
 GaOmwOEZTj4R3hoewSpgU..z.hbWt1iDqayupYQ5idoLfZPJhQV224.MNWWZxofBeJ98RGMd92UZ
 5KaGFHGHawBqwB2IYNYICxi.b4HhhT6Bv9XJVFV4JoRH1D7FZEpUN58cIP.2u9ENDjNEr.cCz1fL
 KaaQTmf61B8Wu.pIv18TF7WctFYR_PAe9BDRoX7I7LcUbHt2PwzDcdVQNhjZUCDOcEyad4O1xsdD
 mWZNoKYvNKSzwgotwV1gdyqyWUces_nC_uYfwP2QffPAipM3pKwud6o_GMA9o_YesKkEPJyLK3zi
 ajLBhLt08s2gVK5xFVvVInR5GDPlNH_1mx83h_9dCXmRqH_ZLwrrZvj86xnuXVLDLrvlCnywBact
 zfRdh6zEIHo2lOfPHfYxQHJB7SetwNmW8IC1jt2xLFIjGn0gLCDFVgu4iq6BjxjSkpsrJ5tKLQEg
 CTk9zgGxY3PEvZtMfZiAyDFgH8N3HvdRvk187oPU.GiIMDHjHz3YTfipNBUfGxmQRDDEkMjcTyHY
 GSHp1HA.tJoKtXNRWRd2EHBf6nR5_XGhAOL555EDoC5K48NUgMoQ4E3itpGAVQ49io9dLhj38E2P
 6Qx856Z1_.TyEDEqm6BLAmVHPHeCbzqfbaV4ASsq9PlyW9TjjtwPmr57QGYl7XsHcrjcwHem6biR
 BGr3xS4l_epIbnxmGhFTOEZxRkWSteSYtCRj.WMGVo.XLnROcthpfybwoApXz9KBv0PjKCS9G1hP
 ZcthxI65hwn1XJeCCOXPrqYMPRG_cR67Spmb0LkCoI514KUAJn7r3aShO2BFu_DI.b.f2tGXpESX
 GoB63mBi6DysHJ.BxNJrt.8kAy_DMIfXZgLgdx6b.dK0KSlEDYJqtReGVlMjW9fxjjfUTGj3tJ2d
 Zj7N7uoWRbqf_zYAfFHEWLCA6iO0FKMqBMSDC18KO.FgSxHnapGzZDdsli_x9GLOG8sZczg7Fo.K
 ywjZUmIGQx9kaD35e5C64OT5TGC.9MZlgoY8BLGtk_RHacoeLivigg1tL7h42kCEuOEt3cq8nSEN
 7O7NKKqtTmOapjsyxmwpJaXH1xbRvQSiWyglo24QSPFHbIqv4ZvsQUiObwO3x6KCyWIi1p3RZj1p
 71huHMkK77RJi.WoCfj0d7d2EHGhRFjqe.L1vCqGTds1u2eq4t7DnVX1ny.tPxPPxTDOPux2SRMu
 bZ4k3qJcEYuS21PPCh4a2nJdMLK0gtlxJYsUNCs12uWK8BaBDelqy3Mts_Cd9YIOOUU_0poxCfF6
 4m3CQZYYuIuu5mFyCb0Fp.ESbj.AYnOWrS1hLTxbQHgfbHerlvrNljt63dnE8knsf2t49Ryn4_J2
 qk.D3WwyuxX86CIpa_wOZhVo1MIzj4qXDj_aMFQpy9oMNIAVAoq17tUOK3aBMncCsU_6vW.iXpI.
 tJX_srdvG4DHF2oJIfvEdHvYBbIw3mFEd8IAc3SOANNCoDgqjWb2D0K0NzofGWN6NmmJv39MJWv9
 jeXv_OzmuxaoaeaiK.MAMxuSLicm20OGu.EYjDmFS2QxKNi.vI5Dy81W.DVVyIGBwdq3ieb8KUVU
 8pUzhzMb8yQc66VquxFcRWJ_NNG42hlWQx0o9TJP4IFunjONN86AXnKuzCbo5ksOwCtovrP0rYIY
 .UFwpvzScO23h2wDSwEmPzDaP9_pjpaz69txgEN7Jv2Ump5lHtk1z5AC3R7wN7a9FdgOeAVrfekY
 DbwEsaYqFmxTDQ3Kt0s5DzgzpSGwy3hvXPGJ9iQyHuLdH_GQrLV7BIqQkAp7jRJnSpywOxkTzSk9
 gQgBWFl4auNbffpZn76Qf3o6JDbOgCuyHyjV5a_srQyYRum_N8he9NSuuh6k6zLmmc.YKuXGkLCv
 FpxlElj_ZYkFHmkn_t2SZroM3_9ZQT7MjtuzjfgML1erhEQNk0FlFC1Nqa7lvdx6lnLru8t.dApg
 wWWieAIlwnRQx4KLwGvqwF1qULttk8VNUWgU.Zs6a0IZvbMuE6mbVQFbrDg--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Thu, 7 Apr 2022 21:37:29 +0000
Received: by hermes--canary-production-bf1-665cdb9985-tmblj (VZM Hermes SMTP Server) with ESMTPA ID a865fb4ad0018b13f62bbe44bfe50d3b;
          Thu, 07 Apr 2022 21:37:25 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH v34 27/29] Audit: Add record for multiple object contexts
Date:   Thu,  7 Apr 2022 14:22:28 -0700
Message-Id: <20220407212230.12893-28-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220407212230.12893-1-casey@schaufler-ca.com>
References: <20220407212230.12893-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
 include/linux/audit.h      |  5 +++
 include/uapi/linux/audit.h |  1 +
 kernel/audit.c             | 47 +++++++++++++++++++++++
 kernel/auditsc.c           | 79 ++++++++++++--------------------------
 4 files changed, 77 insertions(+), 55 deletions(-)

diff --git a/include/linux/audit.h b/include/linux/audit.h
index 14849d5f84b4..1b05eb2dbe77 100644
--- a/include/linux/audit.h
+++ b/include/linux/audit.h
@@ -191,6 +191,8 @@ extern void		    audit_log_path_denied(int type,
 						  const char *operation);
 extern void		    audit_log_lost(const char *message);
 
+extern void audit_log_object_context(struct audit_buffer *ab,
+				     struct lsmblob *blob);
 extern int audit_log_task_context(struct audit_buffer *ab);
 extern void audit_log_task_info(struct audit_buffer *ab);
 
@@ -251,6 +253,9 @@ static inline void audit_log_key(struct audit_buffer *ab, char *key)
 { }
 static inline void audit_log_path_denied(int type, const char *operation)
 { }
+static inline  void audit_log_object_context(struct audit_buffer *ab,
+					     struct lsmblob *blob)
+{ }
 static inline int audit_log_task_context(struct audit_buffer *ab)
 {
 	return 0;
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
index 8ed2d717c217..a8c3ec6ba60b 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -2226,6 +2226,53 @@ static void audit_buffer_aux_end(struct audit_buffer *ab)
 	ab->skb = skb_peek(&ab->skb_list);
 }
 
+void audit_log_object_context(struct audit_buffer *ab, struct lsmblob *blob)
+{
+	int i;
+	int error;
+	struct lsmcontext context;
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
+		audit_log_format(ab, " obj=?");
+		error = audit_buffer_aux_new(ab, AUDIT_MAC_OBJ_CONTEXTS);
+		if (error)
+			goto error_path;
+
+		for (i = 0; i < LSMBLOB_ENTRIES; i++) {
+			if (blob->secid[i] == 0)
+				continue;
+			error = security_secid_to_secctx(blob, &context, i);
+			if (error) {
+				audit_log_format(ab, "%sobj_%s=?",
+						 i ? " " : "",
+						 lsm_slot_to_name(i));
+				if (error != -EINVAL)
+					audit_panic("error in audit_log_object_context");
+			} else {
+				audit_log_format(ab, "%sobj_%s=%s",
+						 i ? " " : "",
+						 lsm_slot_to_name(i),
+						 context.context);
+				security_release_secctx(&context);
+			}
+		}
+
+		audit_buffer_aux_end(ab);
+	}
+	return;
+
+error_path:
+	audit_panic("error in audit_log_object_context");
+}
 
 int audit_log_task_context(struct audit_buffer *ab)
 {
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 557713954a69..04bf3c04ef3d 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -1114,36 +1114,25 @@ static inline void audit_free_context(struct audit_context *context)
 	kfree(context);
 }
 
-static int audit_log_pid_context(struct audit_context *context, pid_t pid,
-				 kuid_t auid, kuid_t uid,
-				 unsigned int sessionid,
-				 struct lsmblob *blob, char *comm)
+static void audit_log_pid_context(struct audit_context *context, pid_t pid,
+				  kuid_t auid, kuid_t uid,
+				  unsigned int sessionid,
+				  struct lsmblob *blob, char *comm)
 {
 	struct audit_buffer *ab;
-	struct lsmcontext lsmctx;
-	int rc = 0;
 
 	ab = audit_log_start(context, GFP_KERNEL, AUDIT_OBJ_PID);
 	if (!ab)
-		return rc;
+		return;
 
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
-
-	return rc;
 }
 
 static void audit_log_execve_info(struct audit_context *context,
@@ -1420,18 +1409,10 @@ static void show_special(struct audit_context *context, int *call_panic)
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
@@ -1588,19 +1569,8 @@ static void audit_log_name(struct audit_context *context, struct audit_names *n,
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
@@ -1805,21 +1775,20 @@ static void audit_log_exit(void)
 		struct audit_aux_data_pids *axs = (void *)aux;
 
 		for (i = 0; i < axs->pid_count; i++)
-			if (audit_log_pid_context(context, axs->target_pid[i],
-						  axs->target_auid[i],
-						  axs->target_uid[i],
-						  axs->target_sessionid[i],
-						  &axs->target_lsm[i],
-						  axs->target_comm[i]))
-				call_panic = 1;
-	}
-
-	if (context->target_pid &&
-	    audit_log_pid_context(context, context->target_pid,
-				  context->target_auid, context->target_uid,
-				  context->target_sessionid,
-				  &context->target_lsm, context->target_comm))
-			call_panic = 1;
+			audit_log_pid_context(context, axs->target_pid[i],
+					      axs->target_auid[i],
+					      axs->target_uid[i],
+					      axs->target_sessionid[i],
+					      &axs->target_lsm[i],
+					      axs->target_comm[i]);
+	}
+
+	if (context->target_pid)
+		audit_log_pid_context(context, context->target_pid,
+				      context->target_auid, context->target_uid,
+				      context->target_sessionid,
+				      &context->target_lsm,
+				      context->target_comm);
 
 	if (context->pwd.dentry && context->pwd.mnt) {
 		ab = audit_log_start(context, GFP_KERNEL, AUDIT_CWD);
-- 
2.35.1

