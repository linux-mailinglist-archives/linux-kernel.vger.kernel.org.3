Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 823905A4EC9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 16:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbiH2OFp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 10:05:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbiH2OFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 10:05:40 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3C941EED7;
        Mon, 29 Aug 2022 07:05:36 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id bu22so10003518wrb.3;
        Mon, 29 Aug 2022 07:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=YxsYn+lNRh28WAAaj7+kTAdJR39vJUyrCXp+vk6Cvh0=;
        b=ggPGeRILlPiMSePQL7ORMuW5XsJGdCQ9fgx6nY0DOVAmSDa0Rn53XVxOdN8K1/yufo
         UOHQjmHv0xlk/VECFGYMZbeVTPtbNyAJy35xbktNo88CDZ3HSilUuFwrTtakLb7elvBB
         hsy3S9iLqtDVKLzyvOzBqIYk98m2xPk/ZzwryuVgUUvmB5zIuWIcFoKgrFT5cW717XjU
         sLIE0lRNf1tXnOsANHBnxVrkYOVyOhsjjiRDOFurln8KvqJ2ztJeeLT/EuxdxhKMcZyj
         yO2PkLPRHoHI8FyCKyNFYCzGldjDGM2qtllfwKtzb1ChGIuLyjgBbKVu4yB3l2Z3lObZ
         NSOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=YxsYn+lNRh28WAAaj7+kTAdJR39vJUyrCXp+vk6Cvh0=;
        b=E8ewN1rHWVAEudcGnAHy9wbd63yfzALHOBDr1+qHzVCw4ApAfRYMB4y+qvSzyxfdQA
         nVwcirm7Xh2/Sdym6Jbvr7FrdXH9VU5D/mO4kaBq6F/dtIjToT1EeADfwvNBOHIU1Znx
         fzrOqibAUxS4qfyMwi4+vLhjJRbZbs0NgEwYoDo197yXZI7/XCXjT68CntVT2rNp24GT
         3/yjerKWK9Fy7kUHopeJOnpe2Da2iN26k4q+QM/7BNDb4t+jTVYgQxV++uBVU0o4TLvg
         0ifm1jpLc2nAn9+svGQ66CWdWpvhZqb7rLAkmmEYzNCe4pc3FtcojdkfqouXKKAmxF3t
         hLeQ==
X-Gm-Message-State: ACgBeo2Nsag9OvKCEjNg+J7qWDE3/Rn2/a0vP3VeF3loS2teoiNx0uOq
        TaOdqpDZrYYt9NXDq5EnQ+w=
X-Google-Smtp-Source: AA6agR45fAMygFUsjMuGLnBHhqEQSEMVz/zRZrLQl5/AjXjCCnfwp1TJFlJNP8Al4v6jRE0NkbZj3A==
X-Received: by 2002:a5d:4fcf:0:b0:226:d82f:c424 with SMTP id h15-20020a5d4fcf000000b00226d82fc424mr3726615wrw.167.1661781935138;
        Mon, 29 Aug 2022 07:05:35 -0700 (PDT)
Received: from [192.168.0.30] ([47.62.125.55])
        by smtp.gmail.com with ESMTPSA id w17-20020a5d6091000000b002237fd66585sm7109376wrt.92.2022.08.29.07.05.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Aug 2022 07:05:34 -0700 (PDT)
Message-ID: <2b18cddc-ae76-fb80-6def-b31d641e74be@gmail.com>
Date:   Mon, 29 Aug 2022 16:05:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH v15] arm64: dts: Add MediaTek MT8186 dts and evaluation
 board and Makefile
Content-Language: en-US
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Chen-Yu Tsai <wenst@chromium.org>, hsinyi@chromium.org
References: <20220825170448.17024-1-allen-kh.cheng@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220825170448.17024-1-allen-kh.cheng@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 25/08/2022 19:04, Allen-KH Cheng wrote:
> MT8186 is a SoC based on 64bit ARMv8 architecture. It contains 6 CA55
> and 2 CA76 cores. MT8186 share many HW IP with MT65xx series.
> 
> We add basic chip support for MediaTek MT8186 on evaluation board.
> 
> Signed-off-by: Allen-KH Cheng <Allen-KH.Cheng@mediatek.com>
> 

Applied, thanks!

