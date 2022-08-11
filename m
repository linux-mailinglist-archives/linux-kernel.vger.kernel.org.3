Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F301C58F6F4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 06:28:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233765AbiHKE2T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 00:28:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233838AbiHKE2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 00:28:16 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C9D13DBCE
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 21:28:15 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id e13so21445856edj.12
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 21:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kali.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=qutPgoHsh0aNCJy6BIy763iqIP4xzHSujrtPjVld1S4=;
        b=JC58/VnqGkEFxA8QdfMx6um+WZA77XEzMoUJ8+lZrQ9UY1GhAHWxQfnmx0PT/vTx1p
         YfAWwam3u+Xi+jpc/dPrSDdWgEMGFHb45OePgxBtTK+oA6lizgEDgE2F3z7LINwj4sUd
         ZhOuDWhqGrzhYtzFvUfIPsAw0BE6ErZU0ApqQ5cKSsiYuh1fB1AP3Db7sFYrrmuPhSsd
         HfcabtG5aZDGqED+MioGWEJ4B+3LhdWYzAV8Yo7hZ8AF8Atj8zuBa83ttJJuk904cC+I
         4FHX++Pnq4Xd42iIaJaIy+NMZebZKIU5Y2guizRdFAJPNQg6XXS2zzZ7B5O4jx7UqWzY
         NA0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=qutPgoHsh0aNCJy6BIy763iqIP4xzHSujrtPjVld1S4=;
        b=L/2jCE7/M+wy4WK4IYJVwae4Wr76m4hYq/BaTMH8sf7tk/OdZfPrYXPM5c7JWDE6dg
         JNyyBv4h4Inj+SJ6gLKBZdcEG8JIiiBoMpurAICWyw0k4kU07PaToGD18mpO+J0NJXop
         EwsABZJCpUofvKfEJWEOmIF1fM/CAE2fUc7yPPJYC7YKG3cjQ7aO5STakLzqu+EL2TGw
         KDLtUtVtmRXrGPj6+i00pqjlhHGDRN9u1clXBPkZ9ANHN3uDwE4jQ2QkOrg5fN6Exmdx
         aCm41OXAz13/h3wxjBrDmbPyNYublcovqNK1bVva5kON4F5/ZKJCrzgeyZWO8pthC8Go
         L2zQ==
X-Gm-Message-State: ACgBeo19InuoMiTdmOO8vPR3x9pumxuQ5HlA45AD3OzcGzWiGwGuy8id
        +rlb7mZg/J+RRZyDyhGLu3khA6proCnVHu3q9KvrMA==
X-Google-Smtp-Source: AA6agR5OCSm/LTkv0sym9nG7SAwBRmVM5H24o1M2VJPyeC3mXlp7Brw8D/MXOG8y0RYzCQi6N+I/5Lj2WwdI7nok9mg=
X-Received: by 2002:a05:6402:449a:b0:442:c81c:b938 with SMTP id
 er26-20020a056402449a00b00442c81cb938mr5079087edb.289.1660192093537; Wed, 10
 Aug 2022 21:28:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220811040121.3775613-1-bjorn.andersson@linaro.org> <20220811040121.3775613-4-bjorn.andersson@linaro.org>
In-Reply-To: <20220811040121.3775613-4-bjorn.andersson@linaro.org>
From:   Steev Klimaszewski <steev@kali.org>
Date:   Wed, 10 Aug 2022 23:28:02 -0500
Message-ID: <CAKXuJqhWn8bcG3x-xvyJ5-1kGXBVqCEuG31aHNidCqKA81NSqQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] drm/msm/dpu: Introduce SC8280XP
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,


On Wed, Aug 10, 2022 at 10:58 PM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> The Qualcomm SC8280XP platform contains DPU version 8.0.0, has 9
> interfaces, 2 DSI controllers and 4 DisplayPort controllers. Extend the
> necessary definitions and describe the DPU in the SC8280XP.
>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>
> Note that MSM_DP_CONTROLLER_3 is also defined in the DP series and as such a
> trivial conflict will occur when merging the latter of the two series.
>
>  .../gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c    | 211 ++++++++++++++++++
>  .../gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h    |   1 +
>  .../gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c |  18 ++
>  .../gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.h |   3 +
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h   |   2 +
>  drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c       |   1 +
>  drivers/gpu/drm/msm/msm_drv.h                 |   1 +
>  drivers/gpu/drm/msm/msm_mdss.c                |   2 +
>  8 files changed, 239 insertions(+)
>
<snip>
>
> diff --git a/drivers/gpu/drm/msm/msm_drv.h b/drivers/gpu/drm/msm/msm_drv.h
> index b3689a2d27d7..5978c6e26a1e 100644
> --- a/drivers/gpu/drm/msm/msm_drv.h
> +++ b/drivers/gpu/drm/msm/msm_drv.h
> @@ -55,6 +55,7 @@ enum msm_dp_controller {
>         MSM_DP_CONTROLLER_0,
>         MSM_DP_CONTROLLER_1,
>         MSM_DP_CONTROLLER_2,
> +       MSM_DP_CONTROLLER_3,
>         MSM_DP_CONTROLLER_COUNT,
>  };
>
This seems to also be part of
https://lore.kernel.org/r/20220810040745.3582985-6-bjorn.andersson@linaro.org
(but only th msm_drv.h hunk

>
> diff --git a/drivers/gpu/drm/msm/msm_mdss.c b/drivers/gpu/drm/msm/msm_mdss.c
> index e13c5c12b775..7c391fab6263 100644
> --- a/drivers/gpu/drm/msm/msm_mdss.c
> +++ b/drivers/gpu/drm/msm/msm_mdss.c
> @@ -208,6 +208,7 @@ static int msm_mdss_enable(struct msm_mdss *msm_mdss)
>                 writel_relaxed(0x420, msm_mdss->mmio + UBWC_STATIC);
>                 break;
>         case DPU_HW_VER_600:
> +       case DPU_HW_VER_800:
>                 /* TODO: 0x102e for LP_DDR4 */
>                 writel_relaxed(0x103e, msm_mdss->mmio + UBWC_STATIC);
>                 writel_relaxed(2, msm_mdss->mmio + UBWC_CTRL_2);
> @@ -445,6 +446,7 @@ static const struct of_device_id mdss_dt_match[] = {
>         { .compatible = "qcom,sc7180-mdss" },
>         { .compatible = "qcom,sc7280-mdss" },
>         { .compatible = "qcom,sc8180x-mdss" },
> +       { .compatible = "qcom,sc8280xp-mdss" },
>         { .compatible = "qcom,sm8150-mdss" },
>         { .compatible = "qcom,sm8250-mdss" },
>         {}
> --
> 2.35.1
>
-- steev
