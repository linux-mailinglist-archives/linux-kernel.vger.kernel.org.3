Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACB174CA515
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 13:44:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241888AbiCBMoo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 07:44:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241870AbiCBMom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 07:44:42 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2A47C1C9B
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 04:43:58 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id b23so1444699qtt.6
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 04:43:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RCQ1Hkosqigsur7jPtC2YOzm+InzZYgdKWMxBC1qOYw=;
        b=FBXgzWMQWPOZtM6gc2/TE90LewcUir6ipXYQhYCpbdVXSFaC2wVUU/vFIZOZv9mLBP
         0slZIBmx33g9PsibumRs0SfQCwQLnKKTmM706sJRj3Tt197DXiAWprVy5qRgapcwC6cN
         z7hxAn7ZXThaH3dSg9FqoxNp3IWG1dKCCtDQWDK7dAeh/KJvucb8WXRlz6VF+fGRQSla
         Z/55AH2ksORaHGH1aUQ8vJ0g8eaClEkk6AT9kxhQuYCiFd28lwvJEWutNflMlwivu8pu
         X6A00103Xt6AfKZ4y0Nx8SKScIrMcGxSqN2ZmDP9Rg+paqSachRkLE9G2XQtWp3tbYEV
         8GWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RCQ1Hkosqigsur7jPtC2YOzm+InzZYgdKWMxBC1qOYw=;
        b=xc6qtANQHMW6LJcHj74YgToF3pPms/Rn/duRFBef3MAPwwIVm9Mbh648qpwxzpxkPr
         cgZx1zp+tuOLRHUqJ/w/h87zLZ77JtG6tFK/skmuAHlhKNhLH+ImW7skMLCDg/9OTNS8
         9ICERsPAQniAMDvu30Bxq+CVOQtjygWdYo2eMS7kI5Ad9Kjy9FFQeJIfDLmjt59cayvv
         24ruQZmOO7amdEBcpDciR7GyWaTyig7tFgrfjqvtFxxeGa7QBtZIjStqqYJPkGTMkSys
         sNb3dfcQ7q0ad88k6gWz17g0NKBywckcvcVIiDOmj8BST1OyunqOprSktYq2N8CIpQF2
         7Ebw==
X-Gm-Message-State: AOAM531SFSoaKxBgZzWX3imwaGDmAZUFC2YEDz6xpPg1Q8Yujac1WYZG
        hRzuCUFwl8zs29S62+AYjEcjNkrCDCoe5rd9TDo9tg==
X-Google-Smtp-Source: ABdhPJwMuxqRwOOLiFtj4FdM+AMZ8K59rjBxOZQQjcAmPJAFrQOD1S3+JJWqcwBfGHhLtMiYAlW2I/Cg5BBeB+b54Vg=
X-Received: by 2002:a05:622a:1206:b0:2de:6fa4:41fb with SMTP id
 y6-20020a05622a120600b002de6fa441fbmr23365305qtx.295.1646225038036; Wed, 02
 Mar 2022 04:43:58 -0800 (PST)
MIME-Version: 1.0
References: <20220302013339.2354076-1-robh@kernel.org> <CAA8EJpowE0VfnA1QhU1LfXobFYjGPirWb52QW6HT5kCpcX0NBQ@mail.gmail.com>
 <20220302123518.3xprnrpp4nt7hmqs@SoMainline.org>
In-Reply-To: <20220302123518.3xprnrpp4nt7hmqs@SoMainline.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Wed, 2 Mar 2022 15:43:46 +0300
Message-ID: <CAA8EJpofXWsEQxacoW77hJ4a+=Si0qp10UmKWQQRhsbifZ2V1Q@mail.gmail.com>
Subject: Re: [PATCH v2] arm64/arm: dts: qcom: Drop bogus interrupt flags cell
 on MDSS nodes
To:     Marijn Suijten <marijn.suijten@somainline.org>
Cc:     Rob Herring <robh@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
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

On Wed, 2 Mar 2022 at 15:35, Marijn Suijten
<marijn.suijten@somainline.org> wrote:
>
> On 2022-03-02 04:53:56, Dmitry Baryshkov wrote:
> > On Wed, 2 Mar 2022 at 04:33, Rob Herring <robh@kernel.org> wrote:
> > >
> > > The MDSS interrupt provider is a single cell, so specifying interrupt flags
> > > on the consumers is incorrect.
> > >
> > > Signed-off-by: Rob Herring <robh@kernel.org>
> >
> > Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>
> Reviewed-by: Marijn Suijten <marijn.suijten@somainline.org>
>
> Dmitry, it seems you sent a similar change - albeit split across one
> patch per DTSI file and omitting arm qcom-msm8974 - inbetween v1 and v2
> of this patch.  To me that only makes sense if every patch includes the
> appropriate, individual `Fixes:` tag but the patches lack those too.
> Which approach should be reviewed and applied going forward?

