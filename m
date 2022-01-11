Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECA1148B499
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 18:52:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242067AbiAKRwx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 12:52:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242204AbiAKRwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 12:52:46 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A034DC06175A
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 09:52:45 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id r28so6070124wrc.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 09:52:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vQV7H1k8exOsSWKyQG8KsYMhFmUsr7KfsLG2MHz/o1w=;
        b=wbT3spThsr/W+NEL008mAHAbggqQ2ihoWWllfG+L4kCSIv1OT+mxhVFT9Xu1lgvIF6
         UpY/GVGa5gFqxaEyeovNIyngExV+/NbcGXrH5BLqiiMXE0QLvtyD4SdWnwtXHCegzSsq
         aMtoWWLv7dfHVoXotfUvYpOCKR0drophadDmcpR/LhHQ04ZSnfNg6MebA4UqIMBLSXEn
         ujhyMQ36X4QmNMQr7jtmMognGzDXlVTdDelv0fL7r+UdwM2eWC16dv6D4J4ZZ3A5p8qV
         QvNP3tuBmAOqhv0zf9Te312E7+4sTXTt+cmCODhTX6Znv+U/ku+/+JpxK8KQTcmRy+fS
         rVaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vQV7H1k8exOsSWKyQG8KsYMhFmUsr7KfsLG2MHz/o1w=;
        b=wfVgWwgS3zS/z2CkFmCIf4iGEPYqM9zKhi/l/J6cRgPyCk0lvNCX8DnkoRkLd6JonR
         ydNdf3wVjNw+/0oyd4CSNi8mYeeMhO7UE2o3VOHRzfK/JDyYzT3usARXmj3NBWa5FVg6
         nIGab20zZVSeoM670Y4wZsX1G6zUzbfrbDA+WFckfF8PKrIXI3Kw4T8K93FGP21d3vwM
         J77ymVgYScO9u1j6T5xJrD3OYK/gcOz07inty9wWqWI/eLOGZxY+SexIa8+A91Ng7r5C
         fWaBdZNtoFph4IoU/Q+D8D9BlpqAW2sUlisrt7BVAfIvlh6fAQffpnZ8gcMIQl7LL72i
         muBw==
X-Gm-Message-State: AOAM5327LH7bs5WTdtDQFO3F+bmVBCJSq6M369Gl1AsDJdjDzxwi3o7p
        TYfuE27rMh+RYY6J6EscJtqw5w==
X-Google-Smtp-Source: ABdhPJy/SOq67WEpADi1gHx1k1OD5/uwhjSEt55UTwb/G6+/YUHv8px0Q2P0S9U1Q6+lJBpgMIaP5Q==
X-Received: by 2002:a5d:6d8a:: with SMTP id l10mr4845085wrs.534.1641923563972;
        Tue, 11 Jan 2022 09:52:43 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:f884:1ae9:44d3:2a67? ([2a01:e34:ed2f:f020:f884:1ae9:44d3:2a67])
        by smtp.googlemail.com with ESMTPSA id i11sm9031090wrn.59.2022.01.11.09.52.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jan 2022 09:52:14 -0800 (PST)
Subject: Re: [PATCH v5 2/6] powercap/drivers/dtpm: Add hierarchy creation
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     rjw@rjwysocki.net, lukasz.luba@arm.com, robh@kernel.org,
        heiko@sntech.de, arnd@linaro.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>
References: <20211218130014.4037640-1-daniel.lezcano@linaro.org>
 <20211218130014.4037640-3-daniel.lezcano@linaro.org>
 <CAPDyKFrLTsUxG8JHdK33h2BT8pxeHk6kiU-4uGrvxUhcQKg3Sw@mail.gmail.com>
 <8fcc0ef8-b0c7-da73-434f-31c88896aed5@linaro.org>
 <CAPDyKFqzxnfh0kow5mzoApFMQpKOAv=e1b7Cy9H-iEh99Wmagw@mail.gmail.com>
 <cbc70ea7-39b4-b5e8-b5c0-45fb436f53eb@linaro.org>
 <CAPDyKFoFpEjakaeb1JvYg47qoagGnzwyh2T1SpHQiwB3sFgkoA@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <aad4eb52-67b0-a486-53c6-755de3dee6be@linaro.org>
