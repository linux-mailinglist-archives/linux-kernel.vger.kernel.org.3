Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B9E44F20F4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 06:08:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbiDEDSZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 23:18:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230162AbiDEDSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 23:18:21 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6540820BE4
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 20:16:23 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id c4so9476421qtx.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 20:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GAZPy8F44T+0UHn6NtNi0+X4cBEopGldC0TkmN69u6E=;
        b=Tvs5t93qlKJXFjTRuA1d3oXkeH3RWES5t5aVX+YN5cBmDfZH61ahKKSb+xk7ovhwK8
         DooQk+HuiNUDg/iciQiiSkEkWQkEoUCB9IJgh+WPXiDIkA5gnW2JiRQJDhQb7K/8PbmW
         Y0Hbw8ger6LNEzJB1eRoxTRRfAJZasJtGiqHtVJGbcOrxaVOG5jflWca2tSTavBPxbWM
         FbgefUt/nJzztjUsGuxiNuUwsCQcUGQK7yIWLlZwpSONiIgDHlpfkBp2++CFTx2P+h0V
         cs4nTdlfpzBLX7hkgI2RFRxoH6XYoEq08cpsrBZzwD9SMSNB2bfsNVNafaO+bgOxiiZ6
         bQ1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GAZPy8F44T+0UHn6NtNi0+X4cBEopGldC0TkmN69u6E=;
        b=H/FaKe2Y7/TWmHYLmNxJVBPQEXIMWtSO/AgW6t/NO440eU8QvFii4z847CyEA0Q50r
         8wBjl+vfIyR/FDny7eumWWjd3oBgV4C9/2LBgSXAo2Qg6Xm9sBXXc7du5X6zewQPOStJ
         detAXG6ahgGb9AegkphB3nQhu0w/ipxusm1+zmWuZvFW6hbvx6q/uydFB2iGDtD8oucb
         ifk1IXpdTlklEcb6Qne34URj4pfq6a247GD9g5LMxu3jlWzukNGOrHfxb35RZXKiOm7H
         jw1v6nwJC9cnwThcE0jEera6jizXwQXTuy1YechgoMhldXfXVDLDrAn1DjSF62cHFa+j
         AjtQ==
X-Gm-Message-State: AOAM532MQicX2RobyQZCCSOCWLvUIFUszFCRaei0zQAfqTwOHoHPVM0l
        M9rmlYbC4lc+vERxSn/TUjgjVyR2z92tGw==
X-Google-Smtp-Source: ABdhPJwRCS8GZ/tEBfrBUHXfGvHoDb4CnX/y4XpkSFQ4NUIMPFi1c5y5AU4A6adp3ll+wV3HZ3IQvQ==
X-Received: by 2002:ac8:5c45:0:b0:2e1:9144:2849 with SMTP id j5-20020ac85c45000000b002e191442849mr1277533qtj.510.1649128582444;
        Mon, 04 Apr 2022 20:16:22 -0700 (PDT)
Received: from euclid ([71.58.109.160])
        by smtp.gmail.com with ESMTPSA id k13-20020a05622a03cd00b002e21621c243sm10455744qtx.39.2022.04.04.20.16.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 20:16:21 -0700 (PDT)
From:   Sevinj Aghayeva <sevinj.aghayeva@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev,
        Sevinj Aghayeva <sevinj.aghayeva@gmail.com>
Subject: [PATCH 1/5] staging: rtl8723bs: remove redundant braces in if statements
Date:   Mon,  4 Apr 2022 23:16:08 -0400
Message-Id: <5f3a013af7ca5ac02b4d680fa22a23049f5712db.1649128267.git.sevinj.aghayeva@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1649128267.git.sevinj.aghayeva@gmail.com>
References: <cover.1649128267.git.sevinj.aghayeva@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adhere to Linux kernel coding style.

Reported by checkpatch:

WARNING: braces {} are not necessary for single statement blocks

