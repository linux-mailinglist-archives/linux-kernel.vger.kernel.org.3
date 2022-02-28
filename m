Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7DB44C719C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 17:20:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237878AbiB1QVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 11:21:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237591AbiB1QVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 11:21:07 -0500
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 777B37DABF;
        Mon, 28 Feb 2022 08:20:28 -0800 (PST)
Received: by mail-ed1-f46.google.com with SMTP id q17so18346716edd.4;
        Mon, 28 Feb 2022 08:20:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=P9w2sABEp/WOpEUZx07FlpoTnPYsNU6bWSHX6sDtljo=;
        b=Rxa8FZSQ2LC0/JvUhw6qnW0zw3TFaubwOKS2ekkhAZMzlyQK02rc4utO0U0g3JkrTc
         gYFVYgkIn1nJEAXVEiYaI2PStK2WmCB3fk5Tq9X+2fF8FyT4e+2iTzV2QtgAG6UcMfAy
         UDvxP8dN4ewcqanG5eyF5HArzP6FL0u4k9U8vx3w2Hy6qgOVAdqSWM2K2xvj6uix157q
         pXa5QcAxbQYFkQGNEL47r4aabHMRDIqbbErSNNEUr3VqmgH+nyt9obPueTkwSaPzc96S
         +188vPhmS0oUqjMQZlIesgGSJggVFZXvvLgVyd0cDBxibKvL+YbzK2TQ/xp8bHjNRnZF
         9TJw==
X-Gm-Message-State: AOAM530qKqHoZ9oQc08WnLuNnbXW/raCS1QdNhJvjMY7vSIEuKI57T5O
        ETq5yHYikTJaOL+KIzmxExc=
X-Google-Smtp-Source: ABdhPJzrs1dQNtccJPLhdeapL/ze/0/SWQ0EdlMjYvwVWpaNhVg3Zn9bLWQFNv98b3cFuMXZ4r9K9A==
X-Received: by 2002:aa7:c983:0:b0:410:d314:6451 with SMTP id c3-20020aa7c983000000b00410d3146451mr19811851edt.56.1646065226872;
        Mon, 28 Feb 2022 08:20:26 -0800 (PST)
Received: from [192.168.0.135] (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.googlemail.com with ESMTPSA id ec21-20020a170906b6d500b006d170a3444csm4476468ejb.164.2022.02.28.08.20.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Feb 2022 08:20:25 -0800 (PST)
Message-ID: <accfbf05-f0ff-7802-6c99-00ccff4e7809@kernel.org>
Date:   Mon, 28 Feb 2022 17:20:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 2/2] dt-bindings: hwmon: Add sample averaging
 properties for ADM1275
Content-Language: en-US
To:     POTIN LAI <potin.lai@quantatw.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Patrick Williams <patrick@stwcx.xyz>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20220228103716.10774-1-potin.lai@quantatw.com>
 <20220228103716.10774-3-potin.lai@quantatw.com>
 <062ad1fb-269f-2a43-0f47-46894bca426c@kernel.org>
 <aca659c8-558c-7091-f2b6-37ef478a14db@quantatw.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <aca659c8-558c-7091-f2b6-37ef478a14db@quantatw.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

On 28/02/2022 17:13, POTIN LAI wrote:
> 
> Krzysztof Kozlowski 於 28/02/2022 10:25 pm 寫道:
>> On 28/02/2022 11:37, Potin Lai wrote:
>>> Add documentation of new properties for sample averaging in PMON_CONFIG
>>> register.
>>>
>>> New properties:
>>> - adi,volt-curr-sample-average
>>> - adi,power-sample-average
>>>
>>> Signed-off-by: Potin Lai <potin.lai@quantatw.com>
>>>
>>> doc
>> You have weirdly formatted commit msg.
> It must be pasted from somewhere accidentally, sorry.
>>> ---
>>>  .../bindings/hwmon/adi,adm1275.yaml           | 39 +++++++++++++++++++
>>>  1 file changed, 39 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/hwmon/adi,adm1275.yaml b/Documentation/devicetree/bindings/hwmon/adi,adm1275.yaml
>>> index 223393d7cafd..bc4206b257a8 100644
>>> --- a/Documentation/devicetree/bindings/hwmon/adi,adm1275.yaml
>>> +++ b/Documentation/devicetree/bindings/hwmon/adi,adm1275.yaml
>>> @@ -37,6 +37,43 @@ properties:
>>>      description:
>>>        Shunt resistor value in micro-Ohm.
>>>  
>>> +  adi,volt-curr-sample-average:
>>> +    description: |
>>> +      Number of samples to be used to report voltage and current values.
>>> +      If the configured value is not a power of 2, sample averaging number
>>> +      will be configured with smaller and closest power of 2.
>>> +
>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>> +    minimum: 1
>>> +    maximum: 128
>>> +    default: 1
>>> +
>>> +  adi,power-sample-average:
>>> +    description: |
>>> +      Number of samples to be used to report power values.
>>> +      If the configured value is not a power of 2, sample averaging number
>>> +      will be configured with smaller and closest power of 2.
>>> +
>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>> +    minimum: 1
>>> +    maximum: 128
>>> +    default: 1
>>> +
>>> +if:
>> This should be in allOf.
> will add it.
>>
>>> +  not:
>> Remove negation and list devices where it is not allowed.
> will remove it.
>>
>>> +    properties:
>>> +      compatible:
>>> +        contains:
>>> +          enum:
>>> +          - adi,adm1272
>>> +          - adi,adm1278
>>> +          - adi,adm1293
>>> +          - adi,adm1294
>>> +then:
>>> +  properties:
>>> +    adi,power-sample-average:
>>> +      description: This property is not allowed.
>> This does not work. Please test it - add not allowed property to such
>> devices and look for error. I gave you the example how it should be
>> done. Why doing it in a different way which does not work?
>>
> Sorry for misunderstanding from original example. I rechecked the example and made a modification as below, before sending out new patch, would you mind help me review it and let me know if anything improper? Thank you.

Don't take the example by copying and pasting. It has to be adjusted, I
just explained there in example how to disallow a property.

> 
> 
> dependencies:
>   adi,enable-power-sample-average: [ 'adi,power-sample-average' ]
>   adi,power-sample-average: [ 'adi,enable-power-sample-average' ]
> 
> allOf:
>   - if:
>       properties:
>         compatible:
>           contains:
>             enum:
>               - adi,adm1272
>               - adi,adm1278
>               - adi,adm1293
>               - adi,adm1294
>     then:
>       required:
>         - adi,enable-power-sample-average

This does not look correct, because it is not a required property.

You should have "if:then: adi,enable-power-sample-average: false" etc"

>     else:
>       properties:
>         adi,enable-power-sample-average: false
> 
> 


Best regards,
Krzysztof
