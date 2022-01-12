Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CF4148BDDA
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 05:22:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350625AbiALEWM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 23:22:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350613AbiALEWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 23:22:09 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47325C06173F
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 20:22:09 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id 59-20020a17090a09c100b001b34a13745eso9359793pjo.5
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 20:22:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kboHIb2qimmeziUoT1eD5XtRn5oDOkA2cacDUt27T1s=;
        b=F+xr3MeBBBwQ6Bn32wVfIBpyKp3OeuNBgl81G53UM3nhoPGi+bh45DIUWSnB+tJWZa
         kj5mksiXv41PBrSIvoSpHSgdP27M5/7RsUVCdBKGCt7DitiLtlcsO6ebNCPSxrAusHsM
         86eYIY8Eu3YfbfpfTH7yWPD2bE+5viurSLAIE7A+yLKjH47U7F7sWo47ULefQEvgtJ9K
         lGbf2VDkdxRolr6itpieS7eX5vv7OoBOyHP71TPmh46StPVnUaIeTDoGl41NrWhbkP1M
         50P5Tqa+sxsknLlifbnLnV34FtLqOaYfRBNH8zNWyD6AYoTwYbuuPQVTX/iK+UkmAqot
         79UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kboHIb2qimmeziUoT1eD5XtRn5oDOkA2cacDUt27T1s=;
        b=ROdJMVOoNHbLsaTbt5HctviAgCkhzEvKOebTPU0vJnPo2+X20MizXsBr1+AQgc7z0u
         UIf022l8ii7mXDVHsLFeDSAyemYYQsYQVaKaH/FnCiCWpQ0JcjNHaLbJCAXoIN01qrpk
         VPTvpbnHvCEpOv3jAZZvu1mHpFOmUTLQ09hleCDr24Bt8Jja7xIigB/CsxQ+oflGWIRn
         QWajncdHO7S9tphmpQiLt0Lw/2cR8ffvzZAGBn3J+zeC1flDa20sq5dpu1VMdIrlYvJV
         usBrRllWAwkutIQCIYLLVWok17Cit29MJAssD/qdGf5JN8+kLymyk85Xtv3HM9DiK/V0
         lQPg==
X-Gm-Message-State: AOAM530eK7vnEfxURgYzHkcnpHdSyRsVdRBa/veE+NBU/ieFbKoQiR7A
        KthyykeX7XzyyITmr+86eCM=
X-Google-Smtp-Source: ABdhPJzVGvNhr1ihwiJVs3pL1YYkNtBu1Z5wvKSit5bZKeiMwVRvn8UYqCjK9P9ApU23ZF8F1B2NLA==
X-Received: by 2002:a17:90a:8b81:: with SMTP id z1mr6817104pjn.83.1641961328550;
        Tue, 11 Jan 2022 20:22:08 -0800 (PST)
Received: from localhost.localdomain ([115.99.137.58])
        by smtp.gmail.com with ESMTPSA id t207sm11237747pfc.205.2022.01.11.20.22.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 20:22:08 -0800 (PST)
From:   Jagath Jog J <jagathjog1996@gmail.com>
To:     gregkh@linuxfoundation.org, fabioaiuto83@gmail.com,
        marcocesati@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        jagathjog1996@gmail.com
Subject: [PATCH  1/4] Staging: rtl8723bs: Placing opening { braces in previous line
Date:   Wed, 12 Jan 2022 09:51:58 +0530
Message-Id: <20220112042201.5056-2-jagathjog1996@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220112042201.5056-1-jagathjog1996@gmail.com>
References: <20220112042201.5056-1-jagathjog1996@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix following checkpatch.pl error by placing opening {
braces in previous line
ERROR: that open brace { should be on the previous line

Signed-off-by: Jagath Jog J <jagathjog1996@gmail.com>
---
 .../staging/rtl8723bs/os_dep/ioctl_cfg80211.c | 40 ++++++-------------
 1 file changed, 13 insertions(+), 27 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
index 5157b5b12597..81b548ad4e30 100644
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
+			/*  it means under processing WPS */
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
-- 
2.17.1

