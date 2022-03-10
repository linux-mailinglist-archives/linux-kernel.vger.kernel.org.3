Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD74E4D55BC
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 00:49:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344887AbiCJXth (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 18:49:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344865AbiCJXtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 18:49:24 -0500
Received: from sonic315-27.consmr.mail.ne1.yahoo.com (sonic315-27.consmr.mail.ne1.yahoo.com [66.163.190.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D3FDE33BC
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 15:48:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1646956101; bh=v4IZ6M3MNP+UA3YRVeGAcbJmER07vGRuoxMYchbXfr4=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=LHnImATeMw17yFr3T1XOr8gJBGNcM6Avb/yHPS7qJySferp/nFHw8nlXEPaZxa+B2gda4SqTg2ss7wYJ3npHJg77+MgAWbcsyvMQoJ7JjLGTLaUxfvPnL6IdMVe/7hYLOp1W9PEY2E7htuaNrAbQV9sD5Pd5YtpcuUsSt95DxSoesgSyzhBfUAZMp+ZOjRCIUqBYjOYiBf/UOngowNryzWjbjMZVsCbAYHuSR0cneOOqKjhcj/VZbJUaKdBESw2yWjv0bUUD/HvjFy7uc8c3OGvjX91rHVttkspihzKqlanlqYnxlffOxWBBXenU2Vgoz/gOCaka2TunziWYsVQn1g==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1646956101; bh=9kHb5y6OEnQl6M9LymVFFKE6/GOoIRHHu5pC0MBs8oc=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=hJ1a3inpkCx4XOmay0+YL4i98bZEdNpYP564u8L25aIY4DCgrPSjnkn3txTpHrzzsdM1AdthPovJ05Tt/LeVRm1vF5ArfdU5uEjrqxiYdXe6MNqYWFS9g77mnqFZrqGQtABhKhZnLgulbMV64hkDywjyW8LohlI6TWtV+ssrh7Qq2dncaekmhHN1ki3rhOQSmtJTMjIooH62VxjTYlVsnsWArbDc9ITWSP2y7kRbWSSmsxtFef39LXjscdZubpHT6zIaJ1Bxy8EEex42JlDCJnSaAaBAKnDXN7Jn30Nb4+noH2IZjWpTp3aaAll2IYelqQkax6IYGFm6CxlaCMzljg==
X-YMail-OSG: SBK6FPkVM1novdr3aQYt9P9Yfmtkr63imK87H8hVfZD8.pfsk3o7awZxjFrDOJR
 wNgCdXaLcm6HMY2Br8frpp4ebiKgjy57y_e0I5DGwO3D1JdwNUnXTuj91TvikI.KPziABYg_fNQv
 4HBFgUNk3pxOUOXfiuucmdMS4NbMQ96DTA8nFR.1Yy67RscMHYFO_z.3mo4B9.wkt7QgtRyjCagl
 NcftT.vWA.cmqporV63Gyf9zSS.tkdrS8bNiuVMfTDLicXcG4CwX0uRIcO5x7Hj6xKI1W.g6GioL
 D0ygNH.oZLoTsASImDoJ.TFt3KArE.vyu4sVnegvG_QHAsXUDR7tMX80rnGg8j9Ju6GlI6dpURP7
 8SvGvZ8rZ49T2Qr8eUPeTBGrb9X3xWgWQqk3KGdZ1bwbtiHIT7fryKQam8_ZcU316neZlVVn9aIU
 nu9vvrQKcVPYEunjXh56lwyW2gRkZVvLvKX6dLL2OgYPz8nYnffV9boxL.fBidExbuReOYKgrCxk
 OIZM91ZayC18PIf5bUowyQFf9kiUDG9n0IKvrX3Is8vHzTaYgo9UF3Wb6PiaC.eZ8D7vWDsxGlW7
 hqJYIUKOI2nhmALbqIW0C8jVrwjAPypquVclXoOo6YrxC6et4byKqK6fiLggMoIYovQCWy3VXSsg
 F4duVW9d7Zd16n.d0TOq9jnNL7YvSF21N7yQNuAOqXFRZBRYlcT4LQGCIXP8JLlAf1JOclSY9M9q
 nQGvBWMN3D_4qWO1_pYOTjJ9ySAobgaJEXR4__nYbqgKBU6s9wCtaivSR8Mcnn13BH09ShrGZ_Ot
 sPEDsZ9SM9FzKl2QZskdiXxVjA.3yyySJJXZIFRpPt0NeFo2W._hnKKKUFC_DEAjSYmU0hETe0D8
 BoliexDivPMOZYEhQ_MbetQucmxcb0GOsd.FzVEvmErL0fDaSdC4vGV.UU5FEM5o_2fBxRgcXaK5
 fNcIsIDAB5yyVh_vP7GNdQ0lGp74UhApELhylISJurw0D8uXA.NHO7GZpCN6tshr5TBwAJzy8Wkx
 5ItN7PTLGsvR4.PJWPzRdtqloNEYCzb2j2J3LmVR59Li8GogRd8PxLIh6Ff4n0DkSPRmHI2Md2HR
 tDMEQce7FT_BWx9nhKj2mvXTzvd._2yBkqxQsUxr0ln27DYbj.z54Op3aZL7W0B9X43YFYsBS.lK
 xzDiEMLLtUDVlZv_HeG3drnrz1wN2IEYTjdu7lUZv.RsJp_hK39wbGoXoGJPIesLwl_OlhRDY5Jj
 KOmslJPJBkSQKAxofKn34DpLJAmF_Rq2DMhjp_ABDBqZScADgB1a8Ndnjl9xXk1oEoFTJiCTOCkQ
 orhx8SzDZqdhGMDADNnZvhTnNkGnEg70psIoWo2.19DOmA.XhGlxSPD2qX.Sd66dyHoFAL_eyBJO
 YumkfOJMFq6WQszSr_0An01YqVfuKMZpr4Dgesvq6OFHWfsQywJWRoghZo5vGFGefamHUyySS8Ej
 NY9Xs_q_25Geh9MQWoljnzS6IwJTuSJEpFdERhzGDnistGXxCwGgZVDef9sEB3i6NEUpNUyoEvnl
 j__Z1KqwtYWerX2ua5vUCWweQ2.Dn0NPgk5gxhQA0DfKfmWP2FbL62vNuQFSHlJKNFCT6wl9tvd1
 d.w4wAZn3qBhDFRbTMEYuoES5xuHdTocMIOUGblyV1.Hxg60kXkajVok8tpMWcNisYafU6SNibBl
 c2WRIQXc_uDvLpC9EnSCD4LRmUQ2yFSq4jpAUlSPKenshsNMh2dpQe76POaxAM9jaFPOTS8WUzMR
 D4K_zec.6fIfKOaMxAVx2MW8EKMVWc1ZMEEniUJNdtu6XzdIV5qkFsvIx2Qejl_Q6oa2ztAKYzTB
 oh._x9Qp1F4ddHfsPLaw50EaZBAFAG4LQ9PWfPaVWQA0kB4x4wNGP6H3iV07i_1WyKVBIaDu86I5
 PECbwsJL64DMEE1YQCBPKTd5PkJPIv1Fr7ZqTvOSEyO3UJ9WwNyjRkMxBMdCqIlg1IH.n2NBkh.c
 takO5NAlf9m9Dt2725X86IlSsXqZr9ke2QEJ3kIGdAx57vx8MXRrPHjSpTF1O2ZDBy8giAKUL6UU
 hkzPwHokGBnxDZMqw71GYVY4Rc.m6vxYH_bOhil8oAkN9VlVM2gPdUMb__C_HiV34EcPHWO356tt
 K0KTJm8EAgAaoMEyrCPJCob6kTu3ZZ0.tvWADEhHKDOU_31A3vKnY07scrntN7_6Co_FFbrmDWgP
 5t_pCmgSE_4zslsDkfhpUb5kKtghQsg86h.8gMlYvL7VvG.3Bri1cXqyMgcui8HbqwhLgd2cUVd3
 bqrOypGYXSrwUnTXDGToNs0u29upBRJBofsTtjveK6w8ykb53FFez_A--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.ne1.yahoo.com with HTTP; Thu, 10 Mar 2022 23:48:21 +0000
Received: by kubenode513.mail-prod1.omega.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 83925d611ffce7fcc78508743dd1e1cf;
          Thu, 10 Mar 2022 23:48:17 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH v33 05/29] IMA: avoid label collisions with stacked LSMs
Date:   Thu, 10 Mar 2022 15:46:08 -0800
Message-Id: <20220310234632.16194-6-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220310234632.16194-1-casey@schaufler-ca.com>
References: <20220310234632.16194-1-casey@schaufler-ca.com>
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
index 882e0d50e5e3..1c3bce00f5bc 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -1978,25 +1978,27 @@ static inline void security_audit_rule_free(struct audit_lsm_rules *lsmrules)
 
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

