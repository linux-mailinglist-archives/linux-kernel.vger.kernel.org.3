Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A07CA515FD7
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 20:33:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244097AbiD3ShK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 14:37:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244079AbiD3ShI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 14:37:08 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C16346B15
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 11:33:46 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id n14so19125008lfu.13
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 11:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=AV6sbWrPg6V/b41EM5Ank+SmBTXdaOFBjgTZNzUyUgQ=;
        b=b6uDRXUhwKdVNAHjuXeRGJr1L8RJoJTUkc0FOKTL4j1+kGJNbWujysc9OYA9AlQT2O
         ceodXdjqUfKxyySwd58WMsf6GAcB2riotDaAWikKc7E46e80CEybqLvZK3jmzLMEXZjy
         1i+yI40myeaxY4nrzTdDFBh4459pbgPxdYP8s3wtRAOg+sj/RPaJILML4i+Q6H066T/W
         YoVBJXT80eNvz/zHSepbFBP/zhv+Ff3LrglVzHXGvhhmOo3WIfEeFzb9svwkgdIb8xvQ
         tSB7eBcYW/Ce9djCUAq1kKPoiNlnEOa5/0NvdxOMb90sr8Xbmczyu/xVK2DNrpLlyYIk
         GFrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=AV6sbWrPg6V/b41EM5Ank+SmBTXdaOFBjgTZNzUyUgQ=;
        b=ACmFXoT8sO8U4PFrNieWaVEfW63H/kQWZCMtDFMMH8O+0+O6AaIDpreALcGrapPODL
         hwimBXAzDbmKNSRQsWWUr2SJHjj9vBlGNiOeIwZWrVgZBk73cE94Kbz9imyU4+gSVck7
         AHp4GopkO6HKmbpY9BFSD7/v3xBH1x8AyhNrgzLHZIDziIjw9w28tRMKftOpvjbzPCCZ
         FcYRXpXHfIfsyXykT33b66etN6wEDT4vuxeUI8PLU76tbwW8WEc2GZLca94+1xOb0WAf
         lNy4TdWWyaa0A/P1h1q14PVBcGeL4rRZ+2VmO9tQ7WFAv/49eHNrHVfScfx1/20IXz5t
         7ESg==
X-Gm-Message-State: AOAM532ItVvRczPhm5dG36gvwThpEIRV7iZQHTCULcvWV/gosYOPi4G+
        1TybfI6SPqzPxj2ve0R8/gsCng==
X-Google-Smtp-Source: ABdhPJwJ5dKEwnh34HUKsP4FEsNgfA56bMSwplFlXMbVBq/CC01S0eEHH0kx6Pw3h4V0hF3lOrfw5g==
X-Received: by 2002:a05:6512:1516:b0:448:39b8:d603 with SMTP id bq22-20020a056512151600b0044839b8d603mr3662345lfb.599.1651343624430;
        Sat, 30 Apr 2022 11:33:44 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id e6-20020a05651c038600b0024f3d1dae88sm603515ljp.16.2022.04.30.11.33.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Apr 2022 11:33:44 -0700 (PDT)
Message-ID: <9b3891d6-4553-5757-e4b0-9900723267f7@linaro.org>
Date:   Sat, 30 Apr 2022 21:33:42 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 3/3] drm/msm/disp: dpu1: Properly sort qcm2290_dpu_caps
Content-Language: en-GB
To:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        ~postmarketos/upstreaming@lists.sr.ht
Cc:     martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Stephen Boyd <swboyd@chromium.org>,
        Robert Foss <robert.foss@linaro.org>,
        Kalyan Thota <quic_kalyant@quicinc.com>,
        Loic Poulain <loic.poulain@linaro.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20220430161529.605843-1-konrad.dybcio@somainline.org>
 <20220430161529.605843-3-konrad.dybcio@somainline.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20220430161529.605843-3-konrad.dybcio@somainline.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/04/2022 19:15, Konrad Dybcio wrote:
> Due to MSM8998 support having been stuck in review for so long,
> another struct was added nearby, which confused git and resulted
> in the definitions not being sorted alphabetically. Fix it.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
>   .../gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c    | 22 +++++++++----------
>   1 file changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
> index 0a217b5172bd..6e904d28824c 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
> @@ -254,6 +254,17 @@ static const struct dpu_caps msm8998_dpu_caps = {
>   	.max_vdeci_exp = MAX_VERT_DECIMATION,
>   };
>   
> +static const struct dpu_caps qcm2290_dpu_caps = {
> +	.max_mixer_width = DEFAULT_DPU_OUTPUT_LINE_WIDTH,
> +	.max_mixer_blendstages = 0x4,
> +	.smart_dma_rev = DPU_SSPP_SMART_DMA_V2,
> +	.ubwc_version = DPU_HW_UBWC_VER_20,
> +	.has_dim_layer = true,
> +	.has_idle_pc = true,
> +	.max_linewidth = 2160,
> +	.pixel_ram_size = DEFAULT_PIXEL_RAM_SIZE,
> +};
> +
>   static const struct dpu_caps sdm845_dpu_caps = {
>   	.max_mixer_width = DEFAULT_DPU_OUTPUT_LINE_WIDTH,
>   	.max_mixer_blendstages = 0xb,
> @@ -417,17 +428,6 @@ static const struct dpu_mdp_cfg msm8998_mdp[] = {
>   	},
>   };
>   
> -static const struct dpu_caps qcm2290_dpu_caps = {
> -	.max_mixer_width = DEFAULT_DPU_OUTPUT_LINE_WIDTH,
> -	.max_mixer_blendstages = 0x4,
> -	.smart_dma_rev = DPU_SSPP_SMART_DMA_V2,
> -	.ubwc_version = DPU_HW_UBWC_VER_20,
> -	.has_dim_layer = true,
> -	.has_idle_pc = true,
> -	.max_linewidth = 2160,
> -	.pixel_ram_size = DEFAULT_PIXEL_RAM_SIZE,
> -};
> -
>   static const struct dpu_mdp_cfg sdm845_mdp[] = {
>   	{
>   	.name = "top_0", .id = MDP_TOP,


-- 
With best wishes
Dmitry
