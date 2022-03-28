Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C09A4E8FC3
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 10:08:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239132AbiC1IJh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 04:09:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231181AbiC1IJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 04:09:36 -0400
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CD8052E58;
        Mon, 28 Mar 2022 01:07:51 -0700 (PDT)
Received: by mail-wm1-f41.google.com with SMTP id h126-20020a1c2184000000b0038d043aac51so738224wmh.0;
        Mon, 28 Mar 2022 01:07:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=aqhIXOehpG2sn3GYsWc941YXJLzzHilfcGYNNCqo6QM=;
        b=TuqBix4Pvc+wCi0Z+SljSG+VkieklhagQITlSeky9hamXq54FjkcBlkHp04ADtjUGb
         0amTFIAh/30c/iL7ZLSdHUjZ6bIns+37MJOGQD2cu9uT78QhezOR+ZWisqRDCZWrgm90
         rZJZxj/+4IS02n80ypLk7jwy3HBfGNv9oLd0pc0b4J8Wjl0JYpKWGOhtD0Gzze1a5pTl
         i2iX/Ixh5f2X+Ry10jGZXB+FCmEBthjElgOQKwSiH/C6PaiZ+/5dSPrjlaxqDdRq/1c2
         fXldXfOCehfnh6gOgajU5gQBObmvDEGKYHXsKTvzGEFJTj9tZiRlXGlyveATG8Ipq5NH
         Tklw==
X-Gm-Message-State: AOAM530jx5Rae6+3FkkVUWyoRqYeCB8GiwxvpJkEBNPaXoM8sqbwBZ1D
        gsYmO06rhXXnfnKVdvWIOkc=
X-Google-Smtp-Source: ABdhPJwKQEhNvAqduG5eNAfs0wurvmYokocu7FgFYMj6haT87acsa3lSCjzm5F29F803nAII8IyeoQ==
X-Received: by 2002:a1c:e915:0:b0:37b:d847:e127 with SMTP id q21-20020a1ce915000000b0037bd847e127mr24995447wmc.180.1648454869508;
        Mon, 28 Mar 2022 01:07:49 -0700 (PDT)
Received: from [192.168.0.162] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.googlemail.com with ESMTPSA id z18-20020a5d6412000000b0020400dde72esm11530807wru.37.2022.03.28.01.07.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Mar 2022 01:07:48 -0700 (PDT)
Message-ID: <5e4e11b5-02b8-e03e-2924-c9f2882921be@kernel.org>
Date:   Mon, 28 Mar 2022 10:07:47 +0200
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
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <53d77f33-27e8-3446-d758-3e545eea2db4@nvidia.com>
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

On 28/03/2022 09:58, Sameer Pujar wrote:
> 
> On 28-03-2022 12:36, Krzysztof Kozlowski wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> On 28/03/2022 08:14, Sameer Pujar wrote:
>>> The rt5658 or rt5659 CODEC system clock (SYSCLK) can be derived from
>>> various clock sources. For example it can be derived either from master
>>> clock (MCLK) or by internal PLL. The internal PLL again can take input
>>> clock references from bit clocks (BCLKs) and MCLK. To enable a flexible
>>> clocking configuration the DT binding is extended here.
>>>
>>> It makes use of standard clock bindings and sets up the clock relation
>>> via DT.
>>>
>>> Signed-off-by: Sameer Pujar <spujar@nvidia.com>
>>> Cc: Oder Chiou <oder_chiou@realtek.com>
>>> ---
>>>   .../devicetree/bindings/sound/realtek,rt5659.yaml  | 53 ++++++++++++++++++++--
>>>   1 file changed, 49 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/sound/realtek,rt5659.yaml b/Documentation/devicetree/bindings/sound/realtek,rt5659.yaml
>>> index b0485b8..0c2f3cb 100644
>>> --- a/Documentation/devicetree/bindings/sound/realtek,rt5659.yaml
>>> +++ b/Documentation/devicetree/bindings/sound/realtek,rt5659.yaml
>>> @@ -29,12 +29,28 @@ properties:
>>>       maxItems: 1
>>>
>>>     clocks:
>>> -    items:
>>> -      - description: Master clock (MCLK) to the CODEC
>>> +    description: |
>>> +      CODEC can receive multiple clock inputs like Master
>>> +      clock (MCLK), I2S bit clocks (BCLK1, BCLK2, BCLK3,
>>> +      BCLK4). The CODEC SYSCLK can be generated from MCLK
>>> +      or internal PLL. In turn PLL can reference from MCLK
>>> +      and BCLKs.
>>>
>>>     clock-names:
>>> -    items:
>>> -      - const: mclk
>>> +    description: |
>>> +      The clock names can be combination of following:
>>> +        "mclk"        : Master clock
>>> +        "pll_ref"     : Reference to CODEC PLL clock
>>> +        "sysclk"      : CODEC SYSCLK
>>> +        "^bclk[1-4]$" : Bit clocks to CODEC
>> No, that does not look correct. You allow anything as clock input (even
>> 20 clocks, different names, any order). That's not how DT schema should
>> work and that's not how hardware looks like.
> 
>>
>> Usually the clock inputs are always there which also you mentioned in
>> description - "multiple clock inputs". All these clocks should be
>> expected, unless really the wires (physical wires) can be left disconnected.
> 
> The CODEC can receive multiple clocks but all the input clocks need not 
> be present or connected always. If a specific configuration is needed 
> and platform supports such an input, then all these inputs can be added. 
> I don't know how to define this detail in the schema. If I make all of 
> them expected, then binding check throws errors. If I were to list all 
> the possible combinations, the list is going to be big (not sure if this 
> would be OK?).

Thanks for explanation. Please differentiate between these two:
1. clock inputs connected, but unused (not needed for driver or for
particular use case),
2. clock inputs really not connected.

For the 1. above, such clock inputs should still be listed in the
bindings and DTS. For the 2. above, such clocks should actually not be
there. How to achieve this depends on number of your combinations. IOW,
how many clocks are physically optional. For some small number of
variations this can be:
oneOf:
 - const: mclk
 - items:
   - const: mclk
   - enum:
       - bclk1
       - bclk2
       - bclk3
       - bclk4
 - items:
   - const: mclk
   - const: pll_ref
   - enum:
       - bclk1
       - bclk2
       - bclk3
       - bclk4

For a total flexibility that any clock input can be disconnected, this
should be a list of enums I guess (with minItems). However please find
the clocks always connected and include them if possible in a fixed way
(like this oneOf above).


Best regards,
Krzysztof
