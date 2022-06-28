Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2334055E33A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:36:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242999AbiF1BN7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 21:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242967AbiF1BNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 21:13:54 -0400
Received: from sonic301-36.consmr.mail.ne1.yahoo.com (sonic301-36.consmr.mail.ne1.yahoo.com [66.163.184.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F9BB1EC58
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 18:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1656378832; bh=kRWyRnOcPJqVHyLojm6fH1oM0GqptpqLobTc//xz+3Y=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=ZXNUjvGELhPo3sghoV+2ggEy/1XYOvkVJjSZyZcsfFp/PXCgqL5Tn6aNeAbD2ND8gl+4iiakC61ce00aTdxlUuJmI2VeYF8ZUKngmSSivudni9sl4aX9/J9Nc4AYsy31W1FsP9gFfsAGblC1vZB9wqKzr1gWgfmpyo1CuxSf9/jSdemc1xcwDBinQMtFiZe6n5Ckf2vyMc4GXi6peGwZ7j/vkMZr5cs1fxE0U+zQTn8p6r0COsz1m1NRFVXOUYi0Ci1IABZ8bzQv9bs/SP+jE4dgqFbfBtJ+DB/1xG0xy9OVVHYXyccOVufZ7gyrgCHnpjGwJ6U2cHIO3PYVI1P5Sw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1656378832; bh=4R4GAfGBvujRgioO0YE4JS8Op/wynGvIty7qAcDPwyy=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=gaRkcciTRXP0IPSkq5jMk5G4QDYNJHBdy5wGYmeI3tAPxS98PI05CAu+U8+BHqHu2enuE5dG0W3r7WLtiEL9bPR14Gsd4nEjyjd2eSBoIRZkheB6RUFUaDq7vUsGJIC4ab1ZXQiMwpZzKfd9qrpANBS/FWbQYO+ptra6eWdmttnrukk3hcICVdsu5lUreH+RjMpO6VTbRZLNkSKzfyuWRju2E+LKPBgAhov6tSVeO//NQU2d3BHxrSc/iYDYSxlQX17AuOlSJKuXDAhTZx/DT9KYZ4f4WG3v+6zVocHw6NaW/hzgTUFIquXSuwND8FyYEMVQDK/w8oBYkqYxEmuw+w==
X-YMail-OSG: rg6XsO0VM1m7BaPQXoJwCjGMIntvuIADTFa43ynvu3oxCbuUIvFFCUkx8nb5BZG
 iToqhRq8DWBJGGVlJqlgQdirxM.jd9kNoSa98k0lFEFNcGxo53ia4ZmdVS15zs3sED0LA8QARbvq
 4lQSSlS2JMHGaJ6REgX2beNjzeYTQ2QvuhCtfSiAGFlZilKTw65bgXJmN1jihLKtIvQ1uJFZTPSI
 454gLHEGMa42.MVbSVAC9y7Xgrux4VDHlWkno_0qWULTQu4M9e966CMtNacgJIJCg2l1BKAmkpan
 M40TfjixCC8LUlPCVzI7xel1FMO_igJnj.8vsSxdpnsnN6kT0xe7SJVOBHVZv4PiAaMzE0vZ1jax
 .29Wh6jHFQLD.vvaI0cH4C0rIcON7Qu1n5qYKngxf_Zdfv_g_5_VhjAzZGFGvz0YY54JyjboAVtZ
 TdtMgKHRiL7GV8vKA8NENZKRdG.9aGTSCATENJz0kb64akOljDd0NnL8XdhsUn.z3KRwfAKoVaA0
 iyypvlLbsyeaF11rcZbBQdydctvoCZCJ95iUKBWSpF90cIouQUc5ciJxmcl2L1ggW4iGbm_L5vnr
 e8YseB0BUHHlp8am1akU7He087xGneGZaz7kZDqkVn0Zu3ADyau6BqtJ2tZSG4mXgbZPJ5Rw3GVu
 s4EfY8HvqlGLEMIasUamzp2R5KsHD19ZWY3zSDjU5_UJl40CwPe4AZ70Mov24JIXMRms7hDt94Oq
 T.Qcox2BTuDdRKkzwQNkKVbgr0RNwbdVc8M6tAw5X44rk4VvLXcJoS0LMd0P6E8QB_dhusUohW_4
 U_8XoOysuehwbX7kdxpRTuVg8gbXUJ1Fdt1Ce3vrXJWteTlAmFfZz6rgGcCoYxixAhyNwc.T.Bq0
 LEYSIv5NGjYNjdZdAUjwZiKZmqorAchI2Ht._G4g1vKIi4yFi1fE.zfwOtwjuAMP9a11zfYXavBy
 5zOxL.KAuNauiswAzN7Qv8IrRrU80DUtwclA0fR6fl45mkG0QmKtX7m_ZCpl.8bxe8MR6pztPtlw
 87_0mufhMAY3DGAUXsa7Ufn2MXR9q8pqGdV_qYSk.5S.n77HozKwvqgCe6pGo4fnXSPWaEK6KGuv
 Eqyad1bsGVe7MguuvQ2DWRHkraxoG8lWFjSArp6ZptVacyju7lejny8PWHb20lQskhCC7yt4cakI
 lq8U1LKridE9fvIiZuuQeab2prpakTj9jmp8225YLGRq4xOfW00rfvrQwcgW.EpAD8chBgYtHjLv
 stbfibgk6DOiDfBE9S9uzEAmvfbAgFWQ.Izqvs9Fu47at8tBdBrmgdJxpPvwVWU7qtq_eT6yiAIf
 yOyEK6UY2v6uYyD1za_.Si2Is1cmIJb.ZIM952E3Ovkf_AFNEdKQx.tpzjphJ7R.s4mpSFbhZrCj
 tib0117LtPsT2FCgzGDjiUOSWTQ2_foCIBG6dek028EZG0vaJ_n99b46JQdnPs3YApEqdzPwZ6H8
 oj1WG6dOXtl3k09WQXev1PhKrFWMyDeZ9w1GlfQmP5g7Jjj2qN7a7eLLBvNkdV5tzImkduae1Auh
 ZNHaUDRibusjfnsyH.lsYdKtK4QHwotQ2MvVK3uFY3bHafZ9zniovI5sjjsTvWxwJfe8ghsA0y9i
 c8Jk3vjJH92G0HFaWG2wU_y8HSE58juX4I6lujD0VNkXDcQdywJevsif0ykjiyBPdHH0GYEuXs7J
 iXjOcmE.fFBnSpWlOXz0vpExcHf10RaPjQujf.RHBp5u0tEdNPoK.gaHvqKyzCNPgR6.FghXXgUL
 CtIb8RElS3q19KbmMpWFyuFP48APBXII5F2.w5fUKfmXfMet8qYA0WDzQkcyNNjkGNxSzgVAOt22
 EFCx6A53SVmBAiStqiRnC0siJcXtUfDd.HSdxqRqisq.fx7M38mdDECdvb9t2uA6aa5snRsIHGx7
 gpNRyGBa0QdWepf0eG5pxe0Yv.mOFWCEDCI4L88ekIl4LF_trZT1QQQXk1oL18A9WLhoWhIa.WX4
 F3YlGD8dkQTBXyU0yPwuvFF3cvuPCtUfa3ep0q4M0pks5eMlKYP9US1SOrdGSs7yAUUu.WkuYXKg
 23UiZR0CuPtAflg1bPnNtxaC.bIbZtCK8u1iv.DLLMKYd22WQ3M0guWwJKWoBuTF3XhohTQoLpnc
 sIqpDnOzBvKqOVrcyPelMuVgHO3wNiY_JNsqTL2OiHDEH6ybdU8HUY9rsLk.ZYNJNGe_3MLzyzfT
 hf0eSQRX29Y6AHPP2m8bbrgPwRIuvUtLQ6gpT5wrLYqpeFXRirzAaTNEeyZcMGSdsagdS
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ne1.yahoo.com with HTTP; Tue, 28 Jun 2022 01:13:52 +0000
Received: by hermes--canary-production-gq1-677bd878b7-wc7mq (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 10aa32686a323c4cda69b8a84be5c273;
          Tue, 28 Jun 2022 01:13:48 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH v37 28/33] audit: multiple subject lsm values for netlabel
Date:   Mon, 27 Jun 2022 17:56:06 -0700
Message-Id: <20220628005611.13106-29-casey@schaufler-ca.com>
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

Refactor audit_log_task_context(), creating a new
audit_log_subject_context(). This is used in netlabel auditing
to provide multiple subject security contexts as necessary.

Acked-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/audit.h        |  7 +++++++
 kernel/audit.c               | 26 ++++++++++++++++----------
 net/netlabel/netlabel_user.c |  7 +------
 3 files changed, 24 insertions(+), 16 deletions(-)

diff --git a/include/linux/audit.h b/include/linux/audit.h
index a7226989d77e..de661c571401 100644
--- a/include/linux/audit.h
+++ b/include/linux/audit.h
@@ -190,6 +190,8 @@ extern void		    audit_log_path_denied(int type,
 						  const char *operation);
 extern void		    audit_log_lost(const char *message);
 
+extern int audit_log_subject_context(struct audit_buffer *ab,
+				     struct lsmblob *blob);
 extern int audit_log_task_context(struct audit_buffer *ab);
 extern void audit_log_task_info(struct audit_buffer *ab);
 
@@ -250,6 +252,11 @@ static inline void audit_log_key(struct audit_buffer *ab, char *key)
 { }
 static inline void audit_log_path_denied(int type, const char *operation)
 { }
+static inline int audit_log_subject_context(struct audit_buffer *ab,
+					    struct lsmblob *blob)
+{
+	return 0;
+}
 static inline int audit_log_task_context(struct audit_buffer *ab)
 {
 	return 0;
diff --git a/kernel/audit.c b/kernel/audit.c
index cee5ee02abc6..e66cc96db62f 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -2226,20 +2226,17 @@ static void audit_buffer_aux_end(struct audit_buffer *ab)
 	ab->skb = skb_peek(&ab->skb_list);
 }
 
-int audit_log_task_context(struct audit_buffer *ab)
+int audit_log_subject_context(struct audit_buffer *ab, struct lsmblob *blob)
 {
 	int i;
 	int error;
-	struct lsmblob blob;
 	struct lsmcontext context;
 
-	security_current_getsecid_subj(&blob);
-	if (!lsmblob_is_set(&blob))
+	if (!lsmblob_is_set(blob))
 		return 0;
 
 	if (!lsm_multiple_contexts()) {
-		error = security_secid_to_secctx(&blob, &context,
-						 LSMBLOB_FIRST);
+		error = security_secid_to_secctx(blob, &context, LSMBLOB_FIRST);
 		if (error) {
 			if (error != -EINVAL)
 				goto error_path;
@@ -2254,15 +2251,15 @@ int audit_log_task_context(struct audit_buffer *ab)
 		if (error)
 			goto error_path;
 		for (i = 0; i < LSMBLOB_ENTRIES; i++) {
-			if (blob.secid[i] == 0)
+			if (blob->secid[i] == 0)
 				continue;
-			error = security_secid_to_secctx(&blob, &context, i);
+			error = security_secid_to_secctx(blob, &context, i);
 			if (error) {
 				audit_log_format(ab, "%ssubj_%s=?",
 						 i ? " " : "",
 						 lsm_slot_to_name(i));
 				if (error != -EINVAL)
-					audit_panic("error in audit_log_task_context");
+					audit_panic("error in audit_log_subject_context");
 			} else {
 				audit_log_format(ab, "%ssubj_%s=%s",
 						 i ? " " : "",
@@ -2277,9 +2274,18 @@ int audit_log_task_context(struct audit_buffer *ab)
 	return 0;
 
 error_path:
-	audit_panic("error in audit_log_task_context");
+	audit_panic("error in audit_log_subject_context");
 	return error;
 }
+EXPORT_SYMBOL(audit_log_subject_context);
+
+int audit_log_task_context(struct audit_buffer *ab)
+{
+	struct lsmblob blob;
+
+	security_current_getsecid_subj(&blob);
+	return audit_log_subject_context(ab, &blob);
+}
 EXPORT_SYMBOL(audit_log_task_context);
 
 void audit_log_d_path_exe(struct audit_buffer *ab,
diff --git a/net/netlabel/netlabel_user.c b/net/netlabel/netlabel_user.c
index 1941877fd16f..42812bdfc31a 100644
--- a/net/netlabel/netlabel_user.c
+++ b/net/netlabel/netlabel_user.c
@@ -84,7 +84,6 @@ struct audit_buffer *netlbl_audit_start_common(int type,
 					       struct netlbl_audit *audit_info)
 {
 	struct audit_buffer *audit_buf;
-	struct lsmcontext context;
 	struct lsmblob blob;
 
 	if (audit_enabled == AUDIT_OFF)
@@ -99,11 +98,7 @@ struct audit_buffer *netlbl_audit_start_common(int type,
 			 audit_info->sessionid);
 
 	lsmblob_init(&blob, audit_info->secid);
-	if (audit_info->secid != 0 &&
-	    security_secid_to_secctx(&blob, &context, LSMBLOB_FIRST) == 0) {
-		audit_log_format(audit_buf, " subj=%s", context.context);
-		security_release_secctx(&context);
-	}
+	audit_log_subject_context(audit_buf, &blob);
 
 	return audit_buf;
 }
-- 
2.36.1

