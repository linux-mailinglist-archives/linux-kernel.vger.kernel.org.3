Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2412D4E4978
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 00:03:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238718AbiCVXEh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 19:04:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbiCVXEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 19:04:35 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D52813E01;
        Tue, 22 Mar 2022 16:03:05 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 6FEB06F3;
        Wed, 23 Mar 2022 00:03:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1647990183;
        bh=kZZ9bNz45LQ42/X+9rsybz3mUPSLrdhkzdo9QoUWPBM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=As0ijnSxkrHjyraydS/Kgachh4nDbPY7bYDhl+sq9djRCzeEhfUy9Azq1SUHTXQmt
         eA5KnJw8jj02TqZ4UwFEjKS1Cq3FpgpSwhu8T71DEuosgJIziGKDaWzuNUlLthVYeE
         czXcIR7tD636B7n4AWW45fjFxVekGjtG/b0yALYY=
Date:   Wed, 23 Mar 2022 01:02:46 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Marcel Ziswiler <marcel@ziswiler.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Alex Marginean <alexandru.marginean@nxp.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Fabio Estevam <festevam@gmail.com>,
        Frank Rowand <frowand.list@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Olof Johansson <olof@lixom.net>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Reinhold Mueller <reinhold.mueller@emtrion.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Tim Harvey <tharvey@gateworks.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 3/3] arm64: dts: freescale: add initial support for
 verdin imx8m plus
Message-ID: <YjpVlmEGewIGE3WR@pendragon.ideasonboard.com>
References: <20220317160122.341484-1-marcel@ziswiler.com>
 <20220317160122.341484-4-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220317160122.341484-4-marcel@ziswiler.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcel,

Thank you for the patch.

On Thu, Mar 17, 2022 at 05:01:22PM +0100, Marcel Ziswiler wrote:
> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> This patch adds the device tree to support Toradex Verdin iMX8M Plus [1]
> a computer on module which can be used on different carrier boards.
> 
> The module consists of an NXP i.MX 8M Plus family SoC (either i.MX 8M
> Plus Quad or 8M Plus QuadLite), a PCA9450C PMIC, a Gigabit Ethernet PHY,
> 1, 2, 4 or 8 GB of LPDDR4 RAM, an eMMC, a TLA2024 ADC, an I2C EEPROM, an
> RX8130 RTC, an optional I2C temperature sensor plus an optional
> Bluetooth/Wi-Fi module.
> 
> Anything that is not self-contained on the module is disabled by
> default.
> 
> The device tree for the Dahlia includes the module's device tree and
> enables the supported peripherals of the carrier board.
> 
> The device tree for the Verdin Development Board includes the module's
> device tree as well as the Dahlia one as it is a superset and supports
> almost all peripherals available.
> 
> So far there is no display functionality supported at all but basic
> console UART, USB host, eMMC and Ethernet functionality work fine.
> 
> [1] https://www.toradex.com/computer-on-modules/verdin-arm-family/nxp-imx-8m-plus
> 
> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> ---
> 
>  arch/arm64/boot/dts/freescale/Makefile        |    4 +
>  .../dts/freescale/imx8mp-verdin-dahlia.dtsi   |  125 ++
>  .../boot/dts/freescale/imx8mp-verdin-dev.dtsi |   44 +
>  .../imx8mp-verdin-nonwifi-dahlia.dts          |   18 +
>  .../freescale/imx8mp-verdin-nonwifi-dev.dts   |   18 +
>  .../dts/freescale/imx8mp-verdin-nonwifi.dtsi  |   54 +
>  .../freescale/imx8mp-verdin-wifi-dahlia.dts   |   18 +
>  .../dts/freescale/imx8mp-verdin-wifi-dev.dts  |   18 +
>  .../dts/freescale/imx8mp-verdin-wifi.dtsi     |   82 +
>  .../boot/dts/freescale/imx8mp-verdin.dtsi     | 1373 +++++++++++++++++
>  10 files changed, 1754 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-verdin-dahlia.dtsi
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-verdin-dev.dtsi
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-verdin-nonwifi-dahlia.dts
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-verdin-nonwifi-dev.dts
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-verdin-nonwifi.dtsi
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-verdin-wifi-dahlia.dts
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-verdin-wifi-dev.dts
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-verdin-wifi.dtsi
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi

[snip]

