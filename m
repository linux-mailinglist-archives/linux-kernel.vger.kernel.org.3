Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56AD8476AB1
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 07:57:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234251AbhLPG4g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 01:56:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231685AbhLPG4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 01:56:34 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1E44C06173E;
        Wed, 15 Dec 2021 22:56:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6FC3DB822E2;
        Thu, 16 Dec 2021 06:56:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2ACFC36AE2;
        Thu, 16 Dec 2021 06:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639637791;
        bh=Opzm7PgrSNHQ/1vmgVHT+1J/KheON2cr3gBjqEDBahs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lz5lLVvEieicDp4OmIzaL7/Nd+VP3jT5fXGJBcryY+OyZ61Z3I0Z6aXcmpQW0gwQq
         z9H7UiM3aBNXHOp36HyrPMCpiQjql52iAZo8r/VMGgmFzRbX6AvPlCq635+B8nJoTm
         rn1TfWLozQtssL7nQSJdRuBxFA3jaHY3OW4jWVywJGyK5/3jyZWYo7NKsJvdtdoY4a
         ocx8r8juurSHqDGuPaCptlE1yRYvfncNKO4EPjl13I+fyX6G3U2E2XOlODV6DVR8bh
         mx9VN4gko4mvg3tNsl0ykc1JtxI4qzmjFXLjw6YHt8iEs7d7L1qCG+0bl6E63xcwmJ
         cEvq8zX6WjV0Q==
Date:   Thu, 16 Dec 2021 14:56:26 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Yunus Bas <y.bas@phytec.de>
Cc:     robh+dt@kernel.org, s.hauer@pengutronix.de,
        devicetree@vger.kernel.org, festevam@gmail.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] ARM: dts: imx6: phytec: Add PEB-WLBT-05 support
Message-ID: <20211216065625.GY4216@dragon>
References: <20211213123833.3011525-1-y.bas@phytec.de>
 <20211213123833.3011525-3-y.bas@phytec.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211213123833.3011525-3-y.bas@phytec.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2021 at 01:38:33PM +0100, Yunus Bas wrote:
