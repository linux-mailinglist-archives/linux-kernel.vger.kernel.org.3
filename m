Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 241E8490AF6
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 16:00:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232187AbiAQPAq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 10:00:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbiAQPAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 10:00:45 -0500
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 856ABC06161C
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 07:00:45 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id y11-20020a0568302a0b00b0059a54d66106so2891724otu.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 07:00:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/dxZvD461SlMfyeHYzrFRmG+0lHmJjYtARJeJQLPvpY=;
        b=lWRjQkiGCj+cTGTeXbOuRbrEMphiURVSpENiEBC0prgzVPEt0g8iXSfTDmshf+ViTD
         CIjoFMzlGXB7oJSSoq0W5kXmTUcSRHhur2KTpXyIbekYrhC+nJS9YFMUx9a0EKRF2F15
         dMtZKZCCYLoW+ULl/4YVAuX/Mk6zWOwbLrHx8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/dxZvD461SlMfyeHYzrFRmG+0lHmJjYtARJeJQLPvpY=;
        b=rLprGQAleqfkTFKGivp7INRx4JKzf67fEOZfbg3f81lG7vHibLHEcdfZZzxGIMOT6T
         z9lJA4IRI7py1ZmUtl11bUlCWGvEhwhHEJ3EgUbvTwLENtRbDW4GFLxWx31Bg+93MjzN
         rbGR/YMNGy9y/E/kv//0MUabmbct60JxGNCABWdJuzUqkssbnrNHjEvcwtbrkKDIfSvZ
         cTyPDOA/eVKash+hTJbtJBiIiFLEDgw30eiWt1uHxPo27tYaUmtGhPepmqr2xaqvQU8h
         NkBMTy3VAZJ80bL/4iT2ZGy2qhubx3poh/XYZImOQanXOrjsRFerhr+0VsMfCVp81dq1
         LWHg==
X-Gm-Message-State: AOAM530ffDXfZcI3IG6tAybzotILkZJYflN7NtTMuwzlvdvggCJESZd0
        FdXPyv1MG/m9CYN3RmEEWWXkcvQPGSKv+IWbKgMiig==
X-Google-Smtp-Source: ABdhPJyjl9zZGHl5jLCvJP/Li+7kpC1gjq+uBoXlAxknMVKszuG/kGjLQ+TET5p0Sgcor7GmumXL5rsNoxy7CE3/xvY=
X-Received: by 2002:a9d:685a:: with SMTP id c26mr16484836oto.239.1642431644611;
 Mon, 17 Jan 2022 07:00:44 -0800 (PST)
MIME-Version: 1.0
References: <YeG8ydoJNWWkGrTb@ls3530> <CAKMK7uGdJckdM+fg+576iJXsqzCOUg20etPBMwRLB9U7GcG01Q@mail.gmail.com>
 <c80ed72c-2eb4-16dd-a7ad-57e9dde59ba1@gmx.de>
