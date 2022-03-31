Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBE574ED4D2
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 09:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232203AbiCaHcC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 03:32:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232206AbiCaHb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 03:31:59 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F13DD4458;
        Thu, 31 Mar 2022 00:30:07 -0700 (PDT)
X-UUID: a5d89c6f4df54789b388472aa1669bc9-20220331
X-UUID: a5d89c6f4df54789b388472aa1669bc9-20220331
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1085765277; Thu, 31 Mar 2022 15:30:00 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Thu, 31 Mar 2022 15:29:59 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 31 Mar 2022 15:29:58 +0800
Message-ID: <58f498a19f6c7be85823b2e2d5955272e78f0176.camel@mediatek.com>
Subject: Re: [PATCH v13 2/2] arm64: dts: Add mediatek SoC mt8195 and
 evaluation board
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Tinghan Shen <tinghan.shen@mediatek.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Wenbin Mei <wenbin.mei@mediatek.com>
CC:     <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <ryder.lee@kernel.org>, <wenst@chromium.org>,
        Seiya Wang <seiya.wang@mediatek.com>
Date:   Thu, 31 Mar 2022 15:29:58 +0800
In-Reply-To: <20220330094532.21721-3-tinghan.shen@mediatek.com>
References: <20220330094532.21721-1-tinghan.shen@mediatek.com>
         <20220330094532.21721-3-tinghan.shen@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-03-30 at 17:45 +0800, Tinghan Shen wrote:
> Add basic chip support for mediatek mt8195.
> 
> Signed-off-by: Seiya Wang <seiya.wang@mediatek.com>
> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <
> angelogioacchino.delregno@collabora.com>
> ---
>  arch/arm64/boot/dts/mediatek/Makefile       |    1 +
>  arch/arm64/boot/dts/mediatek/mt8195-evb.dts |  173 +++
>  arch/arm64/boot/dts/mediatek/mt8195.dtsi    | 1045
> +++++++++++++++++++
>  3 files changed, 1219 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8195-evb.dts
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8195.dtsi
> 
> diff --git a/arch/arm64/boot/dts/mediatek/Makefile
> b/arch/arm64/boot/dts/mediatek/Makefile
> index 8c1e18032f9f..5da29e7223e4 100644
> --- a/arch/arm64/boot/dts/mediatek/Makefile
> +++ b/arch/arm64/boot/dts/mediatek/Makefile
> @@ -38,4 +38,5 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-krane-
> sku0.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-krane-sku176.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-pumpkin.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt8192-evb.dtb
> +dtb-$(CONFIG_ARCH_MEDIATEK) += mt8195-evb.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt8516-pumpkin.dtb
> diff --git a/arch/arm64/boot/dts/mediatek/mt8195-evb.dts
> b/arch/arm64/boot/dts/mediatek/mt8195-evb.dts
> new file mode 100644
> index 000000000000..76b5aaad7263
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt8195-evb.dts
> @@ -0,0 +1,173 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/*
> + * Copyright (C) 2021 MediaTek Inc.
> + * Author: Seiya Wang <seiya.wang@mediatek.com>
> + */
> +/dts-v1/;
> +#include "mt8195.dtsi"
> +
> +/ {
> +	model = "MediaTek MT8195 evaluation board";
> +	compatible = "mediatek,mt8195-evb", "mediatek,mt8195";
> +
> +	aliases {
> +		serial0 = &uart0;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:921600n8";
> +	};
> +
> +	memory@40000000 {
> +		device_type = "memory";
> +		reg = <0 0x40000000 0 0x80000000>;
> +	};
> +};
> +
> +&auxadc {
> +	status = "okay";
> +};
> +
> +&i2c0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c0_pin>;
> +	clock-frequency = <100000>;
> +	status = "okay";
> +};
> +
> +&i2c1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c1_pin>;
> +	clock-frequency = <400000>;
> +	status = "okay";
> +};
> +
> +&i2c4 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c4_pin>;
> +	clock-frequency = <400000>;
> +	status = "okay";
> +};
> +
> +&i2c6 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c6_pin>;
> +	clock-frequency = <400000>;
> +	status = "okay";
> +};
> +
> +&nor_flash {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&nor_pins_default>;
> +
> +	flash@0 {
> +		compatible = "jedec,spi-nor";
> +		reg = <0>;
> +		spi-max-frequency = <50000000>;
> +	};
> +};
> +
> +&pio {
> +	i2c0_pin: i2c0-pins {
> +		pins {
> +			pinmux = <PINMUX_GPIO8__FUNC_SDA0>,
> +				 <PINMUX_GPIO9__FUNC_SCL0>;
> +			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
> +			mediatek,drive-strength-adv = <0>;
> +			drive-strength = <6>;
> +		};
> +	};
> +
> +	i2c1_pin: i2c1-pins {
> +		pins {
> +			pinmux = <PINMUX_GPIO10__FUNC_SDA1>,
> +				 <PINMUX_GPIO11__FUNC_SCL1>;
> +			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
> +			mediatek,drive-strength-adv = <0>;
> +			drive-strength = <6>;
> +		};
> +	};
> +
> +	i2c4_pin: i2c4-pins {
> +		pins {
> +			pinmux = <PINMUX_GPIO16__FUNC_SDA4>,
> +				 <PINMUX_GPIO17__FUNC_SCL4>;
> +			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
> +			mediatek,drive-strength-adv = <7>;
> +		};
> +	};
> +
> +	i2c6_pin: i2c6-pins {
> +		pins {
> +			pinmux = <PINMUX_GPIO25__FUNC_SDA6>,
> +				 <PINMUX_GPIO26__FUNC_SCL6>;
> +			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
> +		};
> +	};
> +
> +	i2c7_pin: i2c7-pins {
> +		pins {
> +			pinmux = <PINMUX_GPIO27__FUNC_SCL7>,
> +				 <PINMUX_GPIO28__FUNC_SDA7>;
> +			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
> +		};
> +	};
> +
> +	nor_pins_default: nor-pins {
> +		pins0 {
> +			pinmux = <PINMUX_GPIO142__FUNC_SPINOR_IO0>,
> +				 <PINMUX_GPIO141__FUNC_SPINOR_CK>,
> +				 <PINMUX_GPIO143__FUNC_SPINOR_IO1>;
> +			bias-pull-down;
> +		};
> +
> +		pins1 {
> +			pinmux = <PINMUX_GPIO140__FUNC_SPINOR_CS>,
> +				 <PINMUX_GPIO130__FUNC_SPINOR_IO2>,
> +				 <PINMUX_GPIO131__FUNC_SPINOR_IO3>;
> +			bias-pull-up;
> +		};
> +	};
> +
> +	uart0_pin: uart0-pins {
> +		pins {
> +			pinmux = <PINMUX_GPIO98__FUNC_UTXD0>,
> +				 <PINMUX_GPIO99__FUNC_URXD0>;
> +		};
> +	};
> +};
> +
> +&u3phy0 {
> +	status="okay";
> +};
> +
> +&u3phy1 {
> +	status="okay";
> +};

Seems forget to enable &phy2/3? due to xhci2/3 are enabled below

> +
> +&uart0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&uart0_pin>;
> +	status = "okay";
> +};
> +
> +&xhci0 {
> +	status = "okay";
> +};
> +
> +&xhci1 {
> +	status = "okay";
> +};
> +
> +&xhci2 {
> +	status = "okay";
> +};
> +
> +&xhci3 {
> +	/* This controller is connected with a BT device.
> +	 * Disable usb2 lpm to prevent known issues.
> +	 */
> +	usb2-lpm-disable;
> +	status = "okay";
> +};
> 
[skip]

