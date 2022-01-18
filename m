Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C912D49251B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 12:43:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240878AbiARLnn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 06:43:43 -0500
Received: from mout.gmx.net ([212.227.17.21]:53893 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236427AbiARLnk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 06:43:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1642506205;
        bh=OVZiZdDalsKRTw9Oarq8Z2Q9xU7mGMuBV/zpzi+L3EY=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=B+cqK2Xst/aEu85PHlKOm/GE1ByaoMeUS1bwEzxwJ/YjoMl7eBvmqreyFJRUbY2c4
         LkK/Q+eTMdQKRnZg8cZUoi28QGG/aWsgX3I5EynBA4CYuKkHxjfjLRHKhrxBkLjB+w
         Bj1q/wGDVJ9WT8RsE8QcdALcUZA6be2zeBQ+SnNE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.155.155]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mqb1c-1mW2EX25uS-00mZVq; Tue, 18
 Jan 2022 12:43:25 +0100
Message-ID: <1400f204-9dd0-585b-d58f-be98977d40b4@gmx.de>
Date:   Tue, 18 Jan 2022 12:42:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] MAINTAINERS: Add Helge as fbdev maintainer
Content-Language: en-US
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-fbdev@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Javier Martinez Canillas <javierm@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
References: <YeG8ydoJNWWkGrTb@ls3530>
 <CAKMK7uGdJckdM+fg+576iJXsqzCOUg20etPBMwRLB9U7GcG01Q@mail.gmail.com>
 <c80ed72c-2eb4-16dd-a7ad-57e9dde59ba1@gmx.de>
 <CAKMK7uHVHn9apB6YYbLSwu+adEB2Fqp4FM0z582zf4F-v3_GnQ@mail.gmail.com>
 <cf21018b-f231-7538-169e-2ad450643cbf@gmx.de>
 <97d49bca-f5f7-dba4-b62d-b6fcdd4276ac@suse.de> <87ee5659dt.fsf@intel.com>
 <4f1d6018-d74e-8e62-ea4d-0ca79c6bbbc5@gmx.de> <87a6ft5thv.fsf@intel.com>
 <5ba33e10-7d75-9f9a-dfd6-c04608d230a4@gmx.de>
 <CAKMK7uG48Due9Tv_78BJT52hvC5JcbT6-7S6_Qt7FiZ-GrTRzw@mail.gmail.com>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <CAKMK7uG48Due9Tv_78BJT52hvC5JcbT6-7S6_Qt7FiZ-GrTRzw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lDiZyS6g5iqJz/lN9mJZPXs48v72kiI5GG1vLQMF+5g7E7UcP5W
 W132AflH+PH8BskWgqJOMlJGq8JRlpP64ztE/HUnCdnutuZ5F5S4AvJM6rSm3a6CoZu3Ame
 zVfdObBXs6czmVHm07XDhq8rus84QFLaVCm/fJZDVH+IhCW3lRLj5ZWLTf0sgr3pu5e/Nh+
 vsyFO4CRqgTZpl0zYm1Zw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:3y58DFp/irM=:aIMj5d47/jhwtJ4ZreUTEN
 rGvLjc2e2YAucN5fWH5xFh9a96DIz+97wCPg0Krd1ahoKzZ7OyI/DNYdHRHLctSlM9FNXo/eg
 baeLaWlpE069ulOemkXaflxC2N0Ce6vYzIwT8fAm2LbulBLTwF7wFwhEMESxmWRQI6OrKwbS4
 c8Lef07488MLToiAg0NV+7Q/DQL8lCPxvQq7QWD8KMplQbKrtACLGUJTFtJYKmoQ3uu45GH8P
 qy9ruCVWQ91EV8kco6n72I6vW4sHwSbwUK5EYyEvrP0vxxSP5r/sBuIdn66ITnw6XvRzWAVAK
 387gOPt9MbGUCOyzmfXoRrDmBI+oXL+i/aby6ryOSgYbpFwrXwhL4ZaCc4dpvfnwOuhcNmz9J
 STk2DFYtvOmPz/gPOFlUeBPF2s9d8UzauBvzjN4makRdFDHUpEfBSbWsmQdvHpkAcHHFcFTYU
 mmJET6MML0gm7AeAUO8Z101/ZVPdjI9LH0vTZPN6EP9HYT2Jdbd1B/yq8cdIwXBMoS6mS73Vy
 +L9F7CeuQOBNXuYn4auoW/W+Z0Fw0JgWByXVtf7xnKm4oblVzD/QiPzGhc4eXfr3Q5HJvxgJN
 5YbPBj9gIRffSnaypYgYopbyL2e21ZMTtwGv+waZrr3oJkvH1YyXtbFDgLYyKtirIyz/OmZGu
 KyaJKrsMvc8Gvcs6qFPmaelnCwZtosmZjTIJHEVCm/BrBQj4MsSme6M+janml9g/BZIS6HV1i
 dQPxvksDf5hqZBjyh2WcsRAt0s3NpBw9TG9mGFXM+xA+WdVOtMQPUhgBL36mXsCpC348bJs4h
 E8XJ6qIMoR5mB740oOFK6y7D4Y2qK5S5h3EIt6iYyxOrP8nSchsrgbTCbzdBgb4OLP5Ytw10u
 Ktfddx206+9N3+CXukD4yQa5B75XzP4uR5nCOGmMr5zp/4HrHaYv45l1mB7Gt51KU8xfk9lnX
 dcOYSm3un6jqNJgXNhkSNJn6gSU0FsJfol3kp++7H0RREnoGVB4EOPvlOu7X9q5vmn8e0TDmh
 YCfQoPCOjx+lgTiYRUxmt5Qw1APwxl0+3iZyxq6sn8dwm1yy3qJcoK19l0xd8qTVqYx+/UPxX
 H2gBnUhHH/7JKA=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	On 1/18/22 12:18, Daniel Vetter wrote:
