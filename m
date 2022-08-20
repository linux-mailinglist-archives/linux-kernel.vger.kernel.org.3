Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E99EC59AD1A
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 12:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344733AbiHTKFd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 06:05:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344722AbiHTKFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 06:05:31 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 805785C9DD;
        Sat, 20 Aug 2022 03:05:30 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id n24so4491957ljc.13;
        Sat, 20 Aug 2022 03:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc;
        bh=8p9wZS7+CAEWP1ZjSQIY5E7ypxKx2jvelFx36fNvhPw=;
        b=XBgmRnDhjwqFKOpVaxIGJhGx/EUHpbk+0hwjAWJWZtpvsHDjwHe2FKxsuVuahE04U2
         JPBZdU4Z2qJHpPKqSVkQsKAPRswumsomsmCGw5hXL7AOrLNk9FcrhOfG/+WV7DN1X69V
         fc2h0u8B90SWIGeDDaT6+YOiJilOhTnWEXEFMX5cpx2s7inCVfD5j5UC3YOT+7k766xp
         kbjlk2zDCMQLnoFF3P6ENfTAtC08x1PlcZ98m016Pq6H+r/IbTLnruzNvt0Qyug6p1LQ
         5dTLlGSgyJyWpmamTxllXQ2tLGVQf9D0aMupe3NAUgYzNbjTLB6LW/ouZbq8saQrIXB8
         nizA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=8p9wZS7+CAEWP1ZjSQIY5E7ypxKx2jvelFx36fNvhPw=;
        b=EQbeMOww5A1UTC8nJKrgtVdAKOFQ5pBd+pydPcTFdCKg0Re3yG2pYVzhGcoP0dckle
         V3xDYk3278Q2TOte3gOq4cYVOGT0KEy5oRonCiWlUK1K3wUBvTpZyErqkyYI8PWaek+m
         IXIZVUBwS+gUMdEcdXnAfrLd7dY7yv/43+MnBPXDilLIQFttxvYuKbYMnbSEWRnNLYpM
         UBTN4EZ6ghUgMVWpOnfHh6mqLYVVavNk5uQlBUWF5dQkksH8qO59bKR4F4MJZIgMWf9a
         qU79JWkDfw/sur40zHwkE7N9QeyB4FHSOBvXZ8IgLob54VFHdsxuf5yaZmoR+f9y9cgC
         fGZA==
X-Gm-Message-State: ACgBeo3dQlQZwintYg+toRWoLBs63jvXENeNEOOl1O0DR/zpwZ71qWrH
        6CvCz+d5WaRlcCnEUPUrmqMqigB7+P4=
X-Google-Smtp-Source: AA6agR6sqyEXZiSXoOfk8vvxzAN7IGKUtKhOp1z901nsxN2bQaDD0nXYU2/x3j/dbeQR9Vi/g04YYg==
X-Received: by 2002:a05:651c:230c:b0:25e:7295:5cd3 with SMTP id bi12-20020a05651c230c00b0025e72955cd3mr3354390ljb.158.1660989928692;
        Sat, 20 Aug 2022 03:05:28 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f3:4a00::1? (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id a2-20020a05651c030200b002619257da21sm969899ljp.118.2022.08.20.03.05.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Aug 2022 03:05:28 -0700 (PDT)
Message-ID: <cff8d041-f3c4-3faf-85a9-acabe60d2de2@gmail.com>
Date:   Sat, 20 Aug 2022 13:05:25 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Content-Language: en-US
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Miaoqian Lin <linmq006@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Xiang wangx <wangxiang@cdjrlc.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <cover.1660934107.git.mazziesaccount@gmail.com>
 <3fd11489356b1c73a3d7b4bd9dec7e12c9fe8788.1660934107.git.mazziesaccount@gmail.com>
 <CAHp75VePr790pXZ5AiRnrPmxkOgZ3YKRTbABE6dvk+udQYrXGA@mail.gmail.com>
 <795d16f2-4dee-7492-4a87-e928020efebe@fi.rohmeurope.com>
 <CAHp75VdGhXpD8YgwkVPLCBEMmupBiTDS4FChocJFVo+BBZ-2KA@mail.gmail.com>
 <0823a6e8-b325-78c5-d060-c5f9442e3df8@fi.rohmeurope.com>
 <CAHp75VdMA5mkxkMrtiRTGn5F-5GWjxKyuD5iBuj3HKWqZZMxkg@mail.gmail.com>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH v3 08/14] iio: bmg160_core: Simplify using
 devm_regulator_*get_enable()
