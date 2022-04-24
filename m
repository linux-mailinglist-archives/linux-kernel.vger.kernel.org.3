Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7F3250D1AB
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 14:22:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbiDXMY6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 08:24:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiDXMYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 08:24:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DCB583027;
        Sun, 24 Apr 2022 05:21:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 27B5960BCC;
        Sun, 24 Apr 2022 12:21:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AF15C385A7;
        Sun, 24 Apr 2022 12:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650802912;
        bh=7gxSeZgXvqRRvnnSUkmJGvEn/og1qUqiGqYeb8JB/88=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mLwToT0lqx6T0v62ep7KgVH2GPfp6ZUeZZt7ndYD9BiQURVjfFxHgY6XAv77UHN5m
         ArfUdSWWRuTS4imxVvOK6FuU9f5+Vu3Jk9S/ugIEZa8vHQ5kYXkjfEQfa324wZBmVR
         LeNStAxO2Dc7JJY9ncwRaeHCliBV2H3pKHRArcK+XMRV3viYUypcPiUJz2jpZKOaL/
         XQH4cvG4xGjVEWBcELNBWcTjyveXhrgehyd3ec6hUg8Fbb2Gjw9Czt/3Ca5ZtNCq7K
         jY96ohkNhfb5m+loZZ9Y9PiYKHIZT9ak6n2vpjxW5exlzxbDrunPCqQQW9btCy5ODd
         Z6uJNsA+QdQVg==
Date:   Sun, 24 Apr 2022 20:21:44 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Manoj Sai <abbaraju.manojsai@amarulasolutions.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Matteo Lisi <matteo.lisi@engicam.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Rob Herring <robh@kernel.org>,
        Suniel Mahesh <sunil@amarulasolutions.com>,
        Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Subject: Re: [PATCH v2 2/3] arm64: dts: imx8mp: Add Engicam i.Core MX8M Plus
 SoM
Message-ID: <20220424122144.GS391514@dragon>
References: <20220330191437.614065-2-abbaraju.manojsai@amarulasolutions.com>
 <20220418144907.327511-1-abbaraju.manojsai@amarulasolutions.com>
 <20220418144907.327511-2-abbaraju.manojsai@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220418144907.327511-2-abbaraju.manojsai@amarulasolutions.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 18, 2022 at 08:19:06PM +0530, Manoj Sai wrote:
