Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2C7555D2B1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238241AbiF1HPE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 03:15:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbiF1HPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 03:15:00 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E56382C12A;
        Tue, 28 Jun 2022 00:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1656400499; x=1687936499;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=lwXZcqdSLbWOAYvNr7FmnphJ8eGlnyLRMExAFU84AxA=;
  b=ltyox8WnviG2e+S+kpvGUU5F/F05ebqqTKJt65x+AdKX/AnKKUrgfBbq
   715SK6pUm6NxUD+v9vLeWRFxl5MqGdEADWDaD7B5VKe/88pRzyYo51SMP
   C7K9wfG+lDIYMcWqkNYL8DKAW3A7coz5NbVH7lJFMbGH7H5MVe+4gQiIp
   E=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 28 Jun 2022 00:14:58 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 00:14:58 -0700
Received: from nalasex01c.na.qualcomm.com (10.47.97.35) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 28 Jun 2022 00:14:57 -0700
Received: from [10.216.11.205] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 28 Jun
 2022 00:14:51 -0700
Message-ID: <2a16703b-5b1e-5ce9-0af0-2e08da49d8ed@quicinc.com>
Date:   Tue, 28 Jun 2022 12:44:48 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH V2 7/8] arm64: dts: Add ipq5018 SoC and MP03 board support
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@somainline.org>, <agross@kernel.org>,
        <bjorn.andersson@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <linus.walleij@linaro.org>,
        <catalin.marinas@arm.com>, <p.zabel@pengutronix.de>,
        <quic_varada@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20220621161126.15883-1-quic_srichara@quicinc.com>
 <20220621161126.15883-8-quic_srichara@quicinc.com>
 <f8aa5f81-e77c-db28-519d-7d9ee119dcf3@somainline.org>
From:   Sricharan Ramabadhran <quic_srichara@quicinc.com>
In-Reply-To: <f8aa5f81-e77c-db28-519d-7d9ee119dcf3@somainline.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Konrad for the review.

