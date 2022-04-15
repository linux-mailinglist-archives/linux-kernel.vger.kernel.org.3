Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD5E05030EE
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 01:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356019AbiDOVfo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 17:35:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355444AbiDOVfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 17:35:30 -0400
Received: from sonic313-15.consmr.mail.ne1.yahoo.com (sonic313-15.consmr.mail.ne1.yahoo.com [66.163.185.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D0EDAC07A
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 14:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1650058380; bh=69UohOF3eRTLQZh2FjF33Zrm4UgU6zPehXD/dlT5I2I=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=dFH1T+R7io9BnJ6wnYAdnrlx4GJ5f/JlODGd7gQwfdHtCGuG45umyM3Zvg9oUFyK5Ib2bhXru5B1Kv8FmjrxFbZZJflqPbvn47c+bhsCbjcsaRhEpgKPZOJkQm0QOo0DHwgRs3qLwsF+Jo9OOyQiX838ihqd7jL820Q4ZOtHGTRk/HbfUtmCMv+OGvsgV4p9nwhYsQJylgZa0wBZiEiyDe5iWXjpqbo2QfYTWSY36Q34vlzO8qoMAlzasgnVflhAsUd5WeeqdBndjYBZZGDKBvD8qyRD9zAvy0566RPHXUJ7W1ZJrSBLWLG9TvL90Y8rj5DaI+aw/sM53Dkpr4Ls2Q==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1650058380; bh=F2aAwfYlp0Jc+hhPV8Os7LpIXKbbebqom/S3aDa2oz5=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=VILz5Yfr2bsr9iKPacBBcKe2xIKDDv1hqYNUv3l8WdTihZSDyeBL2Id0nJk77oY7gZuB7k2PXrm9cGHyuivflI3QklPFATZlxXPVO2w54aTgxvnP/QR4hO4dkWadCEJM4K4KGo4YSubDj/pzanjGlbU5F4XJN7DdxOHadwnEiPvFWcxbXu6MMgyVB4/jILFXYq0czd4YfiAPgUJk8M+aLDB0V+ouhz7qlNt9phUYelv4l44UzSqiRqZ6568V3F6coXkvvfqPhBD4JH2rgbbluZqiRE8JcJDlp2UAYsmB7UrPQHyBJrF1+DiNxsrBbtxtiIasOFNoRkCyiD6qXj+Lyw==
X-YMail-OSG: m1kjiNYVM1kxbDnk_TUK.C7nnu0XVXxbguNCrBvZdqrPAsMXGIjRqFGPnX9DtMV
 gqd0zkUjvA9OUmiFFFajbcNic6EgR.5zkIEFmGAWQXXV8XT5eMbI1TfEDAuY.CXia.On9juYSMP8
 CDXTtF6nzjzFr0P_m.t1Vwxz_a9lfFXC08oyJHmtImNV5y82Tu0Bl8OEblFaziLq5nd6FHOmfq1p
 KZqITUbZQMHh_zgXkARCkhr_nyJftetq2B2CBqxHMwNpsjFr6lsL_90No2mc77gN9l_D5EZ_YgIJ
 aq4u3jJ_jW8fg1v.RgHkEkRTH3Gb69sa156KA.oQm0G1mUT1FDfhxDjoLRkFQ3KEYBDjMh2GQvmb
 FCaDkoJkhP9fwNJbwMnJ8Cq9oDmZZoflm5ns9RxUwTyJzKf.lBkf2GMWP1ByXAD.GUsrXki4vkbJ
 j8QBqTkrl4i0wG3xX7Q4YxpIzi9.qKgPXooK21tLBCYd9KP9xwJmFHjhAfiZos2N5c3wiwY8APn6
 o_wys4rNyG82n.PDur11pc1j6_eZpfARpSLpitBdYA8FaryEPRa9rUiO8MmCoHs1ax0w6n2E5wM8
 NoxBWr4I6PEsKcW81BsMbkIHMwkXAnseVt2RnEgQQV_scShI1MNekDfp75ytfkPxLGduZoLVJBQj
 tgbghPQJFwPm85eLvVTLczqnifBCpYzeLrrxYdaByw3BR8Hz1sHqyPfq6g7v.KJ.A1agoVO4E7GR
 sOU.ebN6Qyc3s9zi4VAIBaD.GXV_y0NSJGkt4AQYMaaawCbrV_LlyokG8cEw960raHi1YR.4GXyA
 filWsg5cbWYijyy6sO3FXG9JQaVxsiag8O968XU5Sce_A7Qj5poEaNBCeQ44swI7erZWR8SEz_Ev
 kFNcroqc21NtErq5hMkPBVlkFkN7pTqGXTKe7LPqrCjZSzYwllT5k2JsNxiENhMvJ73tktFo16nw
 P8xcMeTRhejmQASdjLmidmAU94HSCm6FKNeud53VPOkMzMKU3HyjTkbUHs_HZDjlIoxmZeXtSagm
 payT3WzQxgH40m02o1t2OeQapGk58wvpkhA74Xma8eqXKSpddRN5wQ98fPrVFWwvC7LWGjjcotxS
 Vke94.DCYCUuwgSAUkF6L1QhyfZNg0.T_XJ9jilKiG30xPuRSiYSW9em272gjw2dt2FMze65tcQ0
 YxOAVisC7ch4lkjwYAaCKVuEI_d2Su.OzvYGpoXARppXDhtioy8yfqn0mFmdOr3b.u4hzHqu5Hsg
 4DlJCauGCY7tW6yGDMv8fmy2eJvL.44Ej2ETnPL6N8fkv3J2ZeosFdoYkDVtnMKjK_WaNytBxrFA
 wA6L3omSBrdTrGmWBrYhEJYyglpD6kf5dxcLBdOqK6OH5blirTDyCUFG14KHi84AeBXPTH3qBo4J
 msuddKxBggOOWTOruL5P8h_W4Yd3kntqNnKS3qx2CY2JCF66iypux98o5GqzwLUfGpWGRhDsVW9W
 1D55eYFyBuGgzlgOKbioGnXiV2uZ4Gz5Q_AkyS2b5gJXnhmCn8RhbwPOElkNVAmVB1SLx_Nsdi1i
 SfAk98_QN2SmOQr4Qj_NINsV2_NMhIE1tFpQ9NPJ4KndfSXHiStvkreKLEZrq2LPX4ZrHpECoUQt
 eBTZYTVOdtLAv4fBVo6xyX1cedzxbTNHhFyUqIyFrNOM1Xzn96tM_kPo231xpyeZ5v8tdlZCgS3.
 13LoJw.Gv6S15CfiARHYoYvVASoBQikHslEzc6zY7VKhlxcvCcDRsJssOiqo7bdorrGDfxYMwysh
 7dyBd7VbyAYbqN11LiDjF7W0vPXOnkALQrmAJAyDHu6C.rdc4jjLSmoR78lzuAm8p3bdv5mzOhYf
 fBE8JfyPmkpJrrDt5XoFk5pzuzQfLb7X6CHf5SnO3U72r0441OIPbVhWTD2C5bMj8rKLASgLkURY
 svPuSLFUBSgS59Rke86OYF9uF58R3bCTkerCSV_U7nsKo0Ab56WEvTd4omsVVqAUCunC6w2pnxPl
 cUmHQg.tUTGapmyphIBnr5_tlHkKKX7Amhb4E1SkhwsmClXjhGIyI2rKdI.YYuj.tBAJyES2o8Dw
 endR5duijz_T2KAUfDimDNV87EIlBZ5FHwYfOZ2thubOa04TJOeLg7QKNV1jiueoMFW4n5G2odrN
 v6w9ppewRkEFhmFQujuT9IThviq2yzQPbLeOi1lfolgfB3IohFoQfzU1ewzzzVoH8vl55x.LMf1H
 LZYPYq2MDDBgHo.viG_qtPJ6cJPkMzG0DswBeXSMFsg7kfVzLW7Nfa9uB50ZLch61F6PO8NXE8Sy
 TOEo-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Fri, 15 Apr 2022 21:33:00 +0000
Received: by hermes--canary-production-ne1-c7c4f6977-hpxwv (VZM Hermes SMTP Server) with ESMTPA ID b492b8f8d9f0e2ffe991666b37d07d11;
          Fri, 15 Apr 2022 21:32:57 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH v34 29/29] AppArmor: Remove the exclusive flag
Date:   Fri, 15 Apr 2022 14:18:01 -0700
Message-Id: <20220415211801.12667-30-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220415211801.12667-1-casey@schaufler-ca.com>
References: <20220415211801.12667-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
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

