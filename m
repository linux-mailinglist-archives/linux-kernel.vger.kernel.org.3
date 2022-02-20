Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 523B74BD088
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 19:19:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244365AbiBTSFG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 13:05:06 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238456AbiBTSFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 13:05:04 -0500
Received: from sonic303-22.consmr.mail.ne1.yahoo.com (sonic303-22.consmr.mail.ne1.yahoo.com [66.163.188.148])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B01F527FC
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 10:04:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1645380281; bh=kQk9EXbzrRW3Ifji/73BDGZNCWFj+2QsTUPnJDEexYY=; h=Date:From:To:Cc:Subject:References:From:Subject:Reply-To; b=dGVodEF5+eAMpwQNEcQxrCfKn1b/Ppxl9qGog5f3PI/iZLqjQl2fCk8QNOntoQCo+YxLAiVy0c1pgs7cM7znf50jzijuW7dCLukXxbjTPJxemWcXZoXtgUwiMv4V4gmpujhuU+DymgEpNze82ZnuwXq3/SuQu4xfz7VHd1kLS9H9OyDtcOA+FJ2EXuandMbikk5F61MmjuQ9WcSKZlJNbCQsSZ4kTdZPgucFx8Eex9saFX304l888ejs8DXgpUhjTeo3feAWwf5wbWg/h4yUABZhuFa1HcXz+Y5eWmnVyijd3O3PrtYfcpvDl5v3FxG0hRC6IZW5xhi6ai2mpMVUug==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1645380281; bh=jbzGlOv9+tU3ZG3IhCPab2G+KqdnPqnZienP9coskGf=; h=X-Sonic-MF:Date:From:To:Subject:From:Subject; b=fF4jfjy6QEXqvWl95tSPOTVOCWte0sPjisNtKtUniGgypTiec5WWIyvQ3FOj1+eA7Qv/43CrGgdllipU9QrrL19Siq8coFSjaR/+t5t06WGw6s6doj1yrcT8YC3hZr8zpv6j3IlMcbQT8L2dulL+SL+FjWOAJA9aLdME2+4o/jq/b2CefQY7x5WuRtANGao7dyI8/i6W9/g6d7XurVadHewIxM/1XaHTf/r3vpqz2W0KCE9rauBH1DEJgp2/rDNC2T7tk8cVAgYh7IrYToGelvXQor6pZ2zoIkfDt56Ewo+gHEXVCr7vG6vpkQEe5p69nlhkZbognWk5rJmDHwdfxw==
X-YMail-OSG: LsefwwUVM1kZ1t4heRfRTRFb8ZWUU3eCl5uDylvvoQX9DL5aNMge6EqfbySjoM5
 IOvroQLT2NWUgkKM6LoOZ9lMibIiIkZkjign6m_WZx.c7mDqohFzcnib9ApKYo5o2N30WTXpxKMT
 bZScdxCLe7r2kea9DoQN4r9D20FInak00qfiYEg6e22nM54jWAnHxamZVkN_SMO9FLYznLYaJdKn
 dl9yf7fs27ZVJEz9APtY9sA0AlrqUKSlK9kb9WQgXnxnLaZ7shfiXvx9yuGbSwD7Ic4SsN0NBoYi
 4pD.G6bGbPKIJRO6lQs4zZEOj5Dht8f9FBRukzQ8xCrU.4fN5BS6S29IvyMzjfJbGLX4WFN7q1f5
 4qmcirzIeM6PTMqTm9dAhfwAlI7sOV4sZbUTEX6Ay.NE8EmmhGnmWV9GGGlCUeOukh.3yQH1B8xf
 UK4y2D6gmylDoRIhzHGOdT4IRa.TNnAtotcyqMLDwQYroBK4fV_ISzGWRyptot7Cw7kVyb4lNzsO
 XQVae.UWceJF.40dPjvB82MHF65EZjse5x2SmwQoFO92kcVGbcpNR.tiy1EI4x0SApBH0YaPa.Hv
 aQ5BrSPTTazn5WbgvOjT1u5OrxCDzjPkGIl80Hxyc_tMIWW3YAhJKPzTKgEvPQbH_cESrCZzfJ5M
 .kz9hkEUdgRyBHpvDxkDEUFhZfJLTHb.l508l1MhkNdP4u1gUn1h8a3HkYYnEFMpP1xQe9X6Sf1t
 mjQKj3TNbMwfH4Z6daP4f_Fks2zYvqV48gBSoryJSn92yd6fkfv6_TbUJXpps3wXKdpNCREiLb4p
 ZE.AzX5A2h1NHF1dINjskQiKZGmcarYViW1m_inoaCreag9PepkyDLBD9RcrCl5..J.TYGYvi.qQ
 iXPYPdpQ7NZrCkYRxwfdWS_bS1KGcNlFvfdPKpwp_HD8CObLKl4ActtFM8qVZVXAft9fqTJSYOfk
 ykO9vRcoaupd26fU_EcwEgpoG11OY4vclH3yDau1N0Wdxx9iDTAUVujOMyNy88XE.vXxUpCg8hAM
 TOdIXWntf8BDVUSvX0YWz5jMMIgNPJxz4x9flhwF4X5YdvDzoGCsc1FH8MMqQqDHb4UukC9kxlMi
 00HL2Uuvx0jrt0h__EI2CKNzcLluNvI6g6pK7UgT4enfd31w8wEE8sG_pUGbRB4dgk95KUdsgXQT
 nr4xE.6128rQQTPpDdvkakUWlxY_crhc8cig.Sb9yuaTWo087WptylqI91sHpyCKdUgGqcxc9MMR
 uAS0zk9RhBIa0wfI3rgiC_hpUDdsH.S7mAdUwZQ52QCYE.2iq.fDHfMXv3IR0SKvmFOyqVHHFTpT
 VQrBzdhBn.4OH.vphmcshRcnawd.HF70e8iQQY7s7SJjGvG82uSzf0cSSgLUUPw4fyZJ6KJuRB2j
 KFZsGHBH7fHy7mRdsTlJ6.Wc5twoqN2DkDUK.sK0N000oM2ClxiwjY5SoMnklzflGp9Z_GRh5F_.
 HqVjKwHK_smbFtQaX4.r37q.ki1Gwy3gUIM6WUeaGp7LPLGsKx6LU1FI.fGwk62IjRWfmlyhZW8G
 huhyP4QSINA0ZeIg8qwYCjPBAPHm2IGnK8PpeRjlNlhaONkuCd7W.F03C7GE03HE86eVsvpl6b4b
 of6yv_lKBE92XTbPBeqM.UIGL8k7.YpOtyyT4duGMOMlsIFPzzpr.IzM4NzuoHQ8nvbT5eptFtiR
 L0lSJsvF.VyUTyR8adgy1N.wCSD.jKLW1BKEv_M8016OiCbOgCoiIe_DViFEBZtY3uV0U5PisCW4
 ecUorYudVyVr14eC6N9e2UpnxRqaGEQ0Y05lRq9.wzFgQQDyYpGfZhZc2jdTnl.XPdsgEVgmvx9y
 pZQ4KspZicQ2JuvkENSkZPwgqTyh2vly8lfbo0UI22fWUFg5.BYT4C8_M35PMZkDaqjsTMrsx8eX
 Advs_SjMg9EjlOMSz5nV4OGfu2ieWSmKu1rlGu5CO3HfWEtCE_RvbdYLMgtSthYcQAa4WpaA_.g6
 OKAvXGXm2v1.I7cb8lAgP7SFmecNTSlEbiLeEWSABVUpBNErvtbNefU33JpyCX4QSoN9Y77oq0KL
 Tkikx2tDmuFCV0Tw7ct8yux1SXHUxf3rC2JsBcLbeQOlnLWRTIO87Ooei1sgu214w1oyyFt5n07b
 uRXCg.vvCL.YNGCDGoblhO5yrbE4tTCttSZLGRRM72Mjb254gNZw345iRey65p_FBEi5DOEv1qhi
 iibROEK7i3z4-
