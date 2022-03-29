Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 920CD4EAFB5
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 16:56:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238186AbiC2O63 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 10:58:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236761AbiC2O61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 10:58:27 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EBCE13859F;
        Tue, 29 Mar 2022 07:56:43 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id r7so24101958wrc.0;
        Tue, 29 Mar 2022 07:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=R/qQDmqImOsdqxPn8kuDcCeLYVlLH8EffIXUnNSpyQM=;
        b=lJfjaVRzk35z2+VKzfty+4hdth58zBEjfWrgOS1uOVjbxTgywUo814hEGTppw9/b/D
         j+0HXCGxz3/bHOIYGUIwaFK3U20rT2bcJSnk97q4Ot7JYxcXtS3cHcBsAzck2Sw73D/u
         VkhCdFzujMt55oJrPy7/F9sffWjVL1z12Vg/5xRQtVhiflY0Yitfd6zDO9a9Qw9jY4AF
         awQFOxwl2wexF0hWRCSizYYgH596zgI49uZOIDAqQ/gOxFD8H9K80c539CKVZSWIBC17
         AH+2emkw7ecp4dV2QCdOtUfEy59LMsA/v0e/a2TT+axOCvDgb8DphsfwArx2MfgQXUpk
         i+mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=R/qQDmqImOsdqxPn8kuDcCeLYVlLH8EffIXUnNSpyQM=;
        b=Oo5Tv1/bVfm75igeZ9aTlxUCPu+WFAn9C0v5JJc+piK/HlIdkcxZAQ4fxW9VhbykRD
         KN1J0Nh7u+E+x+hH62902KvhRRB6HMseB75pTSi8vTOs6FQ85yTiSyS2DD1Wills5KEU
         RvExr/Dbzr3vVBm+ywSxrJZYxwFK7Q/otGPiUbMee0+ZTdeKqJC5HOB7gdcB92VzkXBc
         6ltRm5lVDqcLB5Jp9yeuD3KTUwD/CmEphc8OUhJxeBwwLX50A84f/vv5TBA8yY3lSN6s
         LLDTQe+QCod9o10ZZ3NMkYIMcYMQhXg4t7yiUbyfNT5R7dze+m2o5RlYhP+jGsgLWsmD
         wEyg==
X-Gm-Message-State: AOAM533KFpxdwE5WUPTFUouwdMKSlQbkjtNLE5cQX1JVGt9DYq6BZpjm
        p6aK68GcyePaGvVjg+TXv2k=
X-Google-Smtp-Source: ABdhPJyKGT67Vbh5PboaqGSuksq4cMFneOsrDjUNzk68xxXW3hnsa9Wf0OJuOlGS5HoN5wwIbu35ng==
X-Received: by 2002:a05:6000:10ca:b0:205:9b86:7976 with SMTP id b10-20020a05600010ca00b002059b867976mr29258611wrx.542.1648565802446;
        Tue, 29 Mar 2022 07:56:42 -0700 (PDT)
Received: from [192.168.1.145] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id m3-20020a5d6243000000b001e33760776fsm15028121wrv.10.2022.03.29.07.56.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Mar 2022 07:56:41 -0700 (PDT)
Message-ID: <e06b7f3e-fbc7-63ab-c7b9-0c879cb10807@gmail.com>
Date:   Tue, 29 Mar 2022 16:56:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 4/4] arm64: dts: Add Mediatek SoC MT8186 dts and
 evaluation board and Makefile
Content-Language: en-US
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     hsinyi@chromium.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-watchdog@vger.kernel.org
References: <20220311130732.22706-1-allen-kh.cheng@mediatek.com>
 <20220311130732.22706-5-allen-kh.cheng@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220311130732.22706-5-allen-kh.cheng@mediatek.com>
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



On 11/03/2022 14:07, Allen-KH Cheng wrote:
> From: Allen-KH Cheng <Allen-KH.Cheng@mediatek.com>
> 
> Add basic chip support for Mediatek MT8186.
> 

Thanks for your patch. I would love to wait a bit longer to see if we can get 
the clock driver accepted. This way we could get rid of all the dummy clocks 
defined in here.

Please send a new version once the clock driver is accepeted by Stephen, or ping 
this series in a few month.

Thanks,
Matthias

