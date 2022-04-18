Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C871F505BAC
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 17:44:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345471AbiDRPqm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 11:46:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345443AbiDRPpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 11:45:47 -0400
Received: from sonic317-38.consmr.mail.ne1.yahoo.com (sonic317-38.consmr.mail.ne1.yahoo.com [66.163.184.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11FC55A0B9
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 08:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1650294772; bh=h32jrF2Zh2EvU2lSatcW64eAZi8X5he9uuICOJ6hcZ8=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=EUEXTWu282YVpawuQXCOORYBr+NeDn4ScXgjC+v6nlIZhaPqvRwTBrnd6+F3iCJSADvgjC2YCKld51Of0IMci31JMbuz7ynN+pZGDbFHVs8MjJlu1tBLQ0Eqb8cRp9I+E3fcIMoN1OrE9yhMwdylhL1wyHROrN9MmgJuunML7udwTDK5imkPTmGwpZz0rMQ9IJ61oLe7tfWWBRiDDvKbGf86fEromYYHL+NrGqc9vJ0rM4eWj3a8m+vnoefWoM0xpjR14B89Bp0aJi/hoEKKyQArhgi9c8mAhlXNMkTqFCw1iAaXeNOaC/Y9li3vPqomt6C9gKWS0DKOd27fzP6omQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1650294772; bh=pmA4xACC778LtA74VLN82kthedtveeafy7lyo4EkjkV=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=h92aszvKyyMkCyOvSUBLoRzD1iWwWtzIYor6YwHpKglgZbWzlz1dZFLr1DMQQCOFFBgGtG2mbjjOdUnebdfgyfkuGXzERpOaDwPC4xjpHhNMCD0jjP6H3BX5CTdigXf2osuVVYddGb8g82nyWHYSL3F0pqpTM2UKnAhzhCbsDXkWLPKy69GefnjH86Z0N23dLS9idcqS8oBV+YenwP34rKqdpJTm/Ny1k1788ZAk2S2DVhTMAhOaaVf/onwm012nnJ51PYLpkKZ/TS33vA0h94PsF8NoEG+4G9z8tOclrqSnk145fCPhvi6Wbea8jq3mHxH+lS0tUYbLNMLJTHaFxg==
X-YMail-OSG: p2PFZ4sVM1ndt.GBi2tcOQNJYAb6SqrF8ELPpvVVoQcBG8ub9Ox.yvlCyNJbcSU
 RQBIh9nfafvpkuhoIpklIG3W.RxlWGs0nOOa4yyz7abTHsiqpYeJLFPW.4FhLtTdPHQUytU3ulX4
 Yfu1_NJ.aI57W9OEBuvS6aGsx.z4NZUoAyZIiQJlTRyW4lnfLHE9Ob7XtjGqJh__4AGfeRdYYfrP
 RTJoqaiEf8PbskqpOh3r_yYMtyFdXhKxPc8KIcF1v4f3xrYRoAiXAYqTM1FMex6tHm4TBWWCa_Vu
 9I8mrTkU7fAyNm76tppbiKnEgDkwi8mFzGEZkPQ0INth4cOzEOYVRC8JX.oHN.AdWsBtfl7FaYqS
 jlWrazgingSDphC6ls76IAYOkYBB84mVG1km5D2aOwkrZ7QbJlG2JjuJUmXSXTd38AbiYdDYW0kk
 QVXkcRHUPUyLV_VD7rKZALEgc4z6YCtPoMGFsJ0TKZbPCx4vQthfIHEodAUhvYPbI.Fuyo4Uz.P8
 82DdaIjqafNSEVAHRiIwHo_ln7SMDeGpFv0jnP4UknfdWWsfejT0VlRDYw6hLcgcYLlxoDIv601b
 hXlOzOyTj4baB8i_iOVrbpdaexrL5dVzciLXcWStxHGdt9c1cGa_yKaQlv1vH5adfSpALHTyvfVQ
 SytNzmn9Vq1G2DciSjQ7UvFbKyYM31FESWrjTv0XvR28EKLebQycbibi.Za2It.3LTKHRawJ9XNZ
 vbvwtHl2SIOSfYtHRyOpcspZdBWv3_YdvQhtUIdCP8kPZH59OS6MAX.6AiuyMMWT0DCRzBXUxdca
 KiW61P7RyikAAkpI.s1dgUUGiMjLG3jJQPZ77QwYn3pvma0DciDNBCK.L1iYY61xyP5Aq_VAibH6
 yHprYgjnbC8qWpOMroygfRcJtjozb8COFO51AN9KN5LQXO3E48M1Lip9Np1kzV6ODuTeF9XnwC_Z
 6vltyXcx6CNEi.y8c70zj6vEhaWlGrEkuF4c2TnJVIesjnY7FcYRaEWsAsumUC89gYDVgxiUjMRV
 WVxUee2.RMLL3CFAOYpMtfksb2rsos6bc48XNbReMpnMsLPh3MB_UV4ZvkODbmZyOcoqM8PT1ssB
 GpjnEONWpTxpjdc6wUdFl7qlizIIQBQm8PIIawXSg6Rc64SM2kE0iBb7e1vmYmbwvXNaW6X0_4A.
 VAJ4fqx88xM0xduh.pQ9EEZ36fJaCKM_XouDNwspQ5yg4nbGtuC1XtA4KKkhqO_wLB1S2GOw3sxj
 k_6b16DKN0YE6GPy_tHC6SMo7WCdwlDmjQGm8SaGCLDosQkVR5RodyRoZx0voIibbteYiqCzLK2o
 oVvC8rKQ.a9Fgb3y_felupTRvGeoLyOSBJOpxGFb1t9Nc7eEsiv7oCfEbWFdIFQoXuwstV7qCVAk
 DFFChX_T9Hz7V9Gj29p3Ko1m03QKUKJsJ0iV1rpNoGqo9mZoDMoiznDDwo2d4Eypm2uSCWIMkhxM
 dmz3ggiMzPdLXepwlJc0PWe4maAiovOO5rFmU7omTKfTeu0.ylNyhl654JT7YlUOtOqlZnXmko3E
 Yx6LF7b_z2rtbFehEx7JTLQVyoiQ09RdwA4C1FciAqdtNt_lPV0CNa0VDCRJ7jw54Eo5zysDvZvU
 JnpeoANeDbMc8VznjWr.fzdO8.8PyhbVueGJIWE_XhVL2GkEXtTZH3067fpsmtrLa_41ipXDd_KW
 KbuwULV2eOR_SMvLJ7vpFeHcRUUfhjcOxUnGdHNoIBbjImG9fBpN19Ml_kr7RqYni_tqi5yEdytV
 0G0wnj27nJdNrXlmsMQd29eTjkOWRq6DFnhWslT9njAgtPNqb3PaSquOOI3dP2doOZnaQSMmUOGz
 j6kobKBqAaV4elasGxc_4Z7gGxoqXInP6ZdbPA8ojFDbGV7Re1MBcPtzb5J69tnt502dYvNsqcao
 JeMTn9FsVQBThvSSn7VEm0mKaF3YoDajWY.5OPmLXGIBFNfid8A5eEOwNk4Gzux2u9ExL03zJnkU
 5gt9dPvU0NJpXfGyoPzAarzAdLc.GskrJh3OeKGGjMx5xwll9Eq6xXxjJIGD5VvlKo8xF8y3IQDE
 BDE0OlbLTJX1w3e8OBKjU_C_vNi477qPlfYWGnu4j.mFplIA5M_fkaawST1B2rEibEDq5At.SrUq
 UO1tUSUzWzEr6f3iHo7Wd82zck6Rz29bl7PCRFtizRjKhKs9U.R2yysJ5gYwsqtbcIuy1BD3J1Lz
 xSqN60ANCbcHKues8mQcH7dut6anZwpbQu9Hcmmv9rNs.HlkFCrfzTLxep2ha6KYICYzqjuq0.Zi
 zejFsSCd7wcV4s.AyL2v7e9SUEW4D3RYaiO7Xm40YpKoSZAc9MRPL2oJD
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Mon, 18 Apr 2022 15:12:52 +0000
Received: by hermes--canary-production-ne1-c7c4f6977-qcc8c (VZM Hermes SMTP Server) with ESMTPA ID ee952e2418b7fa05874502fbf35997b4;
          Mon, 18 Apr 2022 15:12:49 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH v35 26/29] Audit: Add record for multiple task security contexts
Date:   Mon, 18 Apr 2022 07:59:42 -0700
Message-Id: <20220418145945.38797-27-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220418145945.38797-1-casey@schaufler-ca.com>
References: <20220418145945.38797-1-casey@schaufler-ca.com>
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

