Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A34A955DC2A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:25:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242121AbiF1BKq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 21:10:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241624AbiF1BKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 21:10:37 -0400
Received: from sonic316-27.consmr.mail.ne1.yahoo.com (sonic316-27.consmr.mail.ne1.yahoo.com [66.163.187.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22F86237D3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 18:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1656378636; bh=BPhMUhQdQqXWBnr2/wS0HlsrVSNQU5rfnCK53B9aoW8=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=byNoP1G/cvobMsrA33k/OMed/JUoo9muJuUJRjKws0H1EF1zVzaVjaDEQnrugZUPFLP9hmcGekVCcfr2cs7d6aBCHVhTNkoK7RQUnkd2zEsUTfnCmU9rl8R3wc9+njh/VJPW9i2SnL2ZQddqYFWqhwFhuhMZb5hWlDt8IkKooZdgc0Zfl3pA57V6sODOZdX7C5JGLLhIvt9/Z8turl314/7lrYL1gjKG5/to1AwypheVSQXRJAUz4rVEMR0obj9TfiXlm3VKrsHJwqLD5/mRU1cB0iiJj9Aa1bsf7npiZWdSpeObjModU3t1cVf54WlqIKAw5hyB9XD1K0NAOHl+ew==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1656378636; bh=uEFw0lf7JDnug4vhMYc7Kph0lryGz6Bk0Vc/VsEc6+Y=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=qERoDO1BJ/QQCck4gGee/t+Y2Np1lv3wzfW65uI1QTSFo+OVUgD+nn8zio24X1hVEX7eZo/EAtqcRFlFudRlPR7/mHmYB4LiirHGkktPRiahhQ39woXN82U0QrieAB1Snkgc6ZtEuSIYawGQhevMjtMCKoiHAdaMWd9uGPyQGNG3wpNN14LMGgA/YKtoE39w2+FR9mJq2EpTWBMHetZdi1S/YXPudAvFAD6A0+IYZSA9QebiKP8QOUMzIYItX76Rv5FOBMN/zsZ7j1EOKq6A+MfiHH7Ubz0uqKCf7VfnEyaEugWpUyqp/1WcvH+KtvNy4SByNfLONSvpbMKlBEmadg==
X-YMail-OSG: DxY_U5AVM1kExmWdyB1hqH9IgrYG50hP5Psn5DEBurKVDtB2U4uhNuDEuXNFwjW
 ymAJBGtmpFW0c3Au.c_IuP01C0rpghYpZk4QvHW1vlVLkFNpjK.cHvaXOKNqs55O9XOgOX3mP5_K
 Ks60SfekHDsj5Hl1hC6rp4oWefw0f1CjKF0fPK6BpGjkq_Kgxs7SKdAV25zWmvWdcnf2FAmD2Rxy
 9yBH81XP3ltOiN5jWWjNEQM04EVXE1p7R1tzO2gOTjPUahMZvGvY7fnTzG0aj3i.RQIv4sM7L7eY
 8O1X9Jhs7e26BFZXAQ7dKvcHxuPYAq32Spb7Nrqry2OB8oHWDheP_MGiPfcc05SpVURFTjYFoqso
 _.TM9n8nfIHEmSlnKmMsOzJk1DjqDd6O1cwxpe7Z3xjm59aHdndEWMDQObiH.Vad_HPj8JzSSVs1
 jMv68sKUqlKF9_AHghQWWCu6JFbk01mCOlf2739A7N9bdW8DCL3DEUi7jXzxtzwCve_SYYvH8y3r
 dXLwDxxI.RugiTL_3rEfaxPT3uHlhsCl8s2i4WZ31TGG6a.IUz8XfkkEEx0Cx7osU_Atmvwkf4tt
 sgDPPlgHHVyxyA0PiCoe5HGp.Qke9uY.I0SyysueSiWtGMNVRzlkGJHaJJ26Z9hz5dNZJ6UNZmso
 wpI_Ml_M2bWzfPwd5FNa_tZ0M6FVlXUfYS9aOUpgijoeXgRs8orfhv5Z8g539VU4nbJHtPX.u6z4
 R6tgMhHbUDBhupvDIyK1s7lvxnbgfugTHRDEJMqtBQKHeT9rY0cbarDxOBK53nLJ6ybRb4ER1IlD
 bbSAxm8EEUpC6ZPpDLmWgx2lrpU8EM4V0AITYbP59PIExuUGs3ync6xH4H0h7ANoqVNhQrRNrphG
 1xWk2ZZxNScNOQCG1FHA9tP_8yG4OLgGA.TC9rgQ7pdgGw5Cj2umqhutXQTcgJfuwPmfvPqalbNq
 TbNDr5mw9iDYnzB6JQcYcptwvRElyy1vo0EGgsOpyQxGsDTQlmNs5b6jjm4Y0v0qDY1rPaDxsSmc
 HdcPJd_RH.JIGUBlAPKX7.dXIvDKQo5mg8BaVkqqpFmWPq8A0nfzqG989SJGDnrJkoL_GrHo36gT
 ugH5._ebiACysHa028tfzsMBlfwz26IpEBUtaybJ6iTaL8PCGiyXIaGFJ5uH2yQJp8EgrhKle8CG
 1GEYK8JXYzJiJ_ZKsHB4RrPLLZN0wcto9eLBeC9iyrEKggAqR3mKMXOuBKkQJ32giwSnFQzIZttg
 T3hv2r8ZHQZPrTDtY4dHqIku9pWaCGRuEBjemf5oZ9x9aL4AbEe2n4J.D6SZshj4_Q5fhB4b18bt
 dANFoYdimhKlRm_GwRAFfUvBa1lPLgFbir_8Tb06a0FiQZvOo8a3pXxYb9nqmUn9KnE1xveXTadi
 e0QFxXpeJHcTHAVEO3IUx5PZ9sPmMlQYlryhK.nUrWTGZuaFcPtFmAt0NSelNXNS8zBPHdIPm6jn
 bqag2AZVRP79MKNcA7vMQ._buIZ6N22ShOyrw2WH76u4CT9tKW_f0UIbFpzbXNDmHE1D3mC0TxXD
 SPjMqaXe6BBZAdwbdoV9QZ31WcVlmZZeNWgkil.BLLK745xZ514ExLTAL00D8o7GgMQ71M.vpDTl
 ghhgq7s85qpwpr8OdfcVDY37rLPL7idfNCI1aeZMmd25EMkhAfdHHeTC4o6wAlLWwaU2UHGp3ldf
 oTxHc3vvO8jK3E1dXcygcBtTDh8HS83wO4TKQmB1yT_URymI6iCrWXJVjtCXh7GwLlXSo8hGXZyk
 0xZA90T6Dg.K_0nCCIvnkSZJzsR.mMsABfqXi5RbbvCUqpI.GLfYt54B62hkJSpJLVCP6gAsTEr4
 gzarlQU6ng_uy0m__RiQJqswA3hWqRkiPx5S7ojQM6IKiNvpy88m1qu5H9i20GISDBOz2uNzE.m2
 XfettuRkiDz41vAa0.lBZqSG4TD4IQEwjuDLVQW8AwHhkNXo3GT6kRIobdom0TNynfHGjvgv.6U4
 rztDMSQhzhPdGQgoK7aZ93ddSbfEDlN_V.nPSoSzkQSxKAo2.dKhxh4GIA6xgywjF0atoST4SZOZ
 y16cUSA4HPeDrXvNJ4IAWVlznslVZCuj.QvTHnyvo25E43JS9Kahy41os0ayMqz3rnMswBpeE8ZC
 zcnPe318tflzEkQ.ZA6rG4aXuQrjG42CLDk3_yuWM7vG3AgIPenyky_tMQ_6P96jAUioIWcNi4z_
 ou20RY9TaGlJGFyQvPjYjul6yhRc5e.BO_WF6ffPj8JapVbiiNHmgEC0kjH9fbVkauFs-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.ne1.yahoo.com with HTTP; Tue, 28 Jun 2022 01:10:36 +0000
Received: by hermes--canary-production-gq1-677bd878b7-wc7mq (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID e584f9a769c6d1ee8a468863bbdfebe6;
          Tue, 28 Jun 2022 01:10:33 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH v37 23/33] Audit: Keep multiple LSM data in audit_names
Date:   Mon, 27 Jun 2022 17:56:01 -0700
Message-Id: <20220628005611.13106-24-casey@schaufler-ca.com>
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

Replace the osid field in the audit_names structure
with a lsmblob structure. This accommodates the use
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
index 318529b1f930..4f141655ac0b 100644
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
@@ -2303,17 +2301,13 @@ static void audit_copy_inode(struct audit_names *name,
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
2.36.1

