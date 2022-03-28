Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C7CF4E9830
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 15:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243245AbiC1Nat (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 09:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243240AbiC1Nap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 09:30:45 -0400
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D62FB5E167;
        Mon, 28 Mar 2022 06:29:02 -0700 (PDT)
Received: by mail-wm1-f41.google.com with SMTP id r64so8393568wmr.4;
        Mon, 28 Mar 2022 06:29:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=uLvcnNGD7orwMt3H7FvAzNbV1+jVVtO3wV/gzqZo0EQ=;
        b=dyHP+PwLbxiYYVnxiHYNbDIWC8X79p6vkPrgpbflAwQVgIC7U881QRdLBrPekkO3EA
         ZXqpZbE21r2rGaPJ/zebhvw33HIGV3jlrEbYsa5kiqxNCw6RIEdTkhZvfQnKuXbtbN+M
         PX1Ti6VrlyzlTjkE9ogkDvEPCKqYMYibCGy9ZHl5iX2azy/ANM66lKsX7SskS5PKunlj
         hECzY88l71xgbu5mos2IKUb6nYZUbzTNK4BO6Vt3rg8yhj7M0mOP8M5JkVLoqbHG4kNZ
         S3D0TlXj9hB68YTNiBy2PcuLD8bCj6NZ5pEzvYe8QZ1vltf1U982g7wmypYbC2g7jTSd
         q9ig==
X-Gm-Message-State: AOAM5330+op9inXcO9vC9VJbeEpzrO9AxUOQCnp0WdL1WpimQCqDc8Z2
        aiC/80VhwArod9aDniS80gc=
X-Google-Smtp-Source: ABdhPJzvXxx8G3oSboQduPDY5peChv4cOygHj3HSI2yRRkfQTz9OKVkIUO7HO/NYVQC/sQZwMl+zbQ==
X-Received: by 2002:a05:600c:2e02:b0:38c:8390:d8ca with SMTP id o2-20020a05600c2e0200b0038c8390d8camr26669786wmf.15.1648474141242;
        Mon, 28 Mar 2022 06:29:01 -0700 (PDT)
Received: from [192.168.0.162] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.googlemail.com with ESMTPSA id l9-20020a5d6d89000000b00203d62072c4sm13608526wrs.43.2022.03.28.06.28.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Mar 2022 06:29:00 -0700 (PDT)
Message-ID: <a06f24af-ea9a-c787-ed09-438c019c63ca@kernel.org>
Date:   Mon, 28 Mar 2022 15:28:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [RFC PATCH v2 3/6] ASoC: dt-bindings: Extend clock bindings of
 rt5659
Content-Language: en-US
To:     Sameer Pujar <spujar@nvidia.com>, broonie@kernel.org,
        lgirdwood@gmail.com, robh+dt@kernel.org, krzk+dt@kernel.org,
        perex@perex.cz, tiwai@suse.com, peter.ujfalusi@linux.intel.com,
        pierre-louis.bossart@linux.intel.com
Cc:     oder_chiou@realtek.com, thierry.reding@gmail.com,
        jonathanh@nvidia.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org
References: <1648448050-15237-1-git-send-email-spujar@nvidia.com>
 <1648448050-15237-4-git-send-email-spujar@nvidia.com>
 <da414b44-1bec-5918-84f5-9dfff2009f41@kernel.org>
 <53d77f33-27e8-3446-d758-3e545eea2db4@nvidia.com>
 <5e4e11b5-02b8-e03e-2924-c9f2882921be@kernel.org>
 <fbd9cbfe-d653-d6d2-e55c-fb80527bea13@nvidia.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <fbd9cbfe-d653-d6d2-e55c-fb80527bea13@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/03/2022 15:19, Sameer Pujar wrote:
> 
> On 28-03-2022 13:37, Krzysztof Kozlowski wrote:
>> On 28/03/2022 09:58, Sameer Pujar wrote:
>>> On 28-03-2022 12:36, Krzysztof Kozlowski wrote:
>>>> External email: Use caution opening links or attachments
>>>>
>>>>
>>>> On 28/03/2022 08:14, Sameer Pujar wrote:
>>>>> The rt5658 or rt5659 CODEC system clock (SYSCLK) can be derived from
>>>>> various clock sources. For example it can be derived either from master
>>>>> clock (MCLK) or by internal PLL. The internal PLL again can take input
>>>>> clock references from bit clocks (BCLKs) and MCLK. To enable a flexible
>>>>> clocking configuration the DT binding is extended here.
>>>>>
>>>>> It makes use of standard clock bindings and sets up the clock relation
>>>>> via DT.
>>>>>
>>>>> Signed-off-by: Sameer Pujar <spujar@nvidia.com>
>>>>> Cc: Oder Chiou <oder_chiou@realtek.com>
>>>>> ---
>>>>>    .../devicetree/bindings/sound/realtek,rt5659.yaml  | 53 ++++++++++++++++++++--
>>>>>    1 file changed, 49 insertions(+), 4 deletions(-)
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/sound/realtek,rt5659.yaml b/Documentation/devicetree/bindings/sound/realtek,rt5659.yaml
>>>>> index b0485b8..0c2f3cb 100644
>>>>> --- a/Documentation/devicetree/bindings/sound/realtek,rt5659.yaml
>>>>> +++ b/Documentation/devicetree/bindings/sound/realtek,rt5659.yaml
>>>>> @@ -29,12 +29,28 @@ properties:
>>>>>        maxItems: 1
>>>>>
>>>>>      clocks:
>>>>> -    items:
>>>>> -      - description: Master clock (MCLK) to the CODEC
>>>>> +    description: |
>>>>> +      CODEC can receive multiple clock inputs like Master
>>>>> +      clock (MCLK), I2S bit clocks (BCLK1, BCLK2, BCLK3,
>>>>> +      BCLK4). The CODEC SYSCLK can be generated from MCLK
>>>>> +      or internal PLL. In turn PLL can reference from MCLK
>>>>> +      and BCLKs.
>>>>>
>>>>>      clock-names:
>>>>> -    items:
>>>>> -      - const: mclk
>>>>> +    description: |
>>>>> +      The clock names can be combination of following:
>>>>> +        "mclk"        : Master clock
>>>>> +        "pll_ref"     : Reference to CODEC PLL clock
>>>>> +        "sysclk"      : CODEC SYSCLK
>>>>> +        "^bclk[1-4]$" : Bit clocks to CODEC
>>>> No, that does not look correct. You allow anything as clock input (even
>>>> 20 clocks, different names, any order). That's not how DT schema should
>>>> work and that's not how hardware looks like.
>>>> Usually the clock inputs are always there which also you mentioned in
>>>> description - "multiple clock inputs". All these clocks should be
>>>> expected, unless really the wires (physical wires) can be left disconnected.
>>> The CODEC can receive multiple clocks but all the input clocks need not
>>> be present or connected always. If a specific configuration is needed
>>> and platform supports such an input, then all these inputs can be added.
>>> I don't know how to define this detail in the schema. If I make all of
>>> them expected, then binding check throws errors. If I were to list all
>>> the possible combinations, the list is going to be big (not sure if this
>>> would be OK?).
>> Thanks for explanation. Please differentiate between these two:
>> 1. clock inputs connected, but unused (not needed for driver or for
>> particular use case),
>> 2. clock inputs really not connected.
>>
>> For the 1. above, such clock inputs should still be listed in the
>> bindings and DTS. For the 2. above, such clocks should actually not be
>> there.
> 
> Thank you for the suggestion.
> 
>> How to achieve this depends on number of your combinations. IOW,
>> how many clocks are physically optional.
> 
>  From CODEC point of view all these clock inputs are possible and a 
> platform may choose to connect a subset of it depending on the 
> application. The binding is expected to support all such cases. To 
> support all possibilities, the total combinations can be very big (100+).
> 
>> For some small number of
>> variations this can be:
>> oneOf:
>>   - const: mclk
>>   - items:
>>     - const: mclk
>>     - enum:
>>         - bclk1
>>         - bclk2
>>         - bclk3
>>         - bclk4
>>   - items:
>>     - const: mclk
>>     - const: pll_ref
>>     - enum:
>>         - bclk1
>>         - bclk2
>>         - bclk3
>>         - bclk4
>>
>> For a total flexibility that any clock input can be disconnected, this
>> should be a list of enums I guess (with minItems). However please find
>> the clocks always connected and include them if possible in a fixed way
>> (like this oneOf above).
> 
> May be I can list the most commonly required combinations like below and 
> extend it whenever there is a need for specific combination?

Yes, this would work. Relaxing such constraints is possible.


Best regards,
Krzysztof
