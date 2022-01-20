Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2D1B494E25
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 13:46:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243098AbiATMq2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 07:46:28 -0500
Received: from mail-ua1-f43.google.com ([209.85.222.43]:33517 "EHLO
        mail-ua1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243043AbiATMq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 07:46:26 -0500
Received: by mail-ua1-f43.google.com with SMTP id u6so10689521uaq.0;
        Thu, 20 Jan 2022 04:46:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TVOsKevTrHGaSWoEOZEFy6vOm3loanQlCT1W9IuMkTY=;
        b=o3EiDTvPn7H9z934kwdP+i00L1D+wGbPU88KR0qs4s1OA3tt8R/G+tH1jNkmb+jDpR
         dPJ3KRt78MSwvQELGsqzhCzrF9n/nkQkN6WMd1aEqy1mpI6AhzAzLDZ946Vb8J0gBU9Q
         seEBOdbB3y/IR9ZlfFtUj5e6M+o3MZbqa7FYo+37tdNMpexEMIlAhizD2Aw1bkkSNcVt
         LNNz69f9AA1FQJH3mqAucPA4YJ+seQCPKuGS9Txw9H0ZP0bsv82eu5WDUYeD3MsgBiHc
         YkrTaLLTJFgsYuBoX8SoxJBnzAcm6s6jT2QaNuIKXel259t8/qH36bXk6oakhawQUdR2
         HRVA==
X-Gm-Message-State: AOAM533lzPKxlVZbN5Wo0IH1A65MA9JWeE9QIgXLF5N6rB9ImqyjK1wp
        BHyERx30bRF6gLUsm3kizF2eEs8/o9nr+Q==
X-Google-Smtp-Source: ABdhPJx5aNuJzWU/Xs1db70cb2rO4A5BZGiUuHo0G2s11SyaCMRTVm+bPoNDyRb74EFtnpYECUO1Dw==
X-Received: by 2002:a67:c911:: with SMTP id w17mr13422729vsk.23.1642682785782;
        Thu, 20 Jan 2022 04:46:25 -0800 (PST)
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com. [209.85.222.53])
        by smtp.gmail.com with ESMTPSA id a12sm381809vsq.29.2022.01.20.04.46.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jan 2022 04:46:25 -0800 (PST)
Received: by mail-ua1-f53.google.com with SMTP id n15so9070451uaq.5;
        Thu, 20 Jan 2022 04:46:25 -0800 (PST)
X-Received: by 2002:a67:e985:: with SMTP id b5mr12549674vso.77.1642682784811;
 Thu, 20 Jan 2022 04:46:24 -0800 (PST)
MIME-Version: 1.0
References: <YeG8ydoJNWWkGrTb@ls3530> <c48ad8ae-aea5-43fa-882f-dccb90dde9a4@suse.de>
 <87bl0amc6s.fsf@x1.stackframe.org> <20220118103323.4bae3a7d@eldfell>
 <20220118095352.xsb6fqacw4p276c5@sirius.home.kraxel.org> <CAMuHMdWV+-+Jr7HggbfH_GEDcdep4pJLiMG+15jxBvQ91BCS0w@mail.gmail.com>
 <CAKMK7uEOFg3z2btFERQ5XBQ7hqex6bXCb9X=SdwCjeLfX_SdFw@mail.gmail.com>
 <CAMuHMdVjv1+UNeXkCBE+80tdtLuNg=5d6N12hNLgJdaS-jxERg@mail.gmail.com> <CAKMK7uEwDdaR7kDVi9Oah0w8qFEoAywp_wj2eH7DtttVD2L00A@mail.gmail.com>
In-Reply-To: <CAKMK7uEwDdaR7kDVi9Oah0w8qFEoAywp_wj2eH7DtttVD2L00A@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 20 Jan 2022 13:46:13 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXboG=DxpO9WN-e0c-Zoet-fWwiwYATGb6TZYQd9Ajg6Q@mail.gmail.com>
Message-ID: <CAMuHMdXboG=DxpO9WN-e0c-Zoet-fWwiwYATGb6TZYQd9Ajg6Q@mail.gmail.com>
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

On Thu, Jan 20, 2022 at 1:33 PM Daniel Vetter <daniel@ffwll.ch> wrote:
> On Thu, Jan 20, 2022 at 1:13 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Thu, Jan 20, 2022 at 12:33 PM Daniel Vetter <daniel@ffwll.ch> wrote:
> > > On Thu, Jan 20, 2022 at 10:06 AM Geert Uytterhoeven
> > > <geert@linux-m68k.org> wrote:
> > > > On Thu, Jan 20, 2022 at 4:29 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
> > > > > On Tue, Jan 18, 2022 at 10:33:23AM +0200, Pekka Paalanen wrote:
> > > > > > On Mon, 17 Jan 2022 19:47:39 +0100
> > > > > > Sven Schnelle <svens@stackframe.org> wrote:
> > > > > > > I also tested the speed on my Thinkpad X1 with Intel graphics, and there
> > > > > > > a dmesg with 919 lines one the text console took about 2s to display. In
> > > > > > > x11, i measure 22ms. This might be unfair because encoding might be
> > > > > > > different, but i cannot confirm the 'memcpy' is faster than hardware
> > > > > > > blitting' point. I think if that would be the case, no-one would care
> > > > > > > about 2D acceleration.
> > > > > >
> > > > > > I think that is an extremely unfair comparison, because a graphical
> > > > > > terminal app is not going to render every line of text streamed to it.
> > > > > > It probably renders only the final view alone if you simply run
> > > > > > 'dmesg', skipping the first 800-900 lines completely.
> > > > >
> > > > > Probably more like "render on every vblank", but yes, unlike fbcon it
> > > > > surely wouldn't render every single character sent to the terminal.
> > > > >
> > > > > Also acceleration on modern hardware is more like "compose window
> > > > > content using the 3d engine" than "use 2d blitter to scroll the window".
> > > > >
> > > > > > Maybe fbcon should do the same when presented with a flood of text,
> > > > > > but I don't know how or why it works like it works.
> > > > >
> > > > > fbcon could do the same, i.e. render to fbdev in a 60Hz timer instead of
> > > > > doing it synchronously.
> > > >
> > > > Hopefully only the parts of the screen which need a redraw?
> > > >
> > > > Not all displays can be updated that fast. For a "modern" example, see
> > > > https://patchwork.freedesktop.org/series/93070/.
> > >
> > > drm does damage tracking throughout the stack, e.g.
> > >
> > > https://dri.freedesktop.org/docs/drm/gpu/drm-kms.html#damage-tracking-properties
> > >
> > > And unlike fbdev, it's explicit (so less overhead since userspace
> > > generally knows what it's drawn) and doesn't rely on page fault
> > > intercepting and fun stuff like that.
> >
> > My reply was to a paragraph about rendering text by fbcon, not about
> > userspace rendering graphics.
>
> Yeah, and ofc when I say "throughout the stack" this also includes the
> fbdev emulation, including the mmap intercepting with fbdev_defio and
> all that. They all get remapped to that damage tracking property,
> which drivers can then inspect using a bunch of helpers.

And I really meant the text rendering part, not the copy of the shadow
buffer after the rendering.

> But reading code&docs is too hard I guess, safer to assume it's just
> broken and not supported.

Don't worry, I'm actually writing a larger rebuttal _and_ code...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
