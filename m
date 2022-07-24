Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5799C57F687
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 20:39:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232823AbiGXSjt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 14:39:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbiGXSjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 14:39:46 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB6561183F
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 11:39:44 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id ez10so16733291ejc.13
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 11:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=OQsrTiFtmM0uSWNmt7XCenRWHq96JyN2I/srXLwZrZc=;
        b=epjbefEEH9conl0ZtNvjBrTrFCPf7WUscBELpa1SzV6n/LmZw8D+HQDIA6VNCm2vQ6
         Hjs8M0GpGbRtHTR+nEPpYmT9yFKC6WGgK1y/C1gtyaFvJ9s4y5xKoOp11Ti9nS/kOzsU
         DFEhwFFpNSFJHRtsWAaqHr8wQWPj5Wgd7I9w0+aoyALIfRCZHMKtqCOQr0RVODn3mtLC
         BEO38ig6Psv9TQVpRgvcHgkhDXKbDsnl9TjqdY4SZnjybxsd8xueand72OSMC8rmPIYL
         B3d35jlWCumoj9mu4txgkiSWfDsz4Z7eD7SpEKr9d463wrBxdUTcZ+nMPOKs8mlaX+j5
         H1vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=OQsrTiFtmM0uSWNmt7XCenRWHq96JyN2I/srXLwZrZc=;
        b=zmQXz0DtQmoWQ3KTeT0Sb2iFfyuRSlvTwUXBl6VCMTS0yDxsJQ5ZEWnNHbnljuMqB6
         fA7/kZppPQD4EcZf6zwDUHJCyxaz88WCfOkoUEzq1JblR7UqWgK5oZlE/v4QI9WCBcbq
         WWB7BAkMYkjFpAAZJbtMvJ9xh27SDZ0L/KEdV+0xoIwEwgFEkbZ0RY/fxFaGBEaiKUSV
         JabGala6Oj8q3yP4CDX1C95g58ElXctZk7Xt3lyStFmt0+u0CjobqBZsWOVg4/3Jy40v
         CB/ZtOOERL7qfIpAZaYd50nypWcIrRi1UYM1UQYRBFFoPR4IWQMJOI1DjmT5btGQynO5
         UfDw==
X-Gm-Message-State: AJIora/kwlEIvvphYJcGJ0ielbcipKnhYmO4LnjDvfVMFfQU3gbxCB8U
        jiKrRWHLLgr3t9LOvJAP0XI=
X-Google-Smtp-Source: AGRyM1s4dIIVtdgEWgMlx0p2Kq32Ct0gwA/d/9+VOomdiVYEZfjpqA4B6Le1G6HKyP6sM+GF1Bn8VQ==
X-Received: by 2002:a17:907:760f:b0:72b:7eb4:be52 with SMTP id jx15-20020a170907760f00b0072b7eb4be52mr7263494ejc.737.1658687983285;
        Sun, 24 Jul 2022 11:39:43 -0700 (PDT)
Received: from [192.168.1.100] (p54a07b82.dip0.t-ipconnect.de. [84.160.123.130])
        by smtp.gmail.com with ESMTPSA id i4-20020a1709063c4400b0072abb95c9f4sm4461021ejg.193.2022.07.24.11.39.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Jul 2022 11:39:43 -0700 (PDT)
Message-ID: <f668b918-84d3-eaba-dfb7-d7b32240ffaf@gmail.com>
Date:   Sun, 24 Jul 2022 20:39:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] staging: r8188eu: convert rtw_pwr_wakeup to correct error
 code semantics
Content-Language: en-US
To:     Phillip Potter <phil@philpotter.co.uk>, gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, paskripkin@gmail.com,
        straube.linux@gmail.com, martin@kaiser.cx, abdun.nihaal@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20220724163055.961-1-phil@philpotter.co.uk>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20220724163055.961-1-phil@philpotter.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/24/22 18:30, Phillip Potter wrote:
> Convert the rtw_pwr_wakeup function to use 0 on success and -EPERM on
> error - in all places where we handle this response, we use either -1 or
> -EPERM currently anyway, which are equivalent. Also, for other places
> along the same call chain where we are using -1, use -EPERM.
> 
> This gets the driver closer to removal of the non-standard _SUCCESS and
> _FAIL definitions, which are inverted compared to the standard in-kernel
> error code mechanism.
> 
> Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
> ---
>   drivers/staging/r8188eu/core/rtw_p2p.c       |  4 +--
>   drivers/staging/r8188eu/core/rtw_pwrctrl.c   | 10 +++---
>   drivers/staging/r8188eu/os_dep/ioctl_linux.c | 32 ++++++++++----------
>   3 files changed, 23 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/core/rtw_p2p.c b/drivers/staging/r8188eu/core/rtw_p2p.c
> index c306aafa183b..bd654d4ff8b4 100644
> --- a/drivers/staging/r8188eu/core/rtw_p2p.c
> +++ b/drivers/staging/r8188eu/core/rtw_p2p.c
> @@ -1888,7 +1888,7 @@ int rtw_p2p_enable(struct adapter *padapter, enum P2P_ROLE role)
>   
>   	if (role == P2P_ROLE_DEVICE || role == P2P_ROLE_CLIENT || role == P2P_ROLE_GO) {
>   		/* leave IPS/Autosuspend */
> -		if (rtw_pwr_wakeup(padapter) == _FAIL) {
> +		if (rtw_pwr_wakeup(padapter)) {
>   			ret = _FAIL;
>   			goto exit;
>   		}
> @@ -1902,7 +1902,7 @@ int rtw_p2p_enable(struct adapter *padapter, enum P2P_ROLE role)
>   		init_wifidirect_info(padapter, role);
>   
>   	} else if (role == P2P_ROLE_DISABLE) {
> -		if (rtw_pwr_wakeup(padapter) == _FAIL) {
> +		if (rtw_pwr_wakeup(padapter)) {
>   			ret = _FAIL;
>   			goto exit;
>   		}
> diff --git a/drivers/staging/r8188eu/core/rtw_pwrctrl.c b/drivers/staging/r8188eu/core/rtw_pwrctrl.c
> index cf9020a73933..1cef3ef4d5f1 100644
> --- a/drivers/staging/r8188eu/core/rtw_pwrctrl.c
> +++ b/drivers/staging/r8188eu/core/rtw_pwrctrl.c
> @@ -381,24 +381,24 @@ int rtw_pwr_wakeup(struct adapter *padapter)
>   	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
>   	unsigned long timeout = jiffies + msecs_to_jiffies(3000);
>   	unsigned long deny_time;
> -	int ret = _SUCCESS;
> +	int ret = 0;
>   
>   	while (pwrpriv->ps_processing && time_before(jiffies, timeout))
>   		msleep(10);
>   
>   	/* I think this should be check in IPS, LPS, autosuspend functions... */
>   	if (check_fwstate(pmlmepriv, _FW_LINKED)) {
> -		ret = _SUCCESS;
> +		ret = 0;
>   		goto exit;
>   	}
>   
>   	if (pwrpriv->rf_pwrstate == rf_off && ips_leave(padapter) == _FAIL) {
> -		ret = _FAIL;
> +		ret = -EPERM;
>   		goto exit;
>   	}
>   
>   	if (padapter->bDriverStopped || !padapter->bup || !padapter->hw_init_completed) {
> -		ret = _FAIL;
> +		ret = -EPERM;
>   		goto exit;
>   	}
>   
> @@ -439,7 +439,7 @@ int rtw_pm_set_ips(struct adapter *padapter, u8 mode)
>   		return 0;
>   	} else if (mode == IPS_NONE) {
>   		rtw_ips_mode_req(pwrctrlpriv, mode);
> -		if ((padapter->bSurpriseRemoved == 0) && (rtw_pwr_wakeup(padapter) == _FAIL))
> +		if ((padapter->bSurpriseRemoved == 0) && rtw_pwr_wakeup(padapter))
>   			return -EFAULT;
>   	} else {
>   		return -EINVAL;
> diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
> index 930bb4aea435..e0ae0c3c51f8 100644
> --- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
> +++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
> @@ -689,7 +689,7 @@ static int rtw_wx_set_mode(struct net_device *dev, struct iw_request_info *a,
>   
>   
>   
> -	if (_FAIL == rtw_pwr_wakeup(padapter)) {
> +	if (rtw_pwr_wakeup(padapter)) {
>   		ret = -EPERM;
>   		goto exit;
>   	}
> @@ -933,13 +933,13 @@ static int rtw_wx_set_wap(struct net_device *dev,
>   
>   
>   
> -	if (_FAIL == rtw_pwr_wakeup(padapter)) {
> -		ret = -1;
> +	if (rtw_pwr_wakeup(padapter)) {
> +		ret = -EPERM;
>   		goto exit;
>   	}
>   
>   	if (!padapter->bup) {
> -		ret = -1;
> +		ret = -EPERM;
>   		goto exit;
>   	}
>   
> @@ -1049,23 +1049,23 @@ static int rtw_wx_set_scan(struct net_device *dev, struct iw_request_info *a,
>   	struct ndis_802_11_ssid ssid[RTW_SSID_SCAN_AMOUNT];
>   	struct wifidirect_info *pwdinfo = &padapter->wdinfo;
>   
> -	if (_FAIL == rtw_pwr_wakeup(padapter)) {
> -		ret = -1;
> +	if (rtw_pwr_wakeup(padapter)) {
> +		ret = -EPERM;
>   		goto exit;
>   	}
>   
>   	if (padapter->bDriverStopped) {
> -		ret = -1;
> +		ret = -EPERM;
>   		goto exit;
>   	}
>   
>   	if (!padapter->bup) {
> -		ret = -1;
> +		ret = -EPERM;
>   		goto exit;
>   	}
>   
>   	if (!padapter->hw_init_completed) {
> -		ret = -1;
> +		ret = -EPERM;
>   		goto exit;
>   	}
>   
> @@ -1164,7 +1164,7 @@ static int rtw_wx_set_scan(struct net_device *dev, struct iw_request_info *a,
>   	}
>   
>   	if (!_status)
> -		ret = -1;
> +		ret = -EPERM;
>   
>   exit:
>   
> @@ -1252,13 +1252,13 @@ static int rtw_wx_set_essid(struct net_device *dev,
>   
>   	uint ret = 0, len;
>   
> -	if (_FAIL == rtw_pwr_wakeup(padapter)) {
> -		ret = -1;
> +	if (rtw_pwr_wakeup(padapter)) {
> +		ret = -EPERM;
>   		goto exit;
>   	}
>   
>   	if (!padapter->bup) {
> -		ret = -1;
> +		ret = -EPERM;
>   		goto exit;
>   	}
>   
> @@ -1268,7 +1268,7 @@ static int rtw_wx_set_essid(struct net_device *dev,
>   	}
>   
>   	if (check_fwstate(pmlmepriv, WIFI_AP_STATE)) {
> -		ret = -1;
> +		ret = -EPERM;
>   		goto exit;
>   	}
>   
> @@ -1301,7 +1301,7 @@ static int rtw_wx_set_essid(struct net_device *dev,
>   				}
>   
>   				if (!rtw_set_802_11_infrastructure_mode(padapter, pnetwork->network.InfrastructureMode)) {
> -					ret = -1;
> +					ret = -EPERM;
>   					spin_unlock_bh(&queue->lock);
>   					goto exit;
>   				}
> @@ -1312,7 +1312,7 @@ static int rtw_wx_set_essid(struct net_device *dev,
>   		spin_unlock_bh(&queue->lock);
>   		rtw_set_802_11_authentication_mode(padapter, authmode);
>   		if (!rtw_set_802_11_ssid(padapter, &ndis_ssid)) {
> -			ret = -1;
> +			ret = -EPERM;
>   			goto exit;
>   		}
>   	}

Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com> # Edimax N150
