Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4255653DE46
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 22:53:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347518AbiFEUxK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 16:53:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347385AbiFEUxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 16:53:07 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E7C1631F
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 13:53:05 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id h19so16437789edj.0
        for <linux-kernel@vger.kernel.org>; Sun, 05 Jun 2022 13:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=aFvG2SqOR+C6qV40KBQZFyKAA1NOHDaCfXYjOfceNeI=;
        b=A14ola83BMKA7BEriIYkKr2oRTjFBAvjeueBeJy+gZon25QpheHFnpk2fJMbxXEv4W
         BDaal5QNSnFHtR+7/M9UWxeNXqFX4qCSmv9BG8LPgNZe68C0o5dBofSUuZoV/0mkW2x/
         MijH64imBxV7SJ0EWKt9lPi+Yx+uxEn6aIknQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aFvG2SqOR+C6qV40KBQZFyKAA1NOHDaCfXYjOfceNeI=;
        b=0K46m9VVbexiVDBYQbss1KC/fuZyvBNpSGH/uwWMArBnCxQ+7wQfvkWDatSl6sVTop
         v49ChXcKnF2TA6kF4U9LKtRSR76SRBYVO+D/UOdgmewWJuLM0x/RW/Pb91jj1cJ372h8
         URbC4uikFJbGvTgHaIWdOY2F6v2XNl82BCQJ6ZfDh/47GAbIoOLy5n9qbt6webBHZJ8U
         Xt2ZfyUAJC8neynd9CBdECjpBD7xb3PMQWyL9NnxoAlHgpCxTeycec9ZCTKi3F+i+Gl6
         zwBirh3xzsCiA6WXZLAkjzYi1yuBVpNmadTnLdUo+nqU6h84KKfIdvGf7kB4b7fk1TbA
         GnxA==
X-Gm-Message-State: AOAM533Y3bt1kNyIG3lZ6G/G0GIS1G+z9JLffsD9MaGUdJM9MfT9vO+Y
        xkKepxYjV8wVYKJwn8/wmyzJeg==
X-Google-Smtp-Source: ABdhPJw53gVmTD6sxrgIQ/KbU3mw1nMsBR2I98XDWM8tyPWxY6yntBTIGornF1f9VSjidoxiR0ANKw==
X-Received: by 2002:a05:6402:354a:b0:430:4855:2821 with SMTP id f10-20020a056402354a00b0043048552821mr10244145edd.391.1654462383640;
        Sun, 05 Jun 2022 13:53:03 -0700 (PDT)
Received: from tom-ThinkPad-T14s-Gen-2i (net-2-39-143-183.cust.vodafonedsl.it. [2.39.143.183])
        by smtp.gmail.com with ESMTPSA id e18-20020a1709062d5200b006f3ef214da6sm5571436eji.12.2022.06.05.13.53.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jun 2022 13:53:03 -0700 (PDT)
Date:   Sun, 5 Jun 2022 22:53:00 +0200
From:   Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 2/3] arm64: dts: freescale: add i.MX93 11x11 EVK basic
 support
Message-ID: <20220605205300.GB194967@tom-ThinkPad-T14s-Gen-2i>
References: <20220425110330.1630984-1-peng.fan@oss.nxp.com>
 <20220425110330.1630984-3-peng.fan@oss.nxp.com>
 <20220605203906.GA194967@tom-ThinkPad-T14s-Gen-2i>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220605203906.GA194967@tom-ThinkPad-T14s-Gen-2i>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 05, 2022 at 10:39:06PM +0200, Tommaso Merciai wrote:
