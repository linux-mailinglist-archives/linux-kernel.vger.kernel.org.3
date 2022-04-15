Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70057503156
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 01:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355662AbiDOVeL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 17:34:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355444AbiDOVd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 17:33:56 -0400
Received: from sonic305-28.consmr.mail.ne1.yahoo.com (sonic305-28.consmr.mail.ne1.yahoo.com [66.163.185.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04E1DDA0BC
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 14:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1650058285; bh=h32jrF2Zh2EvU2lSatcW64eAZi8X5he9uuICOJ6hcZ8=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=b8AkL3Lrw0NCDpk/+c9MUKVTG+Wu5VFRG5hAnHXVIEO0nCNzC3A0GzkJ/FH9PaZ0yfGlGsjd9jvkNuhGwlnXAT3uDMgQuT9kQv2GtFJsCe7XUYuNGmCXPVjHKQMaBqYFpqk2eGg2lSWNqrDpIMqqdjNmVS3FbHAHs+YSfrlMDp3t6c5SseEFkU40s7uTzbd1EI4WxblDII/R0jhZUG4ZDXU0cjvNOgoIvSQFGbKeNzJEv56E1AlZlA3nJLL+ClZbls8khY+lqQhrziirsrNhPS27oSkDXFS8gtiPQxYpjYSMsZyI28gI6xTxyi3zZ7iaZNH9Mc5W5LVJp5y/RmzcdQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1650058285; bh=N4aDelz+qBLB6Ic0r9ls8KE+iNmudrgppirdjkSwCPV=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=DBVrn1Y/4zHn7ol5s0FFqpQ27Ti05rbt9fTAz9Pv7H/W1PAO342wSn5sQeBCJsob6MjqPFOjdJPBmNdc2EwbsmNX0w2fesdaxv4VwNuIuwmYqTOjLUBNikjpVIAfAHNZqBJbju61AaQ0Y4Jwgyaf9+CSavYxkjqI46BQF5KBEWqZHhHNr+3ZHdhuwV1gNmDtaH4M5UCeLO7lS9r9xB/nWX6FcwewnX2XxbCTNk8QMDErEEqzTWRexRM4FX27CP5bbuY7l9GTvpzfBneYMZdBmFMi8v12GjhZDTLdxcc79rLgLg2PvHpUO6FurJ8RMQPJvy/A4geMCAu510wwBOZ41g==
X-YMail-OSG: uQPn.E8VM1maRVLlJFdJ4xOiKzP3F51Rz6KRFkwTC1al8f7glB0nOLOu4XVc4rz
 YPPlLJ037ygS0BIhHK_oZ6DNGMAHm.GYW_eQtd4z0y9ZDnz65FBooQwakVAcnaI7U7woEF.UkT3P
 R394kyIOzWFfTLLgyqtgHw5hNBL8iCfVO8JinOl7m8.FM48mS5R.bbz.lGY5rZfSNlpbOC_wLx9i
 AuLDb7tu5ejOC2CJMzWsXXKb6lrqhftv61EL4D.7ntGSq964Qu2XSWb85RNSMHclnMs7T6kWTikt
 k31GRMxXfsdHFMrE2yCz87sp45GCNarzRoZEhjFJ5eh7TZdBGt9kgCbbETjnzPnbOPyu2GXYwFff
 I6B3j_Mp5TNQwTPCVIQcy6qgqlNUkuQJJNGTQzfbQjGCQj4l1fShh0kia8l4HysI9RhvRegLnM82
 mP_hbqigcF6kedh2mRIuhtA75c6DuHcRa75okrPG6t0haM7ZYwz.h8R2Xtb4kcL5GVymYU.mMeOu
 Z3_m34LG96QYSxOn4besQGjAY9f9LO49Fym0TV270cx5rzY4w2A.rhZH8bp5z7dLkpGrkBh2xIFj
 lxz18TM2ws.Np_eaJGeC0CkvWpiortvGAQXSbljDQKtvRGJOLztMMPfcQFS6t8axXYY4Z0212cy2
 CVBuBF7iIYEGupNwxd9ohczS_I78VZtBmU_Dg_jVram_TTy.orGjtRRVaOCN0YmvTGC1pMMmRpzf
 .kxzsZxg__FItKCBkjonQ9Mj7HU0QGPBnUk0zzmee.KwR9mMgI4vBQxdNliTfLL74hNBC8sVHZaS
 Znoir_GYHEfmtuS0Tn0RFM6wAElIiM6UF7NJ.BzcmwYeF3kHlEpoE7Y4DrHCrY3FrZJWWUDQwuSP
 SNUu_uGBJLjnK_LtpT9WKR883YaIMZ2zLXjoDvg2Q4zpE8n.ZCogR3neUuSVV3sZ51hUKzQtEJ7Q
 kkhqe6H5_pX624TE.kKJ4O3A6tT2lSygXZWpaep_bW3imJ5tWFaBnsGVWcQqc8cZ7s3LXi2TJbur
 ZLbMSfz36ByomiHsZitiympaIFC5pGJv_tQss63.tYE0UBr7RJ9TWia0p3fgtGgVkeg9myP63res
 jip0qqRTvMkuTjtFDatNA1oJBxV2Tt1.9uHaLR7uQdq4wosQhW8q42Gip.9V3wYgdrK7Ayu_C6F3
 KAaYXJKXrIhQmK_AT.Oim_WxVTToAfoxZuUl8ICX1MwHxd2FiCBibTsYHtxCc7iNfJ5AhCbbcWrF
 H3raon3Fpo9puNTxcr1YAE4jhkvb8kFsWczevnFrYwcOBAAxDZqoIpsyXHvhV.2mtcnkfJutlARo
 w.77FFzbljMPaqtPuMp6Of0x5Rch7nKMR3HDQKgoFm5ozpuN_rqSK5gx_29NiK02zA_i4GXG06yF
 Br_Q_5TUOEDaeIMjDu2MjmLsDpQqFgboKtE6XvSq9Y_wTu1FPppVg6UiBpnPL8VXeZFLefm_WW5W
 pDN4iXPeWK87.yGLQN6FBtuIqCj93gioivBzYl.Pjrn.Wheifk8hlGxJOOHMgTVlDeG2YO9p.Te7
 XFppbbODDrh4XcyaONk5A9f6.o1jOt390DyJfuooOvzvg.WJo8lTmPY_z.EYX9qfTH_dGsCIhDrf
 XrzYksL.NLJZfh6bz80ZuzNAdpn6quDbDQRgGbDYQ_49M4Lpaz7HmOULreCl3tT18dSTHdw65GlJ
 tPipgOLnSTKQb6rd8iKigNGIErgPOBkrUN8RGvYzWckqVgjrHjzGTaGoioiijEg1p.s64Bahat7K
 r9KTCglCSdLuN9uamCXYyvUnSTihCtcf6bOR7Fxr5XfGm5PdQeuSoGrhaMecXRp6Xdu2ROoAhbEy
 1Ay46xt5gehytloQ8ylaUU16XjUguoGfpI9M2dlSZvnbOo4HYEKZfJ.p5U22ZTaAJSMApsFt7bwM
 xwvqhUDn2VfuMFSenC3BtGyG.2WyICr_4HSG2ljSaWo1KRWaUcKR6LIWQve0Ppc3U_HzmaUaz3uW
 KRfQZBeCNWmROLgCojQ28.wV1ZUf5iDE.d_evZfMd6.KADNY24zASwD.DL1LgwPgHSu4G7CRt6jB
 WgS_cyxEgg46aL4nZzeMjPc.gHqvM96GBi0PP1yX.jiLW9rMZiDJyjWMH7huO86og19UGA0Gkzx5
 rozWGGiCNqO6WuH9ucN1z.X9OK52x6GufteT79FcBbhdxr9iKqUQp5htwBIlcs6AW4oiZk_s8NX2
 SI1Wv8Lx8RNnqUOe_2n4OmdCYfl1rLk6jhcV0HuHcys9_mIFP_cakWgt7dWYMWf92sOg_CRkarnU
 JQuo-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.ne1.yahoo.com with HTTP; Fri, 15 Apr 2022 21:31:25 +0000
Received: by hermes--canary-production-bf1-5f49dbcd6-hf9hx (VZM Hermes SMTP Server) with ESMTPA ID 13670bbd638f1f6033ad5ba33b62894a;
          Fri, 15 Apr 2022 21:31:21 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH v34 26/29] Audit: Add record for multiple task security contexts
Date:   Fri, 15 Apr 2022 14:17:58 -0700
Message-Id: <20220415211801.12667-27-casey@schaufler-ca.com>
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