Signed-off-by: Sevinj Aghayeva <sevinj.aghayeva@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 79 +++++++------------
 1 file changed, 27 insertions(+), 52 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index 359a67462611..73891222f0d0 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -271,11 +271,9 @@ static int has_channel(struct rt_channel_info *channel_set,
 {
 	int i;
 
-	for (i = 0; i < chanset_size; i++) {
-		if (channel_set[i].ChannelNum == chan) {
+	for (i = 0; i < chanset_size; i++)
+		if (channel_set[i].ChannelNum == chan)
 			return 1;
-		}
-	}
 
 	return 0;
 }
@@ -649,9 +647,8 @@ unsigned int OnBeacon(struct adapter *padapter, union recv_frame *precv_frame)
 			if (psta) {
 				/* update WMM, ERP in the beacon */
 				/* todo: the timer is used instead of the number of the beacon received */
-				if ((sta_rx_pkts(psta) & 0xf) == 0) {
+				if ((sta_rx_pkts(psta) & 0xf) == 0)
 					update_beacon_info(padapter, pframe, len, psta);
-				}
 			} else {
 				/* allocate a new CAM entry for IBSS station */
 				cam_idx = allocate_fw_sta_entry(padapter);
@@ -916,11 +913,10 @@ unsigned int OnAuthClient(struct adapter *padapter, union recv_frame *precv_fram
 			go2asoc = 1;
 		}
 	} else if (seq == 4) {
-		if (pmlmeinfo->auth_algo == dot11AuthAlgrthm_Shared) {
+		if (pmlmeinfo->auth_algo == dot11AuthAlgrthm_Shared)
 			go2asoc = 1;
-		} else {
+		else
 			goto authclnt_fail;
-		}
 	} else {
 		/*  this is also illegal */
 		goto authclnt_fail;
@@ -1455,11 +1451,10 @@ unsigned int OnAssocRsp(struct adapter *padapter, union recv_frame *precv_frame)
 	UpdateBrateTbl(padapter, pmlmeinfo->network.supported_rates);
 
 report_assoc_result:
-	if (res > 0) {
+	if (res > 0)
 		rtw_buf_update(&pmlmepriv->assoc_rsp, &pmlmepriv->assoc_rsp_len, pframe, pkt_len);
-	} else {
+	else
 		rtw_buf_free(&pmlmepriv->assoc_rsp, &pmlmepriv->assoc_rsp_len);
-	}
 
 	report_join_res(padapter, res);
 
@@ -1531,9 +1526,8 @@ unsigned int OnDeAuth(struct adapter *padapter, union recv_frame *precv_frame)
 			   reason, GetAddr3Ptr(pframe),
 			   ignore_received_deauth);
 
-		if (ignore_received_deauth == 0) {
+		if (ignore_received_deauth == 0)
 			receive_disconnect(padapter, GetAddr3Ptr(pframe), reason);
-		}
 	}
 	pmlmepriv->LinkDetectInfo.bBusyTraffic = false;
 	return _SUCCESS;
@@ -1674,11 +1668,10 @@ unsigned int OnAction_back(struct adapter *padapter, union recv_frame *precv_fra
 			/* process_addba_req(padapter, (u8 *)&(pmlmeinfo->ADDBA_req), GetAddr3Ptr(pframe)); */
 			process_addba_req(padapter, (u8 *)&(pmlmeinfo->ADDBA_req), addr);
 
-			if (pmlmeinfo->accept_addba_req) {
+			if (pmlmeinfo->accept_addba_req)
 				issue_action_BA(padapter, addr, WLAN_ACTION_ADDBA_RESP, 0);
-			} else {
+			else
 				issue_action_BA(padapter, addr, WLAN_ACTION_ADDBA_RESP, 37);/* reject ADDBA Req */
-			}
 
 			break;
 
@@ -1774,9 +1767,8 @@ static unsigned int on_action_public_vendor(union recv_frame *precv_frame)
 	u8 *pframe = precv_frame->u.hdr.rx_data;
 	u8 *frame_body = pframe + sizeof(struct ieee80211_hdr_3addr);
 
-	if (!memcmp(frame_body + 2, P2P_OUI, 4)) {
+	if (!memcmp(frame_body + 2, P2P_OUI, 4))
 		ret = on_action_public_p2p(precv_frame);
-	}
 
 	return ret;
 }
@@ -2187,9 +2179,8 @@ void issue_beacon(struct adapter *padapter, int timeout_ms)
 
 			wps_ie = rtw_get_wps_ie(pmgntframe->buf_addr+TXDESC_OFFSET+sizeof(struct ieee80211_hdr_3addr)+_BEACON_IE_OFFSET_,
 				pattrib->pktlen-sizeof(struct ieee80211_hdr_3addr)-_BEACON_IE_OFFSET_, NULL, &wps_ielen);
