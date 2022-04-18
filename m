Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BB02505BA2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 17:43:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345483AbiDRPpk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 11:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345668AbiDRPpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 11:45:16 -0400
Received: from sonic305-27.consmr.mail.ne1.yahoo.com (sonic305-27.consmr.mail.ne1.yahoo.com [66.163.185.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B0915A0A1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 08:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1650294676; bh=lg5n6X0Jaleg5WGjAFDMbKg9/7qG3ZPbBsw/+a/HLSM=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=tEOakH+zMlsRALP9meJ8U+fh1z0rXralfznqLK5O/sheDsBsDk7o8csBeglxnRYaPNCFGufJV3nGMwvTl29xQ1SihR5oYCwu1rpuzYTosBV7eNM0rndR2iAIVYGVNRQXm7TtJd+4TnTGMinVXZEMzFlovOL+xWg9+9ubf6K7fqinYgBVLmL5ywB+ZUwsoGrJAujpixAgcRrL/xR5lf67i2odxDrrAk93EId9oLL78mMvr0/jE+w6xfKqVwxc8xD4d4DbRkinNb2Ef83f+1KZDvC28hSBc8bXrqTznT5Bc268VyGwWvP5JI7p9JltrcZQtdTmoXUuWmbGHZ3QBNjTqw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1650294676; bh=UQTGkqSw1gTKXDhE+cQjvs71seTzgbXdCXzT4aoUaUK=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=WMY6v4NYou1lBW4lpwA/pYRHCQG6k8SpMFWDJslfsXVSBXc/StG+y3EjiplmHW9MOUlU/X2jlWAdgvZ14MpkJ9SlruSNk4CIWc8KArrbAWgKlraq+BfXYjxjNSmhmRvkjHVfJYnzhjSvJXif37F1GkmQMFr68Gk3LXVpHlw3HVlEP9N1IO8FXsjTxBzKjm+nYQoYyKu4WRwtwzgBlQM95x0tOGDXg1R5yC0wRd0ZVicMtNa6RxiYOAmZ3b3mfzWaX0aZ+ejZdfVWIC+AZ+WAa7Sn2W8tfIwF53hbLEJoAChCVE2bxgn3ez2932E5maSbUws619Z+m3SGmxQWcg5qIQ==
X-YMail-OSG: .yq_mnkVM1lS9ToOyxi19vg5qqDvk3d6izkKHadK8fjNAz2kHEZ.73UA63twJE6
 RE5Rv86FTTZ77DYKjRlrA0ny31feRyRUQMJ2rY.Hc11G1khegRn9Ua_sEl_zlCDBKyHZ_saOWfo5
 WbRJOu7eRvgbKE2Z_nbWCBAjG.JBu78NtEUMqZNYj1F0OE55nxUx6CfOXLVNgrgxNIqXSgpqzB1z
 h_EESQiADkfD8RUIBlkt4vt_CRz6mp8a4Wea88SWJyKf3B5fHaSEKqcQnRGtwYxU6FExGmHJuX1f
 kzQyoiEN122jOJzIcB21vyENyy6AW.8p5Pj7YxXdYyjdGqFZW4Mua5CsCn2izq3Pn52WEcgTyMUi
 ULFJgML9uC2AghbfeAQyL7zw_0XVfZYbiVHJtYcIJTXTOMZf2kAFj8DViQBbTcRBZ.SbEB_5mWTC
 G6uS8fK2rVzJVYaooYGghUYYNIxoAV.giOOl.DUu3mahJswbCCrxZgc3ri.VZAfgPunGVlOYtoyf
 99pmDvXr3x1Zegn8fIr2LH5v7BYcvGoIT1FrAfrcX_AIAouNOueHVCYSxFvNEpkRbZzhDUA__KO1
 evhOHBBNxhZXNVBT1vYom6F_z.52UMidELHq8qALwZ_eOw0NMx6YlhKlHAydibv7RrHBlvAO8VEn
 fqJzxrwlKAS_qRcTps0UHW61Gu9s3Zd_IV67eEti2..Q9ZFAuv02plKlrZ.B3tpJhoMuKevhPPsq
 A2RgGIyN0QafT68SwiIHjdHqussTtt4djvTv8PC1NYvzr4DFVHPBB3E1XTLpsfIqS8mfD6puuZPi
 4_L6og9XMNsYr62w8j.1lAjnTsI4WPNn7hNQlhqh1bzAY3WERnSTMl4fwYN8EDxD6TzLzH7DOz7t
 AdrVGEOP9C0VBiZwbvoSnm7K9ozpJzK1adPDUzHCpEGHV4zfwPTwzFAKXaV8Espr88_WLCBv7bfe
 T19BbU8JUs1o1_HaC7zze2Cn0BFDvLc7qKFA9GVJZiiMgslJ41cDBr4VJHl3vGnIxj6XENoGakV4
 myFRpZb50Es5m86UQrkby6or0Op.Z_9vBQB_JuZKZWo8ZQht4pUrWI9.7bkiy4XRBf6aoPK9cD6F
 Vxs978_meMZb_Q3ZH4qv3J6QpoZyID3n46Kjyhs3eNcG9y0Hmz5ucriu1Fd.y5TasoQa5oOrvKMJ
 xeGE3VqFUg1MLd9z4V_juGonalJ7D10r2yg8eElDpBHq.wE3QfLcFZF3aE10VhtexM4JuAm2JoSC
 ptPaO4cVBVx4uowTZxtJPMQd9t.mn8rwRcXC.d0DRUxAC416PY4pLG9ZBOqEH5kaO61Z2V1EeS4M
 QKPcUqBDiPCn83kuXGP7xgn1TCsBj1jo0blRfDuiffTDc7uvZoHHF08uEhe0pFtZp2LSGXCzyj6i
 At5SG5VaGE5FIB0Pbg7gBM.NjyST.8oo_F4PvCP2i6zDV.fmfjlbEZIrD7EcARNx9bocSKBI7BoH
 ie6aRWZCts_fnoKlZ.Xlg8sNVeEAMFdmLkOUiqLLzawGGXkXTmccOWnSnHkVyUM9VoP_6tG1.ZVG
 SgxmTX2oYOznOBLFoQZuoOjDmnEJgz893of6HCJ8V50pEZSBjak0ypJwFAADQfVtnRonmJd1UF_c
 mIc.ItdvrHWC0Cm0N9S.BQH2uHUKK2YlP.STJyAT1JEkhWVyCwLGcfLvXeHidxBkGZER5HGuOuwx
 .T8dj52sokdGoSK0UN8ImUb.9duRJmADMnNBKvi6oGQ3YIAte9QndnBQKy665fY0KSJAWZ9drcF7
 PVkFFW3dQKQrevcMBX1WmEavbeUvclxElc24SOJJ_MaB2XR9Duh.wsVFYBgFhsCBz2hmad9BIghL
 clVOdj5OifwRqpu7fZD5kUoDf0Gk58corMJBEkrmK6rD9h52ViW1Ns1JfTnI1jxNoo49YR23ne6u
 bOcZqWWipm0.AtIySkWk5mZ4BM8iM801sldv.Ks2lGZw5x63lr.CKSf0EFf8XsUcQW3ZCsXuTNfq
 RcTgDShKid2v7BmmG9p4Ri6rLX_upsib_SDii5t6rYjKkcsnySjfDioSm53dseX08w_U2BlxoG3k
 EYRkKm_SEe0VIwX7XfIY3z7juTAocM7MogcO.L96iN.PKJjXo9bgm8224.xaETTvJp28Hsyv6xV4
 uXUcyzo7TUoTa3W87rTlaaq4LfVdTOyUtb2Xe175L09vhZ7k1ctpdoFGd7mROpIv14myWt_UTTe4
 SNGo9qJKe8cLjU3NveBQxzSirefPmJw0fGqbTeKPHG.N4f5No9j95UsW2PDhAWvixd05E_nYYLsB
 hOEvh
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.ne1.yahoo.com with HTTP; Mon, 18 Apr 2022 15:11:16 +0000
Received: by hermes--canary-production-gq1-665697845d-2b87j (VZM Hermes SMTP Server) with ESMTPA ID 325f6f931fdc97e0cc6b332f80cb9e73;
          Mon, 18 Apr 2022 15:11:11 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH v35 22/29] Audit: Keep multiple LSM data in audit_names
Date:   Mon, 18 Apr 2022 07:59:38 -0700
Message-Id: <20220418145945.38797-23-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220418145945.38797-1-casey@schaufler-ca.com>
References: <20220418145945.38797-1-casey@schaufler-ca.com>
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
index 231631f61550..6fe9f2525fc1 100644
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
-	name->osid = lsmblob_first(&blob);
+	security_inode_getsecid(inode, &name->lsmblob);
 	if (flags & AUDIT_INODE_NOEVAL) {
 		name->fcap_ver = -1;
 		return;
-- 
2.35.1

