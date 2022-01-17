Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9A13490A05
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 15:10:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234368AbiAQOKP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 09:10:15 -0500
Received: from mail-ua1-f53.google.com ([209.85.222.53]:46844 "EHLO
        mail-ua1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbiAQOKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 09:10:13 -0500
Received: by mail-ua1-f53.google.com with SMTP id c36so30514829uae.13;
        Mon, 17 Jan 2022 06:10:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IVkUe3uV+8LCxfEyOkwQAxMSTEPLRyMs/0Qx0B4nQCU=;
        b=NU3WzHjZNvmYoqfteQtWZMlr5Mpol057e5ikKlgFF54YUjW9Kes83mRSC7lJcr+rUI
         CNLd8zhY8vxhpieLc/Zb/rMVnVizRY73AknaNbUrPNdXpUO9R25G/5RupMHRdu1G47S2
         HHyOC9PP3IuxAQIw4Z9MhxIp9WWXIkb/VVvmp5TMdb2Z7cpQvcRupPR0PYB2bZHZKliU
         fVK3AIJJNa0VH6gqpzrVkXY6fa8ihdbrEx8JsaXa/AWnCQH+9eo6/wGL9Tz2niVAcEf+
         +3IyVo9WsY4jEMg7hReXTZT2tw2FTQQJpkv6fOooFK+3NFxEq4d2C+xCjlVT2wJc6DcK
         iBGg==
X-Gm-Message-State: AOAM532U+ZELnBdqXXmo1ytDWXGLkGaNYYIkYVINhztvePKMpQ4ItS0W
        U6d2vEOlGpR+MDsjCf17lIlIYmH5T3Vbtw==
X-Google-Smtp-Source: ABdhPJyveOK2vsyjygRhrucwI9ABwHYr1oireyMbGlhFB+C+UK+UJAQVIbS4uwiuspQQ12g1GYM6DQ==
X-Received: by 2002:a9f:2105:: with SMTP id 5mr1076798uab.38.1642428612625;
        Mon, 17 Jan 2022 06:10:12 -0800 (PST)
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com. [209.85.221.182])
        by smtp.gmail.com with ESMTPSA id e10sm541227vsa.29.2022.01.17.06.10.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jan 2022 06:10:12 -0800 (PST)
Received: by mail-vk1-f182.google.com with SMTP id n14so9203380vkk.6;
        Mon, 17 Jan 2022 06:10:11 -0800 (PST)
X-Received: by 2002:a1f:2344:: with SMTP id j65mr7794483vkj.7.1642428611448;
 Mon, 17 Jan 2022 06:10:11 -0800 (PST)
MIME-Version: 1.0
References: <YeG8ydoJNWWkGrTb@ls3530> <CAKMK7uGdJckdM+fg+576iJXsqzCOUg20etPBMwRLB9U7GcG01Q@mail.gmail.com>
 <c80ed72c-2eb4-16dd-a7ad-57e9dde59ba1@gmx.de> <20220117125716.yjwxsze35j2ndn2i@sirius.home.kraxel.org>
 <CAMuHMdW=Zpp2mHbrBx7i0WN8PqY3XpK5qpyAyYxgf9n88edpug@mail.gmail.com> <70530b62-7b3f-db88-7f1a-f89b824e5825@suse.de>
In-Reply-To: <70530b62-7b3f-db88-7f1a-f89b824e5825@suse.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 17 Jan 2022 15:10:00 +0100
X-Gmail-Original-Message-ID: <CAMuHMdW5M=zEuGEnQQc3JytDhoxCKRiq0QFw+HOPp0YMORzidw@mail.gmail.com>
Message-ID: <CAMuHMdW5M=zEuGEnQQc3JytDhoxCKRiq0QFw+HOPp0YMORzidw@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Add Helge as fbdev maintainer
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     Gerd Hoffmann <kraxel@redhat.com>, Helge Deller <deller@gmx.de>,
        Daniel Vetter <daniel@ffwll.ch>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "airlied@gmail.com" <airlied@gmail.com>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Javier Martinez Canillas <javierm@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On Mon, Jan 17, 2022 at 2:51 PM Thomas Zimmermann <tzimmermann@suse.de> wrote:
> Am 17.01.22 um 14:29 schrieb Geert Uytterhoeven:
> > On Mon, Jan 17, 2022 at 1:57 PM Gerd Hoffmann <kraxel@redhat.com> wrote:
> >>> b) to include new drivers (for old hardware) if they arrive (probably happens rarely but there can be).
> >>>     I know of at least one driver which won't be able to support DRM....
> >>
> >> Hmm?  I seriously doubt that.  There is always the option to use a
> >> shadow framebuffer, then convert from standard drm formats to whatever
> >> esoteric pixel format your hardware expects.
> >>
> >> Been there, done that.  Have a look at the cirrus driver.  The physical
> >> hardware was designed in the early 90-ies, almost 30 years ago.  These
> >> days it exists in virtual form only (qemu emulates it).  Thanks to the
> >> drm driver it runs wayland just fine even though it has a bunch of
> >> constrains dictated by the hardware design.
> >
> > The Cirrus DRM driver supports TrueColor (RGB565/888 and ARGB8888)
> > modes only.  The Cirrus fbdev driver also supports mochrome and 256
> > color modes.
> >
> > There exist some DRM drivers that do support DRM_FORMAT_C8, but none of
> > the "tiny" ones do. Same for DRM_FORMAT_RGB{332,233}.  Using a shadow
> > frame buffer to convert from truecolor to 256 colors would be doable,
> > but would give bad results. And what about less colors?
> > Adding support for e.g. DRM_FORMAT_C4 is not straight-forward, as
> > the DRM core assumes in many places that a pixel is at least 1 byte,
> > and would crash otherwise (yes I tried).  Other modes needed are
> > DRM_FORMAT_Y4 and DRM_FORMAT_{BW,WB} (monochrome).
>
> We export XRGB32 from each driver, because userspace expects it. But
> that is not a hard requirement. Userspace can use any format. It's just
> that no one seems to have any use cases so far, so no work has been
> done. Think of XRGB32 as a fallback.

Using an XRGB32 intermediate would kill the user experience on old
machines, due to both increased memory usage and copy overhead.

> Personally, I'd much appreciate if userspace would support more of the
> native formats and not rely on XRGB32.

Supporting monochrome, 16 colors, and 256 colors would be nice.

> > This not only to support "old" hardware, but also modern small OLED
> > and e-ink displays.
>
> There's a DRM driver for Repaper e-Ink displays. So it seems doable at
> least.

Which uses an DRM_FORMAT_XRGB8888 intermediate, and
drm_fb_xrgb8888_to_gray8() and repaper_gray8_to_mono_reversed()
to convert from truecolor to monochrome.  I guess that would work,
as this is a slow e-ink display.  Have fun as a text console ;-)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
