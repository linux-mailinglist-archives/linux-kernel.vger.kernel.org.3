Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FAF25457CA
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 01:04:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345841AbiFIXDy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 19:03:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345776AbiFIXDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 19:03:38 -0400
Received: from sonic302-28.consmr.mail.ne1.yahoo.com (sonic302-28.consmr.mail.ne1.yahoo.com [66.163.186.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E1B43A8A45
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 16:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1654815816; bh=0bV7T/9ldkAhMOTelwt9XbMX60qXgBixkPthPMvC7ss=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=GKwKOG4m7hqm2sSDSoR0t/aahDjncqgwD7oZ9+6Rx6Xmp6xGEdESQSQhyOT/Phu2o86B1kiR55Y/FZ7EUX/Kzw92wdC+hLeEZgex10f70bemdp91BE89tZwlJZjNED1O9usyIS0yqQ9h4x2rV4kM1ZSzLif/sIiWOg5gAZWNjE4OY3Eh3bUzrYU+ksI4SvK4y/jvoS6dIqN5ZmWvSvP9jsU+DfvMVXLgd6bBI6SFcX+aD2cSKwwp2UoupjPTaaW543VcepbOFneuhSGoW7LGlEIgfdHAAAAdWu7JyYYl0sz+KP6FtLR/FA8FxxYjWUrtX6F9ciaVzJh5uzD9fQbYBQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1654815816; bh=BuAemCjVXkniWAWbnRDsecxOQNY+HfqhbbKedg/0cTA=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=c48jZ92DkZhAT5qwLhNzxJSwAD/2FGKYEPRm/4BZlvtdbUX6PjWHhoG1Om414aAMMTMGwzUVR7xoOr81ha2yqoJaACrUT9O8eTOIwdUqh9v6BmPLBceiDdH9Da1eLWCThyRxBIXoc9+pSqj+0lBXF5/vmStFZfft/gLTzEgI6Ux+ZT0dG6IDRfTmy4EU8lRKlkrHrUIL128Boq+R12vJ8+2sM50VclHKtcH+Qw5Zlp5RJdi6eqw/zMZXi9STIsHNMfIV0vsSxRP9o92B0YSP8eXTbBIpv6m8jCQqY37Q2TcXSFJUtNjbjRD7cg1u8O7RWv8XXUaE17ZTb9E20zCESQ==
X-YMail-OSG: TLaVfnYVM1kBlYCyJQuCNTcHpjbT_KfAwKK1t8ecK_uhZadoyhzGWBxS7KlslSP
 bw7vRRSBSR4kN2eT6aylmGKrfYFztLODbMPrVFpoUC.i93CrDb_aGTVrTWjKyvYP.K6oLa5CHJpf
 xmGhfbEgZcY03knzRwf53YIqR9dlslZ0.yCZvLAdljT86LAcMJ4Mr7VGQbDCpZLGTcJG52HgPIeR
 bg.AIp.36bp3MJlCCJ5Ug9jU2DNNYKLsAq_biybxMXKuOp0OkUiQ8Aebp50mOSDS1X4psk5Vk.mR
 lW5do5.nJqId4B5j7JHPNUATDHl7E7ov95pJLJ3urUiHxqJxO4sbnmfoTPb0TzZm4EhXKvqOGS7g
 VkYyqc3zWMbo1JJwjrO4ixPy4q8mBSXq_6utiKxGu_1I0f8XUeFpfoaXJWnFAcoxjh.1ZtQAPX7z
 NJiHw6TRJGYxQR_rAG3dSd5INRDse7r1x7Nz3AtQuPKc6jmoAXUCNFUIbY87iFxc..V5.3ABYUkQ
 RihUBZEYqIpht5B_SzEColUJtA4Q8hYBaXJ__8wmHdFWhf7EGL6iEITMVioguGX68N1O7f6RVZsG
 3AG6xo6PZgr8HPDBWfLSeaiSQgUDga.NQKB7FaS6HOdiXmRWm1qJPVaW5eogr5U5rvDoE_OY.HfV
 rxtzzJrRUaWn0pAx2nHmBIXlL_vIACwJ0NJPvakFV7RESV6wZSBr86P0FPPoxgsZO3dAsWtgQNDq
 L.Ny6vu5.ba15z4J7xn3sxvT7Miuxf8Ndx9mjsGd6VteuLahJPFnvtJpmS.jMXpj1mOV0bAVEOoO
 06izEoP8ZENFXVujGrkeNIxwRf5znkHEDo_Z9CK0itA5J2ELUfFXD.pi9gjp.SJovE2mX_aem39W
 K1Zif.kAM3VYko3nAxJ_BfW9fLk5eiTE1_1VHhn116OUr6Vsrp1aJtKsHhVZSXkwKdu10FbdxeOv
 UK.PEm8dGU59KtgHdma_NgkwTvT_FksfEd2hxwR8LJZlEFk8sNGu4wNlYpojxhOldagqqjVPb7pF
 LbNJPr4jZ1aqploqtWOZ.K4U5a8t3ueaaP_QRY1c.1Bsl_jXcHo03HYrGHoys1YozWRnjvn7TlkQ
 XipJUPKPZu6xcMfZ4aiB2gaN6uVE2BLDvQtW03HocKSt5GKw4ku5ubcBGgnbZ_Djo18cjqWN2LHG
 WwmhNM2zjXgIkuoFErifS8v7X24L_CWy0UsohSHWY7ybIDlsQY._CpK0YF_oa0dNiVvzIWvVPJ0l
 CbZdiQ4XNaoYrYDbqALBmnb7Op1WjPxS_MCJ_RfBVqh_xBi4CHp3nElzmUdMU1fG__NF9K7iqyje
 okSqMwhwF4zWL42YI2wbom4geO0t5TTbm6E3uA1XeSBerf51hm.T4.96nhvXuBoHzldU0MpT3LJx
 cj47dxp2SH2SUgth4eQHhlyTO8.wxpc5RAwUb7egS8Q_CH3CDN1Fc98aPXbUD84vTOR3NJH7S2EQ
 jgToZt9FahsRN4MPVowzOk9jfUnyql5DOo1a.QmcVIoNkmxt9iNhNbe2q8r28ypiTVZPRJLQtfRR
 zV3dRexV4nt9lCKYBSWckz0DxTMrl87S9BJmFY3NJGyug6q4QZ.KP2iDNLx1_mGgZ6l3QKFqMRNa
 vGsaNiskaAZye0863KVDt0tHUUAty28Di6HdSkUQUCUbCYN6WWnMYBU6C5e2ebJSwTCdko.cH4LQ
 EuyGaf7ILmDrEX_HjEKtqpcUyDGYqv6xYDCUTE3xZ5NPPYQbihsdMrG18YLOjTj9aEGVoY4ZmIFO
 19mCjP3eZI5FBPwSKHkgz95JQbDlG30sN8tf78Y_o6pcDsbftdm4kyH13qZeW2hgdBDVTlOAxcJK
 fXIJcoJ1emVJZGIHu3u8Ma66O5JK8GDZNQC9vamfv1CHUyYkR19lIiC.7wfMJ6rAQgB9VlBtL_Os
 CG3r3estA_4rjHaQoiabK8iE95h1mBflI3etNpFDzD2mbQb6RoOfa5Q74aJnX9FSi.rPFVIqfT3m
 lWZ1Sebr5N.I3j9Z9uoJlR1sGDoF.1FqWr4jMRjbAkFZ0Zg5omD1QVjV2Gty9G2B8zDKBF8Ku8fl
 DBQ.dKnU6vy45TVoxBIpxJHkuOoI.aR4BFtMXwrmBy1H2sdiZv4i8eEJI_678D5nfCVWyZCK4JOT
 x_gtYHf.Oo.y2JkBT5ALekcfiFGrQy436eeR3BBkJ_OiILIe3H3ftxBTTpnX11XQlsyGOwCYcviO
 GP9MeWEI3QbUa1lnv0XT_Qjkxuag2YswNSrwbPM3zVc01QsiZZzNPATv6ljO9Dr7WhDYRK7SO30y
 Wzz1erwkvOTGtdT2QGwg0lXiG
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.ne1.yahoo.com with HTTP; Thu, 9 Jun 2022 23:03:36 +0000
Received: by hermes--canary-production-gq1-54945cc758-szwwf (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID a765eeab66d702832e1d09e1945c0ee1;
          Thu, 09 Jun 2022 23:03:31 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH v36 05/33] IMA: avoid label collisions with stacked LSMs
Date:   Thu,  9 Jun 2022 16:01:18 -0700
Message-Id: <20220609230146.319210-6-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220609230146.319210-1-casey@schaufler-ca.com>
References: <20220609230146.319210-1-casey@schaufler-ca.com>
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

Integrity measurement may filter on security module information
and needs to be clear in the case of multiple active security
modules which applies. Provide a boot option ima_rules_lsm= to
allow the user to specify an active security module to apply
filters to. If not specified, use the first registered module
that supports the audit_rule_match() LSM hook. Allow the user
to specify in the IMA policy an lsm= option to specify the
security module to use for a particular rule.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
To: Mimi Zohar <zohar@linux.ibm.com>
To: linux-integrity@vger.kernel.org
---
 Documentation/ABI/testing/ima_policy |  8 +++-
 include/linux/security.h             | 14 +++---
 security/integrity/ima/ima_policy.c  | 70 +++++++++++++++++++++++++---
 security/security.c                  | 35 +++++++++++---
 4 files changed, 108 insertions(+), 19 deletions(-)

diff --git a/Documentation/ABI/testing/ima_policy b/Documentation/ABI/testing/ima_policy
index db17fc8a0c9f..bac75acc24ba 100644
--- a/Documentation/ABI/testing/ima_policy
+++ b/Documentation/ABI/testing/ima_policy
@@ -26,7 +26,7 @@ Description:
 				[uid=] [euid=] [gid=] [egid=]
 				[fowner=] [fgroup=]]
 			lsm:	[[subj_user=] [subj_role=] [subj_type=]
-				 [obj_user=] [obj_role=] [obj_type=]]
+				 [obj_user=] [obj_role=] [obj_type=] [lsm=]]
 			option:	[digest_type=] [template=] [permit_directio]
 				[appraise_type=] [appraise_flag=]
 				[appraise_algos=] [keyrings=]
