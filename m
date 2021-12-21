Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C58A347B936
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 05:41:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232300AbhLUElB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 23:41:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbhLUElA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 23:41:00 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 451C7C061574
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 20:41:00 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id z9so11818274qtj.9
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 20:41:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JSpRuL3Dkgc1guMYcky9azBGpIdG/1zM/L5zg9zMIKo=;
        b=X6F2XlhOMAjV/FWcCx6tHXL74AlR7+UPmFiEUZM+VHQFwJkTbklxTYGdewexfBDyPb
         JiD0xaZzAal9Yuzru8jna9bhnXSrcw1KqClxF0y/HVOyuKOz+MtqYjApg4lGdS/o7vq1
         riIjMBCUkiGWZzVaW5awVd+eqXdzs8wu0qEbU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JSpRuL3Dkgc1guMYcky9azBGpIdG/1zM/L5zg9zMIKo=;
        b=Z4iWAwqSeP0GLeOCYB8WpO6IOfAq7rQZIBtA6cKYTxvlG67iEIz9DjB/Jvg7RdU6iK
         tzqz3GnOMWOV/dF2ibuLzdZ+//Smubc3QGUiWCySjEjQ7/VjmdtcaO/QYWctKRGo/HXy
         xSe35YxQeqx5dFi51uumqiNJWOeWx0V6LYeoe6WHqPdLFuK6n5Mxy9N9EikA/y+QNFd0
         bBmbg/OZQbrLsC0D5M21pl5pDWKWsPPWEPll5d04IKltunvaWBBBU14jdy6YoPgOj9XR
         mba0qx7v6YPIc89ZBNAFzVM3IFa+PQWfQO2OuCbtDX97y/fqji0//s/aO0Ot2bst1o4J
         ohRg==
X-Gm-Message-State: AOAM530CGTsw62ovjhDIhi6yOENDiZVJr0UjZfqR6K953d1RJbcll/lW
        9eU5Hgy9fLL6Srfo2HBKeaFBi2FEq3OxaJdlxT0=
X-Google-Smtp-Source: ABdhPJw6cZCVUnCPcM9HISB5PqpqtWafnDMNu+igwRm66xMpbnxPzYWDaWsW8/DsilkqDc6uq+CQG7wCMVNX/jaqAyA=
X-Received: by 2002:ac8:59ce:: with SMTP id f14mr956957qtf.30.1640061659178;
 Mon, 20 Dec 2021 20:40:59 -0800 (PST)
MIME-Version: 1.0
References: <20211130180110.2217042-1-aaelhaj@google.com>
In-Reply-To: <20211130180110.2217042-1-aaelhaj@google.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Tue, 21 Dec 2021 04:40:47 +0000
Message-ID: <CACPK8XcYWqaJrR4fFznROfANAq9X+mua2VBNkbhFBjqY5Ba59w@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: aspeed: Add TYAN S8036 BMC machine
To:     Ali El-Haj-Mahmoud <aaelhaj@google.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andrew Jeffery <andrew@aj.id.au>, Oskar Sneft <osk@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Nov 2021 at 18:01, Ali El-Haj-Mahmoud <aaelhaj@google.com> wrote:
>
> The TYAN S8036 is a server platform with an ASPEED AST2500 BMC.
>
> Signed-off-by: Ali El-Haj-Mahmoud <aaelhaj@google.com>

Reviewed-by: Joel Stanley <joel@jms.id.au>

Applied for v5.17

