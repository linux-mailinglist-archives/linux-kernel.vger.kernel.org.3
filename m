Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BECB494330
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 23:43:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343956AbiASWm6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 17:42:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234465AbiASWm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 17:42:57 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 241C1C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 14:42:57 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id br17so14191185lfb.6
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 14:42:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=QBGuTeJTY4evy0pXgZPGqi5/7wy93IQZWaIcsbMgY0o=;
        b=dYC5q0yEQzPOlqU9aFZ+eQoQxQ3kRwyvkrWswfbjilki02dUSHfjXLVlYHyG3RbZc9
         43iXn+7gaxMapqt/maDxgsSzOpqe1wO9m5FSHukYaVDr+dcjmxtWaCyeeixEpEZdtrFi
         f/nHFkgj9vX6p11C4mVS5/7zRupL8vitbGDGjvryR3P9miQ5WminNEdIF5FIaXvcAZy9
         gyYEdbXwSo7JfZHMDC7euBIbvNhbeo9d4jxoL+XyW2qF6I1b57PgBxxABMXFAw1LArhX
         YZ0NEukdwR2+mL7Q6WEjyhu3flddZe+JjX2Z10mJP5CuhgoeQC7M9DKQDSnsjGlwBk1a
         MoDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=QBGuTeJTY4evy0pXgZPGqi5/7wy93IQZWaIcsbMgY0o=;
        b=jtUz9aNV8wU2V8WUDluTwsJJX014QNYESwADM/ym/WuWCXESwp2Jivnl/o3Kg4/Msu
         ouEmkwcgQ/irCJtD3RhSOwnUItz0Lq5oyKSahdM8imfODu+XzCJx94FXbMQtd5rSHZjU
         EM/hacr1OcDapknWDaAV32lt6I8xG9Xvkzwq/DJGtsvK/eAdHjq/KSiavKd3dg0ZMVJ5
         oiz3rHy/vwbfdjEj9Hs9Dc/KOfTX39wSANBqSDeFpL2dQH+SCuhvr052K17HP/wW+QcI
         Rz62dXhIogZmUmj+w/daGohIhUxyt8aW8j5Osr75D0hopqk5Bss6knM9rRej0MhXCy5A
         JooQ==
X-Gm-Message-State: AOAM532fS6DswKOq1SWSPJU5UYl3bKGVbcJGde+wjzALaQZXRqJZZiZY
        016J65S1XxqVIvi4xVqQhMlVTw==
X-Google-Smtp-Source: ABdhPJyKemZP+GUHTthbYxnWBhvreucyqWDoJdwuFoi+Cbpif8CLT38VaRlhicyGPRXwE+Blu2cNfg==
X-Received: by 2002:a05:6512:260c:: with SMTP id bt12mr29003355lfb.506.1642632175437;
        Wed, 19 Jan 2022 14:42:55 -0800 (PST)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id y19sm85202lji.135.2022.01.19.14.42.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jan 2022 14:42:54 -0800 (PST)
Message-ID: <74c6ad05-331f-5073-89ad-0efda6226dbc@linaro.org>
Date:   Thu, 20 Jan 2022 01:42:54 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH -next] drm/msm: remove variable set but not used
Content-Language: en-GB
To:     Yang Li <yang.lee@linux.alibaba.com>, robdclark@gmail.com
Cc:     sean@poorly.run, quic_abhinavk@quicinc.com, airlied@linux.ie,
        daniel@ffwll.ch, nathan@kernel.org, ndesaulniers@google.com,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Abaci Robot <abaci@linux.alibaba.com>
References: <20211216031103.34146-1-yang.lee@linux.alibaba.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20211216031103.34146-1-yang.lee@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/12/2021 06:11, Yang Li wrote:
> The code that uses variable mdss has been removed, So the declaration
> and assignment of the variable can be removed.
> 
> Eliminate the following clang warning:
> drivers/gpu/drm/msm/msm_drv.c:513:19: warning: variable 'mdss' set but
> not used [-Wunused-but-set-variable]
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Fixes: 2027e5b3413d ("drm/msm: Initialize MDSS irq domain at probe time")
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
>   drivers/gpu/drm/msm/msm_drv.c | 3 ---
>   1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
> index ad35a5d94053..59e30192cdf6 100644
> --- a/drivers/gpu/drm/msm/msm_drv.c
> +++ b/drivers/gpu/drm/msm/msm_drv.c
> @@ -510,7 +510,6 @@ static int msm_drm_init(struct device *dev, const struct drm_driver *drv)
>   	struct msm_drm_private *priv = dev_get_drvdata(dev);
>   	struct drm_device *ddev;
>   	struct msm_kms *kms;
> -	struct msm_mdss *mdss;
>   	int ret, i;
>   
>   	ddev = drm_dev_alloc(drv, dev);
> @@ -521,8 +520,6 @@ static int msm_drm_init(struct device *dev, const struct drm_driver *drv)
>   	ddev->dev_private = priv;
>   	priv->dev = ddev;
>   
> -	mdss = priv->mdss;
> -
>   	priv->wq = alloc_ordered_workqueue("msm", 0);
>   	priv->hangcheck_period = DRM_MSM_HANGCHECK_DEFAULT_PERIOD;
>   


-- 
With best wishes
Dmitry
