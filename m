Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 521FF4F8903
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 00:14:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231856AbiDGViG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 17:38:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231904AbiDGVhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 17:37:51 -0400
Received: from sonic317-39.consmr.mail.ne1.yahoo.com (sonic317-39.consmr.mail.ne1.yahoo.com [66.163.184.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42F821AE1A0
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 14:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1649367349; bh=ClsMUKhtMLE7a7NDrpNFEcSlIfUCv643dLWMaDabIbg=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=Inq7ND7SogEzRbdyp6Q9PRCqUeVR3P8XskGzycnSZo40vVWlWUX8TXhVJDZ1yP+psLtUr6E8B6a6Y8QuCYJ+RsFTT2pvBD7Pc4K+8cvggCjR5x/lG2UyvaTYNzvnGmRG5WC5H4Okn8lLinbA9ScRUCAma2p7yep0t+L7jmc8xvC9wSxRyikc5L8yXDXfHWt174wzMAPk6Pws/9FxG5DencCRl+be2m0qIl1Yw4kpfyu0LNJ+9+EHh2qZW0zPtAmO/NuKK+6QUu22ITorlbb8CpYtB0smcVdgtv4tUa1pg4UY4yfRhiZgmao8uwbjbfrxbwiPaI3O/W3dShCPE8es3Q==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1649367349; bh=WnvfDboAOdYnEaMBi5CNvx6Gm+QKybQ35BKcENG3L77=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=Cm7NcTMClfNBUcGXue1sKvwNZyBg4L29afE5TeXyggNiNGcJWx3IUau8/Kn5MeSSkp6vQyWvgemzJ295n4g5arjPk6linvWUCwx3ML0f6esWD6v1qv8gkt9KYShnET0Arq9R19NO+KmSazRB6Ij51Q9se7IbVKuve20QpisxXTwgFtpwY+H7yGz2lVuxtQalKBmr4k6QRt0/PbeZcFSOJCdHLhnxqhijMVLPipf3ZY9wJY4StTwXmN3mX+Mmvfv+P2NO/dLVwx2Nnac+o5CucoLhvG3EaiWEPAOWvBrMNumMGitnDicXt+WnRS/Mouvr87ibAL1gQFN92LZZGBVfbQ==
X-YMail-OSG: KzT4Lv8VM1kFAIWoNyCg08ba4BvLo_ECQClTd6x3oxRtnEEAq4ZepcysbUGvRaN
 tFR7KLA0KUuNsUMYeOoyXLB9TzFaWiP54UlDArBVypKWU7nejl2VbINU3sqo.v9ceyr5FTtHPvS3
 RRTpRL4X.2m_lUQmHyD_aiyFmbjJcKwJ.vFZfO.qDbr9RgGPRCSZRPcBLZQfaQ2kCbtroYRYFCVj
 PBHwh9hAK8nB0nzqxNb.btkoln2xpx.y4YhXDoRgJa1A0Nw5h.FJFtLlmZ3yxwAA0xbhFE0NhPFY
 V8GwVtSCy6XcBfdi3KQNCq_Dy61YnU6DngY_vk0cKSev5CMzx1t6_fxi35ucLE6VKY_9bpD9i.NB
 jzOtNdFHg7HkM4C3AfyasUcVdtf3tB6KJ9fZi0R9e4ghxq8n6n2voHseNFR1KIPhkeIWwVOZs0sj
 iliYG0eWpNpLS9lo41FOBZ3.K9RHlt2roL94D6de.t5HhsBqAG7qjs8Jt9iMqva7ua7a3fGMFPR5
 yw5oIupGhovO4vR0SdcYPMwThVQ0t0jmNAsOpF7epp9Iy3YnYLpNEyKuOoHQ9sUXw0P.3SDHI8Ys
 QkTgjB4K8FQez_uNdabKeZcMYOvbw3o7cwdV4SN9rKKspm7.WyqH9SYDJCG9Rq9ueGZAvfLdA6Ck
 zuEaAVTEZKEllNEUsRw._SjtJ6N00d.Hl9H0COAxqV9OL3wQ9244s2ewFWmuCahhNyXon_Ci9g0r
 A_hFj4rfe2Cpoz.ZN5yTSdsFH1mRY0nGh8OJM8lz9fVFNuFXbFfTaT.46yYA9jCjOiBcVYzCnfXJ
 s4Bvm8u.Vwf5DGoyqntDAxjnoYmg8Pmm.cVifUpIQ0vpxXXv25zQq.eS0YGGCZKwQ8A5BWljFKHM
 iEFqtd0OqQIuJtD37Oak7JDbVUdIOZOaQBL0VdP2IZn38m6ccXWFO90SsA1B4Tt2FawnGUUEe0u4
 RoKCG.h0tp36dnqS4WQwQF_NJdnMxHWGSzKSkUg4Y53tgBUX4qdeI6qX1GrXoL4A62g803C3lX9P
 uq9tqCHw_nHHcYa9BCgaCzdCt6MjbToJCEy_6K3qgXxzSlZ1HZhkyUZo88P0qGnmBhMVQTbBlqkc
 eHnxkFTj8l.rDit7a7LvdbpvTOuJZnbu9QYGrqVZTj6SoeB5LWfThHmUefCoy3RjuvRJYgjpl1Dl
 LBZfZuZTWL7Pnzl01uNC7RxZSOWiaUymbLGd7BBRSljChr9.JhAhGGDOENR1pVxJwtFwiUmzrkVB
 f2Lkuv4eSoMvps_lk340N3ITIeJ9IgW.XX0KxUXd2hP6Gnsl70uNwaTEGqoCdxjirfqQTXpSwbfk
 0tTQtwbB4Ku3MP_Mbf42iGnx5TQ_NX3JBaEhCSzHIDi6aXnsG2kHYknA9_eeqQnjK77OGr7ZDlYo
 pp4q1aaaD4juNe9ikgfnI5yyp1cYNV5JCWxWCxSJe6hfHouynnqMKsZlTCXtrgB0RLL63nMALzoC
 JcfeGThn01Xstya7bL7dEcqZomLkfKeQXCuce9NmF6fvk27w.u_TBgM5K_m4CcUy4c_CQ9TTu4xo
 55CpO9S7iQ8GUw.KMi4u4Ccsc_9NrFNgtwCvfhFdkeFOUBTxyqZ6_H9XY04_aPVtqb39hjZiXrBk
 AaZxYi_6y7R4YzEAXSCMqfFXCDkGRqPy2IkMTdFC4Gwi0qQc9X_ZcJs1a8wqAS7tCsyPZsrb.bYM
 xUtO.VK5PoS7gSB_se0VkjEk8xmT7d9VxYwwopr1NMpMb6xbueaNRrJLNijb2HETlCecn8xUl7gu
 rgq._3lyAWiSy7Ieg6tJBnT1UJqOXJPZWTT4qFZ9zCN4n306R2sGAIHL4b.x5h_S8Yp04J4bHB6x
 Ae7BLJVnA55xr9ZvVFAg1QO4molaFz7V.r6zKsTgnwDiiaUYF5a8eCu1v3oEZvnmANOPkus70Bg6
 DVlxIpI2kde56DkCnK.dRiH_VfmmQANe5YT_ZDR2xhNov_b8AZqsmFnBBeFxA1r2fGSM_v1L1FDL
 xnThJ_jwnQEWRFSrnZW.YZiwuE9UcnNNSx.wOlMaUnEDzqqmWX15jJBTLdxkT.PxoKNC6cT68y5T
 M0u5vHotYrA7r0uzINSzl_58UwEqlba3kFePgeKvqfagY.Y1H5GvqgAnZVqEd8XKQ6e1EsFuSU6K
 7wJRbHuy8RYgHvb2HY7YCwYQkwXIySFbZpzu23uDMM6JdbJa3Biy8p8Ae7791Al2h8duOSyx4mcs
 ANSWMXNYUWXxG7uVIMePKCX0bSRaFyoayv34F_ikFc6TZvJtbcWMehgfAL01gi6usS.ebqiVgExr
 c1w8hlrVsZI3mf0WFFQ.24KP62JKb8wILli8-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Thu, 7 Apr 2022 21:35:49 +0000
Received: by hermes--canary-production-bf1-665cdb9985-zm65g (VZM Hermes SMTP Server) with ESMTPA ID fb411508bea18f2038d235ae662d3bf0;
          Thu, 07 Apr 2022 21:35:46 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH v34 25/29] Audit: Allow multiple records in an audit_buffer
Date:   Thu,  7 Apr 2022 14:22:26 -0700
Message-Id: <20220407212230.12893-26-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220407212230.12893-1-casey@schaufler-ca.com>
References: <20220407212230.12893-1-casey@schaufler-ca.com>
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

Replace the single skb pointer in an audit_buffer with
a list of skb pointers. Add the audit_stamp information
to the audit_buffer as there's no guarantee that there
will be an audit_context containing the stamp associated
with the event. At audit_log_end() time create auxiliary
records (none are currently defined) as have been added
to the list.

Suggested-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 kernel/audit.c | 62 +++++++++++++++++++++++++++++++-------------------
 1 file changed, 39 insertions(+), 23 deletions(-)

diff --git a/kernel/audit.c b/kernel/audit.c
index 6b6c089512f7..4d44c05053b0 100644
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
+	while((skb = skb_dequeue(&ab->skb_list)))
+		kfree_skb(skb);
 	kmem_cache_free(audit_buffer_cache, ab);
 }
 
@@ -1784,8 +1789,12 @@ static struct audit_buffer *audit_buffer_alloc(struct audit_context *ctx,
 	ab->skb = nlmsg_new(AUDIT_BUFSIZ, gfp_mask);
 	if (!ab->skb)
 		goto err;
+
+	skb_queue_head_init(&ab->skb_list);
+	skb_queue_tail(&ab->skb_list, ab->skb);
+
 	if (!nlmsg_put(ab->skb, 0, 0, type, 0, 0))
-		goto err;
+		kfree_skb(ab->skb);
 
 	ab->ctx = ctx;
 	ab->gfp_mask = gfp_mask;
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
@@ -2402,26 +2410,14 @@ int audit_signal_info(int sig, struct task_struct *t)
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
@@ -2432,6 +2428,26 @@ void audit_log_end(struct audit_buffer *ab)
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
2.35.1

