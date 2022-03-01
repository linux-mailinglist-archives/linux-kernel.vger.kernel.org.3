Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E8A24C90DD
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 17:47:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236401AbiCAQsX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 11:48:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236417AbiCAQr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 11:47:56 -0500
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CD264665D;
        Tue,  1 Mar 2022 08:47:15 -0800 (PST)
Received: by mail-oo1-xc2e.google.com with SMTP id k13-20020a4a948d000000b003172f2f6bdfso23108592ooi.1;
        Tue, 01 Mar 2022 08:47:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:content-language:to
         :cc:references:from:subject:in-reply-to:content-transfer-encoding;
        bh=TJyhIr9uQwSC4Vsri+p7N794sJJ7eTPsgawQLVN8g34=;
        b=jAPFaDS2K5ULsq1PG8vS4As2lLxVauB/3stdyl7zTknK9bYFJTKyAuGN/oyxHrfSgw
         Lzmn+8L1wAgiyE/WfKfYB0GIL86iRnemCgOOLznFdl2kHl0uQ87dcwitBgQoddeDdhz7
         j3sziGJC6IGC+3UxFZSM/YXUU2nsNTPNYCk8T4sVv+mjU3egKf1lKvUpn4U1v8LIjMQu
         Nrz7u7mxwv2G6BYRjbm8lDQZkntQKYQwj8Bo0ffzbjeyNt1qKS1OzlWy6ondUdg4VGFe
         zD3SZ4djKqGx7J/aK3N3lHDFnXaKpegB+q7qEKAbIiYUuz0ofQ1m0wMFKUUFizpfEPLa
         Lw4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=TJyhIr9uQwSC4Vsri+p7N794sJJ7eTPsgawQLVN8g34=;
        b=OIwMexZ5Rha8vzU7uX1gpspqvTgo9/kBmlg7qL889u4aN9+vkccl10gRMyQuzjOgA5
         tcl3Y+g8jBqmdEwqk6f4JAYVJHinoKHirNcbYWITBQxTlpWD/H9hHVkqk1Z0TXI+iaKG
         Ki6awEWqhiWLpbmrSIoRyUHxjpupch7kpALXDk7pdVUJN/EGmStLpsLGu6HTEuXbSIgA
         sICRGxMaeQkj9BFJYuyoQWkBQhGABWWmvuGBSTYlmmNx5MP5LaCxzGtxRUkC+/jISyrw
         1totJt6K+4izqbalRBpM8rT6blXnUdHfW0i9kZQzyiIyO44e8EwNaRIRDTruzuSM0QFZ
         7ZwA==
X-Gm-Message-State: AOAM531+sbY8g7ceyQmcXGR5htqL4HJHoa6IiChrPrCyqfIUPzclWUCr
        PtNODcMhrvOdluI4T4ZDr2s=
X-Google-Smtp-Source: ABdhPJxRlXCSXw5okfjbvGh+ENHHVpGOLCWC0P46271cFZLQm7p25NH4JHb13DPShvjaBP2+hLP/jw==
X-Received: by 2002:a05:6870:600a:b0:d7:4895:75be with SMTP id t10-20020a056870600a00b000d7489575bemr4091771oaa.35.1646153234602;
        Tue, 01 Mar 2022 08:47:14 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q13-20020a0568080ecd00b002d44f01f1d7sm8292922oiv.40.2022.03.01.08.47.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Mar 2022 08:47:13 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <39415d57-ec14-aab8-20fd-92d2a810f3fd@roeck-us.net>
Date:   Tue, 1 Mar 2022 08:47:11 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        POTIN LAI <potin.lai@quantatw.com>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Patrick Williams <patrick@stwcx.xyz>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20220301103900.12637-1-potin.lai@quantatw.com>
 <20220301103900.12637-3-potin.lai@quantatw.com>
 <da4ac970-9e7d-c9cb-eea3-e5ec8a1eef00@kernel.org>
 <9bb56622-2859-1059-6f14-2242ab6a2427@quantatw.com>
 <bf1fa181-d2a7-eab9-4045-cf53ae3ce2f2@kernel.org>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v4 2/2] dt-bindings: hwmon: Add sample averaging
 properties for ADM1275
