Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B6B24DBF0D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 07:13:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbiCQGOc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 02:14:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbiCQGOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 02:14:20 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BD52160169
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 22:51:58 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id o106-20020a9d2273000000b005b21f46878cso2894636ota.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 22:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mVK6yG1N+cUUmYWJ6VDT2FBBH+Bt39KheCAm4I/IFoU=;
        b=HqgLE2UhXsyEjjV27aBFaUHc/bInHEQ6a2qWWJ2gFJ4YWeT6x70E62GT9/SNxpS9BC
         hVboR/wsog/4J2eHJHvsx6BRtcvbNmhebS3IuNwj/56vdBlmhF9alw6tf/MW9O+b3RRO
         IFeD9fcfrdcx8tKUrqMqW8F9nbw1jVhMIR2GXW0YqLiSDZZNQzGL5xV++DV0tj1Fy7nu
         wOvwU0fH4eEcHPdKmN5/7ogJF3I69DNPFknjwwN0xH64UxRDlC/uxEqOg3MfK6L/m7r9
         95LgtI00CYke9yaqaZfRxFn12B/rP7IRU4Te25vjCvez+/gxB1OvbcZ5aq8Ew/0yzmTQ
         rQXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mVK6yG1N+cUUmYWJ6VDT2FBBH+Bt39KheCAm4I/IFoU=;
        b=yYIiowpaOMME6CJP8mLJNPqeaf8sI6GuOiRKq36SNvsGFsg8xLKUIrRU9kU4MZYTbC
         anup2mtkzdr9dJHjJiTTgR0ktvq1nSpwsm+Mvx4azyopzIzbEdCQ4hrqJ65GLV6ZhokZ
         W6uI2tRyRYuBy7xpOGvaUrbXzx8Vv/YEcMPVksC0PNIKKgIwIAJt89Mh/VisV7MfW7G1
         jfURpAZZLjk4mCeM/oSDlEDSNnJOHRQC+MluUt7er+aeEklsAoX9PjU2JqdBJP+NNfwM
         pCMRQJxJFEQKdKhH9Zt/IJlrrZ/6iPSRqI+bjITnnZnExJPZ0xYK6TvWt1NhYOr5YNFB
         Y25g==
X-Gm-Message-State: AOAM532jTQtY1AKz42Q26vHbyyWZNYpT/Qae8Bt4M794GlfE/3viGQWt
        ZITeQ3+mhYShRfgPLfLjoQkkYIIXYx92VR4KecaWMg==
X-Google-Smtp-Source: ABdhPJy76ekb2NCVSFjRseDkxr8YndloWbyFI2Kene2D11LYpSoDDR+0DsqVEoxwIJtDNmrqYXTmeWkJlfA18gm9Vd0=
X-Received: by 2002:a05:6830:c7:b0:5c9:6536:5b96 with SMTP id
 x7-20020a05683000c700b005c965365b96mr1086862oto.28.1647496317475; Wed, 16 Mar
 2022 22:51:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220226184028.111566-1-bhupesh.sharma@linaro.org>
 <20220226184028.111566-4-bhupesh.sharma@linaro.org> <YjC8bfY2U1WyV8FY@builder.lan>
In-Reply-To: <YjC8bfY2U1WyV8FY@builder.lan>
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
Date:   Thu, 17 Mar 2022 11:21:46 +0530
Message-ID: <CAH=2NtzHfqiFi8NKqQ=m24buzVsMT392ObOQ6ahT5BXB=fv6Hw@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] arm64: dts: qcom: sm8150: Add pdc interrupt
 controller node
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, bhupesh.linux@gmail.com,
        agross@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, maz@kernel.org,
        quic_mkshah@quicinc.com, linux-gpio@vger.kernel.org,
        linus.walleij@linaro.org, robh+dt@kernel.org,
        Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>
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

Hi Bjorn,

Thanks for your review.

On Tue, 15 Mar 2022 at 21:48, Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> On Sat 26 Feb 12:40 CST 2022, Bhupesh Sharma wrote:
>
> > Add pdc interrupt controller for sm8150.
> >
> > Cc: Maulik Shah <quic_mkshah@quicinc.com>
> > Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> > Cc: Vinod Koul <vkoul@kernel.org>
> > Cc: Rob Herring <robh@kernel.org>
> > Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> > ---
> >  arch/arm64/boot/dts/qcom/sm8150.dtsi | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
> > index 6012322a5984..aaeacd379460 100644
> > --- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
> > @@ -1626,6 +1626,16 @@ system-cache-controller@9200000 {
> >                       interrupts = <GIC_SPI 582 IRQ_TYPE_LEVEL_HIGH>;
> >               };
> >
> > +             pdc: interrupt-controller@b220000 {
> > +                     compatible = "qcom,sm8150-pdc", "qcom,pdc";
> > +                     reg = <0 0x0b220000 0 0x400>;
> > +                     qcom,pdc-ranges = <0 480 94>, <94 609 31>,
> > +                                       <125 63 1>;
>
> When I look at the platform documentation I get the impression that this
> should be: <0 480 94>, <94 609 32>;
>
> Can you confirm that the last signal is correctly described?

Yes, I confirmed by double checking the entries in downstream 'pdc-sm8150.c'.
The pdc pins in the 2nd range start from 94 and end at 124, so a total
of 31 entries, but both 94 and 124 pins included.

Or, am I missing something?

Thanks,
Bhupesh

> > +                     #interrupt-cells = <2>;
> > +                     interrupt-parent = <&intc>;
> > +                     interrupt-controller;
> > +             };
> > +
> >               ufs_mem_hc: ufshc@1d84000 {
> >                       compatible = "qcom,sm8150-ufshc", "qcom,ufshc",
> >                                    "jedec,ufs-2.0";
> > --
> > 2.35.1
> >
