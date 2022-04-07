Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA4754F89EF
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 00:15:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231825AbiDGViK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 17:38:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231741AbiDGVh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 17:37:57 -0400
Received: from sonic311-30.consmr.mail.ne1.yahoo.com (sonic311-30.consmr.mail.ne1.yahoo.com [66.163.188.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43F8F1AEC8A
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 14:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1649367354; bh=h32jrF2Zh2EvU2lSatcW64eAZi8X5he9uuICOJ6hcZ8=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=b0hZhUpZIQeY5BfGxI+w9HGBRlK6uCBfoptzTHGZ17lt0fd4XPKRhA1cgHTt1wL8HV3sYUMEcXmdYJyWDBIkm31GPtBIr8TUS2UIEPUTduV0K/LGwISt4xMAox9+D6ej9b/2YaLdUJ5FlaDCSNayiiNNXSPHx90Yx4TP6UFTOVCSzVNc/u61+QY1sZzmIqbuSWvshRyj8loryEB5/kHZf4MU8A9WH4FNkXhaGHYeceZ4t37lTXzA3Q+2mcHJZNjfNZGc/KvhPnuU7VRrKWLObAI0Mfu+VGctmBWe5wt/BAf/4WYDi9BbK4amzh/d3m1Tvdy+5//rnn5pzdTO++1pPg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1649367354; bh=hoCLOmwk5lBmZvaAq7xLwWqPgH9hLEAGxgB54uF4yMn=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=rXAU+F0m52V+qlnf5AD72kXnsf3zXZUfzaFxzQyDzRSYsoMfPXVeJyFMuIkQFb++zU0nhfgp1t4wBCSsnWPGlUHUH15OwSabc3cl8r5UxgqazUAP2MQEBNoZBLRrT8aaVC2/1x6FsRztk/Hkm6biuBWlBsXonMeTNgflf0d5FO6d+UPzQ8SHKzG0e88rzREjMNLQO6jPRZ0uosxAENb63rRP58fERYGLzYBT8MJxXQdQIftkcmVwfeD0ygtnpiytZQvO/8qMGHp34LcNWrarLwI95QSigKEdj7nrcrzbkx6E3q9tvbL1YpjxlsZbOs3QadBnWeHGKpNd3dQ4ykkqMQ==
X-YMail-OSG: uGolalgVM1m.a.HdYKaz9GDgyCY3yx.fKbOfM_HVQsXUkaKjgZfoAZx_mFK8_tW
 F6zo_51B.DVjvBEVmpTAEChY7xkowgWAC5pDCWTdBWy2mRXQ.k04d9r7CIvuaC_CsBzIIFcTmrSJ
 uYGMoJunBMi8XXP8fbZh4PNKd4bV3qOkC_ov1l2hHW44lkc_y2XGJtd1bKz.3ZehfTp_uPovFGkB
 dmMh5hs9rqsiAQV88jYjApBNthxZbnzHwvXF06AU.Mfh.6KS6HRvCzkAaRDmyrBGCfWle5QZoYDa
 ad0ASy8VBNoVbtw4GJEJCEqplidZbmAZ.U2uN8eE0DHpfowvuwC0tKD0JDWwuxPOPqWwjyO4dfrS
 KuUvHer4KImTcF0n9dEwegWsICMOd.7GPcsmzafhU2N.SxQlMrZbIfEsANk4N31zfwet0mmXA429
 8gTV_ssrjYpG.QX.hY_0evy_knRqIA0bqCSc59.k09BGQ0PV6ha7AIrUVqDDT_wfjAU.8mEBwHl3
 3bwzy7qMLYK0TqqidqzaWAGbCIoASPD1C3Ar5umoIzDrcYu7T8DcSFoU7f_AWmi6.QB27gIN3Aml
 WYCTvGCnGLM4cQSWUTjesxhvRpXz1_CbSgFN03fEF_IwvtdYtUMNF2iVPg92fOUR.msizUQXR2GP
 X7VMQlqfhudhdrPIQjJsNoVEBUTN5xl9fm0au7zLw8EwEZqyEgNyjyg.Wnod_UJCiL8YX8SU1xAZ
 V9cpQ9q0ar55ekmi_tSXgNcdUFvxgxky67JmDYz_mcghW1FFvGIxEvZE55tBd3fyY1RNT0MKcwiB
 skaKv0QtgrrC8wsReza2Td76430u0HuvXQswYhp1E6SgPZbeAMqPLeqZEje7Xb1PPBTKg_r2vz7U
 H7NnarBZzJG8I5DfAyZHGsEZRjdcSq4Q8IC0cBkRrXKgVfOE2O1SpTefWnbCc5xhSIAsfCKZUAbS
 m8sHZg8cJp7btKtX8k_LJ6tsm_z_Ypld.5fMcixeiCfqb2UZNA6wdyfSMwMBAI7Ra_wQiLj5MRLK
 IwSa1jXOPYubAy24FT2n8hfZtOpqPNZVTa5f_UK7bAoeyeS03Ym4zaNPxcu9p80GoxZsA2oOWMHK
 R3jl7X073jfWcfwgRmeOqz5tfbDZdmV6wr5Svp0KuG.0l9v6uwCFut8OfcMixTPP31Ffzw1mq0Xf
 5QOQg9dYbC1sA9ApG_SVclZ9UUf8UZtwQ94kEAe0GmB3RvFeepBCMH9Hu9_LRGNvviDVf_EOPI5G
 ukcuV8Eig8vv_jlx7Mh7Rbv8v6R5yzF64dRha8hc4kId4WtopuhimNHfwKGqET3PN5IQSgIdjfmD
 7nLhNnrWQvyjfqzG3U20jxiQUCHNE1R12HAVJ9i1qH8RoVV46rRpbk.kmjJ1s7bxlsDDfmOx8.a_
 dog7dTKCvkKRcTn11uMUlgOsKg3KS.8Ype7qlNRSVnplsHA6kHH082ZKA8urEpFVQ6vk1SDGifl1
 KSX91tTLR5tEAgyPHL7Y2gmHZ63UBbiUDZs_IzwqmOm6MZACDfa3i298ZnLqF_N5bh0P5dlGDSHj
 w73etElVjfaUHpliYwafHceWLkCkutiMFdjMCt58JlteUFdKSLAzt5nWKfODz2iq1DsZI_L3URgS
 NNYz1nX853oDvj3qEgkBYKiiUmxOx6KbSiArL_hdNIhtoY_dmuFc57ej7h0RtMj.9x6Tb8IAfShO
 Oigm6TUWOUgGzSzcFlqC4yOHIrue08f6lX.7JFAFZOuWZq92QHuikj2QQZ8RM.t9Jwq6J9JIfo51
 M.XrxzSw08py5WgmEbAdSAso0kmpUS4eV38zS6_wEmIdnsGGeInjof.hUK6u7dPcvTmYlIBa5bRn
 T_4gx7s3I8jEqGh0o.6VinO3kW2DCRD6VH4die_7cRrC1KUCKybSJCQO7vQu1o.RiiQkJ4ITfUGg
 .o82JrFeib.aQUDORo_44MnUIqFYDoyQfVntbJci7pEhjuhdkZq50SU2EXmdyy95MAMctiAhA4xz
 HnqSvqHZ5PsUBuHXR0fjPGNqZsCkl7_9CHYfg0euW_k1cAzoJH5hwoiogiGi3OV1UfU9CSQmxzda
 JGWhqb_5EeARr59C4tWOwwuO9clbeBheBqPx0MmTNb9oxxp8C_TmwEZ9dMZP4cztAwTfL2GwAZyK
 B8JB7GEx69zLKLSPr.uyijzMf0zOx7bf5Prin5xizAY2UtnfFYrXhC04oi2tarBs1jfAW.WzTI9y
 jahsETh0_GrtaE9g9iAXy1K2u6XI.7FcttGdTFNXK8e0o9gG47v6FHKTd
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Thu, 7 Apr 2022 21:35:54 +0000
Received: by hermes--canary-production-bf1-665cdb9985-zm65g (VZM Hermes SMTP Server) with ESMTPA ID fb411508bea18f2038d235ae662d3bf0;
          Thu, 07 Apr 2022 21:35:50 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH v34 26/29] Audit: Add record for multiple task security contexts
Date:   Thu,  7 Apr 2022 14:22:27 -0700
Message-Id: <20220407212230.12893-27-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220407212230.12893-1-casey@schaufler-ca.com>
References: <20220407212230.12893-1-casey@schaufler-ca.com>
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

Functions are created to manage the skb list in the audit_buffer.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/uapi/linux/audit.h |  1 +
 kernel/audit.c             | 93 +++++++++++++++++++++++++++++++++++---
 2 files changed, 88 insertions(+), 6 deletions(-)

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
index 4d44c05053b0..8ed2d717c217 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -2175,8 +2175,61 @@ void audit_log_key(struct audit_buffer *ab, char *key)
 		audit_log_format(ab, "(null)");
 }
 
