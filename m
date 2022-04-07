Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E47394F8988
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 00:14:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231435AbiDGV0n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 17:26:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231292AbiDGV0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 17:26:35 -0400
Received: from sonic310-30.consmr.mail.ne1.yahoo.com (sonic310-30.consmr.mail.ne1.yahoo.com [66.163.186.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85FE7194FFF
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 14:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1649366668; bh=5kt1Liqo/7tCS1co2DHvQ93kIKnE4GkkPhAw1DSEGfQ=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=YHRW4Eo4dnTCsSFjEov26Z41vMyhrW4dpDvWHHlN9c6uS57V1V4Ui/EFPVqszjlPRWQQPtePkKqyt/BkOd+b3fSb8nkyhBL9nS53IjJEKsnV9T4mEOKDqVq5Aodfyks+EKvwg2LKJxH9FPBmMII3Am8b39mCC5fgrOM3EEL1Q/XNuNZiuOsABNkZ/ak95we9Sz4mP3Ctrz9YtxNMw8JQex5cnKwTW6Q3C0SP3qh0yGU3CBmHqx/+B/kHiCXa9bYheqEm1s/d/N1hi8JbY8ad53GUMHWOd8ckIdDFdYcfQDirLnaHnkoLbK1WsOZCPo6v4xdRk02YDZ4qXzi9ZMfb/g==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1649366668; bh=Y/5ZRLO3CBe4wWVFv+UYLo24Nge9yD3TrhDAtyc88iz=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=GCFAPPY/YVut0gizRlCI2q2RVfDBrxrR32zfUohAXWHhl5c3gKVZYl7slb3oOqOFr8qzJNtdW6dssJK6S+qKu/ZrxwSmjP7ay+ax7zPfL2+6nPfm4oOHSKJYvk4G3ac2fQps2dDfBmA0bRKKp1g84uUpMONda5Wb9iROtjWFLF6yvuip0ofQeRJA4Z+P7hI5ErKfQN6NZPr3WzNZx1V5+cxnJBgpeTGsm9/EryRFi708RtPbt4PQoUO9QKA+i0NsW3HAmhFco2jnfyGSTQUA/epc6tSTNXUD7D5xqFyx4BWiComZMWxr8FOyTLOtzEOZiptyUNFWTVyNKNwPVE4QsA==
X-YMail-OSG: U4QFjbIVM1lgtUDRB4xTInYJ7diKM03.Ty_3NL.vSFr7LsTl5F0B4BqFNdMPzeU
 qppaf6e9CHMvZ8J7qPxbWMniLgg5G4U36q.drvtxbhhTfEO59nTXxLCmX1h1NbPfjS0_wdw9DP67
 d9pNCMA1RKtj2WywmhByjvjMDwNYWSC67qvnshfQyHuX60gnJC6sMLjxt53YgJyCyry4CRIVnJ6b
 Ce0WMx0I5hupPvLqUeClZVzL5b3pht8jUtm2BDg.pbHRrkTXy01kF5o_ogsYwqjBe86bjRSB822Q
 oDy0bMvxe768OgftXXNXORARVLqrHGU4xZLfQb56S3DCM6rZgY51fXwk.77P9cxClJ5TgmKL1d6h
 Nhizc2iovXWtSRuKN0X_cxy1R9Q48UXtMzdScXY4GmxtPAqdqsOGDsWTHTk5bSthsUwL9npTliw.
 nTJ44OSHD_jZPatBCTovqRSany9rSygzqPou4s_lepOpWvaPs6Synl4GS70Y15.teJ6Vn4hcGH8d
 N7ZL2A0jpJdeY5TKSwYoRY7As0j7GP_Fg1fBjgAXd44wWZwu3NexkpEmFlYSHjCYS2pkB74nKK6_
 NhqviWUCQKdMxvEamJQYqPQXyhKNgTeEkIakYle5zI5b_6PJx8cwFWteGQ09R.kmR2MFLyR00wNt
 sCRaNynEihucAn.wl4W0cJAljPbpaYzVvP3ILXCL15q_neOW1B5hu_r0VcS3AveUtwe973FEvibr
 QRR.VpalPj5DcTUYaJVnsV1z5sOtLza379d_KZDSfGmVcPX9_zo21z1FY2SSJSEBcXvV7vi94oZy
 mwzObQwPZTLguejxXX_U70tirBlNE8EWGV8GAwBbtiFO_oGvT4GgYetcRHxG1zK.DtFnARjCx86Z
 Blr8YH0Kyy2cC_GQr5i96ziTe5E6J8A74tHmfNzWVr9teIEhYAZMecC7XGPMIJYso.WP4NtV0tat
 Kgo7yPh_XrslAVljMtXdAqxoH2RGdrIXKodsZ9D7jYwr1ggSAEdv0bNIcbNJywK0AxYidQN5bfJo
 ZWpp4kA1Nf6_k.jb3fFmJg.XJ2821nzaRVylTYoS6I1mgumCRfToOW3G6smIEq9fQtqxQLW3oNSv
 yKQYKzgb9yx0Tsq_.lVEg_wX6pa8KVI1egGi62_FKwmUMA2aXd9pbzUNJYtfLdVclSMnDZNp4ih1
 YUIzHIm8.ZEWgEnKMNTi98zkKcZUbV19UgNUE0fbs9vqZ6AmWu4x8frTFTHBpHBaZ0fw6eQuvudX
 C4PHfsGyQPYyYs8Ybu2j1_oox3Ebt9SDBKexlyhsx.zq.WuKcb4zQvDAiaXsDT1nVki05oRSsob2
 q1zQCOAr8wOw0su_HGhYn4PLggVtQmp_J43bF4ecvoMNNLTOveRgs_huX_5JfU9ACp9eop0ya_WR
 TkbBTdZW4R30c0sHy4ck9CfY7srLIBdjtUytTg.gDWQ1WGeeYJPoHTIlVeGhXAD5F6q9VikfOlSu
 _xGk0t6XESD2iY4A1vTPgOoSTJ4m_j_PpSGXRD9NRI4L10aoxX3nvxIxHrwqDV_OP5uKocKrbegK
 K8kfmWKAXAJHk5cW73aW6F3TAaweZtRP_h9TCwZVTPbDaAJxZZjK244hBS_Tx8faEyC4iiQH5whT
 7qHVCp6CXvhSydKNzdOC6TW2DFUK.D_nQOsxW4x7OEgvKaGBG.pCrD6_cEabTZK.0RcBv5An2tO_
 C_nFAOMk9wN9YHX4yMnP12vDV7.lOg2.hX5iz4kCKNZ9BG_BvOGW3cs8YWoWn7644GI5U0HiNGp4
 73N45Lslhqly5fxMV30ZzxCCJeJtSI0eXTfD_WiRapyUusayxyh4xEVa1OyL8veKmpAbtRcfZcWO
 hxjxIUa54X5Z9Ds36wklHfj.C.7yZEwyODLDO8QyOvmo91HBfnp3cdZNMY_aW0q4jPXJhi5l1Bwh
 uF5YVAkxeZD49Nol18yiL14eyVm6CorxNR7qO3WjtrCpHcndLfzCGaeIsdEU7kRVhZx8P_IQ045k
 UmPdsB_qjuACJmZbFSDAtJi170DLtYMluJFzphwpMj89.qEPPv1p.sGbKr_NDRm0_44g7al87A6I
 nj5gcEScmiSTpU_KTvTRTr3hAEiTicS38QhL4yd0xZMcW6ZFLLqGVgsiCXce1wLMwb5mBKsL5CNh
 WSi_nArMoBzkP8Lg7zvis6sSsvEP4T9OQoFrGVPhrOPhq1jACc3QSjumazbVA812LJbwEaWo0yj2
 PjCRJytRozgHupK1CxCy2Um799tVLgSN9FSDo4w0J1a90tiiknu4JJPIJlU.bjQ8_lQcTs.7cfRd
 S5Q--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ne1.yahoo.com with HTTP; Thu, 7 Apr 2022 21:24:28 +0000
Received: by hermes--canary-production-bf1-665cdb9985-6hz22 (VZM Hermes SMTP Server) with ESMTPA ID 7b3eda77d72d772e8386b3c1f765a2b9;
          Thu, 07 Apr 2022 21:24:24 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH v34 05/29] IMA: avoid label collisions with stacked LSMs
Date:   Thu,  7 Apr 2022 14:22:06 -0700
Message-Id: <20220407212230.12893-6-casey@schaufler-ca.com>
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
 Documentation/ABI/testing/ima_policy |  8 ++++-
 include/linux/security.h             | 14 ++++----
 security/integrity/ima/ima_policy.c  | 51 ++++++++++++++++++++++++----
 security/security.c                  | 35 +++++++++++++++----
 4 files changed, 89 insertions(+), 19 deletions(-)

diff --git a/Documentation/ABI/testing/ima_policy b/Documentation/ABI/testing/ima_policy
index 839fab811b18..64863e9d87ea 100644
--- a/Documentation/ABI/testing/ima_policy
+++ b/Documentation/ABI/testing/ima_policy
@@ -26,7 +26,7 @@ Description:
 				[uid=] [euid=] [gid=] [egid=]
 				[fowner=] [fgroup=]]
 			lsm:	[[subj_user=] [subj_role=] [subj_type=]
-				 [obj_user=] [obj_role=] [obj_type=]]
+				 [obj_user=] [obj_role=] [obj_type=]] [lsm=]
 			option:	[[appraise_type=]] [template=] [permit_directio]
 				[appraise_flag=] [appraise_algos=] [keyrings=]
 		  base:
@@ -126,6 +126,12 @@ Description:
 
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
index 5400f68134e5..fbc9318ca288 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -1986,25 +1986,27 @@ static inline void security_audit_rule_free(struct audit_lsm_rules *lsmrules)
 
 #ifdef CONFIG_IMA_LSM_RULES
 #ifdef CONFIG_SECURITY
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
+					   void **lsmrule, int lsmslot)
 {
 	return 0;
 }
 
 static inline int ima_filter_rule_match(u32 secid, u32 field, u32 op,
-					    void *lsmrule)
+					    void *lsmrule, int lsmslot)
 {
 	return 0;
 }
 
-static inline void ima_filter_rule_free(void *lsmrule)
+static inline void ima_filter_rule_free(void *lsmrule, int lsmslot)
 { }
 
 #endif /* CONFIG_SECURITY */
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index eea6e92500b8..97470354c8ae 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -89,6 +89,7 @@ struct ima_rule_entry {
 	bool (*fgroup_op)(kgid_t cred_gid, kgid_t rule_gid); /* gid_eq(), gid_gt(), gid_lt() */
 	int pcr;
 	unsigned int allowed_algos; /* bitfield of allowed hash algorithms */
+	int which;		/* which LSM rule applies to */
 	struct {
 		void *rule;	/* LSM file metadata specific */
 		char *args_p;	/* audit value */
@@ -285,6 +286,20 @@ static int __init default_appraise_policy_setup(char *str)
 }
 __setup("ima_appraise_tcb", default_appraise_policy_setup);
 
+static int ima_rules_lsm __ro_after_init;
+
+static int __init ima_rules_lsm_init(char *str)
+{
+	ima_rules_lsm = lsm_name_to_slot(str);
+	if (ima_rules_lsm < 0) {
+		ima_rules_lsm = 0;
+		pr_err("rule lsm \"%s\" not registered", str);
+	}
+
+	return 1;
+}
+__setup("ima_rules_lsm=", ima_rules_lsm_init);
+
 static struct ima_rule_opt_list *ima_alloc_rule_opt_list(const substring_t *src)
 {
 	struct ima_rule_opt_list *opt_list;
@@ -356,7 +371,7 @@ static void ima_lsm_free_rule(struct ima_rule_entry *entry)
 	int i;
 
 	for (i = 0; i < MAX_LSM_RULES; i++) {
-		ima_filter_rule_free(entry->lsm[i].rule);
+		ima_filter_rule_free(entry->lsm[i].rule, entry->which);
 		kfree(entry->lsm[i].args_p);
 	}
 }
@@ -407,7 +422,8 @@ static struct ima_rule_entry *ima_lsm_copy_rule(struct ima_rule_entry *entry)
 
 		ima_filter_rule_init(nentry->lsm[i].type, Audit_equal,
 				     nentry->lsm[i].args_p,
-				     &nentry->lsm[i].rule);
+				     &nentry->lsm[i].rule,
+				     entry->which);
 		if (!nentry->lsm[i].rule)
 			pr_warn("rule for LSM \'%s\' is undefined\n",
 				nentry->lsm[i].args_p);
