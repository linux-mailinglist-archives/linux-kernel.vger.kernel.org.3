Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBF4D47A149
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Dec 2021 17:33:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236114AbhLSQde (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Dec 2021 11:33:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233228AbhLSQdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Dec 2021 11:33:33 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8492C061574
        for <linux-kernel@vger.kernel.org>; Sun, 19 Dec 2021 08:33:32 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id w16so371969edc.11
        for <linux-kernel@vger.kernel.org>; Sun, 19 Dec 2021 08:33:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KS9Gjd8Tu5fx7nRz0KTvLEQ46TtRhkZSv2L1vjuz2w4=;
        b=FbnewEpGikucovyolpVKuGyC1GLL5WvgWftcd1Hr4zCtk0ZPp/n/wSygXiGNLc45s0
         xGqDTM37WSCRZrv+VthqlUhRizJuDg2yuOXNXEBBoGNuoHXBU6950iiFhgS0F8Z6Rn1S
         xNZG7H0C6DOMw8dbPkK3TGDa5xAZCONWimwActK2WNOFv5vtjByQuHDL3Msl+h39mfsK
         5P1yY1Ue46/LndSFGJUUOKPTesSHBj4bn+WjFKrrHiGU4g/jhTyYeL+ydYj6XwUBoek6
         HmKZ5wn4pd/ACGIGRBwUTS9gocbk6gv8/VKhXJ+KuDMnqdOl7N+BhtkEiniMmDSvC/eF
         STEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KS9Gjd8Tu5fx7nRz0KTvLEQ46TtRhkZSv2L1vjuz2w4=;
        b=CDDP8c4tG/N2yCSYOjmgxyR0X07iZewpLzC+wh+qEy5342sRLJK+DGErNtOrW7srdQ
         ZhZnGGdc1wBeJHDhPpVqS9D2Lcmi2eAwxCfuC/p6ehH6WnYCtnS/HhWq94gmtscTCmYM
         gkXi9eYLv2VTKdyL1Az6hH112xnKMji8XONUcw1Ih+wSRZwttbO3RX+n0EX7p+NuW3zj
         M1H2GxaqFWyi6Sh8zuuXoWn+RugmXe3SsEbo/wR+wtdM1GSvOc3UaI+w2tBu8PrnUrBu
         94ayTOeHBa+TOTW0+iX6ha6/limr68LyBiYeGjo45Z3qI7WmHwAX6FkEges9jfBYuBjT
         1Dmw==
X-Gm-Message-State: AOAM533IydHGMExNppogoU69bC+4VvyZkAHvUBocujZThqkwvBn6W5rW
        kZmHDcuh52Pw39z2YyQYYNZndXY7nPJ8NtNw
X-Google-Smtp-Source: ABdhPJxNM8jq0/Xk0YssSIMtzCBrWtiDU+f542N0mZaQ9CQ05MKtfUzudM5oWAf9va+MXitJnOIVlw==
X-Received: by 2002:a05:6402:27cd:: with SMTP id c13mr12073433ede.57.1639931611088;
        Sun, 19 Dec 2021 08:33:31 -0800 (PST)
Received: from localhost.localdomain ([83.143.250.232])
        by smtp.gmail.com with ESMTPSA id cq19sm1069714edb.27.2021.12.19.08.33.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 19 Dec 2021 08:33:30 -0800 (PST)
From:   Ismayil Mirzali <ismayilmirzeli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-staging@lists.linux.dev, fabioaiuto83@gmail.com,
        gregkh@linuxfoundation.org, paskripkin@gmail.com,
        linux@roeck-us.net
Subject: [PATCH v2] staging: rtl8723bs: Fix styling issues
Date:   Sun, 19 Dec 2021 18:33:18 +0200
Message-Id: <20211219163318.84300-1-ismayilmirzeli@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removed extra whitespaces and brackets for oneline if statements

Removed commented code as suggested per reviewer.
Added blank line after declarations according to styling guide.

Signed-off-by: Ismayil Mirzali <ismayilmirzeli@gmail.com>
---
 .../staging/rtl8723bs/hal/rtl8723bs_xmit.c    | 23 +++++++------------
 1 file changed, 8 insertions(+), 15 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/rtl8723bs_xmit.c b/drivers/staging/rtl8723bs/hal/rtl8723bs_xmit.c
index 7fe3df863fe1..fdefb72047f0 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723bs_xmit.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723bs_xmit.c
@@ -31,9 +31,6 @@ static u8 rtw_sdio_wait_enough_TxOQT_space(struct adapter *padapter, u8 agg_num)
 
 	pHalData->SdioTxOQTFreeSpace -= agg_num;
 
-	/* if (n > 1) */
-	/* 	++priv->pshare->nr_out_of_txoqt_space; */
-
 	return true;
 }
 
