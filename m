Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8796505B37
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 17:37:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241288AbiDRPj0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 11:39:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345250AbiDRPjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 11:39:08 -0400
Received: from sonic305-27.consmr.mail.ne1.yahoo.com (sonic305-27.consmr.mail.ne1.yahoo.com [66.163.185.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D4172AFC
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 08:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1650294094; bh=NhXiLSPDZgHzjNbz7VuiflhsW9/UCs4f9uR1dVs/P+U=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=tsOQJbRjFxqO38j4n0RqjGnlcjEXruGzGN5jkt+78ItgcMMeBUKN3CFLh/z/HPzPjcD0xW3PBtTIpxx62uyq++vowIO9iEILzDqgwTrGuOI4gPnmTPdJIVFPqdDNPX5eKw1M0o923fMW+Bk70UCg8oj9LyaZBzpLVWgz9OuaMRtaaRPGfEcf1DdugrHvqD8IzlxwxmzEUJgIsYB0igTK1CBKIZwJfOrvWV7MBwJWAU0dRSYNGqKuOTD2F6JL57Y3gIyoGLGXop82FvKV4w4pIqraEPJMH22HzP2r9GgW0mPPyjkws9iUK8MznjH7/FAT52HXcD8raXDmdKnf4D745A==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1650294094; bh=mDGAvSgifJX3vaidCWZOVIabrWSbzo6iBLUKZl1sLGl=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=Ew6aFLDqYp1vOpp/ix+FpNqCsbGEyUH/rwi7G7GNw+1B6E13jjMdJHeWL69mfaYgXbWIrrj+j9YtZ3t55dk/h1dCbfRyjvcTAR3lG3OFcgQZvgX2kLF1MxgPt25qxa7ugqT+N4eLQXTaqbcNKS+yujDPB+AcWSKAkpuH66AFVrYzl5ryPjOo0h4dz5o6nnwQ5sy1M+Gk300XWonI5q8rLz40uS6wEM4RpKNv7igMOgkBRH6wCwudaClb3+ylBd5HGEoyhRguoqL5xnTK+MGWe7DNq9YHgQPOrHUUpwo7gQvpEviYQQbhZAVgERYdlASdB7yitSCmgjzDP24X4XAh3Q==
X-YMail-OSG: .ORc7u0VM1lnIWztoGkpCrKlVWLUxOrWVyieaK4d.kcVtSKNEPhm10r0u5axynX
 bACzQRw783qsRNLaAeqs53WPfXWn4YySEpWLQ4Y6M4kL9QWd6R._tP1WvHzxDTqxk2TfPqjRybND
 AALlHdh3K0nlMtvMFTb9nUOW9TDgnU0MwUuSaKiA4OGao0RpaaUsSfId6nL7y27qaxmglReNL8og
 n2iFL9U3gxFufs3FZDi8rpqnDWlMDaIWuM421BWCHpBZHgKRLnMlqxX4VeuyTpzaYKztvgYf3Tli
 CdKyIyHlnUL41ZXvq3HMfZbP6Ti9V_fUnRQjfzuUuu3MnHIJymPbVyOBwFWn2dR3todyHUceo0dx
 Lz14pHBn1Om00MyPxC.mKpc7aK0qEmsyPsPIZwaGB8vQ0yyHr2NxtAEk.83chWmoVvX4Zx2rkuZD
 IfnFmXsxLHXsz.IKz6jO8n8aCDJW1D9s57bJEwaPMFXGoeQ.GatlXe1BMGTvWpSA5zFJXho_R8vD
 8vNlei0Wz2gY.haKg_I6veAIMXEgtPq.2cVnfPl6HiwzsXxGhD0DGnCalnjj_Egafy_nz4vbkeeI
 xGu0i9n0mXuTEDYPOOaQ2jkNuW.R020gT7ZB8JnHLNViH1WleQilDnAsBmigisJqkJvgihiPqX6t
 HsL2JgTVrmMBWl9NmmLPVa.4cHZd69O9pFm6OuCZLqwEcafUOiQb0dvZtbOUfEmGwGp2OELmy7Dj
 RxIhdnTXiItjJ04VXl6o9IMVLytLp437glyhjSgGY9c6oGQIWYVwIA7FwkrYUwC0hst059QHHXMr
 2JXNFYsSCbgnzYC18LreH_hxGx8smbGEsIQX_GQLyyxOwtzfzMYXSKXNrcD8.gvnfJ47ehb0x1oG
 jvb935AmgrS9jnC4cwiZ1FfprDUkpz48Buc_P.7SP4PTQx8ts.gubVrdf.Q3U5c73xQlHkTg3o7i
 mQRRjaRClI17za_WKyokfVn.g.xd2URMouiT1Y7ipfda.DJF0w8EiODIGrFyr1rqpMS65rK.o_PW
 vKd2_y57IpdEq3RagyTcOrouEYhn1RyMbSCzspOIaTQTzFFBJVAvnvS79.nC.e5eUaX3ym4n4RoG
 LsOXZ2yYm2QYkE9dULKmrqfr9Ca6CFC5YUbrvF2w_WNx9G1vKmS9IP4foHWOW8MxDchBl1Pex_30
 QZaRluKYo1DzY1HqjXlPcEGMHl9mxutGtAM8Sn.GJetC54g62Z05NIo4WmYe5kaOJjjxaY969owx
 9tZxU1OJMJDJ6uyaWSf0CNMnMg2xUDBZHd0y6Lp7mres0xFLWlAHhtkMmRIA.7x3wY.4ndJAfWs0
 rkOyDVsWqZJiHiBd.vVqgyyEMBEyoB4qFRmw_MPJ6rc8ZXmZMPzWTlwEa4y.DcczLM738i1szP9o
 RbE4dL22WNtDilz1JhyhzYISUBfXMwfwYMzNkD_c4Y.y2gYCnb4sOeR2yD3HlFW7Ns8GpfYjWki7
 6gPv0bYWl5iq5235FZOGbkYh7aetoLkvsXAEG23XFISY2aIoLDJGFZABsnaj9wHQSg2208QYRLnN
 FfpUvoAqJehM1.VvTaEGFiLMm6gUzf4q7mbxyzBhePOzLKa16RZmZHnxzEr_i8r72TwNAHl5Jn.Y
 qr5pbybV_q.3VgZ5SDqtQ_1xLIt4jsx1e6pCMpDxD86BDCJC83ytleY3zCngKCc00d8srmAnL4S9
 JMb7RPUcUHMxdRkBh7qMeZ0Hy9Zw1GxxTRXHCz6HudJq6pTnvbn7Dq0MtDfzltAA5tD3CrmaX.RK
 3araur54Qormj8dYA.bMYoeI9ehcjUI16SM333tY.gb13sGttU4W5Sefo6Q7RPax0Ht4MOgrh0TM
 oYF_HNbZXkP3beRNFEONcUaG0tXL3m0PeeAZcjG2tqv0Fpznsb0pjjFogZPbwpCGaE9lhiH5tNlL
 0phEFw9uL2Mrrofhnbbn_s4oBQflrv.ewegeYz1_zOJuEp7SawmsFjhtl864iaUkfkH7UxWwGcyd
 LThsNeA9MXFbMZ0VShe1R6AW5ijhb2TQEehd6lWGtPNam9tUMtJdJuAmb6a2uXb8UcB.xW5LgX21
 CNDgrIvrwYFe7y7l2njaZK0cAY4LjXHtvUZkz13X2UqqXJ4zF_spZTljAw60Kl42a..EgwAJMVU5
 SVOPpJrp84gEItW4xpDGO0DPty8xiuNf79bVvnW39XkGwYCFMqEGfTU5dAjcZHoUfBohNn_a2gj4
 r0H1V5tkkcZkcWVmQ8UQl8IKnZEC6QnmIM2cyMVU0d97gTMaiDuARLyL9tL5wNgauppFvV3hgxDd
 4T1KnPN570_l2Ppa8e5kn911_4i9rCZ.w3RP92QH6xX.cB_e2uE5_JxYCE17Cv9jQsa.p9OZJAWt
 S
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.ne1.yahoo.com with HTTP; Mon, 18 Apr 2022 15:01:34 +0000
Received: by hermes--canary-production-ne1-c7c4f6977-qcc8c (VZM Hermes SMTP Server) with ESMTPA ID becb8feefeabb669980d2a553c076f56;
          Mon, 18 Apr 2022 15:01:29 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH v35 05/29] IMA: avoid label collisions with stacked LSMs
Date:   Mon, 18 Apr 2022 07:59:21 -0700
Message-Id: <20220418145945.38797-6-casey@schaufler-ca.com>
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
index d00870d2b416..3666eddad59a 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -1985,25 +1985,27 @@ static inline void security_audit_rule_free(struct audit_lsm_rules *lsmrules)
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

