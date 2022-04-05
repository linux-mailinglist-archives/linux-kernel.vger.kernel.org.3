Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 286C24F3672
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 16:06:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348866AbiDELDO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 07:03:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236948AbiDEIlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 04:41:23 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7E1910C3;
        Tue,  5 Apr 2022 01:34:05 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id B51DC1F43CB7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1649147644;
        bh=FfM6qVWJMyY7R/njhZEZzaji0Pbb6if6CpJrRG+y4tY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=YHzcynJzHNv1ejqF9EDwKXfHOAsAK8d4sL0p/FIIEhf5MhgMQG7gROQWNmcnhURn3
         4Iv6ddyQ0JGV1wxLPWD8T29YwteiR39YbYCrFa6GrCgJVNYqJkFNFRmZdGwTEl1VtB
         O+GATJBYNlp7P5Uv0iXgh20/97cWogHXli77Xsvwu4HNvWRrlaKP/aKIG35I3/ogxP
         isU8cRLX2nQs72hWXm7JD44utGObp9Nzqt/dL90+wVtjC6B530Weft+lNbDC9FKkYd
         ojzUKoOu4haaUAEEJcRnol/d5RoKAsEziW01mYYgiUOvSSKb9xyxTLwbAeZAk0D9Ap
         fdBNBSgHUKWaw==
Message-ID: <bd5ad2d7-54f1-b0d5-9dad-9b7ba64d5017@collabora.com>
Date:   Tue, 5 Apr 2022 10:34:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 2/2] dt-bindings: mfd: syscon: Add support for regmap
 fast-io
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>
Cc:     lee.jones@linaro.org, robh+dt@kernel.org, krzk+dt@kernel.org,
        arnd@arndb.de, matthias.bgg@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
References: <20220401135048.23245-1-angelogioacchino.delregno@collabora.com>
 <20220401135048.23245-3-angelogioacchino.delregno@collabora.com>
 <8588a941-6d3e-9e14-cb21-d7af29b4b2bd@linaro.org>
 <7775eb70-692f-3f1b-f226-f7e0fad47e37@collabora.com>
 <26af9701-267d-5a23-8688-24608617d3f6@linaro.org>
 <af2b304a-a407-3fc6-dfc6-edc85ce1caea@collabora.com>
 <20220404222659.yn2wrda5xtbmvul7@notapiano>
 <df2fc253-b16a-3d93-7682-513abdf967d5@linaro.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <df2fc253-b16a-3d93-7682-513abdf967d5@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 05/04/22 08:48, Krzysztof Kozlowski ha scritto:
> On 05/04/2022 00:26, Nícolas F. R. A. Prado wrote:
>> On Mon, Apr 04, 2022 at 11:39:49AM +0200, AngeloGioacchino Del Regno wrote:
>>> Il 04/04/22 10:55, Krzysztof Kozlowski ha scritto:
>>>> On 04/04/2022 10:40, AngeloGioacchino Del Regno wrote:
>>>>> Il 02/04/22 13:38, Krzysztof Kozlowski ha scritto:
>>>>>> On 01/04/2022 15:50, AngeloGioacchino Del Regno wrote:
>>>>>>> The syscon driver now enables the .fast_io regmap configuration when
>>>>>>> the 'fast-io' property is found in a syscon node.
>>>>>>>
>>>>>>> Keeping in mind that, in regmap, fast_io is checked only if we are
>>>>>>> not using hardware spinlocks, allow the fast-io property only if
>>>>>>> there is no hwlocks reference (and vice-versa).
>>>>>>
>>>>>> I have doubts you need a property for this. "fast" is subjective in
>>>>>> terms of hardware, so this looks more like a software property, not
>>>>>> hardware.
>>>>>>
>>>>>> I think most of MMIOs inside a SoC are considered fast. Usually also the
>>>>>> syscon/regmap consumer knows which regmap it gets, so knows that it is
>>>>>> fast or not.
>>>>>>
>>>>>
>>>>> Hello Krzysztof,
>>>>>
>>>>> well yes, this property is changing how software behaves - specifically,
>>>>> as you've correctly understood, what regmap does.
>>>>>
>>>>> It's true that most of MMIOs inside a SoC are considered fast.. the word "most" is
>>>>> the exact reason why I haven't proposed simply hardcoding '.fast_io = true' in
>>>>> syscon, or in regmap-mmio...
>>>>> There are too many different SoCs around, and I didn't want to end up breaking
>>>>> anything (even if it should be unlikely, since MMIO is fast by principle).
>>
>> Hi Angelo,
>>
>> I think I can see what Krzysztof means by saying this looks more like a software
>> property.
>>
>> This property isn't simply saying whether the hardware is fast or not by itself,
>> since that's relative. Rather, it means that this hardware is fast relative to
>> the time overhead of using a mutex for locking in regmap. Since this is a
>> software construct, the property as a whole is software-dependent. If for some
>> reason the locking in regmap were to be changed and was now a lot faster or
>> slower, the same hardware could now be considered "fast" or "slow". This seems
>> to me a good reason to avoid making "fastness" part of the ABI for each
>> hardware.
> 
> Thanks, that very good explanation!
> 

Okay now that's clearing up my mind, makes me see the issue that was raised in
a different perspective. I've finally got it, and Krzysztof is definitely right
about that, as in the proposed solution raises potential future issues and
definitely cannot be considered for merging.

