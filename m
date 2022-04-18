Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C17D4505BBA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 17:45:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343735AbiDRPsJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 11:48:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345509AbiDRPrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 11:47:14 -0400
Received: from sonic311-30.consmr.mail.ne1.yahoo.com (sonic311-30.consmr.mail.ne1.yahoo.com [66.163.188.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 324FF5BE45
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 08:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1650294873; bh=69UohOF3eRTLQZh2FjF33Zrm4UgU6zPehXD/dlT5I2I=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=oPVbAjSlM89WvAYoyW62RqgjWWq9lBP3EPNHrTTYNreUeen7rPmgI+LfWY3fYutUqoGiyBvow9EzgyFStP/GJMt3ODF+rPbYK516PILPVvDv3kKkLHc2FCizVKY9DIeYnAvzC7tGBQx/15i/K2ZDihonyJYQHf7ynlPMTtAV0B19idYcI+0hjAkKlJcQ8nGzQuN8LmgsZhNZV8yE/YcGxfiEFwQikTW+6LOMEOvC9CouRJFMlDiPpSW9kHGEsURemIZp1eVNmot7n/R/9qGKRzmi20MXAtFuoBUkuhlO+qaCOpggJaSBjMC6PNq12lbW3fBdOrRWzVqmZEOOOoDy3g==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1650294873; bh=nS8fn6QTXDQjCIFL+o4u3xtJmoD/VojRgAaADHs79/N=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=Bncmwg8/E86xI+dhKQGx8TE1QoDA5TsT7JlDL/j5EeBkMENq9v5feXTGpZZvwzAWamQKnRcOmOBy0D2S3qrHc1nLLZ6yZ1VfBbAPpWwrd8ln/uxN/TCOmeeW033KXPImGdTcZx3ecu3DFtVIcR4gLo5xrGeudSla69NExcDxCI5QTx0QQMRAnAYH5ShIaRT68GhtxzOK1bw3IlzlC3MyAkT1hCne2gKBg15gV9oi3hOfrlNssZTNyRpxcH/H0wYYbcn+dPR/dvFULs37TUg8k3QeyDBiMbUqtJZtYxqy85lP+hgvMthOAyR6HtYLl5XMFPbnFOHSfL1xH+uuB622NA==
X-YMail-OSG: QUP9NT8VM1kDlX2S3pPL7dScr7DG3GjZ6wegZmh610UDvje.9iESBMDAqFuJ4.f
 .hr8_548_RU.rtXup7vMN4SfiDHc5kIWFMkX5S3xEhZ2Sxbu5PyrfY5pxESQaHSkHdHna6ogWumK
 nK0UPC0yktGSpXh9mj.d6dTmi8MlHmVyxaYeOTSzhorVD6epBCgnAExPGFZw7nerAqUwIaWYgkk6
 jAsYK2togydhUh26HcbpNXMOGfVlJE4LkRNjSaYGl03_j8ZyOLuK9kq60.mlQZCVuhOKnN5C2v1x
 Vbm.TierF3_FypZAaS6nWxrTqAAx9XG6Yj5CwxcsGj3aoixbpGUKbnT3Bm6qUdopsNVw7CV.JvbC
 s7LnNw2252ISxbVevHTuEPG.b8jAjhghexCEvSKaMVTBk7J14a5olqgQBUSwhRKvSBVkY1IuUU3c
 nDLLwd_weFHKgAB5VyFGQCWWOCNGOd9Qm9Q1TTd3FosVBBYF.NOcDzb5SlFbHPxf_yJzClWVmObp
 A4jQjkhroswUvQruEsqdbYjrTmQG6FfUuCUmR7OH07XKX2xTrDb_BKmHUtubbSHA7Qyt1ma6wiF2
 lYkaH2ft.fl0LS7QdafM7Ucdf_46IyfFx3kYwaxY8fEe3lDL8d3SXLyAyVXzc7m1BDph9zp7ueaN
 liL0AJEn9DQcvPcXQqi0whlZ80V1nN4RxjmFds3g1vmoVXQa5.SaEA.yWYzVHAzXhIIsjtYpBVZT
 TzqLXck18baYqd_UR6je4IAVADlXG51p5Rgr7hCOfK_1Eqf2Vk5UnsC.N7_OclQjtTCLtsWjs5FI
 AEJlujVIoqqxOn2QuPl4.kT6Vbi.FW7YILV4nKr_ngSa527n23ohM8Bgipvpcq6PpVHf7i4lBhJ6
 HfXUGtmHsHsk0QtRSlLCcRUEZ6Ceqow_gfAB5SfATrAnYofx9rv6m0UHrDM8Zb3QVEyVv6VMpkdg
 b3S.yvZEpt3xUek5.vhU8F7Jw0N4OGUL4jEZdSjgU_ByEnuhzu3VuE0i9kKL5UaWwCbKZrNjfXt9
 CmTZO25.KDtWxpBACluCbYDqUC0DOJIKesFP7Qsx69Pyo50G_Ip.x84I4_uyhfcY4oD2LGWTn.Qa
 fbKLzZafTUjgsFCfF507lsDsm9kJ_9Fs836pUomgNieFdhdAMZye45b8DAZWavQ1ALdWSXOOhhXg
 hybqo4ROveJbrRXY6v5caezUdmQ14hFaKl0PXi4jvTXORqgoZEV.rwDVp421PU2ES5X31OaguxKe
 cYn1IaIM88r3yAeDnzriahqmcWbE.._QQGNZoQSgRvlxE6hCyHJ194Ctr1rhSS.DL9cDU8Mrugju
 j9m8KPCu.xwCEm95g758rD4_StuyVhLW..GkPBgMAm6RSD9X7YoDlQljTkwSPMPdyVAuUx3WncHh
 47ctydbWZqBuSr3pw6Z.vUYq0obBNAQFxPOgh9oxKgGKcGb14ZkrvjawZSzjzjCNzG61q7fKoCKu
 DIFJw5gnCelDqH_gz7uRBiSnybzkyS_Nf.4O9NpLOuphIMALUBHfQoKpEvjNyGMih3nCJERKncYC
 ZiZrTV3DkOyj0bgmfreLl6a32uDkQ.D3LdNtNE0.vLoudAwBnz3tiK5r7K7_vVYQYXRZUtHNozjq
 0Hk.ovkmTeC3H81rHVTjZo8yC_8X6iXyKKW_ThcNQ.dLz.GL4vr0nsvVmcX3FBR3qUCSkOr1rEln
 u9.eEDE8ok1jrXlVx51FMzskg0A4vqVLJBlG4._2vdzhE3o_EdQ.x6RZzrXgKUmtHQgTJURWRuAm
 LwBt_3jlABbP2h.KTxCaQKbP3CSyFPdWwhMFkFQ4p.3TeWJTTsasMwbe9E2xsm7fJ.NhaKEVrlbN
 eq9Ae_po6x.pISY1elJliiuPWhfKrdaMYL60Dj3XC3mvloQALfQkXqh1yvbkoXkEmmeHGuZpaT3R
 Iqnp4yQ5qwlT0c2yFB26vKPKNZMeWlcOp18SaGgPe0iASTCRYFZqqHK_qgsOEX9Tx5lUzX_0kXhJ
 AIrRpqHDnGWJTCp5OnDsiU.2DQT_kUTzL44UFJOuar0_Y5bamnQkfUXgpI8.s8dLn1NvyECThIVf
 gNJCY408awzB.SpvxKgwRIJOHit4lyILnMkHWQtvyHuLIpYgz5pmK6tVRc4fszqsOiJfIEvW5wvF
 wPZEcq7WkXevoGfdnHNGXmDV6J4IfQ5NigdBMeLWxPrMiCUtqDULAmZ2rkk8V4rACst8tNRIECEq
 Ulv3rjP3EctNMxyVygVzW26PTW2BHv6lMBhVmVYYkqNib9sNNWa6Ql8XLWs51vwqhOLatNZU954C
 1Ag--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Mon, 18 Apr 2022 15:14:33 +0000
Received: by hermes--canary-production-bf1-5f49dbcd6-xjccz (VZM Hermes SMTP Server) with ESMTPA ID 311eab809775b4af02ae966c725fa26b;
          Mon, 18 Apr 2022 15:14:29 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH v35 29/29] AppArmor: Remove the exclusive flag
Date:   Mon, 18 Apr 2022 07:59:45 -0700
Message-Id: <20220418145945.38797-30-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220418145945.38797-1-casey@schaufler-ca.com>
References: <20220418145945.38797-1-casey@schaufler-ca.com>
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
index 1ee58c1491ab..388298a15556 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -1145,22 +1145,6 @@ static int apparmor_socket_getpeersec_stream(struct socket *sock,
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
@@ -1264,8 +1248,6 @@ static struct security_hook_list apparmor_hooks[] __lsm_ro_after_init = {
 #endif
 	LSM_HOOK_INIT(socket_getpeersec_stream,
 		      apparmor_socket_getpeersec_stream),
-	LSM_HOOK_INIT(socket_getpeersec_dgram,
-		      apparmor_socket_getpeersec_dgram),
 	LSM_HOOK_INIT(sock_graft, apparmor_sock_graft),
 #ifdef CONFIG_NETWORK_SECMARK
 	LSM_HOOK_INIT(inet_conn_request, apparmor_inet_conn_request),
@@ -1919,7 +1901,7 @@ static int __init apparmor_init(void)
 
 DEFINE_LSM(apparmor) = {
 	.name = "apparmor",
-	.flags = LSM_FLAG_LEGACY_MAJOR | LSM_FLAG_EXCLUSIVE,
+	.flags = LSM_FLAG_LEGACY_MAJOR,
 	.enabled = &apparmor_enabled,
 	.blobs = &apparmor_blob_sizes,
 	.init = apparmor_init,
-- 
2.35.1