@@ -138,6 +138,12 @@ Description:
 
 			measure subj_user=_ func=FILE_CHECK mask=MAY_READ
 
+		It is possible to explicitly specify which security
+		module a rule applies to using lsm=.  If the security
+		module specified is not active on the system the rule
+		will be rejected.  If lsm= is not specified the first
+		security module registered on the system will be assumed.
+
 		Example of measure rules using alternate PCRs::
 
 			measure func=KEXEC_KERNEL_CHECK pcr=4
diff --git a/include/linux/security.h b/include/linux/security.h
index 5b7a21237fea..5b0b2a596cee 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -1987,25 +1987,27 @@ static inline void security_audit_rule_free(struct audit_lsm_rules *lsmrules)
 #endif /* CONFIG_AUDIT */
 
 #if defined(CONFIG_IMA_LSM_RULES) && defined(CONFIG_SECURITY)
-int ima_filter_rule_init(u32 field, u32 op, char *rulestr, void **lsmrule);
-int ima_filter_rule_match(u32 secid, u32 field, u32 op, void *lsmrule);
-void ima_filter_rule_free(void *lsmrule);
+int ima_filter_rule_init(u32 field, u32 op, char *rulestr, void **lsmrule,
+			 int lsmslot);
+int ima_filter_rule_match(u32 secid, u32 field, u32 op, void *lsmrule,
+			  int lsmslot);
+void ima_filter_rule_free(void *lsmrule, int lsmslot);
 
 #else
 
 static inline int ima_filter_rule_init(u32 field, u32 op, char *rulestr,
-					   void **lsmrule)
+				       void **lsmrule, int lsmslot)
 {
 	return 0;
 }
 
 static inline int ima_filter_rule_match(u32 secid, u32 field, u32 op,
-					    void *lsmrule)
+					void *lsmrule, int lsmslot)
 {
 	return 0;
 }
 
