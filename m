Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E0244D563F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 01:01:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345119AbiCKAAt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 19:00:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345086AbiCKAAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 19:00:42 -0500
Received: from sonic308-16.consmr.mail.ne1.yahoo.com (sonic308-16.consmr.mail.ne1.yahoo.com [66.163.187.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8F8EDEA2A
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 15:59:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1646956778; bh=CA7uJV6tefTVDxUjGl1tCyNZ2ZbFLUSTedcSfuXVSx4=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=ASaGEkofQQBycWVbjZoJgqOINbe8Ig7sGI6kouTP4nuO39u8A/VY+qXH3yN7n1bAw7h17m28HT4egKOKqx7x7i96Rva+DUkDJgDTyBdAo4BJVTtCvL5zytuwJV3WGr8n0Bsb62Q9I/2BWjmUr6/866Hjn+2lML0DQcBEz7jThcO/a1e/RAxRyZcGSFySyPx+Z1zQfg9SgXTWPB/n3zokIuMptUYtRMX5716YFj+1m3r/eYPz9lFVho+AXxyD3spEdSMXYYVga2KQfcBgrbO6GhuIgODyMgi6OzJGOih5CviSRykRGCSqPAz+VTv1tnkAyXm7crIk4XeUyVimdOOE3g==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1646956778; bh=tnxBETGvTNaLB3bucuBvOJK9fzvEYSrMZbOWVtxF7SU=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=HearUBV6FsKUqC/k/MtzEaOO+i/+H1Pt5P807YV7vWTl0BAmrnU1+dwUaDCLF4aqPvfYqayl8+uxJ+Z0SMv4tC1pu6v811qoaFFprRE/4AMdXG9cwvrbd1ffLpYyl0KVYx3SSb+0SGPGEym9CzwkMM6Q1eRkb6bjOcaxKammBhQw/2k2mGi1qAH6ohc9AONdK9rsH04KvkrNJwqo2e07rGT2OPEsDRRuDJCulq/c4y3Mu0RvULTHDoU5Lofw2JjKq79o7VHvJN+CcSdgzQQfFsljUz3XmaX1VQCwYe4LiEzCfqMdrvZONUkOuHAHEzxR4tfxpNTUIu0HsiQIhbD8nQ==
X-YMail-OSG: ffRpECAVM1m_F4UQwx6YSD0fsLvJ1iEQB_97_4p1sRjaluUVwhAYVdbXgrPP5bT
 P2.9.L_NEi2yNwCQB.IK8vsL9hbofCyfBY1o1OleMtAxLIgJoOiT5l8EcGmkviMSmOmd4G.ubMII
 pBjqL.w4anrBvOGCo_2Mr9vuQArYOlS2OAoa8AQ6rAxSKCvY9QDevWkUtNEbMx1vRsZW6aCyveYQ
 qRw9IhJ6gMeCArJxMA2ic5iOy_owjmtonKdTJbop_vgp2ZwXGsGeOTHNM.U21iZnTsFMOrJuPszE
 v1l6St0eZ2W.vpJ2VyYbhzPeHMw4RG60C5e9u.79IgQsBBCH4m7_FYcf5pu4ghCzTZVA7M_p12aZ
 QQJf61qdzL7xBD4psGaj_bZgvMPFvlYTcVSSeUPW3pPkuBSe6oxJFltaVcs1KUjO3WCiGpw64OSy
 UNXHH.g84TKR8S1jJRNfZaFqOYXSwWMmTKiMsQCr1xZEo6aRtHbhQi3z9sEI9HiniB8CVr2sFstx
 PhnMiVRl4ECx.WcbvLXHzVmYu7V6CtAeJoku3FCV5H9Y74bzC.6NSYMM8XTjCpwZe_V2W5CQ8636
 HuDRuzGnkxv3d6786x9zlU3m65vQlrUP_xB6XRGejtTcRL1eWb77NDuQlyoDVmMiZB9vxV.nNHMR
 CnxCWEuAmF15rHlc1jaDgENtf4GgtyNJuvkFvJMrB9tDXNfU8Bem9tpDc8kRF2QdQw7s2bf60x9V
 lIkjlfSkJlsE1r.1aRr4D9sW82J1taZa36ldSbmnRMzU3ReU_Ykc9rwmzZpOG1mh5lKRbuBiPNWH
 pFPc.VL57VKjlYTnDA4mmRtrli9WojS_pMj9gyTC7zlrp_X3Udq__a.8ZitZOKt0o97oxqgpShKZ
 C4JrgfNLLOlAmpfDMemNzArdtV7FYKkPKNbDHlDKbYgyXBvdh8MiMQLCCj8fkOEIDAyDTdrwgb.K
 rNuRfIKVkoyHcCfEjAo6UcHghlBut9GO.kgZyw8bRC2O84TRxAr2raA.GSi.S5QvDlmNGhaerqRM
 p3TG6ZH7vuiNM7sLcVOQQutrO3dFlyaFEWCqvpGpLD11U_vR8V3CO3k2D27v_1RuZFjoi6Yrrp8v
 IesfTWk_A78k4i8N13_JY7EDrvvklMcidiAF.rbBAvNBPHHz94Z4cGv_QDcV485JgMCgil9RmU0E
 alQVRgms37unrmJWIOloLQiHdcOUYcLB0J88GzwIKHVwnaC_aFVY_WVJXzDwq0iEWoqxHsUI7Ohd
 w4o9.z.iTA6sVYhihb8srFLlIn2tDd2muEG33pDN2KLjvE2dzGipcsGlIKYs3nTpPr_UYCfG9dUc
 hjcppQifv3i32Xouu3OADeu_CePJfuIqDD3NAdlUFZ6kjCybPjGsnKIc0dUGDjZ6HiroKRO7pD4t
 gZ0EvAqf2Kj.ZIz.3vSNKyWiUoPOxVQ_mie00AChYHixcbibDk5upoThn7xnEgurqQcP2FcckFzP
 AKMNXOYEPhnjWKz1Gs8Jv_CLQ_bLtnNbrgaFFf.oNszxNvV1ICi0rmxgSJIL.fPd_ENMk14GHjG5
 5sWwfz9uqMXfvqMJAOiXValH6NsGmLdBQMvyCgIRWcX1Z9C8SRIGRJGiULFtASgo6fQKkmVEeDhL
 uVM2ehkRc0eCGzSU8Hekgh923O.FSfPB6fexm0KQ04yKMvZavspTeTEI0ryHFnpkLJtfo1G502gX
 2l3GCleT.HS3_.RVngjaR2sV7EPzhcDAHI2JDwgDiiVXGVEpr4SjfoEHO4EF.aM.v_GrJ5M2P5IO
 gVZMuw5DGMQj7MqbGmif4pran.2GrkB8N7afsDnTlDUGhbKHXwytr2tYVk_NmmrG22r4JrvnVXV5
 DA_bmyHmEh_okGPVQyKafZcBENn_QSpT0PF0hKYhj8Gez0_jNhb7Bozjj12Oty13Uqw8Av4B_fQ.
 btQGXLCGu.nSQ925c72q_5vIaTkTkjMAtxme3FBWs7G29aS_eJpjmvtjWzZk_fN4wqstcSE53_wl
 7c_Xb5rySwUYd6RlQGi6ckBwL_J24WFUAXEsMozNNBSexDrlfsX7paADefuMRR06fwEWmUfFhpjS
 YYXqClyGqzjG2SPWgFTk7dNYafCbYzsdhq99d4XwS2aDYMfb7D75wHg2BILhgYl1RF0F7BWmzsM8
 4CWbItd0UwRmLgnnK1nY.j1ka9ky_DPV8F73YFhra7OVdzVBMzGY6HsoECFXdJ4ymoH2WvjZaA7Z
 qE5e95SwLZ7Y7Qu7eoAU_TGqZhahBPBPZxEfw5xGo0.pJo_W0Pa8-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ne1.yahoo.com with HTTP; Thu, 10 Mar 2022 23:59:38 +0000
Received: by kubenode510.mail-prod1.omega.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 33032615d5bc216242260d2cf82dc739;
          Thu, 10 Mar 2022 23:59:34 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH v33 26/29] Audit: Add record for multiple task security contexts
Date:   Thu, 10 Mar 2022 15:46:29 -0800
Message-Id: <20220310234632.16194-27-casey@schaufler-ca.com>
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
 include/uapi/linux/audit.h |   1 +
 kernel/audit.c             | 104 ++++++++++++++++++++++++++++++++-----
 2 files changed, 93 insertions(+), 12 deletions(-)

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
index 4713e66a12af..ad825af203cf 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -2147,8 +2147,65 @@ void audit_log_key(struct audit_buffer *ab, char *key)
 		audit_log_format(ab, "(null)");
 }
 
