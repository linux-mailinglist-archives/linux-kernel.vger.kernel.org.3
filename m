Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BD4B4ED4E1
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 09:36:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232210AbiCaHiX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 03:38:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232457AbiCaHiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 03:38:16 -0400
Received: from 9.mo548.mail-out.ovh.net (9.mo548.mail-out.ovh.net [46.105.48.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F328436683
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 00:36:27 -0700 (PDT)
Received: from mxplan5.mail.ovh.net (unknown [10.109.146.27])
        by mo548.mail-out.ovh.net (Postfix) with ESMTPS id EB566222D0;
        Thu, 31 Mar 2022 07:36:25 +0000 (UTC)
Received: from kaod.org (37.59.142.106) by DAG4EX1.mxp5.local (172.16.2.31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 31 Mar
 2022 09:36:25 +0200
Authentication-Results: garm.ovh; auth=pass (GARM-106R0063e6c707f-2c73-4ce7-b171-35deabf783d6,
                    FC9088D273F6636B0CAAD4892A2C3D02B7ACC8E0) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <2a411a3e-4b7f-c116-b595-f33bffccb4e7@kaod.org>
Date:   Thu, 31 Mar 2022 09:36:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v4 02/11] dt-bindings: spi: Add Aspeed SMC controllers
 device tree binding
Content-Language: en-US
To:     Pratyush Yadav <p.yadav@ti.com>
CC:     <linux-spi@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        Mark Brown <broonie@kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-aspeed@lists.ozlabs.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>,
        <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Tao Ren <rentao.bupt@gmail.com>,
        Rob Herring <robh@kernel.org>
References: <20220325100849.2019209-1-clg@kaod.org>
 <20220325100849.2019209-3-clg@kaod.org>
 <20220330191908.nhg52a5ayzczpzai@ti.com>
From:   =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20220330191908.nhg52a5ayzczpzai@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.106]
X-ClientProxiedBy: DAG3EX1.mxp5.local (172.16.2.21) To DAG4EX1.mxp5.local
 (172.16.2.31)
X-Ovh-Tracer-GUID: 42cf838e-2d6c-452a-9ac1-8df5f67bb224
X-Ovh-Tracer-Id: 6483213140691618762
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvvddrudeifedgudduiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfhfhfgjtgfgihesthekredttdefjeenucfhrhhomhepveorughrihgtpgfnvggpifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeduuedtgedugeehfedvfefhieetieefhfeiudeutefhffekieduueeuheegudegfeenucffohhmrghinhepuggvvhhitggvthhrvggvrdhorhhgnecukfhppedtrddtrddtrddtpdefjedrheelrddugedvrddutdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpohhuthdphhgvlhhopehmgihplhgrnhehrdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhnsggprhgtphhtthhopedupdhrtghpthhtoheprhhosghhsehkvghrnhgvlhdrohhrgh
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Pratyush,

On 3/30/22 21:19, Pratyush Yadav wrote:
> On 25/03/22 11:08AM, Cédric Le Goater wrote:
>> The "interrupt" property is optional because it is only necessary for
>> controllers supporting DMAs (Not implemented yet in the new driver).
>>
>> Cc: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
>> Tested-by: Joel Stanley <joel@jms.id.au>
>> Tested-by: Tao Ren <rentao.bupt@gmail.com>
>> Reviewed-by: Joel Stanley <joel@jms.id.au>
>> Reviewed-by: Rob Herring <robh@kernel.org>
>> Signed-off-by: Cédric Le Goater <clg@kaod.org>
>> ---
>>   .../bindings/spi/aspeed,ast2600-fmc.yaml      | 87 +++++++++++++++++++
>>   MAINTAINERS                                   |  9 ++
>>   2 files changed, 96 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/spi/aspeed,ast2600-fmc.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/spi/aspeed,ast2600-fmc.yaml b/Documentation/devicetree/bindings/spi/aspeed,ast2600-fmc.yaml
>> new file mode 100644
>> index 000000000000..e16bbcd38560
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/spi/aspeed,ast2600-fmc.yaml
>> @@ -0,0 +1,87 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/spi/aspeed,ast2600-fmc.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Aspeed SMC controllers bindings
>> +
>> +maintainers:
>> +  - Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
>> +  - Cédric Le Goater <clg@kaod.org>
>> +
>> +description: |
>> +  This binding describes the Aspeed Static Memory Controllers (FMC and
>> +  SPI) of the AST2400, AST2500 and AST2600 SOCs.
>> +
>> +allOf:
>> +  - $ref: "spi-controller.yaml#"
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - aspeed,ast2600-fmc
>> +      - aspeed,ast2600-spi
>> +      - aspeed,ast2500-fmc
>> +      - aspeed,ast2500-spi
>> +      - aspeed,ast2400-fmc
>> +      - aspeed,ast2400-spi
>> +
>> +  reg:
>> +    items:
>> +      - description: registers
>> +      - description: memory mapping
>> +
>> +  clocks:
>> +    maxItems: 1
>> +
>> +  interrupts:
>> +    maxItems: 1
>> +
>> +patternProperties:
>> +  "@[0-9a-f]+":
>> +    type: object
>> +
>> +    properties:
>> +      spi-rx-bus-width:
>> +        enum: [1, 2, 4]
> 
> No need for this. It should already be taken care of by
> spi-peripheral-props.yaml

So we could drop the whole 'patternProperties' section ?

> 
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - clocks
>> +
>> +unevaluatedProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>> +    #include <dt-bindings/interrupt-controller/aspeed-scu-ic.h>
>> +    #include <dt-bindings/clock/ast2600-clock.h>
>> +
>> +    spi@1e620000 {
>> +        reg = <0x1e620000 0xc4>, <0x20000000 0x10000000>;
>> +        #address-cells = <1>;
>> +        #size-cells = <0>;
>> +        compatible = "aspeed,ast2600-fmc";
>> +        clocks = <&syscon ASPEED_CLK_AHB>;
>> +        interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
> 
> Nitpick: Add a blank line here
> 
>> +        flash@0 {
>> +                reg = < 0 >;
>> +                compatible = "jedec,spi-nor";
>> +                spi-max-frequency = <50000000>;
>> +                spi-rx-bus-width = <2>;
>> +        };
> 
> and here
> 
>> +        flash@1 {
>> +                reg = < 1 >;
>> +                compatible = "jedec,spi-nor";
>> +                spi-max-frequency = <50000000>;
>> +                spi-rx-bus-width = <2>;
>> +        };
> 
> and here. Looks a bit nicer.

Thanks for the comments, I will provide the cleanups in v5.

C.



> 
>> +        flash@2 {
>> +                reg = < 2 >;
>> +                compatible = "jedec,spi-nor";
>> +                spi-max-frequency = <50000000>;
>> +                spi-rx-bus-width = <2>;
>> +        };
>> +    };
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index ea9d74b6236f..7d5f81dcd837 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -3021,6 +3021,15 @@ S:	Maintained
>>   F:	Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
>>   F:	drivers/mmc/host/sdhci-of-aspeed*
>>   
>> +ASPEED SMC SPI DRIVER
>> +M:	Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
>> +M:	Cédric Le Goater <clg@kaod.org>
>> +L:	linux-aspeed@lists.ozlabs.org (moderated for non-subscribers)
>> +L:	openbmc@lists.ozlabs.org (moderated for non-subscribers)
>> +L:	linux-spi@vger.kernel.org
>> +S:	Maintained
>> +F:	Documentation/devicetree/bindings/spi/aspeed,ast2600-fmc.yaml
>> +
>>   ASPEED VIDEO ENGINE DRIVER
>>   M:	Eddie James <eajames@linux.ibm.com>
>>   L:	linux-media@vger.kernel.org
>> -- 
>> 2.34.1
>>
> 

