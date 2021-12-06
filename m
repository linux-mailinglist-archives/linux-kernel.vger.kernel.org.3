Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E5BA468E94
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 02:29:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231133AbhLFBdM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 20:33:12 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:58060 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230273AbhLFBdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 20:33:10 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 79DFA61178;
        Mon,  6 Dec 2021 01:29:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CFCCC00446;
        Mon,  6 Dec 2021 01:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638754181;
        bh=L3Qn4bOhAaCe3Mdw9mrSBz/b/0vi5OmdjPQ167bonbw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Bxtolzdoevjt/e6TDjAAfYxbFW4ZyqhfPOcf3GXQSltXM7QOoENny+sklhub7LYu3
         +7XUony8iqxdPfjZuoIU+njI3gNmOB9tdwCGqW4tvJZYIGmycWJPLg3BMBUV2drlUY
         QNZWHhld3TWMbl9IjLTdqttEPIZYDfYjCoD1/nL9msUKFzglCGPXT+cyE5QVk4cz1+
         V7DhWADMe9AUJCKhGsxPwH24moYFKxDlhXXdAylHvZ32Czwdl2WUEpVUxgzaOv82sc
         FSfiWZSbApWWlYFkAK5zIwumTjZPWmVQi9WHrsGRgDSiGPxE4tfZMvDf+PZyZdoYPY
         NaAPlAmxcffDw==
Date:   Mon, 6 Dec 2021 09:29:34 +0800
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
Subject: Re: [PATCH v2 3/5] arm64: dts: imx8mn-bsh-smm-s2/pro: Add iMX8MN BSH
 SMM S2 boards
Message-ID: <20211206012933.GN4216@dragon>
References: <20211123151252.143631-1-ariel.dalessandro@collabora.com>
 <20211123151252.143631-4-ariel.dalessandro@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211123151252.143631-4-ariel.dalessandro@collabora.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 23, 2021 at 12:12:50PM -0300, Ariel D'Alessandro wrote:
