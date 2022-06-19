Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C04CE550CC9
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 21:43:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234554AbiFSTm6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 15:42:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233518AbiFSTmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 15:42:53 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08F8F6250
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 12:42:53 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id o18so951179plg.2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 12:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lnwBlfKsLcAz6io0BTwqY0usDb2Nda3s24yxh9Wy1vs=;
        b=Ig0kvXXHf61H2AJL6sWPLdtzgUeN7hX9Y81ip+5VYrCz0eaZTiSv/KQiwbV+lTOaTf
         pf9thO2GRs7hjeNMdlebIwegofPk/9fVnsFtClaISQ/jULIcj6dzydGvLGEOAgz6vlOZ
         hLqJ28hWh6wcYgz7gFEr2We/DAPjqbg7NpS/iof7iqohExxFad6WmDOkUdGXQX0B5jDR
         zdXHl1hkMmkY0qW7t9VDQ+WcE+vCL9t8A6RGbSNeEy6MiSc1HkF2OGlF5uh5VjkWt88a
         erjeeABx4srqKpuH3ya+IMRo2vhpxC1X6OEIAlC3wTsJ9EOTYxWZQ2Vd2gNzR826Ow3X
         i+Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lnwBlfKsLcAz6io0BTwqY0usDb2Nda3s24yxh9Wy1vs=;
        b=1ECnS6hriutQ6YeKazCg26G0TSu2M3NFvVZcKuUm5oYT2WLDQ0WiPkQ3/qK01nHKeg
         cWDKU8d84qrefxw2At6/qbhRC2ue8QpGBzBHv6U1fT24OMiYgLGN8AhBrFVb5Xb8tc3n
         QoPybkNKYstxHA5JBDJcRLYtr6ZXqDoBXu1SVOACEAlGOrd8Il/z2+B8X1rdJaNP7Jsz
         C1Qvrpj1D2sY9ylaGYF4nmmFHPEZ0p4YSJek/L7R6DGtfRuSRNt5Kug8IEbSNajO6oK/
         VTtysdzO7BGZb4xOKbI4ZWuPF0jQGRRbuyWdFGzcOYajcdOdv8nDpOWZywAhgIIXIWvZ
         RJbw==
X-Gm-Message-State: AJIora/ZzM/JLN+yhRyzawGT+s8QhppNIoL+cDjEfF4fQTvQ1tREVFPc
        pmA8lWMmv7HTRD4tX2gQMUAGgYI9hjOqQr9+
X-Google-Smtp-Source: AGRyM1u/kMveQHb5unIS+o39fAdYB7p0WXj1hjykHwdfWYZ4Ca4PRIB2OBzQVBJGkmh3oOnPiQeM9A==
X-Received: by 2002:a17:90a:4209:b0:1df:b907:ed3d with SMTP id o9-20020a17090a420900b001dfb907ed3dmr23188142pjg.40.1655667772515;
        Sun, 19 Jun 2022 12:42:52 -0700 (PDT)
Received: from localhost (c-67-180-87-133.hsd1.ca.comcast.net. [67.180.87.133])
        by smtp.gmail.com with ESMTPSA id b8-20020a170902650800b00167942e0ee9sm7150970plk.61.2022.06.19.12.42.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jun 2022 12:42:52 -0700 (PDT)
From:   Chang Yu <marcus.yu.56@gmail.com>
To:     Larry.Finger@lwfinger.net, paskripkin@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Chang Yu <marcus.yu.56@gmail.com>
Subject: [PATCH v2 1/5] Staging: r8188eu: core: rtw_xmit: Fixed some whitespace coding style issues
Date:   Sun, 19 Jun 2022 12:42:27 -0700
Message-Id: <841716cec5032ad706fbee8677e1b67aec8ad736.1655666628.git.marcus.yu.56@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1655666628.git.marcus.yu.56@gmail.com>
References: <cover.1655666628.git.marcus.yu.56@gmail.com>
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

Removed superfluous blank lines and added blank lines after variable
declarations as per checkpath.pl

Signed-off-by: Chang Yu <marcus.yu.56@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_xmit.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_xmit.c b/drivers/staging/r8188eu/core/rtw_xmit.c
index 3d8e9dea7651..1aa284453ab2 100644
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
@@ -450,6 +447,7 @@ static s32 update_attrib(struct adapter *padapter, struct sk_buff *pkt, struct p
 		/*  The following is for DHCP and ARP packet, we use cck1M to tx these packets and let LPS awake some time */
 		/*  to prevent DHCP protocol fail */
 		u8 tmp[24];
+
 		_rtw_pktfile_read(&pktfile, &tmp[0], 24);
 		pattrib->dhcp_pkt = 0;
 		if (pktfile.pkt_len > 282) {/* MINIMUM_DHCP_PACKET_SIZE) { */
@@ -1069,7 +1067,6 @@ void rtw_update_protection(struct adapter *padapter, u8 *ie, uint ie_len)
 		}
 		break;
 	}
-
 }
 
 void rtw_count_tx_stats(struct adapter *padapter, struct xmit_frame *pxmitframe, int sz)
@@ -1316,7 +1313,6 @@ void rtw_free_xmitframe_queue(struct xmit_priv *pxmitpriv, struct __queue *pfram
 		rtw_free_xmitframe(pxmitpriv, pxmitframe);
 	}
 	spin_unlock_bh(&pframequeue->lock);
-
 }
 
 s32 rtw_xmitframe_enqueue(struct adapter *padapter, struct xmit_frame *pxmitframe)
@@ -1515,7 +1511,6 @@ void rtw_init_hwxmits(struct hw_xmit *phwxmit, int entry)
 
 	for (i = 0; i < entry; i++, phwxmit++)
 		phwxmit->accnt = 0;
-
 }
 
 static int rtw_br_client_tx(struct adapter *padapter, struct sk_buff **pskb)
-- 
2.36.1

