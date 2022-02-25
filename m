Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DCC84C404D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 09:42:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238592AbiBYImO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 03:42:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238588AbiBYImE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 03:42:04 -0500
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 548BB24FBBB;
        Fri, 25 Feb 2022 00:41:31 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id j2so6618458oie.7;
        Fri, 25 Feb 2022 00:41:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:content-language:to
         :cc:references:from:subject:in-reply-to:content-transfer-encoding;
        bh=F5TvTHEzfjts7n7xwWtLjAIecr0LIjz0bAVcaxg/icE=;
        b=gS2Vx5LulnThHrcvwVNn5kj05DndGf1i3cMCQ7DqE8kBOenLNs7mhCqVGypU73KKFB
         uJAA+ZvJlRR9ABBDxaTONy8ytiyWG0PDt8AdyeH5/JuMg3L2xulp/q+aIzUu0ZjazkVV
         tHt4ZLzplTtYn4S2L7FWJqCU0FEEy/ueWFFRllRtgfWe/jzja8JbL/1YL2ZoBtQk/Nii
         tAH6pax3uWH4JGoeSJv7lXqRMNMGKlm+btUI9braDxQsFSJO5aMf1ebMGpkg9KTp1/9j
         fG0ncuCxCzJHXWdGDDIW3BSzkKAAuq4vaOcq8yl8D7zDEXlcHHGlXYeG8EBfAB3vVRFE
         8G6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=F5TvTHEzfjts7n7xwWtLjAIecr0LIjz0bAVcaxg/icE=;
        b=e0CupBjkIPjCrAJSo6b3PYWnxD4ZcRnwG8eJodYMxAIn9Ekj17edS3W927yYScc8Jj
         zlKmBy2mtFVDwohSum/lAHSvf6SXjZMilY+aYwcTl1kM0+FIs8kW2F8m9E940hDHtJ0R
         oEdVahGhuGoM2tZrHVghsEt7p7nEx4dK/TYpxB+A/92lAug5OkH8B0v1K2Z8vWgHgi+W
         UCeI251QPynAd6qoIhdooBQnvqqHCRmkrrWUqnZ0FdvOpEljts4b71bJF4e6/Ir/PqdO
         3O/FZOhbdf+j5zyrGUpKdxG3QVRvPN229WmowZkVKXPxJmaWLEevpRTuZ0KfcoQiHCdd
         TxHQ==
X-Gm-Message-State: AOAM533eMGAL1IUh3C8MJ+5vU3xsdNYjR3N6tKo2tMCSeDIcDyC24VMV
        j+Von51LfrNuGRwUMYf7nfE=
X-Google-Smtp-Source: ABdhPJyJZ9j+S8dqGSLrVdG0PIZmRZROBmy5/gCqEY/5ztqHZCc3/AnTLe0ZTrBQwJgCWns6I7ejTA==
X-Received: by 2002:a05:6808:1586:b0:2d5:1211:5785 with SMTP id t6-20020a056808158600b002d512115785mr944779oiw.0.1645778490691;
        Fri, 25 Feb 2022 00:41:30 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c8-20020a4ad788000000b0031ce69b1640sm774069oou.10.2022.02.25.00.41.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Feb 2022 00:41:30 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <91e35667-5203-271b-8a0e-b9ddf71561d6@roeck-us.net>
Date:   Fri, 25 Feb 2022 00:41:27 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Potin Lai <potin.lai@quantatw.com>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Patrick Williams <patrick@stwcx.xyz>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20220224154329.9755-1-potin.lai@quantatw.com>
 <20220224154329.9755-3-potin.lai@quantatw.com>
 <c6607953-927e-4d85-21cb-72e01a121453@kernel.org>
 <b527a418-b807-7afa-9ed0-2ac4271ff79e@kernel.org>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v2 2/2] dt-bindings: hwmon: Add sample averaging property
 for ADM1275
In-Reply-To: <b527a418-b807-7afa-9ed0-2ac4271ff79e@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 2/24/22 23:31, Krzysztof Kozlowski wrote:
> On 25/02/2022 08:06, Krzysztof Kozlowski wrote:
>> On 24/02/2022 16:43, Potin Lai wrote:
>>> Add new properties for binding sample averaging in PMON_CONFIG register
>>>
>>> - adi,volt-curr-sample-average
>>> - adi,power-sample-average
>>>
>>> Signed-off-by: Potin Lai <potin.lai@quantatw.com>
>>> ---
>>>   .../bindings/hwmon/adi,adm1275.yaml           | 44 +++++++++++++++++++
>>>   1 file changed, 44 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/hwmon/adi,adm1275.yaml b/Documentation/devicetree/bindings/hwmon/adi,adm1275.yaml
>>> index 223393d7cafd..325f6827648f 100644
>>> --- a/Documentation/devicetree/bindings/hwmon/adi,adm1275.yaml
>>> +++ b/Documentation/devicetree/bindings/hwmon/adi,adm1275.yaml
>>> @@ -37,6 +37,48 @@ properties:
>>>       description:
>>>         Shunt resistor value in micro-Ohm.
>>>   
>>> +  adi,volt-curr-sample-average:
>>> +    description: |
>>> +      A value to configure VI_AVG in PMON_CONFIG register to indicate a
>>> +      number of samples to be used to report voltage and currentvalues.
>>
>> missing space after current.
>>
>>> +      If set to 7, the 128 samples averaging would be used.
>>> +
>>> +    $ref: /schemas/types.yaml#/definitions/uint8
>>
>> Make it a uint32.
>>
>> The previous usage of this field was more appropriate. Instead of
>> keeping register values in DT, it's better to keep logical value. What
>> if in next cheap the register values have calculation method?
>>
>> This should be like in v1 - enum for number of samples to take in averaging.
>>
> 
> One more thought: this field could also stay in current approach if you
> change the meaning from "value to configure VI_AVG" to something like
> "the exponent used to determine the number of samples, where the base is 2".
> 
> This approach would allow you to skip the "ilog" in the code. It sill
> won't be that easily scalable if another chip comes with different
> formula, but I think that's unlikely.
> 

The standard hwmon ABI expects the number of samples, it isn't always a
power of 2, and the driver already implements it (with ilog2) as sysfs
attribute. I don't really see the point of "optimizing" something
like this to be chip specific just to avoid some error checking.

Guenter
