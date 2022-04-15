Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3E525030E4
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 01:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355311AbiDOVbD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 17:31:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356123AbiDOVao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 17:30:44 -0400
Received: from sonic317-39.consmr.mail.ne1.yahoo.com (sonic317-39.consmr.mail.ne1.yahoo.com [66.163.184.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99C8CDFF85
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 14:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1650058087; bh=4/A9RMlo2VDUS+eJ3c9f9QVdqHvAgQb0ICSOChfHCEA=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=GK50ujbSnfrM2F9efciXlWlD8a+j+mcpyyoKoSta0gMUVScn3YpzT4Qu2l6wSCGQuz1zBVXo61DRwHo8+TtJ+hRI275jkXk55C1QUlVwF435p1hKSKgZWFU7VzJEj+sbiZZYupgX/N+ZOTxM/zjXGu2QOf9gLmUrwAMAK8+XCj0ItVBv7pQ6VkENLtiqXkZopt//9PMyO1olf9C0A8s+vVy1EnqVf0fVe8+OZaMrAf/vAWOq71W8aM+hKZNFYTTvxLMjiynfZxFKOYIqdAaIAw/d2qaE7wzidY3skHcemQjgd3bViI+KlnlHAqqRfza31LxE3FAsV9HYoeARkh19vg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1650058087; bh=4zw9B3A7Eo1wBlmHkkvAcOTs6UzW00Ap3rbf/ngGJiX=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=lJLznHFRo7Och1RT/uOT3ekHSSA+ePYFHIRf1fSGdPg56+Ftu+BXB+UeTmXp/FfoUA/q6qxDDu7B6qhvhroArlehEaDASSMLq+I+Yh5xMvAm4ywafG3lskdPQOtK5Of//5PxWMYuFfupb7vIRwsenQbXyBj1SE73nLQUPeKQDPbVXxhcDnSGd0hj2T0i6cKo3WpKCSMnWJUDTm4JBLRr7Xa4n/3vqAO03YEVZb/qXM9SQX8f+0jmTS9uO8Z5G4CYoS2MQBkR4wh0iunFvZlfGU1OpM2WE5CN7jc66QvtbPd0JK4noE6tTDjo+cwH+WNOPg00oM8D9Uabqc9JTmbEXg==
X-YMail-OSG: FF.VAjMVM1k0nW4rA6UQxh7iVqzBGSGqO7mOc6dNu.2_iU0W3uPeO3JM0OT3ny3
 AL4.VUrKbA34Go_4wUH0twIA_vjDrhQfQ0iKMSSIfC.Vj92zdH1CZgV1H62AiNPRNOAYUsltJGpe
 mjSP4cKmcDYVuvSdOUa9AHL4YIPVSkgNDUp3GsBQ2F2TEjmpF.i2BqWF7X1wUlN8hqfwEinpB6qX
 NpQfR6RvyKlir0skBvkRg5AFXT0URegQKRqq6jz.7RDhBu2qFE8qbuv5G.MP8gDIMWS3KkS0_8NY
 xWWzsvuqoPfjJBtPjZzqX2j4s0evIPJHIQWXIKvKMIpQe21tXH58U.7zRse8BQsqHnunFdnRrmYn
 jwQ4qK2PXd.KoOpbQhTPFTfP0A9iOlm_RcOkgTtFmbQ_bLfm6PD_zFAMam57KABc_WIKm6RCzOIy
 ggcQIUv4eGL1mNdCucdaSrYa396pRKNHZe4R4yBz5Y9UXRfzNoHs9dsEioDP.7piEkfmXdm5ueMn
 rBcD1GUo7AFoTcgT39ajbfYD64Y4VZUbG0WE.4xbAhEmzNvwGvF3szUD2jzOnzM7bLUnCVFjfLyp
 mxhes68ajcTCAF..ksN22R0Mjhdzv5yOfNyNyLDFKCwcA_.vJcEo_jZbWtRlVPoZk.dg14F962OQ
 657B_F6vKJdkIK7k69OY6ADDHdokHgJp.yCEh1f2188H6E6tciDvTraxJV5XMwE9B9C3ufvxEirU
 dwk2skPyUpE.7UNhEUsZJHbJubwB.So2GAIOWewRfjubwVl3PQyzgl7eND7Wj4SlUX_jD8M80Zmg
 L7.YcTJdkwo4YPwYRrWESKssli8IR9p2yB_F80dTDQwBAI18dK3W8IY63r6nOoWazNwD.RPbCpso
 FXXkSUkqaftAgY5hHxMOWmhiXb1A3G7pJLV1TA3yZImP3jFZF9VyM9MVAhZV9AosHXbbuhHbzA7a
 OdBe9u.kQVyJw1qf98X3pNuc1tbxdtg9rVUeBEeQ41PxN3B_1MBP.Tfwfh1AupeeOnoQqLjSXzUe
 uxQfutOKH2tJVYvKqqmUg_V5bTW43KeN4QEQHCrbzKokgIWYoAWOKWGs18qqoaX0Qe.B.fw58cKR
 qD4lsVkTrejT3D6.y81uiJjXPqKAjeOVqy2e7afg.xyoJGIhNC6ANP7aAr7r18VPj5S_TMl4LHmB
 M.hWmacTqgu2T8QZKNQtBdIa.4UCBC6GJVV1MaBvx31OvP0JBfz92Ts68rEIhtvA5s_U0cgO0x4N
 98UI1LTm55WvH8butomX7VwQeqk2suxTjdChMfr6mCjAtYYAcGK8V6BzYoJmgXVy65CJO9W01vg8
 dNwt47JX.Bk6KVr_191SNguO.d.eNNhQOCjfNmUll9Csx7rFBQ..PfbQII2mMmapTmP5Nw1DVc4Z
 08LOmBxaVHxZISYFAGvte8yGUTpA8lntYYClLvuZW9paKwZhgFO5IcfogjzB7qbknF76suDxwbIs
 EHBsK3_Y7Z2r6kfkW9Q0y3a9xbhX4a6l.xocKRPcf_gVhFACRJAw9NG2USbC7JhOW214UURLIRZM
 Gl_Usz6PR6tmThbLX6cr1Ti9JvgG05gUfm9XKd1.ob81AWxXjnVa4nvax3bE9B_akDZPtFsDjGc9
 YUJg7vvU3AKc6kNxWuOPMv8.xvTX.Ow9vulDmCM_cIPjQ6mp5A3JSEEsHZtfR6lNyxk0wtl6d3TQ
 yKF5XIETZKeaJ0UpkVaHa9EFHRJEDYzZ51sXmSepOXdcX0JEbzrn4slJadyvszJLv9uYUKwPUpjt
 0unasXOTtZkW.o9L6WLvB.rb3tZhOZA3YhMBgGVew4thYVuBqobXj2eEwBjzNHkpsecurc9Fpoaw
 zwOrX.fxdY.LzZ36fo5.6OppCIO3Wo9eDbRzCdbubuIIvVtDMcsmiWtIIwi0l6edSNw0fvhevcgf
 wgPO85xMgI9CjI3L8GkBikPLxp_nRD6N3X0HlyJBjDiQbBUrRsCFovx3.Zx6.eNBGrDZBiVDHSBR
 1i5wlHYC6jBK9VqZc7pLotax6W5ciKHMCEF1B_ZVQsZ3A0Sx2sG_7QczlzJD6Vof_2.NjbH0e3QG
 3rybNYFKRUMk.MpUeu1pcHNuXXKBrydzPtenXk94y1KI9TDtOx8fHXcu.xtdoV4SR_dIPrtZH4D9
 o6zJt4t.S0VtKVc1Dya6iPzJhOyjBWRodpO.Q_6xiL4bxbw_0.FgaoSIv68hFTiJOcjb2T6Zvvpq
 Up..ZES84cuWsAYs1OQIvfkpCZrd82vIdi5nzOHszNjc7MOgGodUANrvNfQZcK7VwDnMHXY2Q_K5
 GDsk-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Fri, 15 Apr 2022 21:28:07 +0000
Received: by hermes--canary-production-ne1-c7c4f6977-vjx2m (VZM Hermes SMTP Server) with ESMTPA ID 515394db5ae32f289f837259dd1f1b93;
          Fri, 15 Apr 2022 21:28:04 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH v34 20/29] binder: Pass LSM identifier for confirmation
Date:   Fri, 15 Apr 2022 14:17:52 -0700
Message-Id: <20220415211801.12667-21-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220415211801.12667-1-casey@schaufler-ca.com>
References: <20220415211801.12667-1-casey@schaufler-ca.com>
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

