Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02D514977B6
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 04:45:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241079AbiAXDpG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 22:45:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241072AbiAXDpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 22:45:04 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EEE6C06173B
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 19:45:04 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id w190so8414152pfw.7
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 19:45:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8+nbXvw94PzoNmHfYGu561mFtWJdPhsIQ7x5qJXCJwc=;
        b=d0Kpe/sOGKJAd1FxWY5F/WWuCkTWDIyJyyCzeS28umlb8BUqoyDse1LohIIXP4+k49
         D0ccvsP3i+coZq/tBupobh0bByousAnwoHa+aXk3W+wpZJBzFUyJdux+MKq/Ig5Z7ofA
         h5LBetSRv4/8Wgz+szrRVZEBn4fEFjF7aaRvrOy/p4bmfZrysJOHmw5SaWj3+CSGgMgU
         KJonOKHWn3hRiJa3WvqTh1zR7NBYZCJCVeShzIekI8AEYtILjBdYUw0TGaqBvOh9Mm/o
         3hB3lnR26QQab9wKxLnLWiWW69nKOMPqGwoTpJCT21honpP/Z971/0ro0g6r4dttjIrs
         lXCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8+nbXvw94PzoNmHfYGu561mFtWJdPhsIQ7x5qJXCJwc=;
        b=Wcz6ZhVpe+O+UTOmyDM7oFWZIr85Qq5+NV24jI4mMH+oA+Gw6seP0WzI3ICj6swMDg
         XNA1FVuAIa5gK8dZSplwhuol3YtDVwfBrcxWA7AF/YW6ny74DSR1RoOxvI2vd+I0R/+C
         gSqoJ3cFWmhuC43yXsNurLHnY+dUDo4E87LX1wIhSndr5ffe9QaO5Y9B9Irchg06mvUR
         tGyB67CCcXkaJQUX+vTZa6UPqnsHe+Q9BnxZne2WVyXntB+Lec0ggKQecIUzefGXR72F
         xBuf5MOBaMm9xyAnM1BzPbsSbTk+lxY4kR6Zl2ma3gaIuRmbB+8MZocCebWOBEfiTxKl
         L0ag==
X-Gm-Message-State: AOAM531CaQKx1MYzWRCsk8Nw9Ce1LuSQ3hAi0URXX+UV6BXufUQpy7tM
        y9UY0ecxgz1IAWYO4w0bZOM=
X-Google-Smtp-Source: ABdhPJzxaiP8PVfayZs9NI91HT/VTWIetRnfnaWf+VxX8S/yC6wXePeMrhkiV3Zk4DuzQrf5YJvNUQ==
X-Received: by 2002:a63:2b84:: with SMTP id r126mr10522298pgr.624.1642995903985;
        Sun, 23 Jan 2022 19:45:03 -0800 (PST)
Received: from localhost.localdomain ([27.7.142.194])
        by smtp.gmail.com with ESMTPSA id p38sm9853390pgb.36.2022.01.23.19.45.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jan 2022 19:45:03 -0800 (PST)
From:   Jagath Jog J <jagathjog1996@gmail.com>
To:     gregkh@linuxfoundation.org, hdegoede@redhat.com,
        Larry.Finger@lwfinger.net
Cc:     fabioaiuto83@gmail.com, dan.carpenter@oracle.com,
        marcocesati@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, jagathjog1996@gmail.com