-			if (wps_ie && wps_ielen > 0) {
+			if (wps_ie && wps_ielen > 0)
 				rtw_get_wps_attr_content(wps_ie,  wps_ielen, WPS_ATTR_SELECTED_REGISTRAR, (u8 *)(&sr), NULL);
-			}
 			if (sr != 0)
 				set_fwstate(pmlmepriv, WIFI_UNDER_WPS);
 			else
@@ -2245,9 +2236,8 @@ void issue_beacon(struct adapter *padapter, int timeout_ms)
 
 
 	/*  EXTERNDED SUPPORTED RATE */
-	if (rate_len > 8) {
+	if (rate_len > 8)
 		pframe = rtw_set_ie(pframe, WLAN_EID_EXT_SUPP_RATES, (rate_len - 8), (cur_network->supported_rates + 8), &pattrib->pktlen);
-	}
 
 
 	/* todo:HT for adhoc */
@@ -2447,9 +2437,8 @@ void issue_probersp(struct adapter *padapter, unsigned char *da, u8 is_valid_p2p
 
 
 		/*  EXTERNDED SUPPORTED RATE */
-		if (rate_len > 8) {
+		if (rate_len > 8)
 			pframe = rtw_set_ie(pframe, WLAN_EID_EXT_SUPP_RATES, (rate_len - 8), (cur_network->supported_rates + 8), &pattrib->pktlen);
-		}
 
 
 		/* todo:HT for adhoc */
@@ -2674,9 +2663,8 @@ void issue_auth(struct adapter *padapter, struct sta_info *psta, unsigned short
 
 		/*  setting auth algo number */
 		val16 = (pmlmeinfo->auth_algo == dot11AuthAlgrthm_Shared) ? 1 : 0;/*  0:OPEN System, 1:Shared key */
-		if (val16) {
+		if (val16)
 			use_shared_key = 1;
-		}
 		le_tmp = cpu_to_le16(val16);
 
 		/* setting IV for auth seq #3 */
@@ -2831,16 +2819,14 @@ void issue_asocrsp(struct adapter *padapter, unsigned short status, struct sta_i
 				break;
 			}
 
-			if (!pbuf || ie_len == 0) {
+			if (!pbuf || ie_len == 0)
 				break;
-			}
 		}
 
 	}
 
-	if (pmlmeinfo->assoc_AP_vendor == HT_IOT_PEER_REALTEK) {
+	if (pmlmeinfo->assoc_AP_vendor == HT_IOT_PEER_REALTEK)
 		pframe = rtw_set_ie(pframe, WLAN_EID_VENDOR_SPECIFIC, 6, REALTEK_96B_IE, &(pattrib->pktlen));
-	}
 
 	/* add WPS IE ie for wps 2.0 */
 	if (pmlmepriv->wps_assoc_resp_ie && pmlmepriv->wps_assoc_resp_ie_len > 0) {
@@ -3301,9 +3287,8 @@ static int _issue_deauth(struct adapter *padapter, unsigned char *da,
 	__le16 le_tmp;
 
 	pmgntframe = alloc_mgtxmitframe(pxmitpriv);
-	if (!pmgntframe) {
+	if (!pmgntframe)
 		goto exit;
-	}
 
 	/* update attribute */
 	pattrib = &pmgntframe->attrib;
@@ -3627,9 +3612,8 @@ static void issue_action_BSSCoexistPacket(struct adapter *padapter)
 	action = ACT_PUBLIC_BSSCOEXIST;
 
 	pmgntframe = alloc_mgtxmitframe(pxmitpriv);
-	if (!pmgntframe) {
+	if (!pmgntframe)
 		return;
-	}
 
 	/* update attribute */
 	pattrib = &pmgntframe->attrib;
@@ -3802,10 +3786,8 @@ unsigned int send_beacon(struct adapter *padapter)
 
 	} while (false == bxmitok && issue < 100 && !padapter->bSurpriseRemoved && !padapter->bDriverStopped);
 
-	if (padapter->bSurpriseRemoved || padapter->bDriverStopped) {
+	if (padapter->bSurpriseRemoved || padapter->bDriverStopped)
 		return _FAIL;
-	}
-
 
 	if (!bxmitok)
 		return _FAIL;
@@ -4388,9 +4370,8 @@ static void process_80211d(struct adapter *padapter, struct wlan_bssid_ex *bssid
 			}
 
 			/*  skip AP 2.4G channel plan */
-			while ((j < chplan_ap.Len) && (chplan_ap.Channel[j] <= 14)) {
+			while ((j < chplan_ap.Len) && (chplan_ap.Channel[j] <= 14))
 				j++;
-			}
 		}
 
 		pmlmeext->update_channel_plan_by_ap_done = 1;
