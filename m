Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CB10562CA9
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 09:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234969AbiGAHb1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 03:31:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231218AbiGAHbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 03:31:25 -0400
Received: from relay05.th.seeweb.it (relay05.th.seeweb.it [IPv6:2001:4b7a:2000:18::166])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01B8E6B832;
        Fri,  1 Jul 2022 00:31:22 -0700 (PDT)
Received: from [192.168.1.101] (abxi46.neoplus.adsl.tpnet.pl [83.9.2.46])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id DF0693F7B4;
        Fri,  1 Jul 2022 09:31:18 +0200 (CEST)
Message-ID: <198fc303-30e5-31c7-5159-b787916ee6d8@somainline.org>
Date:   Fri, 1 Jul 2022 09:31:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH V2 7/8] arm64: dts: Add ipq5018 SoC and MP03 board support
Content-Language: en-US
To:     Sricharan Ramabadhran <quic_srichara@quicinc.com>,
        agross@kernel.org, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, linus.walleij@linaro.org,
        catalin.marinas@arm.com, p.zabel@pengutronix.de,
        quic_varada@quicinc.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20220621161126.15883-1-quic_srichara@quicinc.com>
 <20220621161126.15883-8-quic_srichara@quicinc.com>
 <f8aa5f81-e77c-db28-519d-7d9ee119dcf3@somainline.org>
 <2a16703b-5b1e-5ce9-0af0-2e08da49d8ed@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <2a16703b-5b1e-5ce9-0af0-2e08da49d8ed@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 28.06.2022 09:14, Sricharan Ramabadhran wrote:
> Thanks Konrad for the review.
> 
> On 6/27/2022 12:02 AM, Konrad Dybcio wrote:
>>
>> On 21.06.2022 18:11, Sricharan R wrote:
>>> From: Varadarajan Narayanan <quic_varada@quicinc.com>
>>>
>>> Add initial device tree support for the Qualcomm IPQ5018 SoC and
>>> MP03.1-C2 board.
>>>
>>> Co-developed-by: Sricharan R <quic_srichara@quicinc.com>
>>> Signed-off-by: Sricharan R <quic_srichara@quicinc.com>
>>> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
>>> ---
>>>   arch/arm64/boot/dts/qcom/Makefile             |   1 +
>>>   .../arm64/boot/dts/qcom/ipq5018-mp03.1-c2.dts |  29 +++
>>>   arch/arm64/boot/dts/qcom/ipq5018.dtsi         | 221 ++++++++++++++++++
>>>   3 files changed, 251 insertions(+)
>>>   create mode 100644 arch/arm64/boot/dts/qcom/ipq5018-mp03.1-c2.dts
>>>   create mode 100644 arch/arm64/boot/dts/qcom/ipq5018.dtsi
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
>>> index f9e6343acd03..c44e701f093c 100644
>>> --- a/arch/arm64/boot/dts/qcom/Makefile
>>> +++ b/arch/arm64/boot/dts/qcom/Makefile
>>> @@ -10,6 +10,7 @@ dtb-$(CONFIG_ARCH_QCOM)    += ipq8074-hk10-c2.dtb
>>>   dtb-$(CONFIG_ARCH_QCOM)    += msm8916-alcatel-idol347.dtb
>>>   dtb-$(CONFIG_ARCH_QCOM)    += msm8916-asus-z00l.dtb
>>>   dtb-$(CONFIG_ARCH_QCOM)    += msm8916-huawei-g7.dtb
>>> +dtb-$(CONFIG_ARCH_QCOM)    += ipq5018-mp03.1-c2.dtb
>>>   dtb-$(CONFIG_ARCH_QCOM)    += msm8916-longcheer-l8150.dtb
>>>   dtb-$(CONFIG_ARCH_QCOM)    += msm8916-longcheer-l8910.dtb
>>>   dtb-$(CONFIG_ARCH_QCOM)    += msm8916-mtp.dtb
>>> diff --git a/arch/arm64/boot/dts/qcom/ipq5018-mp03.1-c2.dts b/arch/arm64/boot/dts/qcom/ipq5018-mp03.1-c2.dts
>>> new file mode 100644
>>> index 000000000000..d1cd080ec3db
>>> --- /dev/null
>>> +++ b/arch/arm64/boot/dts/qcom/ipq5018-mp03.1-c2.dts
>>> @@ -0,0 +1,29 @@
>>> +// SPDX-License-Identifier: GPL-2.0+ OR BSD-3-Clause
>>> +/*
>>> + * IPQ5018 CP01 board device tree source
>>> + *
>>> + * Copyright (c) 2020-2021, The Linux Foundation. All rights reserved.
>>> + */
>>> +
>>> +/dts-v1/;
>>> +
>>> +#include "ipq5018.dtsi"
>>> +
>>> +/ {
>>> +    model = "Qualcomm Technologies, Inc. IPQ5018/AP-MP03-C2";
>>> +    compatible = "qcom,ipq5018-mp03", "qcom,ipq5018";
>>> +
>>> +    aliases {
>>> +        serial0 = &blsp1_uart1;
>>> +    };
>>> +
>>> +    chosen {
>>> +        stdout-path = "serial0:115200n8";
>>> +    };
>>> +};
>>> +
>>> +&blsp1_uart1 {
>>> +    pinctrl-0 = <&serial_1_pins>;
>>> +    pinctrl-names = "default";
>>> +    status = "ok";
>>> +};
>>> diff --git a/arch/arm64/boot/dts/qcom/ipq5018.dtsi b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
>>> new file mode 100644
>>> index 000000000000..084fb7b30dfd
>>> --- /dev/null
>>> +++ b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
>>> @@ -0,0 +1,221 @@
>>> +// SPDX-License-Identifier: GPL-2.0+ OR BSD-3-Clause
>>> +/*
>>> + * Copyright (c) 2017-2021, The Linux Foundation. All rights reserved.
>>> + */
>>> +/*
>>> + * IPQ5018 SoC device tree source
>>> + *
>>> + * Copyright (c) 2019, The Linux Foundation. All rights reserved.
>>> + */
>>> +
>>> +#include <dt-bindings/interrupt-controller/arm-gic.h>
>>> +#include <dt-bindings/clock/qcom,gcc-ipq5018.h>
>>> +#include <dt-bindings/reset/qcom,gcc-ipq5018.h>
>>> +
>>> +/ {
>>> +    #address-cells = <2>;
>>> +    #size-cells = <2>;
>>> +    interrupt-parent = <&intc>;
>> Hi!
>>
>> interrupt-parent could go first.
> 
>  ok.
> 
> 
>>> +
>>> +    sleep_clk: sleep-clk {
>>> +        compatible = "fixed-clock";
>>> +        clock-frequency = <32000>;
>>> +        #clock-cells = <0>;
>>> +    };
>>> +
>>> +    xo: xo {
>>> +        compatible = "fixed-clock";
>>> +        clock-frequency = <24000000>;
>>> +        #clock-cells = <0>;
>>> +    };
>>> +
>>> +    gen2clk0: gen2clk0 {
>>> +        compatible = "fixed-clock";
>>> +        #clock-cells = <0>;
>>> +        clock-frequency = <125000000>;
>>> +        clock-output-names = "pcie20_phy0_pipe_clk";
>>> +    };
>>> +
>>> +    gen2clk1: gen2clk1 {
>>> +        compatible = "fixed-clock";
>>> +        #clock-cells = <0>;
>>> +        clock-frequency = <125000000>;
>>> +        clock-output-names = "pcie20_phy1_pipe_clk";
>>> +    };
>> I am not sure what's the current stance on this, but previously clock nodes
>> used to be wrapped in a clocks {} node, as currently they are not sorted
>> properly.
>>
>  hmm ok, yeah, see the clocks { node in some recent dts as well, will add the wrapper.
> 
> 
>>> +
>>> +    cpus: cpus {
>> Is this label going to be used?
>   hmm, not used, will remove.
>>> +        #address-cells = <1>;
>>> +        #size-cells = <0>;
>>> +
>>> +        CPU0: cpu@0 {
>>> +            device_type = "cpu";
>>> +            compatible = "arm,cortex-a53";
>>> +            reg = <0x0>;
>>> +            enable-method = "psci";
>>> +            next-level-cache = <&L2_0>;
>>> +        };
>>> +
>>> +        CPU1: cpu@1 {
>>> +            device_type = "cpu";
>>> +            compatible = "arm,cortex-a53";
>>> +            enable-method = "psci";
>>> +            reg = <0x1>;
>>> +            next-level-cache = <&L2_0>;
>>> +        };
>>> +
>>> +        L2_0: l2-cache {
>>> +            compatible = "cache";
>>> +            cache-level = <0x2>;
>> This should probably be dec, as it's not a register.
> 
>    'dec' ? Sorry, i did not get that.
Short for decimal.

Konrad

[snip]