X-Sonic-MF: <marcelo.as@aol.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.ne1.yahoo.com with HTTP; Sun, 20 Feb 2022 18:04:41 +0000
Received: by kubenode514.mail-prod1.omega.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 034d5a13fc09754f0eccafe7fd5ff5ed;
          Sun, 20 Feb 2022 18:04:39 +0000 (UTC)
Date:   Sun, 20 Feb 2022 15:04:34 -0300
From:   Marcelo Aloisio da Silva <marcelo.as@aol.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: r8188eu: move open brace to the previous line
Message-ID: <20220220180434.GA12386@snoopy>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
References: <20220220180434.GA12386.ref@snoopy>
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

Fix the following error reported by checkpatch.pl:

ERROR: that open brace { should be on the previous line
+		if (rtw_p2p_chk_state(pwdinfo, P2P_STATE_NONE))
+		{

Signed-off-by: Marcelo Aloisio da Silva <marcelo.as@aol.com>
---
 drivers/staging/r8188eu/core/rtw_mlme.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme.c b/drivers/staging/r8188eu/core/rtw_mlme.c
index 45eff3018d73..3abc7e21bc0d 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme.c
@@ -1378,8 +1378,7 @@ void rtw_dynamic_check_timer_handlder(struct adapter *adapter)
 
 	if (pregistrypriv->wifi_spec == 1) {
 		struct wifidirect_info *pwdinfo = &adapter->wdinfo;
-		if (rtw_p2p_chk_state(pwdinfo, P2P_STATE_NONE))
-		{
+		if (rtw_p2p_chk_state(pwdinfo, P2P_STATE_NONE)) {
 			/* auto site survey */
 			rtw_auto_scan_handler(adapter);
 		}
-- 
2.25.1