> Signed-off-by: Allen-KH Cheng <Allen-KH.Cheng@mediatek.com>
> ---
>   arch/arm64/boot/dts/mediatek/Makefile       |   1 +
>   arch/arm64/boot/dts/mediatek/mt8186-evb.dts |  24 ++
>   arch/arm64/boot/dts/mediatek/mt8186.dtsi    | 356 ++++++++++++++++++++
>   3 files changed, 381 insertions(+)
>   create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-evb.dts
>   create mode 100644 arch/arm64/boot/dts/mediatek/mt8186.dtsi
> 
> diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
> index 8c1e18032f9f..d32fdcf9afc6 100644
> --- a/arch/arm64/boot/dts/mediatek/Makefile
> +++ b/arch/arm64/boot/dts/mediatek/Makefile
> @@ -37,5 +37,6 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-kodama-sku32.dtb
>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-krane-sku0.dtb
>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-krane-sku176.dtb
>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-pumpkin.dtb
> +dtb-$(CONFIG_ARCH_MEDIATEK) += mt8186-evb.dtb
>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt8192-evb.dtb
>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt8516-pumpkin.dtb
> diff --git a/arch/arm64/boot/dts/mediatek/mt8186-evb.dts b/arch/arm64/boot/dts/mediatek/mt8186-evb.dts
> new file mode 100644
> index 000000000000..eb23d1f19f87
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt8186-evb.dts
> @@ -0,0 +1,24 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
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
> diff --git a/arch/arm64/boot/dts/mediatek/mt8186.dtsi b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
> new file mode 100644
> index 000000000000..aa45c75b18c7
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
> @@ -0,0 +1,356 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/*
> + * Copyright (C) 2022 MediaTek Inc.
> + * Author: Allen-KH Cheng <allenn-kh.cheng@mediatek.com>
> + */
> +/dts-v1/;
> +
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/interrupt-controller/irq.h>
> +#include <dt-bindings/phy/phy.h>
> +
> +/ {
> +	compatible = "mediatek,mt8186";
> +	interrupt-parent = <&gic>;
> +	#address-cells = <2>;
> +	#size-cells = <2>;
> +
> +	clk13m: oscillator0 {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <13000000>;
> +		clock-output-names = "clk13m";
> +	};
> +
> +	clk26m: oscillator1 {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <26000000>;
> +		clock-output-names = "clk26m";
> +	};
> +
> +	clk32k: oscillator2 {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <32000>;
> +		clock-output-names = "clk32k";
> +	};
> +
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		cpu0: cpu@000 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a55", "arm,armv8";
> +			reg = <0x0000>;
> +			enable-method = "psci";
> +			clock-frequency = <2000000000>;
> +			cpu-idle-states = <&cpuoff_l &clusteroff_l>;
> +			next-level-cache = <&l2_0>;
> +		};
> +
> +		cpu1: cpu@100 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a55", "arm,armv8";
> +			reg = <0x0100>;
> +			enable-method = "psci";
> +			clock-frequency = <2000000000>;
> +			cpu-idle-states = <&cpuoff_l &clusteroff_l>;
> +			next-level-cache = <&l2_0>;
> +		};
> +
> +		cpu2: cpu@200 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a55", "arm,armv8";
> +			reg = <0x0200>;
> +			enable-method = "psci";
> +			clock-frequency = <2000000000>;
> +			cpu-idle-states = <&cpuoff_l &clusteroff_l>;
> +			next-level-cache = <&l2_0>;
> +		};
> +
> +		cpu3: cpu@300 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a55", "arm,armv8";
> +			reg = <0x0300>;
> +			enable-method = "psci";
> +			clock-frequency = <2000000000>;
> +			cpu-idle-states = <&cpuoff_l &clusteroff_l>;
> +			next-level-cache = <&l2_0>;
> +		};
> +
> +		cpu4: cpu@400 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a55", "arm,armv8";
> +			reg = <0x0400>;
> +			enable-method = "psci";
> +			clock-frequency = <2000000000>;
> +			cpu-idle-states = <&cpuoff_l &clusteroff_l>;
> +			next-level-cache = <&l2_0>;
> +		};
> +
> +		cpu5: cpu@500 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a55", "arm,armv8";
> +			reg = <0x0500>;
> +			enable-method = "psci";
> +			clock-frequency = <2000000000>;
> +			cpu-idle-states = <&cpuoff_l &clusteroff_l>;
> +			next-level-cache = <&l2_0>;
> +		};
> +
> +		cpu6: cpu@600 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a75", "arm,armv8";
> +			reg = <0x0600>;
> +			enable-method = "psci";
> +			clock-frequency = <2050000000>;
> +			cpu-idle-states = <&cpuoff_b &clusteroff_b>;
> +			next-level-cache = <&l2_1>;
> +		};
> +
> +		cpu7: cpu@700 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a75", "arm,armv8";
> +			reg = <0x0700>;
> +			enable-method = "psci";
> +			clock-frequency = <2050000000>;
> +			cpu-idle-states = <&cpuoff_b &clusteroff_b>;
> +			next-level-cache = <&l2_1>;
> +		};
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
> +		idle-states {
> +			entry-method = "arm,psci";
> +
> +			cpuoff_l: cpu-off-l {
> +				compatible = "arm,idle-state";
> +				arm,psci-suspend-param = <0x00010001>;
> +				local-timer-stop;
> +				entry-latency-us = <50>;
> +				exit-latency-us = <100>;
> +				min-residency-us = <1600>;
> +			};
> +
> +			cpuoff_b: cpu-off-b {
> +				compatible = "arm,idle-state";
> +				arm,psci-suspend-param = <0x00010001>;
> +				local-timer-stop;
> +				entry-latency-us = <50>;
> +				exit-latency-us = <100>;
> +				min-residency-us = <1400>;
> +			};
> +
> +			clusteroff_l: cluster-off-l {
> +				compatible = "arm,idle-state";
> +				arm,psci-suspend-param = <0x01010001>;
> +				local-timer-stop;
> +				entry-latency-us = <100>;
> +				exit-latency-us = <250>;
> +				min-residency-us = <2100>;
> +			};
> +
> +			clusteroff_b: cluster-off-b {
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
> +	psci {
> +		compatible = "arm,psci-1.0";
> +		method = "smc";
> +	};
> +
> +	timer: timer {
> +		compatible = "arm,armv8-timer";
> +		interrupt-parent = <&gic>;
> +		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>,
> +			     <GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>,
> +			     <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>,
> +			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>;
> +		clock-frequency = <13000000>;
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
> +			#interrupt-cells = <3>;
> +			#address-cells = <2>;
> +			#size-cells = <2>;
> +			#redistributor-regions = <1>;
> +			interrupt-parent = <&gic>;
> +			interrupt-controller;
> +			reg = <0 0x0c000000 0 0x40000>, // distributor
> +			      <0 0x0c040000 0 0x200000>; // redistributor
> +			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
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
> +		systimer: timer@10017000 {
> +			compatible = "mediatek,mt8186-timer",
> +				     "mediatek,mt6765-timer";
> +			reg = <0 0x10017000 0 0x1000>;
> +			interrupts = <GIC_SPI 207 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&clk13m>;
> +		};
> +
> +		uart0: serial@11002000 {
> +			compatible = "mediatek,mt8186-uart",
> +				     "mediatek,mt6577-uart";
> +			reg = <0 0x11002000 0 0x1000>;
> +			interrupts = <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&clk26m>, <&clk26m>;
> +			clock-names = "baud", "bus";
> +		};
> +
> +		uart1: serial@11003000 {
> +			compatible = "mediatek,mt8186-uart",
> +				     "mediatek,mt6577-uart";
> +			reg = <0 0x11003000 0 0x1000>;
> +			interrupts = <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&clk26m>, <&clk26m>;
> +			clock-names = "baud", "bus";
> +			status = "disabled";
> +		};
> +
> +		uart2: serial@11018000 {
> +			compatible = "mediatek,mt8186-uart",
> +				     "mediatek,mt6577-uart";
> +			reg = <0 0x11018000 0 0x1000>;
> +			interrupts = <GIC_SPI 246 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&clk26m>, <&clk26m>;
> +			clock-names = "baud", "bus";
> +			status = "disabled";
> +		};
> +
> +		mmc0: mmc@11230000 {
> +			compatible = "mediatek,mt8186-mmc",
> +				     "mediatek,mt8183-mmc";
> +			reg = <0 0x11230000 0 0x1000>,
> +			      <0 0x11cd0000 0 0x1000>;
> +			interrupts = <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&clk26m>, <&clk26m>, <&clk26m>,
> +				 <&clk26m>;
> +			clock-names = "source", "hclk", "source_cg", "ahb_clk";
> +			status = "disabled";
> +		};
> +
> +		mmc1: mmc@11240000 {
> +			compatible = "mediatek,mt8186-mmc",
> +				     "mediatek,mt8183-mmc";
> +			reg = <0 0x11240000 0 0x1000>,
> +			      <0 0x11c90000 0 0x1000>;
> +			interrupts = <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&clk26m>, <&clk26m>, <&clk26m>;
> +			clock-names = "source", "hclk", "source_cg";
> +			status = "disabled";
> +		};
> +
> +		u3phy0: t-phy@11c80000 {
> +			compatible = "mediatek,mt8186-tphy",
> +				     "mediatek,generic-tphy-v2";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges = <0x0 0x0 0x11c80000 0x1000>;
> +
> +			u2port1: usb2-phy1@0 {
> +				reg = <0x0 0x700>;
> +				clocks = <&clk26m>;
> +				clock-names = "ref";
> +				#phy-cells = <1>;
> +			};
> +
> +			u3port1: usb3-phy1@700 {
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
> +
> +			u2port0: usb-phy@0 {
> +				reg = <0x0 0x700>;
> +				clocks = <&clk26m>;
> +				clock-names = "ref";
> +				#phy-cells = <1>;
> +				mediatek,discth = <0x8>;
> +			};
> +		};
> +	};
> +};
