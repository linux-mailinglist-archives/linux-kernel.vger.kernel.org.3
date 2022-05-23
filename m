Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E94D65313BA
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 18:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237902AbiEWPaf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 11:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237865AbiEWPac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 11:30:32 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BDD45FF1F
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 08:30:31 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id br17so13916626lfb.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 08:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=11tx15XOReGzewyuScT08wDXVdYnhOX55HUlYSxbVO4=;
        b=I/gaifkPbRc3Ya6NQFwpk6ISV+74r16YxnkKExnrHD9IOzX28AQ+kmze2NkWbcajxc
         rHv5gQJ/FdqRvV/VnJLO1m+Wq65NeJ5loZDsTILiCsV+vsO5PvBRb4dAJgDL0iLSKvoS
         lwH00d024zvK+H4pvhqXRV1DuSqckrOl1deEwV5NBKp+SsgFonev9Rh5nzfhHu4bVffz
         kdh7vdf76mU5/m8oAi7lTVKXdn1K0OT5IWwaQgFsqrMT7hl7TBlsM83gxD4/EEXnbVAw
         1Ekt/995jl2/70M1BYGcUi0EzUGeIq1oLrVv0ObfSdovQG3LLkcYbkm0cZI6SR8aHt6u
         ph3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=11tx15XOReGzewyuScT08wDXVdYnhOX55HUlYSxbVO4=;
        b=kEhCdv97m6Ol5XIYQh6Pjgpj0znjgorKpnuyXdQjrHTegzCwhzJH2o8olXQWsiFs35
         R1JYYesvcCfKNXcSoQtgvqWoWGjFAEihsXJTyV8NlH95i4v0zcEKeKyoeJ4lnyJQL8ov
         cf+z62WWKTZf5T6pOJZS+OaNs+Ip38TXfm8E6mbYoKclZ+TicqMJJzPvmVHHc8wjD3VN
         hk8oyTl+RyCs4CdP0Qs8VyKLisqY4ox3IQkZ8vblGqealiqHPtGbm0b42czKjpQ2S0Sw
         IkCY4O4Ktm5KQcf3br9lDDBVOIhVRDX9G143kphXPp7H9+YvCR05zEjze6BbKTk8iTi3
         LgIQ==
X-Gm-Message-State: AOAM532S8+cmJ7nHZQenMz2YSmS76JvBSXGOGVIGQrbreFfYQvnY7vge
        MxdCcOEBh4HmHbeMHLFCLkBCIQ==
X-Google-Smtp-Source: ABdhPJyJRlA+mwgV/0/+nj51fLL4x7OsYjBS85WmiP6FyM/mBP3cLnw06RZ5gqPSuvgLQC0gSa9pXQ==
X-Received: by 2002:a19:7106:0:b0:478:68b5:86d9 with SMTP id m6-20020a197106000000b0047868b586d9mr6052561lfc.417.1653319829319;
        Mon, 23 May 2022 08:30:29 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id z5-20020a056512308500b0047255d211e9sm1888943lfd.280.2022.05.23.08.30.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 May 2022 08:30:28 -0700 (PDT)
Message-ID: <4f766cdb-a33b-2470-5b2e-3945c821ce6c@linaro.org>
Date:   Mon, 23 May 2022 17:30:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 1/3] dt-bindings: leds: Add bindings for the TLC5925
 controller
Content-Language: en-US
To:     Jean-Jacques Hiblot <jjhiblot@traphandler.com>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc:     linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220523084958.2723943-1-jjhiblot@traphandler.com>
 <20220523084958.2723943-2-jjhiblot@traphandler.com>
 <d12a0afc-c040-5615-fc0d-70a5c29bbf0a@linaro.org>
 <0e1e417a-6444-ddb5-5c48-c89bd78c5fe8@traphandler.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <0e1e417a-6444-ddb5-5c48-c89bd78c5fe8@traphandler.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/05/2022 17:16, Jean-Jacques Hiblot wrote:
> 
> On 23/05/2022 12:14, Krzysztof Kozlowski wrote:
>> On 23/05/2022 10:49, Jean-Jacques Hiblot wrote:
>>> Add bindings documentation for the TLC5925 LED controller.
>>>
>>> Signed-off-by: Jean-Jacques Hiblot <jjhiblot@traphandler.com>
>> Thank you for your patch. There is something to discuss/improve.
>>
>>> ---
>>> devicetree@vger.kernel.org
>>>   .../bindings/leds/leds-tlc5925.yaml           | 100 ++++++++++++++++++
>>>   1 file changed, 100 insertions(+)
>>>   create mode 100644 Documentation/devicetree/bindings/leds/leds-tlc5925.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/leds/leds-tlc5925.yaml b/Documentation/devicetree/bindings/leds/leds-tlc5925.yaml
>>> new file mode 100644
>>> index 000000000000..156db599d5a1
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/leds/leds-tlc5925.yaml
>> Filename: vendor,device
>> so "ti,tlc5925-leds.yaml" for example.
>>
>>
>>
>>> @@ -0,0 +1,100 @@
>>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/leds/leds-tlc5925.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: LEDs connected to TI TLC5925 controller
>>> +
>>> +maintainers:
>>> +  - Jean-Jacques Hiblot <jjhiblot@traphandler.com>
>>> +
>>> +description: |
>>> +  The TLC5925 is a low-power 16-channel constant-current LED sink driver.
>>> +  It is controlled through a SPI interface.
>>> +  It is built around a shift register and latches which convert serial
>>> +  input data into a parallel output. Several TLC5925 can be chained to
>>> +  control more than 16 LEDs with a single chip-select.
>>> +  The brightness level cannot be controlled, each LED is either on or off.
>>> +
>>> +  Each LED is represented as a sub-node of the ti,tlc5925 device.
>>> +
>>> +properties:
>>> +  compatible:
>>> +    const: ti,tlc5925
>>> +
>>> +  shift_register_length:
>>> +    maxItems: 1
>> No...
>> 1. Did you test your bindings with dt_binding_check? This fails
>> obviously... please, do not send untested bindings.
>>
>> 2. vendor prefix, no underscores, proper type, maxItems look wrong here
>>
>>> +    description: |
>>> +      The length of the shift register. If several TLC5925 are chained,
>>> +      shift_register_length should be set to 16 times the number of TLC5925.
>>> +      The value must be a multiple of 8.
>>> +
>>> +  "#address-cells":
>>> +    const: 1
>>> +
>>> +  "#size-cells":
>>> +    const: 0
>>> +
>>> +  output-enable-b-gpios:
>>> +    description: |
>>> +      GPIO pins to enable/disable the parallel output. They describe the GPIOs
>>> +      connected to the OE/ pin of the TLC5925s.
>> maxItems
> 
> There is no limitation in the driver itself. The actual number of items 
> here really depends on the number of chips and how they are wired.

So you could daisy chain 4 billion of devices? Because by not using any
limit you claim that 4 billion is doable?

> 
>>
>>
>>> +
>>> +patternProperties:
>>> +  "@[a-f0-9]+$":
>> How many LEDs you can have here? Usually it is limited, so the pattern
>> should be narrowed.
> 
> There is no limitation here either. The chips can be chained to augment 
> the number of LEDs.
> 
> The max number of LED is equal to the length of the shift-register.



Best regards,
Krzysztof
