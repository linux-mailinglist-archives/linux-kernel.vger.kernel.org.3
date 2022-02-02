Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 121524A7C1F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 00:59:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232450AbiBBX7y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 18:59:54 -0500
Received: from sonic314-27.consmr.mail.ne1.yahoo.com ([66.163.189.153]:39281
        "EHLO sonic314-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230126AbiBBX7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 18:59:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1643846392; bh=HWPHx+c9mffkOYBlCL7PsaufKRO5fGg8oeT9SIKx648=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=sh4LY0sEvEl11GPkF77rzyGDafdkgGVEr8voHWxyBWZ3F27roqk4EKiZqKwcPNuHO/nhR31B2ojz3V7/fzZWWx2VT2rcDvKc1kC+5ZQEnw1YxmjeiDu7b+l8bbv5EPWYxujIfRUwqO8rto+FGveaYxpwWQBfg1Hc9ac1/IZYjO3bydNdwoxqXE09m2Pcf3DWy0ShjiSqQXb8FwhXv+2nDyYdLX6E9fQO7nU+E4zeHndUiUHRiaf9zny23U+tBotUmCyqEZ6FR0l69Y0r6a+odzKHigVZQMCcD7fUYe79uB/cThFF/K1bIrCnIAw+8PiET9D8uBAZuB1bGiJE4IDeTA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1643846392; bh=P5g+uhbsJe0yjPTOrazpGBzz0dkof+C/uejbPynu7gY=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=fqgDPowV/F00A7s4BnSxjWLBdlQp7+MJfDq13ynvKoLqZPC6bKhDUbY5ju+xxWWgOfD5V8O1CaQRU9ZzzK+nYr6mbCk1z6DcfNVjUN9KqFYOCGtpI8rq3bPLxuCAV/qb4L6ZC8aPAAkbe9uIAdt6wEQKcj4j+X9j7yrOd9NaPakeu0ZrnNeC2c3pA/TcOVm3LohYr5AMeaFyr25d2UVhDKlj8MDQINNM4rfZ0/NH1rStNiPCfZQjSngoxpzqbNP5eONjvbEsFvP+wKJS9vuNIBz1rhtJQiaPtbEqbwBIN0MDA4Qz+gwpf7JVcCpZUFmEiLkv9g4U+asMI97yyLTkqg==
X-YMail-OSG: bDrZt.AVM1lb8k_UtgaM6KZ6gIRSDhS4Ao7bl0a989WlofQRkeblB9UWm2NAyVZ
 DI4yq2NVEIfPdieN3_FkqEMRbbPLboxs8oq894exr.bDvn64J0TuJl8_do1F9V306MtCWQ51Z47.
 hUX_cs1CLUxOPCV_37wO3lq4C8e.S8n2dXP.PfuvDolf0z7v0vXQ2mDvZsFnCs3_x6_FS1YSmnJp
 m.a8sAZUvhzasfeEe_1ibuPHiWi965TRjcid._JZ2fdmb7WGiE0_WVRE0mqGEvIhPtxUEhEZy8Nc
 KmcDVdEDIvUHt176niU1Qa7spAis_ccx7ifL5NyC2oVMkvJQCHmg9a5u3bOucHhte_nWuZNOyekY
 Vk6JhnWuc8bjhp7dqsCFVNam6SQt9HcpAc3y1xevc.o9.SnSvZyRZhMUes6QNrko7BncTu7Y3hAt
 WAPEGOdSJLfA82uP00qOAK5oWvS2DyGHq2isndFdu4Ir1.bndD5NFapDqNkN1PLcsQvRYfB5WYK3
 0_LrshTcJPPS0ETkG.iU5F5Owa6i58GnxxPadoJMKmNBTCM2TDyvsK_6ub2XWjtwrTh8cM3qIjxh
 DDbRy.sZmnHd_SYyeG31rGMEufjQc7L0ibyhNFYuoeIPs5b1h99sZzGcE6tH7Pucz9xbcNKs5LCJ
 klMLnkkzRhLLTITcI2A63q3FK3X33TmEGeKmCcjjvggBbqADWLE9IrTxG4oCwouu6BEzvRPhemQz
 LNu0mJPjHVPtJV0Cvmxus4uSC1ac9ipilCmcf2woWhDQrOKbTwKQmCEss1A57C9LhSU09kJHxHCR
 Cy0GRrSDGSI5iums6y2QK_moiRmULb3r0Xxf5vkNt4KLE6kAS7zYdbnJSxamPJelmt82zEoGJPsA
 YDV4TgbN3ySs0B6sPmEzzZBlRwoEXwLIWMmmiY7a9gvBOrEilJ78TpD2UixbisWQhXYd0UWhxRXt
 b3GrLZLq7daGYUwt8lSSzw2XWWHBHHTlNAFvZrJzYZphsAroJd9a3jP5R1wh9A.pLViL.JjkLPYl
 Cx03MiMcC4zP2t0PwrfHp4PSHL7sEMHVngRe1yCpWFdv9VROh.SZfzAXBTDklJ9nQouyyr.dVXbn
 25xQOu2jBXcERtDbFwVf7pd0pZnEAmzROXzKrUhvMtX2_FU8O1fWkiWeuY2EEsUoIHtMjt95cxOr
 2g54t0nLhvOyqb.pYLPOJ4vCrwA_ppQ5DQtwWk6.X2eCaNIvHwqiDjgQmmkZv69Zm4I0yeU4OD5W
 QWi67xzYzW7jip9pxnaLl709MAPWm3QXEMuH8MoxoRWw8l_6V7aLJeFZ8WH5QNvCRppYVtjevabc
 If11HmwoJ8DXJQHngqzB_4CKmqhqN9YEhk2HCBaS8Ar7yVYO4ZrA2ftF.cGxC5H_eIx.esrYIoqZ
 aXTdILITVNKRnvwyHcxy6hD3qd5i1PbARMtE.MHniKsaGDgQ_EHrGBDMlIqlgcpRwTcZWLt3n9aZ
 7KUShQxIqH61n63ajaCTzY24ZgWIOFqqhq_JKXRpwaLSv1Yqt14.tB.y8REXxadHB__3FddKpLez
 5FXO4AL9npRuYqHFlUFy0lRUYYU9AlyHZxafW1YrWNMBNameehxQi41MiENefcO33fcbKaUou0He
 QiX5stpgbwAXClhoy6AsRmzdwtEoKsrpWNVPdvNRS8uWrg2vOvzJlOl30NOxfb8VMcV.ylX5q6IM
 52l_j9KEzjSyDMKnurfHMaQ5wdhx2Ky8RZAVUGSqBUoOutDFnD2MYgAfN3BVgDqZGQhBKek0YtpF
 F78DiTZBmkqZzuhZ5.4rPd2QrQgypul0MuMcneV6_WVYMRyHSrGLtY1cXqDPJo0Ihg7d8nIpZ6fk
 Vg3L1D6MFs.RJTMUsOrCyZ4mlU4s8.qBuVPtXi66g_iggjXmRIeQFonZRKiuh4qbLqsHzjKWraVT
 M2E2QJnO6X5SFOx8tpeXOJVkp8OvgoNyS5RHApp05M7B0CsGjKEZ1.JwS7Miuvtrz5fhSE7ydg8O
 T7IruG5cVsg2RzihIv2VUuhbWNE1lVO6vpDVPmUGJbnHn6S2wicC4NEguDToSpC90Awe0Fo2T.L5
 kkK1NXVIdo3RBujIzor0ETlsZxZh.k0YwK5kGif7N_TnXyiG7YI6q9uRyWS5tO8.gtO5_pAzKo4x
 A7kH5KXUUXJdWVZukXdhxQOKyNpBBNOfPVeByk_6afixcRzIRauBtRsrs.7ShNnIFI5kq124olvs
 5jbLjMSLCnzUdm7d3e4z675LRcl6MpgCT0IjgwXoe6MaQpIzvspyL749L7.49SSssFkclvsw-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.ne1.yahoo.com with HTTP; Wed, 2 Feb 2022 23:59:52 +0000
Received: by kubenode513.mail-prod1.omega.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 246274658a7f9c615ce7598170f9f417;
          Wed, 02 Feb 2022 23:59:47 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org
Subject: [PATCH v32 05/28] IMA: avoid label collisions with stacked LSMs
Date:   Wed,  2 Feb 2022 15:53:00 -0800
Message-Id: <20220202235323.23929-6-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220202235323.23929-1-casey@schaufler-ca.com>
References: <20220202235323.23929-1-casey@schaufler-ca.com>
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
index 6da0c12c9170..1edbb362ee72 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -1977,25 +1977,27 @@ static inline void security_audit_rule_free(struct audit_lsm_rules *lsmrules)
 
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
index 03a0af7e9e81..29fc50322b1f 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2708,19 +2708,42 @@ int security_audit_rule_match(u32 secid, u32 field, u32 op,
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

