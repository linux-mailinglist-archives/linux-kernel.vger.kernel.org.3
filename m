Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B42264909C1
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 14:50:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234536AbiAQNuF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 08:50:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232312AbiAQNuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 08:50:03 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 608EEC061574;
        Mon, 17 Jan 2022 05:50:03 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id e195so15870956ybb.7;
        Mon, 17 Jan 2022 05:50:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=scjuoJKtuO36tP3W1hjGAjC9j/4aelwgjS9MIvmuEC8=;
        b=lCBXc3qnqztf6W10k3Qk98g3+Ijwq19WqmXwp1iJyQy7KxCQ04mOlT9sJHSPi5wr2c
         T3s+CujCS/RBV11YASqBgxGjXahtSiQ6tJislH3m1XWQ4ttdHhLOpe6tdS/t94qBQspO
         //hxWUSwMq0t6l0mL/CItNNSjpziaQl7s5+IIWt0kqaq4CQxp4Znu9epPM1td8Zt4pLT
         BiuHw+D19WKuTd90LqJa37CpGVLuRuHTjug5xItJIiU3e3YklyyfwwyVjcKZ4L0j+5yA
         jLPn4hxqrd9/VzF9TyuRdw9UjfC59GCVQnj4J873lzNfgzi979fWSBXI8CAY4oWganMj
         HjTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=scjuoJKtuO36tP3W1hjGAjC9j/4aelwgjS9MIvmuEC8=;
        b=mpoQKdrNnmZJw+NCfJXkeN2IFcjshNn5JtdBZuvMDURPwlnL5Ufu4nU9+7Us7ssUxg
         eK9PjPBKtmTJ0dyVi1nX9AsbBe7/qX054y3BPmINAq7xgPbHu6q6hNydM0PHuYbz2WTx
         lcxkxBQzjUgHTQ5+8BIw/ZnIeBSjrfSM4YI3UnP0Eq4Y1Suuf9NPGevJLR39hi5U7q2w
         KQfB5sWH6eN+P6TAINp8EEZdpCwF+8DvRyLomlyxHJitEE8mu8Pw3WkB91bV8ol5t67B
         sWZh+AhPIhWmbWh/h8PZei6yVOyM+gE8QmRvsUkQUGoVTWUC9Hm3jQteyLPSQbAIh7jR
         Z6Jg==
X-Gm-Message-State: AOAM531dRrPK+2HAKb34xF+Q/v3SNuimHwt4s0xNsl3k6UeOM5KgDVQd
        EbG+X2yWqRbII9axDHvxit6tRRMOaslR/J1jpBYgpfJoxWY=
X-Google-Smtp-Source: ABdhPJxDG/ZKw84sZTwAfWKvgcJzlnmupgB03nTWxJZkyzn09ElFhr7iZXTWpPeUSsry4ZwtUGd3Zrjj6J17WimIRUw=
X-Received: by 2002:a05:6902:150d:: with SMTP id q13mr2785453ybu.355.1642427402233;
 Mon, 17 Jan 2022 05:50:02 -0800 (PST)
MIME-Version: 1.0
References: <20210728135534.703028-1-pgwipeout@gmail.com> <20210728135534.703028-6-pgwipeout@gmail.com>
 <C3AE0A81-A829-4241-A65E-EB28825E3C33@gmail.com>
