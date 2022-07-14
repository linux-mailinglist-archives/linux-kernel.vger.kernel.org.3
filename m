Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9285D5741D5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 05:22:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232667AbiGNDWu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 23:22:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbiGNDWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 23:22:47 -0400
Received: from mail-sz.amlogic.com (mail-sz.amlogic.com [211.162.65.117])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB3F7240AA;
        Wed, 13 Jul 2022 20:22:45 -0700 (PDT)
Received: from [10.88.19.41] (10.88.19.41) by mail-sz.amlogic.com (10.28.11.5)
 with Microsoft SMTP Server id 15.1.2176.2; Thu, 14 Jul 2022 11:22:42 +0800
Message-ID: <6543a75a-fd9f-7395-70b2-15a19d872339@amlogic.com>
Date:   Thu, 14 Jul 2022 11:22:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.2
Subject: Re: [PATCH 4/4] dt-binding:perf: Add Amlogic DDR PMU
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
References: <20220712063641.2790997-1-jiucheng.xu@amlogic.com>
 <20220712063641.2790997-4-jiucheng.xu@amlogic.com>
 <1aa8e9aa-8cb3-8537-6d65-dd9441d5ee07@linaro.org>
From:   Jiucheng Xu <jiucheng.xu@amlogic.com>
In-Reply-To: <1aa8e9aa-8cb3-8537-6d65-dd9441d5ee07@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.88.19.41]
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for your time ^^.

On 7/12/2022 3:15 PM, Krzysztof Kozlowski wrote:
> [ EXTERNAL EMAIL ]
>
> On 12/07/2022 08:36, Jiucheng Xu wrote:
>> Add binding documentation for the Amlogic G12 series DDR
>> performance monitor unit.
> You need to fix subject - use a prefix matching subsystem. Space after
> each ':'.
I will make the change.
>
>> Signed-off-by: Jiucheng Xu <jiucheng.xu@amlogic.com>
>> ---
>>   .../devicetree/bindings/perf/aml-ddr-pmu.yaml | 51 +++++++++++++++++++
>>   MAINTAINERS                                   |  1 +
>>   2 files changed, 52 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/perf/aml-ddr-pmu.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/perf/aml-ddr-pmu.yaml b/Documentation/devicetree/bindings/perf/aml-ddr-pmu.yaml
>> new file mode 100644
>> index 000000000000..c586b4ab4009
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/perf/aml-ddr-pmu.yaml
> Filename: aml,g12-ddr-pmu.yaml
I will make the change.
>
>> @@ -0,0 +1,51 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/perf/aml-ddr-pmu.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Amlogic G12 DDR performance monitor
>> +
>> +maintainers:
>> +  - Jiucheng Xu <jiucheng.xu@amlogic.com>
>> +
>> +properties:
>> +  compatible:
>> +    oneOf:
>> +      - enum:
>> +          - aml,g12-ddr-pmu
>> +      - items:
>> +          - enum:
>> +              - aml,g12-ddr-pmu
>> +          - const: aml,g12-ddr-pmu
> This does not make any sense. Why do you use two compatibles
> "aml,g12-ddr-pmu", "aml,g12-ddr-pmu" after each other?
Sorry, I think I have a wrong understanding. I will make the change.
>
>> +
>> +  reg:
>> +    maxItems: 2
> You need to describe the items.
I will make the change.
>
>> +
>> +  interrupts:
>> +    maxItems: 1
>> +
>> +required:
>> +  - compatible
>> +  - model
>> +  - dmc_nr
>> +  - chann_nr
> How these ended up here?
> No underscores.
I will make the change.
>
>> +  - reg
>> +  - interrupts
>> +  - interrupt-names
> Also something new. No.
I will make the change.
>
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +          ddr_pmu: ddr_pmu {
> Wrong indentation. 4 spaces for DTS example.
>
> Generic node name, so "pmu", no underscores in node names.
Okay, I will make the change.
>
>> +                  compatible = "amlogic,g12-ddr-pmu";
>> +                  model = "g12a";
>> +                  dmc_nr = <1>;
>> +                  chann_nr = <4>;
> This does not pass the test. Please do not send untested bindings.

Sorry,  due to some problems, I got wrong patch sent. I will make the 
change.


Thanks & Best Regards,

Jiucheng

>
>
> Best regards,
> Krzysztof
>
