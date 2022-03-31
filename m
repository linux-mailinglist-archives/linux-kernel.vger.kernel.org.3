Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBEAC4ED99D
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 14:26:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236105AbiCaM2N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 08:28:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236069AbiCaM2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 08:28:07 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77BBC21044B
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 05:26:20 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id kd21so16653878qvb.6
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 05:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=inD3SnFltpIfXrHtLPhpTWjxkAMH823Ag7N/71vk5DY=;
        b=ZQ5xftc/E2Sid0uo09kzQyKlBB6ON4adiW19kxUoGVe0YV3Bu/j3m1+iG4OxgTeqJl
         Co6n8MGRSKbVGgkPZygeY6XPPXp5Msqi+svw9IIIg4ZQdvTBTOTTbvNWh840Y/lMCxYR
         nEn+Hf59X9kemMlkf2yQG1fXvSCyMC9YNzhDZgoSwUb8PSzCYavQqqFicwaKIOzroy6H
         LzxIc3md0auTgehZp1yTp2QkEw0Q0a3uTyODNF503ffm6Y86egF2k+1LdA0XkAKmb7M7
         QjA6iQA9PpcCDV73ZiTdEnMGYkFttiQyaqeYI84HrN906y5zxUKaD3dNpddY//Onp6lk
         wRVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=inD3SnFltpIfXrHtLPhpTWjxkAMH823Ag7N/71vk5DY=;
        b=Tx0+JfVcBH2gUjODDV3X0tsuLcvemYnD/JrLf73sL1Vbxt3dAxP3DHp+gJUu/GWM0t
         /hslwfJCOxFoPcGI6G55Vn1z9WlwLgJoZ/oflopm4VC/VzNOkd7OimnZREdqx6CINE/p
         X6G4cGAjAJGzRB64Mxpf7VyRfm+Li1lA+Z7bf+iXD6Fe1t8GRgsU++2v+3ZndUiTCUtX
         Ol+Sjox29btyP1W2yeHyHaPPpziRm4C7IXLZp5YTGTBJk6NuIpqSp0iJ/L9IYxqYdw/D
         yue36ysh4D6Lj16lAb+ab1n7UYb9AdejEYT9dnkBGCBV07v6g2Cs8QPnyMW4cwC6CBme
         7vUg==
X-Gm-Message-State: AOAM533UFeYzr3LiFMOI1GWpr28OIw1sIKHJnOqv1kYL7nX3mOqAp9ao
        ArmR3IMczL8HhrHEGjmKtY7oo0M9/eCWig==
X-Google-Smtp-Source: ABdhPJyGoRv10oxt0Yxp7IIsoIxrcILPeJWgBV+CPY92jfoubgGlq/8jxJ12WTuQaPkbbS2k7TdwIw==
X-Received: by 2002:a0c:fbc8:0:b0:440:faa1:880d with SMTP id n8-20020a0cfbc8000000b00440faa1880dmr4008981qvp.66.1648729579481;
        Thu, 31 Mar 2022 05:26:19 -0700 (PDT)
Received: from euclid ([71.58.109.160])
        by smtp.gmail.com with ESMTPSA id p17-20020a37a611000000b0067b2b2c41fasm12672654qke.81.2022.03.31.05.26.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 05:26:18 -0700 (PDT)
Date:   Thu, 31 Mar 2022 08:26:18 -0400
From:   Sevinj Aghayeva <sevinj.aghayeva@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev
Subject: [PATCH v2] staging: rtl8723bs: place constants on the right side of
 tests
Message-ID: <20220331122618.GA434796@euclid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

WARNING: Comparisons should place the constant on the right side of the test

Signed-off-by: Sevinj Aghayeva <sevinj.aghayeva@gmail.com>
---

