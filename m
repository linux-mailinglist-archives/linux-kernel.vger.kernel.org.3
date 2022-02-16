Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 312604B84A8
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 10:43:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232380AbiBPJnX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 04:43:23 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:57370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231143AbiBPJnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 04:43:21 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 505FD28F97D
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 01:43:01 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id g39so2717858lfv.10
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 01:43:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=RmzcFqNmIicXwKmfTqvqrWsz/Hiolw8GCGitWsGR0Nc=;
        b=CriCBEOS3b/qYrPXhXMQCyDb6fpn29rFZE6YHxkOdhAQx7gDCjW7dSA73MIMVmIo5F
         VDpyy/easuRxCgonu5mMF9KsWB/V5+a8tgGvNqZ0NF39P09RjUq1aED+dKfkrjsA7mwK
         BZS8kX+2B1e4078ZzDN7QNallvNYbq3KKqdGijvyNOvLu5W5jQze7w5RyDUc4C2j2TIj
         veQ17n5v1BAgS24ywo7OSyxhp4ZfL9PtXcdLoZrawPgakbNnzq/HFOO0phd2qk7qt2ge
         1Axrdk62ZzTmGVAK3ptOmW5x3Y9Ksw0U1IGiT6274FNc6fMUYgRxt5KfI6l5kaMs/osi
         Ed1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=RmzcFqNmIicXwKmfTqvqrWsz/Hiolw8GCGitWsGR0Nc=;
        b=MurZG6tMMVlJZ/p/961GP53eDJ1kK0o6oaWWAmnZPf2gBwIz36Pd5TiVIyilrkM8pZ
         I1Kqb0dmLXmnu8V5LD0NgbUBBg7A3ELL9Q5oNIPtp3/3ym6++sWgqLMYPZ2XsDXjb0Is
         BcWNVME0qQ0Xywvh6oS+Hr3cW66cquvHpHf4zRNbEuILkr2sTVNMiidMUHSejTd+OCJI
         RRrQ/oorXXUZtQjyp6tQyI6li1LxZQGImk203Z0X1C2LGv0BU2UZf/VPBDye6eo8kYXg
         QJJRyYTBx1/If6+ShPXwaHchrTptLmrH/ghAIeo0grBnzJ3mOIMeOdBp20HQv8olXpK7
         eseQ==
X-Gm-Message-State: AOAM5312s5HP3nQGKVD2zdwbQoRa/Vg3yqx2AcJuWfBw8WiltkeQ/Q4s
        VXocZTSoR2uZGjl8ZihGfv8=
X-Google-Smtp-Source: ABdhPJx3sex45ZPRpSWFrtKnozU42mbU/2i70zIfXr8Gw6hNKRMnwDmseVY9ByDoyQ28ff3cdLukYA==
X-Received: by 2002:ac2:5cb3:0:b0:443:5e19:b12a with SMTP id e19-20020ac25cb3000000b004435e19b12amr1437397lfq.148.1645004579182;
        Wed, 16 Feb 2022 01:42:59 -0800 (PST)
Received: from [192.168.1.11] ([217.117.245.154])
        by smtp.gmail.com with ESMTPSA id e10sm4727594ljk.30.2022.02.16.01.42.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Feb 2022 01:42:58 -0800 (PST)
Message-ID: <e187df14-403c-2908-e4f5-8d38d7f63810@gmail.com>
Date:   Wed, 16 Feb 2022 12:42:57 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v2 02/15] staging: r8188eu: remove smaller sets of
 converted DBG_88E calls
Content-Language: en-US
To:     Phillip Potter <phil@philpotter.co.uk>, gregkh@linuxfoundation.org
Cc:     dan.carpenter@oracle.com, Larry.Finger@lwfinger.net,
        straube.linux@gmail.com, martin@kaiser.cx,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20220216010709.791-1-phil@philpotter.co.uk>
 <20220216010709.791-3-phil@philpotter.co.uk>
