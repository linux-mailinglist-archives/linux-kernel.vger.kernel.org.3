Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 102B8468F4D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 03:44:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234866AbhLFCsK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 21:48:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234737AbhLFCsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 21:48:08 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E64C0C0611F7;
        Sun,  5 Dec 2021 18:44:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5B69661183;
        Mon,  6 Dec 2021 02:44:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B9F7C00446;
        Mon,  6 Dec 2021 02:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638758679;
        bh=phOWGYnBOShD7CuRvwbxOYc1Uf4/NoO+KoCPBeRcF4Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T2yUZDuqVGv7AXxP2T3FEgADYfzrAaMlkcK+RoxtK4j2Kr/KfTbhKMWKFUlC/9KoS
         ln9b46x33dn+HVpkwhczqqM669CYilCZ1DaeBrTDdwCOforSgDVy4Iym3ajtu88dIP
         FOkXDuxwFD2l4OhHJRRqBpnT/CntuyQwZUpSSFzpQ2+6BsD4iA6MwOj8gWRuchmOVT
         jwNIOrMNdT5iCbN7tlhV9HwRifpZ0VknXRDAoGwYHeBMHxcMNi4A7rHVPWz8gQqNBJ
         SpUSseWHw1cangSnq+ZIMmN2WJ/hPbl9AGL4pDRCM7NnHdhlYkDVscroc+qyTsHxHR
         s6q6dgFrMjlFQ==
Date:   Mon, 6 Dec 2021 10:44:34 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Yunus Bas <y.bas@phytec.de>
Cc:     robh+dt@kernel.org, s.hauer@pengutronix.de,
        devicetree@vger.kernel.org, kernel@pengutronix.de,
        festevam@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] ARM: dts: imx6qdl: phytec: Add support for optional
 PEB-EVAL-01 board
