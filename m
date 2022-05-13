Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B40F525BC2
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 08:49:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377443AbiEMGs7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 02:48:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359479AbiEMGs4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 02:48:56 -0400
Received: from maillog.nuvoton.com (maillog.nuvoton.com [202.39.227.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0961C18A696;
        Thu, 12 May 2022 23:48:54 -0700 (PDT)
Received: from NTHCCAS04.nuvoton.com (NTHCCAS04.nuvoton.com [10.1.8.29])
        by maillog.nuvoton.com (Postfix) with ESMTP id 406721C80DD3;
        Fri, 13 May 2022 14:48:54 +0800 (CST)
Received: from NTHCCAS04.nuvoton.com (10.1.8.29) by NTHCCAS04.nuvoton.com
 (10.1.8.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Fri, 13
 May 2022 14:48:53 +0800
Received: from [172.19.1.47] (172.19.1.47) by NTHCCAS04.nuvoton.com
 (10.1.12.25) with Microsoft SMTP Server id 15.1.2176.2 via Frontend
 Transport; Fri, 13 May 2022 14:48:53 +0800
Message-ID: <46a55b01-ee9f-604f-72c9-916bc2f02a09@nuvoton.com>
Date:   Fri, 13 May 2022 14:48:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH V4 3/5] arm64: dts: nuvoton: Add initial support for
 MA35D1
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <ychuang570808@gmail.com>
CC:     <robh+dt@kernel.org>, <sboyd@kernel.org>, <krzk+dt@kernel.org>,
        <arnd@arndb.de>, <olof@lixom.net>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <soc@kernel.org>, <cfli0@nuvoton.com>
References: <20220510032558.10304-1-ychuang3@nuvoton.com>
 <20220510032558.10304-4-ychuang3@nuvoton.com>
 <03ac0a67-bd1f-12ca-74f7-8d5b05857ea7@linaro.org>
From:   Jacky Huang <ychuang3@nuvoton.com>
In-Reply-To: <03ac0a67-bd1f-12ca-74f7-8d5b05857ea7@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/5/12 下午 10:10, Krzysztof Kozlowski wrote:
> On 10/05/2022 05:25, Jacky Huang wrote:
>> Add the initial device tree files for Nuvoton MA35D1 Soc.
>>
>> Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
>> ---
>>   arch/arm64/boot/dts/Makefile               |   1 +
>>   arch/arm64/boot/dts/nuvoton/Makefile       |   2 +
>>   arch/arm64/boot/dts/nuvoton/ma35d1-evb.dts |  24 +++++
>>   arch/arm64/boot/dts/nuvoton/ma35d1.dtsi    | 120 +++++++++++++++++++++
>>   4 files changed, 147 insertions(+)
>>   create mode 100644 arch/arm64/boot/dts/nuvoton/Makefile
>>   create mode 100644 arch/arm64/boot/dts/nuvoton/ma35d1-evb.dts
>>   create mode 100644 arch/arm64/boot/dts/nuvoton/ma35d1.dtsi
>>
>> diff --git a/arch/arm64/boot/dts/Makefile b/arch/arm64/boot/dts/Makefile
>> index 1ba04e31a438..7b107fa7414b 100644
>> --- a/arch/arm64/boot/dts/Makefile
>> +++ b/arch/arm64/boot/dts/Makefile
>> @@ -19,6 +19,7 @@ subdir-y += lg
>>   subdir-y += marvell
>>   subdir-y += mediatek
>>   subdir-y += microchip
>> +subdir-y += nuvoton
>>   subdir-y += nvidia
>>   subdir-y += qcom
>>   subdir-y += realtek
>> diff --git a/arch/arm64/boot/dts/nuvoton/Makefile b/arch/arm64/boot/dts/nuvoton/Makefile
>> new file mode 100644
>> index 000000000000..e1e0c466bf5e
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/nuvoton/Makefile
>> @@ -0,0 +1,2 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +dtb-$(CONFIG_ARCH_NUVOTON) += ma35d1-evb.dtb
>> diff --git a/arch/arm64/boot/dts/nuvoton/ma35d1-evb.dts b/arch/arm64/boot/dts/nuvoton/ma35d1-evb.dts
>> new file mode 100644
>> index 000000000000..95f0facb0476
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/nuvoton/ma35d1-evb.dts
>> @@ -0,0 +1,24 @@
>> +// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +/*
>> + * Device Tree Source for MA35D1 Evaluation Board (EVB)
>> + *
>> + * Copyright (C) 2022 Nuvoton Technology Corp.
>> + */
>> +
>> +/dts-v1/;
>> +#include "ma35d1.dtsi"
>> +
>> +/ {
>> +	model = "Nuvoton MA35D1-EVB";
>> +	compatible = "nuvoton,ma35d1-evb", "nuvoton,ma35d1";
>> +
>> +	chosen {
>> +		stdout-path = "serial0:115200n8";
>> +	};
>> +
>> +	memory@80000000 {
>> +		device_type = "memory";
>> +		reg = <0x0 0x80000000 0x0 0x10000000>;
>> +	};
>> +};
>> +
>
> .git/rebase-apply/patch:60: new blank line at EOF.
>
> +
>
> warning: 1 line adds whitespace errors.
>

I will fix it.

>
>> diff --git a/arch/arm64/boot/dts/nuvoton/ma35d1.dtsi b/arch/arm64/boot/dts/nuvoton/ma35d1.dtsi
>> new file mode 100644
>> index 000000000000..7212f8de6906
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/nuvoton/ma35d1.dtsi
>> @@ -0,0 +1,120 @@
>> +// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +/*
>> + * Copyright (c) 2022 Nuvoton Technology Corp.
>> + */
>> +
>> +#include <dt-bindings/interrupt-controller/arm-gic.h>
>> +#include <dt-bindings/input/input.h>
>> +#include <dt-bindings/gpio/gpio.h>
>> +#include <dt-bindings/clock/nuvoton,ma35d1-clk.h>
>> +
>> +/ {
>> +	compatible = "nuvoton,ma35d1";
>> +	interrupt-parent = <&gic>;
>> +	#address-cells = <2>;
>> +	#size-cells = <2>;
>> +
>> +	cpus {
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>> +		cpu-map {
>> +			cluster0 {
>> +				core0 {
>> +					cpu = <&cpu0>;
>> +				};
>> +				core1 {
>> +					cpu = <&cpu1>;
>> +				};
>> +			};
>> +		};
>> +
>> +		cpu0: cpu@0 {
>> +			device_type = "cpu";
>> +			compatible = "arm,cortex-a35";
>> +			reg = <0x0>;
>> +			enable-method = "psci";
>> +			next-level-cache = <&L2_0>;
>> +		};
>> +
>> +		cpu1: cpu@1 {
>> +			device_type = "cpu";
>> +			compatible = "arm,cortex-a35";
>> +			reg = <0x1>;
>> +			enable-method = "psci";
>> +			next-level-cache = <&L2_0>;
>> +		};
>> +
>> +		L2_0: l2-cache0 {
>> +			compatible = "cache";
>> +			cache-level = <2>;
>> +		};
>> +	};
>> +
>> +	psci {
>> +		compatible = "arm,psci-0.2";
>> +		method = "smc";
>> +	};
>> +
>> +	hxt_24m: hxt_24mhz {
> No underscores in node name. Generic node names, so "clock-X" or
> "clock-some-suffix"

OK, I will modify it as
  hxt-24m: hxt-24mhz

>> +		compatible = "fixed-clock";
>> +		#clock-cells = <0>;
>> +		clock-frequency = <24000000>;
> This does not look like property of SoC. Where is this clock defined? In
> the SoC or on the board?

It's an external crystal on the board.
I add this node, because it's the clock source of clock controller.
It always present on all ma35d1 boards.

     clk: clock-controller@40460200 {
         compatible = "nuvoton,ma35d1-clk";
         reg = <0x0 0x40460200 0x0 0x100>;
         #clock-cells = <1>;
         clocks = <&hxt_24m>;
         clock-names = "HXT_24MHz";
...

>> +		clock-output-names = "HXT_24MHz";
>> +	};
>> +
>> +	timer {
>> +		compatible = "arm,armv8-timer";
>> +		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) |
>> +					  IRQ_TYPE_LEVEL_LOW)>,
>> +			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) |
>> +					  IRQ_TYPE_LEVEL_LOW)>,
>> +			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) |
>> +					  IRQ_TYPE_LEVEL_LOW)>,
>> +			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) |
>> +					  IRQ_TYPE_LEVEL_LOW)>;
>> +		clock-frequency = <12000000>;
>> +	};
>> +
>> +	sys: system-controller@40460000 {
>> +		compatible = "nuvoton,ma35d1-sys", "syscon", "simple-mfd";
> Why is this a simple-mfd if there are no children here? What do you want
> to instantiate here?

It's not a device, but a set of registers for system level control.
I want to provide a register base mapping for other devices to access 
system control registers.

> Where is the nuvoton,ma35d1-sys compatible documented?

OK, I will add the compatible document in next version.


>> +		reg = <0x0 0x40460000 0x0 0x400>;
>> +	};
>> +
>> +	reset: reset-controller {
>> +		compatible = "nuvoton,ma35d1-reset";
> Also not documented.

I will also add the document for it.

>
>> +		nuvoton,ma35d1-sys = <&sys>;
>> +		#reset-cells = <1>;
>> +	};
>> +
>> +	clk: clock-controller@40460200 {
>> +		compatible = "nuvoton,ma35d1-clk";
>> +		reg = <0x0 0x40460200 0x0 0x100>;
>> +		#clock-cells = <1>;
>> +		clocks = <&hxt_24m>;
>> +		clock-names = "HXT_24MHz";
> Please test your DTS with make dtbs_check.
>
> Don't send DTS which does not pass the checks. It is unnecessary use of
> reviewers time when the same job can be done by automated tools.
>
> Best regards,
> Krzysztof

Yes, I read the "writing-schema.rst" and know how to do now.
Thank you.

Sincerely,
Jacky Huang