> ---
>  arch/arm/boot/dts/Makefile                  |   3 +-
>  arch/arm/boot/dts/aspeed-bmc-tyan-s8036.dts | 466 ++++++++++++++++++++
>  2 files changed, 468 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm/boot/dts/aspeed-bmc-tyan-s8036.dts
>
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 8b7f150be39e..b0ca5e88942b 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -1499,4 +1499,5 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
>         aspeed-bmc-quanta-q71l.dtb \
>         aspeed-bmc-supermicro-x11spi.dtb \
>         aspeed-bmc-inventec-transformers.dtb \
> -       aspeed-bmc-tyan-s7106.dtb
> +       aspeed-bmc-tyan-s7106.dtb \
> +       aspeed-bmc-tyan-s8036.dtb
> diff --git a/arch/arm/boot/dts/aspeed-bmc-tyan-s8036.dts b/arch/arm/boot/dts/aspeed-bmc-tyan-s8036.dts
> new file mode 100644
> index 000000000000..873e7bf2361e
> --- /dev/null
> +++ b/arch/arm/boot/dts/aspeed-bmc-tyan-s8036.dts
> @@ -0,0 +1,466 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/dts-v1/;
> +
> +#include "aspeed-g5.dtsi"
> +#include <dt-bindings/gpio/aspeed-gpio.h>
> +#include <dt-bindings/interrupt-controller/irq.h>
> +
> +/ {
> +       model = "Tyan S8036 BMC";
> +       compatible = "tyan,s8036-bmc", "aspeed,ast2500";
> +
> +       chosen {
> +               stdout-path = &uart5;
> +               bootargs = "console=ttyS4,115200 earlycon";
> +       };
> +
> +       memory@80000000 {
> +               device_type = "memory";
> +               reg = <0x80000000 0x20000000>;
> +       };
> +
> +       reserved-memory {
> +               #address-cells = <1>;
> +               #size-cells = <1>;
> +               ranges;
> +
> +               p2a_memory: region@987f0000 {
> +                       no-map;
> +                       reg = <0x987f0000 0x00010000>; /* 64KB */
> +               };
> +
> +               vga_memory: framebuffer@9f000000 {
> +                       no-map;
> +                       reg = <0x9f000000 0x01000000>; /* 16M */
> +               };
> +
> +               gfx_memory: framebuffer {
> +                       size = <0x01000000>; /* 16M */
> +                       alignment = <0x01000000>;
> +                       compatible = "shared-dma-pool";
> +                       reusable;
> +               };
> +       };
> +
> +       leds {
> +               compatible = "gpio-leds";
> +
> +               identify {
> +                       gpios = <&gpio ASPEED_GPIO(A, 2) GPIO_ACTIVE_LOW>;
> +               };
> +
> +               heartbeat {
> +                       gpios = <&gpio ASPEED_GPIO(E, 7) GPIO_ACTIVE_LOW>;
> +               };
> +       };
> +
> +       iio-hwmon {
> +               compatible = "iio-hwmon";
> +               io-channels = <&adc 0>, <&adc 1>, <&adc 2>, <&adc 3>,
> +                       <&adc 4>, <&adc 5>, <&adc 6>, <&adc 7>,
> +                       <&adc 8>, <&adc 9>, <&adc 10>, <&adc 11>,
> +                       <&adc 12>, <&adc 13>, <&adc 14>;
> +       };
> +
> +       iio-hwmon-battery {
> +               compatible = "iio-hwmon";
> +               io-channels = <&adc 15>;
> +       };
> +};
> +
> +&fmc {
> +       status = "okay";
> +       flash@0 {
> +               label = "bmc";
> +               status = "okay";
> +               m25p,fast-read;
> +#include "openbmc-flash-layout.dtsi"
> +       };
> +};
> +
> +&spi1 {
> +       status = "okay";
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_spi1_default>;
> +
> +       flash@0 {
> +               status = "okay";
> +               label = "pnor";
> +               m25p,fast-read;
> +       };
> +};
> +
> +&uart1 {
> +       /* Rear RS-232 connector */
> +       status = "okay";
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_txd1_default
> +                       &pinctrl_rxd1_default>;
> +};
> +
> +&uart2 {
> +       /* RS-232 connector on header */
> +       status = "okay";
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_txd2_default
> +                       &pinctrl_rxd2_default>;
> +};
> +
> +&uart3 {
> +       /* Alternative to vuart to internally connect (route) to uart1
> +        * when vuart cannot be used due to BIOS limitations.
> +        */
> +       status = "okay";
> +};
> +
> +&uart4 {
> +       /* Alternative to vuart to internally connect (route) to the
> +        * external port usually used by uart1 when vuart cannot be
> +        * used due to BIOS limitations.
> +        */
> +       status = "okay";
> +};
> +
> +&uart5 {
> +       /* BMC "debug" (console) UART; connected to RS-232 connector
> +        * on header; selectable via jumpers as alternative to uart2
> +        */
> +       status = "okay";
> +};
> +
> +&uart_routing {
> +       status = "okay";
> +};
> +
> +&vuart {
> +       status = "okay";
> +
> +       /* We enable the VUART here, but leave it in a state that does
> +        * not interfere with the SuperIO. The goal is to have both the
> +        * VUART and the SuperIO available and decide at runtime whether
> +        * the VUART should actually be used. For that reason, configure
> +        * an "invalid" IO address and an IRQ that is not used by the
> +        * BMC.
> +        */
> +       aspeed,lpc-io-reg = <0xffff>;
> +       aspeed,lpc-interrupts = <15 IRQ_TYPE_LEVEL_HIGH>;
> +};
> +
> +&lpc_ctrl {
> +       status = "okay";
> +};
> +
> +&p2a {
> +       status = "okay";
> +       memory-region = <&p2a_memory>;
> +};
> +
> +&lpc_snoop {
> +       status = "okay";
> +       snoop-ports = <0x80>;
> +};
> +
> +&adc {
> +       status = "okay";
> +};
> +
> +&vhub {
> +       status = "okay";
> +};
> +
> +&pwm_tacho {
> +       status = "okay";
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_pwm0_default
> +                       &pinctrl_pwm1_default
> +                       &pinctrl_pwm3_default
> +                       &pinctrl_pwm4_default>;
> +
> +       /* CPU fan */
> +       fan@0 {
> +               reg = <0x00>;
> +               aspeed,fan-tach-ch = /bits/ 8 <0x00>;
> +       };
> +
> +       /* PWM group for chassis fans #1, #2, #3 and #4 */
> +       fan@2 {
> +               reg = <0x03>;
> +               aspeed,fan-tach-ch = /bits/ 8 <0x02>;
> +       };
> +
> +       fan@3 {
> +               reg = <0x03>;
> +               aspeed,fan-tach-ch = /bits/ 8 <0x03>;
> +       };
> +
> +       fan@4 {
> +               reg = <0x03>;
> +               aspeed,fan-tach-ch = /bits/ 8 <0x04>;
> +       };
> +
> +       fan@5 {
> +               reg = <0x03>;
> +               aspeed,fan-tach-ch = /bits/ 8 <0x05>;
> +       };
> +
> +       /* PWM group for chassis fans #5 and #6  */
> +       fan@6 {
> +               reg = <0x04>;
> +               aspeed,fan-tach-ch = /bits/ 8 <0x06>;
> +       };
> +
> +       fan@7 {
> +               reg = <0x04>;
> +               aspeed,fan-tach-ch = /bits/ 8 <0x07>;
> +       };
> +};
> +
> +&i2c0 {
> +       /* Directly connected to Sideband-Temperature Sensor Interface (APML) */
> +       status = "okay";
> +};
> +
> +&i2c1 {
> +       /* Directly connected to IPMB HDR. */
> +       status = "okay";
> +};
> +
> +&i2c2 {
> +       status = "okay";
> +
> +       /* BMC EEPROM, incl. mainboard FRU */
> +       eeprom@50 {
> +               compatible = "atmel,24c256";
> +               reg = <0x50>;
> +       };
> +       /* Also connected to:
> +        * - BCM5720
> +        * - FPGA
> +        * - FAN HDR
> +        * - FPIO HDR
> +        */
> +};
> +
> +&i2c3 {
> +       status = "okay";
> +
> +       /* PSU1 FRU @ 0xA0 */
> +       eeprom@50 {
> +               compatible = "atmel,24c02";
> +               reg = <0x50>;
> +       };
> +
> +       /* PSU2 FRU @ 0xA2 */
> +       eeprom@51 {
> +               compatible = "atmel,24c02";
> +               reg = <0x51>;
> +       };
> +
> +       /* PSU1 @ 0xB0 */
> +       power-supply@58 {
> +               compatible = "pmbus";
> +               reg = <0x58>;
> +       };
> +
> +       /* PSU2 @ 0xB2 */
> +       power-supply@59 {
> +               compatible = "pmbus";
> +               reg = <0x59>;
> +       };
> +
> +};
> +
> +&i2c4 {
> +       status = "okay";
> +};
> +
> +&i2c5 {
> +       status = "okay";
> +       /* Hardware monitor with temperature sensors */
> +       nct7802@28 {
> +               compatible = "nuvoton,nct7802";
> +               reg = <0x28>;
> +               channel@0 { /* LTD */
> +                       reg = <0>;
> +                       status = "okay";
> +               };
> +               channel@1 { /* RTD1 */
> +                       reg = <1>;
> +                       status = "okay";
> +                       sensor-type = "temperature";
> +                       temperature-mode = "thermistor";
> +               };
> +
> +               channel@2 { /* RTD2 */
> +                       reg = <2>;
> +                       status = "okay";
> +                       sensor-type = "temperature";
> +                       temperature-mode = "thermistor";
> +               };
> +
> +               channel@3 { /* RTD3 */
> +                       reg = <3>;
> +                       status = "okay";
> +                       sensor-type = "temperature";
> +               };
> +       };
> +
> +       /* Also connected to:
> +        * - PCA9544
> +        * - CLK BUFF
> +        * - OCP FRU
> +        */
> +};
> +
> +&i2c6 {
> +       status = "okay";
> +       /* Connected to:
> +        * - PCA9548 @0xE0
> +        * - PCA9548 @0xE2
> +        * - PCA9544 @0xE4
> +        */
> +};
> +
> +&i2c7 {
> +       status = "okay";
> +
> +       /* Connected to:
> +        * - PCH SMBUS #4
> +        */
> +};
> +
> +&i2c8 {
> +       status = "okay";
> +
> +       /* Not connected */
> +};
> +
> +&mac0 {
> +       status = "okay";
> +       use-ncsi;
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_rmii1_default>;
> +};
> +
> +&mac1 {
> +       status = "okay";
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_rgmii2_default &pinctrl_mdio2_default>;
> +};
> +
> +&ibt {
> +       status = "okay";
> +};
> +
> +&kcs1 {
> +       status = "okay";
> +       aspeed,lpc-io-reg = <0xca8>;
> +};
> +
> +&kcs3 {
> +       status = "okay";
> +       aspeed,lpc-io-reg = <0xca2>;
> +};
> +
> +/* Enable BMC VGA output to show an early (pre-BIOS) boot screen */
> +&gfx {
> +       status = "okay";
> +       memory-region = <&gfx_memory>;
> +};
> +
> +/* We're following the GPIO naming as defined at
> + * https://github.com/openbmc/docs/blob/master/designs/device-tree-gpio-naming.md.
> + *
> + * Notes on led-identify and id-button:
> + * - A physical button is connected to id-button which
> + *   triggers the clock on a D flip-flop. The /Q output of the
> + *   flip-flop drives its D input.
> + * - The flip-flop's Q output drives led-identify which is
> + *   connected to LEDs.
> + * - With that, every button press toggles the LED between on and off.
> + *
> + * Notes on power-, reset- and nmi- button and control:
> + * - The -button signals can be used to monitor physical buttons.
> + * - The -control signals can be used to actuate the specific
> + *   operation.
> + * - In hardware, the -button signals are connected to the -control
> + *   signals through drivers with the -control signals being
> + *   protected through diodes.
> + */
> +&gpio {
> +       status = "okay";
> +       gpio-line-names =
> +       /*A0*/          "",
> +       /*A1*/          "",
> +       /*A2*/          "led-identify", /* in/out: BMC_CHASSIS_ID_LED_L */
> +       /*A3*/          "",
> +       /*A4*/          "",
> +       /*A5*/          "",
> +       /*A6*/          "",
> +       /*A7*/          "",
> +       /*B0-B7*/       "","","","","","","","",
> +       /*C0-C7*/       "","","","","","","","",
> +       /*D0*/          "",
> +       /*D1*/          "",
> +       /*D2*/          "power-chassis-good", /* in: PWR_GOOD_LED -- Check if this is Z3?*/
> +       /*D3*/          "platform-reset", /* in: RESET_LED_L */
> +       /*D4*/          "",
> +       /*D5*/          "",
> +       /*D6*/          "",
> +       /*D7*/          "",
> +       /*E0*/          "power-button", /* in: BMC_SYS_MON_PWR_BTN_L */
> +       /*E1*/          "power-chassis-control", /* out: BMC_ASSERT_PWR_BTN */
> +       /*E2*/          "reset-button", /* in: BMC_SYS_MOS_RST_BTN_L*/
> +       /*E3*/          "reset-control", /* out: BMC_ASSERT_RST_BTN */
> +       /*E4*/          "nmi-button", /* in: BMC_SYS_MON_NMI_BTN_L */
> +       /*E5*/          "nmi-control", /* out: BMC_ASSERT_NMI_BTN */
> +       /*E6*/          "TSI_RESERT",
> +       /*E7*/          "led-heartbeat", /* out: BMC_GPIOE7 */
> +       /*F0*/          "",
> +       /*F1*/          "clear-cmos-control", /* out: BMC_ASSERT_CLR_CMOS_L */
> +       /*F2*/          "",
> +       /*F3*/          "",
> +       /*F4*/          "led-fault", /* out: BMC_HWM_FAULT_LED_L */
> +       /*F5*/          "BMC_SYS_FAULT_LED_L",
> +       /*F6*/          "BMC_ASSERT_BIOS_WP_L",
> +       /*F7*/          "",
> +       /*G0-G7*/       "","","","","","","","",
> +       /*H0-H7*/       "","","","","","","","",
> +       /*I0-I7*/       "","","","","","","","",
> +       /*J0-J7*/       "","","","","","","","",
> +       /*K0-K7*/       "","","","","","","","",
> +       /*L0-L7*/       "","","","","","","","",
> +       /*M0-M7*/       "","","","","","","","",
> +       /*N0-N7*/       "","","","","","","","",
> +       /*O0-O7*/       "","","","","","","","",
> +       /*P0-P7*/       "","","","","","","","",
> +       /*Q0*/          "",
> +       /*Q1*/          "",
> +       /*Q2*/          "",
> +       /*Q3*/          "",
> +       /*Q4*/          "",
> +       /*Q5*/          "",
> +       /*Q6*/          "id-button", /* in: BMC_CHASSIS_ID_BTN_L */
> +       /*Q7*/          "",
> +       /*R0-R7*/       "","","","","","","","",
> +       /*S0-S7*/       "","","","","","","","",
> +       /*T0-T7*/       "","","","","","","","",
> +       /*U0-U7*/       "","","","","","","","",
> +       /*V0-V7*/       "","","","","","","","",
> +       /*W0-W7*/       "","","","","","","","",
> +       /*X0-X7*/       "","","","","","","","",
> +       /*Y0-Y7*/       "","","","","","","","",
> +       /*Z0-Z2*/       "","","",
> +       /*Z3*/          "post-complete", /* BMC_SYS_MON_PWROK */
> +       /*Z4-Z7*/       "","","","",
> +       /*AA0*/         "",
> +       /*AA1*/         "",
> +       /*AA2*/         "",
> +       /*AA3*/         "",
> +       /*AA4*/         "",
> +       /*AA5*/         "",
> +       /*AA6*/         "",
> +       /*AA7*/         "BMC_ASSERT_BMC_READY",
> +       /*AB0*/         "BMC_SPD_SEL",
> +       /*AB1-AB7*/     "","","","","","","";
> +};
> --
> 2.34.0.rc2.393.gf8c9666880-goog
>
