Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0098E57C7C0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 11:34:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbiGUJep (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 05:34:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbiGUJel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 05:34:41 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABC6A80F5E
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 02:34:39 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id u5so1423097wrm.4
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 02:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=unWbRFoR3EWjx503YNCQWVVDbXiFcIIrT7ES1XYXEvk=;
        b=naK8qn8yhOlTNbXt70DVBxwtB+uDQQDfgDCfkkSzjEd5zE1VMdDkaQZ0s+vE3n0umt
         EiS/3H87o/fv/nQy2hEkkkhe6Cklt9VDsYcEgPEvIg1PM7OR1nW5FK1b9XOi0Tro7mg5
         T+FbB7CeiR9Z0jIjUsMdxbfn/03kQ5O9jr8K3Iil7fmAb6KrPyqygKMrP/R49Nro74Jw
         VUKbZ5u0NwV8t+aqVjVTcTkH9bOKnmZI0OKR9B+MVNg07SyA8p3MPaD75A9DPTpyOZDm
         Eo9OP8M9ZpC4qhJWsQNRRLHmZRMqQfXEDe1xX4IguNddbXgGMbOvWfLOgS9vtalPPCCr
         tiKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=unWbRFoR3EWjx503YNCQWVVDbXiFcIIrT7ES1XYXEvk=;
        b=wESj4iJSf6sS0W2EqLMWcSl0dUxqpRz+afDsur7OYZXkzpSrJu2nS6KsCqqpP9V39q
         wUhTiL2kRniNAo8aHUGtZaG7V+O+mSsForC7wRwJ5koO6OyzFR2NI9rjx98Q4ZwznLvM
         F8iIJislH1LXnBurP/kTnjJMH4pLqK7abqZbBVQ0ntd1dJrW01i6vngL9ALBRE1P79eu
         jqvv49qoFAQ6ZzWY9wZn+Xqxojy0hNeWAzbpKYji9J9UilGmoGQ6Vfnj7+Lu7HsFC5si
         lJSUbJfXkUHgz3EMWAJXhslnA3pHa0YZIrU2ZNiFFyskp5kDXTQuUpa+lGVRakuU0Cos
         BGDA==
X-Gm-Message-State: AJIora+/YNRWmhrzhk6c+9YsZp6TcHBIS7HG6XgGH7AJpZcZmHC8ds7R
        Ahw/g7EKoSvUg4cTgMCTCBmx1w==
X-Google-Smtp-Source: AGRyM1s5c8E24mC8pzAEEx0B61tkzVr/JMheXMv8e5DemwcIXXe5h5hAOsgXpaN4oJ9AQ/T8sEERGQ==
X-Received: by 2002:a05:6000:1f82:b0:21e:3cac:6f38 with SMTP id bw2-20020a0560001f8200b0021e3cac6f38mr9161863wrb.322.1658396078134;
        Thu, 21 Jul 2022 02:34:38 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:5c9a:ee80:52f5:6a1? ([2a05:6e02:1041:c10:5c9a:ee80:52f5:6a1])
        by smtp.googlemail.com with ESMTPSA id d12-20020adffbcc000000b0021b8c554196sm1366579wrs.29.2022.07.21.02.34.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jul 2022 02:34:37 -0700 (PDT)
Message-ID: <f0c217a2-7df0-c8ed-d2ae-c6019c7600d8@linaro.org>
Date:   Thu, 21 Jul 2022 11:34:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3 3/4] thermal/core: Build ascending ordered indexes for
 the trip points
Content-Language: en-US
To:     Zhang Rui <rui.zhang@intel.com>, rafael@kernel.org
Cc:     quic_manafm@quicinc.com, amitk@kernel.org, lukasz.luba@arm.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220715210911.714479-1-daniel.lezcano@linaro.org>
 <20220715210911.714479-3-daniel.lezcano@linaro.org>
 <6d08939a167870ff7c1c83bb254fda5939f1d648.camel@intel.com>
 <04bd27a8-5148-c8eb-5687-83ef511618df@linaro.org>
 <7ee301b76beb679f89e946dfb5921a2d853bd8dc.camel@intel.com>
 <c0d3e523-d75a-d837-313f-bf46f3fab3b4@linaro.org>
 <e3bfb483aa6ce09756b38b3a568fac819b154beb.camel@intel.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <e3bfb483aa6ce09756b38b3a568fac819b154beb.camel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/07/2022 16:17, Zhang Rui wrote:
> On Tue, 2022-07-19 at 09:22 +0200, Daniel Lezcano wrote:
>> On 19/07/2022 03:14, Zhang Rui wrote:
>>> On Mon, 2022-07-18 at 15:21 +0200, Daniel Lezcano wrote:
>>>>
>>>> Hi Zhang,
>>>>
>>>> thanks for the review
>>>>
>>>> On 18/07/2022 07:28, Zhang Rui wrote:
>>>>> On Fri, 2022-07-15 at 23:09 +0200, Daniel Lezcano wrote:
>>>>
>>>> [ ... ]
>>>>
>>>>>> Instead of taking the risk of breaking the existing
>>>>>> platforms,
>>>>>> use an
>>>>>> array of temperature ordered trip identifiers and make it
>>>>>> available
>>>>>> for the code needing to browse the trip points in an ordered
>>>>>> way.
>>>>>>
>>>>>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>>>>>> ---
>>>>
>>>> [ ... ]
>>>>
>>>>>> +static void sort_trips_indexes(struct thermal_zone_device
>>>>>> *tz)
>>>>>> +{
>>>>>> +       int i, j;
>>>>>> +
>>>>>> +       for (i = 0; i < tz->trips; i++)
>>>>>> +               tz->trips_indexes[i] = i;
>>>>>> +
>>>>>> +       for (i = 0; i < tz->trips; i++) {
>>>>>> +               for (j = i + 1; j < tz->trips; j++) {
>>>>>> +                       int t1, t2;
>>>>>> +
>>>>>> +                       tz->ops->get_trip_temp(tz, tz-
>>>>>>> trips_indexes[i], &t1);
>>>>>
>>>>> This line can be moved to the upper loop.
>>>>
>>>> Right, thanks!
>>>>
>>>>>> +                       tz->ops->get_trip_temp(tz, tz-
>>>>>>> trips_indexes[j], &t2);
>>>>>> +
>>>>>
>>>>> what about the disabled trip points?
>>>>>
>>>>> we should ignore those trip points and check the return value
>>>>> to
>>>>> make
>>>>> sure we're comparing the valid trip_temp values.
>>>>
>>>> We don't have to care about, whatever the position, the
>>>> corresponding
>>>> trip id will be disabled by the trip init function before calling
>>>> this
>>>> one and ignored in the handle_thermal_trip() function
>>>
>>> hah, I missed this one and replied to your latest reply directly.
>>>
>>> The thing I'm concerning is that if we don't check the return
>>> value,
>>> for a disabled trip point, the trip_temp (t1/t2) returned is some
>>> random value, it all depends on the previous value set by last
>>> successful .get_trip_temp(), and this may screw up the sorting.
>>
>> The indexes array is the same size as the trip array, that makes the
>> code much less prone to errors.
>>
>> To have the same number of trip points, the index of the disabled
>> trip
>> must be inserted also in the array. We don't care about its position
>> in
>> the indexes array because it is discarded in the handle_trip_point()
>> function anyway. For this reason, the random temperature of the
>> disabled
>> trip point and the resulting position in the sorting is harmless.
>>
>> It is made on purpose to ignore the return value, so we have a
>> simpler code.
>>
> Let's take below case for example,
> say, we have three trip points 0, 1, 2, and trip point 1 is broken and
> disabled.
> 
> trip temp for trip point 0 is 10 and for trip point 2 is 20.
> .get_trip_temp(tz, 1, &t) fails, and t is an uninitialized random value
> 
> 
> Initial:
>     trip_indexes[0]=0,trip_indexes[1]=1,trip_indexes[2]=2
> step1:
>     i=0,j=1
>     get trip temp for trip point trip_indexes[0]=0 and trip_indexes[1]=1
>     trip point 1 returns trip temp 5, and it swaps with trip point 0
>     so
>     trip_indexes[0]=1,trip_indexes[1]=0,trip_indexes[2]=2
> step2:
>     i=0,j=2
>     get trip temp for trip point trip_indexes[0]=1 and trip_indexes[2]=2
>     trip point 1 returns trip temp 25, and it swaps with trip point 2
>     so
>     trip_indexes[0]=2,trip_indexes[1]=0,trip_indexes[2]=1
> 
> And the sorting is broken now.
> 
> please correct me if I'm missing anything.

Oh, nice! Thanks for the detailed explanation.

We can initialize t1 and t2 to INT_MAX, so if the get_trip_temp() fails, 
they will be set to the maximum temperature and it will be at the end of 
the array.

Alternatively, we check the disabled bit and set the temperature to INT_MAX.





-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
