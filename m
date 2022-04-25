Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ACA750EC0F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 00:28:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235875AbiDYWam (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 18:30:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232343AbiDYWac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 18:30:32 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88B9D139388
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 15:23:49 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id t25so28750836lfg.7
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 15:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=X6tPtyrOOLF1/p14xxSTVx958MJNQbxFMOc73dV5Mzo=;
        b=Ce7pCVUGiFJQSnItmyWywubtP/Tv45dyMCL1pPWfKJJsTdHrxgfCvX2KsBbiyFqZGS
         901m5YPZcONrcIef6sdmwhVrPW1kaCXD9G041SP5iPMSzE1RLDX+bASNocYr2CCvcDXs
         zB7zZVUHI8pwS/nHvMGZNa/UtCBMU90HFa3ZsXC8jEoLC+6kVzr7bukkiDi9clU5rCha
         8qOIrhFwfd6NpJUV3luIYezgZV1CPJFqxHRNEiyLpuRKNM5yFKbwPwikPsjqQI/LB11r
         /sXNjJZo08eJQNLd4RxJWAtWXTe3iq0fTXNDpIRvqPVrs2Cme9p0NXt8bwoXT1g50RuN
         QK4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=X6tPtyrOOLF1/p14xxSTVx958MJNQbxFMOc73dV5Mzo=;
        b=t7/L1gSpXxSLgarisyJeo7+PZlYd2tzrAZRm+Xg44naCSIcl6qYGE52SE3UcGUTZj0
         Agg5HRUi3TuJvxAdS3mIMnMUOc1tqi4Rx3wxE0YJSjoag55cjjWmNPZwEUf/ShpWPUCi
         /AUvOKmc0u4F99n6ozA5b17ewSW7gyQaT9TDS02isEYaXVW86qxJat38agPz4FocmHXb
         quMt/sdhMLBUZ/v48DPWvKO/F8IOHLXZhjlfWkBWu5wQj63srVsSX7WDxDlA7cC+v33K
         zRp87QXPxvzr2nUwpoL2BUQWN0tFtiPyMMcvM9xKvqgULcPp7TjQCVzHErqrEkSC0Kiq
         B99w==
X-Gm-Message-State: AOAM532IspSxgAd0Z4KuUL4uon5Oekoh8RzL+3nEuznYLlzA74pkTfdE
        s0rdHo3CoyQQITQjW59AnioG9A==
X-Google-Smtp-Source: ABdhPJzxHLoRrGJZ4lg39u4RC4KZZ7ipF64tibG2Qxu8QIwRay7SmyMbnhHFRx5OOlxuYAKETLeK2Q==
X-Received: by 2002:a05:6512:b1e:b0:44a:9b62:3201 with SMTP id w30-20020a0565120b1e00b0044a9b623201mr14974371lfu.42.1650925419622;
        Mon, 25 Apr 2022 15:23:39 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id z17-20020a05651c023100b0024f11b44e93sm453321ljn.102.2022.04.25.15.23.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Apr 2022 15:23:39 -0700 (PDT)
Message-ID: <d315bd2d-6f8d-592f-b24e-15ee34ca22d8@linaro.org>
Date:   Tue, 26 Apr 2022 01:23:38 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v2] drm: msm: fix error check return value of
 irq_of_parse_and_map()
Content-Language: en-GB
To:     cgel.zte@gmail.com
Cc:     airlied@linux.ie, angelogioacchino.delregno@collabora.com,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        lv.ruyi@zte.com.cn, quic_abhinavk@quicinc.com,
        quic_mkrishn@quicinc.com, sean@poorly.run, swboyd@chromium.org,
        vulab@iscas.ac.cn, Zeal Robot <zealci@zte.com.cn>
References: <39b3828e-064c-6aa4-de77-35b201b1b40f@linaro.org>
 <20220424031959.3172406-1-lv.ruyi@zte.com.cn>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20220424031959.3172406-1-lv.ruyi@zte.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/04/2022 06:19, cgel.zte@gmail.com wrote:
> From: Lv Ruyi <lv.ruyi@zte.com.cn>
> 
> The irq_of_parse_and_map() function returns 0 on failure, and does not
> return an negative value.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Lv Ruyi <lv.ruyi@zte.com.cn>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
> v2: don't print irq, and return ERR_PTR(-EINVAL)
> ---
>   drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c b/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c
> index 3b92372e7bdf..44e395e59df9 100644
> --- a/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c
> +++ b/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c
> @@ -570,9 +570,9 @@ struct msm_kms *mdp5_kms_init(struct drm_device *dev)
>   	}
>   
>   	irq = irq_of_parse_and_map(pdev->dev.of_node, 0);
> -	if (irq < 0) {
> -		ret = irq;
> -		DRM_DEV_ERROR(&pdev->dev, "failed to get irq: %d\n", ret);
> +	if (!irq) {
> +		ret = -EINVAL;
> +		DRM_DEV_ERROR(&pdev->dev, "failed to get irq\n");
>   		goto fail;
>   	}
>   


-- 
With best wishes
Dmitry
