Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7187D551FBA
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 17:07:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242647AbiFTPHF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 11:07:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234402AbiFTPGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 11:06:45 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5FE122B3A;
        Mon, 20 Jun 2022 07:44:16 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 25KEhPPw103094;
        Mon, 20 Jun 2022 09:43:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1655736205;
        bh=msCQwh/1jtTFGMUA6aVLMiqUgrpZbx3J1b6A951eaYs=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=vOIIsAbumW5KLznaAmq33NyjnfJG7lw+ERXEkomw94LUwMTnqSIVHQtG1+KZvyzeY
         lFknTRHLOBtry0Zppo+2TKDtHvFyG9gEBXkxnQtG2unP5qjzGfGHeUjZ070hnB5rIy
         1JC18WLROCcqWo4EF0YuV8Ip/FJB4luNuXaVgDy0=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 25KEhP2F039948
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 20 Jun 2022 09:43:25 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Mon, 20
 Jun 2022 09:43:24 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Mon, 20 Jun 2022 09:43:24 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 25KEhNr1065265;
        Mon, 20 Jun 2022 09:43:24 -0500
Date:   Mon, 20 Jun 2022 20:13:23 +0530
From:   Rahul T R <r-ravikumar@ti.com>
To:     Jason Kridner <jkridner@gmail.com>
CC:     Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>,
        "Raghavendra, Vignesh" <vigneshr@ti.com>,
        Kishon Vijay Abraham <kishon@ti.com>,
        <krzysztof.kozlowski+dt@linaro.org>, <lee.jones@linaro.org>,
        <rogerq@kernel.org>, <devicetree@vger.kernel.org>,
        <kristo@kernel.org>,
        ARM Kernel List <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Suman Anna <s-anna@ti.com>,
        "Pothukuchi, Vijay" <vijayp@ti.com>,
        Robert Nelson <robertcnelson@gmail.com>
Subject: Re: [PATCH v4 3/3] arm64: dts: ti: k3-j721e-sk: Add pinmux for RPi
 Header
Message-ID: <20220620144322.x54zitvhjreiy3ey@uda0490373>
References: <20220530101031.11357-1-r-ravikumar@ti.com>
 <20220530101031.11357-4-r-ravikumar@ti.com>
 <20220618021614.svhnzlsm2chn5jey@kahuna>
 <CA+T6QPnCut5KVUXcSqfHCjoc=5-JFvRSz=WFosCjQMXdRSjrTw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CA+T6QPnCut5KVUXcSqfHCjoc=5-JFvRSz=WFosCjQMXdRSjrTw@mail.gmail.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08:11-20220618, Jason Kridner wrote:
