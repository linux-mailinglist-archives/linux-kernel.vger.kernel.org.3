Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A8E7468E97
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 02:35:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231215AbhLFBjJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 20:39:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230273AbhLFBjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 20:39:08 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99682C061751;
        Sun,  5 Dec 2021 17:35:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DA7E161155;
        Mon,  6 Dec 2021 01:35:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0A7CC00446;
        Mon,  6 Dec 2021 01:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638754539;
        bh=YnLHb1NnlQqzQ1VeaGs3MeHcABJKrdyHMDe7N50Y6SY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LCjOGry84Tn+PdwhzGB+nlQdWsl71nEv4DZvOXI1FmN9fBhBKE7ULW8n53NZ7xCTv
         y2GZ3ss6NYBdt/p66XzXlHJhbDceShOy9pclJFGUQrDg4QPFT3K5LbYTXqUndZHgmh
         KaAaW2CN+iAGg87Q1V1DtFN/6GGhW7OdhGCSmJsSngFsgCjGnBMHw6BqvzDDdK+I8O
         FIKBN/5Uf/3g+DHKdAoERqNYNuII0mmXR/tzyYJSm2vFm9oA43mkoXMrluhk8f725C
         hJdNh4Y/EzTtwhsIpU8zWtljby0fJjZ0aDqWtXqtIYO0EGVy4Q/MPLIZ+FbvhP2rag
         +EqzyGENG5gdQ==
Date:   Mon, 6 Dec 2021 09:35:31 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Ariel D'Alessandro <ariel.dalessandro@collabora.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, aisheng.dong@nxp.com,
        festevam@gmail.com, ioana.ciornei@nxp.com,
        jagan@amarulasolutions.com, kernel@pengutronix.de, krzk@kernel.org,
        linux-imx@nxp.com, matt@traverse.com.au, matteo.lisi@engicam.com,
        meenakshi.aggarwal@nxp.com, michael@amarulasolutions.com,
        nathan@kernel.org, robh+dt@kernel.org, s.hauer@pengutronix.de,
        tharvey@gateworks.com
Subject: Re: [PATCH v2 5/5] arm: dts: imx8ulz-bsh-smm-m2: Add BSH SMM-M2
 IMX6ULZ SystemMaster
Message-ID: <20211206013531.GO4216@dragon>
References: <20211123151252.143631-1-ariel.dalessandro@collabora.com>
 <20211123151252.143631-6-ariel.dalessandro@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211123151252.143631-6-ariel.dalessandro@collabora.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 23, 2021 at 12:12:52PM -0300, Ariel D'Alessandro wrote:
> From: Michael Trimarchi <michael@amarulasolutions.com>
> 
> Add DTS of BSH SMM-M2 SystemMaster.
> 
> This version comes with:
> - 128 MiB DDR3 RAM
> - 256 MiB Nand
> - wifi
> - bluetooth
> 
> Signed-off-by: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
> Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
> ---
>  arch/arm/boot/dts/Makefile               |   3 +-
>  arch/arm/boot/dts/imx6ulz-bsh-smm-m2.dts | 153 +++++++++++++++++++++++
>  2 files changed, 155 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm/boot/dts/imx6ulz-bsh-smm-m2.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 0de64f237cd8..e6d4ad497985 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -693,7 +693,8 @@ dtb-$(CONFIG_SOC_IMX6UL) += \
>  	imx6ull-phytec-segin-ff-rdk-nand.dtb \
>  	imx6ull-phytec-segin-ff-rdk-emmc.dtb \
>  	imx6ull-phytec-segin-lc-rdk-nand.dtb \
> -	imx6ulz-14x14-evk.dtb
> +	imx6ulz-14x14-evk.dtb \
> +	imx6ulz-bsh-smm-m2.dts
>  dtb-$(CONFIG_SOC_IMX7D) += \
>  	imx7d-cl-som-imx7.dtb \
>  	imx7d-colibri-aster.dtb \
> diff --git a/arch/arm/boot/dts/imx6ulz-bsh-smm-m2.dts b/arch/arm/boot/dts/imx6ulz-bsh-smm-m2.dts
> new file mode 100644
> index 000000000000..9e82860469e3
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx6ulz-bsh-smm-m2.dts
> @@ -0,0 +1,153 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/*
> + * Copyright (C) 2021 BSH Hausgeraete GmbH
> + */
> +
> +/dts-v1/;
> +
> +#include <dt-bindings/input/input.h>
> +#include "imx6ulz.dtsi"
> +
> +/ {
> +	model = "BSH SMM M2";
> +	compatible = "bsh,imx6ulz-bsh-smm-m2", "fsl,imx6ull";
> +
> +	chosen {
> +		stdout-path = &uart4;
> +	};
> +
> +	usdhc2_pwrseq: usdhc2_pwrseq {
> +		compatible = "mmc-pwrseq-simple";
> +		reset-gpios = <&gpio2 21 GPIO_ACTIVE_LOW>;
> +		status = "okay";

"okay" status is generally used to flip "disabled" devices.

> +	};
> +
> +};
> +
> +&uart3 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_bluetooth_uart>;
> +	uart-has-rtscts;
> +

Unneeded newline.

