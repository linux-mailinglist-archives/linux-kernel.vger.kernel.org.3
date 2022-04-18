Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 116FB505B4B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 17:37:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245742AbiDRPkU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 11:40:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345261AbiDRPj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 11:39:27 -0400
Received: from sonic305-27.consmr.mail.ne1.yahoo.com (sonic305-27.consmr.mail.ne1.yahoo.com [66.163.185.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C682BC0B
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 08:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1650294190; bh=4K9DoM5GdsOP9uBO1Slcbn4U+njC001nxgM9Gpo/0f8=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=gOuRxdOTnRZpGR4lav0vbuqotTRxryLlZGCnbPO/40nQHEl3dNW/DWqV2Ei6iSVvrVsuTByo39JqPBT1Aeyp9p0qNjLoUvIPvOdK4PPT5L/SBE+6lZSIZkwxl0rkeVMMr0U5HlPChPQOGpBsQr4b4eyrPuuYTzW3UuXOUsWUjWOE2jXHu2VDgLrpS54VouhvcjgOyVJQa4AJ3Hmm5SPfeEf1XIM3yLYYGEVHdfdFSsoaP85RgqOgo9HqYpslceNN7xiLjwOVlbnCqd5h7x6QyYHhdk7m6dZqUKFQt/1XG9zEQXTFalUTWwaGslYQ3YJtIRnzlsWbE9WMTkA988YlDw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1650294190; bh=0pRjLiH9YBFGuP4x91VKvO/pIeMdTPv23xJmTeuYr5Q=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=AEwAfUYYs/HVaCd4MbylUecjmGt+iGcJosK+oK9aUQtdtUWIkud+AGFdqsXrEmJatt6/fI9r56ImKq9l590xGKx49xtYXB8n7gCw/fL1wzg2zSukFj0XhnGtZEOmD9CgFjiQvjKfUO6dazn0UVlU8jL0YME701J42hCL7NyRlUjCoHGR4P0CNJmaHOwrzHQZ3QqTDa1x52rwCNLtYsjAHoN+9zNucUFj5UmSITz7b0blmmcXAhBsS3OXLPA7dvMVHrkfKqQSK+XEtkeQYkg8VH5gcCWtK1ID7wOqKnOa9tdXFPYx9NCXrodc2aLNGx9Qg2IMOEgqXxdNYqqZSA3T7g==
X-YMail-OSG: 3BtJwA4VM1kFlnG2nlgE8gbwdVIKRHBg0BPpt7uHyFYLKOh9eWePRr5Hq40WvsA
 EW9uU23FWUn.auqdbNxbwW51VsfKXnkHrJ7T8Wt7hLioXxrl0Fe6woutfoJOZ3qZnFsQ.1OTuJHa
 B2n.03Vpq3lbLqHASr1SeG1Ecv_jsQF9ETAS4AfDEfmlEcqieIiNcfO7d6qXyBKA_W.YdmvsxUBa
 WykFzQ6ELoxXA0weOVVSYoPoyAa232cTR9YehfnJeNLHN5B4eOr6kLScw1pASyP5GCI.qqLzZS1P
 vC9djHPxwQ7bwKs2PTB0e3hwVg0_uiMerXyQzWe6WWTxF0V9NnaaUwjS7yOBQ4NyyMVeCwdka_wq
 Z2hbi7fywtSnFxieCIjvpc3V5mCWdFDmyMFOssrOmCQRdUm6hnmeNVjddtb0uWmMmOPQM1qOLcGy
 9hMwg1sv0JQAppYZgtERIKZ0f_RLdr.UI_S25w7AHTQc0hTSBiL4gYJvysII3mjobvzlUjYU3xtA
 Rq1E2cdRupHky6wyi3hicvmLbnMFuYPYz3Z1Dx6TViy6K2cd58DbbUGQhpDCcDfT.jm1rpchT5kg
 wwKo6EIiB3Km9qBhqrYD4bjJnfxb6J0NymeR9sPCSmJO6fFF3HnnNC.7EOuWyt72yjBFjDnE7d3Y
 mejBhpGkkEIWzwx80p8jaM3ol3dtif1MfcilvWMIP7.h.0pK9xfXpimKxnmrsyVsHN5pUY_MOXcu
 uIZNjESHeMSXIf0vNQiK9hXbmXgYu0sL.rVWq0Gh8fL9foUuy1TzBWhkvZ9TwdhqDXNuaLjM.29o
 MMmLSTiECjHocn649VYNfvOTRvzGa5YhyauxRTXiqzIh0wCYVPWTgcBSG2CknGlCF4nzUyC1tWGz
 51oIsB.3xAj4xjo1urzhGgeg3wmnZreiMZbqzfqxRK2P49xmI1P_YAPqGHumn.Ykmu5vyHAEno.r
 PNjE7oB2IlhyMCEs9pAkbwfSLCW3_eMJt2UGtLPA6l5TJgugiTYGaNmxOkY22eHS8nw7fLez__GE
 IQYUOBG.bv1pF94M1rScgmchgdRWIhtR0LzLZy2nM5SGmrB_y0Hhbl.WxWNwgOoISQV1fOoK7Wds
 oNH_016JkfaOElcs1.3YbQ_kj6iqr1zOR_Rzw2xYx7ZwdRUfhsSI5_ZliQyjG7PKPex8B.bge5G2
 FcQbwQyfTIR2WLNplqF4dbjrOgkYk_5NdOmAbeYfm5hanoehjjn_skfpKT94BZp_CnWP76tp8qVh
 ZlBweo8uVWVvHDdY4zlzd9Ppoh.oJUkYc5nhzG1ax2aJeYP6NYSbH9buLiN03aM.txKU8j0LdaUf
 _OvU0ym81JRyNeFSrwkTg5if3U1E2Wwp04cvdmxIUQ9ic20XEmU7CjER2CAnKOGAqyMZgakOQK58
 xy59Y6ujVnZrY4CfuxvkZX49_sVOiI9E7k95Gc1kgb6Jr8hxXwVn1P7GfbHRqgZw2a3_P8MOsIP5
 Sbj2KuBEUx2umJX5MzdElw0kqIp.qFRTbc2oZ9X6l1zGUz989QprJOjmSQ3DLhHdv1obOduUI288
 RHUM_iSn._dDwGfJW04OPoOApdrCzxtTPBDFmIjovqjUcxBDffrukgzTWZMDqZcUk7SGkz3FiCid
 leMdRc2EYjNbAvnc1YEvF9FK3Cx3sjSLbleNqIl776Du2bmYSUQSL2eeIzemPlFbCh.nDscqZ0VA
 krdfGH5KV41K2EYiSFPyRwJGWplgYl8jG4aY.Dbm7GCfW9eF1ianjWOwTZZP3ox8c0YolnpcIWrq
 TgDhPsePmdbG43c.VNHXvJM53xSQH_Bv9Tpu1s6qTVs4TYWORy9XLINUXrqPPvCJiOrsAyJ8ridZ
 bX8yukFAKfGP.WvXOp6loNwmbAH9UclPyO1COhNtr9pAc8XtXG3AFW732D7xJZaoB8NfRl9OGVUC
 OutgoDGWGUrlBrpHfubHoCJ6HKDrivkSk0Ya66oMHVbk0GT_GXn7z_b9LW9CQjWWxKeuu3u_xetb
 vZrgDz.6WkX5WhxLHYotC7ov.D5JT9dFuZwNgFHfH06RVnrfZPeLsoPLl5NmH5AE.ABEwuiNlwB9
 0_YQxQzdeE7g8fnsYWKEip8isDy.U63skUanXAl5YqrSriI..r0V_l2JTmK9WCvZJTam_4Yqi0Yq
 dvTYr9UVElCTd.HcglDr4T7kmJ1nSYkvVZuDjGhExweqhDIhHUHTSAlijsXrUPCJU3MNDD2M2xG2
 jj63OV1_linQM7nMeZVlZRDzk_3h.8Bq5Pwzw14_PROF8luBx0CZtInVQTgKSrO85EXoyqFhlCg-
 -
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.ne1.yahoo.com with HTTP; Mon, 18 Apr 2022 15:03:10 +0000
Received: by hermes--canary-production-bf1-5f49dbcd6-b5q4c (VZM Hermes SMTP Server) with ESMTPA ID e12cdaa14792a510c07372742bad7207;
          Mon, 18 Apr 2022 15:03:06 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH v35 07/29] LSM: Use lsmblob in security_kernel_act_as
Date:   Mon, 18 Apr 2022 07:59:23 -0700
Message-Id: <20220418145945.38797-8-casey@schaufler-ca.com>
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
index ee5d14dac65f..68ab0add23d3 100644
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

