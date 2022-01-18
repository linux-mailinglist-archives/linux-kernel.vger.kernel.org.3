Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB0ED4924AF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 12:23:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238097AbiARLXD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 06:23:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231157AbiARLXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 06:23:02 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93739C061574
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 03:23:02 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id bx18so9481837oib.7
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 03:23:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0vxu12L1jZfPH/n8U6n3NYOUika1PiHRFgnFfE0mqac=;
        b=FQcI04UjT4EjGUadFs3tu4NgXPGRJOKF4fVamISkg3N+HpvnrRY052ydvNoRCdWVsm
         DQxKsojVYpQZ/lVhyUlZE4dzcOtYQ5HqNZMtdFoOtzS/mNtFbLcdBrCAKyHdQGtrcNb+
         Dv/SZjYB0cET4g9ABzGbEN0f28Ox80038d3ls=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0vxu12L1jZfPH/n8U6n3NYOUika1PiHRFgnFfE0mqac=;
        b=g5fwfu+AvRE6fNKIK0pVZPiGdrtYV632uk/sDnTCxWU0rEaDuMtN3r7vrH5O93JLeL
         P+kO5blPglnGSI4X//j/M3Ys8CIlQfrSzOW7NSNlj6nX+Wt8Q/DmrjuQyLyOOFFQE7Ep
         5OMl9acy+oOQhw0tSzAumckDEXVfUkwJv+e7fzVlpdpD3FYTPGWn2/WhTybpyRJRaEqK
         xEpKCBhgFzijrBfDSKevK3yn/4EM2GnGxW3+gPmjvLq+NF7jPqIFUs0/h1WeE5BAO4QR
         Y/pBn9WH5rS3a6U1l8/2EXz+8HEkN73Wa2gTKyhNnuKJ3J8FkpPrb4bbWvwgdzDLE22D
         IWgA==
X-Gm-Message-State: AOAM530KugOlJMCq9o/Z6GeNWjwntqvDbIcZNwg1qMGFfw+HtR/eWv64
        o4cBHsM30P8XBHzi4pA5mLyHg2Rw8ZWyMqZ3D5T/+g==
X-Google-Smtp-Source: ABdhPJx04xf4KFu7cR9PzSZ5lOKeBxnc/JEG/KJ4kgQu+iPUN6I304Hyiv0+IwlQnk/spVK2x5FoB5/tKvzavEUuFvo=
X-Received: by 2002:aca:b103:: with SMTP id a3mr26125595oif.14.1642504981992;
 Tue, 18 Jan 2022 03:23:01 -0800 (PST)
MIME-Version: 1.0
References: <YeG8ydoJNWWkGrTb@ls3530> <c48ad8ae-aea5-43fa-882f-dccb90dde9a4@suse.de>
 <87bl0amc6s.fsf@x1.stackframe.org> <20220118103323.4bae3a7d@eldfell> <20220118095352.xsb6fqacw4p276c5@sirius.home.kraxel.org>
In-Reply-To: <20220118095352.xsb6fqacw4p276c5@sirius.home.kraxel.org>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Tue, 18 Jan 2022 12:22:50 +0100
Message-ID: <CAKMK7uGQ=pGHv+LcRxZqb_jV0fqzUZtd+tZCr7aatoMDF4hyvw@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Add Helge as fbdev maintainer
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     Pekka Paalanen <ppaalanen@gmail.com>, linux-fbdev@vger.kernel.org,
        Helge Deller <deller@gmx.de>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Sven Schnelle <svens@stackframe.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 18, 2022 at 10:54 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> On Tue, Jan 18, 2022 at 10:33:23AM +0200, Pekka Paalanen wrote:
> > On Mon, 17 Jan 2022 19:47:39 +0100
> > Sven Schnelle <svens@stackframe.org> wrote:
> >
> > > I also tested the speed on my Thinkpad X1 with Intel graphics, and there
> > > a dmesg with 919 lines one the text console took about 2s to display. In
> > > x11, i measure 22ms. This might be unfair because encoding might be
> > > different, but i cannot confirm the 'memcpy' is faster than hardware
> > > blitting' point. I think if that would be the case, no-one would care
> > > about 2D acceleration.
> >
> > I think that is an extremely unfair comparison, because a graphical
> > terminal app is not going to render every line of text streamed to it.
> > It probably renders only the final view alone if you simply run
> > 'dmesg', skipping the first 800-900 lines completely.
>
> Probably more like "render on every vblank", but yes, unlike fbcon it
> surely wouldn't render every single character sent to the terminal.
>
> Also acceleration on modern hardware is more like "compose window
> content using the 3d engine" than "use 2d blitter to scroll the window".
>
> > Maybe fbcon should do the same when presented with a flood of text,
> > but I don't know how or why it works like it works.
>
> fbcon could do the same, i.e. render to fbdev in a 60Hz timer instead of
> doing it synchronously.

Yeah, and if you use the shadow fb support in drm fbdev helpers,
that's what you get. Maybe we should just make that the default, since
that would also greatly simply stuff like modesetting support for
fbdev.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
