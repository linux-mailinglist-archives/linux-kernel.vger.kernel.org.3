Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FA0E506874
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 12:12:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350527AbiDSKO7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 06:14:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350531AbiDSKOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 06:14:54 -0400
Received: from maillog.nuvoton.com (maillog.nuvoton.com [202.39.227.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5BE9C255B1;
        Tue, 19 Apr 2022 03:12:10 -0700 (PDT)
Received: from NTHCCAS04.nuvoton.com (NTHCCAS04.nuvoton.com [10.1.8.29])
        by maillog.nuvoton.com (Postfix) with ESMTP id 3DD611C81110;
        Tue, 19 Apr 2022 18:12:09 +0800 (CST)
Received: from NTHCCAS04.nuvoton.com (10.1.8.29) by NTHCCAS04.nuvoton.com
 (10.1.8.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 19
 Apr 2022 18:12:08 +0800
Received: from [172.19.1.47] (172.19.1.47) by NTHCCAS04.nuvoton.com
 (10.1.12.25) with Microsoft SMTP Server id 15.1.2176.2 via Frontend
 Transport; Tue, 19 Apr 2022 18:12:08 +0800
Message-ID: <29b00c24-681a-7f6f-f27d-b7525c5b8485@nuvoton.com>
Date:   Tue, 19 Apr 2022 18:12:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v3 2/5] dt-bindings: clock: Document MA35D1 clock
 controller bindings
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <ychuang570808@gmail.com>
CC:     <robh+dt@kernel.org>, <sboyd@kernel.org>, <krzk+dt@kernel.org>,
        <arnd@arndb.de>, <olof@lixom.net>, <will@kernel.org>,
        <soc@kernel.org>, <cfli0@nuvoton.com>
References: <20220418082738.11301-1-ychuang3@nuvoton.com>
 <20220418082738.11301-3-ychuang3@nuvoton.com>
 <2f8d2f6a-32dc-15cc-321c-f75721edf8a2@linaro.org>
From:   Jacky Huang <ychuang3@nuvoton.com>
In-Reply-To: <2f8d2f6a-32dc-15cc-321c-f75721edf8a2@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/4/18 下午 08:18, Krzysztof Kozlowski wrote:
> On 18/04/2022 10:27, Jacky Huang wrote:
>> Add documentation to describe Nuvoton MA35D1 clock driver bindings.
>>
> You skipped the review tag, so I assume because of amount of changes.
> Usually it is nice to mention it...

I search the mail loop and find the "Reviewed-by" tag.
Now I know I should add the review tag to my patch.
Thanks for your reminding.


>> Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
>> ---
>>   .../bindings/clock/nuvoton,ma35d1-clk.yaml    | 63 +++++++++++++++++++
>>   1 file changed, 63 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/clock/nuvoton,ma35d1-clk.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/clock/nuvoton,ma35d1-clk.yaml b/Documentation/devicetree/bindings/clock/nuvoton,ma35d1-clk.yaml
>> new file mode 100644
>> index 000000000000..d0d37c5e84af
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/clock/nuvoton,ma35d1-clk.yaml
>> @@ -0,0 +1,63 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: https://apc01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fdevicetree.org%2Fschemas%2Fclock%2Fnuvoton%2Cma35d1-clk.yaml%23&amp;data=05%7C01%7Cychuang3%40nuvoton.com%7C345b237bf1254018654b08da213588f9%7Ca3f24931d4034b4a94f17d83ac638e07%7C0%7C0%7C637858811062058468%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=gCnLGCaMeUI4kdu23m0T9g6eGPd37z8%2BatQQb%2Ftnxb4%3D&amp;reserved=0
>> +$schema: https://apc01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fdevicetree.org%2Fmeta-schemas%2Fcore.yaml%23&amp;data=05%7C01%7Cychuang3%40nuvoton.com%7C345b237bf1254018654b08da213588f9%7Ca3f24931d4034b4a94f17d83ac638e07%7C0%7C0%7C637858811062058468%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=dj6FannQd0GxVJ%2BGlAjqs08SbNzPKi6ibdyLxLfR4q4%3D&amp;reserved=0
>> +
>> +title: Nuvoton MA35D1 Clock Control Module Binding
>> +
>> +maintainers:
>> +  - Chi-Fang Li <cfli0@nuvoton.com>
>> +  - Jacky Huang <ychuang3@nuvoton.com>
>> +
>> +description: |
>> +  The MA35D1 clock controller generates clocks for the whole chip,
>> +  including system clocks and all peripheral clocks.
>> +
>> +  See also:
>> +    include/dt-bindings/clock/ma35d1-clk.h
>> +
>> +properties:
>> +  compatible:
>> +    const: nuvoton,ma35d1-clk
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  "#clock-cells":
>> +    const: 1
>> +
>> +  assigned-clocks:
> What about clocks? This depends on clocks. What clocks do you want to
> assign if they are not an input to the device?

The clock source of all PLLs are from external 24 MHz crystal.
Yes, I should add clocks such as
clocks = <&hxt_24m>

and add a node
     hxt_24m: hxt_24m {
         compatible = "fixed-clock";
         #clock-cells = <0>;
         clock-frequency = <24000000>;
         clock-output-names = "hxt_24m";
     };


>> +    minItems: 5
>> +    maxItems: 5
> This is different than before. minItems should not be here.
>
> Why do you need assigned-clocks in the binding at all?

The clock controller is equipped with 5 PLLs, which generated clocks for
CPU, DDR, and various peripheral bus. The assigned-clocks describe
these PLL output clocks.
I will remove the minItems.

>> +
>> +  assigned-clock-rates:
>> +    minItems: 5
>> +    maxItems: 5
>> +
>> +  nuvoton,clk-pll-mode:
>> +    A list of PLL operation mode corresponding to DDRPLL, APLL, EPLL,
>> +    and VPLL in sequential.
> This does not look like a binding which was tested. Read
> "writing-schema" and test your bindings.

"nuvoton,clk-pll-mode" is a nonstandard property used to describe the 
operation mode of
corresponding PLLs.

(According to Device tree Specification section "2.2.4 Properties"
Nonstandard property names should specify a unique string prefix, such 
as a stock ticker symbol, identifying the name of
the company or organization that defined the property. Examples:
fsl,channel-fifo-len
ibm,ppc-interrupt-server#s
linux,network-index)
>> +    $ref: /schemas/types.yaml#/definitions/uint32-array
>> +    minItems: 5
> No need for minItems.

Yes, I will remove it.

>> +    maxItems: 5
>> +    items:
>> +      enum: [ 0, 1, 2 ]
> You need to describe the values in description, what's their meaning.

OK, I will add description about the values represented for PLL 
operation modes.


>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - "#clock-cells"
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/clock/nuvoton,ma35d1-clk.h>
>> +
>> +    clk: clock-controller@40460200 {
>> +        compatible = "nuvoton,ma35d1-clk";
>> +        reg = <0x0 0x40460200 0x0 0x100>;
>> +        #clock-cells = <1>;
>> +    };
>> +...
>
> Best regards,
> Krzysztof

Thanks for your review.

Sincerely,
Jacky Huang


