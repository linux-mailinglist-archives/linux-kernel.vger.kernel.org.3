Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1BA34738C7
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 00:46:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243045AbhLMXqR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 18:46:17 -0500
Received: from sonic301-38.consmr.mail.ne1.yahoo.com ([66.163.184.207]:44230
        "EHLO sonic301-38.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238259AbhLMXqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 18:46:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1639439175; bh=vxCUG1h+lCJ94WSHwlr3/Hl5zyslpj5o24+SDdlt7RA=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=P/QTuGYnhkRoxqCEFDmWJFmL47QwPi+bb6YO4NlY7WYhb39fEr17Oe90Iw2ptr81nE76199sVjDRWbn3T9I7LctsBYisH1MI51Eyeo26JaYlD5ID17+Y3MlQyqKpk0yVcWz+UcLGAPxGMM+yv4DW+dQJXjSZM3nulTmKUwSklyXDOP8WX8bbxoObtzXhTK/u5eFDXrhfyVE7pP6r5UYLXLMbyjub2cPnzl3vhWDV+8qv4iiYgEYbVBphApNpDEBaz+CKOeV8HLibmUSMmStPyVrj8NxocbwiGZK9L1gfEW2q6qMm5Ge39ZrZ03UzAv1tmApWE6lnhpmF66DQBxtweg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1639439175; bh=NZZXhOMiWJZL6iq/JQxpUB2JQMzLleOpm7EshhtBfV+=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=KysZ6wvP86mqD8bt5x7bMwhtIebHrpsKY6OdR+bcRxlU7k4ys8+Mo7dTkOLgzpdel9GfcA6pdDxmiJ9wxM12emLxtD1ayCvJNUSjX/HgBoNLj66p2yZQKCsAUqczZRoIdsFXs3oGel46irUJdS9OtQpar6cP2HIyy89HcVxLwgvmp2EFekG7uAj9LUKXJVjojiOrxR/uVk7oK5xeo74UJ7rMON5bV2LSbIfZEHZebOY66KLi2c10ZS0hKKL8Pg3Bh7QzzhkgHTo88YlJK92Zf9O3GqM8lzFo7nrg/Ie3hMwqnUartS4+nEU7pHWc/XqcAxxuBXeJQTWM2oxUazcT0w==
X-YMail-OSG: mlpj3KQVM1mRknd3olSFcQntkPkEC1QeFR9K0mHeFl4_RQPG9cKhTRY9KQ9hi4r
 XA24QlLXhKZE.C85TIQDqCkdbQbNihCDVnG3YhLdpWLp4FHA9SVmXudSQPXcFcuhbE_ZvS12bq64
 oRD11P6xf2yE39r5I7589FxgSd5qlu_QPHK8lYuAKQbx19LnwA8lJd654y8hF5GZ45vwIOwOAAyL
 xquaiw3WbrqCvsvCT6Ssz_8LnW_iMyzIbZHZGDYrCxU_jajkiv0EXIC2VFgXog1J0B0n9TiJ1jyZ
 3Hqh3jspaowaR93BAXezFoGMAuUfRrdtUTLbH2DdMEwYsWlGz35P_nt3TKM5Og4VMevh__3B_Dvo
 eL5vxxVZNsovlBSU4Uj4PrqMBx66DafR8Em4v8ahBHY0NkoJ4ppvSGBoUTW8lJ4DEK5SGi9LDJ9J
 GvVWU4aPQFCPAP8syn34ww0CtLMnggAooZEQfqBdh5zxJ2vO6_Niv6t1haHDs3gWGq7MF6UQqE6R
 Lm6odwKzA7psBRG7rJ.SaaU6sgM8Oi4cgMIvQXm_E3n14G1kOSz54ZAJfQptNLMH.EI_j5QO96R8
 UJL0dxuBwSbRdZc.7xiYOtgXp.srOXY_hJFU1riMXB.OkJ3WOT8nNm803YCtXF.1ZWrj78beuF2P
 FPrTdqsTpDaQcrBbv8x8uEJ5vOy5JSdJmeDSbCIbXzGjx5hElVBy6TMRpHLaU_DKTUv2Mx5gTrp8
 CQC3Ehj.OVHb7al9BQCwj5LTL7As6FLyyu8iKzAAnoYDQ5veUWixD_0XzPWUZ4Y5Ymdj7SZNdF_e
 SVIN54sM4_kkfwWDvjtsk44vo0oHC4WOt3CG68c59JIpEeexs1tkt70IX1_oI4opmvRGsQIbs963
 TLH_uGUN5oiAAsNxJJ7kGicYTiBxpRtdkCzFH2eoAU4K_hs7edsQUz0Uuuai9FQbSHyTnXCQy_6n
 0SxLuiKmW9qHuWXYaz1Y9O4cd5nRpGYS1WcRNWxIx0gbM.f9u6ahcABgTk9ygTGDKmifrhOEp7cn
 ADU0JgqkgbCM0y5TnN0tRPzxzEVQfl6ESXoQL2KpazqksnXJ_QmXKgFUA_mv55xikOhFcJ6MaVdB
 wOauAW.A06CjWFlyxlXWGEBK.5yhWSoob9ysJ1YPvAOb8pctorVu8ibZd9hfGuyn3IB4EdzYt2sc
 JYUw7Cn2.wVcwNRYVN4.1.UhcptgwVd8w9TuQUHfZ48ZwTOl_DSJrGDXirXnRGegkhV_tOvmWZt0
 jzJezgADfyXHOPN4AT2kBoWJv._nSLIwhhfHF8zveDmHqDyBibVZU474yzwJjNbhFQ1zpDJiGTlb
 n4AQ4jAD00XS1N.OZZ3PwJzxxKyEs85qHm5kJYrqhAXcFtrsG4yc.nlWK0.L8mFc0a8ioykAkQ9C
 wCqPgdttuWExOlG04S84IcjztweD1t7.MBmK3AZ5QmK_uuqu1P8N44gC1YK8jMb9Xalxtz5FUn2q
 dsS5l1YvvXL44f2DLZZzQFTAMUDGRnyuAdpnMHCTa8lrXwV4klQ3hNRnHb8XrjzoA.lw5KDOUITw
 jbqfanvS2CQPfWk6z.U1PI4iIUIXdeI9eFNH24TnWpUbrYhxIaZLZIxpFL2irFCfKvufUetiFPw2
 rVYogVZcdONJS7VIZWQ78B_5IKV8Zkv1gFo1_Ii7lvYd4ESM6pYcf0O89OS2lNsiISpkXON6xD.P
 EIIKesmbbfQP4d_dy5sTnSJD4CztCCRxb1LC90GWUE7BBGFWyhtuAAAehQW_YT.LAJV82Cmtr26J
 j1ucm_M80lwz_sMxuf1trzfCbUYgU7ln.jmXTcIWph4ar2QdvAa8mdbxyRCDkE0Ms_2wl5x15kVZ
 xqmbxQSzs_OXIzdmiEefYieRIlDpfboCBk3NnEi0ySHEEjYtWeOa2CMvX.uiB2wAzaWAu_dZ2EWZ
 oC5nd1TZ2z7f2qgqtE6brcxP2Ew2dU4xWCCwLVDGaB9A0MF1gsnNmdm0.qXtHdnNOpXQYeaN2UPF
 RZwHpNPD6D59EgaAD7ndXQOfTKNsjCwqhnrRKtDQUHzAuSuZ4cyo49JzGoXSe02vIuZfnUarRQHL
 LoFxpaVkrs47Ppa9o4JGlWZt1mTnnZKjkxPsoCtxMNx9ucXndQHUfAqJMdQM.R4.kddw6TK20.rW
 yk.914UD4IujmmWWrzb82C0NWIV.Qh79ufecfDVXBk3_KFrlYi1n8drb5kErOEz6txsECoMr6nEK
 xuDNe4vHmhBnx7aMn.LEJGu1yj6Y.AEBZtRKk17Dfw.RCoBMy_ycYnYhIl8I-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ne1.yahoo.com with HTTP; Mon, 13 Dec 2021 23:46:15 +0000
Received: by kubenode548.mail-prod1.omega.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID b7c8ca89523065c6a900f1b41ca9cf40;
          Mon, 13 Dec 2021 23:46:11 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org
Subject: [PATCH v31 05/28] IMA: avoid label collisions with stacked LSMs
Date:   Mon, 13 Dec 2021 15:40:11 -0800
Message-Id: <20211213234034.111891-6-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211213234034.111891-1-casey@schaufler-ca.com>
References: <20211213234034.111891-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index 1bc00edd3a32..9b853796bd4f 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -1985,25 +1985,27 @@ static inline void security_audit_rule_free(struct audit_lsm_rules *lsmrules)
 
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
index 320ca80aacab..22952efcc0b0 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -90,6 +90,7 @@ struct ima_rule_entry {
 	bool (*fgroup_op)(kgid_t cred_gid, kgid_t rule_gid); /* gid_eq(), gid_gt(), gid_lt() */
 	int pcr;
 	unsigned int allowed_algos; /* bitfield of allowed hash algorithms */
+	int which;		/* which LSM rule applies to */
 	struct {
 		void *rule;	/* LSM file metadata specific */
 		char *args_p;	/* audit value */
@@ -286,6 +287,20 @@ static int __init default_appraise_policy_setup(char *str)
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
@@ -357,7 +372,7 @@ static void ima_lsm_free_rule(struct ima_rule_entry *entry)
 	int i;
 
 	for (i = 0; i < MAX_LSM_RULES; i++) {
-		ima_filter_rule_free(entry->lsm[i].rule);
+		ima_filter_rule_free(entry->lsm[i].rule, entry->which);
 		kfree(entry->lsm[i].args_p);
 	}
 }
@@ -408,7 +423,8 @@ static struct ima_rule_entry *ima_lsm_copy_rule(struct ima_rule_entry *entry)
 
 		ima_filter_rule_init(nentry->lsm[i].type, Audit_equal,
 				     nentry->lsm[i].args_p,
-				     &nentry->lsm[i].rule);
+				     &nentry->lsm[i].rule,
+				     entry->which);
 		if (!nentry->lsm[i].rule)
 			pr_warn("rule for LSM \'%s\' is undefined\n",
 				nentry->lsm[i].args_p);
@@ -624,14 +640,16 @@ static bool ima_match_rules(struct ima_rule_entry *rule,
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
@@ -1026,7 +1044,7 @@ enum policy_opt {
 	Opt_fowner_lt, Opt_fgroup_lt,
 	Opt_appraise_type, Opt_appraise_flag, Opt_appraise_algos,
 	Opt_permit_directio, Opt_pcr, Opt_template, Opt_keyrings,
-	Opt_label, Opt_err
+	Opt_lsm, Opt_label, Opt_err
 };
 
 static const match_table_t policy_tokens = {
@@ -1074,6 +1092,7 @@ static const match_table_t policy_tokens = {
 	{Opt_template, "template=%s"},
 	{Opt_keyrings, "keyrings=%s"},
 	{Opt_label, "label=%s"},
+	{Opt_lsm, "lsm=%s"},
 	{Opt_err, NULL}
 };
 
@@ -1092,7 +1111,8 @@ static int ima_lsm_rule_init(struct ima_rule_entry *entry,
 	entry->lsm[lsm_rule].type = audit_type;
 	result = ima_filter_rule_init(entry->lsm[lsm_rule].type, Audit_equal,
 				      entry->lsm[lsm_rule].args_p,
-				      &entry->lsm[lsm_rule].rule);
+				      &entry->lsm[lsm_rule].rule,
+				      entry->which);
 	if (!entry->lsm[lsm_rule].rule) {
 		pr_warn("rule for LSM \'%s\' is undefined\n",
 			entry->lsm[lsm_rule].args_p);
@@ -1781,6 +1801,19 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
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
@@ -1817,6 +1850,7 @@ ssize_t ima_parse_add_rule(char *rule)
 	struct ima_rule_entry *entry;
 	ssize_t result, len;
 	int audit_info = 0;
+	int i;
 
 	p = strsep(&rule, "\n");
 	len = strlen(p) + 1;
@@ -1834,6 +1868,9 @@ ssize_t ima_parse_add_rule(char *rule)
 
 	INIT_LIST_HEAD(&entry->list);
 
+	for (i = 0; i < MAX_LSM_RULES; i++)
+		entry->which = ima_rules_lsm;
+
 	result = ima_parse_rule(p, entry);
 	if (result) {
 		ima_free_rule(entry);
@@ -2151,6 +2188,8 @@ int ima_policy_show(struct seq_file *m, void *v)
 		seq_puts(m, "appraise_flag=check_blacklist ");
 	if (entry->flags & IMA_PERMIT_DIRECTIO)
 		seq_puts(m, "permit_directio ");
+	if (entry->which >= 0)
+		seq_printf(m, pt(Opt_lsm), lsm_slot_to_name(entry->which));
 	rcu_read_unlock();
 	seq_puts(m, "\n");
 	return 0;
diff --git a/security/security.c b/security/security.c
index 9f3a467fb992..580ef0c40be7 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2705,19 +2705,42 @@ int security_audit_rule_match(u32 secid, u32 field, u32 op,
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
2.31.1