Probably it's up to Bjorn to decide. I can resend my series including
the Fixes tags (and msm8974) if he thinks it's the better approach

>
> - Marijn
>
> > > ---
> > > v2:
> > >  - Add a bunch of missed cases
> > > ---
> > >  arch/arm/boot/dts/qcom-msm8974.dtsi   | 4 ++--
> > >  arch/arm64/boot/dts/qcom/msm8996.dtsi | 6 +++---
> > >  arch/arm64/boot/dts/qcom/sdm630.dtsi  | 5 ++---
> > >  arch/arm64/boot/dts/qcom/sdm660.dtsi  | 2 +-
> > >  arch/arm64/boot/dts/qcom/sdm845.dtsi  | 6 +++---
> > >  arch/arm64/boot/dts/qcom/sm8250.dtsi  | 6 +++---
> > >  6 files changed, 14 insertions(+), 15 deletions(-)
> > >
> > > diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom-msm8974.dtsi
> > > index 412d94736c35..3b9af5e24907 100644
> > > --- a/arch/arm/boot/dts/qcom-msm8974.dtsi
> > > +++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
> > > @@ -1495,7 +1495,7 @@ mdp: mdp@fd900000 {
> > >                                 reg-names = "mdp_phys";
> > >
> > >                                 interrupt-parent = <&mdss>;
> > > -                               interrupts = <0 0>;
> > > +                               interrupts = <0>;
> > >
> > >                                 clocks = <&mmcc MDSS_AHB_CLK>,
> > >                                          <&mmcc MDSS_AXI_CLK>,
> > > @@ -1530,7 +1530,7 @@ dsi0: dsi@fd922800 {
> > >                                 reg-names = "dsi_ctrl";
> > >
> > >                                 interrupt-parent = <&mdss>;
> > > -                               interrupts = <4 IRQ_TYPE_LEVEL_HIGH>;
> > > +                               interrupts = <4>;
> > >
> > >                                 assigned-clocks = <&mmcc BYTE0_CLK_SRC>,
> > >                                                   <&mmcc PCLK0_CLK_SRC>;
> > > diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
> > > index f0f81c23c16f..0597d865a4a6 100644
> > > --- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
> > > +++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
> > > @@ -788,7 +788,7 @@ mdp: mdp@901000 {
> > >                                 reg-names = "mdp_phys";
> > >
> > >                                 interrupt-parent = <&mdss>;
> > > -                               interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
> > > +                               interrupts = <0>;
> > >
> > >                                 clocks = <&mmcc MDSS_AHB_CLK>,
> > >                                          <&mmcc MDSS_AXI_CLK>,
> > > @@ -834,7 +834,7 @@ dsi0: dsi@994000 {
> > >                                 reg-names = "dsi_ctrl";
> > >
> > >                                 interrupt-parent = <&mdss>;
> > > -                               interrupts = <4 IRQ_TYPE_LEVEL_HIGH>;
> > > +                               interrupts = <4>;
> > >
> > >                                 clocks = <&mmcc MDSS_MDP_CLK>,
> > >                                          <&mmcc MDSS_BYTE0_CLK>,
> > > @@ -904,7 +904,7 @@ hdmi: hdmi-tx@9a0000 {
> > >                                             "hdcp_physical";
> > >
> > >                                 interrupt-parent = <&mdss>;
> > > -                               interrupts = <8 IRQ_TYPE_LEVEL_HIGH>;
> > > +                               interrupts = <8>;
> > >
> > >                                 clocks = <&mmcc MDSS_MDP_CLK>,
> > >                                          <&mmcc MDSS_AHB_CLK>,
> > > diff --git a/arch/arm64/boot/dts/qcom/sdm630.dtsi b/arch/arm64/boot/dts/qcom/sdm630.dtsi
> > > index 240293592ef9..f646fb80924f 100644
> > > --- a/arch/arm64/boot/dts/qcom/sdm630.dtsi
> > > +++ b/arch/arm64/boot/dts/qcom/sdm630.dtsi
> > > @@ -1453,7 +1453,7 @@ mdp: mdp@c901000 {
> > >                                 reg-names = "mdp_phys";
> > >
> > >                                 interrupt-parent = <&mdss>;
> > > -                               interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
> > > +                               interrupts = <0>;
> > >
> > >                                 assigned-clocks = <&mmcc MDSS_MDP_CLK>,
> > >                                                   <&mmcc MDSS_VSYNC_CLK>;
> > > @@ -1530,7 +1530,7 @@ dsi0: dsi@c994000 {
> > >                                 power-domains = <&rpmpd SDM660_VDDCX>;
> > >
> > >                                 interrupt-parent = <&mdss>;
> > > -                               interrupts = <4 IRQ_TYPE_LEVEL_HIGH>;
> > > +                               interrupts = <4>;
> > >
> > >                                 assigned-clocks = <&mmcc BYTE0_CLK_SRC>,
> > >                                                   <&mmcc PCLK0_CLK_SRC>;
> > > @@ -2487,4 +2487,3 @@ timer {
> > >                                  <GIC_PPI 0 0xf08>;
> > >         };
> > >  };
> > > -
> > > diff --git a/arch/arm64/boot/dts/qcom/sdm660.dtsi b/arch/arm64/boot/dts/qcom/sdm660.dtsi
> > > index eccf6fde16b4..1d748c5305f4 100644
> > > --- a/arch/arm64/boot/dts/qcom/sdm660.dtsi
> > > +++ b/arch/arm64/boot/dts/qcom/sdm660.dtsi
> > > @@ -163,7 +163,7 @@ dsi1: dsi@c996000 {
> > >                 power-domains = <&rpmpd SDM660_VDDCX>;
> > >
> > >                 interrupt-parent = <&mdss>;
> > > -               interrupts = <5 IRQ_TYPE_LEVEL_HIGH>;
> > > +               interrupts = <5>;
> > >
> > >                 assigned-clocks = <&mmcc BYTE1_CLK_SRC>,
> > >                                         <&mmcc PCLK1_CLK_SRC>;
> > > diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > > index 41f4e46e1f85..95e6a97c2170 100644
> > > --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > > +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > > @@ -4281,7 +4281,7 @@ mdss_mdp: mdp@ae01000 {
> > >                                 power-domains = <&rpmhpd SDM845_CX>;
> > >
> > >                                 interrupt-parent = <&mdss>;
> > > -                               interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
> > > +                               interrupts = <0>;
> > >
> > >                                 ports {
> > >                                         #address-cells = <1>;
> > > @@ -4333,7 +4333,7 @@ dsi0: dsi@ae94000 {
> > >                                 reg-names = "dsi_ctrl";
> > >
> > >                                 interrupt-parent = <&mdss>;
> > > -                               interrupts = <4 IRQ_TYPE_LEVEL_HIGH>;
> > > +                               interrupts = <4>;
> > >
> > >                                 clocks = <&dispcc DISP_CC_MDSS_BYTE0_CLK>,
> > >                                          <&dispcc DISP_CC_MDSS_BYTE0_INTF_CLK>,
> > > @@ -4405,7 +4405,7 @@ dsi1: dsi@ae96000 {
> > >                                 reg-names = "dsi_ctrl";
> > >
> > >                                 interrupt-parent = <&mdss>;
> > > -                               interrupts = <5 IRQ_TYPE_LEVEL_HIGH>;
> > > +                               interrupts = <5>;
> > >
> > >                                 clocks = <&dispcc DISP_CC_MDSS_BYTE1_CLK>,
> > >                                          <&dispcc DISP_CC_MDSS_BYTE1_INTF_CLK>,
> > > diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
> > > index fdaf303ba047..956848068871 100644
> > > --- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
> > > +++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
> > > @@ -3200,7 +3200,7 @@ mdss_mdp: mdp@ae01000 {
> > >                                 power-domains = <&rpmhpd SM8250_MMCX>;
> > >
> > >                                 interrupt-parent = <&mdss>;
> > > -                               interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
> > > +                               interrupts = <0>;
> > >
> > >                                 ports {
> > >                                         #address-cells = <1>;
> > > @@ -3252,7 +3252,7 @@ dsi0: dsi@ae94000 {
> > >                                 reg-names = "dsi_ctrl";
> > >
> > >                                 interrupt-parent = <&mdss>;
> > > -                               interrupts = <4 IRQ_TYPE_LEVEL_HIGH>;
> > > +                               interrupts = <4>;
> > >
> > >                                 clocks = <&dispcc DISP_CC_MDSS_BYTE0_CLK>,
> > >                                          <&dispcc DISP_CC_MDSS_BYTE0_INTF_CLK>,
> > > @@ -3325,7 +3325,7 @@ dsi1: dsi@ae96000 {
> > >                                 reg-names = "dsi_ctrl";
> > >
> > >                                 interrupt-parent = <&mdss>;
> > > -                               interrupts = <5 IRQ_TYPE_LEVEL_HIGH>;
> > > +                               interrupts = <5>;
> > >
> > >                                 clocks = <&dispcc DISP_CC_MDSS_BYTE1_CLK>,
> > >                                          <&dispcc DISP_CC_MDSS_BYTE1_INTF_CLK>,
> > > --
> > > 2.32.0
> > >
> >
> >
> > --
> > With best wishes
> > Dmitry



-- 
With best wishes
Dmitry
