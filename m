Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4237350AA3C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 22:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1392529AbiDUUpo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 16:45:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1392503AbiDUUpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 16:45:38 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 096BC4D273;
        Thu, 21 Apr 2022 13:42:47 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id el3so3196930edb.11;
        Thu, 21 Apr 2022 13:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3S3xMeQJrTUZrhJIQy3VpKqV9ZVwtJZ+u4kxUO5hVBg=;
        b=TKBLnkKBOwUQltQ0PH2ZECvjR+e/8dUDppz25eHObIaww8ByFDdu/gBSYuHfV4umLt
         gNJTnqiqeQ2XYq+do6feWidJZbv6zlgDjqK64BWC7Qh3KQJ0BnEwZotiXy+cT3yzcslO
         ShtLUaSu8kFtr38opqZWC2xKOK6nEdcWX5YlVCW3N0DXrFotnbkQ0gXrpzDGyWpW7GY8
         hU13bp5L5imKVbwU80TmfoOnL7Lu9BpI7ySCfix33yX5Q+0R/2+AB4Z4bnxsX8n0vjR7
         DbUPwzRY0u2l//6KOG3z032NBy1htz//dQj1uiu/wpHmOKa33eQHhHR54VXtjlqinvzG
         2OQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3S3xMeQJrTUZrhJIQy3VpKqV9ZVwtJZ+u4kxUO5hVBg=;
        b=hsNowwaC/iCkrSOTAOczFSz2xLkzv8d0dOA87MuchIV8OPAX6bvBAoQR5ZI3ZyEfDE
         1zWH3sROmI2PuEpXLeAX+4stALFrDniidaWKq1AVnk7K1NV12gPGWdpAURtPlok3nsii
         rtvyMgbKNCTiUjBSZlOparEngIEobxDylHrMGy4oyAAdCG4oWOARzwQX5P2OnhgELU5R
         2BnxVXj0E5MQjCI7XoRMLqXZcmVxiVtTrkzJmirRICSMleAqdeKakYfysElL098M5IrG
         G05anijUfZ0VtxsROwILElAxdwG/CmVhcV7j0ybTDqCCMH0CbXtTISwmG+uCZPSpvGnL
         a8EA==
X-Gm-Message-State: AOAM533rLNDo9vQGlV970T0f9NCRvjMyJhGqBR26MwInVSrbm8zlE6on
        Bud/9DxhJQ54neEhs+LeTye4iddZRyRqXe70474=
X-Google-Smtp-Source: ABdhPJzXIqaWH7WYfpaciII42eZAL7zpbp42e721msNiJ9ap1CYpIosSUt3k1Ejq0ctKLtE9ArJcgjqjvSPx8csilPc=
X-Received: by 2002:a05:6402:35cd:b0:423:daf3:f7a3 with SMTP id
 z13-20020a05640235cd00b00423daf3f7a3mr1421329edc.77.1650573765443; Thu, 21
 Apr 2022 13:42:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220421122619.1913496-1-pro@denx.de> <20220421122619.1913496-2-pro@denx.de>
In-Reply-To: <20220421122619.1913496-2-pro@denx.de>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 21 Apr 2022 17:42:34 -0300
Message-ID: <CAOMZO5CWSx_4SBJ=JoDRwJWJ+QojgV2DNPUo_qNwFHx-afCD6Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] ARM: dts: Add bosch acc board
To:     Philip Oberfichtner <pro@denx.de>
Cc:     "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Winker Matthias <Matthias.Winker@de.bosch.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Philip,

On Thu, Apr 21, 2022 at 9:26 AM Philip Oberfichtner <pro@denx.de> wrote:
>
> +/dts-v1/;
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/leds/common.h>
> +#include "imx6q.dtsi"
> +
> +/ {
> +       model =3D "Bosch ACC";
> +       compatible =3D "bosch,imx6q-acc", "fsl,imx6q";
> +
> +       aliases {
> +               serial0 =3D &uart2;
> +               serial1 =3D &uart1;
> +

Unneeded blank line. Please remove it.

> +               i2c0 =3D &i2c1;
> +               i2c1 =3D &i2c2;
> +               i2c2 =3D &i2c3;
> +               /* eMMC is connected to USDHC interface 4, but shall get =
the name 0 */

Unneeded comment. Please remove it.

> +               mmc0 =3D &usdhc4;
> +               /* SC-Cards is connected to USDHC interface 2, but shall =
get the name 1 */

Ditto.

> +               mmc1 =3D &usdhc2;
> +       };
> +
> +       backlight {
> +               compatible =3D "pwm-backlight";
> +               /* The last value is the PWM period in nano-seconds!
> +                * -> 5 kHz =3D 200 =C2=B5S =3D 200.000 ns
> +                */

This is not the correct style for multi-line comments.

It should be:

/*
 * bla bla
 * bla bla
 */

Actually, I think you could just remove these comments.

> +               pwms =3D <&pwm1 0 200000>;
> +               brightness-levels =3D <0 61 499 1706 4079 8022 13938 2223=
7 33328 47623 65535>;
> +               num-interpolated-steps =3D <10>;
> +               default-brightness-level =3D <60>;
> +               power-supply =3D <&reg_lcd0_pwr>;
> +       };
> +
> +       refclk: refclk {
> +               compatible =3D "fixed-factor-clock";
> +               #clock-cells =3D <0>;
> +

Unnecessary blank line.

> +               clocks =3D <&clks IMX6QDL_CLK_CKO2>;
> +               clock-div =3D <1>;
> +               clock-mult =3D <1>;
> +               clock-output-names =3D "12mhz_refclk";

Ditto.

> +
> +       gpio-leds {
> +               compatible =3D "gpio-leds";
> +               pinctrl-names =3D "default";
> +               pinctrl-0 =3D <&pinctrl_reset_gpio_led>;
> +
> +               led-2 {
> +                       color =3D <LED_COLOR_ID_RED>;
> +                       gpios =3D <&gpio5 18 0>;

Better use GPIO label:

gpios =3D <&gpio5 18 GPIO_ACTIVE_HIGH>;

> +       memory@10000000 {
> +               device_type =3D "memory";
> +               reg =3D <0x10000000 0x40000000>;
> +       };

Please put the memory node below the alias.

> +
> +       supply_5P0: regulator-0 {

Please check arch/arm/boot/dts/imx6qdl-sabresd.dtsi for a reference
on how to name the regulators.

> +       soc {
> +               aips1: bus@2000000 {};

Why is this needed?

> +&audmux {
> +       pinctrl-names =3D "default";
> +       pinctrl-0 =3D <&pinctrl_audmux>;
> +       status =3D "okay";

Is this needed? I don't see audio support present on this board.

> +&fec {
> +       pinctrl-names =3D "default";
> +       pinctrl-0 =3D <&pinctrl_enet>;
> +       status =3D "okay";

Please move the status property as the last one.

No need for blank lines.
> +
> +       clocks =3D <&clks IMX6QDL_CLK_ENET>,
> +               <&clks IMX6QDL_CLK_ENET>,
> +               <&clks IMX6QDL_CLK_ENET>,
> +               <&clks IMX6QDL_CLK_ENET_REF>;
> +       clock-names =3D "ipg", "ahb", "ptp", "enet_out";
> +       phy-mode =3D "rmii";
> +       phy-supply =3D <&supply_sw4_3V3>;
> +       phy-handle =3D <&ethphy>;
> +
> +       mdio {
> +               #address-cells =3D <1>;
> +               #size-cells =3D <0>;
> +               ethphy: ethernet-phy@0 {
> +                       compatible =3D "ethernet-phy-ieee802.3-c22";
> +                       reg =3D <0>;
> +                       interrupt-parent =3D <&gpio1>;
> +                       interrupts =3D <23 IRQ_TYPE_EDGE_FALLING>;
> +                       smsc,disable-energy-detect;
> +               };
> +       };
> +};

> +       lm75: sensor@49 {
> +               pinctrl-names =3D "default";
> +               pinctrl-0 =3D <&pinctrl_lm75>;
> +

Uneeded blank line.

> +       pmic: pmic@8 {
> +               compatible =3D "fsl,pfuze100";
> +               reg =3D <0x08>;
> +
> +               regulators {
> +                       /*
> +                        * VDD_CORE is connected to SW1 ABC
> +                        * We need to define sw1ab and sw1c, but later it=
 is controlled solely with
> +                        * sw1c and therefore only this is named "VDD_SOC=
".
> +                        * See PMIC datasheet Rev. 18, chapter 6.4.4.3.1:=
 "The feedback and all
> +                        * other controls are accomplished by use of pin =
SW1CFB and SW1C control
> +                        * registers, respectively."
> +                        * Setting min and max according to SOC datasheet
> +                        */
> +                       pmic_sw1abc: sw1c {
> +                               regulator-name =3D "VDD_SOC (sw1abc)";
> +                               regulator-min-microvolt =3D <1275000>;
> +                               regulator-max-microvolt =3D <1500000>;
> +                               regulator-boot-on;
> +                               regulator-always-on;
> +                               regulator-ramp-delay =3D <6250>;
> +
> +                               default-voltage =3D <1300000>;

This is not a valid property.

> +
> +                       pmic_sw2: sw2 {
> +                               regulator-name =3D "VDD_ARM (sw2)";
> +                               regulator-min-microvolt =3D <1050000>;
> +                               regulator-max-microvolt =3D <1500000>;
> +                               regulator-boot-on;
> +                               regulator-always-on;
> +                               regulator-ramp-delay =3D <6250>;
> +

Unneeded blank line.

> +                               default-voltage =3D <1300000>;

Invalid property.

> +&i2c3 {
> +       pinctrl-names =3D "default";
> +       pinctrl-0 =3D <&pinctrl_i2c3>;
> +       clock-frequency =3D <400000>;
> +       status =3D "okay";
> +
> +       exc3000: touchscreen@2a {
> +               compatible =3D "eeti,exc3000";
> +               reg =3D <0x2a>;
> +
> +               pinctrl-names =3D "default";
> +               pinctrl-0 =3D <&pinctrl_ctouch>;
> +
> +               interrupt-parent =3D <&gpio4>;
> +               interrupts =3D <6 IRQ_TYPE_LEVEL_LOW>;
> +
> +               touchscreen-size-x =3D <4096>;
> +               touchscreen-size-y =3D <4096>;

Remove all the blank lines.

> +&iomuxc {

We usually put the iomuxc node as the last one.

> +       pinctrl_gpio_export_gpio_fixed_in: pinctrl-gpio-export-gpio-fixed=
-in-grp {

Not referenced anywhere.

> +               fsl,pins =3D <
> +                       MX6QDL_PAD_KEY_COL2__GPIO4_IO10         0x8000000=
0      /* CLEAR ALL */
> +                       MX6QDL_PAD_CSI0_DAT4__GPIO5_IO22        0x8000000=
0      /* DIG_IN_1 */
> +                       MX6QDL_PAD_CSI0_DAT5__GPIO5_IO23        0x8000000=
0      /* DIG_IN_2 */
> +                       MX6QDL_PAD_SD3_CMD__GPIO7_IO02          0x8000000=
0      /* PoE */
> +                       MX6QDL_PAD_SD3_CLK__GPIO7_IO03          0x8000000=
0      /* PoE T2P */
> +               >;
> +       };
> +
> +       pinctrl_reset_gpio_led: pinctrl-reset-gpio-led-pin {

pinctrl_reset_gpio_led: pinctrl-reset-gpio-led-grp

> +               fsl,pins =3D <
> +                       MX6QDL_PAD_CSI0_PIXCLK__GPIO5_IO18              0=
x80000000

Please avoid 0x80000000. Use the real pad setting instead.

> +               >;
> +       };
> +
> +       pinctrl_gpio_export_gpio_fixed_out: pinctrl-gpio-export-gpio-fixe=
d-out-grp {

This is not called anywhere. Please check globally.

> +               fsl,pins =3D <
> +                       MX6QDL_PAD_CSI0_DAT6__GPIO5_IO24        0x0001B0B=
0      /*  DIG_OUT_1 */

0x1b0b0 for consistency. Please check globally.


> +       pinctrl_i2c2: i2c2grp {
> +               fsl,pins =3D <
> +                       MX6QDL_PAD_KEY_COL3__I2C2_SCL 0x4001b810
> +                       MX6QDL_PAD_KEY_ROW3__I2C2_SDA 0x4001b810
> +                       /* NO SRE | 130 Ohm | SPEED LOW | Open Drain | PK=
E | PUE | 100k PU | HYS  */

No need for comment.

> +       pinctrl_i2c2_gpio: i2c2-gpiogrp {
> +               fsl,pins =3D <
> +                       MX6QDL_PAD_KEY_COL3__GPIO4_IO12 0x80000000

Avoid  0x80000000. Please check globally.

> +       lvds0: lvds-channel@0 {
> +               fsl,data-mapping =3D "spwg";
> +               fsl,data-width =3D <24>;
> +
> +               display-timings {
> +                       native-mode =3D <&lvds0_timing0>;
> +                       lvds0_timing0: timing0 {
> +                               clock-frequency =3D <79479000>;

Please add this panel support in drivers/gpu/drm/panel/panel-simple.c
and then reference its compatible here.

> +&sdma {
> +       fsl,sdma-ram-script-name =3D "imx/sdma/sdma-imx6q.bin";

Why is this needed?

> +       iram =3D <&ocram>;

Not a valid property for sdma.


> +&uart1 {
> +       pinctrl-names =3D "default";
> +       pinctrl-0 =3D <&pinctrl_uart1>;
> +       status =3D "okay";
> +
> +       rts-gpios =3D <&gpio7 8 0>;

Use GPIO label.

> +       linux,rs485-enabled-at-boot-time;
> +       rs485-rx-during-tx;
> +};
> +
> +&uart2 {
> +       pinctrl-names =3D "default";
> +       pinctrl-0 =3D <&pinctrl_uart2>;
> +       fsl,uart-has-rtscts;

s/ fsl,uart-has-rtscts/uart-has-rtscts;

> +&usbh2 {
> +       pinctrl-names =3D "idle", "active";
> +       pinctrl-0 =3D <&pinctrl_usbh2_idle>;
> +       pinctrl-1 =3D <&pinctrl_usbh2_active>;
> +       status =3D "okay";
> +
> +       vbus-supply =3D <&reg_usb_h2_vbus>;
> +       osc-clkgate-delay =3D <0x3>;

Not a valid property.

> +       pad-supply =3D <&vgen2_reg>;

Not a valid property.
