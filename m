Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 716E455DEA2
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:29:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243014AbiF1BOC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 21:14:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242954AbiF1BN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 21:13:57 -0400
Received: from sonic302-26.consmr.mail.ne1.yahoo.com (sonic302-26.consmr.mail.ne1.yahoo.com [66.163.186.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0129C1EC58
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 18:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1656378835; bh=1IU2J7EU930F0Q9lqPxlXd03lktbo4Qzuo+aIUWpieA=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=TWBvZmwYfIU3ZeapWOtAkl/Xfg3rYRWsLq9WFMVb4brD2bvRoExlPLYwPZ6TDISY8W57bSj/J+5ZLHsok4rlM3/BPZRll9J2Vrtad0XOFEkHeMS6+r7Q9xrD1slIFH3S4Q20m+NctNf1+TSzMHmVCk8jR8ui7FiAWMWDOdM4VWCqly/jnOH8nrlPURRANbwlgApFnbUwdb3Cpy936Wme3dAoF7EkNwkJ/oASmm6etmKqLcbFQhqFXzGsXGoEAw60J7BuXaMyPu7XaKlQpKQLHnQmFfC1JvUJZbYrFQyRlNwc78DH6TIjqXJNfgKoyi6FIcqQ4u/v4pwtcNWMqAnkIQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1656378835; bh=IKtgOcluzS8jLN9CK/zAxw5lDaneQgTY11+6h/VmHqk=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=W3Ew4LUO17n57c+ZBU/CFXONVJtpSbvf6/6d54Y29caOumD0MR0uF8OSU8SQOC9yMJGRLFFhj8Lmh9xT9MuNq1dZUf9a0NY2Y+CY+j/CPZEEDmgwgAozbHqeqbeji2dZ9kgLK2tF3YFksoYqn2ra2LH5Mllvuy85Dab96CO6dXRw1vUi2qhiQ+e1mqh5J2sPHSXxQ5VTU8/7W/GQKaSZ4tpXMrRpihJMSpFvfSaetrpmgLNVSeuW+ptySl24vXHmbPRtnjtcC4Lo4OxDd+claU6jXqs29jDA8MgsQCG0WAKXpvdV4LNjg1wDXeppcKfiifn97KlGkTTfI8DS0026BQ==
X-YMail-OSG: x040Z1IVM1mPyCczeQqnAF7c6JeZFMLs5CxukebdAxKX2yLIdzwcRz2cpYYqRtS
 2J02hP30jPnyDXVNr7H1yK0vH_lqxHegpgVDqIH_iZ.oeWZF1yQVPY2K6WhsmLolYP18fNlcXxPv
 Q.UaGbT2SaJjkg1a2rXigorCOLzYQctL16fa2znWAoP1m5zc_dQ4L9DFofpsn4xNMtOZSNzEJRR.
 BEkqzkH_bh6hFonGmUSrmYkAgcvOqkzLQ.Dt.rjOG9fPZVGkzDYphu__bjAwW8R1lI.fYScC_y8A
 vgXSoLItHiR_ywH2GbUAJEsZRGjXagqPrZg_O55QIRMxM5kDbTk..tys3h4L0qO3PAMWkAp.Y892
 A5Vf5R2d_Obe80nGLVptV8jl.mQtdAjLSAIqB2kGZUljX1h6.7rSN1PSpAJEsh1ooUc3BcoExlHu
 CgMGjatJT_RSdQ5dl6Ky__W6MYzV6vO4UqMaSOPqERVtHuvHV_IVN7Dkpt9Y07mTtCdzmrWHEt2p
 EqwkhKqUJRxgwNqS2Jr_HggFQ91HCapDfwvC5rzOlZwXGFl4gzjlHsu5NbE7darTQffzF_SaKYPL
 8pOWceb12TrD4reXmZaGnC2Ng7gzHQ3XQ4VWaLOUCjbZNY92nTZf0E5UMh5s1qz17Ax2owkjgxYG
 ld7_7N3tSX.da1ElkatCfMteh5atfS.Mx_9L7gIJbXrAAYiLKZAtSGbz1moxhOizhgnufCNqSJbK
 8yOCjONUcPk47HIFVqkbOLSu0VFmNIg1_5jCpaHnrt2N7Twps.blhxI32s73WHd8rnfnnyxNwpGx
 mI1uklhg37b9lZNAK7NDUnCe5J3r5zcR15eudiaJMgBWBM6bHV.yZPZJH3vj._uIMPMYh2qLnEBl
 LDX2MiMisoojr_btSGB9ucVgBpnF_2XHqaq5oXK__KoWXpZHvxc7TSzVUMj2uFPi1OIpNVYgGLX4
 fhIrqI4wt9SPROUJt01jdj2v1TmZXssGyLivBGZv89.ps1CQBSVP2JoEJO86BuUxvi9T_Tw5FwXq
 29BWZXJxbYBotJPBGbAIohiAedMdefQOaND3P1WHgfv_d._OfcWJrSJ0SZWT3vHgxfChKhIS2zbE
 P2ymAMXE_7PSmIJe_hY4xn4q5CfF3NV5p5cHEWfNnQya3Gz.x4GsMq13WJ1fWiAJbUF7V.6zfw3X
 9L.hHV9UXqDEhFsMBzquqOOruLjuOVM98Kn1Qk1_NPn_dk_a1QJTQcOY3qrilUWKwhzL8WpekMU5
 l2vU8aMxvyvs8gRIDc9Qvl9A6Q5VE.eHydaSlJaXh5mFlsRWLiUx7VJNeto9XExIpE4tt35tlErD
 qp64njHg9IPWkPiRjYVUMtrblo13Gh5cZ52KKVqDf4RKJFkFEbFHhbSp39fhFDY.PRjRc4GT5T0R
 iLiJ0qfb8dMuxxCgtGZ0nuFuqZl48a0K8F_Jbpv.uhEKfy6LFb0Pq4LdqFZMGKPTkKETJXS.Ou7E
 7QJ3bow8hBbqO7.YuNwmp3fS_E867VRd5dDWiPgz6cFNt6kJbbKZj_lUoDf289_137uwl72FKQdC
 Y1zwOq1Q.mB4QeOK0yGD3JFBsrD0MbcFsnlT82PsT0gIdd.DKXSZ5dm_amQDGAASYBQqpArLAABM
 WoxEzmUaGvGiaeuUdb9Exb4GohLWD2lIwPRKL.qOJ4lvrYCV4sxL_wfH4GYKBJnF2NuntAqs7uXI
 HzH.KY0i8AE6orvGgIFzJrnzTH4h4yrm2vPldxkxMJCmAjo5t5cw2serOoUaWIpPzt1Ni7AOHWTI
 1z2q686WY0027bT.BKhpREvkwuWLh.v0oxR1LhN9no74hB42j2Z.qeZ63KkMSEFBNHNplHtIQZu8
 iGKy2IKc4NckktpCbEhkcSJIY_296I5_GeufVfXB948rCcnEl_OxpVjqubAJMnxfYceirL1F6VFS
 Ku_n6ROneqEcX0pg2V_hfqX4HEL8HE_Lns1Dm6ax6aHDmOPzpSOV1PCGUjVT4tepRLZ8dWsGagr3
 dCJ0p5Qzw6hrlAva4DnTj8yM.PJ7zUDZI4qFVts_h1JPUwCYhBHU7mef_WthkFbICiXRzWaEBY90
 aB8MU5Cr4SUHrwpbtuawJIsbH4zUkuO4NxhgrMBvkvoAO6WJFYa_BxILeEXtpIkGXpCjuTIr5m4T
 9vUpRBc7eKLySIN4zc_YUiMzhM_5eTaVMcSIRzM8LUQ1N6gg0lO8CiC6u5cP72Fsc.MLQ590JeZU
 qwRllMm9AVeHdUCw2kng3e4L_ejcjnnfukY22KoGpreSm2.MUFmfSpiFADI5UMsuxqnP2Jw--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.ne1.yahoo.com with HTTP; Tue, 28 Jun 2022 01:13:55 +0000
Received: by hermes--canary-production-gq1-677bd878b7-wc7mq (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 10aa32686a323c4cda69b8a84be5c273;
          Tue, 28 Jun 2022 01:13:49 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH v37 29/33] Audit: Add record for multiple object contexts
Date:   Mon, 27 Jun 2022 17:56:07 -0700
Message-Id: <20220628005611.13106-30-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220628005611.13106-1-casey@schaufler-ca.com>
References: <20220628005611.13106-1-casey@schaufler-ca.com>
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
Acked-by: Paul Moore <paul@paul-moore.com>
---
 include/linux/audit.h      |  5 +++
 include/uapi/linux/audit.h |  1 +
 kernel/audit.c             | 49 ++++++++++++++++++++++-
 kernel/auditsc.c           | 79 ++++++++++++--------------------------
 4 files changed, 78 insertions(+), 56 deletions(-)

diff --git a/include/linux/audit.h b/include/linux/audit.h
index de661c571401..4f4ef63df52b 100644
--- a/include/linux/audit.h
+++ b/include/linux/audit.h
@@ -190,6 +190,8 @@ extern void		    audit_log_path_denied(int type,
 						  const char *operation);
 extern void		    audit_log_lost(const char *message);
 
+extern void audit_log_object_context(struct audit_buffer *ab,
+				     struct lsmblob *blob);
 extern int audit_log_subject_context(struct audit_buffer *ab,
 				     struct lsmblob *blob);
 extern int audit_log_task_context(struct audit_buffer *ab);
@@ -252,6 +254,9 @@ static inline void audit_log_key(struct audit_buffer *ab, char *key)
 { }
 static inline void audit_log_path_denied(int type, const char *operation)
 { }
+static inline  void audit_log_object_context(struct audit_buffer *ab,
+					     struct lsmblob *blob)
+{ }
 static inline int audit_log_subject_context(struct audit_buffer *ab,
 					    struct lsmblob *blob)
 {
diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
index 7a5966b46f38..e5fae08982ca 100644
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
index e66cc96db62f..98a50c150dc4 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -1107,7 +1107,6 @@ int is_audit_feature_set(int i)
 	return af.features & AUDIT_FEATURE_TO_MASK(i);
 }
 
-
 static int audit_get_feature(struct sk_buff *skb)
 {
 	u32 seq;
@@ -2288,6 +2287,54 @@ int audit_log_task_context(struct audit_buffer *ab)
 }
 EXPORT_SYMBOL(audit_log_task_context);
 
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
+
 void audit_log_d_path_exe(struct audit_buffer *ab,
 			  struct mm_struct *mm)
 {
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 539469bf1aa3..d84400f1ee47 100644
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
2.36.1

