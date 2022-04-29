Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1372F515578
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 22:22:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355220AbiD2UZg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 16:25:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239571AbiD2UZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 16:25:33 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A02FB53B76
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 13:22:13 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id m20so17422653ejj.10
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 13:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=B5xgiQuwPDVq6wa2pBHGsA/S0+n6F6tg1rxMU8HQg9Q=;
        b=mcE120iimXDKlF7XgivbJgAkUJRut3u22lfY1qcg5dF4wBAejZVviizpd9QnMZA03a
         a4O+PDTm1C+oyCjfvUFiyFfPwd4Pwq5pwv9FsgUl7ohsZZ7xQtITz6LjK6usT0ELjzK4
         MDQYsDK2+NMe6Ff0Ukby5fyhFZf8q6I6j7yriQ/pJbk9cQDvP9JPzqKurw3JQhYSVAA5
         nMUuAeVDdEnbI5eAcwEUlL/87tKb+pkmK9arU7u5s8B7GrZbHyxOPtW86MGKNTW1cPEf
         fuhDF1sgFbZSX08hvTx1X+ay6UpebhSVeqAHx2dL5y7id82s4HzHkRgxjMlCTNm1YHBe
         SdgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=B5xgiQuwPDVq6wa2pBHGsA/S0+n6F6tg1rxMU8HQg9Q=;
        b=5M9zXNWuIc2tvh/LEFcJsc/N0kaVqeXcrA7Tko3aEvM01JIY8oc0Uk3HcRE/1GP6tE
         yaQ25UKIxIq5fIH0bTyZBwbEz3DHT3XAo8YjlJgH0eIFPuL9iJqnTiMBplLrW9xJ+xqT
         HW4fV54nPz5n/7/UjVp4FdoXvuUuKybgQomUJmxH+CaQpZlxoOJvrke1k6uKSEDC+6G+
         Yl57neDPLykAo/OU/aTDfiYp3QhJIY9Bstckh6vkpQl5CGtU5u/pDFh4jj5PGsm4TzX6
         Xf8d4S5sMnI6oAwxPNlfPaNH9anOCjhUQK/Tqv89wTnnH07pZfL3aBpASOYZ/I2fS/g5
         Q6SQ==
X-Gm-Message-State: AOAM533FNM6GBbkWkZl+v/eMu6sCtUUzUfP5dot/+ng0hXKQyY84dkgB
        SDtv3BHGbnS8DHT7BCzoOocxxA==
X-Google-Smtp-Source: ABdhPJxisJ27HjNyI+R3epyENsZDasAoU3UJfcIaj/8Mg+ufNZGEzHjn6GaAqAobdV7jJautl+/OkA==
X-Received: by 2002:a17:907:c01a:b0:6f3:b313:2fd1 with SMTP id ss26-20020a170907c01a00b006f3b3132fd1mr971345ejc.680.1651263732039;
        Fri, 29 Apr 2022 13:22:12 -0700 (PDT)
Received: from [192.168.0.176] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id w23-20020a170907271700b006f3ef214d9fsm959747ejk.5.2022.04.29.13.22.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Apr 2022 13:22:11 -0700 (PDT)
Message-ID: <a84df850-149e-9656-43fa-1f040368a9f1@linaro.org>
Date:   Fri, 29 Apr 2022 22:22:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 1/2] dt-bindings: mtd: partitions: Add binding for
 Sercomm parser
Content-Language: en-US
To:     Mikhail Zhilkin <csharper2005@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc:     NOGUCHI Hiroshi <drvlabo@gmail.com>, Karim <Karimdplay@gmail.com>,
        M <x1@disroot.org>, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20220406195557.1956-1-csharper2005@gmail.com>
 <20220406195946.2019-1-csharper2005@gmail.com>
 <8d0d8b27-35ff-3693-cf80-897b80c26b4e@linaro.org>
 <57bebf2f-af4c-b2d9-10e5-19e5104946fb@gmail.com>
 <29cfa017-bbaf-3aba-fe1d-06771957dbaa@linaro.org>
 <1b391399-984b-7a63-3265-62ef09caec39@gmail.com>
 <bd533827-b575-caad-c230-af060851b231@gmail.com>
 <db70e53b-7484-43bf-e9c8-b6a2dce1fbb5@linaro.org>
 <25da3f43-c46e-8108-2da9-0e4f2b7cc1a4@gmail.com>
 <b279040a-a782-a2ca-2acb-2d8f07709081@linaro.org>
 <1c19faf9-fc1c-9adf-d038-97b673a8f0be@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1c19faf9-fc1c-9adf-d038-97b673a8f0be@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/04/2022 17:26, Mikhail Zhilkin wrote:
