Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AF7B530463
	for <lists+linux-kernel@lfdr.de>; Sun, 22 May 2022 18:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237833AbiEVQOf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 12:14:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbiEVQOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 12:14:32 -0400
X-Greylist: delayed 389 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 22 May 2022 09:14:30 PDT
Received: from shout01.mail.de (shout01.mail.de [IPv6:2001:868:100:600::216])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 554DE3335C
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 09:14:30 -0700 (PDT)
Received: from postfix01.mail.de (postfix01.bt.mail.de [10.0.121.125])
        by shout01.mail.de (Postfix) with ESMTP id F0896A058B;
        Sun, 22 May 2022 18:07:57 +0200 (CEST)
Received: from smtp03.mail.de (smtp03.bt.mail.de [10.0.121.213])
        by postfix01.mail.de (Postfix) with ESMTP id D2FCD8015B;
        Sun, 22 May 2022 18:07:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mail.de;
        s=mailde202009; t=1653235677;
        bh=3WYDi/GoMErwRVlUMIMxcAkTtM7COWBheMSkeoSjw+0=;
        h=From:To:Cc:Subject:Date:Message-Id:From:To:CC:Subject:Reply-To;
        b=0UxBbzFeJzcq3nCm67ZG5xR75sKcG7kygB+PwWp+Pdi4MHPB5+Z2UdNtLPyXHfOWg
         YmGo3bg3G9FRwyamrge3VwufxNJHyvTAdXcaX977DT+vt9ISQ5X5tQoKm7IBweEnp6
         kZ/YyObiPObbdXyrv8I7anEuaYhWhWzXAvKIrtITk3nUTcALWzrnIR7UkpT0njSr21
         TWgg/TC9QEgcyZ/jvbX4Gxahc53c0Z5xVzN/2EbgSr/v/71zXTZ4r8lv6j7yTxOM6I
         qo4v8mQAtbnUT8aKBz4qEP9ALJALa+P43jDxPyx6EcltCa5hYbJOs7wazzySTFViS0
         lrACxjyNDMeLQ==
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp03.mail.de (Postfix) with ESMTPSA id 170CAA03C6;
        Sun, 22 May 2022 18:07:53 +0200 (CEST)
From:   Hannes Braun <hannesbraun@mail.de>
To:     gregkh@linuxfoundation.org, hdegoede@redhat.com,
        Larry.Finger@lwfinger.net
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        fabioaiuto83@gmail.com, dan.carpenter@oracle.com,
        Hannes Braun <hannesbraun@mail.de>