From:   Pavel Skripkin <paskripkin@gmail.com>
In-Reply-To: <20220216010709.791-3-phil@philpotter.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Phillip,

On 2/16/22 04:06, Phillip Potter wrote:
> Remove all the smaller sets of dev_dbg/netdev_dbg/pr_debug calls that
> were previously converted from DBG_88E. After some thought, it makes
> more sense to just entirely strip all of these calls, so that debugging
> code in the driver can be more consistent and useful going forwards.
> 
> Signed-off-by: Phillip Potter <phil@philpotter.co.uk>

[code snip]

> @@ -468,9 +440,6 @@ void update_bmc_sta(struct adapter *padapter)
>   			arg = psta->mac_id & 0x1f;
>   			arg |= BIT(7);
>   			tx_ra_bitmap |= ((raid << 28) & 0xf0000000);
> -			netdev_dbg(padapter->pnetdev,
> -				   "mask = 0x%x, arg = 0x%x\n",
> -				   tx_ra_bitmap, arg);
>   
>   			/* bitmap[0:27] = tx_rate_bitmap */
>   			/* bitmap[28:31]= Rate Adaptive id */
> @@ -489,7 +458,6 @@ void update_bmc_sta(struct adapter *padapter)
>   		spin_unlock_bh(&psta->lock);
>   
>   	} else {
> -		netdev_dbg(padapter->pnetdev, "add_RATid_bmc_sta error!\n");
>   	}

else branch can be dropped completelly

>   }
>   
> @@ -575,8 +543,6 @@ static void update_bcn_erpinfo_ie(struct adapter *padapter)
>   	unsigned char *p, *ie = pnetwork->IEs;
>   	u32 len = 0;
>   
> -	netdev_dbg(padapter->pnetdev, "ERP_enable = %d\n", pmlmeinfo->ERP_enable);
> -
>   	if (!pmlmeinfo->ERP_enable)
>   		return;
>   

[code snip]

>   		if (!psta->no_ht_set) {
> @@ -928,9 +874,6 @@ void bss_cap_update_on_sta_join(struct adapter *padapter, struct sta_info *psta)
>   			pmlmepriv->num_sta_no_ht++;
>   		}
>   		if (pmlmepriv->htpriv.ht_option) {
> -			netdev_dbg(padapter->pnetdev,
> -				   "STA %pM - no HT, num of non-HT stations %d\n",
> -				   (psta->hwaddr), pmlmepriv->num_sta_no_ht);
>   		}
>   	}
>

same here

> @@ -941,8 +884,6 @@ void bss_cap_update_on_sta_join(struct adapter *padapter, struct sta_info *psta)
>   
>   	/* update associated stations cap. */
>   	associated_clients_update(padapter,  beacon_updated);
> -
> -	netdev_dbg(padapter->pnetdev, "updated = %d\n", beacon_updated);
>   }
>   

[code snip]

