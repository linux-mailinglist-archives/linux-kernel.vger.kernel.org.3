Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA14C4EFA47
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 21:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351485AbiDATJD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 15:09:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351469AbiDATI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 15:08:59 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4558C28A019
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 12:07:09 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id t7so2950116qta.10
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 12:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ajcz12srs583Xws3OY/YngwhdPC9ljyQGLcNQQ87rSE=;
        b=kXwc/ND+ShJ1mrSHsIyOqagYcFPXa4hy9K5tYvqL/PVh2o2kMC5SbtaJJu5wMCloXL
         GCNFwDc9lEdj0tV1efWg/8iIH+EBB+qz+qlEAa4gIz2vc8tbMLwu4v08/X98vgjpmtSw
         6vxH/ZSi0OpfWnmvLpppVQOQBiQWUIbY0KmQNBDtMJ6TFiscD6SBPM8+SXQHld+YDAya
         3Dtlkx6RhO22I8ptmOGwcjvIDyh6iKscFa8hwldOgEO4Jkyjdw8VnxJOpgNI+z7uzSJu
         ICt/lE/sUD6WF6/x1cYHcmfakMrZDMCm6CiSZAkg0uDJ8bXJgY8DDaP6o1GuzCMR+7QK
         q2Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ajcz12srs583Xws3OY/YngwhdPC9ljyQGLcNQQ87rSE=;
        b=COpxP4Je8vZVN7x0NQ0QZjHKzumHxmIv/SZljuhYoPPf5h1lXYpn7FO8wrPsPWHHPI
         NIMiLaETJRS7s6jaznU8ePkZdnboH3h1tJR61HcMMIYYNGXoFSLKi/O+5qi1yY2EuTV0
         +w9sUEfilumR7R9GuaeOAq+j2upr3Sl2ySjBRv+PMGpi5nrLBOrP1U/HV/8QLsp0xpN5
         chTr5Esg2Oi7Z/TweyuqXfwggim0dDL27QY9lB9OQOoZEdfY+S+NYSLizyOJYvuRrmBQ
         0dRaUNpAizM9Bgpgh41A092YbOwNkiVggPXkDA0QJSbzp0KcdtP7joJV11C2lC8xBS8Q
         T6DQ==
X-Gm-Message-State: AOAM531Qw2sUk92aJPk3oQf7TPATpkChsR6WGiqVJeUsgd32ZB1rDlZM
        gGSuInguVPtAe54hBzL2yTTPdWkEc1AXX8DS
X-Google-Smtp-Source: ABdhPJy1PHFkOK8rg2s3d9nvIVHs8Tq09j3nPHDr6beP2wZjNnHaEhGdDUkUW0HR8KLRLoij2R2eSg==
X-Received: by 2002:ac8:5a4f:0:b0:2e1:a7be:2d13 with SMTP id o15-20020ac85a4f000000b002e1a7be2d13mr9603016qta.598.1648840028298;
        Fri, 01 Apr 2022 12:07:08 -0700 (PDT)
Received: from euclid ([71.58.109.160])
        by smtp.gmail.com with ESMTPSA id k13-20020a05622a03cd00b002e21621c243sm2508073qtx.39.2022.04.01.12.07.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Apr 2022 12:07:07 -0700 (PDT)
From:   Sevinj Aghayeva <sevinj.aghayeva@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev,
        Sevinj Aghayeva <sevinj.aghayeva@gmail.com>
Subject: [PATCH 1/2] staging: rtl8723bs: place constants on the right side of tests
Date:   Fri,  1 Apr 2022 15:06:56 -0400
Message-Id: <efc56468b8b120cb18d185d0548a0f7cf918a1bc.1648839290.git.sevinj.aghayeva@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1648839290.git.sevinj.aghayeva@gmail.com>
References: <cover.1648839290.git.sevinj.aghayeva@gmail.com>
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