In-Reply-To: <C3AE0A81-A829-4241-A65E-EB28825E3C33@gmail.com>
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Mon, 17 Jan 2022 08:49:50 -0500
Message-ID: <CAMdYzYo2gkNvNYjU9_kc4cTwNBFU+kg3bRwaS3yCCAsMdo-Tow@mail.gmail.com>
Subject: Re: [PATCH 5/9] arm64: dts: rockchip: add rk3568 tsadc nodes
To:     Piotr Oniszczuk <piotr.oniszczuk@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 17, 2022 at 3:43 AM Piotr Oniszczuk
<piotr.oniszczuk@gmail.com> wrote:
>
>
>
> > Wiadomo=C5=9B=C4=87 napisana przez Peter Geis <pgwipeout@gmail.com> w d=
niu 28.07.2021, o godz. 15:55:
> >
> > Add the thermal and tsadc nodes to the rk3568 device tree.
> > There are two sensors, one for the cpu, one for the gpu.
> >
> > Signed-off-by: Peter Geis <pgwipeout@gmail.com>
> > ---
> > .../boot/dts/rockchip/rk3568-pinctrl.dtsi     |  6 ++
> > arch/arm64/boot/dts/rockchip/rk356x.dtsi      | 71 +++++++++++++++++++
> > 2 files changed, 77 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/rockchip/rk3568-pinctrl.dtsi b/arch/ar=
m64/boot/dts/rockchip/rk3568-pinctrl.dtsi
> > index a588ca95ace2..b464c7bda1f7 100644
> > --- a/arch/arm64/boot/dts/rockchip/rk3568-pinctrl.dtsi
> > +++ b/arch/arm64/boot/dts/rockchip/rk3568-pinctrl.dtsi
> > @@ -2420,6 +2420,12 @@ spi3m1_cs1: spi3m1-cs1 {
> >       };
> >
> >       tsadc {
> > +             /omit-if-no-ref/
> > +             tsadc_gpio: tsadc-gpio {
> > +                     rockchip,pins =3D
> > +                             <0 RK_PA1 0 &pcfg_pull_none>;
> > +             };
> > +
> >               /omit-if-no-ref/
> >               tsadcm0_shut: tsadcm0-shut {
> >                       rockchip,pins =3D
> > diff --git a/arch/arm64/boot/dts/rockchip/rk356x.dtsi b/arch/arm64/boot=
/dts/rockchip/rk356x.dtsi
> > index 77c679304916..0905fac0726a 100644
> > --- a/arch/arm64/boot/dts/rockchip/rk356x.dtsi
> > +++ b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
> > @@ -51,6 +51,7 @@ cpu0: cpu@0 {
> >                       compatible =3D "arm,cortex-a55";
> >                       reg =3D <0x0 0x0>;
> >                       clocks =3D <&scmi_clk 0>;
> > +                     #cooling-cells =3D <2>;
> >                       enable-method =3D "psci";
> >                       operating-points-v2 =3D <&cpu0_opp_table>;
> >               };
> > @@ -59,6 +60,7 @@ cpu1: cpu@100 {
> >                       device_type =3D "cpu";
> >                       compatible =3D "arm,cortex-a55";
> >                       reg =3D <0x0 0x100>;
> > +                     #cooling-cells =3D <2>;
> >                       enable-method =3D "psci";
> >                       operating-points-v2 =3D <&cpu0_opp_table>;
> >               };
> > @@ -67,6 +69,7 @@ cpu2: cpu@200 {
> >                       device_type =3D "cpu";
> >                       compatible =3D "arm,cortex-a55";
> >                       reg =3D <0x0 0x200>;
> > +                     #cooling-cells =3D <2>;
> >                       enable-method =3D "psci";
> >                       operating-points-v2 =3D <&cpu0_opp_table>;
> >               };
> > @@ -75,6 +78,7 @@ cpu3: cpu@300 {
> >                       device_type =3D "cpu";
> >                       compatible =3D "arm,cortex-a55";
> >                       reg =3D <0x0 0x300>;
> > +                     #cooling-cells =3D <2>;
> >                       enable-method =3D "psci";
> >                       operating-points-v2 =3D <&cpu0_opp_table>;
> >               };
> > @@ -774,6 +778,73 @@ uart9: serial@fe6d0000 {
> >               status =3D "disabled";
> >       };
> >
> > +     thermal_zones: thermal-zones {
> > +             cpu_thermal: cpu-thermal {
> > +                     polling-delay-passive =3D <100>;
> > +                     polling-delay =3D <1000>;
> > +
> > +                     thermal-sensors =3D <&tsadc 0>;
> > +
> > +                     trips {
> > +                             cpu_alert0: cpu_alert0 {
> > +                                     temperature =3D <70000>;
> > +                                     hysteresis =3D <2000>;
> > +                                     type =3D "passive";
> > +                             };
> > +                             cpu_alert1: cpu_alert1 {
> > +                                     temperature =3D <75000>;
> > +                                     hysteresis =3D <2000>;
> > +                                     type =3D "passive";
> > +                             };
> > +                             cpu_crit: cpu_crit {
> > +                                     temperature =3D <95000>;
> > +                                     hysteresis =3D <2000>;
> > +                                     type =3D "critical";
> > +                             };
> > +                     };
> > +
> > +                     cooling-maps {
> > +                             map0 {
> > +                                     trip =3D <&cpu_alert0>;
> > +                                     cooling-device =3D
> > +                                             <&cpu0 THERMAL_NO_LIMIT T=
HERMAL_NO_LIMIT>,
> > +                                             <&cpu1 THERMAL_NO_LIMIT T=
HERMAL_NO_LIMIT>,
> > +                                             <&cpu2 THERMAL_NO_LIMIT T=
HERMAL_NO_LIMIT>,
> > +                                             <&cpu3 THERMAL_NO_LIMIT T=
HERMAL_NO_LIMIT>;
> > +                             };
> > +                     };
> > +             };
> > +
> > +             gpu_thermal: gpu-thermal {
> > +                     polling-delay-passive =3D <20>; /* milliseconds *=
/
> > +                     polling-delay =3D <1000>; /* milliseconds */
> > +
> > +                     thermal-sensors =3D <&tsadc 1>;
> > +             };
> > +     };
> > +
> > +     tsadc: tsadc@fe710000 {
> > +             compatible =3D "rockchip,rk3568-tsadc";
> > +             reg =3D <0x0 0xfe710000 0x0 0x100>;
> > +             interrupts =3D <GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>;
> > +             assigned-clocks =3D <&cru CLK_TSADC_TSEN>, <&cru CLK_TSAD=
C>;
> > +             assigned-clock-rates =3D <17000000>, <700000>;
> > +             clocks =3D <&cru CLK_TSADC>, <&cru PCLK_TSADC>;
> > +             clock-names =3D "tsadc", "apb_pclk";
> > +             resets =3D <&cru SRST_TSADC>, <&cru SRST_P_TSADC>,
> > +                      <&cru SRST_TSADCPHY>;
> > +             reset-names =3D "tsadc", "tsadc-apb", "tsadc-phy";
> > +             rockchip,grf =3D <&grf>;
> > +             rockchip,hw-tshut-temp =3D <95000>;
> > +             rockchip,hw-tshut-mode =3D <1>; /* tshut mode 0:CRU 1:GPI=
O */
> > +             rockchip,hw-tshut-polarity =3D <0>; /* tshut polarity 0:L=
OW 1:HIGH */
> > +             pinctrl-names =3D "gpio", "otpout";
> > +             pinctrl-0 =3D <&tsadc_gpio>;
> > +             pinctrl-1 =3D <&tsadc_shutorg>;
> > +             #thermal-sensor-cells =3D <1>;
> > +             status =3D "disabled";
> > +     };
> > +
> >       saradc: saradc@fe720000 {
> >               compatible =3D "rockchip,rk3568-saradc", "rockchip,rk3399=
-saradc";
> >               reg =3D <0x0 0xfe720000 0x0 0x100>;
> > --
> > 2.25.1
> >
> >
> > _______________________________________________
> > Linux-rockchip mailing list
> > Linux-rockchip@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-rockchip
>
> Peter,
>
> I'm trying to use this series to get thermal on rk3566 based tvbox (x96-x=
6).
> Driver loads but i'm getting following error:
>
> [  132.873979] rockchip-thermal fe710000.tsadc: failed to register sensor=
 0: -517
> [  132.874650] rockchip-thermal fe710000.tsadc: failed to register sensor=
[0] : error =3D -517
>
> Maybe you have some hints here?

Error -517 means -EPROBE_DEFER, a device it relies on hasn't probed.
TSADC doesn't directly rely on anything that shouldn't already be
enabled. (Pinctrl, clocks, and grf all break a lot more than tsadc if
disabled)
Does your kernel config have all of the rockchip elements enabled?

>
>
