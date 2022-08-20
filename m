Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64CAB59AF26
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 19:28:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346432AbiHTR1M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 13:27:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232136AbiHTR1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 13:27:09 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CB324DB3C;
        Sat, 20 Aug 2022 10:27:07 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id x10so7168227ljq.4;
        Sat, 20 Aug 2022 10:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc;
        bh=SYUrAG1aiaASvdF6qD40sLjvCWKBaaL6uJuFsQa0QUE=;
        b=B2eOAhPCO86paPUSNpZyiTZdZhh9OpxG2Ru+Q+l+kvDWYpncgOJWwUwrFhwVb5Slxf
         /xVNZ0En8cDz+cymfUD6J+jCf3wO5MTKO64QI1WQEcaPPIEvcSc9D2EQf8wqXOEjGR+8
         pmFiYWw54E7bwOAnFrsx+B0Kwk4BxdjasSp2oNKedFzKujIrQtQFxoI9j6kIEH4tRhhq
         GlW4CfjV+egVqHzgCHRg6WTLwLWxNB1Ig/r7ZJsKI1Nhy6MjjnFHyelMCrdFaRoY6XvQ
         GcgIExOZ3fSvqXYNo49cgAAX2vzoYOhSuSmiIWd5UR0HB56nuSq/n9K8XCh23AQbxE/i
         O+pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=SYUrAG1aiaASvdF6qD40sLjvCWKBaaL6uJuFsQa0QUE=;
        b=Ew6sR9kNqgbeYsgWYwiSDGBvp4LNd+z9d36IdbpI599sV+0wpAHHfCG2IDSmyv+Eei
         lPLKMOOS6+LQxSsDe3vEM3q3Il5cVq66uZj3tNHvbrLLsSZYh7wTzufLQr2kWla9IbPF
         +XHHcxf0ErT+vKjEZFOyBLqyE0hfkvObpS/SGsKDHMFqgsi/4/mEdfq3Fbq0YJz5NxFK
         jhMHwKKbWonjOoWkPiDcM0JpUxQxnUcNCNXIPJ/DF2OSt4QGPpdU8b3PoFO63RHK4vVu
         yaqlXPo3eKLjYJUZlDeJrRcUyl//OgcGnyvilSsLUF51geIGdKedgOsvlESgrhGuWHNk
         tGzg==
X-Gm-Message-State: ACgBeo0mDlZ3CIWT6YDFtxYSrwU8dkQDGCmIrLnh/E9kX7jaLeX7mI4K
        Njg0lYrM99LaA0IEn3o3kpbneXWxLMU=
X-Google-Smtp-Source: AA6agR4dNnGp3fxGPt6foxriOPNSnmVtmwWDXkgf2Ctv4vm0cSwYsKiAqym5EE831GXhnZQOcoGMGQ==
X-Received: by 2002:a05:651c:2113:b0:261:c930:b3c7 with SMTP id a19-20020a05651c211300b00261c930b3c7mr414075ljq.212.1661016425739;
        Sat, 20 Aug 2022 10:27:05 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f3:4a00::1? (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id r1-20020a2e8e21000000b00261a8e56fe4sm609701ljk.55.2022.08.20.10.27.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Aug 2022 10:27:04 -0700 (PDT)
Message-ID: <7c2651fe-4f3e-70fd-bdaa-35cb0d66a31a@gmail.com>
Date:   Sat, 20 Aug 2022 20:27:03 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Content-Language: en-US
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>,
        Jonathan Cameron <jic23@kernel.org>,
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
 <cff8d041-f3c4-3faf-85a9-acabe60d2de2@gmail.com>
 <CAHp75VcVziFMbPtKi1FgD1VR42HjeLUJ5fzxYSRqEbfSZ185oQ@mail.gmail.com>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH v3 08/14] iio: bmg160_core: Simplify using
 devm_regulator_*get_enable()
In-Reply-To: <CAHp75VcVziFMbPtKi1FgD1VR42HjeLUJ5fzxYSRqEbfSZ185oQ@mail.gmail.com>
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

On 8/20/22 19:21, Andy Shevchenko wrote:
> On Sat, Aug 20, 2022 at 1:05 PM Matti Vaittinen
> <mazziesaccount@gmail.com> wrote:
>> On 8/20/22 10:18, Andy Shevchenko wrote:
>>> On Sat, Aug 20, 2022 at 9:48 AM Vaittinen, Matti
>>> <Matti.Vaittinen@fi.rohmeurope.com> wrote:
>>>> On 8/20/22 09:25, Andy Shevchenko wrote:
>>>>> On Sat, Aug 20, 2022 at 9:19 AM Vaittinen, Matti
>>>>> <Matti.Vaittinen@fi.rohmeurope.com> wrote:
>>>>>> On 8/20/22 02:30, Andy Shevchenko wrote:
>>>>>>> On Fri, Aug 19, 2022 at 10:21 PM Matti Vaittinen
>>>>>>> <mazziesaccount@gmail.com> wrote:
>>>>>
>>>>> What did I miss?
>>>>
>>>>    >>>>           struct bmg160_data *data;
>>>>    >>>>           struct iio_dev *indio_dev;
>>>>
>>>> This does already violate the rule.
>>>
>>> Indeed, I am reading this with an MTA that has True Type fonts, and I
>>> can't see it at the first glance. But this breaks that rule slightly
>>> while your added line breaks it significantly.
>>
>> Yes. As I said, I think the reverse xmas tree rule is not too well
>> justified. Bunch of the subsystems do not really follow it, nor did this
>> function. Yet, as I said, I can move the array to the first line in the
>> function when I respin the series..
> 
> You still can do better in _your_ series, right?

I don't see the benefit of the reverse xmas tree. We have discussed this 
already in the past :) I definitely have no need to start using reverse 
xmas tree thingee somewhere it has not been previously used. It may be 
better in _your_ opinion.

>>>>>>> this case you even can move it out of the function, so we will see
>>>>>>> clearly that this is (not a hidden) global variable.
>>>>>>
>>>>>> Here I do disagree with you. Moving the array out of the function makes
>>>>>> it _much_ less obvious it is not used outside this function. Reason for
>>>>>> making is "static const" is to allow the data be placed in read-only
>>>>>> area (thanks to Guenter who originally gave me this tip).
>>
>> Just wanted to correct - it was Sebastian Reichel, not Guenter who
>> explained me why doing local static const arrays is better than plain const.
> 
> Did he suggest putting it inside the function?

He asked me to convert a local array to static const. I though like you 
do now that the local array should not be static but just const - and he 
corrected me in his reply. This can be seen in the discussion I linked 
below.

>>>>> "static" in C language means two things (that's what come to my mind):
>>>>> - for functions this tells that a function is not used outside of the module;
>>>>> - for variables that it is a _global_ variable.
>>>>>
>>>>> Hiding static inside functions is not a good coding practice since it
>>>>> hides scope of the variable.
>>>>
>>>> For const arrays the static in function does make sense. Being able to
>>>> place the data in read-only areas do help with the memory on limited
>>>> systems.
>>>
>>> I'm not sure we are on the same page. I do not object to the "const"
>>> part and we are _not_ talking about that.
>>
>> Maybe the explanation by Sebastian here can put us on the same page:
>> https://lore.kernel.org/all/20190502073539.GB7864@localhost.localdomain/
>> https://lore.kernel.org/all/322fa765ddd72972aba931c706657661ca685afa.camel@fi.rohmeurope.com/
> 
> Again, you are too focused on "const", I'm talking about "static". The
> above doesn't clear a bit regarding why you hide the global variable
> inside a function. I don't see either Sebastian's clear point on this.

I don't really see why you talk about "hiding a global variable in a 
function"? A static variable which is declared in function is not 
global. It is local. It causes no more name collisions than a regular 
local variable does so I really don't understand your reasoning.

>>>>> And if you look into the kernel code, I
>>>>> believe the use you are proposing is in minority.
>>>>
>>>> I don't know about the statistics. What I know is that we do have a
>>>> technical benefits when we use static const arrays instead of non static
>>>> ones in the functions. I do also believe placing the variables in blocks
>>>> is a good practice.
>>>
>>> Yes, and global variables are better to be seen as global variables.
>>>
>>>> I tend to agree with you that using local, non const statics has
>>>> pitfalls - but the pitfalls do not really apply with const ones. You
>>>> know the value and have no races. Benefit is that just by seeing that no
>>>> pointer is returned you can be sure that no "sane code" uses the data
>>>> outside the function it resides.
>>>
>>> Putting a global variable (const or non-const) to the function will
>>> hide its scope and it is prone to getting two variables with the same
>>> or very similar names with quite different semantics.
>>
>> I don't see how moving something from a local block to a global scope
>> does make conflicts less of an issue?
> 
> You may add a static variable inside each function in the same module
> and name it "foo" and there will be no conflict, but when you read the
> code your brain will be spoiled.

And how is it different from reading functions where the regular 
variables have identical names? I _really_ can't follow your reasoning.

> This is simply _bad code practice_. I
> don't know how else I can explain this to you.
> 
>> On the contrary, it makes things
>> worse as then the moved variable will collide with any other variable in
>> any of the functions in the whole file. Having the array as function
>> local static makes the naming collisions to be issue only if another
>> global variable has the same name.
> 
> Again, you missed my point. I'm talking about reading and analysing
> the code.

I _definitely_ miss your point here. I have zero problems reading code 
where static const variables are used in a function. I think it is 
pretty much as hard as seeing a #defined value - difference being that 
one can point to the variable.

I admit that static variables whose value is changed can be more of a 
problem especially when access to function is not serialized.

> Otherwise (good) compiler should spill a lot of warnings in
> case you have global vs. local naming collision.
> 
>> And if that happened - the chances
>> are code would still be correct as the function here is clearly intended
>> to use the local one. If someone really later adds a global with the
>> same name - and uses the global in this function - then he should have
>> noted we have local variable with same name. Additionally - such user
>> would be using terribly bad name for a global variable.
>>
>> Please note that scope of the function local static variable is limited
>> to function even if the life-time is not just the life-time of a function.
> 
> Nope. The RO section might be very well flashed into ROM, so...

...so?

>>> That's why it's
>>> really not good practice. I would rather see it outside of the
>>> function _esp_ because it's static const.
>>
>> Sorry, I really don't agree with your reasoning here. :(
> 
> So, whom should we listen to here? Because bad code is bad code. And
> this is code above.

Bad is a subjective concept. I'd say the code gets much worse if we make 
the local variable a global one.

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~
