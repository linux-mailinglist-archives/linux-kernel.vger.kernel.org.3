Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BBE24F8946
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 00:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231428AbiDGV2J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 17:28:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231378AbiDGV2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 17:28:06 -0400
Received: from sonic310-30.consmr.mail.ne1.yahoo.com (sonic310-30.consmr.mail.ne1.yahoo.com [66.163.186.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD01C199500
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 14:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1649366764; bh=Wc9vmFaSeLclWZW27NYtiPedH82eAks2io6BkS5TCZI=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=gWOaFu07S7cPza5o0ekd0b1kRg1LeXhT3gGhRnldbk/k8x5YEdRJKrwUDvNWtStlko1e+CWDlZHrMwlCGYzM+PrlsdMdCAPuiYIXdzqLvQ4E1IvrFWtevXOGoLbYNJdPCuh3ehs22RFEur0lzDsJYzp4w0kWDQZ9bDb4CBt8kDftvhoVmsvXgZUWCbJAD728sSWSESIDLTw9XkLTCHre99PN/8mJ3hocCSxnn0jL/8qtHWUVjX220MZhpXlHpa5nKqI0KiaPc9X8Qx2s5kKXmcaur3B32cp+B0+ND3rRr5aBPe3/CM4940Ha+7cvRXxWmEIUJJ2qhrScEAKNVQ99KA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1649366764; bh=AZPn5ul8F/mkfF6r5mq3iq6JT7j5Dm5/xDPT2H8Nh5Z=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=sTSX4VJSDX5ZmpgPIXpcdxO2o6h6JLUc41BItTdcH4b4H4LUVgSJTCiJwAPMz2PlSci8YbK0T8NnfQ8tF+AMJjFxZDMAJRs6DJVqBQ5SQSkZBG3W5lsZhz1xeaaXjgVPtt9Z582Z42PmiyxvlTHat0m1IuPlGL8UTXF1IYy+E0sCq0/zY6xSnNYKeyfcnDzFNRsG3lx2sNokovfjjUg9ZGgeAFsJdLRjN5zvXA1PYQqLM5mRd7HxIQcmwpliBU9JAHPBlWpVcKzx7ZJmj+xIDfckJUL7U9xJvrb0C/om9Ssx2nYcp6r3m1idDHCUj8XJdiJ7xUhTkXyn6iiF08LtBA==
X-YMail-OSG: j.O1JaAVM1ncJMWEhQyF7RiU08eVkE_09ECKwjlzwCobwO7iSsOw5jqCdZ6mwnp
 OnA3BokKurEHiipkKh5G.z0bRuRBEqpYm2erC3jgJvF1ZjWZIgmKOhna57Y28gq5IQo8yFLVjIuX
 tnpxqhtuJ4e4Mqq8t_Vy_frtkZCzYmfvEn93LE2CVfw_qYW26DAu3KVIcInOL2XI_ekvD3fONsLo
 ZIx4DNbmKgkY1xZfGH1P.9cqGujce4CRkn0SihY4q4pXDqJ8hh6VBWTN0dL1VmWTWRJfXdKJC4Ts
 Jni4zURH7..TxXAbuEsSNmUEAWmkNog3g2Gz4gt50lscfz9q7tS1p1DdQ94w5BAg5BEwLX6JO8KD
 edb_3TPQHK_mMJ7BHIKXRq6wbdxALEXAbL7m4G.fwWrkVRvJn67OwgPU1BPb5Up1QfinFFuLxyj5
 Luw6Cy0jgmloZJYU2FnVnU3Cu7qMcmMCf.oEtscThyI4JyhJaHk8VTqxAe0aVXY.1Xcc1kvsdw6n
 RJqNko4ach8bXEmwaC0LdZ9GbHz39GTmebsV997qGBwpgtyEjocmLDLdYsp2ngg2waLI0Wz3uEMH
 7UmWkV1OVJ_kKdnykeIXIowPFvhmkodpg4EXK4kA7AQmbgNSKvcbS6XbnfGlsQgYm_YIQFggoAbl
 .Blv3gNjrIatNqn5wXMIpti6LTbQjJ17WicGGAGaj4P_aobcQYPeRhA8kIK68pUEIbocDCsZgJPO
 xDSZczq9L1xhIppuqqb0vhYUeP71lS0KU5JZX_IAr8.UXUdLCdK0LEblHYVbp33dJBDxus5gi2k8
 HpGQ.eUHtIQB9mBTq0A_zy.g95xWclRnUeScVwIR55eTwlCHDaiomWDMJjFX53_mLNANq3APltSd
 Q5DIOxsKy98OAEShdipxXeE2FHe4uqTtV8FsaUbqfUUhV3w1avZght1Mt_gy5rWUucSzuHrsIZBn
 FvPD4qefDPYXhEZIz69F0F6u7O6dC.GxJnDXRHr6GWqb.02E80Q33XqhPOv2VwIdGmU6NXGr4I3K
 .JHOJUM3ai3.cFk4sYzW0S35bY7VLVRnTfnUuZlRBdDatj13oJq0u8k.IfJT6VCLiCdqepQ8ZtU8
 hqNWK0RjOFwc8iFai64N0Fx1z74KabdGEc1HvPclc0aU74_sVHWdzr12ulRsF3x5p31x67BA8YE7
 .dkeuqhBYWhnsY5xNbQgG2ePZEVXQB3gCf1IB8.1ZYbF.c7AGwoAWFH81p2TJUWhnLaQPHtenVoZ
 llM0VZQCNiPaoGt5uODc2hs3dQeZKDyO4oN_3zsiMf00yCO4DbxFhpwahiWhqvVqteO7BYGlFmyu
 RWOBPb8.aTi39SXe4mfXxEqHAzxd3DnOuPKY.F3S1ryCR4xVxnZv2ckQYnlTwAG7EeA16H0hXNtp
 WOfcFM6FNHICaA6p6OHPY4eKT9wiV4BtzuS9xwYtRNe4oH0RP7CToty_j74RBCfhCyIszNWpBf5e
 pZkS5WKXncgBgFBZJJFUNW_Jc5VkvOurvC2aneS_96rjUfLhICl5doU_4Ky32mMVIFXyCsp82xAV
 cAYYEfX1nnfZUwyUHNOrP4c4Akpt3lR6Gzw0HpWr77ONQyG.nFX.OH_vNwz3gL0ooQYTMfpEXKL4
 m1ihYXY74JnerRjKitpk2gU9KOACj8c08VqcUkXT4w9.UY5VHGYdiBuLWUxk6EWIQc9SAdpOwUbV
 ra4uT3Lh_k5o5htWsX_guzRyhFivQx7aBk_fVHoPnsTGfn_3oCG3zYOfAMM0Ur9_s_AUoieiNBXE
 7EhiIRfP7aTraT5A2gI1u2TkiFqR99BwGJTNe8NN0x0WE9aT9Pol7talRsXSfjXM09cZggDuWixZ
 9ZGqmpsRGGCicwvPwtPa9iUI7Ycb_nQE1Epf3WgxFDaobcJwh84vT138EupJ5KekLPa4uS5FxwKA
 WqlT.pCnD.q8DhIdeQtQdHO2ZEz7s57kqulX5cZQC0_gu1ElwicSGJROSUZ7VvFUHJcR9pZ4YGlb
 VHfFMibPut1y6TUP_HdGfFYJdnTmmTEXc402NkusJORLiIh7pjJ29SHbtN7wX5aB.UwKl_y_t2F_
 dnETcUgEL2D8P.oFupPsYu.mC0FYXPIgsY9WFjmr_lPvps9NZrSOVUgL1f7EQ5LvbClJwztwHEWF
 nvhlyzTG29r7S97r6ArvE5aHBVj5oq0FHkeFaAhS1y7WtdXtH9Yt1GyiFByfOeImo.6wyBA2DGL7
 17pNflE5BVtkf8LY_VztPPMXdLQh9oaBrujhmixH3I_j1PxM1_cUWdHCffgiRGXy81GxsjixPX.0
 SFlW98eEhwes1A8_8FD5WRO21t1Tg_CE-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ne1.yahoo.com with HTTP; Thu, 7 Apr 2022 21:26:04 +0000
Received: by hermes--canary-production-bf1-665cdb9985-zm65g (VZM Hermes SMTP Server) with ESMTPA ID 1b8a787888cf9c0809abffd2a20a44f0;
          Thu, 07 Apr 2022 21:25:59 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH v34 06/29] LSM: Use lsmblob in security_audit_rule_match
Date:   Thu,  7 Apr 2022 14:22:07 -0700
Message-Id: <20220407212230.12893-7-casey@schaufler-ca.com>
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

Change the secid parameter of security_audit_rule_match
to a lsmblob structure pointer. Pass the entry from the
lsmblob structure for the approprite slot to the LSM hook.

Change the users of security_audit_rule_match to use the
lsmblob instead of a u32. The scaffolding function lsmblob_init()
fills the blob with the value of the old secid, ensuring that
it is available to the appropriate module hook. The sources of
the secid, security_task_getsecid() and security_inode_getsecid(),
will be converted to use the blob structure later in the series.
At the point the use of lsmblob_init() is dropped.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Acked-by: Paul Moore <paul@paul-moore.com>
Cc: linux-audit@redhat.com
---
 include/linux/security.h |  5 +++--
 kernel/auditfilter.c     |  6 ++++--
 kernel/auditsc.c         | 16 +++++++++++-----
 security/security.c      |  5 +++--
 4 files changed, 21 insertions(+), 11 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index fbc9318ca288..8fc599317f79 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -1955,7 +1955,7 @@ static inline int security_key_getsecurity(struct key *key, char **_buffer)
 int security_audit_rule_init(u32 field, u32 op, char *rulestr,
 			     struct audit_lsm_rules *lsmrules);
 int security_audit_rule_known(struct audit_krule *krule);
-int security_audit_rule_match(u32 secid, u32 field, u32 op,
+int security_audit_rule_match(struct lsmblob *blob, u32 field, u32 op,
 			      struct audit_lsm_rules *lsmrules);
 void security_audit_rule_free(struct audit_lsm_rules *lsmrules);
 
@@ -1972,7 +1972,8 @@ static inline int security_audit_rule_known(struct audit_krule *krule)
 	return 0;
 }
 
-static inline int security_audit_rule_match(u32 secid, u32 field, u32 op,
+static inline int security_audit_rule_match(struct lsmblob *blob,
+					    u32 field, u32 op,
 					    struct audit_lsm_rules *lsmrules)
 {
 	return 0;
diff --git a/kernel/auditfilter.c b/kernel/auditfilter.c
index de75bd6ad866..15cd4fe35e9c 100644
--- a/kernel/auditfilter.c
+++ b/kernel/auditfilter.c
@@ -1337,6 +1337,7 @@ int audit_filter(int msgtype, unsigned int listtype)
 
 		for (i = 0; i < e->rule.field_count; i++) {
 			struct audit_field *f = &e->rule.fields[i];
+			struct lsmblob blob;
 			pid_t pid;
 			u32 sid;
 
@@ -1369,8 +1370,9 @@ int audit_filter(int msgtype, unsigned int listtype)
 			case AUDIT_SUBJ_CLR:
 				if (f->lsm_str) {
 					security_current_getsecid_subj(&sid);
-					result = security_audit_rule_match(sid,
-						   f->type, f->op,
+					lsmblob_init(&blob, sid);
+					result = security_audit_rule_match(
+						   &blob, f->type, f->op,
 						   &f->lsm_rules);
 				}
 				break;
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index d272b5cf18a8..a9d5bfa37cb3 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -468,6 +468,7 @@ static int audit_filter_rules(struct task_struct *tsk,
 	const struct cred *cred;
 	int i, need_sid = 1;
 	u32 sid;
+	struct lsmblob blob;
 	unsigned int sessionid;
 
 	if (ctx && rule->prio <= ctx->prio)
@@ -678,8 +679,10 @@ static int audit_filter_rules(struct task_struct *tsk,
 					security_current_getsecid_subj(&sid);
 					need_sid = 0;
 				}
-				result = security_audit_rule_match(sid, f->type,
-							f->op, &f->lsm_rules);
+				lsmblob_init(&blob, sid);
+				result = security_audit_rule_match(&blob,
+							f->type, f->op,
+							&f->lsm_rules);
 			}
 			break;
 		case AUDIT_OBJ_USER:
@@ -692,15 +695,17 @@ static int audit_filter_rules(struct task_struct *tsk,
 			if (f->lsm_str) {
 				/* Find files that match */
 				if (name) {
+					lsmblob_init(&blob, name->osid);
 					result = security_audit_rule_match(
-								name->osid,
+								&blob,
 								f->type,
 								f->op,
 								&f->lsm_rules);
 				} else if (ctx) {
 					list_for_each_entry(n, &ctx->names_list, list) {
+						lsmblob_init(&blob, n->osid);
 						if (security_audit_rule_match(
-							n->osid, f->type, f->op,
+							&blob, f->type, f->op,
 							&f->lsm_rules)) {
 							++result;
 							break;
@@ -710,7 +715,8 @@ static int audit_filter_rules(struct task_struct *tsk,
 				/* Find ipc objects that match */
 				if (!ctx || ctx->type != AUDIT_IPC)
 					break;
-				if (security_audit_rule_match(ctx->ipc.osid,
+				lsmblob_init(&blob, ctx->ipc.osid);
+				if (security_audit_rule_match(&blob,
 							      f->type, f->op,
 							      &f->lsm_rules))
 					++result;
diff --git a/security/security.c b/security/security.c
index 9e0139b0d346..ced1c76a380f 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2703,7 +2703,7 @@ void security_audit_rule_free(struct audit_lsm_rules *lsmrules)
 	}
 }
 
-int security_audit_rule_match(u32 secid, u32 field, u32 op,
+int security_audit_rule_match(struct lsmblob *blob, u32 field, u32 op,
 			      struct audit_lsm_rules *lsmrules)
 {
 	struct security_hook_list *hp;
@@ -2714,7 +2714,8 @@ int security_audit_rule_match(u32 secid, u32 field, u32 op,
 			continue;
 		if (lsmrules->rule[hp->lsmid->slot] == NULL)
 			continue;
-		rc = hp->hook.audit_rule_match(secid, field, op,
+		rc = hp->hook.audit_rule_match(blob->secid[hp->lsmid->slot],
+					field, op,
 					&lsmrules->rule[hp->lsmid->slot]);
 		if (rc)
 			return rc;
-- 
2.35.1

