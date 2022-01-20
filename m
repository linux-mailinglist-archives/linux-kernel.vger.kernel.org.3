Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E97FE494DAD
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 13:14:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232682AbiATMOD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 07:14:03 -0500
Received: from mail-ua1-f41.google.com ([209.85.222.41]:39459 "EHLO
        mail-ua1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbiATMN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 07:13:56 -0500
Received: by mail-ua1-f41.google.com with SMTP id p7so3224137uao.6;
        Thu, 20 Jan 2022 04:13:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=olNvo1hlOps7yRNGdWPhIvGrV31s5RQbZPcE1Lfk/FY=;
        b=DPYJ92Mw1I2q8aKrJ0lGi3LDJ1jkP1hsAXidhUNlxbbp5DKsUBDRIGJaxx5IPBcxMg
         +scjWssmycN5Mx/pVYF7JzPJU9XG6Y6weUaQdIaOhlZk0UZKesZgibSSNmje79Owdc7R
         RUAEz/1Z7WNyF7abNMxc64RntmC+jfIfNgD4OxTiI1svXYxrkEdKRNd++0vionl14Asm
         CwuvONKs/XboBl9WQ6ukcfxOxCmfYE9HP/2ZQCVCvnEL/Mco79R0aaw8BoGW+8NPYmlG
         i5UJ9syUp9HOJq8QkWYZsBMkJXabSsXy13bDLHS6b6fmoASnzUMvLAAZjictT0qE7ETl
         XHDA==
X-Gm-Message-State: AOAM531S3SP+bH4gtBIh+1JIR8vV60yDAxw0nSPN+X1dZbzofPJRCAqm
        i38lOYLpQhIS9wRIIymrByHvhUTB86ecdQ==
X-Google-Smtp-Source: ABdhPJz10yFfydZ2MyS/VscLmlnd50fxuJ8Fa/CJ2sGh4z+eWVPfuJo8I+95gQfk3FoXG7IxuBDkHw==
X-Received: by 2002:a05:6102:94e:: with SMTP id a14mr519914vsi.86.1642680835432;
        Thu, 20 Jan 2022 04:13:55 -0800 (PST)
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com. [209.85.222.49])
        by smtp.gmail.com with ESMTPSA id m6sm420318vsc.28.2022.01.20.04.13.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jan 2022 04:13:55 -0800 (PST)
Received: by mail-ua1-f49.google.com with SMTP id l1so8555495uap.8;
        Thu, 20 Jan 2022 04:13:55 -0800 (PST)
X-Received: by 2002:a67:e055:: with SMTP id n21mr551166vsl.57.1642680834901;
 Thu, 20 Jan 2022 04:13:54 -0800 (PST)
MIME-Version: 1.0
References: <YeG8ydoJNWWkGrTb@ls3530> <c48ad8ae-aea5-43fa-882f-dccb90dde9a4@suse.de>
 <87bl0amc6s.fsf@x1.stackframe.org> <20220118103323.4bae3a7d@eldfell>
 <20220118095352.xsb6fqacw4p276c5@sirius.home.kraxel.org> <CAMuHMdWV+-+Jr7HggbfH_GEDcdep4pJLiMG+15jxBvQ91BCS0w@mail.gmail.com>
 <CAKMK7uEOFg3z2btFERQ5XBQ7hqex6bXCb9X=SdwCjeLfX_SdFw@mail.gmail.com>
In-Reply-To: <CAKMK7uEOFg3z2btFERQ5XBQ7hqex6bXCb9X=SdwCjeLfX_SdFw@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 20 Jan 2022 13:13:43 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVjv1+UNeXkCBE+80tdtLuNg=5d6N12hNLgJdaS-jxERg@mail.gmail.com>
Message-ID: <CAMuHMdVjv1+UNeXkCBE+80tdtLuNg=5d6N12hNLgJdaS-jxERg@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Add Helge as fbdev maintainer
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Gerd Hoffmann <kraxel@redhat.com>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Helge Deller <deller@gmx.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Sven Schnelle <svens@stackframe.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On Thu, Jan 20, 2022 at 12:33 PM Daniel Vetter <daniel@ffwll.ch> wrote:
> On Thu, Jan 20, 2022 at 10:06 AM Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
> > On Thu, Jan 20, 2022 at 4:29 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
> > > On Tue, Jan 18, 2022 at 10:33:23AM +0200, Pekka Paalanen wrote:
> > > > On Mon, 17 Jan 2022 19:47:39 +0100
> > > > Sven Schnelle <svens@stackframe.org> wrote:
> > > > > I also tested the speed on my Thinkpad X1 with Intel graphics, and there
> > > > > a dmesg with 919 lines one the text console took about 2s to display. In
> > > > > x11, i measure 22ms. This might be unfair because encoding might be
> > > > > different, but i cannot confirm the 'memcpy' is faster than hardware
> > > > > blitting' point. I think if that would be the case, no-one would care
> > > > > about 2D acceleration.
> > > >
> > > > I think that is an extremely unfair comparison, because a graphical
> > > > terminal app is not going to render every line of text streamed to it.
> > > > It probably renders only the final view alone if you simply run
> > > > 'dmesg', skipping the first 800-900 lines completely.
> > >
> > > Probably more like "render on every vblank", but yes, unlike fbcon it
> > > surely wouldn't render every single character sent to the terminal.
> > >
> > > Also acceleration on modern hardware is more like "compose window
> > > content using the 3d engine" than "use 2d blitter to scroll the window".
> > >
> > > > Maybe fbcon should do the same when presented with a flood of text,
> > > > but I don't know how or why it works like it works.
> > >
> > > fbcon could do the same, i.e. render to fbdev in a 60Hz timer instead of
> > > doing it synchronously.
> >
> > Hopefully only the parts of the screen which need a redraw?
> >
> > Not all displays can be updated that fast. For a "modern" example, see
> > https://patchwork.freedesktop.org/series/93070/.
>
> drm does damage tracking throughout the stack, e.g.
>
> https://dri.freedesktop.org/docs/drm/gpu/drm-kms.html#damage-tracking-properties
>
> And unlike fbdev, it's explicit (so less overhead since userspace
> generally knows what it's drawn) and doesn't rely on page fault
> intercepting and fun stuff like that.

My reply was to a paragraph about rendering text by fbcon, not about
userspace rendering graphics.

> Like do people actually know what drm can and cannot do, or would that
> take out all the fun?

;-)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