I should've sent this as a RFC instead; this topic is becoming larger than I
could foresee in the short term.

Thanks Krzysztof for raising this flag, and thank you Nic for finding a way to
wake up the hamster in my brain :-P

>>
>>>>
>>>> What I am proposing, is the regmap consumer knows whether access is fast
>>>> or not, so it could call get_regmap() or
>>>> syscon_regmap_lookup_by_phandle() with appropriate argument.
>>>>
>>>> Even if we stay with a DT property, I am not sure if this is an
>>>> attribute of syscon but rather of a bus.
>>>>
>>>> Best regards,
>>>> Krzysztof
>>>
>>> I'm sorry for sending a v2 so fast - apparently, I initially didn't fully
>>> understand your comment, but now it's clear.
>>>
>>> Actually, since locking in regmap's configuration does not use DT at all
>>> in any generic case, maybe bringing this change purely in code may be a
>>> good one... and I have evaluated that before proposing this kind of change.
>>>
>>> My concerns about that kind of approach are:
>>> - First of all, there are * a lot * of drivers, in various subsystems, that
>>>    are using syscon, so changing some function parameter in syscon.c would
>>>    result in a commit that would be touching hundreds of them... and some of
>>>    them would be incorrect, as the default would be no fast-io, while they
>>>    should indeed enable that. Of course this would have to be changed later
>>>    by the respective driver maintainer(s), potentially creating a lot of
>>>    commit noise with lots of Fixes tags, which I am trying to avoid;
>>> - Not all drivers are using the same syscon exported function to get a
>>>    handle to regmap and we're looking at 6 of them; changing only one of
>>>    the six would be rather confusing, and most probably logically incorrect
>>>    as well...
>>>
>>> Of course you know, but for the sake of making this easily understandable
>>> for any casual developers reading this, functions are:
>>> - device_node_to_regmap()
>>> - syscon_node_to_regmap()
>>> - syscon_regmap_lookup_by_compatible()
>>> - syscon_regmap_lookup_by_phandle()
>>> - syscon_regmap_lookup_by_phandle_args()
>>> - syscon_regmap_lookup_by_phandle_optional().
>>
>> What if a separate function was added with the additional regmap configuration
>> argument? That way setting the "fast_io" would be opt-in much like a DT property
>> would. The other drivers wouldn't need to be changed.
> 
> Exactly, there is no need to change all callers now.
> 1. You just add rename existing code and add argument:
> 
>    syscon_regmap_lookup_by_compatible_mmio(...., unsigned long flags);
> 
> 2. Add a wrappers (with old names):
> syscon_regmap_lookup_by_compatible() {
>    syscon_regmap_lookup_by_compatible_mmio(..., SYSCON_IO_DEFAULT);
> }
> 
> 3. and finally slowly convert the users where it is relevant.
> 
> Just one more thing. I was rather thinking out loud, instead of
> proposing a proper solution about clients defining speed. I am still not
> sure if this is correct approach, because actually the regmap provider
> knows the best whether it is slow or fast. Clients within SoC should
> know it, but what if one client asks for fast regmap, other for slow? Or
> not every client is updated to new API?

I didn't consider that kind of solution (adding yet one more function just for
the fast_io case, or wrapping the current ones) exactly because of the reasons
that you just explained...

...if we do that, we're going to also see issues like:
- Client #1 calls syscon fast-io, Client #2 is not converted
- Client #1 is expected to probe earlier than Client #2
- Probe order changes
- Now Client #1 also isn't fast-io

...unless reinitializing regmap mmio (regmap_init_mmio), but this would obviously
be a no-go, because races are under the *nearest* corner at that point. So.. no.

> 
> Another solution would be to add such property to the bus on which the
> syscon device is sitting. Although this is also not complete. Imagine:
> 
> syscon <--ahb-fast-bus--> some bus bridge <--apb-slow-bus--> syscon consumer
> 
> Although your original case also would not be accurate here.

...but then that would still be a software construct and we'd be talking about
the same thing again, just in a different context.

I've also been thinking of adding a way to change the regmap locking on-the-fly
without having to re-init fully, but that also looks like being a no-go, as I
can foresee racing with that solution as well.

By the way, Let me give you some full-er context here, so that you can fully
understand, without any doubt, what I'm trying to do...

Here, on MediaTek SoCs, the HW ABI is in "full IP blocks" (warning: this "term"
may be wrong, but bear with me), for which we see each MMIO range having clocks,
resets, and other IP-specific registers, and sometimes these are "mixed" together.
There's no way to declare a small MMIO sub-range for just clocks, hence syscon is
really the only (relatively?) clean solution that can be used.

Thing is, MTK platforms are continuously locking/unlocking mutexes for simple and
fast operations, even "turning on/off" a clock (actually, due to the nature of the
clock tree for these SoCs, it's always more than one clock at once, so it's always
more than one mutex lock/unlock...), or operating on XHCI registers, etc etc etc.
This gives *a lot* of overhead and you can really experience the stutter sometimes,
and I mean experience with your own eyes, even on more performant chips...

I then checked some other non-MTK platforms, and I saw that it's not really just a
MTK thing (even though it's the heaviest user of syscon between the ones that I
checked)... so I saw a nice improvement pointer for lots of platforms... and I'm
sure that you immediately got that part.

I'm starting to get confused about what could be a good and acceptable solution
here, because at this point there are a lot of blockers around for any different
thing I can think of.

Regards,
Angelo
