Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 446F24738D0
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 00:47:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243218AbhLMXr1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 18:47:27 -0500
Received: from sonic315-27.consmr.mail.ne1.yahoo.com ([66.163.190.153]:39095
        "EHLO sonic315-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243135AbhLMXrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 18:47:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1639439244; bh=jT4PVItnczWnZdcyjvqnskftXdrHFa03HpMlVEGDCsY=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=HPp/ARJv5rLx4AeDAKfUvHDj/bAQ44J/AAGJgHnotKwH/ikvRMPZ1oqU/OUK18hbiCErzq7CS+GOXkYQvKaNdyUEvkIhbpjAdJ/ccxWol7qhyYpMr12QdrhTlheYt6Xfqby2KgddzYJ5qYF9OEXZoZoDpagyHEaQOGfUgIc8fiXJDVu0inTeNmIP9kPLkJJr0aexYaCkA+NJ/NmxHOpVvQhOtJ2jxB3OeSYHAl7BurDeKbJnTyjkcLXqqA3kQxyyrTD/6jvMNzp/1EM87SFhG6vQ4NtaeDd5wqsgv70kqGoZb2kO8n39TpO9o8Be/O4IGloMcKZMPPwvFXaNxWyPmQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1639439244; bh=f6G37XNN9VW/yMBt97O3Ayi4AQaOs7437zvjvRN0Kau=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=F6pMIv28N2S5eeT6TtgoUOFR8vXLqkWZWi4RhM4B9Ul/Mba/CBY2ziidFgVcR9LZ5RbV2lZ1XAQ8SqbZw6nm069bDNyG2iSL6y8b/8mrPPx2ZkDBQ50NsMJIB7/fkgEWUKLOBegALfcK+A6jXgYFW9mssFe8V1dnf8Hi2s5b7Lt4RoLELU9PpjTWY2y5GY49AMORog3kMfCB24GvQEWJMLOsqn5T2AfyUC9OCOKiw3sP4ZzmVHhEuwNeBRjao+0Pv667TSqBDiTNZa1qNZBq+Ff7kQGsX8ZjazmvB2FEkwdFUIDK8mHmQwxFtrlTEIO77QpP+XinHg4U5lviEMydKA==
X-YMail-OSG: hKmQiAQVM1kQ.ehfl9z90d2Qm12A6zpkeH36svwlzDL5lkeDyJ1AtMgJDq0n23a
 iuF_22CMX5W4MjijzkBVBrW4WzNysdVR_inTE4RMvGSwaasoiXgUXJv0spQ6wl1qhtiQXECaGdtf
 GMbIIMevRMdLNQ5qrWPcaS5CikHvRxRv9.nB9iKkQObQ4aFlXNqmJdV0Xny3Kf03wEzthOIrGqAN
 ujfKWJL0Jg3KNp8m5h_1hmWgzNlntn82.vOP1i3P2LFxhgtSOzCfkNbaWfR1kKKLoxDcqT0_ic31
 Owgg.8DdqOOswM2UNSmF_MMxwRMwg3a6j_hQAxCK3YJ8y0.uVu4gO6Xs6WpoSOgkR74bCvZ1X.Ie
 ANm55uwuBl.V8HiToHOWlc8gC7eNDPbjmh8qYhHaBGor9oW4Fx.rM4yYY6MfF9l5AkOpsF72xtXG
 45rILMFWQQMZpM57Ym7ggSG3b5EnaBqcisk16u8L9bpJX9ZNdF9lPclEDGVtR3FMpqYD1yo0Tjb1
 q.waftbxrlmyTBwjqVec9nSkfruwYmuxafFmS6ZkQd7SixZCGNsc2VRvCIRwU7wWeUPNW9SORjji
 3jxqRg4h5USVbX25Laqm7B7oWCR3KZY.yl_j8L2FoCS2WvJDB7FpBTkgVKIUeD4k1Xp6539xS_HE
 RpxBWv5wqtpSzcs9bZT4j.pihIj1V5dUEOTg5_Qu6nf6KREbFSa3TENAcz495aqC7gQFvAF.j0X7
 y2qmS__hqN.AsYQwIGQhXr7i6P3GpPZ4FMvjsvGxiH0mNQ3gINNFmIjbPREl5OIXi8WUEpXDRH1l
 nyJipkFlme2e69TdFeXLHHWFx60RCuU6XVZ8XbbPaE92MQcd911W6QgdALVw8wH7EhrrEnarsyJF
 COkUFcVjQf4l0TLBPUdUEbgPjmSA1cPx1vAT.7.RzuvUJ9FxyoHBemK7eEOPm6MVt2T_zEuW27Zi
 tspb3_G6f1.lxsGqajPV_Olj7Q3LUlia8r7fU_FxLxbIUqO8TZrCsax8Uefbi5aeVrE_PTmyLs66
 jVQZSw4jIx7wWOOsbxEIjGPiy29vWcWN8X3x1N.kfwpXFFLC92.eqcYONV3E4wFNtFjd_l.N4pMq
 tKiDxWIM2_0kNEcOeUd.dxpeWHkpPJBzZbc6rL1N_TUezVoW_CsgaSISjEUXIzGhs52LTC3Js9Eq
 ZEQrl9NhxQVcZv4QehrG0DkJ0LyeL4mzNhvmJ0GJQvypKhGUOhNy_62Zil7Ncl3VdsiGvRbWjc3N
 _LGntZ7IAG2m6U9QMEd_gW4GBHp1zBbmTxCC8loCzHY15o0qzg.7zb3Y_1huPe4c7UkTQ3i6Rsrn
 5k2OPARcd1Mi5B2wDcFnSJVJqZmKnTa7qqLwfJfu9F.CKmBhK8XDXaw9LfwYihv87b9sF_mZBsa8
 eAIOmszkg3Pz77csDqpgK7UeSURbL4Ke6M4aUaUx3vybure7SVj7ybBJ4uWWLX7iZQxbwl5k0VSg
 UcNuhri1o.uEYClDrSozsWufzKJW7KPkdSeH.537LBWQOZBJlxyL5dMfStTfG8YKmfp4KIzs6PvI
 AwYsYwzUr8OtqPIboDkCPaTFcSF3JNdiFl4Iny2KF2F4VE55Cpi_tTRW9iweCWAJD5g8awZGCieY
 _TGbuCz7nauYutIbmCmNqpwDdd2_bn7PkQVuy72KDDD872fStXFqBvijJYDECPb0VllOnWqJCDZs
 Ej7ZY5OcbSUV27i1x9ad6tgnMeJ1vLtnUsUxDjd8uiOFDzsMYQQl0xtRNSuLc4N9EtTpnstgmaXW
 IMvXe2oSS7gNbJSyzPIqctH3CwZZNw622419XB6huuqNCc8ws4CIzwSzv5NDM9K3RMELlDBwOWRo
 _rU7pW6Qw3NakCn7s5isneFo9EVPvU5oMiD1W88htFjqQd6jJS8snDC0uE3bsY2WbVHqhhDNTL12
 LLsgu5jh_r2PuEgotVQknES76z2RaeWAE6.TddRiUf2CQfTPVruxD4J0VAxDQc0GguuZnC6h3swx
 lz0ZYBfMvPdQm8Rp45leVQEcA6oFCmeAyA6cyRGJSH0KF7CsGOyPOYcxMnWEd9r9lsQu7Puc538z
 XiFRVtjQhZnctek4dDOiqexiHI8XRh1Gf8J9dhKOMUD.WHseUDpAkdjyYygjFs4V0RsELVoY3WR5
 0NPy9o2vxKnfMlxmMfAb_Ox31wDUmLOu577Qwpi1l3NcfnnghZMfm00HCSv0x6VI7YhEPQkYPhc.
 zEFVK6RsGOr_G12sPhTnU05Rk0m.3NcCG
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.ne1.yahoo.com with HTTP; Mon, 13 Dec 2021 23:47:24 +0000
Received: by kubenode521.mail-prod1.omega.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 8c2b01bd5b69dc97b5d7e5a25e3d4d3e;
          Mon, 13 Dec 2021 23:47:21 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org
Subject: [PATCH v31 06/28] LSM: Use lsmblob in security_audit_rule_match
Date:   Mon, 13 Dec 2021 15:40:12 -0800
Message-Id: <20211213234034.111891-7-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211213234034.111891-1-casey@schaufler-ca.com>
References: <20211213234034.111891-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the secid parameter of security_audit_rule_match
to a lsmblob structure pointer. Pass the entry from the
lsmblob structure for the approprite slot to the LSM hook.

Change the users of security_audit_rule_match to use the
lsmblob instead of a u32. The scaffolding function lsmblob_init()
fills the blob with the value of the old secid, ensuring that
it is available to the appropriate module hook. The sources of
the secid, security_task_getsecid() and security_inode_getsecid(),
will be converted to use the blob structure later in the series.
At the point the use of lsmblob_init() is dropped.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Acked-by: Paul Moore <paul@paul-moore.com>
Cc: linux-audit@redhat.com
---
 include/linux/security.h |  5 +++--
 kernel/auditfilter.c     |  6 ++++--
 kernel/auditsc.c         | 16 +++++++++++-----
 security/security.c      |  5 +++--
 4 files changed, 21 insertions(+), 11 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index 9b853796bd4f..5a29b9bfdeda 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -1954,7 +1954,7 @@ static inline int security_key_getsecurity(struct key *key, char **_buffer)
 int security_audit_rule_init(u32 field, u32 op, char *rulestr,
 			     struct audit_lsm_rules *lsmrules);
 int security_audit_rule_known(struct audit_krule *krule);
-int security_audit_rule_match(u32 secid, u32 field, u32 op,
+int security_audit_rule_match(struct lsmblob *blob, u32 field, u32 op,
 			      struct audit_lsm_rules *lsmrules);
 void security_audit_rule_free(struct audit_lsm_rules *lsmrules);
 
@@ -1971,7 +1971,8 @@ static inline int security_audit_rule_known(struct audit_krule *krule)
 	return 0;
 }
 
-static inline int security_audit_rule_match(u32 secid, u32 field, u32 op,
+static inline int security_audit_rule_match(struct lsmblob *blob,
+					    u32 field, u32 op,
 					    struct audit_lsm_rules *lsmrules)
 {
 	return 0;
diff --git a/kernel/auditfilter.c b/kernel/auditfilter.c
index c6b25bf0b323..88a8d69d03dd 100644
--- a/kernel/auditfilter.c
+++ b/kernel/auditfilter.c
@@ -1337,6 +1337,7 @@ int audit_filter(int msgtype, unsigned int listtype)
 
 		for (i = 0; i < e->rule.field_count; i++) {
 			struct audit_field *f = &e->rule.fields[i];
+			struct lsmblob blob;
 			pid_t pid;
 			u32 sid;
 
@@ -1370,8 +1371,9 @@ int audit_filter(int msgtype, unsigned int listtype)
 				if (f->lsm_str) {
 					security_task_getsecid_subj(current,
 								    &sid);
-					result = security_audit_rule_match(sid,
-						   f->type, f->op,
+					lsmblob_init(&blob, sid);
+					result = security_audit_rule_match(
+						   &blob, f->type, f->op,
 						   &f->lsm_rules);
 				}
 				break;
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 194a62d86578..e0c71fe27c2f 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -468,6 +468,7 @@ static int audit_filter_rules(struct task_struct *tsk,
 	const struct cred *cred;
 	int i, need_sid = 1;
 	u32 sid;
+	struct lsmblob blob;
 	unsigned int sessionid;
 
 	if (ctx && rule->prio <= ctx->prio)
@@ -669,8 +670,10 @@ static int audit_filter_rules(struct task_struct *tsk,
 					security_task_getsecid_subj(tsk, &sid);
 					need_sid = 0;
 				}
-				result = security_audit_rule_match(sid, f->type,
-							f->op, &f->lsm_rules);
+				lsmblob_init(&blob, sid);
+				result = security_audit_rule_match(&blob,
+							f->type, f->op,
+							&f->lsm_rules);
 			}
 			break;
 		case AUDIT_OBJ_USER:
@@ -683,15 +686,17 @@ static int audit_filter_rules(struct task_struct *tsk,
 			if (f->lsm_str) {
 				/* Find files that match */
 				if (name) {
+					lsmblob_init(&blob, name->osid);
 					result = security_audit_rule_match(
-								name->osid,
+								&blob,
 								f->type,
 								f->op,
 								&f->lsm_rules);
 				} else if (ctx) {
 					list_for_each_entry(n, &ctx->names_list, list) {
+						lsmblob_init(&blob, n->osid);
 						if (security_audit_rule_match(
-							n->osid, f->type, f->op,
+							&blob, f->type, f->op,
 							&f->lsm_rules)) {
 							++result;
 							break;
@@ -701,7 +706,8 @@ static int audit_filter_rules(struct task_struct *tsk,
 				/* Find ipc objects that match */
 				if (!ctx || ctx->type != AUDIT_IPC)
 					break;
-				if (security_audit_rule_match(ctx->ipc.osid,
+				lsmblob_init(&blob, ctx->ipc.osid);
+				if (security_audit_rule_match(&blob,
 							      f->type, f->op,
 							      &f->lsm_rules))
 					++result;
diff --git a/security/security.c b/security/security.c
index 580ef0c40be7..3ad3aa74c59d 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2680,7 +2680,7 @@ void security_audit_rule_free(struct audit_lsm_rules *lsmrules)
 	}
 }
 
-int security_audit_rule_match(u32 secid, u32 field, u32 op,
+int security_audit_rule_match(struct lsmblob *blob, u32 field, u32 op,
 			      struct audit_lsm_rules *lsmrules)
 {
 	struct security_hook_list *hp;
@@ -2691,7 +2691,8 @@ int security_audit_rule_match(u32 secid, u32 field, u32 op,
 			continue;
 		if (lsmrules->rule[hp->lsmid->slot] == NULL)
 			continue;
-		rc = hp->hook.audit_rule_match(secid, field, op,
+		rc = hp->hook.audit_rule_match(blob->secid[hp->lsmid->slot],
+					field, op,
 					&lsmrules->rule[hp->lsmid->slot]);
 		if (rc)
 			return rc;
-- 
2.31.1

