Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C65194BB0CD
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 05:37:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbiBREhf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 23:37:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbiBREhc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 23:37:32 -0500
Received: from sonic301-30.consmr.mail.ne1.yahoo.com (sonic301-30.consmr.mail.ne1.yahoo.com [66.163.184.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 033652CC84
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 20:37:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1645159035; bh=sq5a4qdWbjU1/KzArFpEWfOPpCNEvaRb1x9G1u9L7jo=; h=Date:From:To:Cc:Subject:References:From:Subject:Reply-To; b=lMeULXNGSJ6a4cP6zjur8NgKgfrZsseaVDi0PgHBGfG4FyedkHU6LDG/kW7SKGUJcwpROxd8tscvAaYPfFz/qqgxWK9cFrnfwRh6nwLaTGk6UNgLBQmlU212R7wl9pNKCotDAbNDWY31SlYd+XC5MBsp60H1DkQPaw3CNKaoscfqzYLkNCDG/XR18grtheDJ8oHKMAxyrYxwlmlmRRj1niP+s1Qobefz+UT4GykoLoHjZVrVfDijaGIIv7zqdZVGctNV/92k8P/T2c78Lwi8bK4m9+aufqeuPscpwci9aFrxfzvpf78KE9GfEk8tBvvjrjZHYcNP9xWLGIA8s4WVEQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1645159035; bh=ZqZ2xTyAWAC4T7MoC1h4OxfSeW4WU0GNsmFcSIy5WeE=; h=X-Sonic-MF:Date:From:To:Subject:From:Subject; b=BJqaWVD3YKxrQFFq0AraCBZV8IhxzI5fF6WPeonn+/c6NIGvfSDnk5BIvBuakAnU9mE4alWUc//GPB2MsMDalQLkd1UHi95VNLTP3HjN/pUEHL3ACOukXk41oyXUlBhJopOyaO7ICE4EJ0v++pOoZkGqBw/QU01OWKt2AEbLp11xBNFtYhGb5CH4O72rWkm8PKqLvQSFE5Z2GxuVW9W2A70NNg5hK+ucHVLfJh2nYBDV7PkbejqFNHiT2waCGY2f6Dds0yxviSCZ/QyLIp7s89r3Qg+jwJlFFSdI69780otk+gGdYJZPwTMo9P69H+YimhMIs2U6DnopmR78CNUkzQ==
X-YMail-OSG: v3QVpCQVM1mG1uhLMz.HGTU4Z09Mwz2gOk4SBy8IvbCVN9aXVmNpsPNFa3fagac
 mp7GO0502rMZ99e78Wn_J46wNWtYLhN_Zu9je3QeuKu3CNs8hWMXST.Zr97AFDUUkY3mUiVoW2ms
 1RVSCvHHlPnSUYmb7OFoDx8JCijEWfWOO2vzE4DPXnN7kJPY59014tX_TicXJFdXgfPcQu2niDNt
 M_cmZ0zcvHpk0sY7gGrrq.z_csVHQPcQjQ6eJr5oPPoZWkXFzKalLAOJtHc1D2MaH.F4rKyOabaY
 IioCP4pjMC7SPFJlp3WuYEcpyb3gTxQNXlIKxQS4s8kPZiYORtA1aNKrl4Azv.KgPdNYng_Xoffl
 6ZzyEvci6UG21f9QrWa0z9wPnHeoGOcnUL7h5sysPHjVKpBlz6C1ZtJy4ZCwmaBdphLOMXsPcCJ0
 W9rJ6OtsS28NiKbLbU1qTdE2mEl4n8dkCPipoDgfwiT7quEq43E_0bc2xkUgDKYQg_bh1hb4dHyB
 .oQ7V9.d5Sph4AXTCuu.imX.L7igIq29TMmgav3GwM1l9WiK6wfWq2zJhwtk3OZlJsldAtfgTxLE
 jPXjYfoMeH5ZTN4YjZwCQlabzqHGKwf0EF6PTQpPmPmpdIxU8oRBw2myzw8mcGM6t6UziP7Gp5si
 LBvnOIzoPM0oa5EqurG7dX7tiVRR2z8sARgsR75Rs2IHzXhaEEfa1iEoCbrSc1n5P8ALFrUrVgUL
 QPA.TchVQJxkawwx5RDQ5Yxncop91f3.F7R_IfE1hn2Gm3wiQTeD9hgz8Iz6JVGF_InPPX0ywjUF
 Vp8Z9pTcEP_W2N1QgRanukPSYkJY7A8YPewvK_j_QZFkCBbWC3APChJOCY_3GnJECpZsDGr10KIu
 4VZtQ6kxlViV6ssYMeSgpuFaoPMugiZibKUV3WIamUgT8NYhoiCzdYlh_WAQSj6IlQfASmlR4qX2
 v_Yy0nVvauyl9GLXG3SmjLKYacVsO78tq88KRNGqs4TS0s5hMMPuJ6xwCYyczBr9NkMtTPFmTbK6
 xbNCVf0BsEIZkNsBiaCtEvW9YLusd_XE7LAI6aRHx7GR28Jl_lKIHGMHPOBkhV.azQ2_Ikzt6Y8E
 Vr6.M2nSCieW03SJwYQdLQzb10cFTtAFFWTd638G3vLSBeqxmtvGibujXFLB7GmvftuXIjhR6Dvi
 29zCih5Hf9VbkDPF9FKcLMT1eu_n2bl7hJxQq6v_8MrJ3TYr1gZK_RcBSDG5G5oTqf0en.4AuW1u
 Nxcj6WIxWMigQvWr8og99fDVa82rRlrnNDnpmk5S9Vs8UkDONWjfR_Nhm3CieeScOTK7BcQgW8sl
 mcyBdfyFJPHJnSGHyUaB1oWR2ZNCs.PUAbX5eNAfAsZt9pdBqQXtoebTL2m_PXqyZr3rcdMiuWpS
 IbCT32cpy5GaA16_k1vUrAw5.6AC04OelLQzt2Mx8UvAC0PdVOvjTKD.fw2M_l95kVIoFNwZA6VC
 TxJOc8cfjZbLowDvhgWiO4xj1F3zWMTbiXu71QQs3zL6QoR9r1w7Vv9OA8ccfgvarX3elGJjFJEK
 q_jwOYbQZvMXuYTzGPetPr.vxUU3lKkwb_fMPA6UyfgMQaBvm50W8Tc4nVFHcvVSww72sSiwXaO.
 J8CEFCESynQYZxs2XxHeqidSCpu8OigAt5SXqLSLwz41wnbWgknwSasO3fQUz0u1Vy7CvzdyjvYl
 q9AG6Aw3_hbswFrAzIw94bmrk827DQkpe0ToVbMgr3xItWh3k8UO9l..dOnpxNMzLnv03_JOPom0
 Rg5I7adg7bnL8mCH2DqqKHBym_Eom0mzP92lRfYYUq0wUiGmwWa16pFzFtI_UeqOM8ELLgWrWYh4
 R_D6LEGRb2RJL_KD5fhcIBv39DXcd4WVfEalHr3Dr8Jl1Bi.rksQpUmvW.4XSAxSr5IbkQm7MMSg
 x9uUqhdjffkGz3PvP92M3wK6sQ6sBw1ANh.ldh5iUAofziGkBki6JOzCMUh5g.7Z5z8k4_KaTd1f
 ji3p16415jaOJDLtF4rpCrfwTsa8mR2bGZM1vXRij4oql_zadLYYXipWPeA4EvYlSFUBd_dVYTzR
 vv0yfps7BImuJr5K7PWkwRj3w7muti.pPgKVwrky0CUqVZ5Wj.M0U7mdRYNnPJiHKwZUr6wY0UKg
 PghFwNy5NuQE0bjKOdEc1KPVnvi.w3A.4ARXp56lTqrtqUKj9RYnV2cnOURB9nrjzAPKVl.OOVkE
 teg--
X-Sonic-MF: <marcelo.as@aol.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ne1.yahoo.com with HTTP; Fri, 18 Feb 2022 04:37:15 +0000
Received: by kubenode505.mail-prod1.omega.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID b8353986cbe4cb8f8f5c96fe3d5a36a4;
          Fri, 18 Feb 2022 04:37:09 +0000 (UTC)
Date:   Fri, 18 Feb 2022 01:37:05 -0300
From:   Marcelo Aloisio da Silva <marcelo.as@aol.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: r8188eu: remove unnecessary braces in if statements
Message-ID: <20220218043705.GA23783@snoopy>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
References: <20220218043705.GA23783.ref@snoopy>
X-Mailer: WebService/1.1.19797 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.aol
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Braces are not necessary for single statement blocks.

Signed-off-by: Marcelo Aloisio da Silva <marcelo.as@aol.com>
---
 drivers/staging/r8188eu/core/rtw_mlme.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme.c b/drivers/staging/r8188eu/core/rtw_mlme.c
index 45eff3018d73..ad1d73a27548 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme.c
@@ -1379,10 +1379,8 @@ void rtw_dynamic_check_timer_handlder(struct adapter *adapter)
 	if (pregistrypriv->wifi_spec == 1) {
 		struct wifidirect_info *pwdinfo = &adapter->wdinfo;
 		if (rtw_p2p_chk_state(pwdinfo, P2P_STATE_NONE))
-		{
 			/* auto site survey */
 			rtw_auto_scan_handler(adapter);
-		}
 	}
 
 	rcu_read_lock();
@@ -1392,14 +1390,12 @@ void rtw_dynamic_check_timer_handlder(struct adapter *adapter)
 		/*  expire NAT2.5 entry */
 		nat25_db_expire(adapter);
 
-		if (adapter->pppoe_connection_in_progress > 0) {
+		if (adapter->pppoe_connection_in_progress > 0)
 			adapter->pppoe_connection_in_progress--;
-		}
 
 		/*  due to rtw_dynamic_check_timer_handlder() is called every 2 seconds */
-		if (adapter->pppoe_connection_in_progress > 0) {
+		if (adapter->pppoe_connection_in_progress > 0)
 			adapter->pppoe_connection_in_progress--;
-		}
 	}
 
 	rcu_read_unlock();
-- 
2.25.1