-static inline void ima_filter_rule_free(void *lsmrule)
+static inline void ima_filter_rule_free(void *lsmrule, int lsmslot)
 { }
 
 #endif /* defined(CONFIG_IMA_LSM_RULES) && defined(CONFIG_SECURITY) */
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 73917413365b..b04733a5d066 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -93,6 +93,8 @@ struct ima_rule_entry {
 		void *rule;	/* LSM file metadata specific */
 		char *args_p;	/* audit value */
 		int type;	/* audit type */
+		int rules_lsm;	/* which LSM rule applies to */
+		bool lsm_specific;	/* true if lsm is specified */
 	} lsm[MAX_LSM_RULES];
 	char *fsname;
 	struct ima_rule_opt_list *keyrings; /* Measure keys added to these keyrings */
@@ -285,6 +287,30 @@ static int __init default_appraise_policy_setup(char *str)
 }
 __setup("ima_appraise_tcb", default_appraise_policy_setup);
 
+static int default_rules_lsm __ro_after_init = LSMBLOB_INVALID;
+
+static int __init ima_rules_lsm_init(char *str)
+{
+	const char *oldstr;
+	int newdrl;
+
+	newdrl = lsm_name_to_slot(str);
+	if (newdrl >= 0) {
+		default_rules_lsm = newdrl;
+		return 1;
+	}
+
+	oldstr = lsm_slot_to_name(default_rules_lsm);
+	if (oldstr) {
+		pr_err("default ima rule lsm \"%s\" not registered, continue using \"%s\"",
+		str, oldstr);
+		return 1;
+	}
+
+	return 1;
+}
+__setup("ima_rules_lsm=", ima_rules_lsm_init);
+
 static struct ima_rule_opt_list *ima_alloc_rule_opt_list(const substring_t *src)
 {
 	struct ima_rule_opt_list *opt_list;
@@ -356,7 +382,8 @@ static void ima_lsm_free_rule(struct ima_rule_entry *entry)
 	int i;
 
 	for (i = 0; i < MAX_LSM_RULES; i++) {
-		ima_filter_rule_free(entry->lsm[i].rule);
+		ima_filter_rule_free(entry->lsm[i].rule,
+				     entry->lsm[i].rules_lsm);
 		kfree(entry->lsm[i].args_p);
 	}
 }
