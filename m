Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D951C570562
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 16:20:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbiGKOUz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 10:20:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230280AbiGKOUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 10:20:41 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FB1D6556E
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 07:20:33 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id y11so2416240lfs.6
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 07:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=/WoeXkCRQvdMdIrjzk+AzlBLS61nT7rRY/fBBxAXK0k=;
        b=GHZhHsJGLDFByHdZtXdgKMCe38MElNSWlNaYctpTWBZRb+uuYmyC0NYT74D+v/A45f
         7L1GK3gD+PBmUW0EF5jYkT4PAZj9CU+rzCBR0QUSIR9B2kP5U50HaN9qDunuKqtApV1l
         vdZF10IywYq50YEBWy7kIK0//pFQ5CLtPJ4tUo+lz5/lXrFInc0NWaitov2u4SZgkFhs
         FkugQ0GRQeN0MiSpMxUXwJER8afYBm2WRXWdSNK3cG1vP821iyCmP/9lFN+g5Wh8JeCy
         GZviAFGWGQNuHyLv5WoQOPkczKlRoCd3TPca0QXPY89fNBcFsChn3d6YUnIYix3HND94
         qQIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/WoeXkCRQvdMdIrjzk+AzlBLS61nT7rRY/fBBxAXK0k=;
        b=qwJsoUbpmJBXIF5kMBhyug+r0HrPxZSifyWxUkmmzHvjK5+Q+CKSMlsL+2Zf+X+E5D
         qLgf7WfMVYba3jeVyLQMB4mfHq64nnapFb4Y3xxArduzniV03rQ798JH73S2lqZ8F9qd
         ni/5f0u+iMMAkqZJqYENBw98EAf2rWU85maCbdVBfql4UjURKar8Wv7JO6SZ1GzIvWZB
         7M6oH6b6r14vWGsANxkQO9LyIhrUvS/XGeoO413LQfe79gmBgpk9MttCPEGixxdrUUWG
         R0plhrbXcvSWxpTvyiP7Q2jsgVlrBYFzkDtCjyZubU5HUknnsfZkIek4t5ljaddTq1zf
         2F9Q==
X-Gm-Message-State: AJIora/JHh7gj+DbZlxU7fEYcoxjWqfH6i4jyycvbwP2YrZGf05QGQcT
        FNvxXpXpBhrAxGyxlwPYwMtw2g==
X-Google-Smtp-Source: AGRyM1ttCQzfNuGfapZ+Hp9gVpl3D/qqYFyWS7wCtXI67qND5EYOMdpfxD74TgYdD8Bu/1cVdroWFA==
X-Received: by 2002:ac2:4c15:0:b0:487:8ae9:7491 with SMTP id t21-20020ac24c15000000b004878ae97491mr12467243lfq.214.1657549230418;
        Mon, 11 Jul 2022 07:20:30 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id y16-20020a05651c107000b002554dce4048sm1799264ljm.53.2022.07.11.07.20.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jul 2022 07:20:29 -0700 (PDT)
Message-ID: <455247da-192b-6409-d26d-1c40d72f6a1d@linaro.org>
Date:   Mon, 11 Jul 2022 17:20:29 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v6 03/10] drm/msm/dp: use atomic callbacks for DP bridge
 ops
Content-Language: en-GB
To:     Vinod Polimera <quic_vpolimer@quicinc.com>,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, robdclark@gmail.com,
        dianders@chromium.org, swboyd@chromium.org,
        quic_kalyant@quicinc.com, quic_khsieh@quicinc.com,
        quic_vproddut@quicinc.com, bjorn.andersson@linaro.org,
        quic_aravindh@quicinc.com, quic_abhinavk@quicinc.com,
        quic_sbillaka@quicinc.com
References: <1657544224-10680-1-git-send-email-quic_vpolimer@quicinc.com>
 <1657544224-10680-4-git-send-email-quic_vpolimer@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <1657544224-10680-4-git-send-email-quic_vpolimer@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/07/2022 15:56, Vinod Polimera wrote:
