Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93DE654585C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 01:18:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232434AbiFIXRC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 19:17:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346000AbiFIXQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 19:16:46 -0400
Received: from sonic302-28.consmr.mail.ne1.yahoo.com (sonic302-28.consmr.mail.ne1.yahoo.com [66.163.186.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE1E13C2DFA
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 16:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1654816597; bh=sOP/u9XSiyXDsyWFcZALcYNGLP44f48Lv7XWnF70Jx0=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=oijcy3r1t5T6sXKFa+hn6pjA8OYv+L87ACg6zQpq55PVHTbsBg+ZZPcfNaJTGNBPBTZo4U+5gp8ALjj5P6YLkWSfPmDs7+yCOteaV+nfthEaeYCUxQhTg6BbjbgpZ9WPriCz6BjRV/Tf25OWm1PT4RPujE68CUkrH+/oECsIVeVReVyB/aXnY6IBpfYy0DovaeDxE6EV/m0prufXJbjQgflIbmkUjAvNLpU/Czv8nmzxxWdel3ier3bA/VN9vn+j4tqsIAOWFaqEXeDE5Rck14E1vKCCS1f5yMdhyN2qinzuK8ZvoPW8vksvj64e+eAgcUi/Qr985ZeCrETbIJWLQw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1654816597; bh=h1NBTZFRwcSiPprNLBIDKxaWb3cwxLces4joWcWpzM0=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=liFn2N5ommPexOFic5HSH3Q9D+dqqjlMcl+EGeXLCbophTFxehRqH92e2tQ60g4q2O2pGgZjKKOmdKAHCcLurq2qCPIKOVc2VRR3YXpvKz/zPScknwhfTclI6f5TXmbr6tb0Q4CP4lHu1PvlB8aDIqfn0pf6HIe0lBL0nKN6VppXR7qAZ7XZRVyhaBHReEwOthJlysyL6PE+HogcWT7GvJuMhDuAh3/KMASjm2KhwDzULsXUJ1mRg09SBuDrTtAQtemiQpp/wNpN4IKwiOI8ObrT638VuqcAfNpiOo+D9BWW1+gxlNQsEBanhqLmKEzg3oRp0S4lJbFdhNHfNIiLnA==
X-YMail-OSG: JB3RrvUVM1mVTzw75xNm6gMSu_FMHEFaAZItJERN.tBpdox2lxhbvTPto5ELAF5
 5lMQEsc0f8zlD_E9db4MFWCfp.PXBr5Ck51_136fi1_KXAjEJpxoR9G5JbapmKn0pbGRSws_BEHE
 t_FCgHWcKfEwD4dE3CGbWuK5QeQNoaFPyda2CcinYMmM.FuSWp.Iu8QzetDNwBpb_axZmgV267vn
 62CE5Wu0zRbAfdKrIqEvP1sTK2UZbEXcLM9b.v0sq95HMbeMz6yUU0loZinagRklKEJwTtpJBbXB
 Xr8Z2UXgcMne6krhUQpaa2mCL3mjNXLP8cO00.9jH5QxEjUSvgsxWSwIUqbqbsuMZu46qQGpeefN
 yfnpWHWHGi2mp2rs18whjC0HbGWP8kxiduEgZsfywf55lJWyblCp3SYurT627_PsVuonOGOam3A5
 E1Uj9Psj8lX5Ogu85Q2Im.xHGD_9KI.oJAaoiyoggvD1PG1i7LooMOetes2RUoYCal_SOlxK5HRJ
 WVkLsPls6BuG5LnWCiDMdUkj53EMpFgImeaNqZfGqtceAX473gOaXEtk3BvOITPpUCQl0uLO1kCf
 zBaYf7y_dI8IW4yHttP38T8xf1wuoHZXGgtdO21txIMs06PJo9wIDTEp0eB26Xuw5dIxbbSrzyOx
 qsUMyNe55WKX.4rjc24wYeJBDRnNK_yh5RksnvV4SNH9m1yRVsU1jdod4wTCVcShwXJptW4XziY6
 olv55stDkTsUbzsqHKtun2F2oEItU0OOchkiSEqAp5XVQBj3vIFhbFwm7SOrpQUcX4DXAAUazxZY
 8jEEOGxhLYTWbaSgNcRIhqOeiNsXzb1aoiLotL45bvFSXKLTuJEA0.zNjaTpcU.s5ZYC9Qh43BVe
 99jmT5EorWlwmaG8X_XbTacJ2CPM1h0hEzZ0r9JMrsG0EGERmFEcZ9yZhoZT5AQvxgY4ewmy3yjZ
 vyR3PBI0HcnVJdqfUCEpX2YkP0MtEQFjCsH3aovUd_MMJ5Th5c5BLaEUHvqshZWphwPtG6x2mvpx
 R80Pj09lWchCxNGztlw6y5.otpGYrPQjG40XQmqk0vImC_Dtwe6sIXcgUQbghMSsgBRWl0drRFi7
 FHSQZCKcU2F0CsKZBwBn_1IZiN3rricuQeJQ6KAkxWUDOsM_RahBO0YfEywCvdjpJvwTPbyARgjM
 9xnwtY5iJWu.DSp8ESmmsQqmqK8aDUGAA7jTY0bP7sQEwVYoHsMgidG.ORFIqG8pntXmhL1cK.qe
 a5VBwxkWIcjjDqtI3MQjRWoPY7L_xbscQjIuWaaC6qKHmQdzHKIcR5tLI38oXSmIhNCH4XUmZieM
 tM_Cb_Cbcal6P_UjEmjWWKWV5cPJxph856a_TwmAqXGL.EmNKdVkqryNEWt58emxRPJtFNkviq2K
 Aer7vHcAGt2M941kTyQFKZEPH.FJ5FPZGgJZ1odxUAxHYXTGPr7fDeUqufqZxKKs4neQMDYBNJTX
 H.0MIEufHdUTNNEbAQDVHAzLWYriRtaWW_mB5EKVrDdkzxf2gS6ZKmb78rV1.vL3Ijk.HdGlJmXh
 Jkg3h_WwPfHX1EXORSCd1Ue5KzpN2UHDgSpGJMwlUKdGjBJ4cc5_ZDaZqJHvizPvNFwcEx6PJvKo
 Y4Na20qlZKWgQMtVbh4K_HteTQHh.1SZQyjhRVPU4D5xcK.NsVkshPjeTO1GVRkU72zIKuRYmxoE
 Mah_iWXQBcX43wJF.ACBEpEjj4b0sKihEBnoV9RGVhbDR7XhBI2ZJ8Jw9sPTQWn8CzUb1Nxx2qtO
 gLKG_5xr.fSwksn5c5.36rIk.x8JPwxOQMSxZDmjSAKc9Z4lM0iABjeK9QIFmLI4GvexUUHGeXYl
 .ICvmNA67Uo8t0ibz2xhaCWlXRH7FQv7aSXxD4D7raZARhshKyogETjrXnjAr_LxGSpck3woJ1hY
 sNVY0JxvjldRnvut.H5tPadMeMVkOTwVm0U6Ir1dIM0ohBadAOffAqAIBGUvWA_UHU_AxHCJ.7TK
 Qj4gj.Ti786sYFNqvGzW.l59UxN6SlO6tnEet9F1ljuXkjN8PA6FRf0.pvNw1XEdbZbXJ8kxMmXv
 dIOEMdt18UBdVsXzdcmyqi85BLM1ftSB7xaqTwIZZLHNv6OEaEwnfHTv.4E8ObZwII3VnzhyGr3j
 Ph1vF07bpVMQGycE4T2FH.hbGcZ7f9Frhq_AXsPQ7Y7TWvMaHDREJL6JpW5MA4i2bw9wx3KaC3eU
 EQ8zhPJbzFrJMXKlk8eSFUBMjD4hCg6Lz1UMBVlXiSOxQEc1g_vtmgwSAq0Jh.STww5KzhFGyqq3
 20hVR
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.ne1.yahoo.com with HTTP; Thu, 9 Jun 2022 23:16:37 +0000
Received: by hermes--canary-production-ne1-799d7bd497-7lvgk (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 2d9a335cac260a86aa8227596f2c755a;
          Thu, 09 Jun 2022 23:16:32 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH v36 29/33] Audit: Add record for multiple object contexts
Date:   Thu,  9 Jun 2022 16:01:42 -0700
Message-Id: <20220609230146.319210-30-casey@schaufler-ca.com>
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
index 4ec86d696753..0f9393f5aa4a 100644
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
index be2811d21ba8..d091eee4b991 100644
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

