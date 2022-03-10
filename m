Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 859044D55B5
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 00:47:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240556AbiCJXr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 18:47:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344836AbiCJXro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 18:47:44 -0500
Received: from sonic308-16.consmr.mail.ne1.yahoo.com (sonic308-16.consmr.mail.ne1.yahoo.com [66.163.187.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B50219E023
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 15:46:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1646956002; bh=7Wdp9EDsxW1Zt6K6PMuw73Hqz2U5QPna7Igwbbb21go=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=n2ocOL7AmTUUGZgCtkNczrrUQ+e9HEkOYU67Je1SZJ2NYTtDNYvYxBSYXkz71zhXFdRmR8/gURabuzM0zGIyGiK1SETth/DTSdrTRi4SVDSm/JxfTYNBXlXnpCeV7pkiT360QKcqimGttF+pU82IBKmopnTqBw34aoxaRJG1l54aGPK6hgtUuJlNnHdJhQG9r5/PwlPimSwcr/gGQpWA6ptNqYLkmTTVmM3ifw7Y9WLQt/pr0r2L6wSwqx7oC496Rg8IaCw3jJRvzQQvTe+MTh+d08UhCSas/34HC+Xg/ZbNS6bLXjhqxbuX2+MP3j3iNC7wyDYcsQUDIA6TSH0SFg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1646956002; bh=XubnpSa90/KPZ1N+1EmnRUvUa0SWKGK4EaafBlulVCj=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=nP7yxJ1Q/+EMHGCOIWvnqPFHIHfQgsBZYFMc2k+XehTdEXjrI97boutgDW3wq0AWmICvyZZP0p28Agb4a8fvvdJxBwXUm6v9N4l6fIyTBNxUYElssGL2HPAPTfDHRi2LWWZiz4LXLf2b3wFXKprg5f4nBhU8IBDTWpFaXSKxCL/gFqesKB/r/XFKnsgzq8RDkteiFIlRPIxKzIMi3V3h+OoNktWLH3thJi7EjlI0gNtU+xNNPeh2yC7N0RvKO3M667goxvf4qzhB+1aRLMcJK896n+1rRYdHLOEnJzY6H+ryUkAfZ+gtcH0iZEakm0tYuMTAJPydQLPIMULIB9HWAg==
X-YMail-OSG: 8c.dQKoVM1nJSqqK3oIO9ofSr0jUAuYF_1l_qeXleIzm5ww3f6WpLJLMSFcrBBt
 TEWgk4sXDsYcXXkBwU8uXVG4SuMQONApBf2Qsa9x9snEXZSAUhQHz4IIh8Jd9GoFwg_IbCTY0veZ
 pvaNIAnJuwJaHUAF6n8jyRkfQkVn_q_yQSjS05SQ9R1DmXqN9icTkpJZbOYFkkFNP8VN1Mizv7lh
 nwE23gFEes4GcxfQ8B9dJ6jrgRTKq8fLKHAWzIUL9MnQv31SX4xhhMelUdN4lxRdaa2oTkR.I4Ea
 NF9AjisKeSsnn_wUFNWHVACVPdy18ZoZ1S8evm8IO2kTVwwVdjyKBSlTgcAgQDDFxQ3ibA.aZ8Hx
 6335T7WrtKzTcmbIOOCGXmDrLNvmiD9hRORTjekKP7WNZH1FT1TzSwA2lQkcch0Difgu0Dq.cm.6
 deCsxksGvQ6BlfEj2EvrLbtJWO1cSqtQl.msLrpGIzIJ0TGvBZd1Le9zMcWX1e8vfcjl08yUr93Y
 WnTKw88UjFSnLFeZVV1vYRSaCAZNx40Ja3n154co17EIEzC_Zeg_It_6D16Kv_TAV7J..o1KYu2L
 JRUcEePZsPMPkkzOUTuw7ovyGmPevixZ4.vq_CAtAG5bO6Y6bZp6EWojMsw80SqsGC90Oaxil9YL
 yAZOihe7CLjPS1vP3aicSHvCxjBhqUHFs7lxmQSc0ubUFrr6J_S7ZYY6eNV1IfNUbwB606.VW__L
 ZdRQlVh9P9Htwf2hQVPiEGKgSj_xx.mTlws.7Tu2YBUrB7vW1NdErl.MCoOGiA5NWDAs4ywAY4oz
 PTEIBDZruESsjK3Au0ZrLoTZnR_2eTkLgV7Cl_Y_hBV32OtbDwTUm6It1Nqc4if.NuR6zXdP5aoq
 96UQPmbSO58syjDcyFOXtQepjcYErr3lmpZuy8jpFXG4zVzc__8_byC.zbSqTCdk.Ijjj4hQICeO
 r8zzAybIXw0SCBp4kbTixSCNIalT..bO_lKRIObA_DFgm.u8PnRjJxcTWZIiKGyJnMyFAiTQygpI
 NS_5QmREfm4HOcGW5mGGcztk3Q86n3_.6PxhD7RqUqbThFczuJkCLUh6mjFHHY4.X26ApWgRs.kH
 .qerBqLFnc5inUeLcIsYUyT9p5xM9HjHgGDatNhFZv3K2X6FJocp1TubVK.2q07w8e9uP.baUBw7
 50609tXyIw9zBAragWMrZszah4vR4XeA7SBKNwh_JqSixDjVJ8QmdqX8q6sUAEZCY.d8osX.lXJL
 kjkrv9BS3XRv9CHPXdXMTltQnm4bdjDuD.fHqarHVuoQ86EelbnWwI3Z1WkTYccgNpwR4LGKgga4
 .EMqpaUmzB3hyjrFGlkBcjjRF7u03QF5JRp6_xyxsqdkcsiendD4t_O1pYJVLu5VwiXV.gAAqlKt
 A57gvzflJVcOagTb99kYpUWFPLremNDGxKwVd9NCLYd6m6lhDT6a14Yuy6UmRF8gRY2_joANxBV8
 v3uKXoseZ.U8rhgrnx8_ADhPu5vqQ.iT6GA_s.w4ppMOeMLFqZ2Y38qLahVOqMug1so7pCYEz2ja
 t3IawDg72tr1OeIuniPxOLYIBKBZaVecA_6pbSSrwTzCWefnQpF_kj7d1PfuCFTv1EnwUczW5JZ_
 5PPfK03HGGv.ZMiTNAt9Ae0uCCZS5A5FSV1HGgOQlSb66eQleRSfBhclP5nbYwMFe5pvOLzEhQ0q
 eh6HoxzEdmXlNzYDoEEIh5EMHIaXXoi2arrT_MXmnuGrs6Rjw82qSk_u20wWu.NrUFEwiLg_w0fn
 PJlT.j5mwdyEpOuJTOrVKUh6L0Fb6jel28L97hK3lmmsfgPLzHbh9bMhrFyHFWZIaPx0nsENDyVf
 5Ug5c1TeOsyL6kHk9Bt_xFtf3njrZ7HA9RJ50olQ4eVGKzC3P50_jIAJ_zhRxUOKiNEp4E_iPEBx
 qKMmGedCzbRUsBhRsHWBiO5M928mWm1wSr4XgaeISYQABrzg1r9cjPhVG7pTmy99w6eEpSDYbRiK
 APg42BHRnEtKQMv2lYuB1_O2E1uEV7gR0BoPiHdvAFfQbf6o_JKmMmEVbmL38UzaWLgYzpMQZ.CO
 5BXkEhLlfq.rXXsQFmY.cDBE0SDXkiUNkfX8ASsuVjSo_RIvsdaVSIuFUdMJW1NvXsph1djCnMyc
 GOU7NBquRl5Jnjifw9ZQANNd5vIKoZ3Bj7sEIJmZbokuy_OD7nhvCxcAEEpAK5jVxcBUV9YRdXlx
 V89D8spYF5stZq3.LdPEPHxQDAdo9Zkm_WzxKeuuj8ggTZqpLfqL1YiQzNwqdFWyzOdoou22clcJ
 CYvIt_a2pRYspkbGrzOY_CQ6P
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ne1.yahoo.com with HTTP; Thu, 10 Mar 2022 23:46:42 +0000
Received: by kubenode525.mail-prod1.omega.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 1bc6570d46c38480d6f664d5c69fa809;
          Thu, 10 Mar 2022 23:46:39 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH v33 01/29] integrity: disassociate ima_filter_rule from security_audit_rule
Date:   Thu, 10 Mar 2022 15:46:04 -0800
Message-Id: <20220310234632.16194-2-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220310234632.16194-1-casey@schaufler-ca.com>
References: <20220310234632.16194-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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