+/*
+ * A brief note on aux record management.
+ *
+ * Aux records are allocated and added to the skb list of
+ * the "main" record. The ab->skb is reset to point to the
+ * aux record on its creation. When the aux record in complete
+ * ab->skb has to be reset to point to the "main" record.
+ * This allows the audit_log_ functions to be ignorant of
+ * which kind of record it is logging to. It also avoids adding
+ * special data for aux records.
+ */
+
+/**
+ * audit_buffer_aux_new - Add an aux record buffer to the skb list
+ * @ab: audit_buffer
+ * @type: message type
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
@@ -2157,16 +2214,44 @@ int audit_log_task_context(struct audit_buffer *ab)
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
+				if (error != -EINVAL)
+					audit_panic("error in audit_log_task_context");
+				audit_log_format(ab, "%ssubj_%s=?",
+						 i ? " " : "",
+						 lsm_slot_to_name(i));
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
@@ -2382,13 +2467,8 @@ int audit_signal_info(int sig, struct task_struct *t)
 }
 
 /**
- * __audit_log_end - end one audit record
+ * __audit_log_end - send one audit record
  * @skb: the buffer to send
- *
- * We can not do a netlink send inside an irq context because it blocks (last
- * arg, flags, is not set to MSG_DONTWAIT), so the audit buffer is placed on a
- * queue and a kthread is scheduled to remove them from the queue outside the
- * irq context.  May be called in any context.
  */
 static void __audit_log_end(struct sk_buff *skb)
 {
-- 
2.31.1

