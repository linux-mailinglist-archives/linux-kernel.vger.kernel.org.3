Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BF5D57D5B8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 23:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233750AbiGUVPx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 17:15:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233715AbiGUVPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 17:15:47 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93C537AB26
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 14:15:44 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id m17so3715315wrw.7
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 14:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=m54m8RvCBR4RCXtWNJLvyhQZ9BUR5VwWc91iZkG86iE=;
        b=QKQR5PITqjmTAqTKB9QrLnV4VVpMdG9y36Ycd+3YuwMMf53Oro7gKUeB9aoYJUNKek
         lc9UM32yp9ola5W4/pee09HnqisPgz/UiJl45aqnvuk0FBmcoeOWK9ccicqWBlXvol+k
         Ux3y3D4kFYQ9yMFfVzJCw9gLepw1PeYaiajWzfOKjchCHS9BV0If4r7W0gBaDwx9LRAv
         TKKqnp+uOPmA3Uxyga/VReVNVs0lbZyzDadk9tUghu1LUTu6bediXwEu4vHxYge3VdFz
         xGFp5ZOCY8VRaeITY1AW2Uktmdy66Hhfq5zzhT7MD8KBep8L2Z7TMjV2GALB53qg3cyg
         LZ+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=m54m8RvCBR4RCXtWNJLvyhQZ9BUR5VwWc91iZkG86iE=;
        b=OI/VRCRytCzYJn8s5rAWkeL1n71pawBasWHO7fcakjqXYLrRvOKbbEll29sHIDGSHe
         nqp+qHbv4Bamb17lwial0Pqcfy4NAD/BUwlwDpqvtCQCPZIhKIz/sRkULZz3xIPz02ca
         o6fX5uymCgbtq+4j4bQSXaiG4V4BAGWl9rSm6YtH5Iw0+LwJrtmfuLQTk2Fbo1fz4rnm
         89TiiEqKATY0/aX3MJYicK/6s7gUa4QuMcUpW1E8uRXwr/M8MnEjQzzLvx4KvAM7cjtJ
         gZXBnNmK3IPpRxGxm1ahzOpglnOZPLoA9Ca6/eCiHd3UdmYal1vJvZJ7wXq91A1ia5DZ
         WvKg==
X-Gm-Message-State: AJIora+UAqbsK83daV9B+2ktUOPXB1aVVGexlXYb/iNFjxZL5NSM0ZOw
        K8tsJZv2cN5N0tt1zo40PMyhXw==
X-Google-Smtp-Source: AGRyM1s0MqeGuVbt/htW3z0bW573BI7drNH1xOeMGavak4g7Dza/P833xOdWRBUYAAUG3MaAu3cjyQ==
X-Received: by 2002:adf:eb88:0:b0:21e:488a:5c81 with SMTP id t8-20020adfeb88000000b0021e488a5c81mr223075wrn.437.1658438142648;
        Thu, 21 Jul 2022 14:15:42 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:a2a9:428c:224b:c919? ([2a05:6e02:1041:c10:a2a9:428c:224b:c919])
        by smtp.googlemail.com with ESMTPSA id r67-20020a1c2b46000000b003a308e9a192sm6784124wmr.30.2022.07.21.14.15.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jul 2022 14:15:42 -0700 (PDT)
Message-ID: <8926eed7-436f-5f1a-7036-0e1520bd3a0b@linaro.org>
Date:   Thu, 21 Jul 2022 23:15:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v4 3/4] thermal/core: Build ascending ordered indexes for
 the trip points
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        Amit Kucheria <amitk@kernel.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20220718145038.1114379-1-daniel.lezcano@linaro.org>
 <20220718145038.1114379-3-daniel.lezcano@linaro.org>
 <CAJZ5v0hj0kMRNBqO_0SqsAAY8Rb8h2NrWOYogDLgGZnCtiTEwg@mail.gmail.com>
 <117c778a-4496-4d49-e73d-06fa3efa4d09@linaro.org>
 <CAJZ5v0gjfeyiS8rUoPpa3sMrofw1ZyQe=+P6pvPbeirs07F+Qw@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAJZ5v0gjfeyiS8rUoPpa3sMrofw1ZyQe=+P6pvPbeirs07F+Qw@mail.gmail.com>
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

