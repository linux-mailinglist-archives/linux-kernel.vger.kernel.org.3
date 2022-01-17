Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8548649117E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 22:57:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243410AbiAQV4C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 16:56:02 -0500
Received: from mail-io1-f51.google.com ([209.85.166.51]:45849 "EHLO
        mail-io1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231401AbiAQVzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 16:55:53 -0500
Received: by mail-io1-f51.google.com with SMTP id s11so15153112ioe.12;
        Mon, 17 Jan 2022 13:55:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iq6XuonlfOcKR4C7CyNJxsO+5s/Hfb7aV3tDFA0gEZI=;
        b=QFKnHq8U87cAj0Ze3W6PCEOe8eCb7In4/Qb14+v3Lb0ayakzL+ZM0kcQHp0ypyDVHE
         gKjki8RLuropeK0L5AO9SB6MXDfW9pPEM1wEM2HjfW6ERqHoSl/agt0xEJv8AH4uTaf3
         Td2PCxdYU6u48sxP+WqaOke2qJiBZRLj5nTpaLRvB/n7EwV+ViJud/q7yJz3bH3UxdTm
         29Ot/0Abd3Bc621YGBzg9U78LHvBR1uHFmJ4p/VGykls3khfRskYuSL8Is66HQavleXs
         dxa6SF2z1L9Gen9WTMZkBTN+l26lfh82x2PRJ8Z+NDQO9l5KicxV6wEAwv8YN7PiDhoI
         hNnQ==
X-Gm-Message-State: AOAM533i2uZ/A5oaI0Zupo5BT9GMIpiZ3ZPlA/t01yD3vO+Rnr3Z8hNx
        oVacECmjndxf04Xh+7cCVhLQ8yAj1+TDT0ikP8Y=
X-Google-Smtp-Source: ABdhPJxxA9k4MZckhnsZSeaXrceoVg6qNVBBjDPdSuqgeM5leXyBs8XmXDdISpGBE5qYe2hXdGaekksgj3MT3OVtZY0=
X-Received: by 2002:a05:6638:c1:: with SMTP id w1mr4478075jao.113.1642456552694;
 Mon, 17 Jan 2022 13:55:52 -0800 (PST)
MIME-Version: 1.0
References: <YeG8ydoJNWWkGrTb@ls3530> <CAKMK7uGdJckdM+fg+576iJXsqzCOUg20etPBMwRLB9U7GcG01Q@mail.gmail.com>
 <c80ed72c-2eb4-16dd-a7ad-57e9dde59ba1@gmx.de> <CAKMK7uHVHn9apB6YYbLSwu+adEB2Fqp4FM0z582zf4F-v3_GnQ@mail.gmail.com>
 <cf21018b-f231-7538-169e-2ad450643cbf@gmx.de> <97d49bca-f5f7-dba4-b62d-b6fcdd4276ac@suse.de>
 <e19563aa-21a3-e13c-4143-847bd77a38c7@gmx.de> <e4242fe9-13b1-91b5-d254-992f48115589@gmx.de>
In-Reply-To: <e4242fe9-13b1-91b5-d254-992f48115589@gmx.de>
From:   Ilia Mirkin <imirkin@alum.mit.edu>
Date:   Mon, 17 Jan 2022 16:55:41 -0500
Message-ID: <CAKb7UvgXaeX7FRUK_Q35N=2zBms8WgCe=ZBKr3dHrixoJWtvqw@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Add Helge as fbdev maintainer
To:     Helge Deller <deller@gmx.de>
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-fbdev <linux-fbdev@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 17, 2022 at 2:47 PM Helge Deller <deller@gmx.de> wrote:
>
> On 1/17/22 17:21, Helge Deller wrote:
> > On 1/17/22 16:58, Thomas Zimmermann wrote:
> >> Hi
> >>
> >> Am 17.01.22 um 16:42 schrieb Helge Deller:
> >>> [...]
> >>>>> c) reintroduce the state where fbcon is fast on fbdev. This is important for non-DRM machines,
> >>>>>     either when run on native hardware or in an emulator.
> >>>>> d) not break DRM development
> >>>>>
> >>>>> Especially regarding c) I complained in [1] and got no feedback. I really would like to
> >>>>> understand where the actual problems were and what's necessary to fix them.
> >>>>>
> >>>>> Helge
> >>>>>
> >>>>> [1] https://lore.kernel.org/r/feea8303-2b83-fc36-972c-4fc8ad723bde@gmx.de
> >>
> >> Seems like few people read linux-fbdev these days.
> >> I suggest to partly revert the patch to the point were performance
> >> gets better again.
> > Yes, *please*!
> > That would solve my biggest concern.
> >
> > As far as I can see that's only 2 commits to be reverted:
> > b3ec8cdf457e - "fbdev: Garbage collect fbdev scrolling acceleration, part 1 (from TODO list)"
> > 39aead8373b3 - "fbcon: Disable accelerated scrolling"for-next-next
> >
> > I think both were not related to any 0-day bug reports (but again, I might be wrong).
>
> I did some more checking...
>
> Both patches are not related to DRM, since no DRM driver sets the
> FBINFO_HWACCEL_COPYAREA or FBINFO_HWACCEL_FILLRECT flags.

These used to be set by, at least, nouveau (which is a drm driver).
And yeah, console responsiveness is _way_ worse without that. People
keep pushing the messaging that it's the same speed to do it as
memcpy, but that's just not the case in my experience, on a pretty
bog-standard x86 desktop. The support got dumped, and it felt pretty
clear from the messaging at the time, "too bad". Would love to see it
come back.

Cheers,

  -ilia
