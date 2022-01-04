Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D84124845D5
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 17:11:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235186AbiADQL4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 11:11:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232163AbiADQLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 11:11:55 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04045C061761
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 08:11:55 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id y22so150496404edq.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jan 2022 08:11:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=asDbpD726++9h2NWpRwMXn46LyOsIqdfH+8xUdoIcPo=;
        b=V+0xjBoPkkw4NnmHG92NNshrD52K5YHzPWXXFYcSxf0ldk/QHhh726xS2k4i6Xuh8z
         mjqdwiGpRz/1dOpWvbR3RBavLhxUtP3sLthKJRj8nchNqRcQZGKvtXKbvLFZTyk7Wlk/
         u1AQrr4EQcuq3gyFNMqQcZebV8F41n1vaCoTdxhXRAoaWYXgXAI/u3v2wZkxRW60zCrs
         FydKs85n9JmnCym7FzwRAcOyWNcgnU0Si9VEfey5Qdi8UU8vyeVsM5Z15tTKVXAUXJYR
         kVj3ldii3CFK/TWVFnsWuX7KRerzaJi/k96DT1MCgJ/ur+T9x88QYcQCYjlxKBSSGbQt
         6CmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=asDbpD726++9h2NWpRwMXn46LyOsIqdfH+8xUdoIcPo=;
        b=44jFbt7AmjVVYAWXAZc4tauC+OzhCYgrgYuNW+Ki9dJfToTVHjDbtHzdenaAIAwqUC
         mN4UT6GB0onPNa/dIAzFqWyTFYV+j0ZHpk9qI5/rzyLMzCP89XdXJFQvmq2t7PDop/hL
         jO+gulrHD3DLOpWmKv1ZHKiWNbZ+Fd/YzmfwsYliq6YUkAEPtX+bvZCYp//cAJRqwjZb
         SUJR/vXEkoEcGz8RHPam2S5LEpgaJEpN5KQVMCR2gPUWoU7pZ0lpUqMDzhVP4BlBZ3Xn
         9v6vQN34aTeceH7W3y0LQubFcM6P7013x5yeZ6X6KVhNPRK9HAECaucs7WWY4J76NF+3
         amHw==
X-Gm-Message-State: AOAM530tTRXrkzpSp82hTvqdM+40pac0k33lX6ICXKtvYviRL8DV6baX
        itivTLLGT0CUfcNDeYgvq+E=
X-Google-Smtp-Source: ABdhPJzWHaiRZNBFs8T5XVsoFydsYK5BIXm1nxxNWhXRwCIG8zQscpAFT1gIHV/DDnRKbknGyLW+lw==
X-Received: by 2002:a17:907:7816:: with SMTP id la22mr37630289ejc.180.1641312713608;
        Tue, 04 Jan 2022 08:11:53 -0800 (PST)
Received: from t470p.fritz.box (host-79-36-120-235.retail.telecomitalia.it. [79.36.120.235])
        by smtp.gmail.com with ESMTPSA id k12sm3550102ejk.188.2022.01.04.08.11.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 08:11:53 -0800 (PST)
From:   Alberto Merciai <alb3rt0.m3rciai@gmail.com>
Cc:     alb3rt0.m3rciai@gmail.com, linuxfancy@googlegroups.com,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        Martin Kaiser <martin@kaiser.cx>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: r8188eu: rename camelcase variable uintPeerChannel
Date:   Tue,  4 Jan 2022 17:09:39 +0100
Message-Id: <20220104160945.460113-1-alb3rt0.m3rciai@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename camelcase hungarian notated variable uintPeerChannel into
peer_channel.

Signed-off-by: Alberto Merciai <alb3rt0.m3rciai@gmail.com>
---
 drivers/staging/r8188eu/os_dep/ioctl_linux.c | 36 ++++++++++----------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
