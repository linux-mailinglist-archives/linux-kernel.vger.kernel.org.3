Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B2DD48A167
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 22:05:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343774AbiAJVFO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 16:05:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239741AbiAJVFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 16:05:13 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E0A2C06173F
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 13:05:13 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id i31so48880563lfv.10
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 13:05:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=025bxASF2CibL4ZAmKr6nKes9ydIWvKpgd7RcSLnNtc=;
        b=Md9amwyb/sP8BbBBEWKIsgFjX9Ab0xQ0yCsIG2NvVJDeh2UQWumYTLDmzhI2PEjcrD
         jj+4qSOjs4pEYr1CaaeXDafY1DFDe8C/GFuSFIKnSYeMAn8GouZnAHEzPbh92YdGOiXo
         JfTIvhu/XWD5tDdK64+wzRwQB2lHvZfyEPx+d896pDZnsZ/K67tw375/CgEiBeWGnDF6
         29qe3UQbYPmwUZPE4ALtCogaKXxN53i31cCfns6lGy1EQVvyAx74YjXtBj3wzcv67I8Y
         krVHHh9YeXe+S2RhPm9eb2ZRbPpgwtguciA504aXE8+D1VMeRIYGB8J4LGLj1Pb9skdq
         M+WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=025bxASF2CibL4ZAmKr6nKes9ydIWvKpgd7RcSLnNtc=;
        b=Ly9HjbS1YZjnZTLkw2nGBIYbwsYD9Wo+zGeWYkvkVf+6kzH7qLGO6yNkhocQ0VKNX2
         a3ijVg0qSH/ijHayE06YzEUBVD0nyaOPFUEk5Krx7lI1OMgpj2QHt4zIbYp2tEbVMNQx
         3khn1/IDrM8EACNsH9snDo8HEnmbEOFqYh7Mr2ZzdLLawM/K4+4bD5ukE7WvRU0XUnlG
         53P+2+XwKlGGdP9NYHuiV+zeSxGCdesl4m58o60r7v3JueKfmWT5xwzlx10PLsTdSV+A
         48Hxxn2cDwvWZMtm+SmamD6cFikzz8nhgIsw61gI3uBnpBpaEslYlFwgyUn9q4WxObeJ
         58XA==
X-Gm-Message-State: AOAM5315V1B9K315XjDf6EIJymMXRm5zmGGo4exLYzdLsxjwtV+q0FlT
        TZ+g+bFbg2mVGhU6bntkryI=
X-Google-Smtp-Source: ABdhPJx8JtoqklxmHlLULDNO7P4CjKRSAEcq92jggHNFWSBnqGALKAwM6pGfuVz3JadrMONgWFwv1g==
X-Received: by 2002:a2e:8515:: with SMTP id j21mr863008lji.331.1641848711304;
        Mon, 10 Jan 2022 13:05:11 -0800 (PST)
Received: from [192.168.1.11] ([217.117.245.67])
        by smtp.gmail.com with ESMTPSA id x31sm1131949lfu.166.2022.01.10.13.05.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jan 2022 13:05:10 -0800 (PST)
Message-ID: <32d83cb4-ceff-a5c5-be62-a8fe99aac3de@gmail.com>
Date:   Tue, 11 Jan 2022 00:05:09 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v2 7/7] staging: r8188eu: convert DBG_88E calls in
 core/rtw_sta_mgt.c
Content-Language: en-US
To:     Phillip Potter <phil@philpotter.co.uk>, gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, straube.linux@gmail.com,
        martin@kaiser.cx, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20220110090020.6800-1-phil@philpotter.co.uk>
 <20220110090020.6800-8-phil@philpotter.co.uk>
From:   Pavel Skripkin <paskripkin@gmail.com>
In-Reply-To: <20220110090020.6800-8-phil@philpotter.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Phillip,

On 1/10/22 12:00, Phillip Potter wrote:
> Convert the DBG_88E macro calls in core/rtw_sta_mgt.c to use pr_debug,
> as their information may be useful to observers, and this gets the
> driver closer to the point of being able to remove DBG_88E itself.
> 
> These calls are at points in the call chain where use of dev_dbg or
> netdev_dbg isn't possible due to lack of device pointer, so plain
> pr_debug is appropriate here.
> 
> Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
> ---
>   drivers/staging/r8188eu/core/rtw_sta_mgt.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/core/rtw_sta_mgt.c b/drivers/staging/r8188eu/core/rtw_sta_mgt.c
> index 54561ff239a0..de5406a5870c 100644
> --- a/drivers/staging/r8188eu/core/rtw_sta_mgt.c
> +++ b/drivers/staging/r8188eu/core/rtw_sta_mgt.c
> @@ -104,7 +104,7 @@ inline int rtw_stainfo_offset(struct sta_priv *stapriv, struct sta_info *sta)
>   	int offset = (((u8 *)sta) - stapriv->pstainfo_buf) / sizeof(struct sta_info);
>   
>   	if (!stainfo_offset_valid(offset))
> -		DBG_88E("%s invalid offset(%d), out of range!!!", __func__, offset);
> +		pr_debug("invalid offset(%d), out of range!!!", offset);
>   
>   	return offset;
>   }

There is only one caller of this function and it also checks if offset 
is valid. I think, this check with debug message can be removed from 
this function.

> @@ -112,7 +112,7 @@ inline int rtw_stainfo_offset(struct sta_priv *stapriv, struct sta_info *sta)
>   inline struct sta_info *rtw_get_stainfo_by_offset(struct sta_priv *stapriv, int offset)
>   {
>   	if (!stainfo_offset_valid(offset))
> -		DBG_88E("%s invalid offset(%d), out of range!!!", __func__, offset);
> +		pr_debug("invalid offset(%d), out of range!!!", offset);
>   
>   	return (struct sta_info *)(stapriv->pstainfo_buf + offset * sizeof(struct sta_info));
>   }

Is it safe to proceed with invalid offset? Debug message says it's out 
of range, so might be we should just return with an error?




With regards,
Pavel Skripkin
