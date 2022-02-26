Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1032B4C5771
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 19:27:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232257AbiBZS1s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 13:27:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230237AbiBZS1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 13:27:46 -0500
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2DE01C1EEA
        for <linux-kernel@vger.kernel.org>; Sat, 26 Feb 2022 10:27:10 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id l21-20020a056830239500b005afd2a7eaa2so3342906ots.9
        for <linux-kernel@vger.kernel.org>; Sat, 26 Feb 2022 10:27:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3jtsbTUt6V38pFt8n1sHbB9pg1mHTnabw6ltzIZs8Sg=;
        b=PJdvdyGDQwqh2VpXzxHWkm0p3uewn0h/C1v1R8Fge+1c3Ew4RyGG4ql1sICwSa4f1W
         e1ZKpOkJHZwE9JOSl7QzOJ4rbhpI30ZAonB3Ja83VEewI2lpiSGbdyhXEpzkEWgaK/Nj
         AmtbtOe5eo7nK088NeIGqx6bVIjTrGkLFDH9Wm6BRw9cb5rS8IM6Fxn4IGvsHe4r8XrR
         8ePrsxVJBtP3GECuuMgoGuofe9bZB9e3+J1Acn56EkneXb2wjDaCjLn/hAFYxH/NNvDk
         XtTjOVIa4HumJA2IKKcgEmOxSNv0ES+cOl21/Cb4zH/+44A+d5lFoH+A9OqVS6P/DScd
         jDOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3jtsbTUt6V38pFt8n1sHbB9pg1mHTnabw6ltzIZs8Sg=;
        b=dZ68ZUM/7Zus+R4/E3cPOSr/F5FcXYPyEnPsGU4WlrL3NBU5U6AWPPvGdUr6THsMC0
         L/zgGsTob+VQs62tZ0LyP9clUcNufNIrOmFrBTzgTCO2X7RlJJ0TDVPAyFM2qz1GQJBt
         xRqYxE3C9AMGcXD5MgExVelb+sRwJhkN1fBvlv3ChPUT4c7gh32HDlPn+4OSmRIcqDiR
         3yCAgXsrMSBP/RO9YAAbEavaiazE5zTwoYYiiYWhZPLC/nlGWzV9hxkqjiD98+H5iLyJ
         Q0l8N9xrkDpd0XkQ16KUQsCELFzkcm7twLI8hEJiR00fLC8FUpgWt8awa4qiH5tlo0FZ
         BViA==
X-Gm-Message-State: AOAM531IgMLPnQZrx6mtxdcL8UAKnGNi7Xy7+9EMRwYUuufiJeatmOpI
        TE1dELnOfn0xLuEdw6/114k+zhL6kx839aAUw46T7g==
X-Google-Smtp-Source: ABdhPJwOCKbNzdzYQ6+jQrfMQxqQS9Q3xEvMM97sUzRGrz+RIev6FhgflWcrd307WHoY0AwX79me4MqFX4Z/UCsXEb0=
X-Received: by 2002:a05:6830:55d:b0:5ac:ebf8:6d95 with SMTP id
 l29-20020a056830055d00b005acebf86d95mr5503416otb.162.1645900029933; Sat, 26
 Feb 2022 10:27:09 -0800 (PST)
MIME-Version: 1.0
References: <20220119203133.467264-1-bhupesh.sharma@linaro.org>
 <20220119203133.467264-3-bhupesh.sharma@linaro.org> <2f208798-2ec5-4c29-1362-0de102f29718@quicinc.com>
In-Reply-To: <2f208798-2ec5-4c29-1362-0de102f29718@quicinc.com>
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
Date:   Sat, 26 Feb 2022 23:56:59 +0530
Message-ID: <CAH=2NtxbZf3_O2SwyQgUi1NxrdytyZuZrk+hUVOTeZHsvJVFVw@mail.gmail.com>
Subject: Re: [PATCH 2/4] pinctrl: qcom: sm8150: Specify PDC map
To:     Maulik Shah <quic_mkshah@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, bhupesh.linux@gmail.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, linux-gpio@vger.kernel.org,
        linus.walleij@linaro.org, bjorn.andersson@linaro.org
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

Hi,

Thanks for the review and sorry for the late reply.

