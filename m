Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B22D248693A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 18:55:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242471AbiAFRz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 12:55:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242455AbiAFRzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 12:55:25 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45C9DC061212
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 09:55:25 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id s127so4820854oig.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jan 2022 09:55:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=o/foTQodVBgucFBn3ZXK6eaXM/2HEpmwpEOS38R0Rek=;
        b=hSPPXlxyyC2hbirInmbjImCpaolGvJHLT9KFRGDIBcFrz3Y80wKjpkaTPBHchK9EIk
         PSckyZlYigING79StXqVL/Ouu92/C21UyDwwG+ll4MJIWxZU1NYAqESwjMJEusctC7ou
         ZEURei8f7xz/4Eo3e9J99cANW/ooDYTMt+p3WmHpHTw5pcXX8CQIt28e5cS/sXxjvnrz
         5fcXJAK5q7Z+40rj/jPt3LZtvrtjDmGCyypPlAZcrg+mxzoQgHNqcZ+AyO9Q62148Yuq
         2gjBZIldTpKVLD1bLmPpazjsJdQcFZjRO7Ns955K+ipsxALI9xpXpNPmXwkBCjFmjX5x
         uU7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=o/foTQodVBgucFBn3ZXK6eaXM/2HEpmwpEOS38R0Rek=;
        b=RezKE/ivOiR9DVSiRpbH4LzvC31/bHr/UJiGRWReiCeXzaoAJg6k2N3gA2cBeQ/TmY
         Lgc6LU8XxXaWRifhJW91OpHDZBCnQJCBu/sIqc0jqtv7xQtNQfTK2/upKUgJLXC42J+w
         KZiAlgxAma70RNYE5gDvgxU0RJyYgexDZbhtjzs6zwYE9KbdzJL5xiJB1bslKJM2khMD
         YAkG8pgghDeVPmFsMeD4q70Hu7vrC92eyZyhXi3lqYvPT0l1o1w1Hi/3yNprFVbGmnWD
         dnr//OuWQPZe4rDRRRsboloAgY53EEKzcwSyZM8yBMvLjVofoFZEBOwbQwK6DUom2Url
         +P8A==
X-Gm-Message-State: AOAM531HQoARj9f8P5UDgKIlZ7VHCVr4q29rr+8DaJTpuromm/Z4I3Ca
        1pRKVEchgBZ0gRWxDX4UKITlZQ==
X-Google-Smtp-Source: ABdhPJwfDQwmg+hs7VU/d33Ah9U7qOEmt0rKxDrLc243J4pADglOmvW5+20L18kjkmYeFF1HelWKSA==
X-Received: by 2002:a54:4014:: with SMTP id x20mr7154337oie.129.1641491724590;
        Thu, 06 Jan 2022 09:55:24 -0800 (PST)
Received: from ripper (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id z24sm463628otk.20.2022.01.06.09.55.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 09:55:24 -0800 (PST)
Date:   Thu, 6 Jan 2022 09:56:11 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>
Cc:     robdclark@gmail.com, sean@poorly.run, swboyd@chromium.org,
        vkoul@kernel.org, daniel@ffwll.ch, airlied@linux.ie,
        agross@kernel.org, dmitry.baryshkov@linaro.org,
        quic_abhinavk@quicinc.com, aravindh@codeaurora.org,
        quic_sbillaka@quicinc.com, freedreno@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] drm/msm/dp:  populate connector of struct  dp_panel
Message-ID: <YdctO7wMbTLVpJKn@ripper>
References: <1641489335-20975-1-git-send-email-quic_khsieh@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1641489335-20975-1-git-send-email-quic_khsieh@quicinc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 06 Jan 09:15 PST 2022, Kuogee Hsieh wrote:

> We never assign struct dp_panel::connector, instead the connector is
> stored in struct msm_dp::connector. When we run compliance testing test
> case 4.2.2.6 dp_panel_handle_sink_request() won't have a valid edid set

I unfortunately have no idea what test 4.2.2.6 is or how it ends up in
dp_panel_handle_sink_request() with panel->connector being NULL.

Your new commit message is much better, but I still would like to have
something describing why this particular test case triggers this bug,
how does it differ from normal execution, is it a race, does the test
involve failing edid reads???

> in struct dp_panel::edid so we'll try to use the connectors
> real_edid_checksum and hit a NULL pointer dereference error because the
> connector pointer is never assigned.
> 
> Changes in V2:
> -- populate panel connector at msm_dp_modeset_init() instead of at dp_panel_read_sink_caps()
> 
> Changes in V3:
> -- remove unhelpful kernel crash trace commit text
> -- remove renaming dp_display parameter to dp
> 
> Fixes: 7948fe12d47 ("drm/msm/dp: return correct edid checksum after corrupted edid checksum read")
> Signee-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_display.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> index 3449d3f..40a059d 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -1499,6 +1499,7 @@ int msm_dp_modeset_init(struct msm_dp *dp_display, struct drm_device *dev,
>  			struct drm_encoder *encoder)
>  {
>  	struct msm_drm_private *priv;
> +	struct dp_display_private *dp_priv;
>  	int ret;
>  
>  	if (WARN_ON(!encoder) || WARN_ON(!dp_display) || WARN_ON(!dev))
> @@ -1507,6 +1508,8 @@ int msm_dp_modeset_init(struct msm_dp *dp_display, struct drm_device *dev,
>  	priv = dev->dev_private;
>  	dp_display->drm_dev = dev;
>  
> +	dp_priv = container_of(dp_display, struct dp_display_private, dp_display);
> +
>  	ret = dp_display_request_irq(dp_display);
>  	if (ret) {
>  		DRM_ERROR("request_irq failed, ret=%d\n", ret);
> @@ -1524,6 +1527,8 @@ int msm_dp_modeset_init(struct msm_dp *dp_display, struct drm_device *dev,
>  		return ret;
>  	}
>  
> +	dp_priv->panel->connector = dp_display->connector;

The placement of this assignment in msm_dp_modeset_init() makes much
more sense than what you had in v1, so I think this looks good.

Thanks,
Bjorn

> +
>  	priv->connectors[priv->num_connectors++] = dp_display->connector;
>  	return 0;
>  }
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
