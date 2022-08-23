Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C63D59E1FA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 14:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358134AbiHWLnp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 07:43:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357895AbiHWLjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 07:39:32 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EC7E70E55;
        Tue, 23 Aug 2022 02:28:34 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 27N9RwWQ080103;
        Tue, 23 Aug 2022 04:27:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1661246878;
        bh=xd4qm/j7upLytEKeiy06TJdA6DbvK6VC227evNzbywg=;
        h=Date:CC:Subject:To:References:From:In-Reply-To;
        b=MmhNIicLemZVBqA7iUZ+/2S9/VTqObVudRkclB6P03U/ynv1XIahQKCKFvLQL5mlE
         l7SrT3cog495av+XnkJFY5VoOaCPtzsEC9AMOTPKdLFeIZhIi47KkYu9K5bsxyFbaP
         ehswb6ecd5j3bxcZMf2/9FPNewy6Z1pJleyqVxq8=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 27N9RwZc068060
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 23 Aug 2022 04:27:58 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Tue, 23
 Aug 2022 04:27:58 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Tue, 23 Aug 2022 04:27:58 -0500
Received: from [10.24.69.241] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 27N9RsMR112681;
        Tue, 23 Aug 2022 04:27:55 -0500
Message-ID: <7cd7e745-11d1-476b-a7f6-3131a4ad2bd3@ti.com>
Date:   Tue, 23 Aug 2022 14:57:53 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
CC:     <lee.jones@linaro.org>, <krzysztof.kozlowski@linaro.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <kishon@ti.com>,
        <vkoul@kernel.org>, <dan.carpenter@oracle.com>,
        <grygorii.strashko@ti.com>, <rogerq@kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-phy@lists.infradead.org>, <s-vadapalli@ti.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: phy: ti: phy-gmii-sel: Add bindings
 for J7200
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
References: <20220822065631.27933-1-s-vadapalli@ti.com>
 <20220822065631.27933-2-s-vadapalli@ti.com>
 <20220822214126.GA896562-robh@kernel.org>
From:   Siddharth Vadapalli <s-vadapalli@ti.com>
In-Reply-To: <20220822214126.GA896562-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Rob,

On 23/08/22 03:11, Rob Herring wrote:
> On Mon, Aug 22, 2022 at 12:26:30PM +0530, Siddharth Vadapalli wrote:
>> TI's J7200 SoC supports additional PHY modes like QSGMII and SGMII
>> that are not supported on earlier SoCs. Add a compatible for it.
>>
>> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
>> ---
>>  .../mfd/ti,j721e-system-controller.yaml       |  6 ++++
>>  .../bindings/phy/ti,phy-gmii-sel.yaml         | 30 ++++++++++++++++++-
>>  2 files changed, 35 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.yaml b/Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.yaml
>> index 73cffc45e056..466724cb4157 100644
>> --- a/Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.yaml
>> +++ b/Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.yaml
>> @@ -54,6 +54,12 @@ patternProperties:
>>      description:
>>        Clock provider for TI EHRPWM nodes.
>>  
>> +  "phy@[0-9a-f]+$":
>> +    type: object
>> +    $ref: ../phy/ti,phy-gmii-sel.yaml
> 
> /schemas/phy/...

Thank you for reviewing the patch. I will update $ref to
/schemas/phy/phy-provider.yaml.

> 
>> +    description:
>> +      This is the register to set phy mode through phy-gmii-sel driver.
>> +
>>  required:
>>    - compatible
>>    - reg
>> diff --git a/Documentation/devicetree/bindings/phy/ti,phy-gmii-sel.yaml b/Documentation/devicetree/bindings/phy/ti,phy-gmii-sel.yaml
>> index ff8a6d9eb153..0ffb97f1a77c 100644
>> --- a/Documentation/devicetree/bindings/phy/ti,phy-gmii-sel.yaml
>> +++ b/Documentation/devicetree/bindings/phy/ti,phy-gmii-sel.yaml
>> @@ -53,12 +53,24 @@ properties:
>>        - ti,am43xx-phy-gmii-sel
>>        - ti,dm814-phy-gmii-sel
>>        - ti,am654-phy-gmii-sel
>> +      - ti,j7200-cpsw5g-phy-gmii-sel
>>  
>>    reg:
>>      maxItems: 1
>>  
>>    '#phy-cells': true
>>  
>> +  ti,qsgmii-main-ports:
>> +    $ref: /schemas/types.yaml#/definitions/uint32-array
>> +    description: |
>> +      Required only for QSGMII mode. Array to select the port for
>> +      QSGMII main mode. Rest of the ports are selected as QSGMII_SUB
>> +      ports automatically. Any one of the 4 CPSW5G ports can act as the
>> +      main port with the rest of them being the QSGMII_SUB ports.
>> +    items:
>> +      minimum: 1
>> +      maximum: 4
>> +
>>  allOf:
>>    - if:
>>        properties:
>> @@ -73,6 +85,22 @@ allOf:
>>          '#phy-cells':
>>            const: 1
>>            description: CPSW port number (starting from 1)
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            enum:
>> +              - ti,j7200-cpsw5g-phy-gmii-sel
>> +    then:
>> +      properties:
>> +        '#phy-cells':
>> +          const: 1
>> +          description: CPSW port number (starting from 1)
>> +        ti,qsgmii-main-ports:
>> +          maxItems: 1
> 
> If the array size can only ever be 1, then it's a uint32, not a 
> uint32-array.

For the current device, there can be only one QSGMII main port and
uint32 will be sufficient. However, I plan to send patches for TI's
J721e device which supports up to 2 QSGMII main ports. I wish to
implement the property such that it can be reused by J721e. For this
reason, I am defining the property as a uint32-array. With this
implementation, J7200 will use the property as an array with one
element, while J721e will use the property as an array with two
elements. This is being done to avoid adding a new property in the
future just for J721e. Please let me know if this is fine.

Regards,
Siddharth.
