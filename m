Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0CE9503195
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 01:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355967AbiDOVf3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 17:35:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355513AbiDOVf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 17:35:27 -0400
Received: from sonic317-39.consmr.mail.ne1.yahoo.com (sonic317-39.consmr.mail.ne1.yahoo.com [66.163.184.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED0DAB89B6
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 14:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1650058377; bh=THSmMt/jYH/D+Iz/LfOdT6bexzTnjyuZsXLDVPKXVx8=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=LPyhLJRI5AU6JFTp4wr4A77t4Rmq/ADgcXSQan2dFwzqv33FNFTtUcg+4z1zljlC1rfPpa6nafWXZ6jpqxGY41x9M63FAFrDwXAsDcylQP2rJSs0Y5RMMjKBpBJG37p36HAOx9+h6wT0PHoF02e12DMq7glhtXGYWhnZ0Wltf6yL+nMDy54zjboKgpBRlMX8rHkS7HjjbigiKi0e6lmMNshbDUkDK+59FILdbfwUjILFoCpRzdhTmJZQ926MJNkHUAfhDuxApn0wtlzPLVs7K+Z7NXGXQ2TgZp2x34xda4QX7lo7GaYaXg40CnHEMYEp450uTUEFJyl2rgpTWOzdlw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1650058377; bh=zU83BfaDeCPwJhUs6SeeowPyoWT0/7+ZX37+zLu2PUB=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=O9N6B1Iq5dNayHQMs9HHXwmVDf8EoB8qCPFyZ9/l8Z92Nwh77PWuJLRebZS10GL6+4vaoI3Mfsp9R1h2aeAJlff9qIhV+kWSs10KQ0UqHq95uDhbIxEcpQrXjWO6F1679qwSq8INS1guOhOz39goG31nchJwIBq8WpTDlE0CAkRR3h+qar4vVVux0Dmx/e3QkKsnbZsBYEGS2ODJe0u4237B/rjlXSNcobaLwWStFnA2MB4Ps2+znwwrkzGWS3CMKYPvrF/VQol6uL9vC+VqU98gddrFlEbk0sAgyAN8FJ/UbKTnBCpogroI2S3svK/99l7v5XLQj96hVTcxFrOXtA==
X-YMail-OSG: rxGYwdEVM1mV5nqzfLZwsimLDoh3bOdIGDA85kL8B9j.qEMNFUBjnR.TRqqwgEi
 ZLSlo5RIVxSWl14r2IGrYJ0aWPwUYamYrRXX6UJ9tVQF7Hq2nDppOSNhsIw.pczoqkR0kI.e2Itk
 iNeOs2qAthLtA7woYdNE1mZH0CtP2F.3zJmc4pwYzASsu3NEaeebotayqm5MWYJT1Q8FGp64GiGU
 vgLHF_3t8YXZPvPmke9xfqhbcsjzqRLfAS8.7rEocIiHyDDvIqpbKV77mDNO4o3eMGUZA7m_8keK
 lAHs.CMgwUKKPnzdVUHMW62bO4ySQLyqZEPFHM_ntqQlmg4mVDxq1qntXPEX0ebRx594fkH25NYf
 Lj36UaNzZ9exRG6r9hHEfumnlGVEIr0rqobXQClpoKdBsGyK.kDTlorIxoi5DyAmTwV1.EVbnyz7
 xFdseEKKWAUP3L8D53zS91vlQ1NJSMmqRS_hGdY32ZIUa_FDcqQlKUh7nVqiGB.wsWRvkATu9JWJ
 wZy3dNQlUATTN23o60zFao3OD06IuNgPg74sdMa2XH3ut9ouLfkzDSZKHqg7IqKWsn5dY__wrGGh
 CiP1uCbbcGhd1mP75RwGS.hmthortsIYbPWQdJ5VFvAqTop7PCiM71U5oDaNW9IhA64s0r2xt0yX
 WdvGj4B4CCkTC1HImcw6fRQj5Y4dmDOcjHBDH7bYXciZNg3pZHZyGh6w2mwzDswCPryWd36EHgWc
 CqHtewujUhfNG0VzKUVW1JnR13wMZX8NORqgZ2VfeGXcz_AVrOsWwoM2uvbmQIFbkpwKH7uFzxGq
 jdm4QgvtvuNHeJuCldcoZ0uTI4FOQcqGYgcq.yGrAQ6MEmYYEBmrRgcg3RlftEpzS2r8v2BlRMWI
 AP4FDKH_PFc4FHyu6YqNS1N8IztJzpDOMXvTEk6DU5iUdvdBoPnIyVStol8TsHOM96.UBSfXC389
 Tg5jsKwyearEr.tF373TBlnfjgQ7D2tYGyU_2RnYxa2xVzfayd3g1HhqU9DU.laZ2la2uU.T.gj_
 sYWXe45YWIhQVFZF4lOsIAftRfbBLIYEFueWGBpnyz.hXCrqp0e66sQanPYM2nKoURDUYn1qW7LP
 FGu5KlHdznkvIFeJHOGnZ_FL7qSF1s8Z94QgI6Ld6USPcHsuueDAd_J8L9aXPmocFtMtYw7vR6Jo
 bUxl0uFOgOsM6RhUE_E2H2f3SKYignYuVX0iOU5xLgtdhR0wToNK2Z_3NE6qN_EA.nnz_M2mwk9t
 wyEWLgCHaEIr4cBYL2I0_Hlw3B.fVLaLJx_yz8gESY1E93T7XKT66RlfhToyPbnXu8HNRBYwKwXK
 .S_mm2G6j6JlNkBXLEDN2ATo_RhrECn.UT1EdVnQHhioMSpwVs_XXviW2fYJQ3_Qmj5OAK6qILpL
 do9ZmMlCO70sJiR3JqYTklaA9CDmmk.3tAoasJRLauIvy6xIy4oUWX0l6IYJMAJZP0gPrCef2zwO
 oea.s5GQ1tUnJ6GsrI6UHtEN3gj7gDa9p2pkan6T51F9faZRl1CLeU00XILFfSthwa0MCa.p2lJu
 560V9Kpzud9mR3_p9Ng2OpQhLpHsTnBE1pg0ME_X9bcueZHiF7ftv.AWy5TtVf.4lRxaGXpA98eh
 _erpEj1F2nWdW6GoFojRKNigfv4u_2uTuAu.YfrYjFjp3p5Yeet.6jkSJ2gUtpYIDplgDnZWvJd6
 lwASovOsggLJY5srKMQw.mcPgvrI5zcD8cE7F1VjpZ4Dos_Lyuc7tyELtfauc_27Ii6VCC9cxErG
 IWd9XSRZCZPDbIc382GPEA4UwZzZ_xMcN_VEsxLXPFkyQvzlPCdlrq_r9QlB9txZ5yOMG_WnJtk6
 6jp6L_iCWl5wNDocndgTSYboKXVm7n9h0fPE10XqY.FfeZ37wnxl_E6aIdlnDNFZaNusT5l.rBVY
 jvq6CCdJk8GJSU_uA8WSPz_ym0XxC4lNX4YP_vDccZiLFzuvG4ivtc4gGQjNS4HALr5JAKw97_oe
 ynPGA5z8SGP8e99lEoD.E2HcEu57ha3eNfvBSXIC99eSiGH9Wv4W7Gxq.ZC6GX7QN8T42WSOJlMb
 .3q8XMjvudDQRXmx5YM4trVFlF3pJhdSWg_ZFJFxvceRF520ZOorQeueMbN7Yp3Pv70AzStdI6vu
 .QWrwmrqP.y2BdCEpgzqdKSsQZVeMAgm1P6G2dEAhGXqvAsmNUBWBsvlytz28j9X4aat7pmuNrpR
 mtH08H2tATpyFI47Hu8LaJiiaPsS551_.oYy.SZPpCKZld0EEPiRWIbXBoELmyUBVy4ll2_6gfH1
 U6T1QSEAvZuBaAP6ObpsmM2vrnAuC5T6VSrwrxAMs41EyQihr6.vkahe1xEc-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Fri, 15 Apr 2022 21:32:57 +0000
Received: by hermes--canary-production-ne1-c7c4f6977-hpxwv (VZM Hermes SMTP Server) with ESMTPA ID b492b8f8d9f0e2ffe991666b37d07d11;
          Fri, 15 Apr 2022 21:32:54 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH v34 27/29] Audit: Add record for multiple object contexts
Date:   Fri, 15 Apr 2022 14:17:59 -0700
Message-Id: <20220415211801.12667-28-casey@schaufler-ca.com>
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

