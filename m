Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5AF9501EE6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 01:09:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239609AbiDNXKo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 19:10:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232684AbiDNXKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 19:10:41 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37CE3B1A93
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 16:08:09 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id j8so5879306pll.11
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 16:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs-iitr-ac-in.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=GvZRAUI4B8TvnwdtYzuqjiMqNoZJy4HZ3jhXJO2vTlA=;
        b=QrKZyKd6NBm5yFHKHY7v5DwGjN9+3cH/wf4KjS2w8xJXtD9P0O542w3fQtaV+G08Wy
         DEjhLOJx7bFtChPat5mTfYZia1dniu7oT9trGOYc5MQBoy1Tu1oWCouSSA+Wik7pTO+9
         Kn9RQ3iXI9ZHedXoleZWQ0uSZ/f0xvfg57WQflh5C+WpOwi5XkJTH6nzLIo7/cpxZXeR
         ZuTDwJMTyVdfQ7fhn0n5sQc3C69Ws5Q1fg5pCd+L+HodxljfKn/1/0fUz5yhm4XS2tj7
         yJPOKA7KFLnncHS9IocunmlTJmjvTIwJdQ79XJwqm6K3Wi3ukooemJPJH4UULLDj3tiB
         Er7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=GvZRAUI4B8TvnwdtYzuqjiMqNoZJy4HZ3jhXJO2vTlA=;
        b=s4DRlFN4TvESJa6834b/hsfm2gLUnLQytY6OmM6XrPkiJ/xdWIUmPWesDMxwOXKvV0
         YqL7C9USc5pxt38OYZiqN23U39DokKwRgpOzDHrnReiPkMbHseq54S6G8pVEtVKJlFoC
         2C3Hj0ETynaXglARHdetWtT4v6gcOtT+aOeYCV9O69+h8YjdHaIyoUYX0CQYkrvRufCR
         ZJhD9gnCO6PtlHTH+8qm4tR32RLTzVBrA/ylKjTQTGwtcp0FXaBissSor8nB566lb1vb
         TFE6UCEpdcF4+wathS2y2isOCy/gSqDnogHs/CTNG85n5wl1/Znyps7vr2nlB8gIza/X
         6pCA==
X-Gm-Message-State: AOAM5305gBFplbtNj7z30yj1JLOLqVI3d1xye4ATPZ6FiMcM3GF0X9Tf
        MW/Nzz8YqbxJs+pmNXhmN4yHIQ==
X-Google-Smtp-Source: ABdhPJzaXynYlh/NdWs6XWES7snVaQ9gPplu3lSmLHXCuzKQo63CK5QP9oOqaVSfWDhaO5EfR1cXmg==
X-Received: by 2002:a17:90b:4a82:b0:1c7:8a44:e0c9 with SMTP id lp2-20020a17090b4a8200b001c78a44e0c9mr973767pjb.102.1649977688622;
        Thu, 14 Apr 2022 16:08:08 -0700 (PDT)
Received: from mahak-Inspiron-7570.iitr.ac.in ([103.37.201.168])
        by smtp.googlemail.com with ESMTPSA id bm27-20020a656e9b000000b0039e5d327f78sm2874058pgb.44.2022.04.14.16.08.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 16:08:08 -0700 (PDT)
From:   Mahak Gupta <mahak_g@cs.iitr.ac.in>
To:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, outreachy@lists.linux.dev
Cc:     Mahak Gupta <mahak_g@cs.iitr.ac.in>
Subject: [PATCH] staging: r8188eu: place constants in right side in a comparison
Date:   Fri, 15 Apr 2022 04:37:57 +0530
Message-Id: <20220414230757.19348-1-mahak_g@cs.iitr.ac.in>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

reported by checkpatch:

Comparisons should place the constant on the right side of the test.

Fix these warnings.

