Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BC2A504EE7
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 12:39:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237730AbiDRKmL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 06:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237719AbiDRKmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 06:42:08 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4B8315A32
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 03:39:29 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-de3eda6b5dso13844335fac.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 03:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=62c026OOLAuNuBuSioyVpnipO8MJFXscIe6Hv24ZM6o=;
        b=zJvN5SlP/3qCHDqJo/ZWanngiLrVz0gsXPmvbKN3q4nbnTv+VZ4W/LAl+DZ2KJrnrd
         1C1sQ6Bde0CLweFJXSZ7icY3DY9ml2+FqluhS7m5A4EUIyznFTrVjjYYQbReT2UZKGrk
         tew0f801Qq34i4eMznEJgmjrjiOVHVfclvubXogmUZFXwms1MkwMc4Pvu37vkdKtRkmR
         +ZfczKhD+qFmDmFSbjj5OuxVs/WGPnvhkeRiqTefDiYDtdf8Ou9xh949bfo4msBBIYbp
         n6VoEqFZA5H14v2w9fJTS0Vgd+tEE1pXFr3vk80xG6p/sb2PWhpDBNHX8KYsMQN40+X3
         R7tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=62c026OOLAuNuBuSioyVpnipO8MJFXscIe6Hv24ZM6o=;
        b=ncVgyFrzQzFihuggKbixw5wnqDTmncG2jK3lHJVpvsdqGYJK1uDn0oANYCJiktL3X5
         jEPWX+bsYG4eUOwR2LJyXaudtnmabjF7gW8KFE2jfP2D9R7PFerTNKus17enXjAgDJ41
         OzVPA9C9Wv3avprhK8+S1faJYnFhJWJJEtA7+4U//TPk6JgHRiXhKrOlqtFGJk+uCqr+
         YlYaIE81KUZ1kl5PB0fuzaHs/on5QQJlbi0bhkAy1b1JktS+0Aq1QT610oSAlC2nCYZE
         6YT916OhWQz1W0G90LNVUDf2tvaME5wBnzcka2C/8/JCRdB0yTSjyOHAZRDgFg1+QHSS
         J/3g==
X-Gm-Message-State: AOAM533gWmuUaSeirvbkXImGWM9K4K0wIKKOKCAoVEu+ed+J0J5tKFiN
        M69P/1Ap+BCiDdKET6E2J9oVWvURDk3gimdRZzgCch4YZM/5nw==
X-Google-Smtp-Source: ABdhPJxID8TnHzn6Zu3SHNeySQA/uhoKQT25r6qemvJbcXOXJ0tLPlPVCU0Nm7LeAugRnXZew0nK3yGf2zipJw+03Xw=
X-Received: by 2002:a05:6870:2156:b0:e5:bb8d:f6e3 with SMTP id
 g22-20020a056870215600b000e5bb8df6e3mr3434816oae.48.1650278369148; Mon, 18
 Apr 2022 03:39:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220414122928.349126-1-bhupesh.sharma@linaro.org> <20220414141107.sazz72sl6giehpjx@SoMainline.org>
In-Reply-To: <20220414141107.sazz72sl6giehpjx@SoMainline.org>
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
Date:   Mon, 18 Apr 2022 16:09:18 +0530
Message-ID: <CAH=2NtzFGYAxc_0aEWUV-Jn4JwV4UtCNRui_KL7RRiG4BWF92g@mail.gmail.com>
Subject: Re: [PATCH 1/1] arm64: dts: qcom: sm8350-sagami: UFS phy - add
 'vdda-pll-supply' & 'vdda-phy-supply'
To:     Marijn Suijten <marijn.suijten@somainline.org>
Cc:     linux-arm-msm@vger.kernel.org, bhupesh.linux@gmail.com,
        agross@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        bjorn.andersson@linaro.org, konrad.dybcio@somainline.org,
        Vinod Koul <vkoul@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Martin Botka <martin.botka@somainline.org>
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