In-Reply-To: <c80ed72c-2eb4-16dd-a7ad-57e9dde59ba1@gmx.de>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Mon, 17 Jan 2022 16:00:33 +0100
Message-ID: <CAKMK7uHVHn9apB6YYbLSwu+adEB2Fqp4FM0z582zf4F-v3_GnQ@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Add Helge as fbdev maintainer
To:     Helge Deller <deller@gmx.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "airlied@gmail.com" <airlied@gmail.com>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Javier Martinez Canillas <javierm@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 17, 2022 at 1:16 PM Helge Deller <deller@gmx.de> wrote:
>
> Hello Daniel,
>
> On 1/17/22 11:02, Daniel Vetter wrote:
> > Hi Helge
> >
> > On Fri, Jan 14, 2022 at 7:18 PM Helge Deller <deller@gmx.de> wrote:
> >>
> >> The fbdev layer is orphaned, but seems to need some care.
> >> So I'd like to step up as new maintainer.
> >>
> >> Signed-off-by: Helge Deller <deller@gmx.de>
> >>
> >> diff --git a/MAINTAINERS b/MAINTAINERS
> >> index 5d0cd537803a..ce47dbc467cc 100644
> >> --- a/MAINTAINERS
> >> +++ b/MAINTAINERS
> >> @@ -7583,11 +7583,12 @@ W:      http://floatingpoint.sourceforge.net/emulator/index.html
> >>  F:     arch/x86/math-emu/
> >>
> >>  FRAMEBUFFER LAYER
> >> -L:     dri-devel@lists.freedesktop.org
> >> +M:     Helge Deller <deller@gmx.de>
> >>  L:     linux-fbdev@vger.kernel.org
> >> -S:     Orphan
> >
> > Maybe don't rush maintainer changes in over the w/e without even bothering
> > to get any input from the people who've been maintaining it before.
> >
> > Because the status isn't entirely correct, fbdev core code and fbcon and
> > all that has been maintained, but in bugfixes only mode. And there's very
> > solid&important reasons to keep merging these patches through a drm tree,
> > because that's where all the driver development happens, and hence also
> > all the testing (e.g. the drm test suite has some fbdev tests - the only
> > automated ones that exist to my knowledge - and we run them in CI). So
> > moving that into an obscure new tree which isn't even in linux-next yet is
> > no good at all.
> >
> > Now fbdev driver bugfixes is indeed practically orphaned and I very much
> > welcome anyone stepping up for that, but the simplest approach there would
> > be to just get drm-misc commit rights and push the oddball bugfix in there
> > directly. But also if you want to do your own pull requests to Linus for
> > that I don't care and there's really no interference I think, so
> > whatever floats.
> >
> > But any code that is relevant for drm drivers really needs to go in through
> > drm trees, nothing else makes much sense.
> >
> > I guess you're first action as newly minted fbdev maintainer is going to be to
> > clean up the confusion you just created.
>
> Most of my machines depend on a working fbdev layer since drm isn't (and probably
> -due to technical requirements of DRM- won't be) available for those.
> So, since the fbdev drivers were marked orphaned, I decided to step up as maintainer.
>
> I see your point that at least the fbdev core code and fbcon are shared between DRM and fbdev.
> For me it's really not important to drive any patches through a seperate tree, so
> I'd be happy to join the drm-misc tree if you feel it's necessary. (By the way,
> adding my tree to for-next was on my todo list...)
>
> What's important for me though is, to keep fbdev actively maintained, which means:
> a) to get fixes which were posted to fbdev mailing list applied if they are useful & correct,

Yeah it'd be great if we have that, for a while Bart took care of
these, but had to step down again. drm-misc is maintained with the dim
scrip suite, which comes with docs and bash completion and everything.
Good starting pointer is here:

https://drm.pages.freedesktop.org/maintainer-tools/getting-started.html

Process for getting commit rights is documented here:

https://drm.pages.freedesktop.org/maintainer-tools/commit-access.html#drm-misc

But there's a pile more. I think once we've set that up and got it
going we can look at the bigger items. Some of them are fairly
low-hanging fruit, but the past 5+ years absolutely no one bothered to
step up and sort them out. Other problem areas in fbdev are extremely
hard to fix properly, without only doing minimal security-fixes only
support, so fair warning there. I think a good starting point would be
to read the patches and discussions for some of the things you've
reverted in your tree.

Anyway I hope this gets you started, and hopefully after a minor
detour: Welcome to dri-devel, we're happy to take any help we can get,
there's lots to do!

Cheers, Daniel

> b) to include new drivers (for old hardware) if they arrive (probably happens rarely but there can be).
>    I know of at least one driver which won't be able to support DRM....
>    Of course, if the hardware is capable to support DRM, it should be written for DRM and not applied for fbdev.
> c) reintroduce the state where fbcon is fast on fbdev. This is important for non-DRM machines,
>    either when run on native hardware or in an emulator.
> d) not break DRM development
>
> Especially regarding c) I complained in [1] and got no feedback. I really would like to
> understand where the actual problems were and what's necessary to fix them.
>
> Helge
>
> [1] https://lore.kernel.org/r/feea8303-2b83-fc36-972c-4fc8ad723bde@gmx.de



-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
