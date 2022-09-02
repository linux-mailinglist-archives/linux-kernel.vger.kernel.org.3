Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D24075AA7D4
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 08:10:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235177AbiIBGKX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 02:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235431AbiIBGKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 02:10:20 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E04A62A26D;
        Thu,  1 Sep 2022 23:10:16 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2826A5oH060506;
        Fri, 2 Sep 2022 01:10:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1662099005;
        bh=XR/v9b81w6mGpmeExLWnDP23ZJpTbi18SAxNcyRl+6I=;
        h=Date:CC:Subject:To:References:From:In-Reply-To;
        b=bEknN9lpwqeAXAroFh2gwLRhEHmmzRschD9x+Z854aF6vIi9eIt0v1bHy9Oiah/UT
         Bay04ydBBiY2fz4AkBhl5/0CUgAjpf5AWAzN+0+ZvSu3yotQFDkPEy1/+Zvl8Gv/E2
         o/VTunFre9/86ABF6QFOvslbPZarUSuACMGbfoeU=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2826A4B1102711
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 2 Sep 2022 01:10:05 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Fri, 2 Sep
 2022 01:10:04 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Fri, 2 Sep 2022 01:10:04 -0500
Received: from [10.24.69.241] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2826A0CA047096;
        Fri, 2 Sep 2022 01:10:01 -0500
Message-ID: <44339382-c4e2-26db-de5d-263ae5a585b8@ti.com>
Date:   Fri, 2 Sep 2022 11:39:59 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
CC:     <robh+dt@kernel.org>, <lee.jones@linaro.org>, <kishon@ti.com>,
        <vkoul@kernel.org>, <dan.carpenter@oracle.com>,
        <grygorii.strashko@ti.com>, <rogerq@kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-phy@lists.infradead.org>, <s-vadapalli@ti.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: phy: ti: phy-gmii-sel: Add bindings
 for J7200
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <krzysztof.kozlowski+dt@linaro.org>
References: <20220901085506.138633-1-s-vadapalli@ti.com>
 <20220901085506.138633-2-s-vadapalli@ti.com>
 <4b681c03-7f5a-0234-2276-316e0bad1de5@linaro.org>
From:   Siddharth Vadapalli <s-vadapalli@ti.com>
In-Reply-To: <4b681c03-7f5a-0234-2276-316e0bad1de5@linaro.org>
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

Hello Krzysztof,

On 01/09/22 20:51, Krzysztof Kozlowski wrote:
> On 01/09/2022 11:55, Siddharth Vadapalli wrote:
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
>> index 1aeac43cad92..802374e7645f 100644
>> --- a/Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.yaml
>> +++ b/Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.yaml
>> @@ -54,6 +54,12 @@ patternProperties:
>>      description:
>>        Clock provider for TI EHRPWM nodes.
>>  
>> +  "phy@[0-9a-f]+$":
>> +    type: object
>> +    $ref: /schemas/phy/phy-provider.yaml
> 
> You need instead ref to specific device bindings/schema. Probably to
> /schemas/phy/ti,phy-gmii-sel.yaml#

Thank you for the clarification. I will update $ref to
"/schemas/phy/ti,phy-gmii-sel.yaml#" in the v5 series.

> 
> This was entirely different in v3, so your change is very confusing.

I had misunderstood Rob's comment in the v3 patch. I had initially
provided the relative path to the bindings file ti,phy-gmii-sel.yaml in
the v3 patch. When Rob commented "/schemas/phy/..", I misunderstood and
thought that I had to point $ref to a generic phy-provider schema
present in the dt-schema repo and thus, in this v4 patch, I had updated
$ref accordingly.

> 
>> +    description:
>> +      This is the register to set phy mode through phy-gmii-sel driver.
> 
> I don't understand the description. Please focus on the hardware not
> some drivers - what is here? Phy for something?

I will fix the description, updating it to the following:
"Address of the CTRLMMR_ENETx_CTRL registers which are used to configure
the phy-mode of the CPSW MAC ports."

Please let me know if the above description is fine.

> 
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
> 
> Blank line

I will fix this in the v5 series.

> 
> 
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
> It does not really make sense to limit items here, in the context of
> this patch. You got a comment for it already. Your patch should make
> sense on its own.

I had defined the property as an array because there are more than one
QSGMII main ports for other devices for which I will be posting the
patches. I had planned to reuse this property, with "maxItems: 2" in the
future patches for other compatibles. However, as suggested by you, I
will change the property to a uint32 instead of uint32-array in this
series. Later, in my future patches for other devices, I will change it
back to a uint32-array when I reuse the property.

> 
>> +    else:
>> +      properties:
>> +        ti,qsgmii-main-ports: false
> 
> Blank line

I will fix this in the v5 series.

> 
>>    - if:
>>        properties:
>>          compatible:
>> @@ -97,7 +125,7 @@ additionalProperties: false
>>  
>>  examples:
>>    - |
>> -    phy_gmii_sel: phy-gmii-sel@650 {
>> +    phy_gmii_sel: phy@650 {
> 
> Split cleanup into separate patch.

I will do so. Thank you for reviewing the patch.

Regards,
Siddharth.
