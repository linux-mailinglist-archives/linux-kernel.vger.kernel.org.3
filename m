Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FE984F89BD
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 00:15:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231781AbiDGVjt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 17:39:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231741AbiDGVjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 17:39:46 -0400
Received: from sonic317-39.consmr.mail.ne1.yahoo.com (sonic317-39.consmr.mail.ne1.yahoo.com [66.163.184.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 983A41CB178
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 14:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1649367454; bh=69UohOF3eRTLQZh2FjF33Zrm4UgU6zPehXD/dlT5I2I=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=De7XTiJZkIxTZzigAjW+ka1WASpJP973Nox6K8EGIe6EUpPw/xYxpCpwxO8eW862Aok6l5fahJuls+B6HB0C/UDGrvdkaeOUYAbGCee+Js5eGNLOwuNiTvjLRTGUrOfK1vZiWcCYOvVY5HI6hXmqWQwZEPqrU3BFI6gun4lIIUhgjJ54h/j0ZsZdVSGW0e9U8xBoCVmDKmDqFxGOgG+8S4zoJ+1HI9PI0LHCmwIr8gUXRgUscr78lGfCiuTBTXHX1lAhzQdAGsgEaIelRDWB2xLu+Phwc1sUgcEbqxGvYoNrqA246ExYhDb0EhM7hQ2wzVlJK00hYOABANF2Icd0LA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1649367454; bh=b0NA1XgVGsKqfwBDIhQmxawXIlMscJzpQUkOuRUCtUt=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=Fp0wmY6rNNqXSL5ml9sjxJtsN/rSr96TyMjEnVgdUs/sUyuzp0PZct5pKH4iUiU7RSiGYbwg5S+UTWfPdj2HlRe+B9TH+NzYO3yHO7cNcQ+CLgcqDSycT/4TqrQGzcvPUqgW7MR1QrovCR6+kqpiD7BStJ6QIA6eHN+EPfoD1Q8xHC5Uyghgbj7wfgei+LqDUM2XVQymWdOMuvDsW9e3t47TeeRRUEAOvn+VlqgjaELYGuvWCeUC418PCeOocQm27DN83BDt6bh1t8XdK+SGiuQtHkEwJj2nsOZcHO0Om4FUql/PxeRiRxPKgGbUIiKBzfMFFEVbyIUivYUoqyP2Wg==
X-YMail-OSG: C9.BRM8VM1mJU1kEoPJSwQ6K5p80klnCh0HT9Aks_VlRgdFMi6r.SznV54wmqPK
 xTcWBHZHfLTjGdCOF5RP55OObCcbujzr5.YPvF3IQiWHmp2hugN7BzadwowIrtt18hKs7HTjmO1q
 TgyjMz1W3q6tPamCNernOUQjOY_YZl5zOsvOncPebFS2z_4cJ95Ee3X4RJqe1WCp.PDLYp6Y76OD
 lnrmizM53yuCR8hVvOh0rxqnD7W.LBaP9rJWC.gMjY1T8JwzQP7wHbOQd7SHibKfdYNzMds8StA7
 Yq2MVkfomsy8.9IRDAg_gVTTGGr.ocl0vYBm53qBgFqOVbsUZ2WafaCJAoM_4F9NzDzhOQzxzj_U
 _Bw9eQ1FcU.CB8RUI_skGxMuthZOiOABOuiT3DsxRqAialWDZHbARBFzx3nd_WrBDdka_8QoYfrF
 1sEvLcDGgVp7hdXCI4sCoCj4ageRf.pDmI.vaMHffuc48V_UTz_3UiAeAXbf5ZAdJvX5Ba2qpICq
 cQSffXB5j9sVM6CmBXvtdXADKr2CBOccs4_wDDkZfHDJfSzTN1RSR4G7X88BzsBNbsVqxvxB5VXd
 yF3T5ka7VvkyqOyvHXZfF7k7e9uzsW902YaIyAar_9Wg.6YURjKIOMkkaSr7beGV2hAyZYxjiKk4
 IaCYDDKgmQchqtLmT0K4WPyynDVb7ZW3lSAgYIp8s.LIMLUht13rzpNRYbMtHX1L0Pmk_PhxCXKk
 a2EAeUDLDnUlphOZrcEOLkT1odkYyQGAgvv5DjbglU6m42hLfDCq2rGegDcasfpvPgt3vU0Q1O3M
 FD86__0XwMHFOlWJLcfVDA3W2NEBQsjIRoWNtUqB9iGlAhWjzcQmCS_WSn2vfXq6imGjyteHOD9G
 oTMRcAP3rpUeAeNn.rn3LtuHie_9v0uloZGhIUAU6S3XHeRl_JovoIbsuQOJGYFeUOYgXJ2S0asW
 tU2LJvgOBhAwY7sReV4Cq3DrvciWjFPUBa3Ee.fEcofIGtFT412sNXpfwHzFsIDjFLM8X5eUAjC.
 KzQkOozUiN39uccCZtPTg_V4.SECaBK4OuHC6A9vJ2PqE8jUbhJM6e4uxXKM1SvghP5J5a07q6LQ
 b7orgxJerP3oaGYgwhUiRFm2CieMUwVGmzaOcxSWNy.jFkUy3xaIAvYCxnL1ZhEut3ZcyfuARAbR
 oLDgTot2wvb_HaBaTIVt0_u6lEcOOI3_CAqvVA_nXUgMVciWkJp91Vo3nq1rJtO3Sxg32mLMS8y1
 bJkTHVUYWKGcZ_FbG9BNJHeY8ETWDJ8yQewiM7QpVbQLUxDfk1DPLiS4q3Y47BllsRx1DubMmuOd
 Gw2cOXC7pKflad3vo_HS_saFldIF6FduH3qHqpJ7NTkN3Ha8oMEyLH6CcFy4JyTGzaE86Gh28w.T
 5JDbOVGFzT4EurqzeMAjMok5wPIYNEf3oUSZbQvnlzYD8SOyP.dI_tOA7XptJGx62GgUXCsvGAk_
 D1XaCQNy1Lti4EXuWJiwRn_pdd01tbXWgIpb8.CGytZoe.IM3z5VgDUcHpuKnfSr4J5GHpyqqRt1
 4qtg5m54TRBpUwDrZlB3cTwWBO6y1EdSHzWtEPXA7Fy7Vf2DMh4V48iMh2OSA.jXRY8m4ILRdlvn
 VdLKjQXJMKP2VaqP3YfR4oWP5J3zCfW85V1ntx1GiW5bw9RU2jbraSzUhVcXDt6i4t0ipreoEUN1
 a.XqvP1T.k5OMGa37oVxeAm96J0Fxo8bIAcak93XEm8bWhnE1JKsN6DcW4Yvsijw7sVLqxLpaRKE
 agSA5FWeauk2ZpY0aHwV0l8BJjaEMpzYTFpIM_hzUdeoQvvWs8Z6zrJRAZKz6omyPH3PwdbqkNch
 iYAquxihTkOY9w_2HrbeCpp1qK1y_gZ4ORel4AYxHu151ykbgyFmd3XudQVV1UnJgL3T_ZuBzL_m
 LkLkUQasVIIL4GSQgrUz.pidg1jFIoatBIgFXO0mThE3CycMAqo0k0Bt5ixpNryPBDYXPh9J7_oW
 gYcTVC19WHp3JA16q4vvVWAr87QfpRHEM.i4FvFH7wjie4kUqC0eDASJlxhpvHk.X7.j4argLmfC
 4dY6y2gVIZa9jGZqpPYA66CqwJdoFcPX0TcispnCv5fSK1px.Xlx5FHpbZX8ywK9wjRv0qtl6aHe
 U6Ur1aUnG4AVil2w5RQiR1KnuptxkK16zIdH3ke_cVB1ZGAqvpjgnx6UXLCufurkEUglgZY_CG1h
 bNsYnY077MVaw5GFfeA10.fZo1LqVdrbSRP7qhFpPxsAsmuyeIbcVYfLU8g--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Thu, 7 Apr 2022 21:37:34 +0000
Received: by hermes--canary-production-bf1-665cdb9985-tmblj (VZM Hermes SMTP Server) with ESMTPA ID a865fb4ad0018b13f62bbe44bfe50d3b;
          Thu, 07 Apr 2022 21:37:31 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH v34 29/29] AppArmor: Remove the exclusive flag
Date:   Thu,  7 Apr 2022 14:22:30 -0700
Message-Id: <20220407212230.12893-30-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220407212230.12893-1-casey@schaufler-ca.com>
References: <20220407212230.12893-1-casey@schaufler-ca.com>
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

