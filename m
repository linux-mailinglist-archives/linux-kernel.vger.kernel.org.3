Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6956569E94
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 11:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234837AbiGGJbk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 05:31:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbiGGJbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 05:31:38 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA15633E05;
        Thu,  7 Jul 2022 02:31:36 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 28BF66601978;
        Thu,  7 Jul 2022 10:31:35 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1657186295;
        bh=Ath3rq3p03H6MtSS6xBSdyqJicwlhpDEfZjXuEK6owM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=gc+OBbTWuskc8471X915+qFwxJBafpGBa11wxtFgGBIYZWkvX/vj5OH6RYobXXc+W
         Z3tMlf8Tb3/OPLHaxEh4Dj6J6gfHCFfiHtKLBAj4NAh98Wfh/Pcg3FL+/rDKchUdnl
         ZTBbZTSIeRogDNhL2Wg/78lvx6B0yjYur/AdtszkHvB496RYqc8bj066knggGRbMmc
         fuOCV9Em3Rbrx9CxJZE9ahczAy4RshJSoCrqSk+wI0K/f4AFKZLCwyccBk1rk4ziCt
         ozt1pM4ZSye+gAOvAQH2ISxUgxrfCzNF+YaQNOEYmhu0nZkXeqsey56+YszWpjT37t
         bsml5VhahXBcg==
Message-ID: <ca179698-d79d-f643-95a8-a27d51efddef@collabora.com>
Date:   Thu, 7 Jul 2022 11:31:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v11 3/3] arm64: dts: Add MediaTek SoC MT8186 dts and
 evaluation board and Makefile
Content-Language: en-US
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Chen-Yu Tsai <wenst@chromium.org>,
        Ryder Lee <ryder.lee@kernel.org>, hsinyi@chromium.org
References: <20220520122217.30716-1-allen-kh.cheng@mediatek.com>
 <20220520122217.30716-4-allen-kh.cheng@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220520122217.30716-4-allen-kh.cheng@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 20/05/22 14:22, Allen-KH Cheng ha scritto:
> Add basic chip support for MediaTek MT8186.
> 
> Signed-off-by: Allen-KH Cheng <Allen-KH.Cheng@mediatek.com>
> ---
>   arch/arm64/boot/dts/mediatek/Makefile       |    1 +
>   arch/arm64/boot/dts/mediatek/mt8186-evb.dts |  232 +++++
>   arch/arm64/boot/dts/mediatek/mt8186.dtsi    | 1016 +++++++++++++++++++
>   3 files changed, 1249 insertions(+)
>   create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-evb.dts
>   create mode 100644 arch/arm64/boot/dts/mediatek/mt8186.dtsi
> 
> diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
> index c7d4636a2cb7..50a2c58c5f56 100644
> --- a/arch/arm64/boot/dts/mediatek/Makefile
> +++ b/arch/arm64/boot/dts/mediatek/Makefile
> @@ -37,6 +37,7 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-kodama-sku32.dtb
>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-krane-sku0.dtb
>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-krane-sku176.dtb
>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-pumpkin.dtb
> +dtb-$(CONFIG_ARCH_MEDIATEK) += mt8186-evb.dtb
>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt8192-evb.dtb
>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt8195-demo.dtb
>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt8195-evb.dtb
> diff --git a/arch/arm64/boot/dts/mediatek/mt8186-evb.dts b/arch/arm64/boot/dts/mediatek/mt8186-evb.dts
> new file mode 100644
> index 000000000000..3e8018c1e802
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt8186-evb.dts
> @@ -0,0 +1,232 @@
> +// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +/*
> + * Copyright (C) 2022 MediaTek Inc.
> + */
> +/dts-v1/;
> +#include "mt8186.dtsi"
> +
> +/ {
> +	model = "MediaTek MT8186 evaluation board";
> +	compatible = "mediatek,mt8186-evb", "mediatek,mt8186";
> +
> +	aliases {
> +		serial0 = &uart0;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:921600n8";
> +	};
> +
> +	memory {
> +		device_type = "memory";
> +		reg = <0 0x40000000 0 0x80000000>;
> +	};
> +};
> +
> +&i2c0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c0_pins>;
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	status = "okay";
> +};
> +
> +&i2c1 {
> +	clock-frequency = <400000>;
> +	i2c-scl-internal-delay-ns = <8000>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c1_pins>;
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	status = "okay";
> +};
> +

Can you please reorder like:

&i2c1 {
	status = "okay";

	clock-frequency = <400000>;
	i2c-scl-internal-delay-ns = <12500>;
	pinctrl-names = "default";
	pinctrl-0 = <&i2c1_pins>;
};

