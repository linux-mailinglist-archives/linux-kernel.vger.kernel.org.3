Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A30314BABFE
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 22:44:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343705AbiBQVop (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 16:44:45 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244859AbiBQVoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 16:44:44 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64E37F47EB
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 13:44:26 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id g24so6093374qkl.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 13:44:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5Rr98hn7oiLwb3sXhDwP8hg9nXg3EcyZrzHqqe01vCc=;
        b=wDX+ftq8p+8jCvPhoDUIKpyHez2FGPXGflM+13rCN6II1W7Twta88jBt9Vh6AXzA9+
         lB3wcNhgtT25fEv1/4LUmh46Qkgt8dPgIAPXH39QFtsWAV08PeWR70fJGDszVZKpmy8N
         bBT9z3/p568CaqdB40b6uiGxrCA0IW5m5paj/kEqIrvzoMOcJxZwPumgOfzdZSyNED1a
         VOTfeQPdXgU1qwv6PGPRQOLuwypQpqDNq2U7R+Si/701OldJ2QSkvJNpQj2opO1n3rc1
         97r9oMOdjUASWzGt3K+fw9hY/icpqFoOvdqa1rePx3SEU5ABhPICmxpLYKFPzntDIJNo
         4myw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5Rr98hn7oiLwb3sXhDwP8hg9nXg3EcyZrzHqqe01vCc=;
        b=f5KrfCLbkf1NvKBeJnWD1gc2gIjrknNgb1kCjdFm0nu7wkl8j9qkufgkYngSnNjnoB
         vEuFSnLpHe1Wj5iGp6L1d7uMauhd7amaxR7tloDVjBuSpbZs+dWprUvwLDArwf2k/8KV
         filKN/LV44lOubK4L30N/BPd/AY9dCFqG+REMqfQMWddb9ja4JFWJ8dN9OO+4q/MKlng
         /ceekhhyQl6vzoetpRsxbYvZbS8wmuGDpyzIAc1qeQCZp6e5K9f/mF7AUuqG277hDPEo
         Hkm0Rv7z5pSk2eUizq0r92YlkBUSCVtFmgmgY8sVlK91OfCvXM+LubUQHrV+jZ0Nro7Q
         pt5w==
X-Gm-Message-State: AOAM533bn82sQhFLff0rjgvZc1SM9K228dTInxV2XXykiE7QV6AEvRXw
        0BUqKC5ro243BhjAYAOUHy7saOXJWbcXpSIY8C66Xw==
X-Google-Smtp-Source: ABdhPJwLUI59eFj6lZZDKPgP4ChCLwHjm29xnX5XQmsVjKzi21hEk4rXhMhPTrxHPZZGxIDxkpvEgBRHkaYoHyLrbm0=
X-Received: by 2002:a05:620a:4307:b0:507:d5b1:f65e with SMTP id
 u7-20020a05620a430700b00507d5b1f65emr2849018qko.363.1645134265492; Thu, 17
 Feb 2022 13:44:25 -0800 (PST)
MIME-Version: 1.0
References: <1645133788-5057-1-git-send-email-quic_khsieh@quicinc.com> <1645133788-5057-3-git-send-email-quic_khsieh@quicinc.com>
In-Reply-To: <1645133788-5057-3-git-send-email-quic_khsieh@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Fri, 18 Feb 2022 00:44:14 +0300
Message-ID: <CAA8EJposi1jVw+N7AsuHX8An44K-MiwpsOauY7FHRj5wnBBKMw@mail.gmail.com>
Subject: Re: [PATCH v8 2/4] drm/msm/dpu: replace BIT(x) with correspond marco
 define string
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>
Cc:     dri-devel@lists.freedesktop.org, robdclark@gmail.com,
        sean@poorly.run, swboyd@chromium.org, vkoul@kernel.org,
        daniel@ffwll.ch, airlied@linux.ie, agross@kernel.org,
        bjorn.andersson@linaro.org, quic_abhinavk@quicinc.com,
        quic_aravindh@quicinc.com, quic_sbillaka@quicinc.com,
        freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Feb 2022 at 00:36, Kuogee Hsieh <quic_khsieh@quicinc.com> wrote:
>
> To improve code readability, this patch replace BIT(x) with
> correspond register bit define string
>
> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c
> index 284f561..c2cd185 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c
> @@ -60,6 +60,12 @@
>
>  #define   INTF_MUX                      0x25C
>
> +#define INTF_CFG_ACTIVE_H_EN   BIT(29)
> +#define INTF_CFG_ACTIVE_V_EN   BIT(30)
> +
> +#define INTF_CFG2_DATABUS_WIDEN        BIT(0)
> +#define INTF_CFG2_DATA_HCTL_EN BIT(4)
> +
>  static const struct dpu_intf_cfg *_intf_offset(enum dpu_intf intf,
>                 const struct dpu_mdss_cfg *m,
>                 void __iomem *addr,
> @@ -130,13 +136,13 @@ static void dpu_hw_intf_setup_timing_engine(struct dpu_hw_intf *ctx,
>
>         if (active_h_end) {
>                 active_hctl = (active_h_end << 16) | active_h_start;
> -               intf_cfg |= BIT(29);    /* ACTIVE_H_ENABLE */
> +               intf_cfg |= INTF_CFG_ACTIVE_H_EN;
>         } else {
>                 active_hctl = 0;
>         }
>
>         if (active_v_end)
> -               intf_cfg |= BIT(30); /* ACTIVE_V_ENABLE */
> +               intf_cfg |= INTF_CFG_ACTIVE_V_EN;
>
>         hsync_ctl = (hsync_period << 16) | p->hsync_pulse_width;
>         display_hctl = (hsync_end_x << 16) | hsync_start_x;
> @@ -182,7 +188,7 @@ static void dpu_hw_intf_setup_timing_engine(struct dpu_hw_intf *ctx,
>                                 (0x21 << 8));
>
>         if (ctx->cap->features & BIT(DPU_DATA_HCTL_EN)) {
> -               intf_cfg2 |= BIT(4);
> +               intf_cfg2 |= INTF_CFG2_DATA_HCTL_EN;
>                 display_data_hctl = display_hctl;
>                 DPU_REG_WRITE(c, INTF_CONFIG2, intf_cfg2);
>                 DPU_REG_WRITE(c, INTF_DISPLAY_DATA_HCTL, display_data_hctl);
> --
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
>


-- 
With best wishes
Dmitry
