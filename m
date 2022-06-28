Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FF7A55C4DF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:50:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242892AbiF1BDT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 21:03:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242802AbiF1BC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 21:02:26 -0400
Received: from sonic304-28.consmr.mail.ne1.yahoo.com (sonic304-28.consmr.mail.ne1.yahoo.com [66.163.191.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C356822BCA
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 18:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1656378144; bh=lAzeaySMYExR9867Wp/iqvj4/2i9k9dL3nyCk5m0AUg=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=KMgqZKMlNsBMYbnXUnEmb3cqSsfi+4223y9du2CeVXNEB2knNePekroWgVHm78sQaslyvEXeEqoiMupzP3c+HejpGUj/xv1TPPku8vo78h6JgUCbOV5GNadtTsnYUrg7MeetgRxlGo6O8BLhJgs92IMA671PWg0Xo045QC8GlIwYQ/MyMPOvS2idUCMM5ncRworK2ORY6sDARFIG7Cv4rt/rn2HAyVlcacBkssxK8uxbTsZLjopvWk+VfUIXtR9MGp5wbdN7roqwBETS90w9Doj4qll671nqBXH1hfF2l7lajtdkcmzqO2K9njXf2qoSQVo12gKgmhuoyLeYjoni2g==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1656378144; bh=gPLmQupEko+qO15pw9Mk7YBTdjQVEF/ntX0Dhhj8E3A=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=hqx02pzm0IQ36bQ+RWSa75M9crYSBWsiNjqmf/KXd+zVozS2DIS+jR1HOGkSSmlbHH8J/hs7ypZJy5bNoJZUjOyMAcojfPiI4z7pxLZ8dcf0FhhLRgR8uAoRhj4gSmAYmB82MR99lHxc+khEfgun58qNwyuX9kDBJNIed2eVKuFvHvBkldjYsi443VvvvRjTXEaTSZQasRVD9Xo/0itMt61Kaot/EICgxJ/5KAYSDQiQLiLO3JyXLHZDatrCa98+D5PaWCNxY5AwsiTTmPbNRzCeB2VVU8QCrqGRtsrS71dcgFhsXJBPhXZqI4AYrgyT+c4mGeCP8QAT4Hl+ogBWIQ==
X-YMail-OSG: wjn6n8AVM1nX8SJP6BcjnC3bEqxiaDNQdQn8gPjQIdoNwKFM9ghks7Nb_Eb.L_5
 Ixl2wimfp0gPOzWFFXvogPl8tXOC_3atLpwZ10KQEvCUvSa1bIp_iB8nxf4pfezN0NgQo8sglKPU
 ZLWgr1b1tUu.A6w7K22we7ICnFLNGh4dIpNj7eXL99x6znQQmf.kAFfSZo7EoeiN_GpUamdZXWFy
 ._Ado6jlE9vOkHkHwsRHDt0qoBdVsCqbBGpU2PPIGSI.xgR5n96fv.POm9GtCA.AaTM9UjMAQhv9
 WTwweamVLqV25unx84BR58HDtGLuO80y8f0mfSCcWDu_j.FEuZoRknG5RGj0MuSRYvGq6bxCMpoh
 IiJEOKPd8RzVVId4ZRoEXsG5YFOHZAUb3zQ.lu4r6tfpuOaPnnwkA024Fd1wjkEbagSwysUhMYN_
 C9GFCMMq0V8KdpzInKhJEnFJxF906Bu3tXmXt4LV515GLzkARWQ_cDZ5k9OxiKXcTVfI98AWyosM
 V61A7GHrZWfOUb6GSZ9sqc2OTsmJ2MjuV9ylUX622.kJhuNaJsF6ppagUhP3YvPk4l1W1dzoOt6m
 AATnWmjY9CwIxNvqjgTO2925616clEXk4wSQvgvgPGExPRr.6pe9aAJRU4OVTD5VrWGM6TGykVwh
 5azmd_TObf52zbhFaNSp_JcXFA0cBX2hhnbt6XomMILxzhKs9KyKcJBFEc9FIRLeGjsysCpbMqAr
 uIfnjOmvGu7HdA4gWcVregKoqS1gzPnRHglViLDTeNKroZavWf0pm4swaRHgTaXqhOa7RL8Ag4Gx
 gaW9B8CJb0faSrvHeJkLvWlv.aCA16.1nE.wLjfLQS5ltWuW6Hwra5r4E88m.zFbtbEDgf4CnJey
 v3Vg5bnCr5.lG5kbU1oD9QikihZT.YtgN6nwNbNLMIPabWLWdtwnf9SGCuLVOcC2x0rGc5JD.1yi
 DWEs_WrS4Xktwgjzn12wORB1uJcyJXAYNQjuFz3rlZK_taj_draq0GneK0xHweqbOEZuGXHoqHPU
 fan2c7YY5Vikv407LeqMclLZYOaEf6l9a.gkegn7RxGghcnqfE8MkGCkPjwR3iArP8XgYGjAaJel
 m7qoNZBbQUQycaVZJ8C.D.nX.dTNjgesTRydsBV68pz0GaifWBd4vitUzyQ3HVUkMcPl1_h3W0et
 IfY0oXuiyWmftFcpgn3LAaIC7eLYXTk8hqohAWmrCrG2f7B6cYT7QEQWhdfO51qzO39DnzjeFnt1
 L8XemIyjXKYzxAkuIIvBagNu5OLEEq.30pmlhT.l4QNnvWzvfrj.D696.e4zeyV4JlO36w3ngiQm
 PMwAV6IT_zNqLZYcaVL0eeHc_CZpK6Qlyj9_UVxX53v3qbR_k7oimKSonYP4k3gkOQJ6n_JNnJLW
 9EBitMsAtNTbzKBY4NJFY2gVfC5orWeVSqhKAaxPRPMzNQRfpKKD_h9mzILUm.jv2cQSSxp5Bnox
 JWU93M.BStQzYwNGpiKyoh7WwhqVZDGbOa7cIA7QOE.BkR4Iy0_kyM9htE1Uf.3XmEdgCF.ajnxf
 6lXk8vDq7GhuKHJWcmUZKYXqYtTYlOceXmAbxnwHBnYlAItOKwZBbKqmnMIiXyAhzItimEK0dIB4
 pSDC8BLGrlhAe7eCQOpPzOxAosOfG7cZsFyilkFt3N88sJVQEhzX5rXZXcIMTnGHuXyWAcBWF2cq
 q.mMUf.4Qsa583ExN44MbYHL61AEDWrVnaB.Yau_3wUis8qmpqPAY_L8efoDLdcyTpuKCq5Gg9SD
 IbeY.b0JMRSc7wld1pBf7x6vKDN_mWBwJ.H8tcJzbgKUhTXuJys2eG.NULxazscpZ66bHnu9Jz4I
 P_5WrC5nm1x1IWVfwY2qIHDoJqzOgElSu7Msf5q9jbSWA.ebt1XW_sqTYgD7m645fu4Z7qom2AZ8
 4zo5UfEEW8isbpdoerv3DE6ivqJtOQRfKCE6GoptubehlW1Ya3nzzNULNFV7FTUpeQjdOg4qOUn.
 O9zh8ob76yLyGZJOTaJdIUvs8zsnHIN0RoWhFSkly.8tqAqF_Nh0zEH_8aJOojq9eXWNhEqFdMxb
 3MN8152fnKRHdfZlhTbdKn.AuFGvO74ADixTxqh_b0gWbNDU7GeF6FMDfht6UbzVfcgC2jkAwxve
 WK0M7_f82AO6KDPUm8YMFPOYfIBo1UstKladpz672ankjHE4s3Iqr.j5n5bmCibsKUl06NE7GKjW
 SyL4ax52Kdoz6x0KKZ8QUe3CyZ8YxzBiu2N5IVq8nk.7EwKQ7J.2lYdERag--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ne1.yahoo.com with HTTP; Tue, 28 Jun 2022 01:02:24 +0000
Received: by hermes--production-bf1-7f5f59bd5b-wm5tz (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID dbf52cafe43ef47006ff0c558ab03737;
          Tue, 28 Jun 2022 01:02:21 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH v37 07/33] LSM: Use lsmblob in security_kernel_act_as
Date:   Mon, 27 Jun 2022 17:55:45 -0700
Message-Id: <20220628005611.13106-8-casey@schaufler-ca.com>
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
index 95ba8c223e0c..823880ba613e 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -465,7 +465,7 @@ void security_cred_free(struct cred *cred);
 int security_prepare_creds(struct cred *new, const struct cred *old, gfp_t gfp);
 void security_transfer_creds(struct cred *new, const struct cred *old);
 void security_cred_getsecid(const struct cred *c, u32 *secid);
-int security_kernel_act_as(struct cred *new, u32 secid);
+int security_kernel_act_as(struct cred *new, struct lsmblob *blob);
 int security_kernel_create_files_as(struct cred *new, struct inode *inode);
 int security_kernel_module_request(char *kmod_name);
 int security_kernel_load_data(enum kernel_load_data_id id, bool contents);
@@ -1107,7 +1107,8 @@ static inline void security_cred_getsecid(const struct cred *c, u32 *secid)
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
index ade59e3638e8..d3b28a6b9248 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1810,9 +1810,19 @@ void security_cred_getsecid(const struct cred *c, u32 *secid)
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
2.36.1

