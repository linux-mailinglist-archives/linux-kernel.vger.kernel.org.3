Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24B1F4F89E4
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 00:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231687AbiDGVex (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 17:34:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231610AbiDGVek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 17:34:40 -0400
Received: from sonic310-30.consmr.mail.ne1.yahoo.com (sonic310-30.consmr.mail.ne1.yahoo.com [66.163.186.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F15136E4C5
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 14:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1649367154; bh=4/A9RMlo2VDUS+eJ3c9f9QVdqHvAgQb0ICSOChfHCEA=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=Ryn8OaAKc10C1bsMQSYLoZj9HdSKxoThkl1wq0R8liO9n42Ea3/t+el342QAjKnVIkOrsod0zqYvD/n6XbgqGuRapoYj4MNYp0p+Heuj+BatkHM/HfbEcHxthtgzwS0w1ReZqxnjzjIuZDnUGuRUiwXmESsZYgH+2Gwb5dH1U84DIr10irbZNip5C0KTJm80KoKTvbiZXcOAbiAcJGG0ryR/g5VSRZpc0uT7L2IUnKwBNXKtLX7QLQmmL4jr5O+MhzJAvi6ea6hZowRqZhYA9kCGZmlWInhlHKW2zRCoHnCjTkVNn6cSa5oN9Npq0ZXVB2QdTJROXFIP3xIsM/CR9Q==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1649367154; bh=TeBf3nA4zzz7/MT6VzgAZ5JxMa8Xw9dWH1edEmqrXlP=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=pwrnLS8XONKJyYMCbYpn6NJx1lG3oKnZTuR0qEBQk9IYnUwMeJhQvPuTkzt0h+nUGvh2wPts+MhfUkUsJ//xm3e/d/uwafwfGBmaBXBIOPYkjXUfF1Pupqr+Q4bhktD8RAv2s4vr0k6KW8HivqaTPfLLlMIIeZgoCXhMYbdQF1+b7CTnMwRF6LtegWGaPoc6EeFtPs3Fg+hA2GDOv+g6FB525qmNRWRQQ73dzQexu2DWMhU+JH1f1P2JbG/jnFQ9OfLQKVo3xWgTZdEm64ek/XubTZvb499sgJJMujXwxKQWT6gr+W6W+AJz0iiJLjMqWngHI3kfG3xbcdNYQbDM3w==
X-YMail-OSG: y9XejpMVM1lC7m5GbrJLOOS1fdf_EsZIhL2eiTn341ryonSB3xQxAZ1sQcgIxVH
 9Zj0C0Ap3Fa6l2v2g8PR7mZPwlvheWrN87xHeUbZfwgucEu8NXIF9jQRwyGDZi9lkAQomC_1EFbo
 .B4jFEvMG8Lo7jTmPH0Y3q0KobKPLWRNRAPSpa2PkfZoBskmnCjoUi.SrSwiFj102wN_gk72t1kD
 wxc_h_.muuUH19SCMBtTUZ6S45k5EGlkbwf5Hb_sIH0sAzRYtJYQMM5LuVrMGyXy3xTtpyh8lB5A
 .enQrMHZbym16vpHQjkDiZQNSsYd3BGCkf02ArxlksS52L4CWiHr8MG8EU.Q.ixeNnQIYVx8DNBx
 uwtvqkwCr3RiRShZ0vW_2uemp.QS0gr4Y4sq3J6wWO0_sv7dX2qXInQ_s_GgpXEQR_KFmxP4VHQP
 itKq.2QNiB7hLOBnMTeOWI8I_pU8_taUk4yhqLdY15mKYZB3p2.MY2QJFh6edHnOAEpBuJi22wA6
 n0k0wdYh5W_xbQwRZg6VF.CjCSgFjLD0BxLbJxcIoVfMINJzV3OiReMw.B8JNUkI5SqlUQ03QsXA
 rsrooxMddVkppfDvIac6WShvl2n3KWaZoAWjKGdc5oljQnTX7YKZqS3X0uoni1HvIranodGWdRCb
 nfpPEiGMcKzi5UL6UHkQU8FZ7E0egpptJ7.Qbtr7hkNcm3wp_5OujG8RqA9.dvrAahyuio71U4.H
 MFPXETc2VwBT54qafYkqvqmPyOPPvlNBsaUYNcpDaRrC9L0bu5ZI2_PnbqQI34jfw4mCZQnGOeDf
 zxNh2HGg8n.yBgKTtYI9U6Ld8cf6sp_9PbVFqRqUhe2zoma.OcmGrGU5gN7wwxJijAykS0c3bP94
 U5SleaOSYuWHhoIqDI5_bKHd0nvqT6cyrTlysaSpbFE.CoJ8mMxj2pb6Y9SRlGP_ePrVZQf4fk4B
 pWb1MIS77Fuj8BuIYVIHerzk1haqGiRymQnz2Q7SNXVIlQrBUuvr8rAdYhSAHQn.zKDljtMiT2gV
 7GcB8Po1Te7aCarKzJx40uVZbED1P_s52CXxkBqy8QuFChISozkPdZQidrrsfmsaM1Si.BeMGHLx
 OmAe1efkNvrtBUCPSQHF6.6Edz.cuyD0VBxovmuWTnuVHlGpTJvtQt_QBwuLluiCUUf_fR0q9mqx
 WwV9Oc7dquT_YOv1sIQ3xC0uMXwvE5ijSL8nOvNvplBGCq4Bboa5fg_s2y3ezj4Wxj_IWLMzS2_U
 lCGFwDnQls0NhyAGLj.T9T79O5DEt6yCxf.x.s0kbwSO5k_7moQRVW4c1sFRVsE4Nlc1OwQeq7h.
 hUrVtzdko0fpNZDiMJ_vTHD.c24qe1C.8PooIxLfsvIel3uIbLJSdaIdIfWbyG7at.quykwlEyFu
 Mamk4IQTw93DnRAhH0llJt7sniFT8.sANEeYFNPfMmkYX3adKyT4rjQjRV1ByW4us8hcqH_1ijNG
 pwYe9gld9dbfAPvDEJX4u65_22Q99sdqsZ7K63.g7LjsofKKyYna2LkVxZDsbXiR8pGqAwrC5liZ
 EyaKD7SyoEQta7g2ZdJikQJGcuqq6uRcoB3AvIB2tWwsRMJN_URTWOG0Sg73OL6ruR6z6K6TxOln
 pDi84ovX5i3f.CFTE76xsJWAY.TONwEVNBUsOxMd9M_1dWhahnSIvJQme2PehrIfEXQNEaiajjs9
 GSc81oIanKLBYIsx609tbO.Sn.Z5oMceQvKlOvpJXCclsXe7bRkvf2EeBbyG57BmYRwjqvJNtWI.
 JkmfZxubBW8MSHq9XPDI1hjStURoGZl4K.bZKmCEDRDmQie42bMTuFysQN1Y_t87DUa7M12NieE.
 0vsTiJXvP5HZ.meuI_saDScIHPr9HWTDuGitQsGgfESHGEiT_82AiE7aoHYaHTIld8X5PN5VDk94
 EqaBkDLCCbl1wH0HqNb395wLa5QH1MGGsTvZZchv98nLDNWnrteIzH1g0TIIhsyK0_YZpRfpmaTF
 FB9m6vtv3djhc9qIiWb9rE1KzMsH9ojhLjCv5FDd_n8lcDWhGubWeVsnfOiXbADF2O10ZcJ9cx8W
 B1Yo2QdH1.6mPMprKAL4873YI9gqLzo81odRf3Lw8Vd2l1DTVwadl_tg2AyPMUTjAWuiXlezDsDr
 w_RZI0ZNKZmtJ_sWQga_WXp8lnzg3j_sQgzvPric7ryMy3KExbNIJViYv.mhHZ.v.a_iVd8Ehwm9
 ZZRNb71HyWt76q1Srfa.JMGl7xtPf4nVexfVu8NIv4PM7oO1pk1oPOouuI70j3X2qhmqgobXWh82
 R0wgbedOtaTKBBmsnQxoVbe.Ize7V_q0-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ne1.yahoo.com with HTTP; Thu, 7 Apr 2022 21:32:34 +0000
Received: by kubenode527.mail-prod1.omega.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 1c3e27710c5567bf7ba0bbb257134c66;
          Thu, 07 Apr 2022 21:32:32 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH v34 20/29] binder: Pass LSM identifier for confirmation
Date:   Thu,  7 Apr 2022 14:22:21 -0700
Message-Id: <20220407212230.12893-21-casey@schaufler-ca.com>
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

Send an identifier for the security module interface_lsm
along with the security context. This allows the receiver
to verify that the receiver and the sender agree on which
security module's context is being used. If they don't
agree the message is rejected.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 drivers/android/binder.c          | 21 +++++++++++++++++++++
 drivers/android/binder_internal.h |  1 +
 2 files changed, 22 insertions(+)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index b0b0c132a247..259f5e38e6ba 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -3024,6 +3024,7 @@ static void binder_transaction(struct binder_proc *proc,
 				    ALIGN(extra_buffers_size, sizeof(void *)) -
 				    ALIGN(lsmctx.len, sizeof(u64));
 
+		t->security_interface = lsm_task_ilsm(current);
 		t->security_ctx = (uintptr_t)t->buffer->user_data + buf_offset;
 		err = binder_alloc_copy_to_buffer(&target_proc->alloc,
 						  t->buffer, buf_offset,
@@ -4453,6 +4454,26 @@ static int binder_thread_read(struct binder_proc *proc,
 
 		tr.secctx = t->security_ctx;
 		if (t->security_ctx) {
+			int to_ilsm = lsm_task_ilsm(current);
+			int from_ilsm = t->security_interface;
+
+			if (to_ilsm == LSMBLOB_INVALID)
+				to_ilsm = 0;
+			if (from_ilsm == LSMBLOB_INVALID)
+				from_ilsm = 0;
+			/*
+			 * The sender provided a security context from
+			 * a different security module than the one this
+			 * process wants to report if these don't match.
+			 */
+			if (from_ilsm != to_ilsm) {
+				if (t_from)
+					binder_thread_dec_tmpref(t_from);
+
+				binder_cleanup_transaction(t, "security context mismatch",
+							   BR_FAILED_REPLY);
+				return -EINVAL;
+			}
 			cmd = BR_TRANSACTION_SEC_CTX;
 			trsize = sizeof(tr);
 		}
diff --git a/drivers/android/binder_internal.h b/drivers/android/binder_internal.h
index d6b6b8cb7346..e3a0718ce17c 100644
--- a/drivers/android/binder_internal.h
+++ b/drivers/android/binder_internal.h
@@ -545,6 +545,7 @@ struct binder_transaction {
 	long    saved_priority;
 	kuid_t  sender_euid;
 	struct list_head fd_fixups;
+	int	security_interface;
 	binder_uintptr_t security_ctx;
 	/**
 	 * @lock:  protects @from, @to_proc, and @to_thread
-- 
2.35.1

