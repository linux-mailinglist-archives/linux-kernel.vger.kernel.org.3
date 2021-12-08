Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F8C646D246
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 12:35:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232521AbhLHLiz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 06:38:55 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:12196 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbhLHLiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 06:38:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1638963322; x=1670499322;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=Fo6li3vY+nsV2bqhkvrKHv9g4VJrnvCTr5NIpNiCFHM=;
  b=cpedOLFvXVvOkqBpBFB0CQNbUi6UFjV5/CJXHf/cASdXTZNbf70YCDR7
   7dh8saYwkixumhHYK8i6tvvE7RPsRVZoL0fyhPPPtx3WMBNjqnnikh14X
   yLpdltNqn8qiqAcGu2Hr6bv2/Y54XS9L1JXlmCpNtR7nEkiClIAaaPPKD
   3u7XyVyUjraj9HWj3+HpPG7iO+4VM24Pl2OlmNgBo4ss9dcxRxH9g7vna
   1bJwiRRdbe++E29qELVMN8pRczBoyXc9I/VfgprNCrxcO59MvGM4L60ZF
   d/WCxHweCmqwX5NpOB1J8dubIH3W7ZvxQJrIibGPTrCyBSmNnBHyZ1piu
   Q==;
IronPort-SDR: Ka2nNFQuUNkr8+sUQhZvddTUfm/+twoK68eZcTivUo/fdG3pJNs9WlrniEjj4679giKQV3EbVC
 hYmkxlmk33MnSzI4wtagu2yzz5IJGqSZlGKrE2zdOTb3HK3Yg70+TBrdIwYv1SNEf7qMqj37fV
 BBHFZEGE56iGG2HpncnmqacTIGY+vpZ5udw2qULp4aNQ/JO8dnckcjwEqxINXmjb5cstcSdtCu
 i0AsGTr26BjoztzrzcLojn4ba+KRESq2r0L3omCHtqDV+K3o1fnScrkkee6XpPBoU3/JAwmjop
 HgqkHeFMI+4UZgQPVHKyte26
X-IronPort-AV: E=Sophos;i="5.87,297,1631602800"; 
   d="scan'208";a="139096924"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 Dec 2021 04:35:21 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Wed, 8 Dec 2021 04:35:21 -0700