> Hi Peng,
> 
> On Mon, Apr 25, 2022 at 07:03:29PM +0800, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> > 
> > Enable lpuart & SDHC for console and rootfs
> > 
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >  arch/arm64/boot/dts/freescale/Makefile        |   1 +
> >  .../boot/dts/freescale/imx93-11x11-evk.dts    | 130 ++++++++++++++++++
> >  2 files changed, 131 insertions(+)
> >  create mode 100644 arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
> > 
> > diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
> > index 851e6faf8c05..955706c666d8 100644
> > --- a/arch/arm64/boot/dts/freescale/Makefile
> > +++ b/arch/arm64/boot/dts/freescale/Makefile
> > @@ -105,6 +105,7 @@ dtb-$(CONFIG_ARCH_MXC) += imx8qxp-ai_ml.dtb
> >  dtb-$(CONFIG_ARCH_MXC) += imx8qxp-colibri-eval-v3.dtb
> >  dtb-$(CONFIG_ARCH_MXC) += imx8qxp-mek.dtb
> >  dtb-$(CONFIG_ARCH_MXC) += imx8ulp-evk.dtb
> > +dtb-$(CONFIG_ARCH_MXC) += imx93-11x11-evk.dtb
> >  
> >  imx8mm-venice-gw72xx-0x-imx219-dtbs	:= imx8mm-venice-gw73xx-0x.dtb imx8mm-venice-gw73xx-0x-imx219.dtbo
> >  imx8mm-venice-gw72xx-0x-rs232-rts-dtbs	:= imx8mm-venice-gw72xx-0x.dtb imx8mm-venice-gw72xx-0x-rs232-rts.dtbo
> > diff --git a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
> > new file mode 100644
> > index 000000000000..5ee63e3e4759
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
> > @@ -0,0 +1,130 @@
> > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > +/*
> > + * Copyright 2022 NXP
> > + */
> > +
> > +/dts-v1/;
> > +
> > +#include "imx93.dtsi"
> > +
> > +/ {
> > +	chosen {
> > +		stdout-path = &lpuart1;
> > +	};
> > +
> > +	reg_usdhc2_vmmc: regulator-usdhc2 {
> > +		compatible = "regulator-fixed";
> > +		pinctrl-names = "default";
> > +		pinctrl-0 = <&pinctrl_reg_usdhc2_vmmc>;
> > +		regulator-name = "VSD_3V3";
> > +		regulator-min-microvolt = <3300000>;
> > +		regulator-max-microvolt = <3300000>;
> > +		gpio = <&gpio3 7 GPIO_ACTIVE_HIGH>;
> > +		enable-active-high;
> > +	};
> > +};
> > +
> > +&mu1 {
> > +	status = "okay";
> > +};
> > +
> > +&mu2 {
> > +	status = "okay";
> > +};
> > +
> > +&lpuart1 { /* console */
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&pinctrl_uart1>;
> > +	status = "okay";
> > +};
> > +
> > +&usdhc1 {
> > +	pinctrl-names = "default", "state_100mhz", "state_200mhz";
> > +	pinctrl-0 = <&pinctrl_usdhc1>;
> > +	pinctrl-1 = <&pinctrl_usdhc1>;
> > +	pinctrl-2 = <&pinctrl_usdhc1>;
> > +	bus-width = <8>;
> > +	non-removable;
> > +	status = "okay";
> > +};
> > +
> > +&usdhc2 {
> > +	pinctrl-names = "default", "state_100mhz", "state_200mhz";
> > +	pinctrl-0 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
> > +	pinctrl-1 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
> > +	pinctrl-2 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
> > +	cd-gpios = <&gpio3 00 GPIO_ACTIVE_LOW>;
> > +	vmmc-supply = <&reg_usdhc2_vmmc>;
> > +	bus-width = <4>;
> > +	status = "okay";
> > +	no-sdio;
> > +	no-mmc;
> > +};
> > +
> > +&iomuxc {
> > +	pinctrl-names = "default";
> > +	status = "okay";
> 
> I think you don't need status = "okay" here.
> dts node is enable as default.

Hi Peng,
I was wrong sorry, is the opposite. Disabled as default.
Then looks good to me.

Reviewed-by: Tommaso Merciai <tommaso.merciai@amarulasolutions.com>


> 
> > +
> > +	pinctrl_uart1: uart1grp {
> > +		fsl,pins = <
> > +			MX93_PAD_UART1_RXD__LPUART1_RX			0x31e
> > +			MX93_PAD_UART1_TXD__LPUART1_TX			0x31e
> > +		>;
> > +	};
> > +
> > +	pinctrl_uart2: uart2grp {
> > +		fsl,pins = <
> > +			MX93_PAD_UART2_TXD__LPUART2_TX			0x31e
> > +			MX93_PAD_UART2_RXD__LPUART2_RX			0x31e
> > +		>;
> > +	};
> > +
> > +	pinctrl_uart5: uart5grp {
> > +		fsl,pins = <
> > +			MX93_PAD_DAP_TDO_TRACESWO__LPUART5_TX	0x31e
> > +			MX93_PAD_DAP_TDI__LPUART5_RX		0x31e
> > +			MX93_PAD_DAP_TMS_SWDIO__LPUART5_RTS_B	0x31e
> > +			MX93_PAD_DAP_TCLK_SWCLK__LPUART5_CTS_B	0x31e
> > +		>;
> > +	};
> > +
> > +	pinctrl_usdhc1: usdhc1grp {
> > +		fsl,pins = <
> > +			MX93_PAD_SD1_CLK__USDHC1_CLK		0x17fe
> > +			MX93_PAD_SD1_CMD__USDHC1_CMD		0x13fe
> > +			MX93_PAD_SD1_DATA0__USDHC1_DATA0	0x13fe
> > +			MX93_PAD_SD1_DATA1__USDHC1_DATA1	0x13fe
> > +			MX93_PAD_SD1_DATA2__USDHC1_DATA2	0x13fe
> > +			MX93_PAD_SD1_DATA3__USDHC1_DATA3	0x13fe
> > +			MX93_PAD_SD1_DATA4__USDHC1_DATA4	0x13fe
> > +			MX93_PAD_SD1_DATA5__USDHC1_DATA5	0x13fe
> > +			MX93_PAD_SD1_DATA6__USDHC1_DATA6	0x13fe
> > +			MX93_PAD_SD1_DATA7__USDHC1_DATA7	0x13fe
> > +			MX93_PAD_SD1_STROBE__USDHC1_STROBE	0x17fe
> > +		>;
> > +	};
> > +
> > +	pinctrl_reg_usdhc2_vmmc: regusdhc2vmmcgrp {
> > +		fsl,pins = <
> > +			MX93_PAD_SD2_RESET_B__GPIO3_IO07	0x31e
> > +		>;
> > +	};
> > +
> > +	pinctrl_usdhc2_gpio: usdhc2gpiogrp {
> > +		fsl,pins = <
> > +			MX93_PAD_SD2_CD_B__GPIO3_IO00		0x31e
> > +		>;
> > +	};
> > +
> > +	pinctrl_usdhc2: usdhc2grp {
> > +		fsl,pins = <
> > +			MX93_PAD_SD2_CLK__USDHC2_CLK		0x17fe
> > +			MX93_PAD_SD2_CMD__USDHC2_CMD		0x13fe
> > +			MX93_PAD_SD2_DATA0__USDHC2_DATA0	0x13fe
> > +			MX93_PAD_SD2_DATA1__USDHC2_DATA1	0x13fe
> > +			MX93_PAD_SD2_DATA2__USDHC2_DATA2	0x13fe
> > +			MX93_PAD_SD2_DATA3__USDHC2_DATA3	0x13fe
> > +			MX93_PAD_SD2_VSELECT__USDHC2_VSELECT	0x51e
> > +		>;
> > +	};
> > +};
> > -- 
> > 2.25.1
> > 
> 
> Regards,
> Tommaso
> 
> -- 
> Tommaso Merciai
> Embedded Linux Engineer
> tommaso.merciai@amarulasolutions.com
> __________________________________
> 
> Amarula Solutions SRL
> Via Le Canevare 30, 31100 Treviso, Veneto, IT
> T. +39 042 243 5310
> info@amarulasolutions.com
> www.amarulasolutions.com

-- 
Tommaso Merciai
Embedded Linux Engineer
tommaso.merciai@amarulasolutions.com
__________________________________

Amarula Solutions SRL
Via Le Canevare 30, 31100 Treviso, Veneto, IT
T. +39 042 243 5310
info@amarulasolutions.com
www.amarulasolutions.com
