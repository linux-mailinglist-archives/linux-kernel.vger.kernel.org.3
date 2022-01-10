Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2180489427
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 09:49:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241510AbiAJItH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 03:49:07 -0500
Received: from mail-ed1-f50.google.com ([209.85.208.50]:36441 "EHLO
        mail-ed1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241742AbiAJIrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 03:47:45 -0500
Received: by mail-ed1-f50.google.com with SMTP id 30so48920671edv.3;
        Mon, 10 Jan 2022 00:47:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=L5lnnHiOcmGcA4cFCxCOqeyJSqTKDVIaNUQx60pq6h8=;
        b=3N4C+08c3epD9gnCLapy7OMPvDIw7y/sssVli/hHMHnDKy2ln8oVP37Ixyzmj5usGu
         s7ig3FRt14uDYCW1/hrt4ZhxDZ30Arq49nb908r41m4AibofZu2eY0pfelqT04c6/Xdo
         HN+YNw6LMGIJna99snQ/MjlTuBfKBuTbPpqp26JqIArk2NX8HP094c39vieN00KX3qAd
         35vnk31q5d9DtdAM0hXDeNjS8GdbzXSbQW6d1uWpPIss0LLrz7cRHDQCajLZ/RBgXBIe
         y8CcXv0lMGYikHtSYaEwJe3sYnuzHXk6jKtw1mAxHpkwgH73fNK9/4luU4XFCaOhPv5h
         SGpQ==
X-Gm-Message-State: AOAM530s95QdznR3mXRrtiCzMbWG4jHQ5ghM+W12XS3v/KVXGvXnSq3s
        z+utn4u1izhCs1sae2wzyBs=
X-Google-Smtp-Source: ABdhPJx1ObFqbMHwfySaOt5iBMR42WBVJtvWM4KI9rECPxTFNihulv/K5FZnJkiZpOx7rfLHWWTzEw==
X-Received: by 2002:a05:6402:709:: with SMTP id w9mr4463688edx.167.1641804459916;
        Mon, 10 Jan 2022 00:47:39 -0800 (PST)
Received: from [192.168.1.126] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.googlemail.com with ESMTPSA id hc40sm2159561ejc.72.2022.01.10.00.47.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jan 2022 00:47:38 -0800 (PST)
Message-ID: <c80ac4a7-d401-00c3-c6c2-61bc9a600590@kernel.org>
Date:   Mon, 10 Jan 2022 09:47:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v1 14/14] arm64: dts: freescale: add initial support for
 verdin imx8m mini
Content-Language: en-US
To:     Marcel Ziswiler <marcel@ziswiler.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Marek Vasut <marek.vasut@gmail.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Alex Marginean <alexandru.marginean@nxp.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Olof Johansson <olof@lixom.net>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Tim Harvey <tharvey@gateworks.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220107180314.1816515-1-marcel@ziswiler.com>
 <20220107180314.1816515-15-marcel@ziswiler.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20220107180314.1816515-15-marcel@ziswiler.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/01/2022 19:03, Marcel Ziswiler wrote:
> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> This patch adds the device tree to support Toradex Verdin iMX8M Mini a
> computer on module which can be used on different carrier boards.
> 
> The module consists of an NXP i.MX 8M Mini family SoC (either i.MX 8M
> Mini Quad or 8M Mini DualLite), a PCA9450A PMIC, a Gigabit Ethernet PHY,
> 1 or 2 GB of LPDDR4 RAM, an eMMC, a TLA2024 ADC, an I2C EEPROM, an
> RX8130 RTC, an optional SPI CAN controller plus an optional Bluetooth/
> Wi-Fi module.
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
> console UART, USB host, eMMC and Ethernet and PCIe functionality work
> fine.
> 
> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> ---
> 
>  arch/arm64/boot/dts/freescale/Makefile        |    4 +
>  .../dts/freescale/imx8mm-verdin-dahlia.dtsi   |  143 ++
>  .../boot/dts/freescale/imx8mm-verdin-dev.dtsi |   67 +
>  .../imx8mm-verdin-nonwifi-dahlia.dts          |   18 +
>  .../freescale/imx8mm-verdin-nonwifi-dev.dts   |   18 +
>  .../dts/freescale/imx8mm-verdin-nonwifi.dtsi  |   75 +
>  .../freescale/imx8mm-verdin-wifi-dahlia.dts   |   18 +
>  .../dts/freescale/imx8mm-verdin-wifi-dev.dts  |   18 +
>  .../dts/freescale/imx8mm-verdin-wifi.dtsi     |   95 ++
>  .../boot/dts/freescale/imx8mm-verdin.dtsi     | 1277 +++++++++++++++++
>  10 files changed, 1733 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-verdin-dahlia.dtsi
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-verdin-dev.dtsi
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-verdin-nonwifi-dahlia.dts
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-verdin-nonwifi-dev.dts
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-verdin-nonwifi.dtsi
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-verdin-wifi-dahlia.dts
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-verdin-wifi-dev.dts
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-verdin-wifi.dtsi
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
> 

(...)

> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
> new file mode 100644
> index 000000000000..23eb695a5266
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
> @@ -0,0 +1,1277 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
> +/*
> + * Copyright 2022 Toradex
> + */
> +
> +#include "dt-bindings/pwm/pwm.h"
> +#include "imx8mm.dtsi"
> +
> +/ {
> +	chosen {
> +		bootargs = "console=ttymxc0,115200 earlycon";

earlycon is a debug tool, so should not be part of mainline DTS by
default. Entire bootargs property looks actually not needed.

> +		stdout-path = &uart1;
> +	};
> +

(...)

> +/* Verdin ETH_1 (On-module PHY) */
> +&fec1 {
> +	fsl,magic-packet;
> +	phy-handle = <&ethphy0>;
> +	phy-mode = "rgmii-id";
> +	phy-supply = <&reg_ethphy>;
> +	pinctrl-names = "default", "sleep";
> +	pinctrl-0 = <&pinctrl_fec1>;
> +	pinctrl-1 = <&pinctrl_fec1_sleep>;
> +
> +	mdio {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		ethphy0: ethernet-phy@7 {
> +			compatible = "ethernet-phy-ieee802.3-c22";
> +			interrupt-parent = <&gpio1>;
> +			interrupts = <10 IRQ_TYPE_LEVEL_LOW>;
> +			micrel,led-mode = <0>;
> +			reg = <7>;
> +		};
> +	};
> +};
> +
> +/* Verdin QSPI_1 */
> +&flexspi {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_flexspi0>;
> +#if 0

Please drop it or explain with a comment why we need dead code in Linux
kernel.

> +	flash@0 {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		compatible = "jedec,spi-nor";
> +		reg = <0>;
> +		spi-max-frequency = <80000000>;
> +	};
> +#endif
> +};
> +


Best regards,
Krzysztof
