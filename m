Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E72E554432
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 10:11:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350371AbiFVH0p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 03:26:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiFVH0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 03:26:43 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 119EA3700E
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 00:26:42 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id t25so26270382lfg.7
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 00:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=nVINeQucA0hcOfl1Yl3NKcwENV+ClW7oKgC+Qvvycso=;
        b=A+bC1zR9Iyi6DtY8D0mBXn29lLBQ6l0+WcVTYf82rCLB3Tf/CekLrKRsSco0GzqToP
         TXXD+lu6JMBzvRoqrDnqWcuGOfWUDPdvJWCD5U0fM3BaWqebSVKPvnDuYFrGgWHB0BHr
         x94eLHaGWSTI/jXa4reXZS0ILn6n5qtkmVlso0YP9war5DXgh58Ev2jS9JP5E1AY3X4E
         agrVLRQH6RvaShxUuKX0agzdL582WLNOsePbY1XTEj3vyxxPhU7csSnP0ODVroLeAMkJ
         l77VY29GRznM+B3ONJ6Gt5UfGu7oPNKXHg7L5+YIRna4RJzWNhNPAznRLCmyE47PkXlm
         N/5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=nVINeQucA0hcOfl1Yl3NKcwENV+ClW7oKgC+Qvvycso=;
        b=Kd1ftdGyTfwQwoyvAcFs4vwN48nv7FZj78SsPves+VN1m+xAX3t+LErMxoZf1Aiimx
         lPzl+Rl5mY4eVH+bdqHwQVxxNymifoUVsKyEO+svyB2T89pSRWos2OkOwLASXlKBqRwC
         o9QhuZ6B1YTrcHH1e28p3VEB83dyIMeZHS6db3J/mxZAYxQQcXZmiSHnJUw9CPhuyl+G
         bnTS0TyU9B9hLhI5882aR2IIr34GAO6jcIjD0syYvYoGfPB0BmZIW4CX/xwsN+Wld3wm
         dHfBr/jEAIE8HEtNvuONAS8vr6xSaH/fNe3VMNz5GowaTU0tXfTVIABpOJ92LzeOGhyh
         hvrQ==
X-Gm-Message-State: AJIora8iyBo3PCJUJrnJWF5DOjHSV+CG1QaAP5kec97263qTJgTbOaiM
        yFvgQUZBAqVxGy5vrGs4Kc/KUw==
X-Google-Smtp-Source: AGRyM1s9XrHyP76QQ25ODf9GWmEg2gHGYNQxgUj3tWjupzrc+W5EIBfAY6Kk3S4lbVzlo8jSPMtdsw==
X-Received: by 2002:a05:6512:39d5:b0:47f:6e9a:5bf with SMTP id k21-20020a05651239d500b0047f6e9a05bfmr1314275lfu.580.1655882800383;
        Wed, 22 Jun 2022 00:26:40 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id s28-20020a19771c000000b0047f84ecae2esm488904lfc.236.2022.06.22.00.26.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jun 2022 00:26:39 -0700 (PDT)
Message-ID: <f127060a-5648-fa40-81a0-be1be05b3951@linaro.org>
Date:   Wed, 22 Jun 2022 10:26:39 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v8 1/2] drm/msm/dp: force link training for display
 resolution change
Content-Language: en-GB
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>,
        dri-devel@lists.freedesktop.org, robdclark@gmail.com,
        sean@poorly.run, swboyd@chromium.org, dianders@chromium.org,
        vkoul@kernel.org, daniel@ffwll.ch, airlied@linux.ie,
        agross@kernel.org, bjorn.andersson@linaro.org
Cc:     quic_abhinavk@quicinc.com, quic_aravindh@quicinc.com,
        quic_sbillaka@quicinc.com, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1655399361-10842-1-git-send-email-quic_khsieh@quicinc.com>
 <1655399361-10842-2-git-send-email-quic_khsieh@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <1655399361-10842-2-git-send-email-quic_khsieh@quicinc.com>
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

