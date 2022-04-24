Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73A1F50D172
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 13:22:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239270AbiDXLYF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 07:24:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239264AbiDXLYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 07:24:02 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E6B615FDB
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 04:21:02 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id g6so1686539ejw.1
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 04:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=AP6kJABFBHG2D4OKzCzakTnuRW2oYbz1dDUS+gWnnRg=;
        b=HY4c3l65zyTHDRs/EAWmOPFXQwGpFLHe4fxBZwhMaV/X2BXdQLqt8mkKYH/ElooINu
         WwiglKCOkazE9EhJJ8mwQnwVfPxFU1ao+OECrHJbsLSw8GUsxkkCXXr98S60XNwIpmis
         /1SvIjbszaKwuLCeI8ZaIbBh3TMDx1lnkNReGTVVTIdfLbGKrQsRbc3djz7J6kajJRRq
         8QsF0LM7FWb4dPT0AOfU684L3Gp5+7dyz6kn2ggPXmgK8MTRGvx6LzIoIjLC1dfoUWxQ
         zWpd32tsZXaiMH7UcalGAsIN9u52wNxGv0M4QZjwHZDsrkFKuyGrY/VE+zAPcIwxFuo1
         Erww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=AP6kJABFBHG2D4OKzCzakTnuRW2oYbz1dDUS+gWnnRg=;
        b=UNeaufaZclU5bMhHo0nWFUghm26+h9n1PB2FQc0S6NcHqCnQn7lrbhStOY35YEZus6
         3sbJiWMt4qyKDwifW6rof3tmV0WKBnkc09kpKbE40iRK8RPX0QdFGzok654IqHQ48bPK
         Sg1XEITRp86V7Ggue9zpD+FElBvucY08ScfFGrVhGFZ24NgLNKXt+qhx8Srqmnmxvb4U
         yGb63ZL8wFTSZ22o5HuxEPEXIEJsUqqAw+RGZqQ6/1NOSNXNX3VK5iyuP/SwYFjBTSvS
         PkZzy9qwVmnoDkekp8nz9hodds26l3Rhmblnd2eBpvuX6M7HHOr1SteXaed4FCfriGLw
         em1w==
X-Gm-Message-State: AOAM530s3nAEFH9GbfY9qEB/wdLU4+qLBKvlLKRF93gSBSmjUffyjywE
        /5Ky9f3tJAIakDGtwG0u2WjNZQ==
X-Google-Smtp-Source: ABdhPJy9CnCqBuQQXyUX9GmBqaN2/96mndm+kAM+viZb52Ak2mWIacdO4/j1+X4QFJGaP0AMU/vaOg==
X-Received: by 2002:a17:907:9718:b0:6f3:9606:9fbd with SMTP id jg24-20020a170907971800b006f396069fbdmr141837ejc.290.1650799260622;
        Sun, 24 Apr 2022 04:21:00 -0700 (PDT)
Received: from [192.168.0.235] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id mb22-20020a170906eb1600b006f38dcf211bsm409345ejb.138.2022.04.24.04.20.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Apr 2022 04:21:00 -0700 (PDT)
Message-ID: <baa73bda-91af-8a31-67f4-6d5615862c73@linaro.org>
Date:   Sun, 24 Apr 2022 13:20:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH V3 1/3] dt-bindings: clk: sprd: Add bindings for ums512
 clock controller
