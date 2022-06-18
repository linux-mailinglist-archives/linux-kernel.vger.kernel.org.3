Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5C6A55045F
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 14:11:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233986AbiFRMLX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jun 2022 08:11:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231329AbiFRMLU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jun 2022 08:11:20 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 797FD13DD1;
        Sat, 18 Jun 2022 05:11:19 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id x75so4873350qkb.12;
        Sat, 18 Jun 2022 05:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SXC2BsNoVt3EcIxryvdord8k0rLORi0J738TA6+GHTY=;
        b=NrtAsD3/x8hHa6/raOZLYmPQqsFNexitsbRvGR1RinfIomg6XJs4lj4Y2+/2oDYQjr
         HiLgfg9/AXzVLZQzOrd3sIMnTKmHG8gK4zQ68PuUavMq23azIPeBL0Sb2schJ+rWtziS
         WFrGVMNHU/+0n9k5TpgzwfG0DOKG+9vzZRs8HYU6g/Sbgqo1m5wsJlPNyfTuHt4hKdc9
         8r+6FJK1eQovjARIvGtQ7OoyeL6zv3Vaxe4rRMg2af0J/1+sNOviYSofzKd6osmWsBCT
         M9L1KsblxWeip5BdO8YQRX+6qJSbHOFKfm03WssPQTTy3YFxpzdYIyGTP9Aud63zSU0G
         HXyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SXC2BsNoVt3EcIxryvdord8k0rLORi0J738TA6+GHTY=;
        b=UBpv0DxRPkgqWGcGX7Vh0qN9uNTB5xh7MyNTP25F3yv8lCJ4H5gh9U80oOLIF5vhJ0
         pEN56UmHOKL7F8u3KrUBnMpFQedicZc1JC4uMwcZXtUmo+QQz8/g+Pr4ZTlP/Zimd8NW
         thO5mMBr8IfbEfJ52HP0Vq4M3Zi8Jx71EurZC2TYiq9U8Vde6Gg19d/VF1gXTwVzzS2K
         tj8oYXKJmUkRvYWx0mF6n+F8zJxIQK+wyUBjRsfBFY5UT77Yc/fWKZJKd3ZswqqoPgOE
         c6cwqB9uJ0dic3mXoK7x1fwHllEoOFrwmHtCgcYa+wToEaDK1mxXKs6Ebkc6645F/FsE
         QQeg==
X-Gm-Message-State: AJIora8XpNywwNiLTLquGgJHYsUJpD/VpAbiBixUH/l9OW0zZ7vx2us1
        66FZsthgQ7SIyhnYwREKqZkpzbTYdKgtp1e+wiqwDsx0ooU0Zg==
X-Google-Smtp-Source: AGRyM1u0efNrtt6qKvfc5VUiucWIB57wH5ui2txDo71qtycuSVFPozZBUNURpr0kW/6+oAqX8KXsGr0JeTG4YBuN0Bc=
X-Received: by 2002:a37:a5d0:0:b0:6a6:7cbc:dc2a with SMTP id
 o199-20020a37a5d0000000b006a67cbcdc2amr10131003qke.496.1655554278367; Sat, 18
 Jun 2022 05:11:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220530101031.11357-1-r-ravikumar@ti.com> <20220530101031.11357-4-r-ravikumar@ti.com>
 <20220618021614.svhnzlsm2chn5jey@kahuna>
In-Reply-To: <20220618021614.svhnzlsm2chn5jey@kahuna>
From:   Jason Kridner <jkridner@gmail.com>
Date:   Sat, 18 Jun 2022 08:11:07 -0400
Message-ID: <CA+T6QPnCut5KVUXcSqfHCjoc=5-JFvRSz=WFosCjQMXdRSjrTw@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] arm64: dts: ti: k3-j721e-sk: Add pinmux for RPi Header
To:     Nishanth Menon <nm@ti.com>
Cc:     Rahul T R <r-ravikumar@ti.com>, Rob Herring <robh+dt@kernel.org>,
        "Raghavendra, Vignesh" <vigneshr@ti.com>,
        Kishon Vijay Abraham <kishon@ti.com>,
        krzysztof.kozlowski+dt@linaro.org, lee.jones@linaro.org,
        rogerq@kernel.org, devicetree@vger.kernel.org, kristo@kernel.org,
        ARM Kernel List <linux-arm-kernel@lists.infradead.org>,
        linux-kernel@vger.kernel.org, Suman Anna <s-anna@ti.com>,
        "Pothukuchi, Vijay" <vijayp@ti.com>,
        Robert Nelson <robertcnelson@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For those seeing this message multiple times, my apologies for not
properly setting up my mailer.

