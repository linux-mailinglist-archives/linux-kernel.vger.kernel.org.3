Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A83D8563033
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 11:34:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235818AbiGAJdj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 05:33:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232029AbiGAJdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 05:33:37 -0400
Received: from smtpout1.mo528.mail-out.ovh.net (smtpout1.mo528.mail-out.ovh.net [46.105.34.251])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8471C74371;
        Fri,  1 Jul 2022 02:33:32 -0700 (PDT)
Received: from pro2.mail.ovh.net (unknown [10.109.143.68])
        by mo528.mail-out.ovh.net (Postfix) with ESMTPS id 2E11311478EAB;
        Fri,  1 Jul 2022 11:33:29 +0200 (CEST)
Received: from [192.168.1.41] (88.161.25.233) by DAG1EX2.emp2.local
 (172.16.2.2) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.9; Fri, 1 Jul 2022
 11:33:29 +0200
Message-ID: <c84d0513-b89b-0eea-eeaf-68dc634bd7b0@traphandler.com>
Date:   Fri, 1 Jul 2022 11:33:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 3/4] dt-bindings: leds: Add binding for a multicolor group
 of LEDs
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
CC:     <pavel@ucw.cz>, <sven.schwermer@disruptive-technologies.com>,
        <krzysztof.kozlowski+dt@linaro.org>, <johan+linaro@kernel.org>,
        <marijn.suijten@somainline.org>, <bjorn.andersson@linaro.org>,
        <andy.shevchenko@gmail.com>, <linux-leds@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20220615154918.521687-1-jjhiblot@traphandler.com>
 <20220615154918.521687-4-jjhiblot@traphandler.com>
 <20220627221257.GA3046298-robh@kernel.org>
From:   Jean-Jacques Hiblot <jjhiblot@traphandler.com>
In-Reply-To: <20220627221257.GA3046298-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [88.161.25.233]
X-ClientProxiedBy: DAG2EX1.emp2.local (172.16.2.11) To DAG1EX2.emp2.local
 (172.16.2.2)
X-Ovh-Tracer-Id: 13792836810162911707
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvfedrudehfedgudekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgihesthejredttdefjeenucfhrhhomheplfgvrghnqdflrggtqhhuvghsucfjihgslhhothcuoehjjhhhihgslhhothesthhrrghphhgrnhgulhgvrhdrtghomheqnecuggftrfgrthhtvghrnhepuefgvedvledufeekjeeltedvjeeuuddvtdetjeefjedvveehkeeufeeihfelgfeknecuffhomhgrihhnpeguvghvihgtvghtrhgvvgdrohhrghenucfkpheptddrtddrtddrtddpkeekrdduiedurddvhedrvdeffeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphhouhhtpdhhvghlohepphhrohdvrdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepjhhjhhhisghlohhtsehtrhgrphhhrghnughlvghrrdgtohhmpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdfovfetjfhoshhtpehmohehvdek
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 28/06/2022 00:12, Rob Herring wrote:
> On Wed, Jun 15, 2022 at 05:49:17PM +0200, Jean-Jacques Hiblot wrote:
>> This allows to group multiple monochromatic LEDs into a multicolor
>> LED, e.g. RGB LEDs.
>>
>> Signed-off-by: Jean-Jacques Hiblot <jjhiblot@traphandler.com>
>> ---
>>   .../bindings/leds/leds-group-multicolor.yaml  | 94 +++++++++++++++++++
>>   1 file changed, 94 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/leds/leds-group-multicolor.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/leds/leds-group-multicolor.yaml b/Documentation/devicetree/bindings/leds/leds-group-multicolor.yaml
>> new file mode 100644
>> index 000000000000..30a67985ae33
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/leds/leds-group-multicolor.yaml
>> @@ -0,0 +1,94 @@
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
>> +  multi-led:
>> +    type: object
>> +
>> +    patternProperties:
>> +      "^led-[0-9a-z]+$":
>> +        type: object
>> +        $ref: common.yaml#
>> +
>> +        additionalProperties: false
>> +
>> +        properties:
>> +          leds:
> Not a standard property. What is the type?
That would be a reference to the node of a LED
> Really, just do a GPIO multi-color LED binding similar to the PWM one
> rather than adding this layer. I suppose you could combine LEDs from all
> different controllers, but that seems somewhat unlikely to me.

I'm not using gpio leds, rather leds driven by two TLC5925.

I agree that combining from different model of controller is unlikely. 
However from 2 separate chips of the same model is not (ex: driving 5 
RGB LEDs with two 8-output chips)

In the case of the TLC5925, that is not really a problem because as long 
as the chips are on the same CS, they are considered as a single entity 
by the driver. But for I2C chips at least that would be a problem.


JJ

>
> Rob
