Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F52C4FCF4F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 08:17:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345728AbiDLGTO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 02:19:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbiDLGTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 02:19:12 -0400
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 824DF2E6A5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 23:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=TYmXdeheL04yvKARy8Ln0MLIo+v4FwOlI7ZVl3qCMfA=;
  b=tfusEIGGNTAHPRxRb+ssBmXG130RkW/4IGVc6t3oAQ+iRTG7IcYdwsPH
   B5jfeOks/0rbNhejqKyEdbSh2xtzvLNyvQNihPGOYYLIFnON+bCFIUR0o
   i1hzMe6kS6RjxnTePy0h78d77kZGxBULY5SsLS9QszyCrA/xV3Q/9dPNF
   Y=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.90,253,1643670000"; 
   d="scan'208";a="11243304"
Received: from 203.107.68.85.rev.sfr.net (HELO hadrien) ([85.68.107.203])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2022 08:16:52 +0200
Date:   Tue, 12 Apr 2022 08:16:51 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Mahak Gupta <mahak_g@cs.iitr.ac.in>
cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, outreachy@lists.linux.dev
Subject: Re: [PATCH] staging: r8188eu: correct multiple misspellings in driver
 r8188eu
In-Reply-To: <20220411205321.13109-1-mahak_g@cs.iitr.ac.in>
Message-ID: <alpine.DEB.2.22.394.2204120815530.3122@hadrien>
References: <20220411205321.13109-1-mahak_g@cs.iitr.ac.in>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need for "in driver r8188eu" in the subject.

On Tue, 12 Apr 2022, Mahak Gupta wrote:

> Reported by checkpatch.

It's good to try to find something more informative to characterize what
you have done.  Here all the changes are in comments.

julia

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
> index c90f36dee1ea..a2b42779bc87 100644
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
> index 474391bf7cb5..fd445aa09377 100644
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
> @@ -5790,7 +5790,7 @@ void clear_beacon_valid_bit(struct adapter *adapter)
>
>  /****************************************************************************
>
> -Following are some utitity fuctions for WiFi MLME
> +Following are some utility functions for WiFi MLME
>
>  *****************************************************************************/
>
> @@ -5888,7 +5888,7 @@ void site_survey(struct adapter *padapter)
>  		} else {
>  			/*  20100721:Interrupt scan operation here. */
>  			/*  For SW antenna diversity before link, it needs to switch to another antenna and scan again. */
> -			/*  It compares the scan result and select beter one to do connection. */
> +			/*  It compares the scan result and select better one to do connection. */
>  			if (AntDivBeforeLink8188E(padapter)) {
>  				pmlmeext->sitesurvey_res.bss_cnt = 0;
>  				pmlmeext->sitesurvey_res.channel_idx = -1;
> @@ -6109,7 +6109,7 @@ void start_create_ibss(struct adapter *padapter)
>  	/* update wireless mode */
>  	update_wireless_mode(padapter);
>
> -	/* udpate capability */
> +	/* update capability */
>  	caps = rtw_get_capability((struct wlan_bssid_ex *)pnetwork);
>  	update_capinfo(padapter, caps);
>  	if (caps & cap_IBSS) {/* adhoc master */
> @@ -6160,7 +6160,7 @@ void start_clnt_join(struct adapter *padapter)
>  	/* update wireless mode */
>  	update_wireless_mode(padapter);
>
> -	/* udpate capability */
> +	/* update capability */
>  	caps = rtw_get_capability((struct wlan_bssid_ex *)pnetwork);
>  	update_capinfo(padapter, caps);
>  	if (caps & cap_ESS) {
> @@ -6740,7 +6740,7 @@ void mlmeext_joinbss_event_callback(struct adapter *padapter, int join_res)
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
>
