Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65DAA49DE89
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 10:55:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238332AbiA0Jz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 04:55:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234345AbiA0JzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 04:55:25 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D130C061714;
        Thu, 27 Jan 2022 01:55:25 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id h14so6851948ybe.12;
        Thu, 27 Jan 2022 01:55:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/EedJrG4ul4UwFA3alRTDn+7vyfBymCk2ZRwzLvGunI=;
        b=VAkvS+4+4m9uodQr+lOef7e4aMBiZSRvbRhCl8EvFL8dPoU7aajphSlGTJwbf6G4RG
         +KAXXYIhkuR61kROEhKH5Y0ouyYWDZ48ay/s3NbZKieWtbC+xL3SRtHVmPFWVaqaB2A1
         f+bEkgdj4JRAYXZnHb6AXZgHtfuBQQBqO0Z8JDTwAzzyuIYU25252pG6JUgtROEXOH00
         BPRvyHAUGhHCL0i6LFN8ICnurGmT03vxwzT9kFJCcIpNC24vcFBOZiykXSAQ0PAQ61sy
         +Bw6JnodlGy+8diz8TaiJk6lQv4WXkYyYRl4Mg0Q8lLfCqHb0nBLN+gpsT38Xr+4gTgS
         q9gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/EedJrG4ul4UwFA3alRTDn+7vyfBymCk2ZRwzLvGunI=;
        b=lryoYfNPfPamztyoIjr52kQRROW4ix9O1Pz3IWatpCO706mi8pldTg7Kh0zKQNr3v7
         7eID1CwImpRbELLA4ziMU6O8eNf415wXzte3YBM3l3BRd8P1dD0DwlQUIR8A4m6TWEwx
         PaiA5qB45yjId/gdIwRSsnUXeCzQmC7hVNjAH0xN6nOmHv+sOmjgGzCDzs3HLOwnQAgC
         J7MIvHFh4hIeX7Q6Iih0K8i9IvOMYCptSDrk8ucJxl/WVr0KEOMofGElppZtCmYn3c+Q
         718X6rtdm7MgEdMeOYYzrnSug3GlVhwzi3OM8FGFGzjgEjfjcNDnQ6xfayt7orKKuNbA
         2heg==
X-Gm-Message-State: AOAM531jXcp853Ql2Q3QZ+FIDGejmTjPQHqSD1jpviNdbYpFyAJhFOHK
        J9Ykz0VqbS0NGSQHScA86JMlIow5bqnFY7QEeSw=
X-Google-Smtp-Source: ABdhPJxprAY982Zt5MSbxLAgHsuavBv30BLYQ5498ZVxx3qKzuslSVSbiUu9KBNIyQ9Kxqga4qYumyh/Rxyodf8MQxk=
X-Received: by 2002:a25:dfc7:: with SMTP id w190mr4396026ybg.696.1643277324675;
 Thu, 27 Jan 2022 01:55:24 -0800 (PST)
MIME-Version: 1.0
References: <20220127010023.3169415-1-pgwipeout@gmail.com> <20220127010023.3169415-4-pgwipeout@gmail.com>
 <07281029-0efd-0a74-0d96-92e3dcf5bbb7@gmail.com>
