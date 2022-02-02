Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63AEE4A7BF9
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 00:55:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348176AbiBBXz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 18:55:28 -0500
Received: from sonic307-16.consmr.mail.ne1.yahoo.com ([66.163.190.39]:46439
        "EHLO sonic307-16.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231897AbiBBXz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 18:55:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1643846126; bh=7Wdp9EDsxW1Zt6K6PMuw73Hqz2U5QPna7Igwbbb21go=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=dRM7ThvB9xQCBXhr5j6mRNGopRd30f40EtRQOd2hEymLWmJAMj6JmEa9Uy4JYKQix1maruI4Ut+FnRD0MmE9353IG0c/k68PGZRPZWtkZ8rg3doDAcf3MQFAATmso54wTts/RGBiAfAtzQ1m3VHX2Z9RArxsJWgspQWob1xIX5fbVPVw/+NNSKNW/XPRfXoeCQrx4L2/gZk5JcvTe3qkWv/SoiBv+TgVF8KpEQyrEnagHKCYobVAI5QTou+XjDeMcKx4GFEIwmynGIaat8HVZ2XfvHq4HB83xqI5N3yqZej8Frdv0kK20deL+ZOwbM3eZs9nMRGDW08vzCoVsNjhFQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1643846126; bh=uoevc6ge+Cv1vJ1tnZ9/GxO/v80tYCcRumY1ywvv/n0=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=e4Ao012mh45Hv9nR0fX/kY4kF9PNZwpWbxFaj9hCVCFrb1rWsb22Z+vXfmUTz6iKjw/ufKFqiR/NjIPk8KjqKcKj5QPI6HM6WPWtUCaOHKSMk7tt/Tn1/VJ7IbRNiCs5LSkNU/BQ+/elHdvRPLgScJbeI+UGDci3nc0moIVmpDJdhUJi2A4/CPwIJ75VJbCTqaZXkCI5RaIzaw78+EFOYdWwFFRmypwHNFBfdQtxJkrjXWQ43FeyyAecgHoUDEzNXSiiuSdwu7+zw/w4M0rlePUxnb4NxyMNzFO++mBDQ9Z3wct+rKWkWNdrPPNUL7ecoOGSCjh6EW3fYxR6xJMccw==
X-YMail-OSG: ahew7VQVM1mvaM1LOt1thkorhiKa6anOv3P6yGIfLazmLgdRIAgmJFso49TbfYD
 XYGCwmnOqPvQg31ahSIIRyyPsQI_i7d95kTtyEKVGP1vFL8QnHSG5q66FgLfg6iFUPTN.C14jouB
 5i18FlqH0dosJX59Ei6Y1gWeZqn.GvupuhdKlxRWxcE1yEwTW_gBd_hpRasCLDSCqVzb8AK0zF7s
 DpVxX9ZvDvkxknS.M2USrpxuNITy2GVEbI5L.uLVkJMFEls55bMAIvKesVM4r6XswHET.AJRpeRJ
 UZ6GCjeUcxLZ4Lu1jrxHjXxmm3FLL7Z10acHhEz7S91Pnsgs6NAsYrOelSOMdcf7W5T.4Pqe11N3
 RYaSmyI7uWBYVeyYqLMSmVXrAGiVtYvR4dBLJDJ_XJw1Tp6jw4RDp_EWqeMyCuLcuxBzduQljDFp
 YzB5ziy_dLIoy3lbX1K4uhZmQVBgtyooCsCUWQ5InSwwzuepC3c0seIyWGmfjX0RWzIiPBo2hwXN
 eCoHkBRCxNn6K77hIwBryWBPfImrAdhdlTOoCl8tMdkDu1XvSOCoYZAOcKJZ63M.P3sNMJ9tl8R5
 qZG1flyEvHvbBE_5eRMLT7rmIBGlTKhMo8bU17PNkZREG5QBegXN2dsMvAgxnZyl76HqXsOVtd_n
 0cmDUrLNnz0aAiuHT4YnjfxNLrp5odtlrDOfvapDICvdXgYmfiJBM1dvqQuIhdcOMi76sCqmX1Dw
 LS_seFSi6XAwJJ9ATNsZTxQe1TwC_CwU3mOv0zkSwFJb4KfN01IpXogX5xq0A76Kr1t4TopUPmI8
 nf9haff8Q6UyyeYHklPc0OiUcrXiIo_cNJUn4KCqBttfuiiKyQpxVGWE.jDbaE8cA2OndcrtBo_B
 dL7SAECvWCJWI2UK0_UYXDt_.C7h4FqW1dK0yZOZ4WHQDSTRZz1bOJOrc_bZxwGHPovWgI0SrqdX
 rOUljflQY4OjbjcYnaYStlCpow4sHyBGQngiMfoP7rI.tLXcUVKJvonm8PUK6niYhs8PSZOr54yO
 TLtJSy6x8yBb.m.tCWnHs4CQHS4mSDJZ7Y4FDoxefl97xlOjTHvMirH38i7GWKFtanPnxHOGVUEi
 jBS5BiD9ottSnYdMbcIbdFYPIVjV1HrtdfFOgqPWkKmUtNw4TAXLuAwAb3E2LcEVEJzyuxigCXtH
 EM3uKBgnj5GNYixiECVciWooa4lSH.J4qsRdBZP5_9I49BdrHFaJRq..ynfWgr1dtIdXlKr4.2q5
 gKOwHxxVWzzokjSspIyc1R.CSuMflmkhMtRtl5ZyC5yFfzVwQOmbmSxaLiuh2mW_y2ehqnxDyzOS
 Os7enRiAMmd4RlefMW04ZmDa6BtUDCN4A8XeqHset.M9PLgN8KJbtqqbicaVFeH5eWi4XCoxQ6Iy
 BFSJJts_9sbB79eIjXl0WZJCk5VkpCuX2KWdFMISG_Y4rMOZIdyLz.7P.uOaHo.eNvnNmr7Dmt_j
 l2frcCmnv4epeIgJrRWkkHmThhRroEV6bXn_0YISbghDvs4OGsrlc.r8D0U9cFz2kIrLA5W8RAdk
 fImnOAVfnsQmW1sp5sxfBy1BoP.XETJoFC9mNabltvN1pIB4nMX5Xk6dsDY8ndISN.35oC2_OxPl
 O0fMfh9EN5sBskSOujwNpwCtHdpusLHp2JVxJ970B24TgleVXFrWnBKliPO0XFYRraysFQmjFURp
 2ueMcYTJN9OvuL2hipqI3.l3CJYClbTkQBORNam3Gju8pgJEMX1K7SL0mr5PYoEUYvGJgDdQpwYc
 ZFy1.WNnMlIrOq0VtXzdKAnYl2H_gaFM9YJsTcs7Sw8OFsPneZafwOZPBoixJvr_ReaiwI3WgQ4y
 OYKtPcV2D9l3V9c6DxT8SgUMml3YdHlFlmmxIoflj4BkLMqJQliXvuV5D18RGbow7esZk3mFt0MD
 g62qS8btbxj5GxsP3V3ZHlRzUhiDcxeAJuJvoa5UNV.iohrCJ225kbHAtAZlatZVTPiPCLIqEoKO
 U.zKb4xYchomGENrTmhf9brDo4bVyntu.WmzZ7mNXxlhbt6Ytz9k2qT5jWrtunWr_jT3x1D2.B_H
 xpKLnd4CdMbNQdqirdOblroPCpMnCXIEAzYGiELkLZT7t5dStQpEI.vi0cR_8yQ14Bmd1HN3TlLJ
 b2kE5GIVv9PI8PgL_2QJRmgamoh_Gkw27KMfkO7G9wj0gMMSImgsUU6Q.YETtaris2QYa.k.EsGJ
 CP0sB5ZFoa828JJAw6v5aCWUVZzIHWysfQyqgdBLe8HweKQl126gMM0Pe2d1xXQ8w6Ubb.QR2QyI
 hAF6mO6o1nudALnpki65F
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.ne1.yahoo.com with HTTP; Wed, 2 Feb 2022 23:55:26 +0000
Received: by kubenode550.mail-prod1.omega.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID c9f9b4e3e0a0513a55c332234593eb5a;
          Wed, 02 Feb 2022 23:55:23 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org
Subject: [PATCH v32 01/28] integrity: disassociate ima_filter_rule from security_audit_rule
Date:   Wed,  2 Feb 2022 15:52:56 -0800
Message-Id: <20220202235323.23929-2-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220202235323.23929-1-casey@schaufler-ca.com>
References: <20220202235323.23929-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create real functions for the ima_filter_rule interfaces.
These replace #defines that obscure the reuse of audit
interfaces. The new fuctions are put in security.c because
they use security module registered hooks that we don't
want exported.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Acked-by: Paul Moore <paul@paul-moore.com>
---
 include/linux/security.h     | 26 ++++++++++++++++++++++++++
 security/integrity/ima/ima.h | 26 --------------------------
 security/security.c          | 21 +++++++++++++++++++++
 3 files changed, 47 insertions(+), 26 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index 6d72772182c8..33e0f2e659df 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -1909,6 +1909,32 @@ static inline void security_audit_rule_free(void *lsmrule)
 #endif /* CONFIG_SECURITY */
 #endif /* CONFIG_AUDIT */
 
+#ifdef CONFIG_IMA_LSM_RULES
+#ifdef CONFIG_SECURITY
+int ima_filter_rule_init(u32 field, u32 op, char *rulestr, void **lsmrule);
+int ima_filter_rule_match(u32 secid, u32 field, u32 op, void *lsmrule);
+void ima_filter_rule_free(void *lsmrule);
+
+#else
+
+static inline int ima_filter_rule_init(u32 field, u32 op, char *rulestr,
+					   void **lsmrule)
+{
+	return 0;
+}
+
+static inline int ima_filter_rule_match(u32 secid, u32 field, u32 op,
+					    void *lsmrule)
+{
+	return 0;
+}
+
+static inline void ima_filter_rule_free(void *lsmrule)
+{ }
+
+#endif /* CONFIG_SECURITY */
+#endif /* CONFIG_IMA_LSM_RULES */
+
 #ifdef CONFIG_SECURITYFS
 
 extern struct dentry *securityfs_create_file(const char *name, umode_t mode,
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index be965a8715e4..1b5d70ac2dc9 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -418,32 +418,6 @@ static inline void ima_free_modsig(struct modsig *modsig)
 }
 #endif /* CONFIG_IMA_APPRAISE_MODSIG */
 
-/* LSM based policy rules require audit */
-#ifdef CONFIG_IMA_LSM_RULES
-
-#define ima_filter_rule_init security_audit_rule_init
-#define ima_filter_rule_free security_audit_rule_free
-#define ima_filter_rule_match security_audit_rule_match
-
-#else
-
-static inline int ima_filter_rule_init(u32 field, u32 op, char *rulestr,
-				       void **lsmrule)
-{
-	return -EINVAL;
-}
-
-static inline void ima_filter_rule_free(void *lsmrule)
-{
-}
-
-static inline int ima_filter_rule_match(u32 secid, u32 field, u32 op,
-					void *lsmrule)
-{
-	return -EINVAL;
-}
-#endif /* CONFIG_IMA_LSM_RULES */
-
 #ifdef	CONFIG_IMA_READ_POLICY
 #define	POLICY_FILE_FLAGS	(S_IWUSR | S_IRUSR)
 #else
diff --git a/security/security.c b/security/security.c
index 22261d79f333..5208b21c8433 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2566,6 +2566,27 @@ int security_audit_rule_match(u32 secid, u32 field, u32 op, void *lsmrule)
 }
 #endif /* CONFIG_AUDIT */
 
+#ifdef CONFIG_IMA_LSM_RULES
+/*
+ * The integrity subsystem uses the same hooks as
+ * the audit subsystem.
+ */
+int ima_filter_rule_init(u32 field, u32 op, char *rulestr, void **lsmrule)
+{
+	return call_int_hook(audit_rule_init, 0, field, op, rulestr, lsmrule);
+}
+
+void ima_filter_rule_free(void *lsmrule)
+{
+	call_void_hook(audit_rule_free, lsmrule);
+}
+
+int ima_filter_rule_match(u32 secid, u32 field, u32 op, void *lsmrule)
+{
+	return call_int_hook(audit_rule_match, 0, secid, field, op, lsmrule);
+}
+#endif /* CONFIG_IMA_LSM_RULES */
+
 #ifdef CONFIG_BPF_SYSCALL
 int security_bpf(int cmd, union bpf_attr *attr, unsigned int size)
 {
-- 
2.31.1