On Thu, 20 Jan 2022 at 16:24, Maulik Shah <quic_mkshah@quicinc.com> wrote:
>
> Hi,
>
> On 1/20/2022 2:01 AM, Bhupesh Sharma wrote:
> > Specify the PDC mapping for SM8150, so that gpio interrupts are
> > propertly mapped to the wakeup IRQs of the PDC.
>
> s/propertly/properly

Ok.

> > Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> > Cc: Linus Walleij <linus.walleij@linaro.org>
> > Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> > ---
> >   drivers/pinctrl/qcom/pinctrl-sm8150.c | 21 +++++++++++++++++++++
> >   1 file changed, 21 insertions(+)
> >
> > diff --git a/drivers/pinctrl/qcom/pinctrl-sm8150.c b/drivers/pinctrl/qcom/pinctrl-sm8150.c
> > index 7359bae68c69..499dd05c3e3d 100644
> > --- a/drivers/pinctrl/qcom/pinctrl-sm8150.c
> > +++ b/drivers/pinctrl/qcom/pinctrl-sm8150.c
> > @@ -1500,6 +1500,25 @@ static const struct msm_pingroup sm8150_groups[] = {
> >       [178] = SDC_QDSD_PINGROUP(sdc2_data, 0xB2000, 9, 0),
> >   };
> >
> > +static const struct msm_gpio_wakeirq_map sm8150_pdc_map[] = {
> > +     { 3, 31 }, { 5, 32 }, { 8, 33 }, { 9, 34 }, { 10, 100 },
> > +     { 12, 104 }, { 24, 37 }, { 26, 38 }, { 27, 41 }, { 28, 42 },
> > +     { 30, 39 }, { 36, 43 }, { 37, 44 }, { 38, 30 }, { 39, 118 },
> > +     { 39, 125 },
> GPIO 39 is duplicated. 39 is used with 118 PDC interrupt in downstream.
> so { 39, 125 } can be removed.
> > { 41, 47 }, { 42, 48 }, { 46, 50 }, { 47, 49 },
> > +     { 48, 51 }, { 49, 53 }, { 50, 52 }, { 51, 116 }, { 51, 123 },
> GPIO 51 is duplicated. 51 is used with 116 PDC interrupt in downstream
> so { 51, 123 } can be removed
> > +     { 53, 54 }, { 54, 55 }, { 55, 56 }, { 56, 57 }, { 58, 58 },
> > +     { 60, 60 }, { 61, 61 }, { 68, 62 }, { 70, 63 }, { 76, 71 },
> > +     { 77, 66 }, { 81, 64 }, { 83, 65 }, { 86, 67 }, { 87, 84 },
> > +     { 88, 117 }, { 88, 124 }, { 90, 69 }, { 91, 70 }, { 93, 75 },
> > +     { 95, 72 }, { 96, 73 }, { 97, 74 }, { 101, 40 }, { 103, 77 },
> > +     { 104, 78 }, { 108, 79 }, { 112, 80 }, { 113, 81 }, { 114, 82 },
> > +     { 117, 85 }, { 118, 101 }, { 119, 87 }, { 120, 88 }, { 121, 89 },
> > +     { 122, 90 }, { 123, 91 }, { 124, 92 }, { 125, 93 }, { 129, 94 },
> > +     { 132, 105 }, { 133, 83 }, { 134, 36 }, { 136, 97 }, { 142, 103 },
> > +     { 144, 115 }, { 144, 122 }, { 147, 102 }, { 150, 107 },
> > +     { 152, 108 }, { 153, 109 }
> > +};
> > +
> >   static const struct msm_pinctrl_soc_data sm8150_pinctrl = {
> >       .pins = sm8150_pins,
> >       .npins = ARRAY_SIZE(sm8150_pins),
> > @@ -1510,6 +1529,8 @@ static const struct msm_pinctrl_soc_data sm8150_pinctrl = {
> >       .ngpios = 176,
> >       .tiles = sm8150_tiles,
> >       .ntiles = ARRAY_SIZE(sm8150_tiles),
> > +     .wakeirq_map = sm8150_pdc_map,
> > +     .nwakeirq_map = ARRAY_SIZE(sm8150_pdc_map),
>
> On SM8150 need to set .wakeirq_dual_edge_errata = true, similar to sc7180.

Sure, I will fix this in v2.

Regards,
Bhupesh