In-Reply-To: <CAHp75VdMA5mkxkMrtiRTGn5F-5GWjxKyuD5iBuj3HKWqZZMxkg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/20/22 10:18, Andy Shevchenko wrote:
> On Sat, Aug 20, 2022 at 9:48 AM Vaittinen, Matti
> <Matti.Vaittinen@fi.rohmeurope.com> wrote:
>> On 8/20/22 09:25, Andy Shevchenko wrote:
>>> On Sat, Aug 20, 2022 at 9:19 AM Vaittinen, Matti
>>> <Matti.Vaittinen@fi.rohmeurope.com> wrote:
>>>> On 8/20/22 02:30, Andy Shevchenko wrote:
>>>>> On Fri, Aug 19, 2022 at 10:21 PM Matti Vaittinen
>>>>> <mazziesaccount@gmail.com> wrote:
>>>
>>> What did I miss?
>>
>>   >>>>           struct bmg160_data *data;
>>   >>>>           struct iio_dev *indio_dev;
>>
>> This does already violate the rule.
> 
> Indeed, I am reading this with an MTA that has True Type fonts, and I
> can't see it at the first glance. But this breaks that rule slightly
> while your added line breaks it significantly.

Yes. As I said, I think the reverse xmas tree rule is not too well 
justified. Bunch of the subsystems do not really follow it, nor did this 
function. Yet, as I said, I can move the array to the first line in the 
function when I respin the series..

>>>>> this case you even can move it out of the function, so we will see
>>>>> clearly that this is (not a hidden) global variable.
>>>>
>>>> Here I do disagree with you. Moving the array out of the function makes
>>>> it _much_ less obvious it is not used outside this function. Reason for
>>>> making is "static const" is to allow the data be placed in read-only
>>>> area (thanks to Guenter who originally gave me this tip).

Just wanted to correct - it was Sebastian Reichel, not Guenter who 
explained me why doing local static const arrays is better than plain const.

>>>
>>> "static" in C language means two things (that's what come to my mind):
>>> - for functions this tells that a function is not used outside of the module;
>>> - for variables that it is a _global_ variable.
>>>
>>> Hiding static inside functions is not a good coding practice since it
>>> hides scope of the variable.
>>
>> For const arrays the static in function does make sense. Being able to
>> place the data in read-only areas do help with the memory on limited
>> systems.
> 
> I'm not sure we are on the same page. I do not object to the "const"
> part and we are _not_ talking about that.
> 

Maybe the explanation by Sebastian here can put us on the same page:
https://lore.kernel.org/all/20190502073539.GB7864@localhost.localdomain/
https://lore.kernel.org/all/322fa765ddd72972aba931c706657661ca685afa.camel@fi.rohmeurope.com/

>>> And if you look into the kernel code, I
>>> believe the use you are proposing is in minority.
>>
>> I don't know about the statistics. What I know is that we do have a
>> technical benefits when we use static const arrays instead of non static
>> ones in the functions. I do also believe placing the variables in blocks
>> is a good practice.
> 
> Yes, and global variables are better to be seen as global variables.
> 
>> I tend to agree with you that using local, non const statics has
>> pitfalls - but the pitfalls do not really apply with const ones. You
>> know the value and have no races. Benefit is that just by seeing that no
>> pointer is returned you can be sure that no "sane code" uses the data
>> outside the function it resides.
> 
> Putting a global variable (const or non-const) to the function will
> hide its scope and it is prone to getting two variables with the same
> or very similar names with quite different semantics.

I don't see how moving something from a local block to a global scope 
does make conflicts less of an issue? On the contrary, it makes things 
worse as then the moved variable will collide with any other variable in 
any of the functions in the whole file. Having the array as function 
local static makes the naming collisions to be issue only if another 
global variable has the same name. And if that happened - the chances 
are code would still be correct as the function here is clearly intended 
to use the local one. If someone really later adds a global with the 
same name - and uses the global in this function - then he should have 
noted we have local variable with same name. Additionally - such user 
would be using terribly bad name for a global variable.

Please note that scope of the function local static variable is limited 
to function even if the life-time is not just the life-time of a function.

> That's why it's
> really not good practice. I would rather see it outside of the
> function _esp_ because it's static const.

Sorry, I really don't agree with your reasoning here. :(


-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

Discuss - Estimate - Plan - Report and finally accomplish this:
void do_work(int time) __attribute__ ((const));
