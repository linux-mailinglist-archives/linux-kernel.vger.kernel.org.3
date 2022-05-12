Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0EB35257A6
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 00:17:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359087AbiELWRF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 18:17:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352682AbiELWRD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 18:17:03 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45D2356207
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 15:17:01 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id p10so11429418lfa.12
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 15:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=n/bIpPSR+nG3hRb0LIrVjIvOFsTNueiSrIsjJcX2Yyg=;
        b=qzTc5GL6EkDGWNoKMTNGUgSX5FlQsYQ4ns/GeNhLe1KCAXAuUSoAOMAcIXAzZJeFuX
         nOFvoHNawnO5UlL4FKLNPmhgS27D8xxNDjAcv64jf/FxL4UleEGKef01zMT0zgYKlsK5
         H1eqEDuy2HkGNovSwuJCBlxZZTbQXbUDDucMa4/YAxjKvH8HNfHwTE8CQxjy9XUstTUg
         BmWM2ljqel/SHpMPoc8cxX19pET2WJquRHS+n3hlaiIbwDDKjsjrBVGfsFFmPCrELmNu
         zOi+PJq2je8BBYgwZzcUmMEiItSHB43cmVjN6Vd1NSoW1dPdzLhrrWkMV2MCFJldlXnl
         unWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=n/bIpPSR+nG3hRb0LIrVjIvOFsTNueiSrIsjJcX2Yyg=;
        b=6jRbawFKsgjZpuqFWkhdh+wyK30HT8dvGgREyP2pojmJdtS8s0M1XWkIQrE4mRektK
         5Q63WRzfo6bKft0uNtCmS6RwuCJrcwaUINz+7E2IOScQG4dc7lmgCx6KzQpgX3dscwai
         1tYmc63+mAqabdvmrBcr0dCKfOgFVr5Ya7gnNOcI2HtUTKZDlW6vhp6JyNJ71Y5+4/Qr
         6E116LyhIsK3bsEWqQOVG5pkPFfREDdb1cUiGQYXVzpILjAfu+ewbMO2gdovPhrqAQb1
         /gAQW57dveIhU+dF1ULNBlH/Kt+9+IUuorcyOLJPzx0ZmICjWA0hGmILf0F2DPX3wZXO
         6kbA==
X-Gm-Message-State: AOAM531Pm5LAxhMixJL8Q9GfM1Coa/FXSsBS4WPVn6EcG9nYGmoBGQct
        UglWFCcMYFUMIXZ86soZuA1Vxg==
X-Google-Smtp-Source: ABdhPJxX4B9K3oB+pDmhOUPFgene4MlzAGjW8gHNnQfn1dn3+5mmbqFEiHGjOoaoLLZpnb7zIXh4PA==
X-Received: by 2002:a05:6512:1398:b0:448:bda0:99f2 with SMTP id p24-20020a056512139800b00448bda099f2mr1255101lfa.681.1652393819601;
        Thu, 12 May 2022 15:16:59 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id u7-20020a056512040700b0047255d211d2sm106631lfk.257.2022.05.12.15.16.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 May 2022 15:16:59 -0700 (PDT)
Message-ID: <dd62b8a7-43b9-364a-a427-94d621648012@linaro.org>
Date:   Fri, 13 May 2022 01:16:58 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v4] drm/msm/dsi: don't powerup at modeset time for
 parade-ps8640
Content-Language: en-GB
To:     Douglas Anderson <dianders@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc:     Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>, Sean Paul <sean@poorly.run>,
        Stephen Boyd <swboyd@chromium.org>,
        Vinod Koul <vkoul@kernel.org>, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220512145954.v4.1.Ia196e35ad985059e77b038a41662faae9e26f411@changeid>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20220512145954.v4.1.Ia196e35ad985059e77b038a41662faae9e26f411@changeid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/05/2022 01:00, Douglas Anderson wrote:
> Commit 7d8e9a90509f ("drm/msm/dsi: move DSI host powerup to modeset
> time") caused sc7180 Chromebooks that use the parade-ps8640 bridge
> chip to fail to turn the display back on after it turns off.
> 
> Unfortunately, it doesn't look easy to fix the parade-ps8640 driver to
> handle the new power sequence. The Linux driver has almost nothing in
> it and most of the logic for this bridge chip is in black-box firmware
> that the bridge chip uses.
> 
> Also unfortunately, reverting the patch will break "tc358762".
> 
> The long term solution here is probably Dave Stevenson's series [1]
> that would give more flexibility. However, that is likely not a quick
> fix.
> 
> For the short term, we'll look at the compatible of the next bridge in
> the chain and go back to the old way for the Parade PS8640 bridge
> chip. If it's found that other bridge chips also need this workaround
> then we can add them to the list or consider inverting the condition.
> 
> [1] https://lore.kernel.org/r/cover.1646406653.git.dave.stevenson@raspberrypi.com
> 
> Fixes: 7d8e9a90509f ("drm/msm/dsi: move DSI host powerup to modeset time")
> Suggested-by: Rob Clark <robdclark@gmail.com>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
> Note that, unlike `struct device`, `struct drm_bridge` still has a
> `#ifdef` around the `of_node`. The extra stub function in this patch
> is to make sure that we can pass COMPILE_TEST, not because I expect
> that we'll actually run into real users who are running this driver
> without device tree.
> 
> Changes in v4:
> - Use the compatible string of the next bridge as per Rob.
> 
> Changes in v3:
> - No longer a revert; now a module parameter.
> 
> Changes in v2:
> - Remove the mud from my face.
> 
>   drivers/gpu/drm/msm/dsi/dsi_manager.c | 26 +++++++++++++++++++++++++-
>   1 file changed, 25 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/msm/dsi/dsi_manager.c b/drivers/gpu/drm/msm/dsi/dsi_manager.c
> index 50b987658b1f..2cabba65a8f1 100644
> --- a/drivers/gpu/drm/msm/dsi/dsi_manager.c
> +++ b/drivers/gpu/drm/msm/dsi/dsi_manager.c
> @@ -34,6 +34,26 @@ static struct msm_dsi_manager msm_dsim_glb;
>   #define IS_SYNC_NEEDED()	(msm_dsim_glb.is_sync_needed)
>   #define IS_MASTER_DSI_LINK(id)	(msm_dsim_glb.master_dsi_link_id == id)
>   
> +#ifdef CONFIG_OF
> +static bool dsi_mgr_power_on_early(struct drm_bridge *bridge)
> +{
> +	struct drm_bridge *next_bridge = drm_bridge_get_next_bridge(bridge);
> +
> +	/*
> +	 * If the next bridge in the chain is the Parade ps8640 bridge chip
> +	 * then don't power on early since it seems to violate the expectations
> +	 * of the firmware that the bridge chip is running.
> +	 */
> +	return !(next_bridge && next_bridge->of_node &&
> +		 of_device_is_compatible(next_bridge->of_node, "parade,ps8640"));
> +}
> +#else
> +static inline bool dsi_mgr_power_on_early(struct drm_bridge *bridge)
> +{
> +	return true;
> +}
> +#endif
> +
>   static inline struct msm_dsi *dsi_mgr_get_dsi(int id)
>   {
>   	return msm_dsim_glb.dsi[id];
> @@ -389,6 +409,9 @@ static void dsi_mgr_bridge_pre_enable(struct drm_bridge *bridge)
>   	if (is_bonded_dsi && !IS_MASTER_DSI_LINK(id))
>   		return;
>   
> +	if (!dsi_mgr_power_on_early(bridge))
> +		dsi_mgr_bridge_power_on(bridge);
> +
>   	/* Always call panel functions once, because even for dual panels,
>   	 * there is only one drm_panel instance.
>   	 */
> @@ -570,7 +593,8 @@ static void dsi_mgr_bridge_mode_set(struct drm_bridge *bridge,
>   	if (is_bonded_dsi && other_dsi)
>   		msm_dsi_host_set_display_mode(other_dsi->host, adjusted_mode);
>   
> -	dsi_mgr_bridge_power_on(bridge);
> +	if (dsi_mgr_power_on_early(bridge))
> +		dsi_mgr_bridge_power_on(bridge);
>   }
>   
>   static enum drm_mode_status dsi_mgr_bridge_mode_valid(struct drm_bridge *bridge,


-- 
With best wishes
Dmitry
