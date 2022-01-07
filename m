Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C46A64875BF
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 11:38:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346909AbiAGKh5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 05:37:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346886AbiAGKhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 05:37:04 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C65BC034005
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 02:37:04 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id 200so5133126pgg.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jan 2022 02:37:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XGBMg0dB0s4kyjuf9Ps877T8tPhU3A5IvC8S2pNPBnA=;
        b=AyOZMoB6xaixJcZejfdWDhUVJIMsdLO3BHnjNgmdSax0464w3FSXUxClhz7yecTUE8
         91+/HFkGeDfvcfj9SW1H02YLgavBFIc26VxYhYwdhrHt4WBKeNgQjtIXtwOCkcfqvChe
         WISwaAaEZlDoteqJlKyFu0d5Ub5ipJoqOddvarCrHQPuYLxag9wtbkiKDO72PC1mGHfQ
         g1nBk+4wY0H3MmPFfNwcPY8VfWcaTB7RXhFSLenaO+ezHGDZrgiOV3tNmSmCnmamh6In
         ebRAOR3CXGfBt1GpFtwmMPkmNQcCUKZt0gbaNR4yeM/efj9RbwIBDyn3K4vqk+vw0SYZ
         DEgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XGBMg0dB0s4kyjuf9Ps877T8tPhU3A5IvC8S2pNPBnA=;
        b=iOPYcwvfb9hcP2ekyX/K8bdiu+UeQMjBKblHKB8UwFiX2BqunWyF5ipra5EUKpjh8g
         DqT5LK/+BfdVMlisVaLPZcBXDXkt9yiPh9a3FPzpjrKQFUOQLw+V/IMJzYFpnu2rJ/ph
         A/LJGmbeYYquHvN/zP7d0a4jkGkiqIMaHSS2AR42UA0maNnIgITPYAhtZfHc2NOggKQH
         sx9bUpiEWNZBi4ayRPCbgAIHOdwKNX7kOlQRxG1fTxiA1wA6jmOTjKcO/C3YjB8Er0GF
         RekW6p2Lfc7hJvMD1P2AYkB/ybSVrUzDVyKvKc74DNYFCoJQTFvTmJpBfkSx/oYSO9DI
         JEug==
X-Gm-Message-State: AOAM531xAbrVg+XXKnHxOwenModMuD8tAwZGd15NCZntGZKESHAWgpCy
        sW+N0uDA0AE4kmcenq+GtM0=
X-Google-Smtp-Source: ABdhPJxH5N/QMk4LizWm1ojFpBCXmlCO+2I56An3iRq+CPmjn0nCsLNjwJ2vCLXXvIjRDJXc/F4ODA==
X-Received: by 2002:a63:6c85:: with SMTP id h127mr56126520pgc.491.1641551823675;
        Fri, 07 Jan 2022 02:37:03 -0800 (PST)
Received: from localhost.localdomain ([171.78.146.184])
        by smtp.googlemail.com with ESMTPSA id i1sm4464156pgk.89.2022.01.07.02.37.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jan 2022 02:37:03 -0800 (PST)
From:   Abdun Nihaal <abdun.nihaal@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Abdun Nihaal <abdun.nihaal@gmail.com>, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, straube.linux@gmail.com, martin@kaiser.cx,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] staging: r8188eu: change functions to return void
Date:   Fri,  7 Jan 2022 16:05:41 +0530
Message-Id: <46392ba67b772ecc6aece4f2c58cacbce56609be.1641551261.git.abdun.nihaal@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1641551261.git.abdun.nihaal@gmail.com>
References: <cover.1641551261.git.abdun.nihaal@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some functions in ioctl_linux.c always returns 0 and their return values
are never used. Change return type of these functions to void.

While at it, align function arguments with open parenthesis to fix
checkpatch checks.

Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Abdun Nihaal <abdun.nihaal@gmail.com>
---
v2 -> v3:
Remove empty returns at the end of void functions.

 drivers/staging/r8188eu/os_dep/ioctl_linux.c | 104 ++++++++-----------
 1 file changed, 44 insertions(+), 60 deletions(-)

diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
index 6d8adbee85f3..c1aaab44de0e 100644
--- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
@@ -2308,9 +2308,9 @@ static int rtw_wext_p2p_enable(struct net_device *dev,
 	return ret;
 }
 
