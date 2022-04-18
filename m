Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C598505B38
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 17:37:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244788AbiDRPkG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 11:40:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345349AbiDRPj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 11:39:26 -0400
Received: from sonic313-14.consmr.mail.ne1.yahoo.com (sonic313-14.consmr.mail.ne1.yahoo.com [66.163.185.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8E2EB1DF
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 08:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1650294188; bh=79dycniNE/psTMJPgnE9vt2X02zCvlolhDZ5Y1SzfAg=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=YvVaG6lZs/N49z8askMRaYzreE1K28eqZJJIgb99Tht6cprp6ugN/UWy3+YfK434TOgt8uMcp5Q3J22Lqz0TBdIPzGwTB62e1OtfpkUaAf4lnFe2SgTEUcKR26D3WjAAe7KV93MJSQHxtGkgbyMW+sUV8RIBbAOx9n5srUvGS5G77XeLLLLReTWxwVMgLYvHYftELs5CL1M3VEy9bBmGxfVkam//X2e4SHYHKcrEfASK1nx0pW1Hg7kJQv7CLHPZNYvAOUkn9VpR7D0iQWhdkRfWKF1OnmVaGkSNOgbVTPh5VNgjQUbXFFfCzOnsumxPK8CmzFH0LDNlH1odF6rLSQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1650294188; bh=+lOKv10An49eve281wsstkGJB0oKVPkdcnSoFclbd0J=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=bL2jWqeTUACUvzLNcCPnqX1bZ8hCiOKKqQ2WSXDFmywOYoLyQ6PPVh+ldykxBGBTAM7homIt0T0DDVsys/+DSEv7FeTkXt730/TKmyII4YnftQYPWDi8tiWs2TEK9ReiLbphNEq7/8/fVyzaz1IYkcMrGx7aPI2fS2Z0J3OCy7DdjVW2qotvBNXnJG6jVbf5T6mH5sdh5ZHFbSAqiulfqKcPZPxNEJudSyLMTqAnBtAmxZuw+s53qEFQch9c9Ob68zDEkW7qOelaW035dopjYI5cihFhNg8pd/vneQhqSvldOSk6jjxBApqdri58LmA2p7J/3AgAn/NMKgbnMqJ8wQ==
X-YMail-OSG: aZbeNU8VM1k3Tt5kDO1poy0mamdMLGcRqiPFESfoEbwQu7SZhmzM7BLxhG3H7l8
 I53D2LX6kjnvGIrGUsdqrpKvKfMAcUW8neryWKruMzcyk8IjAimwoum8WuK4VhS6aIt_3V7B_w1R
 yd4C_aDkdcP2wL2FaXX16yfeFt0Ob66517WnY41TUMVDIR3geCYUEOrw60tRi278Dzt1yLmig0T8
 RB0FwJhURbADE1zySAQ9iuXlmU.bITfyMJThz884nZuGvL4c.fWTfnOG4YewFmvWCLkfOQ8DAI8B
 mwTuuD8T0nZ35exAF5BuleT5sTNWoiNdP_YsfN9lsUPrMxDbqspmxAHXyXCnEwR6YbbCqxlmVpqP
 05xIADNNaM0gzf1VmD5ubgn50wEl3eMJgPmroQ0Fydg1lcFb3NUFS2Qv5.cvlb05FjVrtdfn8jr4
 UAZ7HreNjYHd1n_XLtUjtG1p5bNjOfExVz10_YRO4AYVLMtn9vG6IoyiVPxrkV4nLTwwhx7JByvN
 aBK5EiS5UnfxsBlIbdbO7wqZpPyapsghP3aATjgJFSIvlR3kNZcAmJUQbytCM1tELxj0OG9FeGWU
 VhypKI45hhfZvE3sAmD9hdgL3K8dFwYz061h4aB5o.8d4i3rHHtRfN0S5nYNstRWXL2a7AzXRmw4
 vlAt16rEC4RPeabXomN.6jshK7DNimhWFSW5.CNUFgzgLs2.BNeAi6dtHjurCVLMsIalohVnlJvQ
 4Pz2UIFz7cTExn33J3uTkPxGUMNS0P4p_bOWKC5ADkbgCqnWPHrpgfMtq11MhHR9gc_olabtERua
 zy5UJeyc0d2u.9d76Tm5iugjEL3lIHR0RmyOG4.1XEZnC.L4i9JSBBgMDhVeoqf4nysCScPH2CgJ
 oPXa8EOHXWlfn6Phn3mdSYvSUAOyvm3wVoxS3wAQUAUOZJWoi6Po0hSy1bsyYKyYOvgHGthnBSY2
 Lv9NkojGQlM8h3OXYfU28ohC.wbFn65sjNYnbZFvdOC0.rBN_B4uBMRmmulEDbdMmGALEDee.PMB
 SwUQcsiNee7TVO8x48bVdgDWCLPQDnDWlIgqvc7eUzJEjBttAEEH5ChQut8qjdvSJT5YnMhaPa1W
 8wYrRyXe00hOji4KToNuR4GoFD4U4rENqe_1N0El2eQyvoky.q97BIY7ibDd74kYFadEq5T4lbjF
 ESFJd50lDIsb6fF9CUwHH8M2p_ApzMWE2jkX_5EJjvokan3LdpZy0NWB3QA6zpzHOjNlaVX3bPP0
 EalAeVXLq_OxNwFFyS4HY5XC6Mqoofcku6yQe.ekLipn7J5sLhBGIc7SBtr8xhWj7kO5bOVmuaKs
 91272x1UnsxCdKzvEf3.cCTQqNfrKuBMDUFNntcHyfbC1oFfTxw5cELb70_9Kx5SQnhziJnzUQ1C
 yvp2Zg.Y18Y5wIGHqUGyuKzsEaL4g3ARvJMJfRyAxWceljBikWajm.70JSggIM648smqxAv4f0ZB
 V01uB39Z7UXPs6KR55W9RrRaxHMPAL1JDYnURQGxuzhxyRMElxoBiT5QuP8vuU1jK1PL.C7LiKzH
 YabeFi.J4wIF9mVwTKcNWU_T._7ZHEanWOLNDLGdrYwPebbQ0s4ro2plde7v0NmQXkXwE8gtVmHs
 67kjhHSljYXXKhXQxjkRlLzDwwpkhTI5eCsaTnBWXvoHV076CiXl01pG2vGH8UT7VlOnxWMCm7IU
 kUSvihfIDCwkvDduQhRl374nErFlHPVGwVkqFOY5ivG4x.0WMJEfWSmg44D8NMTH8NuYQ..Jsl9O
 3x6jag5ucaZ_56a.D.AOh5_.CsxSYDu2zfyjiLmYLiLl5vxv7bTw.PJXD3XhjtsTMQY4sUixTgQv
 MYWS6E0Tnml4Jxke3PAE.9PSlWFANH9L7rX.UnhZUeUqP7rfw3voRi6QNjmGYmMEY9rrmMNgSvcV
 je.zYMKNZX986O27AVB5yniuYl1VVzcL0ZtmwrOnzs3PHGchaRDERx6Ee6d97VPWACfVC_TOovto
 19kVjTN4i4kGM3H7VXLtAemDhT2YdhOlaHcGYJc0EgSqXN6qPOe9QLZYFl4DvECFaEObdU7ziV_i
 ndUu6GdQWcA.J.Q4xATf9Voxq.oDhg9C8tsiY091eX9ilXWfJDMLepz8qVZUWDZJpZMVY9vEe9EJ
 i4maplZPoI9ocNenDnFEkB2LYeiX09vbKhIEzw9gqFKL8uLyWAmMuonNb9AzMEs.BUjBJ5A3Ua8m
 bMfQnEDwQmzBd5k_W3fIRFzeklrDB5cpBFgXAUpcG2_ImzKbci9.XwJDwWPcroeUJ3KEMLP0-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Mon, 18 Apr 2022 15:03:08 +0000
Received: by hermes--canary-production-bf1-5f49dbcd6-b5q4c (VZM Hermes SMTP Server) with ESMTPA ID e12cdaa14792a510c07372742bad7207;
          Mon, 18 Apr 2022 15:03:03 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH v35 06/29] LSM: Use lsmblob in security_audit_rule_match
Date:   Mon, 18 Apr 2022 07:59:22 -0700
Message-Id: <20220418145945.38797-7-casey@schaufler-ca.com>
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
index 3666eddad59a..ee5d14dac65f 100644
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