In-Reply-To: <07281029-0efd-0a74-0d96-92e3dcf5bbb7@gmail.com>
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Thu, 27 Jan 2022 04:55:13 -0500
Message-ID: <CAMdYzYrKq==Bs0aonrJBC+W2c4nQ8cUn2dn_Se4WDaRCkT6SYg@mail.gmail.com>
Subject: Re: [PATCH 3/3] arm64: dts: rockchip: add Quartz64-A sdmmc1 node
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        devicetree <devicetree@vger.kernel.org>,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2022 at 1:18 AM Johan Jonker <jbx6244@gmail.com> wrote:
>
>
>
> On 1/27/22 02:00, Peter Geis wrote:
> > The sdmmc1 node on Quartz64-A supports the optional wifi module from
> > Pine64.
> > Add the sdmmc1 node and requisite sdio_pwrseq to enable wifi support on
> > the Quartz64-A.
> >
> > Signed-off-by: Peter Geis <pgwipeout@gmail.com>
> > ---
> >  .../boot/dts/rockchip/rk3566-quartz64-a.dts   | 45 +++++++++++++++++++
> >  1 file changed, 45 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
> > index 33c2c18caaa9..1d73ac6557c5 100644
> > --- a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
> > +++ b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
> > @@ -91,6 +91,18 @@ simple-audio-card,codec {
> >               };
> >       };
> >
> > +     sdio_pwrseq: sdio-pwrseq {
>
> > +             status = "okay";
>
> When a node is not previously disabled, then there's no need for "okay".

Thanks, this is here in case an end user wants to easily hack the
board to use this for other purposes.

>
> > +             compatible = "mmc-pwrseq-simple";
> > +             clocks = <&rk817 1>;
> > +             clock-names = "ext_clock";
> > +             pinctrl-names = "default";
> > +             pinctrl-0 = <&wifi_enable_h>;
> > +             reset-gpios = <&gpio2 RK_PC2 GPIO_ACTIVE_LOW>;
> > +             post-power-on-delay-ms = <100>;
> > +             power-off-delay-us = <5000000>;
> > +     };
> > +
> >       vcc12v_dcin: vcc12v_dcin {
> >               compatible = "regulator-fixed";
> >               regulator-name = "vcc12v_dcin";
> > @@ -147,6 +159,17 @@ vcc_sys: vcc_sys {
> >               regulator-max-microvolt = <4400000>;
> >               vin-supply = <&vbus>;
> >       };
> > +
> > +     /* sourced from vcc_sys, sdio module operates internally at 3.3v */
> > +     vcc_wl: vcc_wl {
> > +             compatible = "regulator-fixed";
> > +             regulator-name = "vcc_wl";
> > +             regulator-always-on;
> > +             regulator-boot-on;
> > +             regulator-min-microvolt = <3300000>;
> > +             regulator-max-microvolt = <3300000>;
> > +             vin-supply = <&vcc_sys>;
> > +     };
> >  };
> >
> >  &cpu0 {
> > @@ -475,6 +498,12 @@ pmic_int_l: pmic-int-l {
> >               };
> >       };
> >
> > +     sdio-pwrseq {
> > +             wifi_enable_h: wifi-enable-h {
> > +                     rockchip,pins = <2 RK_PC2 RK_FUNC_GPIO &pcfg_pull_none>;
> > +             };
> > +     };
> > +
> >       vcc_sd {
> >               vcc_sd_h: vcc-sd-h {
> >                       rockchip,pins = <0 RK_PA5 RK_FUNC_GPIO &pcfg_pull_none>;
> > @@ -516,6 +545,22 @@ &sdmmc0 {
> >       status = "okay";
> >  };
> >
> > +&sdmmc1 {
> > +     bus-width = <4>;
> > +     cap-sd-highspeed;
> > +     cap-sdio-irq;
>
> > +     disable-wp;
>
> From mmc-controller.yaml:
>
>   disable-wp:
>     $ref: /schemas/types.yaml#/definitions/flag
>     description:
>       When set, no physical write-protect line is present. This
>       property should only be specified when the controller has a
>       dedicated write-protect detection logic. If a GPIO is always used
>       for the write-protect detection logic, it is sufficient to not
>       specify the wp-gpios property in the absence of a write-protect
>       line. Not used in combination with eMMC or SDIO.

Appreciate it, I will drop this.

>
> > +     keep-power-in-suspend;
> > +     mmc-pwrseq = <&sdio_pwrseq>;
> > +     non-removable;
> > +     pinctrl-names = "default";
> > +     pinctrl-0 = <&sdmmc1_bus4 &sdmmc1_cmd &sdmmc1_clk>;
> > +     sd-uhs-sdr104;
> > +     vmmc-supply = <&vcc_wl>;
> > +     vqmmc-supply = <&vcc_1v8>;
> > +     status = "okay";
> > +};
> > +
> >  &spdif {
> >       status = "okay";
> >  };
