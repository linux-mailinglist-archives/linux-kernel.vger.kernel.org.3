Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F107A49A862
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 05:11:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1318394AbiAYDFg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 22:05:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S3415624AbiAYBuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 20:50:07 -0500
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ECCBC0617A3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 17:50:07 -0800 (PST)
Received: by mail-ot1-x331.google.com with SMTP id n6-20020a9d6f06000000b005a0750019a7so3165782otq.5
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 17:50:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=wUEHk84PPSq5TMcst7Q46Xs07T+hDbMqqFuqhOeSN4c=;
        b=HRToCcScCB2MmK94C4zwwPCL+sRf7G/Qg7BbMZj7V8W7nnP+AvEK28dFClVAdHckcq
         XRvwkazFnxqQjxDnh75dW4WM7LVg34SZWkKfmnQBKScjJ6Knoo5L3b5YxHgyi5e1YLBg
         4FiPnFZ5jL/oipIjK6GjFdOdpgPJrn8KgFlhI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=wUEHk84PPSq5TMcst7Q46Xs07T+hDbMqqFuqhOeSN4c=;
        b=arQBlny3HgDgNS2pklnXzlnzGHTLOyc+gYc4fEWFhEqjUftXGo7Zpjinvw4GFEUb0n
         aDI6UbKCJfzntb4RqgNU/+d9+q/d48QhTclL2pDf3SOwNInR1F4d6f1Mwe2RjswDIP8O
         g5AyrX4YkEBumIKVsA40aLIVGB9zAghEz14NbA34j4r1+1uiGO2hohsqMt4NRWJF/E5L
         xh+cbN6m3v0oqWMig9IX42CoWeMxsOzF+CbRNguToOVJhzznoEJVxPYD2l+3cHcb7Wjy
         aBZHyEnYZlxTOFplWCHEsURTbSmZiKQx3sHHTX0meifpCT7GX/xAmGaIR8r339SVHGkG
         +5wA==
X-Gm-Message-State: AOAM531RdVCmSJ0Tc6lK+Jg5EnWqVNWDRlPWwuCJzEfcCl3zaj84oQUh
        95KJvC9ZunjyEKwJa+5uMqhnG83RoU6fiLhCqjWQ5g==
X-Google-Smtp-Source: ABdhPJywHOsm6rxOv2ws+sHjp3srUtW0vaJGy7NiC9Hr/q913lcg5jyP3m/ecMVqRlFiPi0CJdg2jcKD4Q6Mx8vRJKU=
X-Received: by 2002:a05:6830:30ba:: with SMTP id g26mr6860402ots.159.1643075406598;
 Mon, 24 Jan 2022 17:50:06 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 24 Jan 2022 17:50:06 -0800
MIME-Version: 1.0
In-Reply-To: <1643064292-6965-1-git-send-email-quic_khsieh@quicinc.com>
References: <1643064292-6965-1-git-send-email-quic_khsieh@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Mon, 24 Jan 2022 17:50:06 -0800
Message-ID: <CAE-0n505fYR1zpgZnC=J7WSxp_gpn6mnda9TuVjmJD8vMRn2Rg@mail.gmail.com>
Subject: Re: [PATCH] drm/msm/dp: add connector type to enhance debug messages
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>, agross@kernel.org,
        airlied@linux.ie, bjorn.andersson@linaro.org, daniel@ffwll.ch,
        dmitry.baryshkov@linaro.org, robdclark@gmail.com, sean@poorly.run,
        vkoul@kernel.org
Cc:     quic_abhinavk@quicinc.com, aravindh@codeaurora.org,
        freedreno@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Kuogee Hsieh (2022-01-24 14:44:52)
> DP driver is a generic driver which supports both eDP and DP.
> For debugging purpose it is required to have capabilities to
> differentiate message are generated from eDP or DP. This patch
> add connector type into debug messages for this purpose.
>
> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_ctrl.c    | 20 +++++------
>  drivers/gpu/drm/msm/dp/dp_display.c | 71 ++++++++++++++++++++++++++-----------
>  2 files changed, 60 insertions(+), 31 deletions(-)
>
> diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
> index 245e1b9..dcd0126 100644
> --- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
> +++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
> @@ -1396,6 +1396,8 @@ void dp_ctrl_phy_init(struct dp_ctrl *dp_ctrl)
>
>         dp_catalog_ctrl_phy_reset(ctrl->catalog);
>         phy_init(phy);
> +       DRM_DEBUG_DP("phy=%p init=%d power_on=%d\n",
> +                       phy, phy->init_count, phy->power_count);
>  }
>
>  void dp_ctrl_phy_exit(struct dp_ctrl *dp_ctrl)
> @@ -1410,6 +1412,8 @@ void dp_ctrl_phy_exit(struct dp_ctrl *dp_ctrl)
>
>         dp_catalog_ctrl_phy_reset(ctrl->catalog);
>         phy_exit(phy);
> +       DRM_DEBUG_DP("phy=%p init=%d power_on=%d\n",
> +                       phy, phy->init_count, phy->power_count);
>  }
>
>  static bool dp_ctrl_use_fixed_nvid(struct dp_ctrl_private *ctrl)
> @@ -1484,6 +1488,8 @@ static int dp_ctrl_deinitialize_mainlink(struct dp_ctrl_private *ctrl)
>         phy_exit(phy);
>         phy_init(phy);
>
> +       DRM_DEBUG_DP("phy=%p init=%d power_on=%d\n",
> +                       phy, phy->init_count, phy->power_count);
>         return 0;
>  }
>

These are entirely new messages. Adding messages isn't mentioned in the
commit text. Please either split this out or indicate in the commit text
what's going on here.

> @@ -1895,14 +1901,12 @@ int dp_ctrl_off_link_stream(struct dp_ctrl *dp_ctrl)
>
>         phy_power_off(phy);
>
> -       DRM_DEBUG_DP("After, phy=%x init_count=%d power_on=%d\n",
> -               (u32)(uintptr_t)phy, phy->init_count, phy->power_count);
> -
>         /* aux channel down, reinit phy */
>         phy_exit(phy);
>         phy_init(phy);
>
> -       DRM_DEBUG_DP("DP off link/stream done\n");
> +       DRM_DEBUG_DP("phy=%p init=%d power_on=%d\n",

The DRM_DEBUG_DP macro says it's deprecated now and we should use
drm_dbg_dp() instead. Can you use that macro instead? Then it looks like
drm->dev can actually be any old struct device, so I guess we're allowed
to pass in the particular instance of dp device this is for. Allowing us
to figure out which DP device is actually printing messages.

> +                       phy, phy->init_count, phy->power_count);
>         return ret;
>  }
>
