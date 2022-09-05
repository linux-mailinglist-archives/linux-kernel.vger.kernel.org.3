Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A04A5AD372
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 15:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236751AbiIENJU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 09:09:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbiIENJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 09:09:12 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8154C2F664
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 06:09:10 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id z6so13039421lfu.9
        for <linux-kernel@vger.kernel.org>; Mon, 05 Sep 2022 06:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=kccIl+JPL/b+6R9JLjjCNsOw0ulUkeXWsiCf5YUWos4=;
        b=ZnqLiqI6MLW3lnI05Mf4Eao18FSsDUGp6Da1I+QRkZJcEY0C0QG8K81z9X8m+s4Jyi
         cpGnP5oCG58t28aOFLJdpswJWiLr2fi+irONy0XZ5ND6pSJfVZw77UVCAxvMRU1Om/Cl
         bBWrb7MsAlHlyFRmd1ox3v5xV+d0V2AAzSxywWv7oyTfoWk4Cl/hcSWvZyF9rUbKsaij
         AS6WhBrc9/rOLPnWANRU3f3GcpN7UeM6EzBBoSe8yBMg4alUP83qrsYoqlQoFoVFTsxK
         vinOQUiZ7328zL4xC4r1oM7Cx3UBiruNl1KPZs8v5ftSlrmz7sNJIJjG6ljAkBHyXdlL
         LZtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=kccIl+JPL/b+6R9JLjjCNsOw0ulUkeXWsiCf5YUWos4=;
        b=CR/LXezv3xva6aaAbYWijPKRm1UxAoUIYMdbX3sV4SBWxfoSdyXX3fhrJkwVoG5pv5
         DNeBwSlMqlvHG0zmMhsb+hJgnp4TplNO/mzptYjMbeIylpxVKbz10mMP3U+tOxwA5LrC
         HQADhRIALf2xBKRYnFyhWV0ndMB2vL6BW+JgSTrzXxkg1d0aKS8kGdAYYqvmirmYdQwX
         gZenylbZ4S9q2z3mAwJeoXfhFOBTEpPBRPhzyZnbASSOurRxtkkDxDa/gabhQLXZbBgA
         StMC2LKDRzHPGz6grFmegzVSD7eeo3vKOVuATE1Q3IRolOBuPjQaY496u0Ia3ECOWOIm
         oOiA==
X-Gm-Message-State: ACgBeo1iJuogex02T00IdJX+f1pNb3XkbqyD2RZuIe9jshOX/nrpqgwA
        0uW9Azt3YicEJVpK8YLLZwXRbw==
X-Google-Smtp-Source: AA6agR550FBvF0os40VYLctvNfTKpL2koC3lcJaQTEgPs3sTLgLJC3pSTQya4BN7wV0VNO+pufSWFw==
X-Received: by 2002:a05:6512:b0a:b0:492:dacb:33da with SMTP id w10-20020a0565120b0a00b00492dacb33damr15355633lfu.668.1662383348735;
        Mon, 05 Sep 2022 06:09:08 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id x18-20020a056512079200b0048a7c86f4e7sm1181995lfr.291.2022.09.05.06.09.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Sep 2022 06:09:08 -0700 (PDT)
Message-ID: <4e61b63b-74ac-1682-968f-17e5d8db7ce6@linaro.org>
Date:   Mon, 5 Sep 2022 15:09:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v4 1/2] dt-bindings: phy: ti: phy-gmii-sel: Add bindings
 for J7200
Content-Language: en-US
To:     Siddharth Vadapalli <s-vadapalli@ti.com>,
        krzysztof.kozlowski+dt@linaro.org
Cc:     robh+dt@kernel.org, lee.jones@linaro.org, kishon@ti.com,
        vkoul@kernel.org, dan.carpenter@oracle.com,
        grygorii.strashko@ti.com, rogerq@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org
References: <20220901085506.138633-1-s-vadapalli@ti.com>
 <20220901085506.138633-2-s-vadapalli@ti.com>
 <4b681c03-7f5a-0234-2276-316e0bad1de5@linaro.org>
 <44339382-c4e2-26db-de5d-263ae5a585b8@ti.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <44339382-c4e2-26db-de5d-263ae5a585b8@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/09/2022 08:09, Siddharth Vadapalli wrote:
> Hello Krzysztof,
> 
> On 01/09/22 20:51, Krzysztof Kozlowski wrote:
>> On 01/09/2022 11:55, Siddharth Vadapalli wrote:
>>> TI's J7200 SoC supports additional PHY modes like QSGMII and SGMII
>>> that are not supported on earlier SoCs. Add a compatible for it.
>>>
>>> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
>>> ---
>>>  .../mfd/ti,j721e-system-controller.yaml       |  6 ++++
>>>  .../bindings/phy/ti,phy-gmii-sel.yaml         | 30 ++++++++++++++++++-
>>>  2 files changed, 35 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.yaml b/Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.yaml
>>> index 1aeac43cad92..802374e7645f 100644
>>> --- a/Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.yaml
>>> +++ b/Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.yaml
>>> @@ -54,6 +54,12 @@ patternProperties:
>>>      description:
>>>        Clock provider for TI EHRPWM nodes.
>>>  
>>> +  "phy@[0-9a-f]+$":
>>> +    type: object
>>> +    $ref: /schemas/phy/phy-provider.yaml
>>
>> You need instead ref to specific device bindings/schema. Probably to
>> /schemas/phy/ti,phy-gmii-sel.yaml#
> 
> Thank you for the clarification. I will update $ref to
> "/schemas/phy/ti,phy-gmii-sel.yaml#" in the v5 series.
> 
>>
>> This was entirely different in v3, so your change is very confusing.
> 
> I had misunderstood Rob's comment in the v3 patch. I had initially
> provided the relative path to the bindings file ti,phy-gmii-sel.yaml in
> the v3 patch. When Rob commented "/schemas/phy/..", I misunderstood and
> thought that I had to point $ref to a generic phy-provider schema
> present in the dt-schema repo and thus, in this v4 patch, I had updated
> $ref accordingly.
> 
>>
>>> +    description:
>>> +      This is the register to set phy mode through phy-gmii-sel driver.
>>
>> I don't understand the description. Please focus on the hardware not
>> some drivers - what is here? Phy for something?
> 
> I will fix the description, updating it to the following:
> "Address of the CTRLMMR_ENETx_CTRL registers which are used to configure
> the phy-mode of the CPSW MAC ports."
> 
> Please let me know if the above description is fine.

Hm, but that's a phy node, not address of register... Isn't this a phy
node representing the phy of the CPSW MAC ports?

> 
>>
>>> +
>>>  required:
>>>    - compatible
>>>    - reg
>>> diff --git a/Documentation/devicetree/bindings/phy/ti,phy-gmii-sel.yaml b/Documentation/devicetree/bindings/phy/ti,phy-gmii-sel.yaml
>>> index ff8a6d9eb153..0ffb97f1a77c 100644
>>> --- a/Documentation/devicetree/bindings/phy/ti,phy-gmii-sel.yaml
>>> +++ b/Documentation/devicetree/bindings/phy/ti,phy-gmii-sel.yaml
>>> @@ -53,12 +53,24 @@ properties:
>>>        - ti,am43xx-phy-gmii-sel
>>>        - ti,dm814-phy-gmii-sel
>>>        - ti,am654-phy-gmii-sel
>>> +      - ti,j7200-cpsw5g-phy-gmii-sel
>>>  
>>>    reg:
>>>      maxItems: 1
>>>  
>>>    '#phy-cells': true
>>>  
>>> +  ti,qsgmii-main-ports:
>>> +    $ref: /schemas/types.yaml#/definitions/uint32-array
>>> +    description: |
>>> +      Required only for QSGMII mode. Array to select the port for
>>> +      QSGMII main mode. Rest of the ports are selected as QSGMII_SUB
>>> +      ports automatically. Any one of the 4 CPSW5G ports can act as the
>>> +      main port with the rest of them being the QSGMII_SUB ports.
>>> +    items:
>>> +      minimum: 1
>>> +      maximum: 4
>>> +
>>>  allOf:
>>>    - if:
>>>        properties:
>>> @@ -73,6 +85,22 @@ allOf:
>>>          '#phy-cells':
>>>            const: 1
>>>            description: CPSW port number (starting from 1)
>>
>> Blank line
> 
> I will fix this in the v5 series.
> 
>>
>>
>>> +  - if:
>>> +      properties:
>>> +        compatible:
>>> +          contains:
>>> +            enum:
>>> +              - ti,j7200-cpsw5g-phy-gmii-sel
>>> +    then:
>>> +      properties:
>>> +        '#phy-cells':
>>> +          const: 1
>>> +          description: CPSW port number (starting from 1)
>>> +        ti,qsgmii-main-ports:
>>> +          maxItems: 1
>>
>> It does not really make sense to limit items here, in the context of
>> this patch. You got a comment for it already. Your patch should make
>> sense on its own.
> 
> I had defined the property as an array because there are more than one
> QSGMII main ports for other devices for which I will be posting the
> patches. I had planned to reuse this property, with "maxItems: 2" in the
> future patches for other compatibles. However, as suggested by you, I
> will change the property to a uint32 instead of uint32-array in this
> series. Later, in my future patches for other devices, I will change it
> back to a uint32-array when I reuse the property.

Wait, no. You should not change the property. This should be
uint32-array, because you will extend it soon, just maxItems must be
defined in top-level place.

Best regards,
Krzysztof
