Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 182374E6B01
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 00:06:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355632AbiCXXIR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 19:08:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244602AbiCXXIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 19:08:12 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D528BB097;
        Thu, 24 Mar 2022 16:06:40 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 4CFFD59E;
        Fri, 25 Mar 2022 00:06:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1648163198;
        bh=uRMNGi9N9TZ31uYqlClvaUFRo+8SOHgL8YuapfxJDv0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i8bbDASxYs0UGXWmg23jAOZiH6KLOXG71WI7KDGsR7vEbo2E8mZk+GsDTxtX+pt6G
         o4PqRbiIqkzcAkB8zhEmitvlBEGUqCWwCURmBMsv+u9qaHDZTHlLSZnavVo1RtgRTw
         8fwj9/WZAhdHwqQcupYcwWeFLEovZR4z8xtUKoxk=
Date:   Fri, 25 Mar 2022 01:06:36 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Marcel Ziswiler <marcel@ziswiler.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Alex Marginean <alexandru.marginean@nxp.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Frank Rowand <frowand.list@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Olof Johansson <olof@lixom.net>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Reinhold Mueller <reinhold.mueller@emtrion.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Tim Harvey <tharvey@gateworks.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] arm64: dts: freescale: add initial support for
 verdin imx8m plus
Message-ID: <Yjz5fBwxhr0aBNsU@pendragon.ideasonboard.com>
References: <20220323143600.170778-1-marcel@ziswiler.com>
 <20220323143600.170778-4-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220323143600.170778-4-marcel@ziswiler.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcel,

A couple more comments.

On Wed, Mar 23, 2022 at 03:36:00PM +0100, Marcel Ziswiler wrote:
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
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Tested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> 
> ---
> 
> Changes in v2:
> - Fix capitatlisation of verdin in comments as reported by Laurent.
> - Add/modify todo comments as suggested by Laurent.
> - Add Laurent's reviewed- and tested-by tags.
> 
>  arch/arm64/boot/dts/freescale/Makefile        |    4 +
>  .../dts/freescale/imx8mp-verdin-dahlia.dtsi   |  129 ++
>  .../boot/dts/freescale/imx8mp-verdin-dev.dtsi |   44 +
>  .../imx8mp-verdin-nonwifi-dahlia.dts          |   18 +
>  .../freescale/imx8mp-verdin-nonwifi-dev.dts   |   18 +
>  .../dts/freescale/imx8mp-verdin-nonwifi.dtsi  |   54 +
>  .../freescale/imx8mp-verdin-wifi-dahlia.dts   |   18 +
>  .../dts/freescale/imx8mp-verdin-wifi-dev.dts  |   18 +
>  .../dts/freescale/imx8mp-verdin-wifi.dtsi     |   82 +
>  .../boot/dts/freescale/imx8mp-verdin.dtsi     | 1373 +++++++++++++++++
>  10 files changed, 1758 insertions(+)
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

> diff --git a/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi
> new file mode 100644
> index 000000000000..8cad1d865720
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi
> @@ -0,0 +1,1373 @@

[snip]

> +/* Verdin I2C_2_DSI */
> +&i2c2 {
> +	clock-frequency = <10000>;

Did you really mean 10kHz here, not 100kHz ?

> +	pinctrl-names = "default", "gpio";
> +	pinctrl-0 = <&pinctrl_i2c2>;
> +	pinctrl-1 = <&pinctrl_i2c2_gpio>;

Shouldn't you also specify scl-gpios and sda-gpios, like for the other
I2C buses ?

> +
> +	atmel_mxt_ts_mezzanine: touch-mezzanine@4a {
> +		compatible = "atmel,maxtouch";
> +		/* Verdin GPIO_3 (SODIMM 210) */
> +		interrupt-parent = <&gpio1>;
> +		interrupts = <5 IRQ_TYPE_EDGE_FALLING>;
> +		reg = <0x4a>;
> +		/* Verdin GPIO_2 (SODIMM 208) */
> +		reset-gpios = <&gpio1 1 GPIO_ACTIVE_HIGH>;
> +		status = "disabled";
> +	};
> +};

[snip]

-- 
Regards,

Laurent Pinchart
