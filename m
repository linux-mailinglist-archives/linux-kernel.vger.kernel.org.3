Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03B6A4ED37F
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 07:52:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbiCaFyK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 01:54:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbiCaFyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 01:54:03 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E15A27169
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 22:52:16 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id lr4so37346932ejb.11
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 22:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=xlhIIFxZ+7UCj46G+xfnDqiggYeBVl5XpTI1WKJzMqk=;
        b=aasxhEE9zsyo/dZFz41QBRxyXmresPX6Xj5M5n/pJ0P6xmbR2xH5zmtRmkcM/0uNpQ
         10XIQHeT9WbCxhpP5OLVH6V/515QeCR9z9CAKyY7JaoSmkKV50yv8y13eMw4fVMcGlKe
         6XJgXdetUSnDwgvNJNM5gK2qdolTcmtKDYraFwpVaIhUeujVZrJHx2Z8farDT7gEKW5U
         SkzuOi8ADZt1jGacbjaiJh2LqSBPoUlTXsqQJLJChSRfamPeTPDjkBKOn4DUrYjByv6e
         +/QvoK+iN63tHySuDqAODIEAPXr49CfSiVP5CkPNpYE1dNS4NmJhOFcjtkgln3AzZ6r+
         7SYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=xlhIIFxZ+7UCj46G+xfnDqiggYeBVl5XpTI1WKJzMqk=;
        b=CH/9xyH17rsGVwN7uZDpCof4YLblnz/8BgdfU9ouO3fddy9lI/lph+7xlBSEaxWYbt
         R3mzJOHbthDgURJ1buN3wGu0Ujc81u8kWKj/jMeE1Yi4bRjLlPXIO9yRNjDmef1kkV6U
         4GYSwhhl7INRARqNfYt2lgjk+qogMF3NBIOEDrrCO+egGlFlAOBYSIw2vIj7OxwCUdtm
         VmO3NOvIcqZCrwrtON5aBcBZBh4p2eETrxperY2+BeVDDN+Y/NKsiWUzbduAuQM9SAv3
         XccTJc/tLtDIJpeykPIOu5l6bbSLoSdWlvTeTeD6tIzWkyK4MijiFfwGhdl1OWLxDitR
         5VMA==
X-Gm-Message-State: AOAM531LeYvtj4hNr/RyXEQUaFl2OgWe+J7LK9mm/Mhzb16Y0nsqGrej
        tAhU+H3BtYNkRPInWlCkWzAOPA==
X-Google-Smtp-Source: ABdhPJyP0AKbF9jQz91Jvnmb6y8jcXLJ8hppZwaB8p4gcPOuoem710fyit26eptFKQnaEsl65S8kNA==
X-Received: by 2002:a17:907:a0c8:b0:6e0:b36f:d511 with SMTP id hw8-20020a170907a0c800b006e0b36fd511mr3462133ejc.313.1648705934823;
        Wed, 30 Mar 2022 22:52:14 -0700 (PDT)
Received: from [192.168.0.164] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id h7-20020a50cf87000000b0041b7bd52e1fsm290287edk.78.2022.03.30.22.52.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Mar 2022 22:52:14 -0700 (PDT)
Message-ID: <514ff13e-9e83-6641-8c24-2b51ff1cdcf1@linaro.org>
Date:   Thu, 31 Mar 2022 07:52:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 3/3] arm64: dts: imx8mp: Add Engicam i.Core MX8M Plus
 EDIMM2.2 Starter Kit
Content-Language: en-US
To:     Manoj Sai <abbaraju.manojsai@amarulasolutions.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Matteo Lisi <matteo.lisi@engicam.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Rob Herring <robh@kernel.org>,
        Suniel Mahesh <sunil@amarulasolutions.com>,
        Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
References: <20220330191437.614065-1-abbaraju.manojsai@amarulasolutions.com>
 <20220330191437.614065-4-abbaraju.manojsai@amarulasolutions.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220330191437.614065-4-abbaraju.manojsai@amarulasolutions.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/03/2022 21:14, Manoj Sai wrote:
