Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A43444D55D6
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 00:52:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344904AbiCJXvE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 18:51:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344896AbiCJXu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 18:50:59 -0500
Received: from sonic315-27.consmr.mail.ne1.yahoo.com (sonic315-27.consmr.mail.ne1.yahoo.com [66.163.190.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1B0219E08C
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 15:49:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1646956197; bh=5r8Ggvk44cQdmfQy96U3Kv3d7tWnf2od+pwmkwwRCQ4=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=tRXDlLZi0M1tVA0AE/mVJWLBDiTUWdXNsGODgMgld4CUzaXY0cdU4rIB4/rZLc07qyk6V3/trmGsn+z4ORZU8wIbQIRr3GxZKhQLlRpxkWhHkgCMV+MU+16i/4EvZ9GzFUGVlMfM/zG3Y3GFSR8PoT7ShpvOU6iQ8OIC2wcS1cR1tQ1pnoSvNaqS9zpS2JvwaPiIGCCaEWaHYFJASrWyY57Xu2Ny3isqofl/3XnbVziAmdFw53y0qQ7PiSxuiXsdv8dhibBAUN3hBD8xrkbQDKQmmYU83I+5Spz1kRtU514m7SMcV2MWS+2/lHd3lVuApLOrA4vhvxABBb/3w5ETgg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1646956197; bh=ZuZtQJM5ZOWF+KCh9YmeSoIptBoAn8BYI76+kB+rCee=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=PbEUBJAI2n5kyt8heH3AHdXgOh82kRdCbEqm0j6VNiHN3gHvA3Qi8dcWXf327JyL8OSS4vZYj1L8jCSjOZ8Ky/o800d8r7QzJ/mcdfRhcTIHBgyHIjlrHGjMePUKTZ2QCTCitM37Ttv2kvo97iagSPN8Nb7Zdg9sWZBikInJotdy9orquNuezdX2zzglO8dPE+1vvhwbepLgHBi1OFjxwa8u2qJqawquc4IGEzAuhaa3mXso9j/313CeJG3+1oMbN0NBg7pVCTXVIsELaQUHn+GOrpmDQAOEaiJksm/73par4Z48zLqo04YVZqIf95bnjhXD1E+Ip732g1MieBMflA==
X-YMail-OSG: srCp.GAVM1nSx1voT_KacWVz779EhpvX7kRYUJlP4mzuEFomeaSTq_KZvYTk9Ke
 ImeesSGM62E8R35ce_yP_LcaL.StxA6amcWlEzhrp5UY87pFH3QwYIvS60DSNZHfwi1yXn0lmVnJ
 0wCUdbkhT.13qh1d6CLrejSUZ8Vy8WZhYs.EsiTmuQ3tc36AeAZoZpN3bS_DTE7FLOJNlvM9afE6
 6_cEsfHUX7l.bBKrS_BSdG3JVElF7pK0oA8zK4h2kFr_7gzavElSXC2u3urOeAMTz37RKQHgf.NV
 V66LJYL9umsM2bOqDI6CAvzJo2OaBB..VjZZWstyWBN16ecKIT4wUjLHua64HrMGkDrh3X7tZK2y
 ulNF1Xv9Zn6qoRGSt8l6_.9Mkn8nmgsO.yKiY1fP6LZ4PobOQKG55hc.ysrxxnhBepAuH1sElH.Q
 1UqT7.Ts99RJG5s_ctKVKQ0d2pPyKyKHBeQVyWRY6gPNOrvTz5lzEhxS9a8LG9vAojNRROygAbCQ
 TaiWIbcu23U0ZZbBo15IzVDKb1G6F.uuEQ1Y9FC1UD4uQxJFqJbic9huNwoiV5naNpr1DpX_wis7
 6DaOHF2eIU7vPS3f1ftMyhYf7xPoogXJNLsGkr6poIDtwwIvQmt5V6lrI654sPh0WDqnHGEvCJB4
 oAsbZbnQqWJSJuwIVlzOkqiQ97oFmirkibD8M6FzVNTKH2xyboc2fAkWUm7TuocM_xJet3F4v3in
 o3AMyIfYojPsgsM_3CUH6SZzXLkgyX0M6MM1.x57mgvJYF2j5fp4tiaKpRSDyV_KOZW4VS4u4QUV
 qkneoQ5TNMtmEFlt4nBOO4DTPxSTju.K7YxBFES8NcOtkuWi1S2AtXU8GAWvrWaa1diOB96T3rE9
 DUw6X94uM2QHByYGRptCx70DSsqUSzwJCpkMYMrk3NBCKAppBvaFfSIH4vEv6LqQXB8xBfwi0zYk
 0KqKFYlzS4XBdZb_RqH1_M2dtnTn3XaXEttreUEEJuuorkCsRO.xZuP2HGCIutDugQ68abPM2zjw
 04Ym.NkWFKAN8u38..UPyp50Uy8OjUCb4G7aFTLs_3_RXuEr8CLzeCHkf_AUj_wV_ixhelVAdYdH
 421iiib_7u.UBAlq.zEwCC_xP46HZaEXggJBgiVxJ.6A92TFf3rLwmkI0zQdqji19oPrJX1vQK8h
 0eKdu5oKVuY7eIK0u_lG7E8w8nGXAGktmh.XiCnE_OK_83Em7gaAvimtO0lNauCEgf5qhag7K614
 VClhd6HWyFvXKp0WyxwKN13GSYp.txb.IoN8gA46y8mYA.HHHzHeiTtRVl2hX4FlBkoqNaEqojqt
 H2linAEc5Ne_9X6jl3y9r0GLYeAfico.0K1QjWkE6cdLLQRURojtEB36KZinURAPiYLUzTlP_Nec
 MR.6YZ_KiPxt87zhC9vmkh_LbJaCHv7gEoRUSoJSD9BLlj68LnsIvcDyVfOHXMeMm4qzYAdPWRPR
 ArI_OGNu93DLw9SVFj7rr8hMShW0Gyf4RKHMR33eIQjw674BVmgdWcbv4gK.pX3geB3zAdzvLdti
 FyygtOSpU_.QZyFvtw4NMqiXKb8fg8FWnu3KplNGCO8W8jdWz.ug8Gf2K5QbIAUgaNQluPIOu_NM
 x0PXTc0sNJso9FY3UztENfvmnUjbZ1ftGYPHXRLI_9uYn0lQlXJCX1y7U3hqnd0deJzJV6T47gda
 Nvt_PRvoOcJWpb8kNl.dsFgJ_GAC9fgMkYH6GLnhAiVT2fk5H30_FrpIZ0bTo8PMqYd.l8unW4MI
 Ak7VwIQkUDfRCsAm2b8d6gk7GmJs9r3Z1NbHIob7Y02VRnIXdOQjCy92MVw82ABFbzYJUm5aDK4V
 tBhr50fWBogppEE6ZecsOBeXacZBHFBpMAKoCu8LNRJtYjVtZjDy4NogJbjTF.lHqmlsXcBBSZZf
 oGUKzQ4dhQEfsiYFEm3G2PtJVhmQkifLSAOSZZKTMsK2LAJIlzdDnSPBm_aqHBBIuC5mn0ev9La3
 EfIiOY81rVvfb7zOozO01WNedZjRvKgrnKeJaveBykuUDDUTHI0jalGliaMgCSiTB9808kqgjc13
 xj2ejMJ8WCf2a5IgzjueVHj2lUJ57WgOwoTPvz479o1x5LQ2tExKTg6m2lG.G8uKNUNhDlCixOPS
 h9BCdhpPswmMWnLbsAs.3brRgBSE2XwcsrjvpWXxXOGlX_08aaXyV2MwFekMNgtobWgwNUKCmeSy
 GRJOnZC8HmOl_4Yxi4cydcz_ezKh.ZCLHYRsV.Re_zgRgeU8pAp.cx6EL9Fao5usf22A0_B0cINX
 PIxB.qgrXCbhHxZpUS8yKuq8ufA--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.ne1.yahoo.com with HTTP; Thu, 10 Mar 2022 23:49:57 +0000
Received: by kubenode513.mail-prod1.omega.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 50d9cd6aba58fa399bba8dff0c177f96;
          Thu, 10 Mar 2022 23:49:51 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH v33 06/29] LSM: Use lsmblob in security_audit_rule_match
Date:   Thu, 10 Mar 2022 15:46:09 -0800
Message-Id: <20220310234632.16194-7-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220310234632.16194-1-casey@schaufler-ca.com>
References: <20220310234632.16194-1-casey@schaufler-ca.com>
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
index 1c3bce00f5bc..d02af9b77f8c 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -1947,7 +1947,7 @@ static inline int security_key_getsecurity(struct key *key, char **_buffer)
 int security_audit_rule_init(u32 field, u32 op, char *rulestr,
 			     struct audit_lsm_rules *lsmrules);
 int security_audit_rule_known(struct audit_krule *krule);
-int security_audit_rule_match(u32 secid, u32 field, u32 op,
+int security_audit_rule_match(struct lsmblob *blob, u32 field, u32 op,
 			      struct audit_lsm_rules *lsmrules);
 void security_audit_rule_free(struct audit_lsm_rules *lsmrules);
 
@@ -1964,7 +1964,8 @@ static inline int security_audit_rule_known(struct audit_krule *krule)
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

