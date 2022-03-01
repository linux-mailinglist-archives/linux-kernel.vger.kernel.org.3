Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71A014C8C84
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 14:22:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234354AbiCANWn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 08:22:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231247AbiCANWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 08:22:42 -0500
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EFAB9BB8A;
        Tue,  1 Mar 2022 05:22:01 -0800 (PST)
Received: by mail-ej1-f54.google.com with SMTP id a8so31454957ejc.8;
        Tue, 01 Mar 2022 05:22:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=5Ra2I3hSMIC3yuqrkvmVSbWC/D8eEJ4Xrnz10p75G70=;
        b=6rtA3t3TabidRKd39XlDDrulzZ8Zwtzh1JX8VQL5++jrdOBciLsIV6TkJB34jTN9Jz
         DotlaQFy1fRtbKgcerc0lO+heifoeTGAOAnPc0hwIx1ae8ipO6k0Tjx+Af+c4+2VXFd1
         N55AQE1EUtjzZv6AJNFUJ0ZRjfG2f0P3CzE/ji9IQV43nq0IfK7XLRa5IqIwfMZkRaHk
         3CDTlqSLb3IARBfuh+bvpNxpORDvg3SJNsdU/+IO4odgx+ezMDkZJXsLfoZQkLQKJzaz
         uHjsAYmAZRNEm4qgn6yxpc+uYQbFH0skHhEGuECcD9e/DJjMpsheFA4owB4A5BT5dvS5
         rO8w==
X-Gm-Message-State: AOAM532vA88qD1d4JQvP9xr0KcqFRL26t3utyUyf6bjaCHLnhuR/ptsw
        I1+LoLoQTyIWcgER+x/Ywj8=
X-Google-Smtp-Source: ABdhPJw0qQIcZTY5Qhv2NfeGU9Qhur56YMX3pUpgon42tZ6bx6AhyarSrHoB3HyJjbau7IvycERsgQ==
X-Received: by 2002:a17:906:7d98:b0:6bb:b32b:d3bc with SMTP id v24-20020a1709067d9800b006bbb32bd3bcmr18424888ejo.126.1646140919854;
        Tue, 01 Mar 2022 05:21:59 -0800 (PST)
Received: from [192.168.0.136] (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.googlemail.com with ESMTPSA id p14-20020a05640210ce00b00413211746d4sm7095390edu.51.2022.03.01.05.21.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Mar 2022 05:21:58 -0800 (PST)
Message-ID: <bf1fa181-d2a7-eab9-4045-cf53ae3ce2f2@kernel.org>
Date:   Tue, 1 Mar 2022 14:21:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 2/2] dt-bindings: hwmon: Add sample averaging
 properties for ADM1275
Content-Language: en-US
To:     POTIN LAI <potin.lai@quantatw.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Patrick Williams <patrick@stwcx.xyz>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20220301103900.12637-1-potin.lai@quantatw.com>
 <20220301103900.12637-3-potin.lai@quantatw.com>
 <da4ac970-9e7d-c9cb-eea3-e5ec8a1eef00@kernel.org>
 <9bb56622-2859-1059-6f14-2242ab6a2427@quantatw.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <9bb56622-2859-1059-6f14-2242ab6a2427@quantatw.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

On 01/03/2022 13:42, POTIN LAI wrote:
> 
> Krzysztof Kozlowski 於 1/03/2022 7:16 pm 寫道:
>> On 01/03/2022 11:39, Potin Lai wrote:
>>> Add documentation of new properties for sample averaging in PMON_CONFIG
>>> register.
>>>
>>> New properties:
>>> - adi,volt-curr-sample-average
>>> - adi,power-sample-average
>>> - adi,power-sample-average-enable
>>>
>>> Signed-off-by: Potin Lai <potin.lai@quantatw.com>
>>> ---
>>>  .../bindings/hwmon/adi,adm1275.yaml           | 44 +++++++++++++++++++
>>>  1 file changed, 44 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/hwmon/adi,adm1275.yaml b/Documentation/devicetree/bindings/hwmon/adi,adm1275.yaml
>>> index 223393d7cafd..1b612dc06992 100644
>>> --- a/Documentation/devicetree/bindings/hwmon/adi,adm1275.yaml
>>> +++ b/Documentation/devicetree/bindings/hwmon/adi,adm1275.yaml
>>> @@ -37,6 +37,47 @@ properties:
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
>>> +    enum: [1, 2, 4, 8, 16, 32, 64, 128]
>>> +    default: 1
>>> +
>>> +  adi,power-sample-average:
>>> +    description: |
>>> +      Number of samples to be used to report power values.
>>> +      If the configured value is not a power of 2, sample averaging number
>>> +      will be configured with smaller and closest power of 2.
>>> +
>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>> +    enum: [1, 2, 4, 8, 16, 32, 64, 128]
>>> +    default: 1
>>> +
>>> +  adi,power-sample-average-enable:
>>> +    description: Enable sample averaging for power reading.
>>> +    type: boolean
>> Why do you need this property? Voltage/current sampling is enabled in
>> your driver with presence of adi,volt-curr-sample-average. Why power
>> sampling is different?
> For "adi,power-sample-average", adm1075, adm1275 & adm127 don't have config reg for power sample average, so I add boolean type property to enable it
> But for "adi,power-sample-average-enable", all chips have ability of configuring, so it doesn't need a property to enable or disable.

So the reason to add separate property is that this feature can be
disabled. Since your driver does not disable it, it seems it is a
default state to have it disabled and you have to enable it, right?
Where is the enable code? I see you only write the sample averaging
value with adm1275_write_pmon_config(). There is no enable...

But wait, the power averaging is being disabled by writing 0 to
register, which is not allowed by bindings. How one can disable it?

I don't see any usage of "adi,power-sample-average-enable", neither in
driver nor in hardware. I also do not see the need for it, the purpose.

Then second part, you added default value of 1 to
adi,volt-curr-sample-average and adi,power-sample-average. If the
property is missing, then the default of 1 is applied, right? But
datasheet says that default is 128!

The bindings neither match hardware nor driver. They look entirely
independent. This is wrong. They should instead be strongly related to
the hardware, describe the hardware. Then the driver should implement
proper logic for it.

> Does example means that I can set any type (not just boolean?) of property to false if not allowed?
> Could I write as below?
> 
> allOf:
>   - if:
>       properties:
>         compatible:
>           contains:
>             enum:
>               - chips_not_support
>     then:
>       properties:
>         adi,power-sample-average: false
> 
> Sorry, I am not quite understand the example of set property not allowed, if I still get it wrong, please advise more detailed, thank you.

I gave you the example:
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/Documentation/devicetree/bindings/example-schema.yaml?#n221
and there is no boolean in this example. You have a compatible which
does not allow some property, so you need "then:properties:foobar:false"

Best regards,
Krzysztof