> diff --git a/drivers/staging/r8188eu/core/rtw_ieee80211.c b/drivers/staging/r8188eu/core/rtw_ieee80211.c
> index 25445f3ab4a3..c8998cb276be 100644
> --- a/drivers/staging/r8188eu/core/rtw_ieee80211.c
> +++ b/drivers/staging/r8188eu/core/rtw_ieee80211.c
> @@ -655,8 +655,6 @@ static int rtw_ieee802_11_parse_vendor_specific(u8 *pos, uint elen,
>   	 * sub-type. */
>   	if (elen < 4) {
>   		if (show_errors) {
> -			pr_debug("short vendor specific information element ignored (len=%lu)\n",
> -				 (unsigned long)elen);
>   		}
>   		return -1;


same here

>   	}
> @@ -675,8 +673,6 @@ static int rtw_ieee802_11_parse_vendor_specific(u8 *pos, uint elen,

[code snip]

> @@ -754,8 +742,6 @@ enum parse_res rtw_ieee802_11_parse_elems(u8 *start, uint len,
>   
>   		if (elen > left) {
>   			if (show_errors) {
> -				pr_debug("IEEE 802.11 element parse failed (id=%d elen=%d left=%lu)\n",
> -					 id, elen, (unsigned long)left);
>   			}
>   			return ParseFailed;
>   		}

same here

> @@ -841,8 +827,6 @@ enum parse_res rtw_ieee802_11_parse_elems(u8 *start, uint len,
>   			unknown++;
>   			if (!show_errors)
>   				break;

[code spin]

> @@ -51,8 +47,6 @@ int rtw_IOL_append_cmds(struct xmit_frame *xmit_frame, u8 *IOL_cmds, u32 cmd_len
>   
>   	/* check if the io_buf can accommodate new cmds */
>   	if (ori_len + cmd_len + 8 > MAX_XMITBUF_SZ) {
> -		pr_debug("%u is larger than MAX_XMITBUF_SZ:%u, can't accommodate new cmds\n",
> -			 ori_len + cmd_len + 8, MAX_XMITBUF_SZ);
>   		return _FAIL;
>   	}

Nit: if are going to post v3, please, make checkpatch happy by removing 
bracers

>   
> diff --git a/drivers/staging/r8188eu/core/rtw_mlme.c b/drivers/staging/r8188eu/core/rtw_mlme.c
> index 557f6b96e99c..d7494d820756 100644
> --- a/drivers/staging/r8188eu/core/rtw_mlme.c
> +++ b/drivers/staging/r8188eu/core/rtw_mlme.c
> @@ -611,9 +611,6 @@ static int rtw_is_desired_network(struct adapter *adapter, struct wlan_network *
>   	}
>   
>   	if ((desired_encmode != Ndis802_11EncryptionDisabled) && (privacy == 0)) {
> -		netdev_dbg(adapter->pnetdev,
> -			   "desired_encmode: %d, privacy: %d\n",
> -			   desired_encmode, privacy);
>   		bselected = false;
>   	}
>   

same bracers here

> @@ -725,9 +722,6 @@ void rtw_surveydone_event_callback(struct adapter	*adapter, u8 *pbuf)
>   				_clr_fwstate_(pmlmepriv, _FW_UNDER_LINKING);
>   				rtw_indicate_connect(adapter);
>   			} else {
> -				netdev_dbg(adapter->pnetdev,
> -					   "try_to_join, but select scanning queue fail, to_roaming:%d\n",
> -					   pmlmepriv->to_roaming);
>   				if (rtw_to_roaming(adapter) != 0) {
>   					if (--pmlmepriv->to_roaming == 0 ||
>   					    _SUCCESS != rtw_sitesurvey_cmd(adapter, &pmlmepriv->assoc_ssid, 1, NULL, 0)) {
> @@ -1225,10 +1219,6 @@ void rtw_stadel_event_callback(struct adapter *adapter, u8 *pbuf)
>   	else
>   		mac_id = pstadel->mac_id;
>   
> -	netdev_dbg(adapter->pnetdev,
> -		   "(mac_id=%d)=%pM\n",
> -		   mac_id, pstadel->macaddr);
> -
>   	if (mac_id >= 0) {
>   		u16 media_status;
>   		media_status = (mac_id << 8) | 0; /*   MACID|OPMODE:0 means disconnect */
> @@ -1318,8 +1308,6 @@ void _rtw_join_timeout_handler (struct adapter *adapter)
>   	struct	mlme_priv *pmlmepriv = &adapter->mlmepriv;
>   	int do_join_r;
>   
> -	netdev_dbg(adapter->pnetdev, "fw_state=%x\n", get_fwstate(pmlmepriv));
> -
>   	if (adapter->bDriverStopped || adapter->bSurpriseRemoved)
>   		return;
>   
> @@ -1329,19 +1317,12 @@ void _rtw_join_timeout_handler (struct adapter *adapter)
>   		while (1) {
>   			pmlmepriv->to_roaming--;
>   			if (rtw_to_roaming(adapter) != 0) { /* try another */
> -				netdev_dbg(adapter->pnetdev,
> -					   "try another roaming\n");
>   				do_join_r = rtw_do_join(adapter);
>   				if (_SUCCESS != do_join_r) {
> -					netdev_dbg(adapter->pnetdev,
> -						   "roaming do_join return %d\n",
> -						   do_join_r);
>   					continue;
>   				}

And here. Ok, I won't point out to bracers anymore. I guess, you get me :)


>   				break;
>   			} else {
> -				netdev_dbg(adapter->pnetdev,
> -					   "We've tried roaming but failed\n");
>   				rtw_indicate_disconnect(adapter);
>   				break;
>   			}
> @@ -1362,7 +1343,6 @@ void rtw_scan_timeout_handler (struct adapter *adapter)
>   {
>   	struct	mlme_priv *pmlmepriv = &adapter->mlmepriv;
>   
> -	netdev_dbg(adapter->pnetdev, "fw_state=%x\n", get_fwstate(pmlmepriv));
>   	spin_lock_bh(&pmlmepriv->lock);
>   	_clr_fwstate_(pmlmepriv, _FW_UNDER_SURVEY);
>   	spin_unlock_bh(&pmlmepriv->lock);
> @@ -1467,15 +1447,6 @@ static int rtw_check_join_candidate(struct mlme_priv *pmlmepriv
>   		updated = true;
>   	}
>   	if (updated) {
> -		netdev_dbg(adapter->pnetdev,
> -			   "[by_bssid:%u][assoc_ssid:%s]new candidate: %s(%pM rssi:%d\n",
> -			   pmlmepriv->assoc_by_bssid,
> -			   pmlmepriv->assoc_ssid.Ssid,
> -			   (*candidate)->network.Ssid.Ssid,
> -			   (*candidate)->network.MacAddress,
> -			   (int)(*candidate)->network.Rssi);
> -		netdev_dbg(adapter->pnetdev,
> -			   "[to_roaming:%u]\n", rtw_to_roaming(adapter));
>   	}
>   

drop if

>   exit:
> @@ -1513,21 +1484,13 @@ int rtw_select_and_join_from_scanned_queue(struct mlme_priv *pmlmepriv)
>   		rtw_check_join_candidate(pmlmepriv, &candidate, pnetwork);
>   	}
>   	if (!candidate) {
> -		netdev_dbg(adapter->pnetdev,
> -			   "return _FAIL(candidate==NULL)\n");
>   		ret = _FAIL;
>   		goto exit;
>   	} else {
> -		netdev_dbg(adapter->pnetdev, "candidate: %s(%pM ch:%u)\n",
> -			   candidate->network.Ssid.Ssid, candidate->network.MacAddress,
> -			   candidate->network.Configuration.DSConfig);
>   	}
>   
>   	/*  check for situation of  _FW_LINKED */
>   	if (check_fwstate(pmlmepriv, _FW_LINKED)) {
> -		netdev_dbg(adapter->pnetdev,
> -			   "_FW_LINKED while ask_for_joinbss!!!\n");
> -
>   		rtw_disassoc_cmd(adapter, 0, true);
>   		rtw_indicate_disconnect(adapter);
>   		rtw_free_assoc_resources(adapter, 0);
> @@ -1537,9 +1500,6 @@ int rtw_select_and_join_from_scanned_queue(struct mlme_priv *pmlmepriv)
>   	if (supp_ant_div) {
>   		u8 cur_ant;
>   		GetHalDefVar8188EUsb(adapter, HAL_DEF_CURRENT_ANTENNA, &cur_ant);
> -		netdev_dbg(adapter->pnetdev, "Opt_Ant_(%s), cur_Ant(%s)\n",
> -			   (candidate->network.PhyInfo.Optimum_antenna == 2) ? "A" : "B",
> -			   (cur_ant == 2) ? "A" : "B");
>   	}
>   
>   	ret = rtw_joinbss_cmd(adapter, candidate);
> @@ -1611,10 +1571,6 @@ int rtw_set_key(struct adapter *adapter, struct security_priv *psecuritypriv, in
>   	psetkeyparm->keyid = (u8)keyid;/* 0~3 */
>   	psetkeyparm->set_tx = set_tx;
>   	pmlmepriv->key_mask |= BIT(psetkeyparm->keyid);
> -	netdev_dbg(adapter->pnetdev,
> -		   "algorithm(%x), keyid(%x), key_mask(%x)\n",
> -		   psetkeyparm->algorithm, psetkeyparm->keyid,
> -		   pmlmepriv->key_mask);
>   
>   	switch (psetkeyparm->algorithm) {
>   	case _WEP40_:
> @@ -2005,7 +1961,7 @@ void rtw_update_ht_cap(struct adapter *padapter, u8 *pie, uint ie_len)
>   	/*  Config SM Power Save setting */
>   	pmlmeinfo->SM_PS = (le16_to_cpu(pmlmeinfo->HT_caps.u.HT_cap_element.HT_caps_info) & 0x0C) >> 2;
>   	if (pmlmeinfo->SM_PS == WLAN_HT_CAP_SM_PS_STATIC)
> -		netdev_dbg(padapter->pnetdev, "WLAN_HT_CAP_SM_PS_STATIC\n");
> +		;
>   

Why?

>   	/*  Config current HT Protection mode. */
>   	pmlmeinfo->HT_protection = pmlmeinfo->HT_info.infos[1] & 0x3;
> @@ -2040,7 +1996,6 @@ void rtw_issue_addbareq_cmd(struct adapter *padapter, struct xmit_frame *pxmitfr
>   		issued |= (phtpriv->candidate_tid_bitmap >> priority) & 0x1;
>   
>   		if (0 == issued) {
> -			netdev_dbg(padapter->pnetdev, "p=%d\n", priority);
>   			psta->htpriv.candidate_tid_bitmap |= BIT((u8)priority);
>   			rtw_addbareq_cmd(padapter, (u8)priority, pattrib->ra);
>   		}
> @@ -2068,11 +2023,6 @@ void _rtw_roaming(struct adapter *padapter, struct wlan_network *tgt_network)
>   		pnetwork = &pmlmepriv->cur_network;
>   
>   	if (0 < rtw_to_roaming(padapter)) {
> -		netdev_dbg(padapter->pnetdev,
> -			   "roaming from %s(%pM length:%d\n",
> -			   pnetwork->network.Ssid.Ssid,
> -			   pnetwork->network.MacAddress,
> -			   pnetwork->network.Ssid.SsidLength);
>   		memcpy(&pmlmepriv->assoc_ssid, &pnetwork->network.Ssid, sizeof(struct ndis_802_11_ssid));
>   
>   		pmlmepriv->assoc_by_bssid = false;
> @@ -2082,16 +2032,11 @@ void _rtw_roaming(struct adapter *padapter, struct wlan_network *tgt_network)
>   			if (_SUCCESS == do_join_r) {
>   				break;
>   			} else {
> -				netdev_dbg(padapter->pnetdev,
> -					   "roaming do_join return %d\n",
> -					   do_join_r);
>   				pmlmepriv->to_roaming--;
>   
>   				if (0 < pmlmepriv->to_roaming) {
>   					continue;
>   				} else {
> -					netdev_dbg(padapter->pnetdev,
> -						   "-to roaming fail, indicate_disconnect\n");
>   					rtw_indicate_disconnect(padapter);
>   					break;
>   				}
> diff --git a/drivers/staging/r8188eu/core/rtw_security.c b/drivers/staging/r8188eu/core/rtw_security.c
> index 4e93c720c1b6..fdd2dbf65eb7 100644
> --- a/drivers/staging/r8188eu/core/rtw_security.c
> +++ b/drivers/staging/r8188eu/core/rtw_security.c
> @@ -545,8 +545,6 @@ u32 rtw_tkip_decrypt(struct adapter *padapter, struct recv_frame *precvframe)
>   			if (is_multicast_ether_addr(prxattrib->ra)) {
>   				if (!psecuritypriv->binstallGrpkey) {
>   					res = _FAIL;
> -					netdev_dbg(padapter->pnetdev,
> -						   "rx bc/mc packets, but didn't install group key!\n");
>   					goto exit;
>   				}
>   				prwskey = psecuritypriv->dot118021XGrpKey[prxattrib->key_index].skey;
> @@ -1330,10 +1328,6 @@ static int aes_decipher(struct adapter *padapter, u8 *key, uint hdrlen,
>   	/* compare the mic */
>   	for (i = 0; i < 8; i++) {
>   		if (pframe[hdrlen + 8 + plen - 8 + i] != message[hdrlen + 8 + plen - 8 + i]) {
> -			netdev_dbg(padapter->pnetdev,
> -				   "mic check error mic[%d]: pframe(%x)!=message(%x)\n",
> -				   i, pframe[hdrlen + 8 + plen - 8 + i],
> -				   message[hdrlen + 8 + plen - 8 + i]);
>   			res = _FAIL;
>   		}
>   	}
> @@ -1361,16 +1355,10 @@ u32 rtw_aes_decrypt(struct adapter *padapter, struct recv_frame *precvframe)
>   				/* in concurrent we should use sw descrypt in group key, so we remove this message */
>   				if (!psecuritypriv->binstallGrpkey) {
>   					res = _FAIL;
> -					netdev_dbg(padapter->pnetdev,
> -						   "rx bc/mc packets, but didn't install group key!\n");
>   					goto exit;
>   				}
>   				prwskey = psecuritypriv->dot118021XGrpKey[prxattrib->key_index].skey;
>   				if (psecuritypriv->dot118021XGrpKeyid != prxattrib->key_index) {
> -					netdev_dbg(padapter->pnetdev,
> -						   "not match packet_index=%d, install_index=%d\n",
> -						   prxattrib->key_index,
> -						   psecuritypriv->dot118021XGrpKeyid);
>   					res = _FAIL;
>   					goto exit;
>   				}
> diff --git a/drivers/staging/r8188eu/core/rtw_sta_mgt.c b/drivers/staging/r8188eu/core/rtw_sta_mgt.c
> index 79b49a13fe61..1fb9b6cc7eda 100644
> --- a/drivers/staging/r8188eu/core/rtw_sta_mgt.c
> +++ b/drivers/staging/r8188eu/core/rtw_sta_mgt.c
> @@ -104,7 +104,7 @@ inline int rtw_stainfo_offset(struct sta_priv *stapriv, struct sta_info *sta)
>   	int offset = (((u8 *)sta) - stapriv->pstainfo_buf) / sizeof(struct sta_info);
>   
>   	if (!stainfo_offset_valid(offset))
> -		pr_debug("invalid offset(%d), out of range!!!", offset);
> +		;
>   

Same "why?"

>   	return offset;
>   }
> @@ -112,7 +112,7 @@ inline int rtw_stainfo_offset(struct sta_priv *stapriv, struct sta_info *sta)
>   inline struct sta_info *rtw_get_stainfo_by_offset(struct sta_priv *stapriv, int offset)
>   {
>   	if (!stainfo_offset_valid(offset))
> -		pr_debug("invalid offset(%d), out of range!!!", offset);
> +		;
>   

Same "why?"


I might be missing something, but looks like you are following some rule 
by leaving empty branches. Can you, please, add explanations to commit 
message or remove them, since now it looks very odd




With regards,
Pavel Skripkin