> Introduce BSH SystemMaster (SMM) S2 board family, which consists of:
> iMX8MN SMM S2 and iMX8MN SMM S2 PRO boards.
> 
> Add support for iMX8MN BSH SMM S2 board:
> 
> - 256 MiB DDR3 RAM
> - 512 MiB NAND
> - Megabit Ethernet PHY
> - Wi-Fi 802.11 a/b/g/n/ac with Bluetooth 5.0
> - USB-OTG (peripheral mode)
> 
> Add support for iMX8MN BSH SMM S2 PRO board:
> 
> - 512 MiB DDR3 RAM
> - 8 GiB eMMC
> - Megabit Ethernet PHY
> - Wi-Fi 802.11 a/b/g/n/ac with Bluetooth 5.0
> - USB-OTG (peripheral mode)
> 
> Signed-off-by: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
> Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
> ---
>  arch/arm64/boot/dts/freescale/Makefile        |   2 +
>  .../freescale/imx8mn-bsh-smm-s2-common.dtsi   | 426 ++++++++++++++++++
>  .../boot/dts/freescale/imx8mn-bsh-smm-s2.dts  |  48 ++
>  .../dts/freescale/imx8mn-bsh-smm-s2pro.dts    |  80 ++++
>  4 files changed, 556 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mn-bsh-smm-s2-common.dtsi
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mn-bsh-smm-s2.dts
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mn-bsh-smm-s2pro.dts
> 
> diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
> index a14a6173b765..c3e01c94ff7f 100644
> --- a/arch/arm64/boot/dts/freescale/Makefile
> +++ b/arch/arm64/boot/dts/freescale/Makefile
> @@ -47,6 +47,8 @@ dtb-$(CONFIG_ARCH_MXC) += imx8mm-venice-gw73xx-0x.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mm-venice-gw7901.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mm-venice-gw7902.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mn-beacon-kit.dtb
> +dtb-$(CONFIG_ARCH_MXC) += imx8mn-bsh-smm-s2.dtb
> +dtb-$(CONFIG_ARCH_MXC) += imx8mn-bsh-smm-s2pro.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mn-evk.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mn-ddr4-evk.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mn-var-som-symphony.dtb
> diff --git a/arch/arm64/boot/dts/freescale/imx8mn-bsh-smm-s2-common.dtsi b/arch/arm64/boot/dts/freescale/imx8mn-bsh-smm-s2-common.dtsi
> new file mode 100644
> index 000000000000..a49528e1601c
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx8mn-bsh-smm-s2-common.dtsi
> @@ -0,0 +1,426 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2021 Collabora Ltd.
> + * Copyright 2021 BSH Hausgeraete GmbH
> + */
> +
> +/dts-v1/;
> +
> +#include "imx8mn.dtsi"
> +
> +/ {
> +	chosen {
> +		stdout-path = &uart4;
> +	};
> +
> +	fec_supply: fec_supply_en {

Hyphen is recommended in node name.

> +		compatible = "regulator-fixed";
> +		regulator-name = "tja1101_en";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		gpio = <&gpio2 20 GPIO_ACTIVE_HIGH>;
> +		vin-supply = <&buck4_reg>;
> +		enable-active-high;

Put it right below 'gpio' line.

> +	};
> +
> +	usdhc2_pwrseq: usdhc2_pwrseq {
> +		compatible = "mmc-pwrseq-simple";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_usdhc2_pwrseq>;
> +		reset-gpios = <&gpio4 27 GPIO_ACTIVE_LOW>;
> +	};
> +};
> +
> +&A53_0 {
> +	cpu-supply = <&buck2_reg>;
> +};
> +
> +&A53_1 {
> +	cpu-supply = <&buck2_reg>;
> +};
> +
> +&A53_2 {
> +	cpu-supply = <&buck2_reg>;
> +};
> +
> +&A53_3 {
> +	cpu-supply = <&buck2_reg>;
> +};
> +
> +&ecspi2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_espi2>;
> +	status = "okay";
> +};
> +
> +&fec1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_fec1>;
> +	phy-mode = "rmii";
> +	phy-handle = <&ethphy0>;
> +	phy-supply = <&fec_supply>;
> +	fsl,magic-packet;
> +	status = "okay";
> +
> +	mdio {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		ethphy0: ethernet-phy@0 {
> +			compatible = "ethernet-phy-ieee802.3-c22";
> +			reg = <0>;
> +			reset-gpios = <&gpio1 29 GPIO_ACTIVE_LOW>;
> +			reset-assert-us = <20>;
> +			reset-deassert-us = <2000>;
> +		};
> +	};
> +};
> +
> +&i2c1 {
> +	clock-frequency = <400000>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_i2c1>;
> +	status = "okay";
> +
> +	bd71847: pmic@4b {
> +		compatible = "rohm,bd71847";
> +		reg = <0x4b>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_pmic>;
> +		interrupt-parent = <&gpio1>;
> +		interrupts = <3 IRQ_TYPE_LEVEL_LOW>;
> +		rohm,reset-snvs-powered;
> +
> +		#clock-cells = <0>;
> +		clocks = <&osc_32k 0>;
> +		clock-output-names = "clk-32k-out";
> +
> +		regulators {
> +			buck1_reg: BUCK1 {
> +				/* PMIC_BUCK1 - VDD_SOC */
> +				regulator-name = "buck1";
> +				regulator-min-microvolt = <700000>;
> +				regulator-max-microvolt = <1300000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +				regulator-ramp-delay = <1250>;
> +			};
> +
> +			buck2_reg: BUCK2 {
> +				/* PMIC_BUCK2 - VDD_ARM */
> +				regulator-name = "buck2";
> +				regulator-min-microvolt = <700000>;
> +				regulator-max-microvolt = <1300000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +				regulator-ramp-delay = <1250>;
> +			};
> +
> +			buck3_reg: BUCK3 {
> +				/* PMIC_BUCK5 - VDD_DRAM_VPU_GPU */
> +				regulator-name = "buck3";
> +				regulator-min-microvolt = <700000>;
> +				regulator-max-microvolt = <1350000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			buck4_reg: BUCK4 {
> +				/* PMIC_BUCK6 - VDD_3V3 */
> +				regulator-name = "buck4";
> +				regulator-min-microvolt = <3000000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			buck5_reg: BUCK5 {
> +				/* PMIC_BUCK7 - VDD_1V8 */
> +				regulator-name = "buck5";
> +				regulator-min-microvolt = <1605000>;
> +				regulator-max-microvolt = <1995000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			buck6_reg: BUCK6 {
> +				/* PMIC_BUCK8 - NVCC_DRAM */
> +				regulator-name = "buck6";
> +				regulator-min-microvolt = <800000>;
> +				regulator-max-microvolt = <1400000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			ldo1_reg: LDO1 {
> +				/* PMIC_LDO1 - NVCC_SNVS_1V8 */
> +				regulator-name = "ldo1";
> +				regulator-min-microvolt = <1600000>;
> +				regulator-max-microvolt = <1900000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			ldo2_reg: LDO2 {
> +				/* PMIC_LDO2 - VDD_SNVS_0V8 */
> +				regulator-name = "ldo2";
> +				regulator-min-microvolt = <800000>;
> +				regulator-max-microvolt = <900000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			ldo3_reg: LDO3 {
> +				/* PMIC_LDO3 - VDDA_1V8 */
> +				regulator-name = "ldo3";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			ldo4_reg: LDO4 {
> +				/* PMIC_LDO4 - VDD_MIPI_0V9 */
> +				regulator-name = "ldo4";
> +				regulator-min-microvolt = <900000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			ldo6_reg: LDO6 {
> +				/* PMIC_LDO6 - VDD_MIPI_1V2 */
> +				regulator-name = "ldo6";
> +				regulator-min-microvolt = <900000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +		};
> +	};
> +};
> +
> +&i2c3 {
> +	clock-frequency = <400000>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_i2c3>;
> +	status = "okay";
> +};
> +
> +&i2c4 {
> +	clock-frequency = <400000>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_i2c4>;
> +	status = "okay";
> +};
> +
> +&uart2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart2>;
> +	status = "okay";
> +};
> +
> +&uart3 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart3>;
> +	assigned-clocks = <&clk IMX8MN_CLK_UART3>;
> +	assigned-clock-parents = <&clk IMX8MN_SYS_PLL1_80M>;
> +	uart-has-rtscts;
> +	status = "okay";
> +
> +	bluetooth {
> +		compatible = "brcm,bcm43438-bt";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_bluetooth>;
> +		shutdown-gpios = <&gpio1 15 GPIO_ACTIVE_HIGH>;
> +		device-wakeup-gpios = <&gpio1 18 GPIO_ACTIVE_HIGH>;
> +		host-wakeup-gpios = <&gpio1 28 GPIO_ACTIVE_HIGH>;
> +		max-speed = <3000000>;
> +	};
> +};
> +
> +/* Console */
> +&uart4 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart4>;
> +	status = "okay";
> +};
> +
> +&usbotg1 {
> +	dr_mode = "peripheral";
> +	disable-over-current;
> +	status = "okay";
> +};
> +
> +&usdhc2 {
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	pinctrl-names = "default", "state_100mhz", "state_200mhz";
> +	pinctrl-0 = <&pinctrl_usdhc2>;
> +	pinctrl-1 = <&pinctrl_usdhc2_100mhz>;
> +	pinctrl-2 = <&pinctrl_usdhc2_200mhz>;
> +	mmc-pwrseq = <&usdhc2_pwrseq>;
> +	bus-width = <4>;
> +	non-removable;
> +	status = "okay";
> +
> +	brcmf: bcrmf@1 {
> +		compatible = "brcm,bcm4329-fmac";
> +		reg = <1>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_wlan>;
> +		interrupt-parent = <&gpio1>;
> +		interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
> +		interrupt-names = "host-wake";
> +	};
> +};
> +
> +&wdog1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_wdog>;
> +	fsl,ext-reset-output;
> +	status = "okay";
> +};
> +
> +&iomuxc {
> +	pinctrl_espi2: espi2grp {
> +		fsl,pins = <
> +			MX8MN_IOMUXC_ECSPI2_SCLK_ECSPI2_SCLK            0x082
> +			MX8MN_IOMUXC_ECSPI2_MOSI_ECSPI2_MOSI            0x082
> +			MX8MN_IOMUXC_ECSPI2_MISO_ECSPI2_MISO            0x082
> +			MX8MN_IOMUXC_ECSPI2_SS0_ECSPI2_SS0		0x040
> +		>;
> +	};
> +
> +	pinctrl_i2c1: i2c1grp {
> +		fsl,pins = <
> +			MX8MN_IOMUXC_I2C1_SCL_I2C1_SCL			0x400000c2
> +			MX8MN_IOMUXC_I2C1_SDA_I2C1_SDA			0x400000c2
> +		>;
> +	};
> +
> +	pinctrl_i2c3: i2c3grp {
> +		fsl,pins = <
> +			MX8MN_IOMUXC_I2C3_SCL_I2C3_SCL			0x400000c2
> +			MX8MN_IOMUXC_I2C3_SDA_I2C3_SDA			0x400000c2
> +		>;
> +	};
> +
> +	pinctrl_i2c4: i2c4grp {
> +		fsl,pins = <
> +			MX8MN_IOMUXC_I2C4_SCL_I2C4_SCL			0x400000c2
> +			MX8MN_IOMUXC_I2C4_SDA_I2C4_SDA			0x400000c2
> +		>;
> +	};
> +
> +	pinctrl_pmic: pmicirq {
> +		fsl,pins = <
> +			MX8MN_IOMUXC_GPIO1_IO03_GPIO1_IO3		0x040
> +		>;
> +	};
> +
> +	pinctrl_uart4: uart4grp {
> +		fsl,pins = <
> +			MX8MN_IOMUXC_UART4_RXD_UART4_DCE_RX		0x040
> +			MX8MN_IOMUXC_UART4_TXD_UART4_DCE_TX		0x040
> +		>;
> +	};
> +
> +	pinctrl_usdhc2_pwrseq: usdhc2pwrseqgrp {
> +		fsl,pins = <
> +			MX8MN_IOMUXC_SAI2_MCLK_GPIO4_IO27		0x040	/* WL_REG_ON */
> +		>;
> +	};
> +
> +	pinctrl_usdhc2: usdhc2grp {
> +		fsl,pins = <
> +			MX8MN_IOMUXC_SD2_CLK_USDHC2_CLK			0x090
> +			MX8MN_IOMUXC_SD2_CMD_USDHC2_CMD			0x0d0
> +			MX8MN_IOMUXC_SD2_DATA0_USDHC2_DATA0		0x0d0
> +			MX8MN_IOMUXC_SD2_DATA1_USDHC2_DATA1		0x0d0
> +			MX8MN_IOMUXC_SD2_DATA2_USDHC2_DATA2		0x0d0
> +			MX8MN_IOMUXC_SD2_DATA3_USDHC2_DATA3		0x0d0
> +		>;
> +	};
> +
> +	pinctrl_usdhc2_100mhz: usdhc2grp100mhz {
> +		fsl,pins = <
> +			MX8MN_IOMUXC_SD2_CLK_USDHC2_CLK			0x094
> +			MX8MN_IOMUXC_SD2_CMD_USDHC2_CMD			0x0d4
> +			MX8MN_IOMUXC_SD2_DATA0_USDHC2_DATA0		0x0d4
> +			MX8MN_IOMUXC_SD2_DATA1_USDHC2_DATA1		0x0d4
> +			MX8MN_IOMUXC_SD2_DATA2_USDHC2_DATA2		0x0d4
> +			MX8MN_IOMUXC_SD2_DATA3_USDHC2_DATA3		0x0d4
> +		>;
> +	};
> +
> +	pinctrl_usdhc2_200mhz: usdhc2grp200mhz {
> +		fsl,pins = <
> +			MX8MN_IOMUXC_SD2_CLK_USDHC2_CLK			0x096
> +			MX8MN_IOMUXC_SD2_CMD_USDHC2_CMD			0x0d6
> +			MX8MN_IOMUXC_SD2_DATA0_USDHC2_DATA0		0x0d6
> +			MX8MN_IOMUXC_SD2_DATA1_USDHC2_DATA1		0x0d6
> +			MX8MN_IOMUXC_SD2_DATA2_USDHC2_DATA2		0x0d6
> +			MX8MN_IOMUXC_SD2_DATA3_USDHC2_DATA3		0x0d6
> +		>;
> +	};
> +
> +	pinctrl_wlan: wlangrp {
> +		fsl,pins = <
> +			MX8MN_IOMUXC_GPIO1_IO00_GPIO1_IO0		0x0d6	/* GPIO_0 - WIFI_GPIO_0 */
> +			MX8MN_IOMUXC_GPIO1_IO08_GPIO1_IO8		0x0d6	/* GPIO_1 - WIFI_GPIO_1 */
> +			MX8MN_IOMUXC_GPIO1_IO04_GPIO1_IO4		0x0d6	/* BT_GPIO_5 - WIFI_GPIO_5 */
> +			MX8MN_IOMUXC_SPDIF_RX_GPIO5_IO4			0x0d6	/* I2S_CLK - WIFI_GPIO_6 */
> +		>;
> +	};
> +
> +	pinctrl_uart2: uart2grp {
> +		fsl,pins = <
> +			MX8MN_IOMUXC_UART2_RXD_UART2_DCE_RX		0x040
> +			MX8MN_IOMUXC_UART2_TXD_UART2_DCE_TX		0x040
> +		>;
> +	};
> +
> +	pinctrl_uart3: uart3grp {
> +		fsl,pins = <
> +			MX8MN_IOMUXC_UART3_TXD_UART3_DCE_TX		0x040
> +			MX8MN_IOMUXC_UART3_RXD_UART3_DCE_RX		0x040
> +			MX8MN_IOMUXC_ECSPI1_MISO_UART3_DCE_CTS_B	0x040
> +			MX8MN_IOMUXC_ECSPI1_SS0_UART3_DCE_RTS_B		0x040
> +		>;
> +	};
> +
> +	pinctrl_bluetooth: bluetoothgrp {

Out of alphabetical order.

Shawn

> +		fsl,pins = <
> +			MX8MN_IOMUXC_GPIO1_IO15_GPIO1_IO15		0x044	/* BT_REG_ON */
> +			MX8MN_IOMUXC_ENET_TD3_GPIO1_IO18		0x046	/* BT_DEV_WAKE */
> +			MX8MN_IOMUXC_ENET_RD2_GPIO1_IO28		0x090	/* BT_HOST_WAKE */
> +		>;
> +	};
> +
> +	pinctrl_wdog: wdoggrp {
> +		fsl,pins = <
> +			MX8MN_IOMUXC_GPIO1_IO02_WDOG1_WDOG_B		0x046
> +		>;
> +	};
> +
> +	pinctrl_fec1: fec1grp {
> +		fsl,pins = <
> +			MX8MN_IOMUXC_ENET_MDC_ENET1_MDC			0x002
> +			MX8MN_IOMUXC_ENET_MDIO_ENET1_MDIO		0x002
> +			MX8MN_IOMUXC_ENET_RD0_ENET1_RGMII_RD0		0x090
> +			MX8MN_IOMUXC_ENET_RD1_ENET1_RGMII_RD1		0x090
> +			MX8MN_IOMUXC_ENET_RXC_ENET1_RX_ER		0x090
> +			MX8MN_IOMUXC_ENET_TD0_ENET1_RGMII_TD0		0x016
> +			MX8MN_IOMUXC_ENET_TD1_ENET1_RGMII_TD1		0x016
> +			MX8MN_IOMUXC_ENET_TD2_ENET1_TX_CLK		0x016
> +			MX8MN_IOMUXC_ENET_TX_CTL_ENET1_RGMII_TX_CTL	0x016
> +			MX8MN_IOMUXC_ENET_RX_CTL_ENET1_RGMII_RX_CTL	0x090
> +			MX8MN_IOMUXC_ENET_TXC_ENET1_TX_ER		0x016
> +			MX8MN_IOMUXC_SD2_CD_B_GPIO2_IO12		0x150	/* RMII_INT - ENET_INT */
> +			MX8MN_IOMUXC_SD2_WP_GPIO2_IO20			0x150	/* RMII_EN - ENET_EN */
> +			MX8MN_IOMUXC_SD2_RESET_B_GPIO2_IO19		0x016	/* RMII_WAKE - GPIO_ENET_WAKE */
> +			MX8MN_IOMUXC_ENET_RD3_GPIO1_IO29		0x016	/* RMII_RESET - GPIO_ENET_RST */
> +		>;
> +	};
> +};
> diff --git a/arch/arm64/boot/dts/freescale/imx8mn-bsh-smm-s2.dts b/arch/arm64/boot/dts/freescale/imx8mn-bsh-smm-s2.dts
> new file mode 100644
> index 000000000000..33f98582eace
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx8mn-bsh-smm-s2.dts
> @@ -0,0 +1,48 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2021 Collabora Ltd.
> + * Copyright 2021 BSH Hausgeraete GmbH
> + */
> +
> +/dts-v1/;
> +
> +#include "imx8mn-bsh-smm-s2-common.dtsi"
> +
> +/ {
> +	model = "BSH SMM S2";
> +	compatible = "bsh,imx8mn-bsh-smm-s2", "fsl,imx8mn";
> +
> +	memory@40000000 {
> +		device_type = "memory";
> +		reg = <0x0 0x40000000 0x0 0x10000000>;
> +	};
> +};
> +
> +&gpmi {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_gpmi_nand>;
> +	nand-on-flash-bbt;
> +	status = "okay";
> +};
> +
> +&iomuxc {
> +	pinctrl_gpmi_nand: gpmi-nand {
> +		fsl,pins = <
> +			MX8MN_IOMUXC_NAND_ALE_RAWNAND_ALE		0x00000096
> +			MX8MN_IOMUXC_NAND_CE0_B_RAWNAND_CE0_B		0x00000096
> +			MX8MN_IOMUXC_NAND_CLE_RAWNAND_CLE		0x00000096
> +			MX8MN_IOMUXC_NAND_DATA00_RAWNAND_DATA00		0x00000096
> +			MX8MN_IOMUXC_NAND_DATA01_RAWNAND_DATA01		0x00000096
> +			MX8MN_IOMUXC_NAND_DATA02_RAWNAND_DATA02		0x00000096
> +			MX8MN_IOMUXC_NAND_DATA03_RAWNAND_DATA03		0x00000096
> +			MX8MN_IOMUXC_NAND_DATA04_RAWNAND_DATA04		0x00000096
> +			MX8MN_IOMUXC_NAND_DATA05_RAWNAND_DATA05		0x00000096
> +			MX8MN_IOMUXC_NAND_DATA06_RAWNAND_DATA06		0x00000096
> +			MX8MN_IOMUXC_NAND_DATA07_RAWNAND_DATA07		0x00000096
> +			MX8MN_IOMUXC_NAND_RE_B_RAWNAND_RE_B		0x00000096
> +			MX8MN_IOMUXC_NAND_READY_B_RAWNAND_READY_B	0x00000056
> +			MX8MN_IOMUXC_NAND_WE_B_RAWNAND_WE_B		0x00000096
> +			MX8MN_IOMUXC_NAND_WP_B_RAWNAND_WP_B		0x00000096
> +		>;
> +	};
> +};
> diff --git a/arch/arm64/boot/dts/freescale/imx8mn-bsh-smm-s2pro.dts b/arch/arm64/boot/dts/freescale/imx8mn-bsh-smm-s2pro.dts
> new file mode 100644
> index 000000000000..c6a8ed6745c1
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx8mn-bsh-smm-s2pro.dts
> @@ -0,0 +1,80 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2021 Collabora Ltd.
> + * Copyright 2021 BSH Hausgeraete GmbH
> + */
> +
> +/dts-v1/;
> +
> +#include "imx8mn-bsh-smm-s2-common.dtsi"
> +
> +/ {
> +	model = "BSH SMM S2 PRO";
> +	compatible = "bsh,imx8mn-bsh-smm-s2pro", "fsl,imx8mn";
> +
> +	memory@40000000 {
> +		device_type = "memory";
> +		reg = <0x0 0x40000000 0x0 0x20000000>;
> +	};
> +};
> +
> +/* eMMC */
> +&usdhc1 {
> +	pinctrl-names = "default", "state_100mhz", "state_200mhz";
> +	pinctrl-0 = <&pinctrl_usdhc1>;
> +	pinctrl-1 = <&pinctrl_usdhc1_100mhz>;
> +	pinctrl-2 = <&pinctrl_usdhc1_200mhz>;
> +	bus-width = <8>;
> +	non-removable;
> +	status = "okay";
> +};
> +
> +&iomuxc {
> +	pinctrl_usdhc1: usdhc1grp {
> +		fsl,pins = <
> +			MX8MN_IOMUXC_SD1_CLK_USDHC1_CLK			0x40000090
> +			MX8MN_IOMUXC_SD1_CMD_USDHC1_CMD			0x0d0
> +			MX8MN_IOMUXC_SD1_DATA0_USDHC1_DATA0		0x0d0
> +			MX8MN_IOMUXC_SD1_DATA1_USDHC1_DATA1		0x0d0
> +			MX8MN_IOMUXC_SD1_DATA2_USDHC1_DATA2		0x0d0
> +			MX8MN_IOMUXC_SD1_DATA3_USDHC1_DATA3		0x0d0
> +			MX8MN_IOMUXC_SD1_DATA4_USDHC1_DATA4		0x0d0
> +			MX8MN_IOMUXC_SD1_DATA5_USDHC1_DATA5		0x0d0
> +			MX8MN_IOMUXC_SD1_DATA6_USDHC1_DATA6		0x0d0
> +			MX8MN_IOMUXC_SD1_DATA7_USDHC1_DATA7		0x0d0
> +			MX8MN_IOMUXC_SD1_STROBE_USDHC1_STROBE		0x090
> +		>;
> +	};
> +
> +	pinctrl_usdhc1_100mhz: usdhc1grp100mhz {
> +		fsl,pins = <
> +			MX8MN_IOMUXC_SD1_CLK_USDHC1_CLK			0x40000094
> +			MX8MN_IOMUXC_SD1_CMD_USDHC1_CMD			0x0d4
> +			MX8MN_IOMUXC_SD1_DATA0_USDHC1_DATA0		0x0d4
> +			MX8MN_IOMUXC_SD1_DATA1_USDHC1_DATA1		0x0d4
> +			MX8MN_IOMUXC_SD1_DATA2_USDHC1_DATA2		0x0d4
> +			MX8MN_IOMUXC_SD1_DATA3_USDHC1_DATA3		0x0d4
> +			MX8MN_IOMUXC_SD1_DATA4_USDHC1_DATA4		0x0d4
> +			MX8MN_IOMUXC_SD1_DATA5_USDHC1_DATA5		0x0d4
> +			MX8MN_IOMUXC_SD1_DATA6_USDHC1_DATA6		0x0d4
> +			MX8MN_IOMUXC_SD1_DATA7_USDHC1_DATA7		0x0d4
> +			MX8MN_IOMUXC_SD1_STROBE_USDHC1_STROBE		0x094
> +		>;
> +	};
> +
> +	pinctrl_usdhc1_200mhz: usdhc1grp200mhz {
> +		fsl,pins = <
> +			MX8MN_IOMUXC_SD1_CLK_USDHC1_CLK			0x40000096
> +			MX8MN_IOMUXC_SD1_CMD_USDHC1_CMD			0x0d6
> +			MX8MN_IOMUXC_SD1_DATA0_USDHC1_DATA0		0x0d6
> +			MX8MN_IOMUXC_SD1_DATA1_USDHC1_DATA1		0x0d6
> +			MX8MN_IOMUXC_SD1_DATA2_USDHC1_DATA2		0x0d6
> +			MX8MN_IOMUXC_SD1_DATA3_USDHC1_DATA3		0x0d6
> +			MX8MN_IOMUXC_SD1_DATA4_USDHC1_DATA4		0x0d6
> +			MX8MN_IOMUXC_SD1_DATA5_USDHC1_DATA5		0x0d6
> +			MX8MN_IOMUXC_SD1_DATA6_USDHC1_DATA6		0x0d6
> +			MX8MN_IOMUXC_SD1_DATA7_USDHC1_DATA7		0x0d6
> +			MX8MN_IOMUXC_SD1_STROBE_USDHC1_STROBE		0x096
> +		>;
> +	};
> +};
> -- 
> 2.30.2
> 