> For those seeing this message multiple times, my apologies for not
> properly setting up my mailer.
> 
> On Fri, Jun 17, 2022 at 10:16 PM Nishanth Menon <nm@ti.com> wrote:
> >
> > On 15:40-20220530, Rahul T R wrote:
> > > From: Sinthu Raja <sinthu.raja@ti.com>
> > >
> > > Add pinmux required to bring out
> > > i2c5, ehrpwm 2 and 3 and gpios on
> > > 40 pin RPi header on sk board
> > >
> > > Signed-off-by: Sinthu Raja <sinthu.raja@ti.com>
> > > Signed-off-by: Rahul T R <r-ravikumar@ti.com>
> >
> >
> > I was digging deeper at https://www.ti.com/lit/zip/sprr438
> > (PROC112E2(001)_SCH.pdf - J3, Also looking at
> > https://github.com/beagleboard/beaglebone-ai-64/blob/master/BeagleBone%20AI%20-64_SCH_V1.02_211119.pdf
> > (P8, P9)
> >
> > And comparing it to https://www.raspberrypi-spy.co.uk/2012/06/simple-guide-to-the-rpi-gpio-header-and-pins/
> > And considering potential use such as https://pypi.org/project/RPi.GPIO/
> > variation,
> >
> > Here is my suggestion (applies to other TI Boards that attempt to
> > emulate RPI header)
> > a) Default mux in board.dts should be GPIO except for the i2c used for
> >    ID detection.
> > b) Secondary functions should be a dt overlay. (These can easily enable
> >    the pwms and other functions as needed)
> > c) Maintain node names consistent to allow reuse of overlays across
> >    platforms.
> >
> > Usage: you can either use extlinux.conf OR uEnv.txt to apply the
> > overlays as desired (ID detection from hats might help automate it based
> > on the bootloader you'd want to use)
> >
> > Else, you have created a custom configuration here for 1 specific
> > application, various hats that expect GPIO will end up croaking.
> >
> >
> > I am open to discussions here.
> 
> 
> 
> A read of our recent blog series done with Bootlin is worth a read on
> this topic. https://bbb.io/@2804
> 
> My suggestion is to put the entries for the common functions in the
> base tree, but not enable them (except for the I2C used for ID
> detection, as you suggested). This can remove SoC-specific
> requirements on the overlays such that the overlays are written
> against a header specification as defined by the common symbols
> provided. So, make the entries in the base tree and leave them
> "disabled" such that overlays only need to set the symbol to "okay",
> at least for the common stuff to all implementations of the Pi header.
> 

Hi Nishanth, Jason,

I agree for enabling only gpio's in the base dts
and create overlays based on the specific use case

We cannot create separate overlays for each functionality
since the pimux varies based on the combination of
functions enabled

Ex: pinmux for gpio will be different between
enabling only pwm and enabling pwm + spi

When we create a overlay, along with setting
the status to okay, we need to take care of
configuring right pinmux as well

I will send a respin with enabling only gpio
 
> 
> >
> >
> > > ---
> > >  arch/arm64/boot/dts/ti/k3-j721e-sk.dts | 89 ++++++++++++++++++++++----
> > >  1 file changed, 78 insertions(+), 11 deletions(-)
> > >
> > > diff --git a/arch/arm64/boot/dts/ti/k3-j721e-sk.dts b/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
> > > index 98a55778f3fe..b913b18ae133 100644
> > > --- a/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
> > > +++ b/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
> > > @@ -400,6 +400,57 @@
> > >                       J721E_IOPAD(0x124, PIN_INPUT, 7) /* (Y24) PRG0_PRU1_GPO9.GPIO0_72 */
> > >               >;
> > >       };
> > > +
> > > +     main_i2c5_pins_default: main-i2c5-pins-default {
> > > +             pinctrl-single,pins = <
> > > +                     J721E_IOPAD(0x150, PIN_INPUT_PULLUP, 2) /* (Y26) PRG0_MDIO0_MDIO.I2C5_SCL */
> > > +                     J721E_IOPAD(0x154, PIN_INPUT_PULLUP, 2) /* (AA27) PRG0_MDIO0_MDC.I2C5_SDA */
> > > +             >;
> > > +     };
> > > +
> > > +     rpi_header_gpio0_pins_default: rpi-header-gpio0-pins-default {
> > > +             pinctrl-single,pins = <
> > > +                     J721E_IOPAD(0x01c, PIN_INPUT, 7) /* (AD22) PRG1_PRU0_GPO6.GPIO0_7 */
> > > +                     J721E_IOPAD(0x120, PIN_INPUT, 7) /* (AA28) PRG0_PRU1_GPO8.GPIO0_71 */
> > > +                     J721E_IOPAD(0x14c, PIN_INPUT, 7) /* (AA29) PRG0_PRU1_GPO19.GPIO0_82 */
> > > +                     J721E_IOPAD(0x02c, PIN_INPUT, 7) /* (AD21) PRG1_PRU0_GPO10.GPIO0_11 */
> > > +                     J721E_IOPAD(0x198, PIN_INPUT, 7) /* (V25) RGMII6_TD1.GPIO0_101 */
> > > +                     J721E_IOPAD(0x1b0, PIN_INPUT, 7) /* (W24) RGMII6_RD1.GPIO0_107 */
> > > +                     J721E_IOPAD(0x1a0, PIN_INPUT, 7) /* (W29) RGMII6_TXC.GPIO0_103 */
> > > +                     J721E_IOPAD(0x008, PIN_INPUT, 7) /* (AG22) PRG1_PRU0_GPO1.GPIO0_2 */
> > > +                     J721E_IOPAD(0x1d0, PIN_INPUT, 7) /* (AA3) SPI0_D1.GPIO0_115 */
> > > +                     J721E_IOPAD(0x11c, PIN_INPUT, 7) /* (AA24) PRG0_PRU1_GPO7.GPIO0_70 */
> > > +                     J721E_IOPAD(0x148, PIN_INPUT, 7) /* (AA26) PRG0_PRU1_GPO18.GPIO0_81 */
> > > +                     J721E_IOPAD(0x004, PIN_INPUT, 7) /* (AC23) PRG1_PRU0_GPO0.GPIO0_1 */
> > > +                     J721E_IOPAD(0x014, PIN_INPUT, 7) /* (AH23) PRG1_PRU0_GPO4.GPIO0_5 */
> > > +                     J721E_IOPAD(0x020, PIN_INPUT, 7) /* (AE20) PRG1_PRU0_GPO7.GPIO0_8 */
> > > +                     J721E_IOPAD(0x19c, PIN_INPUT, 7) /* (W27) RGMII6_TD0.GPIO0_102 */
> > > +                     J721E_IOPAD(0x1b4, PIN_INPUT, 7) /* (W25) RGMII6_RD0.GPIO0_108 */
> > > +                     J721E_IOPAD(0x188, PIN_INPUT, 7) /* (Y28) RGMII6_TX_CTL.GPIO0_97 */
> > > +                     J721E_IOPAD(0x00c, PIN_INPUT, 7) /* (AF22) PRG1_PRU0_GPO2.GPIO0_3 */
> > > +                     J721E_IOPAD(0x010, PIN_INPUT, 7) /* (AJ23) PRG1_PRU0_GPO3.GPIO0_4 */
> > > +             >;
> > > +     };
> > > +
> > > +     rpi_header_gpio1_pins_default: rpi-header-gpio1-pins-default {
> > > +             pinctrl-single,pins = <
> > > +                     J721E_IOPAD(0x234, PIN_INPUT, 7) /* (U3) EXT_REFCLK1.GPIO1_12 */
> > > +             >;
> > > +     };
> > > +
> > > +     rpi_header_ehrpwm2_pins_default: rpi-header-ehrpwm2-pins-default {
> > > +             pinctrl-single,pins = <
> > > +                     J721E_IOPAD(0x178, PIN_INPUT, 6) /* (U27) RGMII5_RD3.EHRPWM2_A */
> > > +                     J721E_IOPAD(0x17c, PIN_INPUT, 6) /* (U24) RGMII5_RD2.EHRPWM2_B */
> > > +             >;
> > > +     };
> > > +
> > > +     rpi_header_ehrpwm3_pins_default: rpi-header-ehrpwm3-pins-default {
> > > +             pinctrl-single,pins = <
> > > +                     J721E_IOPAD(0x18c, PIN_INPUT, 6) /* (V23) RGMII6_RX_CTL.EHRPWM3_A */
> > > +                     J721E_IOPAD(0x190, PIN_INPUT, 6) /* (W23) RGMII6_TD3.EHRPWM3_B */
> > > +             >;
> > > +     };
> > >  };
> > >
> > >  &wkup_pmx0 {
> > > @@ -631,11 +682,6 @@
> > >       status = "disabled";
> > >  };
> > >
> > > -&main_i2c5 {
> > > -     /* Brought out on RPi Header */
> > > -     status = "disabled";
> > > -};
> > > -
> >
> > Please don't relocate nodes in the same patch - kinda messes up the
> > diffstat and makes review a bit harder.
> >

