Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBE944816D9
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 21:54:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233090AbhL2Uw6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 15:52:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232671AbhL2Uvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 15:51:54 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E9CCC061747
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 12:51:49 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id s1so46589900wra.6
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 12:51:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fV6rF+h2p4xnM+TdhV3cNj0xTKGOLLvdKxWwKe4ndzI=;
        b=PxM1fXXWlABHeD2m9JqP6uzDMtc+ZCg9F+QP5QCu5sk6NmpOIx+9BCCW3lRxT6AVOg
         rXB+NTBVGEdTq7PqP2QdL1n6+/RslYy3tmY/uV3OgrW8ILMUzntQQE4pCbGj5n4DsY3S
         LPwd3s207Yod6/oPiZELbNgEIDkqES8q6pCJeaB8lBhpWdl1jrVmLY5lT4kAaFasHBkD
         VEORbW6tRBy5M5MHwGigk//OGqjy9+p7L6fPRcKg5ndF1OW9tjiKgCw1ZiIOv6XHoHv6
         2w7SzSzxfbl69FFa9BzPqtsL7eIYvZ3Pv+tcu2q6ikmGVTeZ2dYgUSgX4KWnEVEL2Fs6
         NlVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fV6rF+h2p4xnM+TdhV3cNj0xTKGOLLvdKxWwKe4ndzI=;
        b=QZcAYiaAAjF/+SeKkyXjfdiKYKj1jVBa+N3Sgtocv0+oQ9Kpr/t0zQA9kgCd/Uj1xK
         +9psJIawyS8eLTV3j1og/KDdZ42cQt3tRoXfy6TxWw7XYUGi/09G8tyEp9iFUdU3GdEJ
         lU+oUZDzPmp+9OW0JGj7HJakb4sL33BsXk4K4z9TTwFqqx4ZUf/eTmq3wSXt0A6bum9W
         OwUZsAyATZAuyMreiJ9vnBoeofXbhkQ6snJm9FYGjy1sVwhBQ9QwKLsWhFJXMd3aDA0S
         fWLzwIX/S+RhbFRE4Jlft6yrrGmoYpPYcplY9IkXFlnbW4WrpnhswGRMs33uPZ2ZK9On
         zkRw==
X-Gm-Message-State: AOAM532p5nprvSDC9b650LgalkCMFuypQNruxbVhlZnOeynpjcKxZJ6R
        DNHjMvIaDiDLFiB5lGi9ulg=
X-Google-Smtp-Source: ABdhPJzImfWH65x5+ZAx6c6XJX/1E6vaq1sVobtYRF4hy/86NUSvJaG6ADkHyJUwVE/RTtOMnRS4og==
X-Received: by 2002:adf:ef0b:: with SMTP id e11mr21644086wro.621.1640811107921;
        Wed, 29 Dec 2021 12:51:47 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::6619])
        by smtp.gmail.com with ESMTPSA id l12sm27421989wmq.2.2021.12.29.12.51.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Dec 2021 12:51:47 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 30/32] staging: r8188eu: make odm_EdcaTurboCheck() static
Date:   Wed, 29 Dec 2021 21:51:06 +0100
Message-Id: <20211229205108.26373-31-straube.linux@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211229205108.26373-1-straube.linux@gmail.com>
References: <20211229205108.26373-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function odm_EdcaTurboCheck() is only used in odm.c. Make it static.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/odm.c             | 154 +++++++++---------
 drivers/staging/r8188eu/include/odm_precomp.h |   2 -
 2 files changed, 77 insertions(+), 79 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/odm.c b/drivers/staging/r8188eu/hal/odm.c
index 9afd9ed10432..acdf0ba40567 100644
--- a/drivers/staging/r8188eu/hal/odm.c
+++ b/drivers/staging/r8188eu/hal/odm.c
@@ -560,6 +560,83 @@ static void ODM_EdcaTurboInit(struct odm_dm_struct *pDM_Odm)
 	Adapter->recvpriv.bIsAnyNonBEPkts = false;
 }
 
