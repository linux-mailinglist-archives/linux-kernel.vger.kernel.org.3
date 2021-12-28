Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36872480785
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 09:54:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235776AbhL1Iy2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 03:54:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbhL1IyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 03:54:25 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D571C061574
        for <linux-kernel@vger.kernel.org>; Tue, 28 Dec 2021 00:54:25 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id d9so37125823wrb.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Dec 2021 00:54:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=1riQ33VuP1lOukzFknUf7IQBsn9oya9GdKXWVwko1JE=;
        b=gHTMNl57mYB95VG0ky9WbFqungbhyTpau7UAiWhJbadHdDO1i8ZmIEEQ/1fCvmY+r0
         XDW4Nx1CIyLFuZj+Y7LZu2xwtZht+uf18lXUU8IqmwL1d1rWHiGdkMRzYh17hYhvoC/B
         940l/0Kt7Lk0WESVnhZaI6Wk73HoDCykFs4lohIRf/+aeUqYM90lRrf/KU50SO320uaG
         Fn2ADO3fRp84TEfIFP7BH7Kn0xq7MLhnrIwfCATERJbGdFaTItHwfdQNZE5XlnbVBS07
         FQCKx3NWBLPHhnNK56TMhBSqCO8vwk15b/opi97vtvMoK8aiIKtJkKjbgyu8iBCf0Xba
         VprA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=1riQ33VuP1lOukzFknUf7IQBsn9oya9GdKXWVwko1JE=;
        b=q/jSNlOinF8hsZIEwBXiComuJD8ETHBw9/a3LPjVHOMFYYDXBMvYGpXt5v/jyP1KEP
         8A7RsmSYnkVH2YcqJOFYarv9Fi23WwbtBC5E8L306RQakXJDF+DuejwAl7zD0f5b2yJZ
         4GZqD4gVUohqkIwt8jBBgENoZjwHZYDPEgF7PIBu6QKwDKgNQQ+Iqbxfc4743nl5grKe
         Ctb35/bynIZ9RZqKUdQeDaxFj1X/bozVqq3hUQQUIPLRcH7THv0i+IuL7QhI2wp5rOF4
         AQBkj49N8ipU6tHXZlseQJt6rutnh+gprbsGhvEwffV2WMUQnr0w6YpajhDSJn9o2nm2
         z9Bg==
X-Gm-Message-State: AOAM532O6RrfEy7g98kiySTHc2+B67nH+rO9eWp7eJ49QkFY7qRu2D0Y
        vCjUTGExP9Hp7e6Upq9Y8f4=
X-Google-Smtp-Source: ABdhPJyYFwbYRjIirFGtDG0LeJ8mvPvhssccRgAaSH9isQ4ABnp/VOcA2GdSiplW6hCfqGLl7g1XOg==
X-Received: by 2002:a5d:64ee:: with SMTP id g14mr15261766wri.52.1640681663909;
        Tue, 28 Dec 2021 00:54:23 -0800 (PST)
Received: from ?IPV6:2a02:8108:96c0:3b88::d7e8? ([2a02:8108:96c0:3b88::d7e8])
        by smtp.gmail.com with ESMTPSA id l26sm17126870wrz.44.2021.12.28.00.54.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Dec 2021 00:54:23 -0800 (PST)
Message-ID: <19a72e84-4962-8c10-0608-4081887312c2@gmail.com>
Date:   Tue, 28 Dec 2021 09:54:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH] staging: r8188eu: remove GET_CVID_ROM_VERSION
Content-Language: en-US
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20211226184217.9726-1-straube.linux@gmail.com>
From:   Michael Straube <straube.linux@gmail.com>
In-Reply-To: <20211226184217.9726-1-straube.linux@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/26/21 19:42, Michael Straube wrote:
> The macro GET_CVID_ROM_VERSION is not used. Remove it.
> 
> Signed-off-by: Michael Straube <straube.linux@gmail.com>
> ---
>   drivers/staging/r8188eu/include/HalVerDef.h | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/staging/r8188eu/include/HalVerDef.h b/drivers/staging/r8188eu/include/HalVerDef.h
> index 1d96657e6a98..62b94c993f0d 100644
> --- a/drivers/staging/r8188eu/include/HalVerDef.h
> +++ b/drivers/staging/r8188eu/include/HalVerDef.h
> @@ -35,7 +35,6 @@ struct HAL_VERSION {
>   #define GET_CVID_CHIP_TYPE(version)	(((version).ChipType))
>   #define GET_CVID_MANUFACTUER(version)	(((version).VendorType))
>   #define GET_CVID_CUT_VERSION(version)	(((version).CUTVersion))
> -#define GET_CVID_ROM_VERSION(version)	(((version).ROMVer) & ROM_VERSION_MASK)
>   
>   /* Common Macro. -- */
>   /* HAL_VERSION VersionID */

This patch is outdated, please drop it.
I'll resend it as part of a series.

Thanks,
Michael
