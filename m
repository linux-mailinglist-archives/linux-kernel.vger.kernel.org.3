Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40FF94A7C9D
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 01:16:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348433AbiBCAQb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 19:16:31 -0500
Received: from sonic311-31.consmr.mail.ne1.yahoo.com ([66.163.188.212]:45376
        "EHLO sonic311-31.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1348294AbiBCAQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 19:16:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1643847388; bh=H/2k79voQ0fOdYkvuAiOfOHnDBkNBUmiw2X8r7f2tmM=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=BuASOe5Q6xNYNiBo0rlTsSrNMP1P3XnLAKuM/y3yQhGchdwdP9XjTJuQ29EegOFaYxIx731gf1fWswflSskhQy7uFMz3EyZjtQ6/O5bX7Ura2dUvAOvFhlHZC5uaaa6cxun9Nsi8QUcWNNggI93tBpcL1IAMlCa3v4hfgpiY346K6qVdoSIxZkZUFCnjMrNcDF6hDCsKrby3+iSWZRADZl8V6fBdlKbhHy2f+EvAt0A1Aixh9zUZwr+VHPyX5YDnHPc16iSMgGlmonmNijLbQzEboXIDMTMtBNM8XIaBcMCMX7f4QOHzjmSrurp84p1zcslQtNgVGoFkve6pk/Iwzg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1643847388; bh=5MY5MQXDiueBgfxdftDD0r6AjIp6gx/YwREeTEjUXvW=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=ceQ879kMHEVSsl/0yMgrXl8ol50lw+A6epsB5OCb/TmayP9Yc954vEtHTJOg/tWIW7g/0cISjeeDkM+pnJbJK2/4+0hnYiSOT8y7aPbzVmz6/38k7F+nQ58RvOW8+mbWpAXkUZNwU1SdvJFmZvwKVa/Uv4rc6Cm5rAGpe0zUsH4apv6+gCWGVKJc7AvbwCqXNqzNSJDhL9UZENUcC06rJjHFfXDUwkxe7y6EGyVMOJ9YUDHhXyXUuwviYJsDq2/G2HtBE8gWXu2jeSCwV7RyNteiP4eEt1yhtfW8Xh/KcXhUT2sNUmw43DY9uV2XwpGyZTsHzzWTk0kq6H0BO0I+og==
X-YMail-OSG: QgsbztQVM1n.Fc3mTz0sVyfwDtfXwt4j3MFFo9rYQ.ndv3YPEKybEOZUUd6uKmb
 vLi55oijFtupnHasS0y53SmwuBwtLu4FHrOvWDnIb8QQHebVEGMlOcQ3rMfRxHx1XuDOVbiXJdLV
 3wfDrBj3nWjpp.Fy_QqSipehYPW0iFb_8SXZXZtV341nZeDHtUOYexdQHTKh97RJuN3JDTLaIV4W
 S53kp9QRhyMZbk990rxuP2ZDfvdtgHhlky5v5491n9Dv4MYCRMp1DGun123EbUhY4XWp6zkrmPca
 NURZqYq_WHrFT1ilmePECA6g3Mkf3etmnmgER7Fre9enAIE..bvLpmheTVqICzybOaAo9zbKynEj
 dClimue5Sd9YZk5I2uvPrkeY3SrN2lxNdYJ5pBE3QRVfPxdnES3c4TjOdtatUAKpFU__4G38dNNi
 yHj0ndi1eZDDTAUuu3pttcibDCCkd3GhCeFOhzM0QzqcBzEF0.5XjVZHSArzcemmbWzJjuJpKqFI
 pRxjXzc3EF6BugF91JlxeswQfY1LV.nDMQaDeudZbcGahszsBOQ8L82ufLR4cePYxHyqjTqufsRS
 EBPlqfEJiQaFftuC1Tx1qeksvzFMBB6au5Bb2kym1aI6DjLtAxoXaP7SLF2vRx3JUpF7Pmq.i8lU
 9pRJYHG_O3EgBCbrIaAjXzCCz9LWgfJCHcT0gpudZSRWdeyZZ0DkdmVMF0dQLMwTmDuMlFBvtxZ4
 pcsAWmdu_mpOkwnQI0EHaGO69H_oTFkY4S_ZVo4Mu0giamic5vYa_4ICmMjOgqVItoLdlC4eezJZ
 czGCkYnJACcA1MT9vP0aRMPu8MP.EcO8vIpQ.5TrUNw33.sWOdOzvyKExTt1hSW.xu0TdimdFRZy
 V_678Sec3PSffDqnfOTM31WulKSsJNV_wsCPPjPyF19jzTPee1wiOSHjMfawK99C3A7Adi_L.ThF
 Y4vguL0yppjkJcwseJwCCuSVZefu9jOtkP9j9qkzHZmWbxEDfe8VFTJakZWcIgkATquAymyPe9MS
 lt20KQsQQNcG3feLneO2Zv0Sv0Y3oQIQT4i4BPRrozGWJUIb8gg3PXuJ96XgAxdVA7ZkqfAfR.qR
 bIHtD5u0LbPFeOZyRkqykWfC8UaHR4GhQgLej3xdidDOEPUU16dNtFaMoEW_6hLfULWwPgWFplhB
 WP6n5VEDN2nE0aq5Y534Zei..tKuC85CkOJtlq.83N0R9_2ODR7cxfgn51NU1_rKmKWbO917oMcd
 7Xik1J80yN9w1JH9jGG3KNr3VfW0ST9mNCK55qXAhh3q9SmRH_rzhz5FzkL7UKa4qsWM78sHEfBI
 sIbLp7o4g4RLvrYGA_sDrBBNlv8lEyAsV_WcPQduJjeTA8nw1a_XEniXp3QKLGbxhQ3qY9y3q_je
 UxMqpNzRS5l9K5l3_nR1bNSAJpOrBiMnTBiqnoqJ3MIUEaE5CuDlNq8lyrL7Wvz3g4clCXwLNt4C
 kV1volZlsXsLw4pHQDRrNsAhggMeDPaYWZISe4bS6XxazGE0ZtPR5Z7TsggSi1bkQ03Yg7YWu09u
 Gy4XQ6c_p4UabSKp4kNj2j0Hplt1jc8dACXyUXoDdRiBzS9p.T.0KmokaUULxWa2eUepIWKfJ3Jf
 eqvJLTPlHqstbmsF2Tq5J2h0J3I.gEl9lSb07D2zb95_naoYKgXGVGK9EipHuJpTZEoYCc4phH1P
 0UHcezRcDg2IId4ICN0n3dOKIrkeSCOiT2BEvG4ltuohHFy9LdqYHH2sQRvAUmYKv_gj3aW.MmQl
 Gh.5IITJD3ZlcMby.hwBsUsz8Ql79dVFCGe9j32rNY0XgrR8my_.Zm08My8EX_pfcpwLLVxbc8SB
 SHVQ28YIL2oY5XLkV5fwdhHTKhPPW_M3FtU9ooIj23JfIwGBTS5C._ESS0DyeyiXdGZhKXgzGZuk
 P7ShRdbOioe8vQCK0FPu1VzxQta4xp_.a1wOwvVWJ3ixpuM1rsEHdSMqcATpxExJci7nA2Zuv_3C
 HPO8l3.lEGfFbaBP9kOX.7M3tr414dQGgpK205_KIKBy0JV6uOwpQNS._UVB84SARmMh3rfV6L_Z
 _r.9meDu4TJW0.C7bx199bkCZhUkF1njV1XAxwDLPDOo97pAhMwKhzPuAgTOJhNzQTxFI8HK21AN
 Crm1Mo8bwAOPmpfAqFGqGQFHS57416PEqfmhzS6rSsX5UYt4QswB0fGyWtHgNpgv1WqhAYGh0s.M
 wd4V8ySCdsPyPsrUiKHpXWgFQlx.EG5AGxCTV3EOxRBU8EzXbVYI-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Thu, 3 Feb 2022 00:16:28 +0000
Received: by kubenode516.mail-prod1.omega.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 84a273bae704d785981c3c0fa8e65cd8;
          Thu, 03 Feb 2022 00:16:24 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org
Subject: [PATCH v32 20/28] binder: Pass LSM identifier for confirmation
Date:   Wed,  2 Feb 2022 15:53:15 -0800
Message-Id: <20220202235323.23929-21-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220202235323.23929-1-casey@schaufler-ca.com>
References: <20220202235323.23929-1-casey@schaufler-ca.com>
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

