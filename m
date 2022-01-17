Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83770490991
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 14:31:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234091AbiAQNaC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 08:30:02 -0500
Received: from mail-ua1-f53.google.com ([209.85.222.53]:33625 "EHLO
        mail-ua1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233841AbiAQNaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 08:30:01 -0500
Received: by mail-ua1-f53.google.com with SMTP id u6so30503638uaq.0;
        Mon, 17 Jan 2022 05:30:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aw/HNeVnfTRxU1ZQlE8UIYhuVJjuteUvt0Niy9Bfiz0=;
        b=KnWbplvLSljCNRNiCCRHJ5K41GoWVGxg0ZKT2Zk5Zv6a1bfbDL4NXiHK/bxUI97u2A
         PmPxp6//kL4Ki3IBCDI0BiwJ4S6jJ2F89Fthl57OdP/Bh9hM7Db4ZNKr+A25tGqq0P7d
         ylBjyFrQH8iUj/9VMGsee8hsPD++I3Lju7LGdxi2pp3RCgU1vI2lYRWH1H0t2T/4p2NZ
         g1JXl7r4HnT82FL7b2bXxPq0PTxAdSy5GSb/bIJEioqaU/fuwVEyku4qrzy64k7yA+rV
         msQ0Hqgros7NhcZUH916UxohaJ7Tr2I6yndULKQgpf9pausPEs3S/3VaT8P9adIAFSRV
         23ZA==
X-Gm-Message-State: AOAM533CLI62sOU9V2ouxrNv3UNRNxSGESior0FktVykc7yAAFWbqpOM
        lQPT7EnexyDwxPYbk+SNdu0wQ4YNqlQo2A==
X-Google-Smtp-Source: ABdhPJxmxqUu4KEcgcj7zfNS5xmD58Wd8gVDwVrroulabAdvKck6ib/U6w55VqhYbk0Enjht+OUiiQ==
X-Received: by 2002:a05:6102:ed5:: with SMTP id m21mr7381704vst.56.1642426200221;
        Mon, 17 Jan 2022 05:30:00 -0800 (PST)
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com. [209.85.221.169])
        by smtp.gmail.com with ESMTPSA id s32sm3526190uas.3.2022.01.17.05.29.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jan 2022 05:29:59 -0800 (PST)
Received: by mail-vk1-f169.google.com with SMTP id 191so10375349vkc.1;
        Mon, 17 Jan 2022 05:29:59 -0800 (PST)
X-Received: by 2002:ac5:c967:: with SMTP id t7mr8120473vkm.20.1642426198916;
 Mon, 17 Jan 2022 05:29:58 -0800 (PST)
MIME-Version: 1.0
References: <YeG8ydoJNWWkGrTb@ls3530> <CAKMK7uGdJckdM+fg+576iJXsqzCOUg20etPBMwRLB9U7GcG01Q@mail.gmail.com>
 <c80ed72c-2eb4-16dd-a7ad-57e9dde59ba1@gmx.de> <20220117125716.yjwxsze35j2ndn2i@sirius.home.kraxel.org>
In-Reply-To: <20220117125716.yjwxsze35j2ndn2i@sirius.home.kraxel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 17 Jan 2022 14:29:47 +0100
X-Gmail-Original-Message-ID: <CAMuHMdW=Zpp2mHbrBx7i0WN8PqY3XpK5qpyAyYxgf9n88edpug@mail.gmail.com>
Message-ID: <CAMuHMdW=Zpp2mHbrBx7i0WN8PqY3XpK5qpyAyYxgf9n88edpug@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Add Helge as fbdev maintainer
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     Helge Deller <deller@gmx.de>, Daniel Vetter <daniel@ffwll.ch>,
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

Hi Gerd,

On Mon, Jan 17, 2022 at 1:57 PM Gerd Hoffmann <kraxel@redhat.com> wrote:
> > b) to include new drivers (for old hardware) if they arrive (probably happens rarely but there can be).
> >    I know of at least one driver which won't be able to support DRM....
>
> Hmm?  I seriously doubt that.  There is always the option to use a
> shadow framebuffer, then convert from standard drm formats to whatever
> esoteric pixel format your hardware expects.
>
> Been there, done that.  Have a look at the cirrus driver.  The physical
> hardware was designed in the early 90-ies, almost 30 years ago.  These
> days it exists in virtual form only (qemu emulates it).  Thanks to the
> drm driver it runs wayland just fine even though it has a bunch of
> constrains dictated by the hardware design.

The Cirrus DRM driver supports TrueColor (RGB565/888 and ARGB8888)
modes only.  The Cirrus fbdev driver also supports mochrome and 256
color modes.

There exist some DRM drivers that do support DRM_FORMAT_C8, but none of
the "tiny" ones do. Same for DRM_FORMAT_RGB{332,233}.  Using a shadow
frame buffer to convert from truecolor to 256 colors would be doable,
but would give bad results. And what about less colors?
Adding support for e.g. DRM_FORMAT_C4 is not straight-forward, as
the DRM core assumes in many places that a pixel is at least 1 byte,
and would crash otherwise (yes I tried).  Other modes needed are
DRM_FORMAT_Y4 and DRM_FORMAT_{BW,WB} (monochrome).
This not only to support "old" hardware, but also modern small OLED
and e-ink displays.

On the positive side: DRM would force e.g. the Amiga and Atari
bitplane formats to become internal to the kernel driver, with the
kernel driver converting from packed pixels to bitplanes.  Hence
userspace would no longer have to care about bitplanes.


Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