Subject: [PATCH] staging: rtl8723bs: fix placement of braces
Date:   Sun, 22 May 2022 18:06:11 +0200
Message-Id: <20220522160611.11568-1-hannesbraun@mail.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-purgate: clean
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate-type: clean
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate: clean
X-purgate-size: 22248
X-purgate-ID: 154282::1653235677-0000061A-2801598E/0/0
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch should eliminate the following errors/warnings emitted by
checkpatch.pl:
- that open brace { should be on the previous line
- else should follow close brace '}'
- braces {} are not necessary for single statement blocks

Signed-off-by: Hannes Braun <hannesbraun@mail.de>
---
 .../staging/rtl8723bs/os_dep/ioctl_cfg80211.c | 219 ++++++------------
 1 file changed, 65 insertions(+), 154 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
index 43b5604c0bca..c6932fad037e 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
@@ -366,9 +366,8 @@ void rtw_cfg80211_ibss_indicate_connect(struct adapter *padapter)
 	int freq = (int)cur_network->network.configuration.ds_config;
 	struct ieee80211_channel *chan;
 
-	if (pwdev->iftype != NL80211_IFTYPE_ADHOC) {
+	if (pwdev->iftype != NL80211_IFTYPE_ADHOC)
 		return;
-	}
 
 	if (!rtw_cfg80211_check_bss(padapter)) {
 		struct wlan_bssid_ex  *pnetwork = &(padapter->mlmeextpriv.mlmext_info.network);
@@ -544,9 +543,8 @@ static int rtw_cfg80211_ap_set_encryption(struct net_device *dev, struct ieee_pa
 			goto exit;
 		}
 
-		if (wep_key_len > 0) {
+		if (wep_key_len > 0)
 			wep_key_len = wep_key_len <= 5 ? 5 : 13;
-		}
 
 		if (psecuritypriv->bWepDefaultKeyIdxSet == 0) {
 			/* wep default key has not been set, so use this key index as default key. */
@@ -582,9 +580,8 @@ static int rtw_cfg80211_ap_set_encryption(struct net_device *dev, struct ieee_pa
 				memcpy(grpkey, param->u.crypt.key, (param->u.crypt.key_len > 16 ? 16 : param->u.crypt.key_len));
 
 				psecuritypriv->dot118021XGrpPrivacy = _WEP40_;
-				if (param->u.crypt.key_len == 13) {
+				if (param->u.crypt.key_len == 13)
 						psecuritypriv->dot118021XGrpPrivacy = _WEP104_;
-				}
 
 			} else if (strcmp(param->u.crypt.alg, "TKIP") == 0) {
 				psecuritypriv->dot118021XGrpPrivacy = _TKIP_;
@@ -626,24 +623,16 @@ static int rtw_cfg80211_ap_set_encryption(struct net_device *dev, struct ieee_pa
 
 	}
 
-	if (psecuritypriv->dot11AuthAlgrthm == dot11AuthAlgrthm_8021X && psta) /*  psk/802_1x */
-	{
-		if (check_fwstate(pmlmepriv, WIFI_AP_STATE))
-		{
-			if (param->u.crypt.set_tx == 1) /* pairwise key */
-			{
+	if (psecuritypriv->dot11AuthAlgrthm == dot11AuthAlgrthm_8021X && psta) { /*  psk/802_1x */
+		if (check_fwstate(pmlmepriv, WIFI_AP_STATE)) {
+			if (param->u.crypt.set_tx == 1) { /* pairwise key */
 				memcpy(psta->dot118021x_UncstKey.skey, param->u.crypt.key, (param->u.crypt.key_len > 16 ? 16 : param->u.crypt.key_len));
 
-				if (strcmp(param->u.crypt.alg, "WEP") == 0)
-				{
+				if (strcmp(param->u.crypt.alg, "WEP") == 0) {
 					psta->dot118021XPrivacy = _WEP40_;
 					if (param->u.crypt.key_len == 13)
-					{
 						psta->dot118021XPrivacy = _WEP104_;
-					}
-				}
-				else if (strcmp(param->u.crypt.alg, "TKIP") == 0)
-				{
+				} else if (strcmp(param->u.crypt.alg, "TKIP") == 0) {
 					psta->dot118021XPrivacy = _TKIP_;
 
 					/* DEBUG_ERR("set key length :param->u.crypt.key_len =%d\n", param->u.crypt.key_len); */
@@ -653,14 +642,10 @@ static int rtw_cfg80211_ap_set_encryption(struct net_device *dev, struct ieee_pa
 
 					psecuritypriv->busetkipkey = true;
 
-				}
-				else if (strcmp(param->u.crypt.alg, "CCMP") == 0)
-				{
+				} else if (strcmp(param->u.crypt.alg, "CCMP") == 0) {
 
 					psta->dot118021XPrivacy = _AES_;
-				}
-				else
-				{
+				} else {
 					psta->dot118021XPrivacy = _NO_PRIVACY_;
 				}
 
@@ -670,21 +655,14 @@ static int rtw_cfg80211_ap_set_encryption(struct net_device *dev, struct ieee_pa
 
 				psta->bpairwise_key_installed = true;
 
-			}
-			else/* group key??? */
-			{
-				if (strcmp(param->u.crypt.alg, "WEP") == 0)
-				{
+			} else { /* group key??? */
+				if (strcmp(param->u.crypt.alg, "WEP") == 0) {
 					memcpy(grpkey, param->u.crypt.key, (param->u.crypt.key_len > 16 ? 16 : param->u.crypt.key_len));
 
 					psecuritypriv->dot118021XGrpPrivacy = _WEP40_;
 					if (param->u.crypt.key_len == 13)
-					{
 						psecuritypriv->dot118021XGrpPrivacy = _WEP104_;
-					}
-				}
-				else if (strcmp(param->u.crypt.alg, "TKIP") == 0)
-				{
+				} else if (strcmp(param->u.crypt.alg, "TKIP") == 0) {
 					psecuritypriv->dot118021XGrpPrivacy = _TKIP_;
 
 					memcpy(grpkey, param->u.crypt.key, (param->u.crypt.key_len > 16 ? 16 : param->u.crypt.key_len));
@@ -696,15 +674,11 @@ static int rtw_cfg80211_ap_set_encryption(struct net_device *dev, struct ieee_pa
 
 					psecuritypriv->busetkipkey = true;
 
-				}
-				else if (strcmp(param->u.crypt.alg, "CCMP") == 0)
-				{
+				} else if (strcmp(param->u.crypt.alg, "CCMP") == 0) {
 					psecuritypriv->dot118021XGrpPrivacy = _AES_;
 
 					memcpy(grpkey, param->u.crypt.key, (param->u.crypt.key_len > 16 ? 16 : param->u.crypt.key_len));
-				}
-				else
-				{
+				} else {
 					psecuritypriv->dot118021XGrpPrivacy = _NO_PRIVACY_;
 				}
 
@@ -717,8 +691,7 @@ static int rtw_cfg80211_ap_set_encryption(struct net_device *dev, struct ieee_pa
 				rtw_ap_set_group_key(padapter, param->u.crypt.key, psecuritypriv->dot118021XGrpPrivacy, param->u.crypt.idx);
 
 				pbcmc_sta = rtw_get_bcmc_stainfo(padapter);
-				if (pbcmc_sta)
-				{
+				if (pbcmc_sta) {
 					pbcmc_sta->ieee8021x_blocked = false;
 					pbcmc_sta->dot118021XPrivacy = psecuritypriv->dot118021XGrpPrivacy;/* rx will use bmc_sta's dot118021XPrivacy */
 				}
@@ -746,20 +719,17 @@ static int rtw_cfg80211_set_encryption(struct net_device *dev, struct ieee_param
 	param->u.crypt.err = 0;
 	param->u.crypt.alg[IEEE_CRYPT_ALG_NAME_LEN - 1] = '\0';
 
-	if (param_len < (u32) ((u8 *) param->u.crypt.key - (u8 *) param) + param->u.crypt.key_len)
-	{
+	if (param_len < (u32) ((u8 *) param->u.crypt.key - (u8 *) param) + param->u.crypt.key_len) {
 		ret =  -EINVAL;
 		goto exit;
 	}
 
 	if (param->sta_addr[0] == 0xff && param->sta_addr[1] == 0xff &&
 	    param->sta_addr[2] == 0xff && param->sta_addr[3] == 0xff &&
-	    param->sta_addr[4] == 0xff && param->sta_addr[5] == 0xff)
-	{
+	    param->sta_addr[4] == 0xff && param->sta_addr[5] == 0xff) {
 		if (param->u.crypt.idx >= WEP_KEYS
 			|| param->u.crypt.idx >= BIP_MAX_KEYID
-		)
-		{
+		) {
 			ret = -EINVAL;
 			goto exit;
 		}
@@ -770,19 +740,16 @@ static int rtw_cfg80211_set_encryption(struct net_device *dev, struct ieee_param
 	}
 	}
 
-	if (strcmp(param->u.crypt.alg, "WEP") == 0)
-	{
+	if (strcmp(param->u.crypt.alg, "WEP") == 0) {
 		wep_key_idx = param->u.crypt.idx;
 		wep_key_len = param->u.crypt.key_len;
 
-		if ((wep_key_idx >= WEP_KEYS) || (wep_key_len <= 0))
-		{
+		if ((wep_key_idx >= WEP_KEYS) || (wep_key_len <= 0)) {
 			ret = -EINVAL;
 			goto exit;
 		}
 
-		if (psecuritypriv->bWepDefaultKeyIdxSet == 0)
-		{
+		if (psecuritypriv->bWepDefaultKeyIdxSet == 0) {
 			/* wep default key has not been set, so use this key index as default key. */
 
 			wep_key_len = wep_key_len <= 5 ? 5 : 13;
@@ -791,8 +758,7 @@ static int rtw_cfg80211_set_encryption(struct net_device *dev, struct ieee_param
 			psecuritypriv->dot11PrivacyAlgrthm = _WEP40_;
 			psecuritypriv->dot118021XGrpPrivacy = _WEP40_;
 
-			if (wep_key_len == 13)
-			{
+			if (wep_key_len == 13) {
 				psecuritypriv->dot11PrivacyAlgrthm = _WEP104_;
 				psecuritypriv->dot118021XGrpPrivacy = _WEP104_;
 			}
@@ -809,13 +775,11 @@ static int rtw_cfg80211_set_encryption(struct net_device *dev, struct ieee_param
 		goto exit;
 	}
 
-	if (padapter->securitypriv.dot11AuthAlgrthm == dot11AuthAlgrthm_8021X) /*  802_1x */
-	{
+	if (padapter->securitypriv.dot11AuthAlgrthm == dot11AuthAlgrthm_8021X) { /*  802_1x */
 		struct sta_info *psta, *pbcmc_sta;
 		struct sta_priv *pstapriv = &padapter->stapriv;
 
-		if (check_fwstate(pmlmepriv, WIFI_STATION_STATE | WIFI_MP_STATE) == true) /* sta mode */
-		{
+		if (check_fwstate(pmlmepriv, WIFI_STATION_STATE | WIFI_MP_STATE) == true) { /* sta mode */
 			psta = rtw_get_stainfo(pstapriv, get_bssid(pmlmepriv));
 			if (psta) {
 				/* Jeff: don't disable ieee8021x_blocked while clearing key */
@@ -824,18 +788,15 @@ static int rtw_cfg80211_set_encryption(struct net_device *dev, struct ieee_param
 
 
 				if ((padapter->securitypriv.ndisencryptstatus == Ndis802_11Encryption2Enabled) ||
-						(padapter->securitypriv.ndisencryptstatus ==  Ndis802_11Encryption3Enabled))
-				{
+						(padapter->securitypriv.ndisencryptstatus ==  Ndis802_11Encryption3Enabled)) {
 					psta->dot118021XPrivacy = padapter->securitypriv.dot11PrivacyAlgrthm;
 				}
 
-				if (param->u.crypt.set_tx == 1)/* pairwise key */
-				{
+				if (param->u.crypt.set_tx == 1) { /* pairwise key */
 
 					memcpy(psta->dot118021x_UncstKey.skey, param->u.crypt.key, (param->u.crypt.key_len > 16 ? 16 : param->u.crypt.key_len));
 
-					if (strcmp(param->u.crypt.alg, "TKIP") == 0)/* set mic key */
-					{
+					if (strcmp(param->u.crypt.alg, "TKIP") == 0) { /* set mic key */
 						/* DEBUG_ERR(("\nset key length :param->u.crypt.key_len =%d\n", param->u.crypt.key_len)); */
 						memcpy(psta->dot11tkiptxmickey.skey, &(param->u.crypt.key[16]), 8);
 						memcpy(psta->dot11tkiprxmickey.skey, &(param->u.crypt.key[24]), 8);
@@ -845,11 +806,8 @@ static int rtw_cfg80211_set_encryption(struct net_device *dev, struct ieee_param
 					}
 
 					rtw_setstakey_cmd(padapter, psta, true, true);
-				}
-				else/* group key */
-				{
-					if (strcmp(param->u.crypt.alg, "TKIP") == 0 || strcmp(param->u.crypt.alg, "CCMP") == 0)
-					{
+				} else { /* group key */
+					if (strcmp(param->u.crypt.alg, "TKIP") == 0 || strcmp(param->u.crypt.alg, "CCMP") == 0) {
 						memcpy(padapter->securitypriv.dot118021XGrpKey[param->u.crypt.idx].skey, param->u.crypt.key, (param->u.crypt.key_len > 16 ? 16 : param->u.crypt.key_len));
 						memcpy(padapter->securitypriv.dot118021XGrptxmickey[param->u.crypt.idx].skey, &(param->u.crypt.key[16]), 8);
 						memcpy(padapter->securitypriv.dot118021XGrprxmickey[param->u.crypt.idx].skey, &(param->u.crypt.key[24]), 8);
@@ -857,9 +815,7 @@ static int rtw_cfg80211_set_encryption(struct net_device *dev, struct ieee_param
 
 						padapter->securitypriv.dot118021XGrpKeyid = param->u.crypt.idx;
 						rtw_set_key(padapter, &padapter->securitypriv, param->u.crypt.idx, 1, true);
-					}
-					else if (strcmp(param->u.crypt.alg, "BIP") == 0)
-					{
+					} else if (strcmp(param->u.crypt.alg, "BIP") == 0) {
 						/* save the IGTK key, length 16 bytes */
 						memcpy(padapter->securitypriv.dot11wBIPKey[param->u.crypt.idx].skey, param->u.crypt.key, (param->u.crypt.key_len > 16 ? 16 : param->u.crypt.key_len));
 						/*
@@ -873,25 +829,19 @@ static int rtw_cfg80211_set_encryption(struct net_device *dev, struct ieee_param
 			}
 
 			pbcmc_sta = rtw_get_bcmc_stainfo(padapter);
-			if (!pbcmc_sta)
-			{
+			if (!pbcmc_sta) {
 				/* DEBUG_ERR(("Set OID_802_11_ADD_KEY: bcmc stainfo is null\n")); */
-			}
-			else
-			{
+			} else {
 				/* Jeff: don't disable ieee8021x_blocked while clearing key */
 				if (strcmp(param->u.crypt.alg, "none") != 0)
 					pbcmc_sta->ieee8021x_blocked = false;
 
 				if ((padapter->securitypriv.ndisencryptstatus == Ndis802_11Encryption2Enabled) ||
-						(padapter->securitypriv.ndisencryptstatus ==  Ndis802_11Encryption3Enabled))
-				{
+						(padapter->securitypriv.ndisencryptstatus ==  Ndis802_11Encryption3Enabled)) {
 					pbcmc_sta->dot118021XPrivacy = padapter->securitypriv.dot11PrivacyAlgrthm;
 				}
 			}
-		}
-		else if (check_fwstate(pmlmepriv, WIFI_ADHOC_STATE)) /* adhoc mode */
-		{
+		} else if (check_fwstate(pmlmepriv, WIFI_ADHOC_STATE)) { /* adhoc mode */
 		}
 	}
 
@@ -949,39 +899,29 @@ static int cfg80211_rtw_add_key(struct wiphy *wiphy, struct net_device *ndev,
 
 
 	if (!mac_addr || is_broadcast_ether_addr(mac_addr))
-	{
 		param->u.crypt.set_tx = 0; /* for wpa/wpa2 group key */
-	} else {
+	else
 		param->u.crypt.set_tx = 1; /* for wpa/wpa2 pairwise key */
-	}
 
 	param->u.crypt.idx = key_index;
 
 	if (params->seq_len && params->seq)
-	{
 		memcpy(param->u.crypt.seq, (u8 *)params->seq, params->seq_len);
-	}
 
-	if (params->key_len && params->key)
-	{
+	if (params->key_len && params->key) {
 		param->u.crypt.key_len = params->key_len;
 		memcpy(param->u.crypt.key, (u8 *)params->key, params->key_len);
 	}
 
-	if (check_fwstate(pmlmepriv, WIFI_STATION_STATE) == true)
-	{
+	if (check_fwstate(pmlmepriv, WIFI_STATION_STATE) == true) {
 		ret =  rtw_cfg80211_set_encryption(ndev, param, param_len);
-	}
-	else if (check_fwstate(pmlmepriv, WIFI_AP_STATE) == true)
-	{
+	} else if (check_fwstate(pmlmepriv, WIFI_AP_STATE) == true) {
 		if (mac_addr)
 			memcpy(param->sta_addr, (void *)mac_addr, ETH_ALEN);
 
 		ret = rtw_cfg80211_ap_set_encryption(ndev, param, param_len);
-	}
-        else if (check_fwstate(pmlmepriv, WIFI_ADHOC_STATE) == true
-                || check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE) == true)
-        {
+	} else if (check_fwstate(pmlmepriv, WIFI_ADHOC_STATE) == true
+                || check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE) == true) {
                 ret =  rtw_cfg80211_set_encryption(ndev, param, param_len);
         }
 
@@ -1007,8 +947,7 @@ static int cfg80211_rtw_del_key(struct wiphy *wiphy, struct net_device *ndev,
 	struct adapter *padapter = rtw_netdev_priv(ndev);
 	struct security_priv *psecuritypriv = &padapter->securitypriv;
 
-	if (key_index == psecuritypriv->dot11PrivacyKeyIndex)
-	{
+	if (key_index == psecuritypriv->dot11PrivacyKeyIndex) {
 		/* clear the flag of wep default key set. */
 		psecuritypriv->bWepDefaultKeyIdxSet = 0;
 	}
@@ -1024,16 +963,14 @@ static int cfg80211_rtw_set_default_key(struct wiphy *wiphy,
 	struct adapter *padapter = rtw_netdev_priv(ndev);
 	struct security_priv *psecuritypriv = &padapter->securitypriv;
 
-	if ((key_index < WEP_KEYS) && ((psecuritypriv->dot11PrivacyAlgrthm == _WEP40_) || (psecuritypriv->dot11PrivacyAlgrthm == _WEP104_))) /* set wep default key */
-	{
+	if ((key_index < WEP_KEYS) && ((psecuritypriv->dot11PrivacyAlgrthm == _WEP40_) || (psecuritypriv->dot11PrivacyAlgrthm == _WEP104_))) { /* set wep default key */
 		psecuritypriv->ndisencryptstatus = Ndis802_11Encryption1Enabled;
 
 		psecuritypriv->dot11PrivacyKeyIndex = key_index;
 
 		psecuritypriv->dot11PrivacyAlgrthm = _WEP40_;
 		psecuritypriv->dot118021XGrpPrivacy = _WEP40_;
-		if (psecuritypriv->dot11DefKeylen[key_index] == 13)
-		{
+		if (psecuritypriv->dot11DefKeylen[key_index] == 13) {
 			psecuritypriv->dot11PrivacyAlgrthm = _WEP104_;
 			psecuritypriv->dot118021XGrpPrivacy = _WEP104_;
 		}
@@ -1072,8 +1009,7 @@ static int cfg80211_rtw_get_station(struct wiphy *wiphy,
 	/* for infra./P2PClient mode */
 	if (check_fwstate(pmlmepriv, WIFI_STATION_STATE)
 		&& check_fwstate(pmlmepriv, _FW_LINKED)
-	)
-	{
+	) {
 		struct wlan_network  *cur_network = &(pmlmepriv->cur_network);
 
 		if (memcmp((u8 *)mac, cur_network->network.mac_address, ETH_ALEN)) {
@@ -1100,8 +1036,7 @@ static int cfg80211_rtw_get_station(struct wiphy *wiphy,
  || check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE)
  || check_fwstate(pmlmepriv, WIFI_AP_STATE))
 		&& check_fwstate(pmlmepriv, _FW_LINKED)
-	)
-	{
+	) {
 		/* TODO: should acquire station info... */
 	}
 
@@ -1121,8 +1056,7 @@ static int cfg80211_rtw_change_iface(struct wiphy *wiphy,
 	struct mlme_ext_priv *pmlmeext = &(padapter->mlmeextpriv);
 	int ret = 0;
 
-	if (adapter_to_dvobj(padapter)->processing_dev_remove == true)
-	{
+	if (adapter_to_dvobj(padapter)->processing_dev_remove == true) {
 		ret = -EPERM;
 		goto exit;
 	}
@@ -1141,8 +1075,7 @@ static int cfg80211_rtw_change_iface(struct wiphy *wiphy,
 
 	old_type = rtw_wdev->iftype;
 
-	if (old_type != type)
-	{
+	if (old_type != type) {
 		pmlmeext->action_public_rxseq = 0xffff;
 		pmlmeext->action_public_dialog_token = 0xff;
 	}
@@ -1164,8 +1097,7 @@ static int cfg80211_rtw_change_iface(struct wiphy *wiphy,
 
 	rtw_wdev->iftype = type;
 
-	if (rtw_set_802_11_infrastructure_mode(padapter, networkType) == false)
-	{
+	if (rtw_set_802_11_infrastructure_mode(padapter, networkType) == false) {
 		rtw_wdev->iftype = old_type;
 		ret = -EPERM;
 		goto exit;
@@ -1231,8 +1163,7 @@ void rtw_cfg80211_surveydone_event_callback(struct adapter *padapter)
 		/* report network only if the current channel set contains the channel to which this network belongs */
 		if (rtw_ch_set_search_ch(padapter->mlmeextpriv.channel_set, pnetwork->network.configuration.ds_config) >= 0
 			&& true == rtw_validate_ssid(&(pnetwork->network.ssid))
-		)
-		{
+		) {
 			/* ev =translate_scan(padapter, a, pnetwork, ev, stop); */
 			rtw_cfg80211_inform_bss(padapter, pnetwork);
 		}
@@ -1249,13 +1180,10 @@ static int rtw_cfg80211_set_probe_req_wpsp2pie(struct adapter *padapter, char *b
 	u8 *wps_ie;
 	struct mlme_priv *pmlmepriv = &(padapter->mlmepriv);
 
-	if (len > 0)
-	{
+	if (len > 0) {
 		wps_ie = rtw_get_wps_ie(buf, len, NULL, &wps_ielen);
-		if (wps_ie)
-		{
-			if (pmlmepriv->wps_probe_req_ie)
-			{
+		if (wps_ie) {
+			if (pmlmepriv->wps_probe_req_ie) {
 				pmlmepriv->wps_probe_req_ie_len = 0;
 				kfree(pmlmepriv->wps_probe_req_ie);
 				pmlmepriv->wps_probe_req_ie = NULL;
@@ -1307,10 +1235,8 @@ static int cfg80211_rtw_scan(struct wiphy *wiphy
 	pwdev_priv->scan_request = request;
 	spin_unlock_bh(&pwdev_priv->scan_req_lock);
 
-	if (check_fwstate(pmlmepriv, WIFI_AP_STATE) == true)
-	{
-		if (check_fwstate(pmlmepriv, WIFI_UNDER_WPS|_FW_UNDER_SURVEY|_FW_UNDER_LINKING) == true)
-		{
+	if (check_fwstate(pmlmepriv, WIFI_AP_STATE) == true) {
+		if (check_fwstate(pmlmepriv, WIFI_UNDER_WPS|_FW_UNDER_SURVEY|_FW_UNDER_LINKING) == true) {
 			need_indicate_scan_done = true;
 			goto check_need_indicate_scan_done;
 		}
@@ -1333,15 +1259,13 @@ static int cfg80211_rtw_scan(struct wiphy *wiphy
 		goto check_need_indicate_scan_done;
 	}
 
-	if (pmlmepriv->LinkDetectInfo.bBusyTraffic == true)
-	{
+	if (pmlmepriv->LinkDetectInfo.bBusyTraffic == true) {
 		static unsigned long lastscantime = 0;
 		unsigned long passtime;
 
 		passtime = jiffies_to_msecs(jiffies - lastscantime);
 		lastscantime = jiffies;
-		if (passtime > 12000)
-		{
+		if (passtime > 12000) {
 			need_indicate_scan_done = true;
 			goto check_need_indicate_scan_done;
 		}
@@ -1380,9 +1304,7 @@ static int cfg80211_rtw_scan(struct wiphy *wiphy
 	} else if (request->n_channels <= 4) {
 		for (j = request->n_channels - 1; j >= 0; j--)
 			for (i = 0; i < survey_times; i++)
-		{
 			memcpy(&ch[j*survey_times+i], &ch[j], sizeof(struct rtw_ieee80211_channel));
-		}
 		_status = rtw_sitesurvey_cmd(padapter, ssid, RTW_SSID_SCAN_AMOUNT, ch, survey_times * request->n_channels);
 	} else {
 		_status = rtw_sitesurvey_cmd(padapter, ssid, RTW_SSID_SCAN_AMOUNT, NULL, 0);
@@ -1391,14 +1313,11 @@ static int cfg80211_rtw_scan(struct wiphy *wiphy
 
 
 	if (_status == false)
-	{
 		ret = -1;
-	}
 
 check_need_indicate_scan_done:
 	kfree(ssid);
-	if (need_indicate_scan_done)
-	{
+	if (need_indicate_scan_done) {
 		rtw_cfg80211_surveydone_event_callback(padapter);
 		rtw_cfg80211_indicate_scan_done(padapter, false);
 	}
@@ -1424,9 +1343,7 @@ static int rtw_cfg80211_set_wpa_version(struct security_priv *psecuritypriv, u32
 
 
 	if (wpa_version & (NL80211_WPA_VERSION_1 | NL80211_WPA_VERSION_2))
-	{
 		psecuritypriv->ndisauthtype = Ndis802_11AuthModeWPAPSK;
-	}
 
 	return 0;
 
@@ -1585,8 +1502,7 @@ static int rtw_cfg80211_set_wpa_ie(struct adapter *padapter, u8 *pie, size_t iel
 	if (pairwise_cipher == 0)
 		pairwise_cipher = WPA_CIPHER_NONE;
 
-	switch (group_cipher)
-	{
+	switch (group_cipher) {
 		case WPA_CIPHER_NONE:
 			padapter->securitypriv.dot118021XGrpPrivacy = _NO_PRIVACY_;
 			padapter->securitypriv.ndisencryptstatus = Ndis802_11EncryptionDisabled;
@@ -1609,8 +1525,7 @@ static int rtw_cfg80211_set_wpa_ie(struct adapter *padapter, u8 *pie, size_t iel
 			break;
 	}
 
-	switch (pairwise_cipher)
-	{
+	switch (pairwise_cipher) {
 		case WPA_CIPHER_NONE:
 			padapter->securitypriv.dot11PrivacyAlgrthm = _NO_PRIVACY_;
 			padapter->securitypriv.ndisencryptstatus = Ndis802_11EncryptionDisabled;
@@ -1731,8 +1646,7 @@ static int cfg80211_rtw_leave_ibss(struct wiphy *wiphy, struct net_device *ndev)
 
 		rtw_wdev->iftype = NL80211_IFTYPE_STATION;
 
-		if (rtw_set_802_11_infrastructure_mode(padapter, Ndis802_11Infrastructure) == false)
-		{
+		if (rtw_set_802_11_infrastructure_mode(padapter, Ndis802_11Infrastructure) == false) {
 			rtw_wdev->iftype = old_type;
 			ret = -EPERM;
 			goto leave_ibss;
@@ -1792,9 +1706,8 @@ static int cfg80211_rtw_connect(struct wiphy *wiphy, struct net_device *ndev,
 		ret = -EBUSY;
 		goto exit;
 	}
-	if (check_fwstate(pmlmepriv, _FW_UNDER_SURVEY) == true) {
+	if (check_fwstate(pmlmepriv, _FW_UNDER_SURVEY) == true)
 		rtw_scan_abort(padapter);
-	}
 
 	psecuritypriv->ndisencryptstatus = Ndis802_11EncryptionDisabled;
 	psecuritypriv->dot11PrivacyAlgrthm = _NO_PRIVACY_;
@@ -2287,9 +2200,8 @@ static int rtw_cfg80211_add_monitor_if(struct adapter *padapter, char *name, str
 	mon_ndev->ieee80211_ptr = mon_wdev;
 
 	ret = cfg80211_register_netdevice(mon_ndev);
-	if (ret) {
+	if (ret)
 		goto out;
-	}
 
 	*ndev = pwdev_priv->pmon_ndev = mon_ndev;
 	memcpy(pwdev_priv->ifname_mon, name, IFNAMSIZ+1);
@@ -2402,11 +2314,10 @@ static int rtw_add_beacon(struct adapter *adapter, const u8 *head, size_t head_l
 	rtw_ies_remove_ie(pbuf, &len, _BEACON_IE_OFFSET_, WLAN_EID_VENDOR_SPECIFIC, P2P_OUI, 4);
 	rtw_ies_remove_ie(pbuf, &len, _BEACON_IE_OFFSET_, WLAN_EID_VENDOR_SPECIFIC, WFD_OUI, 4);
 
-	if (rtw_check_beacon_data(adapter, pbuf,  len) == _SUCCESS) {
+	if (rtw_check_beacon_data(adapter, pbuf,  len) == _SUCCESS)
 		ret = 0;
-	} else {
+	else
 		ret = -EINVAL;
-	}
 
 
 	kfree(pbuf);
-- 
2.36.1

