Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BB1A59FA4C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 14:47:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234979AbiHXMre (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 08:47:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237373AbiHXMrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 08:47:22 -0400
Received: from smtpout1.mo3004.mail-out.ovh.net (smtpout1.mo3004.mail-out.ovh.net [79.137.123.219])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD34F915CF;
        Wed, 24 Aug 2022 05:47:20 -0700 (PDT)
Received: from pro2.mail.ovh.net (unknown [10.108.16.97])
        by mo3004.mail-out.ovh.net (Postfix) with ESMTPS id 545DF23F37B;
        Wed, 24 Aug 2022 12:47:19 +0000 (UTC)
Received: from [192.168.1.41] (88.161.25.233) by DAG1EX1.emp2.local
 (172.16.2.1) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12; Wed, 24 Aug
 2022 14:47:18 +0200
Message-ID: <d858ff7b-e835-bda5-a779-8acd42237923@traphandler.com>
Date:   Wed, 24 Aug 2022 14:47:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 3/4] dt-bindings: leds: Add binding for a multicolor
 group of LEDs
Content-Language: en-US
To:     Sascha Hauer <sha@pengutronix.de>
CC:     <pavel@ucw.cz>, <robh+dt@kernel.org>,
        <sven.schwermer@disruptive-technologies.com>,
        <krzysztof.kozlowski+dt@linaro.org>, <johan+linaro@kernel.org>,
        <marijn.suijten@somainline.org>, <bjorn.andersson@linaro.org>,
        <andy.shevchenko@gmail.com>, <linux-leds@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Rob Herring <robh@kernel.org>
References: <20220824103032.163451-1-jjhiblot@traphandler.com>
 <20220824103032.163451-4-jjhiblot@traphandler.com>
 <20220824122156.GQ17485@pengutronix.de>
From:   Jean-Jacques Hiblot <jjhiblot@traphandler.com>
In-Reply-To: <20220824122156.GQ17485@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [88.161.25.233]
X-ClientProxiedBy: DAG1EX1.emp2.local (172.16.2.1) To DAG1EX1.emp2.local
 (172.16.2.1)
X-Ovh-Tracer-Id: 2150187350555900369
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvfedrvdejuddgheejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgihesthejredttdefjeenucfhrhhomheplfgvrghnqdflrggtqhhuvghsucfjihgslhhothcuoehjjhhhihgslhhothesthhrrghphhgrnhgulhgvrhdrtghomheqnecuggftrfgrthhtvghrnhepuefgvedvledufeekjeeltedvjeeuuddvtdetjeefjedvveehkeeufeeihfelgfeknecuffhomhgrihhnpeguvghvihgtvghtrhgvvgdrohhrghenucfkpheptddrtddrtddrtddpkeekrdduiedurddvhedrvdeffeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphhouhhtpdhhvghlohepphhrohdvrdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepjhhjhhhisghlohhtsehtrhgrphhhrghnughlvghrrdgtohhmpdhnsggprhgtphhtthhopedupdhrtghpthhtoheprhhosghhsehkvghrnhgvlhdrohhrghdpoffvtefjohhsthepmhhofedttdeg
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 24/08/2022 14:21, Sascha Hauer wrote:
> On Wed, Aug 24, 2022 at 12:30:31PM +0200, Jean-Jacques Hiblot wrote:
>> This allows to group multiple monochromatic LEDs into a multicolor
>> LED, e.g. RGB LEDs.
>>
>> Signed-off-by: Jean-Jacques Hiblot <jjhiblot@traphandler.com>
>> Reviewed-by: Rob Herring <robh@kernel.org>
>> ---
>>   .../bindings/leds/leds-group-multicolor.yaml  | 61 +++++++++++++++++++
>>   1 file changed, 61 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/leds/leds-group-multicolor.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/leds/leds-group-multicolor.yaml b/Documentation/devicetree/bindings/leds/leds-group-multicolor.yaml
>> new file mode 100644
>> index 000000000000..79e5882a08e2
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/leds/leds-group-multicolor.yaml
>> @@ -0,0 +1,61 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/leds/leds-group-multicolor.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Multi-color LED built with monochromatic LEDs
>> +
>> +maintainers:
>> +  - Jean-Jacques Hiblot <jjhiblot@traphandler.com>
>> +
>> +description: |
>> +  This driver combines several monochromatic LEDs into one multi-color
>> +  LED using the multicolor LED class.
>> +
>> +properties:
>> +  compatible:
>> +    const: leds-group-multicolor
>> +
>> +  leds:
>> +    description:
>> +      An aray of monochromatic leds
>> +    $ref: /schemas/types.yaml#/definitions/phandle-array
>> +
>> +required:
>> +  - leds
>> +
>> +allOf:
>> +  - $ref: leds-class-multicolor.yaml#
>> +
>> +unevaluatedProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/gpio/gpio.h>
>> +    #include <dt-bindings/leds/common.h>
>> +
>> +    monochromatic-leds {
>> +        compatible = "gpio-leds";
>> +
>> +        led0: led-0 {
>> +            gpios = <&mcu_pio 0 GPIO_ACTIVE_LOW>;
>> +        };
>> +
>> +        led1: led-1 {
>> +            gpios = <&mcu_pio 1 GPIO_ACTIVE_HIGH>;
>> +        };
>> +
>> +        led2: led-2 {
>> +            gpios = <&mcu_pio 1 GPIO_ACTIVE_HIGH>;
>> +        };
> led-2 has the same GPIO as led-1, should likely be <&mcu_pio 2 GPIO_ACTIVE_HIGH>;
ok.
>
>> +    };
>> +
>> +    multi-led {
>> +        compatible = "leds-group-multicolor";
>> +        color = <LED_COLOR_ID_RGB>;
>> +        function = LED_FUNCTION_INDICATOR;
>> +        leds = <&led0>, <&led1>, <&led2>;
>> +    };
> When reading this I wondered how the driver knows which LED has which
> color. Should you assign colors to the individual LEDs to make that
> clear in the example?

Good point. I'll add this to the example. Thanks.

JJ

>
> Sascha
>