@@ -623,14 +639,16 @@ static bool ima_match_rules(struct ima_rule_entry *rule,
 			security_inode_getsecid(inode, &osid);
 			rc = ima_filter_rule_match(osid, rule->lsm[i].type,
 						   Audit_equal,
-						   rule->lsm[i].rule);
+						   rule->lsm[i].rule,
+						   rule->which);
 			break;
 		case LSM_SUBJ_USER:
 		case LSM_SUBJ_ROLE:
 		case LSM_SUBJ_TYPE:
 			rc = ima_filter_rule_match(secid, rule->lsm[i].type,
 						   Audit_equal,
-						   rule->lsm[i].rule);
+						   rule->lsm[i].rule,
+						   rule->which);
 			break;
 		default:
 			break;
@@ -1025,7 +1043,7 @@ enum policy_opt {
 	Opt_fowner_lt, Opt_fgroup_lt,
 	Opt_appraise_type, Opt_appraise_flag, Opt_appraise_algos,
 	Opt_permit_directio, Opt_pcr, Opt_template, Opt_keyrings,
-	Opt_label, Opt_err
+	Opt_lsm, Opt_label, Opt_err
 };
 
 static const match_table_t policy_tokens = {
@@ -1073,6 +1091,7 @@ static const match_table_t policy_tokens = {
 	{Opt_template, "template=%s"},
 	{Opt_keyrings, "keyrings=%s"},
 	{Opt_label, "label=%s"},
+	{Opt_lsm, "lsm=%s"},
 	{Opt_err, NULL}
 };
 
@@ -1091,7 +1110,8 @@ static int ima_lsm_rule_init(struct ima_rule_entry *entry,
 	entry->lsm[lsm_rule].type = audit_type;
 	result = ima_filter_rule_init(entry->lsm[lsm_rule].type, Audit_equal,
 				      entry->lsm[lsm_rule].args_p,
-				      &entry->lsm[lsm_rule].rule);
+				      &entry->lsm[lsm_rule].rule,
+				      entry->which);
 	if (!entry->lsm[lsm_rule].rule) {
 		pr_warn("rule for LSM \'%s\' is undefined\n",
 			entry->lsm[lsm_rule].args_p);
@@ -1780,6 +1800,19 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 						 &(template_desc->num_fields));
 			entry->template = template_desc;
 			break;
+		case Opt_lsm:
+			result = lsm_name_to_slot(args[0].from);
+			if (result == LSMBLOB_INVALID) {
+				int i;
+
+				for (i = 0; i < MAX_LSM_RULES; i++)
+					entry->lsm[i].args_p = NULL;
+				result = -EINVAL;
+				break;
+			}
+			entry->which = result;
+			result = 0;
+			break;
 		case Opt_err:
 			ima_log_string(ab, "UNKNOWN", p);
 			result = -EINVAL;
@@ -1816,6 +1849,7 @@ ssize_t ima_parse_add_rule(char *rule)
 	struct ima_rule_entry *entry;
 	ssize_t result, len;
 	int audit_info = 0;
+	int i;
 
 	p = strsep(&rule, "\n");
 	len = strlen(p) + 1;
@@ -1833,6 +1867,9 @@ ssize_t ima_parse_add_rule(char *rule)
 
 	INIT_LIST_HEAD(&entry->list);
 
+	for (i = 0; i < MAX_LSM_RULES; i++)
+		entry->which = ima_rules_lsm;
+
 	result = ima_parse_rule(p, entry);
 	if (result) {
 		ima_free_rule(entry);
@@ -2158,6 +2195,8 @@ int ima_policy_show(struct seq_file *m, void *v)
 		seq_puts(m, "appraise_flag=check_blacklist ");
 	if (entry->flags & IMA_PERMIT_DIRECTIO)
 		seq_puts(m, "permit_directio ");
+	if (entry->which >= 0)
+		seq_printf(m, pt(Opt_lsm), lsm_slot_to_name(entry->which));
 	rcu_read_unlock();
 	seq_puts(m, "\n");
 	return 0;
diff --git a/security/security.c b/security/security.c
index d1ddbb857af1..9e0139b0d346 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2728,19 +2728,42 @@ int security_audit_rule_match(u32 secid, u32 field, u32 op,
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

