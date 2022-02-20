Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C95734BD072
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 18:42:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240363AbiBTRm0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 12:42:26 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233904AbiBTRmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 12:42:24 -0500
Received: from sonic317-32.consmr.mail.ne1.yahoo.com (sonic317-32.consmr.mail.ne1.yahoo.com [66.163.184.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8432AE69
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 09:42:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1645378922; bh=5i7B4UP6i0xOh6BEGhXP90aB1q+OzqFXQ9IFJRSWCgo=; h=Date:From:To:Cc:Subject:References:From:Subject:Reply-To; b=FnH757QLquYfc1IWozZdoMANUi7PhPuxCwGltXLABpxdmUUwv9aypICKlt95pV4cky7gQrsT/dQOzuPzPl4H4Uh4xgW7RCIERYvj1YsRxRylBOyyKW+eY4K0/raiv9XKq/gDGIimorP4iXx7iiH42mlhKV0L0dW6zXohPd/i3DSKAaC4jXYRZL3oZViGeLB0Kg0NbBEyV3NYvCAtLuqF6uzWqYg2ZEf/Ww/TM+o7Shy3S8s+S/Gc5YV/vPn5WzAmyopUm8OLUbkNf48mQ+lvaP+u8rKyy45jiYWro2zw0MlCYX/cuHewIA2ftQOMflZZfTpP5uqWxonFsW7x7IidqA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1645378922; bh=mJvVav5IUmbUUXlDBej+0nUbu4HFqpBiTsqHxcGa1rq=; h=X-Sonic-MF:Date:From:To:Subject:From:Subject; b=Bz+GhXTWrzSFZimiA4geOwhteKImYLf/XVS7SzmH1xLYpHIgVn7ZGgS33qpRJ5k+USHq92+qehuRpjGs0Aq/0THDeGst/rR0+SgXtB0bLC8HVZI1hedJq5i+aGw7u+0NISqzV0UEuWE853G9zxoQEGMBeH+vxEU2QjqWZxDnKeQBe5Tg73K2T9TPYB+apMyN+j4i14Li1h7of2hlHraLF5r+e0h1kriBIA8WmIpUlRQ1KxXXl3KppkcGpvt+pdgafbK/oD84opxA1UWPVxrtM6FlYQLet/nKY4K62Gzl55ioKhK3Nb5OBGe7n3RsGiroMyGEZTdiKjowtVNE+juEIA==
X-YMail-OSG: LvXfeYgVM1mEB9uzn_AVpnyxtYlpeI598xjD5FBfI8VOt203pM52W_wps_bNlSp
 am8ghsM1H7RurTO43jvIMRZ1pKmLG6RqO2I12QitTOyJImQ0Q.Aiag1hTg5ViiJKWU4aoNeEvZwS
 1YGYD1Ja8V49qHqW9ED5zPZG2UD14XBPluGE1HA3hS0LCWHeScu0r0P3Zbn78vFa9VraoxWPG8Ti
 5loMQaO0S8eZu18WIbFmdT1viN7QzhxZA5ximiQAfFfuWRWvHEA22jaxOQK_W0rEUM5xgWRTbnrn
 Uy2eJ.ss.R5MEzZ1Sot3QeEbW0NH0cuhh72dejI1jJrYgwD21pjQ8O_qwIU2KM6IccCcPqYvelbz
 IgXjDBcgNXVm8ju4w7y4Mf_6dMBO1pfbcZGIcvAKSghOvNm0rcOMmsIN0SRdyAVQAeres.yFYSrE
 FOUr1PooqCUdfD5sGf2aRq0tkppwvf8MaVFxMp3.0vDjddFFmGIGPL7ZRANiehoUi77wGtFAzGTt
 SOOi2RQR0RLl93EB6xORxj_3wSKqbwITvSaa2o8Nz7j09jriDbMradi2nEkfL.oNRg0KQ9rW342y
 YAwgIeYd6jkpYYD_clMdLTY066GEOht6LCU2vx8BucSa1e2bN5MU1dJQ4DOGfwhgM47I9.ODosY_
 jiwWRyiK2dUImzHTkVbMOUmg6M.V3qRZ7_Z3tfN03i1l_o5pBdW49kGz4rk8z1Nt9AvFvVavG.EB
 ShT.4DR_MzQCAjAAa0.g0m0xD8s9DpmRXC8287eeC_3PtoZq3qowEQKSWd5gcUxQK_Aam7H3JzLT
 KR46bi0evVaUQWpXWbu3Fm5TMfdrTTpi.43cLTyozk3bCPqDUFg2lFd_AKSiUvGmmnxRnkbGCxvZ
 FLXkMcRzhTLWXhD1WK58u1V0CaZWtF4AFTjYxdtvliKEP4ejfzG8MYMtdGYRBV9Nh0g4Va9RuZQ7
 PflYeFIZgzYlJq853YkGG1U5t9w9YaEYufCC29v1LoYSGLNxAr3BEi32w1DvhhbW2ArSROzW4V9O
 btHNqjiAgM3aDWx7eRaNY1YUIXvPg63AvfnzDbT3YAk4zz9QpWaBz4vFUDEDwvgRf7v3YRuceyB6
 oPwxBr2f0C90cm812f4y7rvKnTciyCx0MdXHOh6mP6NHSuvTahwfEgPYdT5xrH6TY679STgbtNG9
 G0P_6lP_stBMBeSS5bGL3UZ640CnmsEnT9a4YmwfEu02m3UtfY97DhTjKrdY0AwtlnwdhjUTFIAy
 OyZhB30bm5oJgVQ6M9kBtigPcjHFt6sYX4GHRjwuVOYlZ4ZDQ9MVSPOQrZP3fG6pjDPAvyc0KsXD
 hPlEgcziaDXV6EbYt5hr3mWhqlYq.z0.SQAP8Ldcdpkh.rNvNHmNa6EUnhsN9l6wTlWDzkdYm__w
 _oZUXnVAMDU0UckG1ce6toDx.PWWlAH7SmxuSiA32yR1yvzzW22rx9.dtl7pA4aG7sTkBcnGKRug
 1ZX70tG4xqml20gV96zhK0w_BA0mpP7gWxD.hJy0EnspMRW7OHL4KpbGJb.iimSq_OwnWyLVO0Bt
 YSkxa8Udw02o8FD3C2GwWSXNL4akobuzXQIrkf0JzpbfZ5oklCqFSFY_u6aajp9obSIUfJYRonL1
 tdMJ4B866_vH8OtSz1zTYUfqX26YRygXk5DfhsxOteDxV_GUnQC4cq8dZyZ8XY16fRnnWWOAmscB
 ecgTRuSkcZDXAA5QvIlOK3GGcm3E4354dSmE9VE4Jn70UjdcgH5kgfGp9Iu3XtBSIq1SHqQDNGOc
 9Dd06MKUc2QsCOwvi.PYjCG7UwyoxXEQoFPm7frp1XEYB8P9rps.GVSGXS8SWdIvX2upv4VK39cI
 Mc0HyBbkUEErLNa1V.45tlIcMDkU7bwjtKjkolFlY2rsHJoVBUAShh6sG27EQTQ27Gp3IjLRajko
 tVshO6m85ajQozRVd1GLQ2BSb2cBgTn6tpHer.YbwX6Vaby8wDGfwBFCgnxUNjzJNvFUY4SF442t
 UUk.OZz32G9SOTGUlfkafNn1cBmNpUV_V7oVJi3bY2G9wHGFt08T50xALE_lzRgcbPhV13a76HSc
 uKK7x3UFy_jRZ.nKZIbXTbkAEzPIaY1jTxpX3FEGYdxq.90WglJR4HDDPFkNOS4pTolkVlPC0CnH
 SqSBK3PYoLyR.iZNy6Afd5RnkTXKil58FP7h7SXQ_TKTxy.PgDFXNY5WrTobUFLcw0DProjNk1qU
 WqY.Wyg--
X-Sonic-MF: <marcelo.as@aol.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Sun, 20 Feb 2022 17:42:02 +0000
Received: by kubenode550.mail-prod1.omega.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 1d00f9055099d6db87fd586831b218f1;
          Sun, 20 Feb 2022 17:41:59 +0000 (UTC)
Date:   Sun, 20 Feb 2022 14:41:50 -0300
From:   Marcelo Aloisio da Silva <marcelo.as@aol.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2] staging: r8188eu: remove unnecessary braces in if
 statements
Message-ID: <20220220174150.GA11496@snoopy>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
References: <20220220174150.GA11496.ref@snoopy>
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
Changes in v2:
 - Only remove braces for the if statements below.

 drivers/staging/r8188eu/core/rtw_mlme.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme.c b/drivers/staging/r8188eu/core/rtw_mlme.c
index 45eff3018d73..3a438f917904 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme.c
@@ -1392,14 +1392,12 @@ void rtw_dynamic_check_timer_handlder(struct adapter *adapter)
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

