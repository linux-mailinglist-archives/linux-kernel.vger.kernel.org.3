Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 340A84A7CBB
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 01:22:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344903AbiBCAWF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 19:22:05 -0500
Received: from sonic317-39.consmr.mail.ne1.yahoo.com ([66.163.184.50]:35307
        "EHLO sonic317-39.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1348494AbiBCAVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 19:21:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1643847714; bh=sLADDpDeS/OaAkfD4ZYyY97VZX874clZ71WuwPhCS5c=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=tCrf7eBGqNYt9yKpHERpSw1ZwCydwRJtUvQreJwDXCMy4usAKCu01XR9PQ/LbPegZ25IGEXtR3Qnx2SBC3oAZYWKvJ06Lsj1416/9lDLaUR5GtnPW871eAvANzg09ayKKjB2a3VB8lgly9ipLhx9MNzJQOKfevqc4m58UtAdvprrdEgpykwoFJRjsjsZJz1aoMwaO0CqdKf8QQKzhjkGr5tgbvbXWJB3Af+nVsYk5goCmMfxnw6qetkDubED12nsi4Z3QxQRyJKMvrG9rEz1U24giaDkLpwTe36LIJaRARcdrhCsduhSvRVQjLXHdEQ0rfSGvO9bRLl7R0OS+paTCA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1643847714; bh=OyzugtIlpyzCj1RQG9ayViWPgTZUqeMr1ofqsQ0CDlv=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=Ua3HMdRyoeBknSEULVkHgbA3tuxLfpwNvMlUSAvR2tif6ixdctIehnECiqHrzdwFcB5CZtGcf22joIFbkQ25Xab4JBdDXocQ+5BCdZMZiMwztS9mY7mNLEguF5rYw1LqVz1nUG7/4W1B4JeF1I2YRheGpjrF2e2nb2KYnhmA7t09Iy8BSCAI0N3EG+mN8To/dhf1feO+oppER1mAnqkZaCQYlXat7NiGfXgsfx3ylV/PXNHO1SVkLi6VQtt1Yw+/x7zZCovlfSwGuEiIZmA++86KO6WXQ+VWsOKLw7SQ7HdafyVz7zTh/pCcUj4roslvxn1RpSVbKjaUNxJsSI0Hsw==
X-YMail-OSG: .kKA5AEVM1kardbrh6DXy0VAyh0zOe03RojVzFahowtHT6dJg05.FHQsdHShihk
 sIXmWDln1OaDgdf5ULYzkVvTGMuWkba9PZkWkcwrHHNFjT2_ajTBLtEBRBrvROHRnhHZ.psVmqhv
 NSC8gg1TKA2cfWXrtuHIqGX2hxnA2fLX6E1W.vHqvfXJgUMYQL3ewZgMOPfWiXqthUIyh9jMwWa.
 .4Ghhug1W1Aau1L9RCFVo2.yl7RBZUSyE5l9lUg2Lsi6XoRGvDr0_J4o7uP5eUr6PeW9ErqLKzdH
 XyqAA7uoSlLHD1jo2xHBOHvzQT0bWlAsntuOHdhGwz0EASjUZHFnMz_me5U.q0r0taRemXrHE7Hk
 DXF2ym48ntDhSCrAHslg3.PCuj3Z1JkjBEiaCPMmZ2kHWwm.6pkz8TpdNThUxvPI2p3jXzXSiE7s
 QdQRK8qkz0rA3cZTpQr2SzQHjj2Pg4vNCh0J0.8rS_Beq.AKWGO462hFQpRo5vXTaCYvl2p16QQ.
 bQUGiJOqsipC1cGvaiR9Uv1GkQU9KrVYjhGdGxnepFAfGygqJREpGZ1.2XmRQ46FXofqk85wqBhj
 PlZo_KSWytxCgAyG40oeOcKNkQcmllomdYzgACfnE7f05rDfB1U4IiU21aLdwQcnh_GCfH8hbXwS
 BOoe_OEiWUuoXdHIBZ4CLC3fwiADPdD5iwqPWoywONamwSqNSw2oLmKL3uetF5oN9Ukg_C6mSn8j
 8m1DG.vTHg.OvMHrY2tP2XcP9Qz3ehZhiy_nYlS43_q.J.lTg0dBHyvRxz451lXsw5wyUhgfqwoy
 NHfFWQ7e67mEgnNWEHTxnYqP9BuJBos5ejFaC3fKhxMmAfOo7d8SmywWVoduFMzxnue.adgOf3Ki
 ogtyv9SPF9FzycF45OFfAwC8kfY13O0TBu_BVlOHNz8qmodGLw6DUnuYvjXKwCBHjwO4K5ygm34A
 ZJZbyhEFMDwYltW9VTodhhgyyrE7Xh_rVZlVzXQoqf1l_YwMtyEa0LJx7QgR1rF40G71rrtwUeeH
 YfCD0vUBg9AoL0_2hWGw_byBL4i6UCxCvZ5nG0fOY4w6GWN1a2hFnygmbmvYG4a4eHX0eWRJbil0
 cpFmkkCV3VmfTourW_P79U7E0HfHFO.rBjf4qllSbBAM2u72H_IXO9sdurwgV9NtU5WcyyUw3Npa
 nmmJUXS.KYoT3PDmnz7vrzKjxTER3n4zcWw1FpJ3ugJWXyRuSQAQ6h8pHLKh8sr.jCx0MX7QX3Iu
 zHg5X_DUyg5I_78SUMHAek5QVoNwcjTDgV9sITvAqB.bOhlxHt5UpYCxde.u_N24ap11DPdwqQ2O
 MuYxSpgMt6MkoFXHqa4MwQRqGdXHcnOL8popVWvZaS5gnizBjBpE1Kif.6AyUIzm4i7EcFnUVo4B
 lQc4IW5cfYq.rUgh7ZOC0xvCfB450PCOCWvfBXGOR583FOwsd9A_gGyxUSNZFiTGjqM_CA5yAKiX
 JaEJ5sMiwJWnvH8jMDzQt18w1vOotpZYOCdGIN._5UrHCJ3m1QMiU25Y95EE9AngZpwU_Uhh5gbD
 UmGdkr52gePBvArFZWxmOZjlhbREw.z6Js1RiN9uzgN_qTPS5CeYAdXDRn1SBfkP2cNHmRdjx._L
 O2dedBckNT0j_bVdA5PuieWFjR_fx.mvbeVjcBRC.6HoLxCMMPepQfvW2ClM9_GfHWBSzQ.C7ZGZ
 fa.4mxbzwk5WuNRvI83eAdzghbLo6sl3EevEXoFnOVvyAeb4G83wbRM_nnyN9CsnDTWu50GfCAEs
 LE0riUq0GNKrIP8Clgcn_U_uZsVL1tQ0xtXN3TgKpi5HyMCSEBNiYtkQc9GlM8igNbc7tgjCuAQ6
 CsslYp8r5PdpQTfCvKBAlGd9LkpNG8F_sFilTpD9stuHg1XynN1XivzySxTWFTlVOPFmsUhvnSeY
 tSRPlzM6YJirMjY12GKAGo8Pl_XSxmClM9harwQOCCgez.59fN7x2zCxtnmXrGKLJwahBoEi3opY
 Psmw9Ak_IwEO36HPd2L9ayqabSqvl3Sy6VQIRzRw36yvDur7GyX4P_sotFb8JkFwB8i1K1yQ.Wqw
 OMTvKy8nwMB3EHBYeSynYk2fx.Pm.nHqq7G.AgWBZKhiaA2N6XheNeChLPFNoia73IwDcPG9Ayfm
 TGcVfLqTJwLDuz.zGG1VRhwvjzy.njGpw8IwejMsL1GIwBq7QF7Oht1jXIRscYJb_dHx626gFa0G
 SrJh8Xfbj.666w10Dk_TGk2kTJFytxzCAx7R5XdiUkitm5JZWN.SptIRgSWm3AT1zSaJI5I568mU
 BEx52CCS9xBaVQcUUy8v3f7JbYqe.
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Thu, 3 Feb 2022 00:21:54 +0000
Received: by kubenode522.mail-prod1.omega.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 9765e89dffea763971d3123694c911fb;
          Thu, 03 Feb 2022 00:21:51 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org
Subject: [PATCH v32 25/28] Audit: Add record for multiple task security contexts
Date:   Wed,  2 Feb 2022 15:53:20 -0800
Message-Id: <20220202235323.23929-26-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220202235323.23929-1-casey@schaufler-ca.com>
References: <20220202235323.23929-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create a new audit record AUDIT_MAC_TASK_CONTEXTS.
An example of the MAC_TASK_CONTEXTS (1420) record is:

    type=MAC_TASK_CONTEXTS[1420]
    msg=audit(1600880931.832:113)
    subj_apparmor=unconfined
    subj_smack=_

When an audit event includes a AUDIT_MAC_TASK_CONTEXTS record
the "subj=" field in other records in the event will be "subj=?".
An AUDIT_MAC_TASK_CONTEXTS record is supplied when the system has
multiple security modules that may make access decisions based
on a subject security context.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/security.h   |  9 ++++++
 include/uapi/linux/audit.h |  1 +
 kernel/audit.c             | 58 ++++++++++++++++++++++++++++++++------
 3 files changed, 60 insertions(+), 8 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index 39e113574ba7..280ea8d4778f 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -231,6 +231,15 @@ static inline bool lsmblob_equal(struct lsmblob *bloba, struct lsmblob *blobb)
 extern int lsm_name_to_slot(char *name);
 extern const char *lsm_slot_to_name(int slot);
 
+static inline bool lsm_multiple_contexts(void)
+{
+#ifdef CONFIG_SECURITY
+	return lsm_slot_to_name(1) != NULL;
+#else
+	return false;
+#endif
+}
+
 /**
  * lsmblob_value - find the first non-zero value in an lsmblob structure.
  * @blob: Pointer to the data
diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
index 8eda133ca4c1..af0aaccfaf57 100644
--- a/include/uapi/linux/audit.h
+++ b/include/uapi/linux/audit.h
@@ -143,6 +143,7 @@
 #define AUDIT_MAC_UNLBL_STCDEL	1417	/* NetLabel: del a static label */
 #define AUDIT_MAC_CALIPSO_ADD	1418	/* NetLabel: add CALIPSO DOI entry */
 #define AUDIT_MAC_CALIPSO_DEL	1419	/* NetLabel: del CALIPSO DOI entry */
+#define AUDIT_MAC_TASK_CONTEXTS	1420	/* Multiple LSM task contexts */
 
 #define AUDIT_FIRST_KERN_ANOM_MSG   1700
 #define AUDIT_LAST_KERN_ANOM_MSG    1799
diff --git a/kernel/audit.c b/kernel/audit.c
index 559fb14e0380..e8744e80ef21 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -197,6 +197,9 @@ static struct audit_ctl_mutex {
 struct audit_context_entry {
 	struct list_head	list;
 	int			type;	/* Audit record type */
+	union {
+		struct lsmblob	lsm_subjs;
+	};
 };
 
 /* The audit_buffer is used when formatting an audit record.  The caller
@@ -2163,16 +2166,31 @@ int audit_log_task_context(struct audit_buffer *ab)
 	if (!lsmblob_is_set(&blob))
 		return 0;
 
-	error = security_secid_to_secctx(&blob, &context, LSMBLOB_FIRST);
+	if (!lsm_multiple_contexts()) {
+		error = security_secid_to_secctx(&blob, &context,
+						 LSMBLOB_FIRST);
+		if (error) {
+			if (error != -EINVAL)
+				goto error_path;
+			return 0;
+		}
 
-	if (error) {
-		if (error != -EINVAL)
+		audit_log_format(ab, " subj=%s", context.context);
+		security_release_secctx(&context);
+	} else {
+		struct audit_context_entry *ace;
+
+		audit_log_format(ab, " subj=?");
+		ace = kzalloc(sizeof(*ace), ab->gfp_mask);
+		if (!ace) {
+			error = -ENOMEM;
 			goto error_path;
-		return 0;
+		}
+		INIT_LIST_HEAD(&ace->list);
+		ace->type = AUDIT_MAC_TASK_CONTEXTS;
+		ace->lsm_subjs = blob;
+		list_add(&ace->list, &ab->aux_records);
 	}
-
-	audit_log_format(ab, " subj=%s", context.context);
-	security_release_secctx(&context);
 	return 0;
 
 error_path:
@@ -2434,9 +2452,12 @@ void audit_log_end(struct audit_buffer *ab)
 	struct audit_context_entry *entry;
 	struct audit_context mcontext;
 	struct audit_context *mctx;
+	struct lsmcontext lcontext;
 	struct audit_buffer *mab;
 	struct list_head *l;
 	struct list_head *n;
+	int rc;
+	int i;
 
 	if (!ab)
 		return;
@@ -2449,6 +2470,7 @@ void audit_log_end(struct audit_buffer *ab)
 	}
 
 	if (ab->ctx == NULL) {
+		mcontext.context = AUDIT_CTX_SYSCALL;
 		mcontext.stamp = ab->stamp;
 		mctx = &mcontext;
 	} else
@@ -2462,7 +2484,27 @@ void audit_log_end(struct audit_buffer *ab)
 			continue;
 		}
 		switch (entry->type) {
-		/* Don't know of any quite yet. */
+		case AUDIT_MAC_TASK_CONTEXTS:
+			for (i = 0; i < LSMBLOB_ENTRIES; i++) {
+				if (entry->lsm_subjs.secid[i] == 0)
+					continue;
+				rc = security_secid_to_secctx(&entry->lsm_subjs,
+							      &lcontext, i);
+				if (rc) {
+					if (rc != -EINVAL)
+						audit_panic("error in audit_log_end");
+					audit_log_format(mab, "%ssubj_%s=?",
+							 i ? " " : "",
+							 lsm_slot_to_name(i));
+				} else {
+					audit_log_format(mab, "%ssubj_%s=%s",
+							 i ? " " : "",
+							 lsm_slot_to_name(i),
+							 lcontext.context);
+					security_release_secctx(&lcontext);
+				}
+			}
+			break;
 		default:
 			audit_panic("Unknown type in audit_log_end");
 			break;
-- 
2.31.1

