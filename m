Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E96FF4A7CA7
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 01:18:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348454AbiBCASn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 19:18:43 -0500
Received: from sonic312-31.consmr.mail.ne1.yahoo.com ([66.163.191.212]:33792
        "EHLO sonic312-31.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1348443AbiBCASk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 19:18:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1643847520; bh=vgO//PFYDezNojD/b4WOsqsxvAcTkDNEtP0WkzWCjT4=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=AkFHLfSyO4xftRsiAXQXg6kPhJpa7QdfSWWJX6de35/0BJm6iVmJNNVxT2Z6T3KPwvlhM4TNUW3qG7LzaokjDkv4K+4tvx2ZO0993Ju0MaKrtDnrXVJ4YDbLHxkxAnPb0jtWjpL+H/rzMmWYF0Ul/b7zJRpZK2vDukQc1614Ixcn+EY0xdplh2MYyEg9SqjvSDjOdOwf3mL6nSzfFWsdjCEuqr9YvkUfmDe3B3jngpASvaSq8svTWWd9OTzTtqITN0rMOnXObQQb3IjoiLDiXTjxaPPbnKStxsxmc6Qf4E3U2xvllu0XaY6HyN9y2+79FBDejP4n3GfR7R8e8YVE2g==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1643847520; bh=89NtYWfD0iqXz7mfggFY4ZksO3WojLp2Ejc/1l2NcQ1=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=ieyi0p1ZdaN0C3MVpVJjiGTXAkjw5vTV3IxqI7KsHET4U5FgVMhHXvotvFERwTvyxfsfXFLalf48HCh3++LZlW0cbj7CGja/ofs64hrhqbNdO6tDAV615hUbcIZ3QPVqOC9rJyU/F8tR2RTM+t2hisXNNj+b9Ps009MlfSvYIv1GSh0+bJc2MxE/PWJzDAcywExw6eMrq8oXQAXQsVLcE8HWeYIJc13OQlnI3cxxJkOLOt6j4jmIOklpMhqHoVcUac9TYbrmTQr7wDg2bNOVB/Lr5t38yhD8ijVZDlisBCRwfOzOBwNDuOrtdKysOsGaDgp1Q2CceOfaBhQmCy1eAw==
X-YMail-OSG: 76__EsYVM1mqVTBvgNjyup07mJUX44XgY2_46YQDzh7VWHrP2ifPFKOlDO92Gqf
 3EH0qW2vxzxUPSsjdLtvCh4hCQwxI_4K5G_3wxbPmAntSm1J7uo1SW6e2K2cs1iLaKwPup7KFlhL
 UvYWBO9TJdVA3JAREP3XTtpnSXCNL5uzjWV2FLXa53Yz1rSjts4_5qhywt9x7hjxr5EKfPREn5mJ
 KAjlbIgr2WJOe15COToKaV2r4mGWXFJHMZkuUaUKQhMv.bH84xnIluQKoHsEk3M3SOp4zzRweihI
 bszbfZOQW2aXEE6Yukafbvs1hamnKPEYa1Ax9w4sxH29dFemeaue3fPLkKs.311AF.e_9BoZCpJu
 XFfy_R_L7wzuwLR8i_fMVoikzi8wCuv664jx4E7QWKNzOa9kZBHQIbwS3dTd2Xc47r8OgaHO6.Xg
 RpdGrwrwcct374iQv156OQY858EfWGScosHxzKpE9LV1inHhqkbAx6A5Bes5bRdI68WRTagjhOgr
 WVjNNmIKuHq7M39nZCbXAoq4QWOt7IAJvgZGOQuG6F9KFMzR2.yGft8G0JLoHRbgnwmysDKRYHDC
 MEXEx8_xHbO3LKZpS4crHpOOWUEPrYssYmSd6joxIa9sbxwZt4WL7z4es3SIw1e9QM3F8ORdA.k.
 t2Z3GIBwB8H27a12iKH0kuEpebf3kX0vdCaQiIiZ05xB8zcVYklh8_s7U_yQ.y6W.FR6rvIB4MeW
 Td_fQmTDHUJ961rgvw1iE6IYtzq01MwOk49O_TDKCVlexrFne2OFSju8lMd3GuXYLdGoNFjWhole
 zfOZF4A0U.FJASbiacqEjtXKdGCoYtXYewCEm.nvEgow.NuvtCpslB1FQ0j_MpQb2At7wmd7ukk8
 3azZA2FfTE53DNaT3Sy0vWdV6vadCjJ2.F19R6CMaqRqO.w.GoaAt0p9ga5qvkhNJeqN3fxDVXwv
 l.NLhj538g7NyCoMSm5IzLwFzG8gZCPpW_WF9fQ9yjB5VnXmymt7rODV.PduZ1WmAmiafOW4pRN0
 89e2XZj25Xc9nO0TEBAFMq1SspS.AzH.ZWLirBVp_Isjnq34spzX5flTosGF_xZd9Putb2MzRULi
 JgV750P7TixBMJG9b4CqoqDq.q_ZHM6xeV2LoFHyoi5ptpE2TBZmkOLrTqMKjv68e31RVhoED5gU
 Z5FjxJzVTZVPVbCueHjdu1pCTIUl_S8X4wjMCSMykWZh25k_X4ebq2yDuG2TEm4.YD3PscrxxUGy
 Hpzv0ZDLH9GZBM6sCN2m9xSmN.FUnd29QtWQ4YU_O_N6EtTJGFfobs1aNuli0hC02GxtcwyTYMyf
 sjZam04H8_Py4SFtsXsqTlAZ823ZD3t2gniZPQiUga1Njo4oCAAh1J.dd5mzs7YtLn1su2H5nyN4
 YoaOWJhUAXLZSHzpb00P1V82mKkhvnSz2PuhMYIo2lSVcra_FUR2vwCVpQV7EIUBFwJCO4Lu1y_q
 AbhBTI0SubfQbmlzghRUnD48FI8kqeppHpBytC_bixos4wGFy7gDEfNGFIuHPTMpuPphPXq3.shf
 .wxeeytmEReHsFajmZ2Y7AcW8p2SN8qpVuOmU4bPocHiJ5b9HqBW5Rh4rmcQMJgJSvmTeWoTlAY8
 HC6TaJiOagZs9GFjY5027RuR6ER.tLIabrurftVoUwsV_9i4bMns01gPj2pgi1eY5YAP5xcj2b3x
 .imEq.8try8vXWaRRFHZzk8MjO1nUZ0n95pe7mryW3KU3e__2BTtaZdu1ZHk3.tGwsKCVyNP17e6
 emVVdlFlnZwYjQxzGQW5dchkJ19_VixKBb69CpP1O7l9BUslcRlTvwioxJiSMaajtRh3Rovg5IvX
 p2_eoHGSA5v91NbVoncpw8Nm9SM7VLPK2ZvyJdl3_LRFqnY1cRZCBB9uZ6ZUag.TEgG9BPWR1jWv
 adg0A.Fgi4c9sydoEU1oRDCMYsWigb1vcTbPHUs0vDIt8r3SK3O7B7_VmBBRiDlNFEZKzvPilpwY
 .WoCjML9lje54muTtdRwfQ7V9U3HVGUESCDrzBQl1Hz19FKOGZYPPcWk1pvHP717bF1ch72UuTm6
 vfxlpiAn4stOv9d6RgPBUr6hSOzj22gzEyUqUvXXAiHXssCmfs8aDb5uoAxHgdEdcX3dToOXqSQK
 rrzD9bVGv0.stYquJ9kPNey3zrspGgjY8Q9swwU4TXxdts9MPMjZdpy3DcbUNn20MLEu014qHg86
 _iAkRQPCN2TGjzrM0VfmmjvNJPp.7fUjZKc80pgT93rVZGigF4gP_IPr8XMVFptideA_7jdj17Y3
 LMXJ884G4A_xP5LDQDsi5Ps23uU8USw--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.ne1.yahoo.com with HTTP; Thu, 3 Feb 2022 00:18:40 +0000
Received: by kubenode526.mail-prod1.omega.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID b28cf5c59f0e8f0ad457f4b9d7ee197d;
          Thu, 03 Feb 2022 00:18:34 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org
Subject: [PATCH v32 22/28] Audit: Keep multiple LSM data in audit_names
Date:   Wed,  2 Feb 2022 15:53:17 -0800
Message-Id: <20220202235323.23929-23-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220202235323.23929-1-casey@schaufler-ca.com>
References: <20220202235323.23929-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index 527d4c4acb12..a2fca1134519 100644
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
index e091d03f9184..47d34433b91e 100644
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
@@ -1537,13 +1536,12 @@ static void audit_log_name(struct audit_context *context, struct audit_names *n,
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
@@ -2245,17 +2243,13 @@ static void audit_copy_inode(struct audit_names *name,
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
2.31.1

