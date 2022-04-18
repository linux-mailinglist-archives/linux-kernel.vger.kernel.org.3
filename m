Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EA1C505B89
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 17:41:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345403AbiDRPoQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 11:44:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345938AbiDRPnJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 11:43:09 -0400
Received: from sonic317-38.consmr.mail.ne1.yahoo.com (sonic317-38.consmr.mail.ne1.yahoo.com [66.163.184.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBE022DD9
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 08:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1650294577; bh=4/A9RMlo2VDUS+eJ3c9f9QVdqHvAgQb0ICSOChfHCEA=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=A/UEjKhdKa7Fyvn5/Z2KDs//KFmWCJAvubbqPcG+G/zBCHBGhcfJPB3pXknWA3X8vX+QanDZAbX4FWVvgbJwYUkJoTe7009em1mY1omsOcoc1amS4xsap7kfAGP6uSuJ12i1tfD4/YcN4X1pufMB0DL2EX8Ptnue72WAxztyl5fbbmkjMFbCSqWYNzwrTBvOzUspWF5la2Rf/jAE/jpBwYSGEPg4yOPqrUfA0z6TqzEwC23JSMuj7CKN5Z/FgXKIwpkpUiX4VUDu1iN0gHhNARIUlWvuE8CchfBjKdl9usN0K4W0omJhi4gvTTwWYjAG5MsYbNHZ01Itdu7tPMA1rA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1650294577; bh=oJdMXoM1aHAN0JFEx9OPOD3AeUpsAyTED5nLyAsT5Bc=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=n3km329eHxinYLt1EXrIhO93S07FI9Qj8cxR7pQroJKhkgqATU49O+RpWKqJGIwXj5jeISfQMbKF68mMI2fTv3ors3F6z8T88T7gflhgXqQ3cu91uVzErnMuDn7xFuSdk6JXhae9QIqIHvhNdnzIxUMY+0C2QrTpAq4QiYgAJlI4DLOxQpVjI4BLo3qx7cGiJVNUHtO+20GMpOCQV2SpeGdZ/dk1uTi4mVZ6JljZTod9lzwcH8zjgAxsCJM26eqdIJp9ecTTM4d+EQpK2lop4hQIS+KEEJ3JEEcXDVpe9ozmXhCRpCdBa9p212BDaGQ9ljkhq/Y/EsatLreU8v2pKg==
X-YMail-OSG: 0Grc2l4VM1mujQkL6LeEVi8A6k93WrDsKv_0lfuX_SsS._s1hQXUpw0ImYT8Z10
 5UIJYHJCKyMFxbDojRW4PDe2pHcSAvigahxHOZU.ZXnv2AlK9CvEh2zjQYyLXsjWEr4snMj_HBNF
 GEU6g6Vf8ypUWhUWvsqDD1myZcMVHle7WxzV2qAs8oTo7EhwABHx588U_XCac1C.DohbwmQnJcTk
 sRg7qk7p_fEU5pnlEeNI9GhD4b0EYlhfX6CE_W0TxsqxCHw0eH2QceRdRBPdjEbcHTC_SKM_yUxa
 ow6iKw1T8OUAmYmGSRJB37MRlmZliQIaKqh3AJmDLKJ2NIs9m4SMGV8BaGLErbvbc1a7OlA7UwZg
 lT8DmkopHOqWwwjEXGQWarz3i5j4jvcU9Z.STuHQ.Pc_.V3uGBMBsUV1ne1hEaUgV7cyut.cAr1f
 Y5nxujZhJKd50VSa2MEXe2F0uihxFqxqH3vvxE7RTlue6qzPFeGUmSFW_wjcajxMcZGEZ6NcGDN5
 Wdj5Ydv2F0fSpVkphAMkmaXD2SZo6s2eWavGlcV_C5.xY5gCU35mcOX.hFEiIntH2DK_6Kgh2OwH
 At1k9oXbvKgpB7VTgtwaghyqJwldxesgNySlXJ2gYJ_RvusRwh07xOoUiJOT18SBbKMIqT1EVP1P
 wehSaAjsF14jn0tsPF1gZIUHYzs0anF.OTpRMWCXq9QUm81fRTnZKqi8N.I_GDgSjQfAqoaPW1lH
 d8W7giSjOrRLnnDadvIJ3U59LZR2dUgDH1tH5NQZN0PWgHpEjLHIWkRLaKjG4cqJ1_HsSz1ObpG_
 AbgVIYyu4HjMQZNIp_9vwSaUQ0VIrybkuNeTpVOjpRHtDjIFCOUwXIDfZUBZ2UbFQ_jfA4DQ33Bb
 S7UnSZyu6kOyL8mK0KrgtsYnH7_2lnUj76oIODxH3UtP_QcuAfe1mQ4KkXWwYMwozQcVbBVey7BW
 MEMiX.t_N54K31zA3hrcouMxCA3to8404dqEEbnBWH01nW2sHl58nwNy4jyjWYy1gwzw2QSkXDY8
 LQSk5tqDyfIju4UlFb8yvgRLg3ktLlrNGLfx4K0Xho1dSR.vLS8ceHDXSAPCUMWHTQ.OHHDCcauw
 neyVGDr7UQu3d.HUIt53sxUWV5G3tWBdMwEhnDGiCBrUcwcbrK_V7QLCsV4.9xneO2UeIjyPaD2t
 FRLE8cREuBBNxk8RxfBNZpKJSd7ItyfFOYgsc0pqZr0lNCNbfEYhiv1j7HVhuRofmUG6jumB74NF
 oFXYB9iAj.37YSlo.9JjzzG_HozAb_Abc3TMjRDhD0ZkZt05.DnGXmYTgLoJuVJH_BMnaX8o4_So
 WUCIrSRHzo1WpHsOdf8.r.QklafSg4hY3hfrTBKvv5I.oQNvSARTNRTM4C3Vmx1GRbz.7lixuJ5T
 XrTTHOIhC6TZAtGA658rnIap4wlrMBkhinUpXPS3fvHcGlV56b5U5JTq6pJQWLIteFgkDIDXUNNK
 fH3P0cBlMC86GjeGD2grelNYcD9JQN7zyseaG6lRp9FUaev6br5Hvrjnu5Y3wdYcwBzA7NIE3Hgh
 cYXzVK3N19VYjyQnksUaAJqR2nt_8EwEKIVKKuOvIHSaHLbBDFmsMbFz6bN8HzW_HyIkFYkSx69u
 AOvkQCEpN610eQC5pCDrnPNXi96N9zykVXETHDXxy75MyOF8K4L90pwp1tfX35.4k.T2Nba6Nv7m
 hKBqT6O3HNTgbse_wFptoLAXWjerQ8_rybPMlXXSYL8XUfzs5WHYsId1mUrbPFkzHtyQ2CZc0jLo
 f6WjevgSgf4pg6KSfvGl8NtorNOeleV_4l4FBmIbJAFQsXpnIZGEACDVSZk98v4dshU9vS3gywje
 WDlSXd8S7KIuayZrlpI58HYLNMiQ4Jp90dn1tOL61_u3O3qnRoD4WVZQe5Ot70uXC.8zPH9kbJl6
 uzrc4QpenbL.dnU9JE_g5mT.h5OL8sT52x6Ynf9BYUyDq.oamSLubARm1t_E5nHEfcFF_NshF3TZ
 q3uxc4zD1OQlveR9tlzM7d.9pwQwBstSOzN2e1IyH6vqEaGFZKUQPu9gc.e9C16FBFLEJwWsTorZ
 kN4UoiqRF.DWypXsEm5P_utsPIm4AYDg34jXQ48wxaVibfhJlv02oKhvZIkt0DUtZ1uv_9AIUOmG
 DuAKFAhTebecTD3tgy9C0YNZNjrBY3zVLoVycYJ2s6lIIn9R.j17rKjpsULgPvBl5Nd3BHmQt4vc
 6wGE5A4vrc0wN5lGvIpcqahFsucmekmVCcAvD4YZ9aY3EAM0S1.h_wIH5.09m.O5elbW3gZX.5ut
 dFBJFSracrEWpjVHjIGj0xpkA1o4mmVsOMjrjq6LzH07yc.IsMJAHwrNcTQ--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Mon, 18 Apr 2022 15:09:37 +0000
Received: by hermes--canary-production-ne1-c7c4f6977-9gvrn (VZM Hermes SMTP Server) with ESMTPA ID d63a51ac54c25c4b8dfd633eacacc622;
          Mon, 18 Apr 2022 15:09:36 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH v35 20/29] binder: Pass LSM identifier for confirmation
Date:   Mon, 18 Apr 2022 07:59:36 -0700
Message-Id: <20220418145945.38797-21-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220418145945.38797-1-casey@schaufler-ca.com>
References: <20220418145945.38797-1-casey@schaufler-ca.com>
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

