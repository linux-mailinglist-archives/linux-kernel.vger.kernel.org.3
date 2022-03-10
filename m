Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A8DB4D563E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 01:01:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345114AbiCKAAp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 19:00:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345060AbiCKAAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 19:00:40 -0500
Received: from sonic308-16.consmr.mail.ne1.yahoo.com (sonic308-16.consmr.mail.ne1.yahoo.com [66.163.187.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B899DBD10
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 15:59:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1646956778; bh=VbhwXI7Kk2NDgj+KoKdyrDp0/Yhrsf03FmAkgkRnJE8=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=YZG1B99igcOdLxPI3c71s+QZDNob1IJn/21iHxOdKksGWW3ok9Cw2i9FHYfh76lUBmxDf7KfPVg108vdcuUrPfd7zHFcwsoDyR8GJg7hXlHtmhNy8Z8KajX6hWKHhbKgN/HE4dGAfOEM+6ui/tvlJocCtGhV9UYZ7EAjU5PeisKAcFuH8V6gFPPRdVqd+acdh+D8bQAGY+uIyLg1qeRLFHxL3Ebb3J14X/Jdbk3vZtG1d7z8KmsxL/vdXxleycKLmafR/Q+RXXoGioWVaktGpPcoLWim9e2yHY1CQhGy4N8rMwI8HH2LLNZOWpKg+58fb3DDCH/3OWYgNcj0sYtKsA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1646956778; bh=tsVCtN8ka58ecqVBljT1qnDLqTs7l8o9jNh2W/Jq4Yf=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=hss26eVc1lBC5ldeQNugl9Gzja7yLtMva/UsMXi3Me2lexIEVjR5Dfh8v7sqSeQrsyPiWRnqKYDBvhF4Pn3boL990EjkaZi2rmna6GPKYHPINMasa2mHQHs2RyiKShTqrJucN4BgkJ6i2SiQkJJ98282WZU4UvEYZWjNBt8QrSSqcGPtVt6Xg8b8MoBchn9oOx+G2BRnPOmj6iP1RqliTH6eqh5x+pYI/i1dsgfc9dPGpDUNVqA3E2Nx5YYMW8vyglI84Q/H2wZ+52a83go639NKkJ1vh4F7W/o8PHnk3uj8lG5ohB93h5Tnc5IoF2jqd3AhByhOPkor/VonQ4I10w==
X-YMail-OSG: sCQRGiQVM1mnCamP6LSrgVW9s6fGbpeMQi_XgO7aREOJ8cIgQxSecE2yArPXAZM
 9Ko2h1XkkewUdaI0scvCrp8oiqQdt1ej9YNZM17_jNfJw0a1ah_8qBymrjBHj5uIhrXbqbKtt8Fc
 wKsvn0gBJdogIgDAU.GL_d4ohEyqZSqYiEvnHbc2Cguv0b6QYWjhaPTZgdOGKs2C7RLXbrBfHaVK
 YHUvw_MIqezorPV9M4f6S6dL9UQuTEbcGgHg2BHjM.8D8XcLcEQI3xaVfEu4U7mhpMd5Cw9G_jXA
 6PYT9uUngiNlE35awAOxJrgt5dosMG52s.mjW5iV5xBTjd2QA.x.qhzIMaq9kNt04kSWqaHI0Gn.
 Qq2rdziG_26Ye2KBNfLXCJQWZUsg_VpKC21_680tUGbEZmw5yvcD2j16p.hu9PyP2YiVBoSFe1NZ
 aTF686nG7b8pIMNkxfCxz5A2JfBQI.Mi8RrLqNSyFHPP6ATXbG.MLzHDedX6xiZI9DviKYhBjgNl
 yZUom6VDuTXp9uxlVLtvRXmSkW_lgpYdHvhIw6qawmf3PbnLlonvMj7YAlUGI_N2tvOOEORnvYkT
 30njnZhaBMvjD7m9NxKRLL9bIEALWBUr5VLQrXnyAC6Ypu8hngM9BG_MBAvYTayU0yToJSUtC1lG
 Xvrq7tmnkcnexekLDctuJwVORzZVKn.h0Vr.kTWJZ_c3IC7tPvwEpFTZU9vqvbI7S7pSbibfGBw7
 Gsmp_eQ8AKLm1.xW5YBFB.ehWRy7UpFMe7qvd8cnKCYd7z6Zx.Mwr4WHreM44KSZe48aMQa2MoqP
 stuRET6hBLt2xoMK8gNfcf02AuWLdfmpEi4CJiUTBrNj4gUjOMDJcOoaY66FbUQ.Jmp_9DJmNcoX
 _9SnFkirOnPBI_bmM1SFG.Dv.VYFENEzBLeGT0lIyc5vR5Ds99bMRa3MNkUnCejbMM071kGrowm_
 OQ..tCqfLnlgIiTLqwDWtONi6CCCAcQKSLRrNXAGAtNWb27sBog0Q6wP4y_rx_bDbrDpJkZfFGKM
 FeSKjoy1HElkAiGDCsl3yIA.0Y40NmDIOf.mBzpoGq97EnnmCmCEdnHEYQxUsQH7UUsW8fUaYGNm
 1R9hnxwgTeuRSSyUM7KPI2vzhfOXcS_0FwfQB5Xh2xeeTXgn5iT86iQQLMRw49omrDh2Okrc_ddz
 t7n9jOL8u2.nkJ_yQq_fTH8As3QNNickoG3_xgJVNWHLMM4rt0KKCbGd2587MtNFrZC7UzgT9LsA
 bKAMGkgLhaUSLiFtrcU3QLVCk07uPqg1ARfloDDRAZYSxo8LB8cGq1I_N1cQCBtAi0vUnbChfFkB
 wfOzRrLHo3i8F9zzhKgfIIUsSzmtbzCyW31q4GIlM1qrhnpUhPZr1eQWExzp81MpJZsH8QxtP.No
 YUDGTGPhQocjZH7.9FZzzR7eg.XkGPUs7v4U8Uyq4zaEEQLugE6dRtm.1tB_p5977ISqJrMP371E
 ABqfTnGR0PKNsrsO4IhOXacV0QdFUA8v7YZGXBVtFqcRPLpFQRM9Ikjl3luFBoRHVxZwurpLC8GR
 8NQoVJOnwmzAcezzFwlib2s5h9qoQqevyEaU9nUDVH7Xb39yJ4zWVep9SRADqFcMf_EYHRI0z.IJ
 BQhwwVWJu8Stz5V73nN2lwttYZU51ZmSSHOSm1BV5pFdiSXGbRxUlsXH_ZZ3dJvzPzI7bMxihCMv
 3C0mMVXbWJ4HxNI_Eu8.C6eOjUCyQ_XtWl1f0hrNtF_hhe72klJ2xxmyDa8iw5IOagyIKJFB3luw
 YGFr5bQFci7_pQoNUJZcM6HIyzjLsWEQcmQoLF1Z31ecIFhO2SEU_iCPMvmKdy2n1DX3Nht0bgku
 ikITOrmXgqXjIxIPxjSPCywF6DhSzRmJxtFcjateC2BwxXRrO19jH.rOpDY03y0q._oJznvTL9vc
 JvpMXD1ns0pe.ezCZ2886GwUGIE5tjphGgiVSBzyCS03eE0qXcdZm2Wz3WMV2_mmka7D5JnPGoCV
 9SJMfC1G611UtPPCOjeQkDua.kYC0P1Jny6BSBu2IgZJe8mWrrE4GFrKCGT_.e00JFt_f_t_ptFT
 5C9UHwwsA1ocrxvFP1KvWwsgK1_r6bgzXdTwMoZ5g8vk.2Nku.nmaKW7556NNyJfya8kzMWZEb5u
 PdwQxjUJ77TOqeFFSbfgcDmjsWIVeQqbqvHeHab2hVEevdDyxVO5LIHJ7ky4wZEkoSjWfcFv7Bz3
 SPwDCOEN0vgy49J1NQTzG7ggH4PdVqLKdadkLwqcR7AbTgE8p
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ne1.yahoo.com with HTTP; Thu, 10 Mar 2022 23:59:38 +0000
Received: by kubenode510.mail-prod1.omega.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 33032615d5bc216242260d2cf82dc739;
          Thu, 10 Mar 2022 23:59:33 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH v33 25/29] Audit: Allow multiple records in an audit_buffer
Date:   Thu, 10 Mar 2022 15:46:28 -0800
Message-Id: <20220310234632.16194-26-casey@schaufler-ca.com>
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
 kernel/audit.c | 53 +++++++++++++++++++++++++++++++++-----------------
 1 file changed, 35 insertions(+), 18 deletions(-)

diff --git a/kernel/audit.c b/kernel/audit.c
index f012c3786264..4713e66a12af 100644
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
 
@@ -1744,7 +1746,6 @@ static void audit_buffer_free(struct audit_buffer *ab)
 	if (!ab)
 		return;
 
-	kfree_skb(ab->skb);
 	kmem_cache_free(audit_buffer_cache, ab);
 }
 
