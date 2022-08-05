Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6FFD58A740
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 09:39:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240184AbiHEHjv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 03:39:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237602AbiHEHjs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 03:39:48 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C50201BEAA
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 00:39:45 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id w3so2366563edc.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Aug 2022 00:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XZgEKh6jxW616KcwbajBMH6W81xzTe92v2vXiPWmDkY=;
        b=FjNQsdZD415OJH0cS/7We26kEgmIpMKP3fyBUJQbT5QqwUPWMFEd2xoO0jdN4NZSra
         O+RrFfyugrYfh1qJkpdtRkybmkcuHnGmkTBKtpH3Is6+7ur1xxbcEsuuB0HhYnNgFhmw
         eCpCYJz+tY0/n50/MZCIo4Tl2xny1x5kOauP1N6ZoPqgUMypZpFgy2D6wqEKCJr3OZc1
         ctwfeyYO/c2//pAE1eAHBt3+vQjH5n+kR/f0jntfMfpzelPL6t60/TcDTcqidF/z4E1W
         6PGZAWYTJEM2OwZ+3QlUmqSZgCS/ZZ5Amoh9LQfMVXTvHJrnQZfBR/RMtccCu1OWg1W/
         lyrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XZgEKh6jxW616KcwbajBMH6W81xzTe92v2vXiPWmDkY=;
        b=i6VmGH0gqQuneOp751J9RPPK05sMxzWJfKo9kj+sSRH8r+2wn4Cq/z9SnpaJ4P06v+
         u+83JCaz45nz43Q4S+yCuEM2cVkoFpVOKhyBRBGjsfLYtzjsYdLeGQa6MUwzJSp8Plvp
         R0kuUSlRGVFSZkIBh2TI67qHy68l33QghZiU/+WflvLukZt4EA5PF3YRbj5miRKW1mOm
         gg6Tr+IbC9HUSE+rFIfxjAfEJzpsAMVvpUIcbcyNZCfa3BsE9xn82/ogNmg9Vx7fX8ZT
         ibBCvP/8CIj1RtbjKgYYGYPpfcqgWKNMw/iaIkll0iIrv0JIN4vjxBoR7IopyptfpXZT
         TBlQ==
X-Gm-Message-State: ACgBeo1hFoa+KUL2M2gBcrRNoT7yl8ajcrBQ5YIW7STJOyHGQCHAzFuw
        g5A7D8Zx+5qyyGPlG9oPYVM=
X-Google-Smtp-Source: AA6agR7ttzmjivHO+jZjH0ZXobORM2LH3lvM6JZXH/aiQ7wafPm/Mi6L5fvHCtMySdSD/KGevWGdmQ==
X-Received: by 2002:a05:6402:f25:b0:43d:e499:e32e with SMTP id i37-20020a0564020f2500b0043de499e32emr5422561eda.2.1659685183916;
        Fri, 05 Aug 2022 00:39:43 -0700 (PDT)
Received: from localhost.localdomain ([88.208.127.92])
        by smtp.gmail.com with ESMTPSA id s18-20020a1709062ed200b007304d084c5esm1238211eji.166.2022.08.05.00.39.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 00:39:43 -0700 (PDT)
From:   Simone Serra <serrazimone@gmail.com>
To:     gregkh@linuxfoundation.org, fabioaiuto83@gmail.com,
        soumya.negi97@gmail.com, hdegoede@redhat.com,
        straube.linux@gmail.com
Cc:     Simone Serra <serrazimone@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] Fixes checkpatch warnings and checks
Date:   Fri,  5 Aug 2022 09:39:32 +0200
Message-Id: <20220805073932.225975-1-serrazimone@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes checkpatch warningds and checks

Signed-off-by: Simone Serra <serrazimone@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_ap.c | 462 +++++++++++-------------
 1 file changed, 220 insertions(+), 242 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ap.c b/drivers/staging/rtl8723bs/core/rtw_ap.c
