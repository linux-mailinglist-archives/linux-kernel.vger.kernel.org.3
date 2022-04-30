Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F708515A7A
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 06:29:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240901AbiD3Ec1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 00:32:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234630AbiD3EcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 00:32:23 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9179986C8
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 21:29:02 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id hf18so7196762qtb.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 21:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=northvilleschools.net; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=PbK5p4Q9lslkN06k8CDqVzAZ/xtdQ0VtnwJnOkwDNwk=;
        b=jtIJRC5jfX5nx14dM/3cDyAKSxPh0Mg6XL6t8sOI1J2DqMG4ZIwDKPB/aCs6k+7DT+
         iZYXmqcCgr0HhsKUzt8QGGFr1cgIcAHMJqrqzOeq8i2kWkCGo5NmksZoD9UOldO9TCfD
         QFXclDdgmTCxZGMwvNN3tBKFzvGfyfiYV0MnclGFu4TrAu5w2HvUmeuK5ame6TBsfCnc
         LJfY1blmwVHWWrwi3UIyZvjd9we0PnzGAxgpZ7ZHSjqjQ1NAzP8n9PdX3TulUjscSn1B
         GvmL67XYErJPn8KT9alaDo6oWin+i5jvXEb32+4WuiNQmL+yegbtlQA5A5N1MjX6WtYR
         VJjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=PbK5p4Q9lslkN06k8CDqVzAZ/xtdQ0VtnwJnOkwDNwk=;
        b=qr4IXoPiIrDfdJwZWQ4DEiZ8f0iCHa4MNSNqRW21Wsb+fOd9MDF3EiWhTBV5vlB3CL
         YM6Oos+d2i58BOtiWbYjW4QBbXWMZ0BFTI6H5WKIjbQ55jmrPdPjio/hOJNFWr8pk8WG
         n503o4I9BzNa5rhGe44WH77LND269fSiteueHH2LpILfC0ym4C4zNuKkaf12uFwLgFdP
         v/F1MYYvA8qV6i2Kg2lWc4TeCwbKc0O+pkc7ufv6S8Hv8jxd5y7jLuZhFU6FzVuYIdgX
         tRbhb9RlUW9v7DiUXaVB++FXFgfIVhLJK1X9XWNtb4AsMlZMfmjRzL1+z2C9mtGY/LJj
         /aIA==
X-Gm-Message-State: AOAM531oqKFppauh2XwWLbhWhuwXnq28WZ87R2KyptDw9Nkapdfyep9K
        u3BY9K/rr6uw1WJ67kRYi9GXVg==
X-Google-Smtp-Source: ABdhPJz+LblXjVGqorBN72tVH7IURCzxIPWVtlVnJgB2imqTHv2b80fkOgH/6ugIDGZNXqLerb1o2g==
X-Received: by 2002:a05:622a:387:b0:2f3:8d0f:97de with SMTP id j7-20020a05622a038700b002f38d0f97demr2274021qtx.404.1651292941832;
        Fri, 29 Apr 2022 21:29:01 -0700 (PDT)
Received: from sckzor-linux (d4-50-247-168.col.wideopenwest.com. [50.4.168.247])
        by smtp.gmail.com with ESMTPSA id 79-20020a370752000000b0069fc2a7e7a5sm554486qkh.75.2022.04.29.21.29.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 21:29:01 -0700 (PDT)
Date:   Sat, 30 Apr 2022 00:28:59 -0400
From:   Charlie Sands <sandsch@northvilleschools.net>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        paskripkin@gmail.com, straube.linux@gmail.com,
        dan.carpenter@oracle.com, fmdefrancesco@gmail.com
Subject: [PATCH V4] staging: r8188eu: Remove broken rtw_p2p_get function.
Message-ID: <Ymy7C/A2q+VzfBhO@sckzor-linux.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removes broken and unsafe rtw_p2p_get function and all of the code
associated with it from the r8188eu driver.

Signed-off-by: Charlie Sands <charlies256@protonmail.com>
---