On 21/07/2022 13:25, Rafael J. Wysocki wrote:
> On Thu, Jul 21, 2022 at 12:59 PM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>>
>> On 19/07/2022 20:56, Rafael J. Wysocki wrote:
>>> On Mon, Jul 18, 2022 at 4:50 PM Daniel Lezcano
>>> <daniel.lezcano@linaro.org> wrote:
>>>>
>>>> By convention the trips points are declared in the ascending
>>>> temperature order. However, no specification for the device tree, ACPI
>>>> or documentation tells the trip points must be ordered this way.
>>>>
>>>> In the other hand, we need those to be ordered to browse them at the
>>>
>>> s/In/On/
>>>
>>>> thermal events.
>>>
>>> What if they are all inspected every time?
>>
>> My bad, my sentence is confusing. The trip point are browsed every time
>> and we need to have them ordered to detect correctly the thermal events.
> 
> I see.
> 
> So this mostly is a preparation for patch 4, isn't it?

Yes, it is correct

>>>> But if we assume they are ordered and change the code
>>>> based on this assumption, any platform with shuffled trip points
>>>> description will be broken (if they exist).
>>>>
>>>> Instead of taking the risk of breaking the existing platforms, use an
>>>> array of temperature ordered trip identifiers and make it available
>>>> for the code needing to browse the trip points in an ordered way.
>>>
>>> Well, having ops->get_trip_temp() suggests that the trip temperatures
>>> can be dynamic.  Is the ordering guaranteed to be preserved in that
>>> case?
>>
>> The number of trips can not be changed. It is fixed when the thermal
>> zone is created AFAICT.
> 
> The current code appears to assume that and I think that this is a
> reasonable expectation.
> 
>> The get_trip_temp() is just a way to let the
>> different driver declare their own trip structure which is actually
>> something I'm trying to fix by moving the structure thermal_trip inside
>> the thermal zone. But that is a longer and separate work.
> 
> Well, I'm not sure.
> 
> Trip point temperatures can be set via trip_point_temp_store() at
> least in principle.  How is it guaranteed that this won't affect the
> ordering?

Right, that is a good point. I don't see a logical use case where a trip 
point will be set below or above the previous or the next one, so the 
order should be kept. However, strictly speaking, nothing prevents that 
so I guess we need to reorder the trips when one is changed. It should 
be a one line call.


>>> Anyway, if they need to be sorted, why don't we just sort them
>>> properly instead of adding this extra array?
>>
>> We can not because ATM the trip points array is private to the different
>> sensors.
> 
> Well, the core could create an array or list of trip points for the
> thermal zone during registration and populate it from the
> driver-provided data.  Then, it could be sorted at the creation time.


There won't be any benefit ATM. The get_trip_temp/type/hyst ops are 
called all over the place. If we create a second sorted trip point array 
and use it in the core code, then all those ops should be replaced to 
use the sorted array instead of addressing the private trip structure. A 
big deal in terms of changes.

If we don't do the ops changes, then it is simpler to have an array of 
index->trip id and the impact is small.

But I agree we should have a sorted trip array per thermal zone and stop 
using the ops->get_trip_temp|type|hyst. That is part of the work I'm 
doing in parallel to cleanup the thermal-of and I've the plan to migrate 
all the sensors to use the struct thermal_trip instead of private data. 
 From there we will be able to get rid of the get_trip[*] and the sorted 
trip indexes array.

All these changes are not feasible in the short term. I would like to 
keep the indexes trip array approach to fix the trip cross events which 
is broken right now and then go forward with the struct thermal_trip 
changes and the thermal-of cleanups I've sent last week.

Does it sound reasonable ?


> However, the above question needs to be addressed first.


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
