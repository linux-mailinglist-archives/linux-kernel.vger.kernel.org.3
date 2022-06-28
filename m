Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F27D755DD8E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242843AbiF1BDN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 21:03:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242803AbiF1BC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 21:02:26 -0400
Received: from sonic302-26.consmr.mail.ne1.yahoo.com (sonic302-26.consmr.mail.ne1.yahoo.com [66.163.186.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58C6222B31
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 18:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1656378144; bh=vcSW66Q/0Hq4FZPJSQERxuYrJ2YeSRucdjp9kvuPOwI=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=FLegc4FGHhz7skHiIssuUmB2eHLTXALnzoFkC1nkk8kotgKXd0gMkKy58+zvziktTKNQl8hixVRhQggL8Ga5+NjecP2TMRR2IAiPWIQrwvlE0sw59mY0HGrOLIy88w4+baCT4iQOh2pHndseUwJMp0S0xzF7fcuWd8cAM7FYwP42NOEi9S2GOXEYIeNoHiZN9YpUWesIOvZkYC0EIFY6Azt2iiGuj6CsshaLc14dOd1ZeuBvlgAATx9QLDoSw1WReH9ko5YMwQYb0FXFKFO00VTxz41bCTn+XBgmGH+P0sf98WXFNDkvc4X8LFV1LSesVhAntP0J2O3IC9XcDuw8yg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1656378144; bh=je1iv9XeAQ25RoQwoMZ0/J1oTsr2zzYTozag6j6oUJq=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=qv2aPHxLXt49TgdBY7Exxv3bhvt6h7HXqPhBfBH18LYzOuNQhXPEhkQ7DlJ1h2pW0CtUYsTaq8ZLXs14nXbMxyQZdsCovMcc6YhpmuQ2iO1XlM3dijEKxSkpLuQ2ajmTElNGUm/erfNLugPw4cgXvdNN+xQlIUBE04IDBbidYPDVGPrrEBRR2+/BUoBlATJBtBKKlzgJob5BYYI0pe7XXkduOpuDmLWmKoGEV0AtlP4fiHwGMh6yasePczTRiWeD8sUaS8j39mp6z9przkXkx6oLW2sAIHwtib9Z7V+Tloya7LYS7CiNNJJfZJCxhPK+yyNTjiOVUqV3Ru/0sUcBmA==
X-YMail-OSG: 3poEk_MVM1nrdovmES23BHNURK19TP3oJsImC5yiFWFh5aF00AwYbSujBqbaDjf
 iT.zR9o_ToeP.V0LwwzvSWmNjFZAnjHckF_9Xz1udwP0mCEZ5sa4BLJUKMzXnm5CxkM.TNW_LD68
 KPogmYIHQ6lzrIO07zJgCNrD1nTnYnEOrLr3R4hBlBx.uao4JlawodWvKqA.4b4iTwBWPTZbT_qU
 05atae6EJIzU0UeJHk2Sg_Yw_zF1TGIP9V2cfW5IYfoIsxwne2uvkED7TLB0HEkVMMayVafzdixB
 XM1SO9VHWIgAfAzQJ7gYlD8Dc0y63THukgoTc_7KOISgVAVrt3RrFx_R10e5s4zHO3X525MebuXa
 uTigG9hiIfi.s3qboDzFYyWeNMRc.2iz4AwbrfRYTdzxv.w75UuBuNbB0csAomcFtC79UrrTaD9A
 xnQCn5FH_Z.WpDndBVVD7g7El478HMEaGpxlhrIpOtHdHWgRGaUljDG_2iz1XcmQJuDnRBhke1Te
 l5R2MbJkW_hWCUqwYHMYsJ5515KzVYQkb3hxCMQIxTYDNIJZ6Q_m4dAjZw1bkhBf3mysv7f1QMgj
 NcAdMCXh4r9njqTSciD8hErJqLY0OcUOme2GJfWobqW8Zb0KbPH.9H0OHFQF8dC6gaDppgiKb1qY
 joHMcfa75IBPOXo7DeifmxAdYhFwydgr__xgt0J7k649jqZcBbdOElosJZwzW3PdyhS94bQ_Vxf6
 fmx9CqsaR_fCbxkNQ7yiQOGd0bhP1JYt7jK15W4XcKOgbW1dPLswPQJJrIkL4W1OHSQohIqWjezv
 IXeCfQopgCX.R0kWgDCsSjnCYZeoUKVFe2gKb8vp13o6md3A_SfSWA6ffZ34HXdcUEUrYabAn30F
 1Xx5aIStRBptwV8ZXl7jvVyVWX1PGjkwK1UBMeSWSi5JCCgryidVCCGX4EitRs7wQDjKw_LCl9X4
 3Nq.XendfAAYJhESTfpeh3zEp2uj44yiuN3JmPBUG1EAsurKNC34wTBZiNvpb9i2rv4ce37rQHIW
 fVGOtz82M72WxWBk.y3zy1UY.Gk8ql44UIM1.FafJ5B4zBl08iP78aj2PMen4v92AUHVKe.1kvc4
 jpacdADbpi12qyIq5vShu3hyBi_.KJCtEWsFnm2_c3CuTEIXYFkle.o0VRI0QAPFWQSpypV3GbHV
 m.pt8NtBMfBW_6fjnhzh_IBzQdNSnR8n776o6Tjmxksm9netdfMKMLZM8QHNMg_sCGCMrEFsKI6A
 XXnTc6k2inCz5DDNX008H2oCS87iqoSouX0xVNNkfjll.4YIHipV1ZaPZrbjkIe9rK9wP3_qz4LQ
 DP_WMyD3dWQtK1ocrsPCNF.vXh7wypgKVX2Uz7vaXN8n.T2FF8XKEYhSYS0AzKt0S19Z1IR2ByLO
 D1HsIdz12dWwn97znu28OuJ2mhNZ7ldb8WyYRPJYgeObxRo_ktQ31IkNIttBvCfMQwrfiGgeBh48
 DflSi1METcG4eLZfxHcW3iLTxwnPD6o8eljo3ko9hb4W5kqWdEKmhU0ZJdEgm9.x4hcTSVNWdjMp
 3LZWD05mSalCkvNuxxv8kwerKmo6fNmtLFGtEc7zNCMASwF6luG4Rn8VnFjOJZqr3sjRcp7rijZW
 qm9exlAEJoZBZWa30Yx5zq_V0xhEUkNVn.rE5l.odm_v2J3fYh6FV8SPNkBFJfwJWxRne2N8QEJi
 72g1dr9rqGhFgnDeu25TTabIUdArUzoUJNXXHTO635NFcI8OjtyeRaYo4bzYvW_EBj9AIDkCAmKw
 BGzWm7OBAtbT1L0Qlv1MEncBmqeECQcH46dIahgkUZX2bHESfoiBQTN_it4IjdhcZwDRBW71UpRm
 s.8Jjh3AjjJLcGIqHSEBb5FWPpwiKm6N6OYhcMlY33FclWU5JynTHfAmjGC7hRDzmdOqyM5yUSH1
 1SQrrBbm5XO3ip.dBZnfokh9mIMWkQ9LnWXMEIapmBt.QYTPUGuf.nOHAuvj06n2fDOLQgHriyem
 6IxfvCrsiRp.jl3es6bn0QVbznV9Vft9RJprQMeBocFhZcOSUIiwp3PzUJcsJ.Rs._9BxlwFJMSS
 JMkOwnrf7mhgj.UzgenWr7YF3qttSmSkJhh9rabnBgQ1UKP5wHmb01RlvAIWngV34nj.zkW63iIS
 iKISeD9_BHn2XC8pByFQ1I0P9jUl.tqMnbDaWAAKpR7mAcHtrSXsWQiwVV3XqKwhmOVNq0K5pVyJ
 aPOnZJ44FZUV_eB3dr27yow7RGSyD.vSdpekXip96ebd.C8CMgILPt0BI1hn1a8VP9hwVLSIUFCM
 shPTzgeUWSe8035Qlk_7.nDw5WRZlYv9lb1sh
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.ne1.yahoo.com with HTTP; Tue, 28 Jun 2022 01:02:24 +0000
Received: by hermes--production-bf1-7f5f59bd5b-wm5tz (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID dbf52cafe43ef47006ff0c558ab03737;
          Tue, 28 Jun 2022 01:02:18 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH v37 06/33] LSM: Use lsmblob in security_audit_rule_match
Date:   Mon, 27 Jun 2022 17:55:44 -0700
Message-Id: <20220628005611.13106-7-casey@schaufler-ca.com>
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
Reviewed-by: John Johansen <john.johansen@canonical.com>
Cc: linux-audit@redhat.com
---
 include/linux/security.h |  5 +++--
 kernel/auditfilter.c     |  6 ++++--
 kernel/auditsc.c         | 16 +++++++++++-----
 security/security.c      |  5 +++--
 4 files changed, 21 insertions(+), 11 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index 5b0b2a596cee..95ba8c223e0c 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -1957,7 +1957,7 @@ static inline int security_key_getsecurity(struct key *key, char **_buffer)
 int security_audit_rule_init(u32 field, u32 op, char *rulestr,
 			     struct audit_lsm_rules *lsmrules);
 int security_audit_rule_known(struct audit_krule *krule);
-int security_audit_rule_match(u32 secid, u32 field, u32 op,
+int security_audit_rule_match(struct lsmblob *blob, u32 field, u32 op,
 			      struct audit_lsm_rules *lsmrules);
 void security_audit_rule_free(struct audit_lsm_rules *lsmrules);
 
@@ -1974,7 +1974,8 @@ static inline int security_audit_rule_known(struct audit_krule *krule)
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
index 9820f08fc47c..221196b0cde3 100644
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
index 141922732d10..ade59e3638e8 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2697,7 +2697,7 @@ void security_audit_rule_free(struct audit_lsm_rules *lsmrules)
 	}
 }
 
-int security_audit_rule_match(u32 secid, u32 field, u32 op,
+int security_audit_rule_match(struct lsmblob *blob, u32 field, u32 op,
 			      struct audit_lsm_rules *lsmrules)
 {
 	struct security_hook_list *hp;
@@ -2708,7 +2708,8 @@ int security_audit_rule_match(u32 secid, u32 field, u32 op,
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
2.36.1