> The PEB-WLBT-05 is equipped with a Sterling-LWB radio module, which is
> capable of Wi-Fi 802.11 b/g/n and Bluetooth 4.2.
> 
> Signed-off-by: Yunus Bas <y.bas@phytec.de>
> ---
> Changes in v2:
> - Changed node-name underscores to hyphens
> ---
>  .../boot/dts/imx6dl-phytec-mira-rdk-nand.dts  |  1 +
>  .../boot/dts/imx6q-phytec-mira-rdk-emmc.dts   |  1 +
>  .../boot/dts/imx6q-phytec-mira-rdk-nand.dts   |  1 +
>  .../dts/imx6qdl-phytec-mira-peb-wlbt-05.dtsi  | 82 +++++++++++++++++
>  .../boot/dts/imx6qp-phytec-mira-rdk-nand.dts  |  1 +
>  .../dts/imx6ul-phytec-segin-ff-rdk-nand.dts   |  1 +
>  .../dts/imx6ul-phytec-segin-peb-wlbt-05.dtsi  | 87 +++++++++++++++++++
>  .../dts/imx6ull-phytec-segin-ff-rdk-nand.dts  |  1 +
>  .../dts/imx6ull-phytec-segin-lc-rdk-nand.dts  |  1 +
>  .../dts/imx6ull-phytec-segin-peb-wlbt-05.dtsi | 19 ++++
>  10 files changed, 195 insertions(+)
>  create mode 100644 arch/arm/boot/dts/imx6qdl-phytec-mira-peb-wlbt-05.dtsi
>  create mode 100644 arch/arm/boot/dts/imx6ul-phytec-segin-peb-wlbt-05.dtsi
>  create mode 100644 arch/arm/boot/dts/imx6ull-phytec-segin-peb-wlbt-05.dtsi
> 
> diff --git a/arch/arm/boot/dts/imx6dl-phytec-mira-rdk-nand.dts b/arch/arm/boot/dts/imx6dl-phytec-mira-rdk-nand.dts
> index 8165fae2b1d1..d906a7f05aaa 100644
> --- a/arch/arm/boot/dts/imx6dl-phytec-mira-rdk-nand.dts
> +++ b/arch/arm/boot/dts/imx6dl-phytec-mira-rdk-nand.dts
> @@ -10,6 +10,7 @@
>  #include "imx6qdl-phytec-mira.dtsi"
>  #include "imx6qdl-phytec-mira-peb-eval-01.dtsi"
>  #include "imx6qdl-phytec-mira-peb-av-02.dtsi"
> +#include "imx6qdl-phytec-mira-peb-wlbt-05.dtsi"
>  
>  / {
>  	model = "PHYTEC phyBOARD-Mira DualLite/Solo Carrier-Board with NAND";
> diff --git a/arch/arm/boot/dts/imx6q-phytec-mira-rdk-emmc.dts b/arch/arm/boot/dts/imx6q-phytec-mira-rdk-emmc.dts
> index bbf5097ca974..322f071d972f 100644
> --- a/arch/arm/boot/dts/imx6q-phytec-mira-rdk-emmc.dts
> +++ b/arch/arm/boot/dts/imx6q-phytec-mira-rdk-emmc.dts
> @@ -10,6 +10,7 @@
>  #include "imx6qdl-phytec-mira.dtsi"
>  #include "imx6qdl-phytec-mira-peb-eval-01.dtsi"
>  #include "imx6qdl-phytec-mira-peb-av-02.dtsi"
> +#include "imx6qdl-phytec-mira-peb-wlbt-05.dtsi"
>  
>  / {
>  	model = "PHYTEC phyBOARD-Mira Quad Carrier-Board with eMMC";
> diff --git a/arch/arm/boot/dts/imx6q-phytec-mira-rdk-nand.dts b/arch/arm/boot/dts/imx6q-phytec-mira-rdk-nand.dts
> index 95051e18324f..3f13726c8058 100644
> --- a/arch/arm/boot/dts/imx6q-phytec-mira-rdk-nand.dts
> +++ b/arch/arm/boot/dts/imx6q-phytec-mira-rdk-nand.dts
> @@ -10,6 +10,7 @@
>  #include "imx6qdl-phytec-mira.dtsi"
>  #include "imx6qdl-phytec-mira-peb-eval-01.dtsi"
>  #include "imx6qdl-phytec-mira-peb-av-02.dtsi"
> +#include "imx6qdl-phytec-mira-peb-wlbt-05.dtsi"
>  
>  / {
>  	model = "PHYTEC phyBOARD-Mira Quad Carrier-Board with NAND";
> diff --git a/arch/arm/boot/dts/imx6qdl-phytec-mira-peb-wlbt-05.dtsi b/arch/arm/boot/dts/imx6qdl-phytec-mira-peb-wlbt-05.dtsi
> new file mode 100644
> index 000000000000..0abf3e1e1f62
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx6qdl-phytec-mira-peb-wlbt-05.dtsi
> @@ -0,0 +1,82 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (C) 2021 PHYTEC Messtechnik GmbH
> + * Author: Yunus Bas <y.bas@phytec.de>
> + */
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/interrupt-controller/irq.h>
> +
> +/ {
> +	reg_wl_en: regulator-wl-en {
> +		compatible = "regulator-fixed";
> +		regulator-name = "wlan_en";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_wl>;
> +		gpio = <&gpio5 2 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +		startup-delay-us = <100>;
> +		status = "disabled";
> +	};
> +};
> +
> +&uart3 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart3_bt>;
> +	uart-has-rtscts;
> +
> +	bluetooth {
> +		compatible = "brcm,bcm43438-bt";
> +		shutdown-gpios = <&gpio7 0 GPIO_ACTIVE_HIGH>;
> +		device-wakeup-gpios = <&gpio7 1 GPIO_ACTIVE_HIGH>;
> +		host-wakeup-gpios = <&gpio5 26 GPIO_ACTIVE_HIGH>;
> +		status = "disabled";
> +	};
> +};
> +
> +&usdhc3 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_usdhc3_wl>;
> +	vmmc-supply = <&reg_wl_en>;
> +	bus-width = <4>;
> +	non-removable;
> +	no-1-8-v;
> +	status = "disabled";
> +
> +	brmcf: wifi@1 {
> +		compatible = "brcm,bcm4329-fmac";

Shouldn't we have a 'reg' property matching the unit-address in the node
name?

Shawn

> +	};
> +};
> +
> +&iomuxc {
> +	pinctrl_uart3_bt: uart3grp-bt {
> +		fsl,pins = <
> +			MX6QDL_PAD_EIM_D25__UART3_RX_DATA	0x1b0b1
> +			MX6QDL_PAD_EIM_D24__UART3_TX_DATA	0x1b0b1
> +			MX6QDL_PAD_EIM_EB3__UART3_RTS_B		0x1b0b1
> +			MX6QDL_PAD_EIM_D23__UART3_CTS_B		0x1b0b1
> +			MX6QDL_PAD_SD3_DAT5__GPIO7_IO00		0xb0b1	/* BT ENABLE */
> +			MX6QDL_PAD_SD3_DAT4__GPIO7_IO01		0xb0b1	/* DEV WAKEUP */
> +			MX6QDL_PAD_CSI0_DAT8__GPIO5_IO26	0xb0b1  /* HOST WAKEUP */
> +		>;
> +	};
> +
> +	pinctrl_usdhc3_wl: usdhc3grp-wl {
> +		fsl,pins = <
> +			MX6QDL_PAD_SD3_CMD__SD3_CMD		0x17059
> +			MX6QDL_PAD_SD3_CLK__SD3_CLK		0x10059
> +			MX6QDL_PAD_SD3_DAT0__SD3_DATA0		0x17059
> +			MX6QDL_PAD_SD3_DAT1__SD3_DATA1		0x17059
> +			MX6QDL_PAD_SD3_DAT2__SD3_DATA2		0x17059
> +			MX6QDL_PAD_SD3_DAT3__SD3_DATA3		0x17059
> +		>;
> +	};
> +
> +	pinctrl_wl: wlgrp {
> +		fsl,pins = <
> +			MX6QDL_PAD_EIM_A25__GPIO5_IO02      0xb0b1	/* WLAN ENABLE */
> +		>;
> +	};
> +};
> diff --git a/arch/arm/boot/dts/imx6qp-phytec-mira-rdk-nand.dts b/arch/arm/boot/dts/imx6qp-phytec-mira-rdk-nand.dts
> index 343639cb035c..a18266598d39 100644
> --- a/arch/arm/boot/dts/imx6qp-phytec-mira-rdk-nand.dts
> +++ b/arch/arm/boot/dts/imx6qp-phytec-mira-rdk-nand.dts
> @@ -10,6 +10,7 @@
>  #include "imx6qdl-phytec-mira.dtsi"
>  #include "imx6qdl-phytec-mira-peb-eval-01.dtsi"
>  #include "imx6qdl-phytec-mira-peb-av-02.dtsi"
> +#include "imx6qdl-phytec-mira-peb-wlbt-05.dtsi"
>  
>  / {
>  	model = "PHYTEC phyBOARD-Mira QuadPlus Carrier-Board with NAND";
> diff --git a/arch/arm/boot/dts/imx6ul-phytec-segin-ff-rdk-nand.dts b/arch/arm/boot/dts/imx6ul-phytec-segin-ff-rdk-nand.dts
> index bff98e676980..607eddc5030f 100644
> --- a/arch/arm/boot/dts/imx6ul-phytec-segin-ff-rdk-nand.dts
> +++ b/arch/arm/boot/dts/imx6ul-phytec-segin-ff-rdk-nand.dts
> @@ -10,6 +10,7 @@
>  #include "imx6ul-phytec-segin.dtsi"
>  #include "imx6ul-phytec-segin-peb-eval-01.dtsi"
>  #include "imx6ul-phytec-segin-peb-av-02.dtsi"
> +#include "imx6ul-phytec-segin-peb-wlbt-05.dtsi"
>  
>  / {
>  	model = "PHYTEC phyBOARD-Segin i.MX6 UltraLite Full Featured with NAND";
> diff --git a/arch/arm/boot/dts/imx6ul-phytec-segin-peb-wlbt-05.dtsi b/arch/arm/boot/dts/imx6ul-phytec-segin-peb-wlbt-05.dtsi
> new file mode 100644
> index 000000000000..4a75745d6030
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx6ul-phytec-segin-peb-wlbt-05.dtsi
> @@ -0,0 +1,87 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (C) 2021 PHYTEC Messtechnik GmbH
> + * Author: Yunus Bas <y.bas@phytec.de>
> + */
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/interrupt-controller/irq.h>
> +
> +/ {
> +	reg_wl_en: regulator-wl-en {
> +		compatible = "regulator-fixed";
> +		regulator-name = "wlan_en";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_wl>;
> +		gpio = <&gpio5 9 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +		startup-delay-us = <100>;
> +		status = "disabled";
> +	};
> +};
> +
> +&iomuxc {
> +	pinctrl_bt: btgrp {
> +		fsl,pins = <
> +			MX6UL_PAD_GPIO1_IO01__GPIO1_IO01	0x3031	/* BT ENABLE */
> +			MX6UL_PAD_GPIO1_IO03__GPIO1_IO03	0x3031	/* HOST WAKEUP */
> +			MX6UL_PAD_JTAG_MOD__GPIO1_IO10		0x3031	/* DEV WAKEUP */
> +		>;
> +	};
> +
> +	pinctrl_uart2_bt: uart2grp-bt {
> +		fsl,pins = <
> +			MX6UL_PAD_UART2_TX_DATA__UART2_DCE_TX   0x17059
> +			MX6UL_PAD_UART2_RX_DATA__UART2_DCE_RX   0x17059
> +			MX6UL_PAD_UART2_CTS_B__UART2_DCE_CTS    0x17059
> +			MX6UL_PAD_UART2_RTS_B__UART2_DCE_RTS    0x17059
> +		>;
> +	};
> +
> +	pinctrl_usdhc2_wl: usdhc2grp-wl {
> +		fsl,pins = <
> +			MX6UL_PAD_LCD_DATA18__USDHC2_CMD    0x10051
> +			MX6UL_PAD_LCD_DATA19__USDHC2_CLK    0x10061
> +			MX6UL_PAD_LCD_DATA20__USDHC2_DATA0  0x10051
> +			MX6UL_PAD_LCD_DATA21__USDHC2_DATA1  0x10051
> +			MX6UL_PAD_LCD_DATA22__USDHC2_DATA2  0x10051
> +			MX6UL_PAD_LCD_DATA23__USDHC2_DATA3  0x10051
> +		>;
> +	};
> +
> +	pinctrl_wl: wlgrp {
> +		fsl,pins = <
> +			MX6UL_PAD_SNVS_TAMPER9__GPIO5_IO09  0x3031	/* WLAN ENABLE */
> +		>;
> +	};
> +};
> +
> +&uart2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart2_bt &pinctrl_bt>;
> +	uart-has-rtscts;
> +	status = "disabled";
> +
> +	bluetooth {
> +		compatible = "brcm,bcm43438-bt";
> +		shutdown-gpios = <&gpio1 1 GPIO_ACTIVE_HIGH>;
> +		device-wakeup-gpios = <&gpio1 10 GPIO_ACTIVE_HIGH>;
> +		host-wakeup-gpios = <&gpio1 3 GPIO_ACTIVE_HIGH>;
> +	};
> +};
> +
> +&usdhc2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_usdhc2_wl>;
> +	vmmc-supply = <&reg_wl_en>;
> +	bus-width = <4>;
> +	non-removable;
> +	no-1-8-v;
> +	status = "disabled";
> +
> +	brmcf: wifi@1 {
> +		compatible = "brcm,bcm4329-fmac";
> +	};
> +};
> diff --git a/arch/arm/boot/dts/imx6ull-phytec-segin-ff-rdk-nand.dts b/arch/arm/boot/dts/imx6ull-phytec-segin-ff-rdk-nand.dts
> index c8d3eff9ed4b..1d7362b5ac91 100644
> --- a/arch/arm/boot/dts/imx6ull-phytec-segin-ff-rdk-nand.dts
> +++ b/arch/arm/boot/dts/imx6ull-phytec-segin-ff-rdk-nand.dts
> @@ -10,6 +10,7 @@
>  #include "imx6ull-phytec-segin.dtsi"
>  #include "imx6ull-phytec-segin-peb-eval-01.dtsi"
>  #include "imx6ull-phytec-segin-peb-av-02.dtsi"
> +#include "imx6ull-phytec-segin-peb-wlbt-05.dtsi"
>  
>  / {
>  	model = "PHYTEC phyBOARD-Segin i.MX6 ULL Full Featured with NAND";
> diff --git a/arch/arm/boot/dts/imx6ull-phytec-segin-lc-rdk-nand.dts b/arch/arm/boot/dts/imx6ull-phytec-segin-lc-rdk-nand.dts
> index e168494e0a6d..4bcbae024d8d 100644
> --- a/arch/arm/boot/dts/imx6ull-phytec-segin-lc-rdk-nand.dts
> +++ b/arch/arm/boot/dts/imx6ull-phytec-segin-lc-rdk-nand.dts
> @@ -9,6 +9,7 @@
>  #include "imx6ull-phytec-phycore-som.dtsi"
>  #include "imx6ull-phytec-segin.dtsi"
>  #include "imx6ull-phytec-segin-peb-eval-01.dtsi"
> +#include "imx6ull-phytec-segin-peb-wlbt-05.dtsi"
>  
>  / {
>  	model = "PHYTEC phyBOARD-Segin i.MX6 ULL Low Cost with NAND";
> diff --git a/arch/arm/boot/dts/imx6ull-phytec-segin-peb-wlbt-05.dtsi b/arch/arm/boot/dts/imx6ull-phytec-segin-peb-wlbt-05.dtsi
> new file mode 100644
> index 000000000000..df25814a3371
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx6ull-phytec-segin-peb-wlbt-05.dtsi
> @@ -0,0 +1,19 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (C) 2021 PHYTEC Messtechnik GmbH
> + * Author: Yunus Bas <y.bas@phytec.de>
> + */
> +
> +#include "imx6ul-phytec-segin-peb-wlbt-05.dtsi"
> +
> +&iomuxc {
> +	/delete-node/ wlgrp;
> +};
> +
> +&iomuxc_snvs {
> +	pinctrl_wl: wlgrp {
> +		fsl,pins = <
> +			MX6ULL_PAD_SNVS_TAMPER9__GPIO5_IO09	0x3031
> +		>;
> +	};
> +};
> -- 
> 2.25.1
> 
