Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B3F448A283
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 23:13:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345168AbiAJWNR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 17:13:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242582AbiAJWNQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 17:13:16 -0500
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32C56C06173F
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 14:13:16 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id i9so20561087oih.4
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 14:13:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DCLg1+gAtBtfm/JniWwMOPYIQHO9KKXaUPzzO04UAG0=;
        b=NDMlLJcvyL1XU50XTu4Csg2jS74GGkAFbQr3C9M7drxRVy/zJStBCkiZBE8dQ8Ny2A
         24XSlJ9VUkR8Ltr0altZrcMNHU3MPa9mk0Zw7wPRRC2RkUdfVv++BjLzt9bHvQLQYp0r
         9fjtUqRYJlZfK4vzOlqorIN8ZSfom9DI9uHfdvtP686vo11ZsnRg15VG7MkExw7gIi0U
         LDpVRFkKHmYVDtL4XKVw8/64IZuaiFpshhTO6FVUetTwZ9Nkkj0yP6aowj2GxiGiZqiM
         X/uHTxmo/qSdmkav9ZhBPCcyqqmp37b+ux6e3Zpqyyvjm0YK5l32aKgp7isfwes5Gl6n
         zTdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DCLg1+gAtBtfm/JniWwMOPYIQHO9KKXaUPzzO04UAG0=;
        b=zPSGZM2aE/Pjl45DAVtMKvBHTuoFmbLvhBleOJtbSvD2vMov6Mji5c8TPhSVJ6Bego
         Q3Bt3HipwVWQ2Q/mwhE5b1T/9ezkit1RBO7HzEIs/jM85hy25HdiZTPULahnfymC6j6+
         +3hHPj3T6HqO2bKMDflJqUTJy+aICRy5OQgtUyAw7pZV18ySpk1mSoXytPJ+iRsXa2pD
         KGw1sOFToYPasiSxHqmzwsWmAuje/DVmiWTgwn0mSO1toAXFZKSbE80VVWSQkBu2DhPQ
         fnS75kmCIeDxWdzfdlOncT/I/PZcgWkMuSOdwkG133+f7gLsW2jwY3S7NKYOAB5OT766
         k22A==
X-Gm-Message-State: AOAM530DKI+CCG63YEEwoULiSc6kpjektTPVawtInUAX0Nc+99Lt16QJ
        pF/NRjVbJJTu6vEzjCYE1Q57uKXzxwWNH5EoHv4=
X-Google-Smtp-Source: ABdhPJx8DF6wEYlqdbZgoZWTZFDvsXW0Hv6pc6K2gMmTYSOBlxHfjyNKDvnOaBa/NnFVFRFv26Tt6jYvu41ElS6hdRc=
X-Received: by 2002:a05:6808:300b:: with SMTP id ay11mr1047412oib.120.1641852795592;
 Mon, 10 Jan 2022 14:13:15 -0800 (PST)
MIME-Version: 1.0
References: <CAPM=9tz=_hRpQV1V3M-=KmVVEbr1K166qeb-ne64PHk9Sn-ozg@mail.gmail.com>
 <CAHk-=wg9hDde_L3bK9tAfdJ4N=TJJ+SjO3ZDONqH5=bVoy_Mzg@mail.gmail.com> <CAKMK7uEag=v-g6ygHPcT-uQJJx+5KOh2ZRzC2QtM-MCjjW67TA@mail.gmail.com>
In-Reply-To: <CAKMK7uEag=v-g6ygHPcT-uQJJx+5KOh2ZRzC2QtM-MCjjW67TA@mail.gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 10 Jan 2022 17:13:04 -0500
Message-ID: <CADnq5_P9n39RQ5+Nm8O=YKXXvXh1CEzwC2fOEzEJuS2zQLUWEw@mail.gmail.com>
Subject: Re: [git pull] drm for 5.17-rc1 (pre-merge window pull)
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Wentland, Harry" <harry.wentland@amd.com>,
        Dave Airlie <airlied@gmail.com>,
        "Koenig, Christian" <christian.koenig@amd.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2022 at 5:05 PM Daniel Vetter <daniel.vetter@ffwll.ch> wrote:
>
> On Mon, Jan 10, 2022 at 10:30 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > On Thu, Jan 6, 2022 at 10:12 PM Dave Airlie <airlied@gmail.com> wrote:
> > >
> > >   git://anongit.freedesktop.org/drm/drm tags/drm-next-2022-01-07
> >
> > Gaah. I merged things and it built cleanly, and I pushed it out.
> >
> > But then I actually *booted* it, and that's not pretty.
> >
> > It *works", but it's almost unusable because of random scanline
> > flickering.  I'm not sure how to explain it, but it's as if there
> > wasn't quite enough bandwidth on the scan-out, so you get these lines
> > of noise and/or shifted output. They are temporary - so the
> > framebuffer contents themselves is not damaged (although I don't know
> > how the compositor works - maybe the problem happens before scanout).
> >
> > This is on the same Radeon device:
> >
> >    49:00.0 VGA compatible controller: Advanced Micro Devices, Inc.
> > [AMD/ATI] Ellesmere [Radeon RX 470/480/570/570X/580/580X/590] (rev e7)
> >
> > with dual 4k monitors.
> >
> > Any idea?

Sounds like something related to watermarks.  That said, we haven't
really touched the display code for DCE11 cards in quite a while.  Can
you provide your dmesg output?

Alex


>
> Since Christian is mostly the compute/memory side, adding some display
> folks for this.
> -Daniel
> --
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch
