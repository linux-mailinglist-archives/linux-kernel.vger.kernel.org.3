Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B10164E89A3
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Mar 2022 21:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236492AbiC0TTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 15:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231214AbiC0TS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 15:18:58 -0400
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACF25340E4;
        Sun, 27 Mar 2022 12:17:18 -0700 (PDT)
Received: by mail-wr1-f45.google.com with SMTP id r13so17383435wrr.9;
        Sun, 27 Mar 2022 12:17:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Oaw/8wm+54wqYrt/v04SYHLsgZvftt6K+ADFHlX33Q8=;
        b=UUAWzTXgVU7lBCOY0snhn3uVTN9saZFEwQvE9blZ9wmaIuIcnYyCk/5I3g0PapO9qg
         yMOyI46zRywJiXg1QmFuwWsfPsXvBVWNDox5cOC5+GNvv7xi7GZkg8CAjs1iRArgv/nI
         dh8F4tCeJMD767PwRWkROcybUrAUnMVXBGmzCoS+6AbXtx6t4P+8GnVn3o74EY86kxZ/
         EQew6LNPjXMVuo8DSfVqDExr5wWCqhUq7f9vcAkKAh/+IMCVzEgk7Tp+nWY/ENCRUpDo
         yOtnEmaC0gYJwY2fGol6RRrA1EbgCQH3shl+oVhul3nInyXzIOqr5dxBhx+MjZcxPWp0
         KeuA==
X-Gm-Message-State: AOAM531mcUsMSn6DlZDGFTjwTCM3e4wW1d3AKnI2Hsze2MF6LQonqAa6
        YNkU2u01BTy333QDNWJQ+PY=
X-Google-Smtp-Source: ABdhPJxHLn5KWVZXe9zBPNIcugOLVuNFkZgj2go3V4hV9pWvuxAI5h6C60KSey8gfZmeCTV3XYeVOw==
X-Received: by 2002:adf:eb89:0:b0:1e4:b8f4:da74 with SMTP id t9-20020adfeb89000000b001e4b8f4da74mr19026515wrn.408.1648408637148;
        Sun, 27 Mar 2022 12:17:17 -0700 (PDT)
Received: from [192.168.0.162] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.googlemail.com with ESMTPSA id u11-20020a5d6acb000000b002058148822bsm14678569wrw.63.2022.03.27.12.17.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Mar 2022 12:17:16 -0700 (PDT)
Message-ID: <b464921c-5aec-10ca-fcec-02492ec84e73@kernel.org>
Date:   Sun, 27 Mar 2022 21:17:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v1 11/12] ARM: dts: imx: Add i.MXRT1170-EVK support
Content-Language: en-US
To:     Jesse Taube <mr.bossman075@gmail.com>, linux-imx@nxp.com
Cc:     robh+dt@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, aisheng.dong@nxp.com, stefan@agner.ch,
        linus.walleij@linaro.org, daniel.lezcano@linaro.org,
        tglx@linutronix.de, arnd@arndb.de, olof@lixom.net, soc@kernel.org,
        linux@armlinux.org.uk, abel.vesa@nxp.com, dev@lynxeye.de,
        marcel.ziswiler@toradex.com, tharvey@gateworks.com,
        leoyang.li@nxp.com, sebastian.reichel@collabora.com,
        cniedermaier@dh-electronics.com, clin@suse.com,
        giulio.benetti@benettiengineering.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org
References: <20220326144313.673549-1-Mr.Bossman075@gmail.com>
 <20220326144313.673549-12-Mr.Bossman075@gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20220326144313.673549-12-Mr.Bossman075@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/03/2022 15:43, Jesse Taube wrote:
