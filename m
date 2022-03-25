Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 478C94E72AE
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 13:03:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358313AbiCYME6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 08:04:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358249AbiCYMEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 08:04:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCF452558C;
        Fri, 25 Mar 2022 05:03:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6C048B82828;
        Fri, 25 Mar 2022 12:03:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B302CC340E9;
        Fri, 25 Mar 2022 12:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648209796;
        bh=78i4ZvBr8mrRT5MUgR6xw5y5tehZmMaII08aMDCZ7AE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ERALGrRKHbXizKJCwQCwZw7DZyp1WG7jt1b9yK2/NE1whQ3GOpMlzCPbeEuAdX/Cn
         R+tVOElt43CDEqUQxJ45LR3RmXBwGl1CXmsuSHyeu+T0FDOww7DwZLs1Y6PutL2VfO
         99JEDyFhRTQxIDjBlzgdB1eDcexod2uMETtrx1p5M7SLo/oe7FdXp2iBn0wb7GzAeX
         26ul/MVQ3o2Pnsq2q35n24Hhe2F9QJw0b0Qan/LomJdYI4MLlXXK002VdAuGNAExxz
         /yvT8HtHSx2S8sJ54WSSWL4Kutb7nRRadJ+yNr+yBxpRnvRv24NGYzCL4+X/qjAnrv
         7Lj0RrnYltn6Q==
Message-ID: <55ecfc8a-a3e5-e0b5-6e6d-bf9ad93d141f@kernel.org>
Date:   Fri, 25 Mar 2022 14:03:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/3] dt-bindings: mtd: ti,elm: Convert to yaml
Content-Language: en-US
To:     Krzysztof Kozlowski <krzk@kernel.org>, miquel.raynal@bootlin.com,
        robh+dt@kernel.org
Cc:     richard@nod.at, vigneshr@ti.com, kishon@ti.com, nm@ti.com,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220323111851.4699-1-rogerq@kernel.org>
 <20220323111851.4699-2-rogerq@kernel.org>
 <622e5de3-12b3-0f5f-1c1b-6e062c39a626@kernel.org>
From:   Roger Quadros <rogerq@kernel.org>
In-Reply-To: <622e5de3-12b3-0f5f-1c1b-6e062c39a626@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On 24/03/2022 20:24, Krzysztof Kozlowski wrote:
> On 23/03/2022 12:18, Roger Quadros wrote:
>> Convert elm.txt to ti,elm.yaml.
>>
>> Signed-off-by: Roger Quadros <rogerq@kernel.org>
>> ---
>>  Documentation/devicetree/bindings/mtd/elm.txt | 16 -------
>>  .../devicetree/bindings/mtd/ti,elm.yaml       | 48 +++++++++++++++++++
>>  2 files changed, 48 insertions(+), 16 deletions(-)
>>  delete mode 100644 Documentation/devicetree/bindings/mtd/elm.txt
>>  create mode 100644 Documentation/devicetree/bindings/mtd/ti,elm.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/mtd/elm.txt b/Documentation/devicetree/bindings/mtd/elm.txt
>> deleted file mode 100644
>> index 59ddc61c1076..000000000000
>> --- a/Documentation/devicetree/bindings/mtd/elm.txt
>> +++ /dev/null
>> @@ -1,16 +0,0 @@
>> -Error location module
>> -
>> -Required properties:
>> -- compatible: Must be "ti,am3352-elm"
>> -- reg: physical base address and size of the registers map.
>> -- interrupts: Interrupt number for the elm.
>> -
>> -Optional properties:
>> -- ti,hwmods: Name of the hwmod associated to the elm
>> -
>> -Example:
>> -elm: elm@0 {
>> -	compatible = "ti,am3352-elm";
>> -	reg = <0x48080000 0x2000>;
>> -	interrupts = <4>;
>> -};
>> diff --git a/Documentation/devicetree/bindings/mtd/ti,elm.yaml b/Documentation/devicetree/bindings/mtd/ti,elm.yaml
>> new file mode 100644
>> index 000000000000..24ed0fb84204
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/mtd/ti,elm.yaml
>> @@ -0,0 +1,48 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/mtd/ti,elm.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Texas Instruments Error Location Module (ELM).
>> +
>> +maintainers:
>> +  - Roger Quadros <rogerq@kernel.org>
>> +
>> +description:
>> +  ELM module is used together with GPMC and NAND Flash to detect
>> +  errors and the location of the error based on BCH algorithms
>> +  so they can be corrected if possible.
>> +
>> +properties:
>> +  compatible:
>> +    items:
> 
> No items, just const.

OK.

> 
>> +      - const: ti,am3352-elm
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  interrupts:
>> +    maxItems: 1
>> +
>> +  ti,hwmods:
>> +    description:
>> +      Name of the HWMOD associated with ELM. This is for legacy
>> +      platforms only.
>> +    $ref: /schemas/types.yaml#/definitions/string
>> +    deprecated: true
> 
> It was not deprecated before. Could you explain it in commit msg because
> it is not a conversion only.

OK I will mention that hwmod usage is not recommended for new platforms.

> 
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - interrupts
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    elm: elm@0 {
> 
> This is error correction, right? So generic node name "ecc"?
> 
>> +        compatible = "ti,am3352-elm";
>> +        reg = <0x0 0x2000>;
>> +        interrupts = <4>;
>> +    };
> 
> 
> Best regards,
> Krzysztof

cheers,
-roger
