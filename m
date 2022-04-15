Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FB985030EA
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 01:09:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353683AbiDOVVK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 17:21:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343825AbiDOVUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 17:20:43 -0400
Received: from sonic317-39.consmr.mail.ne1.yahoo.com (sonic317-39.consmr.mail.ne1.yahoo.com [66.163.184.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC733DFD71
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 14:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1650057491; bh=3d387zZWuQIpaibCYSztCqIgpNlthrLh1n5KR0d6lpU=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=h1HUFBUrugmpdMNfCmIcRWdOkho+aPrmPKN5zKL6JaOA4AKtd0dwTSY8/WLJ0PaCtYNi45ctOJfrA707UfX1kwmHF6fVMMppgd2h/PAM4HeiJQoeTFYwoAVUktl5wcF2C+JAQqOEKVhT04NsxuuGg+16J863kO+XtjwnnZHJsqAepM7+RAg4pxUnMrcB5/7gGOM+BzPEOHgluX43Sd1PDN9yMS1bq/qgo7ExrdDbL6cj4cchB8s9txja44GXwKmRPuhWTeXhfB+KepQ2692vqH7xjb2YyfIpnf2Nf7oPdBpgRsqp9T/fSIH4J97N0p32yx+VlT+6ooQ3ldJiFnfSuQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1650057491; bh=5yuzBBopTxgxVA/S+xOI+CDihrC/1+itRwFH5erHQNv=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=FoT8P7PixEfY/2wawb5GobF0rXab5d8Lz3C2S6cluZkcMQg7hDoVtsOdEWQFUulBk6Ib6wHrO+bwxL0V7/KdmNikh4C7siP0uUP2c5bss16GYU+JbMRZ/5Zc3OfxbVasDHILFMka5SjK68qAC1g/yzxiJ91QcBBt8t5yC2n9bkQE1TOBwsMic4hAfVcM/CExV5alK+AGw40y6R71W0LmYdSqrFA8tXv5qjggtV489GePK5QVQT26yZpgA5rAFeJrVpfk8flNg9AYa5A1/Bd0Gh/RvREHqXfdzec+14qh/89MXVA26MqBBbyT73GEmfmKdk8nCiMOE1gXXe7IexuHGg==
X-YMail-OSG: UYuGB08VM1mU3_Qi1yenykNzOGtFFSgRCf6PX0n6fmvL2mLH2XW6TK6Lc1sgCTB
 v5G27lc1vgk9ylOHKZIAZKmq3Rrqf97y8Wsn1VtmOzWh8.iDM3C55bl40L3TEPOBMKB51z1f8DNs
 yrE5RWG8VdFs5_CyNgE1H4LSDXH1apsrMGqSLK1ftB.J8IQD1ndc1PiZ0T8cectYpFjlfPFdxEGF
 jUCQtRERLUcSUG8.JnletKTWScK6gNEA4jPFKTxIcwPnSNOMJ4U5g9qEiseQH2Mvu6YUPbieUzEI
 J3Q7Uh44n81pIRRAzDfI4csjVsyCQPOwo3BALJINkLjwkTGyoQh8dGf9X3S5i55HDyu._dvP2aPu
 7y68v8v8LBnts4oAsuLZFjgK3cnwXLFA5ECA40Ys5W1nJ6rI_yVdHYFD4wWnf595qmQlz7ESrwd7
 jpWb4jcKyYl96W1n2UXY8IyYPjV0w8wXVVIgW3i2o9UMBJSaE5vCgmsEFmTkAHLRT8avlPMYlgMo
 uUS51rzUlVkmvPCQ83Y0W7m6wPc76U8y3AC6ghBok_uZotpNR2Cq6ypUV6l8a7d_GD7HfHYGKQSc
 qq9YMHAy3OM1rs5FadvfEPrA7G5UC.VEBLiHT989wohgVragHDCh7pcXqayoZWwoS6801lVw0Ujc
 h0aCOLgjXm40pK_asSsRzSzF_rcG5C3PMyl9fghvgvglWcYeXsYMKixEUDQokD8m1qKH7goqIUOa
 Gpu7YamrtoaRu.RyJjjNycJ5zW700GabXuqi9sxqpzWHVUpueNndDpJmRYl47n8MZQsWTv4RRxu3
 LS0lYCX_29x73gWQ3E4yrQEPFFyaNUT3GkEt2SJej40v7TbTyCbk59h8Uzh9Ybbzwdcgc_uBufcO
 dodxo.J8x.IcgFg0IQhGh4RCAV92nk1EW6bGypCwxTFvnNWZ00GMBdHcyP.MwuZ.PCoemktGwtO5
 U.mpYuCrYKq4txerD4GBAvrX1k7xTIch.DDrQjdCYcxItXM6LtQ28RXVuVqoHxWqSwtKsIob6X2A
 K3YxqbneHgVe.jONxcAGK6dR39dwq_nRV5aUJviBfI.gZSnrl3ZJcPKs7j84138RKzWu2mmEDTl6
 cZUXhDiHAu9p65812QO28nk8w4DrcLudUU55iZg._p.86wFkeTDpOR5Ns12W9emTSSNmljoyfRWE
 PETV_oFj8blihBTvGyYnmFBCDmqw6sC9u4TOHlTGtgLDWckEzU3M712xxk49mxx9zJyLTlGekp3J
 TDyGs_Kb928qEp0kUrh9iFIsfjM_joJ8sujl.dRDJpZAgufCRMg8GYwh_NTGbSqQeBcbawmKhKEa
 C8Pz_gXTlaUDTT.whd0h5OoYR9NmPFlOaSe6..AMoKVxHaFYWu2C.r2xuzqIQ8RcoZCcZ.hb15ES
 lPcNnbb3RXWM_QOegAtObuB1DA1ZLVrzG4.mP2oTpmDj5huBX17bg30rb3w5ac9lvTYGgs3_ACXv
 SnmhJ6aYVTn3liMKz8M.RIVDPxvsjPWtbk4A0U_eD2lQVfSyY_J6wQNOCaBmVMgbmRWdG59mQrtt
 MxAIxigojBugyRyLpoKD2oZ1J9znaH.WzHggd1ZuxN1nBgY1K5QkyYd61XAwoyLMDxYX50scSyZg
 QsnQIDGWEoVr1nWEpSkaj9Iwh9y79vXYSnGpazxabxskW7H0jlNIL7ZeP9Kvof5kuZrEb87ckJvg
 UWy5_nPCh5Rk2ZfoTWMHcPKtnQepeg_x.5FYy98BLVqAoY2JMBBkKTDYe5HpaNv2bqnYmPEszyRq
 QMyDMQ.nXoEWYFBRvjwDro_ErJWGbI1rRNyF4BeY8aNdCGaN0hkHhkRCFkgra9zvPptyJgnL0_eY
 t00dXSQQB8p__chTnT2sjFsMZyBKvpUntf7eN7g5hYFPYP6aBxLuL4twAE4eBTQOmKaZMg.UavZl
 bITmuie2ynTs8chjoN8Es1s1k2SxBZ8I6VM.rH3cws8Pdmvd8_uCUEEyjX8AFMfxAd0WtKMEvapF
 a3.K2GgOg16ahM8.vsMEiZLSm9COgNgX6KwUFDMWj6crpRWnRurGJRVXsLqjEjWvlGvC7NOEzw1Q
 LaW1Cbc8kY56Gkij6hSEHSAkpQiGzQ8JVgyE0sGeNvIC5.QZ3hemXwgN0kZDz6znG_lcATx3YYha
 XO9v04R7n7ceh_Wxb0EFiZhmGQs5756DIvC3YKgUbGup4KJV7eRzi.4u25wrKz2GCFLFXKHNWOkc
 VIuP3qURHibWC6uUyDvrGqrHJgowtBeqUOKOtC_HC65VV3W3oQb_zZD04IuyhqIN3xRs-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Fri, 15 Apr 2022 21:18:11 +0000
Received: by hermes--canary-production-bf1-5f49dbcd6-kfv8t (VZM Hermes SMTP Server) with ESMTPA ID 9074a7c5ad18ae5c2c9c9c9b95ef7563;
          Fri, 15 Apr 2022 21:18:09 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH v34 01/29] integrity: disassociate ima_filter_rule from security_audit_rule
Date:   Fri, 15 Apr 2022 14:17:33 -0700
Message-Id: <20220415211801.12667-2-casey@schaufler-ca.com>
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
index 25b3ef71f495..1e94c55e8e32 100644
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
index b7cf5cbfdc67..22543fdb6041 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2586,6 +2586,27 @@ int security_audit_rule_match(u32 secid, u32 field, u32 op, void *lsmrule)
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
2.35.1

