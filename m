Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 490035031AA
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 01:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355265AbiDOVcY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 17:32:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355240AbiDOVcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 17:32:16 -0400
Received: from sonic317-39.consmr.mail.ne1.yahoo.com (sonic317-39.consmr.mail.ne1.yahoo.com [66.163.184.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DED7C36310
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 14:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1650058182; bh=GCzw8AbIKSF767bZWFoiVd6qOcKopRj1eBVPCUHsTtQ=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=WELmHADivsuv1YI6hCn4GOFbB0UC3X6JYp/cHsj5hlhq073Q0cmqNqgtsWgGSozZpM9a5rDd9F2LOiMzbzQdWnTZvklAgR1nu2I2Xo7vT5tx/wAND81BeRY/FHFqlx6w071gJbFxbMAOAzJk9i0/MrPTmPAp7VSWc7JX7TZI/epblzvP0kdRy2MCMPcxHrRQgH0crqGywzfwAUwOYqaVGolaVuw/unEYVkvcgp3xaip8eR0N12ovFedXSgJ7M7tDJ8iIxyj3Gc9TUbFdAGBtjj73lhosC33MvdO/rv8C+CTaXRQrpNuNXhuOlGpAP2L1gO7f3G7CfnltqtH9K+/azw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1650058182; bh=BMGsZGShAkqoLzf+QVjAtzLK4oVuzlNfEfrpEFPG+3n=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=OSyLAxUz/iazZRzXdCxwRUJsYzZA0uAB505QhV0KJNVT5V3IOyvr5Nse4EjMCZgGhNX02WbqQcWl/3V8mRVAt6+ZtlZHjCz4TwRGYV9OyFeN9URXD7tm6eQqqhVWq3++5ts2UA+ytQcaPzVZXGYFf/2QFsrKsVObWuYO8DuTVVDJ1tls0Csh3xlnelS1NZMUc7sirK66EhwmfJcW6GTWH+Y5ltRcQ3l5scozgYdsqeO7anyoWWEQihCyTbhgYIEpqjEjfsx/1rtZ4EiprhS7UwfTSyF2DTKV6FxMcPItxcPQhveF+ivzn1V8c7grD+dYBIrl2SVlG0woHJdHw/AzQQ==
X-YMail-OSG: LZNoxqIVM1ma.qpLXdNWgMZiXzc9RromagQ0lsRcrVB4rRGw6YZkXpdg9m9Mbge
 _dJuVPU1jBIqO_C81XUqiS9K6yAZMsjcXas9UWGllTmSUfevLXL8.KoDlh4NRg8DJxrJ_M90OrTN
 Uhw9nIKMIk8nvTtTY1DL4sFtA3h7696LHO49_kAYAbqAJM9Y8rNyxtqdNGqRB9sD7Cry7moD0ouk
 F1.zbMb6kcf5k35NYvycHeRfQWbK78TYrq9w7Rd8PXgN4z4so4J9Ca05Kr7ieijywmOp_oH8zACr
 JXLAa2k1.mYYPdXN_mXfzYSnPeBDU2NiEHwY8GpBVFGobha6RrzvLRDX8IqlTlOxCnlah9opanaT
 qbTT2THtMp_q3Y6QpxitasmV8fQ6sFuILJTO2.xhE_uZ4TC1nzAbgQ_CNVgXx2c9s4qRFskBdgXm
 04tO25wL60wJF4yuMB5ZifDjhhNYR8Ws4pTaIQYYKs3f.U43cGRIYHKuyhKlXqvJQq2iSDq2NRDe
 zWksuftIdby_8EscVZVIHAubewggTtwqCu4BWNCgqdK6_qlSv.rHCbKGcFgRPsn3F4mrg_.qk83h
 FERE3OtNlsSXwiuHOG81C6QQucDBBFXh_.B5wZpMjGUhUbMigYAmPAkP0PIS4Vh70WGrbzlEX1KG
 2E0.NUDHxnL2yv_Hx4Y_Qz_6Rl6E70KCmh3uHYO.QGII1fq63X_As_1HdHN7eMtVYQJGRP4GiT7c
 p5JrT5uV.gbd5cTc8UKofO4odak9TpP1Z20UfguYqtGheHlTtkeJMo6fcvp8ffU0jtMZZTLRWvwf
 Q6KCJOEjAZkXVOzgqChjPD6W2i_0aeqvzRAMwvHH4PNfNhrw0y9hhnhMT4x_kT1wqoP.1tueerVH
 vqNb61cc8k3g4wLnFGx8DeEOlM8.mHSwVJScdut8lL961tNZarHZ3Km_vbLy50ExZUjemGiKxH8y
 3_tqIVcx3hS6YYtHSGCnCXGjMi09kY37d0_7zsM5bTOyi1P5daVztzQMRSgsbr56yKr6ZghdCa2_
 4iIUYaF7WgVPdFOaMLaLIeDpM_Mube7XT3IeUp_NFb4DCz5QLpFxE6nQQr1OYGsJ8SaPyTieBv.8
 Cu27MQl6ZG4Szfld6v18g0IrQR034VUw_Lz2lGVy0Nfadc0HJo9Tn2xEY4f5QDLvRXGuEn1XvQ5D
 8jakSCG7wPTSOMdUiEVSZQND0sm23lqwlh9R2_LQW3u2q1W2K0IPlc7qVVXccUnDi.foUtxmRuam
 1fVA6kaUYX8Fat43K8NVBMM4b7DygvJ7sBNjeaIKLfx_m6U4V2yHNZ50G5JXz7f4EuDeLxUTO1A0
 LrOvt40i4Cm8ZnvFX.hHCPk9iHj9Kw_9fhJR7UCKEeWMI6GgBx0FQIclEqqpuX7N2VsscGjKfA51
 tRDR1gqUN._4aZD4gkcqDG02zNaXzk5qVU7ke97OnOl_Yz1rhzlBHRiJw_f0ty0wUhHnKHjYlUj.
 lelXQGrFI5UpcwItMYT0x4zi_.Cc8yULab7nYOO8YnTNzl9vFjeCURTTE8Ze8rn9kTFdx3uo2vhN
 Nz6PjOHPWoxV_P87vHp2pwtbf3YVFE0pL.N.eMafsaLXstnDPLTl0Sn9wjC1stE_PPP4cCe.ML_t
 7PCW1nBidchEFzSbGx4nxNvp2O5Jw0tlTGENRfVQdH_7.igrn7Evd8KsAFhyjF0gb.IUvcbiyS1O
 F4zQ9QLV1F6c5SkmghQGtEgMlFhYB8IH6Q.vmFLowQ7q9ND9asTZYPAauu.4WQbkW2hHw.NoUm8T
 w476vIrNgQeKMNzvzx5hnQVG6CWnIyvR_FZOjq81DSXDbSIK4l_GvhfTq17V_8ATOJ8CMjyCRQeV
 gy34lbouGq1wAY28qSkX6I_VR9VpeuRywtE1_wlNaXk9PLgxmXbMAh77kAjUPeDHWz.nzqTpxFjQ
 7wXkqLDbfaDtTLo1x.Ixv.uQkUUqcnsV36L938GZg3GddnS0i92k9SLF7xmU_bTGannaYLoSA5t1
 9eGFY.b8FjODMrUvRtWBVYnBH5yMeheDK7rcDlgXWldKa_y33YW3WvHEhDsY3C2GEdBBxgCUEvYx
 jPMRc0XNuZuejfriTy0x0l4.J2GoKJE4wvhegvmraINBpA1YTQNdFqM6hlzGUhiacnsE8k8eky8c
 TF5o6y2mRTLKh45M5rVvO_R5gxwZRnQdZ1MTrGZRRrB4YkiYA9D08.r1uUcMiYB4ZTwH1n1CGdp_
 Xu2imDafF6rnN4G30D7_HMgew_BVGRnwuOmMd5rAlwcuBi6nQ5HPaGdADg2LmR0QhDTwgBghEI.L
 cKhoG
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Fri, 15 Apr 2022 21:29:42 +0000
Received: by hermes--canary-production-gq1-665697845d-l9qwj (VZM Hermes SMTP Server) with ESMTPA ID e13e266d8c7792b63d16d18d4175b5aa;
          Fri, 15 Apr 2022 21:29:39 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH v34 22/29] Audit: Keep multiple LSM data in audit_names
Date:   Fri, 15 Apr 2022 14:17:54 -0700
Message-Id: <20220415211801.12667-23-casey@schaufler-ca.com>
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

