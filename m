Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C02124F8A0E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 00:15:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231717AbiDGVgU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 17:36:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231680AbiDGVgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 17:36:12 -0400
Received: from sonic310-30.consmr.mail.ne1.yahoo.com (sonic310-30.consmr.mail.ne1.yahoo.com [66.163.186.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E9A81667E7
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 14:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1649367249; bh=GCzw8AbIKSF767bZWFoiVd6qOcKopRj1eBVPCUHsTtQ=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=bh1gViHq6KdUKY5pn3WJqU67ts2txK2gb2O3Iry8qUH957u4gMGhSodLVr1HkUzfu3DW514RXDEyRpdasVpI5nIQqw+UocjnR3r3T+khfKCnpJ1Wsmmb47EDDd/quD6l9Vsqm9rPw/zYXdQRR9FXoKLRkDCGDXlB8nNsNw04FfFJ6c19PeX2pXBEFejjE8hfLR+27xLASeWVOY9huugUvMmLiR4yxQr66oANJyQfXHacWpP6UFSM0vUWiX8FGFaIXC/U3rVxaaM50axTHbYfMuQY6n/jUGmXE/1Rh3MKYWsdOo33GMcyvoEcrLRZt6CQgDeBmO8aMVeRq2VyihFLNw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1649367249; bh=ChFklgIDo6SkCf2PCYreOpb++eS0TXgTlQ+/JK9CSPS=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=g1kiwzMGW6GIzAz0CNzL4Q0g016mWoEWSyzI0qte529px/ZqkiXwcnlfjacvl7WHft1zi4QF6Cb7i5q5cCH5TcfxlwtlohFH6dk3kh2Tg9/5OCrgVyfKvd0QpSiqWQHxt8SLc9OUkA5+v+Ply9fYE5gR6qG9JOX+pLJTYHIXzB/GXCUR+1Et4AE3OoQ0gRbJizbiTMoimGmfEQ79G71BnbU7MohzpjJnI2CxBvBTYHkP5GmNOA0siqPx508RS6JhHKcxse2oTlKwbE3zbrU2TnD9jUwcay2Jrkl+YsG98BHCtv5h+nxit6PbQoKixfd1MJF4I8X5wjhmyDwKSkT6Xg==
X-YMail-OSG: sKLYDQkVM1lufyPAN1fUu.bkDCs6.fpu5oj6_.fVjixIt.MBYtnQHKEcyIfoIsZ
 gWexlHSGDwXjfKPHjxz8is0yeKbLCj0G0W6EHEa9p0yhMFRWf9fVsB1p4qQ2.51PsnDmz1wsNyPX
 AfUkBjeLWcKDnrbJAjj9IcVnvVlE1SYBlhuKjwLyMbFQ.uuw8DouPvjRxKe5FSotZ5g5yS8kz3AT
 fn0aGLUohzmU4v7FGqXlWRJ3lxaMMlICSYGAMs6Bhtwjaz6tJBe67H1i7XcYcpuSeBca7B4ZpvZe
 cUgsZp8dIZ1tei2dE6SVw8N8zaWQf7kYsNK_gg9giLcNvMJRt6kcivSyO3f1_xJoSPbJ3FSfGZHM
 WQxFJoPxMPAhGu4C91cfLHGb3WnYFldWhMAQIrfQis95hmx7e7mdiIcIXln.VvCMZ84vXmQUg6pV
 e462gYpazB0GDIeHcjVKF8Fgunf5AF_5.SodvTzd5WgoL2Hg3DvQVeb.MUMhEmw55DLtdIapY2EG
 L_0erChbfIcuBN2C_WpWKKto6HgUG79BgSzjRAFp3cZcgjbOvcrWVtoAyG7vOUwa6oEV7.keOsJQ
 4XTqtIaEdO_kACPwzFmcyfQZFGMep12TMmKPwsw2ZmDRrm2pIl3G5MbRbIFwgqNwe4SUH3wyQLUl
 SlveSjThQr5KUVriK3T8AcnXajTRPWbjMPYnXIF0lme9oGncVYGQ_oH6sr2b_lgmGCZ3LdwKo_UW
 xAFRZLExXXXzY1dN2xn7qvsxcQMv6vxlAZ.Y59hioP8Q35iL21Jd8qjmIziGPjpQsmBdvLAvq37y
 fq0cwCuO2ZcbT5FtEvvZMZTRxwWdtN2IYNU7N7MhM6cqPc.PmjUqwbV6Y1WdTp3NiDPp2BXRbLF3
 .6JNz2QSV5YUNxf7VMPrCdVW8RCDo5.gdtXlVcJ8jTKzaNi7h1oNKcuZojM97wZWHEHGiZ36tSFU
 veW_DmiB8RV5Px5Ql0TdNNayEQmGN6_iOyhPiF85eD2NWPg0pWvdIIHQcrBoGcULSdLvq8Vag._K
 jRF1.L7s1UuII0VnHfTC.4oMwGumLu0bMYn.Ze.kjT0vFkpGW9__Qg2tB7pS2.0k.U7KEfb1MwR8
 besMTZFjQjOzdDhhyHr7skY3YGv50D9Cj5yJZf61vJooOZqOTKw0Aejmk3zUu7r9DWfN2x2QUdHS
 WPY6drQI6t9.l44LIf48HiMiYCNSh5MqewXjyBMAr_Y7JlE7a1mkRoXhZ33bbkglbwnl9F4TG1Sb
 dyHJRFoY1id6.O_ZE2sun2avY00e1cTySONyi6K0ESR_GmKsks3A5nM1AmFqjywdAxeUY38for3d
 766HNsZmhlX1O5H1LN8vOWhZp3.WNIwGwrFwW9sES56OW41iJfU.ClsABcL4nt0tqF7m_5uAtwS4
 IaJKJ5TrusoeJfDxMR_0yxagtIuMqxpYcjPY8sIPtCOT9pNiHXXnOQM80zIQeeUrWNBHgkYiukWP
 eEZ2uk5rR.jGQo4XFYJmSA6knvKXy7lga86IHaYkGAV22HHl2eu.yEf7VcK5RdhoQn3Zpl_ZJ4Du
 x8LALXm.8vxajVl54qj9E518dbdi9AcJLXh.uDVQh1.gGPIy0nPjCEOlAZUuB9v4L_sZexniC.qj
 dx2DJ04qZavEU11lML5d00ds5kwhdT6ayfpgS_wfcV4Y7kQC4YiE7ACFTh8kAXIMAIUh..ipRERu
 WQ7oLrGUGIynZ1_AWjiIVgXf.2RQDB_yxHCELeeajzFnmfCtugc7RS3tP5VxdtACu3NfdexX8kEG
 l0WTKCKXb2CB.2oen11oXDgJSnQUrBWnaH.E1kRs4LFbzILSkyI9JxCVWnHCvTeSkmx9RvHjaleq
 hAqH8VPec5SBUYHLW4DNfa7wD2oAh1jNg7ulJeUUp2EuBHCKDg2WqiWg0trSmITA90R10WhuREQd
 QQd20eeiiYFkqEtR9aMkSB2HAM8FBpcgU_SJTUpGKuPThRHNWUbQXNfC5_g_dI6W5fKB7VQeug4X
 B7rlavBtTWnUdwBzdZ6241JNj_kLTRr_6mFI_FiEfmpvpCoXPtFxEAuBJJ47CfSu7Fv4iIE9vUK1
 wxj.5RYdMu0FyYPXO1s0I.6_k66DIzeI3vXpt_LAdxO.gYE.aM.lZQMU0QTf9y4UJzwVYAxu_4zv
 CWgrNJbFH7HdwHAhWGICb24M2LiQ0W8dKnrIkKNNEN0Tq_fPqhOcRRB17RZfXEAXFy1P8HLyRIz1
 nxYnEGYTBrGK7BY4.5vvZ3JPYs.p3NiaGqSl4hVGy8MimrT3lGpQ-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ne1.yahoo.com with HTTP; Thu, 7 Apr 2022 21:34:09 +0000
Received: by kubenode510.mail-prod1.omega.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 6ea890d0479c56b8723f536561e1f9ea;
          Thu, 07 Apr 2022 21:34:07 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH v34 22/29] Audit: Keep multiple LSM data in audit_names
Date:   Thu,  7 Apr 2022 14:22:23 -0700
Message-Id: <20220407212230.12893-23-casey@schaufler-ca.com>
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

Replace the osid field in the audit_names structure
with a lsmblob structure. This accomodates the use
of an lsmblob in security_audit_rule_match() and
security_inode_getsecid().

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Acked-by: Paul Moore <paul@paul-moore.com>
---
 kernel/audit.h   |  2 +-
 kernel/auditsc.c | 22 ++++++++--------------
 2 files changed, 9 insertions(+), 15 deletions(-)

diff --git a/kernel/audit.h b/kernel/audit.h
index 316fac62d5f7..4af63e7dde17 100644
--- a/kernel/audit.h
+++ b/kernel/audit.h
@@ -82,7 +82,7 @@ struct audit_names {
 	kuid_t			uid;
 	kgid_t			gid;
 	dev_t			rdev;
-	u32			osid;
+	struct lsmblob		lsmblob;
 	struct audit_cap_data	fcap;
 	unsigned int		fcap_ver;
 	unsigned char		type;		/* record type */
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 82aa6049a858..6fe9f2525fc1 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -700,17 +700,16 @@ static int audit_filter_rules(struct task_struct *tsk,
 					 * lsmblob, which happens later in
 					 * this patch set.
 					 */
-					lsmblob_init(&blob, name->osid);
 					result = security_audit_rule_match(
-								&blob,
+								&name->lsmblob,
 								f->type,
 								f->op,
 								&f->lsm_rules);
 				} else if (ctx) {
 					list_for_each_entry(n, &ctx->names_list, list) {
-						lsmblob_init(&blob, n->osid);
 						if (security_audit_rule_match(
-							&blob, f->type, f->op,
+							&n->lsmblob,
+							f->type, f->op,
 							&f->lsm_rules)) {
 							++result;
 							break;
@@ -1589,13 +1588,12 @@ static void audit_log_name(struct audit_context *context, struct audit_names *n,
 				 from_kgid(&init_user_ns, n->gid),
 				 MAJOR(n->rdev),
 				 MINOR(n->rdev));
-	if (n->osid != 0) {
-		struct lsmblob blob;
+	if (lsmblob_is_set(&n->lsmblob)) {
 		struct lsmcontext lsmctx;
 
-		lsmblob_init(&blob, n->osid);
-		if (security_secid_to_secctx(&blob, &lsmctx, LSMBLOB_FIRST)) {
-			audit_log_format(ab, " osid=%u", n->osid);
+		if (security_secid_to_secctx(&n->lsmblob, &lsmctx,
+					     LSMBLOB_FIRST)) {
+			audit_log_format(ab, " osid=?");
 			if (call_panic)
 				*call_panic = 2;
 		} else {
@@ -2297,17 +2295,13 @@ static void audit_copy_inode(struct audit_names *name,
 			     const struct dentry *dentry,
 			     struct inode *inode, unsigned int flags)
 {
-	struct lsmblob blob;
-
 	name->ino   = inode->i_ino;
 	name->dev   = inode->i_sb->s_dev;
 	name->mode  = inode->i_mode;
 	name->uid   = inode->i_uid;
 	name->gid   = inode->i_gid;
 	name->rdev  = inode->i_rdev;
-	security_inode_getsecid(inode, &blob);
-	/* scaffolding until osid is updated */
-	name->osid = blob.secid[0];
+	security_inode_getsecid(inode, &name->lsmblob);
 	if (flags & AUDIT_INODE_NOEVAL) {
 		name->fcap_ver = -1;
 		return;
-- 
2.35.1

