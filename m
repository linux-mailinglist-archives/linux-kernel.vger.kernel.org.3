Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 999D255D0BE
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:08:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242712AbiF1BBA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 21:01:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242638AbiF1BAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 21:00:49 -0400
Received: from sonic316-27.consmr.mail.ne1.yahoo.com (sonic316-27.consmr.mail.ne1.yahoo.com [66.163.187.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75A1E22B0F
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 18:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1656378046; bh=+QAFuIueFFODNFCIp51vXXsF16uaRjSDQ9f4wbnX1/Y=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=NsyTbaEAp67PjdMh+i04Uy8c68uB3vm9Uuo61kVmui1SSdWoGTsCSxf6aEgMWP61eJ3jyIMEUpzcjpxGk0QTxoRTSWji50OBKNt+K9n7cJ8pkdPjpw1MXooDmfKMVgqK/2aUyCMC3l2itI1PjO7A47kciMWCo9XxyZwtJBBek+31RVhwxFJ7cU+vl8DjHU3eAmO2jYukgFb610+wxGhjDDKvVnYv4RAjkLBtuAd2h5BcrONmUAnp/BXYEaCx+CcJHRzXRA851PqHxQSqw8l4TuduyZhP4j3+rf9b8eqA5kp8PXyKbxcCB59BxlqU1mGu1Lppp2ETB39n6fAWqpSNjg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1656378046; bh=bquD8fiVhrpPKojfjzVDPS7dI2DuWubLptqP3gwsz3+=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=XxrV0nr9qW2acFNAfgpCP1tLdOTcj834eo4hCFThPQWA1cmidyCtaEGb+jKQbEs/HlZioD6VrYErsHnZrJEEyFpZ35nz1h/JrWGn4gcfbLe1M9aeWdjDUt/3PKT3ZSTAWpOPMzRS957o58+FAzpOuhca+0xESFCeNQGNBzLUrIE3stR7MrUv8HQasJzJnhcfhUXRlEBKYMwpGNX6D/+d1Q9TyvIj1BQ4OluCY0QFmwHirAo6ldYlnU6L6SEVjmNQB6F4kcXHS3BXKKPdUOyzxTMAbeKjIwEmn/4UwCf/bPA/Yo7BTz7zAr4g85eby2iR3bdWxT9WXykb/SNLwuZiwQ==
X-YMail-OSG: aHyCj6gVM1nnfNMIW5n5ndOy0qFRTs8ohyE5BIpltz.XCrqSedpIRx7k7qmS7.e
 7t.kQEeMV8EDxhibTIWy6MsMY_q5.gyOU3rBqy2mOna8Dtj50P3ImeclEdHnzImm0gw7FvZojiiY
 YfAjSQNuBF5dD2vEZnwt8KUoDiOvp4aCNCJpiKVtxLMOTd.f.FV6LNcS.teSdAh72yMP0xq7bRNy
 uG3wEpUy_RLRaAKn8PFyHxX9hMY_Nu18quG0zmTY7DjDsNaZ7A6abr5YZ8KCe1EuwQ.yFeHrkFjG
 49Lm7VRV8r2WTavnULqu6eRO7Co4IU0FFC8MZ1ITugNZIQYoRgke.c7lzJOPOW8fvDjtMtzNH41b
 A.MSHr0y7KZ1rMz_XDCkTFeKGsvhIdXVk6tH7M1J3kev0h2E7DYh_7ZJi9wxWxrN_YyLGik6b22T
 FD9oExF_V_rJGLhdGtkOBrUs26kSYckrFLgduYpwOwWL6Hi6XLKfoVk6u1bPfa0melLnB.loyoIy
 y8NL3RWIqXYm2AY.HUOgkbjhqsj95Ejzlns2p_rcQNtXu.TsExxqdFsiTy8C.kEo9qOZ.FdjRX.P
 M_qkEYigYZozskcLjSkgdudGdik2o_zCv7LR29iF.nIZ0FVDNEChSXk07Lvrc6TimJNodf.XZ7NU
 xHNBPIzRjBB31cYjbOvXTwAWX7LATtR2nyhfpLjJWsEZ1n8caCmyoc1UexGwvh2QOiQgmsibqQcA
 SuXuV22rlBFYWP_kJABgZ32ygvmQnQMO.4HKnFc34HO6CNADyhDBXRgfNbsCIdM0kzH0sNfPmsoC
 D1vuhlhfOYofpkiSPKMcQ3Kn6PRqry6nBcXZzet77mXq6ADzYmXIlye03ZFBBHkPYGR4FyOjF3nq
 OuuPuZjVjlu_2sxq1rOaZ_Mf2MhyKuKe6mDSpDNlIJhL9nrCSGxlJ63m1qwShiCvUnlWraZmljvj
 XSAtILeae9J_r8oVs4LbL3TQOu.sbednYGflZMWNBOm36ZrJcQFUPDxTxS.uE7aIu9G2fBIPgVQu
 4IKeWzBkgdjiZiZwPABs8miko5mcqe2ELhVoENSukMQnylH5hUrmuG4.eJwzHmqhX43kGwKHzEaA
 fr3RmwjyDl8XfzkAPD5Z5.2zJdyjdCKcx_TWK.5P_XMS_5OLm8T0Rphk_FWDB5ss52Is0aPXmdeP
 OWeEX8Ph4_5dFQ__wQ2MkJI0jHrF8bz2MSC5Fxk7PdytpubezjB7xP1nmSWs1F31pud3fy0Yr4s3
 GCDcY4EhIeobRor6t0SQoSlWox9HorhTNhpEGtqiUqiwqapb8_kkIY.OsBGu74LzS6bARYID3kIn
 8rha2irtxsle2YWg8GGJv8Z.KWoZpD2q9_geOWgoHTqfYlNUKxSHZswTfqzJSbqi_eiKMbbAy6NZ
 YG0Sd24uORAY5g7DcVcHMgZVN2YA7GSBdal5LTQsNT7fFSXRvYikmh.ifT5jPSTUlqPvM.wc3HVO
 5e_ES23zFcRd07bEo0v7Mk3BS5_uLYyA1CKMqtQwkstTtmT98e82.wk2LMc9.DZ.TS95Q9cyAfR.
 ZpyP3NJTiuP8hJ9c9cthKM3owTMzo4jlMX3ZiGS2Lgkt5FIGJxV0bmL_k08TU1Dn_tt6yEY3COC4
 zq.teNzNAkVHr_6f8IIr.CszzF_YG8jQ_YTySqc8CyfL2ZdQKJ1Cvc94dyK6FS_BbZHLP_2T2Ava
 r4BieLE72pUR.nARVbVOMLKxKu4aCrCx3rI0xaI5DMqDUdqLl7KC2xbj_snY0CZ1q.uLd82OGNPW
 Owj5ZPtdgDFmkr7_lvODbYeJT2EjcIxkOxcwn.qgzfUVpGBrK_DxTp1bx1LoDnoiDmdnUJNzq_28
 OK2TN0bGdLWTMe6Zb8_2Xdgkhk65oHC99az18wnZdUEymoeZ59EbxTDgtj.hrvguPTek5j6RienL
 8cX5Y4d9kcthk7DGc3_BoKbrseqoDYNcAQ7cXHuYUcxq60d4A4IFe3LDO7LOvDPdgxuKp0gpeLlt
 G8nGapE1ZbBopTNvS54C_zVGOiJDaejehADlDrPoLoEbcZXGDF20d9ERk6c_lgjIstlT4L32ExXK
 aduB9WbYV5jvSYQ63QJs1wluPq8FmuHljkwtjVJQ3UzU1ChLfqWHCNMV8MlS8Zp.ILvKi_Sxgyin
 V2qDf8_i7wSHYmehqfp208YKMYlH7_c10452P3JH86AAdKaKCVpLji6zPwlf2mG7QBgxzPWfhHhy
 IQJGtcsOE7LxfeecSY.M9uxO5FS0NnjgE523Q.KH_1v3BZ4l.IirgmPe4tiLLODEF3R1u5LMWY1e
 PaDaiQsU-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.ne1.yahoo.com with HTTP; Tue, 28 Jun 2022 01:00:46 +0000
Received: by hermes--production-bf1-7f5f59bd5b-wjb4g (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 2eb209f35c81771290ca3d956ba58232;
          Tue, 28 Jun 2022 01:00:43 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH v37 05/33] IMA: avoid label collisions with stacked LSMs
Date:   Mon, 27 Jun 2022 17:55:43 -0700
Message-Id: <20220628005611.13106-6-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220628005611.13106-1-casey@schaufler-ca.com>
References: <20220628005611.13106-1-casey@schaufler-ca.com>
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
2.36.1

