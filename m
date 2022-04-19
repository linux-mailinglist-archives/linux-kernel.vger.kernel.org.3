Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 136E850725C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 17:58:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354150AbiDSP75 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 11:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354145AbiDSP7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 11:59:55 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81EEC24098
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 08:57:12 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id o2so30128195lfu.13
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 08:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=aBBlrcuINY/huqI+pmNpt7ezjRhcp+EsZeDz0RlBbYA=;
        b=oYSRwbUAXncHSazO9/um5GURByFyEv/d1wSyWc52WIGTl0Dn2fBv7EVe8HLgBQaop2
         q6XNg7gZCRjdwhctLljfU9EYI4JWF+aT2nXZ7JUtsuoqr1ldsayYtbNq56JtkDP+uHhs
         EVISorbf2Qb+HvhQlrkODKLDY9lirkhtgzJ/Xp9UwuUAGHYsX3P8i3LoMKg1jBinFkGc
         8HpiDB+f+HYE+kRpEVCBQ5xYc8vGQWEVWZ3OwLaKUsKNSxOqcOQU93sfMiGB5Tj652i/
         OfdAjRhzNoYxolGuewaXMjdRf8rgOo8zH/3YFgHzOnlP6v0Sq3248bwvXIKypJcU/bSv
         YUOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=aBBlrcuINY/huqI+pmNpt7ezjRhcp+EsZeDz0RlBbYA=;
        b=RxfopWMzRBA2O9yD6nNf62pVoWl5gS+sOtNU0BBPMrEstlHNs5u6kUwMUXXETrcXZ8
         uaR4518QiPw6Foa3VJdGl16Ik2z3piRkTYuhSWAQSNUEMUptv2DAfhQ2mVCnQbTMv6+i
         f7q4gZRvO4XKnEN8BOFOh+7pQePrtLEUHm9sODekPz+p8mDgIdXQMdvzo16KbKxdyjay
         TSXN+tOFtJKRl9637E2kzQZoFhNdG+uECSlG+/fYBnRcUHCt4k7acpb18Emh25HMu7Dq
         p5Ju61Kj/lC3Zl/n0VJfc6Fi/Q86XKsKmGMfctkvEOfbISjSYltTCu3WXnIXwpWQc1+/
         DhLA==
X-Gm-Message-State: AOAM533WSyYDMre64VxB4lBozUDPsubXxjyS25Dm0pPTlqDj8zvUOx7B
        a0oj0bR6t38SHqNZQzrjrOA0uw==
X-Google-Smtp-Source: ABdhPJxIyRpDkdE3DsvHCugAEECr9Cihw3eu2sWWZa6oOoYWQV5BWYcP0qZa3q08lMbeYZwFMdbP3Q==
X-Received: by 2002:ac2:4306:0:b0:46b:c41c:1478 with SMTP id l6-20020ac24306000000b0046bc41c1478mr11760488lfh.559.1650383830827;
        Tue, 19 Apr 2022 08:57:10 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id f20-20020a056512229400b0044a6ac1af69sm1546934lfu.181.2022.04.19.08.57.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Apr 2022 08:57:10 -0700 (PDT)
Message-ID: <aadad18c-5a55-ae30-6158-f6c584c59fae@linaro.org>
Date:   Tue, 19 Apr 2022 18:57:09 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] drm/msm/mdp5: Eliminate useless code
Content-Language: en-GB
To:     Haowen Bai <baihaowen@meizu.com>, Rob Clark <robdclark@gmail.com>,
        Sean Paul <sean@poorly.run>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <1650348980-19050-1-git-send-email-baihaowen@meizu.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <1650348980-19050-1-git-send-email-baihaowen@meizu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/04/2022 09:16, Haowen Bai wrote:
> Since mdp5_state is initialized twice at the same time, so
> we make code simple and easy to understand by delete one.
> 
> Signed-off-by: Haowen Bai <baihaowen@meizu.com>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
>   drivers/gpu/drm/msm/disp/mdp5/mdp5_plane.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/mdp5/mdp5_plane.c b/drivers/gpu/drm/msm/disp/mdp5/mdp5_plane.c
> index 428f88b786f9..406c34e9f3f8 100644
> --- a/drivers/gpu/drm/msm/disp/mdp5/mdp5_plane.c
> +++ b/drivers/gpu/drm/msm/disp/mdp5/mdp5_plane.c
> @@ -386,8 +386,6 @@ static int mdp5_plane_atomic_async_check(struct drm_plane *plane,
>   	if (!crtc_state->active)
>   		return -EINVAL;
>   
> -	mdp5_state = to_mdp5_plane_state(new_plane_state);
> -
>   	/* don't use fast path if we don't have a hwpipe allocated yet */
>   	if (!mdp5_state->hwpipe)
>   		return -EINVAL;


-- 
With best wishes
Dmitry
