Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB2AB47F51E
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Dec 2021 05:36:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231482AbhLZEco (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Dec 2021 23:32:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231407AbhLZEcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Dec 2021 23:32:43 -0500
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CE5BC061401
        for <linux-kernel@vger.kernel.org>; Sat, 25 Dec 2021 20:32:43 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id o10so11016648qvc.5
        for <linux-kernel@vger.kernel.org>; Sat, 25 Dec 2021 20:32:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=lN1WtRvCeS02H1Pa2m95KqHERaSK5mK0LUfZcaqMQQQ=;
        b=Z5ErTIRShm5GaF7qbk3N814QLw/lqZz/mMlG7E0Bv7nDyHrLHh1vL6+0dqgn8CiXmU
         6RVMOeegGxJwkc3AxsOb9GoExx39MZUqMxPZxk5UMKWE6cEpErdRjKHB5uGg9l2OLcfR
         KqKDkZTiucuZfFf3QRjiCxpiEXT/uvPDhQ86m+JcP1Nh365aGMqhoCjKejtJQHTb2lw4
         gcDYVPoA2yNhY1IUEl8fEzAL+DmaV1PipXb2K2n7+dpu6uP6drMLKbiBMuOeZiarTkg8
         6bNbZBnPBmwJwfbv4rK3SK2QYDoLMKlvuux6TDM1i6J1VaBy0n5CIWXAwD0rwoX8yr/Z
         QvIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=lN1WtRvCeS02H1Pa2m95KqHERaSK5mK0LUfZcaqMQQQ=;
        b=abVQ130ve2iJ60/B7MlUQ5hA18Ukk1/QkYTPpnOeKDNGhe0ed3UKOGcIq7HY/8uo85
         fJqg+HnN/ef8s3GalzhWC+xzkQNnqvjs3uk0iAPFGVL88eyB5PWFrgsMHTpGgfVV9F7r
         MzwxWKhGGA1kCm7vqXZ+vMHQXspRfgO44or03HnbVEiG+RNVAd39kWQJAFeLCFTdBo0K
         6Me/855nHb3H5EndstA70SH8+p6PBDxf62DtRSWPVij9Ygd74UqIlfnAQR96BMxRm6H9
         2LZlPSytmd4WAYmqN4LpF3nApGRvZmn5NT1/Fqp2EPUyLJZ/irRuitHcgxkiFd7EJO/r
         7mkA==
X-Gm-Message-State: AOAM532KyimoAfZ7yS6k652Hb7ekAcSc14+vv7a58+qKNBNz+cog5M8g
        m/tOZNxH8XdE/yf2068HaZc=
X-Google-Smtp-Source: ABdhPJxFrKlE09a851RmvlYbVlCplKyrgVuboumaZaFS9zyquPJhB+foaQRtnYyZaQAPbFOuY55wXg==
X-Received: by 2002:ad4:5de4:: with SMTP id jn4mr10582951qvb.2.1640493162479;
        Sat, 25 Dec 2021 20:32:42 -0800 (PST)
Received: from Agam.localdomain ([2601:402:4500:22e0::928c])
        by smtp.gmail.com with ESMTPSA id f4sm10427341qkp.14.2021.12.25.20.32.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Dec 2021 20:32:42 -0800 (PST)
Date:   Sat, 25 Dec 2021 23:32:39 -0500
From:   Agam Kohli <agamkohli9@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Staging: rtl871: rtl871x_mlme: fixed coding style issues
Message-ID: <YcfwZ2J3p80HzsTv@Agam.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed multiple line dereferences

Signed-off-by: Agam Kohli <agamkohli9@gmail.com>
---
 drivers/staging/rtl8712/rtl871x_mlme.c | 125 ++++++++++---------------
 1 file changed, 49 insertions(+), 76 deletions(-)

diff --git a/drivers/staging/rtl8712/rtl871x_mlme.c b/drivers/staging/rtl8712/rtl871x_mlme.c
index cabdb3549a5a..a2ced1b54ab5 100644
--- a/drivers/staging/rtl8712/rtl871x_mlme.c
+++ b/drivers/staging/rtl8712/rtl871x_mlme.c
@@ -1,6 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
 /******************************************************************************
- * rtl871x_mlme.c
  *
  * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
  * Linux device driver for RTL8192SU
@@ -124,7 +123,6 @@ static void free_network_nolock(struct mlme_priv *pmlmepriv,
 	pmlmepriv->num_of_scanned--;
 }
 
-
 /* return the wlan_network with the matching addr
  * Shall be called under atomic context...
  * to avoid possible racing condition...
@@ -140,13 +138,13 @@ static struct wlan_network *r8712_find_network(struct  __queue *scanned_queue,
 		return NULL;
 	spin_lock_irqsave(&scanned_queue->lock, irqL);
 	phead = &scanned_queue->queue;
-	plist = phead->next;
-	while (plist != phead) {
-		pnetwork = container_of(plist, struct wlan_network, list);
-		plist = plist->next;
+	list_for_each(plist, phead) {
+		pnetwork = list_entry(plist, struct wlan_network, list);
 		if (!memcmp(addr, pnetwork->network.MacAddress, ETH_ALEN))
 			break;
 	}
+	if (plist == phead)
+		pnetwork = NULL;
 	spin_unlock_irqrestore(&scanned_queue->lock, irqL);
 	return pnetwork;
 }
@@ -249,8 +247,8 @@ static int is_same_network(struct wlan_bssid_ex *src,
 			  src->Ssid.SsidLength))) &&
 			((s_cap & WLAN_CAPABILITY_IBSS) ==
 			(d_cap & WLAN_CAPABILITY_IBSS)) &&
-			((s_cap & WLAN_CAPABILITY_BSS) ==
-			(d_cap & WLAN_CAPABILITY_BSS));
+			((s_cap & WLAN_CAPABILITY_ESS) ==
+			(d_cap & WLAN_CAPABILITY_ESS));
 
 }
 
@@ -264,13 +262,13 @@ struct	wlan_network *r8712_get_oldest_wlan_network(
 	phead = &scanned_queue->queue;
 	plist = phead->next;
 	while (1) {
-		if (end_of_queue_search(phead, plist) ==  true)
+		if (end_of_queue_search(phead, plist))
 			break;
 		pwlan = container_of(plist, struct wlan_network, list);
-		if (pwlan->fixed != true) {
-			if (oldest == NULL ||
+		if (!pwlan->fixed) {
+			if (!oldest ||
 			    time_after((unsigned long)oldest->last_scanned,
-			    (unsigned long)pwlan->last_scanned))
+				       (unsigned long)pwlan->last_scanned))
 				oldest = pwlan;
 		}
 		plist = plist->next;
@@ -358,7 +356,6 @@ static void update_scanned_network(struct _adapter *adapter,
 		plist = plist->next;
 	}
 
-
 	/* If we didn't find a match, then get a new network slot to initialize
 	 * with this beacon's information
 	 */
@@ -433,8 +430,7 @@ static int is_desired_network(struct _adapter *adapter,
 		bselected = false;
 	if (check_fwstate(&adapter->mlmepriv, WIFI_ADHOC_STATE)) {
 		if (pnetwork->network.InfrastructureMode !=
-			adapter->mlmepriv.cur_network.network.
-			InfrastructureMode)
+			adapter->mlmepriv.cur_network.network.InfrastructureMode)
 			bselected = false;
 	}
 	return bselected;
@@ -541,8 +537,7 @@ void r8712_surveydone_event_callback(struct _adapter *adapter, u8 *pbuf)
 					struct wlan_bssid_ex *pdev_network =
 					  &(adapter->registrypriv.dev_network);
 					u8 *pibss =
-						 adapter->registrypriv.
-							dev_network.MacAddress;
+						 adapter->registrypriv.dev_network.MacAddress;
 					pmlmepriv->fw_state ^= _FW_UNDER_SURVEY;
 					memcpy(&pdev_network->Ssid,
 						&pmlmepriv->assoc_ssid,
@@ -621,7 +616,6 @@ void r8712_indicate_connect(struct _adapter *padapter)
 			  jiffies + msecs_to_jiffies(60000));
 }
 
