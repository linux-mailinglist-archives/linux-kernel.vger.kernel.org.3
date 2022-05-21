Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A97852FA93
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 12:13:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233480AbiEUKN0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 06:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbiEUKNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 06:13:20 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFB0D91573;
        Sat, 21 May 2022 03:13:16 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id u15so9608678pfi.3;
        Sat, 21 May 2022 03:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Imk5U5o4qb9sYPb2hIJEDe8z3zcnedsiK3xTbIv0nfU=;
        b=FT2vm54FSlZrbqao1nMBjWXhfOd77eLy3UPGaRLiR2ILowj6K8EXbDyi6kWwXWyt97
         6PYxlHKsXU7nUy1UTwfr6ArN1nfazB8TFElN7MGqd2p1PA8sF6A0DSQkgHl5URDkxCS7
         GlazLPfDggaPVtTvmOUVevU63SyxR9lMHsU78Fp20sOerH/rREbQySWBlpvQP5xiBZMW
         mrIflN1LtUIsWzjwpo+E0PKqfaIYaQ5O2t13s7JkGbll8B0jrh/IugccISy5Hi2S9H4w
         lIX5Go7lWSp+IMeRcVb9QQ7DddHwM5DmPEJFaOq+bCHWYWdq3zwksraW3fvbdfVbZ73m
         kzbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Imk5U5o4qb9sYPb2hIJEDe8z3zcnedsiK3xTbIv0nfU=;
        b=3BPXIWqzx2WCiqMtglmjAFzq7Ukhvn9QJqgCamdP0mhFXX9zE5ipCde34Oia9qZWGP
         wBx6O1Dq1Kw6Y/sGGXTSY2lf1P80LnUb6TAUfOT/WGVVZHmgB/ipxqmF79JcX9U17RTo
         Y4Uf7lT1+LqxhAbuMas3px5uqOrpk+0LID6fCSAP2xng7/ee6YR9RVhpezyY7QTNxNmI
         ptunJhmttwFzumA8538g9sL852Q4W8LpknN/sKEr8keRn9beroXo7+/A9cN5XOLWUZ6j
         jLOLInDNrkQ4BfDDkPpIcgrrJ0Se3JePyxAJ4s5mVhBA1uw2eNm7IwuCyGNfUkdDC0GM
         ZYoQ==
X-Gm-Message-State: AOAM533PB5aNkSEsx8/VK0upcEMVb8z/yfs0DVocI8t7zjLqyavPJ8fa
        5aQkD3zAGlA1XegQ9rqNSms=
X-Google-Smtp-Source: ABdhPJyyVSDvdHIMl+TO/kI7Mu4SCG5/wcN6WFi3HbUvpHpvu5mNdQYPPPiLCbMML+0nofmv5IBa4Q==
X-Received: by 2002:a63:5a01:0:b0:3d8:22cb:9224 with SMTP id o1-20020a635a01000000b003d822cb9224mr12074800pgb.548.1653127996412;
        Sat, 21 May 2022 03:13:16 -0700 (PDT)
Received: from [192.168.2.225] (93.179.119.173.16clouds.com. [93.179.119.173])
        by smtp.gmail.com with ESMTPSA id i18-20020a170902c95200b0015e8d4eb287sm1221001pla.209.2022.05.21.03.13.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 May 2022 03:13:15 -0700 (PDT)
Message-ID: <475ccf8e-5238-6924-0a37-c45bc2c98b69@gmail.com>
Date:   Sat, 21 May 2022 18:13:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 1/2] psi: add support for multi level pressure stall
 trigger
Content-Language: en-US
To:     Chen Wandun <chenwandun@huawei.com>,
        Suren Baghdasaryan <surenb@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Alex Shi <alexs@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
