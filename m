Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24EC04CE43E
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Mar 2022 11:38:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231418AbiCEKi5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Mar 2022 05:38:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231496AbiCEKiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Mar 2022 05:38:55 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75C8615A06
        for <linux-kernel@vger.kernel.org>; Sat,  5 Mar 2022 02:38:05 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id q4so8327891qki.11
        for <linux-kernel@vger.kernel.org>; Sat, 05 Mar 2022 02:38:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lz9u63IzQ1ny8p1MWQPaj5qIKrAWncsqwglKvPt7b18=;
        b=ureuxwwCPGYZzOPqWphv5EaO1kY1yEOA+OfcMXKh++Ta5PzP3Vqj41pK77KeSt1CKr
         oHiDbgZS3JHbshLxXF+pEYWSLCyWKXK/3lNXWTjopaR9vPXmmPkmu1OeG56DQVBJKixm
         r1cZRZJw0aXAtNVTrDkVjGhEATMpLEMgHw1s67JnIwIUkOTer5TKItbrALbdsagJRkso
         1vze8yvTmfCCdTYPrB4FmzaUBlrchxOnMSc8i6PM4to8Avv9Su3Z1nVYOaYiJ32b+cLI
         BpP5eGR4IFMfuig3q+aDiYLkT8Xi41yIKswVkI2IOnKqaxrgZyqMnvFpr7tWsXugSDJ6
         ri2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lz9u63IzQ1ny8p1MWQPaj5qIKrAWncsqwglKvPt7b18=;
        b=R7296uKMC6D5Y+JAGXjR2OxyIdsWV5Tb2v/eMSNv1xcgfwEA56psBorRJQlJ+Iw0Ik
         dVpI29J/7H2Q54WW3o24mijmdkNMBSw2rgwX6Cg5rtt1SCH2Cc4M6LBZ+mw+XTlAe7ja
         I0OC2M5tnzl+whYxG3WZrgmijOz0kuQ7P4D92zGwOseFl+Wm8NINDXTAli2WeQn4LI5a
         3aZSuEBPwfjME5NCpm2aTj2rtAzTpoyDC2BjO7mbGpTF2L+55tuHSmtgKNv0rdTjlGML
         L6/t+3oDbheHg3ByWzyR8app+QL9yNGsI2TxgBSHsf2kXXgSquE5MmXllg+Eic9umxdY
         7Zjw==
X-Gm-Message-State: AOAM533dJLBMr79o9VD59Yp3UZnDZOmtmHJvjoWa+FqxCgUS6LZJWoFR
        5wWMYNkydJ8Jr2fSAP/xqYu4tHlJUlSzTVzp3eZ9Uw==
X-Google-Smtp-Source: ABdhPJwhxXcWrkTJz60CRz6vpb74RSpT9uPgyqmT08HWXkR+SLRk4QdjvtxL/93LY0auGa7N0SvwegppCk4zzWi/9Z4=
X-Received: by 2002:a05:620a:1392:b0:60d:d76a:5073 with SMTP id
 k18-20020a05620a139200b0060dd76a5073mr1620167qki.59.1646476683364; Sat, 05
 Mar 2022 02:38:03 -0800 (PST)
MIME-Version: 1.0
References: <20220304202406.846485-1-robdclark@gmail.com> <CAA8EJprik57F+t0KicoYaRm=oDOgcQHyHSBjJKbekBKjO_-=0A@mail.gmail.com>
 <CAF6AEGtM+Jhye7ahW3uFg-8PFHH257-T7Qudo=XMU5-AU2LvcA@mail.gmail.com>
In-Reply-To: <CAF6AEGtM+Jhye7ahW3uFg-8PFHH257-T7Qudo=XMU5-AU2LvcA@mail.gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Sat, 5 Mar 2022 13:37:52 +0300
Message-ID: <CAA8EJpr3yDW=f4gc4d06KiETtNJkrLNaTcOx28UpS3toVOh6nw@mail.gmail.com>
Subject: Re: [PATCH] drm/msm/a6xx: Fix missing ARRAY_SIZE() check
To:     Rob Clark <robdclark@gmail.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Rob Clark <robdclark@chromium.org>,
        Sean Paul <sean@poorly.run>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Jonathan Marek <jonathan@marek.ca>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        open list <linux-kernel@vger.kernel.org>
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

On Sat, 5 Mar 2022 at 00:57, Rob Clark <robdclark@gmail.com> wrote:
>
> On Fri, Mar 4, 2022 at 1:47 PM Dmitry Baryshkov
> <dmitry.baryshkov@linaro.org> wrote:
> >
> > On Fri, 4 Mar 2022 at 23:23, Rob Clark <robdclark@gmail.com> wrote:
> > >
> > > From: Rob Clark <robdclark@chromium.org>
> > >
> > > Fixes: f6d62d091cfd ("drm/msm/a6xx: add support for Adreno 660 GPU")
> > > Signed-off-by: Rob Clark <robdclark@chromium.org>
> >
> > Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > However see the comment below.
> >
> > > ---
> > >  drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> > > index 02b47977b5c3..6406d8c3411a 100644
> > > --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> > > +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> > > @@ -687,6 +687,7 @@ static void a6xx_set_cp_protect(struct msm_gpu *gpu)
> > >
> > >         BUILD_BUG_ON(ARRAY_SIZE(a6xx_protect) > 32);
> > >         BUILD_BUG_ON(ARRAY_SIZE(a650_protect) > 48);
> > > +       BUILD_BUG_ON(ARRAY_SIZE(a660_protect) > 48);
> >
> > The magic number 32 and 48 are repeated through this code. I'd suggest
> > to define them and use defined names.
> > It can come up as a separate commit.
> >
>
> Or perhaps instead:

IMO this is much better.
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ----
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> index 6406d8c3411a..58c371930fb4 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> @@ -683,20 +683,23 @@ static void a6xx_set_cp_protect(struct msm_gpu *gpu)
>  {
>         struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
>         const u32 *regs = a6xx_protect;
> -       unsigned i, count = ARRAY_SIZE(a6xx_protect), count_max = 32;
> -
> -       BUILD_BUG_ON(ARRAY_SIZE(a6xx_protect) > 32);
> -       BUILD_BUG_ON(ARRAY_SIZE(a650_protect) > 48);
> -       BUILD_BUG_ON(ARRAY_SIZE(a660_protect) > 48);
> +       unsigned i, count, count_max;
>
>         if (adreno_is_a650(adreno_gpu)) {
>                 regs = a650_protect;
>                 count = ARRAY_SIZE(a650_protect);
>                 count_max = 48;
> +               BUILD_BUG_ON(ARRAY_SIZE(a650_protect) > 48);
>         } else if (adreno_is_a660_family(adreno_gpu)) {
>                 regs = a660_protect;
>                 count = ARRAY_SIZE(a660_protect);
>                 count_max = 48;
> +               BUILD_BUG_ON(ARRAY_SIZE(a660_protect) > 48);
> +       } else {
> +               regs = a6xx_protect;
> +               count = ARRAY_SIZE(a6xx_protect);
> +               count_max = 32;
> +               BUILD_BUG_ON(ARRAY_SIZE(a6xx_protect) > 32);
>         }
>
>         /*
> ----
>
> that moves each of the two uses of constant together..  adding three
> #defines each used only twice seems a bit silly, IMHO
>
> BR,
> -R



-- 
With best wishes
Dmitry