Also, address and size cells are common properties and will not change
on a per-board basis: please define them in mt8186.dtsi instead.

Same for the other nodes.


> +&i2c2 {

..snip..

> +
> +&pio {
> +	i2c0_pins: i2c0{

Please perform a dtbs_check before pushing devicetrees upstream:
this node will give you a warning, bindings related warnings are
considered like code warnings and they shall not happen.

pinctrl-mt8186.yaml defines patternProperties as '-pins$'
so this should be:

	i2c0_pins: i2c0-pins {

Please fix.


> +		pins-sda-scl {
> +			pinmux = <PINMUX_GPIO128__FUNC_SDA0>,
> +				 <PINMUX_GPIO127__FUNC_SCL0>;
> +			bias-disable;
> +			mediatek,drive-strength-adv = <0>;

Do not use mediatek,drive-strength-adv: it's not right in principle
to have this property, as it can be expressed with the standard
drive-strength-microamp property instead.

Check pinctrl-mt8192.yaml (or my commits to pinctrl-mt8195.yaml) for
more information.

> +			drive-strength = <MTK_DRIVE_4mA>;

MTK_DRIVE_(x)mA maps to the actual value in mA: please stop using this
definition and simply define this as

			drive-strength = <4>;


> +			input-enable;
> +		};
> +	};
> +

..snip..

> +
> +&u3phy0 {
> +	status="okay";

This should be

	status = "okay";

> +};
> +
> +&u3phy1 {
> +	status="okay";
> +};
> +
> +&uart0 {
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
> diff --git a/arch/arm64/boot/dts/mediatek/mt8186.dtsi b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
> new file mode 100644
> index 000000000000..35281db2e2b9
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
> @@ -0,0 +1,1016 @@
> +// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +/*
> + * Copyright (C) 2022 MediaTek Inc.
> + * Author: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
> + */
> +/dts-v1/;
> +#include <dt-bindings/clock/mt8186-clk.h>
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/interrupt-controller/irq.h>
> +#include <dt-bindings/pinctrl/mt8186-pinfunc.h>
> +#include <dt-bindings/power/mt8186-power.h>
> +#include <dt-bindings/phy/phy.h>
> +#include <dt-bindings/reset/mt8186-resets.h>
> +
> +/ {
> +	compatible = "mediatek,mt8186";
> +	interrupt-parent = <&gic>;
> +	#address-cells = <2>;
> +	#size-cells = <2>;
> +
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +

..snip..

> +
> +		cpu0: cpu@0 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a55";
> +			reg = <0x000>;
> +			enable-method = "psci";
> +			clock-frequency = <2000000000>;
> +			capacity-dmips-mhz = <382>;
> +			cpu-idle-states = <&cpu_off_l &cluster_off_l>;
> +			next-level-cache = <&l2_0>;

No cooling cells?

> +		};
> +

..snip..


> +
> +	soc {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		compatible = "simple-bus";
> +		ranges;
> +
> +		gic: interrupt-controller@c000000 {
> +			compatible = "arm,gic-v3";
> +			#interrupt-cells = <3>;

You're describing PPI partitions below... even if you're not currently
planning to define PPI affinity just yet, interrupt cells should be 4
so that defining affinity will be pretty straightforward in the future.

Please change interrupt-cells to 4.

> +			#address-cells = <2>;
> +			#size-cells = <2>;
> +			#redistributor-regions = <1>;
> +			interrupt-parent = <&gic>;
> +			interrupt-controller;
> +			reg = <0 0x0c000000 0 0x40000>,
> +			      <0 0x0c040000 0 0x200000>;
> +			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
> +
> +			ppi-partitions {
> +				ppi_cluster0: interrupt-partition-0 {
> +					affinity = <&cpu0 &cpu1 &cpu2 &cpu3 &cpu4 &cpu5>;
> +				};
> +
> +				ppi_cluster1: interrupt-partition-1 {
> +					affinity = <&cpu6 &cpu7>;
> +				};
> +			};
> +		};
> +
> +		mcusys: syscon@c53a000 {
> +			compatible = "mediatek,mt8186-mcusys", "syscon";
> +			reg = <0 0xc53a000 0 0x1000>;
> +			#clock-cells = <1>;
> +		};
> +
> +		topckgen: syscon@10000000 {
> +			compatible = "mediatek,mt8186-topckgen", "syscon";
> +			reg = <0 0x10000000 0 0x1000>;
> +			#clock-cells = <1>;
> +		};
> +
> +		infracfg_ao: syscon@10001000 {
> +			compatible = "mediatek,mt8186-infracfg_ao", "syscon";
> +			reg = <0 0x10001000 0 0x1000>;
> +			#clock-cells = <1>;

You missed reset-cells here. This driver is also defining a reset controller.

> +		};
> +
> +		pericfg: syscon@10003000 {
> +			compatible = "mediatek,mt8186-pericfg", "syscon";
> +			reg = <0 0x10003000 0 0x1000>;
> +		};
> +
> +		pio: pinctrl@10005000 {
> +			compatible = "mediatek,mt8186-pinctrl";
> +			reg = <0 0x10005000 0 0x1000>,
> +			      <0 0x10002000 0 0x0200>,
> +			      <0 0x10002200 0 0x0200>,
> +			      <0 0x10002400 0 0x0200>,
> +			      <0 0x10002600 0 0x0200>,
> +			      <0 0x10002A00 0 0x0200>,
> +			      <0 0x10002C00 0 0x0200>,
> +			      <0 0x1000B000 0 0x1000>;
> +			reg-names = "iocfg0", "iocfg_lt", "iocfg_lm", "iocfg_lb",
> +				    "iocfg_bl", "iocfg_rb", "iocfg_rt", "eint";
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +			gpio-ranges = <&pio 0 0 185>;
> +			interrupt-controller;
> +			interrupts = <GIC_SPI 186 IRQ_TYPE_LEVEL_HIGH>;
> +			#interrupt-cells = <2>;
> +		};
> +
> +		scpsys: syscon@10006000 {
> +			compatible = "syscon", "simple-mfd";
> +			reg = <0 0x10006000 0 0x1000>;
> +			#power-domain-cells = <1>;
> +
> +			/* System Power Manager */
> +			spm: power-controller {
> +				compatible = "mediatek,mt8186-power-controller";
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				#power-domain-cells = <1>;
> +
> +				/* power domain of the SoC */
> +				mfg0: power-domain@MT8186_POWER_DOMAIN_MFG0 {
> +					reg = <MT8186_POWER_DOMAIN_MFG0>;
> +					clocks = <&topckgen CLK_TOP_MFG>;
> +					clock-names= "mfg00";

Missing space: `clock-names = "mfg00";`

> +					#address-cells = <1>;
> +					#size-cells = <0>;
> +					#power-domain-cells = <1>;
> +
> +					power-domain@MT8186_POWER_DOMAIN_MFG1 {
> +						reg = <MT8186_POWER_DOMAIN_MFG1>;
> +						mediatek,infracfg = <&infracfg_ao>;
> +						#address-cells = <1>;
> +						#size-cells = <0>;
> +						#power-domain-cells = <1>;
> +
> +						power-domain@MT8186_POWER_DOMAIN_MFG2 {
> +							reg = <MT8186_POWER_DOMAIN_MFG2>;
> +							#power-domain-cells = <0>;
> +						};
> +
> +						power-domain@MT8186_POWER_DOMAIN_MFG3 {
> +							reg = <MT8186_POWER_DOMAIN_MFG3>;
> +							#power-domain-cells = <0>;
> +						};
> +					};
> +				};
> +
> +				power-domain@MT8186_POWER_DOMAIN_CSIRX_TOP {
> +					reg = <MT8186_POWER_DOMAIN_CSIRX_TOP>;
> +					clocks = <&topckgen CLK_TOP_SENINF>,
> +						 <&topckgen CLK_TOP_SENINF1>;
> +					clock-names= "csirx_top0", "csirx_top1";

Same here.

> +					#power-domain-cells = <0>;
> +				};
> +
> +				power-domain@MT8186_POWER_DOMAIN_SSUSB {
> +					reg = <MT8186_POWER_DOMAIN_SSUSB>;
> +					#power-domain-cells = <0>;
> +				};
> +
> +				power-domain@MT8186_POWER_DOMAIN_SSUSB_P1 {
> +					reg = <MT8186_POWER_DOMAIN_SSUSB_P1>;
> +					#power-domain-cells = <0>;
> +				};
> +
> +				power-domain@MT8186_POWER_DOMAIN_ADSP_AO {
> +					reg = <MT8186_POWER_DOMAIN_ADSP_AO>;
> +					clocks = <&topckgen CLK_TOP_AUDIODSP>,
> +						 <&topckgen CLK_TOP_ADSP_BUS>;
> +					clock-names= "adsp_ao0", "adsp_ao1";

...and here, and everywhere else, please fix.

> +					#address-cells = <1>;
> +					#size-cells = <0>;
> +					#power-domain-cells = <1>;
> +

Regards,
Angelo


