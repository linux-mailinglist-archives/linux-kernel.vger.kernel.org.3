Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F71755DB35
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:24:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242982AbiF1BMZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 21:12:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242926AbiF1BMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 21:12:18 -0400
Received: from sonic308-16.consmr.mail.ne1.yahoo.com (sonic308-16.consmr.mail.ne1.yahoo.com [66.163.187.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14D69237EB
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 18:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1656378736; bh=/hWrEJoPbYDBQy6DZ9HC/kYn/Pts2PMigLiTulWyLd8=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=YcuLwxaWthwf270MteCN1LPtVoDatHuUyWrffx12p+G3l0wLhMRK7ZrB7ezIgusGCzMG0WIRl3IuFZLIMyd8vRQ24K8Zlbofzyu9jPxxIBwkYw8wJGgKoAVt4iD18AmjE4ojzBGJWhYBU44+Supg/oWoPB7KB1Oo3m97ECVWVwGlS5rU3qcLPSAevuw5oAg2Xm9nYP1+7U3bELab6cxlJV+JbTvnwxpPTKE+T36JdWuM1GrXB6UQoimMKa5kM1UMMj1AolcxSMDX75BRbtXkXlzyIXtPMjNVZ/7OUtdIg8ENpJ7TkMj1F7/T+hUklXF0L8rZOVDzyImsmKxhfAdjJg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1656378736; bh=hIbOsw4vOQKcIQ893RUZxv/lsbLbpVmDHry2DF/UnRy=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=JKz66iNpWpzWM+8o1W6M+Tcx8pZJymb6bD0jvYXiLp+h19K1UrwlgZZDwgANoDaVcsP/hqrFx5wd3VUL96MQJtfnIC0OKLt3alAQXTnyZdlOH3U+39uUcaOvwMNVljbFJhIlVDeJJCwUhlgITd33BIpJ2I9vpCM9/POpR049OnFqdEvRbnc6nw3b3D8zVrgCMBotxFg7t5CQy72jB/HrHmnQQsGbF8Ee/6XXbCSGLRMaViHFvFZilW5Phzuj8ZZOI8h3q18nZJLvgdUbwfqYTYwXqdmu1pZ9VKLz1gIN1JF1oQsQ7EoHwSfXaOPXgf3xw1xlGluh4UI0kJ/oAgyF7A==
X-YMail-OSG: brAVF54VM1lGAnwua.sfNfX2RnO2uSH2dJV5XgNb_ONeH3A9gYjZ2L11qekqpCw
 QK8J5OgSy1iR_GL3WZ3hLs_bm9.Ef1uc4lODpaJMpuMZQ82O_zjlkIjn1Uxgl1tw4lrfpc6Tg7gW
 FHuHFkc1GgG3bRJb6Roaooy2QX.Vl__typ7feNHATpOrh2hkZK_H8iX1MTkkQmbNWmPDqhB_seie
 v3STh8OX5NPknPlIQBCETUrtypoOHFqXcwdiYyADOFlGieVED8ho3KDlasbIDA8_Ems9I9LJNpHT
 NdNMWWq6nb5TgPHxMusjlY3ww6tIRrtHpf_eWG0CsMI6RaMSWEe4U4rQRRV3pQ32FqpqFjNT6bIy
 3otJ394VPzgU5u61P8Gc5c3pbOAwOSFz0rkM2zwXwBYNbk_X5_3Z6ap0rBTDfu4Pw15uuzSFlzxd
 3W5elhA4.kR_k8b4gnUNKifUo1.F5fVrmcaJq4hrJe4bGdOyKm_IgZkSneCu_h_n3nAKTecacW4D
 YwvRlT5dMinUBmvHpFFy_D9i83T9BVVCpFeUVKYb9QTk.rKP.U61bYZM8zl0ciMZwudmnDb0OlVw
 Z0h9EHsbG7KdClBkLQctZjTUuskbtHnFRc2mF7mMmDplKboj.wBmclZHDBXqMGESfXD3fh3T2Onz
 9iZOrMzk73HjwZVH.5QwD8Zvv2JllzwBU_NJdYiJnI3sDK6B1vCsB0EXBzW87ytpXptAWsayiMAm
 12u4mSLPqRv63Blysm5uqLrh6QEAieASkeXCR4vgoXeA.5FUA7KcuHfYiSLn_McnBxSl.KlfhR.1
 qUpbcoxcpevGNYNrwTq0KfoxH1T5Ufo1b6sH4K8VunTm_vTSzda9pH22ycIVhONdc3kQyUJJiK69
 Hz5ULmhZVDQqU291EBUlSk.p_R0OdHzlXWKsslgxb1kQaShtggbHB07xBKXThBrgJrefR2U0CIBJ
 bmtHbA9RLEyuUqE98RNMH0Fxib5TfpBnM_ppRyfcwGOv_pbM6stk2novtCqIZsEbssaGxxk1XLZm
 uJ38qn5tezDYi2VL9IL6o9sxwxvl1qke77aMStK4x49jJcyAwI3F4r8ydKve9lIA7imihHBYsq2Y
 MdujZotOCiZgFC986pSjOvcuFa36rFGXIcRIy_LSqbGYFpjitrVSvoY9siPfc83V6MXblX2I_tVw
 nKlr5RV_Gw_.ymAAi3fRozv.hAYIhFWCQ6USOkbxS66N8YnXbjb6r_QVvEACyPEZGcsSS5AtERIk
 JbLUdzGnBNm5TEgEtwVQXoj8z0IK4s.Vzc5AWQYvJ_pXZ2T8wwoP_5xl2EqcwJgWHo_1QfqWGVfP
 W3GdH6CUsxZ136rB0iMK5mrPKKVmRaQwSyfZaZoY1ftKyG8G9pugughsuNNEzIgoqVvb2Rcm4Fdp
 4emasNUWE1P2_57Ec_2_l57ZeCDiDpx1_u7ATeXsqSxg3Hdd2ZGIvsrNCiAQlBqJ_IPA4m8l7Arw
 oDdSc9O87o_AGgKthzCAQC2Xei9XemC5QI1Sbwwu1gZNKuqXfMj1iDrdTxBXnXkW7Bu6fss98Bdq
 sZJjNMGF1eOrVGdergmOCSqQta8WyptfRYN4dTYDxdzhC_fvj4LvfNixTLaAP_OVKyFBpXw4JB.C
 qmQJX0JIIf_5DFJAAD_K_pQSzNMrQIsiScrVD9CmD6_Pjx2OTtA1thS5ytetG7q_WMV03ScfAGYk
 __AF3XMfw_ghs58wZbJ_R1sdpLW_UTIurC.mpFTpfrHaIWUGDwBsx3xPdJK3yJlA9Bk1dBhXLsY5
 1opdEZ0kJFowT5vDAW4c4vnZugIXvuLjN0OYy1pR73KHf_bJPvH4hL03dRubAHlt0Hv_AK81D0hK
 5ONbEsoO0OuFTh2Nc4ghGgaUVhId3i_9KEx_bqN1qeHcHNtAJFMBtNq6bU004SQuXVp8c61wGkKs
 vVYqvk8oCMAKv8CosJm7IE6z7o170aOkeCcX_RNPrfn5bnNp5jrI2l4jqegzeXeApo8pTG0siHol
 1iLDBstMhSPiqOKiYpfMCJBViNt1YuwTV8ySILYdhG8ekl65Taht_QdXTa2oDvVRzCorez_bn_Un
 rGIU2zIn.u1yfRriUUmFXcuwE9i3zBj._S5EfqheopG.18KABOb3qOl9tBkZQlEhVHx4gX02VJn9
 N.RjpkxDatzuzrQuGXT4p3h2DEpETIL1YDSkpVfLv2O50nut0Zvd3REwEHOJdRqkYw3uai3_Sl0s
 f.CLfuwaqaulZoSe.SPndMgTzppPJm1VCeMZVjbbi5JeYPROFGuR30OmIMvY-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ne1.yahoo.com with HTTP; Tue, 28 Jun 2022 01:12:16 +0000
Received: by hermes--production-bf1-7f5f59bd5b-zv7ms (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID f1d422e5118ed4ad306a52cf19212beb;
          Tue, 28 Jun 2022 01:12:13 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH v37 26/33] Audit: Allow multiple records in an audit_buffer
Date:   Mon, 27 Jun 2022 17:56:04 -0700
Message-Id: <20220628005611.13106-27-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220628005611.13106-1-casey@schaufler-ca.com>
References: <20220628005611.13106-1-casey@schaufler-ca.com>
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

Replace the single skb pointer in an audit_buffer with
a list of skb pointers. Add the audit_stamp information
to the audit_buffer as there's no guarantee that there
will be an audit_context containing the stamp associated
with the event. At audit_log_end() time create auxiliary
records (none are currently defined) as have been added
to the list. Functions are created to manage the skb list
in the audit_buffer.

Suggested-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 kernel/audit.c | 111 +++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 89 insertions(+), 22 deletions(-)

diff --git a/kernel/audit.c b/kernel/audit.c
index e4ee8ee63484..e4cd2cdda7f5 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -197,8 +197,10 @@ static struct audit_ctl_mutex {
  * to place it on a transmit queue.  Multiple audit_buffers can be in
  * use simultaneously. */
 struct audit_buffer {
-	struct sk_buff       *skb;	/* formatted skb ready to send */
+	struct sk_buff       *skb;	/* the skb for audit_log functions */
+	struct sk_buff_head  skb_list;	/* formatted skbs, ready to send */
 	struct audit_context *ctx;	/* NULL or associated context */
+	struct audit_stamp   stamp;	/* audit stamp for these records */
 	gfp_t		     gfp_mask;
 };
 
@@ -1765,10 +1767,13 @@ __setup("audit_backlog_limit=", audit_backlog_limit_set);
 
 static void audit_buffer_free(struct audit_buffer *ab)
 {
+	struct sk_buff *skb;
+
 	if (!ab)
 		return;
 
-	kfree_skb(ab->skb);
+	while ((skb = skb_dequeue(&ab->skb_list)))
+		kfree_skb(skb);
 	kmem_cache_free(audit_buffer_cache, ab);
 }
 
@@ -1784,6 +1789,10 @@ static struct audit_buffer *audit_buffer_alloc(struct audit_context *ctx,
 	ab->skb = nlmsg_new(AUDIT_BUFSIZ, gfp_mask);
 	if (!ab->skb)
 		goto err;
+
+	skb_queue_head_init(&ab->skb_list);
+	skb_queue_tail(&ab->skb_list, ab->skb);
+
 	if (!nlmsg_put(ab->skb, 0, 0, type, 0, 0))
 		goto err;
 
@@ -1849,7 +1858,6 @@ struct audit_buffer *audit_log_start(struct audit_context *ctx, gfp_t gfp_mask,
 				     int type)
 {
 	struct audit_buffer *ab;
-	struct audit_stamp stamp;
 
 	if (audit_initialized != AUDIT_INITIALIZED)
 		return NULL;
@@ -1904,14 +1912,14 @@ struct audit_buffer *audit_log_start(struct audit_context *ctx, gfp_t gfp_mask,
 		return NULL;
 	}
 
-	audit_get_stamp(ab->ctx, &stamp);
+	audit_get_stamp(ab->ctx, &ab->stamp);
 	/* cancel dummy context to enable supporting records */
 	if (ctx)
 		ctx->dummy = 0;
 	audit_log_format(ab, "audit(%llu.%03lu:%u): ",
-			 (unsigned long long)stamp.ctime.tv_sec,
-			 stamp.ctime.tv_nsec/1000000,
-			 stamp.serial);
+			 (unsigned long long)ab->stamp.ctime.tv_sec,
+			 ab->stamp.ctime.tv_nsec/1000000,
+			 ab->stamp.serial);
 
 	return ab;
 }
@@ -2167,6 +2175,57 @@ void audit_log_key(struct audit_buffer *ab, char *key)
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
 int audit_log_task_context(struct audit_buffer *ab)
 {
 	int error;
@@ -2402,26 +2461,14 @@ int audit_signal_info(int sig, struct task_struct *t)
 }
 
 /**
- * audit_log_end - end one audit record
- * @ab: the audit_buffer
- *
- * We can not do a netlink send inside an irq context because it blocks (last
- * arg, flags, is not set to MSG_DONTWAIT), so the audit buffer is placed on a
- * queue and a kthread is scheduled to remove them from the queue outside the
- * irq context.  May be called in any context.
+ * __audit_log_end - enqueue one audit record
+ * @skb: the buffer to send
  */
-void audit_log_end(struct audit_buffer *ab)
+static void __audit_log_end(struct sk_buff *skb)
 {
-	struct sk_buff *skb;
 	struct nlmsghdr *nlh;
 
-	if (!ab)
-		return;
-
 	if (audit_rate_check()) {
-		skb = ab->skb;
-		ab->skb = NULL;
-
 		/* setup the netlink header, see the comments in
 		 * kauditd_send_multicast_skb() for length quirks */
 		nlh = nlmsg_hdr(skb);
@@ -2432,6 +2479,26 @@ void audit_log_end(struct audit_buffer *ab)
 		wake_up_interruptible(&kauditd_wait);
 	} else
 		audit_log_lost("rate limit exceeded");
+}
+
+/**
+ * audit_log_end - end one audit record
+ * @ab: the audit_buffer
+ *
+ * We can not do a netlink send inside an irq context because it blocks (last
+ * arg, flags, is not set to MSG_DONTWAIT), so the audit buffer is placed on a
+ * queue and a kthread is scheduled to remove them from the queue outside the
+ * irq context.  May be called in any context.
+ */
+void audit_log_end(struct audit_buffer *ab)
+{
+	struct sk_buff *skb;
+
+	if (!ab)
+		return;
+
+	while ((skb = skb_dequeue(&ab->skb_list)))
+		__audit_log_end(skb);
 
 	audit_buffer_free(ab);
 }
-- 
2.36.1

