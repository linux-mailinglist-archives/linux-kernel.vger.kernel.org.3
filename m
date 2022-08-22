Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E72C659CA1F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 22:36:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237496AbiHVUgK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 16:36:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237492AbiHVUgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 16:36:05 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FCA4550B5
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 13:36:03 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id l23so672579lji.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 13:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=Ywx2Ifz/ABKWVJisuMZqTLd+k7zB7LgcLuZnDbx5qWY=;
        b=EGiF52LnWu0oKDZVfUcQPzArNVGqjt8Ky/kICz3i3KBurZON54IyqEK+719nlVPwQy
         TeTioDOaXJVDMuE+zCpFU4gcfx8vgLn7Bwz8SLWcGl+ry46R8MYCRMt7MPk+HhZM4fqY
         C9uEyK2vDvHFo5Bca58j6OjSYlsoqh6H5hGsgVJ+/Sso4Z77MtIPRxpAd9qUsWfv++fC
         f7U6d7YbI+KEBNJUVIqomwoiJ4jtr40sY8Huxso6vi2fvfdDznAQMJGdwLVnlebkOBC2
         BfuO8/pmv4/Kle4GubmX2fcdephn9oy7UxO02RAjF9Us1WBpLXWheLYsXsOp2G0vDxsX
         b94Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=Ywx2Ifz/ABKWVJisuMZqTLd+k7zB7LgcLuZnDbx5qWY=;
        b=xA+hY1MDbG2ch+qm8rNtfjrAFTLOrivFhzgK+OyGGV5EC5F/HTVDDo/hSu5RGLl8kx
         z/r1qrzt/TpE75BLXNNrAkSDRGJsmj1caCevsruyEdkbRt6OPT1O4CbMK9X+CAAlMAdX
         z56jHosgce1wMRBF9Zf0lbIQw1dpWsaU/QtAJZX7hekKYe9MrxpAS6onT2kpanzuCyJT
         g+Kk1uZs+N6WddWrS3mmbxGDYkkyU7JRvs8pRd7msk4DCG+CoozY+ZBuv4jq5kHS8mSy
         RARez1MQRWt0I9SkgD6vsdVcVCnY6hTNxxBt9oq3bqnJ21YHuQjqKG+er6FVtIXvSPC+
         Dquw==
X-Gm-Message-State: ACgBeo0JJ6vKiSoHvTdBVW39neySITBdoJVFHOP3ChQ60W8a0xYg6ylb
        PuAHT7BH+ExY8lt6ZWXGlcUnDA==
X-Google-Smtp-Source: AA6agR5h2CI32nqdz5wOyFqSvf2UhKVe+zSaW8nguIqIjJL4GEDKfAoZM3ZcDoUgFct2NixsH2YdOA==
X-Received: by 2002:a2e:949:0:b0:261:cbac:fc72 with SMTP id 70-20020a2e0949000000b00261cbacfc72mr2163268ljj.463.1661200561957;
        Mon, 22 Aug 2022 13:36:01 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id b17-20020a056512071100b00492c77c55ddsm1811099lfs.67.2022.08.22.13.36.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Aug 2022 13:36:01 -0700 (PDT)
Message-ID: <4a73be48-f1cf-a359-7f34-e3271f14ea95@linaro.org>
Date:   Mon, 22 Aug 2022 23:36:00 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH 5/7] drm/msm/dp: Implement hpd_notify()
Content-Language: en-GB
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Sankeerth Billakanti <quic_sbillaka@quicinc.com>
Cc:     Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220810035013.3582848-1-bjorn.andersson@linaro.org>
 <20220810035013.3582848-6-bjorn.andersson@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20220810035013.3582848-6-bjorn.andersson@linaro.org>
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