@@ -1760,11 +1761,15 @@ static struct audit_buffer *audit_buffer_alloc(struct audit_context *ctx,
 	ab->skb = nlmsg_new(AUDIT_BUFSIZ, gfp_mask);
 	if (!ab->skb)
 		goto err;
-	if (!nlmsg_put(ab->skb, 0, 0, type, 0, 0))
+	if (!nlmsg_put(ab->skb, 0, 0, type, 0, 0)) {
+		kfree_skb(ab->skb);
 		goto err;
+	}
 
 	ab->ctx = ctx;
 	ab->gfp_mask = gfp_mask;
+	skb_queue_head_init(&ab->skb_list);
+	skb_queue_tail(&ab->skb_list, ab->skb);
 
 	return ab;
 
@@ -1825,7 +1830,6 @@ struct audit_buffer *audit_log_start(struct audit_context *ctx, gfp_t gfp_mask,
 				     int type)
 {
 	struct audit_buffer *ab;
-	struct audit_stamp stamp;
 
 	if (audit_initialized != AUDIT_INITIALIZED)
 		return NULL;
@@ -1880,14 +1884,14 @@ struct audit_buffer *audit_log_start(struct audit_context *ctx, gfp_t gfp_mask,
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
@@ -2378,26 +2382,19 @@ int audit_signal_info(int sig, struct task_struct *t)
 }
 
 /**
- * audit_log_end - end one audit record
- * @ab: the audit_buffer
+ * __audit_log_end - end one audit record
+ * @skb: the buffer to send
  *
  * We can not do a netlink send inside an irq context because it blocks (last
  * arg, flags, is not set to MSG_DONTWAIT), so the audit buffer is placed on a
  * queue and a kthread is scheduled to remove them from the queue outside the
  * irq context.  May be called in any context.
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
@@ -2408,6 +2405,26 @@ void audit_log_end(struct audit_buffer *ab)
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
2.31.1

