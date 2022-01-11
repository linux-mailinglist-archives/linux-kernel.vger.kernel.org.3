Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FB1C48B06B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 16:08:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244947AbiAKPIY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 10:08:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244776AbiAKPIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 10:08:23 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EEE0C061751
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 07:08:23 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id w188so1853246oiw.13
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 07:08:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zo32VZLxMS3zJXGjj1I1zmEGC+mu6YnSTq3H93JaVfE=;
        b=Heyv3jK4mICHGAg012fN5bLm0U8J43bySG6C7i3qEmYU3W4v4K5T/HU6QotlZPmNtM
         3NjOHZXk6+tEHOBl1/MeNi2wiIYOlY8+nucM+gl8WjsFxunOsfIq070wf08UxVvTomvm
         BnmR8diWkLVSL2wMK8Cx3w0Gu1yo7kFftTON5/pJOOhfShySbIQV6JvlCVnvx3ZgSb4Z
         kj8hmfT2kivsxcL85x9rZVmdR/DmbogPyRa6TrekwHnzj+h7Ev4MgcYQPGV1NXfvIo+I
         bdOTh2/FrCw8k66dyFo6TIZeU8Jdb82+Pr0QVjTVpORBqUb9e9qTdx56DG3RSBHTilh3
         j9xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zo32VZLxMS3zJXGjj1I1zmEGC+mu6YnSTq3H93JaVfE=;
        b=DEGCKN9SpNaKNmtQ2i2FNK8EKrIriLKN+S7f0HNynwD9oAYvwicQiHmg0ZFv+eHUeu
         48v7VVovobKN6atGrRF87fxoOJWsuaj2ByskGw5Ui6RrTP8B+q1ru8oa07OZ8MGOi3L0
         fp+/IgJ2DsfVitAYo9b7CfNioIoLe9nskILeXAWFnCkctXt6kS+6WmKE1rSZtDnf5bt5
         zFaUcw6RUT/qMsF0R/2OQbOhwxO8fRKN1JuRtvjesouYVCDiRwuXbgKWMbEcnHxb+6bP
         B8/fEX/IzfFXGMPZTBDvd8CrYcYijRwEFyO+EAWRvPznDfNeV33ECyWT0e+jB8/pDz3x
         fHgg==
X-Gm-Message-State: AOAM530wuakflAxgMZxHcmEQuDko9wiHY58lIPGvleFeSy8gN9gZvmQw
        YYwgc1NIwqjC09b0v/BJFpdMFv0tHngujzMTNtA=
X-Google-Smtp-Source: ABdhPJwWtVP4MUZ1ZhbDstAftVZRtLtF9Yj4Z9a9nCZ3XslWL/zrmxNq9Mr+sGuurWu+NDiAulzfV+j3KakpH8XjWCI=
X-Received: by 2002:a05:6808:4c3:: with SMTP id a3mr2123816oie.123.1641913702634;
 Tue, 11 Jan 2022 07:08:22 -0800 (PST)
MIME-Version: 1.0
References: <CAPM=9tz=_hRpQV1V3M-=KmVVEbr1K166qeb-ne64PHk9Sn-ozg@mail.gmail.com>
 <CAHk-=wg9hDde_L3bK9tAfdJ4N=TJJ+SjO3ZDONqH5=bVoy_Mzg@mail.gmail.com>
 <CAKMK7uEag=v-g6ygHPcT-uQJJx+5KOh2ZRzC2QtM-MCjjW67TA@mail.gmail.com>
 <CADnq5_P9n39RQ5+Nm8O=YKXXvXh1CEzwC2fOEzEJuS2zQLUWEw@mail.gmail.com>
 <CAHk-=wgDGcaRxUwRCR6p-rxDVO78Yj4YyM6ZsPRGiT2JOCoQ6A@mail.gmail.com>
 <CADnq5_OYO7kq+9DBnDvbSfpouFvdLB0LPSL6+f1ZPRBsV=qEqA@mail.gmail.com>
 <CAHk-=wiCCRG9Lwzr+Cur=K1V2GJ9ab_ket7EnG4RZhJ8jJM7xQ@mail.gmail.com>
 <CAHk-=wi8b-YKHeNfwyYHMcgR2vJh4xpSZ0qjkv8E8Y9V8Sv2Tg@mail.gmail.com>
 <CAHk-=whnWnB9yjVaqWNKjavSJxDOEbTAPwef=O7qjL8nKZgV6A@mail.gmail.com> <CAHk-=whSAYiO_TkKut6XckdQigFj39ft1Kcs2qJe5niHWPGdwg@mail.gmail.com>
In-Reply-To: <CAHk-=whSAYiO_TkKut6XckdQigFj39ft1Kcs2qJe5niHWPGdwg@mail.gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 11 Jan 2022 10:08:08 -0500
Message-ID: <CADnq5_OZR9Ft=WVVbpM_WUpFZurni4yVxGPpa4nDkhupmod_ag@mail.gmail.com>
Subject: Re: [git pull] drm for 5.17-rc1 (pre-merge window pull)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jun Lei <Jun.Lei@amd.com>,
        Mustapha Ghaddar <mustapha.ghaddar@amd.com>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        meenakshikumar somasundaram <meenakshikumar.somasundaram@amd.com>,
        Daniel Wheeler <daniel.wheeler@amd.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
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

On Mon, Jan 10, 2022 at 9:53 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Mon, Jan 10, 2022 at 6:44 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > I'll double-check to see if a revert fixes it at the top of my tree.
>
> Yup. It reverts cleanly, and the end result builds and works fine, and
> doesn't show the horrendous flickering.
>
> I have done that revert, and will continue the merge window work.
> Somebody else gets to figure out what the actual bug is, but that
> commit was horribly broken on my machine (Sapphire Pulse RX 580 8GB,
> fwiw).

Thanks for tracking this down.  We are investigating the issue.

Alex
