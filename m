Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D63FC50236A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 07:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232351AbiDOFKN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 01:10:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351625AbiDOFGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 01:06:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6551A45783
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 21:58:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E8537B82817
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 04:58:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37BFBC385A6;
        Fri, 15 Apr 2022 04:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649998721;
        bh=/Oqj7R+G5oGbNb/CCFxRs3gQZ2weXhyjFpnl0qPspSY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mejaW1V/IQjK+sdZOKsj/FMgFWjG5WMO2sh4wiBIfZTvz0BrHdAfLWnCL2eQp2jIs
         BZUtPD6JmNrwnmQgvzCkOqAx5fNGUuyRU4B+GNp8S2MLemxQAwPES4Ogdqf31hNS7m
         DLamsAj0+A0MXitKjxEerWg0gSn+/AD64GXiWXpU=
Date:   Fri, 15 Apr 2022 06:58:38 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mahak Gupta <mahak_g@cs.iitr.ac.in>
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev
Subject: Re: [PATCH v3] staging: r8188eu: correct multiple misspellings
Message-ID: <Ylj7fnu8Y2X77o9v@kroah.com>
References: <20220414215302.3690-1-mahak_g@cs.iitr.ac.in>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220414215302.3690-1-mahak_g@cs.iitr.ac.in>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 15, 2022 at 03:23:02AM +0530, Mahak Gupta wrote:
> Fix multiple spelling errors in comments reported by checkpatch.
> 
> Signed-off-by: Mahak Gupta <mahak_g@cs.iitr.ac.in>
> ---
>  drivers/staging/r8188eu/core/rtw_ioctl_set.c |  2 +-
>  drivers/staging/r8188eu/core/rtw_mlme.c      | 10 +++---
>  drivers/staging/r8188eu/core/rtw_mlme_ext.c  | 36 ++++++++++----------
>  drivers/staging/r8188eu/core/rtw_recv.c      |  8 ++---
>  drivers/staging/r8188eu/core/rtw_xmit.c      |  8 ++---
>  5 files changed, 32 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/core/rtw_ioctl_set.c b/drivers/staging/r8188eu/core/rtw_ioctl_set.c
> index 4b78e42d180d..9df6fb122bc5 100644
> --- a/drivers/staging/r8188eu/core/rtw_ioctl_set.c
> +++ b/drivers/staging/r8188eu/core/rtw_ioctl_set.c
> @@ -290,7 +290,7 @@ u8 rtw_set_802_11_infrastructure_mode(struct adapter *padapter,
>  
>  		if ((*pold_state == Ndis802_11Infrastructure) || (*pold_state == Ndis802_11IBSS)) {
>  			if (check_fwstate(pmlmepriv, _FW_LINKED))
> -				rtw_indicate_disconnect(padapter); /* will clr Linked_state; before this function, we must have chked whether  issue dis-assoc_cmd or not */
> +				rtw_indicate_disconnect(padapter); /* will clr Linked_state; before this function, we must have checked whether  issue dis-assoc_cmd or not */
>  	       }
>  
>  		*pold_state = networktype;
> diff --git a/drivers/staging/r8188eu/core/rtw_mlme.c b/drivers/staging/r8188eu/core/rtw_mlme.c
> index aa39f07847c2..93f7d6e3df7f 100644
> --- a/drivers/staging/r8188eu/core/rtw_mlme.c
> +++ b/drivers/staging/r8188eu/core/rtw_mlme.c
> @@ -193,7 +193,7 @@ void _rtw_free_network_nolock(struct	mlme_priv *pmlmepriv, struct wlan_network *
>  /*
>  	return the wlan_network with the matching addr
>  
> -	Shall be calle under atomic context... to avoid possible racing condition...
> +	Shall be called under atomic context... to avoid possible racing condition...
>  */
>  struct wlan_network *_rtw_find_network(struct __queue *scanned_queue, u8 *addr)
>  {
> @@ -329,7 +329,7 @@ void rtw_free_network_queue(struct adapter *dev, u8 isfreeall)
>  /*
>  	return the wlan_network with the matching addr
>  
> -	Shall be calle under atomic context... to avoid possible racing condition...
> +	Shall be called under atomic context... to avoid possible racing condition...
>  */
>  struct	wlan_network *rtw_find_network(struct __queue *scanned_queue, u8 *addr)
>  {
> @@ -912,7 +912,7 @@ static struct sta_info *rtw_joinbss_update_stainfo(struct adapter *padapter, str
>  		}
>  		/* 	Commented by Albert 2012/07/21 */
>  		/* 	When doing the WPS, the wps_ie_len won't equal to 0 */
> -		/* 	And the Wi-Fi driver shouldn't allow the data packet to be tramsmitted. */
> +		/* 	And the Wi-Fi driver shouldn't allow the data packet to be transmitted. */
>  		if (padapter->securitypriv.wps_ie_len != 0) {
>  			psta->ieee8021x_blocked = true;
>  			padapter->securitypriv.wps_ie_len = 0;
> @@ -1304,7 +1304,7 @@ void rtw_stadel_event_callback(struct adapter *adapter, u8 *pbuf)
>  }
>  
>  /*
> -* _rtw_join_timeout_handler - Timeout/faliure handler for CMD JoinBss
> +* _rtw_join_timeout_handler - Timeout/failure handler for CMD JoinBss
>  * @adapter: pointer to struct adapter structure
>  */
>  void _rtw_join_timeout_handler (struct adapter *adapter)
> @@ -1339,7 +1339,7 @@ void _rtw_join_timeout_handler (struct adapter *adapter)
>  }
>  
>  /*
> -* rtw_scan_timeout_handler - Timeout/Faliure handler for CMD SiteSurvey
> +* rtw_scan_timeout_handler - Timeout/Failure handler for CMD SiteSurvey
>  * @adapter: pointer to struct adapter structure
>  */
>  void rtw_scan_timeout_handler (struct adapter *adapter)
> diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
> index 66dd06371991..10cc87a1ee5d 100644
> --- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
> +++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
> @@ -156,7 +156,7 @@ static struct rt_channel_plan_map	RTW_ChannelPlanMap[RT_CHANNEL_DOMAIN_MAX] = {
>  	{0x03},	/* 0x41, RT_CHANNEL_DOMAIN_GLOBAL_DOAMIN_2G */
>  };
>  
> -static struct rt_channel_plan_map RTW_CHANNEL_PLAN_MAP_REALTEK_DEFINE = {0x03}; /* use the conbination for max channel numbers */
> +static struct rt_channel_plan_map RTW_CHANNEL_PLAN_MAP_REALTEK_DEFINE = {0x03}; /* use the combination for max channel numbers */
>  
>  /*
>   * Search the @param channel_num in given @param channel_set
> @@ -1733,7 +1733,7 @@ void issue_p2p_GO_request(struct adapter *padapter, u8 *raddr)
>  	p2pie[p2pielen++] = 0x09;	/*	WFA P2P v1.0 */
>  
>  	/*	Commented by Albert 20110306 */
> -	/*	According to the P2P Specification, the group negoitation request frame should contain 9 P2P attributes */
> +	/*	According to the P2P Specification, the group negotiation request frame should contain 9 P2P attributes */
>  	/*	1. P2P Capability */
>  	/*	2. Group Owner Intent */
>  	/*	3. Configuration Timeout */
> @@ -2088,7 +2088,7 @@ static void issue_p2p_GO_response(struct adapter *padapter, u8 *raddr, u8 *frame
>  	p2pie[p2pielen++] = 0x09;	/*	WFA P2P v1.0 */
>  
>  	/*	Commented by Albert 20100908 */
> -	/*	According to the P2P Specification, the group negoitation response frame should contain 9 P2P attributes */
> +	/*	According to the P2P Specification, the group negotiation response frame should contain 9 P2P attributes */
>  	/*	1. Status */
>  	/*	2. P2P Capability */
>  	/*	3. Group Owner Intent */
> @@ -2384,7 +2384,7 @@ static void issue_p2p_GO_confirm(struct adapter *padapter, u8 *raddr, u8 result)
>  	p2pie[p2pielen++] = 0x09;	/*	WFA P2P v1.0 */
>  
>  	/*	Commented by Albert 20110306 */
> -	/*	According to the P2P Specification, the group negoitation request frame should contain 5 P2P attributes */
> +	/*	According to the P2P Specification, the group negotiation request frame should contain 5 P2P attributes */
>  	/*	1. Status */
>  	/*	2. P2P Capability */
>  	/*	3. Operating Channel */
> @@ -4009,7 +4009,7 @@ struct xmit_frame *alloc_mgtxmitframe(struct xmit_priv *pxmitpriv)
>  
>  /****************************************************************************
>  
> -Following are some TX fuctions for WiFi MLME
> +Following are some TX functions for WiFi MLME
>  
>  *****************************************************************************/
>  
> @@ -4611,7 +4611,7 @@ int issue_probereq_ex(struct adapter *padapter, struct ndis_802_11_ssid *pssid,
>  	return ret;
>  }
>  
> -/*  if psta == NULL, indiate we are station(client) now... */
> +/*  if psta == NULL, indicate we are station(client) now... */
>  void issue_auth(struct adapter *padapter, struct sta_info *psta, unsigned short status)
>  {
>  	struct xmit_frame *pmgntframe;
> @@ -5010,7 +5010,7 @@ void issue_assocreq(struct adapter *padapter)
>  				if (!padapter->registrypriv.wifi_spec) {
>  					/* Commented by Kurt 20110629 */
>  					/* In some older APs, WPS handshake */
> -					/* would be fail if we append vender extensions informations to AP */
> +					/* would be fail if we append vender extensions information to AP */
>  					if (!memcmp(pIE->data, WPS_OUI, 4))
>  						pIE->Length = 14;
>  				}
> @@ -5165,7 +5165,7 @@ void issue_assocreq(struct adapter *padapter)
>  		kfree(pmlmepriv->assoc_req);
>  }
>  
> -/* when wait_ack is ture, this function shoule be called at process context */
> +/* when wait_ack is true, this function should be called at process context */
>  static int _issue_nulldata(struct adapter *padapter, unsigned char *da, unsigned int power_mode, int wait_ack)
>  {
>  	int ret = _FAIL;
> @@ -5234,7 +5234,7 @@ static int _issue_nulldata(struct adapter *padapter, unsigned char *da, unsigned
>  	return ret;
>  }
>  
> -/* when wait_ms > 0 , this function shoule be called at process context */
> +/* when wait_ms > 0 , this function should be called at process context */
>  /* da == NULL for station mode */
>  int issue_nulldata(struct adapter *padapter, unsigned char *da, unsigned int power_mode, int try_cnt, int wait_ms)
>  {
> @@ -5243,7 +5243,7 @@ int issue_nulldata(struct adapter *padapter, unsigned char *da, unsigned int pow
>  	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
>  	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
>  
> -	/* da == NULL, assum it's null data for sta to ap*/
> +	/* da == NULL, assume it's null data for sta to ap*/
>  	if (!da)
>  		da = get_my_bssid(&pmlmeinfo->network);
>  
> @@ -5267,7 +5267,7 @@ int issue_nulldata(struct adapter *padapter, unsigned char *da, unsigned int pow
>  	return ret;
>  }
>  
> -/* when wait_ack is ture, this function shoule be called at process context */
> +/* when wait_ack is true, this function should be called at process context */
>  static int _issue_qos_nulldata(struct adapter *padapter, unsigned char *da, u16 tid, int wait_ack)
>  {
>  	int ret = _FAIL;
> @@ -5340,7 +5340,7 @@ static int _issue_qos_nulldata(struct adapter *padapter, unsigned char *da, u16
>  	return ret;
>  }
>  
> -/* when wait_ms > 0 , this function shoule be called at process context */
> +/* when wait_ms > 0 , this function should be called at process context */
>  /* da == NULL for station mode */
>  int issue_qos_nulldata(struct adapter *padapter, unsigned char *da, u16 tid, int try_cnt, int wait_ms)
>  {
> @@ -5349,7 +5349,7 @@ int issue_qos_nulldata(struct adapter *padapter, unsigned char *da, u16 tid, int
>  	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
>  	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
>  
> -	/* da == NULL, assum it's null data for sta to ap*/
> +	/* da == NULL, assume it's null data for sta to ap*/
>  	if (!da)
>  		da = get_my_bssid(&pmlmeinfo->network);
>  
> @@ -5783,7 +5783,7 @@ void clear_beacon_valid_bit(struct adapter *adapter)
>  
>  /****************************************************************************
>  
> -Following are some utitity fuctions for WiFi MLME
> +Following are some utility functions for WiFi MLME
>  
>  *****************************************************************************/
>  
> @@ -5895,7 +5895,7 @@ void site_survey(struct adapter *padapter)
>  		} else {
>  			/*  20100721:Interrupt scan operation here. */
>  			/*  For SW antenna diversity before link, it needs to switch to another antenna and scan again. */
> -			/*  It compares the scan result and select beter one to do connection. */
> +			/*  It compares the scan result and select better one to do connection. */
>  			if (AntDivBeforeLink8188E(padapter)) {
>  				pmlmeext->sitesurvey_res.bss_cnt = 0;
>  				pmlmeext->sitesurvey_res.channel_idx = -1;
> @@ -6156,7 +6156,7 @@ void start_create_ibss(struct adapter *padapter)
>  	/* update wireless mode */
>  	update_wireless_mode(padapter);
>  
> -	/* udpate capability */
> +	/* update capability */
>  	caps = rtw_get_capability((struct wlan_bssid_ex *)pnetwork);
>  	update_capinfo(padapter, caps);
>  	if (caps & cap_IBSS) {/* adhoc master */
> @@ -6206,7 +6206,7 @@ void start_clnt_join(struct adapter *padapter)
>  	/* update wireless mode */
>  	update_wireless_mode(padapter);
>  
> -	/* udpate capability */
> +	/* update capability */
>  	caps = rtw_get_capability((struct wlan_bssid_ex *)pnetwork);
>  	update_capinfo(padapter, caps);
>  	if (caps & cap_ESS) {
> @@ -6784,7 +6784,7 @@ void mlmeext_joinbss_event_callback(struct adapter *padapter, int join_res)
>  	/* BCN interval */
>  	rtw_write16(padapter, REG_BCN_INTERVAL, pmlmeinfo->bcn_interval);
>  
> -	/* udpate capability */
> +	/* update capability */
>  	update_capinfo(padapter, pmlmeinfo->capability);
>  
>  	/* WMM, Update EDCA param */
> diff --git a/drivers/staging/r8188eu/core/rtw_recv.c b/drivers/staging/r8188eu/core/rtw_recv.c
> index 91a6e0f035f4..a3f71697f6d7 100644
> --- a/drivers/staging/r8188eu/core/rtw_recv.c
> +++ b/drivers/staging/r8188eu/core/rtw_recv.c
> @@ -877,7 +877,7 @@ static void validate_recv_ctrl_frame(struct adapter *padapter,
>  			if (psta->sleepq_len == 0) {
>  				pstapriv->tim_bitmap &= ~BIT(psta->aid);
>  
> -				/* upate BCN for TIM IE */
> +				/* update BCN for TIM IE */
>  				/* update_BCNTIM(padapter); */
>  				update_beacon(padapter, _TIM_IE_, NULL, false);
>  			}
> @@ -891,7 +891,7 @@ static void validate_recv_ctrl_frame(struct adapter *padapter,
>  
>  				pstapriv->tim_bitmap &= ~BIT(psta->aid);
>  
> -				/* upate BCN for TIM IE */
> +				/* update BCN for TIM IE */
>  				/* update_BCNTIM(padapter); */
>  				update_beacon(padapter, _TIM_IE_, NULL, false);
>  			}
> @@ -1810,13 +1810,13 @@ void rtw_signal_stat_timer_hdl(struct timer_list *t)
>  	} else {
>  		if (recvpriv->signal_strength_data.update_req == 0) {/*  update_req is clear, means we got rx */
>  			avg_signal_strength = recvpriv->signal_strength_data.avg_val;
> -			/*  after avg_vals are accquired, we can re-stat the signal values */
> +			/*  after avg_vals are acquired, we can re-stat the signal values */
>  			recvpriv->signal_strength_data.update_req = 1;
>  		}
>  
>  		if (recvpriv->signal_qual_data.update_req == 0) {/*  update_req is clear, means we got rx */
>  			avg_signal_qual = recvpriv->signal_qual_data.avg_val;
> -			/*  after avg_vals are accquired, we can re-stat the signal values */
> +			/*  after avg_vals are acquired, we can re-stat the signal values */
>  			recvpriv->signal_qual_data.update_req = 1;
>  		}
>  
> diff --git a/drivers/staging/r8188eu/core/rtw_xmit.c b/drivers/staging/r8188eu/core/rtw_xmit.c
> index 029b994e1b71..2a686b5c65b1 100644
> --- a/drivers/staging/r8188eu/core/rtw_xmit.c
> +++ b/drivers/staging/r8188eu/core/rtw_xmit.c
> @@ -958,7 +958,7 @@ s32 rtw_xmitframe_coalesce(struct adapter *padapter, struct sk_buff *pkt, struct
>  		}
>  
>  		if (bmcst) {
> -			/*  don't do fragment to broadcat/multicast packets */
> +			/*  don't do fragment to broadcast/multicast packets */
>  			mem_sz = _rtw_pktfile_read(&pktfile, pframe, pattrib->pktlen);
>  		} else {
>  			mem_sz = _rtw_pktfile_read(&pktfile, pframe, mpdu_len);
> @@ -1768,7 +1768,7 @@ int xmitframe_enqueue_for_sleeping_sta(struct adapter *padapter, struct xmit_fra
>  			pstapriv->tim_bitmap |= BIT(0);/*  */
>  			pstapriv->sta_dz_bitmap |= BIT(0);
>  
> -			update_beacon(padapter, _TIM_IE_, NULL, false);/* tx bc/mc packets after upate bcn */
> +			update_beacon(padapter, _TIM_IE_, NULL, false);/* tx bc/mc packets after update bcn */
>  
>  			ret = true;
>  		}
> @@ -1818,7 +1818,7 @@ int xmitframe_enqueue_for_sleeping_sta(struct adapter *padapter, struct xmit_fra
>  				pstapriv->tim_bitmap |= BIT(psta->aid);
>  
>  				if (psta->sleepq_len == 1) {
> -					/* upate BCN for TIM IE */
> +					/* update BCN for TIM IE */
>  					update_beacon(padapter, _TIM_IE_, NULL, false);
>  				}
>  			}
> @@ -2087,7 +2087,7 @@ void xmit_delivery_enabled_frames(struct adapter *padapter, struct sta_info *pst
>  		if ((psta->sleepq_ac_len == 0) && (!psta->has_legacy_ac) && (wmmps_ac)) {
>  			pstapriv->tim_bitmap &= ~BIT(psta->aid);
>  
> -			/* upate BCN for TIM IE */
> +			/* update BCN for TIM IE */
>  			update_beacon(padapter, _TIM_IE_, NULL, false);
>  		}
>  	}
> -- 
> 2.17.1
> 
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/SubmittingPatches for what needs to be done
  here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
