Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA084A7CB3
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 01:20:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348459AbiBCAUq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 19:20:46 -0500
Received: from sonic312-31.consmr.mail.ne1.yahoo.com ([66.163.191.212]:37735
        "EHLO sonic312-31.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242223AbiBCAUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 19:20:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1643847645; bh=42GUyQ/jIyvK1CqeDiPNIBC+BT6wOWf+jsO2OQBpwJE=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=T7xS2/kNTtvN0iCPvfrOTU2cAp0OC1Iz5Os6ft+nFIUPh8Vv2Sj9/7Ypms9ALCklJ9TombijNxNzsYOXNStBIKm4qSHcPAsbk2UdFEvKA7XIh7wMsjwsnmfSBkLme1KLk7OqINGDyqrlAJLp+/9vp+GNZj8OSx1bEWswGg7zRffgVddgfGfyvudnhpQujcLkEKrfZqXF9pXcxFAccF0HTDh/b+2QTMGSdEMHqwhR1+/QrCtWnfQtIeIXh554g9V/48WAk2P4DIUvEIZbYv5L40fsJATja36TbwjX+1i/vTXhX+veHIn8XjBtUbjfRXG4CZ2VyN8MPncKBAyLtgrWvw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1643847645; bh=E/1Dj+zx1FlCiUkMYriQiKadvBaRUqheX5/adQlHFw4=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=f7VatvA9ZILpb7CBbGwYUstRSZcIVa8mW+FL/cydHH0Pu1/DDludJdUeud59EFwYmoNT0tRoHMcUHWkal5MhUyyx8tdJqXlN5GKycQYJ+I5kCSdQ8K1JYy2dJXXceqtSKAubliR22DjFs0JMEehw/M9giaIHsVDUC9DkYIve99mI4A2fGz+FANLdivIT/3bnt3GRdQFTF6AoEfZtPeQeMHgp1qZ+yt16M5heTuD44u1yLc4LHZd3ZckNoQIdEsjq9sqdoWrqI7gHTQxNxNIymmF3YC1VTrAf0zAVRom4oKQVElE0AYTM1MRWmNLiqU3gz7KYFM7lmvojTsVrAS9Xjw==
X-YMail-OSG: CegtVpEVM1nV20gXkBQ8hb.QWjtrCl_fxm5VHFSGJqnEkStDnzmvJbX0rfTErKG
 9ApolmaNLkkIPhAQljHUvn1AgaZDZbGySFiCDW.s6s2AUhdGi88bGCqZ22EkOSw6F2pyWVVbDOWG
 _Xz50AHi2KzViARWRQdwQF8LjsdGAKQ5SBzH0fjQJf.3oymTVjL.7JbQnP4yVReuK6ruGqq0KfRk
 KO_fNFGlBJ5xProw4obq0vG8M8.KmWuy8OAK8RJswqZ2ehaB0y7.PtEFfbKpL0ZKlZYuvFws_ycp
 Zh4DXw2gkH1qFGDmfqaWKDc3Awg7SE9jERWTs7nMO33tZ9cEV03s3dwp2vKMysLRJCA14jkQn9UM
 Mc7nTlT0XBRGIOkMFMSELC0_aOHMJSrVwJ2Ogbv3HoI83.6Slcfm8hXr7ZBMxYzHqaz8ShR4KzOk
 kjWuXbDzjnq.opN5BoDfd.1KMBgYydzfr3PNLz.b5LRrdktfXgzB4pzAHp164g0.GGBTYLPNDGqh
 k9_MthghLVrf9Mx6Mxqc2CP5viqH_7cbrXv8lRxl5dn6yYFOIsHxmpOB_3a6O5lXg8vJnMjIXV__
 VK.LCzMIIXomuh94MPWm0g7yxxezUsyMte4Bx_BeHkPejxmZGfZtkbtY5gRO5ERUrAjfhedRHnWP
 AekYZSYxTXUhFbp4HkCXVIxeA.n7Yysddf6kzIkAaXHk4sOhZurSNhescsqF0bq8rl154dDt3DKy
 ec6aGH9uMuZ8nWmcCv7MYbyunQXbZP9vp1L7Uf6tqdpvFU3kJCRHr3_bK.STV2Yzi7b6vSWb5qJC
 FgHndIH71YjkVH3Rgl2gir0KERIN4VXYoBjWWeKLwgb1RZi5nD3SCU2DHMBXXTJPUI6Xn5ilDPgO
 pwHXiO0eflKwuvhmi2wtXmM0266wVdANwyAS2F2XyFGF7vrMDb306IGwSTgySmQP0AMp852PwaMh
 k83gT3PdKncCErc3FqoElsSm2I3APsL7UWJZ4XaXCrsLBqO9lHOtC5iQgWosPORc4eKLae8iOYyQ
 wqyfS1.db19MBdTiCeyC.4fBSHswTRXaGo5YqQYBBb5wpk2URfeNPvpwW9fdTMhNSTolc6SSMvHe
 A_js3smx0q0RhHoyvhglyLMI9VK78Sx8WrjU3O4_JehBU1pOv875bBjQUw2ZnJ6m5LkAJLWJmZnb
 baYG7HUcZucBc6w0jGNqq4oTm5aBAtXU_gAcsCrgk6FDGihC1JkpcS33g.jeKq53_fIcK.4tY86l
 k8kcx2Wg6Uz4C35obK7F.urjO2_GJeIdH3Q0TVZsHQdfzs9LqnN9jlFA4520z2doPrtfUf46TtGb
 goZnrg9UdJARLAksWMAlmHnZPe2er6QtdMOuQNsA_Srl38nOYLB04NAv0KcTm9uC6yU5JSvB2.gt
 7QqAEZLcZs5hWTFzyw3FzRRLmS._unKU78dA40c2WMQwFwDwOGGEQQ.SL4_McZPotJNY8un1y.LY
 3if5.1fdCMMq5HfyB3qyIqbIbrIpUit9aKAwYZMB_fGUYGjruv3qG5wnofUyf4ngKJ88pxycKrRM
 QpTyCeA_t5Uk4HhCcHxkrSLK1zxU1.B5dl7M_TPp9pd6cwRwkfWzvojjiINMVQPGD2nADFDq2JYQ
 AcI5xwOW1IW_v.nlloPQkZn6sfKBcY0QXbnS0xg0wVvhQbhx5sMwJcycA10SSrkwGkSpvwYGbh7Z
 6SlzI9CHHAZ4xXLvTFTxdf5JrYz9zF24l.O7R_qbbwYfLDA81y3iIusv29XTle33KVAfcjEHcpWU
 W07axfzEsxYiZhXtsscvfjfRnfFS3QMjT2EWwzMa_oao9tOO4q6WZ7IbZG7IBVd91AkGHMzm39jq
 ZxAADr.UXiNgKifaBanADxQEFepEYEcjC30wcOSitJaXwazRBYFZ9hTJIahoTZE1AodetvkfTNBy
 Qf2k.aLztFjGwOUckJt3T_PMnXvUfCrqdhlceBkxUo4livoc6sKFAthDYIW3XC6LTGFteB1piNXM
 eqNjhT7CewVhgbnHrgb9hbPECio6hAW4Sx_27R0VlmsBD14hkOf_9kIoLfQFFsRKRTaM7PY1Lm7d
 4BQJYo_4GRP4.C4P3Asikkh75h87UE2IoSD4ELSJnLjQBgAa7q8uhOT_lmdGIBC_AfyHyfoTwqbZ
 TBmlIBcyBSEy454yBKyfTXtPDjLO_JNbvZ.TZ2JT.sn1zo_TO8Lc_zRvW9WHerzz1l13VXFfxAUP
 oFcxkXdeWWko3oLsUYTY1NyaGQY1lqMTvtxbuuKHg2mldWOQBHkkMagfjxOgRdZAf8AzoKZa2S7Z
 70gbQa5n0Mu3RwwutcO8ac2n9Hlc-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.ne1.yahoo.com with HTTP; Thu, 3 Feb 2022 00:20:45 +0000
Received: by kubenode526.mail-prod1.omega.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID f690c427fb438f8dad9f2bb13db83d44;
          Thu, 03 Feb 2022 00:20:44 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org
Subject: [PATCH v32 24/28] Audit: Add framework for auxiliary records
Date:   Wed,  2 Feb 2022 15:53:19 -0800
Message-Id: <20220202235323.23929-25-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220202235323.23929-1-casey@schaufler-ca.com>
References: <20220202235323.23929-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a list for auxiliary record data to the audit_buffer structure.
Add the audit_stamp information to the audit_buffer as there's no
guarantee that there will be an audit_context containing the stamp
associated with the event. At audit_log_end() time create auxiliary
records (none are currently defined) as have been added to the list.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 kernel/audit.c | 84 ++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 74 insertions(+), 10 deletions(-)

diff --git a/kernel/audit.c b/kernel/audit.c
index f012c3786264..559fb14e0380 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -191,15 +191,25 @@ static struct audit_ctl_mutex {
  * should be at least that large. */
 #define AUDIT_BUFSIZ 1024
 
+/* The audit_context_entry contains data required to create an
+ * auxiliary record.
+ */
+struct audit_context_entry {
+	struct list_head	list;
+	int			type;	/* Audit record type */
+};
+
 /* The audit_buffer is used when formatting an audit record.  The caller
  * locks briefly to get the record off the freelist or to allocate the
  * buffer, and locks briefly to send the buffer to the netlink layer or
  * to place it on a transmit queue.  Multiple audit_buffers can be in
  * use simultaneously. */
 struct audit_buffer {
-	struct sk_buff       *skb;	/* formatted skb ready to send */
-	struct audit_context *ctx;	/* NULL or associated context */
-	gfp_t		     gfp_mask;
+	struct sk_buff		*skb;	/* formatted skb ready to send */
+	struct audit_context	*ctx;	/* NULL or associated context */
+	struct list_head	aux_records;	/* aux record data */
+	struct audit_stamp	stamp;	/* event stamp */
+	gfp_t			gfp_mask;
 };
 
 struct audit_reply {
@@ -1765,6 +1775,7 @@ static struct audit_buffer *audit_buffer_alloc(struct audit_context *ctx,
 
 	ab->ctx = ctx;
 	ab->gfp_mask = gfp_mask;
+	INIT_LIST_HEAD(&ab->aux_records);
 
 	return ab;
 
@@ -1825,7 +1836,6 @@ struct audit_buffer *audit_log_start(struct audit_context *ctx, gfp_t gfp_mask,
 				     int type)
 {
 	struct audit_buffer *ab;
-	struct audit_stamp stamp;
 
 	if (audit_initialized != AUDIT_INITIALIZED)
 		return NULL;
@@ -1880,14 +1890,14 @@ struct audit_buffer *audit_log_start(struct audit_context *ctx, gfp_t gfp_mask,
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
@@ -2378,7 +2388,7 @@ int audit_signal_info(int sig, struct task_struct *t)
 }
 
 /**
- * audit_log_end - end one audit record
+ * __audit_log_end - end one audit record
  * @ab: the audit_buffer
  *
  * We can not do a netlink send inside an irq context because it blocks (last
@@ -2386,7 +2396,7 @@ int audit_signal_info(int sig, struct task_struct *t)
  * queue and a kthread is scheduled to remove them from the queue outside the
  * irq context.  May be called in any context.
  */
-void audit_log_end(struct audit_buffer *ab)
+void __audit_log_end(struct audit_buffer *ab)
 {
 	struct sk_buff *skb;
 	struct nlmsghdr *nlh;
@@ -2408,6 +2418,60 @@ void audit_log_end(struct audit_buffer *ab)
 		wake_up_interruptible(&kauditd_wait);
 	} else
 		audit_log_lost("rate limit exceeded");
+}
+
+/**
+ * audit_log_end - end one audit record
+ * @ab: the audit_buffer
+ *
+ * Let __audit_log_end() handle the message while the buffer housekeeping
+ * is done here.
+ * If there are other records that have been deferred for the event
+ * create them here.
+ */
+void audit_log_end(struct audit_buffer *ab)
+{
+	struct audit_context_entry *entry;
+	struct audit_context mcontext;
+	struct audit_context *mctx;
+	struct audit_buffer *mab;
+	struct list_head *l;
+	struct list_head *n;
+
+	if (!ab)
+		return;
+
+	__audit_log_end(ab);
+
+	if (list_empty(&ab->aux_records)) {
+		audit_buffer_free(ab);
+		return;
+	}
+
+	if (ab->ctx == NULL) {
+		mcontext.stamp = ab->stamp;
+		mctx = &mcontext;
+	} else
+		mctx = ab->ctx;
+
+	list_for_each_safe(l, n, &ab->aux_records) {
+		entry = list_entry(l, struct audit_context_entry, list);
+		mab = audit_log_start(mctx, ab->gfp_mask, entry->type);
+		if (!mab) {
+			audit_panic("alloc error in audit_log_end");
+			continue;
+		}
+		switch (entry->type) {
+		/* Don't know of any quite yet. */
+		default:
+			audit_panic("Unknown type in audit_log_end");
+			break;
+		}
+		__audit_log_end(mab);
+		audit_buffer_free(mab);
+		list_del(&entry->list);
+		kfree(entry);
+	}
 
 	audit_buffer_free(ab);
 }
-- 
2.31.1