@@ -407,7 +434,8 @@ static struct ima_rule_entry *ima_lsm_copy_rule(struct ima_rule_entry *entry)
 
 		ima_filter_rule_init(nentry->lsm[i].type, Audit_equal,
 				     nentry->lsm[i].args_p,
-				     &nentry->lsm[i].rule);
+				     &nentry->lsm[i].rule,
+				     entry->lsm[i].rules_lsm);
 		if (!nentry->lsm[i].rule)
 			pr_warn("rule for LSM \'%s\' is undefined\n",
 				nentry->lsm[i].args_p);
@@ -623,14 +651,16 @@ static bool ima_match_rules(struct ima_rule_entry *rule,
 			security_inode_getsecid(inode, &osid);
 			rc = ima_filter_rule_match(osid, rule->lsm[i].type,
 						   Audit_equal,
-						   rule->lsm[i].rule);
+						   rule->lsm[i].rule,
+						   rule->lsm[i].rules_lsm);
 			break;
 		case LSM_SUBJ_USER:
 		case LSM_SUBJ_ROLE:
 		case LSM_SUBJ_TYPE:
 			rc = ima_filter_rule_match(secid, rule->lsm[i].type,
 						   Audit_equal,
-						   rule->lsm[i].rule);
+						   rule->lsm[i].rule,
+						   rule->lsm[i].rules_lsm);
 			break;
 		default:
 			break;
