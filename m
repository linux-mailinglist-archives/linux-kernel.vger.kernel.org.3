Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9872486942
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 18:58:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242003AbiAFR66 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 12:58:58 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:43514 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241753AbiAFR64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 12:58:56 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7D397B8205B
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 17:58:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78058C36AEB;
        Thu,  6 Jan 2022 17:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1641491934;
        bh=2ZIVF+u68miL0WQl4iX6q7KvCTfASSc9mWjOlyuw1oU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uN9IH3OWWmWyIl0uJLjZmNAyJkLuHC1Hjz74CmIHJ7cFS48lvG1RbGo8Svhj4t2M3
         movfS7cn7Qi4TMfHL8cbevTgRX+YGj+bRjXwlYsWLujXqtHMk8iFAtz3hanmxlW0wa
         AvyCbi49JNZcr6RdEXfdHjmlHrVDPCOhgdvC/mjU=
Date:   Thu, 6 Jan 2022 18:58:50 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Abdun Nihaal <abdun.nihaal@gmail.com>
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        straube.linux@gmail.com, martin@kaiser.cx,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] staging: r8188eu: change functions to return void
Message-ID: <Ydct2sBt6aB+MChS@kroah.com>
References: <cover.1641490034.git.abdun.nihaal@gmail.com>
 <9db6b08837bd6354c8e07a4b1c4bca662091f945.1641490034.git.abdun.nihaal@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9db6b08837bd6354c8e07a4b1c4bca662091f945.1641490034.git.abdun.nihaal@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 06, 2022 at 11:11:52PM +0530, Abdun Nihaal wrote:
> Some functions in ioctl_linux.c always returns 0 and their return values
> are never used. Change return type of such functions to void.
> 
> While at it, align function arguments with open parenthesis to fix
> checkpatch checks.
> 
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Abdun Nihaal <abdun.nihaal@gmail.com>
> ---
>  drivers/staging/r8188eu/os_dep/ioctl_linux.c | 115 ++++++++++---------
>  1 file changed, 58 insertions(+), 57 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
> index 6d8adbee85f3..08914b246380 100644
> --- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
> +++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
> @@ -2308,9 +2308,9 @@ static int rtw_wext_p2p_enable(struct net_device *dev,
>  	return ret;
>  }
>  
> -static int rtw_p2p_set_go_nego_ssid(struct net_device *dev,
> -			       struct iw_request_info *info,
> -			       union iwreq_data *wrqu, char *extra)
> +static void rtw_p2p_set_go_nego_ssid(struct net_device *dev,
> +				     struct iw_request_info *info,
> +				     union iwreq_data *wrqu, char *extra)
>  {
>  	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
>  	struct wifidirect_info *pwdinfo = &padapter->wdinfo;
> @@ -2319,7 +2319,7 @@ static int rtw_p2p_set_go_nego_ssid(struct net_device *dev,
>  	memcpy(pwdinfo->nego_ssid, extra, strlen(extra));
>  	pwdinfo->nego_ssidlen = strlen(extra);
>  
> -	return 0;
> +	return;
>  }
>  
>  static int rtw_p2p_set_intent(struct net_device *dev,
> @@ -2455,9 +2455,9 @@ static int rtw_p2p_profilefound(struct net_device *dev,
>  	return ret;
>  }
>  
> -static int rtw_p2p_setDN(struct net_device *dev,
> -			       struct iw_request_info *info,
> -			       union iwreq_data *wrqu, char *extra)
> +static void rtw_p2p_setDN(struct net_device *dev,
> +			  struct iw_request_info *info,
> +			  union iwreq_data *wrqu, char *extra)
>  {
>  	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
>  	struct wifidirect_info *pwdinfo = &padapter->wdinfo;
> @@ -2467,10 +2467,10 @@ static int rtw_p2p_setDN(struct net_device *dev,
>  	memcpy(pwdinfo->device_name, extra, wrqu->data.length - 1);
>  	pwdinfo->device_name_len = wrqu->data.length - 1;
>  
> -	return 0;
> +	return;
>  }
>  
> -static int rtw_p2p_get_status(struct net_device *dev,
> +static void rtw_p2p_get_status(struct net_device *dev,
>  			       struct iw_request_info *info,
>  			       union iwreq_data *wrqu, char *extra)
>  {
> @@ -2488,7 +2488,7 @@ static int rtw_p2p_get_status(struct net_device *dev,
>  	sprintf(extra, "\n\nStatus =%.2d\n", rtw_p2p_state(pwdinfo));
>  	wrqu->data.length = strlen(extra);
>  
> -	return 0;
> +	return;
>  }
>  
>  /*	Commented by Albert 20110520 */
> @@ -2496,7 +2496,7 @@ static int rtw_p2p_get_status(struct net_device *dev,
>  /*	This config method description will show us which config method the remote P2P device is intended to use */
>  /*	by sending the provisioning discovery request frame. */
>  
> -static int rtw_p2p_get_req_cm(struct net_device *dev,
> +static void rtw_p2p_get_req_cm(struct net_device *dev,
>  			       struct iw_request_info *info,
>  			       union iwreq_data *wrqu, char *extra)
>  {
> @@ -2505,12 +2505,12 @@ static int rtw_p2p_get_req_cm(struct net_device *dev,
>  
>  	sprintf(extra, "\n\nCM =%s\n", pwdinfo->rx_prov_disc_info.strconfig_method_desc_of_prov_disc_req);
>  	wrqu->data.length = strlen(extra);
> -	return 0;
> +	return;
>  }
>  
> -static int rtw_p2p_get_role(struct net_device *dev,
> -			       struct iw_request_info *info,
> -			       union iwreq_data *wrqu, char *extra)
> +static void rtw_p2p_get_role(struct net_device *dev,
> +			     struct iw_request_info *info,
> +			     union iwreq_data *wrqu, char *extra)
>  {
>  	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
>  	struct wifidirect_info *pwdinfo = &padapter->wdinfo;
> @@ -2521,12 +2521,12 @@ static int rtw_p2p_get_role(struct net_device *dev,
>  
>  	sprintf(extra, "\n\nRole =%.2d\n", rtw_p2p_role(pwdinfo));
>  	wrqu->data.length = strlen(extra);
> -	return 0;
> +	return;
>  }
>  
> -static int rtw_p2p_get_peer_ifaddr(struct net_device *dev,
> -			       struct iw_request_info *info,
> -			       union iwreq_data *wrqu, char *extra)
> +static void rtw_p2p_get_peer_ifaddr(struct net_device *dev,
> +				    struct iw_request_info *info,
> +				    union iwreq_data *wrqu, char *extra)
>  {
>  	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
>  	struct wifidirect_info *pwdinfo = &padapter->wdinfo;
> @@ -2537,12 +2537,12 @@ static int rtw_p2p_get_peer_ifaddr(struct net_device *dev,
>  	sprintf(extra, "\nMAC %pM",
>  		pwdinfo->p2p_peer_interface_addr);
>  	wrqu->data.length = strlen(extra);
> -	return 0;
> +	return;
>  }
>  
> -static int rtw_p2p_get_peer_devaddr(struct net_device *dev,
> -			       struct iw_request_info *info,
> -			       union iwreq_data *wrqu, char *extra)
> +static void rtw_p2p_get_peer_devaddr(struct net_device *dev,
> +				     struct iw_request_info *info,
> +				     union iwreq_data *wrqu, char *extra)
>  
>  {
>  	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
> @@ -2554,12 +2554,13 @@ static int rtw_p2p_get_peer_devaddr(struct net_device *dev,
>  	sprintf(extra, "\n%pM",
>  		pwdinfo->rx_prov_disc_info.peerDevAddr);
>  	wrqu->data.length = strlen(extra);
> -	return 0;
> +	return;
>  }
>  
> -static int rtw_p2p_get_peer_devaddr_by_invitation(struct net_device *dev,
> -			       struct iw_request_info *info,
> -			       union iwreq_data *wrqu, char *extra)
> +static void rtw_p2p_get_peer_devaddr_by_invitation(struct net_device *dev,
> +						   struct iw_request_info *info,
> +						   union iwreq_data *wrqu,
> +						   char *extra)
>  
>  {
>  	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
> @@ -2571,12 +2572,12 @@ static int rtw_p2p_get_peer_devaddr_by_invitation(struct net_device *dev,
>  	sprintf(extra, "\nMAC %pM",
>  		pwdinfo->p2p_peer_device_addr);
>  	wrqu->data.length = strlen(extra);
> -	return 0;
> +	return;
>  }
>  
> -static int rtw_p2p_get_groupid(struct net_device *dev,
> -			       struct iw_request_info *info,
> -			       union iwreq_data *wrqu, char *extra)
> +static void rtw_p2p_get_groupid(struct net_device *dev,
> +				struct iw_request_info *info,
> +				union iwreq_data *wrqu, char *extra)
>  
>  {
>  	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
> @@ -2588,12 +2589,12 @@ static int rtw_p2p_get_groupid(struct net_device *dev,
>  		pwdinfo->groupid_info.go_device_addr[4], pwdinfo->groupid_info.go_device_addr[5],
>  		pwdinfo->groupid_info.ssid);
>  	wrqu->data.length = strlen(extra);
> -	return 0;
> +	return;
>  }
>  
> -static int rtw_p2p_get_op_ch(struct net_device *dev,
> -			       struct iw_request_info *info,
> -			       union iwreq_data *wrqu, char *extra)
> +static void rtw_p2p_get_op_ch(struct net_device *dev,
> +			      struct iw_request_info *info,
> +			      union iwreq_data *wrqu, char *extra)
>  
>  {
>  	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
> @@ -2603,7 +2604,7 @@ static int rtw_p2p_get_op_ch(struct net_device *dev,
>  
>  	sprintf(extra, "\n\nOp_ch =%.2d\n", pwdinfo->operating_channel);
>  	wrqu->data.length = strlen(extra);
> -	return 0;
> +	return;
>  }
>  
>  static int rtw_p2p_get_wps_configmethod(struct net_device *dev,
> @@ -3049,9 +3050,9 @@ static int rtw_p2p_connect(struct net_device *dev,
>  	return ret;
>  }
>  
> -static int rtw_p2p_invite_req(struct net_device *dev,
> -			      struct iw_request_info *info,
> -			      union iwreq_data *wrqu, char *extra)
> +static void rtw_p2p_invite_req(struct net_device *dev,
> +			       struct iw_request_info *info,
> +			       union iwreq_data *wrqu, char *extra)
>  {
>  	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
>  	struct wifidirect_info *pwdinfo = &padapter->wdinfo;
> @@ -3076,12 +3077,12 @@ static int rtw_p2p_invite_req(struct net_device *dev,
>  
>  	if (wrqu->data.length <=  37) {
>  		DBG_88E("[%s] Wrong format!\n", __func__);
> -		return 0;
> +		return;
>  	}
>  
>  	if (rtw_p2p_chk_state(pwdinfo, P2P_STATE_NONE)) {
>  		DBG_88E("[%s] WiFi Direct is disable!\n", __func__);
> -		return 0;
> +		return;
>  	} else {
>  		/*	Reset the content of struct tx_invite_req_info */
>  		pinvite_req_info->benable = false;
> @@ -3154,12 +3155,12 @@ static int rtw_p2p_invite_req(struct net_device *dev,
>  	} else {
>  		DBG_88E("[%s] NOT Found in the Scanning Queue!\n", __func__);
>  	}
> -	return 0;
> +	return;
>  }
>  
> -static int rtw_p2p_set_persistent(struct net_device *dev,
> -			       struct iw_request_info *info,
> -			       union iwreq_data *wrqu, char *extra)
> +static void rtw_p2p_set_persistent(struct net_device *dev,
> +				   struct iw_request_info *info,
> +				   union iwreq_data *wrqu, char *extra)
>  {
>  	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
>  	struct wifidirect_info *pwdinfo = &padapter->wdinfo;
> @@ -3172,7 +3173,7 @@ static int rtw_p2p_set_persistent(struct net_device *dev,
>  
>  	if (rtw_p2p_chk_state(pwdinfo, P2P_STATE_NONE)) {
>  		DBG_88E("[%s] WiFi Direct is disable!\n", __func__);
> -		return 0;
> +		return;
>  	} else {
>  		if (extra[0] == '0')	/*	Disable the persistent group function. */
>  			pwdinfo->persistent_supported = false;
> @@ -3182,12 +3183,12 @@ static int rtw_p2p_set_persistent(struct net_device *dev,
>  			pwdinfo->persistent_supported = false;
>  	}
>  	pr_info("[%s] persistent_supported = %d\n", __func__, pwdinfo->persistent_supported);
> -	return 0;
> +	return;
>  }
>  
> -static int rtw_p2p_prov_disc(struct net_device *dev,
> -			       struct iw_request_info *info,
> -			       union iwreq_data *wrqu, char *extra)
> +static void rtw_p2p_prov_disc(struct net_device *dev,
> +			      struct iw_request_info *info,
> +			      union iwreq_data *wrqu, char *extra)
>  {
>  	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
>  	struct wifidirect_info *pwdinfo = &padapter->wdinfo;
> @@ -3214,7 +3215,7 @@ static int rtw_p2p_prov_disc(struct net_device *dev,
>  
>  	if (pwdinfo->p2p_state == P2P_STATE_NONE) {
>  		DBG_88E("[%s] WiFi Direct is disable!\n", __func__);
> -		return 0;
> +		return;
>  	} else {
>  		/*	Reset the content of struct tx_provdisc_req_info excluded the wps_config_method_request. */
>  		memset(pwdinfo->tx_prov_disc_info.peerDevAddr, 0x00, ETH_ALEN);
> @@ -3238,7 +3239,7 @@ static int rtw_p2p_prov_disc(struct net_device *dev,
>  		pwdinfo->tx_prov_disc_info.wps_config_method_request = WPS_CM_LABEL;
>  	} else {
>  		DBG_88E("[%s] Unknown WPS config methodn", __func__);
> -		return 0;
> +		return;
>  	}
>  
>  	spin_lock_bh(&pmlmepriv->scanned_queue.lock);
> @@ -3310,15 +3311,15 @@ static int rtw_p2p_prov_disc(struct net_device *dev,
>  	} else {
>  		DBG_88E("[%s] NOT Found in the Scanning Queue!\n", __func__);
>  	}
> -	return 0;
> +	return;
>  }
>  
>  /*	This function is used to inform the driver the user had specified the pin code value or pbc */
>  /*	to application. */
>  
> -static int rtw_p2p_got_wpsinfo(struct net_device *dev,
> -			       struct iw_request_info *info,
> -			       union iwreq_data *wrqu, char *extra)
> +static void rtw_p2p_got_wpsinfo(struct net_device *dev,
> +				struct iw_request_info *info,
> +				union iwreq_data *wrqu, char *extra)
>  {
>  	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
>  	struct wifidirect_info *pwdinfo = &padapter->wdinfo;
> @@ -3340,7 +3341,7 @@ static int rtw_p2p_got_wpsinfo(struct net_device *dev,
>  		pwdinfo->ui_got_wps_info = P2P_GOT_WPSINFO_PBC;
>  	else
>  		pwdinfo->ui_got_wps_info = P2P_NO_WPSINFO;
> -	return 0;
> +	return;
>  }
>  
>  static int rtw_p2p_set(struct net_device *dev,
> -- 
> 2.34.1
> 
>

Are you sure that checkpatch allowed this change?
