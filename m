Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11D534D564A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 01:02:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345104AbiCKACS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 19:02:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239928AbiCKACN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 19:02:13 -0500
Received: from sonic304-28.consmr.mail.ne1.yahoo.com (sonic304-28.consmr.mail.ne1.yahoo.com [66.163.191.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6657B19F476
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 16:01:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1646956871; bh=RTvVwzxUtupt+jWvRX6MSAbe89oWko2Af3H4A+UakNU=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=uYId9BIOR/aa22wKFP7ZaHT5rRi2MavrVtX/QH5ksk0wirA5HidFpQ4RE1mVPsm/DU5Yhg8CryCPk3Q5QPeffukhfEqi5T/pw0aS0Z1SaRh4f6gKiCTb+YtnIZJ99CcM/v6MZzglnwiOSBUQZcd+LW8Jr902uLlT/Ev9fgiDGdGBaWs7bsXLVkZSgCCt879Kr1FMKPt/KtoQkl+scXon1zT/HawJG0CgWrJgiRDOMlw2evvf5eeZjkzYK736ZIGgrmevZqGKldPe2Hogix4vgL/owdAI4RPiny2yB55kR7I+aEJ+FIwuACh8zi80FgRhuLttnBDuCOUllw94VqE1Wg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1646956871; bh=I1MXv7MyUoL/dKYY5ykBAj5y4X2A/9pbUd1PLz+yTon=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=k3n4cQg0XaVjDduHmcvG+a3rA7Kn8V9dlktb40YXu6wS4vSKDRhh/KXJKxiQfrRp1bYp99O4q48Sn8Spx8C5mLX+YD31XPWgbpgvpcea2AetVft5Lg+27c1jpJ/jLrm8mkVgbrjdSn6szfFDTHdIKR4s2B64g931S/JicZOgQSFRxIqTgAqnwQcfWJMpOBwp2Bxx2HCO7WqnFfpCAJH2F3jrKaxqz8XGTggA4TwDYMxbTz/B6NkHTI9Ek7eM5mYURuMgFZPrfJIJdiFuTbPGGkbZLxoGXK4cnSyqHv0f0jlLVZK4h+0NH1FuGu8VdepUdUO2DI7/m+ny6jFAOzV1Lw==
X-YMail-OSG: XYTl9NkVM1km3lRQCivx58.oqZxbDF8HtbQGh0EslpJmHKlnWj5D0NJeR3W_o.3
 K5bMgKMpUACnQru_6eCGb0XN4Y5jYvvyplYQyXSGeG4JV0W0_6XwSVBhGE95YGMoS7PkWE4mK7Rr
 PY1TUAiya31NEwXCVTKpjprOJdacjWASQVIeJZt41w3_Oais0bpXRcR30..cZEC1ulBR2T2HjxCK
 Dk8IMdi5nS7YvsddGEAXeBB7HztD2qnxxC7V.o8OQp.l..WKeJaf3SXR.rRG_WoTbOdYe8h1jb2m
 5agGHJBlYJGX9kPCvblGlr2xvPNujn78j844n_ljoPEh1aIH2O93.IIxiXUfzq779QyW7Enar5Hy
 zCKJ3sAJyPcR3GRG4TgMmyLFCmeCa97T0C2jBWQ3X66xtUdtGi5uqrvp05ozCDVEmj67tAgNb6Up
 qnKsPp3LR6n7wFHA8swVr7JAfPwrD1PlxY5QnyVYBJe0UQnshVOP7.xe_kRRy_7isRfgE7uLg1wX
 tqkFFKwZrGYoUWl0CpMZEak8TsTbG65HmKXPHmUMkTdFT76ckVEv6kMOH10DcYOKdAN5g483Stu9
 1mEXUb0sbck11mqlCyFyEVuNtrrsE2Yih8X8pGsU5OHh3TcyMf8DaFyX6.GOG8U7.kQ8X0U_aHU9
 hYm2MA1vIkx8sJ8EUhJ70EfJA0GSws4ZcL9QlYm65UeuNNv0ro9p4y6CP9Eq7WxhXrDopuXG9PXG
 YQIWB1FtLUTKYa9ArL0PP0bmdEKl8cKOjIBq5pJTBGH67dWH_0ecxdIdtq3zT7LpyynfliUUc.b8
 6StHm7S.XCH.yeNbKf8Wc6sFTto0Bc1gRcVTZnznpS53P2BYweXrtvzchpSi62_k29AXLCs8m6r1
 lN0psWCg_D5XwaDGUHo91z3uU0tBjygsv8yu3293yeHzZUmnflNPRkwQBkBxOYydUOZe1K2N8Pft
 knITeK1ETaWugzQh1J5VYTw65Ooiq4dGezOPm4.uUuVGZxYWi9Bh9wnltVc4aXZ32SZJ6FkuODzD
 HJGstusIdQHmt1PPPRnYFG6PtfYIwjyK0BpbLpfqM.fojcafLc6SPEAgrtCd9T3DCRTXb3moZxeB
 T950v4xylnCHMk92GjhpUUkTpgW45zzxEb0_FbWhWLqWXxWC3.09.l2_.uXHPgBOaiY_zBwjqUb.
 j8w93hFjpPVReERAsL8GM0FLKhd9_Vg3jUWfP9yEoR0eNymKsllr5ODAMT6gkB1kQQK_vLRZbwqx
 7N1QAoV3nJ4rz2zoqRii6cboP3XugkFf7qvD1uQcU0flh5A5PJBVhDakX2a33wC4Mq69ljtrepEP
 zKRZiTkfPwVAwTazu4tGGRVnLb_GYUxLMvkuodbpjUqvzCLnzpBH0pCQTVE0PcdRyiBObZTkSpHK
 W6c2lPNB3QmX9RYnsxxbxwkoJp9fFDUbEPI.zw8rxik3LM5y4bxyhXS0iSq.C3JUUotPh3pe.CC6
 R8xWcYWedTjYwbhk5e0xV1MGv67Sb6ix7J.wQgZGa3r8dqz80JF1YgxI6VjftQTQHegOG0iOL.T7
 GeizyNpzD12pi35tHmRmkGOkU8dnH_cRHtzI4gi4vATvGjgCZCxm2rC3ULFi271r8P_FptXVC6hj
 x1JGqheAQTBX0Ovewgcqw9ElKNvN3RBB2ykQWDnBHDyZstEa.B44V7MRFA4NGJ4atRg3GmFCTde_
 WC0h2dfNwUozlNbR5QyFqCzaQiUXfzQhs0ipqFEEBlzFeifpTdF53sysnF.kYV4nkp0ch09wK6nv
 fI91nZaj8ZKDsPl.omnmlv4f83OyLmHqHhm7DEhMpLwM8VQGqXkGeCzcOGMbPe1pdYIxysRzB.aH
 J._TeINYkGqsj0PsKc_W5iSPj.Vvol5lBXWPYFFDplLPujAZXP0b_JCGWFa8v1bHEBHaQooQYJ15
 lbBsGF6JNPRMiyKH81GELGZ08kxkO1jzMB9PkqIh.f3U9rtslnHt1OWWvwXEj4N1Ndq0zmN_zOpm
 GfAOfLvwSDnQ8mr2xkWYevyp9UARhUuxCSHEaHzexgwMGmcrtZoRJeb03xv_bj5uwlZGIt4_COQV
 s9.O4N2EAUCy_43kVJxdBteD_A5cOhM681RG9zrxCFx8qQ2R0R4Tca8GxZ.BOuGNlkZ9YVf4w8BK
 R8nVNpDNVw3xjt9zGC663X6d43QDfKeErRFSwt1XiLYk7ogHY0VzGMPIkkTLk0PTSxgpHYNiKz.u
 CXnm5wWkTKmSXdzrdrr4Y.7oTudJAv0RkwKNrxwhbs9ZEtbCIHU60NCwOGNIfbewVbJyaAZaZqv8
 G8dCAxPBrstFyAGeS7Me2o3WFcCKGnQ--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ne1.yahoo.com with HTTP; Fri, 11 Mar 2022 00:01:11 +0000
Received: by kubenode532.mail-prod1.omega.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 14d447c144378bdd823ae563645b8a4f;
          Fri, 11 Mar 2022 00:01:07 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH v33 27/29] Audit: Add record for multiple object security contexts
Date:   Thu, 10 Mar 2022 15:46:30 -0800
Message-Id: <20220310234632.16194-28-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220310234632.16194-1-casey@schaufler-ca.com>
References: <20220310234632.16194-1-casey@schaufler-ca.com>
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
index ad825af203cf..ac92e7fc5aa6 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -2202,6 +2202,53 @@ static void audit_buffer_aux_end(struct audit_buffer *ab)
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
+				if (error != -EINVAL)
+					audit_panic("error in audit_log_object_context");
+				audit_log_format(ab, "%sobj_%s=?",
+						 i ? " " : "",
+						 lsm_slot_to_name(i));
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
index 7848e7351cf9..923e4e3a5697 100644
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
@@ -1373,18 +1362,10 @@ static void show_special(struct audit_context *context, int *call_panic)
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
@@ -1536,19 +1517,8 @@ static void audit_log_name(struct audit_context *context, struct audit_names *n,
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
@@ -1753,21 +1723,20 @@ static void audit_log_exit(void)
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
2.31.1