> ---
> changes since v14:
>   - add some descriptiona for mt8186
>   - remove xhci nodes
>   - correct clk order in pinctrl node from [1]
> [1] https://lore.kernel.org/r/20220819120649.21523-1-allen-kh.cheng@mediatek.com
> 
> changes since v13:
>   - use "mediatek,mt8186-wdt", "mediatek,mt6589-wdt" in wdt node
>   - remove dsi node
> 
> changes since v12:
>   - remove drive-strength fom i2c pins
>   - use lowercase hex addresses in pinctrl node
>   - correct clk order in xhci0
>   - add clk26m for dma_ck
> 
> changes since v11:
>   - add #cooling-cells in cpu nodes
>   - add pmu nodes for mt8186
>   - change #interrupt-cells from 3 to 4
>   - correct interrupts property in each nodes for 4 interrupt cells
>   - remove power domains controller node
>   - move #address-cells and #size-cells into mt8186.dts
>   - remove unused ahb_cg clock in mmc0
>   - add efuse node
>   - add dsi node and remove dpi node
>   - move i2c status position in mt8186-evb.dts
>   - change i2c child nodee name in pio node to *-pins
>   - change property from mediatek,drive-strength-adv to drive-strength-microamp in i2c child nodes of pio
>   - change drive-strength value from MTK_DRIVE_4mA to 4 in i2c child nodes of pio
>   - change i2c child nodes from pins-sda-sc1 to pins-bus
>   - correct pintctrl clk names
> 
> changes since v10:
>   - remove merged PATCHes
>   - add pmu nodes
>   - add #cooling-cells
>   - change #interrupt-cells number from 3 to 4
>   - remove power domains controller node
>   - move #address-cells/#size-cells into mt8186.dts from evb dts for i2c
>   - move status = 'okay' position in i2cx
>   - fix pinctrl patternproperties name in pio
>   - add efuse node
>   - fix dsi node
>   - add #reset-cells in infracfg_ao: syscon
> 
> changes since v9:
>   - remove some merged PATCHs from series
>   - reorder nodes in dts (cpu-map)
>   - remove okay status in auxadc
>   - remove unnecessary suffix node name for i2c
>   - add pwm node
>   - add dsi-phy node
>   - add dpi node
> 
> changes since v9:
>   - add one space before equal sign of drive-strength-adv
>   - corect compatible name for big cores (ca76)
>   - use upper case of address in pinctrl
>   - add pwrap node
>   - add pwm node
> 
> changes since v8:
>   - change name from pins_bus to pins-sda-scl
>   - correct email address
>   - add capacity-dmips-mhz for each CPU
>   - add ppi-partitions in gic node
>   - change name to power-domain
>   - remove status "okay" in scp node
>   - update timer and pericfg compatible in series
> 
> changes since v7:
>   - add scp&auxadc node
> 
> changes since v6:
>   - remove unnecessary blank line
> 
> changes since v5:
>   - replace Mediatek a to MediaTek
>   - use GPL-2.0-only OR BSD-2-Clause
> 
> changes since v4:
>   - correct driver clock of mt8186
>   - add power domains controller and clock controllers
>   - add pinctrl, usb host, spi and i2c nodes
>   - add node status in mt8186-evb.dts
>   - correct some dtbs_check warnings
> 
> changes since v3:
>   - remove serial, mmc and phy patch from series. (already merged)
>   - remove mcusysoff node
>   - move oscillator nodes at the head of dts
>   - change name from usb-phy to t-phy
> 
> changes since v2:
>   - add soc {} in mt8186.dtsi
> 
> changes since v1:
>   - add dt-bindings: arm: Add compatible for MediaTek MT8186
> [Allen-KH Cheng <allen-kh.cheng@mediatek.com>]
> ---
> ---
>   arch/arm64/boot/dts/mediatek/Makefile       |   1 +
>   arch/arm64/boot/dts/mediatek/mt8186-evb.dts | 220 ++++++
>   arch/arm64/boot/dts/mediatek/mt8186.dtsi    | 819 ++++++++++++++++++++
>   3 files changed, 1040 insertions(+)
>   create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-evb.dts
>   create mode 100644 arch/arm64/boot/dts/mediatek/mt8186.dtsi
> 
> diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
> index af362a085a02..0ec90cb3ef28 100644
> --- a/arch/arm64/boot/dts/mediatek/Makefile
> +++ b/arch/arm64/boot/dts/mediatek/Makefile
> @@ -37,6 +37,7 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-kodama-sku32.dtb
>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-krane-sku0.dtb
>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-krane-sku176.dtb
>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-pumpkin.dtb
> +dtb-$(CONFIG_ARCH_MEDIATEK) += mt8186-evb.dtb
>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt8192-asurada-hayato-r1.dtb
>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt8192-asurada-spherion-r0.dtb
>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt8192-evb.dtb
> diff --git a/arch/arm64/boot/dts/mediatek/mt8186-evb.dts b/arch/arm64/boot/dts/mediatek/mt8186-evb.dts
> new file mode 100644
> index 000000000000..ed74a3617c13
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt8186-evb.dts
> @@ -0,0 +1,220 @@
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
> +	memory@40000000 {
> +		device_type = "memory";
> +		reg = <0 0x40000000 0 0x80000000>;
> +	};
> +};
> +
> +&i2c0 {
> +	status = "okay";
> +
> +	clock-frequency = <400000>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c0_pins>;
> +};
> +
> +&i2c1 {
> +	status = "okay";
> +
> +	clock-frequency = <400000>;
> +	i2c-scl-internal-delay-ns = <8000>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c1_pins>;
> +};
> +
> +&i2c2 {
> +	status = "okay";
> +
> +	clock-frequency = <400000>;
> +	i2c-scl-internal-delay-ns = <10000>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c2_pins>;
> +};
> +
> +&i2c3 {
> +	status = "okay";
> +
> +	clock-frequency = <400000>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c3_pins>;
> +};
> +
> +&i2c4 {
> +	status = "okay";
> +
> +	clock-frequency = <400000>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c4_pins>;
> +};
> +
> +&i2c5 {
> +	status = "okay";
> +
> +	clock-frequency = <400000>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c5_pins>;
> +};
> +
> +&i2c6 {
> +	status = "okay";
> +
> +	clock-frequency = <400000>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c6_pins>;
> +};
> +
> +&i2c7 {
> +	status = "okay";
> +
> +	clock-frequency = <400000>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c7_pins>;
> +};
> +
> +&i2c8 {
> +	status = "okay";
> +
> +	clock-frequency = <400000>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c8_pins>;
> +};
> +
> +&i2c9 {
> +	status = "okay";
> +
> +	clock-frequency = <400000>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c9_pins>;
> +};
> +
> +&pio {
> +	i2c0_pins: i2c0-default-pins {
> +		pins-bus {
> +			pinmux = <PINMUX_GPIO128__FUNC_SDA0>,
> +				 <PINMUX_GPIO127__FUNC_SCL0>;
> +			bias-disable;
> +			drive-strength-microamp = <1000>;
> +			input-enable;
> +		};
> +	};
> +
> +	i2c1_pins: i2c1-default-pins {
> +		pins-bus {
> +			pinmux = <PINMUX_GPIO130__FUNC_SDA1>,
> +				 <PINMUX_GPIO129__FUNC_SCL1>;
> +			bias-disable;
> +			drive-strength-microamp = <1000>;
> +			input-enable;
> +		};
> +	};
> +
> +	i2c2_pins: i2c2-default-pins {
> +		pins-bus {
> +			pinmux = <PINMUX_GPIO132__FUNC_SDA2>,
> +				 <PINMUX_GPIO131__FUNC_SCL2>;
> +			bias-disable;
> +			drive-strength-microamp = <1000>;
> +			input-enable;
> +		};
> +	};
> +
> +	i2c3_pins: i2c3-default-pins {
> +		pins-bus {
> +			pinmux = <PINMUX_GPIO134__FUNC_SDA3>,
> +				 <PINMUX_GPIO133__FUNC_SCL3>;
> +			bias-disable;
> +			drive-strength-microamp = <1000>;
> +			input-enable;
> +		};
> +	};
> +
> +	i2c4_pins: i2c4-default-pins {
> +		pins-bus {
> +			pinmux = <PINMUX_GPIO136__FUNC_SDA4>,
> +				 <PINMUX_GPIO135__FUNC_SCL4>;
> +			bias-disable;
> +			drive-strength-microamp = <1000>;
> +			input-enable;
> +		};
> +	};
> +
> +	i2c5_pins: i2c5-default-pins {
> +		pins-bus {
> +			pinmux = <PINMUX_GPIO138__FUNC_SDA5>,
> +				 <PINMUX_GPIO137__FUNC_SCL5>;
> +			bias-disable;
> +			drive-strength-microamp = <1000>;
> +			input-enable;
> +		};
> +	};
> +
> +	i2c6_pins: i2c6-default-pins {
> +		pins-bus {
> +			pinmux = <PINMUX_GPIO140__FUNC_SDA6>,
> +				 <PINMUX_GPIO139__FUNC_SCL6>;
> +			bias-pull-up = <MTK_PULL_SET_RSEL_001>;
> +			drive-strength-microamp = <1000>;
> +			input-enable;
> +		};
> +	};
> +
> +	i2c7_pins: i2c7-default-pins {
> +		pins-bus {
> +			pinmux = <PINMUX_GPIO142__FUNC_SDA7>,
> +				 <PINMUX_GPIO141__FUNC_SCL7>;
> +			bias-disable;
> +			drive-strength-microamp = <1000>;
> +			input-enable;
> +		};
> +	};
> +
> +	i2c8_pins: i2c8-default-pins {
> +		pins-bus {
> +			pinmux = <PINMUX_GPIO144__FUNC_SDA8>,
> +				 <PINMUX_GPIO143__FUNC_SCL8>;
> +			bias-disable;
> +			drive-strength-microamp = <1000>;
> +			input-enable;
> +		};
> +	};
> +
> +	i2c9_pins: i2c9-default-pins {
> +		pins-bus {
> +			pinmux = <PINMUX_GPIO146__FUNC_SDA9>,
> +				 <PINMUX_GPIO145__FUNC_SCL9>;
> +			bias-pull-up = <MTK_PULL_SET_RSEL_001>;
> +			drive-strength-microamp = <1000>;
> +			input-enable;
> +		};
> +	};
> +};
> +
> +&u3phy0 {
> +	status = "okay";
> +};
> +
> +&u3phy1 {
> +	status = "okay";
> +};
> +
> +&uart0 {
> +	status = "okay";
> +};
> diff --git a/arch/arm64/boot/dts/mediatek/mt8186.dtsi b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
> new file mode 100644
> index 000000000000..64693c17af9e
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
> @@ -0,0 +1,819 @@
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
> +		cpu-map {
> +			cluster0 {
> +				core0 {
> +					cpu = <&cpu0>;
> +				};
> +
> +				core1 {
> +					cpu = <&cpu1>;
> +				};
> +
> +				core2 {
> +					cpu = <&cpu2>;
> +				};
> +
> +				core3 {
> +					cpu = <&cpu3>;
> +				};
> +
> +				core4 {
> +					cpu = <&cpu4>;
> +				};
> +
> +				core5 {
> +					cpu = <&cpu5>;
> +				};
> +			};
> +
> +			cluster1 {
> +				core0 {
> +					cpu = <&cpu6>;
> +				};
> +
> +				core1 {
> +					cpu = <&cpu7>;
> +				};
> +			};
> +		};
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
> +			#cooling-cells = <2>;
> +		};
> +
> +		cpu1: cpu@100 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a55";
> +			reg = <0x100>;
> +			enable-method = "psci";
> +			clock-frequency = <2000000000>;
> +			capacity-dmips-mhz = <382>;
> +			cpu-idle-states = <&cpu_off_l &cluster_off_l>;
> +			next-level-cache = <&l2_0>;
> +			#cooling-cells = <2>;
> +		};
> +
> +		cpu2: cpu@200 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a55";
> +			reg = <0x200>;
> +			enable-method = "psci";
> +			clock-frequency = <2000000000>;
> +			capacity-dmips-mhz = <382>;
> +			cpu-idle-states = <&cpu_off_l &cluster_off_l>;
> +			next-level-cache = <&l2_0>;
> +			#cooling-cells = <2>;
> +		};
> +
> +		cpu3: cpu@300 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a55";
> +			reg = <0x300>;
> +			enable-method = "psci";
> +			clock-frequency = <2000000000>;
> +			capacity-dmips-mhz = <382>;
> +			cpu-idle-states = <&cpu_off_l &cluster_off_l>;
> +			next-level-cache = <&l2_0>;
> +			#cooling-cells = <2>;
> +		};
> +
> +		cpu4: cpu@400 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a55";
> +			reg = <0x400>;
> +			enable-method = "psci";
> +			clock-frequency = <2000000000>;
> +			capacity-dmips-mhz = <382>;
> +			cpu-idle-states = <&cpu_off_l &cluster_off_l>;
> +			next-level-cache = <&l2_0>;
> +			#cooling-cells = <2>;
> +		};
> +
> +		cpu5: cpu@500 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a55";
> +			reg = <0x500>;
> +			enable-method = "psci";
> +			clock-frequency = <2000000000>;
> +			capacity-dmips-mhz = <382>;
> +			cpu-idle-states = <&cpu_off_l &cluster_off_l>;
> +			next-level-cache = <&l2_0>;
> +			#cooling-cells = <2>;
> +		};
> +
> +		cpu6: cpu@600 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a76";
> +			reg = <0x600>;
> +			enable-method = "psci";
> +			clock-frequency = <2050000000>;
> +			capacity-dmips-mhz = <1024>;
> +			cpu-idle-states = <&cpu_off_b &cluster_off_b>;
> +			next-level-cache = <&l2_1>;
> +			#cooling-cells = <2>;
> +		};
> +
> +		cpu7: cpu@700 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a76";
> +			reg = <0x700>;
> +			enable-method = "psci";
> +			clock-frequency = <2050000000>;
> +			capacity-dmips-mhz = <1024>;
> +			cpu-idle-states = <&cpu_off_b &cluster_off_b>;
> +			next-level-cache = <&l2_1>;
> +			#cooling-cells = <2>;
> +		};
> +
> +		idle-states {
> +			entry-method = "psci";
> +
> +			cpu_off_l: cpu-off-l {
> +				compatible = "arm,idle-state";
> +				arm,psci-suspend-param = <0x00010001>;
> +				local-timer-stop;
> +				entry-latency-us = <50>;
> +				exit-latency-us = <100>;
> +				min-residency-us = <1600>;
> +			};
> +
> +			cpu_off_b: cpu-off-b {
> +				compatible = "arm,idle-state";
> +				arm,psci-suspend-param = <0x00010001>;
> +				local-timer-stop;
> +				entry-latency-us = <50>;
> +				exit-latency-us = <100>;
> +				min-residency-us = <1400>;
> +			};
> +
> +			cluster_off_l: cluster-off-l {
> +				compatible = "arm,idle-state";
> +				arm,psci-suspend-param = <0x01010001>;
> +				local-timer-stop;
> +				entry-latency-us = <100>;
> +				exit-latency-us = <250>;
> +				min-residency-us = <2100>;
> +			};
> +
> +			cluster_off_b: cluster-off-b {
> +				compatible = "arm,idle-state";
> +				arm,psci-suspend-param = <0x01010001>;
> +				local-timer-stop;
> +				entry-latency-us = <100>;
> +				exit-latency-us = <250>;
> +				min-residency-us = <1900>;
> +			};
> +		};
> +
> +		l2_0: l2-cache0 {
> +			compatible = "cache";
> +			next-level-cache = <&l3_0>;
> +		};
> +
> +		l2_1: l2-cache1 {
> +			compatible = "cache";
> +			next-level-cache = <&l3_0>;
> +		};
> +
> +		l3_0: l3-cache {
> +			compatible = "cache";
> +		};
> +	};
> +
> +	clk13m: oscillator-13m {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <13000000>;
> +		clock-output-names = "clk13m";
> +	};
> +
> +	clk26m: oscillator-26m {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <26000000>;
> +		clock-output-names = "clk26m";
> +	};
> +
> +	clk32k: oscillator-32k {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <32768>;
> +		clock-output-names = "clk32k";
> +	};
> +
> +	pmu-a55 {
> +		compatible = "arm,cortex-a55-pmu";
> +		interrupt-parent = <&gic>;
> +		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_HIGH &ppi_cluster0>;
> +	};
> +
> +	pmu-a76 {
> +		compatible = "arm,cortex-a76-pmu";
> +		interrupt-parent = <&gic>;
> +		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_HIGH &ppi_cluster1>;
> +	};
> +
> +	psci {
> +		compatible = "arm,psci-1.0";
> +		method = "smc";
> +	};
> +
> +	timer {
> +		compatible = "arm,armv8-timer";
> +		interrupt-parent = <&gic>;
> +		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW 0>,
> +			     <GIC_PPI 14 IRQ_TYPE_LEVEL_LOW 0>,
> +			     <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW 0>,
> +			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW 0>;
> +	};
> +
> +	soc {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		compatible = "simple-bus";
> +		ranges;
> +
> +		gic: interrupt-controller@c000000 {
> +			compatible = "arm,gic-v3";
> +			#interrupt-cells = <4>;
> +			#redistributor-regions = <1>;
> +			interrupt-parent = <&gic>;
> +			interrupt-controller;
> +			reg = <0 0x0c000000 0 0x40000>,
> +			      <0 0x0c040000 0 0x200000>;
> +			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH 0>;
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
> +			#reset-cells = <1>;
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
> +			      <0 0x10002a00 0 0x0200>,
> +			      <0 0x10002c00 0 0x0200>,
> +			      <0 0x1000b000 0 0x1000>;
> +			reg-names = "iocfg0", "iocfg_lt", "iocfg_lm", "iocfg_lb",
> +				    "iocfg_bl", "iocfg_rb", "iocfg_rt", "eint";
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +			gpio-ranges = <&pio 0 0 185>;
> +			interrupt-controller;
> +			interrupts = <GIC_SPI 186 IRQ_TYPE_LEVEL_HIGH 0>;
> +			#interrupt-cells = <2>;
> +		};
> +
> +		watchdog: watchdog@10007000 {
> +			compatible = "mediatek,mt8186-wdt",
> +				     "mediatek,mt6589-wdt";
> +			mediatek,disable-extrst;
> +			reg = <0 0x10007000 0 0x1000>;
> +			#reset-cells = <1>;
> +		};
> +
> +		apmixedsys: syscon@1000c000 {
> +			compatible = "mediatek,mt8186-apmixedsys", "syscon";
> +			reg = <0 0x1000c000 0 0x1000>;
> +			#clock-cells = <1>;
> +		};
> +
> +		pwrap: pwrap@1000d000 {
> +			compatible = "mediatek,mt8186-pwrap", "syscon";
> +			reg = <0 0x1000d000 0 0x1000>;
> +			reg-names = "pwrap";
> +			interrupts = <GIC_SPI 194 IRQ_TYPE_LEVEL_HIGH 0>;
> +			clocks = <&infracfg_ao CLK_INFRA_AO_PMIC_AP>,
> +				 <&infracfg_ao CLK_INFRA_AO_PMIC_TMR>;
> +			clock-names = "spi", "wrap";
> +		};
> +
> +		systimer: timer@10017000 {
> +			compatible = "mediatek,mt8186-timer",
> +				     "mediatek,mt6765-timer";
> +			reg = <0 0x10017000 0 0x1000>;
> +			interrupts = <GIC_SPI 207 IRQ_TYPE_LEVEL_HIGH 0>;
> +			clocks = <&clk13m>;
> +		};
> +
> +		scp: scp@10500000 {
> +			compatible = "mediatek,mt8186-scp";
> +			reg = <0 0x10500000 0 0x40000>,
> +			      <0 0x105c0000 0 0x19080>;
> +			reg-names = "sram", "cfg";
> +			interrupts = <GIC_SPI 205 IRQ_TYPE_LEVEL_HIGH 0>;
> +		};
> +
> +		nor_flash: spi@11000000 {
> +			compatible = "mediatek,mt8186-nor";
> +			reg = <0 0x11000000 0 0x1000>;
> +			clocks = <&topckgen CLK_TOP_SPINOR>,
> +				 <&infracfg_ao CLK_INFRA_AO_SPINOR>,
> +				 <&infracfg_ao CLK_INFRA_AO_FLASHIF_133M>,
> +				 <&infracfg_ao CLK_INFRA_AO_FLASHIF_66M>;
> +			clock-names = "spi", "sf", "axi", "axi_s";
> +			assigned-clocks = <&topckgen CLK_TOP_SPINOR>;
> +			assigned-clock-parents = <&topckgen CLK_TOP_UNIVPLL_D3_D8>;
> +			interrupts = <GIC_SPI 293 IRQ_TYPE_LEVEL_HIGH 0>;
> +			status = "disabled";
> +		};
> +
> +		auxadc: adc@11001000 {
> +			compatible = "mediatek,mt8186-auxadc", "mediatek,mt8173-auxadc";
> +			reg = <0 0x11001000 0 0x1000>;
> +			#io-channel-cells = <1>;
> +			clocks = <&infracfg_ao CLK_INFRA_AO_AUXADC>;
> +			clock-names = "main";
> +		};
> +
> +		uart0: serial@11002000 {
> +			compatible = "mediatek,mt8186-uart",
> +				     "mediatek,mt6577-uart";
> +			reg = <0 0x11002000 0 0x1000>;
> +			interrupts = <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH 0>;
> +			clocks = <&clk26m>, <&infracfg_ao CLK_INFRA_AO_UART0>;
> +			clock-names = "baud", "bus";
> +			status = "disabled";
> +		};
> +
> +		uart1: serial@11003000 {
> +			compatible = "mediatek,mt8186-uart",
> +				     "mediatek,mt6577-uart";
> +			reg = <0 0x11003000 0 0x1000>;
> +			interrupts = <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH 0>;
> +			clocks = <&clk26m>, <&infracfg_ao CLK_INFRA_AO_UART1>;
> +			clock-names = "baud", "bus";
> +			status = "disabled";
> +		};
> +
> +		i2c0: i2c@11007000 {
> +			compatible = "mediatek,mt8186-i2c";
> +			reg = <0 0x11007000 0 0x1000>,
> +			      <0 0x10200100 0 0x100>;
> +			interrupts = <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH 0>;
> +			clocks = <&imp_iic_wrap CLK_IMP_IIC_WRAP_AP_CLOCK_I2C0>,
> +				 <&infracfg_ao CLK_INFRA_AO_AP_DMA>;
> +			clock-names = "main", "dma";
> +			clock-div = <1>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			status = "disabled";
> +		};
> +
> +		i2c1: i2c@11008000 {
> +			compatible = "mediatek,mt8186-i2c";
> +			reg = <0 0x11008000 0 0x1000>,
> +			      <0 0x10200200 0 0x100>;
> +			interrupts = <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH 0>;
> +			clocks = <&imp_iic_wrap CLK_IMP_IIC_WRAP_AP_CLOCK_I2C1>,
> +				 <&infracfg_ao CLK_INFRA_AO_AP_DMA>;
> +			clock-names = "main", "dma";
> +			clock-div = <1>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			status = "disabled";
> +		};
> +
> +		i2c2: i2c@11009000 {
> +			compatible = "mediatek,mt8186-i2c";
> +			reg = <0 0x11009000 0 0x1000>,
> +			      <0 0x10200300 0 0x180>;
> +			interrupts = <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH 0>;
> +			clocks = <&imp_iic_wrap CLK_IMP_IIC_WRAP_AP_CLOCK_I2C2>,
> +				 <&infracfg_ao CLK_INFRA_AO_AP_DMA>;
> +			clock-names = "main", "dma";
> +			clock-div = <1>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			status = "disabled";
> +		};
> +
> +		i2c3: i2c@1100f000 {
> +			compatible = "mediatek,mt8186-i2c";
> +			reg = <0 0x1100f000 0 0x1000>,
> +			      <0 0x10200480 0 0x100>;
> +			interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH 0>;
> +			clocks = <&imp_iic_wrap CLK_IMP_IIC_WRAP_AP_CLOCK_I2C3>,
> +				 <&infracfg_ao CLK_INFRA_AO_AP_DMA>;
> +			clock-names = "main", "dma";
> +			clock-div = <1>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			status = "disabled";
> +		};
> +
> +		i2c4: i2c@11011000 {
> +			compatible = "mediatek,mt8186-i2c";
> +			reg = <0 0x11011000 0 0x1000>,
> +			      <0 0x10200580 0 0x180>;
> +			interrupts = <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH 0>;
> +			clocks = <&imp_iic_wrap CLK_IMP_IIC_WRAP_AP_CLOCK_I2C4>,
> +				 <&infracfg_ao CLK_INFRA_AO_AP_DMA>;
> +			clock-names = "main", "dma";
> +			clock-div = <1>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			status = "disabled";
> +		};
> +
> +		i2c5: i2c@11016000 {
> +			compatible = "mediatek,mt8186-i2c";
> +			reg = <0 0x11016000 0 0x1000>,
> +			      <0 0x10200700 0 0x100>;
> +			interrupts = <GIC_SPI 354 IRQ_TYPE_LEVEL_HIGH 0>;
> +			clocks = <&imp_iic_wrap CLK_IMP_IIC_WRAP_AP_CLOCK_I2C5>,
> +				 <&infracfg_ao CLK_INFRA_AO_AP_DMA>;
> +			clock-names = "main", "dma";
> +			clock-div = <1>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			status = "disabled";
> +		};
> +
> +		i2c6: i2c@1100d000 {
> +			compatible = "mediatek,mt8186-i2c";
> +			reg = <0 0x1100d000 0 0x1000>,
> +			      <0 0x10200800 0 0x100>;
> +			interrupts = <GIC_SPI 355 IRQ_TYPE_LEVEL_HIGH 0>;
> +			clocks = <&imp_iic_wrap CLK_IMP_IIC_WRAP_AP_CLOCK_I2C6>,
> +				 <&infracfg_ao CLK_INFRA_AO_AP_DMA>;
> +			clock-names = "main", "dma";
> +			clock-div = <1>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			status = "disabled";
> +		};
> +
> +		i2c7: i2c@11004000 {
> +			compatible = "mediatek,mt8186-i2c";
> +			reg = <0 0x11004000 0 0x1000>,
> +			      <0 0x10200900 0 0x180>;
> +			interrupts = <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH 0>;
> +			clocks = <&imp_iic_wrap CLK_IMP_IIC_WRAP_AP_CLOCK_I2C7>,
> +				 <&infracfg_ao CLK_INFRA_AO_AP_DMA>;
> +			clock-names = "main", "dma";
> +			clock-div = <1>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			status = "disabled";
> +		};
> +
> +		i2c8: i2c@11005000 {
> +			compatible = "mediatek,mt8186-i2c";
> +			reg = <0 0x11005000 0 0x1000>,
> +			      <0 0x10200A80 0 0x180>;
> +			interrupts = <GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH 0>;
> +			clocks = <&imp_iic_wrap CLK_IMP_IIC_WRAP_AP_CLOCK_I2C8>,
> +				 <&infracfg_ao CLK_INFRA_AO_AP_DMA>;
> +			clock-names = "main", "dma";
> +			clock-div = <1>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			status = "disabled";
> +		};
> +
> +		spi0: spi@1100a000 {
> +			compatible = "mediatek,mt8186-spi", "mediatek,mt6765-spi";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <0 0x1100a000 0 0x1000>;
> +			interrupts = <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH 0>;
> +			clocks = <&topckgen CLK_TOP_MAINPLL_D5>,
> +				 <&topckgen CLK_TOP_SPI>,
> +				 <&infracfg_ao CLK_INFRA_AO_SPI0>;
> +			clock-names = "parent-clk", "sel-clk", "spi-clk";
> +			status = "disabled";
> +		};
> +
> +		pwm0: pwm@1100e000 {
> +			compatible = "mediatek,mt8186-disp-pwm", "mediatek,mt8183-disp-pwm";
> +			reg = <0 0x1100e000 0 0x1000>;
> +			interrupts = <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH 0>;
> +			#pwm-cells = <2>;
> +			clocks = <&topckgen CLK_TOP_DISP_PWM>,
> +				 <&infracfg_ao CLK_INFRA_AO_DISP_PWM>;
> +			clock-names = "main", "mm";
> +			status = "disabled";
> +		};
> +
> +		spi1: spi@11010000 {
> +			compatible = "mediatek,mt8186-spi", "mediatek,mt6765-spi";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <0 0x11010000 0 0x1000>;
> +			interrupts = <GIC_SPI 139 IRQ_TYPE_LEVEL_HIGH 0>;
> +			clocks = <&topckgen CLK_TOP_MAINPLL_D5>,
> +				 <&topckgen CLK_TOP_SPI>,
> +				 <&infracfg_ao CLK_INFRA_AO_SPI1>;
> +			clock-names = "parent-clk", "sel-clk", "spi-clk";
> +			status = "disabled";
> +		};
> +
> +		spi2: spi@11012000 {
> +			compatible = "mediatek,mt8186-spi", "mediatek,mt6765-spi";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <0 0x11012000 0 0x1000>;
> +			interrupts = <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH 0>;
> +			clocks = <&topckgen CLK_TOP_MAINPLL_D5>,
> +				 <&topckgen CLK_TOP_SPI>,
> +				 <&infracfg_ao CLK_INFRA_AO_SPI2>;
> +			clock-names = "parent-clk", "sel-clk", "spi-clk";
> +			status = "disabled";
> +		};
> +
> +		spi3: spi@11013000 {
> +			compatible = "mediatek,mt8186-spi", "mediatek,mt6765-spi";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <0 0x11013000 0 0x1000>;
> +			interrupts = <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH 0>;
> +			clocks = <&topckgen CLK_TOP_MAINPLL_D5>,
> +				 <&topckgen CLK_TOP_SPI>,
> +				 <&infracfg_ao CLK_INFRA_AO_SPI3>;
> +			clock-names = "parent-clk", "sel-clk", "spi-clk";
> +			status = "disabled";
> +		};
> +
> +		spi4: spi@11014000 {
> +			compatible = "mediatek,mt8186-spi", "mediatek,mt6765-spi";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <0 0x11014000 0 0x1000>;
> +			interrupts = <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH 0>;
> +			clocks = <&topckgen CLK_TOP_MAINPLL_D5>,
> +				 <&topckgen CLK_TOP_SPI>,
> +				 <&infracfg_ao CLK_INFRA_AO_SPI4>;
> +			clock-names = "parent-clk", "sel-clk", "spi-clk";
> +			status = "disabled";
> +		};
> +
> +		spi5: spi@11015000 {
> +			compatible = "mediatek,mt8186-spi", "mediatek,mt6765-spi";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <0 0x11015000 0 0x1000>;
> +			interrupts = <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH 0>;
> +			clocks = <&topckgen CLK_TOP_MAINPLL_D5>,
> +				 <&topckgen CLK_TOP_SPI>,
> +				 <&infracfg_ao CLK_INFRA_AO_SPI5>;
> +			clock-names = "parent-clk", "sel-clk", "spi-clk";
> +			status = "disabled";
> +		};
> +
> +		imp_iic_wrap: clock-controller@11017000 {
> +			compatible = "mediatek,mt8186-imp_iic_wrap";
> +			reg = <0 0x11017000 0 0x1000>;
> +			#clock-cells = <1>;
> +		};
> +
> +		uart2: serial@11018000 {
> +			compatible = "mediatek,mt8186-uart",
> +				     "mediatek,mt6577-uart";
> +			reg = <0 0x11018000 0 0x1000>;
> +			interrupts = <GIC_SPI 246 IRQ_TYPE_LEVEL_HIGH 0>;
> +			clocks = <&clk26m>, <&infracfg_ao CLK_INFRA_AO_UART2>;
> +			clock-names = "baud", "bus";
> +			status = "disabled";
> +		};
> +
> +		i2c9: i2c@11019000 {
> +			compatible = "mediatek,mt8186-i2c";
> +			reg = <0 0x11019000 0 0x1000>,
> +			      <0 0x10200c00 0 0x180>;
> +			interrupts = <GIC_SPI 356 IRQ_TYPE_LEVEL_HIGH 0>;
> +			clocks = <&imp_iic_wrap CLK_IMP_IIC_WRAP_AP_CLOCK_I2C9>,
> +				 <&infracfg_ao CLK_INFRA_AO_AP_DMA>;
> +			clock-names = "main", "dma";
> +			clock-div = <1>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			status = "disabled";
> +		};
> +
> +		mmc0: mmc@11230000 {
> +			compatible = "mediatek,mt8186-mmc",
> +				     "mediatek,mt8183-mmc";
> +			reg = <0 0x11230000 0 0x1000>,
> +			      <0 0x11cd0000 0 0x1000>;
> +			clocks = <&topckgen CLK_TOP_MSDC50_0>,
> +				 <&infracfg_ao CLK_INFRA_AO_MSDC0>,
> +				 <&infracfg_ao CLK_INFRA_AO_MSDC0_SRC>;
> +			clock-names = "source", "hclk", "source_cg";
> +			interrupts = <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH 0>;
> +			assigned-clocks = <&topckgen CLK_TOP_MSDC50_0>;
> +			assigned-clock-parents = <&apmixedsys CLK_APMIXED_MSDCPLL>;
> +			status = "disabled";
> +		};
> +
> +		mmc1: mmc@11240000 {
> +			compatible = "mediatek,mt8186-mmc",
> +				     "mediatek,mt8183-mmc";
> +			reg = <0 0x11240000 0 0x1000>,
> +			      <0 0x11c90000 0 0x1000>;
> +			clocks = <&topckgen CLK_TOP_MSDC30_1>,
> +				 <&infracfg_ao CLK_INFRA_AO_MSDC1>,
> +				 <&infracfg_ao CLK_INFRA_AO_MSDC1_SRC>;
> +			clock-names = "source", "hclk", "source_cg";
> +			interrupts = <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH 0>;
> +			assigned-clocks = <&topckgen CLK_TOP_MSDC30_1>;
> +			assigned-clock-parents = <&topckgen CLK_TOP_MSDCPLL_D2>;
> +			status = "disabled";
> +		};
> +
> +		u3phy0: t-phy@11c80000 {
> +			compatible = "mediatek,mt8186-tphy",
> +				     "mediatek,generic-tphy-v2";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges = <0x0 0x0 0x11c80000 0x1000>;
> +			status = "disabled";
> +
> +			u2port1: usb-phy@0 {
> +				reg = <0x0 0x700>;
> +				clocks = <&clk26m>;
> +				clock-names = "ref";
> +				#phy-cells = <1>;
> +			};
> +
> +			u3port1: usb-phy@700 {
> +				reg = <0x700 0x900>;
> +				clocks = <&clk26m>;
> +				clock-names = "ref";
> +				#phy-cells = <1>;
> +			};
> +		};
> +
> +		u3phy1: t-phy@11ca0000 {
> +			compatible = "mediatek,mt8186-tphy",
> +				     "mediatek,generic-tphy-v2";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges = <0x0 0x0 0x11ca0000 0x1000>;
> +			status = "disabled";
> +
> +			u2port0: usb-phy@0 {
> +				reg = <0x0 0x700>;
> +				clocks = <&clk26m>;
> +				clock-names = "ref";
> +				#phy-cells = <1>;
> +				mediatek,discth = <0x8>;
> +			};
> +		};
> +
> +		efuse: efuse@11cb0000 {
> +			compatible = "mediatek,mt8186-efuse", "mediatek,efuse";
> +			reg = <0 0x11cb0000 0 0x1000>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +		};
> +
> +		mipi_tx0: dsi-phy@11cc0000 {
> +			compatible = "mediatek,mt8183-mipi-tx";
> +			reg = <0 0x11cc0000 0 0x1000>;
> +			clocks = <&clk26m>;
> +			#clock-cells = <0>;
> +			#phy-cells = <0>;
> +			clock-output-names = "mipi_tx0_pll";
> +			status = "disabled";
> +		};
> +
> +		mfgsys: clock-controller@13000000 {
> +			compatible = "mediatek,mt8186-mfgsys";
> +			reg = <0 0x13000000 0 0x1000>;
> +			#clock-cells = <1>;
> +		};
> +
> +		mmsys: syscon@14000000 {
> +			compatible = "mediatek,mt8186-mmsys", "syscon";
> +			reg = <0 0x14000000 0 0x1000>;
> +			#clock-cells = <1>;
> +			#reset-cells = <1>;
> +		};
> +
> +		wpesys: clock-controller@14020000 {
> +			compatible = "mediatek,mt8186-wpesys";
> +			reg = <0 0x14020000 0 0x1000>;
> +			#clock-cells = <1>;
> +		};
> +
> +		imgsys1: clock-controller@15020000 {
> +			compatible = "mediatek,mt8186-imgsys1";
> +			reg = <0 0x15020000 0 0x1000>;
> +			#clock-cells = <1>;
> +		};
> +
> +		imgsys2: clock-controller@15820000 {
> +			compatible = "mediatek,mt8186-imgsys2";
> +			reg = <0 0x15820000 0 0x1000>;
> +			#clock-cells = <1>;
> +		};
> +
> +		vdecsys: clock-controller@1602f000 {
> +			compatible = "mediatek,mt8186-vdecsys";
> +			reg = <0 0x1602f000 0 0x1000>;
> +			#clock-cells = <1>;
> +		};
> +
> +		vencsys: clock-controller@17000000 {
> +			compatible = "mediatek,mt8186-vencsys";
> +			reg = <0 0x17000000 0 0x1000>;
> +			#clock-cells = <1>;
> +		};
> +
> +		camsys: clock-controller@1a000000 {
> +			compatible = "mediatek,mt8186-camsys";
> +			reg = <0 0x1a000000 0 0x1000>;
> +			#clock-cells = <1>;
> +		};
> +
> +		camsys_rawa: clock-controller@1a04f000 {
> +			compatible = "mediatek,mt8186-camsys_rawa";
> +			reg = <0 0x1a04f000 0 0x1000>;
> +			#clock-cells = <1>;
> +		};
> +
> +		camsys_rawb: clock-controller@1a06f000 {
> +			compatible = "mediatek,mt8186-camsys_rawb";
> +			reg = <0 0x1a06f000 0 0x1000>;
> +			#clock-cells = <1>;
> +		};
> +
> +		mdpsys: clock-controller@1b000000 {
> +			compatible = "mediatek,mt8186-mdpsys";
> +			reg = <0 0x1b000000 0 0x1000>;
> +			#clock-cells = <1>;
> +		};
> +
> +		ipesys: clock-controller@1c000000 {
> +			compatible = "mediatek,mt8186-ipesys";
> +			reg = <0 0x1c000000 0 0x1000>;
> +			#clock-cells = <1>;
> +		};
> +	};
> +};
