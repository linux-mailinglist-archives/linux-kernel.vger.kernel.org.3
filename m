Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E12855C7B8
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:54:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241276AbiF1BKj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 21:10:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241255AbiF1BKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 21:10:36 -0400
Received: from sonic304-28.consmr.mail.ne1.yahoo.com (sonic304-28.consmr.mail.ne1.yahoo.com [66.163.191.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50D7022B18
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 18:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1656378634; bh=d2AZFBkxP9+t+hI8o1br7sFS1euNhHyUWMYU7J/f0uI=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=U8Xg/bdHp7SZgXnt8iiNX/e+8Yt/0XUO0uZSS7vKUeSTW65BsJhCQgxf9lOKtwEreJ4zMVlncm2q1Cwl8j5otvLWFiO7akAoecXhLN81TNw83ppamJ/6q1IiGxPaHWN73mjoGbsCzdywU+yg2f/mZJuj/wdHp+msnjUID5HC2TBqmenG11IECwofQGOedPawH/OtrNn4akCwmhMHe3kbrHcr+o5IRShWOCWhIjx3WhlGkNn89yJk4EvgOlVR9PZcQdyuLRJjsb0WtGhUhSJuBeSfyLWdhDwnD1/6WUl0hkFH/GVxz9pXRiU1JZwjaeJoaXYplVVM8qgobreg+Sb6Jg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1656378634; bh=7mR1+yjsZfiJOWVu7teps0jEx5GlJML0R8ndmJQmrk5=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=TQ8KDe4G0q1UyHhfHr79ILds9y9JUGSsJDWilqudG6VSDDRdVBbF0fS7954FwONvK7npDcRvgQMnnq10NrItj/7+i/sIBLaCjPJv2vsIm4ehTUEYLnm66JECI1T/OETlM0VLxFXdafsPTPHRo4SW35UGeySBiXoIHSiNv1bE3Eqa3tOITxyn5ALKu83reG16adqPRUe0jbwhRInj1tnp9ju/GE8lRSfYzhr2SC44tJ9Zl7s3lk6b6F/8UTQhDp+IY2DwV9aTYV84nuYu3jSYo7atrf1J7a1LxXhFlyWayP+PGNPkmU+JZ4y0GcCjEOKM/JKSY2uzRHBU8zBUcgWMAA==
X-YMail-OSG: PWJKTvQVM1m0LaNnzeyV5SiZKnQe6p5ZH_o3JvdCR.UyeC5BxTqSQA6sFjav.jV
 TrLHy8uetLOAp5tVAwRgb.nX7RYxFKIUyAPagY1oF.EJMVRDEafesrpWVG5Mnz1FEym9DmujE68o
 24HNxzxZBiQrCvdniwV9kc2Yypx2.WvwgYWqC_MmMXmMgoVLahHnYi616ezmdwDDt771AzTnk2eo
 IR6fRFSC1DA3wD9gWJYsWo_R02Yi5p1CmAWRyqTE5Cjynit1k8LQtn6_Tk4gKe0B_34LuoFWoJQ8
 kiwR36bGk8I_KVCCiYeZt.4z0wInXRj67XvHHQ5TOcYG0jOJp2NjCAi0cS3j5p7D0pjFz7Zj57qS
 rzPtKy469MU_GMXN4VAhvt3PmiQHcg61g4rwZ5cN9S_3L8KK.vjBHvJmrIYwe5yFfAOTrS.Xr3TM
 IYQxzjh2qm6ZKX53zKagu4tZ2_xSvRBKPAAqAL_sPJgm4V.33ctHeBTjEg0Xm1E8.J2ilm5UoBYF
 ka1xhOnB0VSKXQCj3cxuecfQjJDtZe4qrXJQzxG_Tk9BmMiVOgxbm_3pU4tyULHO4ApEAEuNcLA8
 eVDvpn1YnKrCMe6lCxPuMabgUOAUvblnF99veSpDzWkuN3PI_hiEtOXOmnJEcFpjfLVQrj7uVgOG
 Y2Jck6g7E5gUNqmIkzMNsLmnII2E9OnNhLNDwRo.dQ8PZdtlnbZoYskfPFUST8wucWjLZZw6B_1M
 Wa1nE3rh1DzHUpizodATnxqV94b1TZz01z2RZWV9q2AliCMFG9l2hsm458y17w_6MDjx2TZu_tQc
 0kqohy1quon76XW4BEippfBEm_JIAp8gFZMu84T58MV0xBeaC1Dn2N.5n4kOcLAsb9uVgKpdfzM4
 fswyviPDrtlBuRjiO1j_RO75h3BuJWc7PvpWCsoAQRg2HD.jfYOZzZOmwJjrr6BFxo4bZmiNkxKK
 9z6JGI3C0o8tFbXj7i7qYDZwwaP0QJMP5Y51TmQ4fpohXQNJpg_F66yYIIJGbVCh1c0bTkwsam5o
 olfcqCwBmTtCHz5k3t0EcBgJ9UAztirVwXiO_EM.oNhW9cHLk_1pTOjlJEn0N5ZbuhLRe7Ngm810
 PfR_TjAQhnfMKp7NyulcdpN5j4hMhGE0e3VqETwh0XjsoUo_1KxzNo5tZvycn5nwKESYVKO.qCna
 3HOhitMLlI3PM6GB1MopKjVUjpvLORS7l_iHKLZ1zNXOxjhASd8AlcyZsavDshJypra6V7iwTl0I
 fto.Q_YI7IhZi6sr.bsFrm9WUKvIVmAIgZf9aQZ_jgas4CuTttwLhEl9Yk5Izg6KYgg8PnPnCcmt
 8IRukGrxWrnkdvCcijPGWjmELdA3kZqvNClIjXsV5OOkhiER7.9ruh5x7aXVt.QG6Z0GHWRpm5hV
 OCqWJJ4ESF._.UKHH2T4X56QG5jevKrOV_a2xrwF_NnrTorcJ45N21OgtO1cbblk.EqQJwHw3qM1
 HDNs0hsg.wQ00NSFgarAs_RnKhwIob5MwGHR2jwqV8Qj0YOpZUkR8hDriWLunKoa1l_tZfAP6VXd
 3Jy1XMsIKYA0TWvULApi5N5e.431FQV1NK74QzHNvao2F.UGJoSlR10UP.LL1XjxfZ_10OzbIhdq
 FOKgCWOdmvn7MZWYlkYTpqTiMxig2qMbYR2u8xdYbt1SuKrg8tEXhT7p1nmfZwsRQ6vFg6S7oyjw
 7PUucnWEnu52FNopY3uAGstu7aC3zEDXp7S4bB0UfuWVei1_kdpnXvhQB1RqtTmuugX7aEiD.xDw
 kmvRnJ_FRcrvgs3lykt5mmUlh56jgiml3f5p8PmI1fujo8laP0q6vsLlPmjI.cvmqe6PBarz7JBh
 TNfA2WnK5abn889WBEgj4APcw0EelCyi2rL6iozx3vLW.jWEGc3HTe.cE6asIivEwk1o.1QxMIjZ
 LXtWEcHNk.ZDG1qfd8zYMmNX8af1XM5XBlg0_IUxOA2Og_ZxE0In7HfN.Ooz7nIdtkNUj.DQmteg
 q3FIL4d9sFhbBXGCOBOl7UjQuvdL46Z6Xq9NO7mH.jnolOFlbDh0FzN.iS2KwhIuBoQExl42stEY
 jhJeOd2XCs8QxarZepemrkYplyXBSy4J7x_NPxyhsp3.0_Mq4V5DF0_qTuCLedByNTmjfom0Y1GQ
 92sbzdelCasWG5svhaljNrThQUXMHRlhJslG_eRE2sU1MOHcENdM8tlvMljkSmRhHzLyhYYC6rOU
 mAQmi05S8hSLv7RxAtxgOs5QIgpU8eqgQ1kxPrvvz_2Ol01_s.VCHtxe8Kid0B9tegjtSoSQJXiQ
 mmxp2KWd_qFtLBlXUPpX7wnAGBiYGs9Jdd0E41BHdAaaS
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ne1.yahoo.com with HTTP; Tue, 28 Jun 2022 01:10:34 +0000
Received: by hermes--canary-production-gq1-677bd878b7-wc7mq (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID e584f9a769c6d1ee8a468863bbdfebe6;
          Tue, 28 Jun 2022 01:10:30 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH v37 21/33] binder: Pass LSM identifier for confirmation
Date:   Mon, 27 Jun 2022 17:55:59 -0700
Message-Id: <20220628005611.13106-22-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220628005611.13106-1-casey@schaufler-ca.com>
References: <20220628005611.13106-1-casey@schaufler-ca.com>
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
2.36.1

