Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8900511AD9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 16:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236744AbiD0NzX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 09:55:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236654AbiD0NzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 09:55:22 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5CA33DA50;
        Wed, 27 Apr 2022 06:52:09 -0700 (PDT)
Received: from mail.denx.de (unknown [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: pro@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 2A2C283E15;
        Wed, 27 Apr 2022 15:52:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1651067526;
        bh=+4EQm9aUZRstkXd2N6FPzz9eEs0x+6MPS42eGcT++Rk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=uRrIplqq9l3qhFpPcBaq/ipFB812hShxEKZ+Xxd/HWlUu6vCY/0T6pymrL8LrTvwO
         lbLNdsQQWEq0k9kY7ZCZKhBRbfan2rQ0m1t1EtZDpfZo9SA+lGa5IqOdF6yJ16+fJX
         aXGpXM0fFbRSnoAzlaqhDoC3nn7O71NfdTuqKYkEAWKPE/29dLVmTtvTcNmF4tuGgq
         o3ACDMqC70ExDGFmdP7sOgCdRNC3qxEoEHiS5CUccWb2jECmeWev3i0vbYX1puWqdY
         MNWeiELysT0zLsAZGTPr6Ejuii/fszQW5iNkq5oUy4Rh+kbfpJunC2Y5gA4ws8hpVz
         pBxUdbcOnw2ig==
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Wed, 27 Apr 2022 15:52:06 +0200
From:   pro@denx.de
To:     Fabio Estevam <festevam@gmail.com>
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
Subject: Re: [PATCH v2 2/2] ARM: dts: Add bosch acc board
In-Reply-To: <CAOMZO5CWSx_4SBJ=JoDRwJWJ+QojgV2DNPUo_qNwFHx-afCD6Q@mail.gmail.com>
References: <20220421122619.1913496-1-pro@denx.de>
 <20220421122619.1913496-2-pro@denx.de>
 <CAOMZO5CWSx_4SBJ=JoDRwJWJ+QojgV2DNPUo_qNwFHx-afCD6Q@mail.gmail.com>
Message-ID: <5fc186a889036da5aa11a3ef609bfcc4@denx.de>
X-Sender: pro@denx.de
User-Agent: Roundcube Webmail/1.3.6
X-Virus-Scanned: clamav-milter 0.103.5 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fabio,

thank you for the review. All comments will be incorporated in v3.

On 2022-04-21 22:42, Fabio Estevam wrote:
> Hi Philip,
> 
> On Thu, Apr 21, 2022 at 9:26 AM Philip Oberfichtner <pro@denx.de> 
> wrote:
>> 
>> +/dts-v1/;
>> +
>> +#include <dt-bindings/gpio/gpio.h>
>> +#include <dt-bindings/leds/common.h>
>> +#include "imx6q.dtsi"
>> +
>> +/ {
>> +       model = "Bosch ACC";
>> +       compatible = "bosch,imx6q-acc", "fsl,imx6q";
>> +
>> +       aliases {
>> +               serial0 = &uart2;
>> +               serial1 = &uart1;
>> +
> 
> Unneeded blank line. Please remove it.
> 
>> +               i2c0 = &i2c1;
>> +               i2c1 = &i2c2;
>> +               i2c2 = &i2c3;
>> +               /* eMMC is connected to USDHC interface 4, but shall 
>> get the name 0 */
> 
> Unneeded comment. Please remove it.
> 
>> +               mmc0 = &usdhc4;
>> +               /* SC-Cards is connected to USDHC interface 2, but 
>> shall get the name 1 */
> 
> Ditto.
> 
>> +               mmc1 = &usdhc2;
>> +       };
>> +
>> +       backlight {
>> +               compatible = "pwm-backlight";
>> +               /* The last value is the PWM period in nano-seconds!
>> +                * -> 5 kHz = 200 µS = 200.000 ns
>> +                */
> 
> This is not the correct style for multi-line comments.
> 
> It should be:
> 
> /*
>  * bla bla
>  * bla bla
>  */
> 
> Actually, I think you could just remove these comments.
> 
>> +               pwms = <&pwm1 0 200000>;
>> +               brightness-levels = <0 61 499 1706 4079 8022 13938 
>> 22237 33328 47623 65535>;
>> +               num-interpolated-steps = <10>;
>> +               default-brightness-level = <60>;
>> +               power-supply = <&reg_lcd0_pwr>;
>> +       };
>> +
>> +       refclk: refclk {
>> +               compatible = "fixed-factor-clock";
>> +               #clock-cells = <0>;
>> +
> 
> Unnecessary blank line.
> 
>> +               clocks = <&clks IMX6QDL_CLK_CKO2>;
>> +               clock-div = <1>;
>> +               clock-mult = <1>;
>> +               clock-output-names = "12mhz_refclk";
> 
> Ditto.
> 
>> +
>> +       gpio-leds {
>> +               compatible = "gpio-leds";
>> +               pinctrl-names = "default";
>> +               pinctrl-0 = <&pinctrl_reset_gpio_led>;
>> +
>> +               led-2 {
>> +                       color = <LED_COLOR_ID_RED>;
>> +                       gpios = <&gpio5 18 0>;
> 
> Better use GPIO label:
> 
> gpios = <&gpio5 18 GPIO_ACTIVE_HIGH>;
> 
>> +       memory@10000000 {
>> +               device_type = "memory";
>> +               reg = <0x10000000 0x40000000>;
>> +       };
> 
> Please put the memory node below the alias.
> 
>> +
>> +       supply_5P0: regulator-0 {
> 
> Please check arch/arm/boot/dts/imx6qdl-sabresd.dtsi for a reference
> on how to name the regulators.
> 
>> +       soc {
>> +               aips1: bus@2000000 {};
> 
> Why is this needed?
> 
>> +&audmux {
>> +       pinctrl-names = "default";
>> +       pinctrl-0 = <&pinctrl_audmux>;
>> +       status = "okay";
> 
> Is this needed? I don't see audio support present on this board.
> 
>> +&fec {
>> +       pinctrl-names = "default";
>> +       pinctrl-0 = <&pinctrl_enet>;
>> +       status = "okay";
> 
> Please move the status property as the last one.
> 
> No need for blank lines.
>> +
>> +       clocks = <&clks IMX6QDL_CLK_ENET>,
>> +               <&clks IMX6QDL_CLK_ENET>,
>> +               <&clks IMX6QDL_CLK_ENET>,
>> +               <&clks IMX6QDL_CLK_ENET_REF>;
>> +       clock-names = "ipg", "ahb", "ptp", "enet_out";
>> +       phy-mode = "rmii";
>> +       phy-supply = <&supply_sw4_3V3>;
>> +       phy-handle = <&ethphy>;
>> +
>> +       mdio {
>> +               #address-cells = <1>;
>> +               #size-cells = <0>;
>> +               ethphy: ethernet-phy@0 {
>> +                       compatible = "ethernet-phy-ieee802.3-c22";
>> +                       reg = <0>;
>> +                       interrupt-parent = <&gpio1>;
>> +                       interrupts = <23 IRQ_TYPE_EDGE_FALLING>;
>> +                       smsc,disable-energy-detect;
>> +               };
>> +       };
>> +};
> 
>> +       lm75: sensor@49 {
>> +               pinctrl-names = "default";
>> +               pinctrl-0 = <&pinctrl_lm75>;
>> +
> 
> Uneeded blank line.
> 
>> +       pmic: pmic@8 {
>> +               compatible = "fsl,pfuze100";
>> +               reg = <0x08>;
>> +
>> +               regulators {
>> +                       /*
>> +                        * VDD_CORE is connected to SW1 ABC
>> +                        * We need to define sw1ab and sw1c, but later 
>> it is controlled solely with
>> +                        * sw1c and therefore only this is named 
>> "VDD_SOC".
>> +                        * See PMIC datasheet Rev. 18, chapter 
>> 6.4.4.3.1: "The feedback and all
>> +                        * other controls are accomplished by use of 
>> pin SW1CFB and SW1C control
>> +                        * registers, respectively."
>> +                        * Setting min and max according to SOC 
>> datasheet
>> +                        */
>> +                       pmic_sw1abc: sw1c {
>> +                               regulator-name = "VDD_SOC (sw1abc)";
>> +                               regulator-min-microvolt = <1275000>;
>> +                               regulator-max-microvolt = <1500000>;
>> +                               regulator-boot-on;
>> +                               regulator-always-on;
>> +                               regulator-ramp-delay = <6250>;
>> +
>> +                               default-voltage = <1300000>;
> 
> This is not a valid property.
> 
>> +
>> +                       pmic_sw2: sw2 {
>> +                               regulator-name = "VDD_ARM (sw2)";
>> +                               regulator-min-microvolt = <1050000>;
>> +                               regulator-max-microvolt = <1500000>;
>> +                               regulator-boot-on;
>> +                               regulator-always-on;
>> +                               regulator-ramp-delay = <6250>;
>> +
> 
> Unneeded blank line.
> 
>> +                               default-voltage = <1300000>;
> 
> Invalid property.
> 
>> +&i2c3 {
>> +       pinctrl-names = "default";
>> +       pinctrl-0 = <&pinctrl_i2c3>;
>> +       clock-frequency = <400000>;
>> +       status = "okay";
>> +
>> +       exc3000: touchscreen@2a {
>> +               compatible = "eeti,exc3000";
>> +               reg = <0x2a>;
>> +
>> +               pinctrl-names = "default";
>> +               pinctrl-0 = <&pinctrl_ctouch>;
>> +
>> +               interrupt-parent = <&gpio4>;
>> +               interrupts = <6 IRQ_TYPE_LEVEL_LOW>;
>> +
>> +               touchscreen-size-x = <4096>;
>> +               touchscreen-size-y = <4096>;
> 
> Remove all the blank lines.
> 
>> +&iomuxc {
> 
> We usually put the iomuxc node as the last one.
> 
>> +       pinctrl_gpio_export_gpio_fixed_in: 
>> pinctrl-gpio-export-gpio-fixed-in-grp {
> 
> Not referenced anywhere.
> 
>> +               fsl,pins = <
>> +                       MX6QDL_PAD_KEY_COL2__GPIO4_IO10         
>> 0x80000000      /* CLEAR ALL */
>> +                       MX6QDL_PAD_CSI0_DAT4__GPIO5_IO22        
>> 0x80000000      /* DIG_IN_1 */
>> +                       MX6QDL_PAD_CSI0_DAT5__GPIO5_IO23        
>> 0x80000000      /* DIG_IN_2 */
>> +                       MX6QDL_PAD_SD3_CMD__GPIO7_IO02          
>> 0x80000000      /* PoE */
>> +                       MX6QDL_PAD_SD3_CLK__GPIO7_IO03          
>> 0x80000000      /* PoE T2P */
>> +               >;
>> +       };
>> +
>> +       pinctrl_reset_gpio_led: pinctrl-reset-gpio-led-pin {
> 
> pinctrl_reset_gpio_led: pinctrl-reset-gpio-led-grp
> 
>> +               fsl,pins = <
>> +                       MX6QDL_PAD_CSI0_PIXCLK__GPIO5_IO18             
>>  0x80000000
> 
> Please avoid 0x80000000. Use the real pad setting instead.
> 
>> +               >;
>> +       };
>> +
>> +       pinctrl_gpio_export_gpio_fixed_out: 
>> pinctrl-gpio-export-gpio-fixed-out-grp {
> 
> This is not called anywhere. Please check globally.
> 
>> +               fsl,pins = <
>> +                       MX6QDL_PAD_CSI0_DAT6__GPIO5_IO24        
>> 0x0001B0B0      /*  DIG_OUT_1 */
> 
> 0x1b0b0 for consistency. Please check globally.
> 
> 
>> +       pinctrl_i2c2: i2c2grp {
>> +               fsl,pins = <
>> +                       MX6QDL_PAD_KEY_COL3__I2C2_SCL 0x4001b810
>> +                       MX6QDL_PAD_KEY_ROW3__I2C2_SDA 0x4001b810
>> +                       /* NO SRE | 130 Ohm | SPEED LOW | Open Drain | 
>> PKE | PUE | 100k PU | HYS  */
> 
> No need for comment.
> 
>> +       pinctrl_i2c2_gpio: i2c2-gpiogrp {
>> +               fsl,pins = <
>> +                       MX6QDL_PAD_KEY_COL3__GPIO4_IO12 0x80000000
> 
> Avoid  0x80000000. Please check globally.
> 
>> +       lvds0: lvds-channel@0 {
>> +               fsl,data-mapping = "spwg";
>> +               fsl,data-width = <24>;
>> +
>> +               display-timings {
>> +                       native-mode = <&lvds0_timing0>;
>> +                       lvds0_timing0: timing0 {
>> +                               clock-frequency = <79479000>;
> 
> Please add this panel support in drivers/gpu/drm/panel/panel-simple.c
> and then reference its compatible here.
> 
>> +&sdma {
>> +       fsl,sdma-ram-script-name = "imx/sdma/sdma-imx6q.bin";
> 
> Why is this needed?
> 
>> +       iram = <&ocram>;
> 
> Not a valid property for sdma.
> 
> 
>> +&uart1 {
>> +       pinctrl-names = "default";
>> +       pinctrl-0 = <&pinctrl_uart1>;
>> +       status = "okay";
>> +
>> +       rts-gpios = <&gpio7 8 0>;
> 
> Use GPIO label.
> 
>> +       linux,rs485-enabled-at-boot-time;
>> +       rs485-rx-during-tx;
>> +};
>> +
>> +&uart2 {
>> +       pinctrl-names = "default";
>> +       pinctrl-0 = <&pinctrl_uart2>;
>> +       fsl,uart-has-rtscts;
> 
> s/ fsl,uart-has-rtscts/uart-has-rtscts;
> 
>> +&usbh2 {
>> +       pinctrl-names = "idle", "active";
>> +       pinctrl-0 = <&pinctrl_usbh2_idle>;
>> +       pinctrl-1 = <&pinctrl_usbh2_active>;
>> +       status = "okay";
>> +
>> +       vbus-supply = <&reg_usb_h2_vbus>;
>> +       osc-clkgate-delay = <0x3>;
> 
> Not a valid property.
> 
>> +       pad-supply = <&vgen2_reg>;
> 
> Not a valid property.

-- 
=====================================================================
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-22 Fax: +49-8142-66989-80    Email: pro@denx.de
=====================================================================
