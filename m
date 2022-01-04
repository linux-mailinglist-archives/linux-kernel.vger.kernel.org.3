Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D94FF48463D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 17:52:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235542AbiADQwo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 11:52:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234046AbiADQwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 11:52:43 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C0C3C061761
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 08:52:43 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id bm14so150886645edb.5
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jan 2022 08:52:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u6V6IrU9rSb+SxqUTIO/OsWV01QIdgCFVuaG2NS96qM=;
        b=RutrI7e4da2CiNLlCqwJ6/sLlNi/nmMfe7o/GUDfYEx2HCIJVAvgC8AH1jFInFJmsn
         /mY+INuPnh07PJ5rxKvs4ba53kDJCExGvpcOjRVaUc58oeMjztsnxQxWo72FOfrM88c8
         mfamE1eKDwJUXM0Nx1bdEnhug3M8N5HKuWZIdd7jIwZgF4YdlNbJnb8UMker1dMX9BWU
         v9zVzklVtxmp1edHx2Wdrww3yRkOqMXD18WKa3qTh2PaLqmhJKMqzYZlGvM6H7PCFf4r
         z3C/KrqTGC35KTuLARGzVXxhBJfekb6Sd0nByc9WLGUnQrerh5wawIsAt1FOSRRaRV5H
         Shvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u6V6IrU9rSb+SxqUTIO/OsWV01QIdgCFVuaG2NS96qM=;
        b=BBxvmXKIvYnqFAP/hwJgc+q4nczlwfz2nP/xKwebdLBvawZUCIiUECjoVuFHw/8qOn
         iM/e5tsAorvu2bm0fjS+MVkhO7CMU6BqXiTFfEnH4RO+w5xxULP/k+oYaeUjfK5C1O/t
         CX+47SDdh+BaoNhMKKwMnXi3BgoDZJwPsIuiowRUwngA0r8tw0KBgc9PmWGUMlilvykQ
         sQzQqTK9+Ntgwx3v6l5mEHzZYOFEhpFoEB9S/oYn24jJDgrzAUIC/b0imIm84qvSoQDW
         4d2rgvH48zgWhvTfl7O9Z9x6aRoSiDms+JLU09S6BN+ghqydyTZ+gSvq6rSqwYDX70Ng
         3wXw==
X-Gm-Message-State: AOAM531f3qQfic9m6L7nXj1/8GwGqfSh0nUf3j5xvviwoCEBtiqEWjUc
        qCnBgrlVdTHi9gfmp8oOZZk=
X-Google-Smtp-Source: ABdhPJwQXyF2aVNJGOFmtwM7j4vIDFsS7PwXKDrRA/8jJFNYpAQlmyCWPCx+f/tNbCPEGyBPkmMcVw==
X-Received: by 2002:a05:6402:35c2:: with SMTP id z2mr50619873edc.43.1641315161905;
        Tue, 04 Jan 2022 08:52:41 -0800 (PST)
Received: from t470p.fritz.box (host-79-36-120-235.retail.telecomitalia.it. [79.36.120.235])
        by smtp.gmail.com with ESMTPSA id w16sm3703881edc.24.2022.01.04.08.52.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 08:52:41 -0800 (PST)
From:   Alberto Merciai <alb3rt0.m3rciai@gmail.com>
Cc:     alb3rt0.m3rciai@gmail.com, linuxfancy@googlegroups.com,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        Martin Kaiser <martin@kaiser.cx>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: r8188eu: rename camelcase variable peerMAC to peer_mac
Date:   Tue,  4 Jan 2022 17:52:32 +0100
Message-Id: <20220104165236.462551-1-alb3rt0.m3rciai@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename camelcase variable peerMAC to peer_mac.

Signed-off-by: Alberto Merciai <alb3rt0.m3rciai@gmail.com>
---
 drivers/staging/r8188eu/os_dep/ioctl_linux.c | 46 ++++++++++----------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
