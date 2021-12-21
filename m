Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1C0647B933
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 05:38:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232241AbhLUEiL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 23:38:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbhLUEiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 23:38:10 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 920A8C061574;
        Mon, 20 Dec 2021 20:38:09 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id t11so11824576qtw.3;
        Mon, 20 Dec 2021 20:38:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RsxagQNVjAlOWZkFF0z6G9kSXib57m9FjMdPpgdXvNY=;
        b=hOcLQa1XcNU+Ih5GiogFhvO2jIoMeutd20hrzV/o0vW18Z2lbhjdo2NA3vleC08r4V
         s21hG1unZAigUUFF1Ov7eg8hr5AejdvW0c3ocFS49FHdiKKmpb+wiX6abC57B29U+iZh
         2EzuZQFqqVhTYc5W5zqkpul67IGFMJJnVAMd8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RsxagQNVjAlOWZkFF0z6G9kSXib57m9FjMdPpgdXvNY=;
        b=bf3jGw0Law1va0gmvwFlaBhdrv9fgreOPt2dhBcx6OiL7UbLyL0ZB+ScyX4JXdJklK
         9Cdq2wjvtph/Tw+vaNOiaTdM76dOY6RoNLka+W5yg9fKnDDHdMMf+clS3ZFgHNgtY59S
         f+XMmczgY8OhxorAi9DC8E0xExWUB9YQ9fhz84LDeNXysMzw0O9xo9jFpebcn7y93lIK
         scPNSkn8tj77NU0HfRVPRvjlTjCioCfVkwOZFK3kPxXVQ3QzYxFRQGFhD3CYZH2rWEWw
         Iogn2qMfATCBJJ4f0ACRUvLYlZ6TquFUuLz8tBC/JT4rGN6aHBh8tUKKwwXzHC60zdGy
         nobg==
X-Gm-Message-State: AOAM5310wmbspRlyzyRNLy9oOj/oRiCfg0bJ16eJhw75Q6bPutfnIXUD
        jAMglzUbKGcWU8I8YWe85RDuV9yoDqdvzo6gQNU=
X-Google-Smtp-Source: ABdhPJy8usOx70sN6kErEx6hvRM9cmMn2UTVkbBPu20sEnZAyjeAOdkS45tQjZJP4WddNHhGez6YYbZsl56LqrfRjRg=
X-Received: by 2002:a05:622a:38d:: with SMTP id j13mr924071qtx.159.1640061487409;
 Mon, 20 Dec 2021 20:38:07 -0800 (PST)
MIME-Version: 1.0
References: <20211207094923.422422-1-howard.chiu@quantatw.com>
In-Reply-To: <20211207094923.422422-1-howard.chiu@quantatw.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Tue, 21 Dec 2021 04:37:55 +0000
Message-ID: <CACPK8XddhFn3PreJM3D=djkREgqGD7yZhS7YoqxxXsNfhZpLhQ@mail.gmail.com>
Subject: Re: [PATCH v8] ARM: dts: aspeed: Adding Facebook Bletchley BMC
To:     Howard Chiu <howard10703049@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Andrew Jeffery <andrew@aj.id.au>,
        devicetree <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Patrick Williams <patrick@stwcx.xyz>,
        =?UTF-8?B?UG90aW4gTGFpICjos7Tmn4/lu7cp?= <Potin.Lai@quantatw.com>,
        Howard Chiu <howard.chiu@quantatw.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Patrick,

On Tue, 7 Dec 2021 at 09:52, Howard Chiu <howard10703049@gmail.com> wrote:
>
> Initial introduction of Facebook Bletchley equipped with
> Aspeed 2600 BMC SoC.
>
> Signed-off-by: Howard Chiu <howard.chiu@quantatw.com>

Are you ok for this one to go in for v5.17?

