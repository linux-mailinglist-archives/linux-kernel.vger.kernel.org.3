Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B6A955D58F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243020AbiF1BRJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 21:17:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241093AbiF1BRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 21:17:07 -0400
Received: from sonic302-26.consmr.mail.ne1.yahoo.com (sonic302-26.consmr.mail.ne1.yahoo.com [66.163.186.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26E9822BD1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 18:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1656379025; bh=ZdG4xpFqsU+bajALxcF2VlnWGR52G82iCMkdVTc2osE=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=aQqENFqDKiIjusmJdO1dPjKaNLnGBnUwe49kFxwaFK6ffWAElWmFS9Ltb8glOEyerFNMmWqxQT8RLwQioV4XVddc0YYisckcKkSZFpTabpgPPt5iXvTj/hIbe7f5CKHUudTK+mZysfHZAn1Hh/ZZPUjPAs5YKwgVnVhrxsKOmokjz6KHxT/so7j9v5xI2PYDR/u4BhEfg3SOe4yWVQsngBAnq/LT+VHm4oz579DrE+C8ryLBZULybnpwQPfhesoTyVOAaa2d01r2gmP9wXb0Hc0kMc8f8bMX9LVe5p3uE7CYGrVIeZvjxkvssKMrynfeT0NF1JA/FWzt8JnhlIzNZQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1656379025; bh=BnocZkrCMlnPpcI7bRWVONAkAFgvhD00MmVMzPoMYx2=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=UCo8YMjCI1hzPwCZdrJMCos57//QRTY9pBOfovM9eq13EDMDOT3fK+YjkmvOWaiBprgwQVLfeatf7mg9tgmHC8Z406r1Ow8va9q1LAjUxeMh7JNwoN/ZYRS+6AdMjIyLgirRNvuQk4FtHwrGqbkIz0D9fLi0aedg6v4LcbEaWGExE8ocrZoAqt6yqCLY59hTzcEvBmLqMkWL3S8ocww2ejfJdkoO/+MMPswajXZsFLJetbOn5MscIHTdVvtlGEyMtlnpB3NKSYoOewF5Or+0c8ks5ALQ0wqzENj3ihK5CkN0DuV5ONU3mj4loyeEsbuAVWFjdUg/vrWmz0riKHUB0g==
X-YMail-OSG: 6j1tcUcVM1mY2pNz0kc_UTsA6EKFHKdzu_9v.DMblyd0JwQA4uua4O37jDB_3yy
 ATeycsio_CKScXnjbPqwxNIQ3__ihPR74kRXInix43UqGeNZO2gC0H7sI530PkdCpYBCvdM5yuIK
 f4fdCnOyZMyHqLV7RKm2w9mYY7CRN06uTomOnP38BrpqJr4T16g0eGrHdU2yWAeQm47vEI6tvuDm
 tmsjW9zLYPNvtcFSP2RXu4zdaJ3YyE8kJaO6gGE2QbnJ1_gWOB_h39PWUum_7GrlxMZk37eYCfz9
 UEeeidfvGSDJneVDTA7Z4v98e9qZyM1z6qceJ0YOYcpxw4XMKnJY.KGq_jCFwEACR17FPA_4IeFE
 EUeC4F13p5HscqkpsA0jImYJSu_ELaPEFuvOMWP0h68eIHjWN1SSL1dDo4DIssIoblVmOT2A4VMx
 dCsUIjBgyUBQcspekNYJjleJM90xXfmt5qWUWEDsEyZ40whVka9bk8L2WjA7Vo.iJjZExosssV96
 ESnP_NsxxB4FVziVhWtS4w5Q8DqLmslmXHfV9O8wA4c1DcybhZhg26aK57c0rvPnkOf4pJ3pJ29S
 C8XBiO2C_YZxJ5k.IvPUEMmVibsNNB9KlSwleER2zjQbtnAgfBvGFXckvqQYYfFk2pLIRkyjYl23
 MbOZvigxoWfoX.OsRz24EEr3gnvElahfvWKMgVvk1bfIQVndOgJrFQJDduToYyPqyC7nzXWHxPHD
 czXsmAWMNAI7CAlFcZEzsBgLh6c7xcQe.MTCkAWryzHW5OZrSzATA3x9Dq.CH0nI_0TXy8zWCvv6
 GpC8KEkz2BajPVcIc.rGvOqXp5f0KJBL4ppw9MIL0wSX._CUq2nG0DhSzeakbOzMf2VQwp8Mo.oD
 sDZ6mjNPzLnq7b_0NuUDynVOeFugRkcvrIp4n0yuEtRklIw7tGddRu8A8hVJJMPlV6Z2GHrh8UnK
 rTV6lioHGMpG0CL7cFWAtu8akMiDJ4BjYiREW0jMHMisQGGVw6.MpWHy3A2JrLpT0.jOOi2kZG3S
 O6kBleAfb13cTuUT66N.Z_5DIhKhWpEp.jlBe6m6xvtp62gzULlldwax_kSFMvCnpFiyF3W11JCs
 h.FC.rDaiT58olhbuwc00hUJ6rusKLyCU0b2P5dTRnRREUzvt.vr..jMApU.Mp9suDVYMjDnR3oi
 52GKHddLGQQsxI8tDwVFR_TTE5iwaBdk8W0T_baeRVzSWsca1eclrpXNfY_Fydjnu5H.ALE1_MnD
 Caz74gAdJBGOR6QDz65G9gCRWQulpC0F_x9H0tjnPTKbyOaWUtgMnvG.Ww1umbnZDrQia1TCwe45
 VDPbmt5kePhEPu7MYlCgIpeqKMnl3JxAwUOM1lwpzygZbOqRBNPy0LEycGYS7mbOAPmTh8N3QSpQ
 8tqY9GvpLNCT7PRvRGhAPiYhYHaGH6ISohRsjd1mpS9zzYWtyvVEOjnoZhox482m3dZzpb3pvO1V
 mOdKlELV6GIvBC_ryxbooMMFGueLdIsJiOivAr71hjQE8Qdj73FCqoUsnSU45XbbZwCvYhVKtg4Y
 rCHNx56ahlxJWQc9C1gZYfr0XNAFHa9FBeWD6RYljhXlnV7Ycp9oxHW4zLVjC2udolfbOGy5wXen
 5TcyLzy4VDN7vw8YwwOmkELvHNncgU0O3y9OZs.9syGQRW050us7wSwKLzygc3Fz.M8aUv7MJ6y0
 5r1KUkR8kKVsM64KigKPwLeK7nNoMayg4svzeovGzf0Mi3EfsrOwADWBAgDyRzOk39HCBELFp9mK
 q8fMZsu_xQBL.5DAnuXEvpVzyh18h.1.jMsh27.J8UX7i3Rlp3luG60KuphuhoTOsA34kWzKWrIC
 SJFD0tYYBkKlXiDri9KGsgYqjkKdBxdHHM7vzKN9riRU85qRF2df.zWv59xDlvl6Tp8uXQ3jS._D
 6ZHlwjML6K16hglU7S.ZZtSU4FduUMdtmEQG72bwJePibT9DWq0jgnGd0mzhbsGGDEc9FT8ETu.U
 2tOidP.nkyQaCtjgQXwpi.q3.RRmjLlvcJTscWSv2ZqGHzaSnTB4JJp6UPVLTAUgewHawWiXzW89
 Z0Wfa1FAid.P3zOKpLqk3PjLJTTZawCf0iUBC1iHFCxFZ2gCCsfnPflohCvBlULRNO9.5zTPA6a7
 xwlYPaB4r4cCmUDubRJ9X0HEH3HjBirzJmTzVjOeHVFMFoiFYrHC.MRUs8hr822jjqVYQfc7B9G0
 3BkEY1drcIIP03opXGTAKJTHZiF_0zMjx.vJdrQ0rNsaG2GuCqkWVp85xwuM-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.ne1.yahoo.com with HTTP; Tue, 28 Jun 2022 01:17:05 +0000
Received: by hermes--production-bf1-7f5f59bd5b-9k855 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 9cbde2a328acbc97554c754593bf0b6d;
          Tue, 28 Jun 2022 01:17:01 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH v37 33/33] AppArmor: Remove the exclusive flag
Date:   Mon, 27 Jun 2022 17:56:11 -0700
Message-Id: <20220628005611.13106-34-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220628005611.13106-1-casey@schaufler-ca.com>
References: <20220628005611.13106-1-casey@schaufler-ca.com>
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

With the inclusion of the interface LSM process attribute
mechanism AppArmor no longer needs to be treated as an
"exclusive" security module. Remove the flag that indicates
it is exclusive. Remove the stub getpeersec_dgram AppArmor
hook as it has no effect in the single LSM case and
interferes in the multiple LSM case.

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
Acked-by: John Johansen <john.johansen@canonical.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 security/apparmor/lsm.c | 20 +-------------------
 1 file changed, 1 insertion(+), 19 deletions(-)

diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index 1fdb885facbb..1d742d864e0b 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -1165,22 +1165,6 @@ static int apparmor_socket_getpeersec_stream(struct socket *sock,
 	return error;
 }
 
-/**
- * apparmor_socket_getpeersec_dgram - get security label of packet
- * @sock: the peer socket
- * @skb: packet data
- * @secid: pointer to where to put the secid of the packet
- *
- * Sets the netlabel socket state on sk from parent
- */
-static int apparmor_socket_getpeersec_dgram(struct socket *sock,
-					    struct sk_buff *skb, u32 *secid)
-
-{
-	/* TODO: requires secid support */
-	return -ENOPROTOOPT;
-}
-
 /**
  * apparmor_sock_graft - Initialize newly created socket
  * @sk: child sock
@@ -1284,8 +1268,6 @@ static struct security_hook_list apparmor_hooks[] __lsm_ro_after_init = {
 #endif
 	LSM_HOOK_INIT(socket_getpeersec_stream,
 		      apparmor_socket_getpeersec_stream),
-	LSM_HOOK_INIT(socket_getpeersec_dgram,
-		      apparmor_socket_getpeersec_dgram),
 	LSM_HOOK_INIT(sock_graft, apparmor_sock_graft),
 #ifdef CONFIG_NETWORK_SECMARK
 	LSM_HOOK_INIT(inet_conn_request, apparmor_inet_conn_request),
@@ -1939,7 +1921,7 @@ static int __init apparmor_init(void)
 
 DEFINE_LSM(apparmor) = {
 	.name = "apparmor",
-	.flags = LSM_FLAG_LEGACY_MAJOR | LSM_FLAG_EXCLUSIVE,
+	.flags = LSM_FLAG_LEGACY_MAJOR,
 	.enabled = &apparmor_enabled,
 	.blobs = &apparmor_blob_sizes,
 	.init = apparmor_init,
-- 
2.36.1