Content-Language: en-US
To:     Cixi Geng <gengcixi@gmail.com>
Cc:     Michael Turquette <mturquette@baylibre.com>, sboyd@kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org,
        Orson Zhai <orsonzhai@gmail.com>,
        "baolin.wang7@gmail.com" <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        linux-clk@vger.kernel.org,
        Devicetree List <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220418125630.2342538-1-gengcixi@gmail.com>
 <20220418125630.2342538-2-gengcixi@gmail.com>
 <714caf6e-5f81-6d73-7629-b2c675f1f1d4@linaro.org>
 <CAF12kFv6uioc7ATtXLpGTTDBFT1wYWZUBoyjQqP1bSUnut0pKA@mail.gmail.com>
 <a5a59f3c-00a3-afc5-24aa-1ae3de2600ec@linaro.org>
 <CAF12kFu5KW+fw=0kP6LrEqOvKYR38mELfPjG64=n+gudRxsZUQ@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAF12kFu5KW+fw=0kP6LrEqOvKYR38mELfPjG64=n+gudRxsZUQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/04/2022 12:47, Cixi Geng wrote:
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> 于2022年4月19日周二 14:38写道：
>>
>> On 19/04/2022 03:53, Cixi Geng wrote:
>>> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> 于2022年4月19日周二 00:28写道：
>>>>
>>>> On 18/04/2022 14:56, Cixi Geng wrote:
>>>>> From: Cixi Geng <cixi.geng1@unisoc.com>
>>>>>
>>>>> Add a new bindings to describe ums512 clock compatible string.
>>>>>
>>>>> Signed-off-by: Cixi Geng <cixi.geng1@unisoc.com>
>>>>> ---
>>>>>  .../bindings/clock/sprd,ums512-clk.yaml       | 112 ++++++++++++++++++
>>>>>  1 file changed, 112 insertions(+)
>>>>>  create mode 100644 Documentation/devicetree/bindings/clock/sprd,ums512-clk.yaml
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/clock/sprd,ums512-clk.yaml b/Documentation/devicetree/bindings/clock/sprd,ums512-clk.yaml
>>>>> new file mode 100644
>>>>> index 000000000000..89824d7c6be4
>>>>> --- /dev/null
>>>>> +++ b/Documentation/devicetree/bindings/clock/sprd,ums512-clk.yaml
>>>>> @@ -0,0 +1,112 @@
>>>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>>>> +# Copyright 2022 Unisoc Inc.
>>>>> +%YAML 1.2
>>>>> +---
>>>>> +$id: "http://devicetree.org/schemas/clock/sprd,ums512-clk.yaml#"
>>>>> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
>>>>> +
>>>>> +title: UMS512 Clock Control Unit Device Tree Bindings
>>>>
>>>> Remove "Device Tree Bindings". You could do the same also in the
>>>> subject, because you repeat the prefix ("dt-bindings: clk: sprd: Add
>>>> ums512 clock controller").
>>>>
>>>>> +
>>>>> +maintainers:
>>>>> +  - Orson Zhai <orsonzhai@gmail.com>
>>>>> +  - Baolin Wang <baolin.wang7@gmail.com>
>>>>> +  - Chunyan Zhang <zhang.lyra@gmail.com>
>>>>> +
>>>>> +properties:
>>>>> +  "#clock-cells":
>>>>> +    const: 1
>>>>> +
>>>>> +  compatible:
>>>>
>>>> Put the compatible first, by convention and makes finding matching
>>>> bindings easier.
>>>>
>>>>> +    oneOf:
>>>>> +      - items:
>>>>> +          - const: sprd,ums512-glbregs
>>>>> +          - const: syscon
>>>>> +          - const: simple-mfd
>>>>
>>>> Why do you need simple-mfd for these? This looks like a regular syscon,
>>>> so usually does not come with children. What is more, why this "usual
>>>> syscon" is a separate clock controller in these bindings?
>>> there is a warning log before add these const.  and the reason we need
>>> the simply-mfd
>>> is some clock is a child of syscon node,which should set these compatible.
>>> failed to match any schema with compatible: ['sprd,ums512-glbregs',
>>> 'syscon', 'simple-mfd']
>>
>> Neither here nor later you did not answer the question - why do you need
>> such complex construction, instead of adding syscon to the clock controller?
>>
>> Let me paste again my concerns:
>>
>>   You have nodes with reg but without unit address ("rpll"). These nodes
>>   are modeled as children but they are not children - it's a workaround
>>   for exposing syscon, isn't it? The sc9863a looks like broken design,
>>   so please do not duplicate it here.
>>
>> IOW, sc9863a uses similar pattern as here and the DTS is made wrong.
>> Because of this you need to create complex ways to get the regmap for
>> the clock controller... Why not making it simple? Clock controller with
>> syscon?
> 
> I find the history discuss about the sp9863 clock[1] and last
> ums512-clk dt-bindings patch[2] which from chunyan.
> please refer to the reasons below.
> 
> These clocks are at the same register range with global registers.
> the registers shared with more than one devices  which  basically
> are multimedia devices. You may noticed that these are all gate
> clocks which are in the global registers  ranges and are used to
> controll the enable status of some devices or some part of devices.
> 
> [1] https://lore.kernel.org/all/CAAfSe-s0gcehu0ZDj=FTe5S7CzAHC5mahXBH2fJm7mXS7Xys1Q@mail.gmail.com/#r
> [2] https://lore.kernel.org/all/163425295208.1688384.11023187625793114662@swboyd.mtv.corp.google.com/#r

Which looks like discussion about different bindings. You had there a
clock controller and additional clock device using "sprd,syscon". Why
the rpll is a subdevice and not a part of clock controller. The same as
all other clocks coming from that clock-controller, right? What is so
special about rpll that is is a separate device, not part of the clock
controller? It's the same address space, isn't it?

Best regards,
Krzysztof
