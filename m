Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 832B3473937
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 01:02:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242043AbhLNACq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 19:02:46 -0500
Received: from sonic306-28.consmr.mail.ne1.yahoo.com ([66.163.189.90]:37293
        "EHLO sonic306-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241190AbhLNACp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 19:02:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1639440165; bh=/pHqOJC+O/1FpZFd856W6ZYsy0o7dIQH5ZBENXEFO9Y=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=VbQYERYs1UsHFgimKOjrEbtpl3TcUwUNwadhUOMU10RBDJuo2nKKjufNXkUySAWYZaA20O95NspsTjDacrI0BTQN9tDhmjfuoT//UCnp0o7OBhGyA6QRYl0z1YBKzETVx/Cu+SD2e/QBTZ8bEYR5AWVrPp2JFV0z8PN4u0QpoaDjaEPZULSyQmmR/VkLbPIMYDNSB/EEAxFaTijBNqIXku3xqHbbKr1X26d0exYMSeFTCV2ljIlr0mQt9pSwndY+oc7wkXixXVcLgEj8HUt6NkpEtlkncbjl7+bz6x3OYB1iyAy5m5sJ7RW44/xxyoV6DIpedUkdnkqDdIp1se3b0g==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1639440165; bh=5zDE+k4poBX2HVvaHxG72W9zxd07J/6Ii8nPTjhustl=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=iTiJjkVTPZGWmWTH6wVmVct8B23EBg+iGEtgFH+AbKzN99zmwACWjf95JmbW26NKSu4tjWLSC+ghN2S5ee4ycEKpZcPhj7Ja1CVEHS8JjFuESQDBhmKCWSbXtxuwNiKEYZ0jSeb71SHyWV9av5+CDpDE6+fIXAR3lDuQRMAfK+aRZDjnBhE9GemTZT2CDYpNKQIk5vN2G8l5PXlIyltrSEftqSQVCC3n24qE6W7ad2GYwnlYmYT5wpwUIojg9865+o46bZS10qtu36pTK4+17p/+/6O+hnNKSa/9hio7Tf5kDagrecqSaSZ7IH4T+RkSP8SXUE/ogck5I8wwjv5aXw==
X-YMail-OSG: D9Y2RM4VM1m8VF6y_GDUYbZ4qrEEKj03EoAjIOqpFT0ue45UfXkuoR825daQEh_
 pshvxavWjx8NY_PA01NPBWCJyRBtVX6QL5mm0gBGttZy830alWuLBH.yIg8bHKaAFIBp7wcAeQxN
 MN0g8tSpJA5eoxQnY1vlD4dI1FT0IsDPEWeV0e3zcD6TqQi3JdY6am0ArJGSlPcG4XzLbizlsE.a
 4ZOzha9826wc_FWKsSKzwdnsvJJRrL1cZgpuyPC1VEpiaacCIuVnbTfP.HAqonVm.fgEEgaThxGv
 Mu_eZWxYA_dA2wS861qwQ7fjkh6V9QZo896f_fXMWBfFMccT.HVyZZXLtHxh36hJZa8viwJjzZo6
 LeiaALdt1oTHaJ9Ez12kxBPP2PpxkwmNud.rXwL6REutPLVms9lOm4Q9R9f5gq31dG88lVaCN_gH
 hKq0YV06N94UkA6o1yOVIxzIL4mDBVdMlnyM7yL5oq0ktvteRv8cTHPUxDioqdkCcZ4Yohp0PWJn
 EsOVQBHwJeKwok98Po8zQdztDd_3TCJ04qD9LiP69bMWBjSvVWPnEtJJc_CjwkCbyNd6l5.GMzV4
 vdQltyfYB_iCOqttYkH33yi1Njy5EvXA9ccAdCoKC9TDkKFQPF11tdmk2wKsKzSHGwN_Jhs164Nf
 b55htQIrwucIPQj0_zd3ImnnFkGZpy6PsN3a9tsgqDBVOEb9rJvu13.pgbZby9AMjRoV9H8CDlRN
 yJzVsefRPxjuVtfMEkkqKfecrj7VKushKCH4APy2wLBXbc4RmOf8A9sY9Q.Nl1EKIWgUbes3_X6a
 fEO3QwLE4XpHwuzdX3o5AEoJdR.H1f1VVVU7AQ64SYdUbS72MmDskHimN4zC.iGY9eZsfXSNO35F
 DKKKVnF0YOquzOYmRi_aNL7HW424Z.hiY7_0OmlI5cxETULzCV7ZxueF9O8_Sho7lb7ldNQ9iuEH
 O1K.N02fMh2R074pJ9Oni5fuZkfyT__j3LkGiY1jMpq2EDvVBvBSenavVcdAyBR4naQoUr_j8.im
 x63DR53sEJfi2YFXkcT0HleQXZ.N0Q3y.Q3U4HgXVMy0ZFYDPt_3drYLZjkFqdRsax47zyvhOTQf
 4XUusUqF0Aj1oZgbs3z3e47mUABqpU8D64EjJMifrhLN4.OF6cqTImFomDWueA3BgW_dqofjGBWJ
 SS9qfZEc6bzGIJtiirJMgtLnxvgKHs2srShWovthYbbW60B48DgzBUXwBstZBIw2gjxmo4GxCvyI
 5erYUWRTiFbg7Mt5hQTSQyscAibaxDB_RZ2JmNz_IwyPZEWrOHWsSQaBkpqPpNfbgNTx2A5PZmF2
 5wUMyTkRXmInKFs_J4hYApyytGmOTn4CVJ0PPVCmBWxtfWr.D.5J0a1pFXTgYq7QqKEs8WsvBybk
 DZ6VDsLJVn4WrfnVnbIceGUvixUn5iqgpMVNURORYjQnfhTs2HXudrpkQiiUGF5YEHhSCrWlQitk
 5MQPQuvcKR2gQ3ghBu_qk2A6GxOch8BHDwbKAlVW5hHlrlNN88xEzN1xYNuThbDnaI0TfX2OMUe.
 kWttQyaf_ESyxtqEFsMhyUkKkgRveCYtZOrMEnuOWRZLdASAsTWTXZavbMIwR_3bK1LBITCsut_S
 VKyEZ7CJoyQpcbYaHQBBrM4LqnbmNHbPfJ7lpj6YIxAv6HQiCVqpCtQItbMwWneMEtX2wgPWLGaA
 CHeYxSJZhpsxDmL5EfxZkzxk6wgjwqo8Ci5TKvgJpIBz0NvxgUkUixVKoxpzS61QT0YtjGzgpW1M
 vf_lvkMzoAhT81F0QVbtK.NlCFTTDhRCrEoNUKM6k15EtbmPdXy4vyuGlCd.wCO_SZzQefmpd35v
 wda9zn2gpZFeu2zvlEwE33SfEVt4Ti88z8nf0j85yEmP7C99b9m6.6sGQbUtCg2OH_XgW4iqN5Wi
 kRWmutHEZtBIH4GFs6kShkdDlYebKWqwhx62zBu5LHWeq1VGjWDPpr42WdJlRkSlmSNnmlHg64E5
 B2OTFJZdwqgP1oXxqgdHCVYlHfoANT6dMhXj8ZVLxUb1Y6AKd27Sod91vYpk617s7YaEH7BzNQD7
 iJav2v5xCgP.s.ILT5uwR3RuKcw6FUVzPZnEkiZI6F4wGQ19g6agMVeEn6xVkeRnOo3djro..fUj
 V034ScwgXqprvZWzPcAneHQIyNCldf1GevE_BpL_8Hnun8K.Ir7S1GRzTUYmb.jFwgxi98cT.hYs
 6j_siaLResNUsyaGKC3HmuCS2lpvfY5bxFMzBmoZSVw--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Tue, 14 Dec 2021 00:02:45 +0000
Received: by kubenode522.mail-prod1.omega.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 3e1325cfd5c69eb7866c2bf85c314813;
          Tue, 14 Dec 2021 00:02:42 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org
Subject: [PATCH v31 20/28] binder: Pass LSM identifier for confirmation
Date:   Mon, 13 Dec 2021 15:40:26 -0800
Message-Id: <20211213234034.111891-21-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211213234034.111891-1-casey@schaufler-ca.com>
References: <20211213234034.111891-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index b9699f7ac603..e15fb8575c81 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -2762,6 +2762,7 @@ static void binder_transaction(struct binder_proc *proc,
 				    ALIGN(extra_buffers_size, sizeof(void *)) -
 				    ALIGN(lsmctx.len, sizeof(u64));
 
+		t->security_interface = lsm_task_ilsm(current);
 		t->security_ctx = (uintptr_t)t->buffer->user_data + buf_offset;
 		err = binder_alloc_copy_to_buffer(&target_proc->alloc,
 						  t->buffer, buf_offset,
@@ -4132,6 +4133,26 @@ static int binder_thread_read(struct binder_proc *proc,
 
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
2.31.1

