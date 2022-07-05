Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26EE956774F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 21:08:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233349AbiGETG2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 15:06:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbiGETGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 15:06:06 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B710320BDF
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 12:06:05 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id e12so22152743lfr.6
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 12:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=xOhWnb540p1r36VjLLL8ynDSP8n2cvWSH5xUUPsNb0M=;
        b=lm2URx2gBPg+e7VroVtwkgkusQ2E2ZSJiom5CZjR4M8O5n6lVaAq+I61NSMrLINxtM
         cZfUeHCtDkFX+ch6acEweNswtrAYaAzNin4rTHPldBoZgJ6QsXvSbhKxEe1B1WF+2RCA
         NmAJtjqhzptVu6Jo94qpW9zfG4Tyt210jTOlx5NEyzy5morfUcCvi7UoubjtrYo4F/0m
         dY1P4lSCsbMNCgmeFI/VsmG0wnDx7qvsVhAJHaY5GHNrxbV98U8evB3bHT1qdogPSITI
         /yPw4VTopbvhVeZCpgD47v9tS84boS2IHUtruz+4c4wzHwzT6JvKCYR5cN6HlF8Kxrhm
         DaoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=xOhWnb540p1r36VjLLL8ynDSP8n2cvWSH5xUUPsNb0M=;
        b=cT2QA3Swb6w5DWhDWEhcN7lqOc6OY4BKVjWhkeq6SNoQH1Fx4o6nR53vwHNP7iaXiB
         pwbztNjItAGBIDc4tlIMb8KsY4a4acZM15+RdpwDL5h0/HHpifwrZkjixMIAkCmdwZuK
         Dx3pCKlJa699CXwJ74R+MxDC2woEE1TXmW9PY/4tRsb3VgtdjB/NDJy5cOsxVN+nPwYw
         B+zZKcnnzibn3CjNe/UlbgbfnVsb7ztnh++Zo6eRhfpbA64uVzFnHZcVUEvWGa02bYUK
         aK9uba8MNlakqK9IoX7GNUGZeAE+kQx9LOoFwzIKS9LW/cSxQTLPkuyH3Iy22frIK1e6
         ilVg==
X-Gm-Message-State: AJIora9bo3vb8h0D61wWllKnmOm5rKV5wN+ZB8GQm9FhA9m4hgMli1X6
        tpuWVIdpgyHpGNpvBVVDYaMHSYqrQ59aVg==
X-Google-Smtp-Source: AGRyM1uAV+E6puJrOXSAla6ccZGskpklniPb4N5wfYqqJeeFOoZDBigSJVJ8jjQIAMPwUcg8nbbJ3A==
X-Received: by 2002:a05:6512:70c:b0:47f:8e9f:ac2 with SMTP id b12-20020a056512070c00b0047f8e9f0ac2mr24437278lfs.156.1657047963895;
        Tue, 05 Jul 2022 12:06:03 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id u19-20020ac25193000000b0048326115186sm633670lfi.10.2022.07.05.12.06.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Jul 2022 12:06:03 -0700 (PDT)
Message-ID: <6562f44a-dfd8-f8c4-0271-2cda6afd7c2a@linaro.org>
Date:   Tue, 5 Jul 2022 22:06:02 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v4 4/7] drm/bridge: use atomic enable/disable callbacks
 for panel bridge
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
References: <1657040445-13067-1-git-send-email-quic_vpolimer@quicinc.com>
 <1657040445-13067-5-git-send-email-quic_vpolimer@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <1657040445-13067-5-git-send-email-quic_vpolimer@quicinc.com>
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

On 05/07/2022 20:00, Vinod Polimera wrote:
> Use atomic variants for panel bridge callback functions such that
> certain states like self-refresh can be accessed as part of
> enable/disable sequence.
> 
> Signed-off-by: Sankeerth Billakanti <quic_sbillaka@quicinc.com>
> Signed-off-by: Vinod Polimera <quic_vpolimer@quicinc.com>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
>   drivers/gpu/drm/bridge/panel.c | 20 ++++++++++++--------
>   1 file changed, 12 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/panel.c b/drivers/gpu/drm/bridge/panel.c
> index 0ee563e..eeb9546 100644
> --- a/drivers/gpu/drm/bridge/panel.c
> +++ b/drivers/gpu/drm/bridge/panel.c
> @@ -108,28 +108,32 @@ static void panel_bridge_detach(struct drm_bridge *bridge)
>   		drm_connector_cleanup(connector);
>   }
>   
> -static void panel_bridge_pre_enable(struct drm_bridge *bridge)
> +static void panel_bridge_atomic_pre_enable(struct drm_bridge *bridge,
> +				struct drm_bridge_state *old_bridge_state)
>   {
>   	struct panel_bridge *panel_bridge = drm_bridge_to_panel_bridge(bridge);
>   
>   	drm_panel_prepare(panel_bridge->panel);
>   }
>   
> -static void panel_bridge_enable(struct drm_bridge *bridge)
> +static void panel_bridge_atomic_enable(struct drm_bridge *bridge,
> +				struct drm_bridge_state *old_bridge_state)
>   {
>   	struct panel_bridge *panel_bridge = drm_bridge_to_panel_bridge(bridge);
>   
>   	drm_panel_enable(panel_bridge->panel);
>   }
>   
> -static void panel_bridge_disable(struct drm_bridge *bridge)
> +static void panel_bridge_atomic_disable(struct drm_bridge *bridge,
> +				struct drm_bridge_state *old_bridge_state)
>   {
>   	struct panel_bridge *panel_bridge = drm_bridge_to_panel_bridge(bridge);
>   
>   	drm_panel_disable(panel_bridge->panel);
>   }
>   
> -static void panel_bridge_post_disable(struct drm_bridge *bridge)
> +static void panel_bridge_atomic_post_disable(struct drm_bridge *bridge,
> +				struct drm_bridge_state *old_bridge_state)
>   {
>   	struct panel_bridge *panel_bridge = drm_bridge_to_panel_bridge(bridge);
>   
> @@ -158,10 +162,10 @@ static void panel_bridge_debugfs_init(struct drm_bridge *bridge,
>   static const struct drm_bridge_funcs panel_bridge_bridge_funcs = {
>   	.attach = panel_bridge_attach,
>   	.detach = panel_bridge_detach,
> -	.pre_enable = panel_bridge_pre_enable,
> -	.enable = panel_bridge_enable,
> -	.disable = panel_bridge_disable,
> -	.post_disable = panel_bridge_post_disable,
> +	.atomic_pre_enable = panel_bridge_atomic_pre_enable,
> +	.atomic_enable = panel_bridge_atomic_enable,
> +	.atomic_disable = panel_bridge_atomic_disable,
> +	.atomic_post_disable = panel_bridge_atomic_post_disable,
>   	.get_modes = panel_bridge_get_modes,
>   	.atomic_reset = drm_atomic_helper_bridge_reset,
>   	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,


-- 
With best wishes
Dmitry
