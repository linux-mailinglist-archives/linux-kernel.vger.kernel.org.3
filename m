Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 057714738D4
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 00:48:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241821AbhLMXsf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 18:48:35 -0500
Received: from sonic306-28.consmr.mail.ne1.yahoo.com ([66.163.189.90]:34283
        "EHLO sonic306-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236425AbhLMXsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 18:48:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1639439313; bh=WqTilqDGcIu+1yT7DKcfjayEylLcsuo2HVtuuRvXH5c=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=jsvYivaPXDu+wKTF4Vo9e0+zu5C0gV1mhLegloQ/iAVIvGvTof5n0dKSj/sSDsKw/o93sT8OkKABdVJ/ckcMZO6DpYhx/wtRZfIj7AQ3WFyMCvMTsLiNPAG4/1RhxlbBZoR3KBZh01woB5rS8AYaRZayetdeqcTC1A12Ah/jiKU7HOXSyGlL9JPWLxF++g3oQssg2c8z1MocO6X66Hd9k3qJ7ao4z5cj8rjGEWJwwhXKy7ZgEaa1zeAt2hQNJYM7h8jiPhgsoEU29z4Vxt1CYe/7V+rvr2KSuMl8Z2hQ71Mmi5zVhF8/vfD739bISvfbNL/Ibqbro5ZWUe9eNBNA/w==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1639439313; bh=pZEQ+AKMGlTkclHIbVOxsbJlt0XKEaHRoaK8sLEla0g=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=YcZwdtgHFo0evK2+kh697ocImjlQNT8KNXF+2hRISMTlwwd9Jjq5bUOrHd/jH9bB87IPZhRzJKr5zSVA680nXSDhRkr9wkKfPw+MGAuqP47LbV5zm675HhonUM5w7oOvd4oCGDlcxWePTfsKxzOoKbo8GGMfqJix+9nYJHUiJCWl5RZWxa1JnpPL8n+t8CKi5Ld1HABoH1yTHkYUw/oWrgf6+AFXqjODITQlTdejBXjZ0pN1JGVOIz8ObWkK26bT5RFy6BqCgDjmEAcjOMtzUfR7aFDNi1q77I0SGFiPsHKl74I7Ip59eZ5sVvPDv1xvwm7Ixh/Ic1NZ/W/u36a0ZA==
X-YMail-OSG: WXWcCnIVM1kIkBckywGKgWDi.rkR8SWA5tiA6vG.YdhcczLjCmzS_RyOi8Dhj0g
 yxl6S7vjcM.w8D.XWmJhs38uDKp9zavBhgn900db2l9ecqSAtZKGsjfUrPhZw_ZgGlLTpSTrURq.
 EnMpby3D5f01QcuqQLqM5TS2qOVyXNRW.qOSVNVYWLayKRPT3H8xZx4Jeo9M24V3OFftxNSe4UsE
 MHThI1DzGj2nIuq7sMJSbxZ2S16i7PJgmxoy148Z1vobMqZbC9IXbUUG4d5nxvj1uceXjO3yAoSc
 XAq5jwUXV_aE1Z8PA.lvEhTqkEyXSW9VzVjmgJSuK.638p1qYFEQ9BMB5EP8Jkl4iSblIfDCCLGP
 2UA5v19VWxsRGoRzicDxpl1vzZdyyu0YLaMq83EAuek6D9qeQplOoV5QAIGH0FIbUtx4osQ_CbeJ
 TxOHyl5Ja.nPWAyWHm5w0oMGSL8EEYtMQkcPv_EAhCeQcWzqdf0Kg84.eDGxkn4vSD02Bi4t3uhX
 .UpZZrqT6oY7u3thLjmwazVuJ3WJ_Y7Z1n961IuwMyLIaoxMfgh2fXw4iloWaG0NQnaZUU7DOdCq
 tywuOT0FPiO8NDZIqJFNlUlneSReoyLKo0acRwAiq2cemW6QN6I0x7nDoTAozkNKpIissKbB1xC.
 FhLLP8Hd1W2D23FuLewfgMYuKN3yWA75XimLEWcdUMPgiW3ZeAAbuUPzszp17kmtM7qbnFABnYJT
 46fEohrMGqXuCRRfBO0ybLZxWVNss6OqENa5ebKb9P9K4idMfJua7b2CFr.PK..tB615FEMH089e
 hEISLRF0l1e7uy2V85rk6Car_dmj8F_zwkYiVsUXQWTVhdaigigxgFZNhhaWt84zG8nc8fM2gmao
 oyNy5F6FGcn_9v_BfgrMsU0WCV17gDHWd24LZzVW0Tp0Mk28k37RsCy9OdmiDQZkSQ2vLRnGv5BD
 qwvkZfYbmgOE94oMRqZdOpL3ZRtyNKXEKRVgQ6HWt34Zyvc8SMyASq5.UYtXIfQwkiLg1ZLZCkZd
 Ek2318UCZLYInnru7iQO6a7COa9019I14It5iz9d9UcYdexL.k4Q8lZqrVhDTz4jKiJqY8dDdcle
 0pAhtF2_75BbCuFHgnBpYohaV8OIWhuYdVt.e37J5I2Cbpg86RjJkV8goKVq7mVcYevMx3BQtlxg
 3CuwRN3hD8YmlhFw1sjKwEkGcFZpmz8Nx1ez616PYuLqGIhGw9bQJSC1fFCzZ6uDLbhztpQqSFP4
 .Y78qUJDUkgDTlS1ynoPz5OAXZZgdHUL3F3znlZJ2zXq.FPUdD4RqaoCSQ4K3wUqFGBVaeDtBH7z
 rj79B_QeKeDcc.Lqg5kADSFZ.lNKJYqYjNGt6PCMvy2CbPkAk5odpmZs6A8rmvBk6a.hDvSiBKMI
 WBO13_pdLMsxL8szpTtJc6u9CEB4lqcjYd8BK2qy7nefdid95elKyk5NS3laGJtm510i5Wy7UEhL
 KLesCBk.zNBxl_LJ3RnDj6h3ZLYFBoqZK35VFcqpx803bv.wniSXVDPmUjX.d1N_zNp9k.OoDXvN
 PQcpJp4BPsddZIm12GVjLt4HtY1vjWh.AVX80HL.ZGvYG_5YQuJdjZ7VqZa1PURR92wiVBUIkX1q
 XWgRuDn3qEUWAC5.NfDI5hngTK_TyMD7PL1PVkej416doiGuDYlc1mP3exTL93zCA.JnDcvist.w
 2qHHHsQqlEn_PRfx2TxwZwf1sy8QP4CMw4rV8uL0374gGKkjbwAoHLepedVfxuK0RfE7UCVaP3EQ
 DRnLAXMvkU4Xl6nxcB.bPPTW4FvouuDWZuKLpQVqNV3.jg6PFEO4rVP.FafA_Olrg4mIaPaOvZ3v
 CNHdtv8PvjalBEM_Qos1PXnoPTMce0oKICZGrdAg9uyzauyf9GEISa6f6D3Jo9j.seyEFjcShLMM
 Bh1jxyQ6wL2de4eyfFApurj6J4UHPzQg6JpHzswHBPW2xglefdXH9dYKRwcuGT.2Xx8t9.lx_QVl
 R_szFo2m1Edx2yqvM6XrG6Jiv0piXAMsgeZV6CnH9wuk3vhA9brNbPMycNEiKHtxF8p_QIuBmXTk
 ueAvOmKDmjKbLYRLrTFa1MwcAI.bisnoE9UCghhGNpcdyangIUL5WL6QoM8dPtikSGIUy6_2zDPH
 5RC73SptOYNCMJdEC.KrLKU6_0ggrjsRGJ1xozxNUbkIB0.HPK.GId0JQmPjqbDJfaAhO3pjE1yI
 TkoUhFIfEnDBSk5turGQ1K85Ohn8Xd8UBCVb12AM1u702RuTFt_G_oDfBPjwhRnlxBIq6.Ti9cAM
 VMHJp4cjL8kI-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Mon, 13 Dec 2021 23:48:33 +0000
Received: by kubenode545.mail-prod1.omega.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 2e021ae071039d083444738cca3c5d3c;
          Mon, 13 Dec 2021 23:48:27 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v31 07/28] LSM: Use lsmblob in security_kernel_act_as
Date:   Mon, 13 Dec 2021 15:40:13 -0800
Message-Id: <20211213234034.111891-8-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211213234034.111891-1-casey@schaufler-ca.com>
References: <20211213234034.111891-1-casey@schaufler-ca.com>
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
index 5a29b9bfdeda..aaa63bf5026e 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -464,7 +464,7 @@ void security_cred_free(struct cred *cred);
 int security_prepare_creds(struct cred *new, const struct cred *old, gfp_t gfp);
 void security_transfer_creds(struct cred *new, const struct cred *old);
 void security_cred_getsecid(const struct cred *c, u32 *secid);
-int security_kernel_act_as(struct cred *new, u32 secid);
+int security_kernel_act_as(struct cred *new, struct lsmblob *blob);
 int security_kernel_create_files_as(struct cred *new, struct inode *inode);
 int security_kernel_module_request(char *kmod_name);
 int security_kernel_load_data(enum kernel_load_data_id id, bool contents);
@@ -1112,7 +1112,8 @@ static inline void security_cred_getsecid(const struct cred *c, u32 *secid)
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
index 3ad3aa74c59d..171e2fe66e5e 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1800,9 +1800,19 @@ void security_cred_getsecid(const struct cred *c, u32 *secid)
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