v1 -> v2: Missed one case of constant being placed on the left. Now
checkpath reports no such warnings for this file.

 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 32 +++++++++----------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index 49a3f45cb771..359a67462611 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -311,11 +311,11 @@ static void init_channel_list(struct adapter *padapter, struct rt_channel_info *
 			if (!has_channel(channel_set, chanset_size, ch))
 				continue;
 
-			if ((0 == padapter->registrypriv.ht_enable) && (8 == o->inc))
+			if ((padapter->registrypriv.ht_enable == 0) && (o->inc == 8))
 				continue;
 
 			if ((0 < (padapter->registrypriv.bw_mode & 0xf0)) &&
-				((BW40MINUS == o->bw) || (BW40PLUS == o->bw)))
+				((o->bw == BW40MINUS) || (o->bw == BW40PLUS)))
 				continue;
 
 			if (!reg) {
@@ -345,7 +345,7 @@ static u8 init_channel_set(struct adapter *padapter, u8 ChannelPlan, struct rt_c
 
 	if (is_supported_24g(padapter->registrypriv.wireless_mode)) {
 		b2_4GBand = true;
-		if (RT_CHANNEL_DOMAIN_REALTEK_DEFINE == ChannelPlan)
+		if (ChannelPlan == RT_CHANNEL_DOMAIN_REALTEK_DEFINE)
 			Index2G = RTW_CHANNEL_PLAN_MAP_REALTEK_DEFINE.Index2G;
 		else
 			Index2G = RTW_ChannelPlanMap[ChannelPlan].Index2G;
@@ -355,14 +355,14 @@ static u8 init_channel_set(struct adapter *padapter, u8 ChannelPlan, struct rt_c
 		for (index = 0; index < RTW_ChannelPlan2G[Index2G].Len; index++) {
 			channel_set[chanset_size].ChannelNum = RTW_ChannelPlan2G[Index2G].Channel[index];
 
-			if ((RT_CHANNEL_DOMAIN_GLOBAL_DOAMIN == ChannelPlan) ||/* Channel 1~11 is active, and 12~14 is passive */
-				(RT_CHANNEL_DOMAIN_GLOBAL_NULL == ChannelPlan)) {
+			if ((ChannelPlan == RT_CHANNEL_DOMAIN_GLOBAL_DOAMIN) ||/* Channel 1~11 is active, and 12~14 is passive */
+				(ChannelPlan == RT_CHANNEL_DOMAIN_GLOBAL_NULL)) {
 				if (channel_set[chanset_size].ChannelNum >= 1 && channel_set[chanset_size].ChannelNum <= 11)
 					channel_set[chanset_size].ScanType = SCAN_ACTIVE;
 				else if ((channel_set[chanset_size].ChannelNum  >= 12 && channel_set[chanset_size].ChannelNum  <= 14))
 					channel_set[chanset_size].ScanType  = SCAN_PASSIVE;
-			} else if (RT_CHANNEL_DOMAIN_WORLD_WIDE_13 == ChannelPlan ||
-				RT_CHANNEL_DOMAIN_2G_WORLD == Index2G) { /*  channel 12~13, passive scan */
+			} else if (ChannelPlan == RT_CHANNEL_DOMAIN_WORLD_WIDE_13 ||
+				 Index2G == RT_CHANNEL_DOMAIN_2G_WORLD) { /*  channel 12~13, passive scan */
 				if (channel_set[chanset_size].ChannelNum <= 11)
 					channel_set[chanset_size].ScanType = SCAN_ACTIVE;
 				else
@@ -1331,7 +1331,7 @@ unsigned int OnAssocReq(struct adapter *padapter, union recv_frame *precv_frame)
 	spin_unlock_bh(&pstapriv->asoc_list_lock);
 
 	/*  now the station is qualified to join our BSS... */
-	if (pstat && (pstat->state & WIFI_FW_ASSOC_SUCCESS) && (WLAN_STATUS_SUCCESS == status)) {
+	if (pstat && (pstat->state & WIFI_FW_ASSOC_SUCCESS) && (status == WLAN_STATUS_SUCCESS)) {
 		/* 1 bss_cap_update & sta_info_update */
 		bss_cap_update_on_sta_join(padapter, pstat);
 		sta_info_update(padapter, pstat);
@@ -1520,7 +1520,7 @@ unsigned int OnDeAuth(struct adapter *padapter, union recv_frame *precv_frame)
 			(pmlmeinfo->state & WIFI_FW_ASSOC_STATE)) {
 			if (reason == WLAN_REASON_CLASS2_FRAME_FROM_NONAUTH_STA) {
 				ignore_received_deauth = 1;
-			} else if (WLAN_REASON_PREV_AUTH_NOT_VALID == reason) {
+			} else if (reason == WLAN_REASON_PREV_AUTH_NOT_VALID) {
 				/*  TODO: 802.11r */
 				ignore_received_deauth = 1;
 			}
@@ -1531,7 +1531,7 @@ unsigned int OnDeAuth(struct adapter *padapter, union recv_frame *precv_frame)
 			   reason, GetAddr3Ptr(pframe),
 			   ignore_received_deauth);
 
-		if (0 == ignore_received_deauth) {
+		if (ignore_received_deauth == 0) {
 			receive_disconnect(padapter, GetAddr3Ptr(pframe), reason);
 		}
 	}
@@ -3552,13 +3552,13 @@ void issue_action_BA(struct adapter *padapter, unsigned char *raddr, unsigned ch
 				rtw_hal_get_def_var(padapter,
 						    HW_VAR_MAX_RX_AMPDU_FACTOR, &max_rx_ampdu_factor);
 
-			if (IEEE80211_HT_MAX_AMPDU_64K == max_rx_ampdu_factor)
+			if (max_rx_ampdu_factor == IEEE80211_HT_MAX_AMPDU_64K)
 				BA_para_set = ((le16_to_cpu(pmlmeinfo->ADDBA_req.BA_para_set) & 0x3f) | 0x1000); /* 64 buffer size */
-			else if (IEEE80211_HT_MAX_AMPDU_32K == max_rx_ampdu_factor)
+			else if (max_rx_ampdu_factor == IEEE80211_HT_MAX_AMPDU_32K)
 				BA_para_set = ((le16_to_cpu(pmlmeinfo->ADDBA_req.BA_para_set) & 0x3f) | 0x0800); /* 32 buffer size */
-			else if (IEEE80211_HT_MAX_AMPDU_16K == max_rx_ampdu_factor)
+			else if (max_rx_ampdu_factor == IEEE80211_HT_MAX_AMPDU_16K)
 				BA_para_set = ((le16_to_cpu(pmlmeinfo->ADDBA_req.BA_para_set) & 0x3f) | 0x0400); /* 16 buffer size */
-			else if (IEEE80211_HT_MAX_AMPDU_8K == max_rx_ampdu_factor)
+			else if (max_rx_ampdu_factor == IEEE80211_HT_MAX_AMPDU_8K)
 				BA_para_set = ((le16_to_cpu(pmlmeinfo->ADDBA_req.BA_para_set) & 0x3f) | 0x0200); /* 8 buffer size */
 			else
 				BA_para_set = ((le16_to_cpu(pmlmeinfo->ADDBA_req.BA_para_set) & 0x3f) | 0x1000); /* 64 buffer size */
@@ -5086,7 +5086,7 @@ void linked_status_chk(struct adapter *padapter)
 			if (pmlmeinfo->FW_sta_info[i].status == 1) {
 				psta = pmlmeinfo->FW_sta_info[i].psta;
 
-				if (NULL == psta)
+				if (psta == NULL)
 					continue;
 
 				if (pmlmeinfo->FW_sta_info[i].rx_pkt == sta_rx_pkts(psta)) {
@@ -6073,7 +6073,7 @@ u8 run_in_thread_hdl(struct adapter *padapter, u8 *pbuf)
 	struct RunInThread_param *p;
 
 
-	if (NULL == pbuf)
+	if (pbuf == NULL)
 		return H2C_PARAMETERS_ERROR;
 	p = (struct RunInThread_param *)pbuf;
 
-- 
2.25.1

