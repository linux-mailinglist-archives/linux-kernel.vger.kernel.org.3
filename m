Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE40531275
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 18:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238057AbiEWPiE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 11:38:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238047AbiEWPh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 11:37:56 -0400
Received: from smtpout1.mo528.mail-out.ovh.net (smtpout1.mo528.mail-out.ovh.net [46.105.34.251])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 110A931217;
        Mon, 23 May 2022 08:37:51 -0700 (PDT)
Received: from pro2.mail.ovh.net (unknown [10.109.146.141])
        by mo528.mail-out.ovh.net (Postfix) with ESMTPS id 72B0710374D39;
        Mon, 23 May 2022 17:37:50 +0200 (CEST)
Received: from [192.168.1.42] (88.161.25.233) by DAG1EX2.emp2.local
 (172.16.2.2) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.9; Mon, 23 May
 2022 17:37:49 +0200
Message-ID: <bcf87cc8-85dc-efd6-1076-91e56ec4286c@traphandler.com>
Date:   Mon, 23 May 2022 17:37:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 1/3] dt-bindings: leds: Add bindings for the TLC5925
 controller
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
CC:     <linux-leds@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20220523084958.2723943-1-jjhiblot@traphandler.com>
 <20220523084958.2723943-2-jjhiblot@traphandler.com>
 <d12a0afc-c040-5615-fc0d-70a5c29bbf0a@linaro.org>
 <0e1e417a-6444-ddb5-5c48-c89bd78c5fe8@traphandler.com>
 <4f766cdb-a33b-2470-5b2e-3945c821ce6c@linaro.org>
From:   Jean-Jacques Hiblot <jjhiblot@traphandler.com>
In-Reply-To: <4f766cdb-a33b-2470-5b2e-3945c821ce6c@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [88.161.25.233]
X-ClientProxiedBy: CAS1.emp2.local (172.16.1.1) To DAG1EX2.emp2.local
 (172.16.2.2)
X-Ovh-Tracer-Id: 12271746037776660955
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvfedrjedugdeitdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfhisehtjeertddtfeejnecuhfhrohhmpeflvggrnhdqlfgrtghquhgvshcujfhisghlohhtuceojhhjhhhisghlohhtsehtrhgrphhhrghnughlvghrrdgtohhmqeenucggtffrrghtthgvrhhnpeeugfevvdeludefkeejleetvdejueduvddtteejfeejvdevheekueefiefhlefgkeenucffohhmrghinhepuggvvhhitggvthhrvggvrdhorhhgnecukfhppedtrddtrddtrddtpdekkedrudeiuddrvdehrddvfeefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpohhuthdphhgvlhhopehprhhovddrmhgrihhlrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehjjhhhihgslhhothesthhrrghphhgrnhgulhgvrhdrtghomhdpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 23/05/2022 17:30, Krzysztof Kozlowski wrote:
> On 23/05/2022 17:16, Jean-Jacques Hiblot wrote:
>> On 23/05/2022 12:14, Krzysztof Kozlowski wrote:
>>> On 23/05/2022 10:49, Jean-Jacques Hiblot wrote:
>>>> Add bindings documentation for the TLC5925 LED controller.
>>>>
>>>> Signed-off-by: Jean-Jacques Hiblot <jjhiblot@traphandler.com>
>>> Thank you for your patch. There is something to discuss/improve.
>>>
>>>> ---
>>>> devicetree@vger.kernel.org
>>>>    .../bindings/leds/leds-tlc5925.yaml           | 100 ++++++++++++++++++
>>>>    1 file changed, 100 insertions(+)
>>>>    create mode 100644 Documentation/devicetree/bindings/leds/leds-tlc5925.yaml
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/leds/leds-tlc5925.yaml b/Documentation/devicetree/bindings/leds/leds-tlc5925.yaml
>>>> new file mode 100644
>>>> index 000000000000..156db599d5a1
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/leds/leds-tlc5925.yaml
>>> Filename: vendor,device
>>> so "ti,tlc5925-leds.yaml" for example.
>>>
>>>
>>>
>>>> @@ -0,0 +1,100 @@
>>>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>>>> +%YAML 1.2
>>>> +---
>>>> +$id: http://devicetree.org/schemas/leds/leds-tlc5925.yaml#
>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>> +
>>>> +title: LEDs connected to TI TLC5925 controller
>>>> +
>>>> +maintainers:
>>>> +  - Jean-Jacques Hiblot <jjhiblot@traphandler.com>
>>>> +
>>>> +description: |
>>>> +  The TLC5925 is a low-power 16-channel constant-current LED sink driver.
>>>> +  It is controlled through a SPI interface.
>>>> +  It is built around a shift register and latches which convert serial
>>>> +  input data into a parallel output. Several TLC5925 can be chained to
>>>> +  control more than 16 LEDs with a single chip-select.
>>>> +  The brightness level cannot be controlled, each LED is either on or off.
>>>> +
>>>> +  Each LED is represented as a sub-node of the ti,tlc5925 device.
>>>> +
>>>> +properties:
>>>> +  compatible:
>>>> +    const: ti,tlc5925
>>>> +
>>>> +  shift_register_length:
>>>> +    maxItems: 1
>>> No...
>>> 1. Did you test your bindings with dt_binding_check? This fails
>>> obviously... please, do not send untested bindings.
>>>
>>> 2. vendor prefix, no underscores, proper type, maxItems look wrong here
>>>
>>>> +    description: |
>>>> +      The length of the shift register. If several TLC5925 are chained,
>>>> +      shift_register_length should be set to 16 times the number of TLC5925.
>>>> +      The value must be a multiple of 8.
>>>> +
>>>> +  "#address-cells":
>>>> +    const: 1
>>>> +
>>>> +  "#size-cells":
>>>> +    const: 0
>>>> +
>>>> +  output-enable-b-gpios:
>>>> +    description: |
>>>> +      GPIO pins to enable/disable the parallel output. They describe the GPIOs
>>>> +      connected to the OE/ pin of the TLC5925s.
>>> maxItems
>> There is no limitation in the driver itself. The actual number of items
>> here really depends on the number of chips and how they are wired.
> So you could daisy chain 4 billion of devices? Because by not using any
> limit you claim that 4 billion is doable?

You could chain 1000 devices or more and have 16000 leds. It would be a 
bit tedious to describe them all in the DTS though.

We can impose a limit but it will be arbitrary. Is this how it is 
usually treated ?

>>>
>>>> +
>>>> +patternProperties:
>>>> +  "@[a-f0-9]+$":
>>> How many LEDs you can have here? Usually it is limited, so the pattern
>>> should be narrowed.
>> There is no limitation here either. The chips can be chained to augment
>> the number of LEDs.
>>
>> The max number of LED is equal to the length of the shift-register.
>
>
> Best regards,
> Krzysztof