@@ -4402,9 +4383,8 @@ static void process_80211d(struct adapter *padapter, struct wlan_bssid_ex *bssid
 	i = 0;
 	while ((i < MAX_CHANNEL_NUM) && (chplan_new[i].ChannelNum != 0)) {
 		if (chplan_new[i].ChannelNum == channel) {
-			if (chplan_new[i].ScanType == SCAN_PASSIVE) {
+			if (chplan_new[i].ScanType == SCAN_PASSIVE)
 				chplan_new[i].ScanType = SCAN_ACTIVE;
-			}
 			break;
 		}
 		i++;
@@ -4629,9 +4609,8 @@ void report_del_sta_event(struct adapter *padapter, unsigned char *MacAddr, unsi
 	struct cmd_priv *pcmdpriv = &padapter->cmdpriv;
 
 	pcmd_obj = rtw_zmalloc(sizeof(struct cmd_obj));
-	if (!pcmd_obj) {
+	if (!pcmd_obj)
 		return;
-	}
 
 	cmdsz = (sizeof(struct stadel_event) + sizeof(struct C2HEvent_Header));
 	pevtcmd = rtw_zmalloc(cmdsz);
@@ -5124,9 +5103,8 @@ void survey_timer_hdl(struct timer_list *t)
 
 	/* issue rtw_sitesurvey_cmd */
 	if (pmlmeext->sitesurvey_res.state > SCAN_START) {
-		if (pmlmeext->sitesurvey_res.state ==  SCAN_PROCESS) {
+		if (pmlmeext->sitesurvey_res.state ==  SCAN_PROCESS)
 			pmlmeext->sitesurvey_res.channel_idx++;
-		}
 
 		if (pmlmeext->scan_abort) {
 			pmlmeext->sitesurvey_res.channel_idx = pmlmeext->sitesurvey_res.ch_num;
@@ -5135,9 +5113,8 @@ void survey_timer_hdl(struct timer_list *t)
 		}
 
 		ph2c = rtw_zmalloc(sizeof(struct cmd_obj));
-		if (!ph2c) {
+		if (!ph2c)
 			goto exit_survey_timer_hdl;
-		}
 
 		psurveyPara = rtw_zmalloc(sizeof(struct sitesurvey_parm));
 		if (!psurveyPara) {
@@ -5348,9 +5325,8 @@ u8 join_cmd_hdl(struct adapter *padapter, u8 *pbuf)
 
 	/* check already connecting to AP or not */
 	if (pmlmeinfo->state & WIFI_FW_ASSOC_SUCCESS) {
-		if (pmlmeinfo->state & WIFI_FW_STATION_STATE) {
+		if (pmlmeinfo->state & WIFI_FW_STATION_STATE)
 			issue_deauth_ex(padapter, pnetwork->mac_address, WLAN_REASON_DEAUTH_LEAVING, 1, 100);
-		}
 		pmlmeinfo->state = WIFI_FW_NULL_STATE;
 
 		/* clear CAM */
@@ -5485,9 +5461,8 @@ u8 disconnect_hdl(struct adapter *padapter, unsigned char *pbuf)
 	struct wlan_bssid_ex		*pnetwork = (struct wlan_bssid_ex *)(&(pmlmeinfo->network));
 	u8 val8;
 
-	if (is_client_associated_to_ap(padapter)) {
+	if (is_client_associated_to_ap(padapter))
 			issue_deauth_ex(padapter, pnetwork->mac_address, WLAN_REASON_DEAUTH_LEAVING, param->deauth_timeout_ms/100, 100);
-	}
 
 	if (((pmlmeinfo->state&0x03) == WIFI_FW_ADHOC_STATE) || ((pmlmeinfo->state&0x03) == WIFI_FW_AP_STATE)) {
 		/* Stop BCN */
-- 
2.25.1