-
 /*
  * r8712_ind_disconnect: the caller has to lock pmlmepriv->lock
  */
@@ -691,11 +685,9 @@ void r8712_joinbss_event_callback(struct _adapter *adapter, u8 *pbuf)
 	pnetwork->network.Configuration.DSConfig =
 		 le32_to_cpu(pnetwork->network.Configuration.DSConfig);
 	pnetwork->network.Configuration.FHConfig.DwellTime =
-		 le32_to_cpu(pnetwork->network.Configuration.FHConfig.
-			     DwellTime);
+		 le32_to_cpu(pnetwork->network.Configuration.FHConfig.DwellTime);
 	pnetwork->network.Configuration.FHConfig.HopPattern =
-		 le32_to_cpu(pnetwork->network.Configuration.
-			     FHConfig.HopPattern);
+		 le32_to_cpu(pnetwork->network.Configuration.FHConfig.HopPattern);
 	pnetwork->network.Configuration.FHConfig.HopSet =
 		 le32_to_cpu(pnetwork->network.Configuration.FHConfig.HopSet);
 	pnetwork->network.Configuration.FHConfig.Length =
@@ -720,41 +712,35 @@ void r8712_joinbss_event_callback(struct _adapter *adapter, u8 *pbuf)
 			if (check_fwstate(pmlmepriv, _FW_LINKED)) {
 				if (the_same_macaddr) {
 					ptarget_wlan =
-					    r8712_find_network(&pmlmepriv->
-					    scanned_queue,
+					    r8712_find_network(&pmlmepriv->scanned_queue,
 					    cur_network->network.MacAddress);
 				} else {
 					pcur_wlan =
-					     r8712_find_network(&pmlmepriv->
-					     scanned_queue,
+					     r8712_find_network(&pmlmepriv->scanned_queue,
 					     cur_network->network.MacAddress);
-					pcur_wlan->fixed = false;
+					if (pcur_wlan)
+						pcur_wlan->fixed = false;
 
 					pcur_sta = r8712_get_stainfo(pstapriv,
 					     cur_network->network.MacAddress);
-					spin_lock_irqsave(&pstapriv->
-						sta_hash_lock, irqL2);
+					spin_lock_irqsave(&pstapriv->sta_hash_lock, irqL2);
 					r8712_free_stainfo(adapter, pcur_sta);
-					spin_unlock_irqrestore(&(pstapriv->
-						sta_hash_lock), irqL2);
+					spin_unlock_irqrestore(&(pstapriv->sta_hash_lock), irqL2);
 
 					ptarget_wlan =
-						 r8712_find_network(&pmlmepriv->
-						 scanned_queue,
-						 pnetwork->network.
-						 MacAddress);
+						 r8712_find_network(&pmlmepriv->scanned_queue,
+						 pnetwork->network.MacAddress);
 					if (ptarget_wlan)
 						ptarget_wlan->fixed = true;
 				}
 			} else {
-				ptarget_wlan = r8712_find_network(&pmlmepriv->
-						scanned_queue,
+				ptarget_wlan = r8712_find_network(&pmlmepriv->scanned_queue,
 						pnetwork->network.MacAddress);
 				if (ptarget_wlan)
 					ptarget_wlan->fixed = true;
 			}
 
-			if (ptarget_wlan == NULL) {
+			if (!ptarget_wlan) {
 				if (check_fwstate(pmlmepriv,
 					_FW_UNDER_LINKING))
 					pmlmepriv->fw_state ^=
@@ -768,7 +754,7 @@ void r8712_joinbss_event_callback(struct _adapter *adapter, u8 *pbuf)
 					ptarget_sta =
 						 r8712_get_stainfo(pstapriv,
 						 pnetwork->network.MacAddress);
-					if (ptarget_sta == NULL)
+					if (!ptarget_sta)
 						ptarget_sta =
 						 r8712_alloc_stainfo(pstapriv,
 						 pnetwork->network.MacAddress);
@@ -781,39 +767,29 @@ void r8712_joinbss_event_callback(struct _adapter *adapter, u8 *pbuf)
 					ptarget_sta->aid = pnetwork->join_res;
 					ptarget_sta->qos_option = 1;
 					ptarget_sta->mac_id = 5;
-					if (adapter->securitypriv.
-					    AuthAlgrthm == 2) {
-						adapter->securitypriv.
-							binstallGrpkey =
+					if (adapter->securitypriv.AuthAlgrthm == 2) {
+						adapter->securitypriv.binstallGrpkey =
 							 false;
-						adapter->securitypriv.
-							busetkipkey =
+						adapter->securitypriv.busetkipkey =
 							 false;
-						adapter->securitypriv.
-							bgrpkey_handshake =
+						adapter->securitypriv.bgrpkey_handshake =
 							 false;
 						ptarget_sta->ieee8021x_blocked
 							 = true;
 						ptarget_sta->XPrivacy =
-							 adapter->securitypriv.
-							 PrivacyAlgrthm;
-						memset((u8 *)&ptarget_sta->
-							 x_UncstKey,
+							 adapter->securitypriv. PrivacyAlgrthm;
+						memset((u8 *)&ptarget_sta->x_UncstKey,
 							 0,
 							 sizeof(union Keytype));
-						memset((u8 *)&ptarget_sta->
-							 tkiprxmickey,
+						memset((u8 *)&ptarget_sta->tkiprxmickey,
 							 0,
 							 sizeof(union Keytype));
-						memset((u8 *)&ptarget_sta->
-							 tkiptxmickey,
+						memset((u8 *)&ptarget_sta->tkiptxmickey,
 							 0,
 							 sizeof(union Keytype));
-						memset((u8 *)&ptarget_sta->
-							 txpn, 0,
+						memset((u8 *)&ptarget_sta->txpn, 0,
 							 sizeof(union pn48));
-						memset((u8 *)&ptarget_sta->
-							 rxpn, 0,
+						memset((u8 *)&ptarget_sta->rxpn, 0,
 							 sizeof(union pn48));
 					}
 				} else {
@@ -879,7 +855,7 @@ void r8712_stassoc_event_callback(struct _adapter *adapter, u8 *pbuf)
 	if (!r8712_access_ctrl(&adapter->acl_list, pstassoc->macaddr))
 		return;
 	psta = r8712_get_stainfo(&adapter->stapriv, pstassoc->macaddr);
-	if (psta != NULL) {
+	if (psta) {
 		/*the sta have been in sta_info_queue => do nothing
 		 *(between drv has received this event before and
 		 * fw have not yet to set key to CAM_ENTRY)
@@ -888,7 +864,7 @@ void r8712_stassoc_event_callback(struct _adapter *adapter, u8 *pbuf)
 	}
 
 	psta = r8712_alloc_stainfo(&adapter->stapriv, pstassoc->macaddr);
-	if (psta == NULL)
+	if (!psta)
 		return;
 	/* to do : init sta_info variable */
 	psta->qos_option = 0;
@@ -944,8 +920,7 @@ void r8712_stadel_event_callback(struct _adapter *adapter, u8 *pbuf)
 			pdev_network = &(adapter->registrypriv.dev_network);
 			pibss = adapter->registrypriv.dev_network.MacAddress;
 			memcpy(pdev_network, &tgt_network->network,
-				r8712_get_wlan_bssid_ex_sz(&tgt_network->
-							network));
+				r8712_get_wlan_bssid_ex_sz(&tgt_network->network));
 			memcpy(&pdev_network->Ssid,
 				&pmlmepriv->assoc_ssid,
 				sizeof(struct ndis_802_11_ssid));
@@ -1080,8 +1055,7 @@ int r8712_select_and_join_from_scan(struct mlme_priv *pmlmepriv)
 	pmlmepriv->pscanned = phead->next;
 	while (1) {
 		if (end_of_queue_search(phead, pmlmepriv->pscanned)) {
-			if ((pmlmepriv->assoc_by_rssi) &&
-			    (pnetwork_max_rssi != NULL)) {
+			if (pmlmepriv->assoc_by_rssi && pnetwork_max_rssi) {
 				pnetwork = pnetwork_max_rssi;
 				goto ask_for_joinbss;
 			}
@@ -1095,8 +1069,7 @@ int r8712_select_and_join_from_scan(struct mlme_priv *pmlmepriv)
 			src_ssid = pmlmepriv->assoc_bssid;
 			if (!memcmp(dst_ssid, src_ssid, ETH_ALEN)) {
 				if (check_fwstate(pmlmepriv, _FW_LINKED)) {
-					if (is_same_network(&pmlmepriv->
-					    cur_network.network,
+					if (is_same_network(&pmlmepriv->cur_network.network,
 					    &pnetwork->network)) {
 						_clr_fwstate_(pmlmepriv,
 							_FW_UNDER_LINKING);
@@ -1650,25 +1623,25 @@ unsigned int r8712_restructure_ht_ie(struct _adapter *padapter, u8 *in_ie,
 	struct ht_priv *phtpriv = &pmlmepriv->htpriv;
 
 	phtpriv->ht_option = 0;
-	p = r8712_get_ie(in_ie + 12, _HT_CAPABILITY_IE_, &ielen, in_len - 12);
+	p = r8712_get_ie(in_ie + 12, WLAN_EID_HT_CAPABILITY, &ielen, in_len - 12);
 	if (p && (ielen > 0)) {
 		if (pqospriv->qos_option == 0) {
 			out_len = *pout_len;
-			r8712_set_ie(out_ie + out_len, _VENDOR_SPECIFIC_IE_,
+			r8712_set_ie(out_ie + out_len, WLAN_EID_VENDOR_SPECIFIC,
 				     _WMM_IE_Length_, WMM_IE, pout_len);
 			pqospriv->qos_option = 1;
 		}
 		out_len = *pout_len;
 		memset(&ht_capie, 0, sizeof(struct ieee80211_ht_cap));
-		ht_capie.cap_info = cpu_to_le16(IEEE80211_HT_CAP_SUP_WIDTH |
+		ht_capie.cap_info = cpu_to_le16(IEEE80211_HT_CAP_SUP_WIDTH_20_40 |
 				    IEEE80211_HT_CAP_SGI_20 |
 				    IEEE80211_HT_CAP_SGI_40 |
 				    IEEE80211_HT_CAP_TX_STBC |
 				    IEEE80211_HT_CAP_MAX_AMSDU |
 				    IEEE80211_HT_CAP_DSSSCCK40);
-		ht_capie.ampdu_params_info = (IEEE80211_HT_CAP_AMPDU_FACTOR &
-				0x03) | (IEEE80211_HT_CAP_AMPDU_DENSITY & 0x00);
-		r8712_set_ie(out_ie + out_len, _HT_CAPABILITY_IE_,
+		ht_capie.ampdu_params_info = (IEEE80211_HT_AMPDU_PARM_FACTOR &
+				0x03) | (IEEE80211_HT_AMPDU_PARM_DENSITY & 0x00);
+		r8712_set_ie(out_ie + out_len, WLAN_EID_HT_CAPABILITY,
 			     sizeof(struct ieee80211_ht_cap),
 			     (unsigned char *)&ht_capie, pout_len);
 		phtpriv->ht_option = 1;
@@ -1699,13 +1672,13 @@ static void update_ht_cap(struct _adapter *padapter, u8 *pie, uint ie_len)
 	/*check Max Rx A-MPDU Size*/
 	len = 0;
 	p = r8712_get_ie(pie + sizeof(struct NDIS_802_11_FIXED_IEs),
-				_HT_CAPABILITY_IE_,
+				WLAN_EID_HT_CAPABILITY,
 				&len, ie_len -
 				sizeof(struct NDIS_802_11_FIXED_IEs));
 	if (p && len > 0) {
 		pht_capie = (struct ieee80211_ht_cap *)(p + 2);
 		max_ampdu_sz = (pht_capie->ampdu_params_info &
-				IEEE80211_HT_CAP_AMPDU_FACTOR);
+				IEEE80211_HT_AMPDU_PARM_FACTOR);
 		/* max_ampdu_sz (kbytes); */
 		max_ampdu_sz = 1 << (max_ampdu_sz + 3);
 		phtpriv->rx_ampdu_maxlen = max_ampdu_sz;
@@ -1734,7 +1707,7 @@ static void update_ht_cap(struct _adapter *padapter, u8 *pie, uint ie_len)
 	}
 	len = 0;
 	p = r8712_get_ie(pie + sizeof(struct NDIS_802_11_FIXED_IEs),
-		   _HT_ADD_INFO_IE_, &len,
+		   WLAN_EID_HT_OPERATION, &len,
 		   ie_len - sizeof(struct NDIS_802_11_FIXED_IEs));
 }
 
-- 
2.34.1