@@ -147,13 +144,12 @@ s32 rtl8723bs_xmit_buf_handler(struct adapter *padapter)
 		return _SUCCESS;
 
 	ret = rtw_register_tx_alive(padapter);
-	if (ret != _SUCCESS) {
+	if (ret != _SUCCESS)
 		return _SUCCESS;
-	}
 
 	do {
 		queue_empty = rtl8723_dequeue_writeport(padapter);
-/* 	dump secondary adapter xmitbuf */
+		/*	dump secondary adapter xmitbuf */
 	} while (!queue_empty);
 
 	rtw_unregister_tx_alive(padapter);
@@ -247,6 +243,7 @@ static s32 xmit_xmitframes(struct adapter *padapter, struct xmit_priv *pxmitpriv
 						if (pxmitbuf->len > 0 &&
 						    pxmitbuf->priv_data) {
 							struct xmit_frame *pframe;
+
 							pframe = (struct xmit_frame *)pxmitbuf->priv_data;
 							pframe->agg_num = k;
 							pxmitbuf->agg_num = k;
@@ -310,8 +307,6 @@ static s32 xmit_xmitframes(struct adapter *padapter, struct xmit_priv *pxmitpriv
 					txlen = txdesc_size + pxmitframe->attrib.last_txcmdsz;
 					pxmitframe->pg_num = (txlen + 127) / 128;
 					pxmitbuf->pg_num += (txlen + 127) / 128;
-				    /* if (k != 1) */
-					/* 	((struct xmit_frame*)pxmitbuf->priv_data)->pg_num += pxmitframe->pg_num; */
 					pxmitbuf->ptail += _RND(txlen, 8); /*  round to 8 bytes alignment */
 					pxmitbuf->len = _RND(pxmitbuf->len, 8) + txlen;
 				}
@@ -333,6 +328,7 @@ static s32 xmit_xmitframes(struct adapter *padapter, struct xmit_priv *pxmitpriv
 		if (pxmitbuf) {
 			if (pxmitbuf->len > 0) {
 				struct xmit_frame *pframe;
+
 				pframe = (struct xmit_frame *)pxmitbuf->priv_data;
 				pframe->agg_num = k;
 				pxmitbuf->agg_num = k;
@@ -385,9 +381,8 @@ static s32 rtl8723bs_xmit_handler(struct adapter *padapter)
 	spin_lock_bh(&pxmitpriv->lock);
 	ret = rtw_txframes_pending(padapter);
 	spin_unlock_bh(&pxmitpriv->lock);
-	if (ret == 0) {
+	if (ret == 0)
 		return _SUCCESS;
-	}
 
 	/*  dequeue frame and write to hardware */
 
@@ -405,9 +400,8 @@ static s32 rtl8723bs_xmit_handler(struct adapter *padapter)
 	spin_lock_bh(&pxmitpriv->lock);
 	ret = rtw_txframes_pending(padapter);
 	spin_unlock_bh(&pxmitpriv->lock);
-	if (ret == 1) {
+	if (ret == 1)
 		goto next;
-	}
 
 	return _SUCCESS;
 }
@@ -428,10 +422,9 @@ int rtl8723bs_xmit_thread(void *context)
 
 	do {
 		ret = rtl8723bs_xmit_handler(padapter);
-		if (signal_pending(current)) {
+		if (signal_pending(current))
 			flush_signals(current);
-		}
-	} while (_SUCCESS == ret);
+	} while (ret == _SUCCESS);
 
 	complete(&pxmitpriv->SdioXmitTerminate);
 
-- 
2.25.1