On Thu, 14 Apr 2022 at 19:41, Marijn Suijten
<marijn.suijten@somainline.org> wrote:
>
> On 2022-04-14 17:59:28, Bhupesh Sharma wrote:
> > As suggested by Bjorn during review of [1], the vdda-pll-supply' &
> > 'vdda-phy-supply' supplies denote the power for the bus and the
> > clock of the UFS PHY.
> >
> > For pdx215 to have a functional UFS [..] safe to assume [..]
>
> By "functional" you are referring to sending a certain UFS command that
> accidentally wipes the bootloader [1] [2], turning the device into a
> _very_ expensive (+$1000) paperweight?
>
> [1]: https://lore.kernel.org/lkml/20211111184630.605035-1-konrad.dybcio@somainline.org/
> [2]: https://github.com/kholk/kernel/commit/2e7a9ee1c91a016baa0b826a7752ec45663a0561
>
> > In absence of the same 'make dtbs_check' leads to following warnings:
> >
> > arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami-pdx215.dt.yaml:
> >  phy-wrapper@88e9000: 'vdda-phy-supply' is a required property
> >
> > arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami-pdx215.dt.yaml:
> >  phy-wrapper@88e9000: 'vdda-pll-supply' is a required property
> >
> > [1]. https://lore.kernel.org/lkml/20220228123019.382037-9-bhupesh.sharma@linaro.org/
> >
> > Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> > Cc: konrad.dybcio@somainline.org
> > Cc: Vinod Koul <vkoul@kernel.org>
> > Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> > ---
> >  .../dts/qcom/sm8350-sony-xperia-sagami.dtsi   | 25 +++++++++++++++++++
> >  1 file changed, 25 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami.dtsi b/arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami.dtsi
> > index 90b13cbe2fa6..238ac9380ca2 100644
> > --- a/arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami.dtsi
> > @@ -3,6 +3,7 @@
> >   * Copyright (c) 2021, Konrad Dybcio <konrad.dybcio@somainline.org>
> >   */
> >
> > +#include <dt-bindings/regulator/qcom,rpmh-regulator.h>
> >  #include "sm8350.dtsi"
> >  #include "pm8350.dtsi"
> >  #include "pm8350b.dtsi"
> > @@ -75,6 +76,27 @@ ramoops@ffc00000 {
> >       };
> >  };
> >
> > +&apps_rsc {
> > +     pm8350-rpmh-regulators {
> > +             compatible = "qcom,pm8350-rpmh-regulators";
> > +             qcom,pmic-id = "b";
> > +
> > +             vreg_l1b_0p88: ldo1 {
> > +                     regulator-name = "vreg_l1b_0p88";
> > +                     regulator-min-microvolt = <912000>;
> > +                     regulator-max-microvolt = <920000>;
> > +                     regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> > +             };
> > +
> > +             vreg_l6b_1p2: ldo6 {
> > +                     regulator-name = "vreg_l6b_1p2";
> > +                     regulator-min-microvolt = <1200000>;
> > +                     regulator-max-microvolt = <1208000>;
> > +                     regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> > +             };
> > +     };
> > +};
> > +
> >  &adsp {
> >       status = "okay";
> >       firmware-name = "qcom/adsp.mbn";
> > @@ -256,4 +278,7 @@ &usb_1_hsphy {
> >
> >  &usb_1_qmpphy {
> >       status = "okay";
> > +
> > +     vdda-phy-supply = <&vreg_l6b_1p2>;
> > +     vdda-pll-supply = <&vreg_l1b_0p88>;
>
> I'm probably understanding your patch wrong, but this is the USB phy,
> not the UFS phy?  The warning from dtbs_check on `phy-wrapper@88e9000`
> is also the `qmp-usb3-phy`, not the `qmp-ufs-phy` - seems this patch has
> little to do with UFS after all?

Indeed, it should be the qmp USB3 phy, instead.. my bad.. I will fix it in v2.

Do you see any issues with enabling these two regulators in the
'sm8350-sony-xperia-sagami-pdx215' dts?

Thanks,
Bhupesh

> >  };
> > --
> > 2.35.1
> >