will fix this in the respin

Regards
Rahul T R

> > >  &main_i2c6 {
> > >       /* Unused */
> > >       status = "disabled";
> > > @@ -1138,18 +1184,39 @@
> > >       status = "disabled";
> > >  };
> > >
> > > -&main_ehrpwm2 {
> > > +&main_ehrpwm4 {
> > >       status = "disabled";
> > >  };
> > >
> > > -&main_ehrpwm3 {
> > > +&main_ehrpwm5 {
> > >       status = "disabled";
> > >  };
> > >
> > > -&main_ehrpwm4 {
> > > -     status = "disabled";
> > > +&main_gpio0 {
> > > +     pinctrl-names = "default";
> > > +     pinctrl-0 = <&rpi_header_gpio0_pins_default>;
> > >  };
> > >
> > > -&main_ehrpwm5 {
> > > -     status = "disabled";
> > > +&main_gpio1 {
> > > +     pinctrl-names = "default";
> > > +     pinctrl-0 = <&rpi_header_gpio1_pins_default>;
> > > +};
> > > +
> > > +&main_i2c5 {
> > > +     pinctrl-names = "default";
> > > +     pinctrl-0 = <&main_i2c5_pins_default>;
> > > +     clock-frequency = <400000>;
> > > +     status = "okay";
> >
> > Defaults in SoC.dtsi so far are "okay" - so adding that again is
> > superfluous This happens when you are relocating nodes etc
> >
> > > +};
> > > +
> > > +&main_ehrpwm2 {
> > > +     pinctrl-names = "default";
> > > +     pinctrl-0 = <&rpi_header_ehrpwm2_pins_default>;
> > > +     status = "okay";
> > > +};
> > > +
> > > +&main_ehrpwm3 {
> > > +     pinctrl-names = "default";
> > > +     pinctrl-0 = <&rpi_header_ehrpwm3_pins_default>;
> > > +     status = "okay";
> > >  };
> >
> > --
> > Regards,
> > Nishanth Menon
> > Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
> 
> 
> 
> -- 
> https://beagleboard.org/about/jkridner - a 501c3 non-profit educating
> around open hardware computing