+/**
+ * audit_buffer_aux_new - Add an aux record buffer to the skb list
+ * @ab: audit_buffer
+ * @type: message type
+ *
+ * Aux records are allocated and added to the skb list of
+ * the "main" record. The ab->skb is reset to point to the
+ * aux record on its creation. When the aux record in complete
+ * ab->skb has to be reset to point to the "main" record.
+ * This allows the audit_log_ functions to be ignorant of
+ * which kind of record it is logging to. It also avoids adding
+ * special data for aux records.
+ *
+ * On success ab->skb will point to the new aux record.
+ * Returns 0 on success, -ENOMEM should allocation fail.
+ */
+static int audit_buffer_aux_new(struct audit_buffer *ab, int type)
+{
+	WARN_ON(ab->skb != skb_peek(&ab->skb_list));
+
+	ab->skb = nlmsg_new(AUDIT_BUFSIZ, ab->gfp_mask);
+	if (!ab->skb)
+		goto err;
+	if (!nlmsg_put(ab->skb, 0, 0, type, 0, 0))
+		goto err;
+	skb_queue_tail(&ab->skb_list, ab->skb);
+
+	audit_log_format(ab, "audit(%llu.%03lu:%u): ",
+			 (unsigned long long)ab->stamp.ctime.tv_sec,
+			 ab->stamp.ctime.tv_nsec/1000000,
+			 ab->stamp.serial);
+
+	return 0;
+
+err:
+	kfree_skb(ab->skb);
+	ab->skb = skb_peek(&ab->skb_list);
+	return -ENOMEM;
+}
+
+/**
+ * audit_buffer_aux_end - Switch back to the "main" record from an aux record
+ * @ab: audit_buffer
+ *
+ * Restores the "main" audit record to ab->skb.
+ */
+static void audit_buffer_aux_end(struct audit_buffer *ab)
+{
+	ab->skb = skb_peek(&ab->skb_list);
+}
+
+
 int audit_log_task_context(struct audit_buffer *ab)
 {
+	int i;
 	int error;
 	struct lsmblob blob;
 	struct lsmcontext context;
@@ -2185,16 +2238,44 @@ int audit_log_task_context(struct audit_buffer *ab)
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
+		/* Multiple LSMs provide contexts. Include an aux record. */
+		audit_log_format(ab, " subj=?");
+		error = audit_buffer_aux_new(ab, AUDIT_MAC_TASK_CONTEXTS);
+		if (error)
 			goto error_path;
-		return 0;
+		for (i = 0; i < LSMBLOB_ENTRIES; i++) {
+			if (blob.secid[i] == 0)
+				continue;
+			error = security_secid_to_secctx(&blob, &context, i);
+			if (error) {
+				audit_log_format(ab, "%ssubj_%s=?",
+						 i ? " " : "",
+						 lsm_slot_to_name(i));
+				if (error != -EINVAL)
+					audit_panic("error in audit_log_task_context");
+			} else {
+				audit_log_format(ab, "%ssubj_%s=%s",
+						 i ? " " : "",
+						 lsm_slot_to_name(i),
+						 context.context);
+				security_release_secctx(&context);
+			}
+		}
+		audit_buffer_aux_end(ab);
 	}
 
-	audit_log_format(ab, " subj=%s", context.context);
-	security_release_secctx(&context);
 	return 0;
 
 error_path:
-- 
2.35.1

