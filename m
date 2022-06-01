Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38B3A53ADE0
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 22:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbiFAUqs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 16:46:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbiFAUoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 16:44:09 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA4141EA077
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 13:29:09 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id u23so4640978lfc.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 13:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=DcSjpVSz5kBdKttL/qibmuyG6zf/I/eEkUNKVypzm4Y=;
        b=LeXZCfDwi2JzAKvy4kHtOnltGKxqKYskF08v+UIdsvEtOxxkwoK78b2BOKkHrkgRfW
         Y+8VuwFXMA22RggbMXr8BqJP8G9jxw4NnRbS5rJ+Hlm7fSLvPjIgZFIY3mCYuRhB7AwR
         TDIq6/uCsckrZ4MnKi3K5jPuGZNp+R5ffvuOnJlAukZOGyMaOXN+e+lddOkZneNNJNBr
         KwAPb0MnVnY+5+izFAW7GUFLx7j2b7w7PBm9XR71icRTloDMuybxUTteLsrK5SaaUyO/
         N0nALzFMvqA0DKYCugRlIBeZSBKbPu6/Dkk/jBaJJJ1YQoQIpWnIz7fBd9gMiYKhkysR
         s9CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=DcSjpVSz5kBdKttL/qibmuyG6zf/I/eEkUNKVypzm4Y=;
        b=FEBauB0nzdmEQXXTcOEQG9NcmCjB4ITQq/+r2Rmm+m0t8VfSHHkGaGuIdORQdaPQH0
         UVIw6JE5rVS5oObs500iglWUsaBFalehL+WWL8qNAv2gCWcJYp+zMps+tNROnGbbNEHE
         KfTJ2ULff4unEQcwXukDUaZXZcxokXOXSwyAn+Xx3XOJ+ArMK6/LWOU0qyQkNa8aO/yM
         Yh7vma4N3uXHI6FsatDGRHbfoJ4pdWCQF0rgvw8XwBly3XseZjGZQlRDYXv4ODVkSgDB
         ZsgZaeQ+uA5Tv/w43crndp4EuhemNw7ou3jsr80MWRIYDh1+OmvQbCg/YNTBVQEYs4fl
         8KAQ==
X-Gm-Message-State: AOAM533mJ4qsda2Sdy+lryrHTcO99th3FWP4Kxh6qxkxCcvrKehUZn3o
        NZT3quK3OM0MdQkdcAuGpuyRxg==
X-Google-Smtp-Source: ABdhPJyo80JtJC9EIe0BPck/BKbot5NFyz0n8b5/KWlTwdKmU8JYQYlgeVZ7FO9/zTX8ShzY5j01dg==
X-Received: by 2002:ac2:4289:0:b0:477:b3eb:f2f with SMTP id m9-20020ac24289000000b00477b3eb0f2fmr916181lfh.386.1654115347986;
        Wed, 01 Jun 2022 13:29:07 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id z8-20020a0565120c0800b00478e5ef1ee5sm550811lfu.245.2022.06.01.13.29.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jun 2022 13:29:07 -0700 (PDT)
Message-ID: <846ef8f5-230e-4e52-f67c-d2fc2530fcc0@linaro.org>
Date:   Wed, 1 Jun 2022 23:29:06 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v3 1/4] drm/dp: Export symbol / kerneldoc fixes for DP AUX
 bus
Content-Language: en-GB
To:     Douglas Anderson <dianders@chromium.org>,
        dri-devel@lists.freedesktop.org
Cc:     Hsin-Yi Wang <hsinyi@chromium.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Philip Chen <philipchen@chromium.org>,
        Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        Robert Foss <robert.foss@linaro.org>,
        freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Stephen Boyd <swboyd@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Lyude Paul <lyude@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org
References: <20220510192944.2408515-1-dianders@chromium.org>
 <20220510122726.v3.1.Ia91f4849adfc5eb9da1eb37ba79aa65fb3c95a0f@changeid>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20220510122726.v3.1.Ia91f4849adfc5eb9da1eb37ba79aa65fb3c95a0f@changeid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/05/2022 22:29, Douglas Anderson wrote:
> While working on the DP AUX bus code I found a few small things that
> should be fixed. Namely the non-devm version of
> of_dp_aux_populate_ep_devices() was missing an export. There was also
> an extra blank line in a kerneldoc and a kerneldoc that incorrectly
> documented a return value. Fix these.
> 
> Fixes: aeb33699fc2c ("drm: Introduce the DP AUX bus")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
> None of these seem critical, so my plan is to land this in
> drm-misc-next and not drm-misc-fixes. This will avoid merge conflicts
> with future patches.
> 
> Changes in v3:
> - Patch ("drm/dp: Export symbol / kerneldoc fixes...") split for v3.
> 
>   drivers/gpu/drm/display/drm_dp_aux_bus.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/display/drm_dp_aux_bus.c b/drivers/gpu/drm/display/drm_dp_aux_bus.c
> index dccf3e2ea323..552f949cff59 100644
> --- a/drivers/gpu/drm/display/drm_dp_aux_bus.c
> +++ b/drivers/gpu/drm/display/drm_dp_aux_bus.c
> @@ -66,7 +66,6 @@ static int dp_aux_ep_probe(struct device *dev)
>    * @dev: The device to remove.
>    *
>    * Calls through to the endpoint driver remove.
> - *
>    */
>   static void dp_aux_ep_remove(struct device *dev)
>   {
> @@ -120,8 +119,6 @@ ATTRIBUTE_GROUPS(dp_aux_ep_dev);
>   /**
>    * dp_aux_ep_dev_release() - Free memory for the dp_aux_ep device
>    * @dev: The device to free.
> - *
> - * Return: 0 if no error or negative error code.
>    */
>   static void dp_aux_ep_dev_release(struct device *dev)
>   {
> @@ -256,6 +253,7 @@ int of_dp_aux_populate_ep_devices(struct drm_dp_aux *aux)
>   
>   	return 0;
>   }
> +EXPORT_SYMBOL_GPL(of_dp_aux_populate_ep_devices);
>   
>   static void of_dp_aux_depopulate_ep_devices_void(void *data)
>   {


-- 
With best wishes
Dmitry