References: <20220516033524.3130816-1-chenwandun@huawei.com>
 <30b37eeb-e77b-882e-fc24-3367321a8ca3@gmail.com>
 <CAJuCfpE7fBsp8ntYVeLsW7Cd0Z09OmxN75X9Az_Qco0GJrz3Wg@mail.gmail.com>
 <CAJuCfpH-BDqsft1YvGFhkbR60VC0TJgfXKRVN+80e0iqQdhxpA@mail.gmail.com>
 <3a31521f-a68a-b2a9-baae-9a458ee17033@huawei.com>
 <070fe87d-43a0-5e4f-e4c7-c44782c2c195@gmail.com>
 <CAJuCfpH1mTxe5hmzZTe+AbPFse9heenx8uhGzCXE6fAh5G8SzA@mail.gmail.com>
 <29d66a46-d141-2d02-45dd-a8931786588e@gmail.com>
 <9fc88a71-b484-c471-66cd-a4d87d8c02c4@huawei.com>
From:   Alex Shi <seakeel@gmail.com>
In-Reply-To: <9fc88a71-b484-c471-66cd-a4d87d8c02c4@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/21/22 15:23, Chen Wandun wrote:
> 
> 
> 在 2022/5/19 14:15, Alex Shi 写道:
>>
>> On 5/19/22 05:38, Suren Baghdasaryan wrote:
>>> On Wed, May 18, 2022 at 3:29 AM Alex Shi <seakeel@gmail.com> wrote:
>>>>
>>>>
>>>> On 5/17/22 20:46, Chen Wandun wrote:
>>>>>>>> This breaks the old ABI. And why you need this new function?
>>>>>>> Both great points.
>>>>>> BTW, I think the additional max_threshold parameter could be
>>>>>> implemented in a backward compatible way so that the old API is not
>>>>>> broken:
>>>>>>
>>>>>> arg_count = sscanf(buf, "some %u %u %u", &min_threshold_us,  &arg2, &arg3);
>>>>>> if (arg_count < 2) return ERR_PTR(-EINVAL);
>>>>>> if (arg_count < 3) {
>>>>>>       max_threshold_us = INT_MAX;
>>>>>>       window_us = arg2;
>>>>>> } else {
>>>>>>       max_threshold_us = arg2;
>>>>>>       window_us = arg3;
>>>>>> }
>>>>> OK
>>>>>
>>>>> Thanks.
>>>>>> But again, the motivation still needs to be explained.
>>>>> we want do different operation for different stall level,
>>>>> just as prev email explain, multi trigger is also OK in old
>>>>> ways, but it is a litter complex.
>>>> In fact, I am not keen for this solution, the older and newer
>>>> interface is easy to be confused by users, for some resolvable
>>>> unclear issues. It's not a good idea.
>>> Maybe adding the max_threshold as an optional last argument will be
>>> less confusing? Smth like this:
>>>
>>> some/full min_threshold window_size [max_threshold]
>> It's already confused enough. :)
> which point make you confused？
> Interface suggest by Suren is compatible with current version,
> I think it is more reasonable and there is no difficuty to understand it.

Your 3rd parameter has different meaning depends on the exists or non-exist
4th one. It's not a good design. 

>> BTW, I still don't see the strong reason for the pressure range.
> Considering this case:
> I divide pressure into multi levels, and each level corresponds to a
> hander,  I have to register multi triggers and wait for fire events,
> nowadays, these trigger is something like:
> echo “some 150000 1000000” > /proc/pressure/memory
> echo “some 350000 1000000” > /proc/pressure/memory
> echo “some 550000 1000000” > /proc/pressure/memory
> echo “some 750000 1000000” > /proc/pressure/memory
> 
> In the best case, stall pressure between 150000 and 350000,
> only one trigger fire, and only one wakeup.
> 
> In any other case,  multi triggers fire and multi wakeup, but it
> indeed is no need.
> 

Could you give more details info to show what detailed problem
which your propose could address, but current code cannot?


Thanks
Alex

> New implement make the fire and wakeup more precise,
> userspace code will be more simple, no confusing fire event,
> no need to filter fire event anymore, maybe minor performance
> improved.
> 
> Thanks.
>>
>>>> Also, if we do decide to add it, there should be a warning in the
>>> documentation that max_threshold usage might lead to a stall being
>>> missed completely. In your example:
>>>
>>> echo "some 150000 350000 1000000" > /proc/pressure/memory
>>>
>>> If there is a stall of more than 350ms within a given window, that
>>> trigger will not fire at all.
>> Right.
>> And what if others propose more pressure combinations?
>> Maybe leave them to user space is more likely workable?
>>
>> Thanks
>> Alex
>> .
> 
