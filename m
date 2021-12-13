Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8313C47394E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 01:07:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235853AbhLNAHN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 19:07:13 -0500
Received: from sonic301-36.consmr.mail.ne1.yahoo.com ([66.163.184.205]:38109
        "EHLO sonic301-36.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232153AbhLNAHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 19:07:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1639440431; bh=TxNpdlzUmw1+Q621GRMs5woVbaxw2QJk07agF6+Fd/I=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=g4Xx/cteLAbB9FJjnzgl4iWxM+11/nPK+EePDXARALvzZObCbXBvHqRkk3W9HTQKbw9+KAZSCetVw3aXZ/rkZcueUEHnhbTsxAXn0Q+jLqhNeXaOdSGavpvlZTQNqf8UBdkBV2p2ZaximGi4sxPtcCgTwNYNVmJD8k60enb3Dv1bddLFi+RclXeIreGNwXQkSi3pi083e6uMn2bsWiWKaFxBo+2468z8h0CCcFKzxysXvyjNK/tfP2FyKDQOfhwLZ7IYs20bFfn+FAgkUAHa9nOclVaSSKUHuKWGoBT+WUZL10Yl/c7kWbdrl7d0CWNNpIfO2JpxVPL1GM4JomlVoQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1639440431; bh=6kZqOyyifQKvDyAEplPy1+5QW2lJbvzcBKRE8bZSph0=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=SY8lzhaaKWAMJx9LajcmdmUhAbS2pPXJyvujUDRSgHLIDacF3fmsCqCfI7fOBR9nBNZspXhMZ3PiA7zXRHm6pfMXqGoz6EbQtZiKUUm1pRYLIS8bKo/9OTNgnWKp+nBDIffsa3UWhEGWTCEDdhc94cA0iHN6/ss9i345RjrYG3V7HtU76mVlnraaYemxz5w4T3sPh1y8lQLqUQ5OV3wxydHsni19NJey/UcAe/ZWHJMM29x9AwjSTGNz8AP9+cOWxH85RXG24pCCNbtalaO0fWDFJY7ktpfSk1hKo1fR+IPrJcDXY9ksejdvlaU2x1bjwYv/r97LHOqnH5fxITJXsA==
X-YMail-OSG: UM9eCKwVM1nophkTjnoLZQG7D6JWCNzW36cx5knz1vQ5aVbMnRJ2oDbWGr3qV4Z
 qV3o6zBjHs7fQ2m4_2wBh_ZaIseJTc352UPUx6UHG9zrRkV.l7bmh0a2hBxn1JgroGouQZu9btUz
 Rx2bvvMoJWeh0UJs226U4V5TagbcwZoUkJffZAQbjqK2_ZFWuLdjcW6RyPHWIk5.VfDClaw6_vBw
 MKoQzg2sMILygh2o8aYBUOFWc032TYxYfFVlSjODuf5N5Sv1u.OOQYi8FyTxkTL1boxjzBEAMEzp
 DUdLp3Ib35Q506tWNjKwNfHHTDKiMy5w5bdHd0K_l9_Q6ogQlW37NWxr6ZdEq2.ETmncZt6ySE_j
 hEaZDHVKtxLkaiLDtYseyTHRwgt25o1lrkYDrPKgwmqpi4va339.OkK_7zfAFxVkVRKiFp011Q9o
 IwQeMq2_X9_v0f6ZpUlzFwF0wVOQaTbGGhbNz1bDiF6r6NA13Unln9sKPn9NVWs54cBWe94fSkX8
 Qz6_wfu775V4oPKSKvlfU8JNoEESOtTQScGzLR9Km4vLB2DpELPtziRbQ5as8x.iUemzX4sHLlSb
 Kzb0z3HHam6WNloWKrSBtBkJOabQt4pswI.FL.6vSHjInclQamYwLgLblfRUJ_e6RWJvldjISEb5
 HkZwEk5a61XIFeUbMtezk7WWQJ1AVQToZZYMk2zaCyacxoUM19q6ysW1xfBDf3Za1KQOjCGFv9Yh
 RRMtHpj4UYqX59Nz7Mdja.hPPP0K5lZn7JA_WzuEaCL5T7yvuyI7hKGes3bjfEsMPItIURRV_6Vo
 tHBHYf_NdNfs6WYmtMLqbXK2Vx7b9fvrfaTzTpiqT79G8CnWr50ButEBrpSPa8nEENBie2Wq1yEt
 0NKZfSCb7t6pyb0zze1u.OH0JTgZPlZwcfOtrC8l7OSqcpok42DWflTmsT8TY9a1RgHQIIrRUXnj
 6C_weIYeCLenURBguZ6wChssNcz9lQEQk7pl.OR1gwJY1S3YYOMFQquscsFGKx_OUqsLuYREnIvQ
 rvxFpiL92MeoqC3JmT4j3e0iyEWdP2e1v6_cVbk827_MxQn9rRZxW97TXaFRqqjiee3cDOXF_AZ9
 9DtLYQRgx7Agl4Qr38gY7jPw2xs03zb44XWWpqa6L9ZWGpY4ITBVFEZXmhaxEcqyoDm8SgMwv8Mw
 coCfrHZMyKo5raExpeIA1sbU_wyEMLso_Apzmm6gVcNXYbutXkkADLQk0bAIosZx_pBIO4X3M9wE
 0NNRVxB4NkXAq_9nhHdFcd6oi.kTcaHO2x7ikLHnInyBatQCl.9CZr5Hq_h07v3pYV.08DxVdCKW
 M4DAdazOsTU_ReNv3vUycvqF4VP7hr_ePHLE1.DO_NVgae5rH0XdUGxJKg7hspj85ty3oMvdkOZE
 gZkT3QVyIxu7EdRbwuojKip.aKKJ86r8ac76GIfRTfzLbRiv2zNgb7uOn6YJKSCH7kvqRsV.tiEv
 KVY0QsaeE_vcHLQtADOM7hiO49rDqMkHbBi50CTVxmPqjtGaCg6HFebqYVWZ.83oChLss1LcdHv1
 gVKAmnmTB65jEJuAB77O67DWx2TmtpTqOKs6dsqvSVKVcRclEVAYVnonKVQKNAMziDHJ6uyUA5C4
 LDmPumZUgUJyctMc_3jcLAdwXL22feSKlacsqWXO1899ciu6qlP3X2uZjyGaJZG9giCMZJbIcbpY
 25sKlLnWAcXP7xZFWspUl2i5Vm1nfdDK7DkUk4iw7fet806z0EukZZ.LlmQQZt1DKtJ_l505rhj9
 4jvIvplWD9q_GDdKubQepiJ_7FsSKCNttLHOjcVBoQEEK9QS4h9gAxAQj9i5CrGlJbRTutdOhGti
 MF8Q8byPyAu2xglkheQHW9Gsd234oCqfhIBOOhp_C_pb6qBPB.qs0ThIGdA5krY84Qbm1K3jUPej
 FAamD.8IYIbI9Bz_uqEHvSBuC9.ncd_QV_iTjf_FwoclYPxPEJGCMXhauXdnCV9C40D8ytBnsaRP
 6JB2zFiTQ9xS0ANNymyGz11Om_EqhCflSFixm5Hi0zJJqJehK0I3jAXPVSm0RumogYDSCGe_x6oR
 WnyCBizQNUH9CFl38m2aqSJwEFZZroIHbUoIN9Wqy_64003RzpXDwQGZ.6GLhlQeK22HFsBlvF0P
 855oLFmoI.MtqodGtWumvEr4hMR2OUmUGMYPtP5PVg2dRr1iJp8UwG7Mo2n_ttvp4hs7q9D59ivE
 0S3vAj7tdWbj06p2hMtUadZA8eeap9GNzRD65Gfg85cwzDmSoYN6qt0WhSCbPwyT08UdjCaBl2iv
 D3YqAyd0c0Y5T44tSSVfeDw--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ne1.yahoo.com with HTTP; Tue, 14 Dec 2021 00:07:11 +0000
Received: by kubenode530.mail-prod1.omega.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 7e9ba4d68a399c1dc68810fb1b73116f;
          Tue, 14 Dec 2021 00:07:08 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org
Subject: [PATCH v31 24/28] Audit: Add framework for auxiliary records
Date:   Mon, 13 Dec 2021 15:40:30 -0800
Message-Id: <20211213234034.111891-25-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211213234034.111891-1-casey@schaufler-ca.com>
References: <20211213234034.111891-1-casey@schaufler-ca.com>
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
index 069cd4c81a61..fc3662ff126e 100644
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
@@ -1753,6 +1763,7 @@ static struct audit_buffer *audit_buffer_alloc(struct audit_context *ctx,
 
 	ab->ctx = ctx;
 	ab->gfp_mask = gfp_mask;
+	INIT_LIST_HEAD(&ab->aux_records);
 
 	return ab;
 
@@ -1813,7 +1824,6 @@ struct audit_buffer *audit_log_start(struct audit_context *ctx, gfp_t gfp_mask,
 				     int type)
 {
 	struct audit_buffer *ab;
-	struct audit_stamp stamp;
 
 	if (audit_initialized != AUDIT_INITIALIZED)
 		return NULL;
@@ -1866,14 +1876,14 @@ struct audit_buffer *audit_log_start(struct audit_context *ctx, gfp_t gfp_mask,
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
@@ -2363,7 +2373,7 @@ int audit_signal_info(int sig, struct task_struct *t)
 }
 
 /**
- * audit_log_end - end one audit record
+ * __audit_log_end - end one audit record
  * @ab: the audit_buffer
  *
  * We can not do a netlink send inside an irq context because it blocks (last
@@ -2371,7 +2381,7 @@ int audit_signal_info(int sig, struct task_struct *t)
  * queue and a kthread is scheduled to remove them from the queue outside the
  * irq context.  May be called in any context.
  */
-void audit_log_end(struct audit_buffer *ab)
+void __audit_log_end(struct audit_buffer *ab)
 {
 	struct sk_buff *skb;
 	struct nlmsghdr *nlh;
@@ -2393,6 +2403,60 @@ void audit_log_end(struct audit_buffer *ab)
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

