Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C73B64FFBC2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 18:51:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236974AbiDMQyJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 12:54:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbiDMQyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 12:54:07 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C22F5657A5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 09:51:45 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-df02f7e2c9so2583163fac.10
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 09:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=TJdp16GZ/mcVK+wOid+S8lTMX4JVLRpFOyG7YWpiyYk=;
        b=G74mrMtKZfCmaT1K+/+e13WLFdFCdrMRv45WXSrhliiMa8PHskOM9VU7bWEmqvOQ9B
         tzJY6EAA/xD441QAMm/pGepeNCbLWpi/J6XJmG4DTPo4eb+RqGbedKNM43UbCYM5NmFT
         hW8JsYuf5MwaUthhEpC5n+ZOEnxWOfCAtBcUKR2yM+BgIew4z4VN3MrDm6ktIn0iJKwl
         WH5PLzR7QvbeR+SZ96AvGkIoe7YZ/6UaxzEZcFA32ICU33HXv7HQn/aGaXSAA7nu9Rf/
         Zks0k9+MtTc8UzlgsZmbVvzXANuffjSguGJYms65m/8Krd5VVQ0xv0BfsfH64JAUczo2
         PdLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=TJdp16GZ/mcVK+wOid+S8lTMX4JVLRpFOyG7YWpiyYk=;
        b=2arIsFDEMEXEPuElNI1a5hvjD8v4JVM39M1qqDyXpc3spUX+Nrdqr2+sW+/9C1nRTT
         KtnCfyf3r/k67tHLXMz4ZTMJizQ/QLKD8qT/pIYB2OWixk3CG8Vy0LQ+hknfXavPO1yf
         o9UKp7fdQg6EtL3XkTSZyLcwhcXEDSOmAzMrgOzcuskCBWe8VW0rN4OIKBuFv/aI6JHW
         PFTItlFwzFmW7yp7S8v867xRIGuEHwu2efB+6k9M20nKB/ZxVKerV4t8dBIcGwqpAOfA
         zO0hoZelL1Nd6P+fDDydR7rLe5Ew/UGe+0LJbDqbUfyJj+Puynh5EkhDRG5zv1IhVE8v
         omLg==
X-Gm-Message-State: AOAM533kBKtSCOHTFzM685AK5SW+uBniKRTLvEm+6QrC+7kq4F/PtYyO
        bHjsXEk6jpVILysD+ZGKVBc=
X-Google-Smtp-Source: ABdhPJz5PgZuXwBkZsDDDJNbjq8qvznCj5Vd1r0MW6KqKiLNj8E6HeQiD2e5gSwDQE1ZN4nnen6rmg==
X-Received: by 2002:a05:6870:9122:b0:e2:c5d0:c3b2 with SMTP id o34-20020a056870912200b000e2c5d0c3b2mr4561249oae.246.1649868704142;
        Wed, 13 Apr 2022 09:51:44 -0700 (PDT)
Received: from ?IPV6:2603:8090:2005:39b3::100e? (2603-8090-2005-39b3-0000-0000-0000-100e.res6.spectrum.com. [2603:8090:2005:39b3::100e])
        by smtp.gmail.com with ESMTPSA id y4-20020aca4b04000000b002fa75582a34sm544087oia.36.2022.04.13.09.51.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Apr 2022 09:51:43 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <20226182-81b2-92b9-d286-d9520a1d568b@lwfinger.net>
Date:   Wed, 13 Apr 2022 11:51:41 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] staging: r8188eu: remove else after return and break
 statements
Content-Language: en-US
To:     Mahak Gupta <mahak_g@cs.iitr.ac.in>, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, outreachy@lists.linux.dev
References: <20220413052759.4859-1-mahak_g@cs.iitr.ac.in>
From:   Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <20220413052759.4859-1-mahak_g@cs.iitr.ac.in>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/13/22 00:27, Mahak Gupta wrote:
> Else is not necessary after return and break statements, hence remove
> it.
> 
> Reported by checkpatch:
> 
> WARNING: else is not generally useful after a break or return
> 
> Signed-off-by: Mahak Gupta <mahak_g@cs.iitr.ac.in>

The commit message is redundant. I would suggest the following:

checkpatch reports the following:

WARNING: else is not generally useful after a break or return

Remove those cases.


> ---
>   drivers/staging/r8188eu/core/rtw_ieee80211.c | 41 ++++++++------------
>   1 file changed, 17 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/core/rtw_ieee80211.c b/drivers/staging/r8188eu/core/rtw_ieee80211.c
> index 5a0e42ed4a47..bb4c9bc864da 100644
> --- a/drivers/staging/r8188eu/core/rtw_ieee80211.c
> +++ b/drivers/staging/r8188eu/core/rtw_ieee80211.c
> @@ -97,16 +97,15 @@ bool	rtw_is_cckratesonly_included(u8 *rate)
>   
>   int rtw_check_network_type(unsigned char *rate, int ratelen, int channel)
>   {
> -	if (channel > 14) {
> +	if (channel > 14)
>   		return WIRELESS_INVALID;
> -	} else {  /*  could be pure B, pure G, or B/G */
> -		if (rtw_is_cckratesonly_included(rate))
> -			return WIRELESS_11B;
> -		else if (rtw_is_cckrates_included(rate))
> -			return	WIRELESS_11BG;
> -		else
> -			return WIRELESS_11G;
> -	}
> +	/*  could be pure B, pure G, or B/G */
> +	if (rtw_is_cckratesonly_included(rate))
> +		return WIRELESS_11B;
> +	else if (rtw_is_cckrates_included(rate))
> +		return	WIRELESS_11BG;
> +	else
> +		return WIRELESS_11G;

Is this 'else' necessary?


Larry