Subject: [Patch  1/3] Staging: rtl8723bs: Placing opening { braces in previous line
Date:   Mon, 24 Jan 2022 09:14:54 +0530
Message-Id: <20220124034456.8665-2-jagathjog1996@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220124034456.8665-1-jagathjog1996@gmail.com>
References: <20220124034456.8665-1-jagathjog1996@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix following checkpatch.pl error by placing opening {
braces in previous line
ERROR: that open brace { should be on the previous line

Signed-off-by: Jagath Jog J <jagathjog1996@gmail.com>
---
 .../staging/rtl8723bs/os_dep/ioctl_cfg80211.c | 98 ++++++-------------
 1 file changed, 32 insertions(+), 66 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
index 5157b5b12597..43b5604c0bca 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
@@ -113,13 +113,10 @@ static struct ieee80211_supported_band *rtw_spt_band_alloc(
 	struct ieee80211_supported_band *spt_band = NULL;
 	int n_channels, n_bitrates;
 
-	if (band == NL80211_BAND_2GHZ)
-	{
+	if (band == NL80211_BAND_2GHZ) {
 		n_channels = RTW_2G_CHANNELS_NUM;
 		n_bitrates = RTW_G_RATES_NUM;
-	}
-	else
-	{
+	} else {
 		goto exit;
 	}
 
@@ -135,8 +132,7 @@ static struct ieee80211_supported_band *rtw_spt_band_alloc(
 	spt_band->n_channels = n_channels;
 	spt_band->n_bitrates = n_bitrates;
 
-	if (band == NL80211_BAND_2GHZ)
-	{
+	if (band == NL80211_BAND_2GHZ) {
 		rtw_2g_channels_init(spt_band->channels);
 		rtw_2g_rates_init(spt_band->bitrates);
 	}
@@ -235,8 +231,7 @@ struct cfg80211_bss *rtw_cfg80211_inform_bss(struct adapter *padapter, struct wl
 	{
 		u16 wapi_len = 0;
 
-		if (rtw_get_wapi_ie(pnetwork->network.ies, pnetwork->network.ie_length, NULL, &wapi_len) > 0)
-		{
+		if (rtw_get_wapi_ie(pnetwork->network.ies, pnetwork->network.ie_length, NULL, &wapi_len) > 0) {
 			if (wapi_len > 0)
 				goto exit;
 		}
@@ -244,8 +239,7 @@ struct cfg80211_bss *rtw_cfg80211_inform_bss(struct adapter *padapter, struct wl
 
 	/* To reduce PBC Overlap rate */
 	/* spin_lock_bh(&pwdev_priv->scan_req_lock); */
-	if (adapter_wdev_data(padapter)->scan_request)
-	{
+	if (adapter_wdev_data(padapter)->scan_request) {
 		u8 *psr = NULL, sr = 0;
 		struct ndis_802_11_ssid *pssid = &pnetwork->network.ssid;
 		struct cfg80211_scan_request *request = adapter_wdev_data(padapter)->scan_request;
@@ -258,14 +252,12 @@ struct cfg80211_bss *rtw_cfg80211_inform_bss(struct adapter *padapter, struct wl
 		if (wpsie && wpsielen > 0)
 			psr = rtw_get_wps_attr_content(wpsie,  wpsielen, WPS_ATTR_SELECTED_REGISTRAR, (u8 *)(&sr), NULL);
 
-		if (sr != 0)
-		{
-			if (request->n_ssids == 1 && request->n_channels == 1) /*  it means under processing WPS */
-			{
+		if (sr != 0) {
+			/* it means under processing WPS */
+			if (request->n_ssids == 1 && request->n_channels == 1) {
 				if (ssids[0].ssid_len != 0 &&
 				    (pssid->ssid_length != ssids[0].ssid_len ||
-				     memcmp(pssid->ssid, ssids[0].ssid, ssids[0].ssid_len)))
-				{
+				     memcmp(pssid->ssid, ssids[0].ssid, ssids[0].ssid_len))) {
 					if (psr)
 						*psr = 0; /* clear sr */
 				}
@@ -374,8 +366,7 @@ void rtw_cfg80211_ibss_indicate_connect(struct adapter *padapter)
 	int freq = (int)cur_network->network.configuration.ds_config;
 	struct ieee80211_channel *chan;
 
-	if (pwdev->iftype != NL80211_IFTYPE_ADHOC)
-	{
+	if (pwdev->iftype != NL80211_IFTYPE_ADHOC) {
 		return;
 	}
 
@@ -383,14 +374,11 @@ void rtw_cfg80211_ibss_indicate_connect(struct adapter *padapter)
 		struct wlan_bssid_ex  *pnetwork = &(padapter->mlmeextpriv.mlmext_info.network);
 		struct wlan_network *scanned = pmlmepriv->cur_network_scanned;
 
-		if (check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE) == true)
-		{
+		if (check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE) == true) {
 
 			memcpy(&cur_network->network, pnetwork, sizeof(struct wlan_bssid_ex));
 			rtw_cfg80211_inform_bss(padapter, cur_network);
-		}
-		else
-		{
+		} else {
 			if (!scanned) {
 				rtw_warn_on(1);
 				return;
@@ -473,9 +461,7 @@ void rtw_cfg80211_indicate_connect(struct adapter *padapter)
 		roam_info.resp_ie_len =
 			pmlmepriv->assoc_rsp_len-sizeof(struct ieee80211_hdr_3addr)-6;
 		cfg80211_roamed(padapter->pnetdev, &roam_info, GFP_ATOMIC);
-	}
-	else
-	{
+	} else {
 		cfg80211_connect_result(padapter->pnetdev, cur_network->network.mac_address
 			, pmlmepriv->assoc_req+sizeof(struct ieee80211_hdr_3addr)+2
 			, pmlmepriv->assoc_req_len-sizeof(struct ieee80211_hdr_3addr)-2
@@ -527,24 +513,19 @@ static int rtw_cfg80211_ap_set_encryption(struct net_device *dev, struct ieee_pa
 	param->u.crypt.err = 0;
 	param->u.crypt.alg[IEEE_CRYPT_ALG_NAME_LEN - 1] = '\0';
 
-	if (param_len !=  sizeof(struct ieee_param) + param->u.crypt.key_len)
-	{
+	if (param_len !=  sizeof(struct ieee_param) + param->u.crypt.key_len) {
 		ret =  -EINVAL;
 		goto exit;
 	}
 
 	if (param->sta_addr[0] == 0xff && param->sta_addr[1] == 0xff &&
 	    param->sta_addr[2] == 0xff && param->sta_addr[3] == 0xff &&
-	    param->sta_addr[4] == 0xff && param->sta_addr[5] == 0xff)
-	{
-		if (param->u.crypt.idx >= WEP_KEYS)
-		{
+	    param->sta_addr[4] == 0xff && param->sta_addr[5] == 0xff) {
+		if (param->u.crypt.idx >= WEP_KEYS) {
 			ret = -EINVAL;
 			goto exit;
 		}
-	}
-	else
-	{
+	} else {
 		psta = rtw_get_stainfo(pstapriv, param->sta_addr);
 		if (!psta)
 			/* ret = -EINVAL; */
@@ -554,24 +535,20 @@ static int rtw_cfg80211_ap_set_encryption(struct net_device *dev, struct ieee_pa
 	if (strcmp(param->u.crypt.alg, "none") == 0 && !psta)
 		goto exit;
 
-	if (strcmp(param->u.crypt.alg, "WEP") == 0 && !psta)
-	{
+	if (strcmp(param->u.crypt.alg, "WEP") == 0 && !psta) {
 		wep_key_idx = param->u.crypt.idx;
 		wep_key_len = param->u.crypt.key_len;
 
-		if ((wep_key_idx >= WEP_KEYS) || (wep_key_len <= 0))
-		{
+		if ((wep_key_idx >= WEP_KEYS) || (wep_key_len <= 0)) {
 			ret = -EINVAL;
 			goto exit;
 		}
 
-		if (wep_key_len > 0)
-		{
+		if (wep_key_len > 0) {
 			wep_key_len = wep_key_len <= 5 ? 5 : 13;
 		}
 
-		if (psecuritypriv->bWepDefaultKeyIdxSet == 0)
-		{
+		if (psecuritypriv->bWepDefaultKeyIdxSet == 0) {
 			/* wep default key has not been set, so use this key index as default key. */
 
 			psecuritypriv->dot11AuthAlgrthm = dot11AuthAlgrthm_Auto;
@@ -579,8 +556,7 @@ static int rtw_cfg80211_ap_set_encryption(struct net_device *dev, struct ieee_pa
 			psecuritypriv->dot11PrivacyAlgrthm = _WEP40_;
 			psecuritypriv->dot118021XGrpPrivacy = _WEP40_;
 
-			if (wep_key_len == 13)
-			{
+			if (wep_key_len == 13) {
 				psecuritypriv->dot11PrivacyAlgrthm = _WEP104_;
 				psecuritypriv->dot118021XGrpPrivacy = _WEP104_;
 			}
@@ -598,24 +574,19 @@ static int rtw_cfg80211_ap_set_encryption(struct net_device *dev, struct ieee_pa
 
 	}
 
-
-	if (!psta && check_fwstate(pmlmepriv, WIFI_AP_STATE)) /* group key */
-	{
-		if (param->u.crypt.set_tx == 0) /* group key */
-		{
-			if (strcmp(param->u.crypt.alg, "WEP") == 0)
-			{
+	/* group key */
+	if (!psta && check_fwstate(pmlmepriv, WIFI_AP_STATE)) {
+		/* group key */
+		if (param->u.crypt.set_tx == 0) {
+			if (strcmp(param->u.crypt.alg, "WEP") == 0) {
 				memcpy(grpkey, param->u.crypt.key, (param->u.crypt.key_len > 16 ? 16 : param->u.crypt.key_len));
 
 				psecuritypriv->dot118021XGrpPrivacy = _WEP40_;
-				if (param->u.crypt.key_len == 13)
-				{
+				if (param->u.crypt.key_len == 13) {
 						psecuritypriv->dot118021XGrpPrivacy = _WEP104_;
 				}
 
-			}
-			else if (strcmp(param->u.crypt.alg, "TKIP") == 0)
-			{
+			} else if (strcmp(param->u.crypt.alg, "TKIP") == 0) {
 				psecuritypriv->dot118021XGrpPrivacy = _TKIP_;
 
 				memcpy(grpkey, param->u.crypt.key, (param->u.crypt.key_len > 16 ? 16 : param->u.crypt.key_len));
@@ -627,15 +598,11 @@ static int rtw_cfg80211_ap_set_encryption(struct net_device *dev, struct ieee_pa
 
 				psecuritypriv->busetkipkey = true;
 
-			}
-			else if (strcmp(param->u.crypt.alg, "CCMP") == 0)
-			{
+			} else if (strcmp(param->u.crypt.alg, "CCMP") == 0) {
 				psecuritypriv->dot118021XGrpPrivacy = _AES_;
 
 				memcpy(grpkey, param->u.crypt.key, (param->u.crypt.key_len > 16 ? 16 : param->u.crypt.key_len));
-			}
-			else
-			{
+			} else {
 				psecuritypriv->dot118021XGrpPrivacy = _NO_PRIVACY_;
 			}
 
@@ -648,8 +615,7 @@ static int rtw_cfg80211_ap_set_encryption(struct net_device *dev, struct ieee_pa
 			rtw_ap_set_group_key(padapter, param->u.crypt.key, psecuritypriv->dot118021XGrpPrivacy, param->u.crypt.idx);
 
 			pbcmc_sta = rtw_get_bcmc_stainfo(padapter);
-			if (pbcmc_sta)
-			{
+			if (pbcmc_sta) {
 				pbcmc_sta->ieee8021x_blocked = false;
 				pbcmc_sta->dot118021XPrivacy = psecuritypriv->dot118021XGrpPrivacy;/* rx will use bmc_sta's dot118021XPrivacy */
 			}
-- 
2.17.1