index 67a8af79508f..41b457838a5b 100644
--- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
@@ -2998,7 +2998,7 @@ static int rtw_p2p_connect(struct net_device *dev,
 	struct list_head *plist, *phead;
 	struct __queue *queue	= &pmlmepriv->scanned_queue;
 	struct	wlan_network	*pnetwork = NULL;
-	uint uintPeerChannel = 0;
+	u32 peer_channel = 0;
 
 	/*	Commented by Albert 20110304 */
 	/*	The input data contains two informations. */
@@ -3028,7 +3028,7 @@ static int rtw_p2p_connect(struct net_device *dev,
 	while (phead != plist) {
 		pnetwork = container_of(plist, struct wlan_network, list);
 		if (!memcmp(pnetwork->network.MacAddress, peerMAC, ETH_ALEN)) {
-			uintPeerChannel = pnetwork->network.Configuration.DSConfig;
+			peer_channel = pnetwork->network.Configuration.DSConfig;
 			break;
 		}
 
@@ -3037,11 +3037,11 @@ static int rtw_p2p_connect(struct net_device *dev,
 
 	spin_unlock_bh(&pmlmepriv->scanned_queue.lock);
 
-	if (uintPeerChannel) {
+	if (peer_channel) {
 		memset(&pwdinfo->nego_req_info, 0x00, sizeof(struct tx_nego_req_info));
 		memset(&pwdinfo->groupid_info, 0x00, sizeof(struct group_id_info));
 
-		pwdinfo->nego_req_info.peer_channel_num[0] = uintPeerChannel;
+		pwdinfo->nego_req_info.peer_channel_num[0] = peer_channel;
 		memcpy(pwdinfo->nego_req_info.peerDevAddr, pnetwork->network.MacAddress, ETH_ALEN);
 		pwdinfo->nego_req_info.benable = true;
 
@@ -3076,7 +3076,7 @@ static int rtw_p2p_invite_req(struct net_device *dev,
 	struct list_head *plist, *phead;
 	struct __queue *queue	= &pmlmepriv->scanned_queue;
 	struct	wlan_network	*pnetwork = NULL;
-	uint uintPeerChannel = 0;
+	uint peer_channel = 0;
 	u8 attr_content[50] = {0x00};
 	u8 *p2pie;
 	uint p2pielen = 0, attr_contentlen = 0;
@@ -3132,13 +3132,13 @@ static int rtw_p2p_invite_req(struct net_device *dev,
 			if (rtw_get_p2p_attr_content(p2pie, p2pielen, P2P_ATTR_DEVICE_ID, attr_content, &attr_contentlen)) {
 				/*	Handle the P2P Device ID attribute of Beacon first */
 				if (!memcmp(attr_content, pinvite_req_info->peer_macaddr, ETH_ALEN)) {
-					uintPeerChannel = pnetwork->network.Configuration.DSConfig;
+					peer_channel = pnetwork->network.Configuration.DSConfig;
 					break;
 				}
 			} else if (rtw_get_p2p_attr_content(p2pie, p2pielen, P2P_ATTR_DEVICE_INFO, attr_content, &attr_contentlen)) {
 				/*	Handle the P2P Device Info attribute of probe response */
 				if (!memcmp(attr_content, pinvite_req_info->peer_macaddr, ETH_ALEN)) {
-					uintPeerChannel = pnetwork->network.Configuration.DSConfig;
+					peer_channel = pnetwork->network.Configuration.DSConfig;
 					break;
 				}
 			}
@@ -3148,7 +3148,7 @@ static int rtw_p2p_invite_req(struct net_device *dev,
 
 	spin_unlock_bh(&pmlmepriv->scanned_queue.lock);
 
-	if (uintPeerChannel) {
+	if (peer_channel) {
 		/*	Store the GO's bssid */
 		for (jj = 0, kk = 18; jj < ETH_ALEN; jj++, kk += 3)
 			pinvite_req_info->go_bssid[jj] = key_2char2num(extra[kk], extra[kk + 1]);
@@ -3157,12 +3157,12 @@ static int rtw_p2p_invite_req(struct net_device *dev,
 		pinvite_req_info->ssidlen = wrqu->data.length - 36;
 		memcpy(pinvite_req_info->go_ssid, &extra[36], (u32)pinvite_req_info->ssidlen);
 		pinvite_req_info->benable = true;
-		pinvite_req_info->peer_ch = uintPeerChannel;
+		pinvite_req_info->peer_ch = peer_channel;
 
 		rtw_p2p_set_pre_state(pwdinfo, rtw_p2p_state(pwdinfo));
 		rtw_p2p_set_state(pwdinfo, P2P_STATE_TX_INVITE_REQ);
 
-		set_channel_bwmode(padapter, uintPeerChannel, HAL_PRIME_CHNL_OFFSET_DONT_CARE, HT_CHANNEL_WIDTH_20);
+		set_channel_bwmode(padapter, peer_channel, HAL_PRIME_CHNL_OFFSET_DONT_CARE, HT_CHANNEL_WIDTH_20);
 
 		_set_timer(&pwdinfo->pre_tx_scan_timer, P2P_TX_PRESCAN_TIMEOUT);
 
@@ -3215,7 +3215,7 @@ static int rtw_p2p_prov_disc(struct net_device *dev,
 	struct list_head *plist, *phead;
 	struct __queue *queue	= &pmlmepriv->scanned_queue;
 	struct	wlan_network	*pnetwork = NULL;
-	uint uintPeerChannel = 0;
+	uint peer_channel = 0;
 	u8 attr_content[100] = {0x00};
 	u8 *p2pie;
 	uint p2pielen = 0, attr_contentlen = 0;
@@ -3265,7 +3265,7 @@ static int rtw_p2p_prov_disc(struct net_device *dev,
 	plist = phead->next;
 
 	while (phead != plist) {
-		if (uintPeerChannel != 0)
+		if (peer_channel != 0)
 			break;
 
 		pnetwork = container_of(plist, struct wlan_network, list);
@@ -3283,13 +3283,13 @@ static int rtw_p2p_prov_disc(struct net_device *dev,
 				if (rtw_get_p2p_attr_content(p2pie, p2pielen, P2P_ATTR_DEVICE_ID, attr_content, &attr_contentlen)) {
 					/*	Handle the P2P Device ID attribute of Beacon first */
 					if (!memcmp(attr_content, peerMAC, ETH_ALEN)) {
-						uintPeerChannel = pnetwork->network.Configuration.DSConfig;
+						peer_channel = pnetwork->network.Configuration.DSConfig;
 						break;
 					}
 				} else if (rtw_get_p2p_attr_content(p2pie, p2pielen, P2P_ATTR_DEVICE_INFO, attr_content, &attr_contentlen)) {
 					/*	Handle the P2P Device Info attribute of probe response */
 					if (!memcmp(attr_content, peerMAC, ETH_ALEN)) {
-						uintPeerChannel = pnetwork->network.Configuration.DSConfig;
+						peer_channel = pnetwork->network.Configuration.DSConfig;
 						break;
 					}
 				}
@@ -3304,11 +3304,11 @@ static int rtw_p2p_prov_disc(struct net_device *dev,
 
 	spin_unlock_bh(&pmlmepriv->scanned_queue.lock);
 
-	if (uintPeerChannel) {
-		DBG_88E("[%s] peer channel: %d!\n", __func__, uintPeerChannel);
+	if (peer_channel) {
+		DBG_88E("[%s] peer channel: %d!\n", __func__, peer_channel);
 		memcpy(pwdinfo->tx_prov_disc_info.peerIFAddr, pnetwork->network.MacAddress, ETH_ALEN);
 		memcpy(pwdinfo->tx_prov_disc_info.peerDevAddr, peerMAC, ETH_ALEN);
-		pwdinfo->tx_prov_disc_info.peer_channel_num[0] = (u16)uintPeerChannel;
+		pwdinfo->tx_prov_disc_info.peer_channel_num[0] = (u16)peer_channel;
 		pwdinfo->tx_prov_disc_info.benable = true;
 		rtw_p2p_set_pre_state(pwdinfo, rtw_p2p_state(pwdinfo));
 		rtw_p2p_set_state(pwdinfo, P2P_STATE_TX_PROVISION_DIS_REQ);
@@ -3320,7 +3320,7 @@ static int rtw_p2p_prov_disc(struct net_device *dev,
 			pwdinfo->tx_prov_disc_info.ssid.SsidLength = P2P_WILDCARD_SSID_LEN;
 		}
 
-		set_channel_bwmode(padapter, uintPeerChannel, HAL_PRIME_CHNL_OFFSET_DONT_CARE, HT_CHANNEL_WIDTH_20);
+		set_channel_bwmode(padapter, peer_channel, HAL_PRIME_CHNL_OFFSET_DONT_CARE, HT_CHANNEL_WIDTH_20);
 
 		_set_timer(&pwdinfo->pre_tx_scan_timer, P2P_TX_PRESCAN_TIMEOUT);
 
-- 
2.25.1

