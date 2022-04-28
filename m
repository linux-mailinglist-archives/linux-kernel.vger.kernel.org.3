Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22EDF513538
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 15:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347262AbiD1NgO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 09:36:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347227AbiD1NgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 09:36:06 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95C5E21274;
        Thu, 28 Apr 2022 06:32:51 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id BCEC41F458A0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1651152769;
        bh=/U63ACeQUirihMwLAXg7hRsWkkxF4fnAOZcyYxhREIo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=VAwCobX1tvMAfcq07elW+o6jf6vMrnFtj3SFVtm6XXgvep+Jcvdu3sRocW7vTpLIl
         y6Z13jOY/Y6yOh/8ylDW3yvp1rtfxPYPZYmADILgl6ECGVx8WGD3fjQP3GoeuQEk0s
         zywlw3BLloSE/4zj3xnwcLlwUchlvX4eMJTWMFYZQ5CJozsLWDtgMBHwoZyFMxIpHr
         kytepd1Rf4A21PNrC1aZn1dm0uMFTq7bD8jO/HaGyv4kDy30ZqZnZPmTLqsTlgDEUU
         medm6fH/o8RcYSUZ2HXQNAc08kj5GOCAj+lSNSsfxG2xGWNvEyJWr/MgpKYplfX9Qt
         99vRaBNp3U+KA==
Message-ID: <c60bf00a-340d-e1de-cabc-87535470c472@collabora.com>
Date:   Thu, 28 Apr 2022 15:32:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v8 2/2] arm64: dts: Add MediaTek SoC MT8186 dts and
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
References: <20220428061717.11197-1-allen-kh.cheng@mediatek.com>
 <20220428061717.11197-3-allen-kh.cheng@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220428061717.11197-3-allen-kh.cheng@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 28/04/22 08:17, Allen-KH Cheng ha scritto:
> Add basic chip support for MediaTek MT8186.
> 
> Signed-off-by: Allen-KH Cheng <Allen-KH.Cheng@mediatek.com>
> ---
>   arch/arm64/boot/dts/mediatek/Makefile       |   1 +
>   arch/arm64/boot/dts/mediatek/mt8186-evb.dts | 232 +++++
>   arch/arm64/boot/dts/mediatek/mt8186.dtsi    | 949 ++++++++++++++++++++
>   3 files changed, 1182 insertions(+)
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
> index 000000000000..6bf5b81e3e6b
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt8186-evb.dts
> @@ -0,0 +1,232 @@

..snip..

> +
> +&pio {
> +	i2c0_pins: i2c0{
> +		pins_bus {

No underscores please!

Either name this "pins-bus" or, more appropriately, I would give it a more
descriptive name, like "pins-sda-scl".

> +			pinmux = <PINMUX_GPIO128__FUNC_SDA0>,
> +				 <PINMUX_GPIO127__FUNC_SCL0>;
> +			bias-disable;
> +			mediatek,drive-strength-adv =<0>;
> +			drive-strength = <MTK_DRIVE_4mA>;
> +			input-enable;
> +		};
> +	};

..snip..

> diff --git a/arch/arm64/boot/dts/mediatek/mt8186.dtsi b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
> new file mode 100644
> index 000000000000..9e3d45f3e5de
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
> @@ -0,0 +1,949 @@
> +// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +/*
> + * Copyright (C) 2022 MediaTek Inc.
> + * Author: Allen-KH Cheng <allenn-kh.cheng@mediatek.com>

Uhm, you typoed your email address! :-)

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
> +		cpu0: cpu@0 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a55";
> +			reg = <0x000>;
> +			enable-method = "psci";
> +			clock-frequency = <2000000000>;

No capacity-dmips-mhz for the CPUs?!

> +			cpu-idle-states = <&cpu_off_l &cluster_off_l>;
> +			next-level-cache = <&l2_0>;
> +		};

..snip..

> +	soc {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		compatible = "simple-bus";
> +		ranges;
> +
> +		gic: interrupt-controller@c000000 {
> +			compatible = "arm,gic-v3";
> +			#interrupt-cells = <3>;
> +			#address-cells = <2>;
> +			#size-cells = <2>;
> +			#redistributor-regions = <1>;
> +			interrupt-parent = <&gic>;
> +			interrupt-controller;
> +			reg = <0 0x0c000000 0 0x40000>,
> +			      <0 0x0c040000 0 0x200000>;
> +			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;

Are there no ppi-partitions for this interrupt controller?

> +		};
> +

..snip..

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
> +				mfg0: mfg0@MT8186_POWER_DOMAIN_MFG0 {
This should be, for consistency with other mtk devicetrees:
     mfg0: power-domain@MT8186_POWER_DOMAIN_MFG0 {

> +					reg = <MT8186_POWER_DOMAIN_MFG0>;
> +					clocks = <&topckgen CLK_TOP_MFG>;
> +					clock-names= "mfg00";
> +					#address-cells = <1>;
> +					#size-cells = <0>;
> +					#power-domain-cells = <1>;
> +
> +					mfg1@MT8186_POWER_DOMAIN_MFG1 {

power-domain@MT8186_POWER_DOMAIN_MFG1

....and the same for all of the other occurrences.

> +						reg = <MT8186_POWER_DOMAIN_MFG1>;
> +						mediatek,infracfg = <&infracfg_ao>;
> +						#address-cells = <1>;
> +						#size-cells = <0>;
> +						#power-domain-cells = <1>;

..snip..

> +
> +		scp: scp@10500000 {
> +			compatible = "mediatek,mt8186-scp";
> +			reg = <0 0x10500000 0 0x40000>,
> +			      <0 0x105c0000 0 0x19080>;
> +			reg-names = "sram", "cfg";
> +			interrupts = <GIC_SPI 205 IRQ_TYPE_LEVEL_HIGH>;
> +			status = "okay";

`status = "okay"` can be omitted here: all the nodes are enabled by default.

> +		};
> +

Cheers,
Angelo
