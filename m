Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 662A3494A55
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 10:07:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232711AbiATJGX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 04:06:23 -0500
Received: from mail-ua1-f52.google.com ([209.85.222.52]:40721 "EHLO
        mail-ua1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358624AbiATJGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 04:06:15 -0500
Received: by mail-ua1-f52.google.com with SMTP id w21so9557155uan.7;
        Thu, 20 Jan 2022 01:06:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9hW9NoHGAjAtGmLgUFLCO4iu8bgqOUYOgRPSBz28dQI=;
        b=gz3O9TQALU//uJ3Ys1iuLzlh8sdDEDWLAezBshq8s9nb5p12tPXIQuPztiX8HOtUul
         sux5AQNz7v/iIaF+wnzDCWdF/pYR7pHMuyR3fa7U04mRH9TXpvi+tYqewiYOC4lB99vg
         fhhIRwIQAUF1FK1BFqVCQ7UMWebcFV0Uhd5yTcz5u0ADNUPQQzVomTqB77h2XYJ2mdgz
         +tX7BoGlory8qjsO78zzGlx0nSo8PZjeG47M1W4qIwvof6snsBKpxrO9sIcQfgpiia7K
         HJtHZY1PdP/ZQMoFFBLWm9GHdIaZfOy44M5s6dWsPEYHwVF0F6S3DNKmZiPGe1R4F+d5
         JGHA==
X-Gm-Message-State: AOAM530UWnMi8SuDmMsvlf18cvp4Pcyp/5zNS+/8u7TCrTdAIRb0clMX
        +RrupQf3l5s7V7sdLyOd3aRW4eLgu+s9FQ==
X-Google-Smtp-Source: ABdhPJz1oTOokLYNyA095Sy0z2F/YJvGyOTLAnnNfnN4Ja7xkyyIdiPf1jsHirUOCqIc7JwzxRwk7A==
X-Received: by 2002:a05:6102:3010:: with SMTP id s16mr656050vsa.47.1642669574242;
        Thu, 20 Jan 2022 01:06:14 -0800 (PST)
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com. [209.85.222.52])
        by smtp.gmail.com with ESMTPSA id 10sm438357vky.24.2022.01.20.01.06.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jan 2022 01:06:13 -0800 (PST)
Received: by mail-ua1-f52.google.com with SMTP id x33so9507934uad.12;
        Thu, 20 Jan 2022 01:06:13 -0800 (PST)
X-Received: by 2002:a05:6102:3581:: with SMTP id h1mr13566234vsu.5.1642669573470;
 Thu, 20 Jan 2022 01:06:13 -0800 (PST)
MIME-Version: 1.0
References: <YeG8ydoJNWWkGrTb@ls3530> <c48ad8ae-aea5-43fa-882f-dccb90dde9a4@suse.de>
 <87bl0amc6s.fsf@x1.stackframe.org> <20220118103323.4bae3a7d@eldfell> <20220118095352.xsb6fqacw4p276c5@sirius.home.kraxel.org>
In-Reply-To: <20220118095352.xsb6fqacw4p276c5@sirius.home.kraxel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 20 Jan 2022 10:06:01 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWV+-+Jr7HggbfH_GEDcdep4pJLiMG+15jxBvQ91BCS0w@mail.gmail.com>
Message-ID: <CAMuHMdWV+-+Jr7HggbfH_GEDcdep4pJLiMG+15jxBvQ91BCS0w@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Add Helge as fbdev maintainer
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     Pekka Paalanen <ppaalanen@gmail.com>,
        Sven Schnelle <svens@stackframe.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Helge Deller <deller@gmx.de>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gerd,

On Thu, Jan 20, 2022 at 4:29 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
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

Hopefully only the parts of the screen which need a redraw?

Not all displays can be updated that fast. For a "modern" example, see
https://patchwork.freedesktop.org/series/93070/.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
