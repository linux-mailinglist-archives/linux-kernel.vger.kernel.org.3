Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AD414D55CC
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 00:50:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344895AbiCJXu7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 18:50:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244700AbiCJXu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 18:50:57 -0500
Received: from sonic304-28.consmr.mail.ne1.yahoo.com (sonic304-28.consmr.mail.ne1.yahoo.com [66.163.191.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69692182BDE
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 15:49:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1646956195; bh=LFedpjKaSHoLpI6CM7sE9P2ATDJzUAMQYIYdkGRF0a8=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=GrIqbMABGW5AMvuUWhab8mCJxdXRaDGWBd5OQ9juELVyIC4nra9uxdYcNZn3kF5j5MIw0RAZEP2wM0dvESRfAeHG0YxfE58PMgCDj+KK/Kpo/0KSJzj3tRz8kKCWeFm8f1ktiwgxiFAUdbXq5QIh1gA9kbcBM8gLlHLTAg8Pih8f79CazGn5BJ1Z2h2GJioWPB8qtMusn6OKBEcGmYhhx9Q2qvHOW3kSnZaDuvgjlsrBHOs++7shlVZNUtUqbnRv8YuRTUSzVlHEkaoO59/cxGFFyWfbX7bxTECXPTAgrsSbmCMDdFDbGjFCKTeVvUV5KwdA/ye1GDJxEMOaVTlILg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1646956195; bh=5nAvq/RdhPCEPK0CjkIQZsaHQfrv+ZNYhvNSyVVOhrj=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=p2vD8n+K+yhWojAgE8BUDoz6XAdtlWKWH3uLkXAVZYQvyCjjl4fs6VaCFhL9qWJ+HRgviLinCmHH5WRHH7s1mLCI3BaBO2eLWpu7TeYmT4JBiZ1GYkuXJ/gva/xS06dsHdOM90nqYn7CD3171sJc0CIi9oQdrxm6JPE4K1MhI45cUbhyIzCwHK/a0GPPQq6GKqjE+b0O5sYXaXzeAYoYZpHcK8IV52r7ShqSYZ8zTgl3OkFprC9pX4V4uoBQNN1U7gcOw9K1BFJktpyjwsl9f+e+V7VUjVNaa+kdY8aVwj+t+ik78F9asntArcDfLm0JVIPCWKDBtDVWvhboletRfw==
X-YMail-OSG: aY_cSn4VM1k_CnMMAskjMyc_BEBKPijOEtkYGBetFihT62nEsI6UVz9MDPcEGWb
 AmLy18H8.r6S0UrPiudwzkt1U8f55txr2rTgHFq3pNgbHU6_sQayl7V5htoYmp8ZZkyAXQ4mdF3j
 kYDYeem.svny47kHO60jl11wel9SJix5BBBXN.Namdv6.Qdw5HTXS86FcF1dzHemaR9umxZ3C6FH
 O.y5vhpdtnHWQJ1K2zg446N3.CSkCnraEA8zDQAs5y_9IsVXSoVYAvpib3cnxQd0bif2wyWsa1yx
 SsB.FqMVBPnPeIEhIR7fxfz5Hn05oFDdzChTD.cQZSwEhyd6kF.crbv5fsrvOkOfo7FXCTlm74xu
 tX2yHNE39CazyuBD3WR4gKSDGK8nBwSkGg0N86jqHbufveFUbnCFlv9ksLQKJOnf7Fla3Da05aNw
 w0VDVX84aF1Fg1d5cpdn_3wGD8grCDPq7Dy5pyeAcne8MMYX60uy0TvLjuqLfiW7VsgUPB3RqTJ4
 o39omOIgti_06qYKKcfpFWMA3kXwZCn9K36pQlnWkE1itF62aYifySq451j3_BesNj.nD0lDDnNG
 ml4MRO83Tq35YplBYmcl9vDFcIHRNYxyuojFqOIDSOQRfKFcP8s6SAr7rq_AiQx20lewDB2vbhh0
 xAFe8PBQyAI3r8TDuZDV0VxeAyOezf9dn1olmIAMgRlS5wDt2ucxiTWz3pL_hoVZdGDLqdHjRM2q
 .DmNDX.LHvlM5NXcvpqqOOMz4Ta3YJmJEqINla6xfl_JzoQ0N2UVfR.CqkdFO9QV1XqIFz_Ln9sy
 tthUtPgC91zTAWwQ6bRk69s9GxCRZ4M1d.WjH_d_hxoLn1lJDo_xoiXL7VD2DmflWKxOdFZixOp0
 2XbROkRk0QGEKprzQ7s2SPEpsHdRlBnuXl2YPYpVJjlz2ujdqjm0tjBK62HlP6Kb7IuHTPD1Imvv
 swpHIi9gqOWKyXG5xOaB.tpuL22ZYhyMSF0mXeuGvWDDxgFWJhEgo4aprKldEg5c4XWBehXuId1z
 POaF2h321PPnFDZ3yvZop_FhytGHOKJbrHMQswHtbetyGY4DDdtIQ3Ue2dMuIEv.YAZZMtFNumdy
 wy1UOnLnxk46hhL2dOFuKW26fPJhpBeYTOkzgX6YrQfUwW1tQ3GDA8Yyta0BNnCoLpiyMk8czEH3
 aO1ZrVIztjiJQy.xGPSM6ZjinXfcTKTrKLJJxZBjeoh61xxtrP11hRBVDkqsIEuj5BtZZuW_Y3KH
 SaI4fpWcriM.yRMOEe2VJFQ0bLGEetaLQ6qvkFMJwvGdlQ4XaqRtYv2HKa8oAIyPVajlW_CagZBJ
 pum_a8NI0xkgEBYShmDxMoaiz2LZn0Tqs7Jegm17hCAOb.FlWtEoa2dIbZIe6g32pK_mDYns1wMV
 BdwnLIf8c4VQbRvLiQjBWQ4_VOXw5wRbdGngU.KxSXEsTnox5CP.IOpSuKfN3eUhFRvNGLidlmtV
 JbddzIpjf4EeCL0WQaJjCR0.UQ2aOBs4WCGOmVmUYYj7qVM0xUWMFO83SJb2fQkfMYMSKMYdzjxh
 QRka_1fl6coGK39jLYWQoAmjWcjZ3EPPj_FjbO3ZjM8rWLidPVDqGNjemyRHA6GSTQDbsDZVgjrw
 lvgPGCPcLxBD22C4hHVysqwNBb4vg7DrpxHWPFTpq.VnM0by2RoI5RclShT_ICrpd8BFyOeSC8iF
 zsMavvUED0mmMIzFlThWJNeUSYSQWU9X2Xon.JmKkW3Q5Utf81PlEsEZw0OGfMyFfKRmCeR2Zyje
 RYYyp0JwOxFp6pt97qfJWcd0NBSmd0UZTHU12.jvej86.6sS.jUvxBd0fBWt1_bZlwgQ3MwhWOZ0
 9MGUXuTNduqCk16mmmbDMuLLHqlEV6ebJWPTpEkO_oXWJQWwTb6gfOVDJYLTKZk2TxqSn5_39vCR
 z2aHiXi5E2HnP6R5pEdIgy5VfES7lqg_XxOtpQ3ApyzaMV8sUlzXcs5LusAVCwhyy9Lzrbwj2Jdx
 _nATph.LRiahhPAslSrAunCIMXSvVqVQqmeID4xJS7E630drY5cBq2bKFpmAzYbY904ewwooLS3c
 AS5XqcUVbpZe953u0mVSgZY_McnK3pndwiA2_4OnTqDhlN3WCSLw83Mnw98myizE9JhzYeZA.3Nt
 xZvAn0BHIxjF6fHuem6ugiBPcAG6DXiG2BDyojJbXzJo9S.lVHdTJrQ7j2F6FcTwZ.c34WX6DX8g
 Y0Zz09hdwFi6R8hlL3eoYXEWjdNc7jew37No_pNjKGENsym7S2Q--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ne1.yahoo.com with HTTP; Thu, 10 Mar 2022 23:49:55 +0000
Received: by kubenode513.mail-prod1.omega.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 50d9cd6aba58fa399bba8dff0c177f96;
          Thu, 10 Mar 2022 23:49:52 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH v33 07/29] LSM: Use lsmblob in security_kernel_act_as
Date:   Thu, 10 Mar 2022 15:46:10 -0800
Message-Id: <20220310234632.16194-8-casey@schaufler-ca.com>
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

Change the security_kernel_act_as interface to use a lsmblob
structure in place of the single u32 secid in support of
module stacking. Change its only caller, set_security_override,
to do the same. Change that one's only caller,
set_security_override_from_ctx, to call it with the new
parameter type.

The security module hook is unchanged, still taking a secid.
The infrastructure passes the correct entry from the lsmblob.
lsmblob_init() is used to fill the lsmblob structure, however
this will be removed later in the series when security_secctx_to_secid()
is updated to provide a lsmblob instead of a secid.

Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: John Johansen <john.johansen@canonical.com>
Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
Acked-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
To: David Howells <dhowells@redhat.com>
---
 include/linux/cred.h     |  3 ++-
 include/linux/security.h |  5 +++--
 kernel/cred.c            | 10 ++++++----
 security/security.c      | 14 ++++++++++++--
 4 files changed, 23 insertions(+), 9 deletions(-)

diff --git a/include/linux/cred.h b/include/linux/cred.h
index fcbc6885cc09..eb02e8514239 100644
--- a/include/linux/cred.h
+++ b/include/linux/cred.h
@@ -18,6 +18,7 @@
 
 struct cred;
 struct inode;
+struct lsmblob;
 
 /*
  * COW Supplementary groups list
@@ -165,7 +166,7 @@ extern const struct cred *override_creds(const struct cred *);
 extern void revert_creds(const struct cred *);
 extern struct cred *prepare_kernel_cred(struct task_struct *);
 extern int change_create_files_as(struct cred *, struct inode *);
-extern int set_security_override(struct cred *, u32);
+extern int set_security_override(struct cred *, struct lsmblob *);
 extern int set_security_override_from_ctx(struct cred *, const char *);
 extern int set_create_files_as(struct cred *, struct inode *);
 extern int cred_fscmp(const struct cred *, const struct cred *);
diff --git a/include/linux/security.h b/include/linux/security.h
index d02af9b77f8c..4ce8dbeb3dad 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -463,7 +463,7 @@ void security_cred_free(struct cred *cred);
 int security_prepare_creds(struct cred *new, const struct cred *old, gfp_t gfp);
 void security_transfer_creds(struct cred *new, const struct cred *old);
 void security_cred_getsecid(const struct cred *c, u32 *secid);
-int security_kernel_act_as(struct cred *new, u32 secid);
+int security_kernel_act_as(struct cred *new, struct lsmblob *blob);
 int security_kernel_create_files_as(struct cred *new, struct inode *inode);
 int security_kernel_module_request(char *kmod_name);
 int security_kernel_load_data(enum kernel_load_data_id id, bool contents);
@@ -1105,7 +1105,8 @@ static inline void security_cred_getsecid(const struct cred *c, u32 *secid)
 	*secid = 0;
 }
 
-static inline int security_kernel_act_as(struct cred *cred, u32 secid)
+static inline int security_kernel_act_as(struct cred *cred,
+					 struct lsmblob *blob)
 {
 	return 0;
 }
diff --git a/kernel/cred.c b/kernel/cred.c
index 473d17c431f3..e5e41bd4efc3 100644
--- a/kernel/cred.c
+++ b/kernel/cred.c
@@ -772,14 +772,14 @@ EXPORT_SYMBOL(prepare_kernel_cred);
 /**
  * set_security_override - Set the security ID in a set of credentials
  * @new: The credentials to alter
- * @secid: The LSM security ID to set
+ * @blob: The LSM security information to set
  *
  * Set the LSM security ID in a set of credentials so that the subjective
  * security is overridden when an alternative set of credentials is used.
  */
-int set_security_override(struct cred *new, u32 secid)
+int set_security_override(struct cred *new, struct lsmblob *blob)
 {
-	return security_kernel_act_as(new, secid);
+	return security_kernel_act_as(new, blob);
 }
 EXPORT_SYMBOL(set_security_override);
 
@@ -795,6 +795,7 @@ EXPORT_SYMBOL(set_security_override);
  */
 int set_security_override_from_ctx(struct cred *new, const char *secctx)
 {
+	struct lsmblob blob;
 	u32 secid;
 	int ret;
 
@@ -802,7 +803,8 @@ int set_security_override_from_ctx(struct cred *new, const char *secctx)
 	if (ret < 0)
 		return ret;
 
-	return set_security_override(new, secid);
+	lsmblob_init(&blob, secid);
+	return set_security_override(new, &blob);
 }
 EXPORT_SYMBOL(set_security_override_from_ctx);
 
diff --git a/security/security.c b/security/security.c
index 5b2dc867c57d..2178235529eb 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1803,9 +1803,19 @@ void security_cred_getsecid(const struct cred *c, u32 *secid)
 }
 EXPORT_SYMBOL(security_cred_getsecid);
 
-int security_kernel_act_as(struct cred *new, u32 secid)
+int security_kernel_act_as(struct cred *new, struct lsmblob *blob)
 {
-	return call_int_hook(kernel_act_as, 0, new, secid);
+	struct security_hook_list *hp;
+	int rc;
+
+	hlist_for_each_entry(hp, &security_hook_heads.kernel_act_as, list) {
+		if (WARN_ON(hp->lsmid->slot < 0 || hp->lsmid->slot >= lsm_slot))
+			continue;
+		rc = hp->hook.kernel_act_as(new, blob->secid[hp->lsmid->slot]);
+		if (rc != 0)
+			return rc;
+	}
+	return 0;
 }
 
 int security_kernel_create_files_as(struct cred *new, struct inode *inode)
-- 
2.31.1