On 10/08/2022 06:50, Bjorn Andersson wrote:
> The DisplayPort controller's hot-plug mechanism is based on pinmuxing a
> physical signal no a GPIO pin into the controller. This is not always
> possible, either because there aren't dedicated GPIOs available or
> because the hot-plug signal is a virtual notification, in cases such as
> USB Type-C.
> 
> For these cases, by implementing the hpd_notify() callback for the
> DisplayPort controller's drm_bridge, a downstream drm_bridge
> (next_bridge) can be used to track and signal the connection status
> changes.
> 
> This makes it possible to use downstream drm_bridges such as
> display-connector or any virtual mechanism, as long as they are
> implemented as a drm_bridge.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>   drivers/gpu/drm/msm/dp/dp_display.c | 23 +++++++++++++++++++++++
>   drivers/gpu/drm/msm/dp/dp_display.h |  1 +
>   drivers/gpu/drm/msm/dp/dp_drm.c     |  3 +++
>   drivers/gpu/drm/msm/dp/dp_drm.h     |  2 ++
>   4 files changed, 29 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> index 699f28f2251e..568295381246 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -1303,6 +1303,7 @@ static int dp_display_probe(struct platform_device *pdev)
>   	if (!desc)
>   		return -EINVAL;
>   
> +	dp->dp_display.dev = &pdev->dev;
>   	dp->pdev = pdev;
>   	dp->name = "drm_dp";
>   	dp->id = desc->id;
> @@ -1765,3 +1766,25 @@ void dp_bridge_mode_set(struct drm_bridge *drm_bridge,
>   	dp_display->dp_mode.h_active_low =
>   		!!(dp_display->dp_mode.drm_mode.flags & DRM_MODE_FLAG_NHSYNC);
>   }
> +
> +void dp_bridge_hpd_notify(struct drm_bridge *bridge,
> +			  enum drm_connector_status status)
> +{
> +	struct msm_dp_bridge *dp_bridge = to_dp_bridge(bridge);
> +	struct msm_dp *dp_display = dp_bridge->dp_display;
> +	struct dp_display_private *dp = container_of(dp_display, struct dp_display_private, dp_display);
> +
> +	/* Without next_bridge interrupts are handled by the DP core directly */
> +	if (!dp_display->next_bridge)
> +		return;
> +
> +	if (!dp->core_initialized) {
> +		drm_dbg_dp(dp->drm_dev, "not initialized\n");
> +		return;
> +	}
> +
> +	if (!dp_display->is_connected && status == connector_status_connected)
> +		dp_add_event(dp, EV_HPD_PLUG_INT, 0, 0);
> +	else if (dp_display->is_connected && status == connector_status_disconnected)
> +		dp_add_event(dp, EV_HPD_UNPLUG_INT, 0, 0);
> +}
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.h b/drivers/gpu/drm/msm/dp/dp_display.h
> index dcedf021f7fe..d7bc537ead31 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.h
> +++ b/drivers/gpu/drm/msm/dp/dp_display.h
> @@ -11,6 +11,7 @@
>   #include "disp/msm_disp_snapshot.h"
>   
>   struct msm_dp {
> +	struct device *dev;
>   	struct drm_device *drm_dev;
>   	struct device *codec_dev;
>   	struct drm_bridge *bridge;
> diff --git a/drivers/gpu/drm/msm/dp/dp_drm.c b/drivers/gpu/drm/msm/dp/dp_drm.c
> index 6df25f7662e7..875b23910bef 100644
> --- a/drivers/gpu/drm/msm/dp/dp_drm.c
> +++ b/drivers/gpu/drm/msm/dp/dp_drm.c
> @@ -68,6 +68,7 @@ static const struct drm_bridge_funcs dp_bridge_ops = {
>   	.mode_valid   = dp_bridge_mode_valid,
>   	.get_modes    = dp_bridge_get_modes,
>   	.detect       = dp_bridge_detect,
> +	.hpd_notify   = dp_bridge_hpd_notify,
>   };
>   
>   struct drm_bridge *dp_bridge_init(struct msm_dp *dp_display, struct drm_device *dev,
> @@ -138,6 +139,8 @@ struct drm_connector *dp_drm_connector_init(struct msm_dp *dp_display, struct dr
>   	if (IS_ERR(connector))
>   		return connector;
>   
> +	connector->fwnode = fwnode_handle_get(dev_fwnode(dp_display->dev));

Not used anymore, isn't it? Then dp_display->dev also seems unused.

> +
>   	drm_connector_attach_encoder(connector, encoder);
>   
>   	return connector;
> diff --git a/drivers/gpu/drm/msm/dp/dp_drm.h b/drivers/gpu/drm/msm/dp/dp_drm.h
> index 82035dbb0578..79e6b2cf2d25 100644
> --- a/drivers/gpu/drm/msm/dp/dp_drm.h
> +++ b/drivers/gpu/drm/msm/dp/dp_drm.h
> @@ -32,5 +32,7 @@ enum drm_mode_status dp_bridge_mode_valid(struct drm_bridge *bridge,
>   void dp_bridge_mode_set(struct drm_bridge *drm_bridge,
>   			const struct drm_display_mode *mode,
>   			const struct drm_display_mode *adjusted_mode);
> +void dp_bridge_hpd_notify(struct drm_bridge *bridge,
> +			  enum drm_connector_status status);
>   
>   #endif /* _DP_DRM_H_ */

-- 
With best wishes
Dmitry