Signed-off-by: Mahak Gupta <mahak_g@cs.iitr.ac.in>
---
 drivers/staging/r8188eu/core/rtw_ieee80211.c |  4 +--
 drivers/staging/r8188eu/core/rtw_ioctl_set.c |  4 +--
 drivers/staging/r8188eu/core/rtw_iol.c       |  4 +--
 drivers/staging/r8188eu/core/rtw_mlme.c      | 12 ++++----
 drivers/staging/r8188eu/core/rtw_mlme_ext.c  | 30 ++++++++++----------
 5 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_ieee80211.c b/drivers/staging/r8188eu/core/rtw_ieee80211.c
index bb4c9bc864da..385a9ed8eff7 100644
--- a/drivers/staging/r8188eu/core/rtw_ieee80211.c
+++ b/drivers/staging/r8188eu/core/rtw_ieee80211.c
@@ -1051,7 +1051,7 @@ static int rtw_get_cipher_info(struct wlan_network *pnetwork)
 	pbuf = rtw_get_wpa_ie(&pnetwork->network.IEs[12], &wpa_ielen, pnetwork->network.IELength - 12);
 
 	if (pbuf && (wpa_ielen > 0)) {
-		if (_SUCCESS == rtw_parse_wpa_ie(pbuf, wpa_ielen + 2, &group_cipher, &pairwise_cipher, &is8021x)) {
+		if (rtw_parse_wpa_ie(pbuf, wpa_ielen + 2, &group_cipher, &pairwise_cipher, &is8021x) == _SUCCESS) {
 			pnetwork->BcnInfo.pairwise_cipher = pairwise_cipher;
 			pnetwork->BcnInfo.group_cipher = group_cipher;
 			pnetwork->BcnInfo.is_8021x = is8021x;
@@ -1061,7 +1061,7 @@ static int rtw_get_cipher_info(struct wlan_network *pnetwork)
 		pbuf = rtw_get_wpa2_ie(&pnetwork->network.IEs[12], &wpa_ielen, pnetwork->network.IELength - 12);
 
 		if (pbuf && (wpa_ielen > 0)) {
-			if (_SUCCESS == rtw_parse_wpa2_ie(pbuf, wpa_ielen + 2, &group_cipher, &pairwise_cipher, &is8021x)) {
+			if (rtw_parse_wpa2_ie(pbuf, wpa_ielen + 2, &group_cipher, &pairwise_cipher, &is8021x) == _SUCCESS) {
 				pnetwork->BcnInfo.pairwise_cipher = pairwise_cipher;
 				pnetwork->BcnInfo.group_cipher = group_cipher;
 				pnetwork->BcnInfo.is_8021x = is8021x;
diff --git a/drivers/staging/r8188eu/core/rtw_ioctl_set.c b/drivers/staging/r8188eu/core/rtw_ioctl_set.c
index 9df6fb122bc5..06da79829622 100644
--- a/drivers/staging/r8188eu/core/rtw_ioctl_set.c
+++ b/drivers/staging/r8188eu/core/rtw_ioctl_set.c
@@ -44,7 +44,7 @@ u8 rtw_do_join(struct adapter *padapter)
 		    pmlmepriv->to_roaming > 0) {
 			/*  submit site_survey_cmd */
 			ret = rtw_sitesurvey_cmd(padapter, &pmlmepriv->assoc_ssid, 1, NULL, 0);
-			if (_SUCCESS != ret)
+			if (ret != _SUCCESS)
 				pmlmepriv->to_join = false;
 		} else {
 			pmlmepriv->to_join = false;
@@ -91,7 +91,7 @@ u8 rtw_do_join(struct adapter *padapter)
 				if (!pmlmepriv->LinkDetectInfo.bBusyTraffic ||
 				    pmlmepriv->to_roaming > 0) {
 					ret = rtw_sitesurvey_cmd(padapter, &pmlmepriv->assoc_ssid, 1, NULL, 0);
-					if (_SUCCESS != ret)
+					if (ret != _SUCCESS)
 						pmlmepriv->to_join = false;
 				} else {
 					ret = _FAIL;
diff --git a/drivers/staging/r8188eu/core/rtw_iol.c b/drivers/staging/r8188eu/core/rtw_iol.c
index e14e3746efdd..af8e84a41b85 100644
--- a/drivers/staging/r8188eu/core/rtw_iol.c
+++ b/drivers/staging/r8188eu/core/rtw_iol.c
@@ -57,10 +57,10 @@ int rtw_IOL_append_cmds(struct xmit_frame *xmit_frame, u8 *IOL_cmds, u32 cmd_len
 
 bool rtw_IOL_applied(struct adapter  *adapter)
 {
-	if (1 == adapter->registrypriv.fw_iol)
+	if (adapter->registrypriv.fw_iol == 1)
 		return true;
 
-	if ((2 == adapter->registrypriv.fw_iol) &&
+	if ((adapter->registrypriv.fw_iol == 2) &&
 	    (adapter_to_dvobj(adapter)->pusbdev->speed != USB_SPEED_HIGH))
 		return true;
 
diff --git a/drivers/staging/r8188eu/core/rtw_mlme.c b/drivers/staging/r8188eu/core/rtw_mlme.c
index fff359d79493..a2ead9dc210b 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme.c
@@ -722,7 +722,7 @@ void rtw_surveydone_event_callback(struct adapter	*adapter, u8 *pbuf)
 			set_fwstate(pmlmepriv, _FW_UNDER_LINKING);
 			pmlmepriv->to_join = false;
 			s_ret = rtw_select_and_join_from_scanned_queue(pmlmepriv);
-			if (_SUCCESS == s_ret) {
+			if (s_ret == _SUCCESS) {
 			     _set_timer(&pmlmepriv->assoc_timer, MAX_JOIN_TIMEOUT);
 			} else if (s_ret == 2) { /* there is no need to wait for join */
 				_clr_fwstate_(pmlmepriv, _FW_UNDER_LINKING);
@@ -730,7 +730,7 @@ void rtw_surveydone_event_callback(struct adapter	*adapter, u8 *pbuf)
 			} else {
 				if (rtw_to_roaming(adapter) != 0) {
 					if (--pmlmepriv->to_roaming == 0 ||
-					    _SUCCESS != rtw_sitesurvey_cmd(adapter, &pmlmepriv->assoc_ssid, 1, NULL, 0)) {
+					    rtw_sitesurvey_cmd(adapter, &pmlmepriv->assoc_ssid, 1, NULL, 0) != _SUCCESS) {
 						rtw_set_roaming(adapter, 0);
 						rtw_free_assoc_resources(adapter, 1);
 						rtw_indicate_disconnect(adapter);
@@ -1975,7 +1975,7 @@ void rtw_issue_addbareq_cmd(struct adapter *padapter, struct xmit_frame *pxmitfr
 		issued = (phtpriv->agg_enable_bitmap >> priority) & 0x1;
 		issued |= (phtpriv->candidate_tid_bitmap >> priority) & 0x1;
 
-		if (0 == issued) {
+		if (issued == 0) {
 			psta->htpriv.candidate_tid_bitmap |= BIT((u8)priority);
 			rtw_addbareq_cmd(padapter, (u8)priority, pattrib->ra);
 		}
@@ -2002,19 +2002,19 @@ void _rtw_roaming(struct adapter *padapter, struct wlan_network *tgt_network)
 	else
 		pnetwork = &pmlmepriv->cur_network;
 
-	if (0 < rtw_to_roaming(padapter)) {
+	if (rtw_to_roaming(padapter) > 0) {
 		memcpy(&pmlmepriv->assoc_ssid, &pnetwork->network.Ssid, sizeof(struct ndis_802_11_ssid));
 
 		pmlmepriv->assoc_by_bssid = false;
 
 		while (1) {
 			do_join_r = rtw_do_join(padapter);
-			if (_SUCCESS == do_join_r) {
+			if (do_join_r == _SUCCESS) {
 				break;
 			} else {
 				pmlmepriv->to_roaming--;
 
-				if (0 < pmlmepriv->to_roaming) {
+				if (pmlmepriv->to_roaming > 0) {
 					continue;
 				} else {
 					rtw_indicate_disconnect(padapter);
diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
index 26e188264525..207250e52bcf 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
@@ -286,11 +286,11 @@ static void init_channel_list(struct adapter *padapter, struct rt_channel_info *
 				continue;
 			}
 
-			if ((0 == padapter->registrypriv.ht_enable) && (8 == o->inc))
+			if ((padapter->registrypriv.ht_enable == 0) && (o->inc == 8))
 				continue;
 
-			if ((0 == (padapter->registrypriv.cbw40_enable & BIT(1))) &&
-			    ((BW40MINUS == o->bw) || (BW40PLUS == o->bw)))
+			if (((padapter->registrypriv.cbw40_enable & BIT(1)) == 0) &&
+			    ((o->bw == BW40MINUS) || (o->bw == BW40PLUS)))
 				continue;
 
 			if (!reg) {
@@ -319,7 +319,7 @@ static u8 init_channel_set(struct adapter *padapter, u8 ChannelPlan, struct rt_c
 
 	if (padapter->registrypriv.wireless_mode & WIRELESS_11G) {
 		b2_4GBand = true;
-		if (RT_CHANNEL_DOMAIN_REALTEK_DEFINE == ChannelPlan)
+		if (ChannelPlan == RT_CHANNEL_DOMAIN_REALTEK_DEFINE)
 			Index2G = RTW_CHANNEL_PLAN_MAP_REALTEK_DEFINE.Index2G;
 		else
 			Index2G = RTW_ChannelPlanMap[ChannelPlan].Index2G;
@@ -329,14 +329,14 @@ static u8 init_channel_set(struct adapter *padapter, u8 ChannelPlan, struct rt_c
 		for (index = 0; index < RTW_ChannelPlan2G[Index2G].Len; index++) {
 			channel_set[chanset_size].ChannelNum = RTW_ChannelPlan2G[Index2G].Channel[index];
 
-			if ((RT_CHANNEL_DOMAIN_GLOBAL_DOAMIN == ChannelPlan) ||/* Channel 1~11 is active, and 12~14 is passive */
-			    (RT_CHANNEL_DOMAIN_GLOBAL_DOAMIN_2G == ChannelPlan)) {
+			if ((ChannelPlan == RT_CHANNEL_DOMAIN_GLOBAL_DOAMIN) ||/* Channel 1~11 is active, and 12~14 is passive */
+			    (ChannelPlan == RT_CHANNEL_DOMAIN_GLOBAL_DOAMIN_2G)) {
 				if (channel_set[chanset_size].ChannelNum >= 1 && channel_set[chanset_size].ChannelNum <= 11)
 					channel_set[chanset_size].ScanType = SCAN_ACTIVE;
 				else if ((channel_set[chanset_size].ChannelNum  >= 12 && channel_set[chanset_size].ChannelNum  <= 14))
 					channel_set[chanset_size].ScanType  = SCAN_PASSIVE;
-			} else if (RT_CHANNEL_DOMAIN_WORLD_WIDE_13 == ChannelPlan ||
-				   RT_CHANNEL_DOMAIN_2G_WORLD == Index2G) {/*  channel 12~13, passive scan */
+			} else if (ChannelPlan == RT_CHANNEL_DOMAIN_WORLD_WIDE_13 ||
+				   Index2G == RT_CHANNEL_DOMAIN_2G_WORLD) {/*  channel 12~13, passive scan */
 				if (channel_set[chanset_size].ChannelNum <= 11)
 					channel_set[chanset_size].ScanType = SCAN_ACTIVE;
 				else
@@ -971,7 +971,7 @@ unsigned int OnAssocReq(struct adapter *padapter, struct recv_frame *precv_frame
 			status = _STATS_FAILURE_;
 	}
 
-	if (_STATS_SUCCESSFUL_ != status)
+	if (status != _STATS_SUCCESSFUL_)
 		goto OnAssocReqFail;
 
 	/*  check if the supported rate is ok */
@@ -1060,7 +1060,7 @@ unsigned int OnAssocReq(struct adapter *padapter, struct recv_frame *precv_frame
 		wpa_ie_len = 0;
 	}
 
-	if (_STATS_SUCCESSFUL_ != status)
+	if (status != _STATS_SUCCESSFUL_)
 		goto OnAssocReqFail;
 
 	pstat->flags &= ~(WLAN_STA_WPS | WLAN_STA_MAYBE_WPS);
@@ -1255,7 +1255,7 @@ unsigned int OnAssocReq(struct adapter *padapter, struct recv_frame *precv_frame
 	spin_unlock_bh(&pstapriv->asoc_list_lock);
 
 	/*  now the station is qualified to join our BSS... */
-	if (pstat && (pstat->state & WIFI_FW_ASSOC_SUCCESS) && (_STATS_SUCCESSFUL_ == status)) {
+	if (pstat && (pstat->state & WIFI_FW_ASSOC_SUCCESS) && (status == _STATS_SUCCESSFUL_)) {
 		/* 1 bss_cap_update & sta_info_update */
 		bss_cap_update_on_sta_join(padapter, pstat);
 		sta_info_update(padapter, pstat);
@@ -1431,7 +1431,7 @@ unsigned int OnDeAuth(struct adapter *padapter, struct recv_frame *precv_frame)
 		    (pmlmeinfo->state & WIFI_FW_ASSOC_STATE)) {
 			if (reason == WLAN_REASON_CLASS2_FRAME_FROM_NONAUTH_STA) {
 				ignore_received_deauth = 1;
-			} else if (WLAN_REASON_PREV_AUTH_NOT_VALID == reason) {
+			} else if (reason == WLAN_REASON_PREV_AUTH_NOT_VALID) {
 				// TODO: 802.11r
 				ignore_received_deauth = 1;
 			}
@@ -3651,7 +3651,7 @@ static unsigned int on_action_public_p2p(struct recv_frame *precv_frame)
 			pwdinfo->nego_req_info.benable = false;
 			result = process_p2p_group_negotation_resp(pwdinfo, frame_body, len);
 			issue_p2p_GO_confirm(pwdinfo->padapter, GetAddr2Ptr(pframe), result);
-			if (P2P_STATUS_SUCCESS == result) {
+			if (result == P2P_STATUS_SUCCESS) {
 				if (rtw_p2p_role(pwdinfo) == P2P_ROLE_CLIENT) {
 					pwdinfo->p2p_info.operation_ch[0] = pwdinfo->peer_operating_ch;
 					pwdinfo->p2p_info.scan_op_ch_only = 1;
@@ -3666,7 +3666,7 @@ static unsigned int on_action_public_p2p(struct recv_frame *precv_frame)
 		break;
 	case P2P_GO_NEGO_CONF:
 		result = process_p2p_group_negotation_confirm(pwdinfo, frame_body, len);
-		if (P2P_STATUS_SUCCESS == result) {
+		if (result == P2P_STATUS_SUCCESS) {
 			if (rtw_p2p_role(pwdinfo) == P2P_ROLE_CLIENT) {
 				pwdinfo->p2p_info.operation_ch[0] = pwdinfo->peer_operating_ch;
 				pwdinfo->p2p_info.scan_op_ch_only = 1;
@@ -7009,7 +7009,7 @@ void linked_status_chk(struct adapter *padapter)
 			if (pmlmeinfo->FW_sta_info[i].status == 1) {
 				psta = pmlmeinfo->FW_sta_info[i].psta;
 
-				if (NULL == psta)
+				if (psta == NULL)
 					continue;
 				if (pmlmeinfo->FW_sta_info[i].rx_pkt == sta_rx_pkts(psta)) {
 					if (pmlmeinfo->FW_sta_info[i].retry < 3) {
-- 
2.17.1

