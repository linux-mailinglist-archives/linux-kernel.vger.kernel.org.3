Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E682050315B
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 01:10:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353906AbiDOVX1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 17:23:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354105AbiDOVWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 17:22:33 -0400
Received: from sonic310-30.consmr.mail.ne1.yahoo.com (sonic310-30.consmr.mail.ne1.yahoo.com [66.163.186.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C9BE41316
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 14:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1650057595; bh=5kt1Liqo/7tCS1co2DHvQ93kIKnE4GkkPhAw1DSEGfQ=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=oaK/J/fbsD5QZAwC5PfY5chpSdYKtKg5hMC4ml/AlHXu/+GpOV/NlB9GEpaee51T6FMlMmoJjL9X0LH8LRHfF9ORwoKooBRoE7/jZxhSaN0XD4k8i9k2vvr8nE/x0LUMVO8MsjhszXeyS6WXpB7iPBlNQ35Q/IkIfm2AW8eM0UZQKszjiE0jYmGf02LfxNFQdfY8WT4Q7J2/sQ+Qrv2b4Tf/IQBbxzhNeDD1x5NRZ1u76RdeikQe4jLNVXi+kODYao1RDg31emy3ff6TznDleT76+Q+VbcVSevkVchpZB8BcBF5+MVEvlTa/SuvBcaBDM/l/x1ry6jI1JuqUF9ZliQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1650057595; bh=UXlXah/CWtov0rpMkSEPFwKHYhhAxYc2JV1stb17Ng1=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=XCOVVVihPjjNbB0A3zP7alU7r0JH2YzmiBujjXyShxpv+FV1Ve2UhW5N+HX+/FwpWQD/ZIF41gkhHvmd52uHTW11Wu2fKSSdmZfdrAF0XK2eh12GMXhE/GScRmp+d8UdhBSPSpdcbH9qArkUGoL3QfAPsKq7bHk5w6MWZVK/tYZprWQix4vfVjHDPbpu/13ddqpTfD533zSyLSjWGChbnVdJdSUCR8W8KLgcQXvTvm7D/IySBrLiGe6jeLwSNm8vOucdbuEVDfY7T0ahbB4YavPh8fyo0uBezKwIROH267mKN3X1posPXBDOcAKBmrL2sx0+CQmI007Sr+aVIUbnpA==
X-YMail-OSG: t_D83BkVM1ldKJG4PzBOK5I37cI1OSx1OWu7lclKu.INwnDxPoA.z_Q.ipsovQg
 x_N8JQv4dxXZDoaMuMGtaXx9fptXtTk.JP8k4mJA4iz_QfOJMuAi8e._48JVGkY1L1iRdKhGVExp
 .24mSYoQD5EKdNGwDDzzk8PDcTZbNMcgFtK1Hoa.W38C0jo1xzp6diUiUHmna6XoZOtT0nwH9ktO
 6HW25S0PGh9Dy.5CA.94IZnbWTaQTe.SOTiNoYhwBeNW8DaDNB2RNNCilHwyqKlWCtcXnB.fbBRJ
 d4L4I6zEBI9ot53UM1ZQ.H97OfWjerG15joN4K8uGGczIERWGMI2mUi2CnqKJeKPgQbVo_yV3RWu
 hhcJZ8gpN3R2xVFbskDzH1fo6DLIF8aU9nkfAecunmpLfln5PFCkUqIMcvTvNeGQc29PcRuXMyRi
 icd6vlcfyddfAusPAEp3Wk67qTjXi6AOSJ8nvWmnd0Fn2sTOVoWw_pG1vqEQz45L1SF8Q5TUO8FD
 vdR.kYKI8O1MPM9dVLa8C3nCS500dG6IA6Sr8oGSQP9VzfWOnoS8AEqa71TrMcpwiJUmrg3GDusF
 tynk9QkMN7ych2LamdxBP8FQ_UmiBHW7FjqzE4HHEHuSlBixt.iTDH6ozdoozDmO5jOXC7pB2RXA
 uNeRcZADkWK3m4793crib5GWduTAUeRi5yxHdxooT2VDCDiDPeS9cXmuKKooY7zN3lq.bEBNVyJm
 Wr6NGr_won2D__uvpRRutLsF7_xfTJVPXCCq4raSJF5jJntdqMcMFYZfVmyTmZAzinDdM3hqu0gi
 OgbPxyOF68DZa8wWqJSRJvfAR_Iw0rTAstueKIiE5APnKsXllgCxhFD4pnDoZtdFAgSD72hCLQwI
 aP..5m3eUqmPUPzwyXdrBoSpKiTpoMou0SVcleYamrBjgQSRtFOwDS9ggwzLgiLlWVkiGFdjzwUs
 kvflPg_QVRT2D_oT.cMCU8wG3t3bk_IcjolY1CU1MvW3TjyRinWLFrFeh_wXWn.ayc2jCD8bUWPQ
 JAmuCR9A4htBkuHL9jSTcLm_8QJR8E0YLYk56db6OWUhkWffYV7rHq4GjscVCw9Oml5LVK68wl1F
 TvTuLw2hTfQ2QgQeNhuXAubrEIbESFOKGtbM6JkvvSSiwh8bps.sJ96TNTt9XXqcjTQw281H71r0
 Wc7jbkngmNXQnxnDiprS6HU.6C4xkwsN6F0aXL9AuARmSu0XiPxLyXURzRirIkHz0KO20_GyWeLp
 T.8XWAzavPN5_9xI7wxqZEN72OM_AvGE9V5.dE7JtMK3dtIoHyvtutyp9EncNWL7nocnpsUiLC8W
 m71Y4RczY8JUpBNztNJEi6Spz0dDJQardA8OnyEQScVOrHvuwlu9mWtx8qt9jAi674N6I9uWSzl8
 xLdES2M7WUvQMCqXSalaYHGMu2ZO9EkG_.e6pPHSyNEDm06LpCmTCTqfIxwIvCmK_MjFRMwsw3xL
 ANQ1NoNaodGAO.KzTQZRL7kL_hsMWnggNPFxQR1SplyK9YweECtDpaZBMyLaewckqKHViSHQHwpn
 2fBzsV5BrR1KUGlKm4PGkvwbOXuYw9f9p6N8EWXlo8tPu0krSkF1Tf7R_6Us0eOTy813OS2JBdCg
 ZwisJq7LJMYohGX3f3U6OiNdt12frImX.0_uonc64c7sHMWAu0BI4sk_KIVz7X_0O9fyatB2Y4zz
 YSn8Lmsk.2al_9VlGceuFq.0r7O01byR93ILYzrtv.WDNnEAPF2ytSd4OF4z5AwmGPpMkmJZ5vXG
 Kl_86ntz3osZ3QJgbxOpeQokHyOcvHF9TnB5lVAMyz_h8kP6DZ60.so48U2JfPnd2O_dBLccCBOx
 ikjWRbnNsgr_3jAchONgIH7wDgrvxy3oYAx0nBCPVwpM5r4qb.BeJYvVh.fy9d1BVjLYQqUwQeXf
 9NNMeTuLSuNeXX6.xQLH6sy_Xd1btjVtsuPdeeeylKXXDMqilNLVT_2Sx.g8ztcrc8Kvd8q251bn
 yn0bcdPEyjyqzT_MSq2jiqEzmCmHyauUO7qbvxLIuDnDEhLx3idyoK3akw0DLoisumnDDugMSC.b
 Gu57XtswiwNq2DboWGJ1bmos6p.Jd1nV7wDKnZMmQc_CvBtykkISt0xQUiwB0hj3FZodf0V0oXtY
 gKT1ORGHRvjGipndZ5g0HcfwwAOxdS3_AwOzvpMtJWdswdPLLvcxkraglhwrBH9.U.Ow_8rZPT_4
 nrGYVXSUZScF_VygNvsYZTiHeBstM6oq_cj7Ed0M3CPy4.SFYD1LJNjrgZGCCIyr0XCy9yDtsIWC
 TIhDb1.riNqp0WWiN6Q4wstYcPNExeBNePSSExW3Fzn0AbMhAGc6pB_2SuKGeXQk4Vb8ykQkn
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ne1.yahoo.com with HTTP; Fri, 15 Apr 2022 21:19:55 +0000
Received: by hermes--canary-production-bf1-5f49dbcd6-hf9hx (VZM Hermes SMTP Server) with ESMTPA ID e160565289e8323acb3cde95677cb354;
          Fri, 15 Apr 2022 21:19:53 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH v34 05/29] IMA: avoid label collisions with stacked LSMs
Date:   Fri, 15 Apr 2022 14:17:37 -0700
Message-Id: <20220415211801.12667-6-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220415211801.12667-1-casey@schaufler-ca.com>
References: <20220415211801.12667-1-casey@schaufler-ca.com>
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