> On 4/29/2022 9:46 AM, Krzysztof Kozlowski wrote:
> 
>>>> I am sorry, but you changed now a lot in the bindings and it looks
>>>> entirely different. Things previously being correct now are wrong, so
>>>> rather start from your old bindings...
>>>
>>> Looks like I'm a bit confused... I use dual "compatible" in my real dts
>>> and I realized that:
>>>
>>> 1. Therefore I have to use  dual "compatible" in example too:
>>>
>>> compatible = "sercomm,sc-partitions", "fixed-partitions";
>>>
>>> 2. When I'm trying to reuse "fixed-partitions" compatible from
>>> fixed-partitions.yaml in my new .yaml I get "too long" errors.
>> Yes, the fixed-partitions.yaml would have to be changed to allow extension.
> 
> Well.
> 
>>> Real dts:
>>>
>>> Link:
>>> https://github.com/openwrt/openwrt/blob/edcc1a9a734bb3fcdc9242025290d3f173e71b78/target/linux/ramips/dts/mt7621_beeline_smartbox-giga.dts#L79
>>>
>>> So, I currently found another solution - to extend fixed-partitions.yaml
>>> with "sercomm,sc-partitions". Is It ok from your side? Can I use this
>>> code in v3?
>> Not really, I don't understand why do you need it 
> 
> The main idea is keeping original Sercomm firmware behavior:
> 
> 1. If dynamic partition map found then use offsets and mtd sizes stored
> in partition map. It's provided by "sercomm,sc-partitions" compatible.
> 
> 2. If dynamic partition map doesn't exist or broken then default values
> (from dts) are used. It's provided by "fixed-partitions" compatible.

Then you need to adjust fixed-partitions for such case. See syscon case
(all over the tree and Documentation/devicetree/bindings/mfd/syscon.yaml).

> 
>> and it does not
>> include our previous talks.
> 
> At the time, I didn't realize how important is it. Understanding began
> to come after dozens of experiments and checking the similar Linux patches.
> 
>>> diff --git
>>> a/Documentation/devicetree/bindings/mtd/partitions/fixed-partitions.yaml
>>> b/Documentation/devicetree/bindings/mtd/partitions/fixed-partitions.yaml
>>> index ea4cace6a955..9eebe39a57fb 100644
>>> --- a/Documentation/devicetree/bindings/mtd/partitions/fixed-partitions.yaml
>>> +++ b/Documentation/devicetree/bindings/mtd/partitions/fixed-partitions.yaml
>>> @@ -19,7 +19,11 @@ maintainers:
>>>  
>>>  properties:
>>>    compatible:
>>> -    const: fixed-partitions
>>> +    oneOf:
>>> +      - const: fixed-partitions
>>> +      - items:
>>> +          - const: sercomm,sc-partitions
>>> +          - const: fixed-partitions
>>>  
>>>    "#address-cells": true
>>>  
>>> @@ -27,7 +31,18 @@ properties:
>>>  
>>>  patternProperties:
>>>    "@[0-9a-f]+$":
>>> -    $ref: "partition.yaml#"
>>> +    allOf:
>>> +      - $ref: "partition.yaml#"
>>> +      - if:
>>> +          properties:
>>> +            compatible:
>>> +              contains:
>>> +                const: sercomm,sc-partitions
>>> +        then:
>>> +          properties:
>>> +            scpart-id:
>> It still misses vendor prefix and we agreed you don't need it, didn't we?
> 
> Do you mean "sercomm" vendor prefix? If so then we agreed that I include
> it in a separate patch:

There was some misunderstanding then. We talk here about scpart-id name.
Adding vendor prefix cannot be a separate patch because it does not make
much sense. You add new property with wrong name and immediately
change/fix it in next patch.

No, it should have proper name since beginning. The property is not used
in the kernel.

> 
> Link:
> https://lore.kernel.org/linux-mtd/1b391399-984b-7a63-3265-62ef09caec39@gmail.com/
> 
> I'm going to send it in v3:
> 
> ---
> dt-bindings: Add Sercomm (Suzhou) Corporation vendor prefix
> 
> Update Documentation/devicetree/bindings/vendor-prefixes.yaml to include
> "sercomm" as a vendor prefix for "Sercomm (Suzhou) Corporation".
> Company website:
> Link: https://www.sercomm.com/
> 
> Signed-off-by: Mikhail Zhilkin <csharper2005@gmail.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> index 01430973ecec..65ff22364fb3 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> @@ -1082,6 +1082,8 @@ patternProperties:
>      description: Sensirion AG
>    "^sensortek,.*":
>      description: Sensortek Technology Corporation
> +  "^sercomm,.*":
> +    description: Sercomm (Suzhou) Corporation

This can be separate patch, but it's separate issue...


Best regards,
Krzysztof