> Engicam EDIMM2.2 Starter Kit is an EDIMM 2.2 Form Factor Capacitive
> Evaluation Board.
> 
> Genaral features:
> - LCD 7" C.Touch
> - microSD slot
> - Ethernet 1Gb
> - Wifi/BT
> - 2x LVDS Full HD interfaces
> - 3x USB 2.0
> - 1x USB 3.0
> - HDMI Out
> - Plus PCIe
> - MIPI CSI
> - 2x CAN
> - Audio Out
> 
> i.Core MX8M Plus is an EDIMM SoM based on NXP i.MX8M Plus from Engicam.
> 
> i.Core MX8M Plus needs to mount on top of this Evaluation board for
> creating complete i.Core MX8M Plus EDIMM2.2 Starter Kit.
> 
> Add support for it.
> 
> Signed-off-by: Manoj Sai <abbaraju.manojsai@amarulasolutions.com>
> Signed-off-by: Matteo Lisi <matteo.lisi@engicam.com>
> Reviewed-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
>  arch/arm64/boot/dts/freescale/Makefile        |   1 +
>  .../freescale/imx8mp-icore-mx8mp-edimm2.2.dts | 176 ++++++++++++++++++
>  2 files changed, 177 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-icore-mx8mp-edimm2.2.dts
> 
> diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
> index 7f51b537df40..66985eae4942 100644
> --- a/arch/arm64/boot/dts/freescale/Makefile
> +++ b/arch/arm64/boot/dts/freescale/Makefile
> @@ -77,6 +77,7 @@ dtb-$(CONFIG_ARCH_MXC) += imx8mn-tqma8mqnl-mba8mx.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mn-var-som-symphony.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mn-venice-gw7902.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mp-evk.dtb
> +dtb-$(CONFIG_ARCH_MXC) += imx8mp-icore-mx8mp-edimm2.2.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mp-phyboard-pollux-rdk.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mq-evk.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mq-hummingboard-pulse.dtb
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp-icore-mx8mp-edimm2.2.dts b/arch/arm64/boot/dts/freescale/imx8mp-icore-mx8mp-edimm2.2.dts
> new file mode 100644
> index 000000000000..e0667299388a
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx8mp-icore-mx8mp-edimm2.2.dts
> @@ -0,0 +1,176 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (c) 2018 NXP
> + * Copyright (c) 2019 Engicam srl
> + * Copyright (c) 2020 Amarula Solutons(India)
> + */
> +
> +/dts-v1/;
> +
> +#include "imx8mp.dtsi"
> +#include "imx8mp-icore-mx8mp.dtsi"
> +#include <dt-bindings/usb/pd.h>
> +
> +/ {
> +	model = "Engicam i.Core MX8M Plus EDIMM2.2 Starter Kit";
> +	compatible = "engicam,icore-mx8mp-edimm2.2", "engicam,icore-mx8mp",
> +		     "fsl,imx8mp";
> +
> +	chosen {
> +		stdout-path = &uart2;
> +	};
> +
> +	reg_usb1_host_vbus: regulator-usb1-vbus {
> +		compatible = "regulator-fixed";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_reg_usb1_vbus>;
> +		regulator-name = "usb1_host_vbus";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		regulator-always-on;
> +		gpio = <&gpio1 14 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +	};
> +
> +	usdhc2_vmmc: regulator-usdhc2 {
> +		compatible = "regulator-fixed";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_reg_usdhc2_vmmc>;
> +		regulator-name = "VSD_3V3";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		gpio = <&gpio2 19 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +	};
> +};
> +
> +/* Ethernet */
> +&eqos {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_eqos>;
> +	phy-mode = "rgmii-id";
> +	phy-handle = <&ethphy0>;
> +	status = "okay";
> +
> +	mdio {
> +		compatible = "snps,dwmac-mdio";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		ethphy0: ethernet-phy@7 {
> +			compatible = "ethernet-phy-ieee802.3-c22";
> +			micrel,led-mode = <0>;
> +			reg = <7>;
> +		};
> +	};
> +};
> +
> +&iomuxc {
> +	pinctrl_eqos: eqosgrp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_ENET_MDC__ENET_QOS_MDC				0x3
> +			MX8MP_IOMUXC_ENET_MDIO__ENET_QOS_MDIO				0x3
> +			MX8MP_IOMUXC_ENET_RD0__ENET_QOS_RGMII_RD0			0x91
> +			MX8MP_IOMUXC_ENET_RD1__ENET_QOS_RGMII_RD1			0x91
> +			MX8MP_IOMUXC_ENET_RD2__ENET_QOS_RGMII_RD2			0x91
> +			MX8MP_IOMUXC_ENET_RD3__ENET_QOS_RGMII_RD3			0x91
> +			MX8MP_IOMUXC_ENET_RXC__CCM_ENET_QOS_CLOCK_GENERATE_RX_CLK	0x91
> +			MX8MP_IOMUXC_ENET_RX_CTL__ENET_QOS_RGMII_RX_CTL			0x91
> +			MX8MP_IOMUXC_ENET_TD0__ENET_QOS_RGMII_TD0			0x1f
> +			MX8MP_IOMUXC_ENET_TD1__ENET_QOS_RGMII_TD1			0x1f
> +			MX8MP_IOMUXC_ENET_TD2__ENET_QOS_RGMII_TD2			0x1f
> +			MX8MP_IOMUXC_ENET_TD3__ENET_QOS_RGMII_TD3			0x1f
> +			MX8MP_IOMUXC_ENET_TX_CTL__ENET_QOS_RGMII_TX_CTL			0x1f
> +			MX8MP_IOMUXC_ENET_TXC__CCM_ENET_QOS_CLOCK_GENERATE_TX_CLK	0x1f
> +			MX8MP_IOMUXC_NAND_DATA01__GPIO3_IO07				0x19
> +		>;
> +	};
> +
> +	pinctrl_reg_usdhc2_vmmc: regusdhc2vmmcgrp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_SD2_RESET_B__GPIO2_IO19	0x41
> +		>;
> +	};
> +
> +	pinctrl_uart2: uart2grp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_UART2_RXD__UART2_DCE_RX	0x49
> +			MX8MP_IOMUXC_UART2_TXD__UART2_DCE_TX	0x49
> +		>;
> +	};
> +
> +	pinctrl_uart3: uart3grp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_UART3_RXD__UART3_DCE_RX	0x140
> +			MX8MP_IOMUXC_UART3_TXD__UART3_DCE_TX	0x140
> +			MX8MP_IOMUXC_SD1_STROBE__UART3_DCE_CTS	0x140
> +		>;
> +	};
> +
> +	pinctrl_reg_usb1_vbus: usb1grp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_GPIO1_IO14__GPIO1_IO14	0x19
> +		>;
> +	};
> +
> +	pinctrl_usdhc2_gpio: usdhc2grp-gpio {

Same as patch 2, wrong node name.


Best regards,
Krzysztof
