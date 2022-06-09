Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F471545884
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 01:20:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234087AbiFIXT7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 19:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237914AbiFIXTw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 19:19:52 -0400
Received: from sonic304-28.consmr.mail.ne1.yahoo.com (sonic304-28.consmr.mail.ne1.yahoo.com [66.163.191.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 323374833C
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 16:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1654816790; bh=6OEHWBhN+Xf3kcIIRqn1KVWVpE9iuHUdlNhbzS5Ytzg=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=oyIZoaiMp7F4UjJR1ztRGiQ2Qs2OPHaJPbzgIfc44FwiyJKeN9/wlJjyqBGCPcdf+fhF2Oazpt26CVPSno/AZVZGN18saU5PTTcv3yprWtHCxqhP1JUl7uYoHrjbvwq+A6PYz7wdvSQtIOPi+41kvUnA5fXiqAu/6rNAhxVxkSLqWR7vHMZ5fAZlMUaqe4mcruLeaExcll6KVAVDs54qQO9axI7nnWm8pEun+1Ln5JVlxN4n6r0CK0+Qg7tm1+wbKDTB7YFMKNmPO9QKdkU0uHqIn6v6uyJ8cMgTFdXL0d2aD1J5JQLROnhcf8QD2M4hL3ArSN46wpQgIMatgvlgfA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1654816790; bh=Nv+6WX90LR6zUWYNLfCynFqbtbcic+HHa4tQKlq+7cV=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=WMqmxybe8gJAwoyYUMUKqVHAIZAQEHJMC+nKSe1FHDg2ZrhPsYe0Il0lKIX2vTtXzBHBQOIMdnpNn4tWSmNJe9+JGNa3RVvK4078E4fOEKFzYvF/Zpez/Lwc7xLUF6guPPeH4ZfApshpKYltbe4EzXTIUYs3OJs+Zr/RhOqwqIwvmuiOJlh/j4fTzkfLvSH+xGHNlx7iHtL+M5Dqll5RQlLJj1T2mVjSm0xXZzdgFTdRLkgmI8XQ+/GHHMuH3NZi5ocHpTrlWBxgUBezUGjBacILiw3QC/hc6S5ZDAj/vR8H4fEkju0MoVrAd3zbavfIwvkMCLIXn7JrSetsTw7T0Q==
X-YMail-OSG: rBtIgioVM1kkk6gmUTR90KOa0AEj3PA1t3DdjqftKZbH5MJELjXYbsNouK8KkQ8
 BX2HKIlczQ0z8nJX.3_JnOHpGNo0zTms4vJRAU5cFgB1GEAjr_cHM5dhdyUPTKAEyd4ubJBB6C5K
 Jn4wGldGxZxZZXkbRUHIo_uPAMl76aXw2OYSdh75JsidfHwWk8vtBDiRD5dAAh_DtUv0qFhT0Qmj
 owGDi4Wfq_4zANVEJUUUJ5gqD2dhqsQFqKs_AfxiF3hV0eY_4yLX6HC.GNkNtVdpoWGo6.OYmEOU
 kgg7O4RPQraTPbzHphSdwDCvgDGNRTyhp_Y2NxUBNH8gVRv98S0tCYDax4rnmjcYDLCUzqEeEB9g
 sz.MndfpRJhibnTsdg7i.vjG4gIMPr2Bfx6iSZ.hKg6mM3XxFTbsxfLXPPSKXumzEx8tzpcL8qi0
 Vk74a67Kg42tUdV8u37WZtnFskhm70djSWDt55eqpeU4pkp0DNa4AfMF67cO7gvH_IvrrYVYyu1G
 lJZ5mQxF1rBGR2ecEtviXaMwxUUcV_1W1ZUW7e0MteKmhm8SS0lzrQHGm2fVhQadCKoqobyAJc9s
 ruQvQyLYCD8QmTu8hZE7KUxum5AJKwUse5kBCHqJBvFSFpgxu4JIhD.0TpX3rG3ViubtCHj.r4iJ
 niSVcLgEikMIf9yzGdBlLjTTp0Fyo5aIcIKYnENi4ebBuz00fkpe_lNxGkfY4cqIJaoRzHNCITBk
 wZbl30puH2.Jdtjbdhzuep0ipE3ShtDHjJGPCUumOuVathnmndtgU69dPv3t0ini.GV9bE24UgvD
 NacQ5wYsDRb9AajHPCye067kz7jyJOrpNDup2Ctae.bEkw9Ms8EbFdR_FJuawDRqFClotRdbVbtA
 I0GeJV7qICaSgSPuhvj1CqTFd9ps2alORdwEXYkFiRcAMR0ueMYohWM0nWZxAXevgWe9ajFloSpJ
 TBjOR7pEYCdlBmZJRLik89gZUKBASmH95Rj.XpJDg1jWnAnuWyceqB0aDO.zyHUwSH1ranPPGx5L
 4EfLPHxxICamy8fgnZQAtSrPip0H6_uk3uZE0B4zq07XuB2P5jDx68jZMmm0qy8ymIE6ruuv00vG
 9OenoFLJSK1.iEPQqxsaNDkiRMep9ypHdJnLNFOjv533PKmhqxcRANSjvDEDYaIbjkQUm4Kvy_g5
 V7.v4bVDyQ04xAcaERws0eKs4D0PKjx_i7Rtpy7EDaAMvJe1iN_YkVMoWA8XUn4dAua0y_Qni_rA
 1cf2u6jW3c7t9xNAwQTuWjIymZUwwfa6Ow_tBIZZL4s0zDUmLaMfXsU1g.DzfO.DAa56rDfEJmgp
 N1n4i6Ydtllh7cHC.AwXcL1gPtrgltWxCKwTiwuB3D5lmJnHiId7Su9_OsBaeArRcsRjL4Yc_bTU
 .0yWOFwVnEbHBqsuNYAj6srNGjVizpsPKLhBBNwSThXwZCsXT_n_oH2OYPMCmbbnCn_W9638WWz2
 HWt5ENUWT8HDcexNbelrTdiJpJHMK_Lqmce2yCLCLLxSey_4dk0ev2pdi.U1zxU2VLqLQOmQymkc
 nAs8jyDrUF80Qp6vTDFeqA5d_UAm_64M.fWoduSazJzEvEZFDs8a_gaVkmXpjLR8THqyiZzXW7j0
 oRojvkudytBmd13VOvbiQPnUBbgT2A0.Dlw.LmMeNYUxBWcGOu.nV_QyCPYdoBHWhoOp3A.jFrGz
 WWerpyAuCFvESibbSKjnUq_PKKr.aGoRgVNb3KxDEKZYxNS6U8zvjgTztuoWnUviiXtrKlO8.Epi
 XZ4WumPflPjM1iDpFjvItnCjMc5AtAXsJdqNh8Q53jL5EGmfyiFNV_HLXy3tu7h20gvhEdhNQAaJ
 XUVZf5xcY3PlzM7eVObKwAr33xBqVMN8zdgI7HHrmmTvGdYDLy9nl4xneLaKeIev5G0uz7l6Py1d
 0TpYax9RAsGmeXQYs.yrmkv79MCPR9z2AlCJ_iysf81kDG9A7xaXnnkbmgCWAl0m55kHwmwKycjD
 F2DbTTl_mCX7apE1OgRv1xM6XMKswwbLNyI5aYVq4.X4g35KcaH7vetkE5SV0qKBtDz58CMthq1i
 .q3z_S6QKeWNEA74Eoy.PazbWaZMPpaomuixqCUR2ef.IqxOEiuCa4cVBKrKzCmgGT_.iNGcrcww
 5_hj8EqvJ39j1nEXMTXgxly9CEzu_yedO91WKDDooMgg4MJIolbfq0sMwZMt2zjsZiHyWmQGqZx3
 h88V0TOPJm1yWoo76izZ2mSlnOGd2Qra3uJU08z3ClTTHKnHT.DedaZX4qRiTci8PUpR3nbndyvP
 dOg--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ne1.yahoo.com with HTTP; Thu, 9 Jun 2022 23:19:50 +0000
Received: by hermes--canary-production-bf1-856dbf94db-29hkj (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID d4831bccd9bce2c443fd61283228c72f;
          Thu, 09 Jun 2022 23:19:48 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH v36 33/33] AppArmor: Remove the exclusive flag
Date:   Thu,  9 Jun 2022 16:01:46 -0700
Message-Id: <20220609230146.319210-34-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220609230146.319210-1-casey@schaufler-ca.com>
References: <20220609230146.319210-1-casey@schaufler-ca.com>
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
2.35.1

