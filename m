Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5954D4D5628
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 00:58:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345081AbiCJX7N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 18:59:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345030AbiCJX7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 18:59:05 -0500
Received: from sonic308-16.consmr.mail.ne1.yahoo.com (sonic308-16.consmr.mail.ne1.yahoo.com [66.163.187.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 791225F4DE
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 15:58:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1646956682; bh=vgO//PFYDezNojD/b4WOsqsxvAcTkDNEtP0WkzWCjT4=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=eA/IpXYlxN7FaAJKltc0323QG+pnB8rwJcKw7eBCfiNUQjct104HQIEnmv8FngIWL1nUJuAN986xR/TGVuRicolLxcCvp/rVULygTDqb0CZg4hUbfBvk6iHC6jatcq4iXNcbwm5cPke/tOXT69lFdeWfuYD4m8TUnN8MY+vRaL/8YkaDdOjeC3NeHPIfRyg6wd21CJly/STnwauZbSXaEb0EcFukCX4qSW6yknMJw5EdePzMlM3VNh8qfIEmmEvRTY+uJKBXJcGYDc2i8m6gU5ipG4bnfZOiN346oOB5TizNZHpxGyHBWKcaoX1RqUHD+0S/g1VahaSlgOp73BjqDA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1646956682; bh=QeAKXrHutqGOEC52e+GlO1m/pSV3Kse9tjSES3QeLzV=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=Ao0AYVn13hCVnKezqkERjeh/qFfptUzo/hNwms2KDHpkXPcgG0cSX8ByOqImyglHLfhu6BUFEg/g2zNxhpYxTFL+bwL4B5QAYALdDHHjkM31tjxAS35NzGwA4J5b5uMXbg7oo+rgj8ixQeq7S2qsHuobrCOMQ5xHpJ/Zw8fpi2hDYQX9w+q7QeRV4YHRb6Et5vcW1YuOlwzCts2JN2adktYauQdSatCMUzDKg4gGH7SasfHVJyOiGaX69vBokrJ0N1ceFQiwV1fhKNF+hgTCXlPz7CCsmdoLdPm5E4toGWylcOP84+Yso6yWFcGfeyT5vTfez0RY5S1PX0hKzli31g==
X-YMail-OSG: ffF50pAVM1m_JFZkzp8s088rBK3QE.AN_MjkNcsXIDmVvlP9j9xR5glvc4_syGm
 1R31EvK.QxGpy.z6X4XEYaNZaEk1okBuT.AaJNxqitnTXF.kCML897_Sb6UPmFEjQyOnDYyXMdsh
 XvPdNkAaG8mjw42HyEUGqPHns8JqZvTybyxeK.Y7LWNCLUOxzbz3g8aokWuxHxxqa8aJS44rNpaQ
 O0jU_HIcm4qtSyHnhKpaVH_44gvog9I.p4zzfXFVuYxrEPS84NIC0W08myCIM9.G8Xl8u7KraK90
 PKMgOPnOmgEA7tSLjdYEsMUunF24mWH2utzwKFRBEI.a5Eu68DTEj8HxvFvabGw1O_2M3gA7GWMp
 RVTJ8Nwh5Zi.2KhEnWG0mGvVaOgvynE6EkLbNA6DFAvu8q.fnwEjRVoXu_Y4inY1_Il.8A0XbKVu
 SpGjslMSIlw9OmtmMd2PY1C0K3EVXcWXTkVoBhjMWd48v9aRF54h.nbPMyWbq9nK_8OmL9J83RAn
 Z.W6L4Pqd86CXm9wMdog0_ak1iicM6iKxWRZuP5PtNc201CGWfqdbBYvUiC6W18rYHl5IVAm4puu
 AnRK7Ju_9TXoTCiv6T.c62jgN1hRPm7LDEqEdkFf0BQdFkivAh38UffWr84j9kJUv4IIIkfen2YQ
 hakBwT_i98AdF2Z1IpUO9_dkpY9vvYfvM5nr6e_GDXnt_zdRPa00vjcA_Nhgc..bEDhq8UjB0xFk
 0UiWS4TOGR2KAjbr6DVVTn9emy9BVRXVw6D5JF4hEnBoN8jnpMJTXujeDT.ztS6GJtIACYEdabgM
 Rib.vV3D..iujDqyNh9f7EccT3YN1nTwOmDZDknuUGJVB0TytxYOxfuZs4y.n.SbO8FCdrYuVfT6
 SKYtDjMX2jVWGjJaiL_BzJiE8HOfUDtP8eTQKJhigm5Qm5ZUMt7Udog9IGVTnq6MK5HJcNudNQEY
 41kVRFV7RpCtHN_mDepIKcJn_ZOeslDbsoheiSKldoJB3E.ifNti4PafUgGIpVO3nOl2R634MBc_
 2qugaLNPNyrquu_pgJNZ6wmez6FU0nB2zs89zkBMIZdwV3YBiWfHaVUuKBIOiGFG4Y9X4Wq0SP42
 H268stdIv6G7nrpGlidZRDsIhtaJFx3DSKnbNqmydPA24yp8T1U39kC9RKabgOcjhT6nWHXhC7vV
 0Rk49CXZqCcATmxDzZPURaCsOAp_kXQk15dj3fnJWIeSwPi0s0qcJBVWa2bonxcTN.T0fPlI2FQI
 Jp9r83PDCYu6yl2L5.wcWc4.PIVvFvf1sQvTTvYll8KLfiwrvbzytwf3_uLiQy9_QZ2fALoTOabA
 gEQNwoVysOxu8XctyzoS.utPJJyKFbEu8npOzMzflCGcRnjtZDSQhdHSrAJXmnY4JM7G3tt6P9jV
 42XqDTm4Vt8d2Xdxl.qtofORIIh.OZK24TJaOyj29gp6evkR0V0M_.vRwkWgRs83BLLeOCJqbHcj
 YqevVfX7GIFdk3WdqpPauevj3KbS4a0JlpbJXlI_e76jS.yxZgvTzzxZ3Js3Dh0lKA15ZWv3hbbW
 dgTxSv39VX_rBJj97Xn0Ua_ItKqffXrJ4Lt.dxcPMY8zHTYXExeNlnO48.HBAuzmhUpzi3eyYoHY
 VtMfilgggvMlPrFI0FwCa8TaJ3JAbvJLKdkNGzjeKIfP3GvOIKlueeZqdeFeQKqWKShkqK.Gv6rY
 7dU3LXJeNIx79maQx3vrhyKoBPZ7Uffa9u4AtGmBgOAuj8r8tI5ihAhW5Yb3sfRCBZcR9yFueiYi
 SrusMTdMpcz95DnlwLZYJ0PsAvU0TD4bw5LoWUPvnnTXW5TJVNKFf7PeWMvNUb6IW2FZkTiU4gDI
 VXKfPKwV9emJ0i6fmP0ccDqMl7ORDOotk.kmTQfGFpeADmwc9kmX9GvEQbe7318xx0FUR9k97gmm
 879wTFllEENNsFVjWPPChKCzWJ4jcZZnPotAkGWgboH6VY3e6DwzDmYuodIqvWDBBtHDTe73UlRE
 e6_7iJZg4cDuSJhapxytSqrVtHIBaRJPSAPs3gg3ygXOvCcu2z.jIv23b7Fpx2RPjGmaW1OzajiY
 hnHTAvC2_22jLnieA20rhI.jA9UrXdBJJEAYf8TdQMAwIL.Bd4PVcs6aTwWXasA.Od5Y8Hsd4emP
 4_.T74xBAIFkh9QpEl67bhnHrkL1D6yymGJRRfyyqxgo3qLjVbepr_9e8L6cv_KjEWDxW9PYpGHt
 74pb36U2hWZo38g7o0JRb1z5GkM0To7SHtVnvzCDopVfqCGweWh8-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ne1.yahoo.com with HTTP; Thu, 10 Mar 2022 23:58:02 +0000
Received: by kubenode526.mail-prod1.omega.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 075078af6eda9fc0a8c4174c138d83b1;
          Thu, 10 Mar 2022 23:57:57 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH v33 22/29] Audit: Keep multiple LSM data in audit_names
Date:   Thu, 10 Mar 2022 15:46:25 -0800
Message-Id: <20220310234632.16194-23-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220310234632.16194-1-casey@schaufler-ca.com>
References: <20220310234632.16194-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
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

