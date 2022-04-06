Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8640E4F5FF8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 15:30:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233370AbiDFN3i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 09:29:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233646AbiDFN2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 09:28:01 -0400
Received: from maillog.nuvoton.com (maillog.nuvoton.com [202.39.227.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 578D01BE117;
        Wed,  6 Apr 2022 03:25:47 -0700 (PDT)
Received: from NTHCCAS04.nuvoton.com (NTHCCAS04.nuvoton.com [10.1.8.29])
        by maillog.nuvoton.com (Postfix) with ESMTP id 236BF1C8112B;
        Wed,  6 Apr 2022 17:25:44 +0800 (CST)
Received: from NTHCCAS03.nuvoton.com (10.1.20.28) by NTHCCAS04.nuvoton.com
 (10.1.8.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 6 Apr
 2022 17:25:43 +0800
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCCAS03.nuvoton.com
 (10.1.20.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1847.3; Wed, 6 Apr 2022
 17:25:43 +0800
Received: from [172.19.1.47] (172.19.1.47) by NTHCCAS01.nuvoton.com
 (10.1.12.25) with Microsoft SMTP Server id 15.1.2375.7 via Frontend
 Transport; Wed, 6 Apr 2022 17:25:42 +0800
Message-ID: <ab89589f-6dd7-d4ff-635d-ff8dbd2d3e02@nuvoton.com>
Date:   Wed, 6 Apr 2022 17:25:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 3/3] arm64: dts: nuvoton: Add initial support for MA35D1
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
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
 <ef8efda1-e985-0684-470f-7acf9b8a5e93@nuvoton.com>
 <bba99b9d-6960-f6e8-0ee4-0b5fe8a5601d@linaro.org>
From:   Jacky Huang <ychuang3@nuvoton.com>
In-Reply-To: <bba99b9d-6960-f6e8-0ee4-0b5fe8a5601d@linaro.org>
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



On 2022/4/6 下午 03:14, Krzysztof Kozlowski wrote:
> On 06/04/2022 04:58, Jacky Huang wrote:
>>>> diff --git a/arch/arm64/boot/dts/Makefile b/arch/arm64/boot/dts/Makefile
>>>> index 639e01a4d855..28e01442094f 100644
>>>> --- a/arch/arm64/boot/dts/Makefile
>>>> +++ b/arch/arm64/boot/dts/Makefile
>>>> @@ -30,3 +30,4 @@ subdir-y += synaptics
>>>>    subdir-y += ti
>>>>    subdir-y += toshiba
>>>>    subdir-y += xilinx
>>>> +subdir-y += nuvoton
>>>> diff --git a/arch/arm64/boot/dts/nuvoton/Makefile b/arch/arm64/boot/dts/nuvoton/Makefile
>>>> new file mode 100644
>>>> index 000000000000..e1e0c466bf5e
>>>> --- /dev/null
>>>> +++ b/arch/arm64/boot/dts/nuvoton/Makefile
>>>> @@ -0,0 +1,2 @@
>>>> +# SPDX-License-Identifier: GPL-2.0
>>>> +dtb-$(CONFIG_ARCH_NUVOTON) += ma35d1-evb.dtb
>>> ARCH_NUVOTON does not exist.
>> I would add the following to end of arch/arm64/Kconfig.platforms,
> Don't add things at the end of files but rather in respective place
> without messing the order.

OK, I will put it to the right place in alphanumeric order.
It should be between ARCH_MXC and ARCH_QCOM.

>
>> and
>> add the
>> modification to this patch series.
>>
>> config ARCH_MA35D1
>>       bool "Nuvoton MA35D1 SOC Family"
> We do not add options for specific SoCs, but for entire families, so
> ARCH_NUVOTON is correct.

Yes, I would like to modify it as the following:

config ARCH_NUVOTON
     bool "Nuvoton SoC Family"
     select PINCTRL
     select PINCTRL_MA35D1
     select PM
     select GPIOLIB
     select SOC_BUS
     help
       This enables support for Nuvoton MA35D1 ARMv8 SoC.

(Currently, we have MA35D1 only in the support list for arm64 SoC.).

>>       select PINCTRL
>>       select PINCTRL_MA35D1
>>       select PM
>>       select GPIOLIB
>>       select SOC_BUS
>>       select VIDEOMODE_HELPERS
>>       select FB_MODE_HELPERS
>>       help
>>         This enables support for Nuvoton MA35D1 SOC Family.
>>
>>
>>>> diff --git a/arch/arm64/boot/dts/nuvoton/ma35d1-evb.dts b/arch/arm64/boot/dts/nuvoton/ma35d1-evb.dts
>>>> new file mode 100644
>>>> index 000000000000..38e4f734da0f
>>>> --- /dev/null
>>>> +++ b/arch/arm64/boot/dts/nuvoton/ma35d1-evb.dts
>>>> @@ -0,0 +1,23 @@
>>>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>>>> +/*
>>>> + * Device Tree Source for MA35D1 Evaluation Board (EVB)
>>>> + *
>>>> + * Copyright (C) 2021 Nuvoton Technology Corp.
>>>> + */
>>>> +
>>>> +/dts-v1/;
>>>> +#include "ma35d1.dtsi"
>>>> +
>>>> +/ {
>>>> +       model = "Nuvoton MA35D1-EVB";
>>>> +
>>>> +       chosen {
>>>> +               bootargs = "console=ttyS0,115200n8";
>>> No bootargs. "chosen", please.
>> OK, I would modify it as:
>>
>> chosen {
>>           stdout-path = "serial0:115200n8";
>>       };
>>
>>
>>>> +       };
>>> You need compatible and bindings.
>> I will add the compatible here
>> compatible = "nuvoton,ma35d1-evb", "nuvoton,ma35d1"
>>
>> And, I should create a new binding file
>> Documentation/devicetree/bindings/arm/nuvoton.yaml to this patch series.
>> And the property would be:
>>
>> properties:
>>     compatible:
>>       description: Nuvoton MA35D1-EVB
>>       items:
>>         - const: nuvoton,ma35d1-evb
>>         - const: nuvoton,ma35d1
>>
>>
>> Is it OK?
> Yes
>
>
>
> Best regards,
> Krzysztof

Thanks for your review.

Sincerely,
Jacky