@@ -1026,7 +1056,7 @@ enum policy_opt {
 	Opt_digest_type,
 	Opt_appraise_type, Opt_appraise_flag, Opt_appraise_algos,
 	Opt_permit_directio, Opt_pcr, Opt_template, Opt_keyrings,
-	Opt_label, Opt_err
+	Opt_lsm, Opt_label, Opt_err
 };
 
 static const match_table_t policy_tokens = {
@@ -1074,6 +1104,7 @@ static const match_table_t policy_tokens = {
 	{Opt_pcr, "pcr=%s"},
 	{Opt_template, "template=%s"},
 	{Opt_keyrings, "keyrings=%s"},
+	{Opt_lsm, "lsm=%s"},
 	{Opt_label, "label=%s"},
 	{Opt_err, NULL}
 };
@@ -1093,7 +1124,8 @@ static int ima_lsm_rule_init(struct ima_rule_entry *entry,
 	entry->lsm[lsm_rule].type = audit_type;
 	result = ima_filter_rule_init(entry->lsm[lsm_rule].type, Audit_equal,
 				      entry->lsm[lsm_rule].args_p,
-				      &entry->lsm[lsm_rule].rule);
+				      &entry->lsm[lsm_rule].rule,
+				      entry->lsm[lsm_rule].rules_lsm);
 	if (!entry->lsm[lsm_rule].rule) {
 		pr_warn("rule for LSM \'%s\' is undefined\n",
 			entry->lsm[lsm_rule].args_p);
@@ -1833,6 +1865,23 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 						 &(template_desc->num_fields));
 			entry->template = template_desc;
 			break;
+		case Opt_lsm: {
+			int i;
+
+			result = lsm_name_to_slot(args[0].from);
+			if (result < 0) {
+				for (i = 0; i < MAX_LSM_RULES; i++)
+					entry->lsm[i].args_p = NULL;
+				result = -EINVAL;
+				break;
+			}
+			for (i = 0; i < MAX_LSM_RULES; i++) {
+				entry->lsm[i].rules_lsm = result;
+				entry->lsm[i].lsm_specific = true;
+			}
+			result = 0;
+			break;
+			}
 		case Opt_err:
 			ima_log_string(ab, "UNKNOWN", p);
 			result = -EINVAL;
@@ -1878,6 +1927,7 @@ ssize_t ima_parse_add_rule(char *rule)
 	struct ima_rule_entry *entry;
 	ssize_t result, len;
 	int audit_info = 0;
+	int i;
 
 	p = strsep(&rule, "\n");
 	len = strlen(p) + 1;
@@ -1895,6 +1945,11 @@ ssize_t ima_parse_add_rule(char *rule)
 
 	INIT_LIST_HEAD(&entry->list);
 
+	for (i = 0; i < MAX_LSM_RULES; i++) {
+		entry->lsm[i].rules_lsm = default_rules_lsm;
+		entry->lsm[i].lsm_specific = false;
+	}
+
 	result = ima_parse_rule(p, entry);
 	if (result) {
 		ima_free_rule(entry);
@@ -2205,6 +2260,9 @@ int ima_policy_show(struct seq_file *m, void *v)
 					   entry->lsm[i].args_p);
 				break;
 			}
+			if (entry->lsm[i].lsm_specific)
+				seq_printf(m, pt(Opt_lsm),
+				    lsm_slot_to_name(entry->lsm[i].rules_lsm));
 			seq_puts(m, " ");
 		}
 	}
diff --git a/security/security.c b/security/security.c
index 37c14572501e..141922732d10 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2722,19 +2722,42 @@ int security_audit_rule_match(u32 secid, u32 field, u32 op,
  * The integrity subsystem uses the same hooks as
  * the audit subsystem.
  */
-int ima_filter_rule_init(u32 field, u32 op, char *rulestr, void **lsmrule)
+int ima_filter_rule_init(u32 field, u32 op, char *rulestr, void **lsmrule,
+			 int lsmslot)
 {
-	return call_int_hook(audit_rule_init, 0, field, op, rulestr, lsmrule);
+	struct security_hook_list *hp;
+
+	hlist_for_each_entry(hp, &security_hook_heads.audit_rule_init, list)
+		if (hp->lsmid->slot == lsmslot)
+			return hp->hook.audit_rule_init(field, op, rulestr,
+							lsmrule);
+
+	return 0;
 }
 
-void ima_filter_rule_free(void *lsmrule)
+void ima_filter_rule_free(void *lsmrule, int lsmslot)
 {
-	call_void_hook(audit_rule_free, lsmrule);
+	struct security_hook_list *hp;
+
+	hlist_for_each_entry(hp, &security_hook_heads.audit_rule_free, list) {
+		if (hp->lsmid->slot == lsmslot) {
+			hp->hook.audit_rule_free(lsmrule);
+			return;
+		}
+	}
 }
 
-int ima_filter_rule_match(u32 secid, u32 field, u32 op, void *lsmrule)
+int ima_filter_rule_match(u32 secid, u32 field, u32 op, void *lsmrule,
+			  int lsmslot)
 {
-	return call_int_hook(audit_rule_match, 0, secid, field, op, lsmrule);
+	struct security_hook_list *hp;
+
+	hlist_for_each_entry(hp, &security_hook_heads.audit_rule_match, list)
+		if (hp->lsmid->slot == lsmslot)
+			return hp->hook.audit_rule_match(secid, field, op,
+							 lsmrule);
+
+	return 0;
 }
 #endif /* CONFIG_IMA_LSM_RULES */
 
-- 
2.35.1

