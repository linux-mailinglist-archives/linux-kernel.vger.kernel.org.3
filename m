Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E33304B0020
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 23:28:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235395AbiBIWZz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 17:25:55 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:53920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235384AbiBIWZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 17:25:39 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBE3BE00FA61
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 14:25:09 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id bx31so5531346ljb.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Feb 2022 14:25:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=hIcx7fgKf79oX3DQejLBFipd+nYlJybj4bCOUvRVfTk=;
        b=AlKhd6Y+1pFKRAL1Gs0aGJemkU9izAFnRZhqMlBaMSz8KC/XHIV+ftQIqR0T+2Pv0g
         iHaSekL2qjqYoQg48jXn6Li+zsiiNBgZOavlJPwPpmx7FS3as0roA3vYdVTGL+5Hl8p6
         0/yHjvl7FFo92P3shC64MLzA5PjgKri39OfSj5KVgWTvfUybQVEUd5eAk3A39OGl2/Up
         aTcL1aLw+i22DqH2LVq2zkGsp5X9y53Vebd/FxsxVz7DN29WnCQvXejtpuUrq9EAkqCy
         RhD5ZgxUos3uDuChqgQkq2qbYHRNGLF2F+h1QkMbhrFCdk5aYjTLTP1RWGhOf4+v54Zn
         oPcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=hIcx7fgKf79oX3DQejLBFipd+nYlJybj4bCOUvRVfTk=;
        b=3s2ryJ0R9lcs0+XJzOGWivqWe6iHKSt6E0NQXgBRZNFH2hxtu5Nw1qJ65P/GVfOd/e
         c9pM46s7FET7Jh8sKbWsW64RDiXihT6It7ncg9ZIpArNyd41PsNFYEHmvP5lMEFLEbgd
         2nQhY2DMSA43tHfIaZ+r8PFZYHbv8z4Ot4wQ0e2MpEvB4j94aPe4w7sAB67yKPUL23ih
         G1eq+73RcYd71E+BNge5IIUwH6DLMe6o8+LONNb+mpWsGuxuLzoFNQt/psA0YR1mHmf5
         P0Sohg2d2pFbIxjrzGeKDoGWQ7ZrUOD6IEsjyJv56YsL66b1nSZjr0cI17cnj3Ru/4Mg
         Ibtg==
X-Gm-Message-State: AOAM5306RsWcg20OlP9olwysPmmWd1JCrR7HQ+0eKncoOqkolKrTz4lt
        LxUjx+hhoRq1JH+ci79wXevsqA==
X-Google-Smtp-Source: ABdhPJwBNTpjejPUqQ20I3Mf4h67E5BFHnM2+lhr2w2BSwR1xW8oumn+pmF/vKAuybdKMNJNXLT2LA==
X-Received: by 2002:a05:651c:54d:: with SMTP id q13mr2950529ljp.352.1644445508012;
        Wed, 09 Feb 2022 14:25:08 -0800 (PST)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id bi16sm1131966lfb.309.2022.02.09.14.25.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Feb 2022 14:25:07 -0800 (PST)
Message-ID: <fa5f1cd9-d274-a5ed-18a2-eb16ffe82196@linaro.org>
Date:   Thu, 10 Feb 2022 01:25:06 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH] drm/msm/rd: Add chip-id
Content-Language: en-GB
To:     Rob Clark <robdclark@gmail.com>, dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Rob Clark <robdclark@chromium.org>,
        Sean Paul <sean@poorly.run>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        open list <linux-kernel@vger.kernel.org>
References: <20220114185742.283539-1-robdclark@gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20220114185742.283539-1-robdclark@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/01/2022 21:57, Rob Clark wrote:
> From: Rob Clark <robdclark@chromium.org>
> 
> For newer devices which deprecate gpu-id and do matching based on
> chip-id, we need this information in cmdstream dumps so that the
> decoding tools know how to decode them.
> 
> Signed-off-by: Rob Clark <robdclark@chromium.org>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
>   drivers/gpu/drm/msm/msm_rd.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/msm_rd.c b/drivers/gpu/drm/msm/msm_rd.c
> index 81432ec07012..7e4d6460719e 100644
> --- a/drivers/gpu/drm/msm/msm_rd.c
> +++ b/drivers/gpu/drm/msm/msm_rd.c
> @@ -62,6 +62,7 @@ enum rd_sect_type {
>   	RD_FRAG_SHADER,
>   	RD_BUFFER_CONTENTS,
>   	RD_GPU_ID,
> +	RD_CHIP_ID,
>   };
>   
>   #define BUF_SZ 512  /* should be power of 2 */
> @@ -202,6 +203,9 @@ static int rd_open(struct inode *inode, struct file *file)
>   
>   	rd_write_section(rd, RD_GPU_ID, &gpu_id, sizeof(gpu_id));
>   
> +	gpu->funcs->get_param(gpu, MSM_PARAM_CHIP_ID, &val);
> +	rd_write_section(rd, RD_CHIP_ID, &val, sizeof(val));
> +
>   out:
>   	mutex_unlock(&gpu->lock);
>   	return ret;


-- 
With best wishes
Dmitry
