Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E1A8505B35
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 17:36:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343839AbiDRPih (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 11:38:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345721AbiDRPhm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 11:37:42 -0400
Received: from sonic317-38.consmr.mail.ne1.yahoo.com (sonic317-38.consmr.mail.ne1.yahoo.com [66.163.184.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 690952ED7A
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 07:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1650293995; bh=FrtnF1QWnv6CNa0v+rzlMUyWifYNw9jrxv4OBi8+iac=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=rbZpu+alTOAoJI+wtr/Drkh28JEaLsFKAcYENIaLwRByGDg8SdFbJZtV31wjVH04mAi9ki4zPfsWlYJGWngb108gT/hK1cchTwTP+L+zP8tzkv0gFFSo6A9CEJyM6Uh7VHWvKS+6ZTE/xA+gWZxddeV3Xfxp0k3sXM118Wj8FgIha0W0XGtC3xvg1l+hMbfbQPPUAUuTBcw4JUCL9a/c1s1dKjPyRLe/+97WXJRPL2UWUJA8NZ5W3sJ5FVujOCdkuy0pFrhZpoItcaNWPJV99vWRM7Q18HqfrqtLpd2BMUr5ZI+di4mNMgAXr+XWdg4XLy4aqS69GNtqIImUIvixew==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1650293995; bh=usxWUtk/jJY1mCgLR9XfM/0RpveDKeL3gru/pqE/ETg=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=pmQwuG5oFq0PrpDuczON/ajDchMtB0SjL4T3JLXzeQ5RvOvOGSqvoYCuuVkZhwp+B71XW7KuHUCVzntZL3nxYWiC5JyHTZuMxeuABHn5PUhgKdpeLaDkUlj5ATjY2M/rNCAtsrRVvseoGE7pSschNI/Li60NYFghNdSCr7duXyeoaXfip9ye6tngauyxZ5QrUc6TUd01Q0anOoS0dzcwis3eKCNgs0hcKqXGmaKbcYiwPxGeRVdL1AOQFLWgzoFq1Yq0nubwdVoIDZLF6bhQvEbvLRJzISVak5xqOBd7xfzyBNpNfdfT+mRl+433Y2dNfMwq++CqfxkiMX3+56NkCA==
X-YMail-OSG: JqkFVOEVM1luVx8VCja4JyF.fqBRXx0SRYooL26Bm4esqTjB268wcbdW.G5hyjG
 OHmJqTCHudTVPxGT2mW4shIUDu85O_dGEy99JZDJgQCPQoqsTrE3jzd6bJ2x6b_3D8wqU26QH273
 mik87FsNNg4psNN53bv26ME8a_8_MzEcGsACgzryWyKlH3lzZJ1CCoBlRialYJJAOFZ2HLjnTLUL
 MVCecfNpwoYmTE8eipLG5YLYK2khmy__85NFnwxQrwIYUHfZ_SqjhFP4cABxqsxtMlLtM74KcLR6
 YZSeuxJ361g708yOCJHZbLTps9V3tknVtNPmUdIxfZkbPGXV_su2zvWidGcb8_zbL5TFGUFQXhUr
 InoyV2ISiK4_LyA8ZqulmbzC1W3W6nQzcmAufkSBQO4MC4bNGC3mxl6eRH5PCDwMHG8JpG51eNui
 H7Q4lS5TFH0EWVSQr4oNIL7OQ9KRBvpoHuLdddYJ_KhcoyjcQ3WofvXwirgxUUdT7u46pMVMAETU
 fVMxq_nSjhtKzCPYneXuxRzwJ_psR_ddnkqjdvmwsletF_9wWFmsapqBDpiz4Ek7prLQrRud70GV
 4W4mwVyN3xKqeOy7k7F_nlyPJQTdnH5OLdKRwetq0V4zYrH2v5T_mh4ij2Akqs0cd3Y47zM1NKPK
 i3QIoBI71aP8YPf4.QLw.JmhKqh73ao6GOotC5nR4I8ShqeNonGHifmvQxWYvzC4odWihJD3OMQA
 J8weal.WnYL.nqw1rzTRycUHsgxyzgUlkhrfhSiw7yxc1AJJTsEZhJgZfFkCxL9DAC6n1zgPKcWF
 _CM6BUACTDXqq9UujFa14MAbzsXfi3c0wskJ.ZvHegZ_alCOrDjZ.LeNiJGFBO6sFf4fU94aq1Dq
 G.pTAY40jGU3TXZ33_i9bPuP53mxEnBACjv5.gTeOylaErgQ7TJaW8d6ocwVsFLuO4rUD0Qr4sBm
 Y3pc2BGOnu4qMqfX_FJfzDcdFxZ7mpnfYwqVd_lbV76Rh3zF9w_POE75S5xxm69x9ac1HJbolYCb
 L1ISt_pVtIvNaFGcosYcjMEhh3p.5Kdq5Vl2lnZ8zfofeecS2wCkHiHFEFjojqsOxH6LTgZQPcll
 wtrEjORTURYfs0fnZBJ.dHT4snVZn8nIOmMbwVoLrldelF1xELkSSycMQfiP2nigF6Aa8Bpt8AMH
 NweXc5ep6LmTq7WpC52TaKngU0MTsZnEHvulrbLcsgReMB0FsebHfOqfL9CUmoRv8mUvtplOiy7X
 ZO02PdCPvkVX0WvkIE1Ln.F7SokT3JyPf68uuz.HIXMuiqm39w5CxAZjlSTmcx2bfwe.XSCyt_y2
 OzHStG1tnDNRoX0R0wbSEo7.xxtd2wiV_UvdjdEtxnezJZxzRwTlh_sxy.fg_pO0wDrLbpnhWZ2K
 BDMZuEMlpc2YUF7vuIPkymBoR5kPpf96DUKd7BpHEFXZ3ASmsbxXI.WKUzgXwmpzZUjhG6Y3aCMV
 dPqtD9FxgDIQnrEH3NIMnEa_ERTlnOQJ0xvuTAF0WyaBLnOM2.GCIl7KkmXvHIVC_UVWO15Kgs7R
 .iT3VA47W_iPwHrGq95Lrct2hy8Xx5XkHbkMRsCoO6ab5s_xSiVHJ3szkkL2R_YvDd24Jk7bplIw
 gsowuC1Aoy.7JYpOzhh3LddL9atI_Zeo9iz0X4Pe4DvwtVeIH.y7YGLKFyRElURzi3zurl6lGaF4
 Joc0ANFC3JL6_PaD_AwU8MC8_IrZBBER_ucGEsatbcKbzVl098bsCCpIkaUnrrcBV5mbXqqRoDTj
 TMDvYdPf6hk_HCmhudLDPqVUbH6Dvy2fHrH07bjZWGmCFonWAUt5UCY9jBH_NhyRHFcVS2aMGQyk
 Ch_7NpsagYGXHH4QJOiXCV.GuPPLlHmXB.7SWBwk3y2BhYeGNu7y3PowFM5zSjKBrs9C98cS9.tk
 BQGCnwAq8fkLxRRzGDUFBwIvoVn9sDxlJYhGHeb1FepOax824lfxyJn6_JyJ67Xe2JZUqPBRa47b
 1T7MmElJP9zxu9KlIihh4S1ZvrafRJ.W7yovTv7v2ysH3ZA4C4HaWA1.c0ORJ_DOnOe9ZsDrimIZ
 co_XNhDTH1kKhP6vCIogKM391zaVaiRkqaXbZGg96ozvtOs6cNEohePqOirsUDGMK810GlzDunGp
 CfRqMmrjC.vT6uNEupQ.hC1b8__1JGV4asDaKsdktD546nEK0wJRmrn0mSiCQ5Si27L.Xxs0pVwB
 ZfKmH91wDcJcTnuwyUcaXLTaBgBbyYensZwRKbmFRAofzEYH9VAXm17A82TVbDhxk5lZ3ZfOZ5Pq
 op1L9ghU5l7ROqT1eZjKoq3MuFqEoN.YwQOM7TfL6_beOtwrH
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Mon, 18 Apr 2022 14:59:55 +0000
Received: by hermes--canary-production-ne1-c7c4f6977-8bhqd (VZM Hermes SMTP Server) with ESMTPA ID b46a1ec8e23e86c6d7b566815ebdad73;
          Mon, 18 Apr 2022 14:59:51 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH v35 01/29] integrity: disassociate ima_filter_rule from security_audit_rule
Date:   Mon, 18 Apr 2022 07:59:17 -0700
Message-Id: <20220418145945.38797-2-casey@schaufler-ca.com>
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

Create real functions for the ima_filter_rule interfaces.
These replace #defines that obscure the reuse of audit
interfaces. The new fuctions are put in security.c because
they use security module registered hooks that we don't
want exported.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Acked-by: Paul Moore <paul@paul-moore.com>
---
 include/linux/security.h     | 24 ++++++++++++++++++++++++
 security/integrity/ima/ima.h | 26 --------------------------
 security/security.c          | 21 +++++++++++++++++++++
 3 files changed, 45 insertions(+), 26 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index 25b3ef71f495..2986342dad41 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -1917,6 +1917,30 @@ static inline void security_audit_rule_free(void *lsmrule)
 #endif /* CONFIG_SECURITY */
 #endif /* CONFIG_AUDIT */
 
+#if defined(CONFIG_IMA_LSM_RULES) && defined(CONFIG_SECURITY)
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
+#endif /* defined(CONFIG_IMA_LSM_RULES) && defined(CONFIG_SECURITY) */
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

