Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDA3255E2A1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:35:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232775AbiF0H5L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 03:57:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233183AbiF0H5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 03:57:10 -0400
Received: from smtpout1.mo3004.mail-out.ovh.net (smtpout1.mo3004.mail-out.ovh.net [79.137.123.219])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E02B60FD;
        Mon, 27 Jun 2022 00:57:08 -0700 (PDT)
Received: from pro2.mail.ovh.net (unknown [10.108.4.193])
        by mo3004.mail-out.ovh.net (Postfix) with ESMTPS id 5447D23D650;
        Mon, 27 Jun 2022 07:57:06 +0000 (UTC)
Received: from [192.168.1.41] (88.161.25.233) by DAG1EX2.emp2.local
 (172.16.2.2) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.9; Mon, 27 Jun
 2022 09:57:05 +0200
Message-ID: <fdd31cbb-186d-f403-5650-2e9fde7070fe@traphandler.com>
Date:   Mon, 27 Jun 2022 09:57:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v5 1/3] dt-bindings: leds: Add bindings for the TLC5925
 controller
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
CC:     <pavel@ucw.cz>, <krzk+dt@kernel.org>, <andy.shevchenko@gmail.com>,
        <linux-leds@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20220614154245.354167-1-jjhiblot@traphandler.com>
 <20220614154245.354167-2-jjhiblot@traphandler.com>
 <20220617231949.GA2613244-robh@kernel.org>
From:   Jean-Jacques Hiblot <jjhiblot@traphandler.com>
In-Reply-To: <20220617231949.GA2613244-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [88.161.25.233]
X-ClientProxiedBy: DAG1EX1.emp2.local (172.16.2.1) To DAG1EX2.emp2.local
 (172.16.2.2)
X-Ovh-Tracer-Id: 7120753961133291995
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvfedrudeggedguddvfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfhisehtjeertddtfeejnecuhfhrohhmpeflvggrnhdqlfgrtghquhgvshcujfhisghlohhtuceojhhjhhhisghlohhtsehtrhgrphhhrghnughlvghrrdgtohhmqeenucggtffrrghtthgvrhhnpeeugfevvdeludefkeejleetvdejueduvddtteejfeejvdevheekueefiefhlefgkeenucffohhmrghinhepuggvvhhitggvthhrvggvrdhorhhgnecukfhppedtrddtrddtrddtpdekkedrudeiuddrvdehrddvfeefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpohhuthdphhgvlhhopehprhhovddrmhgrihhlrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehjjhhhihgslhhothesthhrrghphhgrnhgulhgvrhdrtghomhdpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdpoffvtefjohhsthepmhhofedttdeg
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 18/06/2022 01:19, Rob Herring wrote:
> On Tue, Jun 14, 2022 at 05:42:43PM +0200, Jean-Jacques Hiblot wrote:
>> Add bindings documentation for the TLC5925 LED controller.
>>
>> Signed-off-by: Jean-Jacques Hiblot <jjhiblot@traphandler.com>
>> ---
>>   .../devicetree/bindings/leds/ti,tlc5925.yaml  | 107 ++++++++++++++++++
>>   1 file changed, 107 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/leds/ti,tlc5925.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/leds/ti,tlc5925.yaml b/Documentation/devicetree/bindings/leds/ti,tlc5925.yaml
>> new file mode 100644
>> index 000000000000..12a71e48f854
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/leds/ti,tlc5925.yaml
>> @@ -0,0 +1,107 @@
>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/leds/ti,tlc5925.yaml#
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
>> +$ref: /schemas/spi/spi-peripheral-props.yaml#
>> +
>> +properties:
>> +  compatible:
>> +    const: ti,tlc5925
>> +
>> +  ti,shift-register-length:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    minimum: 8
>> +    description: |
> Don't need '|' if no formatting to preserve.
>
>> +      The length of the shift register. If several TLC5925 are chained,
>> +      shift_register_length should be set to 16 times the number of TLC5925.
>> +      The value must be a multiple of 8.
> multipleOf: 8
>
> Though I'm confused why it's not 16.

The reason why it is 8 instead of 16, is that there exists other LEDs 
controllers that are compatible with this driver and use only a 8-bits 
shift register.

The main reason is that the granularity of the size of a SPI transfer is 
8 bits.

>> +
>> +  "#address-cells":
>> +    const: 1
>> +
>> +  "#size-cells":
>> +    const: 0
>> +
>> +  output-enable-b-gpios:
>> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> Already has a type.
>
>> +    description: |
>> +      Optional GPIO pins to enable/disable the parallel output. They describe
>> +      the GPIOs connected to the OE/ pin of the TLC5925s.
>> +
>> +patternProperties:
>> +  "@[0-9a-f]+$":
>> +    type: object
>> +    $ref: common.yaml#
>         unevaluatedProperties: false
>
>> +
>> +    properties:
>> +      reg:
>> +        $ref: /schemas/types.yaml#/definitions/uint32
> Don't need a type here.
>
>> +        description: |
>> +          LED pin number (must be lower than ti,shift-register-length).
>> +          The furthest LED down the chain has the pin number 0.
>> +
>> +    required:
>> +      - reg
>> +
>> +required:
>> +  - "#address-cells"
>> +  - "#size-cells"
>> +  - ti,shift-register-length
> Is there not a default when not chained?

A default value could be used indeed. I'll rework the driver to use a 
default value of 16

Thanks

Jean-Jacques

>
>> +
>> +unevaluatedProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/gpio/gpio.h>
>> +    #include <dt-bindings/leds/common.h>
>> +
>> +    spi0 {
> spi {
>
>> +        #address-cells = <1>;
>> +        #size-cells = <0>;
>> +
>> +        leds@2 {
>> +            compatible = "ti,tlc5925";
>> +            reg = <0x02>;
>> +            spi-max-frequency = <30000000>;
>> +            ti,shift-register-length = <32>;
>> +            output-enable-b-gpios = <&gpio0b 9 GPIO_ACTIVE_HIGH>, <&gpio0b 7 GPIO_ACTIVE_HIGH>;
>> +            #address-cells = <1>;
>> +            #size-cells = <0>;
>> +
>> +            led@0 {
>> +                reg = <0>;
>> +                function = LED_FUNCTION_STATUS;
>> +                color = <LED_COLOR_ID_GREEN>;
>> +            };
>> +
>> +            led@4 {
>> +                reg = <4>;
>> +                function = LED_FUNCTION_STATUS;
>> +                color = <LED_COLOR_ID_RED>;
>> +            };
>> +
>> +            led@1f {
>> +                reg = <31>;
>> +                function = LED_FUNCTION_PANIC;
>> +                color = <LED_COLOR_ID_RED>;
>> +            };
>> +        };
>> +
>> +    };
>> -- 
>> 2.25.1
>>
>>