> The NXP i.MXRT1170 Evaluation Kit (EVK) provides a platform for rapid
> evaluation of the i.MXRT, which features NXP's implementation of the Arm
> Cortex-M7 and M4 core.
> 
> The EVK provides 64 MB SDRAM, 128 MB Quad SPI flash, Micro SD card socket,
> two USB 2.0 OTG, and two Ethernet ports.
> 
> This patch aims to support the preliminary booting up features
> as follows:
> GPIO
> LPUART
> SD/MMC
> 
> Cc: Giulio Benetti <giulio.benetti@benettiengineering.com>
> Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>
> ---
>  arch/arm/boot/dts/Makefile          |   3 +-
>  arch/arm/boot/dts/imxrt1170-evk.dts | 126 +++++++++++++
>  arch/arm/boot/dts/imxrt1170.dtsi    | 278 ++++++++++++++++++++++++++++
>  3 files changed, 406 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm/boot/dts/imxrt1170-evk.dts
>  create mode 100644 arch/arm/boot/dts/imxrt1170.dtsi
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 07acd6189cae..87ae30818f39 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -724,7 +724,8 @@ dtb-$(CONFIG_SOC_IMX7ULP) += \
>  	imx7ulp-com.dtb \
>  	imx7ulp-evk.dtb
>  dtb-$(CONFIG_SOC_IMXRT) += \
> -	imxrt1050-evk.dtb
> +	imxrt1050-evk.dtb \
> +	imxrt1170-evk.dtb
>  dtb-$(CONFIG_SOC_LS1021A) += \
>  	ls1021a-moxa-uc-8410a.dtb \
>  	ls1021a-qds.dtb \
> diff --git a/arch/arm/boot/dts/imxrt1170-evk.dts b/arch/arm/boot/dts/imxrt1170-evk.dts
> new file mode 100644
> index 000000000000..fc3b41de8215
> --- /dev/null
> +++ b/arch/arm/boot/dts/imxrt1170-evk.dts
> @@ -0,0 +1,126 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
> +/*
> + * Copyright (C) 2022
> + * Author(s):  Jesse Taube <Mr.Bossman075@gmail.com>
> + */
> +
> +/dts-v1/;
> +#include "imxrt1170.dtsi"
> +#include "imxrt1170-pinfunc.h"
> +
> +/ {
> +	model = "NXP imxrt1170-evk board";
> +	compatible = "fsl,imxrt1170-evk", "fsl,imxrt1170";
> +
> +	chosen {
> +		stdout-path = &lpuart1;
> +	};
> +
> +	aliases {
> +		gpio0 = &gpio1;
> +		gpio1 = &gpio2;
> +		gpio2 = &gpio3;
> +		gpio3 = &gpio4;
> +		gpio4 = &gpio5;
> +		gpio5 = &gpio6;
> +		gpio6 = &gpio7;
> +		gpio7 = &gpio8;
> +		gpio8 = &gpio9;
> +		gpio9 = &gpio10;
> +		gpio10 = &gpio11;
> +		gpio11 = &gpio12;
> +		gpio12 = &gpio13;
> +		mmc0 = &usdhc1;
> +		serial0 = &lpuart1;
> +		usbphy0 = &usbphy1;
> +	};
> +
> +	memory@20240000 {
> +		device_type = "memory";
> +		reg = <0x20240000 0xf0000>;
> +	};
> +
> +	memory@80000000 {
> +		device_type = "memory";
> +		reg = <0x80000000 0x4000000>;
> +	};
> +
> +	reg_usb_otg1_vbus: regulator-usb-otg1-vbus {
> +		compatible = "regulator-fixed";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_pwm0>;
> +		regulator-name = "usb_otg1_vbus";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		gpio = <&gpio9 9 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +	};
> +};
> +
> +&lpuart1 { /* console */
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_lpuart1>;
> +	status = "okay";
> +};
> +
> +
> +&usbotg1 {
> +	vbus-supply = <&reg_usb_otg1_vbus>;
> +	dr_mode = "host";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_usbotg1_id>;
> +	disable-over-current;
> +	status = "okay";
> +};
> +
> +&iomuxc {
> +	pinctrl_lpuart1: lpuart1grp {
> +		fsl,pins = <
> +			IOMUXC_GPIO_AD_24_LPUART1_TXD 0xf1
> +			IOMUXC_GPIO_AD_25_LPUART1_RXD 0xf1
> +		>;
> +	};
> +
> +	pinctrl_pwm0: pwm0grp {
> +		fsl,pins = <
> +			IOMUXC_GPIO_AD_11_USB_OTG1_OC 0xf1
> +		>;
> +	};
> +
> +	pinctrl_usbotg1_id: pinctrl_usbotg1_id {

No underscores in node names. Does not match the DT schema, please test
your DTS (make dtbs_check).

> +		fsl,pins = <
> +			IOMUXC_GPIO_AD_09_USBPHY1_OTG_ID 0xf1
> +		>;
> +	};
> +
> +	pinctrl_usdhc0: usdhc0grp {
> +		fsl,pins = <
> +			IOMUXC_GPIO_AD_32_USDHC1_CD_B
> +				0x1B000
> +			IOMUXC_GPIO_AD_34_USDHC1_VSELECT
> +				0xB069
> +			IOMUXC_GPIO_SD_B1_00_USDHC1_CMD
> +				0x17061
> +			IOMUXC_GPIO_SD_B1_01_USDHC1_CLK
> +				0x17061
> +			IOMUXC_GPIO_SD_B1_05_USDHC1_DATA3
> +				0x17061
> +			IOMUXC_GPIO_SD_B1_04_USDHC1_DATA2
> +				0x17061
> +			IOMUXC_GPIO_SD_B1_03_USDHC1_DATA1
> +				0x17061
> +			IOMUXC_GPIO_SD_B1_02_USDHC1_DATA0
> +				0x17061
> +		>;
> +	};
> +};
> +
> +&usdhc1 {
> +	pinctrl-names = "default", "state_100mhz", "state_200mhz", "sleep";
> +	pinctrl-0 = <&pinctrl_usdhc0>;
> +	pinctrl-1 = <&pinctrl_usdhc0>;
> +	pinctrl-2 = <&pinctrl_usdhc0>;
> +	pinctrl-3 = <&pinctrl_usdhc0>;
> +	status = "okay";
> +	broken-cd;
> +};
> diff --git a/arch/arm/boot/dts/imxrt1170.dtsi b/arch/arm/boot/dts/imxrt1170.dtsi
> new file mode 100644
> index 000000000000..fb53347571a9
> --- /dev/null
> +++ b/arch/arm/boot/dts/imxrt1170.dtsi
> @@ -0,0 +1,278 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
> +/*
> + * Copyright (C) 2022
> + * Author(s):  Jesse Taube <Mr.Bossman075@gmail.com>
> + */
> +
> +#include "armv7-m.dtsi"
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/clock/imxrt1170-clock.h>
> +#include <dt-bindings/gpio/gpio.h>
> +
> +/ {
> +	#address-cells = <1>;
> +	#size-cells = <1>;
> +
> +	reserved-memory {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges;
> +
> +		linux,cma {
> +			compatible = "shared-dma-pool";
> +			size = <0x40000>;
> +			no-map;
> +			linux,dma-default;
> +		};
> +	};
> +
> +	clocks {
> +		osc: osc {
> +			compatible = "fixed-clock";
> +			#clock-cells = <0>;
> +			clock-frequency = <24000000>;
> +		};
> +
> +		rcosc16M: rcosc16M {
> +			compatible = "fixed-clock";
> +			#clock-cells = <0>;
> +			clock-frequency = <16000000>;
> +		};
> +
> +		osc32k: osc32k {
> +			compatible = "fixed-clock";
> +			#clock-cells = <0>;
> +			clock-frequency = <32768>;
> +		};
> +
> +		osc3M: osc3M {
> +			compatible = "fixed-clock";
> +			#clock-cells = <0>;
> +			clock-frequency = <3000000>;
> +		};
> +	};
> +
> +	soc {
> +		anatop: anatop@40c84000 {
> +			compatible = "fsl,imxrt-anatop";
> +			reg = <0x40c84000 0x4000>;
> +		};
> +
> +		clks: ccm@40cc0000 {

Generic node names. Isn't it clock-controller?

> +			compatible = "fsl,imxrt1170-ccm";
> +			reg = <0x40cc0000 0x4000>;
> +			clocks = <&osc>, <&rcosc16M>, <&osc32k>;
> +			clock-names = "osc", "rcosc16M", "osc32k";
> +			#clock-cells = <1>;
> +		};
> +
> +		edma1: dma-controller@40070000 {
> +			#dma-cells = <2>;
> +			compatible = "fsl,imx7ulp-edma";
> +			reg = <0x40070000 0x4000>,
> +				<0x40074000 0x4000>;
> +			dma-channels = <32>;
> +			interrupts = <0>, <1>, <2>, <3>, <4>, <5>, <6>, <7>, <8>,
> +				<9>, <10>, <11>, <12>, <13>, <14>, <15>, <16>;
> +			clock-names = "dma", "dmamux0";
> +			clocks = <&clks IMXRT1170_CLK_BUS>,
> +				 <&clks IMXRT1170_CLK_M4>;
> +		};
> +
> +		gpio1: gpio@4012c000 {
> +			compatible = "fsl,imxrt1170-gpio", "fsl,imx35-gpio";
> +			reg = <0x4012c000 0x4000>;
> +			interrupts = <100>, <101>;
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +			interrupt-controller;
> +			#interrupt-cells = <2>;
> +		};
> +
> +		gpio2: gpio@40130000 {
> +			compatible = "fsl,imxrt1170-gpio", "fsl,imx35-gpio";
> +			reg = <0x40130000 0x4000>;
> +			interrupts = <102>, <103>;
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +			interrupt-controller;
> +			#interrupt-cells = <2>;
> +		};
> +
> +		gpio3: gpio@40134000 {
> +			compatible = "fsl,imxrt1170-gpio", "fsl,imx35-gpio";
> +			reg = <0x40134000 0x4000>;
> +			interrupts = <104>, <105>;
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +			interrupt-controller;
> +			#interrupt-cells = <2>;
> +		};
> +
> +		gpio4: gpio@40138000 {
> +			compatible = "fsl,imxrt1170-gpio", "fsl,imx35-gpio";
> +			reg = <0x40138000 0x4000>;
> +			interrupts = <106>, <107>;
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +			interrupt-controller;
> +			#interrupt-cells = <2>;
> +		};
> +
> +		gpio5: gpio@4013c000 {
> +			compatible = "fsl,imxrt1170-gpio", "fsl,imx35-gpio";
> +			reg = <0x4013c000 0x4000>;
> +			interrupts = <108>, <109>;
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +			interrupt-controller;
> +			#interrupt-cells = <2>;
> +		};
> +
> +		gpio6: gpio@40140000 {
> +			compatible = "fsl,imxrt1170-gpio", "fsl,imx35-gpio";
> +			reg = <0x40140000 0x4000>;
> +			interrupts = <61>, <62>;
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +			interrupt-controller;
> +			#interrupt-cells = <2>;
> +		};
> +
> +		gpio7: gpio@40c5c000 {
> +			compatible = "fsl,imxrt1170-gpio", "fsl,imx35-gpio";
> +			reg = <0x40c5c000 0x4000>;
> +			interrupts = <99>, <99>;
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +			interrupt-controller;
> +			#interrupt-cells = <2>;
> +		};
> +
> +		gpio8: gpio@40c60000 {
> +			compatible = "fsl,imxrt1170-gpio", "fsl,imx35-gpio";
> +			reg = <0x40c60000 0x4000>;
> +			interrupts = <99>, <99>;
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +			interrupt-controller;
> +			#interrupt-cells = <2>;
> +		};
> +
> +		gpio9: gpio@40c64000 {
> +			compatible = "fsl,imxrt1170-gpio", "fsl,imx35-gpio";
> +			reg = <0x40c64000 0x4000>;
> +			interrupts = <99>, <99>;
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +			interrupt-controller;
> +			#interrupt-cells = <2>;
> +		};
> +
> +		gpio10: gpio@40c68000 {
> +			compatible = "fsl,imxrt1170-gpio", "fsl,imx35-gpio";

Undocumented compatible.

> +			reg = <0x40c68000 0x4000>;
> +			interrupts = <99>, <99>;
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +			interrupt-controller;
> +			#interrupt-cells = <2>;
> +		};
> +
> +		gpio11: gpio@40c6c000 {
> +			compatible = "fsl,imxrt1170-gpio", "fsl,imx35-gpio";
> +			reg = <0x40c6c000 0x4000>;
> +			interrupts = <99>, <99>;
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +			interrupt-controller;
> +			#interrupt-cells = <2>;
> +		};
> +
> +		gpio12: gpio@40c70000 {
> +			compatible = "fsl,imxrt1170-gpio", "fsl,imx35-gpio";
> +			reg = <0x40c70000 0x4000>;
> +			interrupts = <61>, <62>;
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +			interrupt-controller;
> +			#interrupt-cells = <2>;
> +		};
> +
> +		gpio13: gpio@40ca0000 {
> +			compatible = "fsl,imxrt1170-gpio", "fsl,imx35-gpio";
> +			reg = <0x40ca0000 0x4000>;
> +			interrupts = <93>, <93>;
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +			interrupt-controller;
> +			#interrupt-cells = <2>;
> +		};
> +
> +		gpt: timer@400ec000 {
> +			compatible = "fsl,imxrt1170-gpt", "fsl,imx6dl-gpt", "fsl,imx6sl-gpt";

Wrong compatibles.

> +			reg = <0x400ec000 0x4000>;
> +			interrupts = <119>;
> +			clocks = <&osc3M>;
> +			clock-names = "per";
> +		};
> +
> +		iomuxc: iomuxc@400e8000 {
> +			compatible = "fsl,imxrt1170-iomuxc";
> +			reg = <0x400e8000 0x4000>;
> +			fsl,mux_mask = <0x7>;
> +		};
> +
> +		lpuart1: serial@4007c000 {
> +			compatible = "fsl,imxrt1170-lpuart", "fsl,imxrt1050-lpuart", "fsl,imx7ulp-lpuart";

Undocumented compatible.

> +			reg = <0x4007c000 0x4000>;
> +			interrupts = <20>;
> +			clocks = <&clks IMXRT1170_CLK_LPUART1>;
> +			clock-names = "ipg";
> +			status = "disabled";
> +		};
> +
> +		usdhc1: mmc@40418000 {
> +			compatible ="fsl,imxrt1050-usdhc", "fsl,imx6sl-usdhc";

Wrong compatibles.

> +			reg = <0x40418000 0x10000>;
> +			interrupts = <133>;
> +			clocks = <&clks IMXRT1170_CLK_BUS>,
> +				<&clks IMXRT1170_CLK_BUS>,
> +				<&clks IMXRT1170_CLK_USDHC1>;
> +			clock-names = "ipg", "ahb", "per";
> +			bus-width = <4>;
> +			fsl,wp-controller;
> +			no-1-8-v;
> +			max-frequency = <4000000>;
> +			fsl,tuning-start-tap = <20>;
> +			fsl,tuning-step= <2>;
> +			status = "disabled";
> +		};
> +> +

One line break.

> +		usbmisc1: usbmisc@40430200 {
> +			compatible = "fsl,imx7ulp-usbmisc";
> +			#index-cells = <1>;
> +			reg = <0x40430200 0x200>;
> +		};
> +



Best regards,
Krzysztof