> On Tue, Jan 18, 2022 at 9:56 AM Helge Deller <deller@gmx.de> wrote:
>>
>> On 1/18/22 09:38, Jani Nikula wrote:
>>> On Mon, 17 Jan 2022, Helge Deller <deller@gmx.de> wrote:
>>>> On 1/17/22 22:40, Jani Nikula wrote:
>>>>> On Mon, 17 Jan 2022, Thomas Zimmermann <tzimmermann@suse.de> wrote:
>>>>>> Seems like few people read linux-fbdev these days.
>>>>>
>>>>> How much traffic is there to linux-fbdev that is *not* Cc'd to dri-d=
evel
>>>>> also?
>>>>
>>>> Doesn't seem like much traffic - which IMHO is OK for such a tree wit=
h
>>>> mostly just maintenance patches.
>>>>
>>>>> Do we still need a separate linux-fbdev mailing list at all?
>>>>
>>>> Yes. I want to have it seperate of dri-devel.
>>>> Actually I'd prefer to drop dri-devel from the list where patches
>>>> for fbdev are sent...
>>>
>>> Disagreed. If anything, this thread shows we can't have fbdev and drm =
in
>>> silos of their own.
>>
>> Patches to fbdev usually don't affect DRM.
>> Patches which affect DRM needs to through to dri-devel.
>> In addition this would take the burden of the dri-developers to receive
>> unrelated fbdev driver updates and patches.
>
> I added dri-devel for fbdev because stuff landed that shouldn't have.
> Let's not remove that, because the amount of patches for fbdev which
> arent relevant for drm drivers is pretty much nothing.

I'm fine with keeping both lists mentioned in the MAINTAINERS file.
It was a proposal and I understand you want to keep it. Ok for me.

> I really don't like the idea that fbdev goes off again becoming a
> silo, just because it's too hard to wire through low-bit greyscale
> support. Which no I can't type for you, because I don't have such hw
> here.
>
> Everything where people cared enough for adding fbdev compat support
> for to actually write a patch is supported.
>
> If you do want a silo  for fbdev then I think the only reasonable
> option is that we create a copy of the fbdev/fbcon code for drm
> (somewhat renamed), so that you can do the reverts without impacting
> drm drivers.

I don't see *any impact* on drm drivers at all if both patches would be
reverted now.

> But there will still be some overlap and minimal
> coordination, plus I'm not seeing anyone from the drm side
> volunteering for the sizeable amount of work.

I wonder why you don't want to give it a try?
My current proposal is to revert those two changes.
Reverting them does not affect DRM code.

Both DRM and some fbdev drivers still share excactly the same code paths i=
n the SCROLL_REDRAW case.
In addition there are some fbdev drivers which provide 2D support and inst=
ead allow SCROLL_MOVE.
That's it.

Currently I don't know which other cleanups or refactorings of fbcon are
planned from DRM side, but I'm sure there is a easy way to keep both suppo=
rted.

If it then really turns out that it's not possible we can decide then how
to continue.

Helge

> -Daniel
>
>>> Also, if the patches continue to get merged through drm-misc, they nee=
d
>>> to be sent to dri-devel.
>>
>> Helge
>
>
>

