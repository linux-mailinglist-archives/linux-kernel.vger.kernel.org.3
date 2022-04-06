Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75BA94F580A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 10:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243488AbiDFIet (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 04:34:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359474AbiDFId1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 04:33:27 -0400
Received: from maillog.nuvoton.com (maillog.nuvoton.com [202.39.227.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 55EB61563F4;
        Tue,  5 Apr 2022 19:59:00 -0700 (PDT)
Received: from NTHCCAS01.nuvoton.com (NTHCCAS01.nuvoton.com [10.1.8.28])
        by maillog.nuvoton.com (Postfix) with ESMTP id 9EE731C805DD;
        Wed,  6 Apr 2022 10:58:59 +0800 (CST)
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Wed, 6 Apr 2022
 10:58:59 +0800
Received: from [172.19.1.47] (172.19.1.47) by NTHCCAS01.nuvoton.com
 (10.1.12.25) with Microsoft SMTP Server id 15.1.2375.7 via Frontend
 Transport; Wed, 6 Apr 2022 10:58:59 +0800
Message-ID: <ef8efda1-e985-0684-470f-7acf9b8a5e93@nuvoton.com>
Date:   Wed, 6 Apr 2022 10:58:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 3/3] arm64: dts: nuvoton: Add initial support for MA35D1
Content-Language: en-US
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>, "olof@lixom.net" <olof@lixom.net>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "soc@kernel.org" <soc@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <20220307091923.9909-1-ychuang3@nuvoton.com>
 <20220307091923.9909-4-ychuang3@nuvoton.com>
 <2669852c-5bb6-1edf-bf58-ea815f54d50f@kernel.org>
From:   Jacky Huang <ychuang3@nuvoton.com>
In-Reply-To: <2669852c-5bb6-1edf-bf58-ea815f54d50f@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/3/7 下午 06:25, Krzysztof Kozlowski wrote:
> On 07/03/2022 10:19, Jacky Huang wrote:
>> Add the initial device tree files for Nuvoton MA35D1 Soc.
>>
>> Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
>> ---
>>   arch/arm64/boot/dts/Makefile               |   1 +
>>   arch/arm64/boot/dts/nuvoton/Makefile       |   2 +
>>   arch/arm64/boot/dts/nuvoton/ma35d1-evb.dts |  23 +++++
>>   arch/arm64/boot/dts/nuvoton/ma35d1.dtsi    | 106 +++++++++++++++++++++
>>   4 files changed, 132 insertions(+)
>>   create mode 100644 arch/arm64/boot/dts/nuvoton/Makefile
>>   create mode 100644 arch/arm64/boot/dts/nuvoton/ma35d1-evb.dts
>>   create mode 100644 arch/arm64/boot/dts/nuvoton/ma35d1.dtsi
>>
>> diff --git a/arch/arm64/boot/dts/Makefile b/arch/arm64/boot/dts/Makefile
>> index 639e01a4d855..28e01442094f 100644
>> --- a/arch/arm64/boot/dts/Makefile
>> +++ b/arch/arm64/boot/dts/Makefile
>> @@ -30,3 +30,4 @@ subdir-y += synaptics
>>   subdir-y += ti
>>   subdir-y += toshiba
>>   subdir-y += xilinx
>> +subdir-y += nuvoton
>> diff --git a/arch/arm64/boot/dts/nuvoton/Makefile b/arch/arm64/boot/dts/nuvoton/Makefile
>> new file mode 100644
>> index 000000000000..e1e0c466bf5e
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/nuvoton/Makefile
>> @@ -0,0 +1,2 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +dtb-$(CONFIG_ARCH_NUVOTON) += ma35d1-evb.dtb
> ARCH_NUVOTON does not exist.

I would add the following to end of arch/arm64/Kconfig.platforms, and 
add the
modification to this patch series.

config ARCH_MA35D1
     bool "Nuvoton MA35D1 SOC Family"
     select PINCTRL
     select PINCTRL_MA35D1
     select PM
     select GPIOLIB
     select SOC_BUS
     select VIDEOMODE_HELPERS
     select FB_MODE_HELPERS
     help
       This enables support for Nuvoton MA35D1 SOC Family.


>> diff --git a/arch/arm64/boot/dts/nuvoton/ma35d1-evb.dts b/arch/arm64/boot/dts/nuvoton/ma35d1-evb.dts
>> new file mode 100644
>> index 000000000000..38e4f734da0f
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/nuvoton/ma35d1-evb.dts
>> @@ -0,0 +1,23 @@
>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>> +/*
>> + * Device Tree Source for MA35D1 Evaluation Board (EVB)
>> + *
>> + * Copyright (C) 2021 Nuvoton Technology Corp.
>> + */
>> +
>> +/dts-v1/;
>> +#include "ma35d1.dtsi"
>> +
>> +/ {
>> +       model = "Nuvoton MA35D1-EVB";
>> +
>> +       chosen {
>> +               bootargs = "console=ttyS0,115200n8";
> No bootargs. "chosen", please.

OK, I would modify it as:

chosen {
         stdout-path = "serial0:115200n8";
     };


>> +       };
> You need compatible and bindings.

I will add the compatible here
compatible = "nuvoton,ma35d1-evb", "nuvoton,ma35d1"

And, I should create a new binding file 
Documentation/devicetree/bindings/arm/nuvoton.yaml to this patch series.
And the property would be:

properties:
   compatible:
     description: Nuvoton MA35D1-EVB
     items:
       - const: nuvoton,ma35d1-evb
       - const: nuvoton,ma35d1


Is it OK?

>> +
>> +       memory@80000000 {
>> +               device_type = "memory";
>> +               reg = <0x00000000 0x80000000 0 0x10000000>;
>> +       };
>> +};
>> +
>> diff --git a/arch/arm64/boot/dts/nuvoton/ma35d1.dtsi b/arch/arm64/boot/dts/nuvoton/ma35d1.dtsi
>> new file mode 100644
>> index 000000000000..27adac4975c3
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/nuvoton/ma35d1.dtsi
>> @@ -0,0 +1,106 @@
>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
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
>> +       compatible = "nuvoton,ma35d1";
> Please run checkpatch. This compatible looks undocumented.

I will create a new binding file 
Documentation/devicetree/bindings/arm/nuvoton.yaml to this patch series.


>> +       interrupt-parent = <&gic>;
>> +       #address-cells = <2>;
>> +       #size-cells = <2>;
>> +
>> +       cpus {
>> +               #address-cells = <2>;
>> +               #size-cells = <0>;
>> +               cpu-map {
>> +                       cluster0 {
>> +                               core0 {
>> +                                       cpu = <&cpu0>;
>> +                               };
>> +                               core1 {
>> +                                       cpu = <&cpu1>;
>> +                               };
>> +                       };
>> +               };
> Line break between each nodes, here and below.

OK, I will fix it in the next version.

>
>> +               cpu0: cpu@0 {
>> +                       device_type = "cpu";
>> +                       compatible = "arm,cortex-a35";
>> +                       reg = <0x0 0x0>;
>> +                       enable-method = "psci";
>> +                       next-level-cache = <&L2_0>;
>> +               };
>> +               cpu1: cpu@1 {
>> +                       device_type = "cpu";
>> +                       compatible = "arm,cortex-a35";
>> +                       reg = <0x0 0x1>;
>> +                       enable-method = "psci";
>> +                       next-level-cache = <&L2_0>;
>> +               };
>> +               L2_0: l2-cache0 {
>> +                       compatible = "cache";
>> +                       cache-level = <2>;
>> +               };
>> +       };
>> +
>> +       psci {
>> +               compatible = "arm,psci-0.2";
>> +               method = "smc";
>> +       };
>> +
>> +       timer {
>> +               compatible = "arm,armv8-timer";
>> +               interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) |
>> +                                         IRQ_TYPE_LEVEL_LOW)>,
>> +                            <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) |
>> +                                         IRQ_TYPE_LEVEL_LOW)>,
>> +                            <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) |
>> +                                         IRQ_TYPE_LEVEL_LOW)>,
>> +                            <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) |
>> +                                         IRQ_TYPE_LEVEL_LOW)>;
>> +               clock-frequency = <12000000>;
>> +       };
>> +
>> +       sys: system-controller@40460000 {
>> +               compatible = "nuvoton,ma35d1-sys", "syscon", "simple-mfd";
>> +               reg = <0x0 0x40460000 0x0 0x200>;
>> +       };
>> +
>> +       reset: reset-controller {
>> +               compatible = "nuvoton,ma35d1-reset";
>> +               nuvoton,ma35d1-sys = <&sys>;
>> +               #reset-cells = <1>;
>> +       };
>> +
>> +       clk: clock-controller@40460200 {
>> +               compatible = "nuvoton,ma35d1-clk";
>> +               reg = <0x00000000 0x40460200 0x0 0x100>;
>> +               #clock-cells = <1>;
>> +               assigned-clocks = <&clk DDRPLL>,
>> +                                 <&clk APLL>,
>> +                                 <&clk EPLL>,
>> +                                 <&clk VPLL>;
>> +               assigned-clock-rates = <266000000>,
>> +                                      <180000000>,
>> +                                      <500000000>,
>> +                                      <102000000>;
>> +               clock-pll-mode = <1>, <0>, <0>, <0>;
>> +       };
>> +
>> +       gic: interrupt-controller@50800000 {
>> +               compatible = "arm,gic-400";
>> +               #interrupt-cells = <3>;
>> +               interrupt-parent = <&gic>;
>> +               interrupt-controller;
>> +               reg = <0x0 0x50801000 0 0x1000>,
>> +                     <0x0 0x50802000 0 0x2000>,
>> +                     <0x0 0x50804000 0 0x2000>,
>> +                     <0x0 0x50806000 0 0x2000>;
>> +               interrupts = <GIC_PPI 9 (GIC_CPU_MASK_RAW(0x13) |
>> +                                        IRQ_TYPE_LEVEL_HIGH)>;
>> +       };
>> +};
>> --
>> 2.17.1
>>
>> ________________________________
>> ________________________________
>>   The privileged confidential information contained in this email is intended for use only by the addressees as indicated by the original sender of this email. If you are not the addressee indicated in this email or are not responsible for delivery of the email to such a person, please kindly reply to the sender indicating this fact and delete all copies of it from your computer and network server immediately.
>
>> Your cooperation is highly appreciated...
> Cooperation seems futile... :)
>
> Best regards,
> Krzysztof

I am sorry. I have requested mail server manager to add exception rule.
The unpleasant official declarations are removed.

Thanks for your review.

Sincerely,

Jacky




