Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CA0A4B6124
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 03:41:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233711AbiBOClq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 21:41:46 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233696AbiBOCln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 21:41:43 -0500
Received: from sonic301-57.consmr.mail.ne1.yahoo.com (sonic301-57.consmr.mail.ne1.yahoo.com [66.163.184.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D51D51B784
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 18:41:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1644892893; bh=cwlZyrxzndX/rf1BmsU10DtvJE31JIYmldJr7uTBP2I=; h=Date:From:To:Cc:Subject:References:From:Subject:Reply-To; b=YKbJZci5fDWArSh+Kyn6jCb9yPAE3ndp76E+4i08lN5i+LwIq7wSC5DjhWTpAcJoCU1rBqpK4eDXoNg0LdBc6m1pOEM8b6oSBYuZIxxCZENrQwG0n2dLvWC5xiJRveT4jlLlV6V+ebgeEKb7M7rvDPC5ygWK9NsIGY5ud12WGr8MdZ7b818HyL1Ic6UuIhSjPhJ0yLREtqzuHsxUjGOWLrqcf2XyfdEmHS8L9Qd4VYzx0I4UtwDaUuYoh5wcNp+MOWojFFXY+KRdBkya8bmYn5svRw200cBbfVTG3y1nw0q4k70ShHkiqMy9ahg7aQ/Ql6d3EezNswspsFG7nviYug==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1644892893; bh=QVfgZHb4UfdjjPM9Lhmi8YMeaV5fSTbihIVIou1DOl8=; h=X-Sonic-MF:Date:From:To:Subject:From:Subject; b=H/h7K5eI5TY+6ANSrtqzI52MHoODOLwuwwXtCmrn8ORCOCj18R5ldF5T1zfBgqKa3Q4NWMrtfkUUTUjJYwHU19cMXe0mvIuGpxX5AYcYPuhi1yZ/I9RgZfJmzJ1t8lW//tSRss5xPfGPgJuf9ECTRrUL7pu3c9pe/9ysivX6B7wqq0U5gIjuoVfavTRQNpxl0Z3fdRPQGw6U4666XRUfXpIogAaqqDAkkYD7dGeKYi6hycZ/V0mGcb7mZCU40raAUMx2VuKFW41jgfHxF5Q4T4+9O3SxJF+WmJfrSyFb5OdykZB6cVTRkQMDf4alSgTg8Q21VAKfPV8pZ0LtJTINHQ==
X-YMail-OSG: BTNaKOUVM1ndshD.f1HSeq7iFloCTdP1lhMBf.hImdjd145NsOJMtlN1sNLH0NF
 VqGIteGfnoPXHEVi6bGUILzOUfEkJ_R1VWnjDbhDSBUxLZYyqdb3EBSk_PRVwFiTMQ5uoLMhvl9O
 jmsKZUyvjJq0vB2GCK9MbtlUDs8FGvoHWP7fmDVfwu6kuleTiOnuN75GbMwoQjEYU1zcZGiKbq7j
 ofIZnpYqf_BGsEV3u8JMQdscZuxRkFpn8A9xQphHM4hW1oD3WS0m1Ntahfh6ZZAbHcphcMLSLAhe
 8pKrMzU3QFynJfEJtyku_6vvtNv.dNp3D.z4VxaukpbczVuwCfdTi1qtJj9vM7oeSQzuzlHBjVmN
 3bQrRKh0Fa5XmNEVNagAG0mI5dy_iMl4mLthEhvzmOIsza4NKsQWZtWx83zdlwqNNbqoIaxtMfqb
 Uku.Vnd2uVbKFJxqsUii4v6eKXQGeIsy52k2UyQMfDnjSdH5h6sQyGr25hFZqcOm6jXNAr.COGbm
 VTUn5233tRp99dgOON6mwmsfBd60_KrZD8PikFQaEAvbNUO11i_aKT3krfdaA7ZCkoNE9pE588S3
 uV9oV9pA.XGAMMdCtx3brMa110fGZ_Ur5hsMxWthY.U3LRiuo8uFn04B2k2WcTkm8l7TWUUG1VCo
 9UXRILn0O2A2BivLevMjqv347GE6P5rvi8KRWTRJ1819pueHD4jm7.GzggGZF_bvoFnp0dXSkCdh
 zx9GP3xUKiSfdzvhieIs5vejH2vDUM0ytL3wVCvhuwPzWKNVJoWloHDeiImcsOEVWWvrZMK_QiBo
 1Uh999uQy286jyyqQziqr9EYzdr.6DhcrBd.ARfxV2C6hcSzD_dNr5PLjgWWUVNQaVTfbOhuB0p2
 RLEFJOKhdltCmAzSFPa8IoclOD2X.doUTuRHtgxzkX_85G81mljCFiYuAh.9o3rEsq9xmSzY2ur0
 s1I8cTjKHH82FYbz9rBJO84k3W9ZY58WAu8JoG_SBCyd7zDPKOkyWzFx4s1.gxBvCRVYpE4BuN9p
 0XEJZuOUeG86VIyYcYRni_09CuvVqoixSidCo1nmlyjLZdcrVyT6Np56yBWpB5NL9pKKuk_PQWy4
 7DaZ_fMOcR0dKcXYf3PSidsRzd2OSVmZyFR1b2X9c7dE9kdE.bMtOs9ZXP_Xdy_eDjoP9NgO7xdC
 M5GEi0uMAvMS.ra8wEcfLT75AXAxfiIVq4CAbDYsHzBoxN33QdwQLm5eVyANvhMai4SQHkYtEDKv
 AcJs26quJAcV3gnyDgnfv69NTGPGYp3k4yyafdD4.iS3hASW4v4D3Z7bveNIi8j9b273qeHvhyYM
 8A8I0MjwFWJRyi_kM3rceJRJYWv.nOQ38x4jySlKjhkySwCsmo91g3.C5lOtE0uzikUNPsLXbY4E
 OFUTwN28T8sClbP4zhKqiboXPP7SJLPWH4Unne3nQQIQdEZRseetdoIMbt9uf4JjUPFVES76Nz8p
 Xy2rfDfAx.JGJQm7eyBlkxYA40JLKq0ujLXUJ8aDFCrifT5iZPIn8FeTHurgwmz5_vbcXEMkpx17
 Fs.zKgsApWic0IRDT3M0.hXl2CVPBZbYTFXI813DIcKh7zL8xRecGgtgZ3Jba33osMPt7g7V3aWG
 j8jJiQAwlkSIIk_O9lxZczY1dxtFi9RK1cj4.UiuJMwj7UdSEsKubttmEcwn85QdstNTK.JqhEi6
 FXCiWaZ53qVnp18i..xiynOqAd455CaUVmAc38nQpiVdOSwkqPCAdU14eMfWCPj1rYfRxpFIjcpo
 4mx0pWfnGVd23HusIqnGKLFLITiZYa_ZTL6tR.43MF2rlq4TKUDGH.Yj6qCnVedmy_gbqjbZd.V.
 OAyfSN3kHT1mtTAwi3jq0YNvrNrlDm0J16RWYJ_WK1qK5Ytjx2m6RnAtecQEp_D2eXNGz.ebg1TM
 RsGBkRNooOa9TyN5i.JQolQaETuQfWlxRJO8CXg1nCeWwveC9qtsY9cgYoKyukGN5QT9YO5KFHOB
 BYxk2sloLgvB3TkzFGojrjANCZ4zPU95_NPnoDg57z259dp07tdVeQlc_TXxmXihiE3vfpekXQle
 oFsTzIrd1ohUjjECK7hmVxHm4iEjNLd7qSeR5uDU2MoxKpGSTKEoT6_Miq7ua8ZET1whke_z53XJ
 QWIqV6IFmVbWYIMbeQ7ldEmKFGRFOHLgNFFooTdGBRd9l4kSOWnXG5OwH9rejY6QVqu8rG5wf.Uk
 U
X-Sonic-MF: <marcelo.as@aol.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ne1.yahoo.com with HTTP; Tue, 15 Feb 2022 02:41:33 +0000
Received: by kubenode514.mail-prod1.omega.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID b7b91e8796b59d15c24591af310d5abf;
          Tue, 15 Feb 2022 02:39:30 +0000 (UTC)
Date:   Mon, 14 Feb 2022 23:39:26 -0300
From:   Marcelo Aloisio da Silva <marcelo.as@aol.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: r8188eu: remove unconditional if statement
Message-ID: <20220215023926.GA52339@snoopy>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
References: <20220215023926.GA52339.ref@snoopy>
X-Mailer: WebService/1.1.19724 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.aol
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove if condition that is always true. It is useless and
makes the code less readable.

Signed-off-by: Marcelo Aloisio da Silva <marcelo.as@aol.com>
---
 drivers/staging/r8188eu/core/rtw_ap.c | 124 +++++++++++++-------------
 1 file changed, 62 insertions(+), 62 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_ap.c b/drivers/staging/r8188eu/core/rtw_ap.c
index 19d12dd9788e..5e22b1baf9a5 100644
--- a/drivers/staging/r8188eu/core/rtw_ap.c
+++ b/drivers/staging/r8188eu/core/rtw_ap.c
@@ -55,85 +55,85 @@ static void update_BCNTIM(struct adapter *padapter)
 	struct mlme_ext_info *pmlmeinfo = &pmlmeext->mlmext_info;
 	struct wlan_bssid_ex *pnetwork_mlmeext = &pmlmeinfo->network;
 	unsigned char *pie = pnetwork_mlmeext->IEs;
+	u8 *p, *dst_ie, *premainder_ie = NULL;
+	u8 *pbackup_remainder_ie = NULL;
+	__le16 tim_bitmap_le;
+	uint offset, tmp_len, tim_ielen, tim_ie_offset, remainder_ielen;
 
 	/* update TIM IE */
-	if (true) {
-		u8 *p, *dst_ie, *premainder_ie = NULL;
-		u8 *pbackup_remainder_ie = NULL;
-		__le16 tim_bitmap_le;
-		uint offset, tmp_len, tim_ielen, tim_ie_offset, remainder_ielen;
-
-		tim_bitmap_le = cpu_to_le16(pstapriv->tim_bitmap);
-
-		p = rtw_get_ie(pie + _FIXED_IE_LENGTH_, _TIM_IE_, &tim_ielen, pnetwork_mlmeext->IELength - _FIXED_IE_LENGTH_);
-		if (p && tim_ielen > 0) {
-			tim_ielen += 2;
-			premainder_ie = p + tim_ielen;
-			tim_ie_offset = (int)(p - pie);
-			remainder_ielen = pnetwork_mlmeext->IELength - tim_ie_offset - tim_ielen;
-			/* append TIM IE from dst_ie offset */
-			dst_ie = p;
-		} else {
-			tim_ielen = 0;
 
-			/* calculate head_len */
-			offset = _FIXED_IE_LENGTH_;
-			offset += pnetwork_mlmeext->Ssid.SsidLength + 2;
+	p = rtw_get_ie(pie + _FIXED_IE_LENGTH_, _TIM_IE_, &tim_ielen,
+		       pnetwork_mlmeext->IELength - _FIXED_IE_LENGTH_);
+	if (p && tim_ielen > 0) {
+		tim_ielen += 2;
+		premainder_ie = p + tim_ielen;
+		tim_ie_offset = (int)(p - pie);
+		remainder_ielen = pnetwork_mlmeext->IELength - tim_ie_offset - tim_ielen;
+		/* append TIM IE from dst_ie offset */
+		dst_ie = p;
+	} else {
+		tim_ielen = 0;
 
-			/*  get supported rates len */
-			p = rtw_get_ie(pie + _BEACON_IE_OFFSET_, _SUPPORTEDRATES_IE_, &tmp_len, (pnetwork_mlmeext->IELength - _BEACON_IE_OFFSET_));
-			if (p)
-				offset += tmp_len + 2;
+		/* calculate head_len */
+		offset = _FIXED_IE_LENGTH_;
+		offset += pnetwork_mlmeext->Ssid.SsidLength + 2;
 
-			/* DS Parameter Set IE, len = 3 */
-			offset += 3;
+		/*  get supported rates len */
+		p = rtw_get_ie(pie + _BEACON_IE_OFFSET_, _SUPPORTEDRATES_IE_,
+			       &tmp_len, (pnetwork_mlmeext->IELength - _BEACON_IE_OFFSET_));
+		if (p)
+			offset += tmp_len + 2;
 
-			premainder_ie = pie + offset;
+		/* DS Parameter Set IE, len = 3 */
+		offset += 3;
 
-			remainder_ielen = pnetwork_mlmeext->IELength - offset - tim_ielen;
+		premainder_ie = pie + offset;
 
-			/* append TIM IE from offset */
-			dst_ie = pie + offset;
-		}
+		remainder_ielen = pnetwork_mlmeext->IELength - offset - tim_ielen;
 
-		if (remainder_ielen > 0) {
-			pbackup_remainder_ie = kmalloc(remainder_ielen, GFP_ATOMIC);
-			if (pbackup_remainder_ie && premainder_ie)
-				memcpy(pbackup_remainder_ie, premainder_ie, remainder_ielen);
-		}
-		*dst_ie++ = _TIM_IE_;
+		/* append TIM IE from offset */
+		dst_ie = pie + offset;
+	}
 
-		if ((pstapriv->tim_bitmap & 0xff00) && (pstapriv->tim_bitmap & 0x00fc))
-			tim_ielen = 5;
-		else
-			tim_ielen = 4;
+	if (remainder_ielen > 0) {
+		pbackup_remainder_ie = kmalloc(remainder_ielen, GFP_ATOMIC);
+		if (pbackup_remainder_ie && premainder_ie)
+			memcpy(pbackup_remainder_ie, premainder_ie, remainder_ielen);
+	}
+	*dst_ie++ = _TIM_IE_;
 
-		*dst_ie++ = tim_ielen;
+	if ((pstapriv->tim_bitmap & 0xff00) && (pstapriv->tim_bitmap & 0x00fc))
+		tim_ielen = 5;
+	else
+		tim_ielen = 4;
 
-		*dst_ie++ = 0;/* DTIM count */
-		*dst_ie++ = 1;/* DTIM period */
+	*dst_ie++ = tim_ielen;
 
-		if (pstapriv->tim_bitmap & BIT(0))/* for bc/mc frames */
-			*dst_ie++ = BIT(0);/* bitmap ctrl */
-		else
-			*dst_ie++ = 0;
+	*dst_ie++ = 0;/* DTIM count */
+	*dst_ie++ = 1;/* DTIM period */
 
-		if (tim_ielen == 4) {
-			*dst_ie++ = *(u8 *)&tim_bitmap_le;
-		} else if (tim_ielen == 5) {
-			memcpy(dst_ie, &tim_bitmap_le, 2);
-			dst_ie += 2;
-		}
+	if (pstapriv->tim_bitmap & BIT(0))/* for bc/mc frames */
+		*dst_ie++ = BIT(0);/* bitmap ctrl */
+	else
+		*dst_ie++ = 0;
 
-		/* copy remainder IE */
-		if (pbackup_remainder_ie) {
-			memcpy(dst_ie, pbackup_remainder_ie, remainder_ielen);
+	tim_bitmap_le = cpu_to_le16(pstapriv->tim_bitmap);
 
-			kfree(pbackup_remainder_ie);
-		}
-		offset =  (uint)(dst_ie - pie);
-		pnetwork_mlmeext->IELength = offset + remainder_ielen;
+	if (tim_ielen == 4) {
+		*dst_ie++ = *(u8 *)&tim_bitmap_le;
+	} else if (tim_ielen == 5) {
+		memcpy(dst_ie, &tim_bitmap_le, 2);
+		dst_ie += 2;
+	}
+
+	/* copy remainder IE */
+	if (pbackup_remainder_ie) {
+		memcpy(dst_ie, pbackup_remainder_ie, remainder_ielen);
+
+		kfree(pbackup_remainder_ie);
 	}
+	offset =  (uint)(dst_ie - pie);
+	pnetwork_mlmeext->IELength = offset + remainder_ielen;
 
 	set_tx_beacon_cmd(padapter);
 }
-- 
2.25.1

