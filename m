Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 043B5508286
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 09:44:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376360AbiDTHrY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 03:47:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376356AbiDTHrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 03:47:19 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24F563BBE6
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 00:44:33 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-e5ca5c580fso1153605fac.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 00:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WwYw/7+o6YUXusBvVdcg713W697lIpIcWLImq9IQZLc=;
        b=u5OH/XQou5ikOvTKcspY/ijZaVXhW6U5psQ/O9mEKbptbh4j66ixnNtqXdwStg8beJ
         X45gflZSx1QfLlQPoyoHoKFb/0MLikPjKRrsoVBpHsFEBj+Gkt6/htirUu+0KqnGd2Cc
         aHazL9Hk+Cvhc+LwgYtYQtczBybQVPOHC7k2o6WYR9g2fzXfObo8aG4kvn58oFupo+z/
         XNWw1Pq/aIK2AY09pJV0mLtjPa/fpqo4UwSroZgI8kAL0TYrSDeGBO3BEz8ON1Xu74G8
         JdltELfQgLwLwaOJQ70CpVrL4PvQzNmMBiN/rQpAulP1uZVOSzND7ME4GjFnXkiDapEr
         ZpdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WwYw/7+o6YUXusBvVdcg713W697lIpIcWLImq9IQZLc=;
        b=OjdPA0TTQljji0jwsizigD5JTZiEHBnEeeh+PtODStR1v+isE+WRcep94c4Spy0dOF
         bBuVRxoyS+7apbBENZPpT273vUj+r/nI5mWdCKHK/TDpErVH7a//9HaH2ecSmhaGhIAj
         RdwGsVke4sZ0uANfVdSa/TFvPSj4piQwN97B8iOw9nGKjCMWUO728IPWKhlfie/iBEhk
         CTfdzoXDxCX7UgjmFsqbdfEUkYyMZVpMlksMDEmwIg31v3wVHCAeKB7ih2tIXUZaWMBr
         5wQ4f9D5lg3c6gZojssRviXnYeg1LlqRmTojgCRrh6b53KI60qjsKXg7qUCzN+UwzEaA
         KGvA==
X-Gm-Message-State: AOAM530mqvobTfK9JdaSXnZnWIJ/Fh/hFHOSGeGOwqJhLzu3AHR+rlcX
        NvgmEB7iHfrjVAw0Pxv9iwiolVVD3+g20/5YEBqns0fZvLg=
X-Google-Smtp-Source: ABdhPJz3HSKgFwTK7WGltRhpVJk5iwIQWxVia6R3e4KCXShKV9t/bmdxczAI1bTaTvoNtpu2MKMcFZ1ufXtoA6K68a4=
X-Received: by 2002:a05:6870:2156:b0:e5:bb8d:f6e3 with SMTP id
 g22-20020a056870215600b000e5bb8df6e3mr1021563oae.48.1650440672449; Wed, 20
 Apr 2022 00:44:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220414213139.476240-1-bhupesh.sharma@linaro.org>
 <20220414213139.476240-2-bhupesh.sharma@linaro.org> <Yl92blX6FaCMU48p@builder.lan>
In-Reply-To: <Yl92blX6FaCMU48p@builder.lan>
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
Date:   Wed, 20 Apr 2022 13:14:21 +0530
Message-ID: <CAH=2NtweJYnbtNwt93u+5VfWnLD7AfBob-LmBrE+g_U68qtfbw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] arm64: dts: qcom: sm8150: Add support for SDC2
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, bhupesh.linux@gmail.com,
        agross@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        Rob Herring <robh@kernel.org>
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

On Wed, 20 Apr 2022 at 08:26, Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> On Thu 14 Apr 16:31 CDT 2022, Bhupesh Sharma wrote:
>
> > Add support for SDC2 which can be used to interface uSD card.
> >
> > Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> > Cc: Rob Herring <robh@kernel.org>
> > Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
>
> Thanks for the patch Bhupesh. I have already applied v1 though. Can you
> please double check linux-next to confirm that things are in order?

Sure, I will send a minor iommu sid related fix shortly as a separate
patch, which
is required to fix a ADMA error while using the microSD card on the ADP board
(after rebasing it to linux-next/master tip).

Regards,
Bhupesh

> > ---
> >  arch/arm64/boot/dts/qcom/sm8150.dtsi | 45 ++++++++++++++++++++++++++++
> >  1 file changed, 45 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
> > index 15f3bf2e7ea0..0fecebf0a473 100644
> > --- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
> > @@ -3270,6 +3270,51 @@ usb_2_ssphy: phy@88eb200 {
> >                       };
> >               };
> >
> > +             sdhc_2: sdhci@8804000 {
> > +                     compatible = "qcom,sm8150-sdhci", "qcom,sdhci-msm-v5";
> > +                     reg = <0 0x08804000 0 0x1000>;
> > +
> > +                     interrupts = <GIC_SPI 204 IRQ_TYPE_LEVEL_HIGH>,
> > +                                  <GIC_SPI 222 IRQ_TYPE_LEVEL_HIGH>;
> > +                     interrupt-names = "hc_irq", "pwr_irq";
> > +
> > +                     clocks = <&gcc GCC_SDCC2_AHB_CLK>,
> > +                              <&gcc GCC_SDCC2_APPS_CLK>,
> > +                              <&rpmhcc RPMH_CXO_CLK>;
> > +                     clock-names = "iface", "core", "xo";
> > +                     iommus = <&apps_smmu 0x6a0 0x0>;
> > +                     qcom,dll-config = <0x0007642c>;
> > +                     qcom,ddr-config = <0x80040868>;
> > +                     power-domains = <&rpmhpd 0>;
> > +                     operating-points-v2 = <&sdhc2_opp_table>;
> > +
> > +                     status = "disabled";
> > +
> > +                     sdhc2_opp_table: sdhc2-opp-table {
> > +                             compatible = "operating-points-v2";
> > +
> > +                             opp-19200000 {
> > +                                     opp-hz = /bits/ 64 <19200000>;
> > +                                     required-opps = <&rpmhpd_opp_min_svs>;
> > +                             };
> > +
> > +                             opp-50000000 {
> > +                                     opp-hz = /bits/ 64 <50000000>;
> > +                                     required-opps = <&rpmhpd_opp_low_svs>;
> > +                             };
> > +
> > +                             opp-100000000 {
> > +                                     opp-hz = /bits/ 64 <100000000>;
> > +                                     required-opps = <&rpmhpd_opp_svs>;
> > +                             };
> > +
> > +                             opp-202000000 {
> > +                                     opp-hz = /bits/ 64 <202000000>;
> > +                                     required-opps = <&rpmhpd_opp_svs_l1>;
> > +                             };
> > +                     };
> > +             };
> > +
> >               dc_noc: interconnect@9160000 {
> >                       compatible = "qcom,sm8150-dc-noc";
> >                       reg = <0 0x09160000 0 0x3200>;
> > --
> > 2.35.1
> >
