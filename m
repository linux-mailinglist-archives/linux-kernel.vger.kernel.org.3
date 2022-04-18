Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1140505BBC
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 17:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345735AbiDRPrZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 11:47:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345645AbiDRPrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 11:47:08 -0400
Received: from sonic305-27.consmr.mail.ne1.yahoo.com (sonic305-27.consmr.mail.ne1.yahoo.com [66.163.185.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E89935B3EC
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 08:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1650294866; bh=THSmMt/jYH/D+Iz/LfOdT6bexzTnjyuZsXLDVPKXVx8=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=qiu9X23bEpzyY+FRQwPtfPltb6pSM2p+KgsU60e3KicQ3u7+s/U5LYiqaVRLpYCRVcu7Ldpsa8jdbKStDfb6CY8BzSNqIREHQKCi6uMCUu1G4KMhftalP+Ev5o7+GrkFoha07zueNZtXIVjzCzF6NvMOq9B0dygxBhSG6fp64ljq7B8vaVt8PMJvx0s7pPgaJFS9nKgizsilSEbMrvFcO8X2rNjOECb55YRhLUkz3/vwU3YQOvExkH3xIm8s2irUAKWuzJufKzEM6qEoHZTBAxoS7iQLoc7ZDkhW5PoT8eEeaQ+AUrY08nyoOvdh/iDk79l6V1r6LrrxJTFIZIRgCA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1650294866; bh=BdKTJ21h2NPBp0xOBZBGJnDCvy6iafVp+GJ6GlkHl6F=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=gIjgr8CcIvB8fhBHFfWiMAHq/H8Yy4lvfC1lNRy5EV++h4fB2i+hjK+7+vKCacuOAFxYzm8euFbzN7XId+VDrT1wvxN5TX3+WrJbEw5WIIyR+TH18+bWhP1XuaEbHKjFWGeQpBEIJxYUqBTt6L+qYZhp75SfB2/Pw+l2krMBNCO4tta5NYFJn4Qat81Pc8M87lArl72cHnwjP40tYZ7KiHbnwo8KZOgNbQUKdbIuLGPkOxLmDQFxghTA0+U1xjwIRNeHWDw2jIFtu5OEVdzjSc+Oy66gVXRcxpV/a7Yo8cCimKQmwnrxsQskLHky2ocDLDbsR1Habzc0ZgNIuP2gJg==
X-YMail-OSG: Kbr1yM0VM1lwxGcGtALRsZKodwuyuaZ9m4zoboBBD_e8W0CfRSHRW3TfNdaYl7X
 3MNEh3QJwQyGxhvomZgZqiUjlrF627u1_BRW7xMBJPihAU_wPbaVRucgvCvWGPEstHZoguOJi2kH
 zReURwSjBSgoql.5R2xELb5XfqVl4k40jUBJ2obWuZvRTSuYYZEACCGziqXdwTN6xBlJdsXdEBXl
 8a2tYmw7KXh8JmLDfDoo7y5QRz5RJrtWTNPPuqKgibErQxy5RDwziKy.uwfr4VFH4FuBnqr950p_
 JJ3lZj3CGJLUi0pyG7_zbAMoerwVEYNTBfVLwAc7mtj0r4jRWiP3KPqojJ7s.a_rovMtqeF3OrRc
 IxYfW_0QbtMTtwzq48_024eU2I1lmYf.NJvvYRRRd1B6g5fwrtYU5awNwmmMO4i3x8NHIIyIwmct
 L21k2ljoOtgsa0lEbU_ABvLQ.alcs4WZa_cUd4d8gF5anNjyx_i2m10v74osYxgF.uEM6KiQRhlX
 wHq9JePqadmiMSy61M45s1oHOti9r9Rj.gBDzIZxQxvcmf_hg.QiwQ1aJLekIRV4Xc.7wRv8MtMZ
 P_yiPMCXgEtC2NqCws6RLMiSfq5YKtiJNlXh33VyH.W7bXCVC0kvXigju4pi288JpE147DCB4yVq
 BboUvsS49OYFID5EgFasOi8n3v2pwdt1V1aXgPheW4V0XI0eXa8Z5WmqRxWPN95Qw2KIO2GqRRb0
 bABO7xhMcvQiS004m62U5RAZbFAFxgmXdITR2Fi7bTbMS.D13igKshQyOFS6czf3vckCw70_Y3cC
 GCLlXTx.G0Vi_gFfw3Y2xjQgKRBcn2v.DmYOsost6MS86mN4vir0B4i_pf9szJQyx1caTi7n6LOg
 IixfQsptRG59qzyuxcq.FnveFJslUlwD3T4dVfuGyby9oUdqJI_db9.lkSOuEli1V0G.QTaryPQw
 JRmWt83BCKjt2ouTKSg7PRdrK1xvElqZ1PTKm1nD16aRo77WpNgdza4fZ6hHjeNPBpmzeNzzytzk
 UjZjUu0Rjh3i5bdM8B1TMbZP9ja2JpQko9txwDlMkEN_Jlbt2rS72wVuEnhKDOzteVzrsLZOxakJ
 fMgS.8lIjpEvoHkRq4IQbqd3qA6bOzd38Hjk.tm2IxCZr1Tf1rpoLdDVWFLA63OxGipeASCQ5Ozf
 Kn0K7_h2tovB1BGZSa1S2PaJacyLcZRcHosis39_PYFDYIaUriMvCyEfWrlB8hsx62CpEOXhVjuI
 ww2venEGhK.5eRx.uWjdE5DXHwWm1feqvdpTk4YTD6cLlE6_VxJc0dpjFoSUNH3fVbjaS9F5ifZw
 8p3mX0mG2mWK.DQbtZZHanzZbreQgyjPK1hP2LhXe4WbN.WnGbNlllFLLA_MicP4GvFR6OFL6KLD
 G4.UDRBz_GA6XROENQxrcOnDg6XeKwn4L3QVBWeJyBlCDWRnzAXiQeWfysDnVR5cTpgt9_cYtYfa
 xwXNY4PwuoK86CyTQPwAx.EwmKXQk8d2wg3lSD18HbgvCGuR8GlIX_vs8gb1UCmFRAUl0mlHBkG.
 y5BFzSen3Qihk6VLoFTZn5De_KoAwhCI78LYh_9sCHxGlQ04QlQ1EECIroQ0g4JwH6xb7Q7MTVLS
 13KBIVJQwhpraHJ0OH4fSsaiWSswQHmUUDKm_aIxDYqQAIQ7G5PZm7g9F7IRbYHBYBPdaYarkHqX
 WK1O3ogRAbFCs_zXF9bGCVxpxYv7CXe52zS5C7q_WCB_RpWa5qN7RXYr87oMM1xAFa6DijEfPcCp
 Zg8iWkZiiduTNXm0GVEKUWLPMlj.aplWh0g7sa8osX.F54SAysFgyX95MphYCJd2PXJ..3tEKR.b
 pW6ZZCqOaHg5ML4KdbYuUaNmkhYA1iaXYrJFyXErZnluP.0KQPQewNc6TfJRe5DPqGXOINWIxeDq
 Dg04Md6JMVUhE2IocfOZ5TeFgrxyEF3eKrBsJopLl8UAtSPer3iCqbkV32pu8Ocn.NShlZVvtmPy
 etpXf8mglUVm4Rq8gFwxEfNHTRAX.I43vbkUQy0s3EiMOg_qjSaR.Qv4j8A_Zt4zfjIijqhj2hr0
 TQhL7_mkSCLGdhFqqfmwhhgmOwd_U_G8ihyBuGEbVwAw8yg3Suu4.AKfMNxzZyimA48RCakxwXfP
 JSQoRhoUGFPvZ094e_N.GsIN..9Oehsg1neugywXC.NSJObURPC5nSbbuFoJB6rqsHHqneLIYbLI
 xIFh0CTThxlJTX1zHkhpF_gwjY.wBoLF1q6H_7UpR2fzxdMkLnGWPzjAyP7ed.RivZkrkOIchuuk
 0jINz6eRnxWyCUvZA9n.8ruWZvg_c2plYyMcWl4Jn_XLjGZk9oGVSZWQ_
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.ne1.yahoo.com with HTTP; Mon, 18 Apr 2022 15:14:26 +0000
Received: by hermes--canary-production-bf1-5f49dbcd6-xjccz (VZM Hermes SMTP Server) with ESMTPA ID 311eab809775b4af02ae966c725fa26b;
          Mon, 18 Apr 2022 15:14:23 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH v35 27/29] Audit: Add record for multiple object contexts
Date:   Mon, 18 Apr 2022 07:59:43 -0700
Message-Id: <20220418145945.38797-28-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220418145945.38797-1-casey@schaufler-ca.com>
References: <20220418145945.38797-1-casey@schaufler-ca.com>
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