> ---
> Change since v7:
> - Add switchphy mode back due to unknown failure
>
> Change since v6:
> - Fix FUSB302 node warnings
> - Remove switchphy node.
> - Remvoe status property from spi-gpio node
> - Remove interrupt pin of FUSB302 temporally due to hardware issue
> - Add more gpio-line-name
> - Replace MP5023 device drivr with "mps,mp5023"
>
> Change since v5:
> - Add an EEPROM on i2c-7
> - Change address of FUSB302 to 0x22
> - Assign interrupt pin to FUSB302
> - Rework pin assignment of pca9539
>
> Change since v4:
> - Change address of TMP421 on i2c-12 to 0x4d
>
> Change since v3:
> - Add a TMP421 on i2c-10
>
> Change since v2:
> - Remove uart5 workaround
> - Remove gpio nodes of pca9552/pca9539
> - Modify gpio-line-name of led/power/presence pins with openbmc pattern
> - Add MP5023 devices
>
> Change since v1:
> - Keep sorted in Makefile
> - Change baudrate to 57600 from 115200
> - Rename node *-ember to *-amber
> - Use openbmc-flash-layout-128.dtsi
>
>  arch/arm/boot/dts/Makefile                    |   1 +
>  .../dts/aspeed-bmc-facebook-bletchley.dts     | 756 ++++++++++++++++++
>  2 files changed, 757 insertions(+)
>  create mode 100644 arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
>
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 0de64f237cd8..b804b577010a 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -1482,6 +1482,7 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
>         aspeed-bmc-arm-stardragon4800-rep2.dtb \
>         aspeed-bmc-asrock-e3c246d4i.dtb \
>         aspeed-bmc-bytedance-g220a.dtb \
> +       aspeed-bmc-facebook-bletchley.dtb \
>         aspeed-bmc-facebook-cloudripper.dtb \
>         aspeed-bmc-facebook-cmm.dtb \
>         aspeed-bmc-facebook-elbert.dtb \
> diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
> new file mode 100644
> index 000000000000..f973ea883b97
> --- /dev/null
> +++ b/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
> @@ -0,0 +1,756 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +// Copyright (c) 2021 Facebook Inc.
> +/dts-v1/;
> +
> +#include "aspeed-g6.dtsi"
> +#include <dt-bindings/gpio/aspeed-gpio.h>
> +#include <dt-bindings/usb/pd.h>
> +
> +/ {
> +       model = "Facebook Bletchley BMC";
> +       compatible = "facebook,bletchley-bmc", "aspeed,ast2600";
> +
> +       aliases {
> +               serial4 = &uart5;
> +       };
> +
> +       chosen {
> +               bootargs = "console=ttyS4,57600n8";
> +       };
> +
> +       memory@80000000 {
> +               device_type = "memory";
> +               reg = <0x80000000 0x80000000>;
> +       };
> +
> +       iio-hwmon {
> +               compatible = "iio-hwmon";
> +               io-channels = <&adc0 0>, <&adc0 1>, <&adc0 2>, <&adc0 3>,
> +                       <&adc0 4>, <&adc0 5>, <&adc0 6>, <&adc0 7>,
> +                       <&adc1 0>, <&adc1 1>, <&adc1 2>, <&adc1 3>,
> +                       <&adc1 4>, <&adc1 5>, <&adc1 6>, <&adc1 7>;
> +       };
> +
> +       spi_gpio: spi-gpio {
> +               compatible = "spi-gpio";
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +
> +               gpio-sck = <&gpio0 ASPEED_GPIO(Z, 3) GPIO_ACTIVE_HIGH>;
> +               gpio-mosi = <&gpio0 ASPEED_GPIO(Z, 4) GPIO_ACTIVE_HIGH>;
> +               gpio-miso = <&gpio0 ASPEED_GPIO(Z, 5) GPIO_ACTIVE_HIGH>;
> +               num-chipselects = <1>;
> +               cs-gpios = <&gpio0 ASPEED_GPIO(Z, 0) GPIO_ACTIVE_LOW>;
> +
> +               tpmdev@0 {
> +                       compatible = "tcg,tpm_tis-spi";
> +                       spi-max-frequency = <33000000>;
> +                       reg = <0>;
> +               };
> +       };
> +
> +       switchphy: ethernet-phy@0 {
> +               // Fixed link
> +       };
> +
> +       leds {
> +               compatible = "gpio-leds";
> +
> +               sys_log_id {
> +                       retain-state-shutdown;
> +                       default-state = "keep";
> +                       gpios = <&front_leds 0 GPIO_ACTIVE_HIGH>;
> +               };
> +               fan0_blue {
> +                       retain-state-shutdown;
> +                       default-state = "on";
> +                       gpios = <&fan_ioexp 8 GPIO_ACTIVE_HIGH>;
> +               };
> +               fan1_blue {
> +                       retain-state-shutdown;
> +                       default-state = "on";
> +                       gpios = <&fan_ioexp 9 GPIO_ACTIVE_HIGH>;
> +               };
> +               fan2_blue {
> +                       retain-state-shutdown;
> +                       default-state = "on";
> +                       gpios = <&fan_ioexp 10 GPIO_ACTIVE_HIGH>;
> +               };
> +               fan3_blue {
> +                       retain-state-shutdown;
> +                       default-state = "on";
> +                       gpios = <&fan_ioexp 11 GPIO_ACTIVE_HIGH>;
> +               };
> +               fan0_amber {
> +                       retain-state-shutdown;
> +                       default-state = "off";
> +                       gpios = <&fan_ioexp 12 GPIO_ACTIVE_HIGH>;
> +               };
> +               fan1_amber {
> +                       retain-state-shutdown;
> +                       default-state = "off";
> +                       gpios = <&fan_ioexp 13 GPIO_ACTIVE_HIGH>;
> +               };
> +               fan2_amber {
> +                       retain-state-shutdown;
> +                       default-state = "off";
> +                       gpios = <&fan_ioexp 14 GPIO_ACTIVE_HIGH>;
> +               };
> +               fan3_amber {
> +                       retain-state-shutdown;
> +                       default-state = "off";
> +                       gpios = <&fan_ioexp 15 GPIO_ACTIVE_HIGH>;
> +               };
> +               sled0_amber {
> +                       retain-state-shutdown;
> +                       default-state = "off";
> +                       gpios = <&sled0_leds 0 GPIO_ACTIVE_LOW>;
> +               };
> +               sled0_blue {
> +                       retain-state-shutdown;
> +                       default-state = "off";
> +                       gpios = <&sled0_leds 1 GPIO_ACTIVE_LOW>;
> +               };
> +               sled1_amber {
> +                       retain-state-shutdown;
> +                       default-state = "off";
> +                       gpios = <&sled1_leds 0 GPIO_ACTIVE_LOW>;
> +               };
> +               sled1_blue {
> +                       retain-state-shutdown;
> +                       default-state = "off";
> +                       gpios = <&sled1_leds 1 GPIO_ACTIVE_LOW>;
> +               };
> +               sled2_amber {
> +                       retain-state-shutdown;
> +                       default-state = "off";
> +                       gpios = <&sled2_leds 0 GPIO_ACTIVE_LOW>;
> +               };
> +               sled2_blue {
> +                       retain-state-shutdown;
> +                       default-state = "off";
> +                       gpios = <&sled2_leds 1 GPIO_ACTIVE_LOW>;
> +               };
> +               sled3_amber {
> +                       retain-state-shutdown;
> +                       default-state = "off";
> +                       gpios = <&sled3_leds 0 GPIO_ACTIVE_LOW>;
> +               };
> +               sled3_blue {
> +                       retain-state-shutdown;
> +                       default-state = "off";
> +                       gpios = <&sled3_leds 1 GPIO_ACTIVE_LOW>;
> +               };
> +               sled4_amber {
> +                       retain-state-shutdown;
> +                       default-state = "off";
> +                       gpios = <&sled4_leds 0 GPIO_ACTIVE_LOW>;
> +               };
> +               sled4_blue {
> +                       retain-state-shutdown;
> +                       default-state = "off";
> +                       gpios = <&sled4_leds 1 GPIO_ACTIVE_LOW>;
> +               };
> +               sled5_amber {
> +                       retain-state-shutdown;
> +                       default-state = "off";
> +                       gpios = <&sled5_leds 0 GPIO_ACTIVE_LOW>;
> +               };
> +               sled5_blue {
> +                       retain-state-shutdown;
> +                       default-state = "off";
> +                       gpios = <&sled5_leds 1 GPIO_ACTIVE_LOW>;
> +               };
> +       };
> +};
> +
> +&mac2 {
> +       status = "okay";
> +       phy-mode = "rgmii";
> +       phy-handle = <&switchphy>;
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_rgmii3_default>;
> +
> +       fixed-link {
> +               speed = <1000>;
> +               full-duplex;
> +       };
> +};
> +
> +&rtc {
> +       status = "okay";
> +};
> +
> +&fmc {
> +       status = "okay";
> +       flash@0 {
> +               status = "okay";
> +               m25p,fast-read;
> +               label = "bmc";
> +               spi-max-frequency = <50000000>;
> +#include "openbmc-flash-layout-128.dtsi"
> +       };
> +};
> +
> +&spi2 {
> +       status = "okay";
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_spi2_default>;
> +
> +       flash@0 {
> +               status = "okay";
> +               m25p,fast-read;
> +               label = "pnor";
> +               spi-max-frequency = <100000000>;
> +       };
> +};
> +
> +&i2c0 {
> +       status = "okay";
> +       /* TODO: Add ADC INA230 */
> +
> +       mp5023@40 {
> +               compatible = "mps,mp5023";
> +               reg = <0x40>;
> +       };
> +
> +       tmp421@4f {
> +               compatible = "ti,tmp421";
> +               reg = <0x4f>;
> +       };
> +
> +       sled0_ioexp: pca9539@76 {
> +               compatible = "nxp,pca9539";
> +               reg = <0x76>;
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +               gpio-controller;
> +               #gpio-cells = <2>;
> +
> +               gpio-line-names =
> +               "SLED0_MS_DETECT1","SLED0_VBUS_BMC_EN","SLED0_INA230_ALERT","SLED0_P12V_STBY_ALERT",
> +               "SLED0_SSD_ALERT","SLED0_MS_DETECT0","SLED0_RST_CCG5","SLED0_FUSB302_INT",
> +               "SLED0_MD_STBY_RESET","SLED0_MD_IOEXP_EN_FAULT","SLED0_MD_DIR","SLED0_MD_DECAY",
> +               "SLED0_MD_MODE1","SLED0_MD_MODE2","SLED0_MD_MODE3","power-host0";
> +       };
> +
> +       sled0_leds: pca9552@67 {
> +               compatible = "nxp,pca9552";
> +               reg = <0x67>;
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +               gpio-controller;
> +               #gpio-cells = <2>;
> +
> +               gpio-line-names =
> +               "led-sled0-amber","led-sled0-blue","SLED0_RST_IOEXP","",
> +               "","","","",
> +               "","","","",
> +               "","","","";
> +       };
> +
> +       sled0_fusb302: typec-portc@22 {
> +               compatible = "fcs,fusb302";
> +               reg = <0x22>;
> +
> +               connector {
> +                       compatible = "usb-c-connector";
> +                       label = "USB-C";
> +                       power-role = "dual";
> +                       try-power-role = "sink";
> +                       data-role = "dual";
> +                       source-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>;
> +                       sink-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)
> +                                       PDO_VAR(3000, 12000, 3000)
> +                                       PDO_PPS_APDO(3000, 11000, 3000)>;
> +                       op-sink-microwatt = <10000000>;
> +               };
> +       };
> +};
> +
> +&i2c1 {
> +       status = "okay";
> +       /* TODO: Add ADC INA230 */
> +
> +       mp5023@40 {
> +               compatible = "mps,mp5023";
> +               reg = <0x40>;
> +       };
> +
> +       tmp421@4f {
> +               compatible = "ti,tmp421";
> +               reg = <0x4f>;
> +       };
> +
> +       sled1_ioexp: pca9539@76 {
> +               compatible = "nxp,pca9539";
> +               reg = <0x76>;
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +               gpio-controller;
> +               #gpio-cells = <2>;
> +
> +               gpio-line-names =
> +               "SLED1_MS_DETECT1","SLED1_VBUS_BMC_EN","SLED1_INA230_ALERT","SLED1_P12V_STBY_ALERT",
> +               "SLED1_SSD_ALERT","SLED1_MS_DETECT0","SLED1_RST_CCG5","SLED1_FUSB302_INT",
> +               "SLED1_MD_STBY_RESET","SLED1_MD_IOEXP_EN_FAULT","SLED1_MD_DIR","SLED1_MD_DECAY",
> +               "SLED1_MD_MODE1","SLED1_MD_MODE2","SLED1_MD_MODE3","power-host1";
> +       };
> +
> +       sled1_leds: pca9552@67 {
> +               compatible = "nxp,pca9552";
> +               reg = <0x67>;
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +               gpio-controller;
> +               #gpio-cells = <2>;
> +
> +               gpio-line-names =
> +               "led-sled1-amber","led-sled1-blue","SLED1_RST_IOEXP","",
> +               "","","","",
> +               "","","","",
> +               "","","","";
> +       };
> +
> +       sled1_fusb302: typec-portc@22 {
> +               compatible = "fcs,fusb302";
> +               reg = <0x22>;
> +
> +               connector {
> +                       compatible = "usb-c-connector";
> +                       label = "USB-C";
> +                       power-role = "dual";
> +                       try-power-role = "sink";
> +                       data-role = "dual";
> +                       source-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>;
> +                       sink-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)
> +                                       PDO_VAR(3000, 12000, 3000)
> +                                       PDO_PPS_APDO(3000, 11000, 3000)>;
> +                       op-sink-microwatt = <10000000>;
> +               };
> +       };
> +};
> +
> +&i2c1 {
> +       status = "okay";
> +};
> +
> +&i2c2 {
> +       status = "okay";
> +       /* TODO: Add ADC INA230 */
> +
> +       mp5023@40 {
> +               compatible = "mps,mp5023";
> +               reg = <0x40>;
> +       };
> +
> +       tmp421@4f {
> +               compatible = "ti,tmp421";
> +               reg = <0x4f>;
> +       };
> +
> +       sled2_ioexp: pca9539@76 {
> +               compatible = "nxp,pca9539";
> +               reg = <0x76>;
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +               gpio-controller;
> +               #gpio-cells = <2>;
> +
> +               gpio-line-names =
> +               "SLED2_MS_DETECT1","SLED2_VBUS_BMC_EN","SLED2_INA230_ALERT","SLED2_P12V_STBY_ALERT",
> +               "SLED2_SSD_ALERT","SLED2_MS_DETECT0","SLED2_RST_CCG5","SLED2_FUSB302_INT",
> +               "SLED2_MD_STBY_RESET","SLED2_MD_IOEXP_EN_FAULT","SLED2_MD_DIR","SLED2_MD_DECAY",
> +               "SLED2_MD_MODE1","SLED2_MD_MODE2","SLED2_MD_MODE3","power-host2";
> +       };
> +
> +       sled2_leds: pca9552@67 {
> +               compatible = "nxp,pca9552";
> +               reg = <0x67>;
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +               gpio-controller;
> +               #gpio-cells = <2>;
> +
> +               gpio-line-names =
> +               "led-sled2-amber","led-sled2-blue","SLED2_RST_IOEXP","",
> +               "","","","",
> +               "","","","",
> +               "","","","";
> +       };
> +
> +       sled2_fusb302: typec-portc@22 {
> +               compatible = "fcs,fusb302";
> +               reg = <0x22>;
> +
> +               connector {
> +                       compatible = "usb-c-connector";
> +                       label = "USB-C";
> +                       power-role = "dual";
> +                       try-power-role = "sink";
> +                       data-role = "dual";
> +                       source-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>;
> +                       sink-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)
> +                                       PDO_VAR(3000, 12000, 3000)
> +                                       PDO_PPS_APDO(3000, 11000, 3000)>;
> +                       op-sink-microwatt = <10000000>;
> +               };
> +       };
> +};
> +
> +&i2c3 {
> +       status = "okay";
> +       /* TODO: Add ADC INA230 */
> +
> +       mp5023@40 {
> +               compatible = "mps,mp5023";
> +               reg = <0x40>;
> +       };
> +
> +       tmp421@4f {
> +               compatible = "ti,tmp421";
> +               reg = <0x4f>;
> +       };
> +
> +       sled3_ioexp: pca9539@76 {
> +               compatible = "nxp,pca9539";
> +               reg = <0x76>;
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +               gpio-controller;
> +               #gpio-cells = <2>;
> +
> +               gpio-line-names =
> +               "SLED3_MS_DETECT1","SLED3_VBUS_BMC_EN","SLED3_INA230_ALERT","SLED3_P12V_STBY_ALERT",
> +               "SLED3_SSD_ALERT","SLED3_MS_DETECT0","SLED3_RST_CCG5","SLED3_FUSB302_INT",
> +               "SLED3_MD_STBY_RESET","SLED3_MD_IOEXP_EN_FAULT","SLED3_MD_DIR","SLED3_MD_DECAY",
> +               "SLED3_MD_MODE1","SLED3_MD_MODE2","SLED3_MD_MODE3","power-host3";
> +       };
> +
> +       sled3_leds: pca9552@67 {
> +               compatible = "nxp,pca9552";
> +               reg = <0x67>;
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +               gpio-controller;
> +               #gpio-cells = <2>;
> +
> +               gpio-line-names =
> +               "led-sled3-amber","led-sled3-blue","SLED3_RST_IOEXP","",
> +               "","","","",
> +               "","","","",
> +               "","","","";
> +       };
> +
> +       sled3_fusb302: typec-portc@22 {
> +               compatible = "fcs,fusb302";
> +               reg = <0x22>;
> +
> +               connector {
> +                       compatible = "usb-c-connector";
> +                       label = "USB-C";
> +                       power-role = "dual";
> +                       try-power-role = "sink";
> +                       data-role = "dual";
> +                       source-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>;
> +                       sink-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)
> +                                       PDO_VAR(3000, 12000, 3000)
> +                                       PDO_PPS_APDO(3000, 11000, 3000)>;
> +                       op-sink-microwatt = <10000000>;
> +               };
> +       };
> +};
> +
> +&i2c4 {
> +       status = "okay";
> +       /* TODO: Add ADC INA230 */
> +
> +       mp5023@40 {
> +               compatible = "mps,mp5023";
> +               reg = <0x40>;
> +       };
> +
> +       tmp421@4f {
> +               compatible = "ti,tmp421";
> +               reg = <0x4f>;
> +       };
> +
> +       sled4_ioexp: pca9539@76 {
> +               compatible = "nxp,pca9539";
> +               reg = <0x76>;
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +               gpio-controller;
> +               #gpio-cells = <2>;
> +
> +               gpio-line-names =
> +               "SLED4_MS_DETECT1","SLED4_VBUS_BMC_EN","SLED4_INA230_ALERT","SLED4_P12V_STBY_ALERT",
> +               "SLED4_SSD_ALERT","SLED4_MS_DETECT0","SLED4_RST_CCG5","SLED4_FUSB302_INT",
> +               "SLED4_MD_STBY_RESET","SLED4_MD_IOEXP_EN_FAULT","SLED4_MD_DIR","SLED4_MD_DECAY",
> +               "SLED4_MD_MODE1","SLED4_MD_MODE2","SLED4_MD_MODE3","power-host4";
> +       };
> +
> +       sled4_leds: pca9552@67 {
> +               compatible = "nxp,pca9552";
> +               reg = <0x67>;
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +               gpio-controller;
> +               #gpio-cells = <2>;
> +
> +               gpio-line-names =
> +               "led-sled4-amber","led-sled4-blue","SLED4_RST_IOEXP","",
> +               "","","","",
> +               "","","","",
> +               "","","","";
> +       };
> +
> +       sled4_fusb302: typec-portc@22 {
> +               compatible = "fcs,fusb302";
> +               reg = <0x22>;
> +
> +               connector {
> +                       compatible = "usb-c-connector";
> +                       label = "USB-C";
> +                       power-role = "dual";
> +                       try-power-role = "sink";
> +                       data-role = "dual";
> +                       source-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>;
> +                       sink-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)
> +                                       PDO_VAR(3000, 12000, 3000)
> +                                       PDO_PPS_APDO(3000, 11000, 3000)>;
> +                       op-sink-microwatt = <10000000>;
> +               };
> +       };
> +};
> +
> +&i2c5 {
> +       status = "okay";
> +       /* TODO: Add ADC INA230 */
> +
> +       mp5023@40 {
> +               compatible = "mps,mp5023";
> +               reg = <0x40>;
> +       };
> +
> +       tmp421@4f {
> +               compatible = "ti,tmp421";
> +               reg = <0x4f>;
> +       };
> +
> +       sled5_ioexp: pca9539@76 {
> +               compatible = "nxp,pca9539";
> +               reg = <0x76>;
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +               gpio-controller;
> +               #gpio-cells = <2>;
> +
> +               gpio-line-names =
> +               "SLED5_MS_DETECT1","SLED5_VBUS_BMC_EN","SLED5_INA230_ALERT","SLED5_P12V_STBY_ALERT",
> +               "SLED5_SSD_ALERT","SLED5_MS_DETECT0","SLED5_RST_CCG5","SLED5_FUSB302_INT",
> +               "SLED5_MD_STBY_RESET","SLED5_MD_IOEXP_EN_FAULT","SLED5_MD_DIR","SLED5_MD_DECAY",
> +               "SLED5_MD_MODE1","SLED5_MD_MODE2","SLED5_MD_MODE3","power-host5";
> +       };
> +
> +       sled5_leds: pca9552@67 {
> +               compatible = "nxp,pca9552";
> +               reg = <0x67>;
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +               gpio-controller;
> +               #gpio-cells = <2>;
> +
> +               gpio-line-names =
> +               "led-sled5-amber","led-sled5-blue","SLED5_RST_IOEXP","",
> +               "","","","",
> +               "","","","",
> +               "","","","";
> +       };
> +
> +       sled5_fusb302: typec-portc@22 {
> +               compatible = "fcs,fusb302";
> +               reg = <0x22>;
> +
> +               connector {
> +                       compatible = "usb-c-connector";
> +                       label = "USB-C";
> +                       power-role = "dual";
> +                       try-power-role = "sink";
> +                       data-role = "dual";
> +                       source-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>;
> +                       sink-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)
> +                                       PDO_VAR(3000, 12000, 3000)
> +                                       PDO_PPS_APDO(3000, 11000, 3000)>;
> +                       op-sink-microwatt = <10000000>;
> +               };
> +       };
> +};
> +
> +&i2c6 {
> +       status = "okay";
> +
> +       eeprom@56 {
> +               compatible = "atmel,24c64";
> +               reg = <0x56>;
> +       };
> +
> +       rtc@51 {
> +               compatible = "nxp,pcf85263";
> +               reg = <0x51>;
> +       };
> +};
> +
> +&i2c7 {
> +       status = "okay";
> +
> +       eeprom@54 {
> +               compatible = "atmel,24c64";
> +               reg = <0x54>;
> +       };
> +};
> +
> +&i2c9 {
> +       status = "okay";
> +
> +       tmp421@4f {
> +               compatible = "ti,tmp421";
> +               reg = <0x4f>;
> +       };
> +};
> +
> +&i2c10 {
> +       status = "okay";
> +
> +       tmp421@4f {
> +               compatible = "ti,tmp421";
> +               reg = <0x4f>;
> +       };
> +
> +       hdc1080@40 {
> +               compatible = "ti,hdc1080";
> +               reg = <0x40>;
> +       };
> +
> +       front_leds: pca9552@67 {
> +               compatible = "nxp,pca9552";
> +               reg = <0x67>;
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +               gpio-controller;
> +               #gpio-cells = <2>;
> +
> +               gpio-line-names =
> +               "led-fault-identify","power-p5v-stby-good",
> +               "power-p1v0-dvdd-good","power-p1v0-avdd-good",
> +               "","","","",
> +               "","","","",
> +               "","","","";
> +       };
> +};
> +
> +&i2c12 {
> +       status = "okay";
> +
> +       adm1278@11 {
> +               compatible = "adi,adm1278";
> +               reg = <0x11>;
> +       };
> +
> +       tmp421@4c {
> +               compatible = "ti,tmp421";
> +               reg = <0x4c>;
> +       };
> +
> +       tmp421@4d {
> +               compatible = "ti,tmp421";
> +               reg = <0x4d>;
> +       };
> +
> +       fan_ioexp: pca9552@67 {
> +               compatible = "nxp,pca9552";
> +               reg = <0x67>;
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +               gpio-controller;
> +               #gpio-cells = <2>;
> +
> +               gpio-line-names =
> +               "presence-fan0","presence-fan1",
> +               "presence-fan2","presence-fan3",
> +               "power-fan0-good","power-fan1-good",
> +               "power-fan2-good","power-fan3-good",
> +               "","","","",
> +               "","","","";
> +       };
> +};
> +
> +&i2c13 {
> +       multi-master;
> +       aspeed,hw-timeout-ms = <1000>;
> +       status = "okay";
> +};
> +
> +&gpio0 {
> +       gpio-line-names =
> +       /*A0-A7*/       "","","","","","","","",
> +       /*B0-B7*/       "","","SEL_SPI2_MUX","SPI2_MUX1",
> +                       "SPI2_MUX2","SPI2_MUX3","","",
> +       /*C0-C7*/       "","","","","","","","",
> +       /*D0-D7*/       "","","","","","","","",
> +       /*E0-E7*/       "","","","","","","","",
> +       /*F0-F7*/       "","","","","","","","",
> +       /*G0-G7*/       "","SWITCH_FRU_MUX","","","","","","",
> +       /*H0-H7*/       "presence-riser1","presence-riser2",
> +                       "presence-sled0","presence-sled1",
> +                       "presence-sled2","presence-sled3",
> +                       "presence-sled4","presence-sled5",
> +       /*I0-I7*/       "REV_ID0","","REV_ID1","REV_ID2",
> +                       "","","","",
> +       /*J0-J7*/       "","","","","","","","",
> +       /*K0-K7*/       "","","","","","","","",
> +       /*L0-L7*/       "","","","","","","","",
> +       /*M0-M7*/       "ALERT_SLED0","ALERT_SLED1",
> +                       "ALERT_SLED2","ALERT_SLED3",
> +                       "ALERT_SLED4","ALERT_SLED5",
> +                       "P12V_AUX_ALERT1","",
> +       /*N0-N7*/       "","","","","","","","",
> +       /*O0-O7*/       "","","","",
> +                       "","BOARD_ID0","BOARD_ID1","BOARD_ID2",
> +       /*P0-P7*/       "","","","","","","","",
> +       /*Q0-Q7*/       "","","","","","","","",
> +       /*R0-R7*/       "","","","","","","","",
> +       /*S0-S7*/       "","","","BAT_DETECT",
> +                       "BMC_BT_WP0","BMC_BT_WP1","","",
> +       /*T0-T7*/       "","","","","","","","",
> +       /*U0-U7*/       "","","","","","","","",
> +       /*V0-V7*/       "","RST_BMC_MVL","","",
> +                       "USB2_SEL0_A","USB2_SEL1_A",
> +                       "USB2_SEL0_B","USB2_SEL1_B",
> +       /*W0-W7*/       "RST_FRONT_IOEXP","","","","","","","",
> +       /*X0-X7*/       "","","","","","","","",
> +       /*Y0-Y7*/       "","","BSM_FLASH_LATCH","","","","","",
> +       /*Z0-Z7*/       "","","","","","","","";
> +};
> +
> +&adc0 {
> +       vref = <1800>;
> +       status = "okay";
> +
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_adc0_default &pinctrl_adc1_default
> +               &pinctrl_adc2_default &pinctrl_adc3_default
> +               &pinctrl_adc4_default &pinctrl_adc5_default
> +               &pinctrl_adc6_default &pinctrl_adc7_default>;
> +};
> +
> +&adc1 {
> +       vref = <2500>;
> +       status = "okay";
> +
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_adc8_default &pinctrl_adc9_default
> +               &pinctrl_adc10_default &pinctrl_adc11_default
> +               &pinctrl_adc12_default &pinctrl_adc13_default
> +               &pinctrl_adc14_default &pinctrl_adc15_default>;
> +};
> --
> 2.25.1
>
