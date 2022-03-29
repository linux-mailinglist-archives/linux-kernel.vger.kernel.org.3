Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D55654EB3AC
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 20:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240692AbiC2Srp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 14:47:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240683AbiC2Srl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 14:47:41 -0400
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC2EF98F72
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 11:45:57 -0700 (PDT)
Received: by mail-oo1-xc30.google.com with SMTP id p34-20020a4a95e5000000b003248d73d460so3222851ooi.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 11:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:rubject:from:user-agent:date
         :message-id:subject:to:cc;
        bh=UwSlcldOxyZRO1MzDqS4vkDmvSWdf2ZglslWTy2RMao=;
        b=LQdX8Pj1uKYFSjrfi8XmkrbgDYCpuEWJY2NJSntC/mDPqnwW1Cywvy+Uzc9vE13KXH
         enQQrMLPvG5vcI3W/23hWZjfj5nUuElKEOx/qttjFu/vCRN5ZHsC1sz5bozJaYuF8yCB
         vKkmPm6dcKaXNQ0sirOP4QpJXhNA8opP6kudc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:rubject:from
         :user-agent:date:message-id:subject:to:cc;
        bh=UwSlcldOxyZRO1MzDqS4vkDmvSWdf2ZglslWTy2RMao=;
        b=wKO7416Xlv/xhP70RWkEsaqENOuY14PmdfQGj2oR77/iPe+GYfr4VR67BR6X7GGJ9f
         RqQvEwis1mba0BHmwThL0XmxA0Plle10mpOrh41jGIsCH6XYQe860XAve+2lsBtV2XEf
         PLWXefcfCsgaIPD8+6JNh0QpsT7DovK1q4vY7xLgZ1SRB04dTKuhbAELe1LCprl8lP2g
         0zt3a2NSdvfl2qwiKWut1GbPfSV0FkSO1GCE+7HJvS78hfYJQMGwUzwitv93+MIIu+92
         4N3Cu2kABTSP+5IBTC0b1y0/WEqiF5dD7IQD2E08GusGdmovyzTVZyDWpfNG/GUIbTtP
         +VOw==
X-Gm-Message-State: AOAM53026Wg9GDR13GmG47ZtrZEdqdbuLE7rBS2gjDJQ2Wq/uNgzdCbk
        9EBzZh3HOUPBhc3mgmoE70th6/+aSjJezF/e40LFZw==
X-Google-Smtp-Source: ABdhPJyp72b5rDcmu/+a6g3PLUOI0TLaNt/1tMn2krnsCiqt/I4ljeBmBxOMeBdj+cUluUZ1rDXi6LEX7K5eOaAmqls=
X-Received: by 2002:a05:6820:555:b0:324:b7c5:d7b2 with SMTP id
 n21-20020a056820055500b00324b7c5d7b2mr1564948ooj.1.1648579556793; Tue, 29 Mar
 2022 11:45:56 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 29 Mar 2022 20:45:56 +0200
MIME-Version: 1.0
In-Reply-To: <CAD=FV=Wk86sd1m0DU0gYrA2PASArdLnKnf_M8EAeSxzpLt_f8A@mail.gmail.com>
References: <20220325234344.199841-1-swboyd@chromium.org> <20220325234344.199841-3-swboyd@chromium.org>
 <CAD=FV=Wk86sd1m0DU0gYrA2PASArdLnKnf_M8EAeSxzpLt_f8A@mail.gmail.com>
rubject: Re: [PATCH 2/2] arm64: dts: qcom: sc7180-trogdor: Simplify spi0/spi6 labeling
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Tue, 29 Mar 2022 20:45:56 +0200
Message-ID: <CAE-0n524bn+=sj2hhCD5AjMWuVe=tp_JMHXruDUbEk-uft7RNQ@mail.gmail.com>
Subject: 
To:     Doug Anderson <dianders@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Joseph Barrera <joebar@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Doug Anderson (2022-03-28 09:05:05)
> Hi,
>
> On Fri, Mar 25, 2022 at 4:43 PM Stephen Boyd <swboyd@chromium.org> wrote:
> >
> > We had to do this spi0/spi6 flip-flop on trogdor-r0 because the spi
> > buses got swizzled between r0 and r1. The swizzle stopped after r1, but
> > we kept this around to support either hardware possibility and to keep
> > trogdor-r0 working.
> >
> > trogdor-r0 isn't supported upstream, so this swizzle is not doing
> > anything besides making a pattern that others try to copy for the EC and
> > H1 nodes. Let's remove it and simplify the dts files.
> >
> > Cc: Joseph Barrera <joebar@google.com>
> > Cc: Douglas Anderson <dianders@chromium.org>
> > Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> > ---
> >  arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz.dtsi   | 5 -----
> >  arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar.dtsi | 3 ---
> >  arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor.dtsi    | 3 ---
> >  arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi          | 5 +++--
> >  4 files changed, 3 insertions(+), 13 deletions(-)
>
> What about pompom?
> What about trogdor-r1?
>
>
> > diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor.dtsi
> > index 75df5d1633b2..fe2369c29aad 100644
> > --- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor.dtsi
> > @@ -5,9 +5,6 @@
> >   * Copyright 2020 Google LLC.
> >   */
> >
> > -ap_ec_spi: &spi6 {};
> > -ap_h1_spi: &spi0 {};
> > -
> >  #include "sc7180-trogdor.dtsi"
> >
> >  &ap_sar_sensor {
> > diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
> > index 3bf40b6abcba..3123665f6c3c 100644
> > --- a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
> > @@ -11,6 +11,7 @@
> >  #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
> >  #include <dt-bindings/sound/sc7180-lpass.h>
> >
> > +#include "sc7180.dtsi"
>
> If we're going to move the "sc7180.dtsi" to trogdor then we should
> move it for everyone, right? Right now you're _only_ removing it from
> coachz. I think that means that for every other board the
> "sc7180.dtsi" file is included more than once. These aren't like C
> header files where there's a convention to have header guards.

Yes that was the intention. I didn't notice that there were so many
other includes of sc7180.dtsi though.

>
> I _think_ that could actually cause problems too, right? So if you
> include it once and then you override a status to "okay" and then you
> included it again it might get changed back to "disabled" ?
>
> The easiest solution would be to just leave the sc7180.dtsi include
> where it was. If you want to try to do better, I _think_ (but haven't
> tried) that you can change all of the existing includes of
> "sc7180.dtsi" to be includes of "sc7180-trogdor.dtsi" and then remove
> the existing includes of "sc7180-trogdor.dtsi". IIRC the reason that
> the sc7180.dtsi include is scattered everywhere is that we needed the
> i2c bus before we could define the parade / ti bridge but then we
> needed the parade / ti bridge before we included the board specific
> bits so we could define the panel.

Yeah let me try that.