Follow up to the patch called "staging: r8188eu: Fix unsafe memory access
by memcmp." 

V2: Fixed checkpatch.pl warning and changed variable name as suggested
by Greg K. H. and improved error checking on the "copy_from_user" function as
suggested by Pavel Skripkin.

V3: Return -EFAULT from the function when there is a memory error while
moving it from user space to kernel space and fix incorrect subject from V2

V4: Updated commit message and changes to reflect those sugested by Dan 
Carpenter.

 drivers/staging/r8188eu/os_dep/ioctl_linux.c | 136 +------------------
 1 file changed, 1 insertion(+), 135 deletions(-)

diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
index eb9375b0c660..51f1a464d5bd 100644
--- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
@@ -2363,114 +2363,6 @@ static void rtw_p2p_setDN(struct net_device *dev,
 	pwdinfo->device_name_len = wrqu->data.length - 1;
 }
 
-static void rtw_p2p_get_status(struct net_device *dev,
-			       struct iw_request_info *info,
-			       union iwreq_data *wrqu, char *extra)
-{
-	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
-	struct wifidirect_info *pwdinfo = &padapter->wdinfo;
-
-	/*	Commented by Albert 2010/10/12 */
-	/*	Because of the output size limitation, I had removed the "Role" information. */
-	/*	About the "Role" information, we will use the new private IOCTL to get the "Role" information. */
-	sprintf(extra, "\n\nStatus =%.2d\n", rtw_p2p_state(pwdinfo));
-	wrqu->data.length = strlen(extra);
-}
-
-/*	Commented by Albert 20110520 */
-/*	This function will return the config method description */
-/*	This config method description will show us which config method the remote P2P device is intended to use */
-/*	by sending the provisioning discovery request frame. */
-
-static void rtw_p2p_get_req_cm(struct net_device *dev,
-			       struct iw_request_info *info,
-			       union iwreq_data *wrqu, char *extra)
-{
-	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
-	struct wifidirect_info *pwdinfo = &padapter->wdinfo;
-
-	sprintf(extra, "\n\nCM =%s\n", pwdinfo->rx_prov_disc_info.strconfig_method_desc_of_prov_disc_req);
-	wrqu->data.length = strlen(extra);
-}
-
-static void rtw_p2p_get_role(struct net_device *dev,
-			     struct iw_request_info *info,
-			     union iwreq_data *wrqu, char *extra)
-{
-	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
-	struct wifidirect_info *pwdinfo = &padapter->wdinfo;
-
-	sprintf(extra, "\n\nRole =%.2d\n", rtw_p2p_role(pwdinfo));
-	wrqu->data.length = strlen(extra);
-}
-
-static void rtw_p2p_get_peer_ifaddr(struct net_device *dev,
-				    struct iw_request_info *info,
-				    union iwreq_data *wrqu, char *extra)
-{
-	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
-	struct wifidirect_info *pwdinfo = &padapter->wdinfo;
-
-	sprintf(extra, "\nMAC %pM",
-		pwdinfo->p2p_peer_interface_addr);
-	wrqu->data.length = strlen(extra);
-}
-
-static void rtw_p2p_get_peer_devaddr(struct net_device *dev,
-				     struct iw_request_info *info,
-				     union iwreq_data *wrqu, char *extra)
-
-{
-	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
-	struct wifidirect_info *pwdinfo = &padapter->wdinfo;
-
-	sprintf(extra, "\n%pM",
-		pwdinfo->rx_prov_disc_info.peerDevAddr);
-	wrqu->data.length = strlen(extra);
-}
-
-static void rtw_p2p_get_peer_devaddr_by_invitation(struct net_device *dev,
-						   struct iw_request_info *info,
-						   union iwreq_data *wrqu,
-						   char *extra)
-
-{
-	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
-	struct wifidirect_info *pwdinfo = &padapter->wdinfo;
-
-	sprintf(extra, "\nMAC %pM",
-		pwdinfo->p2p_peer_device_addr);
-	wrqu->data.length = strlen(extra);
-}
-
-static void rtw_p2p_get_groupid(struct net_device *dev,
-				struct iw_request_info *info,
-				union iwreq_data *wrqu, char *extra)
-
-{
-	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
-	struct wifidirect_info *pwdinfo = &padapter->wdinfo;
-
-	sprintf(extra, "\n%.2X:%.2X:%.2X:%.2X:%.2X:%.2X %s",
-		pwdinfo->groupid_info.go_device_addr[0], pwdinfo->groupid_info.go_device_addr[1],
-		pwdinfo->groupid_info.go_device_addr[2], pwdinfo->groupid_info.go_device_addr[3],
-		pwdinfo->groupid_info.go_device_addr[4], pwdinfo->groupid_info.go_device_addr[5],
-		pwdinfo->groupid_info.ssid);
-	wrqu->data.length = strlen(extra);
-}
-
-static void rtw_p2p_get_op_ch(struct net_device *dev,
-			      struct iw_request_info *info,
-			      union iwreq_data *wrqu, char *extra)
-
-{
-	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
-	struct wifidirect_info *pwdinfo = &padapter->wdinfo;
-
-	sprintf(extra, "\n\nOp_ch =%.2d\n", pwdinfo->operating_channel);
-	wrqu->data.length = strlen(extra);
-}
-
 static int rtw_p2p_get_wps_configmethod(struct net_device *dev,
 			       struct iw_request_info *info,
 			       union iwreq_data *wrqu, char *extra)
