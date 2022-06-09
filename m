Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83D9D545839
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 01:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345930AbiFIXOP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 19:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346009AbiFIXNl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 19:13:41 -0400
Received: from sonic304-28.consmr.mail.ne1.yahoo.com (sonic304-28.consmr.mail.ne1.yahoo.com [66.163.191.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF50662A2A
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 16:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1654816400; bh=lFb6izMu4S7T4jlacKPy5JLTz0oyrcHEb/BCqA/yNBc=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=ZRH/BUfdnpP/anfcjtGjOf4iG14nWLl+qdLWVT5en6XWEa5uFo9VljKs1d8ilmKyjMsaYbQdDCUGeaXa+MjHunmnU0Kbc6/hGIzFWvr8yk1Fj2i2xLKGYJhdeefC2FH8u24vD0jBRKxtawHW4Ev3kyvYns9aJ9qOSLCLQd/GsWgufZWcBlZGqWlm9oVUj54dH62wVXSthTVVP0Hq1Yt79FRtYpOK/9l+7thq83T6rWjzTkwdxdhPcbLOz5nBKcHj4L/EsRQyiNt8/x5qI9ETi1oefYAU2Yv0x8SEfA01xIUVLFW+ZvA4aWsglDOgeBitoI87gYJS3hdsxKA19x27QQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1654816400; bh=lEvHMldb+W9PmTRN957mHexexGunXVJAe4MsrCSSt+R=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=Am4VvxXkNwGSiOFDPOL4468pJ5yYU/qlvLNmBJvq487d6etFntB8Y4NY2Rr0GD0trIlaH48Z6A+tt9rW6LgbJ3v1m7S6Qk7HHZEmia6843hOivTz1WGpm16f393JUdTa6zMsYdVeVZUU4iCNxAjiACFYuMGO4SM5eTgQtCws3U18jmlRiVa1s5533Xzyo/ghzR2Ncn8LUtKx6X6EONS7qjaC1/rwC9Rd0yN9VcA3EJSozrX7R/bGfBALyAkWk1tqgAJvNZn3prTe4ApEXB/DWDgQSFWYn+xLWptV5sS2GIitO+pnOGGGIt8UZMyAyMLVG28FU9JGXgxAq57oBXvZ3A==
X-YMail-OSG: eniDTmcVM1myeZhnvC48CMTpgGrDMHUiWujYgiUTrf7Giv_1NZpepqohiirDJuN
 bdWNPPb8ctsR2w5vUK9ngJXY5x1wzvgmiIURyply9mmWiFOfdGClA..L1wAsi21mSLPZN19s3JOK
 HXeTpejPWZtaGLN0nul21u2zeJTHlIsVDHUFrdue_.aO2JBjQX5aVJwVMfp7vpKndbXa6B98WaTa
 nxA_m.7JTPn3eqPlPsDo.DSh66V5NlzXnJ8wjYF1bHqI_4KSRoTCUY8OukNreH5COoFQ5vU2IBuU
 Zy27AA0rYpo6MtI9e5ICIqwe.bU.s21i4b9peBJZn0EeN8.z4tsmbm9ZMFhM7eSwwTaBjre4qhks
 t0vPf13XfeieKkQKcxIcwotHoX9ZcvG4KVJXr6TCqK9jCHUKGPIcaCyfibHY.ne1i6ZE3uBiyG0Y
 50phEgP23iTvMO8ujA_WOvF.sVDq0gyIMSEunZKsk_fH0tlLBxyuxeuIfSUDqNpMz1Riywaf5S2X
 PoP9Va289rBT138hsnJGUpIs0eEI0s5BZ.Q_V5760EIOR0nHTQSBN3O5Hhc6dcWKBKAx5riUkjPd
 i6bhRtL3Zj_tz5qLjz9t_.tHA8124.ZwpR2Nmaq6vz1O1TWdfH_yBzeFWRyKU0L5O6dJdOqNW6E4
 gIcJYF7o.s0sXABC0StWs_sjDBGVHLde8tC4RNipQdOOkBSR1mt4aNZCVpDLAuHJ9Di8jwfCvumT
 xZm8bQbBI.GAyjXqrCgc.YFxFFbJ52IjYtgwI_Bfkpr.I1iwFcZUkKiwsXfxwgkT7mggxlOLnkEh
 t64LJHDhu3y46necRB5AZzGHQBhNDzrDzmaJP27OZXQBz09vIxzW4SJBSzA47RmalMmfgUfmQAxy
 H436GyiuNCQujb_J6j88CVLeUCq2Jqp0htOsD1E_HLcPi758gbcDpihxoyzc_Zd5VITjteUX0vmi
 PQGWvL9m071hitMuJ8R.QpKsSdAYB9M9rTwKkDOXl9Vgqf_QAdxLSPDuNp2EGWgnBKaKh0oKR8tL
 9VPIwBevr2wCqhKm7b9Us7OftZQIFB3Oh6p0958918npu56KRysSCi9R3n5xYnsil6AR.7_DFxA5
 4Kicqbw04pne.C7RXCU6j3FgKnFu6mUNfBIFmTww6BqzcBjARR.eI5NmMpxEajxdNOwDNgCILZb8
 ChYAG3wA8C03CUFPjIfbwgHU6wD79mm47F_WAQ7ET2kaQt2FDqDt5pAm_pJuRVRipj3BeP_KXIxZ
 fwTbuGfkQU1gJMRchcyyvO8OgF61qw0fX4BBd8eSYY1uFsFV5m2Q35TqeITM3IaSf3wWyoTHgxpx
 KftPt3.fgbJfZeGZ.Bu4CpCDjDbQeRf70m2My.WXnd6Vb9bm6.AE5pd4Cb1pUfw0VDHpSFSkXFyD
 _FO1t.8RTHqWc.w.c5dxHkz8P1DvBhxCG.inTUwmXrWzSSoX3er9VJwFqicqhFIAqYNjZxiq2KZq
 T7KHB3w8TX_3FWxPoZ.nv_YlC2nXbZQ4vJ09NOCNxQQBDDFOO3IvS4ImiVBpUatCli9yYYo6BJ5I
 UNFyXYvhmUo7kmhky6dkQUNXaKg8NEjww3D35_.N8WKDybkA7fZPnCMmEJwDAQiP3hEMLjf1yNjM
 dCyL3DbCcbO2hXanAV1Kl2zm.evFWHoS2jlZpOc0.NO.iTq9V8vokxnrlpXLwQ0FnfsXjS6WBA0z
 ogKPmjZ8iYW7F_NoUIC6pjHLKeUSQP_j_10HcSqi7Fi6dT442pR1mO.I1Oi_MN2_mBxv_uS4QvhZ
 hPnW_e2f4_7hKRJP_ZDMUCJwsxpkCkzUFL9HiPK.aLfORzecXIRpcfU3i07WH9c3vC1JNsftDzuq
 FkjeKVGOus1bnsVFFl_SmzCKrJEb9jwbVzru3vvBv15Rz3ypcqsHLMXYtNuTSqOGUwCQ2jxIF2uo
 PLFNfaCr7qdbbwumVDYLHGN6Z0GDePl18c4ycOMpLULMMMGTK7QcoSP1Ep4PDe0IF2YnicjUJbu6
 Dbo5FBlSt_g5UfOMYLSsEiEC3DL3EvcDF1Y8M4i.JPEPMFYf9S0.U4qX0aExT7dmnHGdyXlax3oK
 e8ApT9UasqSmiZFd6adxnxCguHx2aTx8XcTYzbjPrt5oBChFypf3H2UOfaGRSDEmO.SpV1cyuBac
 jgqAtr3Sx8z7OeIrGj5PgagfPo4zmWT5YQeeMUkWnrjoTAqCszV.WaabTAbWJwaRub_U7fJmgd0f
 GU8Pcj74mjUC5dNjyC_gWPW57kcbbE9M6qPZXMiV_O9lFN_fF0t3sVwTnDK_JyA4prFrjCebmaOq
 POZZcpAM3D3WTEHONSk79LOht2TiNPm7hqeUUcd_5PUCHBXIcxi.Tjy7VQQ--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ne1.yahoo.com with HTTP; Thu, 9 Jun 2022 23:13:20 +0000
Received: by hermes--canary-production-gq1-54945cc758-szwwf (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 2f409ca26a6c68d04d9ee89cddfc02e1;
          Thu, 09 Jun 2022 23:13:14 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH v36 21/33] binder: Pass LSM identifier for confirmation
Date:   Thu,  9 Jun 2022 16:01:34 -0700
Message-Id: <20220609230146.319210-22-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220609230146.319210-1-casey@schaufler-ca.com>
References: <20220609230146.319210-1-casey@schaufler-ca.com>
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
index 8ae1a624cd37..f2a0faf6d9c6 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -3107,6 +3107,7 @@ static void binder_transaction(struct binder_proc *proc,
 				    ALIGN(extra_buffers_size, sizeof(void *)) -
 				    ALIGN(lsmctx.len, sizeof(u64));
 
+		t->security_interface = lsm_task_ilsm(current);
 		t->security_ctx = (uintptr_t)t->buffer->user_data + buf_offset;
 		err = binder_alloc_copy_to_buffer(&target_proc->alloc,
 						  t->buffer, buf_offset,
@@ -4552,6 +4553,26 @@ static int binder_thread_read(struct binder_proc *proc,
 
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
index 8dc0bccf8513..7233bfdb72db 100644
--- a/drivers/android/binder_internal.h
+++ b/drivers/android/binder_internal.h
@@ -550,6 +550,7 @@ struct binder_transaction {
 	long    saved_priority;
 	kuid_t  sender_euid;
 	struct list_head fd_fixups;
+	int	security_interface;
 	binder_uintptr_t security_ctx;
 	/**
 	 * @lock:  protects @from, @to_proc, and @to_thread
-- 
2.35.1