> +	status = "okay";
> +
> +	bluetooth {
> +		compatible = "brcm,bcm4330-bt";
> +		max-speed = <3000000>;
> +		shutdown-gpios = <&gpio1 1 GPIO_ACTIVE_HIGH>;
> +		device-wakeup-gpios = <&gpio2 17 GPIO_ACTIVE_HIGH>;
> +		host-wakeup-gpios = <&gpio2 13 GPIO_ACTIVE_HIGH>;
> +	};
> +};
> +
> +&uart4 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_debug_uart>;
> +	status = "okay";
> +};
> +
> +&usbotg1 {
> +	dr_mode = "peripheral";
> +	srp-disable;
> +	hnp-disable;
> +	adp-disable;
> +	status = "okay";
> +};
> +
> +&usbphy1 {
> +	fsl,tx-d-cal = <106>;
> +};
> +
> +&usdhc2 {
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_wlan>;
> +	bus-width = <4>;
> +	no-1-8-v;
> +	non-removable;
> +	cap-power-off-card;
> +	pm-ignore-notify;

What is this?

> +	keep-power-in-suspend;
> +	wifi-host;

and this?

> +	cap-sdio-irq;
> +	mmc-pwrseq = <&usdhc2_pwrseq>;
> +	status = "okay";
> +
> +	brcmf: wifi@1 {
> +		reg = <1>;
> +		compatible = "brcm,bcm4329-fmac";
> +		interrupt-parent = <&gpio1>;
> +		interrupts = <18 IRQ_TYPE_LEVEL_HIGH>;
> +		interrupt-names = "host-wake";
> +	};
> +};
> +
> +&wdog1 {
> +	status = "okay";
> +};
> +
> +&gpmi {

Out of alphabetical order.

> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_gpmi_nand>;
> +	status = "okay";

End property list with status.

> +	nand-on-flash-bbt;
> +};
> +
> +&iomuxc {
> +	pinctrl_bluetooth_uart: uart3grp {

Name label and node consistently.

> +		fsl,pins = <
> +			MX6UL_PAD_UART3_TX_DATA__UART3_DCE_TX	0x1b0b1
> +			MX6UL_PAD_UART3_RX_DATA__UART3_DCE_RX	0x1b099
> +			MX6UL_PAD_UART3_RTS_B__UART3_DCE_RTS	0x1b0b1
> +			MX6UL_PAD_UART3_CTS_B__UART3_DCE_CTS	0x1b099
> +

Unnecessary newline.

> +			MX6UL_PAD_GPIO1_IO01__GPIO1_IO01	0x79		/* BT_REG_ON */
> +			MX6UL_PAD_SD1_CLK__GPIO2_IO17		0x100b1		/* BT_DEV_WAKE out */
> +			MX6UL_PAD_ENET2_TX_EN__GPIO2_IO13	0x1b0b0		/* BT_HOST_WAKE in */
> +		>;
> +	};
> +
> +	pinctrl_debug_uart: uart4grp {
> +		fsl,pins = <
> +			MX6UL_PAD_UART4_TX_DATA__UART4_DCE_TX	0x1b0b1
> +			MX6UL_PAD_UART4_RX_DATA__UART4_DCE_RX	0x1b0b1
> +		>;
> +	};
> +
> +	pinctrl_gpmi_nand: gpmi-nand {

Name node in the same style as others.

Shawn

> +		fsl,pins = <
> +			MX6UL_PAD_NAND_CLE__RAWNAND_CLE		0xb0b1
> +			MX6UL_PAD_NAND_ALE__RAWNAND_ALE		0xb0b1
> +			MX6UL_PAD_NAND_WP_B__RAWNAND_WP_B	0xb0b1
> +			MX6UL_PAD_NAND_READY_B__RAWNAND_READY_B	0xb000
> +			MX6UL_PAD_NAND_CE0_B__RAWNAND_CE0_B	0xb0b1
> +			MX6UL_PAD_NAND_RE_B__RAWNAND_RE_B	0xb0b1
> +			MX6UL_PAD_NAND_WE_B__RAWNAND_WE_B	0xb0b1
> +			MX6UL_PAD_NAND_DATA00__RAWNAND_DATA00	0xb0b1
> +			MX6UL_PAD_NAND_DATA01__RAWNAND_DATA01	0xb0b1
> +			MX6UL_PAD_NAND_DATA02__RAWNAND_DATA02	0xb0b1
> +			MX6UL_PAD_NAND_DATA03__RAWNAND_DATA03	0xb0b1
> +			MX6UL_PAD_NAND_DATA04__RAWNAND_DATA04	0xb0b1
> +			MX6UL_PAD_NAND_DATA05__RAWNAND_DATA05	0xb0b1
> +			MX6UL_PAD_NAND_DATA06__RAWNAND_DATA06	0xb0b1
> +			MX6UL_PAD_NAND_DATA07__RAWNAND_DATA07	0xb0b1
> +		>;
> +	};
> +
> +	pinctrl_wlan: wlangrp {
> +		fsl,pins = <
> +			MX6UL_PAD_CSI_HSYNC__USDHC2_CMD		0x17059
> +			MX6UL_PAD_CSI_VSYNC__USDHC2_CLK		0x10059
> +			MX6UL_PAD_CSI_DATA00__USDHC2_DATA0	0x17059
> +			MX6UL_PAD_CSI_DATA01__USDHC2_DATA1	0x17059
> +			MX6UL_PAD_CSI_DATA02__USDHC2_DATA2	0x17059
> +			MX6UL_PAD_CSI_DATA03__USDHC2_DATA3	0x17059
> +
> +			MX6UL_PAD_SD1_DATA3__GPIO2_IO21		0x79		/* WL_REG_ON */
> +			MX6UL_PAD_UART2_CTS_B__GPIO1_IO22	0x100b1		/* WL_DEV_WAKE - WiFi_GPIO_4 - WiFi FW UART */
> +			MX6UL_PAD_UART1_CTS_B__GPIO1_IO18	0x1b0b1		/* WL_HOST_WAKE - WIFI_GPIO_0 - OOB IRQ */
> +			MX6UL_PAD_ENET1_RX_EN__OSC32K_32K_OUT	0x4001b031	/* OSC 32Khz wifi clk in */
> +		>;
> +	};
> +};
> -- 
> 2.30.2
> 
