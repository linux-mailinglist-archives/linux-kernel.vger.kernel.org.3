Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E318659AF2E
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 19:33:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346491AbiHTRaI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 13:30:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231989AbiHTRaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 13:30:05 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3F6463EE;
        Sat, 20 Aug 2022 10:30:04 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id e15so10015518lfs.0;
        Sat, 20 Aug 2022 10:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=rJ0Ne9VM7WLcghppSo9UhKDb/HOu4dd15q3FDJTgM+o=;
        b=Pn1aDNuAwLvuleWSK1NadHbTPk4SyKRIQ0tLUHKqLQJvF5TRF7aBqbem765CFEm6vK
         WAiE98bNECwW1MVak3+GEOc2DJducl5Awdt1/hCVF3EdcItBQhLLWYu28CPwaVjqJZJw
         3RnYzHauYB9sfQBa89wG0JTlHDtIgkNGPKgPWtFRwRSv/QQb341GHV/4lKeHDUhAr7+e
         4iq7idl+U8ISdKDBB7hUQOoueBzpEGs1ICN3W/3EFuVfkMMdHBm5K8VLR9ss65PNaK1r
         DBURuNZFxhKC4KjQb8pR1Dri89aNXPz4odbZoAd3ILXhfr9T7idc2dHoc+N6LpNLSmZg
         0SNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=rJ0Ne9VM7WLcghppSo9UhKDb/HOu4dd15q3FDJTgM+o=;
        b=XQ6d0Awuyh9m9ue+11fdtMMdjHOIh8ecQ/o6CVmIBaVfqpsQ/5zAxpD8ZzXH87YGpw
         dNxJ8bLVSew1eRnwFZeZquYoXBqrne/3/gAIy/fpapiamY2ErRkY/6c6E3mflVYjS6hU
         HoK9S3Dg5y9mtT3N/x8SuCAU20PPsvdeHRpjPx6NiVNz42YcPVmgD2hu4ilszyArm1ji
         I/185Em7N4tWlkFj1a6E7BGfrnl6e1Yj1lpWV1AW4NfgxevOJX93E8/+a8qzj/uJfqK9
         rr8wek4ZzNo/O3WxB3N+2+vZtC4xrRNeprfbhk5/tma9Kd/ij1o2rgEIuc1lXAT9A57o
         0Oog==
X-Gm-Message-State: ACgBeo18xXrzqwyxwCggaNbA3AfGYoPjWuHsvHnww+QoWqC/uW+DK4ly
        scFRcMH8HXZ0cvqQcrO3pME=
X-Google-Smtp-Source: AA6agR6TixLXFhO1Ol9RBzDvvCgmi2VJFdL81Kr5gaQN8RqnyM/m/0o8tEiFaqDRN8JtaEwvZEkX7A==
X-Received: by 2002:a05:6512:150e:b0:492:d9fd:9bdf with SMTP id bq14-20020a056512150e00b00492d9fd9bdfmr773215lfb.583.1661016603083;
        Sat, 20 Aug 2022 10:30:03 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f3:4a00::1? (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id x21-20020a056512131500b0048af3154456sm474828lfu.146.2022.08.20.10.30.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Aug 2022 10:30:01 -0700 (PDT)
Message-ID: <01fec744-f3d4-b633-d3ce-bcd86a153132@gmail.com>
Date:   Sat, 20 Aug 2022 20:30:00 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v3 07/14] iio: ltc2688: Simplify using
 devm_regulator_*get_enable()
Content-Language: en-US
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        =?UTF-8?Q?Nuno_S=c3=a1?= <nuno.sa@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <cover.1660934107.git.mazziesaccount@gmail.com>
 <a29493f594c84b3bd852e462bbd3e591a8575a27.1660934107.git.mazziesaccount@gmail.com>
 <20220820122120.57dddcab@jic23-huawei>
 <412c5d22-d59b-9191-80dd-e3ca11360bc4@gmail.com>
 <CAHp75VdoKtc2QqFcDuJ00KBz6mjg0fnM_WhyVqhCmDVo_3K6kg@mail.gmail.com>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <CAHp75VdoKtc2QqFcDuJ00KBz6mjg0fnM_WhyVqhCmDVo_3K6kg@mail.gmail.com>
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

On 8/20/22 19:09, Andy Shevchenko wrote:
> On Sat, Aug 20, 2022 at 4:45 PM Matti Vaittinen
> <mazziesaccount@gmail.com> wrote:
>> On 8/20/22 14:21, Jonathan Cameron wrote:
>>> On Fri, 19 Aug 2022 22:19:17 +0300
>>> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> 
> ...
> 
>>>> +    static const char * const regulators[] = {"vcc", "iovcc"};
>>> trivial - slight preference for
>>>    { "vcc", "iovcc" };
>>>
>>> This isn't as important as for numeric values as we get some readability
>>> from the quotes but still nice to have.
>>
>> Right. I'll fix it.
> 
> And also make it a reversed xmas tree order.

can do.

> 
>>> For the whole static / vs non static. My personal preference is not
>>> to have the static marking but I don't care that much.
>>
>> I'd like to stick with the static here. I know this one particular array
>> does not have much of a footprint - but I'd like to encourage the habit
>> of considering the memory usage. This discussion serves as an example of
>> how unknown the impact of making const data static is. I didn't know
>> this myself until Sebastian educated me :)  Hence my strong preference
>> on keeping this 'static' as an example for others who are as ignorant as
>> I were ;) After all, having const data arrays static is quite an easy
>> way of improving things - and it really does matter when there is many
>> of arrays - or when they contain large data.
> 
> But still the same comment about global scope of the variable is applied.

I don't understand why you keep claiming the variable is global when it 
is not?

> As I explained before, hiding global variables inside a function is a
> bad code practice.

I don't really get what you mean here. And I definitely don't see any 
improvement if we would really use a global variable instead of a local one.

--Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

Discuss - Estimate - Plan - Report and finally accomplish this:
void do_work(int time) __attribute__ ((const));
