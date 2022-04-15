Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 884D65030A7
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 01:09:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354616AbiDOVZa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 17:25:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354388AbiDOVY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 17:24:26 -0400
Received: from sonic310-30.consmr.mail.ne1.yahoo.com (sonic310-30.consmr.mail.ne1.yahoo.com [66.163.186.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91269D4443
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 14:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1650057695; bh=6tvzPbUYER32tgoFjKl1mHuZU5CweXvTxDb5j027Opo=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=mYkpETNvjp5mmPLAdVjNf5yS6R6uJFN29+L9EXsooKygrnNsdZGODLwcVZZp2zA2r/Nic7kTj0AN/NIjibxtdwU/alb/mB6qUo93fsKI1Xgc3o1BCS45Hm5vylahoUJCl8HBHP4O/sRiN8EOtGIdxVD1mO0vW0R+eX60V3Dx1hmUVAPvHxckPioYAiFC92QZXFB4C72LqHDNgzsKnYoCIIwvEUyrhw9Er1Uir6IAuNJYSY1iiSX7c4sSXIFis6mgJE8V7t9bIcvVjL/o+YW2bENqI0yyVyQnVr3YOHDgrmNGeFMriSavxWr1Xuni+2aj/9j6j7OcUoN4rOxP7Zy3lg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1650057695; bh=SFYLFOK+xybiVxHQ4Oh7UGYJimrhaiYkSnxJQxIyf9E=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=gC9qNtBXg66evHwPtdZCYIDXoYsbn9OjgC5tefqS90YNwCGUZAO0Yg1XOj87HUm1eZtXMYh2lvD5t32xfjFp43YdJmwJAq+DwjNTCGfeKqU3tG/0bCR4YG01YT/REa+RhwROk5fVBoW4f8UYM+2fzNnjt4YA9uvc+Fyt4Lyh9Hw5oT1e5CFkgIO5xW4Tvq52uBYlsZZBGlpiJ1uG0Am0DR4q6Db6C+MlLcQsWKcIk6GejOIpsJRGAlmI68gMJJwkvpDiHyBwg7Fb96i3OZfHhxmwcm46mcZts5gQhEcbvFNUVQQADeb86WGfKLzHxb00oBOL9w7ycaiFu4bJ82lngQ==
X-YMail-OSG: xAnbkgIVM1mo8nouA67a.3h9MiI6ulaGBCEE92zIPfSZs4dVqUogOixv1UGg1cq
 8m_UW0XJWi3y12zoXq4z9etXMrpZ1NMxDO6_Gwgxz6fSK_ow5TpYkVkrR85mBrNZlCzVg0n9bIl3
 QXyLsEkoJHH8oRm_zHUh_IRw3HXbvcOUk3Q9h5LmnwOCWabtVW30qRzgQhk7xcmE0CenlsQKlrWq
 3D99i8eGP5TQyOVK5Fc_MR5n71FR4oe_y3OVRn4bkmS3s_G47H9Z7AdDIHLIf8yajgiCwVjt9nsn
 OfdmL.L0L.jXgRWl6AS_.WkMgF2Hp6jKu_LviOaQ9tp1gRDoir05lLkh0NBGqeGRH..FI_BxWoBr
 2ZJIsnl2vjl7zR6uT.IZoZu_SOHjiOkdaiEi82W6CICz2dEsmBM5zqgZHIwhCMt.iiZi7e9ClWXZ
 6HUvvXztyKO7rFdIlldKulovLen29iWnJJ6Jxde65H14PXUBVHWs0_QLlwD5Zww7iRBuJ1gdyOZ3
 AKEY77xObAFIVnZGUn4eFQV89cVupX0LWPedLyH3ZcmWSP5Qa0mG_G6Gj.0EG2L2cUKN5SbNzFlk
 CZEmI9uqKosgz5.SHmrfAXHgXurtYK3kIfW8F9459imioEQ1UzOBDmS.ylJ92B7f5U.h.3diH7hZ
 THCcArg.RxJpIOyqNrRKuiu.Wo3B9sk9MYDBTo4RIw6XaYrBvTKz1vW8G4IepdigtGJxZdhfO9.y
 4nN2O2owqMyCBIDl2OJXJSw_oU5YUEFCqj0EdYDmeHHtm_aA0zByU5tesbT_b_PQ9V.ErgU4WnEQ
 1NqTesnzG5SrZbUh2zZqQWRVPUBcHtNedqpx4hGHXVEoyI45uBb.vrBM17g06o2SoxqebNH7KSrt
 sUkYi07mtR3srLTpGLHWp.ZRw0Tfv9V1R_QDr0JpqQ5bTCvX0Qf4Vg44WPMVWZcEYW_jcyNpCE5c
 vQzACUlKvKHu1pov6ZbCWSc7rJHhs4kGJd6mT8cbFxOzfqTGu4xblg9Hi0bH_mNkkNe_C8c9pcJY
 qxcS13fZSE8IycKzctEGhqq2aHADrSJ25ztwWCu6wbPHTV5RULRyiNJeCG20DyeCsw2K3TVFAz_N
 GE2ct4yYCskKB3VQEp9NEwnzxRYRTW2jLL5w3.jx7AFUhnVdjFb9fqmiQxykhKfNWbWRD0FVx0d8
 KEgXRiBfQYrf1HCLjDYhzu5Ah8fSIA5bUqCW2QWANVWDRgNAe2xw6LwSSWxtLbpFZJ4yrfgVrsCj
 dk6szO6FqkS9vfv6iEDV0J4U5fie9.jEZjiV0VysLUkdhmMuxYo0MWKXN0gXTmp3jqxZtX564xbX
 c5Za.U8Vk0PuJNOb1lCJdPQRNr69UxcqGoeXor9z97bRvdbAFJZQNawxhFFsF34XZgnwR_WpM8xL
 42hpD5uQC5WROdwtbNgJrdfYqat_Dm95NFhJfY6NjoyYPD37.fGLOFCJg1CFj7fVHnHDEvWhcrB_
 Zz73B6Fd98RKrSDkhumo5GXdnTOp79OJOFexI.VJb0AcSj_2XHxnTwo7NXT9gsYzaTxjRhywtCuC
 LfmA6qCNeo4M1CUm8rZZvhKXFG_ZtzvSQvauzHSfdNj6CwO8h3u6C6lf0LOg3pOQtHQP3qjZ3_bl
 Nt.Flt9QTCV3yEMxyYbh2cTE7swPz6XKiA.6yHU80ahTb3W1kO87IcFaleHrceqCFaTbxUzOwY_F
 2HvXxOJVGGRFnvcUpW6abGXl6U0Pbv.44YV9YqQIe0ltBEtqfj0XhzEPqPxJgs1U1AsQkB5TPjk9
 N4C0R0vjSo7n5vEi48u0mkz.NpYWsVPk4hH2iO1b1vPcDgBc.3qe8H4NhZ5lRow3IuVcra7638cA
 bvLVqEdbHSTCOmxdo2JXE3iQ0DaMtAAnHwjcin814jBusMLV936tVBKQL1TSYKy_G43.9baMoD.8
 JtMHXSn.vQJqBYkDtzvkh8iwYUg32J9LpxojiTfAKMbLTvg8wlAnhmp4ip0UWKhzIN0uwR_YIEtp
 0oFFsTQ_p5.mzZEcUMzF5ydf3Y8rh00aZPqVRwBkRGVMzWuU08PVlczS7wXfhfIGjS2ms_eM0swC
 M6_KulpdznEyJaE4RBYKK8lQokrwjO4UFesI_VIF2FrOebhI8gDEdmEecIPSRt523tMTYC_C4LYJ
 QjRa4nKI3egEHcGeZiXuZ2ruG0y0XKvixrI8A4hZEhI2Y2qxJdrtk4Qqe8EitnU70hGPBKJKXdgs
 N5iroTIV44St81YE8deelc3cy6T_wTaJBY1jhdszfbPKoVvTlfMQHa.prvh_TUwD.os4-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ne1.yahoo.com with HTTP; Fri, 15 Apr 2022 21:21:35 +0000
Received: by hermes--canary-production-bf1-5f49dbcd6-b5q4c (VZM Hermes SMTP Server) with ESMTPA ID c91982c747db758d7776974a874b1b0e;
          Fri, 15 Apr 2022 21:21:30 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH v34 07/29] LSM: Use lsmblob in security_kernel_act_as
Date:   Fri, 15 Apr 2022 14:17:39 -0700
Message-Id: <20220415211801.12667-8-casey@schaufler-ca.com>
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
index 9ed9232af934..610f70a99f60 100644
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
index 8fc599317f79..e9f185e9162a 100644
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
index e10c15f51c1f..3925d38f49f4 100644
--- a/kernel/cred.c
+++ b/kernel/cred.c
@@ -767,14 +767,14 @@ EXPORT_SYMBOL(prepare_kernel_cred);
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
 
@@ -790,6 +790,7 @@ EXPORT_SYMBOL(set_security_override);
  */
 int set_security_override_from_ctx(struct cred *new, const char *secctx)
 {
+	struct lsmblob blob;
 	u32 secid;
 	int ret;
 
@@ -797,7 +798,8 @@ int set_security_override_from_ctx(struct cred *new, const char *secctx)
 	if (ret < 0)
 		return ret;
 
-	return set_security_override(new, secid);
+	lsmblob_init(&blob, secid);
+	return set_security_override(new, &blob);
 }
 EXPORT_SYMBOL(set_security_override_from_ctx);
 
diff --git a/security/security.c b/security/security.c
index ced1c76a380f..e9f1487af0e5 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1816,9 +1816,19 @@ void security_cred_getsecid(const struct cred *c, u32 *secid)
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
2.35.1