> Use atomic variants for DP bridge callback functions so that
> the atomic state can be accessed in the interface drivers.
> The atomic state will help the driver find out if the display
> is in self refresh state.
> 
> Signed-off-by: Sankeerth Billakanti <quic_sbillaka@quicinc.com>
> Signed-off-by: Vinod Polimera <quic_vpolimer@quicinc.com>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
>   drivers/gpu/drm/msm/dp/dp_display.c |  9 ++++++---
>   drivers/gpu/drm/msm/dp/dp_drm.c     | 17 ++++++++++-------
>   drivers/gpu/drm/msm/dp/dp_drm.h     |  9 ++++++---
>   3 files changed, 22 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> index bce7793..5bd6677 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -1652,7 +1652,8 @@ int msm_dp_modeset_init(struct msm_dp *dp_display, struct drm_device *dev,
>   	return 0;
>   }
>   
> -void dp_bridge_enable(struct drm_bridge *drm_bridge)
> +void dp_bridge_atomic_enable(struct drm_bridge *drm_bridge,
> +			     struct drm_bridge_state *old_bridge_state)
>   {
>   	struct msm_dp_bridge *dp_bridge = to_dp_bridge(drm_bridge);
>   	struct msm_dp *dp = dp_bridge->dp_display;
> @@ -1716,7 +1717,8 @@ void dp_bridge_enable(struct drm_bridge *drm_bridge)
>   	mutex_unlock(&dp_display->event_mutex);
>   }
>   
> -void dp_bridge_disable(struct drm_bridge *drm_bridge)
> +void dp_bridge_atomic_disable(struct drm_bridge *drm_bridge,
> +			      struct drm_bridge_state *old_bridge_state)
>   {
>   	struct msm_dp_bridge *dp_bridge = to_dp_bridge(drm_bridge);
>   	struct msm_dp *dp = dp_bridge->dp_display;
> @@ -1727,7 +1729,8 @@ void dp_bridge_disable(struct drm_bridge *drm_bridge)
>   	dp_ctrl_push_idle(dp_display->ctrl);
>   }
>   
> -void dp_bridge_post_disable(struct drm_bridge *drm_bridge)
> +void dp_bridge_atomic_post_disable(struct drm_bridge *drm_bridge,
> +				   struct drm_bridge_state *old_bridge_state)
>   {
>   	struct msm_dp_bridge *dp_bridge = to_dp_bridge(drm_bridge);
>   	struct msm_dp *dp = dp_bridge->dp_display;
> diff --git a/drivers/gpu/drm/msm/dp/dp_drm.c b/drivers/gpu/drm/msm/dp/dp_drm.c
> index 62d58b9..294c28a 100644
> --- a/drivers/gpu/drm/msm/dp/dp_drm.c
> +++ b/drivers/gpu/drm/msm/dp/dp_drm.c
> @@ -61,13 +61,16 @@ static int dp_bridge_get_modes(struct drm_bridge *bridge, struct drm_connector *
>   }
>   
>   static const struct drm_bridge_funcs dp_bridge_ops = {
> -	.enable       = dp_bridge_enable,
> -	.disable      = dp_bridge_disable,
> -	.post_disable = dp_bridge_post_disable,
> -	.mode_set     = dp_bridge_mode_set,
> -	.mode_valid   = dp_bridge_mode_valid,
> -	.get_modes    = dp_bridge_get_modes,
> -	.detect       = dp_bridge_detect,
> +	.atomic_enable = dp_bridge_atomic_enable,
> +	.atomic_disable = dp_bridge_atomic_disable,
> +	.atomic_post_disable = dp_bridge_atomic_post_disable,
> +	.mode_set = dp_bridge_mode_set,
> +	.mode_valid = dp_bridge_mode_valid,
> +	.get_modes = dp_bridge_get_modes,
> +	.detect = dp_bridge_detect,
> +	.atomic_reset = drm_atomic_helper_bridge_reset,
> +	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
> +	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
>   };
>   
>   struct drm_bridge *dp_bridge_init(struct msm_dp *dp_display, struct drm_device *dev,
> diff --git a/drivers/gpu/drm/msm/dp/dp_drm.h b/drivers/gpu/drm/msm/dp/dp_drm.h
> index f4b1ed1..6b8ef29 100644
> --- a/drivers/gpu/drm/msm/dp/dp_drm.h
> +++ b/drivers/gpu/drm/msm/dp/dp_drm.h
> @@ -23,9 +23,12 @@ struct drm_connector *dp_drm_connector_init(struct msm_dp *dp_display);
>   struct drm_bridge *dp_bridge_init(struct msm_dp *dp_display, struct drm_device *dev,
>   			struct drm_encoder *encoder);
>   
> -void dp_bridge_enable(struct drm_bridge *drm_bridge);
> -void dp_bridge_disable(struct drm_bridge *drm_bridge);
> -void dp_bridge_post_disable(struct drm_bridge *drm_bridge);
> +void dp_bridge_atomic_enable(struct drm_bridge *drm_bridge,
> +			     struct drm_bridge_state *old_bridge_state);
> +void dp_bridge_atomic_disable(struct drm_bridge *drm_bridge,
> +			      struct drm_bridge_state *old_bridge_state);
> +void dp_bridge_atomic_post_disable(struct drm_bridge *drm_bridge,
> +				   struct drm_bridge_state *old_bridge_state);
>   enum drm_mode_status dp_bridge_mode_valid(struct drm_bridge *bridge,
>   					  const struct drm_display_info *info,
>   					  const struct drm_display_mode *mode);


-- 
With best wishes
Dmitry