+static void odm_EdcaTurboCheck(struct odm_dm_struct *pDM_Odm)
+{
+	struct adapter *Adapter = pDM_Odm->Adapter;
+	u32	trafficIndex;
+	u32	edca_param;
+	u64	cur_tx_bytes = 0;
+	u64	cur_rx_bytes = 0;
+	u8	bbtchange = false;
+	struct hal_data_8188e *pHalData = &Adapter->haldata;
+	struct xmit_priv		*pxmitpriv = &Adapter->xmitpriv;
+	struct recv_priv		*precvpriv = &Adapter->recvpriv;
+	struct registry_priv	*pregpriv = &Adapter->registrypriv;
+	struct mlme_ext_priv	*pmlmeext = &Adapter->mlmeextpriv;
+	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
+
+	if (!(pDM_Odm->SupportAbility & ODM_MAC_EDCA_TURBO))
+		return;
+
+	if (pregpriv->wifi_spec == 1)
+		goto dm_CheckEdcaTurbo_EXIT;
+
+	if (pmlmeinfo->assoc_AP_vendor >=  HT_IOT_PEER_MAX)
+		goto dm_CheckEdcaTurbo_EXIT;
+
+	/*  Check if the status needs to be changed. */
+	if ((bbtchange) || (!precvpriv->bIsAnyNonBEPkts)) {
+		cur_tx_bytes = pxmitpriv->tx_bytes - pxmitpriv->last_tx_bytes;
+		cur_rx_bytes = precvpriv->rx_bytes - precvpriv->last_rx_bytes;
+
+		/* traffic, TX or RX */
+		if ((pmlmeinfo->assoc_AP_vendor == HT_IOT_PEER_RALINK) ||
+		    (pmlmeinfo->assoc_AP_vendor == HT_IOT_PEER_ATHEROS)) {
+			if (cur_tx_bytes > (cur_rx_bytes << 2)) {
+				/*  Uplink TP is present. */
+				trafficIndex = UP_LINK;
+			} else {
+				/*  Balance TP is present. */
+				trafficIndex = DOWN_LINK;
+			}
+		} else {
+			if (cur_rx_bytes > (cur_tx_bytes << 2)) {
+				/*  Downlink TP is present. */
+				trafficIndex = DOWN_LINK;
+			} else {
+				/*  Balance TP is present. */
+				trafficIndex = UP_LINK;
+			}
+		}
+
+		if ((pDM_Odm->DM_EDCA_Table.prv_traffic_idx != trafficIndex) || (!pDM_Odm->DM_EDCA_Table.bCurrentTurboEDCA)) {
+			if ((pmlmeinfo->assoc_AP_vendor == HT_IOT_PEER_CISCO) && (pmlmeext->cur_wireless_mode & WIRELESS_11_24N))
+				edca_param = EDCAParam[pmlmeinfo->assoc_AP_vendor][trafficIndex];
+			else
+				edca_param = EDCAParam[HT_IOT_PEER_UNKNOWN][trafficIndex];
+
+			rtw_write32(Adapter, REG_EDCA_BE_PARAM, edca_param);
+
+			pDM_Odm->DM_EDCA_Table.prv_traffic_idx = trafficIndex;
+		}
+
+		pDM_Odm->DM_EDCA_Table.bCurrentTurboEDCA = true;
+	} else {
+		/*  Turn Off EDCA turbo here. */
+		/*  Restore original EDCA according to the declaration of AP. */
+		if (pDM_Odm->DM_EDCA_Table.bCurrentTurboEDCA) {
+			rtw_write32(Adapter, REG_EDCA_BE_PARAM, pHalData->AcParam_BE);
+			pDM_Odm->DM_EDCA_Table.bCurrentTurboEDCA = false;
+		}
+	}
+
+dm_CheckEdcaTurbo_EXIT:
+	/*  Set variables for next time. */
+	precvpriv->bIsAnyNonBEPkts = false;
+	pxmitpriv->last_tx_bytes = pxmitpriv->tx_bytes;
+	precvpriv->last_rx_bytes = precvpriv->rx_bytes;
+}
+
 /* 3 Export Interface */
 
 /*  2011/09/21 MH Add to describe different team necessary resource allocate?? */
@@ -874,80 +951,3 @@ void ODM_TXPowerTrackingCheck(struct odm_dm_struct *pDM_Odm)
 		pDM_Odm->RFCalibrateInfo.TM_Trigger = 0;
 	}
 }
