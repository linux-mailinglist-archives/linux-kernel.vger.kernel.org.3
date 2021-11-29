Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92BCF462201
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 21:17:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233221AbhK2UUP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 15:20:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232600AbhK2URq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 15:17:46 -0500
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80218C06FD54
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 08:50:45 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id s11so10900029ilv.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 08:50:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tuXSCi3W5k4YjYyZpaX5+bo97wFIHp81oIVUYJL00SI=;
        b=UyFcnTVKWLAVQm/9FbeKbsayqMz78WqtkFPrc9up7Rg6PAgQyOYZBDiW6xdgBaTHte
         a5jAPCEY9vOXO424NLcgUoU766WQrmmXjp6V6U7NH/WL++ftTSLEfk/WyU5IwWMvm2sE
         n8Boy1Qiz7bHNekvogxyghLcGUCJVbrvZ5AKo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tuXSCi3W5k4YjYyZpaX5+bo97wFIHp81oIVUYJL00SI=;
        b=4PHdqYUXWQ1qhEfUCQZ4Yy9/dXcNdz7WuKcNyY6rvbDDbIqSuJ6OJDINqSrhkl7yij
         47s7vcSrE+cUtDoh8w1izEIGioCas77eOsk8zxDAdDHRCyJGtraQ55mDI0wChllwYe5Z
         Bvx7L7sDtBEwXMTh4l6HUswoRlFk57xYYOlUEF7qDpyS6UcrKMWEVX8dZuHiey8shlej
         WjX3Swafx4T8oaqnH1r1KZ18DuaH9+EAu/RSbgaz+qYYIdfCgCAQ4rZJNHNlCDTPrCjU
         r3Un+6jHSRtU4Hizg6ixEe5VCn9etp+YSjKG+ZRBOIHmynu81jjwVBm76QGsW1bKX30m
         bSZw==
X-Gm-Message-State: AOAM5335CQdO1PplV0GARmrkkAJKvTXS88+7vNiMjDeC3FkLake3Q4N4
        FrIkUx42V0H+RaPMN1SODPpCQFHXPiq6zA==
X-Google-Smtp-Source: ABdhPJyhOXOOHq4ywMCmUO7eim5WqEnbIuR3y9OE4scJaQRdn19YuaEH1I9oXwPLCS6iIcgSxMKwXA==
X-Received: by 2002:a05:6e02:1b8a:: with SMTP id h10mr49743195ili.14.1638204643324;
        Mon, 29 Nov 2021 08:50:43 -0800 (PST)
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com. [209.85.166.182])
        by smtp.gmail.com with ESMTPSA id q20sm8609813iob.42.2021.11.29.08.50.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Nov 2021 08:50:42 -0800 (PST)
Received: by mail-il1-f182.google.com with SMTP id t8so18137566ilu.8
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 08:50:42 -0800 (PST)
X-Received: by 2002:a05:6e02:190f:: with SMTP id w15mr10809909ilu.114.1638204642437;
 Mon, 29 Nov 2021 08:50:42 -0800 (PST)
MIME-Version: 1.0
References: <20211029122359.1.I1e23f382fbd8beb19fe1c06d70798b292012c57a@changeid>
 <CAE=gft4MRvq-VCBW4EX4dGfPi4s7Lco8h6Z_ejRH5A1e-K2-yA@mail.gmail.com>
 <CAJZ5v0hsGFHxcTb8PUkGSm9oas1wdquB=euofS19zriRc1CXYw@mail.gmail.com>
 <CAE=gft6CjUhkcrmcjVEOp5S+rgqN1_ZGTKbK0DierTanu0d16A@mail.gmail.com> <CAJZ5v0gamixc4dkBEXJjjw5zQynuz8BkQ9xv8YpbjkTkdMb2TQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0gamixc4dkBEXJjjw5zQynuz8BkQ9xv8YpbjkTkdMb2TQ@mail.gmail.com>
From:   Evan Green <evgreen@chromium.org>
Date:   Mon, 29 Nov 2021 08:50:06 -0800
X-Gmail-Original-Message-ID: <CAE=gft6o0JxhDgazPA5DVbL6hQ+36D_GkzgN-AuR3YA43NSqaw@mail.gmail.com>
Message-ID: <CAE=gft6o0JxhDgazPA5DVbL6hQ+36D_GkzgN-AuR3YA43NSqaw@mail.gmail.com>
Subject: Re: [PATCH] PM / hibernate: Fix snapshot partial write lengths
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 24, 2021 at 4:54 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Tue, Nov 16, 2021 at 9:22 PM Evan Green <evgreen@chromium.org> wrote:
> >
> > On Tue, Nov 16, 2021 at 9:54 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > >
> > > On Mon, Nov 15, 2021 at 6:13 PM Evan Green <evgreen@chromium.org> wrote:
> > > >
> > > > Gentle bump.
> > > >
> > > >
> > > > On Fri, Oct 29, 2021 at 12:24 PM Evan Green <evgreen@chromium.org> wrote:
> > > > >
> > > > > snapshot_write() is inappropriately limiting the amount of data that can
> > > > > be written in cases where a partial page has already been written. For
> > > > > example, one would expect to be able to write 1 byte, then 4095 bytes to
> > > > > the snapshot device, and have both of those complete fully (since now
> > > > > we're aligned to a page again). But what ends up happening is we write 1
> > > > > byte, then 4094/4095 bytes complete successfully.
> > > > >
> > > > > The reason is that simple_write_to_buffer()'s second argument is the
> > > > > total size of the buffer, not the size of the buffer minus the offset.
> > > > > Since simple_write_to_buffer() accounts for the offset in its
> > > > > implementation, snapshot_write() can just pass the full page size
> > > > > directly down.
> > > > >
> > > > > Signed-off-by: Evan Green <evgreen@chromium.org>
> > > > > ---
> > > > >
> > > > >  kernel/power/user.c | 2 +-
> > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/kernel/power/user.c b/kernel/power/user.c
> > > > > index 740723bb388524..ad241b4ff64c58 100644
> > > > > --- a/kernel/power/user.c
> > > > > +++ b/kernel/power/user.c
> > > > > @@ -177,7 +177,7 @@ static ssize_t snapshot_write(struct file *filp, const char __user *buf,
> > > > >                 if (res <= 0)
> > > > >                         goto unlock;
> > > > >         } else {
> > > > > -               res = PAGE_SIZE - pg_offp;
> > > > > +               res = PAGE_SIZE;
> > > > >         }
> > > > >
> > > > >         if (!data_of(data->handle)) {
> > > > > --
> > >
> > > Do you actually see this problem in practice?
> >
> > Yes. I may fire up another thread to explain why I'm stuck doing a
> > partial page write, and how I might be able to stop doing that in the
> > future with some kernel help. But either way, this is a bug.
>
> OK, patch applied as 5.16-rc material.
>
> I guess it should go into -stable kernels too?

Yes, putting it into -stable would make sense also. I should have CCed
them originally, doing that now.
-Evan
