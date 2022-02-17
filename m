Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 267744B9B59
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 09:43:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237962AbiBQIn2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 03:43:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbiBQInX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 03:43:23 -0500
X-Greylist: delayed 87897 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 17 Feb 2022 00:43:08 PST
Received: from 5.mo552.mail-out.ovh.net (5.mo552.mail-out.ovh.net [188.165.45.220])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B40A12225FF
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 00:43:08 -0800 (PST)
Received: from mxplan5.mail.ovh.net (unknown [10.109.146.173])
        by mo552.mail-out.ovh.net (Postfix) with ESMTPS id ECDFB24EAF;
        Thu, 17 Feb 2022 08:37:04 +0000 (UTC)
Received: from kaod.org (37.59.142.97) by DAG4EX1.mxp5.local (172.16.2.31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 17 Feb
 2022 09:37:03 +0100
Authentication-Results: garm.ovh; auth=pass (GARM-97G002328e9798-957d-4e35-ae92-239b6e2566ca,
                    6074F5EAC11FD030A47E229993F36105E76D55A4) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <a77fe4bb-c4d6-4329-b25e-26e990e8092b@kaod.org>
Date:   Thu, 17 Feb 2022 09:37:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 02/10] dt-bindings: spi: Add Aspeed SMC controllers device
 tree binding
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
CC:     <linux-spi@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        Mark Brown <broonie@kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-aspeed@lists.ozlabs.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20220214094231.3753686-1-clg@kaod.org>
 <20220214094231.3753686-3-clg@kaod.org> <YgwV5ZGCbrNhlk0s@robh.at.kernel.org>
From:   =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <YgwV5ZGCbrNhlk0s@robh.at.kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.97]
X-ClientProxiedBy: DAG2EX1.mxp5.local (172.16.2.11) To DAG4EX1.mxp5.local
 (172.16.2.31)
X-Ovh-Tracer-GUID: 03c1adce-a0aa-4472-8090-987f0bcc8d30
X-Ovh-Tracer-Id: 662029147249740676
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvvddrjeejgdduvddtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvfhfhjggtgfhisehtkeertddtfeejnecuhfhrohhmpeevrogurhhitggpnfgvpgfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepudeutdegudegheefvdefhfeiteeifefhieduueethfffkeeiudeuueehgedugeefnecuffhomhgrihhnpeguvghvihgtvghtrhgvvgdrohhrghenucfkpheptddrtddrtddrtddpfeejrdehledrudegvddrleejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpohhuthdphhgvlhhopehmgihplhgrnhehrdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/15/22 22:06, Rob Herring wrote:
> On Mon, Feb 14, 2022 at 10:42:23AM +0100, Cédric Le Goater wrote:
>> The "interrupt" property is optional because it is only necessary for
>> controllers supporting DMAs (Not implemented yet in the new driver).
>>
>> Cc: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
>> Signed-off-by: Cédric Le Goater <clg@kaod.org>
>> ---
>>   .../bindings/spi/aspeed,ast2600-fmc.yaml      | 92 +++++++++++++++++++
>>   1 file changed, 92 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/spi/aspeed,ast2600-fmc.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/spi/aspeed,ast2600-fmc.yaml b/Documentation/devicetree/bindings/spi/aspeed,ast2600-fmc.yaml
>> new file mode 100644
>> index 000000000000..ed71c4d86930
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/spi/aspeed,ast2600-fmc.yaml
>> @@ -0,0 +1,92 @@
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
>> +
>> +    required:
>> +      - reg
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
>> +        reg = < 0x1e620000 0xc4
>> +                0x20000000 0x10000000 >;
>> +        #address-cells = <1>;
>> +        #size-cells = <0>;
>> +        compatible = "aspeed,ast2600-fmc";
>> +        clocks = <&syscon ASPEED_CLK_AHB>;
>> +        status = "disabled";
> 
> Why is your example disabled? Drop 'status'.

my bad. I took the basic definition of the SoC and the devices
are activated in the boards. I will fix in v2.

Thanks,

C.


> 
>> +        interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
>> +        flash@0 {
>> +                reg = < 0 >;
>> +                compatible = "jedec,spi-nor";
>> +                spi-max-frequency = <50000000>;
>> +                status = "disabled";
> 
> Ditto.
> 
>> +        };
>> +        flash@1 {
>> +                reg = < 1 >;
>> +                compatible = "jedec,spi-nor";
>> +                spi-max-frequency = <50000000>;
>> +                status = "disabled";
>> +        };
>> +        flash@2 {
>> +                reg = < 2 >;
>> +                compatible = "jedec,spi-nor";
>> +                spi-max-frequency = <50000000>;
>> +                status = "disabled";
>> +        };
>> +    };
>> -- 
>> 2.34.1
>>
>>