-static int rtw_p2p_set_go_nego_ssid(struct net_device *dev,
-			       struct iw_request_info *info,
-			       union iwreq_data *wrqu, char *extra)
+static void rtw_p2p_set_go_nego_ssid(struct net_device *dev,
+				     struct iw_request_info *info,
+				     union iwreq_data *wrqu, char *extra)
 {
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
 	struct wifidirect_info *pwdinfo = &padapter->wdinfo;
@@ -2318,8 +2318,6 @@ static int rtw_p2p_set_go_nego_ssid(struct net_device *dev,
 	DBG_88E("[%s] ssid = %s, len = %zu\n", __func__, extra, strlen(extra));
 	memcpy(pwdinfo->nego_ssid, extra, strlen(extra));
 	pwdinfo->nego_ssidlen = strlen(extra);
-
-	return 0;
 }
 
 static int rtw_p2p_set_intent(struct net_device *dev,
@@ -2455,9 +2453,9 @@ static int rtw_p2p_profilefound(struct net_device *dev,
 	return ret;
 }
 
-static int rtw_p2p_setDN(struct net_device *dev,
-			       struct iw_request_info *info,
-			       union iwreq_data *wrqu, char *extra)
+static void rtw_p2p_setDN(struct net_device *dev,
+			  struct iw_request_info *info,
+			  union iwreq_data *wrqu, char *extra)
 {
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
 	struct wifidirect_info *pwdinfo = &padapter->wdinfo;
@@ -2466,11 +2464,9 @@ static int rtw_p2p_setDN(struct net_device *dev,
 	memset(pwdinfo->device_name, 0x00, WPS_MAX_DEVICE_NAME_LEN);
 	memcpy(pwdinfo->device_name, extra, wrqu->data.length - 1);
 	pwdinfo->device_name_len = wrqu->data.length - 1;
-
-	return 0;
 }
 
-static int rtw_p2p_get_status(struct net_device *dev,
+static void rtw_p2p_get_status(struct net_device *dev,
 			       struct iw_request_info *info,
 			       union iwreq_data *wrqu, char *extra)
 {
@@ -2487,8 +2483,6 @@ static int rtw_p2p_get_status(struct net_device *dev,
 	/*	About the "Role" information, we will use the new private IOCTL to get the "Role" information. */
 	sprintf(extra, "\n\nStatus =%.2d\n", rtw_p2p_state(pwdinfo));
 	wrqu->data.length = strlen(extra);
-
-	return 0;
 }
 
 /*	Commented by Albert 20110520 */
@@ -2496,7 +2490,7 @@ static int rtw_p2p_get_status(struct net_device *dev,
 /*	This config method description will show us which config method the remote P2P device is intended to use */
 /*	by sending the provisioning discovery request frame. */
 
-static int rtw_p2p_get_req_cm(struct net_device *dev,
+static void rtw_p2p_get_req_cm(struct net_device *dev,
 			       struct iw_request_info *info,
 			       union iwreq_data *wrqu, char *extra)
 {
@@ -2505,12 +2499,11 @@ static int rtw_p2p_get_req_cm(struct net_device *dev,
 
 	sprintf(extra, "\n\nCM =%s\n", pwdinfo->rx_prov_disc_info.strconfig_method_desc_of_prov_disc_req);
 	wrqu->data.length = strlen(extra);
-	return 0;
 }
 
-static int rtw_p2p_get_role(struct net_device *dev,
-			       struct iw_request_info *info,
-			       union iwreq_data *wrqu, char *extra)
+static void rtw_p2p_get_role(struct net_device *dev,
+			     struct iw_request_info *info,
+			     union iwreq_data *wrqu, char *extra)
 {
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
 	struct wifidirect_info *pwdinfo = &padapter->wdinfo;
@@ -2521,12 +2514,11 @@ static int rtw_p2p_get_role(struct net_device *dev,
 
 	sprintf(extra, "\n\nRole =%.2d\n", rtw_p2p_role(pwdinfo));
 	wrqu->data.length = strlen(extra);
-	return 0;
 }
 
-static int rtw_p2p_get_peer_ifaddr(struct net_device *dev,
-			       struct iw_request_info *info,
-			       union iwreq_data *wrqu, char *extra)
+static void rtw_p2p_get_peer_ifaddr(struct net_device *dev,
+				    struct iw_request_info *info,
+				    union iwreq_data *wrqu, char *extra)
 {
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
 	struct wifidirect_info *pwdinfo = &padapter->wdinfo;
@@ -2537,12 +2529,11 @@ static int rtw_p2p_get_peer_ifaddr(struct net_device *dev,
 	sprintf(extra, "\nMAC %pM",
 		pwdinfo->p2p_peer_interface_addr);
 	wrqu->data.length = strlen(extra);
-	return 0;
 }
 
-static int rtw_p2p_get_peer_devaddr(struct net_device *dev,
-			       struct iw_request_info *info,
-			       union iwreq_data *wrqu, char *extra)
+static void rtw_p2p_get_peer_devaddr(struct net_device *dev,
+				     struct iw_request_info *info,
+				     union iwreq_data *wrqu, char *extra)
 
 {
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
@@ -2554,12 +2545,12 @@ static int rtw_p2p_get_peer_devaddr(struct net_device *dev,
 	sprintf(extra, "\n%pM",
 		pwdinfo->rx_prov_disc_info.peerDevAddr);
 	wrqu->data.length = strlen(extra);
-	return 0;
 }
 
-static int rtw_p2p_get_peer_devaddr_by_invitation(struct net_device *dev,
-			       struct iw_request_info *info,
-			       union iwreq_data *wrqu, char *extra)
+static void rtw_p2p_get_peer_devaddr_by_invitation(struct net_device *dev,
+						   struct iw_request_info *info,
+						   union iwreq_data *wrqu,
+						   char *extra)
 
 {
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
@@ -2571,12 +2562,11 @@ static int rtw_p2p_get_peer_devaddr_by_invitation(struct net_device *dev,
 	sprintf(extra, "\nMAC %pM",
 		pwdinfo->p2p_peer_device_addr);
 	wrqu->data.length = strlen(extra);
-	return 0;
 }
 
-static int rtw_p2p_get_groupid(struct net_device *dev,
-			       struct iw_request_info *info,
-			       union iwreq_data *wrqu, char *extra)
+static void rtw_p2p_get_groupid(struct net_device *dev,
+				struct iw_request_info *info,
+				union iwreq_data *wrqu, char *extra)
 
 {
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
@@ -2588,12 +2578,11 @@ static int rtw_p2p_get_groupid(struct net_device *dev,
 		pwdinfo->groupid_info.go_device_addr[4], pwdinfo->groupid_info.go_device_addr[5],
 		pwdinfo->groupid_info.ssid);
 	wrqu->data.length = strlen(extra);
-	return 0;
 }
 
-static int rtw_p2p_get_op_ch(struct net_device *dev,
-			       struct iw_request_info *info,
-			       union iwreq_data *wrqu, char *extra)
+static void rtw_p2p_get_op_ch(struct net_device *dev,
+			      struct iw_request_info *info,
+			      union iwreq_data *wrqu, char *extra)
 
 {
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
@@ -2603,7 +2592,6 @@ static int rtw_p2p_get_op_ch(struct net_device *dev,
 
 	sprintf(extra, "\n\nOp_ch =%.2d\n", pwdinfo->operating_channel);
 	wrqu->data.length = strlen(extra);
-	return 0;
 }
 
 static int rtw_p2p_get_wps_configmethod(struct net_device *dev,
@@ -3049,9 +3037,9 @@ static int rtw_p2p_connect(struct net_device *dev,
 	return ret;
 }
 
-static int rtw_p2p_invite_req(struct net_device *dev,
-			      struct iw_request_info *info,
-			      union iwreq_data *wrqu, char *extra)
+static void rtw_p2p_invite_req(struct net_device *dev,
+			       struct iw_request_info *info,
+			       union iwreq_data *wrqu, char *extra)
 {
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
 	struct wifidirect_info *pwdinfo = &padapter->wdinfo;
@@ -3076,12 +3064,12 @@ static int rtw_p2p_invite_req(struct net_device *dev,
 
 	if (wrqu->data.length <=  37) {
 		DBG_88E("[%s] Wrong format!\n", __func__);
-		return 0;
+		return;
 	}
 
 	if (rtw_p2p_chk_state(pwdinfo, P2P_STATE_NONE)) {
 		DBG_88E("[%s] WiFi Direct is disable!\n", __func__);
-		return 0;
+		return;
 	} else {
 		/*	Reset the content of struct tx_invite_req_info */
 		pinvite_req_info->benable = false;
@@ -3154,12 +3142,11 @@ static int rtw_p2p_invite_req(struct net_device *dev,
 	} else {
 		DBG_88E("[%s] NOT Found in the Scanning Queue!\n", __func__);
 	}
-	return 0;
 }
 
-static int rtw_p2p_set_persistent(struct net_device *dev,
-			       struct iw_request_info *info,
-			       union iwreq_data *wrqu, char *extra)
+static void rtw_p2p_set_persistent(struct net_device *dev,
+				   struct iw_request_info *info,
+				   union iwreq_data *wrqu, char *extra)
 {
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
 	struct wifidirect_info *pwdinfo = &padapter->wdinfo;
@@ -3172,7 +3159,7 @@ static int rtw_p2p_set_persistent(struct net_device *dev,
 
 	if (rtw_p2p_chk_state(pwdinfo, P2P_STATE_NONE)) {
 		DBG_88E("[%s] WiFi Direct is disable!\n", __func__);
-		return 0;
+		return;
 	} else {
 		if (extra[0] == '0')	/*	Disable the persistent group function. */
 			pwdinfo->persistent_supported = false;
@@ -3182,12 +3169,11 @@ static int rtw_p2p_set_persistent(struct net_device *dev,
 			pwdinfo->persistent_supported = false;
 	}
 	pr_info("[%s] persistent_supported = %d\n", __func__, pwdinfo->persistent_supported);
-	return 0;
 }
 
-static int rtw_p2p_prov_disc(struct net_device *dev,
-			       struct iw_request_info *info,
-			       union iwreq_data *wrqu, char *extra)
+static void rtw_p2p_prov_disc(struct net_device *dev,
+			      struct iw_request_info *info,
+			      union iwreq_data *wrqu, char *extra)
 {
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
 	struct wifidirect_info *pwdinfo = &padapter->wdinfo;
@@ -3214,7 +3200,7 @@ static int rtw_p2p_prov_disc(struct net_device *dev,
 
 	if (pwdinfo->p2p_state == P2P_STATE_NONE) {
 		DBG_88E("[%s] WiFi Direct is disable!\n", __func__);
-		return 0;
+		return;
 	} else {
 		/*	Reset the content of struct tx_provdisc_req_info excluded the wps_config_method_request. */
 		memset(pwdinfo->tx_prov_disc_info.peerDevAddr, 0x00, ETH_ALEN);
@@ -3238,7 +3224,7 @@ static int rtw_p2p_prov_disc(struct net_device *dev,
 		pwdinfo->tx_prov_disc_info.wps_config_method_request = WPS_CM_LABEL;
 	} else {
 		DBG_88E("[%s] Unknown WPS config methodn", __func__);
-		return 0;
+		return;
 	}
 
 	spin_lock_bh(&pmlmepriv->scanned_queue.lock);
@@ -3310,15 +3296,14 @@ static int rtw_p2p_prov_disc(struct net_device *dev,
 	} else {
 		DBG_88E("[%s] NOT Found in the Scanning Queue!\n", __func__);
 	}
-	return 0;
 }
 
 /*	This function is used to inform the driver the user had specified the pin code value or pbc */
 /*	to application. */
 
-static int rtw_p2p_got_wpsinfo(struct net_device *dev,
-			       struct iw_request_info *info,
-			       union iwreq_data *wrqu, char *extra)
+static void rtw_p2p_got_wpsinfo(struct net_device *dev,
+				struct iw_request_info *info,
+				union iwreq_data *wrqu, char *extra)
 {
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
 	struct wifidirect_info *pwdinfo = &padapter->wdinfo;
@@ -3340,7 +3325,6 @@ static int rtw_p2p_got_wpsinfo(struct net_device *dev,
 		pwdinfo->ui_got_wps_info = P2P_GOT_WPSINFO_PBC;
 	else
 		pwdinfo->ui_got_wps_info = P2P_NO_WPSINFO;
-	return 0;
 }
 
 static int rtw_p2p_set(struct net_device *dev,
-- 
2.34.1