index d30d6e6bcd07..1f0b8b99598e 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ap.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ap.c
@@ -259,9 +259,9 @@ void expire_timeout_chk(struct adapter *padapter)
 		} else {
 			/* TODO: Aging mechanism to digest frames in sleep_q to */
 			/* avoid running out of xmitframe */
-			if (psta->sleepq_len > (NR_XMITFRAME / pstapriv->asoc_list_cnt)
-				&& padapter->xmitpriv.free_xmitframe_cnt < ((
-					NR_XMITFRAME / pstapriv->asoc_list_cnt
+			if (psta->sleepq_len > (NR_XMITFRAME / pstapriv->asoc_list_cnt) &&
+			    padapter->xmitpriv.free_xmitframe_cnt <
+						 ((NR_XMITFRAME / pstapriv->asoc_list_cnt
 				) / 2)
 			)
 				wakeup_sta_to_xmit(padapter, psta);
@@ -277,7 +277,7 @@ void expire_timeout_chk(struct adapter *padapter)
 		/* switch to correct channel of current network  before issue keep-alive frames */
 		if (rtw_get_oper_ch(padapter) != pmlmeext->cur_channel) {
 			backup_oper_channel = rtw_get_oper_ch(padapter);
-			SelectChannel(padapter, pmlmeext->cur_channel);
+			select_channel(padapter, pmlmeext->cur_channel);
 		}
 
 		/* issue null data to check sta alive*/
@@ -315,17 +315,17 @@ void expire_timeout_chk(struct adapter *padapter)
 		}
 
 		if (backup_oper_channel > 0) /* back to the original operation channel */
-			SelectChannel(padapter, backup_oper_channel);
+			select_channel(padapter, backup_oper_channel);
 	}
 
 	associated_clients_update(padapter, updated);
 }
 
-void add_RATid(struct adapter *padapter, struct sta_info *psta, u8 rssi_level)
+void add_ratid(struct adapter *padapter, struct sta_info *psta, u8 rssi_level)
 {
-	unsigned char sta_band = 0, shortGIrate = false;
+	unsigned char sta_band = 0, short_gi_rate = false;
 	unsigned int tx_ra_bitmap = 0;
-	struct mlme_priv *pmlmepriv = &(padapter->mlmepriv);
+	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	struct wlan_bssid_ex
 		*pcur_network = (struct wlan_bssid_ex *)&pmlmepriv->cur_network.network;
 
@@ -338,7 +338,7 @@ void add_RATid(struct adapter *padapter, struct sta_info *psta, u8 rssi_level)
 	rtw_hal_update_sta_rate_mask(padapter, psta);
 	tx_ra_bitmap = psta->ra_mask;
 
-	shortGIrate = query_ra_short_GI(psta);
+	short_gi_rate = query_ra_short_GI(psta);
 
 	if (pcur_network->configuration.ds_config > 14) {
 		sta_band |= WIRELESS_INVALID;
@@ -361,7 +361,7 @@ void add_RATid(struct adapter *padapter, struct sta_info *psta, u8 rssi_level)
 
 		arg[0] = psta->mac_id;
 		arg[1] = psta->raid;
-		arg[2] = shortGIrate;
+		arg[2] = short_gi_rate;
 		arg[3] = psta->init_rate;
 
 		rtw_hal_add_ra_tid(padapter, tx_ra_bitmap, arg, rssi_level);
@@ -371,11 +371,11 @@ void add_RATid(struct adapter *padapter, struct sta_info *psta, u8 rssi_level)
 void update_bmc_sta(struct adapter *padapter)
 {
 	unsigned char network_type;
-	int supportRateNum = 0;
+	int support_rate_num = 0;
 	unsigned int tx_ra_bitmap = 0;
-	struct mlme_priv *pmlmepriv = &(padapter->mlmepriv);
-	struct mlme_ext_priv *pmlmeext = &(padapter->mlmeextpriv);
-	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
+	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
+	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
+	struct mlme_ext_info *pmlmeinfo = &pmlmeext->mlmext_info;
 	struct wlan_bssid_ex
 		*pcur_network = (struct wlan_bssid_ex *)&pmlmepriv->cur_network.network;
 	struct sta_info *psta = rtw_get_bcmc_stainfo(padapter);
@@ -394,12 +394,10 @@ void update_bmc_sta(struct adapter *padapter)
 
 		memset((void *)&psta->sta_stats, 0, sizeof(struct stainfo_stats));
 
-		/* psta->dot118021XPrivacy = _NO_PRIVACY_;//!!! remove it, because it has been set before this. */
-
 		/* prepare for add_RATid */
-		supportRateNum = rtw_get_rateset_len((u8 *)&pcur_network->supported_rates);
+		support_rate_num = rtw_get_rateset_len((u8 *)&pcur_network->supported_rates);
 		network_type = rtw_check_network_type((u8 *)&pcur_network->supported_rates,
-						      supportRateNum,
+						      support_rate_num,
 						      pcur_network->configuration.ds_config
 		);
 		if (is_supported_tx_cck(network_type)) {
@@ -439,7 +437,6 @@ void update_bmc_sta(struct adapter *padapter)
 		spin_lock_bh(&psta->lock);
 		psta->state = _FW_LINKED;
 		spin_unlock_bh(&psta->lock);
-
 	}
 }
 
@@ -452,9 +449,9 @@ void update_bmc_sta(struct adapter *padapter)
 
 void update_sta_info_apmode(struct adapter *padapter, struct sta_info *psta)
 {
-	struct mlme_priv *pmlmepriv = &(padapter->mlmepriv);
+	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	struct security_priv *psecuritypriv = &padapter->securitypriv;
-	struct mlme_ext_priv *pmlmeext = &(padapter->mlmeextpriv);
+	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
 	struct ht_priv *phtpriv_ap = &pmlmepriv->htpriv;
 	struct ht_priv *phtpriv_sta = &psta->htpriv;
 	u8 cur_ldpc_cap = 0, cur_stbc_cap = 0, cur_beamform_cap = 0;
@@ -468,7 +465,7 @@ void update_sta_info_apmode(struct adapter *padapter, struct sta_info *psta)
 	/* ap mode */
 	rtw_hal_set_odm_var(padapter, HAL_ODM_STA_INFO, psta, true);
 
-	if (psecuritypriv->dot11AuthAlgrthm == dot11AuthAlgrthm_8021X)
+	if (psecuritypriv->dot11_auth_algrthm == dot11_auth_algrthm_8021X)
 		psta->ieee8021x_blocked = true;
 	else
 		psta->ieee8021x_blocked = false;
@@ -483,13 +480,12 @@ void update_sta_info_apmode(struct adapter *padapter, struct sta_info *psta)
 		/* check if sta supports rx ampdu */
 		phtpriv_sta->ampdu_enable = phtpriv_ap->ampdu_enable;
 
-		phtpriv_sta->rx_ampdu_min_spacing = (
-			phtpriv_sta->ht_cap.ampdu_params_info & IEEE80211_HT_CAP_AMPDU_DENSITY
+		phtpriv_sta->rx_ampdu_min_spacing =
+		(phtpriv_sta->ht_cap.ampdu_params_info & IEEE80211_HT_CAP_AMPDU_DENSITY
 		) >> 2;
 
 		/*  bwmode */
-		if ((
-			phtpriv_sta->ht_cap.cap_info & phtpriv_ap->ht_cap.cap_info
+		if ((phtpriv_sta->ht_cap.cap_info & phtpriv_ap->ht_cap.cap_info
 		) & cpu_to_le16(IEEE80211_HT_CAP_SUP_WIDTH))
 			psta->bw_mode = CHANNEL_WIDTH_40;
 		else
@@ -501,14 +497,12 @@ void update_sta_info_apmode(struct adapter *padapter, struct sta_info *psta)
 		phtpriv_sta->ch_offset = pmlmeext->cur_ch_offset;
 
 		/* check if sta support s Short GI 20M */
-		if ((
-			phtpriv_sta->ht_cap.cap_info & phtpriv_ap->ht_cap.cap_info
+		if ((phtpriv_sta->ht_cap.cap_info & phtpriv_ap->ht_cap.cap_info
 		) & cpu_to_le16(IEEE80211_HT_CAP_SGI_20))
 			phtpriv_sta->sgi_20m = true;
 
 		/* check if sta support s Short GI 40M */
-		if ((
-			phtpriv_sta->ht_cap.cap_info & phtpriv_ap->ht_cap.cap_info
+		if ((phtpriv_sta->ht_cap.cap_info & phtpriv_ap->ht_cap.cap_info
 		) & cpu_to_le16(IEEE80211_HT_CAP_SGI_40)) {
 			if (psta->bw_mode == CHANNEL_WIDTH_40) /* according to psta->bw_mode */
 				phtpriv_sta->sgi_40m = true;
@@ -564,10 +558,10 @@ void update_sta_info_apmode(struct adapter *padapter, struct sta_info *psta)
 
 static void update_ap_info(struct adapter *padapter, struct sta_info *psta)
 {
-	struct mlme_priv *pmlmepriv = &(padapter->mlmepriv);
+	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	struct wlan_bssid_ex
 		*pnetwork = (struct wlan_bssid_ex *)&pmlmepriv->cur_network.network;
-	struct mlme_ext_priv *pmlmeext = &(padapter->mlmeextpriv);
+	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
 	struct ht_priv *phtpriv_ap = &pmlmepriv->htpriv;
 
 	psta->wireless_mode = pmlmeext->cur_wireless_mode;
@@ -610,7 +604,7 @@ static void update_hw_ht_param(struct adapter *padapter)
 	unsigned char max_AMPDU_len;
 	unsigned char min_MPDU_spacing;
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
-	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
+	struct mlme_ext_info *pmlmeinfo = &pmlmeext->mlmext_info;
 
 	/* handle A-MPDU parameter field
 	 *
@@ -628,8 +622,8 @@ static void update_hw_ht_param(struct adapter *padapter)
 	/*  */
 	/*  Config SM Power Save setting */
 	/*  */
-	pmlmeinfo->SM_PS = (le16_to_cpu(
-		pmlmeinfo->HT_caps.u.HT_cap_element.HT_caps_info
+	pmlmeinfo->SM_PS = (le16_to_cpu
+		(pmlmeinfo->HT_caps.u.HT_cap_element.HT_caps_info
 	) & 0x0C) >> 2;
 
 	/*  */
@@ -646,13 +640,13 @@ void start_bss_network(struct adapter *padapter)
 	u32 acparm;
 	int	ie_len;
 	struct registry_priv  *pregpriv = &padapter->registrypriv;
-	struct mlme_priv *pmlmepriv = &(padapter->mlmepriv);
-	struct security_priv *psecuritypriv = &(padapter->securitypriv);
+	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
+	struct security_priv *psecuritypriv = &padapter->securitypriv;
 	struct wlan_bssid_ex
 		*pnetwork = (struct wlan_bssid_ex *)&pmlmepriv->cur_network.network;
-	struct mlme_ext_priv *pmlmeext = &(padapter->mlmeextpriv);
-	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
-	struct wlan_bssid_ex *pnetwork_mlmeext = &(pmlmeinfo->network);
+	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
+	struct mlme_ext_info *pmlmeinfo = &pmlmeext->mlmext_info;
+	struct wlan_bssid_ex *pnetwork_mlmeext = &pmlmeinfo->network;
 	struct HT_info_element *pht_info = NULL;
 	u8 cbw40_enable = 0;
 
@@ -662,7 +656,8 @@ void start_bss_network(struct adapter *padapter)
 	cur_ch_offset = HAL_PRIME_CHNL_OFFSET_DONT_CARE;
 
 	/* check if there is wps ie, */
-	/* if there is wpsie in beacon, the hostapd will update beacon twice when stating hostapd, */
+	/* if there is wpsie in beacon, the hostapd will update beacon twice when stating */
+	/* hostapd, */
 	/* and at first time the security ie (RSN/WPA IE) will not include in beacon. */
 	if (!rtw_get_wps_ie(pnetwork->ies + _FIXED_IE_LENGTH_,
 			    pnetwork->ie_length - _FIXED_IE_LENGTH_, NULL, NULL))
@@ -685,13 +680,13 @@ void start_bss_network(struct adapter *padapter)
 	if (!pmlmepriv->cur_network.join_res) { /* setting only at  first time */
 
 		/* WEP Key will be set before this function, do not clear CAM. */
-		if ((psecuritypriv->dot11PrivacyAlgrthm != _WEP40_) &&
-		    (psecuritypriv->dot11PrivacyAlgrthm != _WEP104_))
+		if ((psecuritypriv->dot11_privacy_algrthm != _WEP40_) &&
+		    (psecuritypriv->dot11_privacy_algrthm != _WEP104_))
 			flush_all_cam_entry(padapter);	/* clear CAM */
 	}
 
 	/* set MSR to AP_Mode */
-	Set_MSR(padapter, _HW_STATE_AP_);
+	set_msr(padapter, _HW_STATE_AP_);
 
 	/* Set BSSID REG */
 	rtw_hal_set_hwreg(padapter, HW_VAR_BSSID, pnetwork->mac_address);
@@ -708,8 +703,7 @@ void start_bss_network(struct adapter *padapter)
 	rtw_hal_set_hwreg(padapter, HW_VAR_AC_PARAM_BK, (u8 *)(&acparm));
 
 	/* Set Security */
-	val8 = (
-		psecuritypriv->dot11AuthAlgrthm == dot11AuthAlgrthm_8021X
+	val8 = (psecuritypriv->dot11_auth_algrthm == dot11_auth_algrthm_8021X
 	) ? 0xcc : 0xcf;
 	rtw_hal_set_hwreg(padapter, HW_VAR_SEC_CFG, (u8 *)(&val8));
 
@@ -728,7 +722,7 @@ void start_bss_network(struct adapter *padapter)
 		/* Switch_DM_Func(padapter, DYNAMIC_FUNC_DISABLE, false); */
 
 		/* turn on all dynamic functions */
-		Switch_DM_Func(padapter, DYNAMIC_ALL_FUNC_ENABLE, true);
+		switch_DM_func(padapter, DYNAMIC_ALL_FUNC_ENABLE, true);
 
 		/* rtw_hal_set_hwreg(padapter, HW_VAR_INITIAL_GAIN, (u8 *)(&initialgain)); */
 	}
@@ -786,13 +780,12 @@ void start_bss_network(struct adapter *padapter)
 	update_wireless_mode(padapter);
 
 	/* update RRSR after set channel and bandwidth */
-	UpdateBrateTbl(padapter, pnetwork->supported_rates);
+	update_brate_tbl(padapter, pnetwork->supported_rates);
 	rtw_hal_set_hwreg(padapter, HW_VAR_BASIC_RATE, pnetwork->supported_rates);
 
 	/* update capability after cur_wireless_mode updated */
-	update_capinfo(
-		padapter,
-		rtw_get_capability((struct wlan_bssid_ex *)pnetwork)
+	update_capinfo(padapter,
+		       rtw_get_capability((struct wlan_bssid_ex *)pnetwork)
 	);
 
 	if (pmlmeext->bstart_bss) {
@@ -812,19 +805,19 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
 {
 	int ret = _SUCCESS;
 	u8 *p;
-	u8 *pHT_caps_ie = NULL;
-	u8 *pHT_info_ie = NULL;
+	u8 *pht_caps_ie = NULL;
+	u8 *pht_info_ie = NULL;
 	struct sta_info *psta = NULL;
 	u16 cap, ht_cap = false;
 	uint ie_len = 0;
 	int group_cipher, pairwise_cipher;
-	u8 channel, network_type, supportRate[NDIS_802_11_LENGTH_RATES_EX];
-	int supportRateNum = 0;
+	u8 channel, network_type, support_rate[NDIS_802_11_LENGTH_RATES_EX];
+	int support_rate_num = 0;
 	u8 OUI1[] = {0x00, 0x50, 0xf2, 0x01};
 	u8 WMM_PARA_IE[] = {0x00, 0x50, 0xf2, 0x02, 0x01, 0x01};
 	struct registry_priv *pregistrypriv = &padapter->registrypriv;
 	struct security_priv *psecuritypriv = &padapter->securitypriv;
-	struct mlme_priv *pmlmepriv = &(padapter->mlmepriv);
+	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	struct wlan_bssid_ex
 		*pbss_network = (struct wlan_bssid_ex *)&pmlmepriv->cur_network.network;
 	u8 *ie = pbss_network->ies;
@@ -841,15 +834,16 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
 
 	memcpy(ie, pbuf, pbss_network->ie_length);
 
-	if (pbss_network->infrastructure_mode != Ndis802_11APMode)
+	if (pbss_network->infrastructure_mode != ndis802_11_ap_mode)
 		return _FAIL;
 
 	pbss_network->rssi = 0;
 
-	memcpy(pbss_network->mac_address, myid(&(padapter->eeprompriv)), ETH_ALEN);
+	memcpy(pbss_network->mac_address, myid(&padapter->eeprompriv), ETH_ALEN);
 
 	/* beacon interval */
-	p = rtw_get_beacon_interval_from_ie(ie);/* ie + 8;	8: TimeStamp, 2: Beacon Interval 2:Capability */
+	p = rtw_get_beacon_interval_from_ie(ie);/* ie + 8;	8: TimeStamp, */
+	/* 2: Beacon Interval 2:Capability */
 	/* pbss_network->configuration.beacon_period = le16_to_cpu(*(unsigned short*)p); */
 	pbss_network->configuration.beacon_period = get_unaligned_le16(p);
 
@@ -859,11 +853,10 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
 	cap = get_unaligned_le16(ie);
 
 	/* SSID */
-	p = rtw_get_ie(
-		ie + _BEACON_IE_OFFSET_,
-		WLAN_EID_SSID,
-		&ie_len,
-		(pbss_network->ie_length - _BEACON_IE_OFFSET_)
+	p = rtw_get_ie(ie + _BEACON_IE_OFFSET_,
+		       WLAN_EID_SSID,
+		       &ie_len,
+		       (pbss_network->ie_length - _BEACON_IE_OFFSET_)
 	);
 	if (p && ie_len > 0) {
 		memset(&pbss_network->ssid, 0, sizeof(struct ndis_802_11_ssid));
@@ -874,51 +867,47 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
 	/* channel */
 	channel = 0;
 	pbss_network->configuration.length = 0;
-	p = rtw_get_ie(
-		ie + _BEACON_IE_OFFSET_,
-		WLAN_EID_DS_PARAMS, &ie_len,
-		(pbss_network->ie_length - _BEACON_IE_OFFSET_)
+	p = rtw_get_ie(ie + _BEACON_IE_OFFSET_,
+		       WLAN_EID_DS_PARAMS, &ie_len,
+		       (pbss_network->ie_length - _BEACON_IE_OFFSET_)
 	);
 	if (p && ie_len > 0)
 		channel = *(p + 2);
 
 	pbss_network->configuration.ds_config = channel;
 
-	memset(supportRate, 0, NDIS_802_11_LENGTH_RATES_EX);
+	memset(support_rate, 0, NDIS_802_11_LENGTH_RATES_EX);
 	/*  get supported rates */
-	p = rtw_get_ie(
-		ie + _BEACON_IE_OFFSET_,
-		WLAN_EID_SUPP_RATES,
-		&ie_len,
-		(pbss_network->ie_length - _BEACON_IE_OFFSET_)
+	p = rtw_get_ie(ie + _BEACON_IE_OFFSET_,
+		       WLAN_EID_SUPP_RATES,
+		       &ie_len,
+		       (pbss_network->ie_length - _BEACON_IE_OFFSET_)
 	);
 	if (p) {
-		memcpy(supportRate, p + 2, ie_len);
-		supportRateNum = ie_len;
+		memcpy(support_rate, p + 2, ie_len);
+		support_rate_num = ie_len;
 	}
 
 	/* get ext_supported rates */
-	p = rtw_get_ie(
-		ie + _BEACON_IE_OFFSET_,
-		WLAN_EID_EXT_SUPP_RATES,
-		&ie_len,
-		pbss_network->ie_length - _BEACON_IE_OFFSET_
+	p = rtw_get_ie(ie + _BEACON_IE_OFFSET_,
+		       WLAN_EID_EXT_SUPP_RATES,
+		       &ie_len,
+		       pbss_network->ie_length - _BEACON_IE_OFFSET_
 	);
 	if (p) {
-		memcpy(supportRate + supportRateNum, p + 2, ie_len);
-		supportRateNum += ie_len;
+		memcpy(support_rate + support_rate_num, p + 2, ie_len);
+		support_rate_num += ie_len;
 	}
 
-	network_type = rtw_check_network_type(supportRate, supportRateNum, channel);
+	network_type = rtw_check_network_type(support_rate, support_rate_num, channel);
 
 	rtw_set_supported_rate(pbss_network->supported_rates, network_type);
 
 	/* parsing ERP_IE */
-	p = rtw_get_ie(
-		ie + _BEACON_IE_OFFSET_,
-		WLAN_EID_ERP_INFO,
-		&ie_len,
-		(pbss_network->ie_length - _BEACON_IE_OFFSET_)
+	p = rtw_get_ie(ie + _BEACON_IE_OFFSET_,
+		       WLAN_EID_ERP_INFO,
+		       &ie_len,
+		       (pbss_network->ie_length - _BEACON_IE_OFFSET_)
 	);
 	if (p && ie_len > 0)
 		ERP_IE_handler(padapter, (struct ndis_80211_var_ie *)p);
@@ -935,21 +924,20 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
 	group_cipher = 0; pairwise_cipher = 0;
 	psecuritypriv->wpa2_group_cipher = _NO_PRIVACY_;
 	psecuritypriv->wpa2_pairwise_cipher = _NO_PRIVACY_;
-	p = rtw_get_ie(
-		ie + _BEACON_IE_OFFSET_,
-		WLAN_EID_RSN,
-		&ie_len,
-		(pbss_network->ie_length - _BEACON_IE_OFFSET_)
+	p = rtw_get_ie(ie + _BEACON_IE_OFFSET_,
+		       WLAN_EID_RSN,
+		       &ie_len,
+		       (pbss_network->ie_length - _BEACON_IE_OFFSET_)
 	);
 	if (p && ie_len > 0) {
-		if (rtw_parse_wpa2_ie(
-			p,
+		if (rtw_parse_wpa2_ie
+			(p,
 			ie_len + 2,
 			&group_cipher,
 			&pairwise_cipher,
 			NULL
 		) == _SUCCESS) {
-			psecuritypriv->dot11AuthAlgrthm = dot11AuthAlgrthm_8021X;
+			psecuritypriv->dot11_auth_algrthm = dot11_auth_algrthm_8021X;
 
 			psecuritypriv->dot8021xalg = 1;/* psk,  todo:802.1x */
 			psecuritypriv->wpa_psk |= BIT(1);
@@ -965,21 +953,20 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
 	psecuritypriv->wpa_group_cipher = _NO_PRIVACY_;
 	psecuritypriv->wpa_pairwise_cipher = _NO_PRIVACY_;
 	for (p = ie + _BEACON_IE_OFFSET_; ; p += (ie_len + 2)) {
-		p = rtw_get_ie(
-			p,
-			WLAN_EID_VENDOR_SPECIFIC,
-			&ie_len,
-			(pbss_network->ie_length - _BEACON_IE_OFFSET_ - (ie_len + 2))
+		p = rtw_get_ie(p,
+			       WLAN_EID_VENDOR_SPECIFIC,
+			       &ie_len,
+			       (pbss_network->ie_length - _BEACON_IE_OFFSET_ - (ie_len + 2))
 		);
 		if ((p) && (!memcmp(p + 2, OUI1, 4))) {
-			if (rtw_parse_wpa_ie(
-				p,
+			if (rtw_parse_wpa_ie
+				(p,
 				ie_len + 2,
 				&group_cipher,
 				&pairwise_cipher,
 				NULL
 			) == _SUCCESS) {
-				psecuritypriv->dot11AuthAlgrthm = dot11AuthAlgrthm_8021X;
+				psecuritypriv->dot11_auth_algrthm = dot11_auth_algrthm_8021X;
 
 				psecuritypriv->dot8021xalg = 1;/* psk,  todo:802.1x */
 
@@ -1001,8 +988,8 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
 	pmlmepriv->qospriv.qos_option = 0;
 	if (pregistrypriv->wmm_enable) {
 		for (p = ie + _BEACON_IE_OFFSET_; ; p += (ie_len + 2)) {
-			p = rtw_get_ie(
-				p,
+			p = rtw_get_ie
+				(p,
 				WLAN_EID_VENDOR_SPECIFIC,
 				&ie_len,
 				(pbss_network->ie_length - _BEACON_IE_OFFSET_ - (ie_len + 2))
@@ -1028,8 +1015,8 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
 	}
 
 	/* parsing HT_CAP_IE */
-	p = rtw_get_ie(
-		ie + _BEACON_IE_OFFSET_,
+	p = rtw_get_ie
+		(ie + _BEACON_IE_OFFSET_,
 		WLAN_EID_HT_CAPABILITY,
 		&ie_len,
 		(pbss_network->ie_length - _BEACON_IE_OFFSET_)
@@ -1038,17 +1025,17 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
 		u8 max_rx_ampdu_factor = 0;
 		struct ieee80211_ht_cap *pht_cap = (struct ieee80211_ht_cap *)(p + 2);
 
-		pHT_caps_ie = p;
+		pht_caps_ie = p;
 
 		ht_cap = true;
 		network_type |= WIRELESS_11_24N;
 
 		rtw_ht_use_default_setting(padapter);
 
-		if (pmlmepriv->htpriv.sgi_20m == false)
+		if (!pmlmepriv->htpriv.sgi_20m)
 			pht_cap->cap_info &= cpu_to_le16(~(IEEE80211_HT_CAP_SGI_20));
 
-		if (pmlmepriv->htpriv.sgi_40m == false)
+		if (!pmlmepriv->htpriv.sgi_40m)
 			pht_cap->cap_info &= cpu_to_le16(~(IEEE80211_HT_CAP_SGI_40));
 
 		if (!TEST_FLAG(pmlmepriv->htpriv.ldpc_cap, LDPC_HT_ENABLE_RX))
@@ -1060,8 +1047,8 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
 		if (!TEST_FLAG(pmlmepriv->htpriv.stbc_cap, STBC_HT_ENABLE_RX))
 			pht_cap->cap_info &= cpu_to_le16(~(IEEE80211_HT_CAP_RX_STBC_3R));
 
-		pht_cap->ampdu_params_info &= ~(
-			IEEE80211_HT_CAP_AMPDU_FACTOR | IEEE80211_HT_CAP_AMPDU_DENSITY
+		pht_cap->ampdu_params_info &=
+			~(IEEE80211_HT_CAP_AMPDU_FACTOR | IEEE80211_HT_CAP_AMPDU_DENSITY
 		);
 
 		if ((psecuritypriv->wpa_pairwise_cipher & WPA_CIPHER_CCMP) ||
@@ -1073,13 +1060,12 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
 						       0x00);
 		}
 
-		rtw_hal_get_def_var(
-			padapter,
-			HW_VAR_MAX_RX_AMPDU_FACTOR,
-			&max_rx_ampdu_factor
+		rtw_hal_get_def_var(padapter,
+				    HW_VAR_MAX_RX_AMPDU_FACTOR,
+				    &max_rx_ampdu_factor
 		);
-		pht_cap->ampdu_params_info |= (
-			IEEE80211_HT_CAP_AMPDU_FACTOR & max_rx_ampdu_factor
+		pht_cap->ampdu_params_info |=
+		(IEEE80211_HT_CAP_AMPDU_FACTOR & max_rx_ampdu_factor
 		); /* set  Max Rx AMPDU size  to 64K */
 
 		pht_cap->mcs.rx_mask[0] = 0xff;
@@ -1089,27 +1075,27 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
 	}
 
 	/* parsing HT_INFO_IE */
-	p = rtw_get_ie(
-		ie + _BEACON_IE_OFFSET_,
+	p = rtw_get_ie
+		(ie + _BEACON_IE_OFFSET_,
 		WLAN_EID_HT_OPERATION,
 		&ie_len,
 		(pbss_network->ie_length - _BEACON_IE_OFFSET_)
 	);
 	if (p && ie_len > 0)
-		pHT_info_ie = p;
+		pht_info_ie = p;
 
 	switch (network_type) {
 	case WIRELESS_11B:
-		pbss_network->network_type_in_use = Ndis802_11DS;
+		pbss_network->network_type_in_use = ndis802_11ds;
 		break;
 	case WIRELESS_11G:
 	case WIRELESS_11BG:
 	case WIRELESS_11G_24N:
 	case WIRELESS_11BG_24N:
-		pbss_network->network_type_in_use = Ndis802_11OFDM24;
+		pbss_network->network_type_in_use = ndis802_11ofdm24;
 		break;
 	default:
-		pbss_network->network_type_in_use = Ndis802_11OFDM24;
+		pbss_network->network_type_in_use = ndis802_11ofdm24;
 		break;
 	}
 
@@ -1131,13 +1117,13 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
 		if (pregistrypriv->ampdu_enable == 1)
 			pmlmepriv->htpriv.ampdu_enable = true;
 
-		HT_caps_handler(padapter, (struct ndis_80211_var_ie *)pHT_caps_ie);
+		ht_caps_handler(padapter, (struct ndis_80211_var_ie *)pht_caps_ie);
 
-		HT_info_handler(padapter, (struct ndis_80211_var_ie *)pHT_info_ie);
+		ht_info_handler(padapter, (struct ndis_80211_var_ie *)pht_info_ie);
 	}
 
-	pbss_network->length = get_wlan_bssid_ex_sz(
-		(struct wlan_bssid_ex  *)pbss_network
+	pbss_network->length = get_wlan_bssid_ex_sz
+		((struct wlan_bssid_ex  *)pbss_network
 	);
 
 	/* issue beacon to start bss network */
@@ -1155,7 +1141,8 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
 	/*  update AP's sta info */
 	update_ap_info(padapter, psta);
 
-	psta->state |= WIFI_AP_STATE;		/* Aries, add, fix bug of flush_cam_entry at STOP AP mode , 0724 */
+	psta->state |= WIFI_AP_STATE;	/* Aries, add, fix bug of flush_cam_entry */
+	/* at STOP AP mode , 0724 */
 	rtw_indicate_connect(padapter);
 
 	pmlmepriv->cur_network.join_res = true;/* for check if already set beacon */
@@ -1187,26 +1174,26 @@ int rtw_acl_add_sta(struct adapter *padapter, u8 *addr)
 	if ((NUM_ACL - 1) < pacl_list->num)
 		return (-1);
 
-	spin_lock_bh(&(pacl_node_q->lock));
+	spin_lock_bh(&pacl_node_q->lock);
 
 	phead = get_list_head(pacl_node_q);
 	list_for_each(plist, phead) {
 		paclnode = list_entry(plist, struct rtw_wlan_acl_node, list);
 
 		if (!memcmp(paclnode->addr, addr, ETH_ALEN)) {
-			if (paclnode->valid == true) {
+			if (paclnode->valid) {
 				added = true;
 				break;
 			}
 		}
 	}
 
-	spin_unlock_bh(&(pacl_node_q->lock));
+	spin_unlock_bh(&pacl_node_q->lock);
 
 	if (added)
 		return ret;
 
-	spin_lock_bh(&(pacl_node_q->lock));
+	spin_lock_bh(&pacl_node_q->lock);
 
 	for (i = 0; i < NUM_ACL; i++) {
 		paclnode = &pacl_list->aclnode[i];
@@ -1226,7 +1213,7 @@ int rtw_acl_add_sta(struct adapter *padapter, u8 *addr)
 		}
 	}
 
-	spin_unlock_bh(&(pacl_node_q->lock));
+	spin_unlock_bh(&pacl_node_q->lock);
 
 	return ret;
 }
@@ -1238,17 +1225,17 @@ void rtw_acl_remove_sta(struct adapter *padapter, u8 *addr)
 	struct sta_priv *pstapriv = &padapter->stapriv;
 	struct wlan_acl_pool *pacl_list = &pstapriv->acl_list;
 	struct __queue	*pacl_node_q = &pacl_list->acl_node_q;
-	u8 baddr[ETH_ALEN] = { 0xff, 0xff, 0xff, 0xff, 0xff, 0xff };	/* Baddr is used for clearing acl_list */
+	u8 baddr[ETH_ALEN] = { 0xff, 0xff, 0xff, 0xff, 0xff, 0xff };	/* Baddr is */
+	/* used for clearing acl_list */
 
-	spin_lock_bh(&(pacl_node_q->lock));
+	spin_lock_bh(&pacl_node_q->lock);
 
 	phead = get_list_head(pacl_node_q);
 	list_for_each_safe(plist, tmp, phead) {
 		paclnode = list_entry(plist, struct rtw_wlan_acl_node, list);
 
-		if (
-			!memcmp(paclnode->addr, addr, ETH_ALEN) ||
-			!memcmp(baddr, addr, ETH_ALEN)
+		if (!memcmp(paclnode->addr, addr, ETH_ALEN) ||
+		    !memcmp(baddr, addr, ETH_ALEN)
 		) {
 			if (paclnode->valid) {
 				paclnode->valid = false;
@@ -1260,8 +1247,7 @@ void rtw_acl_remove_sta(struct adapter *padapter, u8 *addr)
 		}
 	}
 
-	spin_unlock_bh(&(pacl_node_q->lock));
-
+	spin_unlock_bh(&pacl_node_q->lock);
 }
 
 u8 rtw_ap_set_pairwise_key(struct adapter *padapter, struct sta_info *psta)
@@ -1284,13 +1270,13 @@ u8 rtw_ap_set_pairwise_key(struct adapter *padapter, struct sta_info *psta)
 		goto exit;
 	}
 
-	init_h2fwcmd_w_parm_no_rsp(ph2c, psetstakey_para, _SetStaKey_CMD_);
+	init_h2fwcmd_w_parm_no_rsp(ph2c, psetstakey_para, _set_stakey_cmd_);
 
-	psetstakey_para->algorithm = (u8)psta->dot118021XPrivacy;
+	psetstakey_para->algorithm = (u8)psta->dot118021_xprivacy;
 
 	memcpy(psetstakey_para->addr, psta->hwaddr, ETH_ALEN);
 
-	memcpy(psetstakey_para->key, &psta->dot118021x_UncstKey, 16);
+	memcpy(psetstakey_para->key, &psta->dot118021x_uncst_key, 16);
 
 	res = rtw_enqueue_cmd(pcmdpriv, ph2c);
 
@@ -1299,18 +1285,17 @@ u8 rtw_ap_set_pairwise_key(struct adapter *padapter, struct sta_info *psta)
 	return res;
 }
 
-static int rtw_ap_set_key(
-	struct adapter *padapter,
-	u8 *key,
-	u8 alg,
-	int keyid,
-	u8 set_tx
+static int rtw_ap_set_key(struct adapter *padapter,
+			  u8 *key,
+			  u8 alg,
+			  int keyid,
+			  u8 set_tx
 )
 {
 	u8 keylen;
 	struct cmd_obj *pcmd;
 	struct setkey_parm *psetkeyparm;
-	struct cmd_priv *pcmdpriv = &(padapter->cmdpriv);
+	struct cmd_priv *pcmdpriv = &padapter->cmdpriv;
 	int res = _SUCCESS;
 
 	pcmd = rtw_zmalloc(sizeof(struct cmd_obj));
@@ -1347,9 +1332,9 @@ static int rtw_ap_set_key(
 		keylen = 16;
 	}
 
-	memcpy(&(psetkeyparm->key[0]), key, keylen);
+	memcpy(&psetkeyparm->key[0], key, keylen);
 
-	pcmd->cmdcode = _SetKey_CMD_;
+	pcmd->cmdcode = _setkey_cmd_;
 	pcmd->parmbuf = (u8 *)psetkeyparm;
 	pcmd->cmdsz =  (sizeof(struct setkey_parm));
 	pcmd->rsp = NULL;
@@ -1369,12 +1354,11 @@ int rtw_ap_set_group_key(struct adapter *padapter, u8 *key, u8 alg, int keyid)
 	return rtw_ap_set_key(padapter, key, alg, keyid, 1);
 }
 
-int rtw_ap_set_wep_key(
-	struct adapter *padapter,
-	u8 *key,
-	u8 keylen,
-	int keyid,
-	u8 set_tx
+int rtw_ap_set_wep_key(struct adapter *padapter,
+		       u8 *key,
+		       u8 keylen,
+		       int keyid,
+		       u8 set_tx
 )
 {
 	u8 alg;
@@ -1399,10 +1383,10 @@ static void update_bcn_fixed_ie(struct adapter *padapter)
 
 static void update_bcn_erpinfo_ie(struct adapter *padapter)
 {
-	struct mlme_priv *pmlmepriv = &(padapter->mlmepriv);
-	struct mlme_ext_priv *pmlmeext = &(padapter->mlmeextpriv);
-	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
-	struct wlan_bssid_ex *pnetwork = &(pmlmeinfo->network);
+	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
+	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
+	struct mlme_ext_info *pmlmeinfo = &pmlmeext->mlmext_info;
+	struct wlan_bssid_ex *pnetwork = &pmlmeinfo->network;
 	unsigned char *p, *ie = pnetwork->ies;
 	u32 len = 0;
 
@@ -1410,28 +1394,27 @@ static void update_bcn_erpinfo_ie(struct adapter *padapter)
 		return;
 
 	/* parsing ERP_IE */
-	p = rtw_get_ie(
-		ie + _BEACON_IE_OFFSET_,
-		WLAN_EID_ERP_INFO,
-		&len,
-		(pnetwork->ie_length - _BEACON_IE_OFFSET_)
+	p = rtw_get_ie(ie + _BEACON_IE_OFFSET_,
+		       WLAN_EID_ERP_INFO,
+		       &len,
+		       (pnetwork->ie_length - _BEACON_IE_OFFSET_)
 	);
 	if (p && len > 0) {
-		struct ndis_80211_var_ie *pIE = (struct ndis_80211_var_ie *)p;
+		struct ndis_80211_var_ie *p_ie = (struct ndis_80211_var_ie *)p;
 
 		if (pmlmepriv->num_sta_non_erp == 1)
-			pIE->data[0] |= RTW_ERP_INFO_NON_ERP_PRESENT | RTW_ERP_INFO_USE_PROTECTION;
+			p_ie->data[0] |= RTW_ERP_INFO_NON_ERP_PRESENT | RTW_ERP_INFO_USE_PROTECTION;
 		else
-			pIE->data[0] &= ~(
-				RTW_ERP_INFO_NON_ERP_PRESENT | RTW_ERP_INFO_USE_PROTECTION
+			p_ie->data[0] &=
+				~(RTW_ERP_INFO_NON_ERP_PRESENT | RTW_ERP_INFO_USE_PROTECTION
 			);
 
 		if (pmlmepriv->num_sta_no_short_preamble > 0)
-			pIE->data[0] |= RTW_ERP_INFO_BARKER_PREAMBLE_MODE;
+			p_ie->data[0] |= RTW_ERP_INFO_BARKER_PREAMBLE_MODE;
 		else
-			pIE->data[0] &= ~(RTW_ERP_INFO_BARKER_PREAMBLE_MODE);
+			p_ie->data[0] &= ~(RTW_ERP_INFO_BARKER_PREAMBLE_MODE);
 
-		ERP_IE_handler(padapter, pIE);
+		ERP_IE_handler(padapter, p_ie);
 	}
 }
 
@@ -1463,18 +1446,17 @@ static void update_bcn_wps_ie(struct adapter *padapter)
 	u8 *pbackup_remainder_ie = NULL;
 
 	uint wps_ielen = 0, wps_offset, remainder_ielen;
-	struct mlme_priv *pmlmepriv = &(padapter->mlmepriv);
-	struct mlme_ext_priv *pmlmeext = &(padapter->mlmeextpriv);
-	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
-	struct wlan_bssid_ex *pnetwork = &(pmlmeinfo->network);
+	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
+	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
+	struct mlme_ext_info *pmlmeinfo = &pmlmeext->mlmext_info;
+	struct wlan_bssid_ex *pnetwork = &pmlmeinfo->network;
 	unsigned char *ie = pnetwork->ies;
 	u32 ielen = pnetwork->ie_length;
 
-	pwps_ie = rtw_get_wps_ie(
-		ie + _FIXED_IE_LENGTH_,
-		ielen - _FIXED_IE_LENGTH_,
-		NULL,
-		&wps_ielen
+	pwps_ie = rtw_get_wps_ie(ie + _FIXED_IE_LENGTH_,
+				 ielen - _FIXED_IE_LENGTH_,
+				 NULL,
+				 &wps_ielen
 	);
 
 	if (!pwps_ie || wps_ielen == 0)
@@ -1499,7 +1481,7 @@ static void update_bcn_wps_ie(struct adapter *padapter)
 	wps_ielen = (uint)pwps_ie_src[1];/* to get ie data len */
 	if ((wps_offset + wps_ielen + 2 + remainder_ielen) <= MAX_IE_SZ) {
 		memcpy(pwps_ie, pwps_ie_src, wps_ielen + 2);
-		pwps_ie += (wps_ielen+2);
+		pwps_ie += (wps_ielen + 2);
 
 		if (pbackup_remainder_ie)
 			memcpy(pwps_ie, pbackup_remainder_ie, remainder_ielen);
@@ -1539,8 +1521,8 @@ void update_beacon(struct adapter *padapter, u8 ie_id, u8 *oui, u8 tx)
 	if (!padapter)
 		return;
 
-	pmlmepriv = &(padapter->mlmepriv);
-	pmlmeext = &(padapter->mlmeextpriv);
+	pmlmepriv = &padapter->mlmepriv;
+	pmlmeext = &padapter->mlmeextpriv;
 	/* pmlmeinfo = &(pmlmeext->mlmext_info); */
 
 	if (!pmlmeext->bstart_bss)
@@ -1621,14 +1603,14 @@ static int rtw_ht_operation_update(struct adapter *padapter)
 {
 	u16 cur_op_mode, new_op_mode;
 	int op_mode_changes = 0;
-	struct mlme_priv *pmlmepriv = &(padapter->mlmepriv);
+	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	struct ht_priv *phtpriv_ap = &pmlmepriv->htpriv;
 
 	if (pmlmepriv->htpriv.ht_option)
 		return 0;
 
-	if (!(pmlmepriv->ht_op_mode & IEEE80211_HT_OP_MODE_NON_GF_STA_PRSNT)
-	    && pmlmepriv->num_sta_ht_no_gf) {
+	if (!(pmlmepriv->ht_op_mode & IEEE80211_HT_OP_MODE_NON_GF_STA_PRSNT) &&
+	    pmlmepriv->num_sta_ht_no_gf) {
 		pmlmepriv->ht_op_mode |=
 			IEEE80211_HT_OP_MODE_NON_GF_STA_PRSNT;
 		op_mode_changes++;
@@ -1660,9 +1642,8 @@ static int rtw_ht_operation_update(struct adapter *padapter)
 	if (pmlmepriv->num_sta_no_ht ||
 	    (pmlmepriv->ht_op_mode & IEEE80211_HT_OP_MODE_NON_GF_STA_PRSNT))
 		new_op_mode = IEEE80211_HT_OP_MODE_PROTECTION_NONHT_MIXED;
-	else if (
-		(le16_to_cpu(phtpriv_ap->ht_cap.cap_info) & IEEE80211_HT_CAP_SUP_WIDTH)
-		&& pmlmepriv->num_sta_ht_20mhz)
+	else if ((le16_to_cpu(phtpriv_ap->ht_cap.cap_info) &
+			IEEE80211_HT_CAP_SUP_WIDTH) && pmlmepriv->num_sta_ht_20mhz)
 		new_op_mode = IEEE80211_HT_OP_MODE_PROTECTION_20MHZ;
 	else if (pmlmepriv->olbc_ht)
 		new_op_mode = IEEE80211_HT_OP_MODE_PROTECTION_NONMEMBER;
@@ -1705,8 +1686,8 @@ void associated_clients_update(struct adapter *padapter, u8 updated)
 void bss_cap_update_on_sta_join(struct adapter *padapter, struct sta_info *psta)
 {
 	u8 beacon_updated = false;
-	struct mlme_priv *pmlmepriv = &(padapter->mlmepriv);
-	struct mlme_ext_priv *pmlmeext = &(padapter->mlmeextpriv);
+	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
+	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
 
 	if (!(psta->flags & WLAN_STA_SHORT_PREAMBLE)) {
 		if (!psta->no_short_preamble_set) {
@@ -1825,8 +1806,8 @@ void bss_cap_update_on_sta_join(struct adapter *padapter, struct sta_info *psta)
 u8 bss_cap_update_on_sta_leave(struct adapter *padapter, struct sta_info *psta)
 {
 	u8 beacon_updated = false;
-	struct mlme_priv *pmlmepriv = &(padapter->mlmepriv);
-	struct mlme_ext_priv *pmlmeext = &(padapter->mlmeextpriv);
+	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
+	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
 
 	if (!psta)
 		return beacon_updated;
@@ -1834,8 +1815,8 @@ u8 bss_cap_update_on_sta_leave(struct adapter *padapter, struct sta_info *psta)
 	if (psta->no_short_preamble_set) {
 		psta->no_short_preamble_set = 0;
 		pmlmepriv->num_sta_no_short_preamble--;
-		if (pmlmeext->cur_wireless_mode > WIRELESS_11B
-		    && pmlmepriv->num_sta_no_short_preamble == 0){
+		if (pmlmeext->cur_wireless_mode > WIRELESS_11B &&
+		    pmlmepriv->num_sta_no_short_preamble == 0){
 			beacon_updated = true;
 			update_beacon(padapter, 0xFF, NULL, true);
 		}
@@ -1853,8 +1834,8 @@ u8 bss_cap_update_on_sta_leave(struct adapter *padapter, struct sta_info *psta)
 	if (psta->no_short_slot_time_set) {
 		psta->no_short_slot_time_set = 0;
 		pmlmepriv->num_sta_no_short_slot_time--;
-		if (pmlmeext->cur_wireless_mode > WIRELESS_11B
-		    && pmlmepriv->num_sta_no_short_slot_time == 0){
+		if (pmlmeext->cur_wireless_mode > WIRELESS_11B &&
+		    pmlmepriv->num_sta_no_short_slot_time == 0){
 			beacon_updated = true;
 			update_beacon(padapter, 0xFF, NULL, true);
 		}
@@ -1883,11 +1864,10 @@ u8 bss_cap_update_on_sta_leave(struct adapter *padapter, struct sta_info *psta)
 	return beacon_updated;
 }
 
-u8 ap_free_sta(
-	struct adapter *padapter,
-	struct sta_info *psta,
-	bool active,
-	u16 reason
+u8 ap_free_sta(struct adapter *padapter,
+	       struct sta_info *psta,
+	       bool active,
+	       u16 reason
 )
 {
 	u8 beacon_updated = false;
@@ -1934,7 +1914,7 @@ void rtw_sta_flush(struct adapter *padapter)
 	struct sta_info *psta = NULL;
 	struct sta_priv *pstapriv = &padapter->stapriv;
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
-	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
+	struct mlme_ext_info *pmlmeinfo = &pmlmeext->mlmext_info;
 	u8 bc_addr[ETH_ALEN] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
 
 	if ((pmlmeinfo->state & 0x03) != WIFI_FW_AP_STATE)
@@ -1964,7 +1944,7 @@ void rtw_sta_flush(struct adapter *padapter)
 void sta_info_update(struct adapter *padapter, struct sta_info *psta)
 {
 	int flags = psta->flags;
-	struct mlme_priv *pmlmepriv = &(padapter->mlmepriv);
+	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 
 	/* update wmm cap. */
 	if (WLAN_STA_WME & flags)
@@ -1993,47 +1973,46 @@ void sta_info_update(struct adapter *padapter, struct sta_info *psta)
 void ap_sta_info_defer_update(struct adapter *padapter, struct sta_info *psta)
 {
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
-	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
+	struct mlme_ext_info *pmlmeinfo = &pmlmeext->mlmext_info;
 
 	if (psta->state & _FW_LINKED) {
 		pmlmeinfo->FW_sta_info[psta->mac_id].psta = psta;
 
 		/* add ratid */
-		add_RATid(padapter, psta, 0);/* DM_RATR_STA_INIT */
+		add_rat_id(padapter, psta, 0);/* DM_RATR_STA_INIT */
 	}
 }
+
 /* restore hw setting from sw data structures */
 void rtw_ap_restore_network(struct adapter *padapter)
 {
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
 	struct sta_priv *pstapriv = &padapter->stapriv;
 	struct sta_info *psta;
-	struct security_priv *psecuritypriv = &(padapter->securitypriv);
+	struct security_priv *psecuritypriv = &padapter->securitypriv;
 	struct list_head	*phead, *plist;
 	u8 chk_alive_num = 0;
 	char chk_alive_list[NUM_STA];
 	int i;
 
-	rtw_setopmode_cmd(padapter, Ndis802_11APMode, false);
+	rtw_setopmode_cmd(padapter, ndis802_11apmode, false);
 
-	set_channel_bwmode(
-		padapter,
-		pmlmeext->cur_channel,
-		pmlmeext->cur_ch_offset,
-		pmlmeext->cur_bwmode
+	set_channel_bwmode(padapter,
+			   pmlmeext->cur_channel,
+			   pmlmeext->cur_ch_offset,
+			   pmlmeext->cur_bwmode
 	);
 
 	start_bss_network(padapter);
 
-	if ((padapter->securitypriv.dot11PrivacyAlgrthm == _TKIP_) ||
-	    (padapter->securitypriv.dot11PrivacyAlgrthm == _AES_)) {
+	if ((padapter->securitypriv.dot11_privacy_algrthm == _TKIP_) ||
+	    (padapter->securitypriv.dot11_privacy_algrthm == _AES_)) {
 		/* restore group key, WEP keys is restored in ips_leave() */
-		rtw_set_key(
-			padapter,
-			psecuritypriv,
-			psecuritypriv->dot118021XGrpKeyid,
-			0,
-			false
+		rtw_set_key(padapter,
+			    psecuritypriv,
+			    psecuritypriv->dot118021_xgrp_keyid,
+			    0,
+			    false
 		);
 	}
 
@@ -2060,11 +2039,11 @@ void rtw_ap_restore_network(struct adapter *padapter)
 
 		if (psta->state & _FW_LINKED) {
 			rtw_sta_media_status_rpt(padapter, psta, 1);
-			Update_RA_Entry(padapter, psta);
+			update_ra_entry(padapter, psta);
 			/* pairwise key */
 			/* per sta pairwise key and settings */
-			if ((psecuritypriv->dot11PrivacyAlgrthm == _TKIP_) ||
-			    (psecuritypriv->dot11PrivacyAlgrthm == _AES_)) {
+			if ((psecuritypriv->dot11_privacy_algrthm == _TKIP_) ||
+			    (psecuritypriv->dot11_privacy_algrthm == _AES_)) {
 				rtw_setstakey_cmd(padapter, psta, true, false);
 			}
 		}
@@ -2074,7 +2053,7 @@ void rtw_ap_restore_network(struct adapter *padapter)
 void start_ap_mode(struct adapter *padapter)
 {
 	int i;
-	struct mlme_priv *pmlmepriv = &(padapter->mlmepriv);
+	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	struct sta_priv *pstapriv = &padapter->stapriv;
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
 	struct wlan_acl_pool *pacl_list = &pstapriv->acl_list;
@@ -2111,7 +2090,7 @@ void start_ap_mode(struct adapter *padapter)
 	pmlmepriv->p2p_probe_resp_ie = NULL;
 
 	/* for ACL */
-	INIT_LIST_HEAD(&(pacl_list->acl_node_q.queue));
+	INIT_LIST_HEAD(&pacl_list->acl_node_q.queue);
 	pacl_list->num = 0;
 	pacl_list->mode = 0;
 	for (i = 0; i < NUM_ACL; i++) {
@@ -2126,7 +2105,7 @@ void stop_ap_mode(struct adapter *padapter)
 	struct rtw_wlan_acl_node *paclnode;
 	struct sta_info *psta = NULL;
 	struct sta_priv *pstapriv = &padapter->stapriv;
-	struct mlme_priv *pmlmepriv = &(padapter->mlmepriv);
+	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
 	struct wlan_acl_pool *pacl_list = &pstapriv->acl_list;
 	struct __queue	*pacl_node_q = &pacl_list->acl_node_q;
@@ -2135,16 +2114,15 @@ void stop_ap_mode(struct adapter *padapter)
 	pmlmeext->bstart_bss = false;
 
 	/* reset and init security priv , this can refine with rtw_reset_securitypriv */
-	memset(
-		(unsigned char *)&padapter->securitypriv,
-		0,
-		sizeof(struct security_priv)
+	memset((unsigned char *)&padapter->securitypriv,
+	       0,
+	       sizeof(struct security_priv)
 	);
-	padapter->securitypriv.ndisauthtype = Ndis802_11AuthModeOpen;
-	padapter->securitypriv.ndisencryptstatus = Ndis802_11WEPDisabled;
+	padapter->securitypriv.ndisauthtype = ndis802_11auth_mode_open;
+	padapter->securitypriv.ndisencryptstatus = ndis802_11wep_disabled;
 
 	/* for ACL */
-	spin_lock_bh(&(pacl_node_q->lock));
+	spin_lock_bh(&pacl_node_q->lock);
 	phead = get_list_head(pacl_node_q);
 	list_for_each_safe(plist, tmp, phead) {
 		paclnode = list_entry(plist, struct rtw_wlan_acl_node, list);
@@ -2157,7 +2135,7 @@ void stop_ap_mode(struct adapter *padapter)
 			pacl_list->num--;
 		}
 	}
-	spin_unlock_bh(&(pacl_node_q->lock));
+	spin_unlock_bh(&pacl_node_q->lock);
 
 	rtw_sta_flush(padapter);
 
@@ -2171,5 +2149,5 @@ void stop_ap_mode(struct adapter *padapter)
 
 	rtw_free_mlme_priv_ie_data(pmlmepriv);
 
-	rtw_btcoex_MediaStatusNotify(padapter, 0); /* disconnect */
+	rtw_btcoex_media_status_notify(padapter, 0); /* disconnect */
 }
-- 
2.25.1