Date:   Tue, 11 Jan 2022 18:52:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAPDyKFoFpEjakaeb1JvYg47qoagGnzwyh2T1SpHQiwB3sFgkoA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/01/2022 09:28, Ulf Hansson wrote:
> On Mon, 10 Jan 2022 at 16:55, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>>
>> On 07/01/2022 16:54, Ulf Hansson wrote:
>>> [...]
>>>
>>>>>> +static int dtpm_for_each_child(const struct dtpm_node *hierarchy,
>>>>>> +                              const struct dtpm_node *it, struct dtpm *parent)
>>>>>> +{
>>>>>> +       struct dtpm *dtpm;
>>>>>> +       int i, ret;
>>>>>> +
>>>>>> +       for (i = 0; hierarchy[i].name; i++) {
>>>>>> +
>>>>>> +               if (hierarchy[i].parent != it)
>>>>>> +                       continue;
>>>>>> +
>>>>>> +               dtpm = dtpm_node_callback[hierarchy[i].type](&hierarchy[i], parent);
>>>>>> +               if (!dtpm || IS_ERR(dtpm))
>>>>>> +                       continue;
>>>>>> +
>>>>>> +               ret = dtpm_for_each_child(hierarchy, &hierarchy[i], dtpm);
>>>>>
>>>>> Why do you need to recursively call dtpm_for_each_child() here?
>>>>>
>>>>> Is there a restriction on how the dtpm core code manages adding
>>>>> children/parents?
>>>>
>>>> [ ... ]
>>>>
>>>> The recursive call is needed given the structure of the tree in an array
>>>> in order to connect with the parent.
>>>
>>> Right, I believe I understand what you are trying to do here, but I am
>>> not sure if this is the best approach to do this. Maybe it is.
>>>
>>> The problem is that we are also allocating memory for a dtpm and we
>>> call dtpm_register() on it in this execution path - and this memory
>>> doesn't get freed up nor unregistered, if any of the later recursive
>>> calls to dtpm_for_each_child() fails.
>>>
>>> The point is, it looks like it can get rather messy with the recursive
>>> calls to cope with the error path. Maybe it's easier to store the
>>> allocated dtpms in a list somewhere and use this to also find a
>>> reference of a parent?
>>
>> I think it is better to continue the construction with other nodes even
>> some of them failed to create, it should be a non critical issue. As an
>> analogy, if one thermal zone fails to create, the other thermal zones
>> are not removed.
> 
> Well, what if it fails because its "consumer part" is waiting for some
> resource to become available?
> 
> Maybe the devfreq driver/subsystem isn't available yet and causes
> -EPROBE_DEFER, for example. Perhaps this isn't the way the dtpm
> registration works currently, but sure it's worth considering when
> going forward, no?

It should be solved by the fact that the DTPM description is a module
and loaded after the system booted. The module loading ordering is
solved by userspace.

I agree, we could improve that but it is way too complex to be addressed
in a single series and should be part of a specific change IMO.

> In any case, papering over the error seems quite scary to me. I would
> much prefer if we instead could propagate the error code correctly to
> the caller of dtpm_create_hierarchy(), to allow it to retry if
> necessary.

It is really something we should be able to address later.

>> In addition, that should allow multiple nodes description for different
>> DT setup for the same platform. That should fix the issue pointed by Bjorn.
>>
>>> Later on, when we may decide to implement "dtpm_destroy_hierarchy()"
>>> (or whatever we would call such interface), you probably need a list
>>> of the allocated dtpms anyway, don't you think?
>>
>> No it is not necessary, the dtpms list is the dtpm tree itself and it
>> can be destroyed recursively.
> 
> I could quite figure out how that should work though, but I assume
> that is what the ->release() callback in the struct dtpm_ops is there
> to help with, in some way.
> 
> Kind regards
> Uffe
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