Received: from [10.12.73.2] (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2176.14 via Frontend
 Transport; Wed, 8 Dec 2021 04:35:19 -0700
Subject: Re: [PATCH v1] ARM: at91: add Microchip EVB-KSZ9477 board
To:     Oleksij Rempel <o.rempel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
References: <20211111081045.711323-1-o.rempel@pengutronix.de>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
Message-ID: <51b1a195-0902-8826-6544-d58a22c188ea@microchip.com>
Date:   Wed, 8 Dec 2021 12:35:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20211111081045.711323-1-o.rempel@pengutronix.de>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/11/2021 at 09:10, Oleksij Rempel wrote:
> Add KSZ9477 managed switch evaluation kit with SAMA5D36 MPU:
> https://www.microchip.com/en-us/development-tool/evb-ksz9477
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

Patch looks good to me:
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

Thanks Oleksij, best regards,
   Nicolas

> ---
>   arch/arm/boot/dts/Makefile                    |   1 +
>   .../arm/boot/dts/at91-sama5d3_ksz9477_evb.dts | 209 ++++++++++++++++++
>   2 files changed, 210 insertions(+)
>   create mode 100644 arch/arm/boot/dts/at91-sama5d3_ksz9477_evb.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 7e0934180724..ff0557b9dfc7 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -59,6 +59,7 @@ dtb-$(CONFIG_SOC_SAM_V7) += \
>          at91-sama5d2_icp.dtb \
>          at91-sama5d2_ptc_ek.dtb \
>          at91-sama5d2_xplained.dtb \
> +       at91-sama5d3_ksz9477_evb.dtb \
>          at91-sama5d3_xplained.dtb \
>          at91-dvk_som60.dtb \
>          at91-gatwick.dtb \
> diff --git a/arch/arm/boot/dts/at91-sama5d3_ksz9477_evb.dts b/arch/arm/boot/dts/at91-sama5d3_ksz9477_evb.dts
> new file mode 100644
> index 000000000000..443e8b022897
> --- /dev/null
> +++ b/arch/arm/boot/dts/at91-sama5d3_ksz9477_evb.dts
> @@ -0,0 +1,209 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
> +/*
> + * Copyright (c) 2021 Oleksij Rempel <kernel@pengutronix.de>, Pengutronix
> + */
> +/dts-v1/;
> +#include "sama5d36.dtsi"
> +
> +/ {
> +       model = "EVB-KSZ9477";
> +       compatible = "microchip,sama5d3-ksz9477-evb", "atmel,sama5d36",
> +                    "atmel,sama5d3", "atmel,sama5";
> +
> +       chosen {
> +               stdout-path = &dbgu;
> +       };
> +
> +       reg_3v3: regulator-3v3 {
> +               compatible = "regulator-fixed";
> +               regulator-name = "3v3";
> +               regulator-min-microvolt = <3300000>;
> +               regulator-max-microvolt = <3300000>;
> +       };
> +
> +       reg_vcc_mmc0: regulator-mmc0 {
> +               compatible = "regulator-fixed";
> +               pinctrl-names = "default";
> +               pinctrl-0 = <&pinctrl_mcc0_vcc>;
> +               regulator-name = "mmc0-vcc";
> +               regulator-max-microvolt = <3300000>;
> +               regulator-min-microvolt = <3300000>;
> +               gpio = <&pioE 2 GPIO_ACTIVE_LOW>;
> +       };
> +};
> +
> +&dbgu {
> +       status = "okay";
> +};
> +
> +&ebi {
> +       pinctrl-0 = <&pinctrl_ebi_nand_addr>;
> +       pinctrl-names = "default";
> +       status = "okay";
> +};
> +
> +&i2c0 {
> +       pinctrl-0 = <&pinctrl_i2c0_pu>;
> +       status = "okay";
> +};
> +
> +&macb0 {
> +       phy-mode = "rgmii";
> +       status = "okay";
> +
> +       fixed-link {
> +               speed = <1000>;
> +               full-duplex;
> +       };
> +};
> +
> +&main_xtal {
> +       clock-frequency = <12000000>;
> +};
> +
> +&mmc0 {
> +       pinctrl-0 = <&pinctrl_mmc0_clk_cmd_dat0 &pinctrl_mmc0_dat1_3
> +                    &pinctrl_mmc0_dat4_7 &pinctrl_mmc0_cd>;
> +       status = "okay";
> +
> +       slot@0 {
> +               reg = <0>;
> +               bus-width = <8>;
> +               cd-gpios = <&pioE 0 GPIO_ACTIVE_LOW>;
> +               disable-wp;
> +               vmmc-supply = <&reg_vcc_mmc0>;
> +               vqmmc-supply = <&reg_3v3>;
> +       };
> +};
> +
> +&nand_controller {
> +       status = "okay";
> +
> +       nand@3 {
> +               reg = <0x3 0x0 0x2>;
> +               atmel,rb = <0>;
> +               nand-bus-width = <8>;
> +               nand-ecc-mode = "hw";
> +               nand-ecc-strength = <4>;
> +               nand-ecc-step-size = <512>;
> +               nand-on-flash-bbt;
> +               label = "atmel_nand";
> +       };
> +};
> +
> +&slow_xtal {
> +       clock-frequency = <32768>;
> +};
> +
> +&spi0 {
> +       cs-gpios = <&pioD 13 GPIO_ACTIVE_LOW>, <0>, <0>,
> +                  <&pioD 16 GPIO_ACTIVE_LOW>;
> +       status = "okay";
> +};
> +
> +&spi1 {
> +       pinctrl-0 = <&pinctrl_spi_ksz>;
> +       cs-gpios = <&pioC 25 GPIO_ACTIVE_LOW>;
> +       status = "okay";
> +
> +       switch@0 {
> +               compatible = "microchip,ksz9477";
> +               reg = <0>;
> +               spi-max-frequency = <1000000>;
> +               spi-cpha;
> +               spi-cpol;
> +
> +               ports {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +
> +                       port@0 {
> +                               reg = <0>;
> +                               label = "lan1";
> +                       };
> +
> +                       port@1 {
> +                               reg = <1>;
> +                               label = "lan2";
> +                       };
> +
> +                       port@2 {
> +                               reg = <2>;
> +                               label = "lan3";
> +                       };
> +
> +                       port@3 {
> +                               reg = <3>;
> +                               label = "lan4";
> +                       };
> +
> +                       port@4 {
> +                               reg = <4>;
> +                               label = "lan5";
> +                       };
> +
> +                       port@5 {
> +                               reg = <5>;
> +                               label = "cpu";
> +                               ethernet = <&macb0>;
> +                               phy-mode = "rgmii-txid";
> +
> +                               fixed-link {
> +                                       speed = <1000>;
> +                                       full-duplex;
> +                               };
> +                       };
> +               };
> +       };
> +};
> +
> +&usb0 {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_usba_vbus>;
> +       atmel,vbus-gpio = <&pioE 9 GPIO_ACTIVE_HIGH>;
> +       status = "okay";
> +};
> +
> +&pinctrl {
> +       board {
> +               pinctrl_i2c0_pu: i2c0-pu {
> +                       atmel,pins =
> +                               <AT91_PIOA 30 AT91_PERIPH_A AT91_PINCTRL_PULL_UP>,
> +                               <AT91_PIOA 31 AT91_PERIPH_A AT91_PINCTRL_PULL_UP>;
> +               };
> +
> +               pinctrl_mmc0_cd: mmc0-cd {
> +                       atmel,pins = <AT91_PIOE 0 AT91_PERIPH_GPIO AT91_PINCTRL_NONE>;
> +               };
> +
> +               pinctrl_mcc0_vcc: mmc0-vcc {
> +                       atmel,pins = <AT91_PIOE 2 AT91_PERIPH_GPIO AT91_PINCTRL_NONE>;
> +               };
> +
> +               pinctrl_spi_ksz: spi-ksz {
> +                       atmel,pins =
> +                               <
> +                               /* SPI1_MISO */
> +                               AT91_PIOC 22 AT91_PERIPH_A AT91_PINCTRL_PULL_UP
> +                               /* SPI1_MOSI */
> +                               AT91_PIOC 23 AT91_PERIPH_A AT91_PINCTRL_NONE
> +                               /* SPI1_SPCK */
> +                               AT91_PIOC 24 AT91_PERIPH_A AT91_PINCTRL_NONE
> +
> +                               /* SPI CS */
> +                               AT91_PIOC 25 AT91_PERIPH_GPIO AT91_PINCTRL_NONE
> +                               /* switch IRQ */
> +                               AT91_PIOB 28 AT91_PERIPH_GPIO AT91_PINCTRL_DEGLITCH
> +                               /* switch PME_N, SoC IN */
> +                               AT91_PIOC 30 AT91_PERIPH_GPIO AT91_PINCTRL_PULL_UP
> +                               /* switch RST */
> +                               AT91_PIOC 31 AT91_PERIPH_GPIO AT91_PINCTRL_PULL_UP_DEGLITCH
> +                               >;
> +               };
> +
> +               pinctrl_usba_vbus: usba-vbus {
> +                       atmel,pins =
> +                               <AT91_PIOE 9 AT91_PERIPH_GPIO AT91_PINCTRL_DEGLITCH>;
> +               };
> +       };
> +};
> --
> 2.30.2
> 


-- 
Nicolas Ferre
