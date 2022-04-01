Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E1024EFA63
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 21:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351623AbiDATar (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 15:30:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351600AbiDATan (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 15:30:43 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82C4535AB4
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 12:28:51 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id c4so3034871qtx.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 12:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ajcz12srs583Xws3OY/YngwhdPC9ljyQGLcNQQ87rSE=;
        b=IDFEZUcCRfY0bowEPr2fMidGRsrHYYi2uoe8U5CrCpZ1Te7QDRm/h9exKMoYyW9lmq
         noMq8dttOrrVusoDdrw6g4Zkq1n595rqw1ri9c6aZ1InWAaqFsKatu8Ofy5TMQXwv9zs
         E9RMTRb+82dn4IJEjQvn197YyL/IYxupJWFgjO+D/C5qfzx1ODs0YWMDs+p+CFDmayDx
         YbVxW4+EOu42OLyIbB9ka4HGPG3DXOYgDzVOnZss6Ouu0Fj0IQwL2t57ys3KseVaYR3I
         zjnlS82n4mGfnFGQEaqWbUZ4dZBamvPE7G0KATJQPBeeP1hlY96Le36XDdxa8REqzH+7
         4QHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ajcz12srs583Xws3OY/YngwhdPC9ljyQGLcNQQ87rSE=;
        b=bPL6NWRJmCC3juWS5iXYKziCO8unK/eOsrEEaCj9wL8D4uNZ2uGoe0I0vTD+OTmgy8
         CuOSZi1hmycYWmmyfVte7zh+rsJfxznzhLsWNuDD7SSqUhCQA45lLtBGhey3OhgwBxus
         LngwUVs9bsKAN5SRPzX9blLKmSCaDRROWCY5zIVklRGbtHr2jO4cz5PGQC0dze48hcI7
         rNfJMpz+rczExD5KHUMOWrLHy0gnvOtIHOI6ybBQcJ/njzwP8ciU4xCBhbWl2J2SYsL1
         VmYhGTRoJdsqjXnzNJgyk5uJ/aYMyoIkuDFO7Y/qUS1aE5QJb24sQfa3C13jvIQUkPfn
         luAg==
X-Gm-Message-State: AOAM532SGEu8wRp1mF7ZzTXe/bdtJk54LAfpPMDkpO9a7bs27UE5rCj+
        p4KOnBHl0b8rthZ3p7cbiE8=
X-Google-Smtp-Source: ABdhPJx2g+bDHvoKOHwb4J1FnJPGBLWS7+CjSXTxyNpsxeqveQwAgrAAZLAM40C3BkKpQMIksF9h6w==
X-Received: by 2002:ac8:5f87:0:b0:2e1:c6be:3dd4 with SMTP id j7-20020ac85f87000000b002e1c6be3dd4mr9658981qta.574.1648841330611;
        Fri, 01 Apr 2022 12:28:50 -0700 (PDT)
Received: from euclid ([71.58.109.160])
        by smtp.gmail.com with ESMTPSA id j1-20020a05620a410100b0067ec5ecac66sm2096129qko.19.2022.04.01.12.28.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Apr 2022 12:28:50 -0700 (PDT)
From:   Sevinj Aghayeva <sevinj.aghayeva@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev,
        Sevinj Aghayeva <sevinj.aghayeva@gmail.com>
Subject: [PATCH v3 2/3] staging: rtl8723bs: place constants on the right side of tests
Date:   Fri,  1 Apr 2022 15:28:37 -0400
Message-Id: <efc56468b8b120cb18d185d0548a0f7cf918a1bc.1648840991.git.sevinj.aghayeva@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1648840991.git.sevinj.aghayeva@gmail.com>
References: <cover.1648840991.git.sevinj.aghayeva@gmail.com>
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

WARNING: Comparisons should place the constant on the right side of the test

Signed-off-by: Sevinj Aghayeva <sevinj.aghayeva@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 34 +++++++++----------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index 9f328e9a81ff..81e4b1bf68f6 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -308,11 +308,11 @@ static void init_channel_list(struct adapter *padapter, struct rt_channel_info *
 			if (!has_channel(channel_set, chanset_size, ch))
 				continue;
 
-			if ((0 == padapter->registrypriv.ht_enable) && (8 == o->inc))
+			if ((padapter->registrypriv.ht_enable == 0) && (o->inc == 8))
 				continue;
 
-			if ((0 < (padapter->registrypriv.bw_mode & 0xf0)) &&
-				((BW40MINUS == o->bw) || (BW40PLUS == o->bw)))
+			if (((padapter->registrypriv.bw_mode & 0xf0) > 0) &&
+				((o->bw == BW40MINUS) || (o->bw == BW40PLUS)))
 				continue;
 
 			if (!reg) {
@@ -342,7 +342,7 @@ static u8 init_channel_set(struct adapter *padapter, u8 ChannelPlan, struct rt_c
 
 	if (is_supported_24g(padapter->registrypriv.wireless_mode)) {
 		b2_4GBand = true;
-		if (RT_CHANNEL_DOMAIN_REALTEK_DEFINE == ChannelPlan)
+		if (ChannelPlan == RT_CHANNEL_DOMAIN_REALTEK_DEFINE)
 			Index2G = RTW_CHANNEL_PLAN_MAP_REALTEK_DEFINE.Index2G;
 		else
 			Index2G = RTW_ChannelPlanMap[ChannelPlan].Index2G;
@@ -352,14 +352,14 @@ static u8 init_channel_set(struct adapter *padapter, u8 ChannelPlan, struct rt_c
 		for (index = 0; index < RTW_ChannelPlan2G[Index2G].Len; index++) {
 			channel_set[chanset_size].ChannelNum = RTW_ChannelPlan2G[Index2G].Channel[index];
 
-			if ((RT_CHANNEL_DOMAIN_GLOBAL_DOAMIN == ChannelPlan) ||/* Channel 1~11 is active, and 12~14 is passive */
-				(RT_CHANNEL_DOMAIN_GLOBAL_NULL == ChannelPlan)) {
+			if ((ChannelPlan == RT_CHANNEL_DOMAIN_GLOBAL_DOAMIN) || /* Channel 1~11 is active, and 12~14 is passive */
+				(ChannelPlan == RT_CHANNEL_DOMAIN_GLOBAL_NULL)) {
 				if (channel_set[chanset_size].ChannelNum >= 1 && channel_set[chanset_size].ChannelNum <= 11)
 					channel_set[chanset_size].ScanType = SCAN_ACTIVE;
 				else if ((channel_set[chanset_size].ChannelNum  >= 12 && channel_set[chanset_size].ChannelNum  <= 14))
 					channel_set[chanset_size].ScanType  = SCAN_PASSIVE;
-			} else if (RT_CHANNEL_DOMAIN_WORLD_WIDE_13 == ChannelPlan ||
-				RT_CHANNEL_DOMAIN_2G_WORLD == Index2G) { /*  channel 12~13, passive scan */
+			} else if (ChannelPlan == RT_CHANNEL_DOMAIN_WORLD_WIDE_13 ||
+				Index2G == RT_CHANNEL_DOMAIN_2G_WORLD) { /* channel 12~13, passive scan */
 				if (channel_set[chanset_size].ChannelNum <= 11)
 					channel_set[chanset_size].ScanType = SCAN_ACTIVE;
 				else
@@ -1326,7 +1326,7 @@ unsigned int OnAssocReq(struct adapter *padapter, union recv_frame *precv_frame)
 	spin_unlock_bh(&pstapriv->asoc_list_lock);
 
 	/*  now the station is qualified to join our BSS... */
-	if (pstat && (pstat->state & WIFI_FW_ASSOC_SUCCESS) && (WLAN_STATUS_SUCCESS == status)) {
+	if (pstat && (pstat->state & WIFI_FW_ASSOC_SUCCESS) && (status == WLAN_STATUS_SUCCESS)) {
 		/* 1 bss_cap_update & sta_info_update */
 		bss_cap_update_on_sta_join(padapter, pstat);
 		sta_info_update(padapter, pstat);
@@ -1514,7 +1514,7 @@ unsigned int OnDeAuth(struct adapter *padapter, union recv_frame *precv_frame)
 			(pmlmeinfo->state & WIFI_FW_ASSOC_STATE)) {
 			if (reason == WLAN_REASON_CLASS2_FRAME_FROM_NONAUTH_STA) {
 				ignore_received_deauth = 1;
-			} else if (WLAN_REASON_PREV_AUTH_NOT_VALID == reason) {
+			} else if (reason == WLAN_REASON_PREV_AUTH_NOT_VALID) {
 				/*  TODO: 802.11r */
 				ignore_received_deauth = 1;
 			}
@@ -1525,7 +1525,7 @@ unsigned int OnDeAuth(struct adapter *padapter, union recv_frame *precv_frame)
 			   reason, GetAddr3Ptr(pframe),
 			   ignore_received_deauth);
 
-		if (0 == ignore_received_deauth)
+		if (ignore_received_deauth == 0)
 			receive_disconnect(padapter, GetAddr3Ptr(pframe), reason);
 	}
 	pmlmepriv->LinkDetectInfo.bBusyTraffic = false;
@@ -3536,13 +3536,13 @@ void issue_action_BA(struct adapter *padapter, unsigned char *raddr, unsigned ch
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
@@ -5065,7 +5065,7 @@ void linked_status_chk(struct adapter *padapter)
 			if (pmlmeinfo->FW_sta_info[i].status == 1) {
 				psta = pmlmeinfo->FW_sta_info[i].psta;
 
-				if (NULL == psta)
+				if (psta == NULL)
 					continue;
 
 				if (pmlmeinfo->FW_sta_info[i].rx_pkt == sta_rx_pkts(psta)) {
@@ -6049,7 +6049,7 @@ u8 run_in_thread_hdl(struct adapter *padapter, u8 *pbuf)
 	struct RunInThread_param *p;
 
 
-	if (NULL == pbuf)
+	if (pbuf == NULL)
 		return H2C_PARAMETERS_ERROR;
 	p = (struct RunInThread_param *)pbuf;
 
-- 
2.25.1

