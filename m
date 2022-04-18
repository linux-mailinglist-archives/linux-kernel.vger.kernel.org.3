Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E35C0505BA9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 17:44:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244580AbiDRPqg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 11:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345456AbiDRPpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 11:45:47 -0400
Received: from sonic317-38.consmr.mail.ne1.yahoo.com (sonic317-38.consmr.mail.ne1.yahoo.com [66.163.184.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B9AE5A0BD
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 08:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1650294772; bh=ClsMUKhtMLE7a7NDrpNFEcSlIfUCv643dLWMaDabIbg=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=X5kw5fclF0fxinjx1XQai4e+a1qJ2Cjl96g0VM9Jeox+WbR5B7COXDnwc14OwXS17h1ASNzcsEmlrkRbv6PwTHIlgbFmuubXOtfe+gzF52sMoRRNIi+J4cOMehaB68UqL+HC+Ykt6JZyRpsZcAgiP7cfTNxxKHDuoV+mqrumy4TLj8c9D/Rq70BKPH+qcEsp/1tuW4uknWZv0fQZBgBBoRGC3HFjhRRTnMj3LvjMkXX2GSqVuxnLheHajfxmGOBTkFxIIvnoVdTsQjcpmsVzvS7Mh2sM4vXA8PVm+cviyDRPeSi90lkuYIgP7DtpDw4aM9P19HjqEwqjKGg2CztdQQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1650294772; bh=/pK/xmZRUjcShdUOKrB8IKcCqk6Fal/YzeqwKrWyrkL=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=kjNKjuDtA7HFYPsMeP2apufQC360b8mrFE0icHJURCu6gtiZuMf+XW28DHAmQjDTcuxX87dOmHe/K2+FPHxRqLPaZPGc6rMB7I1jx+rQ9YgCBmODHDyBDxRutzsicI7WGphnln87F3lnZSIht+M2YTMqSfgnObAvryLE0/IHnu97rwSedjRYnT7xZI3GkLWQQv5XYeqX2Ciup6CZFHRu4C++CSWO1pHPkY+bb6sXhRPfdyqx5b6vDVUqvHqq+nlCi/yRAQ9WwlALOMnU8eSBbd4TRsXemrY6f3xaHNGu2S2nqzMPniGg1Bp0UCTh6wMLuVnFbXh7CHWOHockStkWqg==
X-YMail-OSG: 3uT_ewIVM1nTDx1gnW_LgXd9XAPjFXUoKoEnTEAlcduyf_WthJuSyEHaoEeBk3V
 Ebevb2z.wQtVsIB1Q7SUIPUWFHChTiWytipvSYO8uddvV60ALdPjPNZj8W_XBDIxIZ0COGqGa9dg
 MnG0Vptg9t52VztSMtmv5PmHwvcgMYTKqSivCvKIQUdkdWmq56.LQsyCg9_QwrXZQls4TWCBlipp
 Fml74AR8BDxLP1e_ynsgq7tVpd3.ooC57l18V14lAkKg6xIxyiJSyxkhrdz7TDkw2TngeA8y_ihs
 zOSTNd7AsZ7ul.ADIz2xhoEM0pcuj0DBDj2KSwzXfSqNOtaemJ4nYHHftx5evpmIZ9VO_pNP1NBl
 7Cn3PsdnnUbmfhxTvb6lFppvGr8V8iZKktfoaMSQe6Hl1GWN7evnDd8FQ1nX0m_3LNR71oN3wyLz
 T_OSfkBJYyewebwnNzDPknSpU4QGR1VYM4h4O1QoPLCW5bHTW66lzgw_0cSrRcJRRKy0lzIQwrIy
 jxjqTnLMAAHi_isvKZVIO9JyjYhPb_8pm2apW54mnK_3H4CvcIYis5xxqN_y_Gb2992QogMsL2Hn
 H4gUE.TOTRP_z2bt6cNOtgDiQ086eZKKFYQVoH3hvPpFd80v7T_ubXuavo9S0teblxKOdidCNFAy
 vPk9SWQ_vwtkqIJTjD56GVMmVh_Y56H4.3KHAtWQ9mEq.HDJ_Qt9IQUWHYKLkKEoa8hB92Z0KKzd
 f_Y8iZ9FR00tvYScZ4gnRxueGH.ZJNi_mC1ABjogbje3rABxgiELWi1jDJo7ceEzqCuqBgzJqZss
 zK0A_E52S2LhIm8kiAhWF1qZicBoQo_MFfGOwZVbGnKlB9J.NNuI8_biSB6nUWwCvlfx_.kGmFy.
 lg1OoydIaPjFXY1YkRllH3tWTvQscSRK1KBeOwQuWJhjifpDmO39Wbt.Gk6tK2fcDsH8V4S0Atkd
 .oFwxihHD.3z0S5tExekHt5ea3P6wXhjkraNwHQuoLNzfefyw_UQxiztivp71V4CWiLfh6S4GCFv
 kRbbyc0IhgT.GVvdCEJLvCj6wVmQJsPCfHJ00uW7uKCEpYTv6.r.lPHCZPkUlMbkYcTBB913aYHD
 GsKH0EPa.UdMB6I2ZopZ0yjvOn8Dfg20pFHc0pJ68HYt7tYI4j42PdfZck0CC5sVcg_m5PeNSviW
 lD_Nah5.yoM6dLIA0Z3TxkURnnAlOWt5lQUQZzdBFqUltLuVwzhylEGfQ_rjURbe3t3nw0fRibOU
 kNWZQQj3brBKbj9GeSvnvvl2H24KG890V.jb8QKuIHT82Pft_5FAXza1ZR9F.5QuARBUDcVP3RU6
 dhMn.x67qKNOIq0vtIVIRDdpnb2Zz42_4vj4ZYlnaHO1fsMhfD13VoXfScRizleSZQSs0JtuUyOT
 aFi8iRZvu_YQmMdh5hRG4O41CVm2vERbpQ7orjLuYSBLupJvYtDssB8jm3tVHvBkDgGCC5yZO2R2
 kv3Kbl4NwOJLlkAgx0.DuY5Ng2pT8BuQF08kCHbIpPM9KnLd0_8XiIb_C5z3LCeBJvO3ZUuiLdvo
 xjAyWGhFA18IEPYb0NB8E9vSXnWDeMWabKYpIyAqesjL0yPYCfloLMOtc21vlwGtitE6_ufRbkJi
 MfmqUvWA7RboZgObCYFmCVxc5j9AVrke1k6WSSyzwPDtWwUdxrNDQdXsNub0tBLQiw64oeNoRafk
 0K8pJSe3IJvw7wsGl7aAcYYZaUQYgpAX5L0ao0etRpZQYeeHfZ0AHLlawLhZafpGZopVpHH5IL6R
 8WMD46IfLxgOb9NyV7topZHvnw7YNRK2V2ROWsi4y42t8_YtcD.iB5hTwaweh2O3SCQnL_S602hN
 Xnl8e42clC6uiRil.rNAXW.LBfS.vPMZKFLTF2oaVsJ7pXVzgUjmlWJoh8rZNZ4fQzNcyQ5TAb4W
 Q3tpgVS5F0WDNceQ6YnApnm_LaXIFr9abmQznVaxl.yphjIm0HZGRRjD3ZqdikwmKW34r1MzHSoc
 dpL1sbny0SlLuebC8Cf0TlD1CCFMYeOsXj265ILDDVOodu450HXhBOj9zJaS9lQuzxgmDdHO495Z
 7OH8z29BdADq9H5HdU.oF_cSojE543.HQG1MguT70FpWXxFpiFCMgbPPAapwRWVrnjWMCZxTmIze
 fTmP3Yl9uv1T3em7VYLqniy1xytBDLaN1TjiDkGUHCxqeiwglR8P6mlDUCk72ulfI8cBT4szVTPy
 vaNJ_bOGye3IWrDBnOtQsCSOP5jm1eFpDtLZGo_xg.Mz5Lh22.3igSzdUs8mQGEL2jKKfBTG7IFO
 7WQ--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Mon, 18 Apr 2022 15:12:52 +0000
Received: by hermes--canary-production-ne1-c7c4f6977-qcc8c (VZM Hermes SMTP Server) with ESMTPA ID ee952e2418b7fa05874502fbf35997b4;
          Mon, 18 Apr 2022 15:12:47 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH v35 25/29] Audit: Allow multiple records in an audit_buffer
Date:   Mon, 18 Apr 2022 07:59:41 -0700
Message-Id: <20220418145945.38797-26-casey@schaufler-ca.com>
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

