Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ABF95506B8
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 22:46:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230525AbiFRUpR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jun 2022 16:45:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiFRUpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jun 2022 16:45:14 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4530313DD8
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jun 2022 13:45:13 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id r1so6565221plo.10
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jun 2022 13:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gKaVM+0QMGax/rhBtZVVyBor0BK65j3JTrJ7MKdrLpk=;
        b=RPGhczN7etWK46U3ehU0iRJFtb/x2LggYWn7KPmol85I0Mwp0qk2VjDzFuWEBBmYUk
         R+4nm9Vs++3/EVRAz9Y/4jgXnNu13bGmxWtIjrgGpvOxBXGyKzbzohrKZ+jNcMy3OMQW
         W5HxNyO5JsOabU4prXYsSFHuX4B7DfmqEiPjNkMq1Qz/JGki9wrJacxfAcNRqQZkQP7c
         xPk1TZs39GzVg644pSulLPeTtsxHZFQwFnsTjbugRepwzBgEoc4N1UMxGloPmb2V+nHU
         Uz7m5Vea3gmER+MTG6ZPvkD+56MgKbLg5zdMN+4PINrDk5Av2yp10skIK3kIK9cCW7gG
         OrOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gKaVM+0QMGax/rhBtZVVyBor0BK65j3JTrJ7MKdrLpk=;
        b=qiYt50OFO6Tny3UoB8sVDFQ8UUzp1hrTa968n1pP8WWVzDAyDjSnFrIgmOMBOIu17N
         6Yd3yUFWrgdubcxK+B3njyW9tU2SmxKfqPwF+6RvLXGIXGMC2Qcz0nWc0fPzMbkTmVKW
         t9eftH2iBVstKuRdYO+z/ByYh6bWDC+Q12EzxZw1kMGde9k3Rd+GgoKG1dF3sdo1nKdQ
         XeGh/NzDG55Yf6+02I8Eno2XKp6N8RnxzdmESq+4wcLdwD9X9nH+PqMlfHPkaPmEScFK
         abW9fi4LZwtiy/o4bfba3pZ6cmxZDy8ep/JjA1QzYwtTgAY3kTelnQadQIwIpLsO5/2/
         ykjA==
X-Gm-Message-State: AJIora/JUBV8A8HNCVhrH838vp8aKA3ErDmUYt7E4/fIZlFHVnViV6kx
        r4cfoh4Bc+DK9AzaAqMYv5Y=
X-Google-Smtp-Source: AGRyM1sJil//Af9lvbnYSBnHWR4zmgT9Oxr23a9RzjK/ZAwFQ6haYB5TJtEe6lopkEr9r0lDVg7hhA==
X-Received: by 2002:a17:90a:31cf:b0:1c9:f9b8:68c7 with SMTP id j15-20020a17090a31cf00b001c9f9b868c7mr29021287pjf.34.1655585112724;
        Sat, 18 Jun 2022 13:45:12 -0700 (PDT)
Received: from localhost (c-67-180-87-133.hsd1.ca.comcast.net. [67.180.87.133])
        by smtp.gmail.com with ESMTPSA id e23-20020a170902ed9700b001678dcb4c5asm5798544plj.100.2022.06.18.13.45.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jun 2022 13:45:12 -0700 (PDT)
From:   Chang Yu <marcus.yu.56@gmail.com>
To:     Larry.Finger@lwfinger.net
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Chang Yu <marcus.yu.56@gmail.com>
Subject: [PATCH] Staging: r8188eu: core: rtw_xmit: Fixed a few coding style issues
Date:   Sat, 18 Jun 2022 13:44:54 -0700
Message-Id: <20220618204454.16071-1-marcus.yu.56@gmail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed a few coding style issues and spelling errors in the comments.

Signed-off-by: Chang Yu <marcus.yu.56@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_xmit.c | 28 ++++++++++---------------
 1 file changed, 11 insertions(+), 17 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_xmit.c b/drivers/staging/r8188eu/core/rtw_xmit.c
index 3d8e9dea7651..943422141c8b 100644
--- a/drivers/staging/r8188eu/core/rtw_xmit.c
+++ b/drivers/staging/r8188eu/core/rtw_xmit.c
@@ -16,16 +16,13 @@ static u8 RFC1042_OUI[P80211_OUI_LEN] = { 0x00, 0x00, 0x00 };
 
 static void _init_txservq(struct tx_servq *ptxservq)
 {
-
 	INIT_LIST_HEAD(&ptxservq->tx_pending);
 	rtw_init_queue(&ptxservq->sta_pending);
 	ptxservq->qcnt = 0;
-
 }
 
 void	_rtw_init_sta_xmit_priv(struct sta_xmit_priv *psta_xmitpriv)
 {
-
 	memset((unsigned char *)psta_xmitpriv, 0, sizeof(struct sta_xmit_priv));
 	spin_lock_init(&psta_xmitpriv->lock);
 	_init_txservq(&psta_xmitpriv->be_q);
@@ -34,7 +31,6 @@ void	_rtw_init_sta_xmit_priv(struct sta_xmit_priv *psta_xmitpriv)
 	_init_txservq(&psta_xmitpriv->vo_q);
 	INIT_LIST_HEAD(&psta_xmitpriv->legacy_dz);
 	INIT_LIST_HEAD(&psta_xmitpriv->apsd);
-
 }
 
 s32	_rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter)