On 6/27/2022 12:02 AM, Konrad Dybcio wrote:
>
> On 21.06.2022 18:11, Sricharan R wrote:
>> From: Varadarajan Narayanan <quic_varada@quicinc.com>
>>
>> Add initial device tree support for the Qualcomm IPQ5018 SoC and
>> MP03.1-C2 board.
>>
>> Co-developed-by: Sricharan R <quic_srichara@quicinc.com>
>> Signed-off-by: Sricharan R <quic_srichara@quicinc.com>
>> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
>> ---
>>   arch/arm64/boot/dts/qcom/Makefile             |   1 +
>>   .../arm64/boot/dts/qcom/ipq5018-mp03.1-c2.dts |  29 +++
>>   arch/arm64/boot/dts/qcom/ipq5018.dtsi         | 221 ++++++++++++++++++
>>   3 files changed, 251 insertions(+)
>>   create mode 100644 arch/arm64/boot/dts/qcom/ipq5018-mp03.1-c2.dts
>>   create mode 100644 arch/arm64/boot/dts/qcom/ipq5018.dtsi
>>
>> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
>> index f9e6343acd03..c44e701f093c 100644
>> --- a/arch/arm64/boot/dts/qcom/Makefile
>> +++ b/arch/arm64/boot/dts/qcom/Makefile
>> @@ -10,6 +10,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= ipq8074-hk10-c2.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-alcatel-idol347.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-asus-z00l.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-huawei-g7.dtb
>> +dtb-$(CONFIG_ARCH_QCOM)	+= ipq5018-mp03.1-c2.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-longcheer-l8150.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-longcheer-l8910.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-mtp.dtb
>> diff --git a/arch/arm64/boot/dts/qcom/ipq5018-mp03.1-c2.dts b/arch/arm64/boot/dts/qcom/ipq5018-mp03.1-c2.dts
>> new file mode 100644
>> index 000000000000..d1cd080ec3db
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/qcom/ipq5018-mp03.1-c2.dts
>> @@ -0,0 +1,29 @@
>> +// SPDX-License-Identifier: GPL-2.0+ OR BSD-3-Clause
>> +/*
>> + * IPQ5018 CP01 board device tree source
>> + *
>> + * Copyright (c) 2020-2021, The Linux Foundation. All rights reserved.
>> + */
>> +
>> +/dts-v1/;
>> +
>> +#include "ipq5018.dtsi"
>> +
>> +/ {
>> +	model = "Qualcomm Technologies, Inc. IPQ5018/AP-MP03-C2";
>> +	compatible = "qcom,ipq5018-mp03", "qcom,ipq5018";
>> +
>> +	aliases {
>> +		serial0 = &blsp1_uart1;
>> +	};
>> +
>> +	chosen {
>> +		stdout-path = "serial0:115200n8";
>> +	};
>> +};
>> +
>> +&blsp1_uart1 {
>> +	pinctrl-0 = <&serial_1_pins>;
>> +	pinctrl-names = "default";
>> +	status = "ok";
>> +};
>> diff --git a/arch/arm64/boot/dts/qcom/ipq5018.dtsi b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
>> new file mode 100644
>> index 000000000000..084fb7b30dfd
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
>> @@ -0,0 +1,221 @@
>> +// SPDX-License-Identifier: GPL-2.0+ OR BSD-3-Clause
>> +/*
>> + * Copyright (c) 2017-2021, The Linux Foundation. All rights reserved.
>> + */
>> +/*
>> + * IPQ5018 SoC device tree source
>> + *
>> + * Copyright (c) 2019, The Linux Foundation. All rights reserved.
>> + */
>> +
>> +#include <dt-bindings/interrupt-controller/arm-gic.h>
>> +#include <dt-bindings/clock/qcom,gcc-ipq5018.h>
>> +#include <dt-bindings/reset/qcom,gcc-ipq5018.h>
>> +
>> +/ {
>> +	#address-cells = <2>;
>> +	#size-cells = <2>;
>> +	interrupt-parent = <&intc>;
> Hi!
>
> interrupt-parent could go first.

  ok.


>> +
>> +	sleep_clk: sleep-clk {
>> +		compatible = "fixed-clock";
>> +		clock-frequency = <32000>;
>> +		#clock-cells = <0>;
>> +	};
>> +
>> +	xo: xo {
>> +		compatible = "fixed-clock";
>> +		clock-frequency = <24000000>;
>> +		#clock-cells = <0>;
>> +	};
>> +
>> +	gen2clk0: gen2clk0 {
>> +		compatible = "fixed-clock";
>> +		#clock-cells = <0>;
>> +		clock-frequency = <125000000>;
>> +		clock-output-names = "pcie20_phy0_pipe_clk";
>> +	};
>> +
>> +	gen2clk1: gen2clk1 {
>> +		compatible = "fixed-clock";
>> +		#clock-cells = <0>;
>> +		clock-frequency = <125000000>;
>> +		clock-output-names = "pcie20_phy1_pipe_clk";
>> +	};
> I am not sure what's the current stance on this, but previously clock nodes
> used to be wrapped in a clocks {} node, as currently they are not sorted
> properly.
>
  hmm ok, yeah, see the clocks { node in some recent dts as well, will 
add the wrapper.


>> +
>> +	cpus: cpus {
> Is this label going to be used?
   hmm, not used, will remove.
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>> +
>> +		CPU0: cpu@0 {
>> +			device_type = "cpu";
>> +			compatible = "arm,cortex-a53";
>> +			reg = <0x0>;
>> +			enable-method = "psci";
>> +			next-level-cache = <&L2_0>;
>> +		};
>> +
>> +		CPU1: cpu@1 {
>> +			device_type = "cpu";
>> +			compatible = "arm,cortex-a53";
>> +			enable-method = "psci";
>> +			reg = <0x1>;
>> +			next-level-cache = <&L2_0>;
>> +		};
>> +
>> +		L2_0: l2-cache {
>> +			compatible = "cache";
>> +			cache-level = <0x2>;
> This should probably be dec, as it's not a register.

    'dec' ? Sorry, i did not get that.


>> +		};
>> +	};
>> +
>> +	pmuv8: pmu {
> Are there any other PMUs? And is this label going to be used?

   ok, will remove the label.


>> +		compatible = "arm,cortex-a53-pmu";
>> +		interrupts = <GIC_PPI 7 (GIC_CPU_MASK_SIMPLE(4) |
>> +					 IRQ_TYPE_LEVEL_HIGH)>;
> I think this can fit in a single 100-char line.
>
   ok.


>> +	};
>> +
>> +	psci: psci {
>> +		compatible = "arm,psci-1.0";
>> +		method = "smc";
>> +	};
>> +
>> +	memory@40000000 {
> This node is not sorted properly.

   ok, will sort for all nodes.


>> +		device_type = "memory";
>> +		/* We expect the bootloader to fill in the size */
>> +		reg = <0x0 0x40000000 0x0 0x0>;
>> +	};
>> +
>> +	reserved-memory {
>> +		#address-cells = <2>;
>> +		#size-cells = <2>;
>> +		ranges;
>> +
>> +		tz: tz@4ac00000 {
> Please rename it to tz_memory or tz_region or something more
> descriptive. Also, memory@

  ok.


>> +			reg = <0x0 0x4ac00000 0x0 0x00400000>;
> I don't think we tend to pad size to 8 hex digits.

  ok.


>> +			no-map;
>> +		};
>> +	};
>> +
>> +	timer {
> This is not sorted properly.

  ok.


>> +		compatible = "arm,armv8-timer";
>> +		interrupts = <GIC_PPI 2 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
>> +			     <GIC_PPI 3 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
>> +			     <GIC_PPI 4 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
>> +			     <GIC_PPI 1 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
>> +	};
>> +
>> +	soc: soc@0 {
>> +		#address-cells = <1>;
>> +		#size-cells = <1>;
>> +		ranges = <0 0 0 0xffffffff>;
> Isn't that the default value?

   ok, if omitting this would be retain the default, then will do it.


>> +		compatible = "simple-bus";
> Please sort the properties.

   ok.


>> +
>> +		tlmm: pinctrl@1000000 {
>> +			compatible = "qcom,ipq5018-pinctrl";
>> +			reg = <0x01000000 0x300000>;
>> +			interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
>> +			gpio-controller;
>> +			#gpio-cells = <2>;
>> +			gpio-ranges = <&tlmm 0 80>;
>> +			interrupt-controller;
>> +			#interrupt-cells = <2>;
>> +
>> +			serial_1_pins: serial1-pinmux {
> Other DTs call it uart pins, also this is the default/poweron
> state but the hardware provides support for sleep/poweroff.
> Please rename this accordingly.

   ok.


>> +				pins = "gpio31", "gpio32", "gpio33", "gpio34";
>> +				function = "blsp1_uart1";
>> +				drive-strength = <8>;
>> +				bias-pull-down;
>> +			};
>> +		};
>> +
>> +		gcc: clock-controller@1800000 {
>> +			compatible = "qcom,gcc-ipq5018";
>> +			reg = <0x01800000 0x80000>;
>> +			clocks = <&xo>, <&sleep_clk>;
>> +			clock-names = "xo", "sleep_clk";
>> +			#clock-cells = <1>;
>> +			#reset-cells = <1>;
>> +		};
>> +
>> +		blsp1_uart1: serial@78af000 {
>> +			compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
>> +			reg = <0x078af000 0x200>;
>> +			interrupts = <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
>> +			clocks = <&gcc GCC_BLSP1_UART1_APPS_CLK>,
>> +				<&gcc GCC_BLSP1_AHB_CLK>;
> Not sure whether thunderbird is dumb again, or the indentation
> is off by 1 space.
   indentation issue, will fix.
>> +			clock-names = "core", "iface";
>> +			status = "disabled";
>> +		};
>> +
>> +		intc: interrupt-controller@b000000 {
>> +			compatible = "qcom,msm-qgic2";
> Please sort the properties (compatible and reg gotta go first, etc.).

  ok.


>> +			interrupt-controller;
>> +			#interrupt-cells = <0x3>;
> *-cells should be decimal.
>
   ok.


>> +			reg =   <0x0b000000 0x1000>,  /*GICD*/
> /* GICD */, please (and the next ones too)

  ok.


>> +				<0x0b002000 0x1000>,  /*GICC*/
>> +				<0x0b001000 0x1000>,  /*GICH*/
>> +				<0x0b004000 0x1000>;  /*GICV*/
>> +			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
>> +		};
>> +
>> +		timer@b120000 {
>> +			#address-cells = <1>;
>> +			#size-cells = <1>;
>> +			ranges;
>> +			compatible = "arm,armv7-timer-mem";
>> +			reg = <0x0b120000 0x1000>;
>> +			clock-frequency = <19200000>;
> Please sort the properties, also in subnodes.

   ok, will do.

Regards,
   Sricharan


