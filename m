Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6939A5687B2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 14:03:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232099AbiGFMCL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 08:02:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231549AbiGFMCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 08:02:05 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0950B29C9A
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 05:02:03 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id ay10so17808672qtb.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 05:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GS+uFCqn73s3FUnXQGK+mJpwi26ezGNzDSPMuucFva8=;
        b=C1PEfoHu1JZutIhSBq7xyrTzSwdP6gfzqlbmYagZ6SO614AVCSvZuTG/YcopNih2u0
         XXZH06tjN/7HwT05MgoOtpKdZc8oBLn7RLDLCt5cjTeM5lb6gpuKj+2d7uLQXMnuvX3i
         wde7KD1Sv+YJl6PQ/byNoahvr0JX4PqEliAiGIwbso/soQMekhN0iDCes1q2wpwhil4A
         qWK6iHx1rd7r15nqFvFUJSefPwMIOTum21ZrKCZ3TdAeKdX7xqfXghTIDvA9LHIf/Pur
         HVAKjbv4je6GQwD13gprqb87kpQq8AjACvJVJSfZtJFwyb3sO7iaVNEoXXSOkX9z/ufc
         /o4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GS+uFCqn73s3FUnXQGK+mJpwi26ezGNzDSPMuucFva8=;
        b=j6iIQ21FUE/O9Pzhu//2YUu5jh9A0OJmxJPVbn7pnaD7trZ6ZXIADnztONK1MZLL/s
         OfcZ40O16N6++Z5tjyMMhllsMHwD6TzDGB4O2EZBq0da/K/scM1BtUnFj1+DC4J8vf1Z
         scqG9cdjkcvYNL+7oalDS+u88xsvnaYCvuOcvSMy0eiSdBRrz0j87rbpTA1LNAv8VjVA
         7Fej0+eXRc9YYVFlgj8Aj1bqPSHdqS+5hzILsFSuBUtcACRABFV47FnIcgDYhZsd8mQv
         RziA7sv3E3augkN3hYNNKvWM7v8WtBg+ytH8Bjftqy5VTQkc5WzdJYwy7dzE4yJn+2wH
         PITw==
X-Gm-Message-State: AJIora9DWWTq2A89n3szXsWrV9ECe7wNWmJGBByEHjZwdPbsvIZ3/BwG
        FTI6v8oJPhPNX+f69e30hXXOocUt23Lb5ekyXdZfPA==
X-Google-Smtp-Source: AGRyM1tF1EnvSFKXQDug6KASOTgwF0P8AMmoLtvHbfrVH6CtHl3jRQNThamLYnI3w6qH79JwwlKN3CNfi8dZU5i5lMU=
X-Received: by 2002:ad4:5f8a:0:b0:473:2108:7fe0 with SMTP id
 jp10-20020ad45f8a000000b0047321087fe0mr1081454qvb.115.1657108921700; Wed, 06
 Jul 2022 05:02:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220705133917.8405-1-ansuelsmth@gmail.com> <20220705133917.8405-10-ansuelsmth@gmail.com>
 <c5bf6246-a350-8a87-71bc-bc13d502a8af@linaro.org> <62c56477.1c69fb81.8ec4c.f1ac@mx.google.com>
In-Reply-To: <62c56477.1c69fb81.8ec4c.f1ac@mx.google.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Wed, 6 Jul 2022 15:01:50 +0300
Message-ID: <CAA8EJpoUcSrOU=emcqanUd0PRuToZsSB1x=oGzcvjtMMVjhSvQ@mail.gmail.com>
Subject: Re: [PATCH 09/13] ARM: dts: qcom: add smem node for ipq8064
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jonathan McDowell <noodles@earth.li>
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

On Wed, 6 Jul 2022 at 13:31, Christian Marangi <ansuelsmth@gmail.com> wrote:
>
> On Wed, Jul 06, 2022 at 10:39:16AM +0200, Krzysztof Kozlowski wrote:
> > On 05/07/2022 15:39, Christian Marangi wrote:
> > > Add missing smem node for ipq8064.
> > >
> > > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > > Tested-by: Jonathan McDowell <noodles@earth.li>
> > > ---
> > >  arch/arm/boot/dts/qcom-ipq8064.dtsi | 18 ++++++++++++++++++
> > >  1 file changed, 18 insertions(+)
> > >
> > > diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
> > > index b5aede3d7ccf..98527a7d885e 100644
> > > --- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
> > > +++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
> > > @@ -908,6 +908,11 @@ lcc: clock-controller@28000000 {
> > >                     #reset-cells = <1>;
> > >             };
> > >
> > > +           sfpb_mutex_block: syscon@1200600 {
> > > +                   compatible = "syscon";
> >
> > syscon alone is not allowed.
> >
>
> Mh... This is problematic. How this should be handled?
> This should be put in sfpb_mutex and change the driver to use regs if
> present instead of syscon?

If nothing else works, you can add two compat strings, for example:
"qcom,ipq8064-sfpb-mutex", "syscon";
This way if we add an sfpb driver at some point, we can still use old dts files.

-- 
With best wishes
Dmitry
