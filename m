Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF08C4B1BC0
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 02:59:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347068AbiBKB6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 20:58:14 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347045AbiBKB6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 20:58:12 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40B59B44
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 17:58:12 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id bu29so8545334lfb.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 17:58:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=gamHH2XRTylhvnpesSgZb4MLgHOJXtNvgSBoVlaZkEI=;
        b=axTit6MZ8JevfejidD0uuSMhoc6TK0NFsQLJ0jrYJvdvFiGqCFO8wqcQiomHy1yhzh
         xTdbz8AvRF/U6lD92A0I2bWKuEKexGffBNam4Xsu8sh5OAlMVqgG0OY/YN9OjxYXJIra
         FYwOlLO8xVSyXZaYbLLN40HfOzX8/8L5nmZfKqsy+/2Q/aDxRNAgoGM1Vv8qdlRqp1VR
         IvhvnDGqBy6ytxSrGECCOX18B4KCVqLYEmh5o8zA10Ivj4xEA775Oyv4EQVfCEPn03Bf
         af5wDQcXoEI5STOF7rv1MF6gwZERigtsexXX2J2aOCFdHaKPktTsiD8S71NzmH9TgWym
         HYoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=gamHH2XRTylhvnpesSgZb4MLgHOJXtNvgSBoVlaZkEI=;
        b=V9RrLwP5+hRqXSWYgI17+hr1/uVhPdsQxHMxSQzDDn8/2DhPF5MFAvS2qYCglsOhSw
         VgQMzFAlsCkIWRCT3ZmUnVR5r2bfUw8Z0Px4r+ccqK+DL0jSfsX0/k/d0CiTFu0eC8Bm
         I1G3ulu6/jf+zQlXO+bi2O4XoKczB2ZXpfMGTZVY6LuzYZ1lqmF6wNCFRFS7CZX9lr6r
         FbWGU5AUTdWai5AtrkU+k/ETWaRybweaq/NwC5NLyzxNHHVAIP4DxfRjxJg9OvLlipS1
         gKe9jyfraJTy/8wQboFMAHscSoz0hlecjAvM8X7/zu2SRyf5p4jjQdnLOScMAEu6Ff9L
         Pa2g==
X-Gm-Message-State: AOAM532jtUfIm2sexYxQMZVVp+Lkp9CCVGXF4qIzxCfqZWWHtRN8PVog
        +FlAbrVyrijpmUa3vUuwdpSixg==
X-Google-Smtp-Source: ABdhPJyNVF6EHpX/FJ4wtTo5mfa3zXeG+RA9WaRc4cptEen5cejv2SgQ4zqhUXKN8rip2gX3CTeGqw==
X-Received: by 2002:a05:6512:158a:: with SMTP id bp10mr6949684lfb.407.1644544690570;
        Thu, 10 Feb 2022 17:58:10 -0800 (PST)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id bt2sm1206999lfb.93.2022.02.10.17.58.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Feb 2022 17:58:10 -0800 (PST)
Message-ID: <16278118-e33b-44f6-e815-fdcab44641bd@linaro.org>
Date:   Fri, 11 Feb 2022 04:58:09 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH 1/3] drm/msm/dpu: Remove set but unused variables
Content-Language: en-GB
To:     Vinod Koul <vkoul@kernel.org>, Rob Clark <robdclark@gmail.com>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sean Paul <sean@poorly.run>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Stephen Boyd <swboyd@chromium.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Kalyan Thota <quic_kalyant@quicinc.com>,
        Mark Yacoub <markyacoub@google.com>,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20220210114106.290669-1-vkoul@kernel.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20220210114106.290669-1-vkoul@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/02/2022 14:41, Vinod Koul wrote:
> We get warning:
> 
> In function ‘dpu_encoder_virt_enable’: drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c:1145:33:
> warning: variable ‘priv’ set but not used [-Wunused-but-set-variable]
>   1145 |         struct msm_drm_private *priv;
> 
> In function ‘dpu_encoder_virt_disable’: drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c:1182:33:
> warning: variable ‘priv’ set but not used [-Wunused-but-set-variable]
>   1182 |         struct msm_drm_private *priv;
> 
> Remove these unused but set variables
> 
> Signed-off-by: Vinod Koul <vkoul@kernel.org>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
>   drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 5 -----
>   1 file changed, 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> index 1e648db439f9..132844801e92 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> @@ -1142,14 +1142,12 @@ static void dpu_encoder_virt_enable(struct drm_encoder *drm_enc)
>   {
>   	struct dpu_encoder_virt *dpu_enc = NULL;
>   	int ret = 0;
> -	struct msm_drm_private *priv;
>   	struct drm_display_mode *cur_mode = NULL;
>   
>   	dpu_enc = to_dpu_encoder_virt(drm_enc);
>   
>   	mutex_lock(&dpu_enc->enc_lock);
>   	cur_mode = &dpu_enc->base.crtc->state->adjusted_mode;
> -	priv = drm_enc->dev->dev_private;
>   
>   	trace_dpu_enc_enable(DRMID(drm_enc), cur_mode->hdisplay,
>   			     cur_mode->vdisplay);
> @@ -1179,7 +1177,6 @@ static void dpu_encoder_virt_enable(struct drm_encoder *drm_enc)
>   static void dpu_encoder_virt_disable(struct drm_encoder *drm_enc)
>   {
>   	struct dpu_encoder_virt *dpu_enc = NULL;
> -	struct msm_drm_private *priv;
>   	int i = 0;
>   
>   	dpu_enc = to_dpu_encoder_virt(drm_enc);
> @@ -1188,8 +1185,6 @@ static void dpu_encoder_virt_disable(struct drm_encoder *drm_enc)
>   	mutex_lock(&dpu_enc->enc_lock);
>   	dpu_enc->enabled = false;
>   
> -	priv = drm_enc->dev->dev_private;
> -
>   	trace_dpu_enc_disable(DRMID(drm_enc));
>   
>   	/* wait for idle */


-- 
With best wishes
Dmitry
