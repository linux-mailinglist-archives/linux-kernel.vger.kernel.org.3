Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC06650310E
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 01:09:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355559AbiDOVd6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 17:33:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354902AbiDOVdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 17:33:50 -0400
Received: from sonic313-15.consmr.mail.ne1.yahoo.com (sonic313-15.consmr.mail.ne1.yahoo.com [66.163.185.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D47CD4443
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 14:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1650058279; bh=ClsMUKhtMLE7a7NDrpNFEcSlIfUCv643dLWMaDabIbg=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=OjwDI2OXEPzF9tG61K078Ewwds4hlf9ZiK7c39di4t+hCPSvrF5nnN+qdCjPdtghCXfIKibk3sc1lw1hXyzYcmt+8wNd7Oyr4yT3o9FUpYKiFXqrixqsbh72tDzohoGIDwchB+TBTD55KOvEu4x4hpNa+c6E8xRKwdcXEW8QuRtgb8TnUWCC9e8q7D8s1IW68IfKN4KbL0Zldqyah98bZxRBwbqSD5YYQHcKlbhcB2WURU00pxRzn5Vc7CVBwYS8rWicPKnBFf7WatlUqLXqpNRzzj/urHJioo36v0mH/ebjbOowvcqe0/H8CSbT8RQkQfz83gZgWAWQTVgcgja1jA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1650058279; bh=8MbwMCWJoRKLEMaEANvHci2yEv/iZsN6ZKDmNxGMrWJ=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=mee0X2zT7lnjKhtkQsctvDazbut/KxvKfHf13DP+trFKcYI/aoFCgM/nIoBK5XWoNz88BC4OGjN7D3BlHN4RNk1PfqNGkqElMAsI43vDHv94x3QHj9JUq5W5JBkjZyuEdWupZW/HaVIB4MO/wAeUVVdIdZtmhNwRqZzstLxO64Nuj/HsNj7gQLAs1iGRXweM6oqlCy7owSqy709pM2tD0KyRM48BN7EFefJww/axngDNxbo0aiF6LYZEiUE+mg2JI9vFFJXiZg+bDgqGcm6DtTdFpWvFIzK+cScstXC1bXuqXjiYGeX97bsgl4mG7WXwXShxyStKWWlt/+yO0ir52A==
X-YMail-OSG: 2rOmjeUVM1mLjdFs_O0B4AHE.a7VvGDxeK8YtXg9ZcHkv7KpA1NxuXNs0Tk60aB
 wenQ7BBUpNiIyIAr3lTXgXQLMTE8qsh3EZ7RClhShFJacV6aA7BshFs6GXkpH9IKytGw_aTORPy0
 MGPrL.j_y23RtnHwx4U9kWo6cyDij6UrKvjwLT9MP1TGCrkc.m7wRe3UFSX_2BKxBwd7mdenWeAQ
 8Dche6Vqfi4Gt7MTa473e077PSgYW9rdCRzqCJ4d_AUYOaco6i31nJbP1PEdpy1MNkHK8BrMFB6e
 0W1yrhClz62kM.xUOONP24sJpE7z.D4w9yyu4Frsa9zcdoWC3z72.ibP09UgAeBu8BCbAlahfwiF
 ljbUAYwuzI6dJXCgtlMvwoeDbkhKBI6YXqE0GPQEFCQiXbkU9ZyooKsmFR8JCFmZN1O9lkG52gAI
 kTKmUA7I6l2ObHl3VNiEx3K6gMR1wXFLKQl3tProgC8VTD6MAw5IscyQ7JaUkbyt7nj3nasSPQEJ
 YVG6eKWGJnhBOK5wCuTEYYYfsFdi8HECkqU8XEtCszqZsAcpcTiea.hqzDlneUdAitNX7KYk35AB
 sbOw0Ie4ExhFjj3sZoyOr73vgq4ZojjnFH..J7H600iycgOML3Frx4L837hizq4JtkZjZZbYugkn
 xTdsZhQXbISbQW0uUJFEBo31tP3Ch.sUrnwm.SnyerbxaiJerghYCHjbQ0.oKl42DJ1wI_zfEoh2
 FfF8KsgBBLHMBqUJtXmLCEp4834ha4XtHM520X.iyQTYD8eRmWNh51ftB.NDfEt4hohEBzIz80NJ
 L44B5nfG5yLa0NkYpYCNTy08vG_qBm5I1Tv5S_n0HwvMyH_gfhaRXC_Xxs3VNk5f9rxK3icezEyB
 vY2YFUq7OfyokoRvDG1zXuMvpam2sZUYmtKI4gSrtDO9n2aVqB_j.ASXBWkuAmLZ9kFQgzTmDO46
 DRY6Edj4BiC6rGPj2fTQ3mDNYOPsEIM.YAaN0VMeoXe39pzNXLTiyZxqqoXSUBHsQurqcGyuEU7z
 RY0df29ajM0jFvtv0K6xBjRyf68tuztxaGVBXZJz5lrl6rk5afEU4..Etps13Pq1LUCgzHlLcUDb
 Rv_19FQaACh9reZO5PePYKZaAWw_kTGjDuSbhuRFhNehxFtixm1HZY5_huoWkyLhKrUKwkir1TKA
 gr4imsthjeSqNovPGZ3MJhLQkICv05r6MdBj4ZFKNQ.LzB6csXDJfr4ZywPL5e1dWMzjI2Jl1WLC
 5oFvIabkhv4N1deMorjQG8y6eRp.1zrnwfpexLZr_uBI7amel6aH1eBlLzUU2KjCmZJgaTFLfZy3
 pAY6miJ2S4nfpPBJTG6W8MMertOxrkwNf9MMQS1Xkq39JiJnF0T7ZcwB64eWRaKbHUlcM92S3a.f
 UJis1YuENS2E7CNE0CfuhZT_nSVu1GBoVO2QnvI3nZf1iZq.J.kferteyUaZ2CtefVDhlorrBcC7
 _FZZWoDqDJ0HtgicZrURjXQtVsbUwWlT27JeqH8VfzhkqdY8IYEB9vWO_bne7ECOI7sVv39.yQ.d
 vKNu1n6kpsOBQ5FKkbsAjDRtKh9a6C2R1KxwFMKrDZNrzggD9eSFUpAvndfcOBTrq1SYzAOB4s6A
 Eehq1phJZtvQufQT.td7675XoeEYZXyewMyAXKOTeuhMlNsur.KPu8yNFfaTUFdqRPRxTm786H40
 opqV1xxRLbu3Vct7ZeTqY6zDyOMc07UjtMDS641q9Gzn.ECd8oAg0NVOVRGC1p1Zx9McYuCFHk1v
 1vlmYSvg.STIf9QNHNA4dWU.HHvayFT6vBzX4IyOm4_cMVOKhs4ScCxngJne6OZRs3b5AZxDqeKN
 BRZ8mNxdoTXRmhBJDa0CkID3kplRhz.YQpQNKwpjiuGi6h6InEziWAQsRQXdV8hxqVkFa9Z75E1f
 livTURitVXxmreqF4FUPvEpLztKRlWvWn4kUPB7sbJaVs7yCr1JGEfd_CClbYlGRvgBojE9g3EY1
 o.ZHr6h13jE3FBeXRieUkScIK6D6ZHjnIP0onXkBfgKWir8oj5DHL6SvHFt5UHqi_arq6FPt9QX3
 pWcg2wPQbkDMQDFE1Mjzdwmi_T8qD0mW1lUUnR7sqz8nQf.yEykAxA90vFzHP0e0uk.VOXospZAW
 zB6aSthaOKR0wwpLs9dEHLeV9AoGeag_d5.FFIAEmTw92hq.p3UZqldCBqNbXspIVdOzyvWR8Bgt
 C8UnoGqDb.7EueaeAuzVVpjUEbZvpWGB49eeV43y3wxDOGFXBU1N6CkIuotPio_Ut1nB42S1A1Lo
 2mJ8-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Fri, 15 Apr 2022 21:31:19 +0000
Received: by hermes--canary-production-bf1-5f49dbcd6-hf9hx (VZM Hermes SMTP Server) with ESMTPA ID 13670bbd638f1f6033ad5ba33b62894a;
          Fri, 15 Apr 2022 21:31:18 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH v34 25/29] Audit: Allow multiple records in an audit_buffer
Date:   Fri, 15 Apr 2022 14:17:57 -0700
Message-Id: <20220415211801.12667-26-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220415211801.12667-1-casey@schaufler-ca.com>
References: <20220415211801.12667-1-casey@schaufler-ca.com>
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

