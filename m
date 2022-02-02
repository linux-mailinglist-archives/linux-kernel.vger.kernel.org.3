Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2DDF4A7CD2
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 01:25:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348524AbiBCAZM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 19:25:12 -0500
Received: from sonic314-27.consmr.mail.ne1.yahoo.com ([66.163.189.153]:35860
        "EHLO sonic314-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239246AbiBCAZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 19:25:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1643847910; bh=ufFIfi+QJcABRY0VK+r+pIW1TjiSDfvy9tEFxMIQ5C8=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=R1mNa/Q794DYHK1XLg7zJ2HI+IeCme00pxQd7Ph6esvURqteiWhfOBYxwkMcotb7GtyMBiqsbovEbnfsiIO+aCNKhZUhmeYMnC/NSIBX3aOjnDe90jmSzdkamlwSuLRJfiIdVDieQYSdiDRtP50fAJ4MJTYNv8VMPigU125huGTJQgvh5nmbhW75o1A+Fs/M/0ilnSxvXrOSaxUnaCydDFObmTFrjvi+Z8SZ3M9ibH2YfIEYIJzA1z7bxnYoX0UtTaownHWh7w5nFL6CqwHrIIcNQT2wfF08Jj5WDSoQklMw+mM0PQSKO4n+w8l63SO7Ae741aF0YYRblA7aJMu4ig==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1643847910; bh=G5s4dn6DjGEuEutRnfaG5pRwh0unvfXgWtdEkUsCoo+=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=CPE8465Ta6XXIKGEV6XkJY9QXXaBxHynJKey0EF8WPuiD8wbzblHBL9nUjA7p7IkphGJWT4kiw4iTk/XhH47Vz5eVIFR0CKSbCvKZjJXXTSk3agK7olinzhU4zN3PnrfCXR+31JsSYQzplZwVupsib56CECSSXAx38ciIm7mh3YUI8h4PMJkx7/+xXIbhuINe0gh5gGKLSsaTAveOsJFSEE3ob93+1MU7fJlVWinyVbRyfd7fc993QCg3dbGOF0gPxXFKL8xSre4UyqIetfNQSn3oL5f6+H2E9OE6UoDlujjPC+ESPoFSMUbGsXHgi9YW2mGYwpWTRpV09G59q3ikQ==
X-YMail-OSG: o9wezOAVM1mW_P0992CxGmY8y0GRsMMhQW05q7rvPao01lyxy13HDe25lOCY2fn
 2qjELBW0htYWCqvVU_KrDkhhFDvu5zQR1hroeqDRikq0fqreVOcns0na7PMEvJ05pJ6jEmVeyTSG
 ArdWj3GdEPm2XXQM_9fTjkNigD5GLxFrYJ0Wzl6.geLJEmZdHa8khsKe15So9K_76x.VnslGJqRy
 7aa143aYwdWWhcWy0CW1RWDRNUR7uXqO3kcjk1HMIwOXR_cg9R9PakbIsr3yLubl1uPan5KMMjfX
 o1.dTO237IkBvH1X_QlqIIxC8CsXW5fsR07jDv1P5zdUa7mK0uXXOz84Gs4NSF6jcXHcTJTit4rV
 YH.7DeJqfUs3WompJtU6iQ.YhC5pdvV0K9KJwEAyoXqIxXGRVcY3zrQVzPM3mYdkPQwrSizJg9Oe
 gBeCKcu3WFGcSmQYLlAYhKj4Yixo86RMjIX4OsmCN.gcR4tSwdm6oQnNq7Zwip705JSt8rc3Dv4x
 3oLEzyWq50EieviGDh.xLw__RPA2WEatnXT2AvsqtMRe59Nx2pQW7REt9EOrvvOLsKZT5JatCwIS
 ADrwKPXUWy1kIrQ3pzcRSb7SN954ne8odDJSt8swhgpm8L0_pkQexGoXYoTLCBMpZc4cdJrQyO4y
 VRitT9Xn1FvAHiTPwxQd_PV1tZahPQLBvGPmo4Ec1Usyon8fLqxByQaPaJfpbCMnvH8k5MAS1z9g
 bvJr4k0HcSNHFm5wNjtfd4NDbpsEQua4eA0lgJnqTRZybGFjKhRJFbV_Zqfsj2lpuSowRDlCrqSB
 6Cr7hmH4ext.z0rz7pONmFA5Yw2rjkJwBQYhQiCvj0tVT2pIKhrfc8TeBhwaCNy.f6oOC5bgtjEC
 bJjbk5S_3JgC5RgedtWdqbfMtb0E5mQmINaYDdk0m8CYmOkGNuB1miAJdpEr8r5fiwAc7i5dvx5M
 iqAqFkZRrjGQG0A.ikJEUsaZ0VCfOjLpsUaLXQcI_14cOmgXX_Avpnzg8NDkK_VaInHE4CmXRS3S
 RQELHS9cC7qTC5t9OH8ZrOrgRlwgXmXyHb9pMIBnaCFE04h4l.VEKpUMasnxl59U.S9ys6Zz0uMe
 4ZzIH_y3A217.eFqNIFOInmvpZ2jVbxqwnRAXKSNdMoAfxxUUKNxE3Yo2ATJBAZzuHrvKhI.YL_k
 C9YxOQkrVsCgdvyHolcT0jBLn6N0IAMwEjWFeneRneFM6NDH_Esvr.y0SUyPaokxZNtRr5.mQ9dX
 lu4gHeIq8OEVktRuziHDe7.tt_ysvHmBv9kzWesZdK8HPBh7G4p9wfnu699Z7cnHlxA_Pd50e7gD
 AIjl4ei3FM9uc1BAcjku1dbXIQHcVtyJCn21uj4KQg_KhxqJd0oEgwz0tpF_emt4PI_OdOpa6.V1
 3uHqqtuWExTo_gScuMyMvwf6My_4PsPxj3dCn5nW0HE0og.GnKjaSPCMp0JcPsIv7LBePYz2uAa8
 RSQ.QQA0es32rv2G38YPBL32VDO31Ev9LhJmfCk4q4e8g98m3wPaCJL4cGNtOU_ERhEV_OOAXFQB
 kH7bb7Q8angi61Kpm34AJyNVp12S0rpdyoWKUpzhANrNs256dzepPcs2ZaKtb6HassBefqKiJu9m
 8wlu.rY24k6jndpnlz8UY_T1iYGmw23y1IW94GrDnAFCP.E5V9ofXctLqL8kXY9YF33nGdFyowMJ
 1Di3kL5Ve1iQsbQsMiZaOj7gZ2kDnV3VzlgDukBYHdnenWnC1uSFPVDfyoXcC1pBWFLbjLeQO3jI
 7.hCMdsGo4NpQeHqA0fL0mLl.NxkkscoA7CjoRp8cq49qBL41ePgXVFDJdMQ0xFG8MbQJNqFF6.J
 v0lRERFA.3Sths7vGHcW1TIShtWYHrsQvU.8dZJ9RB_1orfrXfr3sPHcpl2DbTPriWrlt_1KYkV9
 1RdT4eGULU80634Wvy9R8sTTDYsA2ARSwy7VjTUMEfS3vanmg1OyTBThJfu9WFU1hze72RrsXYY_
 LiFVtPCiyNEh9KUy6rYMXjGo4.vh3hzmHoHXzhTzyh1kIzCggU6Hw198kdEXnFuZnd6rhyAY6qQ8
 DSDnh0oXk5NNKF3hVkaKKbWLLkO0FAn1WSG9jpv6poJwGcuqRp8cENNKIW.TAB4GGUBunFP8njZG
 Niqg_qtxTp7XMHbfDqusFmKevmqDzzcFPSxPzoJoTFWw24btCx805qOA20WcdfzMHhFdHqo6fibq
 RTfDKG9emF2xkvPpqvHjoqOYAyR6dmtmuWRzwVmHafSSV7Hy_jFw-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.ne1.yahoo.com with HTTP; Thu, 3 Feb 2022 00:25:10 +0000
Received: by kubenode526.mail-prod1.omega.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID eabcb31384f559dd1421d5f3a1b09447;
          Thu, 03 Feb 2022 00:25:10 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v32 28/28] AppArmor: Remove the exclusive flag
Date:   Wed,  2 Feb 2022 15:53:23 -0800
Message-Id: <20220202235323.23929-29-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220202235323.23929-1-casey@schaufler-ca.com>
References: <20220202235323.23929-1-casey@schaufler-ca.com>
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

