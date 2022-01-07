Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56D914875BE
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 11:38:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347160AbiAGKhz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 05:37:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346728AbiAGKhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 05:37:00 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F376C034000
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 02:37:00 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id l10-20020a17090a384a00b001b22190e075so11537750pjf.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jan 2022 02:37:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MhmlDtAbY6r4xiN3WIXb8n/SWnEVkFHX5SyGJsjUmAc=;
        b=GlGbnGAksyGfQ/sTphCjuiNzBT6JqxUWl37J1PnyRVsN8i+JCTjmUtJCYyA9HG4Uyc
         E//MRewvjl3R/Gk3frutQJCzy/S+UYxrlndIkTtG6O/cpcSdjcICqQUsGiHvM9WA2iT4
         DVpQ/g1RcemF8oDi26L2lGClFn1oECbvmJskeAEamTUNlY82rckuk2HDEz0DVihJkGue
         8DjLdxKDxkapom8GzMK75pvenAaZx1ZRLTWwTPWMO0QkFY0X5zcRPa/2aos2FacgW20E
         xcZId2249OshNdnGjLJV4YOaCVklQfzgt7ncFZqW48IB9x9fBr6kt8t+0BtXb2RH1jhU
         MQ2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MhmlDtAbY6r4xiN3WIXb8n/SWnEVkFHX5SyGJsjUmAc=;
        b=XSRfFSLsM/3o7T7Zdtexy0b4E1yTqekkMBaXA7BXS1Dp5/rDSmvwQeuxhYZG0tbDqA
         gWauzWqrfbqzt188CZ6nuvg7dtPhzvMBnnuqSt8eNxxSLvnFUx5Rr13jMm+FW6yoBpYY
         aK33nxLB13xWKeRABMQ/Lh7Ztxb44/zbQvZJ21k44C5HKDnl9dS7KAkLDkWivHcg+MaM
         UZLvUivbhQSob9wYBEYZlXURpfamVdZ1+v0i2Adzc+Z+D/cLa3xGG2h243G/Sgo7e1uF
         i3YtJAQKaWLztK9sn8PdGiMrv8Atrowwa1s++fKXsI9HiY36PqAkJ5jrLvgyIetOdCBm
         991w==
X-Gm-Message-State: AOAM5302fAuJuUTSUG9PWPvIBB/6V+XFP6LoMBNF0ZhPwlTpU1VnxZm3
        Bhd9rb2uYRuUU/BiPhlGfy8=
X-Google-Smtp-Source: ABdhPJxzxQmYQM62POey5sNtD5cQZkQQm4YW3wN/lRwoIJdrdRGktRdcjejlFcBbULxkKf9kLv6jdA==
X-Received: by 2002:a17:90a:e60c:: with SMTP id j12mr9883868pjy.156.1641551819725;
        Fri, 07 Jan 2022 02:36:59 -0800 (PST)
Received: from localhost.localdomain ([171.78.146.184])
        by smtp.googlemail.com with ESMTPSA id i1sm4464156pgk.89.2022.01.07.02.36.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jan 2022 02:36:59 -0800 (PST)
From:   Abdun Nihaal <abdun.nihaal@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Abdun Nihaal <abdun.nihaal@gmail.com>, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, straube.linux@gmail.com, martin@kaiser.cx,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] staging: r8188eu: remove unneeded ret variables
Date:   Fri,  7 Jan 2022 16:05:40 +0530
Message-Id: <c9c24c13d2823ccaadbbce33613d1242531dbe86.1641551261.git.abdun.nihaal@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1641551261.git.abdun.nihaal@gmail.com>
References: <cover.1641551261.git.abdun.nihaal@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unneeded return variables in ioctl_linux.c that are initialized
to 0 and are not assigned after. Instead, return 0 directly.

Found using coccinelle (returnvar.cocci).

Signed-off-by: Abdun Nihaal <abdun.nihaal@gmail.com>
---
v1 -> v2:
Not removing unneeded return variable in rtw_p2p_get, rtw_p2p_get2 and
rtw_p2p_set because they may have to be used.

 drivers/staging/r8188eu/os_dep/ioctl_linux.c | 79 +++++++-------------
 1 file changed, 29 insertions(+), 50 deletions(-)

diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
index 67a8af79508f..6d8adbee85f3 100644
--- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
@@ -1383,7 +1383,7 @@ static int rtw_wx_get_essid(struct net_device *dev,
 			      struct iw_request_info *a,
 			      union iwreq_data *wrqu, char *extra)
 {
-	u32 len, ret = 0;
+	u32 len;
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
 	struct	mlme_priv	*pmlmepriv = &padapter->mlmepriv;
 	struct wlan_bssid_ex  *pcur_bss = &pmlmepriv->cur_network.network;
@@ -1399,7 +1399,7 @@ static int rtw_wx_get_essid(struct net_device *dev,
 	wrqu->essid.length = len;
 	wrqu->essid.flags = 1;
 
-	return ret;
+	return 0;
 }
 
 static int rtw_wx_set_rate(struct net_device *dev,
@@ -1717,7 +1717,7 @@ static int rtw_wx_get_enc(struct net_device *dev,
 			    struct iw_request_info *info,
 			    union iwreq_data *wrqu, char *keybuf)
 {
-	uint key, ret = 0;
+	uint key;
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
 	struct iw_point *erq = &wrqu->encoding;
 	struct	mlme_priv	*pmlmepriv = &padapter->mlmepriv;
@@ -1778,7 +1778,7 @@ static int rtw_wx_get_enc(struct net_device *dev,
 	}
 
 
-	return ret;
+	return 0;
 }
 
 static int rtw_wx_get_power(struct net_device *dev,
@@ -2312,7 +2312,6 @@ static int rtw_p2p_set_go_nego_ssid(struct net_device *dev,
 			       struct iw_request_info *info,
 			       union iwreq_data *wrqu, char *extra)
 {
-	int ret = 0;
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
 	struct wifidirect_info *pwdinfo = &padapter->wdinfo;
 
@@ -2320,7 +2319,7 @@ static int rtw_p2p_set_go_nego_ssid(struct net_device *dev,
 	memcpy(pwdinfo->nego_ssid, extra, strlen(extra));
 	pwdinfo->nego_ssidlen = strlen(extra);
 
-	return ret;
+	return 0;
 }
 
 static int rtw_p2p_set_intent(struct net_device *dev,
@@ -2460,7 +2459,6 @@ static int rtw_p2p_setDN(struct net_device *dev,
 			       struct iw_request_info *info,
 			       union iwreq_data *wrqu, char *extra)
 {
-	int ret = 0;
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
 	struct wifidirect_info *pwdinfo = &padapter->wdinfo;
 
@@ -2469,14 +2467,13 @@ static int rtw_p2p_setDN(struct net_device *dev,
 	memcpy(pwdinfo->device_name, extra, wrqu->data.length - 1);
 	pwdinfo->device_name_len = wrqu->data.length - 1;
 
-	return ret;
+	return 0;
 }
 
 static int rtw_p2p_get_status(struct net_device *dev,
 			       struct iw_request_info *info,
 			       union iwreq_data *wrqu, char *extra)
 {
-	int ret = 0;
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
 	struct wifidirect_info *pwdinfo = &padapter->wdinfo;
 
@@ -2491,7 +2488,7 @@ static int rtw_p2p_get_status(struct net_device *dev,
 	sprintf(extra, "\n\nStatus =%.2d\n", rtw_p2p_state(pwdinfo));
 	wrqu->data.length = strlen(extra);
 
-	return ret;
+	return 0;
 }
 
 /*	Commented by Albert 20110520 */
@@ -2503,20 +2500,18 @@ static int rtw_p2p_get_req_cm(struct net_device *dev,
 			       struct iw_request_info *info,
 			       union iwreq_data *wrqu, char *extra)
 {
-	int ret = 0;
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
 	struct wifidirect_info *pwdinfo = &padapter->wdinfo;
 
 	sprintf(extra, "\n\nCM =%s\n", pwdinfo->rx_prov_disc_info.strconfig_method_desc_of_prov_disc_req);
 	wrqu->data.length = strlen(extra);
-	return ret;
+	return 0;
 }
 
 static int rtw_p2p_get_role(struct net_device *dev,
 			       struct iw_request_info *info,
 			       union iwreq_data *wrqu, char *extra)
 {
-	int ret = 0;
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
 	struct wifidirect_info *pwdinfo = &padapter->wdinfo;
 
@@ -2526,14 +2521,13 @@ static int rtw_p2p_get_role(struct net_device *dev,
 
 	sprintf(extra, "\n\nRole =%.2d\n", rtw_p2p_role(pwdinfo));
 	wrqu->data.length = strlen(extra);
-	return ret;
+	return 0;
 }
 
 static int rtw_p2p_get_peer_ifaddr(struct net_device *dev,
 			       struct iw_request_info *info,
 			       union iwreq_data *wrqu, char *extra)
 {
-	int ret = 0;
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
 	struct wifidirect_info *pwdinfo = &padapter->wdinfo;
 
@@ -2543,7 +2537,7 @@ static int rtw_p2p_get_peer_ifaddr(struct net_device *dev,
 	sprintf(extra, "\nMAC %pM",
 		pwdinfo->p2p_peer_interface_addr);
 	wrqu->data.length = strlen(extra);
-	return ret;
+	return 0;
 }
 
 static int rtw_p2p_get_peer_devaddr(struct net_device *dev,
@@ -2551,7 +2545,6 @@ static int rtw_p2p_get_peer_devaddr(struct net_device *dev,
 			       union iwreq_data *wrqu, char *extra)
 
 {
-	int ret = 0;
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
 	struct wifidirect_info *pwdinfo = &padapter->wdinfo;
 
@@ -2561,7 +2554,7 @@ static int rtw_p2p_get_peer_devaddr(struct net_device *dev,
 	sprintf(extra, "\n%pM",
 		pwdinfo->rx_prov_disc_info.peerDevAddr);
 	wrqu->data.length = strlen(extra);
-	return ret;
+	return 0;
 }
 
 static int rtw_p2p_get_peer_devaddr_by_invitation(struct net_device *dev,
@@ -2569,7 +2562,6 @@ static int rtw_p2p_get_peer_devaddr_by_invitation(struct net_device *dev,
 			       union iwreq_data *wrqu, char *extra)
 
 {
-	int ret = 0;
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
 	struct wifidirect_info *pwdinfo = &padapter->wdinfo;
 
@@ -2579,7 +2571,7 @@ static int rtw_p2p_get_peer_devaddr_by_invitation(struct net_device *dev,
 	sprintf(extra, "\nMAC %pM",
 		pwdinfo->p2p_peer_device_addr);
 	wrqu->data.length = strlen(extra);
-	return ret;
+	return 0;
 }
 
 static int rtw_p2p_get_groupid(struct net_device *dev,
@@ -2587,7 +2579,6 @@ static int rtw_p2p_get_groupid(struct net_device *dev,
 			       union iwreq_data *wrqu, char *extra)
 
 {
-	int ret = 0;
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
 	struct wifidirect_info *pwdinfo = &padapter->wdinfo;
 
@@ -2597,7 +2588,7 @@ static int rtw_p2p_get_groupid(struct net_device *dev,
 		pwdinfo->groupid_info.go_device_addr[4], pwdinfo->groupid_info.go_device_addr[5],
 		pwdinfo->groupid_info.ssid);
 	wrqu->data.length = strlen(extra);
-	return ret;
+	return 0;
 }
 
 static int rtw_p2p_get_op_ch(struct net_device *dev,
@@ -2605,7 +2596,6 @@ static int rtw_p2p_get_op_ch(struct net_device *dev,
 			       union iwreq_data *wrqu, char *extra)
 
 {
-	int ret = 0;
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
 	struct wifidirect_info *pwdinfo = &padapter->wdinfo;
 
@@ -2613,14 +2603,13 @@ static int rtw_p2p_get_op_ch(struct net_device *dev,
 
 	sprintf(extra, "\n\nOp_ch =%.2d\n", pwdinfo->operating_channel);
 	wrqu->data.length = strlen(extra);
-	return ret;
+	return 0;
 }
 
 static int rtw_p2p_get_wps_configmethod(struct net_device *dev,
 			       struct iw_request_info *info,
 			       union iwreq_data *wrqu, char *extra)
 {
-	int ret = 0;
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
 	u8 peerMAC[ETH_ALEN] = {0x00};
 	int jj, kk;
@@ -2681,14 +2670,13 @@ static int rtw_p2p_get_wps_configmethod(struct net_device *dev,
 
 	if (copy_to_user(wrqu->data.pointer, attr_content_str, 6 + 17))
 		return -EFAULT;
-	return ret;
+	return 0;
 }
 
 static int rtw_p2p_get_go_device_address(struct net_device *dev,
 			       struct iw_request_info *info,
 			       union iwreq_data *wrqu, char *extra)
 {
-	int ret = 0;
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
 	u8 peerMAC[ETH_ALEN] = {0x00};
 	int jj, kk;
@@ -2764,14 +2752,13 @@ static int rtw_p2p_get_go_device_address(struct net_device *dev,
 
 	if (copy_to_user(wrqu->data.pointer, go_devadd_str, 10 + 17))
 		return -EFAULT;
-	return ret;
+	return 0;
 }
 
 static int rtw_p2p_get_device_type(struct net_device *dev,
 			       struct iw_request_info *info,
 			       union iwreq_data *wrqu, char *extra)
 {
-	int ret = 0;
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
 	u8 peerMAC[ETH_ALEN] = {0x00};
 	int jj, kk;
@@ -2840,14 +2827,13 @@ static int rtw_p2p_get_device_type(struct net_device *dev,
 		return -EFAULT;
 	}
 
-	return ret;
+	return 0;
 }
 
 static int rtw_p2p_get_device_name(struct net_device *dev,
 			       struct iw_request_info *info,
 			       union iwreq_data *wrqu, char *extra)
 {
-	int ret = 0;
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
 	u8 peerMAC[ETH_ALEN] = {0x00};
 	int jj, kk;
@@ -2906,14 +2892,13 @@ static int rtw_p2p_get_device_name(struct net_device *dev,
 
 	if (copy_to_user(wrqu->data.pointer, dev_name_str, 5 + ((dev_len > 17) ? dev_len : 17)))
 		return -EFAULT;
-	return ret;
+	return 0;
 }
 
 static int rtw_p2p_get_invitation_procedure(struct net_device *dev,
 			       struct iw_request_info *info,
 			       union iwreq_data *wrqu, char *extra)
 {
-	int ret = 0;
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
 	u8 peerMAC[ETH_ALEN] = {0x00};
 	int jj, kk;
@@ -2982,7 +2967,7 @@ static int rtw_p2p_get_invitation_procedure(struct net_device *dev,
 	}
 	if (copy_to_user(wrqu->data.pointer, inv_proc_str, 8 + 17))
 		return -EFAULT;
-	return ret;
+	return 0;
 }
 
 static int rtw_p2p_connect(struct net_device *dev,
@@ -3068,7 +3053,6 @@ static int rtw_p2p_invite_req(struct net_device *dev,
 			      struct iw_request_info *info,
 			      union iwreq_data *wrqu, char *extra)
 {
-	int ret = 0;
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
 	struct wifidirect_info *pwdinfo = &padapter->wdinfo;
 	int jj, kk;
@@ -3092,12 +3076,12 @@ static int rtw_p2p_invite_req(struct net_device *dev,
 
 	if (wrqu->data.length <=  37) {
 		DBG_88E("[%s] Wrong format!\n", __func__);
-		return ret;
+		return 0;
 	}
 
 	if (rtw_p2p_chk_state(pwdinfo, P2P_STATE_NONE)) {
 		DBG_88E("[%s] WiFi Direct is disable!\n", __func__);
-		return ret;
+		return 0;
 	} else {
 		/*	Reset the content of struct tx_invite_req_info */
 		pinvite_req_info->benable = false;
@@ -3170,14 +3154,13 @@ static int rtw_p2p_invite_req(struct net_device *dev,
 	} else {
 		DBG_88E("[%s] NOT Found in the Scanning Queue!\n", __func__);
 	}
-	return ret;
+	return 0;
 }
 
 static int rtw_p2p_set_persistent(struct net_device *dev,
 			       struct iw_request_info *info,
 			       union iwreq_data *wrqu, char *extra)
 {
-	int ret = 0;
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
 	struct wifidirect_info *pwdinfo = &padapter->wdinfo;
 
@@ -3189,7 +3172,7 @@ static int rtw_p2p_set_persistent(struct net_device *dev,
 
 	if (rtw_p2p_chk_state(pwdinfo, P2P_STATE_NONE)) {
 		DBG_88E("[%s] WiFi Direct is disable!\n", __func__);
-		return ret;
+		return 0;
 	} else {
 		if (extra[0] == '0')	/*	Disable the persistent group function. */
 			pwdinfo->persistent_supported = false;
@@ -3199,14 +3182,13 @@ static int rtw_p2p_set_persistent(struct net_device *dev,
 			pwdinfo->persistent_supported = false;
 	}
 	pr_info("[%s] persistent_supported = %d\n", __func__, pwdinfo->persistent_supported);
-	return ret;
+	return 0;
 }
 
 static int rtw_p2p_prov_disc(struct net_device *dev,
 			       struct iw_request_info *info,
 			       union iwreq_data *wrqu, char *extra)
 {
-	int ret = 0;
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
 	struct wifidirect_info *pwdinfo = &padapter->wdinfo;
 	u8 peerMAC[ETH_ALEN] = {0x00};
@@ -3232,7 +3214,7 @@ static int rtw_p2p_prov_disc(struct net_device *dev,
 
 	if (pwdinfo->p2p_state == P2P_STATE_NONE) {
 		DBG_88E("[%s] WiFi Direct is disable!\n", __func__);
-		return ret;
+		return 0;
 	} else {
 		/*	Reset the content of struct tx_provdisc_req_info excluded the wps_config_method_request. */
 		memset(pwdinfo->tx_prov_disc_info.peerDevAddr, 0x00, ETH_ALEN);
@@ -3256,7 +3238,7 @@ static int rtw_p2p_prov_disc(struct net_device *dev,
 		pwdinfo->tx_prov_disc_info.wps_config_method_request = WPS_CM_LABEL;
 	} else {
 		DBG_88E("[%s] Unknown WPS config methodn", __func__);
-		return ret;
+		return 0;
 	}
 
 	spin_lock_bh(&pmlmepriv->scanned_queue.lock);
@@ -3328,7 +3310,7 @@ static int rtw_p2p_prov_disc(struct net_device *dev,
 	} else {
 		DBG_88E("[%s] NOT Found in the Scanning Queue!\n", __func__);
 	}
-	return ret;
+	return 0;
 }
 
 /*	This function is used to inform the driver the user had specified the pin code value or pbc */
@@ -3338,7 +3320,6 @@ static int rtw_p2p_got_wpsinfo(struct net_device *dev,
 			       struct iw_request_info *info,
 			       union iwreq_data *wrqu, char *extra)
 {
-	int ret = 0;
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
 	struct wifidirect_info *pwdinfo = &padapter->wdinfo;
 
@@ -3359,7 +3340,7 @@ static int rtw_p2p_got_wpsinfo(struct net_device *dev,
 		pwdinfo->ui_got_wps_info = P2P_GOT_WPSINFO_PBC;
 	else
 		pwdinfo->ui_got_wps_info = P2P_NO_WPSINFO;
-	return ret;
+	return 0;
 }
 
 static int rtw_p2p_set(struct net_device *dev,
@@ -3422,8 +3403,6 @@ static int rtw_p2p_get(struct net_device *dev,
 			       struct iw_request_info *info,
 			       union iwreq_data *wrqu, char *extra)
 {
-	int ret = 0;
-
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
 
 	if (padapter->bShowGetP2PState)
@@ -3447,7 +3426,7 @@ static int rtw_p2p_get(struct net_device *dev,
 	} else if (!memcmp(wrqu->data.pointer, "op_ch", 5)) {
 		rtw_p2p_get_op_ch(dev, info, wrqu, extra);
 	}
-	return ret;
+	return 0;
 }
 
 static int rtw_p2p_get2(struct net_device *dev,
-- 
2.34.1

