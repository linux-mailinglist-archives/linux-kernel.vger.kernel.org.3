Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88A0E4A7C31
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 01:02:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348251AbiBCACG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 19:02:06 -0500
Received: from sonic317-39.consmr.mail.ne1.yahoo.com ([66.163.184.50]:35453
        "EHLO sonic317-39.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1348246AbiBCACD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 19:02:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1643846522; bh=YfdUW96wvEBYALhSt5D2yGP08y9mz4oFH+V9zqwgcbw=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=aOz1ewxj6d4kOCBWsyPvJ8kxpZixnYGOUx3+VqmfKu3LujgA2iUufJk7bReir+M1NxVOWf9Hwf5rpZsy9wvabBFU1hC+MhycnZnFGpqrDy1KUFTf5XvHYNU1I0+OXcKsdhSTydXs/Wmj6Rp67icVZhhxggJ9eVXqXg2ettrClZ4CxltIeXND0JT7vHrRe0d8HQ/OUTxv/76j1IYHws5K5lV2TIYIaG1iUvurJK9XoTIKpKD9w7q7qYrrmy6UUWolAtIzJ75XdtUHK8yvDGajVXBKsmHW0MjMqPvb//3uqw0dbvMIUPNrSwukVaBomAF1/Ezym9KLb4Y34f/HPGqmmg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1643846522; bh=hkeN8trIp7LqG3qocZkXyVfp2yx3funQIAPxb+BUmcU=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=AXA4fxALf2Vy/ETlpzzTYSYkb+oN/Guqw3SAIGC+pFYoyEBQWwwR7TcXoU/SClO0sox2oyQe8rQ5UN5PNpKBPeafcy++1km+NbbrfXZblarEWF0M2TqkuEgjTU++yhBHdUTmEXjCwam5TFF2vmD3UNKScchBOOoozQ9ivaX10DZPrt0LMgbjZz6tqZGnP4SrHo1DoqrMIG+eBlpOmNnEmWK3SSF5bSCPafgNFrPeDDhy9QTC58dgUT7ZZuLkT2/IfiOdrWzhbjtHdKS8FVJFg02jcnsPvzg74Zlw5PTz3JtdnQQvyLYh0xiGa2Ql3q3Wo9ghW7MeXbr0WSs6c+dPHg==
X-YMail-OSG: k2XWFU0VM1lgdtxmZjzXF5oFCol2lzXriaWa0xkPfWlhEnD8jQUA3bbdoV1iWTI
 mlR.1rB0zYzBw0pZU5IuQmzftDUgmSKH4ZKTl9Jd7fXWy8Q4FPMBzqpr6d8YiHafET2S9AYCdoFU
 ts7SI19qIY.1bdEZaTl_6HQtW2oEZydp5fOwJiZnruMGExPMpg8E.C9d93NBy599O4AaKEe_mYHo
 3RgTduqH48BaYZ.bQ9bQU9ZswuR.IScaIxiVw.INDr08bNaQoEgprv3_cAAs58ZfHpMrrAF_rXQ2
 q8zXOmQuXvRGyCU8Jfi0imVGzhfMQQx8LuhhryCXz0FE39AncqAHuPcNqS4Sb2FvBh9x4MN4zVM1
 fawd3iL3oQYl1Evax4KcqVR1GRE2pEtO_n7bXgpAZDu8uJ6sWKZQ1AFWjkoNvXbMYokJ0pT6A95m
 5C5sA6BmNAHCZEjaaC8HRH_LtFR7MVjlxZGuTzODbXGNkwRVC.dyJ.NTrJRGetPvXF0p__GWG6qF
 1qhz29tdpQlmoUG7dGbuIOQojmtYJR1_o955lttd9md0ty_8wuHDkJAazhTmVUXRguP42.1RuHK.
 Mps9dJB0Vlam10uvJL5PYvpraqxtIqjGC2_M3Am4k9eZp5ri7rjOPfGDDjEbbLlHwWwql4CHvfAC
 CznA_Yy4ypFBtJfcIYzuJuVbGVgBMjZz7UUkFLt1VkZXV114ekgMBPfuBm0x1LsO4qkW534iFQO0
 U02fxhXVEeDVeI4on..G4se6aNuPJyK5k0AWJ6MUFJD293Tc6wWqscUdcFcIdEWlcHSS8sWIlDTp
 QspPEice7hVT4UAZGE5xMwAFpfdl73hpt1X.7bMIGH.dFuyCvOGn.eXH6o9arBe2zesYFvi6ExyL
 wNZ357l9hP2h.Zp7DPQbhK_PPhht9MmS6F6W0u2fNWZ.bXpzuLb3iKqO4A.qcTNs0piJeTJI6DoP
 z4Sa34vOw8ffb92UJ.XawcxxroBFGCeEkptiLuWWsqL8G9lNPzf0qYbvUdRlnXHq2_QaB6o5V9S0
 AXDGRxe4TYc2nIrExfFX_zfYcmQ02P0VRYaxhVfApMIe78t_ITfUKee5txWfNW8g9Oo8zBIBEy.k
 I2mKyFPxWEcklHdAvd_hPrux6OCYmc9s1ThrR30sWInZLp37_GrO3yGeTR51C2_8XAH6hAgcdtwK
 MCCbJdMkOUmGNnJYlX2CknIE1TFtbYjMPNeOIrIFjSeYSmwqObC93rFGZfeu9bVfBU_xXmFhxYxH
 0bjZsAzNGOFK1d6uGs2EI5kR6I2IqpH3pUXK5F40HPOaho.HJYlP5asuLPdHMUd.V59KUtl2fmjK
 uyJ3G1EMNyXfKh_XDOrA2ASrEbfGEHeGzJT8LO8YfOsdaWUlinq242nOfeNwf6GorVaMMCYgdwWn
 _OeVtAOU_Qe5oGsHMCyZayoTjV2xvzYSvQY9ZgO6EKB__uQn8L3k2CUhVPrwCfKf5Lu2hkNL7LYP
 U75a_r9y9jVGWiBVM0o1wC7FKZQezVBpUMCgRY84vZFBdCHV2Q7x_3nWe3z.5hwu_04RArm6e94o
 TWM214vSoss_OVRYgam8eNKJXxVbTvdiiRuj036Igc3DjhkvFqoFiEa13n3QQgCOVIjef5i5ORUC
 NyFnTWFAofKhPGPOQHQQFxHXpA.Cn99CGlw7aO.5dtiqaMKGsIckcl5FqcIpBK_p8.r9pKIWQ6aK
 92zQ5XFnA_1d3xd5FLZ90XsqO6ymoN24uhagJScrKJ7V49L0GfSnHp2ctM_GaBH3Vc0pK2TxGhOR
 _3iWUy_IQfbTXd96QO9dkdjBY9VoTS_nOExc4S8oGK7Udb1Yp26yRKCB8mTYzGdk0ZYHp_8GDRRS
 fBK_Ld2WhD8L5ZmR6h3rWmvHxwQZuWgZyn_YbUitTORpiI4RpdtuZXh2pBSHCC6BCZ.tZh1w6KLR
 woVwn4WeMEN5hyyQVlHgj8_qeXNoQ0JprG4z14MWJ8PxX1nos5Qp499E0lRmyv_PM0F.B7pKEnJL
 XW46sNeF_68ahJpe7BcXjb2wu9SBHe9SDJ0ifWxl4_nxtdYmhaXMn2unJb32Ju.TDuYEg.s0tnhH
 jHNu.MCIufXCs2nZgOfoPlvi6yPHUvYA5bDiaKa2GzjAX9MFEIGYYFsJdLbNh_mWaAVbxxZ0jNaK
 e0x69n_4OkiJeG7LiQJsfIMOoKGu2IwSIIl_7ixNcyCH7ufTs71vbXCh85fF9kpAyhWf9o9oRI2X
 10NNz0.rXiR1RQuE7G2h_tYcRZ3h5sCH_h_.6p3VD1I2G_nv3QtiGiTHcpBsEXBRzij9MWU.4yFM
 2N5udt1iTUONKwssvxjC49ik-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Thu, 3 Feb 2022 00:02:02 +0000
Received: by kubenode548.mail-prod1.omega.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID a665ec3aa0aed90f3239ab23ee85f667;
          Thu, 03 Feb 2022 00:02:00 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v32 07/28] LSM: Use lsmblob in security_kernel_act_as
Date:   Wed,  2 Feb 2022 15:53:02 -0800
Message-Id: <20220202235323.23929-8-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220202235323.23929-1-casey@schaufler-ca.com>
References: <20220202235323.23929-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index 3b734ebb7e29..4a256d302d97 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -462,7 +462,7 @@ void security_cred_free(struct cred *cred);
 int security_prepare_creds(struct cred *new, const struct cred *old, gfp_t gfp);
 void security_transfer_creds(struct cred *new, const struct cred *old);
 void security_cred_getsecid(const struct cred *c, u32 *secid);
-int security_kernel_act_as(struct cred *new, u32 secid);
+int security_kernel_act_as(struct cred *new, struct lsmblob *blob);
 int security_kernel_create_files_as(struct cred *new, struct inode *inode);
 int security_kernel_module_request(char *kmod_name);
 int security_kernel_load_data(enum kernel_load_data_id id, bool contents);
@@ -1104,7 +1104,8 @@ static inline void security_cred_getsecid(const struct cred *c, u32 *secid)
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