> i.Core MX8M Plus is an EDIMM SoM based on NXP i.MX8M Plus
> from Engicam.
> 
> General features:
> - NXP i.MX8M Plus
> - Up to 4GB LDDR4
> - 8 eMMC
> - Gigabit Ethernet
> - USB 3.0, 2.0 Host/OTG
> - PCIe 3.0 interface
> - I2S
> - LVDS
> - rest of i.MX8M Plus features
> 
> i.Core MX8M Plus needs to mount on top of Engicam baseboards
> for creating complete platform solutions.
> 
> Add support for it.
> 
> Signed-off-by: Manoj Sai <abbaraju.manojsai@amarulasolutions.com>
> Signed-off-by: Matteo Lisi <matteo.lisi@engicam.com>
> Reviewed-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
> Changes for v2 :
>  -corrected the naming convetion of nodes as per existing
>   sources and bindings
>  -added the iomux to the end as per nxp convention.
> ---
>  .../dts/freescale/imx8mp-icore-mx8mp.dtsi     | 184 ++++++++++++++++++
>  1 file changed, 184 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-icore-mx8mp.dtsi
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp-icore-mx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-icore-mx8mp.dtsi
> new file mode 100644
> index 000000000000..8f6e8ef4b009
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx8mp-icore-mx8mp.dtsi
> @@ -0,0 +1,184 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (c) 2018 NXP
> + * Copyright (c) 2019 Engicam srl
> + * Copyright (c) 2020 Amarula Solutons(India)
> + */
> +
> +/ {
> +	compatible = "engicam,icore-mx8mp", "fsl,imx8mp";
> +};
> +
> +&A53_0 {
> +	cpu-supply = <&buck2>;
> +};
> +
> +&A53_1 {
> +	cpu-supply = <&buck2>;
> +};
> +
> +&A53_2 {
> +	cpu-supply = <&buck2>;
> +};
> +
> +&A53_3 {
> +	cpu-supply = <&buck2>;
> +};
> +
> +&i2c1 {
> +	clock-frequency = <100000>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_i2c1>;
> +	status = "okay";

Please have a newline between properties and child node.

> +	pmic@25 {
> +		compatible = "nxp,pca9450c";
> +		reg = <0x25>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_pmic>;
> +		interrupt-parent = <&gpio3>;
> +		interrupts = <1 IRQ_TYPE_LEVEL_LOW>;

Ditto

Shawn

> +		regulators {
> +			buck1: BUCK1 {
> +				regulator-name = "BUCK1";
> +				regulator-min-microvolt = <720000>;
> +				regulator-max-microvolt = <1000000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +				regulator-ramp-delay = <3125>;
> +			};
> +
> +			buck2: BUCK2  {
> +				regulator-name = "BUCK2";
> +				regulator-min-microvolt = <720000>;
> +				regulator-max-microvolt = <1025000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +				regulator-ramp-delay = <3125>;
> +				nxp,dvs-run-voltage = <950000>;
> +				nxp,dvs-standby-voltage = <850000>;
> +			};
> +
> +			buck4: BUCK4 {
> +				regulator-name = "BUCK4";
> +				regulator-min-microvolt = <3000000>;
> +				regulator-max-microvolt = <3600000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			buck5: BUCK5 {
> +				regulator-name = "BUCK5";
> +				regulator-min-microvolt = <1650000>;
> +				regulator-max-microvolt = <1950000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			buck6: BUCK6 {
> +				regulator-name = "BUCK6";
> +				regulator-min-microvolt = <1045000>;
> +				regulator-max-microvolt = <1155000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			ldo1: LDO1 {
> +				regulator-name = "LDO1";
> +				regulator-min-microvolt = <1650000>;
> +				regulator-max-microvolt = <1950000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			ldo3: LDO3 {
> +				regulator-name = "LDO3";
> +				regulator-min-microvolt = <1710000>;
> +				regulator-max-microvolt = <1890000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			ldo5: LDO5 {
> +				regulator-name = "LDO5";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +		};
> +	};
> +};
> +
> +/* EMMC */
> +&usdhc3 {
> +	pinctrl-names = "default", "state_100mhz", "state_200mhz";
> +	pinctrl-0 = <&pinctrl_usdhc3>;
> +	pinctrl-1 = <&pinctrl_usdhc3_100mhz>;
> +	pinctrl-2 = <&pinctrl_usdhc3_200mhz>;
> +	bus-width = <8>;
> +	non-removable;
> +	status = "okay";
> +};
> +
> +&iomuxc {
> +	pinctrl_i2c1: i2c1grp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_I2C1_SCL__I2C1_SCL		0x400001c3
> +			MX8MP_IOMUXC_I2C1_SDA__I2C1_SDA		0x400001c3
> +		>;
> +	};
> +
> +	pinctrl_pmic: pmicgrp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_NAND_CE0_B__GPIO3_IO01	  0x41
> +		>;
> +	};
> +
> +	pinctrl_usdhc3: usdhc3grp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_NAND_WE_B__USDHC3_CLK	0x190
> +			MX8MP_IOMUXC_NAND_WP_B__USDHC3_CMD	0x1d0
> +			MX8MP_IOMUXC_NAND_DATA04__USDHC3_DATA0	0x1d0
> +			MX8MP_IOMUXC_NAND_DATA05__USDHC3_DATA1	0x1d0
> +			MX8MP_IOMUXC_NAND_DATA06__USDHC3_DATA2	0x1d0
> +			MX8MP_IOMUXC_NAND_DATA07__USDHC3_DATA3	0x1d0
> +			MX8MP_IOMUXC_NAND_RE_B__USDHC3_DATA4	0x1d0
> +			MX8MP_IOMUXC_NAND_CE2_B__USDHC3_DATA5	0x1d0
> +			MX8MP_IOMUXC_NAND_CE3_B__USDHC3_DATA6	0x1d0
> +			MX8MP_IOMUXC_NAND_CLE__USDHC3_DATA7	0x1d0
> +			MX8MP_IOMUXC_NAND_CE1_B__USDHC3_STROBE	0x190
> +		>;
> +	};
> +
> +	pinctrl_usdhc3_100mhz: usdhc3-100mhzgrp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_NAND_WE_B__USDHC3_CLK	0x194
> +			MX8MP_IOMUXC_NAND_WP_B__USDHC3_CMD	0x1d4
> +			MX8MP_IOMUXC_NAND_DATA04__USDHC3_DATA0	0x1d4
> +			MX8MP_IOMUXC_NAND_DATA05__USDHC3_DATA1	0x1d4
> +			MX8MP_IOMUXC_NAND_DATA06__USDHC3_DATA2	0x1d4
> +			MX8MP_IOMUXC_NAND_DATA07__USDHC3_DATA3	0x1d4
> +			MX8MP_IOMUXC_NAND_RE_B__USDHC3_DATA4	0x1d4
> +			MX8MP_IOMUXC_NAND_CE2_B__USDHC3_DATA5	0x1d4
> +			MX8MP_IOMUXC_NAND_CE3_B__USDHC3_DATA6	0x1d4
> +			MX8MP_IOMUXC_NAND_CLE__USDHC3_DATA7	0x1d4
> +			MX8MP_IOMUXC_NAND_CE1_B__USDHC3_STROBE	0x194
> +		>;
> +	};
> +
> +	pinctrl_usdhc3_200mhz: usdhc3-200mhzgrp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_NAND_WE_B__USDHC3_CLK	0x196
> +			MX8MP_IOMUXC_NAND_WP_B__USDHC3_CMD	0x1d6
> +			MX8MP_IOMUXC_NAND_DATA04__USDHC3_DATA0	0x1d6
> +			MX8MP_IOMUXC_NAND_DATA05__USDHC3_DATA1	0x1d6
> +			MX8MP_IOMUXC_NAND_DATA06__USDHC3_DATA2	0x1d6
> +			MX8MP_IOMUXC_NAND_DATA07__USDHC3_DATA3	0x1d6
> +			MX8MP_IOMUXC_NAND_RE_B__USDHC3_DATA4	0x1d6
> +			MX8MP_IOMUXC_NAND_CE2_B__USDHC3_DATA5	0x1d6
> +			MX8MP_IOMUXC_NAND_CE3_B__USDHC3_DATA6	0x1d6
> +			MX8MP_IOMUXC_NAND_CLE__USDHC3_DATA7	0x1d6
> +			MX8MP_IOMUXC_NAND_CE1_B__USDHC3_STROBE	0x196
> +		>;
> +	};
> +};
> -- 
> 2.25.1
> 