@@ -3229,32 +3121,6 @@ static int rtw_p2p_set(struct net_device *dev,
 	return ret;
 }
 
-static int rtw_p2p_get(struct net_device *dev,
-			       struct iw_request_info *info,
-			       union iwreq_data *wrqu, char *extra)
-{
-	if (!memcmp(wrqu->data.pointer, "status", 6)) {
-		rtw_p2p_get_status(dev, info, wrqu, extra);
-	} else if (!memcmp(wrqu->data.pointer, "role", 4)) {
-		rtw_p2p_get_role(dev, info, wrqu, extra);
-	} else if (!memcmp(wrqu->data.pointer, "peer_ifa", 8)) {
-		rtw_p2p_get_peer_ifaddr(dev, info, wrqu, extra);
-	} else if (!memcmp(wrqu->data.pointer, "req_cm", 6)) {
-		rtw_p2p_get_req_cm(dev, info, wrqu, extra);
-	} else if (!memcmp(wrqu->data.pointer, "peer_deva", 9)) {
-		/*	Get the P2P device address when receiving the provision discovery request frame. */
-		rtw_p2p_get_peer_devaddr(dev, info, wrqu, extra);
-	} else if (!memcmp(wrqu->data.pointer, "group_id", 8)) {
-		rtw_p2p_get_groupid(dev, info, wrqu, extra);
-	} else if (!memcmp(wrqu->data.pointer, "peer_deva_inv", 9)) {
-		/*	Get the P2P device address when receiving the P2P Invitation request frame. */
-		rtw_p2p_get_peer_devaddr_by_invitation(dev, info, wrqu, extra);
-	} else if (!memcmp(wrqu->data.pointer, "op_ch", 5)) {
-		rtw_p2p_get_op_ch(dev, info, wrqu, extra);
-	}
-	return 0;
-}
-
 static int rtw_p2p_get2(struct net_device *dev,
 			       struct iw_request_info *info,
 			       union iwreq_data *wrqu, char *extra)
@@ -3919,7 +3785,7 @@ NULL,					/* 0x03 */
 	NULL,				/* 0x0F */
 
 	rtw_p2p_set,			/* 0x10 */
-	rtw_p2p_get,			/* 0x11 */
+	NULL,				/* 0x11 */
 	rtw_p2p_get2,			/* 0x12 */
 
 	NULL,				/* 0x13 */
-- 
2.36.0

