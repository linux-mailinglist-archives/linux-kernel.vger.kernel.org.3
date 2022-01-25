Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0C0D49AB54
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 05:49:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbiAYEtk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 23:49:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S250369AbiAYEQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 23:16:48 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48817C036BF1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 18:47:43 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id x11so54004178lfa.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 18:47:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=WSgw+Bai9akIbsNX8qE1iDGkZDqwpur2u3wwvUxZaos=;
        b=oh0ZGUYdJjwb/WULwnJIpti/MED7HLmMZVHOk9IKD0rr8P1tHXUBsy0GnBK6ZwnYIh
         tJCowFsUgGAVBBYLsw4BFJPAXHTlcoHxc6pkhKCwUUiyLK18hTNYa8EkrIiEUCK30f7+
         e9B86H6+E5jHBxNituWhdgYulf+E1Pmn2NoWGyUzDcZqU09ii/UfH4aWOc4QYjXOagRL
         nIKlAMTUw4RY6LRQmrof23eAD/aSAyNlQuygygGFJf+hwTpZPljRaWoVquCojr6YlrO8
         3vjCDFb1uGUKdCHRnXgGSUZMUGealQRlTR0nNvT522GnnVDptIvCHG88NDdprW0RNcVK
         mqbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=WSgw+Bai9akIbsNX8qE1iDGkZDqwpur2u3wwvUxZaos=;
        b=6pRuZhmm58hKb3cwaBUeKQ1xLFUM/aDwe68JC/txPmlUcbPbK8DcWDEbgKjzu+0DW1
         2FlBzWuZ5ANkf+qZTucMF4WTgSSLsZrO56dv5sogrgAbzoDamqSluppe88UzuJZle1jb
         noTwULXIkOcuotY+wPA4v4fnHsSv+s+uFVxNIB1tghzRpZ1QOD5BOA63kJAtUoy7a6wK
         +beEFCtIhq33PWsm3fO+ft0F/Y4XjWgSDPCkLT5kh/UrbfplIsTf9njsec2SzVDjz1e/
         kBQcrsajhSfxNACubMgC/9KcQlYyCKBliJHpGrd6M8gpNe18Dq1In1ZEcUbUxPRAVsL1
         xpAQ==
X-Gm-Message-State: AOAM530aHE89xumur1WEKFC3BSVPv1PgJfaDWvd4GVnQdM/JvUZ1E9pI
        2Kmz+Z7i+Y8xzqa6SW2N/QtrUtxEYXw6NQ==
X-Google-Smtp-Source: ABdhPJw/HdOl+VUK3mcD6a1INueBqbK59eArLJlh5fV2q6DjMOQxtjwEObG+XzPUSBGydBKpE5XwKw==
X-Received: by 2002:a19:640c:: with SMTP id y12mr5522574lfb.245.1643078861686;
        Mon, 24 Jan 2022 18:47:41 -0800 (PST)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id u1sm1065629lfc.98.2022.01.24.18.47.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jan 2022 18:47:40 -0800 (PST)
Message-ID: <4d9fa340-19fd-ee0f-0244-15ded5e66c67@linaro.org>
Date:   Tue, 25 Jan 2022 05:47:40 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] drm/msm/a6xx: Add missing suspend_count increment
Content-Language: en-GB
To:     Rob Clark <robdclark@gmail.com>, dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Rob Clark <robdclark@chromium.org>,
        Danylo Piliaiev <dpiliaiev@igalia.com>,
        Sean Paul <sean@poorly.run>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Jonathan Marek <jonathan@marek.ca>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Eric Anholt <eric@anholt.net>,
        Douglas Anderson <dianders@chromium.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20220113163215.215367-1-robdclark@gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20220113163215.215367-1-robdclark@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/01/2022 19:32, Rob Clark wrote:
> From: Rob Clark <robdclark@chromium.org>
> 
> Reported-by: Danylo Piliaiev <dpiliaiev@igalia.com>
> Fixes: 3ab1c5cc3939 ("drm/msm: Add param for userspace to query suspend count")
> Signed-off-by: Rob Clark <robdclark@chromium.org>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
>   drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> index 51b83776951b..17cfad6424db 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> @@ -1560,6 +1560,8 @@ static int a6xx_pm_suspend(struct msm_gpu *gpu)
>   		for (i = 0; i < gpu->nr_rings; i++)
>   			a6xx_gpu->shadow[i] = 0;
>   
> +	gpu->suspend_count++;
> +
>   	return 0;
>   }
>   


-- 
With best wishes
Dmitry