@@ -300,6 +296,7 @@ static void update_attrib_vcs_info(struct adapter *padapter, struct xmit_frame *
 			/* check HT op mode */
 			if (pattrib->ht_en) {
 				u8 htopmode = pmlmeinfo->HT_protection;
+
 				if ((pmlmeext->cur_bwmode && (htopmode == 2 || htopmode == 3)) ||
 				    (!pmlmeext->cur_bwmode && htopmode == 3)) {
 					pattrib->vcs_mode = RTS_CTS;
@@ -446,10 +443,11 @@ static s32 update_attrib(struct adapter *padapter, struct sk_buff *pkt, struct p
 
 	pattrib->pktlen = pktfile.pkt_len;
 
-	if (ETH_P_IP == pattrib->ether_type) {
+	if (pattrib->ether_type == ETH_P_IP) {
 		/*  The following is for DHCP and ARP packet, we use cck1M to tx these packets and let LPS awake some time */
 		/*  to prevent DHCP protocol fail */
 		u8 tmp[24];
+
 		_rtw_pktfile_read(&pktfile, &tmp[0], 24);
 		pattrib->dhcp_pkt = 0;
 		if (pktfile.pkt_len > 282) {/* MINIMUM_DHCP_PACKET_SIZE) { */
@@ -628,7 +626,7 @@ static s32 xmitframe_addmic(struct adapter *padapter, struct xmit_frame *pxmitfr
 				if (pframe[1] & 2)  /* From Ds == 1 */
 					rtw_secmicappend(&micdata, &pframe[24], 6);
 				else
-				rtw_secmicappend(&micdata, &pframe[10], 6);
+					rtw_secmicappend(&micdata, &pframe[10], 6);
 			} else {	/* ToDS == 0 */
 				rtw_secmicappend(&micdata, &pframe[4], 6);   /* DA */
 				if (pframe[1] & 2)  /* From Ds == 1 */
@@ -954,12 +952,11 @@ s32 rtw_xmitframe_coalesce(struct adapter *padapter, struct sk_buff *pkt, struct
 			mpdu_len -= llc_sz;
 		}
 
-		if ((pattrib->icv_len > 0) && (pattrib->bswenc)) {
+		if ((pattrib->icv_len > 0) && (pattrib->bswenc))
 			mpdu_len -= pattrib->icv_len;
-		}
 
 		if (bmcst) {
-			/*  don't do fragment to broadcat/multicast packets */
+			/*  don't do fragment to broadcast/multicast packets */
 			mem_sz = _rtw_pktfile_read(&pktfile, pframe, pattrib->pktlen);
 		} else {
 			mem_sz = _rtw_pktfile_read(&pktfile, pframe, mpdu_len);
@@ -1069,7 +1066,6 @@ void rtw_update_protection(struct adapter *padapter, u8 *ie, uint ie_len)
 		}
 		break;
 	}
-
 }
 
 void rtw_count_tx_stats(struct adapter *padapter, struct xmit_frame *pxmitframe, int sz)
@@ -1316,7 +1312,6 @@ void rtw_free_xmitframe_queue(struct xmit_priv *pxmitpriv, struct __queue *pfram
 		rtw_free_xmitframe(pxmitpriv, pxmitframe);
 	}
 	spin_unlock_bh(&pframequeue->lock);
-
 }
 
 s32 rtw_xmitframe_enqueue(struct adapter *padapter, struct xmit_frame *pxmitframe)
@@ -1515,7 +1510,6 @@ void rtw_init_hwxmits(struct hw_xmit *phwxmit, int entry)
 
 	for (i = 0; i < entry; i++, phwxmit++)
 		phwxmit->accnt = 0;
-
 }
 
 static int rtw_br_client_tx(struct adapter *padapter, struct sk_buff **pskb)
@@ -1742,7 +1736,7 @@ int xmitframe_enqueue_for_sleeping_sta(struct adapter *padapter, struct xmit_fra
 	bool bmcst = is_multicast_ether_addr(pattrib->ra);
 
 	if (!check_fwstate(pmlmepriv, WIFI_AP_STATE))
-	    return ret;
+		return ret;
 
 	if (pattrib->psta)
 		psta = pattrib->psta;
@@ -1770,8 +1764,8 @@ int xmitframe_enqueue_for_sleeping_sta(struct adapter *padapter, struct xmit_fra
 
 			pstapriv->tim_bitmap |= BIT(0);/*  */
 			pstapriv->sta_dz_bitmap |= BIT(0);
-
-			update_beacon(padapter, _TIM_IE_, NULL, false);/* tx bc/mc packets after upate bcn */
+			/* tx bc/mc packets after update bcn */
+			update_beacon(padapter, _TIM_IE_, NULL, false);
 
 			ret = true;
 		}
@@ -1821,7 +1815,7 @@ int xmitframe_enqueue_for_sleeping_sta(struct adapter *padapter, struct xmit_fra
 				pstapriv->tim_bitmap |= BIT(psta->aid);
 
 				if (psta->sleepq_len == 1) {
-					/* upate BCN for TIM IE */
+					/* update BCN for TIM IE */
 					update_beacon(padapter, _TIM_IE_, NULL, false);
 				}
 			}
@@ -2090,7 +2084,7 @@ void xmit_delivery_enabled_frames(struct adapter *padapter, struct sta_info *pst
 		if ((psta->sleepq_ac_len == 0) && (!psta->has_legacy_ac) && (wmmps_ac)) {
 			pstapriv->tim_bitmap &= ~BIT(psta->aid);
 
-			/* upate BCN for TIM IE */
+			/* update BCN for TIM IE */
 			update_beacon(padapter, _TIM_IE_, NULL, false);
 		}
 	}
-- 
2.36.1

