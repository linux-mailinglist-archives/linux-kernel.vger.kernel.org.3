Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87FE4473955
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 01:08:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244388AbhLNAIW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 19:08:22 -0500
Received: from sonic306-28.consmr.mail.ne1.yahoo.com ([66.163.189.90]:43564
        "EHLO sonic306-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244007AbhLNAIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 19:08:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1639440501; bh=O0t9t6KDAGwmtN5P/fvZGVlmF/QKJqhLo2fzNqAdHtk=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=q6/mo7ConiGb85ElzpNwLw4EDUi4UUO3pCN68xjbiET75l1G4oVhfXbCXmK96jYGzUHlflieiwyRuUIzeBcid3F1gnCckuWCw3xt5wFAeM3fFPxhwWsJcL4pSR0cDk0l5TgatbnwHGG4KLziCwl5ZFr2y13qARzAMIPUKJQ2FJDJoYs65yid4sx1tHIumYi6g9W2J97E8DT8LU7HJ/APy2rklJB02Gq8ifohUCn7zzr0kt6SC2X6woCxi9gGOPkqkqE92kAUeeWj0CRoTfaYyqhQ6Y6gbC4pEjnqq2wKy5HyAPQ+faCnRnb1yVfEd0p3o/I+mGrUtvUveoehbLyaGA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1639440501; bh=0HRPhQo25TrB+JrIpm/t0Xbh3zepdLzr+2xTHr0MW2S=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=OH+5MY3MFm7J6ep/yGPM+lgqV/UtObATdoXDhg5j8poUwgfrDfKowZGXeKqXzip8EKKBWe4pZ+Gk0crkjw3fbibJ5DICsJBKBb7T+fhMMA9VnRRYv1DlItULx+HFB+909umfjt+/LrhCDNs8AQ+nYhIuHBvRYDaWfbem6fKfVEF75XESGM/q3oTx7ppU8RKUn1fasR0QaoqScb+i3z9CrglRV2Rk/0fiNisbf/BWwBPTDaDN0faDxQxPhBmaRIR+183PctseVQ7c11ftSJlCftaERIF6h6nYp+MnGvRxMVrM5RaJTxHV5jXaUOK55P8ckrytDqomDavqiPjoP3kr9Q==
X-YMail-OSG: wdEiZ0kVM1lO_WLhGuZhg5pkE01DwiusKLFKUAz21br9smv1.RcXs1_sjCNAmIR
 C7gezLe.kTRDEo9W4b7uJ5JJJkXPJiO50D9Tfa2JlTu3yarhXQj0tFAmCt4b1o7mUlMJItrc0ZOt
 7W5z0oqEylGa9bUz7pB2S4dyQLejIa_dXk2PHdvhttcQsGa4i5M4J6hv269oS58uZY0jqqD0dwt9
 nH6NQ1CAlsshUacFkHePKKIXo7l17xIMVC.cZYchvR8RhJF3P.TUPvtERvQP2Oyq1EBLslvCj.9F
 r8E3QORlNPUQRFljvCLQzzSqKj.bGg7iFuf4g2X89rLdEr0zoF7rxfqF8uFXYsbx9mw5amZazD71
 2Dif9TLDeoCLuS3caAbRiw8n3WxC4Moo8ygzcNnMDZLNt.OlR0bgE3db5Lcuid.uSmFJxbi8MiQP
 RhowTil.hyFEycQrfBwBu7Lr6StD54qtgIdCOYh65keX61BqxrBF1mnhyUZ8mbLoajW0JUZe6.PS
 0gl7RG_qxlMuNVBn9LBbEizZ.oMLN0Tcwvss9EMq6OBDywXqqLVekRHqhJOpHIzDTRY7KBBfeBNE
 yPtjawjQl154bqKxWc6vwXZfp8l6YpqSkuFxwSBXdPzlAr80ECXeW7M3UlK2J7iH6MfIyTpqSlSt
 Q3PyuqHmXrQ7Zz0RAA9Q4zh3XOqNdWM7oxFx8BPhEFEvLcB3.O5ZEbS8zEhdfSN403F8xEnBAk9b
 0pJzYdVSIFwgrkHDgIi9lepfHvGWfmQQF1InYmnkvq9MkvKHNJ1md27xvJDOkJ8hh.WcijvRr0OT
 eR00aZcEjMgL4cAweVFTidC8pv42AE_hRE_lgMdYBlyaTbFIJD7T4weO6ldDb5oaOYWnF9UN0wJF
 WLhMuI4DYP.5N5xbuta_SWgKFUxZ5XGi3qn8fn0d4sw88v5YOPVeCCr0MOWcqDWgGhKmJWyronja
 OGvi2qjDj82NckrTet6_CT5StFrVb2tsJXluQWSBSTCyS2g4T1Q4u_pufj.NVHKIDR.hCrarOE3u
 F5_MdOTl7eZdIvdYMbQM.u0RJF5LMuSw0igVvCOLKFeFvqDbsHWpLlEMIe37cY0_nRMQmjzzs2IB
 VESXUEjQ5pqxPE_77YoJwJMcq3Stbxwp5UGzgipoSZVNKza1_j3zBvmyp2VG0He92lSHstHMjo4u
 i_oRTM4c3clMCvjv.LBqHyIyak6KrwCzbyLQl6IdJYSLutPZuQJXPJebOSfFGiJ7pd1U8b55.PA5
 0izsKqZPRPpBoxolX4vPajRgy5yzqDPg2crTbjeCqnRTy6ylPU9IvY70rsHF_UG7eqEpaDkIkKcW
 Yq3V5rA8pVZBkEAI3CY6gJ.MCAXJlceZwvlbDaydf1eATvOAWwpYI2dJLMTT.tmwu9qPbJTID3r8
 lbxArbwMO2ObVPuQ8q_zSASwaM762JHKQA5ncCcU9As_rBtSAjNO0dmS2EmYu5FelDiZeN8zmsnD
 ZCWZTibhfWmyya3FjnZF.6yw0kLuewW4JkjSj0yVlOzAbKa.2YLgRu5dGwCdUewDctw1s0oK4f9h
 HbyDmimY1K2Ox_SIvOUhAMmGiEafDNP_RvPcZHchp.5dMm8_ozTc630D2j336azbuEGbKO.WqmOK
 1FtlgIxdyzRzgWLDO48Tz6MYJDapJtjKnUlaHDrf3Rlo.9nmvKdUaciNCkkKGipoAjDPqzYTpAX2
 c2LL9TihHCxlCAjtmBVuLQ7YLOfhuJF5z8ZDGjD2nkNhH7IhK2OHklp7JP99gjoEbZD.a.gmdmJq
 VN.YifuDqamB8yr8dboofQQPaqktbg7oJCQLU6c1ldNCgCXJaii.pILGo.6hYsroGWKMeso.Q8PD
 8H.Bl11FtFmzbI_4LO4U_EIjoswGx2R7yRCT6ev1kXcPnyCCuQVT0oleyJv9ypmVtK.5pT.0GisG
 8c5xNdD6qgxD6BPP4dZ3Og9lnb7syz756lpeP5SpzfQytQ110GiQ5IDzKyMEi7oVn1XpwMVM4Obo
 cDdpMIbZIVxPyAcdvPJaQcji.Mc8mPknPiwFh2pz_6zrLrP7AuZgiZ9_zmZiRY6bSgCOxDKJaub1
 LQPQzHsxqKN6sre3nFzxdhyNjur6lQTBZwZGFjHlZfWfr2w0dv8eiQ9rQgCGzl5U4X3MiJW9JHX1
 S6TnKlTgsRUWCp7sYvvE03HO5WTJYvdCmqiKM8_qWYWLCuNEiB9SYOkn0pigZCcPVrxjTX51xFxy
 q.NU31LqDfacBeimi9049pN79FWwnlzZBJfb29gM.bw--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Tue, 14 Dec 2021 00:08:21 +0000
Received: by kubenode505.mail-prod1.omega.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 794c3351da4f176dfc5edcd3b1422ada;
          Tue, 14 Dec 2021 00:08:15 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org
Subject: [PATCH v31 25/28] Audit: Add record for multiple task security contexts
Date:   Mon, 13 Dec 2021 15:40:31 -0800
Message-Id: <20211213234034.111891-26-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211213234034.111891-1-casey@schaufler-ca.com>
References: <20211213234034.111891-1-casey@schaufler-ca.com>
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
index bec8505f2ce5..a54179451410 100644
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
index 9176a095fefc..86ad3da4f0d4 100644
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
index fc3662ff126e..4ee2bf620df7 100644
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
@@ -2149,15 +2152,30 @@ int audit_log_task_context(struct audit_buffer *ab)
 	if (!lsmblob_is_set(&blob))
 		return 0;
 
-	error = security_secid_to_secctx(&blob, &context, LSMBLOB_FIRST);
-	if (error) {
-		if (error != -EINVAL)
+	if (!lsm_multiple_contexts()) {
+		error = security_secid_to_secctx(&blob, &context,
+						 LSMBLOB_FIRST);
+		if (error) {
+			if (error != -EINVAL)
+				goto error_path;
+			return 0;
+		}
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
@@ -2419,9 +2437,12 @@ void audit_log_end(struct audit_buffer *ab)
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
@@ -2434,6 +2455,7 @@ void audit_log_end(struct audit_buffer *ab)
 	}
 
 	if (ab->ctx == NULL) {
+		mcontext.context = AUDIT_CTX_SYSCALL;
 		mcontext.stamp = ab->stamp;
 		mctx = &mcontext;
 	} else
@@ -2447,7 +2469,27 @@ void audit_log_end(struct audit_buffer *ab)
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

