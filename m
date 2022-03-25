Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6E444E7374
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 13:28:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357919AbiCYM3i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 08:29:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241992AbiCYM3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 08:29:36 -0400
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9DBFF61;
        Fri, 25 Mar 2022 05:28:02 -0700 (PDT)
Received: by mail-ej1-f42.google.com with SMTP id o10so15079864ejd.1;
        Fri, 25 Mar 2022 05:28:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=PcH2id7e3RzV4DA+fDI2YdpFNqalBTclxR9S6QfqEqw=;
        b=Qpbg0ILZdrrVH3DPopX3Er5kV6byirV9b02DNhBcvyx94rcRTEwnKYu2T66XTlIQz3
         6QEpfe63aLhR7UthOzv0XQBPEu38GeOeX34sx739XBXo0PtK+wbYAxLPI4V2LOIngaqe
         WVUVfGMOZPkAlhG2TJWae0n3hUu7nr+OZ9+xp4G18hYtgl3sDU1GglRIsA/i8ixwRQO+
         2Mp3PDldn6LE/NpPNQ3T/0V/ViilaTQDgIWvMpZQ8Ajcu7NZzK4aRvwtByglbHl9zLG0
         WCYjxPtSXMn/OAjA5n3QVqtfVMI0HqKRRl1mjkAYzh1o1R3pSi07B2i0Oht/PuNHv1zH
         sIZA==
X-Gm-Message-State: AOAM531/01nA6HukxHR2u2ffAQSMt855L2wtjACiYnmOWF4Hi5+UrFXl
        xtTZvQ8dgX2uQU4yAAE4vK6fmMBXga6D/Q==
X-Google-Smtp-Source: ABdhPJwksDpAoMEkvuK3Mq+z+58lVXdP0JP6yQ5NAosjOqB4r6xZT/YCxttfSJIWseOiCQHQO0WKsA==
X-Received: by 2002:a17:906:3042:b0:6cd:20ed:7c5c with SMTP id d2-20020a170906304200b006cd20ed7c5cmr11122565ejd.241.1648211281236;
        Fri, 25 Mar 2022 05:28:01 -0700 (PDT)
Received: from [192.168.0.160] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.googlemail.com with ESMTPSA id g9-20020aa7c849000000b00412fc6bf26dsm2845067edt.80.2022.03.25.05.28.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Mar 2022 05:28:00 -0700 (PDT)
Message-ID: <b328549b-fc0a-a5b6-586e-bf5e8d8513b6@kernel.org>
Date:   Fri, 25 Mar 2022 13:27:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 2/3] dt-bindings: mtd: ti,elm: Add support for AM64 ELM
Content-Language: en-US
To:     Roger Quadros <rogerq@kernel.org>, miquel.raynal@bootlin.com,
        robh+dt@kernel.org
Cc:     richard@nod.at, vigneshr@ti.com, kishon@ti.com, nm@ti.com,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220323111851.4699-1-rogerq@kernel.org>
 <20220323111851.4699-3-rogerq@kernel.org>
 <a222efb1-4f95-d65d-919b-ed55c5448c9a@kernel.org>
 <abcbe390-45a8-6183-56a8-f9f751e84f49@kernel.org>
 <597e4bfb-383d-0f3b-dce8-ffc12f543b46@kernel.org>
 <85022bd4-52fb-d15c-cc47-8d891ae3a968@kernel.org>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <85022bd4-52fb-d15c-cc47-8d891ae3a968@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/03/2022 13:13, Roger Quadros wrote:
> 
> 
> On 25/03/2022 14:08, Krzysztof Kozlowski wrote:
>> On 25/03/2022 13:05, Roger Quadros wrote:
>>>
>>>
>>> On 24/03/2022 20:26, Krzysztof Kozlowski wrote:
>>>> On 23/03/2022 12:18, Roger Quadros wrote:
>>>>> TI's AM64 SoC has the Error Locator Module. Add compatible and
>>>>> related properties to support ELM on AM64 SoC.
>>>>>
>>>>> Signed-off-by: Roger Quadros <rogerq@kernel.org>
>>>>> ---
>>>>>  .../devicetree/bindings/mtd/ti,elm.yaml       | 27 ++++++++++++++++++-
>>>>>  1 file changed, 26 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/mtd/ti,elm.yaml b/Documentation/devicetree/bindings/mtd/ti,elm.yaml
>>>>> index 24ed0fb84204..bc01d35ce605 100644
>>>>> --- a/Documentation/devicetree/bindings/mtd/ti,elm.yaml
>>>>> +++ b/Documentation/devicetree/bindings/mtd/ti,elm.yaml
>>>>> @@ -17,7 +17,9 @@ description:
>>>>>  properties:
>>>>>    compatible:
>>>>>      items:
>>>>> -      - const: ti,am3352-elm
>>>>> +      - enum:
>>>>> +          - ti,am3352-elm
>>>>> +          - ti,am64-elm
>>>>>  
>>>>>    reg:
>>>>>      maxItems: 1
>>>>> @@ -25,6 +27,17 @@ properties:
>>>>>    interrupts:
>>>>>      maxItems: 1
>>>>>  
>>>>> +  clocks:
>>>>> +    maxItems: 1
>>>>> +    description: Functional clock.
>>>>> +
>>>>> +  clock-names:
>>>>> +    items:
>>>>> +      - const: fck
>>>>> +
>>>>> +  power-domains:
>>>>> +    maxItems: 1
>>>>> +
>>>>>    ti,hwmods:
>>>>>      description:
>>>>>        Name of the HWMOD associated with ELM. This is for legacy
>>>>> @@ -37,6 +50,18 @@ required:
>>>>>    - reg
>>>>>    - interrupts
>>>>>  
>>>>> +allOf:
>>>>> +  - if:
>>>>> +      properties:
>>>>> +        compatible:
>>>>> +          contains:
>>>>> +            const: ti,am64-elm
>>>>> +    then:
>>>>> +      required:
>>>>> +        - clocks
>>>>> +        - clock-names
>>>>> +        - power-domains
>>>>
>>>> Are these new properties also valid for am3352?
>>>
>>> No they are not required for am3352-elm. Only required for K3 based platforms like AM64.
>>>
>>
>> I understand they are not required, but I asked if they are valid. IOW,
>> whether ELM in am3352 also is part of power domain and has clock input?
> 
> Yes it does have power and clock domains but they are handled a bit differently
> on AM335x platform. i.e. in the parent node

Then I guess it can stay like this. Otherwise (if there is no clock
input) "else:" with "clocks:false" would be expected.


Best regards,
Krzysztof
