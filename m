Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23DC8473964
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 01:11:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244441AbhLNALi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 19:11:38 -0500
Received: from sonic301-36.consmr.mail.ne1.yahoo.com ([66.163.184.205]:37666
        "EHLO sonic301-36.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242347AbhLNALh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 19:11:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1639440697; bh=ILfwu5YCWq+aaMpJ0ICX0L0I4dees4dHGOc836rinKI=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=T/JRjc0fshckqXCnuWidx8AHHIZBqzQBjGvck3S+tVR1lEEmTJZdrKnOchyOuRU48InuLOUrSgB/xeCMwRKmHxo1XAfWi08/wWsWKdpTDdu3RIBZTDjP20fF79kLPVX8+LYnpScxlkLZ3Jt+q6jc4avLjzyck/KFjzFpAmsk0OaCRTheXfRy+VT27UwSDJoiFRHme8i1AKyzFj6k7OmCqOE0xBU4JlAeXRZAL6M0DRpia4ROGBVE40XMvxL/xWMh3C0HBneDuHfioqgCxLWPJM4crAMfnddCf1IyElsaiX7PmJ9D8yi6IiZMQBn9T9JZD1gM0Jpv58l0YQLJoz3RMQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1639440697; bh=Ppt2IS0Fm4P/To0BhBoA62Aq94pDN5B83hjpnJiRLLI=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=uXlrYQOgCG6czmOS5TSGgShYcHlijB4QCJF8csQ5jo3/cIMd99PBHn3Bg6n2D/BzkewdBUaM2JmldAbbbwwc7+meejEJwQKUN76ERWs0oGFsKXmkkSxc4V0R2BNxuIfr0wwHMHeeXmbVkfAlbRTa6VZWK/+c55DSzpq/EdqyW+e0LLREWGkQ/bKqJG8R+dX/HPyI6NHfu3Wz9vHoLZu2LQlSBxqTuubxfSQIQKKSyxe/hTSDPZz3+z6DcM4ewZH/Pg2V/qlzWE+97mzunIaHZSe3FOZmF7TX+Th6xBE+utnGKhy//zs0N4fhyaa4Sl64M9poRA5EUVtQoSzRt2XJ+w==
X-YMail-OSG: k92q7zwVM1nykDC2ZVP00pX.y7.HhpKJ4U0.0wcKDApxEp_omcZZRWasfhuo2xm
 Itnjo3b09fDcfHenVLIK12J5dMnH1pRnHlllWpBX16wc9LYzEm.2gSqfyhFoDNx.nxv1pMZXTkLV
 av7QfM3dq1KMpjtcSS8Co_rzP8.xq5G7ngJWPPfSBduACjiHJWtwucgcJa3xwfVk9HhT1LsqcXsV
 evSwSpVy3SxOhhZM2oZRyZ9IIPoyp64DyQ_KT.uZQUMvMjxkNTl0oyyoaTPnVHPOtkX00FmbwjXG
 bx.NkbK1NtS57bhqaA6ziVH5Tnd7lb2ajcB.rmJ4djIf_iAJHL0S5Mu4ooyaCENirWE5Ksoscf8u
 Vw45i4AveS9wpEbD9tN6pfhe7ilcMLn7XMBf_q6f2ILVIHuJqVK7aCCJ9q6blW7T1l5T2cet9wVy
 lyjku9S2i2XUDJFlDe_HAyOd_Ao5ctwTyZBLKjWIFAFGoQDcaeaSf71GTux5cnHSh37kKZMLwoff
 2IoAU_1CrQAOwp5goUpglKhsPJsPLJg7cNl09R7bM6boc5IVeeJxOsrePVHqQ72L5LGpCOIrV579
 jHjc8GtEAOnoX6pVRFy.2S0GPCMthH13FGXBosjvDduHTblATI9Z7B_TrwmD_pmWFO3HZBVkbNix
 sHOroESvsyWuy27dzUqLcMDsagKjWyezviJ0Uj63TujZOu5xBfAbp_B6yMOvQ3LxOgGTIOWcU7qj
 iJdKcVWtRO0DwpExRYryKoWAzGGY7j6hokp1MgiNbMtdvenSGQlMBjzUJ22uRpB1lcB.8gE9yLNi
 kpEafyMyFcdRiWU.DOYYTIF_rv.7.LG7o48SRSImVtZR_sy_H7ksCccW09fTwaPLo9qYEXdJ79Kd
 5uqQPLX77.JNRhX_ilxVDoUt9NP5F2aA1VCQGjhbrHwz2B7.db2gSEijCH1DC1D0VMUvWx9m9mH4
 SIzQy9Ldn2lodcRAMHfJoL1reHEc4QDmmsEY8rZiD3uiw2p1G7YqZp7iYI.Wie1avrl5M_5gOw4u
 Ak01Jc.MtkCUrkIORihCb9.7sCDd5LchgZ7kF4pnPr4t9NjqCtDVF9I3oXB.uAfieAORpggVjY6p
 skpaxrkV4BX9RdFbLyaFmrLKXYY3ohGc0f9FAt.swt7NRjZ51LIa4hz1XIwmO0rzJKdSdmzwPgN_
 U6eY8opyBjrACjtEarU5pw5H3qpB2qhGJft4.9wPTDr31JTk6mN1myig9omEE.nxHuAEOMK3f1fn
 Du0J7qJPHSvMwQk9SqcRIKETVdXPd_5QoNxvHe42g3GKmzZybC_N1FqM_yYXw_ouua4LA4Z0239I
 aqFhFURGeYW2CRIfBhtwy.orYqI0TJmPFGMFUMPYBe4EgFi0UkudwxW1xnaNztOAxDlap83u.g4L
 sgfTVnDnqDyNNghcHZptSjUx7AzDabd_V.SXV0BXMXCp81FObY6eB9tI3wUip69Su_AFyJcS0Iy9
 cQ0Jbxd0bvmQnxuheplNepZ3CA29ui5.9qcZ2TwFsED1j1jMHIdZ9rPMyICjMqpGCGZ82R_TPDQH
 Xjy2SXrtS6QX6H.s.WZ0pEJ9VkDTFhPJMzCl.XbFMxUqTl5uUy5oPAi3.pl6Ev.T3fcLoLYZRIuE
 47C5IvPIgb3fmS4umMbNuHtslvfgjGLUtBhI2SdmPWWKEaIU2fVy6kWTSCD.NDMpqSfDaglWHg1L
 .uESdowcWyeCbPSES5bSGKYhT4u.6mkYtJ21PDy0oMd5kQWffF1BN_jFoyRnUKSsaX3zuhOQV3xH
 EKBYSXOanybOTsWnOtTFQRBtP.E0bAfQBKqWHcT6lYcFmc_TGs4LpePnw7fJJhv.xhXaK3ZklwYg
 AatFRStJb3eTlB3R_FDcNt.jebskjbkY_bvAvyh7B3wN5CJP.X8E1Aq6RZmJFsLksIRrETIR6hFY
 hOqE93N8HJMQwFBztHnlTdGz483coTJbnpAUktyHTrF1yZamGJmxvhkQxGiQs06m_nPiynvnRE.0
 oYKI5KChkXQMwIYaq8_BOcmeqYcedsXfo_bnh9OEKgLiVvllZT.UT7nGKj..2s6Zf8J9lzCI2P2z
 xEyfApc3C9ald.myWuBBerBjUjeYfd3KYfFARQ16SfqyJ37b84LL1vRKhJGwe0JlJzXQYlQBfsdC
 haWP6ot84iM1kXP9Qvf.mvj6dVDMMYdyis8gTHN5SdgHvR.7GrZZba0pZghilMdNEuebzi.kZgNJ
 WkBPOWxoYudwK6Jy_ylM2SLMS5oCLau9QaKsRCPK0LA--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ne1.yahoo.com with HTTP; Tue, 14 Dec 2021 00:11:37 +0000
Received: by kubenode509.mail-prod1.omega.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 9e450a556259a79ffdde5f51166f9c6d;
          Tue, 14 Dec 2021 00:11:33 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v31 28/28] AppArmor: Remove the exclusive flag
