Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C557A545843
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 01:15:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242203AbiFIXPH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 19:15:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345288AbiFIXPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 19:15:00 -0400
Received: from sonic316-27.consmr.mail.ne1.yahoo.com (sonic316-27.consmr.mail.ne1.yahoo.com [66.163.187.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44D8656C17
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 16:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1654816497; bh=K8jbhpaBxl+Glo0jHhoCvSy9+XQm8vF6MsRuBhYH8I8=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=RUPlnjj1TKxukuvoRxR0p1qHVR9IeY0pS/4NMxN55xORuDW2scxjmrVk/hL4hGpOV+gJOsevuDH331vvTtyoxuOXqWdvTVPzdamyi0mzMx398IuNyJXLO4slnMPjJ04LN45g5ddWtDf+5K3oK097SnklW0doOHdqCimXOnsvpHqmo32DjpLvqDLoilyKBmP7u0hPtruz4poOmqP6r38/J1awn9GZl6H4FL47dWrVkudScqmRMCi9gu++FTRWV4a3iMF4k39AO/0d9J7OjWkqP8s6pl9h3k8zP+6EtJO4ZQlw3VWcfUls4N6IPlxTPW+BUlDZO8dYp4Vuoh/nvRfRpQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1654816497; bh=9waLbm36AOUDHGeBB4AEufrKkVrLifaZO1jYIET+sh7=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=jp08M6LDZCkw3D9akcZTLZ7aTR24sIlLN19laim3CFPK6XWLCiJU6H2aA6cHZsqi/I90i//P7hsTB0kDn7lGCTLa9qTH73U4+PsVBNNM8f3JIPX95Go1SsHBRgcXWZhH9edGTjctvgqZ2nFCxQOCEvPx+Ix46tM7MvtmiNW1NhZL69/WaiLfJfrr3/qw+6bDgCtBvMkstoXDFGr8iJePpVTrXYSNgsvmOsqfpJnAtukbqYIvIv2o7yqkfF4FQnP+KHcEw2zQx2dd4e4aZkuyRuXNk4pNpbtFoSV7492tzAHDKgbQ3u3KGTCvV5xsu+Dq3m8ryBPUwy1EB2mWHfjOPg==
X-YMail-OSG: _EhUFcsVM1lxA_rWwXEHdf_QQ1hUrhNguZt3i4f9jxw8msXUGDSfhmYkcAuI10m
 1hh9K_YyY9ujYzyowx9u3H3a20bh3pasJ46FATJYs082weTwJuuJw4enrf7nJRnQEKIlP045PqoH
 mAr8ZmPatnKA3FSeOoN3U0H9pzxEGrp4LrGFNyZpdeh9nwkD59DnMVgp1QpUOIIaaTd0JB5em7W3
 I7x2_L9H2iU1sxQJydkv6AcEwxYlrLF0JWMvdxvB2RsGIVPQCqHwnmQq5v46IW_WRqxKNy8sders
 XyzVAk15WAFUmJQKUMhPuKFkt7L8A1.dwiK.cTG.DAHGEBTXcgjDv3Mw.M1QP0t51qpdSuzwuhHU
 YAGMkUIBACFrAimL1SRBPX6pj0mg_JUW9cGflPf2wRvKR_VMClvp9GHUiydpY_VeV6o9608BFfSh
 qeUHwrIbPLx2u3nfyVdMaFeteR8rHVZmhEnOALees6PGHpQNIS.e3XhrAmeIwNVDLGwBUtbVnLNM
 nBktX0bJYC08mMR3De4wnjP6jiyS3SBojXSS3bsIXrOtLNW7HmesgnPiSQgczyjEyuBEYAeWVzT2
 xn_LeVf2EXfzxxb6gIm3FlK38fw1vohzJ63939q4yoYPDTEXQgW5EL4G7s9uzTvfKXMNLDrJSIHj
 AMlByp4FXPSHoX5Vx0TAxrYKHEGCs9Q2VQVdSIZFIZZdpqzKVOBfdp2YhahCCRhQFW0VbPy0usnm
 5YHL32jeSjtkEQJ.vxz678IqesTAje0VjEnXCvZQebP02Vu5MGR.LcBMKhiGdrUF9gwhoqtEGc_v
 bviI4iL4zMNSazuEqwq67Lq4QLKwcscichFc0WhgGvpdGujGqL1urnnxoWRxLTAGOdW48MJy_.vx
 DITwEdNM7c0CgTjlN8vgeVIRoX4IcWeKBSfrLFiTE9PrLvzCvZMm5.2T65F9MOlyXqEr.W3HEInr
 fiXLGT5InGiRX3wDrO7XFonaPLAYV6Z5UAP3nyJscLqcLukBM0Qdlpp_DP9DZKWlAHX.d5cCdebv
 NMpM_A2f26Qxb2cn5fqJw82LrfX6igUn9XSgK25v7MBVHqoX4Y0DcMc5HaeeSwLNQbjw1hVhgrus
 bYI.ax0_6cl9J0SB.Cm5OmEou6RaXzR8Mslx5qRi6X1evlW1doflYLm1u3CdbZIjlOoU0s2bsx2G
 i8XhbCnyyRJsnkYuk07EWzrToLL74lof0WbtS.AuKuYK.Dc_tWyv.YVEiiE0oGaV6gOSShCLa6q2
 G8btF7oeCb5oiwmQwPf2PeiRxl2z0F84rG0dAzev2R0iWIkRzYKCJ82QTYMclO4k9iPfSqnxpi6.
 yzPSzTwWVVP.L95Bnf_JahdPyolbgwEC_EXSwnvOu3DwX6NeLXXPSSbEVxTW_KSXBlSLq434nfm8
 bLamO6wLZYWSRrtrQvBDuH1e5NlZMcedhI38fF.WjTiFjZjvVc5jFSYq6ngGBxxu9DWfx6d4TMli
 n6vZTyu3CY.4I63rpAKrTzLpeIivZTLIT09mupzNQpsp3KJWNjJgTU1dmwTrScRpX5I.rFrAPW1s
 TnYTBaKxk7hlAlGrlpPPjqTQv1DPVvbmDM0JmIxuJdVd2.2t_i.oxQz3YjIakLgdvOujiep8V9Xo
 ODiZLGG5Iw8tL_p5NLleEH9rm94mUhXiimE0QgMmYTuM0k_6mSWQgDRvM4gzoLaljB8aXJnKm4VC
 tlOysgcU656pWd0NjAp8uygb9o6YYIFyijgw3gCJVI4esoqwALqaZCow5f9ZIR468zZPOhMphdMw
 _ulugHJJeTLorVyc13SWGuPtRTv58m17Agg7jLY3F97fnGJmk2BrynE47IGXLtcOgG9m_Gz4Qr6O
 1eJaJY1X3H8eY7sikPrulBFDGgotGT1OBmVLAzWNzlVM8tjpI_ZU0Iu5Uob.MhWlxZu9C_VeZSJq
 WAfHaKcowjvlMY7clvSQoOtCO6y_gxz1qBrlFN9hM75gcOfyUdxEetWA38kto4MW30ciwDXFL0Dr
 DYwl.71Un4zt_kMMyk7hoZUQeDJl19RaHFD3VbPp7TpnTGalwtkucd931X23JeXTrDVS59.7zMtK
 S50fAOWdEasQO5aEhnG9nH4jd6CKQwN1jj_HTRQm7X1XCgos2kIFr2BY7zeto6hZx69.GJ2Tkw3L
 ZTDMBtRbCrqDCxzyDjjwSFFAJEdevNYjrN6ZkIvDwowxOLwn3b_vjROA0J7RHmCLPZLxTlNTgjyk
 QBVk6BLSF5Y_Rv0EGQ2mI5Ran3L91DJBXeW573ga2KPznjqRwQTlKGNGA3.rXc0OuoiD5ALh.TmV
 JYGVL
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.ne1.yahoo.com with HTTP; Thu, 9 Jun 2022 23:14:57 +0000
Received: by hermes--canary-production-gq1-54945cc758-dgl4g (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 8f2f82ea5c9f338d52d2410bae995cf8;
          Thu, 09 Jun 2022 23:14:55 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH v36 26/33] Audit: Allow multiple records in an audit_buffer
Date:   Thu,  9 Jun 2022 16:01:39 -0700
Message-Id: <20220609230146.319210-27-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220609230146.319210-1-casey@schaufler-ca.com>
References: <20220609230146.319210-1-casey@schaufler-ca.com>
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
 kernel/audit.c | 113 +++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 90 insertions(+), 23 deletions(-)

diff --git a/kernel/audit.c b/kernel/audit.c
index 6b6c089512f7..987740374dfa 100644
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
2.35.1

