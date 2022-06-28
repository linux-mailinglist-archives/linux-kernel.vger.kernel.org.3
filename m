Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 296C055D5E2
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242969AbiF1BN4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 21:13:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242954AbiF1BNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 21:13:53 -0400
Received: from sonic308-16.consmr.mail.ne1.yahoo.com (sonic308-16.consmr.mail.ne1.yahoo.com [66.163.187.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 475F01EAFF
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 18:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1656378831; bh=KWpA26gtlvWO/il7xoaxAGnTtkd69RoCWupkmUBZbjo=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=d9+itOcYdE8vK1eCZ8O0VHKKhHTMJjnUECqaFcQIz3hQ6eEm83z7BLFZnWBiy31jgSAhHsrqAwDuYo5lwfjw/YwUQV1DUY5YxPJWotTGMCUiEE5he1LhteaTw+vDcd8H31ILpqKffV+fSMKsunmC0NygraIHnvBGaWpaC6BoQaaQgpMwu8iqtqonB6Ny7sYHHy+xykmp8cnYiVWzBms7y51O6prBd2ePNDsJdJ4iCTQItQu7lGmyKmqwWTox7KzhoiiRH4/yvEtp4N9LHTh2fO2VX8oWtkKmmnkxiVb0o4Ru4TYjLI01zsBLt7eR8k4/o8MWxQR5gaTl7szrT78yEw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1656378831; bh=FIPNMHPn7hBoLTKGS/sXbwDciJnpgpLeDpiotzCLv9R=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=UTCSawZ/a83Icp31HeZe/imPRCUVqVNz5tunKrdy5ihu3hsZP+VkFKtfhJKdaq7SPuJGj6o2EV7XPGPgdpvYxhwBtu4oi0LakJaECHt1hYwP7UY33QLnf6pdztKmusGzAbQ923sIco/zloZ1dpb5/6XkzTclDBeysuknf17vMgJXNyJnbd3o2FYFRKPo839aXDUkZgORtsLTqSCpbsUhecoJJ0+lVCHOAcZFuNHty78bSeVczAEKsx/8Pe4QhPtlfwHbxqaGA3N2aV77ydlKtswEnDYsLYBvfceqNXLYOJ//Us1KGI1JEaGZAn706HXpT2vG6wnHCVQ/bnqf5IUHcQ==
X-YMail-OSG: v7kuU80VM1kIRGekmPbtvh6fQ7Imje1K.5vzNc4O9MCzfrBIr1.ONOk64nV3NHW
 i_BAWzMebniw_M2VHjF2zBi_TNvGNUZ.xUPvmQ4aJfBrmJOLTepjZqGJ20oVvJ.YO3Kx9x4VNr.C
 Kyi02e3vuHyZpNaJxJQxRZAXnUKpG1yGQQMQxUmzQmC1df7aNrR8JNq7BDIC34p3GbIgVCUicn6Q
 veA6sonRE6I.XrPklc4Rv4iaCMHuN4FheSBGs_4gGjyavti2o.7JUqUywrwS7pgRAy5Hh0R5HIT6
 WthNv8gRwpRCktAmoAXvhVe6qH8fQknp6mFibRxSbuuf4z0SU4FaBHYioatl4v30a2c5IL49kC35
 cr070i4UdQdRbPQosdGHKbgIVOKX.FhfT3tUo0LiTAgxxuAeVjls9bEvLrvW9Cy6e3NewceshHE4
 oHSCXlzN5HXFUxkJkcCVKzj5eBv4jZJgsZpI_7Ao.4R2SxhZ7Jl7XMYDMDH0MRzYVEnz5RU.Xetw
 7lyXRQU0Dd7j7nJrzE9w8KbJ.ijfY_0Jx_K_q1DSSEaYsZUo1VwuY5SJVJLxnjsNKozsX23M3nnE
 lpjJENlAdtCMobG1Jbi1g0SDnC7uy5ClZrf1PxhnwANw03rJ_9eph_MRHHPFY5HB8EobOUrspYk7
 hOTROQtHI5FYfGthOuNykqgIfBsmC5KGL.cf3dflDra8NEZ1WEs9Era2k2lfXY91B9pRDNYGU8GS
 Io5l_2FbMYSUe.1yDDh4vLjHKWWvODQAaQvfNJYtRMVznAssaJ4Ai7HH7jDbD9TGZ8ZabgvXVhPK
 o2YU6j54bshwgvqlzJFQcYX1W1BfNDj555Z.1bkqO2PFiAV7IIs2oci6bA5ZFftk6aipHwEyw5lj
 hTgjEwA1.VnDzk6qb3DUCDNynD5KJWVnVjkkD9hm29VewOl51dfA7TZ8LO4bA1obgBF_lOGWwJmH
 PQEr3CsDFwZi9cb1taDDbvE8cXqX3Hj7T7L38UtVBuy90gFZnqsTBRQopT2l9LiDzI4T0BQcJrNx
 iV5WegC4xC9YmklShYk0u4vBUZ1qdLtXAPg4v3fVTIT2s2F2PiAM7mdzek3hRkStxSY1j2hKOTMh
 txttW9uUd4.b2aSPNsnOSN8QCjve4bCSHeL1DCqOz5nNWYo6.DAVc66RrUivCScsCNbtU2O3dY7y
 .FzMhdPNjEoc6I18BAJQ6SQaYElyBfkRa7A8MJwCwsFoBZGfklO01AcS90ZH9TFQscolUOhX0Dvp
 5WbNoUELlMDr99TSTtV8_DakFdvuW_MM1ZrYNDsMTxh90gRPPkTdYkmneRemXGZpuPvh65fW2X1C
 ER8W3pJncpavIvxDigT6DZhBJ7bnoI8OuMY.O7zEMn1wWzWJGIgr9VUGKmyDOSVP8N76.6TTn9PH
 Z1HBu9nEPGBuoGBTfn_OH1pS_e1q9pARslAHzbn308KPTZfpKE65U8tdlnwpC5eOyRvX0I.D9GEr
 Dl7hpGhYNa9Pbj.KSOfQni3EYYUA_wqaLkbOjx11FzuhciPS_NIKN02AOhBAzTc4nfF56WrSbZwS
 jIbABtGcrSdAnEiRAfzuhqJt91PAjjBeD2UFcIX3D9qJOUmnzaJOPo6AqDBxB3VzjIfend.5qp1j
 3.FkRh222QT6nszPmS049S1KvLLVIXRaoSDtqsk0Tpu5NY1avcXgKG2.Pb86Oiob1YehjBZnETJW
 j4tIl943MOVOuOtpEvdYceLXUBMlF45fMoXsZTkN6Mn2O1kbfpWzRfnd2giy04d26Ip.kOTHFUeJ
 SYKtr.iK.oAU9GtENOwFVhtnbNBZdRa_2itqQe6rFeYn0.QdlQLkx4K8dLUeIz96GC6W7chdgacs
 NYa4A6fvQuvGH2hDxOmSwa3XaJDc0ZJm4Cq3o4GtmLahB0YFi4H2f4vxIDjvKqgYhkkQ8Cp_7Bw1
 bP6iT2g6xs4eSLOUVuZO3N11oi0E66PVNDMUhJHSvXrCWHrpwy3SOilL12I52krC7E4I65scNYfe
 K2lfq4ZZHCDi72_Sc1dkkNY3rWByW5JMUDM_I42q96vI5alkVX9r8Ua4UOFAeR4ewOXfAZuuobN6
 GarqZhRCFC3mkJBO1yv0ng33fUjQwpoP45vJr22t3sHUhPN17NqgBm78qArDYOgVRArAEQyhQrcH
 Q_XHcbtpvnBhCjFVnffCbyHlLE27pyk1a4dxmAbumKDDGFsO4kHXpKKVwTfrx0OZx7yQr.QU8GqJ
 d8B895urQKyavAlqFI0r.JOX0OBX360RFcwvZqtRL4MUPMzle6fPjtYGnSYYvBB4BJGzkZJSoDDr
 jS3Z2CdZRUSRCLgCN0o_8mMJHEWcc9DN.ilyqvG82zAxX
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ne1.yahoo.com with HTTP; Tue, 28 Jun 2022 01:13:51 +0000
Received: by hermes--canary-production-gq1-677bd878b7-wc7mq (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 10aa32686a323c4cda69b8a84be5c273;
          Tue, 28 Jun 2022 01:13:46 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH v37 27/33] Audit: Add record for multiple task security contexts
Date:   Mon, 27 Jun 2022 17:56:05 -0700
Message-Id: <20220628005611.13106-28-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220628005611.13106-1-casey@schaufler-ca.com>
References: <20220628005611.13106-1-casey@schaufler-ca.com>
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

Acked-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/uapi/linux/audit.h |  1 +
 kernel/audit.c             | 42 +++++++++++++++++++++++++++++++-------
 2 files changed, 36 insertions(+), 7 deletions(-)

diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
index 7c1dc818b1d5..7a5966b46f38 100644
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
index e4cd2cdda7f5..cee5ee02abc6 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -2228,6 +2228,7 @@ static void audit_buffer_aux_end(struct audit_buffer *ab)
 
 int audit_log_task_context(struct audit_buffer *ab)
 {
+	int i;
 	int error;
 	struct lsmblob blob;
 	struct lsmcontext context;
@@ -2236,16 +2237,43 @@ int audit_log_task_context(struct audit_buffer *ab)
 	if (!lsmblob_is_set(&blob))
 		return 0;
 
-	error = security_secid_to_secctx(&blob, &context, LSMBLOB_FIRST);
-
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
2.36.1