On Fri, Jun 17, 2022 at 10:16 PM Nishanth Menon <nm@ti.com> wrote:
>
> On 15:40-20220530, Rahul T R wrote:
> > From: Sinthu Raja <sinthu.raja@ti.com>
> >
> > Add pinmux required to bring out
> > i2c5, ehrpwm 2 and 3 and gpios on
> > 40 pin RPi header on sk board
> >
> > Signed-off-by: Sinthu Raja <sinthu.raja@ti.com>
> > Signed-off-by: Rahul T R <r-ravikumar@ti.com>
>
>
> I was digging deeper at https://www.ti.com/lit/zip/sprr438
> (PROC112E2(001)_SCH.pdf - J3, Also looking at
> https://github.com/beagleboard/beaglebone-ai-64/blob/master/BeagleBone%20AI%20-64_SCH_V1.02_211119.pdf
> (P8, P9)
>
> And comparing it to https://www.raspberrypi-spy.co.uk/2012/06/simple-guide-to-the-rpi-gpio-header-and-pins/
> And considering potential use such as https://pypi.org/project/RPi.GPIO/
> variation,
>
> Here is my suggestion (applies to other TI Boards that attempt to
> emulate RPI header)
> a) Default mux in board.dts should be GPIO except for the i2c used for
>    ID detection.
> b) Secondary functions should be a dt overlay. (These can easily enable
>    the pwms and other functions as needed)
> c) Maintain node names consistent to allow reuse of overlays across
>    platforms.
>
> Usage: you can either use extlinux.conf OR uEnv.txt to apply the
> overlays as desired (ID detection from hats might help automate it based
> on the bootloader you'd want to use)
>
> Else, you have created a custom configuration here for 1 specific
> application, various hats that expect GPIO will end up croaking.
>
>
> I am open to discussions here.



A read of our recent blog series done with Bootlin is worth a read on
this topic. https://bbb.io/@2804

My suggestion is to put the entries for the common functions in the
base tree, but not enable them (except for the I2C used for ID
detection, as you suggested). This can remove SoC-specific
requirements on the overlays such that the overlays are written
against a header specification as defined by the common symbols
provided. So, make the entries in the base tree and leave them
"disabled" such that overlays only need to set the symbol to "okay",
at least for the common stuff to all implementations of the Pi header.


>
>
> > ---
> >  arch/arm64/boot/dts/ti/k3-j721e-sk.dts | 89 ++++++++++++++++++++++----
> >  1 file changed, 78 insertions(+), 11 deletions(-)
> >
> > diff --git a/arch/arm64/boot/dts/ti/k3-j721e-sk.dts b/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
> > index 98a55778f3fe..b913b18ae133 100644
> > --- a/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
> > +++ b/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
> > @@ -400,6 +400,57 @@
> >                       J721E_IOPAD(0x124, PIN_INPUT, 7) /* (Y24) PRG0_PRU1_GPO9.GPIO0_72 */
> >               >;
> >       };
> > +
> > +     main_i2c5_pins_default: main-i2c5-pins-default {
> > +             pinctrl-single,pins = <
> > +                     J721E_IOPAD(0x150, PIN_INPUT_PULLUP, 2) /* (Y26) PRG0_MDIO0_MDIO.I2C5_SCL */
> > +                     J721E_IOPAD(0x154, PIN_INPUT_PULLUP, 2) /* (AA27) PRG0_MDIO0_MDC.I2C5_SDA */
> > +             >;
> > +     };
> > +
> > +     rpi_header_gpio0_pins_default: rpi-header-gpio0-pins-default {
> > +             pinctrl-single,pins = <
> > +                     J721E_IOPAD(0x01c, PIN_INPUT, 7) /* (AD22) PRG1_PRU0_GPO6.GPIO0_7 */
> > +                     J721E_IOPAD(0x120, PIN_INPUT, 7) /* (AA28) PRG0_PRU1_GPO8.GPIO0_71 */
> > +                     J721E_IOPAD(0x14c, PIN_INPUT, 7) /* (AA29) PRG0_PRU1_GPO19.GPIO0_82 */
> > +                     J721E_IOPAD(0x02c, PIN_INPUT, 7) /* (AD21) PRG1_PRU0_GPO10.GPIO0_11 */
> > +                     J721E_IOPAD(0x198, PIN_INPUT, 7) /* (V25) RGMII6_TD1.GPIO0_101 */
> > +                     J721E_IOPAD(0x1b0, PIN_INPUT, 7) /* (W24) RGMII6_RD1.GPIO0_107 */
> > +                     J721E_IOPAD(0x1a0, PIN_INPUT, 7) /* (W29) RGMII6_TXC.GPIO0_103 */
> > +                     J721E_IOPAD(0x008, PIN_INPUT, 7) /* (AG22) PRG1_PRU0_GPO1.GPIO0_2 */
> > +                     J721E_IOPAD(0x1d0, PIN_INPUT, 7) /* (AA3) SPI0_D1.GPIO0_115 */
> > +                     J721E_IOPAD(0x11c, PIN_INPUT, 7) /* (AA24) PRG0_PRU1_GPO7.GPIO0_70 */
> > +                     J721E_IOPAD(0x148, PIN_INPUT, 7) /* (AA26) PRG0_PRU1_GPO18.GPIO0_81 */
> > +                     J721E_IOPAD(0x004, PIN_INPUT, 7) /* (AC23) PRG1_PRU0_GPO0.GPIO0_1 */
> > +                     J721E_IOPAD(0x014, PIN_INPUT, 7) /* (AH23) PRG1_PRU0_GPO4.GPIO0_5 */
> > +                     J721E_IOPAD(0x020, PIN_INPUT, 7) /* (AE20) PRG1_PRU0_GPO7.GPIO0_8 */
> > +                     J721E_IOPAD(0x19c, PIN_INPUT, 7) /* (W27) RGMII6_TD0.GPIO0_102 */
> > +                     J721E_IOPAD(0x1b4, PIN_INPUT, 7) /* (W25) RGMII6_RD0.GPIO0_108 */
> > +                     J721E_IOPAD(0x188, PIN_INPUT, 7) /* (Y28) RGMII6_TX_CTL.GPIO0_97 */
> > +                     J721E_IOPAD(0x00c, PIN_INPUT, 7) /* (AF22) PRG1_PRU0_GPO2.GPIO0_3 */
> > +                     J721E_IOPAD(0x010, PIN_INPUT, 7) /* (AJ23) PRG1_PRU0_GPO3.GPIO0_4 */
> > +             >;
> > +     };
> > +
> > +     rpi_header_gpio1_pins_default: rpi-header-gpio1-pins-default {
> > +             pinctrl-single,pins = <
> > +                     J721E_IOPAD(0x234, PIN_INPUT, 7) /* (U3) EXT_REFCLK1.GPIO1_12 */
> > +             >;
> > +     };
> > +
> > +     rpi_header_ehrpwm2_pins_default: rpi-header-ehrpwm2-pins-default {
> > +             pinctrl-single,pins = <
> > +                     J721E_IOPAD(0x178, PIN_INPUT, 6) /* (U27) RGMII5_RD3.EHRPWM2_A */
> > +                     J721E_IOPAD(0x17c, PIN_INPUT, 6) /* (U24) RGMII5_RD2.EHRPWM2_B */
> > +             >;
> > +     };
> > +
> > +     rpi_header_ehrpwm3_pins_default: rpi-header-ehrpwm3-pins-default {
> > +             pinctrl-single,pins = <
> > +                     J721E_IOPAD(0x18c, PIN_INPUT, 6) /* (V23) RGMII6_RX_CTL.EHRPWM3_A */
> > +                     J721E_IOPAD(0x190, PIN_INPUT, 6) /* (W23) RGMII6_TD3.EHRPWM3_B */
> > +             >;
> > +     };
> >  };
> >
> >  &wkup_pmx0 {
> > @@ -631,11 +682,6 @@
> >       status = "disabled";
> >  };
> >
> > -&main_i2c5 {
> > -     /* Brought out on RPi Header */
> > -     status = "disabled";
> > -};
> > -
>
> Please don't relocate nodes in the same patch - kinda messes up the
> diffstat and makes review a bit harder.
>
> >  &main_i2c6 {
> >       /* Unused */
> >       status = "disabled";
> > @@ -1138,18 +1184,39 @@
> >       status = "disabled";
> >  };
> >
> > -&main_ehrpwm2 {
> > +&main_ehrpwm4 {
> >       status = "disabled";
> >  };
> >
> > -&main_ehrpwm3 {
> > +&main_ehrpwm5 {
> >       status = "disabled";
> >  };
> >
> > -&main_ehrpwm4 {
> > -     status = "disabled";
> > +&main_gpio0 {
> > +     pinctrl-names = "default";
> > +     pinctrl-0 = <&rpi_header_gpio0_pins_default>;
> >  };
> >
> > -&main_ehrpwm5 {
> > -     status = "disabled";
> > +&main_gpio1 {
> > +     pinctrl-names = "default";
> > +     pinctrl-0 = <&rpi_header_gpio1_pins_default>;
> > +};
> > +
> > +&main_i2c5 {
> > +     pinctrl-names = "default";
> > +     pinctrl-0 = <&main_i2c5_pins_default>;
> > +     clock-frequency = <400000>;
> > +     status = "okay";
>
> Defaults in SoC.dtsi so far are "okay" - so adding that again is
> superfluous This happens when you are relocating nodes etc
>
> > +};
> > +
> > +&main_ehrpwm2 {
> > +     pinctrl-names = "default";
> > +     pinctrl-0 = <&rpi_header_ehrpwm2_pins_default>;
> > +     status = "okay";
> > +};
> > +
> > +&main_ehrpwm3 {
> > +     pinctrl-names = "default";
> > +     pinctrl-0 = <&rpi_header_ehrpwm3_pins_default>;
> > +     status = "okay";
> >  };
>
> --
> Regards,
> Nishanth Menon
> Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D



-- 
https://beagleboard.org/about/jkridner - a 501c3 non-profit educating
around open hardware computing
