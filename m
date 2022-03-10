Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3ABD4D564B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 01:02:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345142AbiCKACX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 19:02:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345102AbiCKACP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 19:02:15 -0500
Received: from sonic308-16.consmr.mail.ne1.yahoo.com (sonic308-16.consmr.mail.ne1.yahoo.com [66.163.187.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A23471A06CB
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 16:01:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1646956873; bh=ufFIfi+QJcABRY0VK+r+pIW1TjiSDfvy9tEFxMIQ5C8=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=mobOI7BFWqlqOI7w/QW+5ttyB+ulpgTo4PDQaRD/jBdp+2Wfh1YOZxvXxNyaLR98fbfjDahOeS9YqUgr8/9vIxopbx9NAnU9RfzBr2DKSnc/DjlI38XWXjgBgruSCApK+RS87qbXVqlpfg+4/+78VoUkj7KcD89tGQ/GYzxN4eTSkFtv7Vo+RVWWLL83ekJ85YlDpBrYsfh3SVOebFlvoGQGGi88p/nu6aZZbEHM4XJsj+6aR3KLU+WR1fNR52B/AkJPnuX+UyXYboYaov3gnGTifxndR9MhUY4KA4klQWvy5YIuGIhwPbSwseabOu0vu8XId6cyn9glmoDiien5Tg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1646956873; bh=aOP+pLUA6Rg1M2NxD6rHfWgXBkXW4mkGNdVoDRvsjiM=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=shMzy+BtmeE6A3DzgYmaXqfLTz6WoN5sgnkOeXNrkQLk4tseVhM7PhFf1JYxC4AZY8WT2T0dQ7Jif6Wt6J+ZGLDAGC9HYc5KKFxp3iu1S+YvvEWzlI73pglKojfSFKfS7nCuF/B4xmhx9/zAIJMwxakCNPCr/jh2keuY6gtgyc7oad7rIN+ylDhtCrxP81iK0s2wrgq6LCo04210Zw587cNSb9F4Bly4LxMH5HvQxxhgWhsQeHaelu3PvMZHVCkGKpefjtdBagRUJ0c5ehL7fdgsAso3C12vLpZ3a7OUdckLzKazuxmF7bt7tNu9EvXNf70aCmyTEO4ugVBADA6S+A==
X-YMail-OSG: 8tsblVoVM1nI3rfpUcBqY7AcjQtIvs70pdPMglNT3QeSGMzp9dxs31ZHCJhXjVX
 t5gBBAj1fvLEakpTj29YEQpvdu0fieT1EskkDOVGZvND2ZivH2ZsV1hlb6gMyMI3dxqPBFOBgGS4
 G0mx5j2L_IedkrgUA5FqH.aVVh0GZnbrcZUHNyiqqG.GQUS_lqiHpUdGTBBoFwPZYmvbu4c77npS
 RTiF46ziQa_AYalCVBw2M9ff2mPh1D6iCrBnZbhG_uAaR4T6jcIOzed9a28oMCqV_n4LdS2scrFW
 AAPXgm2G7p2.1.oRxIN6rf9uZ.XjxP_r49saJos7jS34_8UnrbMo5qSjdt.3KO8zvSHEc3xY9j93
 aOnvhEQeboGYs4B04.9br8y62VstH2Tjf2TQCnvFODqJR33DDEp.FIHtTNN.FTJyOg9wxFJbxvlk
 LLSmPBWaLwflZkd1k3ct1eME86cljZnxSM11ghf.yvLVpnGkZMb9cwMly6kuG5P2uyCtOz3Y8s.g
 UxC_Y1kCIecFCHkeXk7hshkFXPVKcPDKAKbOt3o5Yh1RlfiOehV8e6TH1nnC0TeIbXj8RQ9e1gp7
 2FjWZbdcwYQqXWe.eKdU2vnmXV4ZZHqJ6K0G20tMAZEZ4BiU3Plj9WvUL8LSbk6CB53FsUzNuULo
 MVmR.PPLjWHiis0wE1ZauaGHI0T4EbZYBx4BqfvShe0STyP_YlKU07ZDQrK9omZ5y93FqXcDKMlX
 zQBNKnjp65vwkiF9yrVzODSxjP24ROQmiitjjaEfVhW1n8KvW1jJWUqcBXnoEYV2H34WJsUK4DtB
 up_7.RS0k26SoIofhu7Se6Brtd5BEmgOejK9YU8jgq_mL_fNTPm8LdlGD9iKdHByK6sBHSo21J3C
 8_iN5yBO_gE.HDCznvZM7XmxUAn766pafUzwZQYPRK4Y0vcwyuuZMqnTnR4za2Q50EbtBSS6CNfC
 i29E9dcAWcZPSABroMhePiKPaeYF9VeWn.lKfx3C.rCmb2UA3FNUzxrh0hl4bco2cmMMIvrNR3s0
 YH5dSFsiOgJzNYm9gV9UogxL84565c0tseseKW26ovwJbel2d7wS.JQsq2LhA.TmCtaq.bhEWhpO
 V3LjzqCO6csOv.CSOy4hqiv4c7sRWnrCjSqOcKbwF0hV4kkfHBIs_U1aJviztz6FHAP5QLuK9DQk
 wAWQhcfSYzDU6xe6MBl0SrNIZiS_cBHL.Wr7QVm8zRI1ZWpH9KsiTryFVX4tgTWxw_bh5n9Y7zwl
 6kbZcZ1xgPvJaSe.U1rxgTh1cyGKJj30ekwCEpenTGtC0mw_8hEMPo6QX8BN19Rvl6y0bsuJCjFu
 cYWzd6jIP8xD51S5u3IOEU__JXjOL7jK8KNAJuD1hJRy9bFvR9XqaYwcRC774O_MxscOjiQvgg9C
 YjzvvYdbLQ7sHKBeyesa5j6y2BnpTOBlx3nzfh2Oh8uo_21L4F9pwNvRQicGqw034MhZxjnGqhw3
 YcxIboMNKMOwyV6YWQCl3tNArEn2gguIIEwkl12pvoXWd0wWiQ77a2KcVSVCn1cEdYD0cV.vLYcw
 pI_cqTQuk0Sxi5Ur2vg9hNvIkMcKtdUPSgGIBQcRwgLyI0_OASXCP81H2QzUz6eO9ReiOt5UJ8C1
 yTKvA8dg8pr860.h05AlXFPaNuR5ioQTqZ9w0r3vg0CmONsXNnJAUoIlk4r04MH7O9iq6M83ut58
 F0RzZvoB4_mMRNYZURtJQU51A2fQOjQTHfIB_LvwPz2hbEhEwcglzzkvTXFMd8n3xSmPS98Nhfr8
 _Fem4h_bsffiLotJfH7dl15IdX5oqszM5YNFdTtLnZWzAbKLHLArFy_bX1Q2NC6a7Zg_FpNNxWtK
 9GUfJSx5lBuDl6eYkpK_7BFXxYbdHPpMu4P8ZwJRHcjisqF_VebANcmturstjhRubdKapzDW40J.
 0yEbpO7Ch9oUebTSDokcqCLyjdhVth2nnJ.kfPdghB7TOFEoD5QZXu.Ziz7TsbkC6XE.CwNT_wdh
 rdkXdVCsksqF.xlCiDQDr7NAGaAVSYKmJvKvQdGvWecivfInA0H0kC7P74HGzjiRNrHGVpjuavHj
 _YKiZIfy4lsVbHlWJl7X1C56lNprq2Q2GeC.T5CLmqNDPY6UyotdTWkegBmUFlv4_Uyou0fj23Qs
 437TRYKqmWBBjV.RmUrKADS5.20OHPtbtbT5YZFOb6tqbbEabXyJFVOK7qsVYeD0yWfl5k9hHEI9
 D7QFH03.X_XHIqIO6CuhuV6f1Tjzelv6sHJbXcuG6BbqgzqHihvtecn9JqYPNqEkLGcxGq9rN8Mv
 qULYEJxB3UJLvmR2S7AXup7opwKzI
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ne1.yahoo.com with HTTP; Fri, 11 Mar 2022 00:01:13 +0000
Received: by kubenode532.mail-prod1.omega.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 14d447c144378bdd823ae563645b8a4f;
          Fri, 11 Mar 2022 00:01:10 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH v33 29/29] AppArmor: Remove the exclusive flag
Date:   Thu, 10 Mar 2022 15:46:32 -0800
Message-Id: <20220310234632.16194-30-casey@schaufler-ca.com>
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
2.31.1