On 16/06/2022 20:09, Kuogee Hsieh wrote:
> Display resolution change is implemented through drm modeset. Older
> modeset (resolution) has to be disabled first before newer modeset
> (resolution) can be enabled. Display disable will turn off both
> pixel clock and main link clock so that main link have to be
> re-trained during display enable to have new video stream flow
> again. At current implementation, display enable function manually
> kicks up irq_hpd_handle which will read panel link status and start
> link training if link status is not in sync state.
> 
> However, there is rare case that a particular panel links status keep
> staying in sync for some period of time after main link had been shut
> down previously at display disabled. In this case, main link retraining
> will not be executed by irq_hdp_handle(). Hence video stream of newer
> display resolution will fail to be transmitted to panel due to main
> link is not in sync between host and panel.
> 
> This patch will bypass irq_hpd_handle() in favor of directly call
> dp_ctrl_on_stream() to always perform link training in regardless of
> main link status. So that no unexpected exception resolution change
> failure cases will happen. Also this implementation are more efficient
> than manual kicking off irq_hpd_handle function.
> 
> Changes in v2:
> -- set force_link_train flag on DP only (is_edp == false)
> 
> Changes in v3:
> -- revise commit  text
> -- add Fixes tag
> 
> Changes in v4:
> -- revise commit  text
> 
> Changes in v5:
> -- fix spelling at commit text
> 
> Changes in v6:
> -- split dp_ctrl_on_stream() for phy test case
> -- revise commit text for modeset
> 
> Changes in v7:
> -- drop 0 assignment at local variable (ret = 0)
> 
> Changes in v8:
> -- add patch to remove pixel_rate from dp_ctrl
> 
> Fixes: 62671d2ef24b ("drm/msm/dp: fixes wrong connection state caused by failure of link train")
> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> ---
>   drivers/gpu/drm/msm/dp/dp_ctrl.c    | 31 +++++++++++++++++++++++--------
>   drivers/gpu/drm/msm/dp/dp_ctrl.h    |  3 ++-
>   drivers/gpu/drm/msm/dp/dp_display.c | 13 ++++++-------
>   3 files changed, 31 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
> index af7a80c..01028b5 100644
> --- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
> +++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
> @@ -1551,7 +1551,7 @@ static int dp_ctrl_process_phy_test_request(struct dp_ctrl_private *ctrl)
>   
>   	ret = dp_ctrl_on_link(&ctrl->dp_ctrl);
>   	if (!ret)
> -		ret = dp_ctrl_on_stream(&ctrl->dp_ctrl);
> +		ret = dp_ctrl_on_stream_phy_test_report(&ctrl->dp_ctrl);
>   	else
>   		DRM_ERROR("failed to enable DP link controller\n");
>   
> @@ -1807,7 +1807,27 @@ static int dp_ctrl_link_retrain(struct dp_ctrl_private *ctrl)
>   	return dp_ctrl_setup_main_link(ctrl, &training_step);
>   }
>   
> -int dp_ctrl_on_stream(struct dp_ctrl *dp_ctrl)
> +int dp_ctrl_on_stream_phy_test_report(struct dp_ctrl *dp_ctrl)
> +{
> +	int ret;
> +	struct dp_ctrl_private *ctrl;
> +
> +	ctrl = container_of(dp_ctrl, struct dp_ctrl_private, dp_ctrl);
> +
> +	ctrl->dp_ctrl.pixel_rate = ctrl->panel->dp_mode.drm_mode.clock;

Stephen has raised an interesting question. Comparing this to the 
dp_ctrl_on_stream(), he noticed that we do not halve the pixel clock 
here (if the wide bus is supported). So, the question is if this is 
correct or not.

> +
> +	ret = dp_ctrl_enable_stream_clocks(ctrl);
> +	if (ret) {
> +		DRM_ERROR("Failed to start pixel clocks. ret=%d\n", ret);
> +		return ret;
> +	}
> +
> +	dp_ctrl_send_phy_test_pattern(ctrl);
> +
> +	return 0;
> +}
> +
> +int dp_ctrl_on_stream(struct dp_ctrl *dp_ctrl, bool force_link_train)
>   {
>   	int ret = 0;
>   	bool mainlink_ready = false;
> @@ -1843,12 +1863,7 @@ int dp_ctrl_on_stream(struct dp_ctrl *dp_ctrl)
>   		goto end;
>   	}
>   
> -	if (ctrl->link->sink_request & DP_TEST_LINK_PHY_TEST_PATTERN) {
> -		dp_ctrl_send_phy_test_pattern(ctrl);
> -		return 0;
> -	}
> -
> -	if (!dp_ctrl_channel_eq_ok(ctrl))
> +	if (force_link_train || !dp_ctrl_channel_eq_ok(ctrl))
>   		dp_ctrl_link_retrain(ctrl);
>   
>   	/* stop txing train pattern to end link training */


-- 
With best wishes
Dmitry
