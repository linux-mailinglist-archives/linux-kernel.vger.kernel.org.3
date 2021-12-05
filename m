Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 754D7468905
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 05:05:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbhLEEIz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 23:08:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbhLEEIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 23:08:54 -0500
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36B42C0613F8
        for <linux-kernel@vger.kernel.org>; Sat,  4 Dec 2021 20:05:28 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id n17-20020a9d64d1000000b00579cf677301so9005845otl.8
        for <linux-kernel@vger.kernel.org>; Sat, 04 Dec 2021 20:05:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=AXzcZCKOBu/msJYDlg3Y+fzM95FhQ9eIvXKzuLg8CYs=;
        b=AmuNcydbQKjrjST36znuG6aIEps8lr+NEoZm8GTsEJRrucyjgTzlxRG5CWPEAF5zLI
         jQzT0P+RXN+fZz1zyegaxKmqkaob+q9Qx7NFgGzwYqMNNvPNLIv10p44avHxK1L5LOi3
         bygNpdX9oJMohTtI3RY5UtfKzoaa+WypyAjpg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=AXzcZCKOBu/msJYDlg3Y+fzM95FhQ9eIvXKzuLg8CYs=;
        b=Wpdg003S/DLdyOHdtg5VU1Wmvff9Yf6fGhsRjGUYpiD0W64gkOBDi/R4IHkgJltjpM
         jlApRD3rZo66rFWzoY0i1wMahblVdDbFqT6F11BnZz7wtAX0Pxb12ZDg/h0RkcPC/yS6
         XtoZIAXbyUL7JzNrE1dqGAp9LsJYgRVP7+mcBI19JgrNz3uy2QcWrEqP2svseszwh4Vv
         nh2VcvucwjOOJ9h0dMOFs2K0d3+nGO8NsMEzo0b9R0SpfFQpdX2cPY/j9KBt98kA8BS5
         0U/gg3x54jX7G8I+tQd7B9OMhJ+REQCZExwRHv8/EBa5RX0UIaOyDqLenu35Lff2JFi+
         ff2A==
X-Gm-Message-State: AOAM533Q0ikN6Ah9P8H+i2krhszRU55DVcvxaPjoG5kewvfZzmSs/CeQ
        kPu98fvyquMjHMe08yTXQdkXnskrJTT/zRU3J782Vw==
X-Google-Smtp-Source: ABdhPJxWcPtz+q1YJarR+oJWSUf3FTjY0xDPDQPv8K4vpWyix5KmjKghi6TmOgkMKNZ83F0NU4bIZDFmxzAfdegAiwA=
X-Received: by 2002:a9d:2243:: with SMTP id o61mr23402340ota.126.1638677127497;
 Sat, 04 Dec 2021 20:05:27 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 4 Dec 2021 20:05:27 -0800
MIME-Version: 1.0
In-Reply-To: <1638568959-7564-1-git-send-email-quic_khsieh@quicinc.com>
References: <1638568959-7564-1-git-send-email-quic_khsieh@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Sat, 4 Dec 2021 20:05:26 -0800
Message-ID: <CAE-0n51TZG9SjjOaNmNJPhzOZmQLsywcAT7_Vf4uz4VPga5xhw@mail.gmail.com>
Subject: Re: [PATCH] drm/msm/dp: Add "qcom,sc7280-dp" to support display port.
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>, agross@kernel.org,
        airlied@linux.ie, bjorn.andersson@linaro.org, daniel@ffwll.ch,
        dmitry.baryshkov@linaro.org, robdclark@gmail.com, sean@poorly.run,
        vkoul@kernel.org
Cc:     quic_abhinavk@quicinc.com, aravindh@codeaurora.org,
        quic_sbillaka@quicinc.com, freedreno@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Kuogee Hsieh (2021-12-03 14:02:39)
> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_display.c | 1 +
>  1 file changed, 1 insertion(+)

One nit

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

>
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> index d44f18b..91582d3 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -146,6 +146,7 @@ static const struct msm_dp_config sc7280_dp_cfg = {
>  static const struct of_device_id dp_dt_match[] = {
>         { .compatible = "qcom,sc7180-dp", .data = &sc7180_dp_cfg },
>         { .compatible = "qcom,sc7280-edp", .data = &sc7280_dp_cfg },
> +       { .compatible = "qcom,sc7280-dp", .data = &sc7280_dp_cfg },

The letter d comes before e so it would be better to sort this
alphanumerically and avoid conflicts later.