In-Reply-To: <bf1fa181-d2a7-eab9-4045-cf53ae3ce2f2@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/1/22 05:21, Krzysztof Kozlowski wrote:
> On 01/03/2022 13:42, POTIN LAI wrote:
>>
>> Krzysztof Kozlowski 於 1/03/2022 7:16 pm 寫道:
>>> On 01/03/2022 11:39, Potin Lai wrote:
>>>> Add documentation of new properties for sample averaging in PMON_CONFIG
>>>> register.
>>>>
>>>> New properties:
>>>> - adi,volt-curr-sample-average
>>>> - adi,power-sample-average
>>>> - adi,power-sample-average-enable
>>>>
>>>> Signed-off-by: Potin Lai <potin.lai@quantatw.com>
>>>> ---
>>>>   .../bindings/hwmon/adi,adm1275.yaml           | 44 +++++++++++++++++++
>>>>   1 file changed, 44 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/hwmon/adi,adm1275.yaml b/Documentation/devicetree/bindings/hwmon/adi,adm1275.yaml
>>>> index 223393d7cafd..1b612dc06992 100644
>>>> --- a/Documentation/devicetree/bindings/hwmon/adi,adm1275.yaml
>>>> +++ b/Documentation/devicetree/bindings/hwmon/adi,adm1275.yaml
>>>> @@ -37,6 +37,47 @@ properties:
>>>>       description:
>>>>         Shunt resistor value in micro-Ohm.
>>>>   
>>>> +  adi,volt-curr-sample-average:
>>>> +    description: |
>>>> +      Number of samples to be used to report voltage and current values.
>>>> +      If the configured value is not a power of 2, sample averaging number
>>>> +      will be configured with smaller and closest power of 2.
>>>> +
>>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>>> +    enum: [1, 2, 4, 8, 16, 32, 64, 128]
>>>> +    default: 1
>>>> +
>>>> +  adi,power-sample-average:
>>>> +    description: |
>>>> +      Number of samples to be used to report power values.
>>>> +      If the configured value is not a power of 2, sample averaging number
>>>> +      will be configured with smaller and closest power of 2.
>>>> +
>>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>>> +    enum: [1, 2, 4, 8, 16, 32, 64, 128]
>>>> +    default: 1
>>>> +
>>>> +  adi,power-sample-average-enable:
>>>> +    description: Enable sample averaging for power reading.
>>>> +    type: boolean
>>> Why do you need this property? Voltage/current sampling is enabled in
>>> your driver with presence of adi,volt-curr-sample-average. Why power
>>> sampling is different?
>> For "adi,power-sample-average", adm1075, adm1275 & adm127 don't have config reg for power sample average, so I add boolean type property to enable it
>> But for "adi,power-sample-average-enable", all chips have ability of configuring, so it doesn't need a property to enable or disable.
> 
> So the reason to add separate property is that this feature can be
> disabled. Since your driver does not disable it, it seems it is a
> default state to have it disabled and you have to enable it, right?
> Where is the enable code? I see you only write the sample averaging
> value with adm1275_write_pmon_config(). There is no enable...
> 
> But wait, the power averaging is being disabled by writing 0 to
> register, which is not allowed by bindings. How one can disable it?
> 

Valid register values are 0..7, matching dt property values of
BIT(x) or 1 .. 128. Setting the property value to 1 (= 1 sample)
is equivalent to disabling sampling.

> I don't see any usage of "adi,power-sample-average-enable", neither in
> driver nor in hardware. I also do not see the need for it, the purpose.
> 
> Then second part, you added default value of 1 to
> adi,volt-curr-sample-average and adi,power-sample-average. If the
> property is missing, then the default of 1 is applied, right? But
> datasheet says that default is 128!
> 
> The bindings neither match hardware nor driver. They look entirely
> independent. This is wrong. They should instead be strongly related to
> the hardware, describe the hardware. Then the driver should implement
> proper logic for it.
> 

Agreed.

Guenter
