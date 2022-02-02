Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C5C74A7C28
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 01:01:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348239AbiBCAA6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 19:00:58 -0500
Received: from sonic311-31.consmr.mail.ne1.yahoo.com ([66.163.188.212]:40598
        "EHLO sonic311-31.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242403AbiBCAA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 19:00:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1643846456; bh=fQfW5dthVjGFtJA2gwR0MhT0Aeepd3QCgSYtlUwhOyo=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=dC41yTZ83ZN+Ojjuei2pxlXmlI7FY5fWORvuJy7NgpJuVipcXxL+0lOBGikzhFUqSBTApzc9S96RlaaK8bW9HkwF0kXAsyiQohH0fIUqZT+iROnJuIqguDtt2JXaFK1tNmAacV6GWqQFsLGinV+qxkdygZq9mZYG9DYVwU67CbwL9mUkbEGk2nOQ073OQ1cw2Lu8N6De42B6eWDOGUsySWY4aAgkRySe4QQUaN57G4WPD3Xn1xg0anOME035r22Z6xG5BQQOv32ASRige9ndaTZygO73PaMScbmBeRfu2itZIdpRMxhGVsw6CQu6S4GU8yAkOtWShmJcR9C4LyNTsA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1643846456; bh=5JM7m8MZbB4yMdxh21LgrB95d+z3weTFMgYAuW+kQAA=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=F51KCfuXLwUFSKsCei/kSrAzyY9tfkmzvp4+jR7NPqTfFyuAFQUXcjLupm+9+pBrN6d23vHccn61tNnGOc0TNf0rRv7r+Hqp4Yi4yZuzaSxPy55DIYIDMknaFEnM0BbHwqBawaWKEJ/9UijAiVmjNEd9c67bpW0j5g58ovjT87Gr1j854+vMMqkx5Ja7OZGDfCXgyR/oBrjO+AYF0gWlPxL45qd1CNBO9WF47t/+krkOr75NKlC4VmF/9Nk0U/DfzK/3buq8UcWJcY3oSg0J6SI8mKhnSE+LQWS5jl1CPvqdrOZDb80+5ME7HWVRtdmFA4MDC3TVRKsaX853ScBHGw==
X-YMail-OSG: j6sBNu4VM1nzWev4aNc.IkaUAaFKB3stnY2m9Od4ilCgiWTtJCYLW5gcOwsKPtX
 4r955rCYOYU_6eDx70Z6nFccudXVc6R2dQ2sXd5quySkQhU3qH4bz4Kjt6Ju65iPN7P3630amytC
 NR96Hg6nSIt2kauyu0R2j4hiJ4g2j8rAosKpwl_6n02Ez5fMkwGG25Xdf2y5MP7g6A534e5ehODs
 YfCDwLEyYoZZtcUr_YPQ_80NwhLmfhBvqlN1FnONAHjIWFLycFQrcDLLDoPKdN6PQP_ShFPwVrM_
 z2ZTCbAlv.73dDJ21O9oilh9hmGZYWvAKUJif.8WM0uXTzcwKo2ewceuTzPKQm2I.qNv83wkHv5C
 BUDis4mJcNs2.bzHqLbJkSNwYUta7vuvuPT3mA2Y64htTBUHJ9mM.xZjgE9HrivP7SoHl9eAiTrv
 L33_2TUWoyypbtQccl9IHaaA10_XdXe5tRRaZuUseVn6tRT28CHeuRqBJWajtGYIbmYHNY63iEz1
 rM7Uor7tgXKeXsLvIpHi00fzjEtyr6rQvBBU5ltCxebVLaguV7IGkbpDtVpDsRYAqRdjN94bs0Wi
 1S4lvvkWzY1ZdvR4LrHr8n3o3UUfnwIJsZIp2haj4XCbBpI3xlI_oXg1c9lDAXy5Z.X26hydkAoT
 mrPF5kY18gB6EBLTEZufe3oQl3cpqixQIvIwO5lLblWWGUJdoiZGAH.l8XdttvtmNmEnKWDoQ2iU
 xU3vaCNJ57QJd7_CHzFCwitO2VhGt6iFqh9.Z.EyLrFnOI1JQY4uAdkfDYBkxley5Rw5oYLj5xKT
 dW9I57sB5ahzvAfO05pGGD55TQgoOanE2mmfw4eAUIOaPA0Y9tuxfsPVnbv8JHPyRzCAhpcfus6O
 2pTjvSTJxuYRjMGHvXkThbzeC5v1aMXs7_muyxdb6CT8CEeV_C5ZStZmb8V_YIvwccW_hhwjbn4r
 bqlJ5W7aBilm4fXL_XTOGWBxYANnW_MqwZC4I_CVDKfnVs9RtWi2jdcoV5UWj5BZsHXjqfF.bVJO
 cp4THTZEZtYVlyH0YtvHHoqkKpW7Rb8XHP7dP_B354VSYw68tSAlaoV9U5K_VdUdCatBiriG_xyY
 Tha21i1IFU_xTEaAkxnp6pNKYSpz34VkARJBkZ0pH1qVM1eOhFqtSh2fZw5qZS9LOT7A98DNpYnG
 cn5XR8ppyLbWOUbK58lkHvf_CkefERSrcbd9yYHD0i8T1szw5q761I7r_yg1O1jU8CgkyWswy2eZ
 LEuVDKEkx2nr2mXTem_irfs6Avej7nLMvUmeXsuzMeqrGprurU6ncOXS04fZ8AhhFhR0rX2r1oSF
 J92NrvaLehWofCqsZ6gj32Wwub49y9eiAjhsfPtMnrR_uulLjf7qdZ0U2ifx8sSfLeFLD1f2oN7p
 aSWfioxsWusqNMs3TL1KGbmE2Ugk3zx6Lw_4dU7yP55pTOnHV402hekDdKzk1LPMppSRE8kfGyrm
 eZGlAFOwGiHmWxwxmpYvh74.kCIKhLLvRr9wNMRtELqH1LpjHPPvZs3WBZOotSef.5tc1X.JqUfs
 Vj1a82ax.5AhBj2.DVZk01i5RpktSPBzIKe2HsmX6nyxBfoYfFyjFKq_dFaQFTNzENDBvPMUPi4m
 VcLbzX9WDyMJXqCo7xrzKDle3.J.pthk3G9stLbWXHOHqvwALv6SZH1im_w7yw6nORoVco.1wJmw
 eiNpvqUN54LG1HTdtQVwFobL1uq1MV8plFCTQmw9XWkGao1N7GfJDY13y_tnsliCdtK0jPRFcPzy
 Pa0rdkVrPR1mdC7ebEZwR7fDmaf5AvI2AC73uKeb97BYaO7l1RkZ8eppecnpEHPWARzlD2v1vkut
 bPJOsJEGLUQa35T1C2jTWNDG_zrZd5WIc31ziW.wL7sJ1EdumgHrg0k8ojxthCoMgJshCjrfSdX3
 LBhgrYX9dzJFIUTkZfvovKMEK3yK2Tl8IT1yfc6b6cb1jqmV5YamTqNXhv6jIwNDLp8VvMe5eZVh
 Kgvdbd0Tj3Xn1_Y0tuafH2HV9ZY3JJ_e0SS08ikG1tSgcpoCqirBBumkM5QsO.ooxXWA4L1UfdCx
 sYbYjgPaySFihIEjv4IMFg1OhCwMkNb8yDFFn3PMdOOk2tQ7Mlkh0Qtg9W__MS4tEBxCcQRAI_LK
 0.QqA2UNGcYSx9JE.ByNeJCrrAzc3.QaUbDbiOnOhPE3OETJ6gjqHRfVbuIHHNpfLK5lI_6vT05e
 Q_nF_y.DurTW_8rncyKXop4kzrO14y9yWvmA9JY1m2r2uAw--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Thu, 3 Feb 2022 00:00:56 +0000
Received: by kubenode551.mail-prod1.omega.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID a02ef9b2aefbc6e63003d79c476ffd53;
          Thu, 03 Feb 2022 00:00:53 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org
Subject: [PATCH v32 06/28] LSM: Use lsmblob in security_audit_rule_match
Date:   Wed,  2 Feb 2022 15:53:01 -0800
Message-Id: <20220202235323.23929-7-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220202235323.23929-1-casey@schaufler-ca.com>
References: <20220202235323.23929-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index 1edbb362ee72..3b734ebb7e29 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -1946,7 +1946,7 @@ static inline int security_key_getsecurity(struct key *key, char **_buffer)
 int security_audit_rule_init(u32 field, u32 op, char *rulestr,
 			     struct audit_lsm_rules *lsmrules);
 int security_audit_rule_known(struct audit_krule *krule);
-int security_audit_rule_match(u32 secid, u32 field, u32 op,
+int security_audit_rule_match(struct lsmblob *blob, u32 field, u32 op,
 			      struct audit_lsm_rules *lsmrules);
 void security_audit_rule_free(struct audit_lsm_rules *lsmrules);
 
@@ -1963,7 +1963,8 @@ static inline int security_audit_rule_known(struct audit_krule *krule)
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
index f1c26a322f9d..e5ca89160b5f 100644
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
index 29fc50322b1f..5b2dc867c57d 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2683,7 +2683,7 @@ void security_audit_rule_free(struct audit_lsm_rules *lsmrules)
 	}
 }
 
-int security_audit_rule_match(u32 secid, u32 field, u32 op,
+int security_audit_rule_match(struct lsmblob *blob, u32 field, u32 op,
 			      struct audit_lsm_rules *lsmrules)
 {
 	struct security_hook_list *hp;
@@ -2694,7 +2694,8 @@ int security_audit_rule_match(u32 secid, u32 field, u32 op,
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
2.31.1

