Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B11850FB1E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 12:39:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349296AbiDZKk5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 06:40:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349673AbiDZKj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 06:39:27 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C5B123BF2;
        Tue, 26 Apr 2022 03:28:25 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id p7-20020a05600c358700b00393e80c59daso1058118wmq.0;
        Tue, 26 Apr 2022 03:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=SxJUEuYfElbNAyi6VUakC34OKngPypTgTexAAjBP7JY=;
        b=mCM+uZv83rSqqW9CvccthNgY54DlSZhZhi3mP8gtZMt3FfoYZVqICru+xS90Ihi/UK
         DyJwjyLSgY+jPTEOBrW8T08tmOqjfJM4WHO93qJprAQ+cWzyRMYrkyF8keybKx5jLXKe
         gHgPru3BPSR6AbJIdT8A1T0BFTA+nwvBSM1RQq9MCS5cnM1RYdZL3akgy5CZfe3kqfsK
         c8mclVACEFrLG6cLhs0Pz5T4ugJOsycLycqt3U5LFhnx2thkh29lRZI/HkX45OCnboqC
         aNogSg6ZSpEEq17YpYOsbc3581r46epst9MFOWhE7qiIM3e89bdghHIF6O0vNc7Luzth
         BeWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=SxJUEuYfElbNAyi6VUakC34OKngPypTgTexAAjBP7JY=;
        b=UNhW4Tg6+yvjNTjfHLeqmCmigth0b0l24zJTAY3NdN5UGtTsVjsMMAZ3hhkvi71UvL
         ZsSIbhptMqy3fwwWPkkf5zWhfn+bWCrI6ppAXq/oNER3N24hOcww+OjUG6Beig1YzSP3
         U6gRqy0aljxB64xIXjGXnHwctrgt0XmS+9j9i7P7JOhR7Dr5t+wD9akP1T+IRwqDIRGs
         RiDW/GX9lu7Qf4I38sKo3+3k4FeqpOa3tUjsBQN7P8nJdJBSaeD8dO/7PSgHsM4kTYRR
         PTIcZyNLQdVvRW/jv5ttqPG+qtMGk9MuLuXi1dYeQJpucgdqHotCIcNIaxj1LBBsNuQx
         ufRQ==
X-Gm-Message-State: AOAM531l6dmX27QWolp6sGCMNd00ptT45/E9LNeu3BtXF87gWpYgv2TX
        6A5MqaUU8/ppOAJFs4/FL28=
X-Google-Smtp-Source: ABdhPJyb1I0ZdgKngbzk0E/iWW599SuU2LJ0LhZsdbRvBYG6AWTY7Xn6Fm+EzSMAqVMi9gXsr4vB8g==
X-Received: by 2002:a7b:c201:0:b0:38f:f7f5:f6db with SMTP id x1-20020a7bc201000000b0038ff7f5f6dbmr29808360wmi.191.1650968904003;
        Tue, 26 Apr 2022 03:28:24 -0700 (PDT)
Received: from [192.168.0.43] (static-35-180-85-188.ipcom.comunitel.net. [188.85.180.35])
        by smtp.gmail.com with ESMTPSA id o10-20020a5d47ca000000b0020a992ce36esm12918917wrc.1.2022.04.26.03.28.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Apr 2022 03:28:23 -0700 (PDT)
Message-ID: <4561a64e-0675-8f26-3c0c-53e422b65ab8@gmail.com>
Date:   Tue, 26 Apr 2022 12:28:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 4/4] arm64: dts: Add Mediatek SoC MT8186 dts and
 evaluation board and Makefile
Content-Language: en-US
To:     "allen-kh.cheng" <allen-kh.cheng@mediatek.com>,
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
 <e06b7f3e-fbc7-63ab-c7b9-0c879cb10807@gmail.com>
 <8c27fbbdf109b53cff5472e89da83741bee4b202.camel@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <8c27fbbdf109b53cff5472e89da83741bee4b202.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Allen,

On 30/03/2022 09:34, allen-kh.cheng wrote:
> Hi Matthias,
> 
> On Tue, 2022-03-29 at 16:56 +0200, Matthias Brugger wrote:
>>
>> On 11/03/2022 14:07, Allen-KH Cheng wrote:
>>> From: Allen-KH Cheng <Allen-KH.Cheng@mediatek.com>
>>>
>>> Add basic chip support for Mediatek MT8186.
>>>
>>
>> Thanks for your patch. I would love to wait a bit longer to see if we
>> can get
>> the clock driver accepted. This way we could get rid of all the dummy
>> clocks
>> defined in here.
>>
>> Please send a new version once the clock driver is accepeted by
>> Stephen, or ping
>> this series in a few month.
>>
>> Thanks,
>> Matthias
>>
> 
> Sure, that's great.
> 
> I will send a new version after the clock driver is accepted.
> 

