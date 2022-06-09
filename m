Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 146B15457D8
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 01:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236550AbiFIXFQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 19:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232493AbiFIXFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 19:05:12 -0400
Received: from sonic304-28.consmr.mail.ne1.yahoo.com (sonic304-28.consmr.mail.ne1.yahoo.com [66.163.191.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F29F63BD4EA
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 16:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1654815909; bh=5/jTOpYaVAKU+EKIuon8pMnvXb6vARGpTk0K0DaQRlY=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=lJ2zIGBgsa4lCPbn8SmSBDDe3bA8n059Zt1c+xLP0/fmVuOABIB+EsxdyeRMOZCf442V5XMUFKH7q+RtjHWZgzYAT6D//psepQP8tcmuZt5cFNbr9IoXHK3XRjRY7ynN1hQr45QrhoL5DFNjgEltPEtiyRIKL0kztNybVw6v9lC2h/kADll5b4W6MHsi2YoMKB/bh5JUIW0pRa4BTTs9InIFsHLwYj805xUlLiImJZ9DTcl7R0ZPnHAM7CGeKB0bthcl0xH7SdT42L8Tqups6r9BuWCUpXtuKSOumYrI6YlTFsTcvoFZqelFT5Ubbu1FArFOtL0Pz82R5sMr92p5SQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1654815909; bh=mf6nHe3TEPUscMy8f4tEt178RtP5N5cLSMGsoDN5py5=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=t7QYIeaZWxGGyVCiVE5XObDx/vhiU0c1qLuHFr9wQM0YykeGz/JGFGxK6vu6Jzr3jqYTC4/tk/ZDkSaS7m+uwXWDq7t875ASUpynJ+1srorjYBS+HAVp9GY3xvw/oTH4bdNPGF2q8ftzN3XmNnrQm5wS9vrcBYuLTm1vGEVHFvJbsHTvwNT26uVRwG5T45sFQt+wMMjBSCrxj9/Rq5CmhYBdhQWF8zVGxq1Nps6ZMxi/n7e7SnYeyuaT9SKAU/q7wu2w8XKFftlXHno1f4bH0e24udBG/5ALFdscHoxFOYNTADCszQ/XQwK77OD1lAvcEBsVm0VMlMOqLlVfpF+GTg==
X-YMail-OSG: ZRuh9N0VM1nsBGZ_BOs8gEa028WuA21mbvuJO4naFd9vhlqLIjw3.Kc32tmWXvl
 bUYbEj4tzOXcPPss1dKWq6Y5IHmRMIueLv2PQLiUgRqlaol6uKAsFBLxOge08Nec3w.EpFxbbLw2
 x_M.NfDqJgsWC8ajcvJ8o.Uo6tUmnY0ADv9n4Y8Wh7KvAx8r4roxLGi634Au5E1vOxFZfJSUpwOs
 UMH2Jb2VJdPUr.61ZTcMAV0U9OnFbJvJm5Hwat.gJqImdQNuxNMK.JtghVzeOwElR03eJiHOvpUt
 B.anplbpqducVHc6tLW.MG25sojEIwVK1s_BogthuQFqHlGX9iKzTHXWXRwVce1oVcJIxlK2H25R
 mISzwXoxH74cvtWPssfFwA7pxmqO6qVe9CAPKLGdY.vzZ5SdMMxEUurbm8lWbs4ZFGJf2QaD7iJV
 GB8vnzPBtHKYlm5krr3Nz6y9enZX2ln7tVaLvAA0CK0SqK1xUVpBQcwKcPzbDkSbReuQHgOSb9z0
 MXzlox8H_358UYKhB118FxWnUjgGAQfk19zuZ6dhG6yWaxh0QqQL2SpCxL5DVpzkc2WAYX0krP3g
 3ExydSnPy0BLHN4izpPR8cR53P3aa1FbP6UFys_13zDuAYZ0yObY.__zFtxtmolG4zecZKE0TO9N
 ph_KY8Wm6BwBJ39i2sL6Q1kKe6ZQ9aLd1ilzVc4w01lwXKa1eud.gUXprwUx8wL9UoIVzudfCZGd
 7yUgsUlwvworPBavS9Nhf7owD3CtVKLGQwiSLl8PUXzL6kNmk.EfvLsVnuZv8wPZ5BuIUtU4clLC
 zJ0Gy4TadYJ5.lqId9NUqdLwVF.spTk_ZrOqqrlQUSweiLezUqcM6hPfYqqukZC59fwaBrr8sxqk
 OjR7t1Iv17X4_1BkgornHHX7g3.P9CCx8dcJBM44DGeJw1p_EgREye6kBcYFuiJm7gNcjJllIEpC
 EtlzWNqAGORgagtwnN8vZtIrZlMY8czXuyxoTiv.pkjHqpBQmlKoQrMkxUaU5tUa6VOjBDOecv5j
 KWbu.l0KXwmLytCKUTZd6QMIBPQnlCyMRJTniPTAVViuzonjgwg1_Isw7vccQpyfwRq27Q5snPGa
 v1.LA1T8xnB9bF6KV6oBdRxvLpTZZogmhhnYbQqihBRL2NW2_Zz31LKGKLWLe5mDGcdAmCCJGchb
 oMHIGXfzB0gRdFUo6V6TMk.JnNpjfCDZ_xsLKOi8Npx.LHbSebUOZLnEpqtVKn1ZJFelzwwrgwQD
 KYtuR_i.1I8Pcrfjh7xrUk62jPjvVT0UoJjW63287eA4t_fLhJXPf28STAEc_dq7Yj1XTlI0EFYX
 vi4qlMGw2kAgxLYh.5.BjLuf36amwH6bOnP9M60.HymC6UucoUoUiJLmh7P6loew2DuwQE9Tfk.5
 RdGfjp1aNmyjWGbAvZSzFsBEPJTZwGybCMuz9o5R4kdaGmD_Dp8uNAc6MieTJ5KO3ZxWBDX4fHLu
 _AHsoZR9iq2qxVZ37em5FM2Zb6sGsOfRyl7WUJAK4ym5OcQuOi8jsOaFqug.mVAytErJ3kifQvzc
 ImhHJSNU.3DWNWfwqaEkw_5Ti9fsnlQwQD5ADpVcdpefMRw8MwRoyxJtCbXJVWdSbR97VaE5mC6i
 ATJNMbRqiKMomZrplGAdbH6y4AwCqev4XbVkKYOgod.wVkETpBVlDikHyIXlU8jGFFnesZN4r_78
 SCz.frTUfVuNpXMghfW_dCeAx2nAhBGUU5fD5T8l5y5EoaZWXWNsy_YJFH9hSlfYb2Wb6OCOg.PY
 GIdTTkrwJ_..7Nytg2axPW9NaDCoIGQGCZ7BuAGIUb2JsIC4eCxiHLCvrsYODiIJL2Mltsg0s8DX
 BgTT4soLK.TMfSJm2_6wuyZMQWJQ9W7hGxBVO06LZOanQYgNQHUVIf8y4j6NV5kkGFo5RGbsXjTa
 wRhYND2E9Z4YJ8s3lYkAsfModB81dA8quhirtjlURtgoFufBYbV_jnnx6peSXRktngyUIdQ8RcoH
 V_3ARkL8pFuKErW81WawOy76DI46vdd7O5hGBcHN64UlP4H.cnZQbT8evAkbaHBdRWx.V6Oj9mVx
 hthUVCVnvL_0q5PB3Wg7CZQGojGpWiODHBAEHu__QuKdPTzg2btERUNukujbpcB8fEd7IabOgQ72
 c6N2MehCMkYsxcopV1WJWoy0HLFAvohmusgj4H_mB7P4RFAnJ3HSDzbcUt85r_xLvU6U16.tZKXX
 T3WH23ksvrc1i6PIT0zpAiLSGsYQmFLwzPmICS_C24TG3GuJhGD4AIW83O2VvU2cvsmcBkKMDY5V
 Eyd3g_T_b21LyEqNiMmNMPBFWzIKEyaVeNVCTOLXnMx4m5Pr2jbmlAxuK6A--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ne1.yahoo.com with HTTP; Thu, 9 Jun 2022 23:05:09 +0000
Received: by hermes--canary-production-bf1-856dbf94db-mq9q8 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID a994d58746f340bf5c8b571efdccf4f1;
          Thu, 09 Jun 2022 23:05:06 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH v36 06/33] LSM: Use lsmblob in security_audit_rule_match
Date:   Thu,  9 Jun 2022 16:01:19 -0700
Message-Id: <20220609230146.319210-7-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220609230146.319210-1-casey@schaufler-ca.com>
References: <20220609230146.319210-1-casey@schaufler-ca.com>
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
Reviewed-by: John Johansen <john.johansen@canonical.com>
Cc: linux-audit@redhat.com
---
 include/linux/security.h |  5 +++--
 kernel/auditfilter.c     |  6 ++++--
 kernel/auditsc.c         | 16 +++++++++++-----
 security/security.c      |  5 +++--
 4 files changed, 21 insertions(+), 11 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index 5b0b2a596cee..95ba8c223e0c 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -1957,7 +1957,7 @@ static inline int security_key_getsecurity(struct key *key, char **_buffer)
 int security_audit_rule_init(u32 field, u32 op, char *rulestr,
 			     struct audit_lsm_rules *lsmrules);
 int security_audit_rule_known(struct audit_krule *krule);
-int security_audit_rule_match(u32 secid, u32 field, u32 op,
+int security_audit_rule_match(struct lsmblob *blob, u32 field, u32 op,
 			      struct audit_lsm_rules *lsmrules);
 void security_audit_rule_free(struct audit_lsm_rules *lsmrules);
 
@@ -1974,7 +1974,8 @@ static inline int security_audit_rule_known(struct audit_krule *krule)
 	return 0;
 }
 
-static inline int security_audit_rule_match(u32 secid, u32 field, u32 op,
+static inline int security_audit_rule_match(struct lsmblob *blob,
+					    u32 field, u32 op,
 					    struct audit_lsm_rules *lsmrules)
 {
 	return 0;
diff --git a/kernel/auditfilter.c b/kernel/auditfilter.c
index de75bd6ad866..15cd4fe35e9c 100644
--- a/kernel/auditfilter.c
+++ b/kernel/auditfilter.c
@@ -1337,6 +1337,7 @@ int audit_filter(int msgtype, unsigned int listtype)
 
 		for (i = 0; i < e->rule.field_count; i++) {
 			struct audit_field *f = &e->rule.fields[i];
+			struct lsmblob blob;
 			pid_t pid;
 			u32 sid;
 
@@ -1369,8 +1370,9 @@ int audit_filter(int msgtype, unsigned int listtype)
 			case AUDIT_SUBJ_CLR:
 				if (f->lsm_str) {
 					security_current_getsecid_subj(&sid);
-					result = security_audit_rule_match(sid,
-						   f->type, f->op,
+					lsmblob_init(&blob, sid);
+					result = security_audit_rule_match(
+						   &blob, f->type, f->op,
 						   &f->lsm_rules);
 				}
 				break;
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 1dcdf863adf6..7701dba499f5 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -468,6 +468,7 @@ static int audit_filter_rules(struct task_struct *tsk,
 	const struct cred *cred;
 	int i, need_sid = 1;
 	u32 sid;
+	struct lsmblob blob;
 	unsigned int sessionid;
 
 	if (ctx && rule->prio <= ctx->prio)
@@ -678,8 +679,10 @@ static int audit_filter_rules(struct task_struct *tsk,
 					security_current_getsecid_subj(&sid);
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
@@ -692,15 +695,17 @@ static int audit_filter_rules(struct task_struct *tsk,
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
@@ -710,7 +715,8 @@ static int audit_filter_rules(struct task_struct *tsk,
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
index 141922732d10..ade59e3638e8 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2697,7 +2697,7 @@ void security_audit_rule_free(struct audit_lsm_rules *lsmrules)
 	}
 }
 
-int security_audit_rule_match(u32 secid, u32 field, u32 op,
+int security_audit_rule_match(struct lsmblob *blob, u32 field, u32 op,
 			      struct audit_lsm_rules *lsmrules)
 {
 	struct security_hook_list *hp;
@@ -2708,7 +2708,8 @@ int security_audit_rule_match(u32 secid, u32 field, u32 op,
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
2.35.1

