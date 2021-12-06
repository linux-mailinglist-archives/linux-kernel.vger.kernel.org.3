Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70013468F68
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 03:49:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235166AbhLFCxS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 21:53:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbhLFCxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 21:53:17 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F07AC0613F8;
        Sun,  5 Dec 2021 18:49:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 885CCB80EF9;
        Mon,  6 Dec 2021 02:49:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0F97C00446;
        Mon,  6 Dec 2021 02:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638758986;
        bh=I1ufE0O/P6/FqJHy8w79hHDEWQCSvfYzaDczoLanhDY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RjGyh04dgTy9Abr4OVieUhGHXEjX3TdjzWCSoX+qCwnLpkt7Ch71q7Z3NLcF5i2yE
         gBmj34CPtrfO4CAFrvp4KYvLQsnaBYretCdKF57pjq/FdxCUQUi7Eb4Pso1jkN4YFD
         k89H6wt43//5gCLDp1xIFjvwZKIYDEfxSrJUdH+F1XWkt6MR1ojRMytn7o7T7cbsC8
         pRy7Fyrar9TJSRuFIQvPLfzfLTwGVdf2cyn23VTl2OJqLVWsqZj99AQDRXJx8yUM63
         uYLNz8lrtUV3KpxPuSQ3ydgb1hxhf2j67HfDTzMY/XQUStu+Q+e/PZoFr+g44bTSvB
         nfCwVv+4HAkrw==
Date:   Mon, 6 Dec 2021 10:49:40 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Yunus Bas <y.bas@phytec.de>
Cc:     robh+dt@kernel.org, s.hauer@pengutronix.de,
        devicetree@vger.kernel.org, kernel@pengutronix.de,
        festevam@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] ARM: dts: imx6qdl: phytec: Add support for optional
 PEB-AV-02 LCD adapter
Message-ID: <20211206024939.GX4216@dragon>
References: <20211130085355.2291607-1-y.bas@phytec.de>
 <20211130085355.2291607-2-y.bas@phytec.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211130085355.2291607-2-y.bas@phytec.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 30, 2021 at 09:53:54AM +0100, Yunus Bas wrote:
> The PEB-AV-02 expansion adapter extends the phyBOARD-Mira boards to
> connect parallel LCD displays, either with capacitive or resistive
> touch.
> 
> Signed-off-by: Yunus Bas <y.bas@phytec.de>
> ---
>  .../boot/dts/imx6dl-phytec-mira-rdk-nand.dts  |   1 +
>  .../boot/dts/imx6q-phytec-mira-rdk-emmc.dts   |   1 +
>  .../boot/dts/imx6q-phytec-mira-rdk-nand.dts   |   1 +
>  .../dts/imx6qdl-phytec-mira-peb-av-02.dtsi    | 122 ++++++++++++++++++
>  .../boot/dts/imx6qp-phytec-mira-rdk-nand.dts  |   1 +
>  5 files changed, 126 insertions(+)
>  create mode 100644 arch/arm/boot/dts/imx6qdl-phytec-mira-peb-av-02.dtsi
> 
> diff --git a/arch/arm/boot/dts/imx6dl-phytec-mira-rdk-nand.dts b/arch/arm/boot/dts/imx6dl-phytec-mira-rdk-nand.dts
> index b057fa664a6b..8165fae2b1d1 100644
> --- a/arch/arm/boot/dts/imx6dl-phytec-mira-rdk-nand.dts
> +++ b/arch/arm/boot/dts/imx6dl-phytec-mira-rdk-nand.dts
> @@ -9,6 +9,7 @@
>  #include "imx6qdl-phytec-phycore-som.dtsi"
>  #include "imx6qdl-phytec-mira.dtsi"
>  #include "imx6qdl-phytec-mira-peb-eval-01.dtsi"
> +#include "imx6qdl-phytec-mira-peb-av-02.dtsi"
>  
>  / {
>  	model = "PHYTEC phyBOARD-Mira DualLite/Solo Carrier-Board with NAND";
> diff --git a/arch/arm/boot/dts/imx6q-phytec-mira-rdk-emmc.dts b/arch/arm/boot/dts/imx6q-phytec-mira-rdk-emmc.dts
> index db6e2cc36759..bbf5097ca974 100644
> --- a/arch/arm/boot/dts/imx6q-phytec-mira-rdk-emmc.dts
> +++ b/arch/arm/boot/dts/imx6q-phytec-mira-rdk-emmc.dts
> @@ -9,6 +9,7 @@
>  #include "imx6qdl-phytec-phycore-som.dtsi"
>  #include "imx6qdl-phytec-mira.dtsi"
>  #include "imx6qdl-phytec-mira-peb-eval-01.dtsi"
> +#include "imx6qdl-phytec-mira-peb-av-02.dtsi"
>  
>  / {
>  	model = "PHYTEC phyBOARD-Mira Quad Carrier-Board with eMMC";
> diff --git a/arch/arm/boot/dts/imx6q-phytec-mira-rdk-nand.dts b/arch/arm/boot/dts/imx6q-phytec-mira-rdk-nand.dts
> index 51ff601b1aec..95051e18324f 100644
> --- a/arch/arm/boot/dts/imx6q-phytec-mira-rdk-nand.dts
> +++ b/arch/arm/boot/dts/imx6q-phytec-mira-rdk-nand.dts
> @@ -9,6 +9,7 @@
>  #include "imx6qdl-phytec-phycore-som.dtsi"
>  #include "imx6qdl-phytec-mira.dtsi"
>  #include "imx6qdl-phytec-mira-peb-eval-01.dtsi"
> +#include "imx6qdl-phytec-mira-peb-av-02.dtsi"
>  
>  / {
>  	model = "PHYTEC phyBOARD-Mira Quad Carrier-Board with NAND";
> diff --git a/arch/arm/boot/dts/imx6qdl-phytec-mira-peb-av-02.dtsi b/arch/arm/boot/dts/imx6qdl-phytec-mira-peb-av-02.dtsi
> new file mode 100644
> index 000000000000..671e8024cba5
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx6qdl-phytec-mira-peb-av-02.dtsi
> @@ -0,0 +1,122 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (C) 2018 PHYTEC Messtechnik
> + * Author: Christian Hemp <c.hemp@phytec.de>
> + */
> +
> +/ {
> +
> +	display: display@di0 {

di0 being unit-address?

> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		compatible = "fsl,imx-parallel-display";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_disp0>;
> +		interface-pix-fmt = "rgb24";
> +		status = "disabled";
> +
> +		port@0 {
> +			reg = <0>;
> +
> +			display0_in: endpoint {
> +				remote-endpoint = <&ipu1_di0_disp0>;
> +			};
> +		};
> +
> +		port@1 {
> +			reg = <1>;
> +
> +			display0_out: endpoint {
> +				remote-endpoint = <&peb_panel_lcd_in>;
> +			};
> +		};
> +	};
> +
> +	panel-lcd {
> +		compatible = "edt,etm0700g0edh6";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_disp0_pwr>;
> +		power-supply = <&reg_display>;
> +		enable-gpios = <&gpio3 22 GPIO_ACTIVE_HIGH>;
> +		backlight = <&backlight>;
> +		status = "disabled";
> +
> +		port {
> +			peb_panel_lcd_in: endpoint {
> +				remote-endpoint = <&display0_out>;
> +			};
> +		};
> +	};
> +
> +	reg_display: regulator-peb-display {
> +		compatible = "regulator-fixed";
> +		regulator-name = "peb-display";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +	};
> +};
> +
> +&i2c1 {
> +	edt_ft5x06: touchscreen@38 {
> +		compatible = "edt,edt-ft5406", "edt,edt-ft5x06";

Did you run make dtbs_check against bindings?

 Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.yaml

> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_edt_ft5x06>;
> +		reg = <0x38>;
> +		interrupt-parent = <&gpio3>;
> +		interrupts = <2 IRQ_TYPE_NONE>;
> +		status = "disabled";
> +        };
> +};
> +
> +&ipu1_di0_disp0 {
> +	remote-endpoint = <&display0_in>;
> +};
> +
> +&iomuxc {
> +	pinctrl_disp0: disp0grp {
> +		fsl,pins = <
> +			MX6QDL_PAD_DI0_DISP_CLK__IPU1_DI0_DISP_CLK	0x10
> +			MX6QDL_PAD_DI0_PIN2__IPU1_DI0_PIN02		0x10
> +			MX6QDL_PAD_DI0_PIN3__IPU1_DI0_PIN03		0x10
> +

Drop the newline.

> +			MX6QDL_PAD_DI0_PIN15__IPU1_DI0_PIN15		0x1b080
> +

Ditto

Shawn

> +			MX6QDL_PAD_DISP0_DAT0__IPU1_DISP0_DATA00	0x10
> +			MX6QDL_PAD_DISP0_DAT1__IPU1_DISP0_DATA01	0x10
> +			MX6QDL_PAD_DISP0_DAT2__IPU1_DISP0_DATA02	0x10
> +			MX6QDL_PAD_DISP0_DAT3__IPU1_DISP0_DATA03	0x10
> +			MX6QDL_PAD_DISP0_DAT4__IPU1_DISP0_DATA04	0x10
> +			MX6QDL_PAD_DISP0_DAT5__IPU1_DISP0_DATA05	0x10
> +			MX6QDL_PAD_DISP0_DAT6__IPU1_DISP0_DATA06	0x10
> +			MX6QDL_PAD_DISP0_DAT7__IPU1_DISP0_DATA07	0x10
> +			MX6QDL_PAD_DISP0_DAT8__IPU1_DISP0_DATA08	0x10
> +			MX6QDL_PAD_DISP0_DAT9__IPU1_DISP0_DATA09	0x10
> +			MX6QDL_PAD_DISP0_DAT10__IPU1_DISP0_DATA10	0x10
> +			MX6QDL_PAD_DISP0_DAT11__IPU1_DISP0_DATA11	0x10
> +			MX6QDL_PAD_DISP0_DAT12__IPU1_DISP0_DATA12	0x10
> +			MX6QDL_PAD_DISP0_DAT13__IPU1_DISP0_DATA13	0x10
> +			MX6QDL_PAD_DISP0_DAT14__IPU1_DISP0_DATA14	0x10
> +			MX6QDL_PAD_DISP0_DAT15__IPU1_DISP0_DATA15	0x10
> +			MX6QDL_PAD_DISP0_DAT16__IPU1_DISP0_DATA16	0x10
> +			MX6QDL_PAD_DISP0_DAT17__IPU1_DISP0_DATA17	0x10
> +			MX6QDL_PAD_DISP0_DAT18__IPU1_DISP0_DATA18	0x10
> +			MX6QDL_PAD_DISP0_DAT19__IPU1_DISP0_DATA19	0x10
> +			MX6QDL_PAD_DISP0_DAT20__IPU1_DISP0_DATA20	0x10
> +			MX6QDL_PAD_DISP0_DAT21__IPU1_DISP0_DATA21	0x10
> +			MX6QDL_PAD_DISP0_DAT22__IPU1_DISP0_DATA22	0x10
> +			MX6QDL_PAD_DISP0_DAT23__IPU1_DISP0_DATA23	0x10
> +		>;
> +	};
> +
> +	pinctrl_disp0_pwr: disp0pwrgrp {
> +		fsl,pins = <
> +			MX6QDL_PAD_EIM_D22__GPIO3_IO22			0x1b0b0
> +		>;
> +	};
> +
> +	pinctrl_edt_ft5x06: edtft5x06grp {
> +		fsl,pins = <
> +			MX6QDL_PAD_EIM_DA2__GPIO3_IO02			0xb0b1
> +		>;
> +	};
> +};
> diff --git a/arch/arm/boot/dts/imx6qp-phytec-mira-rdk-nand.dts b/arch/arm/boot/dts/imx6qp-phytec-mira-rdk-nand.dts
> index 06fe0c5315fc..343639cb035c 100644
> --- a/arch/arm/boot/dts/imx6qp-phytec-mira-rdk-nand.dts
> +++ b/arch/arm/boot/dts/imx6qp-phytec-mira-rdk-nand.dts
> @@ -9,6 +9,7 @@
>  #include "imx6qdl-phytec-phycore-som.dtsi"
>  #include "imx6qdl-phytec-mira.dtsi"
>  #include "imx6qdl-phytec-mira-peb-eval-01.dtsi"
> +#include "imx6qdl-phytec-mira-peb-av-02.dtsi"
>  
>  / {
>  	model = "PHYTEC phyBOARD-Mira QuadPlus Carrier-Board with NAND";
> -- 
> 2.25.1
> 