I've seen that the clock driver got accepted. Can you please send a new patch 
adding the correct clocks to the nodes?

Thanks a lot.
Matthias

> Thanks,
> Allen
> 
>>> Signed-off-by: Allen-KH Cheng <Allen-KH.Cheng@mediatek.com>
>>> ---
>>>    arch/arm64/boot/dts/mediatek/Makefile       |   1 +
>>>    arch/arm64/boot/dts/mediatek/mt8186-evb.dts |  24 ++
>>>    arch/arm64/boot/dts/mediatek/mt8186.dtsi    | 356
>>> ++++++++++++++++++++
>>>    3 files changed, 381 insertions(+)
>>>    create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-evb.dts
>>>    create mode 100644 arch/arm64/boot/dts/mediatek/mt8186.dtsi
>>>
>>> diff --git a/arch/arm64/boot/dts/mediatek/Makefile
>>> b/arch/arm64/boot/dts/mediatek/Makefile
>>> index 8c1e18032f9f..d32fdcf9afc6 100644
>>> --- a/arch/arm64/boot/dts/mediatek/Makefile
>>> +++ b/arch/arm64/boot/dts/mediatek/Makefile
>>> @@ -37,5 +37,6 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-
>>> kodama-sku32.dtb
>>>    dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-krane-sku0.dtb
>>>    dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-krane-sku176.dtb
>>>    dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-pumpkin.dtb
>>> +dtb-$(CONFIG_ARCH_MEDIATEK) += mt8186-evb.dtb
>>>    dtb-$(CONFIG_ARCH_MEDIATEK) += mt8192-evb.dtb
>>>    dtb-$(CONFIG_ARCH_MEDIATEK) += mt8516-pumpkin.dtb
>>> diff --git a/arch/arm64/boot/dts/mediatek/mt8186-evb.dts
>>> b/arch/arm64/boot/dts/mediatek/mt8186-evb.dts
>>> new file mode 100644
>>> index 000000000000..eb23d1f19f87
>>> --- /dev/null
>>> +++ b/arch/arm64/boot/dts/mediatek/mt8186-evb.dts
>>> @@ -0,0 +1,24 @@
>>> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
>>> +/*
>>> + * Copyright (C) 2022 MediaTek Inc.
>>> + */
>>> +/dts-v1/;
>>> +#include "mt8186.dtsi"
>>> +
>>> +/ {
>>> +	model = "MediaTek MT8186 evaluation board";
>>> +	compatible = "mediatek,mt8186-evb", "mediatek,mt8186";
>>> +
>>> +	aliases {
>>> +		serial0 = &uart0;
>>> +	};
>>> +
>>> +	chosen {
>>> +		stdout-path = "serial0:921600n8";
>>> +	};
>>> +
>>> +	memory {
>>> +		device_type = "memory";
>>> +		reg = <0 0x40000000 0 0x80000000>;
>>> +	};
>>> +};
>>> diff --git a/arch/arm64/boot/dts/mediatek/mt8186.dtsi
>>> b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
>>> new file mode 100644
>>> index 000000000000..aa45c75b18c7
>>> --- /dev/null
>>> +++ b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
>>> @@ -0,0 +1,356 @@
>>> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
>>> +/*
>>> + * Copyright (C) 2022 MediaTek Inc.
>>> + * Author: Allen-KH Cheng <allenn-kh.cheng@mediatek.com>
>>> + */
>>> +/dts-v1/;
>>> +
>>> +#include <dt-bindings/interrupt-controller/arm-gic.h>
>>> +#include <dt-bindings/interrupt-controller/irq.h>
>>> +#include <dt-bindings/phy/phy.h>
>>> +
>>> +/ {
>>> +	compatible = "mediatek,mt8186";
>>> +	interrupt-parent = <&gic>;
>>> +	#address-cells = <2>;
>>> +	#size-cells = <2>;
>>> +
>>> +	clk13m: oscillator0 {
>>> +		compatible = "fixed-clock";
>>> +		#clock-cells = <0>;
>>> +		clock-frequency = <13000000>;
>>> +		clock-output-names = "clk13m";
>>> +	};
>>> +
>>> +	clk26m: oscillator1 {
>>> +		compatible = "fixed-clock";
>>> +		#clock-cells = <0>;
>>> +		clock-frequency = <26000000>;
>>> +		clock-output-names = "clk26m";
>>> +	};
>>> +
>>> +	clk32k: oscillator2 {
>>> +		compatible = "fixed-clock";
>>> +		#clock-cells = <0>;
>>> +		clock-frequency = <32000>;
>>> +		clock-output-names = "clk32k";
>>> +	};
>>> +
>>> +	cpus {
>>> +		#address-cells = <1>;
>>> +		#size-cells = <0>;
>>> +
>>> +		cpu0: cpu@000 {
>>> +			device_type = "cpu";
>>> +			compatible = "arm,cortex-a55", "arm,armv8";
>>> +			reg = <0x0000>;
>>> +			enable-method = "psci";
>>> +			clock-frequency = <2000000000>;
>>> +			cpu-idle-states = <&cpuoff_l &clusteroff_l>;
>>> +			next-level-cache = <&l2_0>;
>>> +		};
>>> +
>>> +		cpu1: cpu@100 {
>>> +			device_type = "cpu";
>>> +			compatible = "arm,cortex-a55", "arm,armv8";
>>> +			reg = <0x0100>;
>>> +			enable-method = "psci";
>>> +			clock-frequency = <2000000000>;
>>> +			cpu-idle-states = <&cpuoff_l &clusteroff_l>;
>>> +			next-level-cache = <&l2_0>;
>>> +		};
>>> +
>>> +		cpu2: cpu@200 {
>>> +			device_type = "cpu";
>>> +			compatible = "arm,cortex-a55", "arm,armv8";
>>> +			reg = <0x0200>;
>>> +			enable-method = "psci";
>>> +			clock-frequency = <2000000000>;
>>> +			cpu-idle-states = <&cpuoff_l &clusteroff_l>;
>>> +			next-level-cache = <&l2_0>;
>>> +		};
>>> +
>>> +		cpu3: cpu@300 {
>>> +			device_type = "cpu";
>>> +			compatible = "arm,cortex-a55", "arm,armv8";
>>> +			reg = <0x0300>;
>>> +			enable-method = "psci";
>>> +			clock-frequency = <2000000000>;
>>> +			cpu-idle-states = <&cpuoff_l &clusteroff_l>;
>>> +			next-level-cache = <&l2_0>;
>>> +		};
>>> +
>>> +		cpu4: cpu@400 {
>>> +			device_type = "cpu";
>>> +			compatible = "arm,cortex-a55", "arm,armv8";
>>> +			reg = <0x0400>;
>>> +			enable-method = "psci";
>>> +			clock-frequency = <2000000000>;
>>> +			cpu-idle-states = <&cpuoff_l &clusteroff_l>;
>>> +			next-level-cache = <&l2_0>;
>>> +		};
>>> +
>>> +		cpu5: cpu@500 {
>>> +			device_type = "cpu";
>>> +			compatible = "arm,cortex-a55", "arm,armv8";
>>> +			reg = <0x0500>;
>>> +			enable-method = "psci";
>>> +			clock-frequency = <2000000000>;
>>> +			cpu-idle-states = <&cpuoff_l &clusteroff_l>;
>>> +			next-level-cache = <&l2_0>;
>>> +		};
>>> +
>>> +		cpu6: cpu@600 {
>>> +			device_type = "cpu";
>>> +			compatible = "arm,cortex-a75", "arm,armv8";
>>> +			reg = <0x0600>;
>>> +			enable-method = "psci";
>>> +			clock-frequency = <2050000000>;
>>> +			cpu-idle-states = <&cpuoff_b &clusteroff_b>;
>>> +			next-level-cache = <&l2_1>;
>>> +		};
>>> +
>>> +		cpu7: cpu@700 {
>>> +			device_type = "cpu";
>>> +			compatible = "arm,cortex-a75", "arm,armv8";
>>> +			reg = <0x0700>;
>>> +			enable-method = "psci";
>>> +			clock-frequency = <2050000000>;
>>> +			cpu-idle-states = <&cpuoff_b &clusteroff_b>;
>>> +			next-level-cache = <&l2_1>;
>>> +		};
>>> +
>>> +		cpu-map {
>>> +			cluster0 {
>>> +				core0 {
>>> +					cpu = <&cpu0>;
>>> +				};
>>> +
>>> +				core1 {
>>> +					cpu = <&cpu1>;
>>> +				};
>>> +
>>> +				core2 {
>>> +					cpu = <&cpu2>;
>>> +				};
>>> +
>>> +				core3 {
>>> +					cpu = <&cpu3>;
>>> +				};
>>> +
>>> +				core4 {
>>> +					cpu = <&cpu4>;
>>> +				};
>>> +
>>> +				core5 {
>>> +					cpu = <&cpu5>;
>>> +				};
>>> +			};
>>> +
>>> +			cluster1 {
>>> +				core0 {
>>> +					cpu = <&cpu6>;
>>> +				};
>>> +
>>> +				core1 {
>>> +					cpu = <&cpu7>;
>>> +				};
>>> +			};
>>> +		};
>>> +
>>> +		idle-states {
>>> +			entry-method = "arm,psci";
>>> +
>>> +			cpuoff_l: cpu-off-l {
>>> +				compatible = "arm,idle-state";
>>> +				arm,psci-suspend-param = <0x00010001>;
>>> +				local-timer-stop;
>>> +				entry-latency-us = <50>;
>>> +				exit-latency-us = <100>;
>>> +				min-residency-us = <1600>;
>>> +			};
>>> +
>>> +			cpuoff_b: cpu-off-b {
>>> +				compatible = "arm,idle-state";
>>> +				arm,psci-suspend-param = <0x00010001>;
>>> +				local-timer-stop;
>>> +				entry-latency-us = <50>;
>>> +				exit-latency-us = <100>;
>>> +				min-residency-us = <1400>;
>>> +			};
>>> +
>>> +			clusteroff_l: cluster-off-l {
>>> +				compatible = "arm,idle-state";
>>> +				arm,psci-suspend-param = <0x01010001>;
>>> +				local-timer-stop;
>>> +				entry-latency-us = <100>;
>>> +				exit-latency-us = <250>;
>>> +				min-residency-us = <2100>;
>>> +			};
>>> +
>>> +			clusteroff_b: cluster-off-b {
>>> +				compatible = "arm,idle-state";
>>> +				arm,psci-suspend-param = <0x01010001>;
>>> +				local-timer-stop;
>>> +				entry-latency-us = <100>;
>>> +				exit-latency-us = <250>;
>>> +				min-residency-us = <1900>;
>>> +			};
>>> +		};
>>> +
>>> +		l2_0: l2-cache0 {
>>> +			compatible = "cache";
>>> +			next-level-cache = <&l3_0>;
>>> +		};
>>> +
>>> +		l2_1: l2-cache1 {
>>> +			compatible = "cache";
>>> +			next-level-cache = <&l3_0>;
>>> +		};
>>> +
>>> +		l3_0: l3-cache {
>>> +			compatible = "cache";
>>> +		};
>>> +	};
>>> +
>>> +	psci {
>>> +		compatible = "arm,psci-1.0";
>>> +		method = "smc";
>>> +	};
>>> +
>>> +	timer: timer {
>>> +		compatible = "arm,armv8-timer";
>>> +		interrupt-parent = <&gic>;
>>> +		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>,
>>> +			     <GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>,
>>> +			     <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>,
>>> +			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>;
>>> +		clock-frequency = <13000000>;
>>> +	};
>>> +
>>> +	soc {
>>> +		#address-cells = <2>;
>>> +		#size-cells = <2>;
>>> +		compatible = "simple-bus";
>>> +		ranges;
>>> +
>>> +		gic: interrupt-controller@c000000 {
>>> +			compatible = "arm,gic-v3";
>>> +			#interrupt-cells = <3>;
>>> +			#address-cells = <2>;
>>> +			#size-cells = <2>;
>>> +			#redistributor-regions = <1>;
>>> +			interrupt-parent = <&gic>;
>>> +			interrupt-controller;
>>> +			reg = <0 0x0c000000 0 0x40000>, // distributor
>>> +			      <0 0x0c040000 0 0x200000>; //
>>> redistributor
>>> +			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
>>> +		};
>>> +
>>> +		watchdog: watchdog@10007000 {
>>> +			compatible = "mediatek,mt8186-wdt",
>>> +				     "mediatek,mt6589-wdt";
>>> +			mediatek,disable-extrst;
>>> +			reg = <0 0x10007000 0 0x1000>;
>>> +			#reset-cells = <1>;
>>> +		};
>>> +
>>> +		systimer: timer@10017000 {
>>> +			compatible = "mediatek,mt8186-timer",
>>> +				     "mediatek,mt6765-timer";
>>> +			reg = <0 0x10017000 0 0x1000>;
>>> +			interrupts = <GIC_SPI 207 IRQ_TYPE_LEVEL_HIGH>;
>>> +			clocks = <&clk13m>;
>>> +		};
>>> +
>>> +		uart0: serial@11002000 {
>>> +			compatible = "mediatek,mt8186-uart",
>>> +				     "mediatek,mt6577-uart";
>>> +			reg = <0 0x11002000 0 0x1000>;
>>> +			interrupts = <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>;
>>> +			clocks = <&clk26m>, <&clk26m>;
>>> +			clock-names = "baud", "bus";
>>> +		};
>>> +
>>> +		uart1: serial@11003000 {
>>> +			compatible = "mediatek,mt8186-uart",
>>> +				     "mediatek,mt6577-uart";
>>> +			reg = <0 0x11003000 0 0x1000>;
>>> +			interrupts = <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>;
>>> +			clocks = <&clk26m>, <&clk26m>;
>>> +			clock-names = "baud", "bus";
>>> +			status = "disabled";
>>> +		};
>>> +
>>> +		uart2: serial@11018000 {
>>> +			compatible = "mediatek,mt8186-uart",
>>> +				     "mediatek,mt6577-uart";
>>> +			reg = <0 0x11018000 0 0x1000>;
>>> +			interrupts = <GIC_SPI 246 IRQ_TYPE_LEVEL_HIGH>;
>>> +			clocks = <&clk26m>, <&clk26m>;
>>> +			clock-names = "baud", "bus";
>>> +			status = "disabled";
>>> +		};
>>> +
>>> +		mmc0: mmc@11230000 {
>>> +			compatible = "mediatek,mt8186-mmc",
>>> +				     "mediatek,mt8183-mmc";
>>> +			reg = <0 0x11230000 0 0x1000>,
>>> +			      <0 0x11cd0000 0 0x1000>;
>>> +			interrupts = <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>;
>>> +			clocks = <&clk26m>, <&clk26m>, <&clk26m>,
>>> +				 <&clk26m>;
>>> +			clock-names = "source", "hclk", "source_cg",
>>> "ahb_clk";
>>> +			status = "disabled";
>>> +		};
>>> +
>>> +		mmc1: mmc@11240000 {
>>> +			compatible = "mediatek,mt8186-mmc",
>>> +				     "mediatek,mt8183-mmc";
>>> +			reg = <0 0x11240000 0 0x1000>,
>>> +			      <0 0x11c90000 0 0x1000>;
>>> +			interrupts = <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>;
>>> +			clocks = <&clk26m>, <&clk26m>, <&clk26m>;
>>> +			clock-names = "source", "hclk", "source_cg";
>>> +			status = "disabled";
>>> +		};
>>> +
>>> +		u3phy0: t-phy@11c80000 {
>>> +			compatible = "mediatek,mt8186-tphy",
>>> +				     "mediatek,generic-tphy-v2";
>>> +			#address-cells = <1>;
>>> +			#size-cells = <1>;
>>> +			ranges = <0x0 0x0 0x11c80000 0x1000>;
>>> +
>>> +			u2port1: usb2-phy1@0 {
>>> +				reg = <0x0 0x700>;
>>> +				clocks = <&clk26m>;
>>> +				clock-names = "ref";
>>> +				#phy-cells = <1>;
>>> +			};
>>> +
>>> +			u3port1: usb3-phy1@700 {
>>> +				reg = <0x700 0x900>;
>>> +				clocks = <&clk26m>;
>>> +				clock-names = "ref";
>>> +				#phy-cells = <1>;
>>> +			};
>>> +		};
>>> +
>>> +		u3phy1: t-phy@11ca0000 {
>>> +			compatible = "mediatek,mt8186-tphy",
>>> +				     "mediatek,generic-tphy-v2";
>>> +			#address-cells = <1>;
>>> +			#size-cells = <1>;
>>> +			ranges = <0x0 0x0 0x11ca0000 0x1000>;
>>> +
>>> +			u2port0: usb-phy@0 {
>>> +				reg = <0x0 0x700>;
>>> +				clocks = <&clk26m>;
>>> +				clock-names = "ref";
>>> +				#phy-cells = <1>;
>>> +				mediatek,discth = <0x8>;
>>> +			};
>>> +		};
>>> +	};
>>> +};
> 
