Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6372C4F5B5C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 12:42:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbiDFKVZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 06:21:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378803AbiDFKUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 06:20:01 -0400
Received: from maillog.nuvoton.com (maillog.nuvoton.com [202.39.227.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9CE59281816;
        Tue,  5 Apr 2022 21:15:53 -0700 (PDT)
Received: from NTHCCAS04.nuvoton.com (NTHCCAS04.nuvoton.com [10.1.8.29])
        by maillog.nuvoton.com (Postfix) with ESMTP id B56A41C8112A;
        Wed,  6 Apr 2022 12:15:52 +0800 (CST)
Received: from NTHCCAS03.nuvoton.com (10.1.20.28) by NTHCCAS04.nuvoton.com
 (10.1.8.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 6 Apr
 2022 12:15:52 +0800
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCCAS03.nuvoton.com
 (10.1.20.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1847.3; Wed, 6 Apr 2022
 12:15:52 +0800
Received: from [172.19.1.47] (172.19.1.47) by NTHCCAS01.nuvoton.com
 (10.1.12.25) with Microsoft SMTP Server id 15.1.2375.7 via Frontend
 Transport; Wed, 6 Apr 2022 12:15:52 +0800
Message-ID: <6cf25693-38dd-3b3d-8f38-649fc208ac90@nuvoton.com>
Date:   Wed, 6 Apr 2022 12:15:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 2/3] dt-bindings: clock: Document MA35D1 clock controller
 bindings
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>, "olof@lixom.net" <olof@lixom.net>,
        "soc@kernel.org" <soc@kernel.org>, MS10 CFLi0 <CFLi0@nuvoton.com>
References: <20220331024256.14762-1-ychuang3@nuvoton.com>
 <20220331024256.14762-3-ychuang3@nuvoton.com>
 <YkYRGNr1o087/6MM@robh.at.kernel.org>
From:   Jacky Huang <ychuang3@nuvoton.com>
In-Reply-To: <YkYRGNr1o087/6MM@robh.at.kernel.org>
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



On 2022/4/1 上午 04:37, Rob Herring wrote:
> On Thu, Mar 31, 2022 at 10:42:55AM +0800, Jacky Huang wrote:
>> Add documentation to describe Nuvoton MA35D1 clock driver bindings.
>>
>> Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
>> ---
>>   .../bindings/clock/nuvoton,ma35d1-clk.yaml    | 59 +++++++++++++++++++
>>   1 file changed, 59 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/clock/nuvoton,ma35d1-clk.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/clock/nuvoton,ma35d1-clk.yaml b/Documentation/devicetree/bindings/clock/nuvoton,ma35d1-clk.yaml
>> new file mode 100644
>> index 000000000000..bf5474b10420
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/clock/nuvoton,ma35d1-clk.yaml
>> @@ -0,0 +1,59 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: https://apc01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fdevicetree.org%2Fschemas%2Fclock%2Fnuvoton%2Cma35d1-clk.yaml%23&amp;data=04%7C01%7Cychuang3%40nuvoton.com%7C2af0b5b253d14b24de4e08da1356520e%7Ca3f24931d4034b4a94f17d83ac638e07%7C0%7C0%7C637843795866047143%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=imev20A0MjoKYaL8o%2FXx3b%2FeCbSnXxVEjs9XqCLQZo0%3D&amp;reserved=0
>> +$schema: https://apc01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fdevicetree.org%2Fmeta-schemas%2Fcore.yaml%23&amp;data=04%7C01%7Cychuang3%40nuvoton.com%7C2af0b5b253d14b24de4e08da1356520e%7Ca3f24931d4034b4a94f17d83ac638e07%7C0%7C0%7C637843795866047143%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=zYcNQdhT2KPxQeVzPJ8Tm5gzRxk6Z0j7O6Cy01LWDRU%3D&amp;reserved=0
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
>> +    dt-bindings/clock/ma35d1-clk.h
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
>> +  clocks:
>> +    maxItems: 1
>> +
>> +  assigned-clocks:
>> +    maxItems: 4
> These aren't usually in the clock controller...

"clocks" is actually not used. I will remove it.

Does the "aren't usually" include "assigned-clocks"?
I saw it in other vendors.
For example rk3399.dtsi
It presents in cru: clock-controller@ff760000 node.

We use "assigned-clocks" to declare the four output PLLs of the clock 
controller.

>
>> +
>> +  assigned-clock-rates:
>> +    maxItems: 4
>> +
>> +  clock-pll-mode:
>> +    maxItems: 4
> What's this? Not a standard property. Needs a type, description, and
> vendor prefix.

clock-pll-mode is a vendor specific property.
I would modify it as the following:

   nuvoton,clk-pll-mode:
     A list of PLL operation mode corresponding to DDRPLL, APLL, EPLL, 
and VPLL
     in sequential.
     $ref: /schemas/types.yaml#/definitions/uint32-array
     minItems: 4
     maxItems: 4
     items:
       enum: [ 0, 1, 2 ]

Is it OK?


>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - "#clock-cells"
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  # clock control module node:
>> +  - |
>> +    #include <dt-bindings/clock/nuvoton,ma35d1-clk.h>
>> +
>> +    clk: clock-controller@40460200 {
>> +        compatible = "nuvoton,ma35d1-clk";
>> +        reg = <0x40460200 0x100>;
>> +        #clock-cells = <1>;
>> +    };
>> +...
>> -- 
>> 2.30.2
>>
>>

