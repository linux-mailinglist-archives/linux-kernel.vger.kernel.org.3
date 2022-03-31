Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BEA04ED979
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 14:16:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235955AbiCaMRo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 08:17:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235935AbiCaMRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 08:17:39 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1BCE419B9
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 05:15:52 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id t7so21179155qta.10
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 05:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=XF/s3UO58P3HsSZw+GTULwVtlQyjwaiZoqdQ/vxoa0Q=;
        b=LmqzuotlFBpEVS8oxw8kc6t8ivWB8dCcGXySEGVPZFyBqFBNvxQByoZviEjyOmfiSw
         8esc0Naf/cZa8vAWfj7m/63TOcANOhWkYTjt5EI+Zth4Dz/pimjaODvycr/wp6xwgYMF
         qP0tDJKWd7ygKU2hdG9uLerHsSEUQz1qwx0s1yT6Q12hF8pSJ5aS+fGgdfXW3cJ5OnWe
         nT2Fulthff08XqUZQRXMFOL1YgS4DEQBiuK8NMcxUtG6ajCW7aBU0a5Xv+RNCqdeexJN
         zfRuXNcKvUOxwd9BA1e/kNl08g56Qnaez9Kf4BBU12p+p2W24smkSMGtiwgK9eLQ7rur
         0UGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=XF/s3UO58P3HsSZw+GTULwVtlQyjwaiZoqdQ/vxoa0Q=;
        b=G79DxkwwieQEi4vTbCzGFWbA9tqJW6InKG9NQSlE4/oZt5/euQf3UWOWshVTuPMRjB
         Li8Z8uW8WvJ6LZznfnskjkvLigAKCvm7EUu864C/hIrLpWv6AgNfG4gKsxKOHAUXpJa3
         wCtC+V/iSogVy5236QQ6T9+VYHeAr1l11hbPoGtslWwa6Qk4I0i+ZHpbUtfR3yTieFj+
         8LoRMf+Fi9hZJ41VFIa3iFsndT7NgLpk5tRIRjCi5ShWyQBrPTgFy3NYTecGvpXf82Sf
         07FRPF5QW/Jyy9WVXWtiZbuVVou2PKVKPsWmT/69i+7shJL7XSde9+0xJx/fqSIFW5rQ
         tYkQ==
X-Gm-Message-State: AOAM532Mx2gxHXJzO2tqKnUpTdiuG/urJ2bB1nYxnV/Eth9elauShODy
        8QMg5ebF0md0+BvjQ9Lojoo=
X-Google-Smtp-Source: ABdhPJx4wyrbXP3SPA0GaXnuXNXsuT9Bg0w2bVzN1hfotU+bgrDJvUZd9K3uIlYNTD1/BaQsHabTAQ==
X-Received: by 2002:a05:622a:89:b0:2e1:b8c7:9975 with SMTP id o9-20020a05622a008900b002e1b8c79975mr3907324qtw.342.1648728951887;
        Thu, 31 Mar 2022 05:15:51 -0700 (PDT)
Received: from euclid ([71.58.109.160])
        by smtp.gmail.com with ESMTPSA id g5-20020ac87f45000000b002e125ef0ba3sm19503701qtk.82.2022.03.31.05.15.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 05:15:51 -0700 (PDT)
Date:   Thu, 31 Mar 2022 08:15:50 -0400
From:   Sevinj Aghayeva <sevinj.aghayeva@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev
Subject: [PATCH] staging: rtl8723bs: place constants on the right side of
 tests
Message-ID: <20220331121550.GA429809@euclid>
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
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 32 +++++++++----------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index 49a3f45cb771..9fdbcd83b46e 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -311,11 +311,11 @@ static void init_channel_list(struct adapter *padapter, struct rt_channel_info *
 			if (!has_channel(channel_set, chanset_size, ch))
 				continue;
 
-			if ((0 == padapter->registrypriv.ht_enable) && (8 == o->inc))
+			if ((padapter->registrypriv.ht_enable == 0) && (8 == o->inc))
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

