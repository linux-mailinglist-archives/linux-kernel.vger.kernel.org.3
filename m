Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4159B4F895C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 00:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231484AbiDGV2Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 17:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231424AbiDGV2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 17:28:07 -0400
Received: from sonic305-28.consmr.mail.ne1.yahoo.com (sonic305-28.consmr.mail.ne1.yahoo.com [66.163.185.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAACF199530
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 14:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1649366765; bh=6tvzPbUYER32tgoFjKl1mHuZU5CweXvTxDb5j027Opo=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=TAnv48ADkDUrvujrtpMUSHAOvJINKjK73IMR+k1aXvtdFGCTRVAM9Co9+xk1QhYzlneOTNGoD2VKHEpujdLd1kZdgCDiJ8kzzWEP7Nj6UZwHZGnMVxhKbmfMHo4YFImpaATmRXVI1Dh/Yktla2G8CtiDSIVJXQXpkZP0zRLhHREcIE/aFXg/uFTp+jPnHri63kWE3xqDdMRzrk4tohtSU7LH556DZZNO/RHSq7njBTwvNorGEP/JSIrcbqw6N4/R4/syG2drgyFLB4L7PVv9sxN3kLPXsZMF98rREDQYK78pNsJXiiEGsbN+qxveAut78gzF5zklT/ya/+dLyY0PAg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1649366765; bh=ORKfbquBHDJwCT2u4GBOHeFgik/m75sYXaI84HBGqPO=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=GmlLq/++bN+Ank4WAtCuJanx2dN08uxBo1t0z1PI/PJKZZo+1c6vwkEzgqFJuvReH8dEgH5Lr/swEkNcWGMr6Uz4xgAmhDrfsKsV0VS4nAhzcZZP9PIxqf80yaly7PiYsiUFZnjUVJEG86Pxn5Qf/gC5i29cMhaXdVQNW+FNZJGUii/2NWe3yYS5X08ox0mIjwvXGmAeQmzZSXu6iyjxJ8JDClVRgXWg56Mz4GzMoClCBg7bRehIq41ZwxhI1AxPZQalm6mdHinTzGBgO4zM6knlG4DoLXaCui8j7ii/nI01NT4gf/4ZONp4KXZ0eUUteBKigZNB9rAR9ftzlrw/Gw==
X-YMail-OSG: .kgncYAVM1ma9STGnm9yr0SbfqVtPNbXjXcUthkTK9JuKKKbBXp8silZ90NLh2z
 JlpS_lX24eI2ZrU3DIv87xWIdsFS1nIPGZ83GgQmhEALaET2JqN4E.7efZk.h6wz0zA0mBix6khn
 ejEVGn4HSQLGjyW6_cR7pAVfm5hqyK0lV3PatyZIJ5rpXaKHVbpnTi5Kvjend2csLXvmeamgpdgj
 t0dlpBcst0_3lKp3fuxH.XlrvBH3CmgCMU7p7Cmo_7BhYvMBRQ_Gr2oUdORPFkQozehANKTCSEQw
 a7u0s9kpeYiIbxzGpvb3Q_qgMcuKMXQNVTFzIGHjKlZdIae6hab1AnKJXyUMWFtPLj8Hogd67WpI
 FmQU0uXiP0DeOg0Y1IW9U6TwIWI0PHxPFknnISLQX0zH_IQVUUedohx8bmjKUAROd6W8FsCCnyk3
 aZ9AeRYZ0VudAUp5ONCO8hIOHOHT6jKFlh1mo3dWlpMfsXpR893_cVKIj5YYmxkmI3qOrs9pBao.
 l9wGoBbv8Csi1.qvNngb0E9NJrZfvHFeUmWXkt_JZp76tYJNqtC_CRmkbjx9xuK1suff9.TlVA_F
 L3enbw.vitNH45nVJkZmSKCvThxcba9sQ2C4WBHteVeW95WEUXVEN5o9X6npV7y6CGddLbRXXl.w
 vcYGBuWAGeWCS8PEywaYKdsOO8_LyqPpzpPANdnfW2ppcqvaLormlNC0ypDoNOPdh2ogSpKRzNwl
 CDmLCSV_zmyfcMGxLv5ILi7Dp3Qd2bGaAgqvNxmVeTY3WZkYk3oCWbIUG6CPZyIhS9loydZQJR.b
 FBZmHCruNYf95ARxbgv0XimcT5OtXjXopfdHZQsixgbSSAepp3wSDJ9RPQ.BN598KfzYl5XM1cZq
 NANiGwC4lTVxUJlVrXb4fRP35qKJbJCceYiJ_z6f5iZ7JSsmqlLD1oJyLgeWCsyU7Hem1DvzDPqD
 GGK44pLddXIiYaZHUAztN.HeL3as6p.elS_ujS_4eTC_eOVVLV4IKsVF5UDRDfAyM5WHKYcFBBpp
 egbrcoUuFLH7RKhnhvmPv6tBgA9SPSH0FrZ6qs6JCo_3Hf4A5NLvEa0r09VSaWEXinbtnmukyZE2
 vYEehpnGTfZwmTx72Y6MkgppI1FwcLBpyZBjXk0nSgeXBF0okGpY0.mtK6GxvYIG5th_tNG0wXzn
 UujQ86oAnIsDMO4NLthj6izVmK29bP.mpxRLyXWLnCP0NbJB251v3zq5nZedStgj0TF_k88XbxKi
 TSD93rxJb5mtHVVx42eVtA8IrE6RwlDsrKMrXxRU5kawZtjOQbXsOwjJXn7KO8gtiIgpa0C4oFZ_
 _S548T4JraPeQ8JCc6F4PXNj9uX4K2GGfVgrW9CdvmxDuGwl9M3hAGkakY0LHXvSwjBJimbtlwxk
 Hh7ErL5xRBAY8OISRE8SRf9dSpXcgZq1mmmoTUc0uQGpgnvUPG3mrbn8Zk9j4VRH2rBy7Iuc5kdN
 X_b7ecw_SFkf33BEaC3yaoCDe3Le4WKn2tviE.fAHVefyFa86UaQ0teuEQYqJXgIGo0hmcbB7h.k
 atnLNAkFyPJbsDlder390QOSPsHwNxcf1TOl23NlIlLTr8COqaxyj1CDO83B9cTZfpwW6umyz3Ed
 WwDLCrC0XzE8.7GGfkeZmVrkvhtDwovT4ooYSIX4rnLNVU3aE012DmIZwhtHxoDmP0BNcjn0r6Du
 TWfdzlInC8E8beJoPu_iBCuSHMGjRdfNkA0ACV42eSVgAj_De2RMBLcA3HXWzdisDioYhzkNTBE8
 4RhaKAGB6H0kFbNoduwlCTPhpX8Jqs0NKBVvPaog5IMSd3F7NhDLAZZjNyA1KDwKYcJJ_sYPRjM8
 YYFWWRFSGabp.lJIhVvYs3dehg6QH0TqQV3pplgQE4xYEUwySwLrpnuFDypKt254_MKc90jeUbpj
 i6fLvN4qWqltn7H0S_sVBBqAYFIq0t_2vAqq_TGja1uFbNeopCg7tuP2FJ15R6GIgDemOfFuekDu
 sxECd3PfHpkmYq2PYtjmMzxAFZvY4EpSyX4cLQRoXs66SV9VXq6tI.12L4uwb144ToMeMKZ87I2h
 oz1ONbHdkyRRIyYnk6VJzVxca4mVgLJ.VH0oJ3B_ckYYejVnyXcxN9NANhFdUCjeE5BLVJ.hTHX9
 khPFNkjE6Dy54BUPwG3Hlf7ieIlclsh95hbxUVoSnToNY5zZpc2suStyVtLQkMwI81a67cP8cwjR
 CtGbh57lFBdKJpsGyton6z1a4ZjgnKNkgCTAXglQi2YuSWJATZUXqADgdgkJWkzZyLDYMFN3_l_Z
 OuiMByEf8sjowpMZZaT3MAkmX5fR5ug--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.ne1.yahoo.com with HTTP; Thu, 7 Apr 2022 21:26:05 +0000
Received: by hermes--canary-production-bf1-665cdb9985-zm65g (VZM Hermes SMTP Server) with ESMTPA ID 1b8a787888cf9c0809abffd2a20a44f0;
          Thu, 07 Apr 2022 21:26:02 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH v34 07/29] LSM: Use lsmblob in security_kernel_act_as
Date:   Thu,  7 Apr 2022 14:22:08 -0700
Message-Id: <20220407212230.12893-8-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220407212230.12893-1-casey@schaufler-ca.com>
References: <20220407212230.12893-1-casey@schaufler-ca.com>
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

