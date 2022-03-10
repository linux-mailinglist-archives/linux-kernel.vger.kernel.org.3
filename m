Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBA3C4D561F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 00:56:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345065AbiCJX5f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 18:57:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345043AbiCJX53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 18:57:29 -0500
Received: from sonic304-28.consmr.mail.ne1.yahoo.com (sonic304-28.consmr.mail.ne1.yahoo.com [66.163.191.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26B5919E73D
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 15:56:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1646956585; bh=H/2k79voQ0fOdYkvuAiOfOHnDBkNBUmiw2X8r7f2tmM=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=loQZCca05tIQkjzt70YXDBkJhkPjaGueh/2TWU10Mik1YJYLRPTFpIqaPOBsWWlbNTsmVSLDMNOAAhB4FX0n2Ylx9E51H/pDt0gOmVvlb9OM69LztGG6x7MiAx/zg8zxZpuMjP5Shyxg0KqGYKeRdl4s5PFuOW3zO1SwcCuy/sydjCn+qe3CIIhD5bkioioOtoz1avXLnifJqipUcLCuVtt46Yzm6DbXZuKjsKHT91BrbfljcJO9URINyThaviJ81ee7lsKSZj6ESBH9pFPQxAHA00xr16auY6TOrCAHK2l+nE5/3BsbM+CLIJYWAh5aJjGOZcAPkE4JyZ5rHhGj0g==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1646956585; bh=Hf6lYf5hX9iLiDPKZ8yd6aGPwAzl1BrsRYbF4zZmdaN=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=JIVZH8XE7EyFlw8JYkaB/ZdIL3/URtwgaJgiLgoGOlbRE/mBSev6kLCZ7wyKqpp5FljHjDwYPmzsVtHxaGzsQRhy/LwgXYTmByNB43em0W7tUVApCz7Fbl+PlWCob2sveH0q3WOaKW/t0TfIlJUxStGZWKZ+R3FtwGhNcdqaoFsxaiWCPDnJN711MXoXA2HYX+3ZEwna87hvwUZtmtrbLNQGS/v8CxF5fa2VEbZWMfKIvfMfdf2xCZ9G5ic2H4siIPWxgdJUGEpJ3PQ+tMl6lGRhjYh756AJhHNwdcip7YKecxUzMModn+neHGTbRdUOe8Vwj8faz7Hm+225m+FiQA==
X-YMail-OSG: zOlMbuwVM1l8XSQlN3OQN8O30YzMJmthOinLtLSzFVQ5L7z8UNQYKdzGmUR22y5
 uBeAwINUWGDkjy2ZakTDPVQA7h22wXeXx.9m3risJfVeB56_QnjDCdzMGi5uj_hi7EfwVWHzDT.b
 HmnE1w0Kph0LzrD8TU4zhEMFo4kDNYcjV2AWAJLMYET8UqMevYFA5_LbAsUKUrSWN32oU51ipSqX
 pzjEz.KwhNGz3LQkOOeZUrvpXA7erxkRb0lhqwbDbnYw0pJ6x4Tfdql.f2xg1noBASCchcqMcuP3
 jPWygOLdJ9HXmd1Ky_K7m9g3vsC_zzt13Wcjc_0k2Kd7XDSzryfHXV1irhXa0YLwm2t0ZCjzVLq7
 WrE8CtgqqSNaxfe4NXufTE1Nk4JYvZ4Rro1O0VY7TnqNGB_x6btHzhS2uw8FsqqyezzWiSd4TfFO
 jRrsnPxLcQc9_.twapESs2wOoioZ88EdDCkN3Q0yJDCl1fDWSV5ys9PGZzL55qjbYAgqxl3fHiFG
 jVGfNdchJYPc0dSZDK79oYgoWWaqTqLhwphdFlpkhkJUpM.fy6bolEXFSYwCBJU4uixg1RlAX77j
 gZV_AfEFxlnRniiWYOIwETPOrxv1x3vzeA2B.Mh_m3MLRJDs9kZEZ2JSTsA1G_eeuT9r_NPyZ3PR
 YouNoYfAeCRzsGZRM8H5o7Kf.BZwYK6CEmdaztsefxxHpcpAYv6iHuNuSoEzLqd1DSBLAzxYEa4N
 risgmBOU4MtkfeAGb0LWrzcILaE0knsAzcwH.SmbTByoulWVZLZfgph29quYJLBi5p8LDVNz1OXG
 8QqpioKnB9O88YStE8.ViIrIKEo9EUI19gT39l2mEKL8IeJ6pywOopn0Wrc7ENUMvXrWRfslX6Su
 1z_iNTJOlzorpPZ.npw.7w1LX75G3_.HFrP940t9UBhkc7hqBXJbug6pCI0PqSa7bCIR_ZrSZYxt
 fj1ljK8VwINLmk3t9vJ1p5OeSG507Cn1jyjALAp16vXQju2fI6zB6nSYRr_2E8l.DRx7i8lDC2M8
 .DE4AHhQEBWjfCHSkEiHLjFV76SEleywXvyy2ao_EIO9yj5uip7svBrt3ye1gis7MBYUlt0gaM.7
 Ew6KPFQ1_s_4UPBnxiXWDmKtIhs6eQlLTXcYzmV0DkTYr4xg2CbNOOXCtACI1Rwbl79TccmTEb95
 g5wFka_3bLGLJZA5R.MOX7xmft46TP0W4KEV6Zc8COGWkWMlxn45pVI.r4uZUufgJEgbYphvv8HC
 sUsQWyzV1Afezpwg658nHU.6MSRL_z7HC0O5V8MRZERNByFjSYz6iKU.A7XQOZk7Z7M2NNOwzRuI
 ACkLzuuU4fQ3OpdAcCj2Qhw3P3jNwn46nbDZdURQubLWGYiTiYalRt.9AfOJgZxGOniMQreeUdg4
 tBzKvGyZ6ZbKLHqLYk3uK2oeuUirRDIWkVNG.cr6_cKaAPQS5gw9wTEdruqwMKFbVk9tPzvJQ8OT
 b9JRTUUiICK9vnXmXkS8gZiPJ4AXLssaNaNHKfTeso8ovLAbJA7YOKt3gJserokaNzU4b1qoFkXI
 w_zccRswe7bjGttTe.cs9VMuqOfEKc14ci97qup0v0peAOGM9CC.aL_CEDlqwHDklAuFcMFrkUge
 LM2v61N.yfzpaqA8znQAIWY79r6cadlhyBIcXbGZx5at7bp2h13OEo8vFvnP9hE0mMddI5cZQTBQ
 J2TzqXz0.jrxei65ZeHA0q_4HLEjbtD40.xAtJpg2oBohiCe_ghEON5h90...YmV3BlEiP8Y2gxM
 4Btz07EBVm.Rx33z_NioCHxkIs.CCRdPHPZMA.k9Ry28bHQvTgnVLZBnnXch.AlSb0s967DiQKlX
 zgNLEJKrYVY3AhJ6ajm7tttpbjHd0tx6GxlnTiz6qwEVaLuIYMoqHl0Vh_7YosunFdSzb54yttgx
 V4aWZc.F9_tr7saWDrHMAdB7JHVN90oQv9yq1P7Y7.uJ5WwK3qURabKbvXdvDg6Il0XR9Kdxwuqs
 0MIeFqPhRf4raFYiE4ld3RwELN4GiAHj8xdw_fsX7mp6g3DymRYvfVUq73NJWX90SeZvudAlkOyM
 XWfiGPfhOCaSySifpRuZ5gVcczWj_IVxTaOWVBLjHSWGAy5szSFwOkKK_fCeKKSKF_78Kk5sfPwO
 yvyB3.vmXPi9qaqm36xyITkeCgr2ujJL7l1epTgUnzOqJXL3.76nD5Vy_lWS6i4iGU1qMUCeiDdt
 iNdfdkVLJgwVfcHh_2xK53JnhN0AcoHKeSYUK7SnUFb7KwhSqyZJpLgaR9_LKe9CRtz54hmI6GjB
 yYw8R3FU8VxNVCRuOEkJq9Sw8y4_gkQ--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ne1.yahoo.com with HTTP; Thu, 10 Mar 2022 23:56:25 +0000
Received: by kubenode537.mail-prod1.omega.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 85c60a74110af086a1e93bbc48c45823;
          Thu, 10 Mar 2022 23:56:22 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH v33 20/29] binder: Pass LSM identifier for confirmation
Date:   Thu, 10 Mar 2022 15:46:23 -0800
Message-Id: <20220310234632.16194-21-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220310234632.16194-1-casey@schaufler-ca.com>
References: <20220310234632.16194-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
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
2.31.1

