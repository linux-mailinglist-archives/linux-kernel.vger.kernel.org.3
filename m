Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8F8649BB18
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 19:18:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbiAYSRx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 13:17:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbiAYSRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 13:17:51 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69270C06173B
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 10:17:50 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id y15so50118151lfa.9
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 10:17:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=dSrhbE6iArK7VijAEwS8NR5d4m9Smmxvwd2EDBXBHpo=;
        b=VUSOPfVzTzm4wRr/wB2VnqTi6Fj2OqDXU8+PHVeLlp3K+Pc/x1RY+fglCx7BhMBSa+
         PKTHsi4O1AL9e6WXXPWUT7+3SKRkeGq39KUQoXuE9dxFrNqnFz7nmw8odA2lYDnIQ5pl
         5cek0vjaRZh8ehbk3FUt/iIQEjnU0JdFR4+/+7pBueAAT9kU6lGiLYMGxhTVFL/h/Owt
         LpL8znqPwu2Wo2BH8xzJUL36k8ldSsODaxbq8Wtf00Hwsoh+muyJEtyC0E/xEaVjJSAO
         1mVk6Whr4D6GG6syoPyFB8BIjrJS6tWkVk2dixxxZZueeunZx7NiGiUJZoZTiPABF1f1
         L7dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=dSrhbE6iArK7VijAEwS8NR5d4m9Smmxvwd2EDBXBHpo=;
        b=KBZpmhbn2dPnMpyoxtjWjaNZAHtttpo11Hh4dkO7f1u0Udl54jSVJI90+rqMbR3OrS
         +EhCLT6fpSSqADQl2N4zTkX4iDlNcyu3ns/jbZ2vLNTOAoeDgzXbim1dDUDIteM0nZD1
         SQubJj6Chu2NjVgSw+B5HFkwCEZ9/4XvBzcu5m3IIiHJYmPLax/MhHlDJn2ti9/9jGNn
         b1D3hO4YqzblYqMhibQ7ufrj1khcL+5ZqxIx5R113h1zcwa1RzkuBF3Dc4r2BOE7QklM
         iIzb/xRjKPMgap67Od5f+P7MI0aq70bv9q5FjX34UAjPvEVmoK/cYJeSiGVXH3rtRSnc
         qNnA==
X-Gm-Message-State: AOAM530gAIaX9ba8E6q2FlJdp6lsNchPcSXQhkdTJp53D9arZjTwhRxa
        7BO9Irhpz20dQNfPahCRf/s=
X-Google-Smtp-Source: ABdhPJwsxaWTWmvC4LeG2DLDz32vnINItdR3fWQNB9i+auG2YZyF8jicYHresU/0MXauuZ64ffaZDA==
X-Received: by 2002:a05:6512:2386:: with SMTP id c6mr17510288lfv.684.1643134668514;
        Tue, 25 Jan 2022 10:17:48 -0800 (PST)
Received: from [192.168.1.11] ([94.103.227.208])
        by smtp.gmail.com with ESMTPSA id f22sm1560371lfj.261.2022.01.25.10.17.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jan 2022 10:17:47 -0800 (PST)
Message-ID: <47fcbfb5-ee59-a1ef-781d-83989e26e1aa@gmail.com>
Date:   Tue, 25 Jan 2022 21:17:46 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 02/10] staging: r8188eu: remove smaller sets of DBG_88E
 calls from core dir
Content-Language: en-US
To:     Phillip Potter <phil@philpotter.co.uk>, gregkh@linuxfoundation.org
Cc:     dan.carpenter@oracle.com, Larry.Finger@lwfinger.net,
        straube.linux@gmail.com, martin@kaiser.cx,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20220124224415.831-1-phil@philpotter.co.uk>
 <20220124224415.831-3-phil@philpotter.co.uk>
From:   Pavel Skripkin <paskripkin@gmail.com>
In-Reply-To: <20220124224415.831-3-phil@philpotter.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Phillip,

On 1/25/22 01:44, Phillip Potter wrote:
> Remove all DBG_88E calls from the core directory, other than those in
> core/rtw_mlme_ext.c, as this contains over 100 on its own so will be
> done in a separate patch for ease of review. These calls do not conform
> to kernel coding standards and are superfluous. Also restructure where
> appropriate to remove no longer needed code left behind by removal of
> these calls. This will allow the eventual removal of the DBG_88E macro
> itself.
> 
> Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
> ---