index 67a8af79508f..54d8357d668a 100644
--- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
@@ -2622,7 +2622,7 @@ static int rtw_p2p_get_wps_configmethod(struct net_device *dev,
 {
 	int ret = 0;
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
-	u8 peerMAC[ETH_ALEN] = {0x00};
+	u8 peer_mac[ETH_ALEN] = {0x00};
 	int jj, kk;
 	u8 peerMACStr[17] = {0x00};
 	struct mlme_priv		*pmlmepriv = &padapter->mlmepriv;
@@ -2645,7 +2645,7 @@ static int rtw_p2p_get_wps_configmethod(struct net_device *dev,
 		return -EFAULT;
 
 	for (jj = 0, kk = 0; jj < ETH_ALEN; jj++, kk += 3)
-		peerMAC[jj] = key_2char2num(peerMACStr[kk], peerMACStr[kk + 1]);
+		peer_mac[jj] = key_2char2num(peerMACStr[kk], peerMACStr[kk + 1]);
 
 	spin_lock_bh(&pmlmepriv->scanned_queue.lock);
 
@@ -2654,7 +2654,7 @@ static int rtw_p2p_get_wps_configmethod(struct net_device *dev,
 
 	while (phead != plist) {
 		pnetwork = container_of(plist, struct wlan_network, list);
-		if (!memcmp(pnetwork->network.MacAddress, peerMAC, ETH_ALEN)) {
+		if (!memcmp(pnetwork->network.MacAddress, peer_mac, ETH_ALEN)) {
 			u8 *wpsie;
 			uint wpsie_len = 0;
 			__be16 be_tmp;
@@ -2690,7 +2690,7 @@ static int rtw_p2p_get_go_device_address(struct net_device *dev,
 {
 	int ret = 0;
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
-	u8 peerMAC[ETH_ALEN] = {0x00};
+	u8 peer_mac[ETH_ALEN] = {0x00};
 	int jj, kk;
 	u8 peerMACStr[17] = {0x00};
 	struct mlme_priv		*pmlmepriv = &padapter->mlmepriv;
@@ -2714,7 +2714,7 @@ static int rtw_p2p_get_go_device_address(struct net_device *dev,
 		return -EFAULT;
 
 	for (jj = 0, kk = 0; jj < ETH_ALEN; jj++, kk += 3)
-		peerMAC[jj] = key_2char2num(peerMACStr[kk], peerMACStr[kk + 1]);
+		peer_mac[jj] = key_2char2num(peerMACStr[kk], peerMACStr[kk + 1]);
 
 	spin_lock_bh(&pmlmepriv->scanned_queue.lock);
 
@@ -2723,7 +2723,7 @@ static int rtw_p2p_get_go_device_address(struct net_device *dev,
 
 	while (phead != plist) {
 		pnetwork = container_of(plist, struct wlan_network, list);
-		if (!memcmp(pnetwork->network.MacAddress, peerMAC, ETH_ALEN)) {
+		if (!memcmp(pnetwork->network.MacAddress, peer_mac, ETH_ALEN)) {
 			/*	Commented by Albert 2011/05/18 */
 			/*	Match the device address located in the P2P IE */
 			/*	This is for the case that the P2P device address is not the same as the P2P interface address. */
@@ -2773,7 +2773,7 @@ static int rtw_p2p_get_device_type(struct net_device *dev,
 {
 	int ret = 0;
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
-	u8 peerMAC[ETH_ALEN] = {0x00};
+	u8 peer_mac[ETH_ALEN] = {0x00};
 	int jj, kk;
 	u8 peerMACStr[17] = {0x00};
 	struct mlme_priv		*pmlmepriv = &padapter->mlmepriv;
@@ -2795,7 +2795,7 @@ static int rtw_p2p_get_device_type(struct net_device *dev,
 		return -EFAULT;
 
 	for (jj = 0, kk = 0; jj < ETH_ALEN; jj++, kk += 3)
-		peerMAC[jj] = key_2char2num(peerMACStr[kk], peerMACStr[kk + 1]);
+		peer_mac[jj] = key_2char2num(peerMACStr[kk], peerMACStr[kk + 1]);
 
 	spin_lock_bh(&pmlmepriv->scanned_queue.lock);
 
@@ -2804,7 +2804,7 @@ static int rtw_p2p_get_device_type(struct net_device *dev,
 
 	while (phead != plist) {
 		pnetwork = container_of(plist, struct wlan_network, list);
-		if (!memcmp(pnetwork->network.MacAddress, peerMAC, ETH_ALEN)) {
+		if (!memcmp(pnetwork->network.MacAddress, peer_mac, ETH_ALEN)) {
 			u8 *wpsie;
 			uint wpsie_len = 0;
 
@@ -2849,7 +2849,7 @@ static int rtw_p2p_get_device_name(struct net_device *dev,
 {
 	int ret = 0;
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
-	u8 peerMAC[ETH_ALEN] = {0x00};
+	u8 peer_mac[ETH_ALEN] = {0x00};
 	int jj, kk;
 	u8 peerMACStr[17] = {0x00};
 	struct mlme_priv		*pmlmepriv = &padapter->mlmepriv;
@@ -2871,7 +2871,7 @@ static int rtw_p2p_get_device_name(struct net_device *dev,
 		return -EFAULT;
 
 	for (jj = 0, kk = 0; jj < ETH_ALEN; jj++, kk += 3)
-		peerMAC[jj] = key_2char2num(peerMACStr[kk], peerMACStr[kk + 1]);
+		peer_mac[jj] = key_2char2num(peerMACStr[kk], peerMACStr[kk + 1]);
 
 	spin_lock_bh(&pmlmepriv->scanned_queue.lock);
 
@@ -2880,7 +2880,7 @@ static int rtw_p2p_get_device_name(struct net_device *dev,
 
 	while (phead != plist) {
 		pnetwork = container_of(plist, struct wlan_network, list);
-		if (!memcmp(pnetwork->network.MacAddress, peerMAC, ETH_ALEN)) {
+		if (!memcmp(pnetwork->network.MacAddress, peer_mac, ETH_ALEN)) {
 			u8 *wpsie;
 			uint wpsie_len = 0;
 
@@ -2915,7 +2915,7 @@ static int rtw_p2p_get_invitation_procedure(struct net_device *dev,
 {
 	int ret = 0;
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
-	u8 peerMAC[ETH_ALEN] = {0x00};
+	u8 peer_mac[ETH_ALEN] = {0x00};
 	int jj, kk;
 	u8 peerMACStr[17] = {0x00};
 	struct mlme_priv		*pmlmepriv = &padapter->mlmepriv;
@@ -2939,7 +2939,7 @@ static int rtw_p2p_get_invitation_procedure(struct net_device *dev,
 		return -EFAULT;
 
 	for (jj = 0, kk = 0; jj < ETH_ALEN; jj++, kk += 3)
-		peerMAC[jj] = key_2char2num(peerMACStr[kk], peerMACStr[kk + 1]);
+		peer_mac[jj] = key_2char2num(peerMACStr[kk], peerMACStr[kk + 1]);
 
 	spin_lock_bh(&pmlmepriv->scanned_queue.lock);
 
@@ -2948,7 +2948,7 @@ static int rtw_p2p_get_invitation_procedure(struct net_device *dev,
 
 	while (phead != plist) {
 		pnetwork = container_of(plist, struct wlan_network, list);
-		if (!memcmp(pnetwork->network.MacAddress, peerMAC, ETH_ALEN)) {
+		if (!memcmp(pnetwork->network.MacAddress, peer_mac, ETH_ALEN)) {
 			/*	Commented by Albert 20121226 */
 			/*	Match the device address located in the P2P IE */
 			/*	This is for the case that the P2P device address is not the same as the P2P interface address. */
@@ -2992,7 +2992,7 @@ static int rtw_p2p_connect(struct net_device *dev,
 	int ret = 0;
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
 	struct wifidirect_info *pwdinfo = &padapter->wdinfo;
-	u8 peerMAC[ETH_ALEN] = {0x00};
+	u8 peer_mac[ETH_ALEN] = {0x00};
 	int jj, kk;
 	struct mlme_priv		*pmlmepriv = &padapter->mlmepriv;
 	struct list_head *plist, *phead;
@@ -3018,7 +3018,7 @@ static int rtw_p2p_connect(struct net_device *dev,
 		return -1;
 
 	for (jj = 0, kk = 0; jj < ETH_ALEN; jj++, kk += 3)
-		peerMAC[jj] = key_2char2num(extra[kk], extra[kk + 1]);
+		peer_mac[jj] = key_2char2num(extra[kk], extra[kk + 1]);
 
 	spin_lock_bh(&pmlmepriv->scanned_queue.lock);
 
@@ -3027,7 +3027,7 @@ static int rtw_p2p_connect(struct net_device *dev,
 
 	while (phead != plist) {
 		pnetwork = container_of(plist, struct wlan_network, list);
-		if (!memcmp(pnetwork->network.MacAddress, peerMAC, ETH_ALEN)) {
+		if (!memcmp(pnetwork->network.MacAddress, peer_mac, ETH_ALEN)) {
 			uintPeerChannel = pnetwork->network.Configuration.DSConfig;
 			break;
 		}
@@ -3209,7 +3209,7 @@ static int rtw_p2p_prov_disc(struct net_device *dev,
 	int ret = 0;
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
 	struct wifidirect_info *pwdinfo = &padapter->wdinfo;
-	u8 peerMAC[ETH_ALEN] = {0x00};
+	u8 peer_mac[ETH_ALEN] = {0x00};
 	int jj, kk;
 	struct mlme_priv		*pmlmepriv = &padapter->mlmepriv;
 	struct list_head *plist, *phead;
@@ -3244,7 +3244,7 @@ static int rtw_p2p_prov_disc(struct net_device *dev,
 	}
 
 	for (jj = 0, kk = 0; jj < ETH_ALEN; jj++, kk += 3)
-		peerMAC[jj] = key_2char2num(extra[kk], extra[kk + 1]);
+		peer_mac[jj] = key_2char2num(extra[kk], extra[kk + 1]);
 
 	if (!memcmp(&extra[18], "display", 7)) {
 		pwdinfo->tx_prov_disc_info.wps_config_method_request = WPS_CM_DISPLYA;
@@ -3282,13 +3282,13 @@ static int rtw_p2p_prov_disc(struct net_device *dev,
 
 				if (rtw_get_p2p_attr_content(p2pie, p2pielen, P2P_ATTR_DEVICE_ID, attr_content, &attr_contentlen)) {
 					/*	Handle the P2P Device ID attribute of Beacon first */
-					if (!memcmp(attr_content, peerMAC, ETH_ALEN)) {
+					if (!memcmp(attr_content, peer_mac, ETH_ALEN)) {
 						uintPeerChannel = pnetwork->network.Configuration.DSConfig;
 						break;
 					}
 				} else if (rtw_get_p2p_attr_content(p2pie, p2pielen, P2P_ATTR_DEVICE_INFO, attr_content, &attr_contentlen)) {
 					/*	Handle the P2P Device Info attribute of probe response */
-					if (!memcmp(attr_content, peerMAC, ETH_ALEN)) {
+					if (!memcmp(attr_content, peer_mac, ETH_ALEN)) {
 						uintPeerChannel = pnetwork->network.Configuration.DSConfig;
 						break;
 					}
@@ -3307,7 +3307,7 @@ static int rtw_p2p_prov_disc(struct net_device *dev,
 	if (uintPeerChannel) {
 		DBG_88E("[%s] peer channel: %d!\n", __func__, uintPeerChannel);
 		memcpy(pwdinfo->tx_prov_disc_info.peerIFAddr, pnetwork->network.MacAddress, ETH_ALEN);
-		memcpy(pwdinfo->tx_prov_disc_info.peerDevAddr, peerMAC, ETH_ALEN);
+		memcpy(pwdinfo->tx_prov_disc_info.peerDevAddr, peer_mac, ETH_ALEN);
 		pwdinfo->tx_prov_disc_info.peer_channel_num[0] = (u16)uintPeerChannel;
 		pwdinfo->tx_prov_disc_info.benable = true;
 		rtw_p2p_set_pre_state(pwdinfo, rtw_p2p_state(pwdinfo));
-- 
2.25.1