> diff --git a/arch/arm64/boot/dts/freescale/imx8mp-verdin-dahlia.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-verdin-dahlia.dtsi
> new file mode 100644
> index 000000000000..103d97a3b029
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx8mp-verdin-dahlia.dtsi
> @@ -0,0 +1,125 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
> +/*
> + * Copyright 2022 Toradex
> + */
> +
> +&backlight {
> +	power-supply = <&reg_3p3v>;
> +};
> +
> +/* Verdin SPI_1 */
> +&ecspi1 {
> +	status = "okay";
> +};
> +
> +/* EEPROM on display adapter boards */
> +&eeprom_display_adapter {
> +	status = "okay";
> +};
> +
> +/* EEPROM on Verdin Development board */
> +&eeprom_carrier_board {
> +	status = "okay";
> +};
> +
> +&eqos {
> +	status = "okay";
> +};
> +
> +&flexcan1 {
> +	status = "okay";
> +};
> +
> +&flexcan2 {
> +	status = "okay";
> +};
> +
> +/* Verdin QSPI_1 */
> +&flexspi {
> +	status = "okay";
> +};
> +
> +/* Current measurement into module VCC */
> +&hwmon {
> +	status = "okay";
> +};
> +
> +&hwmon_temp {
> +	vs-supply = <&reg_1p8v>;
> +	status = "okay";
> +};
> +
> +/* Verdin I2C_2_DSI */
> +&i2c2 {
> +	status = "okay";
> +};
> +
> +&i2c3 {
> +	status = "okay";
> +};
> +
> +/* Verdin I2C_1 */
> +&i2c4 {
> +	status = "okay";
> +};
> +
> +/* Verdin PCIE_1 */

Is this comment needed ? Is it a placeholder for future PCIe support ?
If so I'd write

/* TODO: Verdin PCIE_1 */

> +
> +/* Verdin PWM_1 */
> +&pwm1 {
> +	status = "okay";
> +};
> +
> +/* Verdin PWM_2 */
> +&pwm2 {
> +	status = "okay";
> +};
> +
> +/* Verdin PWM_3_DSI */
> +&pwm3 {
> +	status = "okay";
> +};
> +
> +&reg_usdhc2_vmmc {
> +	vin-supply = <&reg_3p3v>;
> +};
> +
> +/* VERDIN I2S_1 */

Same here. By the way, you may want to standardize on Verdin or VERDIN
and not mix both. These comments apply to the other files too.

> +
> +/* Verdin UART_1 */
> +&uart1 {
> +	status = "okay";
> +};
> +
> +/* Verdin UART_2 */
> +&uart2 {
> +	status = "okay";
> +};
> +
> +/* Verdin UART_3, used as the Linux Console */
> +&uart3 {
> +	status = "okay";
> +};
> +
> +/* Verdin USB_1 */
> +&usb3_0 {
> +	status = "okay";
> +};
> +
> +&usb3_phy0 {
> +	status = "okay";
> +};
> +
> +/* Verdin USB_2 */
> +&usb3_1 {
> +	status = "okay";
> +};
> +
> +&usb3_phy1 {
> +	status = "okay";
> +};
> +
> +/* Verdin SD_1 */
> +&usdhc2 {
> +	status = "okay";
> +};

[snip]

> diff --git a/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi
> new file mode 100644
> index 000000000000..26d6c2819ee8
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi
> @@ -0,0 +1,1373 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
> +/*
> + * Copyright 2022 Toradex
> + */
> +
> +#include "dt-bindings/pwm/pwm.h"
> +#include "imx8mp.dtsi"
> +
> +/ {
> +	chosen {
> +		stdout-path = &uart3;
> +	};
> +
> +	aliases {
> +		/* Ethernet aliases to ensure correct MAC addresses */
> +		ethernet0 = &eqos;
> +		ethernet1 = &fec;

On Dahlia the ethernet connector is routed to the eqos if I'm not
mistaken. On my board U-Boot considers this to be the second ethernet
controller, with the fec being the first one. The mismatch results in
the MAC addresses being swapped between eth0 and eth1 when comparing
U-Boot and Linux. Am I using a too old boot loader, or should the two
ethernet controlls be swapped here ?

> +		rtc0 = &rtc_i2c;
> +		rtc1 = &snvs_rtc;
> +	};

[snip]

With these issues addressed,

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Tested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

-- 
Regards,

Laurent Pinchart
