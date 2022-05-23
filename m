Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CA6453142A
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 18:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237731AbiEWPQQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 11:16:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237564AbiEWPQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 11:16:13 -0400
Received: from smtpout1.mo528.mail-out.ovh.net (smtpout1.mo528.mail-out.ovh.net [46.105.34.251])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C3981CFD7;
        Mon, 23 May 2022 08:16:12 -0700 (PDT)
Received: from pro2.mail.ovh.net (unknown [10.108.20.84])
        by mo528.mail-out.ovh.net (Postfix) with ESMTPS id 338DA10372A93;
        Mon, 23 May 2022 17:16:10 +0200 (CEST)
Received: from [192.168.1.42] (88.161.25.233) by DAG1EX2.emp2.local
 (172.16.2.2) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.9; Mon, 23 May
 2022 17:16:10 +0200
Message-ID: <0e1e417a-6444-ddb5-5c48-c89bd78c5fe8@traphandler.com>
Date:   Mon, 23 May 2022 17:16:09 +0200
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
From:   Jean-Jacques Hiblot <jjhiblot@traphandler.com>
In-Reply-To: <d12a0afc-c040-5615-fc0d-70a5c29bbf0a@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [88.161.25.233]
X-ClientProxiedBy: CAS1.emp2.local (172.16.1.1) To DAG1EX2.emp2.local
 (172.16.2.2)
X-Ovh-Tracer-Id: 11905828566854613467
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvfedrjedugdehiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfhisehtjeertddtfeejnecuhfhrohhmpeflvggrnhdqlfgrtghquhgvshcujfhisghlohhtuceojhhjhhhisghlohhtsehtrhgrphhhrghnughlvghrrdgtohhmqeenucggtffrrghtthgvrhhnpeeugfevvdeludefkeejleetvdejueduvddtteejfeejvdevheekueefiefhlefgkeenucffohhmrghinhepuggvvhhitggvthhrvggvrdhorhhgnecukfhppedtrddtrddtrddtpdekkedrudeiuddrvdehrddvfeefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpohhuthdphhgvlhhopehprhhovddrmhgrihhlrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehjjhhhihgslhhothesthhrrghphhgrnhgulhgvrhdrtghomhdpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 23/05/2022 12:14, Krzysztof Kozlowski wrote:
> On 23/05/2022 10:49, Jean-Jacques Hiblot wrote:
>> Add bindings documentation for the TLC5925 LED controller.
>>
>> Signed-off-by: Jean-Jacques Hiblot <jjhiblot@traphandler.com>
> Thank you for your patch. There is something to discuss/improve.
>
>> ---
>> devicetree@vger.kernel.org
>>   .../bindings/leds/leds-tlc5925.yaml           | 100 ++++++++++++++++++
>>   1 file changed, 100 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/leds/leds-tlc5925.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/leds/leds-tlc5925.yaml b/Documentation/devicetree/bindings/leds/leds-tlc5925.yaml
>> new file mode 100644
>> index 000000000000..156db599d5a1
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/leds/leds-tlc5925.yaml
> Filename: vendor,device
> so "ti,tlc5925-leds.yaml" for example.
>
>
>
>> @@ -0,0 +1,100 @@
>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/leds/leds-tlc5925.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: LEDs connected to TI TLC5925 controller
>> +
>> +maintainers:
>> +  - Jean-Jacques Hiblot <jjhiblot@traphandler.com>
>> +
>> +description: |
>> +  The TLC5925 is a low-power 16-channel constant-current LED sink driver.
>> +  It is controlled through a SPI interface.
>> +  It is built around a shift register and latches which convert serial
>> +  input data into a parallel output. Several TLC5925 can be chained to
>> +  control more than 16 LEDs with a single chip-select.
>> +  The brightness level cannot be controlled, each LED is either on or off.
>> +
>> +  Each LED is represented as a sub-node of the ti,tlc5925 device.
>> +
>> +properties:
>> +  compatible:
>> +    const: ti,tlc5925
>> +
>> +  shift_register_length:
>> +    maxItems: 1
> No...
> 1. Did you test your bindings with dt_binding_check? This fails
> obviously... please, do not send untested bindings.
>
> 2. vendor prefix, no underscores, proper type, maxItems look wrong here
>
>> +    description: |
>> +      The length of the shift register. If several TLC5925 are chained,
>> +      shift_register_length should be set to 16 times the number of TLC5925.
>> +      The value must be a multiple of 8.
>> +
>> +  "#address-cells":
>> +    const: 1
>> +
>> +  "#size-cells":
>> +    const: 0
>> +
>> +  output-enable-b-gpios:
>> +    description: |
>> +      GPIO pins to enable/disable the parallel output. They describe the GPIOs
>> +      connected to the OE/ pin of the TLC5925s.
> maxItems

There is no limitation in the driver itself. The actual number of items 
here really depends on the number of chips and how they are wired.

>
>
>> +
>> +patternProperties:
>> +  "@[a-f0-9]+$":
> How many LEDs you can have here? Usually it is limited, so the pattern
> should be narrowed.

There is no limitation here either. The chips can be chained to augment 
the number of LEDs.

The max number of LED is equal to the length of the shift-register.


Jean-Jacques

>
>> +    type: object
>> +
>> +    $ref: common.yaml#
>> +
>> +    properties:
>> +      reg:
>> +        items:
> Not correct syntax... I will stop reviewing. There is no point to use
> reviewers time to do the job of a tool.
>
>
>> +examples:
>> +  - |
>> +    &spi0 {
>> +        leds@2 {
>> +                compatible = "ti,tlc5925";
> Messed up indentation. 4 spaces for DTS example.
>
>> +                reg = <0x02>;
>> +                spi-max-frequency = <30000000>;
>> +                shift_register_length = <32>;
>> +                output-enable-b-gpios = <&gpio0b 9 GPIO_ACTIVE_HIGH>, <&gpio0b 7 GPIO_ACTIVE_HIGH>;
>> +                #address-cells = <1>;
>> +                #size-cells = <0>;
>> +
>> +                led-satus@0 {
>> +                        reg = <0>;
>> +                        function = LED_FUNCTION_STATUS;
>> +                        color = <LED_COLOR_ID_GREEN>;
>> +                };
>> +
>> +                led-satus@4 {
>> +                        reg = <4>;
>> +                        function = LED_FUNCTION_STATUS;
>> +                        color = <LED_COLOR_ID_RED>;
>> +                };
>> +
>> +                led-alive@24 {
>> +                        reg = <24>;
>> +                        label = "green:alive"
>> +                };
>> +
>> +                led-panic@31 {
>> +                        reg = <31>;
>> +                        label = "red:panic"
>> +                };
>> +        };
>> +    };
>
> Best regards,
> Krzysztof
