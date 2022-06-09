Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 083D2545838
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 01:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242233AbiFIXOT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 19:14:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346018AbiFIXNm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 19:13:42 -0400
Received: from sonic308-16.consmr.mail.ne1.yahoo.com (sonic308-16.consmr.mail.ne1.yahoo.com [66.163.187.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C23C162A37
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 16:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1654816401; bh=o1PPay0YIGm8Oi6jbgQlBMiNdwtfMgNj96sVZpJz2B4=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=CMhYzbOlGZZwyXJ4KA4rbzHIdekJ/nPl8x6Cf7Y9DGjvCVoejb/s4I5LxMIvh1tcOeWeLSiS3oxST7hS0mKeMVa+INgvqD1qe+/ajUU2iCHbRcnCrTD+MxOUBVwxuEdlYt5KIpj6OqcPsEZJrYYvpwp8dSgjEHGy+vl8TWlYL5NoEAU2rJNBONI7SjsXAwAHtxV+xqPJR2YNpjhitjYA9EFcM6wZbhuK5b9bU+sXsC/JM6R9ASHcWZqE0UsWApj3Lh3RUMzhMaaz60NI81/wVtiDNGef1MPZiC4tKAnE6kAk8TMzLwGRcEvGk4trDKX2n57uee7afqRj/m9nTwNcJA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1654816401; bh=y9QhoXxQ4Zet0ZlOypG3o5jsH9agAtH3/gX4paMaSZn=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=rQsx4zLyPn2jo9TcQvpw2MYRz6brDv7spRIVoJzFk13R4xZOQAXVFwf1t6BL0LuFtX5/EqKlkcQQlA0qpUCCJV3/4T8r9zvi+fQnxSevFg7tGdltC2UyewZxEEjvpWZ9MLDCmLWinqJJkhnoie6jBsj8QPrZJZjDXormlMXVb4LumS5Hihwnvh4Iu/jNZ4TXoi6keppNXyH75aqT6BFJT2Cgq7XhNCyaLamBWijJWM7e/bsbOBgGh+GC1JufXtP/+8IASmh0uYQiMipjWAvZ4fZYRoP7+aiOqHxn/REQCRjC8bMNVgtFQx0c2eUzHy0C81IY0LI1Rc1hgsZEjiY1Tw==
X-YMail-OSG: soA.6zgVM1ljbKTPPKboDbBj2H_O6taymxSp3UV1EA_psVvWQZ2d.M6970yEmMY
 h7GDi9SFixbJP3rEgfp1N4woRY0BzWYPz83CFGudlefo5EVYLvzW3ASUf7fhsdbk2GjZBtX3K.ti
 fQ7A.pNRXwZ.3QlZMWklnH1zaFSoZXNQi6fYKpaHXlHM27rjZL.UpjKvNRMXNABWjqVNbxPdfN2u
 YQ54bZPP9OPfh7HtBdQruwJ5omdwRvWqf25hQupQbd.BZlUvxa9w8X7LSPrW0GocTCWl38dfDI6I
 sOdGSN2yjZwmQrC7VLijsa0mfH.HoZ0oGaCN8nY1JhLgJSEbi8Ri5PysVWj4_niW_rgTEB60PLLY
 .SHIpBKy7_bJhG2IF3xSAD6xYlCwUCr0hOGqw8MsDMMYt_UHprdwSpNfmt0KjMkxKrA.AmA8UMwE
 xjuqLq8EYFxuEgyYfzkjRZWnnQeQzIeY6BajMKx_TpOkME4QDAuI0OLPTDpc42Ir8pFun6cyMP3p
 0tgMra0XxSAVO.YBRnotUUiFNOvvQd5nb7DZNujySFokLPpblQv88kkamZXplGI.PCJVGrN_tyNP
 rhQaNGmg42XxsUEuo16f42jRtaT1NzRvjqJx9pzNK3ilm81AHfPIQdfQfcyNbdHehZ4fVImiAyBS
 F4I4yujmuR4OIgn87BDpry9azisgXrxRG2U2kfDAHfR8OoRtcf7FFxsWnMKaUEBe2NJRMehJWTgA
 bV8rDNRFsEZFawt7yD2GcjtT8xJ35iSfMGgE9cTm4luZT7zjaDMreImq4eqg18d5tThxI4qA79Ma
 KO4rn5jNhlllnpUepA2ecioFwqH8ZuGozyUpw0N7Fh8DuYvEWfDK9rD6png8lSLP5wokIfxvrAjc
 kZq5k5MrYmPGInJ3fUEiy4TDlxl8LtvOuhF6.FGmuimOPql3KlPbatnzxGlG24EelwWArMlBPoVs
 Dk8GgNyuJ_N1lcokG5ZaNEbwIjrXTZQBvV3YpfolMsAOh1SwlR3MmklGdm1a.KGczPBsYyGHLc8j
 qZwleKpLtx7JpIzTzUPPTiL2SJUgAYcjm2vk7gb4CbUf9luUplxDeWlO9zCGFR6rYarkT8cNW67C
 PTvwy.lVqyrWQ3dgcrmh6WZg6up7ZHkEzceY17Th3CQ6b11VSSZzRMERAlL7m1wEMSZ1ybI9swXF
 hTmKg8xm8lDTTPMcGX6bo29kTizytfswYWTZDcjnEUF6pOaWYetv4oHxGfdSdTUqnd6r1KW75zVD
 azHsyG7J4Nm764CGyoa25NuHuZXmuZNAKew.bnWyla_YoBnb.A62KXyAZWuLA63W31i_wODsmCJP
 LwrP1LpS8TbCAUZgi63MRhTSsfLSygvcMovOKNqR7XctesegFKUF6EjBbni1aQ6QIay_Y4W90Zta
 q1Dg0hXHeLKIZFSZ2ccGAmIfS.d6Sg0AKq9z6REUCHLZ3c0XszE.QqE3cgcVe2UTaZ7ziSj5GGsX
 5UjrkXEKyxX0HcZN.oJ.aPd4PdKOo4yTHymzkCWha.ZvcqNad4KpJZwnaBmc03LhzyeCm7htHuqi
 rhynuyOH_PpXOwHW3pi_iNMnMSBvTMcbKKTVITDqNIdRd9mD_ywN_g7NZHL4JOI4s.YOAGA9ZZC9
 EA78UNil5DyWgTfTMPF0QRq2jHg4Yy8cKdSkFoGIE9mDnoZPxlD_rX6dWU6aUQy8ATrmunPzmegZ
 6XtFeA5t.s4OVeFtrTzMMBIaj6NF2iLhCl9rK_tGvD1K.94YBIypiWDqDwNqsSN6Jtv4Ozmix2l9
 eDclJpPqDWGst7_ClnIuUQsWU0wThnoH4JuesdOGzl_jvcFJbUZtA0i5nag3MC0IRf5rkR5ObL_n
 .7ypJ0uf2ey.Xr5lAFCzyyhhFhNRnCUA6.Wdh6VBtxwPJRS.jF9.igOuDSSRHgv0ZMzAvsDPirk2
 GFVAqSK.MzbiGdbJyFM4EOWNpkidlW1PqtlE2xVflvCHNOpU5MQj5EXUk86KoqPDE8NySJ62Jl2O
 mfSoVpy4hIVbz2aCcWtQQj6j2bnKU6GosG_bjg9gpNIM9nQ4lC.prIdMZ69e5x.US2nC_lePEgGr
 ZLK2Bo0Uunqh8VTZEfKDjndsvwYPhQq4BlyuEYAkFYWcBTxT_drenkVcUnMQf5mX5VbZMRvja5gr
 BQz3aBZ_u2n8khYGLQNEDQz6b3DVEiEC6KaSvqcv71ys.y6JBJSe_NgX6VrUpJPl0erIhI1vzd5B
 f3_1Z40JS1E9wcvtunasAbCYPAejuQT8RrI6sfTCM7M2wIsZSNYE9I7J0KDtLPbheI4ASKz1.HXT
 DVc4-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ne1.yahoo.com with HTTP; Thu, 9 Jun 2022 23:13:21 +0000
Received: by hermes--canary-production-gq1-54945cc758-szwwf (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 2f409ca26a6c68d04d9ee89cddfc02e1;
          Thu, 09 Jun 2022 23:13:18 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH v36 23/33] Audit: Keep multiple LSM data in audit_names
Date:   Thu,  9 Jun 2022 16:01:36 -0700
Message-Id: <20220609230146.319210-24-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220609230146.319210-1-casey@schaufler-ca.com>
References: <20220609230146.319210-1-casey@schaufler-ca.com>
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
index 200406c33617..c9e87ff4c396 100644
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
2.35.1

