Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70FC1592C03
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 12:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240385AbiHOJE5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 05:04:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231418AbiHOJEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 05:04:37 -0400
Received: from mail-sz.amlogic.com (mail-sz.amlogic.com [211.162.65.117])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F826222A7;
        Mon, 15 Aug 2022 02:04:32 -0700 (PDT)
Received: from [10.88.37.200] (10.88.37.200) by mail-sz.amlogic.com
 (10.28.11.5) with Microsoft SMTP Server id 15.1.2507.6; Mon, 15 Aug 2022
 17:04:28 +0800
Message-ID: <c57044ca-3742-37c1-b8ad-14806cbc05ea@amlogic.com>
Date:   Mon, 15 Aug 2022 17:04:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH v4 4/4] dt-binding: perf: Add Amlogic DDR PMU
Content-Language: en-US
From:   Jiucheng Xu <jiucheng.xu@amlogic.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>, <devicetree@vger.kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Chris Healy <cphealy@gmail.com>
References: <20220805071426.2598818-1-jiucheng.xu@amlogic.com>
 <20220805071426.2598818-4-jiucheng.xu@amlogic.com>
 <a3cd55ad-cec2-9570-2078-6724ab1d7300@linaro.org>
 <880842a1-a769-f228-7c91-5402e6d9391e@amlogic.com>
In-Reply-To: <880842a1-a769-f228-7c91-5402e6d9391e@amlogic.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.88.37.200]
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/8/5 18:00, Jiucheng Xu wrote:
>
> On 2022/8/5 16:21, Krzysztof Kozlowski wrote:
>> [ EXTERNAL EMAIL ]
>>
>> On 05/08/2022 09:14, Jiucheng Xu wrote:
>>> Add binding documentation for the Amlogic G12 series DDR
>>> performance monitor unit.
>>>
>> Bindings go first in the series, before their implementation.
>>
>>> Signed-off-by: Jiucheng Xu <jiucheng.xu@amlogic.com>
>>> ---
>>> Changes v3 -> v4:
>>>    - Fix "$id: relative path/filename doesn't match actual path or
>>>      filename" warning
>>>
>>> Changes v2 -> v3:
>>>    - Remove oneOf
>>>    - Add descriptions
>>>    - Fix compiling warning
>>>
>>> Changes v1 -> v2:
>>>    - Rename file, from aml_ddr_pmu.yaml to amlogic,g12_ddr_pmu.yaml
>>>    - Delete "model", "dmc_nr", "chann_nr" new properties
>>>    - Fix compiling error
>>> ---
>>>   .../bindings/perf/amlogic,g12-ddr-pmu.yaml    | 52 
>>> +++++++++++++++++++
>>>   MAINTAINERS                                   |  1 +
>>>   2 files changed, 53 insertions(+)
>>>   create mode 100644 
>>> Documentation/devicetree/bindings/perf/amlogic,g12-ddr-pmu.yaml
>>>
>>> diff --git 
>>> a/Documentation/devicetree/bindings/perf/amlogic,g12-ddr-pmu.yaml 
>>> b/Documentation/devicetree/bindings/perf/amlogic,g12-ddr-pmu.yaml
>>> new file mode 100644
>>> index 000000000000..4d018574ffd1
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/perf/amlogic,g12-ddr-pmu.yaml
>>> @@ -0,0 +1,52 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/perf/amlogic,g12-ddr-pmu.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Amlogic G12 DDR performance monitor
>>> +
>>> +maintainers:
>>> +  - Jiucheng Xu <jiucheng.xu@amlogic.com>
>>> +
>>> +description: |
>>> +  Amlogic G12 series SoC integrate DDR bandwidth monitor.
>>> +  A timer is inside and can generate interrupt when timeout.
>>> +  The bandwidth is counted in the timer ISR. Different platform
>>> +  has different subset of event format attribute.
>>> +
>>> +properties:
>>> +  compatible:
>>> +    items:
>> You have only one item, so remove "items".

Hi Krzysztof,

I have tried to remove "items", but error comes.

properties:
   compatible:
     - enum:
       - amlogic,g12a-ddr-pmu
       - amlogic,g12b-ddr-pmu
       - amlogic,sm1-ddr-pmu

Do I get misunderstand? I think the "item" is necessary.

>>
>>> +      - enum:
>>> +          - amlogic,g12b-ddr-pmu
>>> +          - amlogic,g12a-ddr-pmu
>>> +          - amlogic,sm1-ddr-pmu
>>> +
>>> +  reg:
>>> +    items:
>>> +      - description: Physical address of DMC bandwidth register
>>> +          and size of the configuration address space.
>> Skip obvious pieces, so only:
>>
>> description: DMC bandwidth register space
>>
>>> +      - description: Physical address of DMC PLL register and
>>> +          size of the configuration address space.
>> description: DMC PLL bandwidth register space
>>
>>
>>> +
>>> +  interrupts:
>>> +    items:
>>> +      - description: The IRQ of the inside timer timeout.
>>> +
>>> +required:
>>> +  - compatible
>>> +  - reg
>>> +  - interrupts
>>> +
>>> +additionalProperties: false
>>> +
>>> +examples:
>>> +  - |
>>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>>> +    ddr_pmu@ff638000 {
>> No underscores in node names, generic node names, so just "pmu".
>> https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation 
>>
>>
>>> +        compatible = "amlogic,g12a-ddr-pmu";
>>> +        reg = <0xff638000 0x100
>>> +               0xff638c00 0x100>;
>> This is still not fixed. Binding says you have two items, but you
>> declared here only one item.
>
> Okay, I will change it as your comments.
>
>
>> Best regards,
>> Krzysztof
>>
-- 
Thanks,
Jiucheng