Date:   Mon, 13 Dec 2021 15:40:34 -0800
Message-Id: <20211213234034.111891-29-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211213234034.111891-1-casey@schaufler-ca.com>
References: <20211213234034.111891-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index 28ed41a3ffcf..816145276c74 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -1138,22 +1138,6 @@ static int apparmor_socket_getpeersec_stream(struct socket *sock,
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
@@ -1257,8 +1241,6 @@ static struct security_hook_list apparmor_hooks[] __lsm_ro_after_init = {
 #endif
 	LSM_HOOK_INIT(socket_getpeersec_stream,
 		      apparmor_socket_getpeersec_stream),
-	LSM_HOOK_INIT(socket_getpeersec_dgram,
-		      apparmor_socket_getpeersec_dgram),
 	LSM_HOOK_INIT(sock_graft, apparmor_sock_graft),
 #ifdef CONFIG_NETWORK_SECMARK
 	LSM_HOOK_INIT(inet_conn_request, apparmor_inet_conn_request),
@@ -1912,7 +1894,7 @@ static int __init apparmor_init(void)
 
 DEFINE_LSM(apparmor) = {
 	.name = "apparmor",
-	.flags = LSM_FLAG_LEGACY_MAJOR | LSM_FLAG_EXCLUSIVE,
+	.flags = LSM_FLAG_LEGACY_MAJOR,
 	.enabled = &apparmor_enabled,
 	.blobs = &apparmor_blob_sizes,
 	.init = apparmor_init,
-- 
2.31.1

