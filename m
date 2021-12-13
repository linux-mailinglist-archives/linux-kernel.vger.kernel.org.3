Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63631473943
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 01:05:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242043AbhLNAFB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 19:05:01 -0500
Received: from sonic315-27.consmr.mail.ne1.yahoo.com ([66.163.190.153]:40124
        "EHLO sonic315-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234643AbhLNAFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 19:05:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1639440300; bh=4WSfb/YrW81av1VKokm3tSF+cQI845WVs77GasckxVg=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=EIrpbM1dc79MYXj2Jzw46xFjMNITvG9uX3zZBApaBQpYtozt0ild/bYiN2tEQ2TEHU7JVbkIP4Gig8aZ/C8RszHBPk+0fFxFMkCQNhYMcRwPEGIIRbno/lac35397EJBvUGUhjnJDrsrhsHOksI/YeT5cL9+P0KpHyc5fEDIeQrZUBejSKd2DOJSPtuhsDOmWkXo+g6PuHR0v1KsZ+ytGiEv99GjNPcdtRCyDV2vxT2huBHo4z9Ju0x0bVit0ve6EGuyzcgSndrczSgPvRAtOI78XNYnn1Vz0DhhWm8WWunR9+Lk1DSflNEecEv6J9VJ9Z+0pP6YGWOY05+w7q4ZSA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1639440300; bh=20QH4BoFmuvmnHhZ3gbCqjw+LH5ipMFcBKgCAo9WlAA=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=iat/onq+llk1etUL2G027QuupvRQ5X6OBvVWafgRFY7U99jhPNpkD2m5wh42GEE1qVtjc13/OhKWGQ49smtG06z9HSLl7y1AIvx448sDL7E0Ojqhys+7hP58S1JlECgX4odvirr00W0cpUF0w6nzU4UHrdiHUSLKlk50xuCoSeTZbte9a/T7MjeY4CR3N+cgs1up856vflNszNoWOa3FY4qOkhpxLmFAVkoWZxxG74keWyq58RZzjsq2Ng+UKWu9Pq8QOoLuWQ0KehcXd3/3W3ekiH9dSfYQcMf7XtFZcxQZDGnHUodpdf9beU+M+cVxocxzBCCkmD0dVuds1J7Kpg==
X-YMail-OSG: ns4p0XkVM1lHWxHOrw_wqFUCEy9Dddt1KA1ZsgdnRL3BULr3UTrDhD8qoDqW9r9
 CoWCYQdtdgwG0wjU8.JCxYdM0KaW3rLURolA3QqGPDgWCaQ1GQNJt4BV6RgvMAtgfrck4qfZyuMQ
 dnwLQKwZh6CfiRjPaJTTpVAUJ9NIx0VQ6NWQafhxMvDo90whAI1qGS9hlS2y0lP7IB_thP9c.ztf
 3mrtmcz3jAZdsAEuvf61hl1Z1WwAT.sN2ctLqDnahHoijM4hkWPld.PlZ8E3b5arHRgGAes35QAk
 cNcC6ny1e3aXWo5sI8GaLcDDAuUwEKYQNAZsQLdx5GBZljy.zo.XIfdGZp4kS1FPioHYidGxBba7
 uA.3YrCCuRtRvI6TtJOFtvpEEWPA6wcN6F59ohDvJ8IPVaqvFDTKAVYQM8LBZiCzi7mrWUA3MSwO
 TY0dQQ4h7D6RQLenGqBryTXNb_5tePm3VcibP3_8.Vu4XcxWVlZTfyuNMDBh.42PasU5o0AeljeF
 FHeg.MCT_1Y6EEohgQX68ze.LYwHz.mxTgGdzlHbNazIjByCjMNySOxkJM4pGRF1v91pq7CJJmai
 N.7XbTYwcAqn78nkKWH5ggszK7e9DJ2hTiRH3YnoDB0RhK76ENQappykM.ZYNIe5.KBVDszWCvBi
 UTrOZ1ufV6WaHV1qcZ2Ha7jk8HDhtDm1hRrZdrFeunsoH9r6TnA2DcvhBgKNnuhprIqi.Es1yOAG
 1.ygHpnMrzOSW3njCj5yixHWtbmo5.JxfHu75tU3PmTdES60jtmo6eKdvrsXCYKGFV6v3EEa74Ng
 tpwVndcQobb3WpW.04cX7N4z2WL3wAH.5Om8CutYXPeij6iWH0SRCdphUlqvQzm.nF_.v1kmfgHJ
 ZUVrbCJeWyRp8zVFkJaAVCMUKPuqG91ACoJnY4_ZvwJtk_5HUokKlMamMt5gUbZvdRjrPDgPhCmC
 MuR0fb4RQW3UqrEordC.IffjkKEi4_dWcDKm4FDazEFoOP32a7Tobaz1Fy7RbkbpjvyJHxsjQRZI
 UbJGvplL2WG3tMPRWIgrwbntzWcLImnjPpj9uW3gW1xgLnQ9jTUMPC87ZIin6TEsg19_D6dYdivs
 RDXgmgiRXQTJB1s7sKMaqzt2vNSQmm6AyE_C62.DJGyN.SnerMfNmZ24SqFEyuTvCkca.xXGngGT
 sWQfWhsTshvPQypNhLThfEPWwlnOEXRt.8Hm6bPuV9F7QpyWXXNH2TS.pnsPeN6dkZ_Ma.CeYLDq
 a.Uwg6zPQ5D1SaGlqPrp5LK30MUdvayiLBoAX7Acb6BQ1gqQeTm5yOl.ggNqofAf8kN7Qizfi6oN
 FpRCqSkjaxUUsGiKGyDRv400VKWTwBmhEKW0PcyDQAxwnaQ42hljOCa8gILj34lZrv.UkZ_hgo65
 ybcdOrH3ePB3BZY0WfXoAjANBrHMdO7cNozFz2arBbC4RMNOjGrs35SSom4HotmoKY_ZVBwUBter
 a7znlkZEXdtDrHhXy5N8FA4J_MUZ0dH44y8_CZVuEaKtzoUSg9kUwl8RgKZgNxJGf7s1wSlq.y9J
 l7EY1tpCPFfHhbaVeBAJD171xkW7kjJ5BOnOJ47i_Vw2rWx2OHETS_VsZ_Okn_anVvh7bCV4qxGP
 x1E4vjnG_EwQsbTSFpkjfx3i4h4BXLCs4d1l5ZCqvf2M_U1oTdblOTYCLWynpvK.3ODKDUJYuBaW
 hlJdUelznzq2kt13q1b25g083.OqAZ2ISdNZZPkeO2UAqUu8miMvpHvySPvgyD00r5moOGh0Gunl
 RA9B0AQ0zocpbZ5.gZ1SBG253hPVFCxVPWrMZfqlH5HLX89H3G0OZsFgXl19BslZ41le0Xp2vCMG
 mhkn3YtF5gr1bcPyHWNCLM9HMMZ9N.rHCrkOrmNgoT2MGyro.S7lM6YNjazxHdomJMEIJ3jT7VoU
 P2ZKZx7QWgnRHkId.tf6lPXHh9361M_ZjmJ5jjtV2csQobPy.BaAkbx3OjfBhC05Jv3Z0XAido90
 mlpUs0w2ryVJcNSGY7FKwWmlUlsvzoXacZWEJw7KCHX7cFpBNokfcc1fOTYh7EkafVS8FTA7thfi
 lk7rcm8uo1KiZ0D3vnTB4TkYwEqYqs1g5ppJY0bHmc5f3aDz1ma_7J5ShWeeMs_qHfch_bTzfkRf
 APNWYDkpsnsbQbKjeUOMDGcfYlZUpUot_enc3XsvQqb9HE9SV23P1p3NecYn5naElOehN_Eehhjj
 JQuy1EuTZlWUzTwD6jwv0cBCF17C30lz7HIGYLZb95W2Hg9a4nSY1.cYjG0xWaUTP10i0lAzVCC3
 IYGfdcJx8GhqaPWjPj5Q2ow--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.ne1.yahoo.com with HTTP; Tue, 14 Dec 2021 00:05:00 +0000
Received: by kubenode516.mail-prod1.omega.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 2c944b2e55a0f5436b828dcda8d0831e;
          Tue, 14 Dec 2021 00:04:55 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org
Subject: [PATCH v31 22/28] Audit: Keep multiple LSM data in audit_names
Date:   Mon, 13 Dec 2021 15:40:28 -0800
Message-Id: <20211213234034.111891-23-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211213234034.111891-1-casey@schaufler-ca.com>
References: <20211213234034.111891-1-casey@schaufler-ca.com>
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
index 2cf39de8f961..d373b4d8eb34 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -691,17 +691,16 @@ static int audit_filter_rules(struct task_struct *tsk,
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
@@ -1528,13 +1527,12 @@ static void audit_log_name(struct audit_context *context, struct audit_names *n,
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
@@ -2236,17 +2234,13 @@ static void audit_copy_inode(struct audit_names *name,
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

