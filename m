Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D1C45031B1
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 01:10:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354703AbiDOVZN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 17:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354600AbiDOVYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 17:24:24 -0400
Received: from sonic310-30.consmr.mail.ne1.yahoo.com (sonic310-30.consmr.mail.ne1.yahoo.com [66.163.186.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69270D1129
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 14:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1650057690; bh=Wc9vmFaSeLclWZW27NYtiPedH82eAks2io6BkS5TCZI=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=TSolbHrZPD5mBP0C8P10H5o+HwdBmehmnGMRE4LyoUl9N/eGGimgaY0IcUWXxNpSkd8FRK24mpTN2SSx9JM1N9iYBolInLTLFeyyJuLZ25CrbADKwIUM902jqvwDg9tg1IcR8BkPiWYPbG0G8qPGS+WzeMCGU5W/6lsVcJsb9+lQgP9m5NGa5VgCyRCPnUYtmVDGUaHDKhkYvA0CNbx1R6XP04Y9ThaQFWB5FIwf/5eB5m4iCaJb3Z7aDuf82Yri6iaVkpDRCeTZPqEMGYTD5dsdAInN1lizrzCkld/0w5ICw0CKgrT216xXdkDPuQFGfLV0eYt7Vt1JEdDEz4qFnQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1650057690; bh=XBpvnOzZCnpvV8hduzeqoQNKBrw/6ovTPtyVxAZDLjX=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=idMUgep9693LfZ5wpKr5HJzvYuo6PK8GdfdgRkcs2+rvAsr15f2ZdZolTKkHz0z8dXUHFpYiMwdj6uplMII9TuDQ1ctdjs/3U+9iDlfzE5Vgh4+oa5ip/V8BUPotMbn7o/o3jyzMZV0UtgIGDQLH8tttec6VhkcYDZ253xiTDC7DX0ALGw6ubhFxP4SVJ9AS/R6cKRrq5vChvQYmAlJKG3MFlhff7nrBH+sJTR4uze7EiTKT4Db3WtSXoa0cq2hfzl8kJN5ctq5SFjwtYwuKLR+k+n1+j1Cf/7x9tljyL3G4q9Qd6F4eoDtu2hhw6C/+FlenyuZMnAnrCRxYX7BhxA==
X-YMail-OSG: hnM9meEVM1nY0JMSMjW.9vkbiHOtTitB5yH70WhroD6r.GAi_A_mU2iBqF9Jr4Y
 ksKehWRcB9QNj2CUWcRpU6vBR86nL8E_u0LsXeafun7P_p9n3PqrtaafD1uSMcz7r5x1amJ6ujs_
 g_lFfpVcX0RAdbQjann4ysYg0Uo_dy1ZO8iF6QAnunL5WaEl.VJ0Sof4Hn_fEtNeB.rwY2A3RVFE
 5S2g7eCPtFP19S9SXfmIGOhsh18dxWpo2C7tnDtzxojDHLkEY7cRCShmZOqijZkq4K3pNLbb8DHn
 W1_Lcq_nhy.edM3EX4TNJ8C5HDqYLH0osOpZMve4adEKbEeK2xUxa5uMnoTagY4VNRvP8RDuAKL5
 W9AiU8dNRWLD2.xzd1AYEws8vGlEAbcTfet610JqZgaqa_3SFo0Hjx4eK1UCbuZJS2PC.QIzBPmZ
 urdM6Qw8oA8VV24kQe0S6na9HQHSuaf5b8OKULbQgxGMEBzPeeq0v2bTQ8DvrbMIXyXLPnhnc1Sq
 b2Q0r59BEaP8yaN9idOMDcpdRnXrINXVlaxUEiC7oQqYChppt3bWu11XcrYSXj7NHoJasZsZ0DNe
 A7vWseqWO4zMHwk4U4MgdNb_Uqesr5b_3sgsfGI5uwPjpCYNG63Qp5.O6GKMZ8uTjEOJ9dg9D1bv
 bXW4yPGRoD8JqowEIQrI2a9erJrMnkh7.i.yxOPuZv3SBqrAf_BcmtMoQ7lJ6lETs1S9aLwOTR1G
 5SZtRTre5kHzNBvkFsg8gsg90b1b7GSmCoe9bafhSFcO4JthaTvKptG11rf8MfAaVXs4c6zH3DoP
 2fLRfJQYcDMoOPscKgwo6Z9wqQ3Ns1FzBTfzu18tbV3OCO5MWeG0W7jLFFmAq7XUpaxpYhp_7dWQ
 PZD9x76ctuhdC3LZfaAnWw9kgnuQx24K_PmDhyWOvtUV80zibsBCSjXOnNNWXuk6PX3OJT4Bjrm4
 TC9.3.1f.1cTgh4FFRJ.m29IX0wrdvdqfUOSLN.CDPfYlyz8_H_2oEnSptfQotlxgXrE.QrzgOoO
 1d3k2SGd24ph8yT6VsDf6.F0JlGH21zrv3wLAm7qrYrQLWlqIv4VXgNS7IFxOIky9.wi5p09FWwT
 P5wXdlgjrrzdUtAPrPsjWJ6EVmosKQh5oss8Gv0YGLHxRF01V2HuCY2ZPS5dR09ztGZOkfmDSLgH
 9_JYZ5TUsE1Ur0UcpLHnx6XQVbRZI807thzyOq7Y8OYtWbkTELjd6p9zI7mnIQRPT44lZ.jGTBlX
 L1gn9qMjRya9ZaR2BtP2Ee3w_vY70SRPQDS4tRhOiQJKN9dm.uTtoO5k28LvZ6K6aIQwdVZeStl2
 kxqRlZ91FM0WZHvywsiunAFGEinmXP8nK0XHp6Gi51P6Lnwlf_2CnZfxmy4X9LVuTm6YYpxvMmKK
 CtOu99Ix1TA584K78ZhyYv1ljMmt8OYYJT_JGeoizAotO05URTlsfV5p3uedpxCtizEUd1g1Zxo9
 0cV.uHusQ5Slv8LM5KGZJRk1aqC9DEtHDiebvgE1jbhQxgXgJkK3THqZbBAO3UEK4z_kIkWrJzab
 h2GMZOBgKeoxSzKk5U0RgAfwK_XPzVzKfbbABTe9peYXBtj4ZLwbrZpgOZLm9GYXmdivnPsaDVXn
 38oxqBwvY5anQ_nxynyA6AJh395_YSOom4rbRGdIDNBRdFvG_UVdri.qJIpyBolKsKQcYhTWiLo5
 sxK1cUg5ysOa0_chxeI.rMg9eVZbIs9pK1AnS52VMlxK3l36yCq9A7HzzFpesD1iEWYWdGKqeDxQ
 rQ_23A2nnkBvfL7KF5SaLggzuP6jStyuR7tL.mfFi8B._66Ou.2TIBU8Q.B.hwPPhpN9RjenpZ21
 RNLFMlQoJq5XGI9TG0nDXsdZFWCwFZhe7JyUbOK59jiZiC5dav4h9ZrC_PoKlYFtuH3RtqXuY_u6
 duKnUaPx_cfTjIk2GNgQO7j4gFrbam_nWHbmmwrIOaqu2mgXqLXZK383uR7mbRo.6mX1D4guQGFS
 lUUhREM8Tf2HiEDJqDfNTkVj_gHcvOAijRdeU3vrXKPzCktOSBNZcfN17WGeMtSXVCjnzDEHi58A
 5WkBXwOwELR456e.FIefp1pkjHPIXRK1TVfD2jnLW.VJq2hWfz.lpxi7Y.j6IqDDhYnd_A7go6By
 JRjushnFH6N.2jEXqdP5846K5Z9tfhccBC1ieYobGFO3.XHNOa59Nqffji9jtqLS7oljnovcqhJ_
 Xf0aLmvwR.OAw_RSwX_zLweCKArGH3wmZzGdaGK.iOdUQ9IAgBVtcQsHWPYo6OWbMPAo-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ne1.yahoo.com with HTTP; Fri, 15 Apr 2022 21:21:30 +0000
Received: by hermes--canary-production-bf1-5f49dbcd6-b5q4c (VZM Hermes SMTP Server) with ESMTPA ID c91982c747db758d7776974a874b1b0e;
          Fri, 15 Apr 2022 21:21:28 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH v34 06/29] LSM: Use lsmblob in security_audit_rule_match
Date:   Fri, 15 Apr 2022 14:17:38 -0700
Message-Id: <20220415211801.12667-7-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220415211801.12667-1-casey@schaufler-ca.com>
References: <20220415211801.12667-1-casey@schaufler-ca.com>
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