[code snip]

> diff --git a/drivers/staging/r8188eu/core/rtw_ieee80211.c b/drivers/staging/r8188eu/core/rtw_ieee80211.c
> index ad87954bdeb4..62354c3194bd 100644
> --- a/drivers/staging/r8188eu/core/rtw_ieee80211.c
> +++ b/drivers/staging/r8188eu/core/rtw_ieee80211.c
> @@ -653,13 +653,8 @@ static int rtw_ieee802_11_parse_vendor_specific(u8 *pos, uint elen,
>   	/* first 3 bytes in vendor specific information element are the IEEE
>   	 * OUI of the vendor. The following byte is used a vendor specific
>   	 * sub-type. */
> -	if (elen < 4) {
> -		if (show_errors) {
> -			DBG_88E("short vendor specific information element ignored (len=%lu)\n",
> -				(unsigned long)elen);
> -		}
> +	if (elen < 4)
>   		return -1;
> -	}

show_errors seems unused after this change

>   
>   	oui = RTW_GET_BE24(pos);
>   	switch (oui) {
> @@ -674,11 +669,8 @@ static int rtw_ieee802_11_parse_vendor_specific(u8 *pos, uint elen,
>   			elems->wpa_ie_len = elen;
>   			break;
>   		case WME_OUI_TYPE: /* this is a Wi-Fi WME info. element */
> -			if (elen < 5) {
> -				DBG_88E("short WME information element ignored (len=%lu)\n",
> -					(unsigned long)elen);
> +			if (elen < 5)
>   				return -1;
> -			}
>   			switch (pos[4]) {
>   			case WME_OUI_SUBTYPE_INFORMATION_ELEMENT:
>   			case WME_OUI_SUBTYPE_PARAMETER_ELEMENT:
> @@ -690,8 +682,6 @@ static int rtw_ieee802_11_parse_vendor_specific(u8 *pos, uint elen,
>   				elems->wme_tspec_len = elen;
>   				break;
>   			default:
> -				DBG_88E("unknown WME information element ignored (subtype=%d len=%lu)\n",
> -					pos[4], (unsigned long)elen);
>   				return -1;
>   			}
>   			break;
> @@ -701,8 +691,6 @@ static int rtw_ieee802_11_parse_vendor_specific(u8 *pos, uint elen,
>   			elems->wps_ie_len = elen;
>   			break;
>   		default:
> -			DBG_88E("Unknown Microsoft information element ignored (type=%d len=%lu)\n",
> -				pos[3], (unsigned long)elen);
>   			return -1;
>   		}
>   		break;
> @@ -714,14 +702,10 @@ static int rtw_ieee802_11_parse_vendor_specific(u8 *pos, uint elen,
>   			elems->vendor_ht_cap_len = elen;
>   			break;
>   		default:
> -			DBG_88E("Unknown Broadcom information element ignored (type=%d len=%lu)\n",
> -				pos[3], (unsigned long)elen);
>   			return -1;
>   		}
>   		break;
>   	default:
> -		DBG_88E("unknown vendor specific information element ignored (vendor OUI %02x:%02x:%02x len=%lu)\n",
> -			pos[0], pos[1], pos[2], (unsigned long)elen);
>   		return -1;
>   	}
>   	return 0;
> @@ -752,13 +736,8 @@ enum parse_res rtw_ieee802_11_parse_elems(u8 *start, uint len,
>   		elen = *pos++;
>   		left -= 2;
>   
> -		if (elen > left) {
> -			if (show_errors) {
> -				DBG_88E("IEEE 802.11 element parse failed (id=%d elen=%d left=%lu)\n",
> -					id, elen, (unsigned long)left);
> -			}

same here

> +		if (elen > left)
>   			return ParseFailed;
> -		}
>   
>   		switch (id) {
>   		case WLAN_EID_SSID:
> @@ -839,10 +818,6 @@ enum parse_res rtw_ieee802_11_parse_elems(u8 *start, uint len,
>   			break;
>   		default:
>   			unknown++;
> -			if (!show_errors)
> -				break;
> -			DBG_88E("IEEE 802.11 element parse ignored unknown element (id=%d elen=%d)\n",
> -				id, elen);
>   			break;

and here



With regards,
Pavel Skripkin
