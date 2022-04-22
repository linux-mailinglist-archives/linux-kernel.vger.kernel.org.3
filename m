Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 769CE50C3B6
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 01:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231770AbiDVWOh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 18:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233007AbiDVWNL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 18:13:11 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A9BD22D9E7
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 14:01:03 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id j8so13402503pll.11
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 14:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=vRnN2bu3w2ZJ13Banq4mYlhcFKZGZG+RSSq3HA+wfno=;
        b=oNf2L0dIpA81G6+3xhM+TgZkV9TlJsj1XqB65gROI1z4zCjk55iA3qVnThyXl4ONmH
         ucoBK3qy/EMOz8pt/vLlIbUu9xBE2OaujA9RpsOugKSyYNkt7hLSR34Qq3iOJD/J5umB
         Z6i7y/kE5qrhHQ2VOlMcaPMpexpnqt3tNFQqtQzI3n5XrrHY5LgZQ6hOvC/VRvOe6xQ4
         exNlAArkbkdPegSOpZ1tXfG9h6sfcsKlwE5MUc7BKyKDfRcNvaL1ULHoQZQ2gYDvx0RK
         ZnJs60PHR6eSMc7CACUAOOTlOe48623D4cALr73xdGnR++duHMULrElUHckTxJpWxHwT
         RMdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=vRnN2bu3w2ZJ13Banq4mYlhcFKZGZG+RSSq3HA+wfno=;
        b=gTG4mPAzgsQHRDiG6ieIB3zMDKFdW/llalMsuf3L8HKo5wX2qOR6gRKd1WWfZAL9Wc
         QtBP8jezysR4Ozp0ipp8zOfXi61Mi2kvApQ9truY7uGjUy4NhtzBVEh1rC91q7o7xWyu
         ycr1ZKwtUjUNSo71+QlewMQuMmn7zsJfOrwebUnvdmUGYVD/0euG6i6XNAoYjCvxBdQh
         R5TPY73wg5AkXgAekjazwJwWrlt+5LV5wXOoUKfBR3RnExf6e2V/0CHlneyTTtL8dcDZ
         ICvgKKbdr0tHRrU+YB3tFt4GUlapoTVyjBOaOFwRfwAMjnnucmpeyr8uoUFF/jZ6/Fuk
         v57w==
X-Gm-Message-State: AOAM531Kmi2RCOE5WV6V3FURho9TwdKQdqIydt+FFp0q9Og57U9sTadV
        aGZcW8AcOXNzT+mLYk5+Uh4=
X-Google-Smtp-Source: ABdhPJwJ+KOf9aFH1LqV3PlSBwvYymg8uxjX9IrW60mKBBChOxYJWyL/1fA+oHKwRNASlZtUTPmuFQ==
X-Received: by 2002:a17:902:9b94:b0:156:2c08:14a5 with SMTP id y20-20020a1709029b9400b001562c0814a5mr6213251plp.60.1650661262927;
        Fri, 22 Apr 2022 14:01:02 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id d5-20020a17090acd0500b001d5c571f487sm7233796pju.25.2022.04.22.14.01.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Apr 2022 14:01:02 -0700 (PDT)
Message-ID: <5af5d392-ffca-6612-c5a2-7042b6e01546@gmail.com>
Date:   Fri, 22 Apr 2022 14:00:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] MAINTAINERS: Broadcom internal lists aren't maintainers
Content-Language: en-US
To:     William Zhang <william.zhang@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     bcm-kernel-feedback-list@broadcom.com,
        LKML <linux-kernel@vger.kernel.org>
References: <04eb301f5b3adbefdd78e76657eff0acb3e3d87f.camel@perches.com>
 <db4b9db9-fa02-4b92-3b9a-bd866fa0e73e@gmail.com>
 <b95d9b1058eed13489adba0bccdeb600950eb153.camel@perches.com>
 <dd97ffe3-3983-fc45-469b-703900077f2f@broadcom.com>
 <feff60ee8a6d10da7d10b421d18407a5d040680e.camel@perches.com>
 <b8a5bb60-15d4-0b3b-9d96-758e5136fb46@gmail.com>
 <aa27b58d-af62-1add-1b27-1fb30ce6b8c5@broadcom.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <aa27b58d-af62-1add-1b27-1fb30ce6b8c5@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/22/22 10:42, William Zhang wrote:
> 
> 
> On 4/22/22 10:24, Florian Fainelli wrote:
>> On 4/20/22 14:31, Joe Perches wrote:
>>> On Wed, 2022-04-20 at 11:50 -0700, William Zhang wrote:
>>>>
>>>> On 4/19/22 16:11, Joe Perches wrote:
>>>>> On Tue, 2022-04-19 at 12:00 -0700, Florian Fainelli wrote:
>>>>>> On 4/12/2022 11:34 AM, Joe Perches wrote:
>>>>>>> Convert the broadcom internal list M: and L: entries to R: as
>>>>>>> exploder email addresses are neither maintainers nor mailing lists.
>>>>>>>
>>>>>>> Reorder the entries as necessary.
>>>>> []
>>>>>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>>>> []
>>>>>>> @@ -3746,7 +3746,7 @@ F:    include/linux/platform_data/b53.h
>>>>>>>     BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE
>>>>>>>     M:    Nicolas Saenz Julienne <nsaenz@kernel.org>
>>>>>>> -L:    bcm-kernel-feedback-list@broadcom.com
>>>>>>> +R:    Broadcom Kernel Team <bcm-kernel-feedback-list@broadcom.com>
>>>>>
>>>>>> There is not a "Broadcom Kernel Team", the description of R: 
>>>>>> appears to
>>>>>> require some kind of full name, hence the choice of L: instead of R:.
>>>>>
>>>>> If you don't like "Broadcom Kernel Team", perhaps
>>>>> "Broadcom Kernel Reviewers" might work for you.
>>>>>
>>>>> I think it doesn't matter much.
>>>>>
>>>> I can see that we shouldn't use M as maintainer for this Broadcom
>>>> mailing list email. But I honestly don't understand why we have to use
>>>> R. Just for the sake of full name?  Not everyone in this distribution
>>>> list is reviewer.  IMHO I would prefer to change all entries to L
>>>> without a full name.
>>>
>>> I think "R:" is a better choice than "L:"
>>>
>>> "L:" Mailing list entries have archives that are publicly searchable.
>>>
>>> Are the broadcom bcm-kernel-feedback-list entries publicly archived?
>>
>> They are not indeed.
>>
>>>
>>> If not, these are one-way entries, so someone sends and hopes only.
>>> Replies that are sent from these entries are not visible to the public.
>>
>> OK, fair enough, I will change to:
>>
>> R: Broadcom internal kernel review list 
>> <bcm-kernel-feedback-list@broadcom.com>
>>
>> If that works for everyone?
> Sounds good to me.

OK, now applied with the suggested change, thanks everyone.
-- 
Florian