-
-void odm_EdcaTurboCheck(struct odm_dm_struct *pDM_Odm)
-{
-	struct adapter *Adapter = pDM_Odm->Adapter;
-	u32	trafficIndex;
-	u32	edca_param;
-	u64	cur_tx_bytes = 0;
-	u64	cur_rx_bytes = 0;
-	u8	bbtchange = false;
-	struct hal_data_8188e *pHalData = &Adapter->haldata;
-	struct xmit_priv		*pxmitpriv = &Adapter->xmitpriv;
-	struct recv_priv		*precvpriv = &Adapter->recvpriv;
-	struct registry_priv	*pregpriv = &Adapter->registrypriv;
-	struct mlme_ext_priv	*pmlmeext = &Adapter->mlmeextpriv;
-	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
-
-	if (!(pDM_Odm->SupportAbility & ODM_MAC_EDCA_TURBO))
-		return;
-
-	if (pregpriv->wifi_spec == 1)
-		goto dm_CheckEdcaTurbo_EXIT;
-
-	if (pmlmeinfo->assoc_AP_vendor >=  HT_IOT_PEER_MAX)
-		goto dm_CheckEdcaTurbo_EXIT;
-
-	/*  Check if the status needs to be changed. */
-	if ((bbtchange) || (!precvpriv->bIsAnyNonBEPkts)) {
-		cur_tx_bytes = pxmitpriv->tx_bytes - pxmitpriv->last_tx_bytes;
-		cur_rx_bytes = precvpriv->rx_bytes - precvpriv->last_rx_bytes;
-
-		/* traffic, TX or RX */
-		if ((pmlmeinfo->assoc_AP_vendor == HT_IOT_PEER_RALINK) ||
-		    (pmlmeinfo->assoc_AP_vendor == HT_IOT_PEER_ATHEROS)) {
-			if (cur_tx_bytes > (cur_rx_bytes << 2)) {
-				/*  Uplink TP is present. */
-				trafficIndex = UP_LINK;
-			} else {
-				/*  Balance TP is present. */
-				trafficIndex = DOWN_LINK;
-			}
-		} else {
-			if (cur_rx_bytes > (cur_tx_bytes << 2)) {
-				/*  Downlink TP is present. */
-				trafficIndex = DOWN_LINK;
-			} else {
-				/*  Balance TP is present. */
-				trafficIndex = UP_LINK;
-			}
-		}
-
-		if ((pDM_Odm->DM_EDCA_Table.prv_traffic_idx != trafficIndex) || (!pDM_Odm->DM_EDCA_Table.bCurrentTurboEDCA)) {
-			if ((pmlmeinfo->assoc_AP_vendor == HT_IOT_PEER_CISCO) && (pmlmeext->cur_wireless_mode & WIRELESS_11_24N))
-				edca_param = EDCAParam[pmlmeinfo->assoc_AP_vendor][trafficIndex];
-			else
-				edca_param = EDCAParam[HT_IOT_PEER_UNKNOWN][trafficIndex];
-
-			rtw_write32(Adapter, REG_EDCA_BE_PARAM, edca_param);
-
-			pDM_Odm->DM_EDCA_Table.prv_traffic_idx = trafficIndex;
-		}
-
-		pDM_Odm->DM_EDCA_Table.bCurrentTurboEDCA = true;
-	} else {
-		/*  Turn Off EDCA turbo here. */
-		/*  Restore original EDCA according to the declaration of AP. */
-		 if (pDM_Odm->DM_EDCA_Table.bCurrentTurboEDCA) {
-			rtw_write32(Adapter, REG_EDCA_BE_PARAM, pHalData->AcParam_BE);
-			pDM_Odm->DM_EDCA_Table.bCurrentTurboEDCA = false;
-		}
-	}
-
-dm_CheckEdcaTurbo_EXIT:
-	/*  Set variables for next time. */
-	precvpriv->bIsAnyNonBEPkts = false;
-	pxmitpriv->last_tx_bytes = pxmitpriv->tx_bytes;
-	precvpriv->last_rx_bytes = precvpriv->rx_bytes;
-}
diff --git a/drivers/staging/r8188eu/include/odm_precomp.h b/drivers/staging/r8188eu/include/odm_precomp.h
index d6046cf9645a..994f5c883979 100644
--- a/drivers/staging/r8188eu/include/odm_precomp.h
+++ b/drivers/staging/r8188eu/include/odm_precomp.h
@@ -31,6 +31,4 @@
 #include "odm_RegConfig8188E.h"
 #include "odm_RTL8188E.h"
 
-void odm_EdcaTurboCheck(struct odm_dm_struct *pDM_Odm);
-
 #endif	/*  __ODM_PRECOMP_H__ */
-- 
2.34.1

