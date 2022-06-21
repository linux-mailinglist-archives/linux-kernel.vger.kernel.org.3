Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C825552FF3
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 12:41:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348259AbiFUKk4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 06:40:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347324AbiFUKkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 06:40:53 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15D0828E27
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 03:40:51 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id t16so14673499qvh.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 03:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J0pHSWTmAqkhHPu3ewOMcrRY8+PhQnj0jfHcdTdRDz8=;
        b=R3GE8vGso5FRS+jJMjZddlY67ciEK0NtOwp1vMLp6WYzw0y3wH9uVEGbIa+l9roKRX
         eSK6mQEMo66vnDTwbEETiIzI8np+jeQVbf6+569W1HDwVhjFsnKUc1h/q02E5qLdsXln
         bUomPzqz9/w7zeoWTihKrSMU5vyRT0xn6T6Gi1Fy+wi2Fpa/La+VvjpJep1yoWsBiram
         Z95mhj6iVWCSAr2InYjymblYmKgKr+2IMrlpKLN8s6JghGQVuAbiv07Dv0XISr9zI2xj
         wHUgzu0en/bM0/EGHjMkfKrkP2Ppg/bWKLGcfRmD7cEVMmNdhaq65oWAxkdvaF9Xqf4w
         C4Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J0pHSWTmAqkhHPu3ewOMcrRY8+PhQnj0jfHcdTdRDz8=;
        b=na8JBCINAXrzxKhS53LhJzk5eGG2TvS/NQI72FnNHSXs2aC9lwDXiiK1BnlEji3BQ+
         y53XnBaPWzsehHa4WFdVwUe/B54/8fYmumTyfJD3ZT9gQNJ4A6EdrGXYaGVFGnxaOQGc
         gu1knecPvtHtkEXRZw0iZNgJZUmH/NRFBhbM0dx81h3YD3lE3wvZpQskX2RMx5jxR2wc
         Qab69VI+WGV3MGmRatBjDls7nhoFtbUDuQwbLGXb1tRekwx7ko938RtTZVkrz/5l7eHD
         n7YFV+FJ4WDg+nqVJum9N/y+5omMVgUZYltznDsy+EWPYpjESOL5SjRxIN12K2q2hlJO
         yijA==
X-Gm-Message-State: AJIora/JT+UoLEEO1bP80pqdWD6Mo/3W6x7LPBdwsD8TCA+/TkW3jsHf
        0M0HqKH9E8pESmJuXfpWhzXWqrijWTXcsc30+K0QCNrISMjV+g==
X-Google-Smtp-Source: AGRyM1urOiTfLmkkWIabUrLK/wKc4zU+J23cZPS1taggxWTn8VedAh7d2hubXG/NEdz5XLnEZWJHk8q7ZC9Z13NzqG8=
X-Received: by 2002:a05:622a:487:b0:304:fbfc:9933 with SMTP id
 p7-20020a05622a048700b00304fbfc9933mr23585690qtx.682.1655808050220; Tue, 21
 Jun 2022 03:40:50 -0700 (PDT)
MIME-Version: 1.0
References: <1655802387-15275-1-git-send-email-quic_kalyant@quicinc.com>
In-Reply-To: <1655802387-15275-1-git-send-email-quic_kalyant@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 21 Jun 2022 13:40:39 +0300
Message-ID: <CAA8EJpqon=3NQJo_jwbXJvvZ5FJJ9xO=k-f4ogNTaH83pbVOjQ@mail.gmail.com>
Subject: Re: [v1 1/2] drm/msm/disp/dpu1: add dspp support for sc7280
To:     Kalyan Thota <quic_kalyant@quicinc.com>
Cc:     y@qualcomm.com, dri-devel@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        robdclark@gmail.com, dianders@chromium.org, swboyd@chromium.org,
        quic_vpolimer@quicinc.com, quic_abhinavk@quicinc.com
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

On Tue, 21 Jun 2022 at 12:06, Kalyan Thota <quic_kalyant@quicinc.com> wrote:
>
> Add destination side post processing hw block support in sc7280.
>
> This hwblock enablement is necessary to support color features
> like CT Matix (Ex: Night Light feature)
>
> Change-Id: Iba7d5e1693b06cede2891f5b998466070a77c6ef
> Signed-off-by: Kalyan Thota <quic_kalyant@quicinc.com>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
> index a4fe77c..021eb2f 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
> @@ -928,7 +928,7 @@ static const struct dpu_lm_cfg sm8150_lm[] = {
>
>  static const struct dpu_lm_cfg sc7280_lm[] = {
>         LM_BLK("lm_0", LM_0, 0x44000, MIXER_SC7180_MASK,
> -               &sc7180_lm_sblk, PINGPONG_0, 0, 0),
> +               &sc7180_lm_sblk, PINGPONG_0, 0, DSPP_0),
>         LM_BLK("lm_2", LM_2, 0x46000, MIXER_SC7180_MASK,
>                 &sc7180_lm_sblk, PINGPONG_2, LM_3, 0),
>         LM_BLK("lm_3", LM_3, 0x47000, MIXER_SC7180_MASK,
> @@ -1792,6 +1792,8 @@ static void sc7280_cfg_init(struct dpu_mdss_cfg *dpu_cfg)
>                 .ctl = sc7280_ctl,
>                 .sspp_count = ARRAY_SIZE(sc7280_sspp),
>                 .sspp = sc7280_sspp,
> +               .dspp_count = ARRAY_SIZE(sc7180_dspp),
> +               .dspp = sc7180_dspp,
>                 .mixer_count = ARRAY_SIZE(sc7280_lm),
>                 .mixer = sc7280_lm,
>                 .pingpong_count = ARRAY_SIZE(sc7280_pp),
> --
> 2.7.4
>


-- 
With best wishes
Dmitry