Message-ID: <20211206024433.GW4216@dragon>
References: <20211130085355.2291607-1-y.bas@phytec.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211130085355.2291607-1-y.bas@phytec.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 30, 2021 at 09:53:53AM +0100, Yunus Bas wrote:
> The PHYTEC PEV-EVAL-01 expansion board adds support for additional
> gpio-triggered user-leds and gpio-key support.
> 
> Signed-off-by: Yunus Bas <y.bas@phytec.de>
> ---
>  .../boot/dts/imx6dl-phytec-mira-rdk-nand.dts  |  1 +
>  .../boot/dts/imx6q-phytec-mira-rdk-emmc.dts   |  1 +
>  .../boot/dts/imx6q-phytec-mira-rdk-nand.dts   |  1 +
>  .../dts/imx6qdl-phytec-mira-peb-eval-01.dtsi  | 71 +++++++++++++++++++
>  .../boot/dts/imx6qp-phytec-mira-rdk-nand.dts  |  1 +
>  5 files changed, 75 insertions(+)
>  create mode 100644 arch/arm/boot/dts/imx6qdl-phytec-mira-peb-eval-01.dtsi
> 
> diff --git a/arch/arm/boot/dts/imx6dl-phytec-mira-rdk-nand.dts b/arch/arm/boot/dts/imx6dl-phytec-mira-rdk-nand.dts
> index 9f7f9f98139d..b057fa664a6b 100644
> --- a/arch/arm/boot/dts/imx6dl-phytec-mira-rdk-nand.dts
> +++ b/arch/arm/boot/dts/imx6dl-phytec-mira-rdk-nand.dts
> @@ -8,6 +8,7 @@
>  #include "imx6dl.dtsi"
>  #include "imx6qdl-phytec-phycore-som.dtsi"
>  #include "imx6qdl-phytec-mira.dtsi"
> +#include "imx6qdl-phytec-mira-peb-eval-01.dtsi"
>  
>  / {
>  	model = "PHYTEC phyBOARD-Mira DualLite/Solo Carrier-Board with NAND";
> diff --git a/arch/arm/boot/dts/imx6q-phytec-mira-rdk-emmc.dts b/arch/arm/boot/dts/imx6q-phytec-mira-rdk-emmc.dts
> index 2e70ea5623c6..db6e2cc36759 100644
> --- a/arch/arm/boot/dts/imx6q-phytec-mira-rdk-emmc.dts
> +++ b/arch/arm/boot/dts/imx6q-phytec-mira-rdk-emmc.dts
> @@ -8,6 +8,7 @@
>  #include "imx6q.dtsi"
>  #include "imx6qdl-phytec-phycore-som.dtsi"
>  #include "imx6qdl-phytec-mira.dtsi"
> +#include "imx6qdl-phytec-mira-peb-eval-01.dtsi"
>  
>  / {
>  	model = "PHYTEC phyBOARD-Mira Quad Carrier-Board with eMMC";
> diff --git a/arch/arm/boot/dts/imx6q-phytec-mira-rdk-nand.dts b/arch/arm/boot/dts/imx6q-phytec-mira-rdk-nand.dts
> index 65d2e483c136..51ff601b1aec 100644
> --- a/arch/arm/boot/dts/imx6q-phytec-mira-rdk-nand.dts
> +++ b/arch/arm/boot/dts/imx6q-phytec-mira-rdk-nand.dts
> @@ -8,6 +8,7 @@
>  #include "imx6q.dtsi"
>  #include "imx6qdl-phytec-phycore-som.dtsi"
>  #include "imx6qdl-phytec-mira.dtsi"
> +#include "imx6qdl-phytec-mira-peb-eval-01.dtsi"
>  
>  / {
>  	model = "PHYTEC phyBOARD-Mira Quad Carrier-Board with NAND";
> diff --git a/arch/arm/boot/dts/imx6qdl-phytec-mira-peb-eval-01.dtsi b/arch/arm/boot/dts/imx6qdl-phytec-mira-peb-eval-01.dtsi
> new file mode 100644
> index 000000000000..3bcad402d3ec
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx6qdl-phytec-mira-peb-eval-01.dtsi
> @@ -0,0 +1,71 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (C) 2018 PHYTEC Messtechnik
> + * Author: Christian Hemp <c.hemp@phytec.de>
> + */
> +
> +#include <dt-bindings/input/input.h>
> +
> +/ {
> +	gpio-keys {
> +		compatible = "gpio-keys";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_gpio_keys>;
> +		status = "disabled";
> +
> +		home {
> +			label = "Home";
> +			gpios = <&gpio6 18 GPIO_ACTIVE_LOW>;
> +			linux,code = <KEY_SLEEP>;

KEY_SLEEP for Home?

Shawn

> +		};
> +
> +		power {
> +			label = "Power Button";
> +			gpios = <&gpio5 28 GPIO_ACTIVE_LOW>;
> +			linux,code = <KEY_WAKEUP>;
> +			wakeup-source;
> +		};
> +	};
> +
> +	user_leds: user-leds {
> +		compatible = "gpio-leds";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_user_leds>;
> +		status = "disabled";
> +
> +		user-led1 {
> +			gpios = <&gpio7 1 GPIO_ACTIVE_HIGH>;
> +			linux,default-trigger = "gpio";
> +			default-state = "on";
> +		};
> +
> +		user-led2 {
> +			gpios = <&gpio7 0 GPIO_ACTIVE_HIGH>;
> +			linux,default-trigger = "gpio";
> +			default-state = "on";
> +		};
> +
> +		user-led3 {
> +			gpios = <&gpio5 29 GPIO_ACTIVE_HIGH>;
> +			linux,default-trigger = "gpio";
> +			default-state = "on";
> +		};
> +	};
> +};
> +
> +&iomuxc {
> +	pinctrl_gpio_keys: gpiokeysgrp {
> +		fsl,pins = <
> +			MX6QDL_PAD_SD3_DAT6__GPIO6_IO18		0x1b0b0
> +			MX6QDL_PAD_CSI0_DAT10__GPIO5_IO28	0x1b0b0
> +		>;
> +	};
> +
> +	pinctrl_user_leds: userledsgrp {
> +		fsl,pins = <
> +			MX6QDL_PAD_SD3_DAT4__GPIO7_IO01		0x1b0b0
> +			MX6QDL_PAD_SD3_DAT5__GPIO7_IO00		0x1b0b0
> +			MX6QDL_PAD_CSI0_DAT11__GPIO5_IO29	0x1b0b0
> +		>;
> +	};
> +};
> diff --git a/arch/arm/boot/dts/imx6qp-phytec-mira-rdk-nand.dts b/arch/arm/boot/dts/imx6qp-phytec-mira-rdk-nand.dts
> index f27d7ab42626..06fe0c5315fc 100644
> --- a/arch/arm/boot/dts/imx6qp-phytec-mira-rdk-nand.dts
> +++ b/arch/arm/boot/dts/imx6qp-phytec-mira-rdk-nand.dts
> @@ -8,6 +8,7 @@
>  #include "imx6qp.dtsi"
>  #include "imx6qdl-phytec-phycore-som.dtsi"
>  #include "imx6qdl-phytec-mira.dtsi"
> +#include "imx6qdl-phytec-mira-peb-eval-01.dtsi"
>  
>  / {
>  	model = "PHYTEC phyBOARD-Mira QuadPlus Carrier-Board with NAND";
> -- 
> 2.25.1
> 
