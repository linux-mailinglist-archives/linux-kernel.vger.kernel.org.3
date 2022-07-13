Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4C40573B12
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 18:22:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236759AbiGMQWO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 12:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236704AbiGMQWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 12:22:10 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B11D27FCF;
        Wed, 13 Jul 2022 09:22:09 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id q5-20020a17090a304500b001efcc885cc4so4425022pjl.4;
        Wed, 13 Jul 2022 09:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=1rTBKikYG7GcM7zEHGN21/oYPFM/gmtlrQl2UtJfAZY=;
        b=cXJELSm6ihVr91CW9ncTpgzaoUcQlP7h3NCKOLNcWveH5nNiLBOmK7ve5JgqBpVhpz
         pceXDUDYdbyGyBvf/x2uusPpg+/NzFnebJpCByfh1DXOUj/1Dg8CZFQwwanZ6BkNeun8
         z7dMBobzMzuPRtb8pYsHozY6RPViVT9MzPUO96JH42Np5I8fnQqly/4sr8Pgc8B0Dnz5
         oPKzx9FuuFfXQBYpi11/RdzwELvOJV3sZbfZ/7MRS5cyLguGc7RHH0mmINw60rF/wdNf
         AJ8LvWc6x3b4zloxNPSCI+HBPSbUaKB/C2zzXYsB3BuhMGwWBcAsvSDVy2TLVibqHF+G
         R0nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=1rTBKikYG7GcM7zEHGN21/oYPFM/gmtlrQl2UtJfAZY=;
        b=1Wnm4JIFPrQ4BQCyU6uTmd7/uSAxKdLpNtoIHE2AInorPPsaismCyGqjjrZBoEnxnk
         eR6HfkFbroBcK2HEQJTQQnkGLMI5heXxu+mqUDMB9ktLT8gltIcZj+KHKAySYtFJQ2eE
         J1rqNSSdcK7Ynh6IX8Q6fiZecuuJXiF9t/QLFn0Q8AkT8VxPwwyvmwmgHFdN1W6mYhlF
         hrVCE3fIjvIDcTPzyQkdD5mxMlxSGKgBnZCDrrBIAy5IPMAIqBHPi/D9J6HckiwDoLeX
         CsDIxub53b4uA8Py+XNc/S65iHQWM+DAyytypVzCFi6kRzmdOzIGjZYKcSj4wQPPX47b
         FhaQ==
X-Gm-Message-State: AJIora95IuVzhQIfUEDNdokKclD8o+iyf8a06gA11vbtlz6ufXJJMFKg
        R3/eKkfhgPOHDB3ftLb4H/s=
X-Google-Smtp-Source: AGRyM1uVZiyU/tYTSwluF1BCNKA5dghptyONixdw3nZZaBMRKHzVYbZsCmWHKmlSQqpjt9B2lw9erg==
X-Received: by 2002:a17:902:d543:b0:16c:3150:9ba1 with SMTP id z3-20020a170902d54300b0016c31509ba1mr4148865plf.13.1657729328967;
        Wed, 13 Jul 2022 09:22:08 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id m7-20020a1709026bc700b0016bea26bb2asm8877768plt.245.2022.07.13.09.21.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Jul 2022 09:22:08 -0700 (PDT)
Message-ID: <69db228b-f923-13f3-989e-447f94151ac8@gmail.com>
Date:   Wed, 13 Jul 2022 09:21:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [RFC PATCH 1/3] dt-bindings: arm64: bcmbca: Merge BCM4908 into
 BCMBCA
Content-Language: en-US
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        William Zhang <william.zhang@broadcom.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Linux ARM List <linux-arm-kernel@lists.infradead.org>,
        kursad.oney@broadcom.com, anand.gore@broadcom.com,
        dan.beygelman@broadcom.com, f.fainelli@gmail.com,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>,
        joel.peshkin@broadcom.com,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220712021144.7068-1-william.zhang@broadcom.com>
 <20220712021144.7068-2-william.zhang@broadcom.com>
 <ca8c3003-1bcb-6658-592c-566609fd7bd2@linaro.org>
 <94b0ab39-279d-d3c2-98a4-054c10ad041c@broadcom.com>
 <c40f20c7-59ee-99f4-9a11-e928b41eda9f@linaro.org>
 <6efb1cfe-6129-276a-eeb3-44147304d211@broadcom.com>
 <e4356c5e89492eb690e3dc863ba281bd@milecki.pl>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <e4356c5e89492eb690e3dc863ba281bd@milecki.pl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/13/22 03:50, Rafał Miłecki wrote:
> On 2022-07-13 02:57, William Zhang wrote:
>> On 7/12/22 11:18, Krzysztof Kozlowski wrote:
>>> On 12/07/2022 19:37, William Zhang wrote:
>>>>>> +      - description: BCM4908 Family based boards
>>>>>> +        items:
>>>>>> +          - enum:
>>>>>> +              # BCM4908 SoC based boards
>>>>>> +              - brcm,bcm94908
>>>>>> +              - asus,gt-ac5300
>>>>>> +              - netgear,raxe500
>>>>>> +              # BCM4906 SoC based boards
>>>>>> +              - brcm,bcm94906
>>>>>> +              - netgear,r8000p
>>>>>> +              - tplink,archer-c2300-v1
>>>>>> +          - enum:
>>>>>> +              - brcm,bcm4908
>>>>>> +              - brcm,bcm4906
>>>>>> +              - brcm,bcm49408
>>>>>
>>>>> This is wrong.  brcm,bcm94908 followed by brcm,bcm4906 does not look
>>>>> like valid list of compatibles.
>>>>>
>>>> For 4908 board variant, it will need to be followed by 4908 chip. Sorry
>>>> for the basic question but is there any requirement to enforce this 
>>>> kind
>>>> of rule?  I would assume dts writer know what he/she is doing and 
>>>> select
>>>> the right combination.
>>>
>>> The entire point of DT schema is to validate DTS. Combination like above
>>> prevents that goal.
>>>
>>> Best regards,
>>> Krzysztof
>> Understand the DT schema purpose. But items property allows multiple
>> enums in the list which gives a lot of flexibility but make it hard to
>> validate. I am not familiar with DT schema, is there any directive to
>> specify one enum value depending on another so dts validation tool can
>> report error if combination is wrong?
>>
>> This is our preferred format of all bcmbca compatible string
>> especially when we could have more than 10 chip variants for the same
>> chip family and we really want to work on the chip family id.  We will
>> make sure they are in the right combination in our own patch and patch
>> from other contributors. Would this work? If not, I will probably have
>> to revert the change of 4908(maybe append brcm,bcmbca as this chip
>> belongs to the same bca group) and use "enum board variant", "const
>> main chip id", "brcm,bca" for all other chips as our secondary choice.
> 
> I'm not sure why I didn't even receive 1/3 and half of discussion
> e-mails.

You are copied on all 4 emails (including cover letter).
-- 
Florian
