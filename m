Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 593A95879CE
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 11:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235949AbiHBJZf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 05:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232771AbiHBJZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 05:25:32 -0400
Received: from mail-sz.amlogic.com (mail-sz.amlogic.com [211.162.65.117])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AA2F1A819;
        Tue,  2 Aug 2022 02:25:30 -0700 (PDT)
Received: from [10.88.19.200] (10.88.19.200) by mail-sz.amlogic.com
 (10.28.11.5) with Microsoft SMTP Server id 15.1.2507.6; Tue, 2 Aug 2022
 17:25:28 +0800
Message-ID: <bafb824a-d450-b4d3-20a9-026dccaca2cd@amlogic.com>
Date:   Tue, 2 Aug 2022 17:25:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.2
Subject: Re: [PATCH v3 4/4] dt-binding: perf: Add Amlogic DDR PMU
Content-Language: en-US
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
References: <20220801060049.1655177-1-jiucheng.xu@amlogic.com>
 <20220801060049.1655177-4-jiucheng.xu@amlogic.com>
 <0893fab6-a7e1-bfa7-2497-239e044cc7ed@linaro.org>
From:   Jiucheng Xu <jiucheng.xu@amlogic.com>
In-Reply-To: <0893fab6-a7e1-bfa7-2497-239e044cc7ed@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.88.19.200]
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/8/2 16:04, Krzysztof Kozlowski wrote:
> [ EXTERNAL EMAIL ]
>
> On 01/08/2022 08:00, Jiucheng Xu wrote:
>> Add binding documentation for the Amlogic G12 series DDR
>> performance monitor unit.
>>
>> Signed-off-by: Jiucheng Xu <jiucheng.xu@amlogic.com>
>> ---
>> Changes v2 -> v3:
>>    - Remove oneOf
>>    - Add descriptions
>>    - Fix compiling warning
>>
>> Changes v1 -> v2:
>>    - Rename file, from aml_ddr_pmu.yaml to amlogic,g12_ddr_pmu.yaml
>>    - Delete "model", "dmc_nr", "chann_nr" new properties
>>    - Fix compiling error
>> ---
>>   .../bindings/perf/amlogic,g12_ddr_pmu.yaml    | 51 +++++++++++++++++++
>>   MAINTAINERS                                   |  1 +
>>   2 files changed, 52 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/perf/amlogic,g12_ddr_pmu.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/perf/amlogic,g12_ddr_pmu.yaml b/Documentation/devicetree/bindings/perf/amlogic,g12_ddr_pmu.yaml
>> new file mode 100644
>> index 000000000000..961656d4db6e
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/perf/amlogic,g12_ddr_pmu.yaml
>> @@ -0,0 +1,51 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/perf/amlogic,g12-ddr-pmu.yaml#
> You still did not test the bindings...
>
> You received such comment (with instructions how to do it) and still
> decided to send untested bindings.
>
> That's not how submission procces should look like.
>
> NAK, till you send something which you actually test.
>
>
> Best regards,
> Krzysztof

Hi Krzysztof,


Thanks for your time. I think I got a wrong understanding.

As the binding doc says, I run the following command to check:

# make dt_binding_check DT_SCHEMA_FILES=amlogic,g12_ddr_pmu.yaml ARCH=arm64

I saw the warning/errors in v2 patch, and thanks to your comments let 
them gone.

But I didn't see any warning/errors keywords printing in v3 except the 
message as below:

"$id: relative path/filename doesn't match actual path or filename".


I admit I didn't understand this prompt. I found the doc in example says 
that:

# $id is a unique identifier based on the filename. There may or may not 
be a
# file present at the URL.

So I thought that was not warning/errors prompt.

Today, I find the root cause of the warning/errors prompt.

I think I have fixed it and the building log is so quiet.


This is my first upstream patch, TBH I even didn't know what is binding 
before.

In order to upstream my driver, I try to learn how to write binding scheme.

It looks like I still did terribly.

I think my stupid misunderstanding get you angry. I'm sorry for wasting 
your time and comments.

I will re-submit v4 to fix it.

-- 
Thanks,
Jiucheng

