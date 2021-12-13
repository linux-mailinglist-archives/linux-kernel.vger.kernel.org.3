Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC9C34738AA
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 00:41:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244241AbhLMXlt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 18:41:49 -0500
Received: from sonic315-27.consmr.mail.ne1.yahoo.com ([66.163.190.153]:39992
        "EHLO sonic315-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238160AbhLMXls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 18:41:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1639438908; bh=SXOF32V2D3oq++Ma3iBAcofIvwMGvODK6Fu8YccgUZw=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=IWotJD8t7jr2XfcEARU7bJ4ZAxBuyFBMaUeb49iLsRv44z8Oa4cqQipjbs4Y9N3VrN2acx6aSNlntYNC9tzHXbuT28d5LyKSybiI3kNCxpKI91Yvgb6SZ+Xd4/bvyHsmpO8kmdnaxzYjlwAynZrXUdnHj8TV782Q7tUWxzFfzYLxPH6kpSif1MaCYzkC+Yxl0F3RS0TmOHvmA8JEtI7F0E/DJ+O92751BHL3flZtWvlC8vqP+UqVxZESvbAD7/DeuKJv2q7B6UJ5kidj4/E2vyZk3SR2OVWAph1L3aEiatGD+YTD1iCht8FRq4qcKsMx3dUhCc27CjgtJ99zgXUYmA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1639438908; bh=7DhhCH6ZSiPYrYC1RrvBFfjjHhaCyD74ddvzMQJfhae=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=DdJk+2p1pGE4zw6zU+AjDy7ifYSmMDD53gu+87liliU170sJLZ6J+6WipY6x6wQcdU5NIj3WP4K7gunJSuvMQrW9gyiU2sAm5p0iKJKbyKAH6IJNFdiFm/nMFV4c/MVFZLppvPIgrgfy/hVKhOdoDKY/s1IlJt9KUCzANEWX1iHn33GjUD/cK4gnBrXBR12BHrhnd/j7iSNY30FhnDaVGt0cRYuDpsekrJ3wtw5v5zN1rLPNEgTm+6BABGbmKPCFL0qNuLAz00EMDrRNXhzSwSXxd1I+P8RmL85TDBMiWINSBhHCyCm4VVUCAUUqgZdUfOVGsEEd9TTN8YDs46yNKg==
X-YMail-OSG: J9MkZAoVM1kmQYVG_L1EGVsayCVbzdTOImL4UT.G7363eNXAVbDDk0qufCAr2Ix
 bjZ2IJN2K3Qf.7aNlPU7R46c4hV7IlDhAJhLEsf3wVC9vFTsz8ppK77pjEchUNY4MsaQON3ErzI1
 5lsF6p.cSr5MEgkR13gkAk8.s6ijFvVDCEWhbd4uELkMkQbe.N8ALWH6aMtVtv1hwgAbbHNLqsDF
 Ff0Gs8y2u.YtDL5H_uPzNkYDqG6NCj8QbpBi7S0.RX6QDXNRSfEdnQE.0q.ou2crIQfP7.JuqGds
 FairnGg0PV_I9TJDC994xHpIEr9km3HMCCll.lW1ghs4qCkvooVYLOQms1XLf.I_jLrLucE4GFh3
 i0C3duGYBJymXJcTbHia6qvero4WhEjnVwzY46XmAl3PupS2YwuXfUWHfPQAZQty6g4MVurvUajS
 W0UdrJGZzrxkM00RF8EftXdLe26bwOpaJBdNpGPcq4Rm4CwYUoFTTrQtckxl4gNOJaM76xUyY6Fe
 1Lt.3ycB78NLl0EEsPuQVFd90og5AYQILg9MVigcFAkdZtVYvRNOJ5njnddmsanWnRk_t5kgi.FU
 rZRGH9SHo6sMN8B7EzLt33Psl2JAQGFro3hKKX81mZVt.fEg0hbuXQJr.Q.xOMWpxfwWBQx7INYi
 HlHrdxteuhsuW6RPsJaQuJWEr5tNyd4o6vtCXN11V4F3AmnkWDeSYxzybH7vR2Yn0tAYhkVg0zdd
 qYDt3i_nGSX1aa1bXAU48Tzgj0vU46OzSN0E5auxxXXJ0o2U30mY6JN5BeBq_GG2977_WvYEawx3
 KyYNgDm9eU1tJAT9S6bksM9vNxRC9t3btL0MhZOYpy0bTzESC3lwcCYvFEdelsmy08A3nBJFFDrZ
 sp2kVrRHgN3Rgl71vbNgjtcMJX_stOQbCo9aRfXbFtvKOuI.Jx8Djs4gyjcjOrlgqz4Kepnb7HMS
 I_hxE9u8zLPHf6GTNibEokGQ0fvGB5OVwSjoCYYcrQxeHd9xLb5qOCbearU69ZZNeH38DndQGOwu
 VsWXLZaifoezwc_GnuxiwbPzlRq2XBhNQrIy8CiKEQnKx0bGRpcstj6ERSdMDV5CDyKKXOZX3jtw
 2IYQUA08IdFbHz5i83jCT5WP9ZFtySHXWRo6xNQVNKCTCXiT6jV3uDuvnPwAeTX8JyHJ25AQa_Ul
 qU8Q8T3Rug4OZMm1qFTQFToK6kwtm0VOEGHpK_R3gZdV.s1y62RAJ6umKxbwxbOYFUtCJYnwmTkJ
 nPeXNfpDcp29CpjDriZRMiw.BDgoZSmo.5W7oXyX.jOcRlO2.R4cxwBfwuRZTJDcGrb9l0qn.HkE
 4i4QyflX3d9h615vafHb.vZzopPQKKZyVYQAmBmfSJiJad9WUkbK7fohQ.kCcmEIroCxfD5Lq_mJ
 mRWkS5gjRTr6y.tvth6FPX8QcDs1tYE.7VABHujfE5alRWdcufOYvS1OoCs7gXWhGzYKrOyIWGBI
 iGpN.eoec2lUhlIXMGKlsv.om_mK5mqXOedE02IsLpPFMnF1zlMalQ46yZPlVXSkjJ71KS_Gn0FB
 qnMPhU9gHEwCPWtQSwOVn0Jv8DNHCWNolSIFFRy8qj68gJhVDeyPi9Ioll3DCcmxZdCz6yyt6OS6
 8yct__MTbfPk_.BOsoK7Tu6qRaEpc4BcedqwRTr38qCxBht9TM3ffyg8DbZ9PO4pCVw19uXw6TjI
 ZR5kTVnH5YFwA5QMXwu0ERHfDbVR21kefN2ZZk2p_1bp4AZYMmdFwHGwp2KkeFum_x7eia6UWjtP
 lW4NnlCRIW8H2gGa8HrjIWxuu_sHYu4uZA52X22O.jSlFcmbeJPlYc_BcVSQwi3F5XPKbmofBu2i
 FqiE49.j2ynXAxtkmBCW3NKqbp8bx3bAMu.4eakE9TFtg0JC8MBUzVVwNvE2P7uo.2SyxT3PQIlN
 aFyGnW3fAMBvDryCpoFxR3Y4VL._NjYnTgtmDw43_CzVH6v6RZUxADtsakipfpD7pJq7n1OxkDTr
 smnv2B0NQUYvodgi_ztyXcRxM7FZt8s8Mw_dJ9zA.6wWqoH48MnVO2mQKaI4BR5ttub_9MoBcl7p
 GuPBVGsZtJ4GdzLupT4LoZbN3U3hqB133RW0U0Pn1hImt9fEfWSDk4TUl7gSD08kbiRqcoYvm6d2
 Ln7knS0VPEObV_lQhKeuJ4K.7OXaRvNWwe3TeqffLNNzUdMmnMIOzdRWaBsh0QjD2Uwu7QPHe1Qu
 DMpk3jfN0OmYwTT4GAq2KDCig.PMK5untvhEbyODUIQYXbQBUZxZTDWVdslVQSCluw.ZUOGnGfuI
 DK9UZqvfhzQ--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.ne1.yahoo.com with HTTP; Mon, 13 Dec 2021 23:41:48 +0000
Received: by kubenode545.mail-prod1.omega.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 11ae262dee001154213f3941f24256ad;
          Mon, 13 Dec 2021 23:41:45 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org
Subject: [PATCH v31 01/28] integrity: disassociate ima_filter_rule from security_audit_rule
Date:   Mon, 13 Dec 2021 15:40:07 -0800
Message-Id: <20211213234034.111891-2-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211213234034.111891-1-casey@schaufler-ca.com>
References: <20211213234034.111891-1-casey@schaufler-ca.com>
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
index bbf44a466832..71eac35bfa21 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -1917,6 +1917,32 @@ static inline void security_audit_rule_free(void *lsmrule)
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
index c88167a414b4..063c9cbbcea6 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2563,6 +2563,27 @@ int security_audit_rule_match(u32 secid, u32 field, u32 op, void *lsmrule)
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

