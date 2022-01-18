Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B9614920FE
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 09:10:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343965AbiARIKo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 03:10:44 -0500
Received: from mail-ua1-f46.google.com ([209.85.222.46]:41942 "EHLO
        mail-ua1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234311AbiARIKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 03:10:43 -0500
Received: by mail-ua1-f46.google.com with SMTP id i10so13060063uab.8;
        Tue, 18 Jan 2022 00:10:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VAQlLcFBVgyKQTaBnoQmFYzL/LSJbyFvZ8WuVXWI65o=;
        b=JwFBjHy22YvCQM3WaWTkZG0ypHBTNGIldGDxsI+2WZEbJn1yKepEDDNzdAkqhjeBnI
         Zr2N71RmPpTSrsIDyr7XByvesAUuy+LNHfeAk4Kt/OO3+qRDbbnQszw+RhWzqurK24fF
         dBKY7n6V/De8OhU83y0y+CjvqPPAtdcyW7gIeBeN/H63nCTbFLpotMsmozhSZtZKorB9
         i3qDinyR1rZkh12QEOCQihzDy3lGowHeQ6f+iJueuetIDLt2SmkGxGdSH53pQukJRS5u
         sfp8jDQTPAOcpdH+/fcoLs7aFqX4CxRfhVXJd4sH+vQfrnF17+T9krA3Kk7Qx+sWiTK7
         Ngyg==
X-Gm-Message-State: AOAM530zmE/k60Y6JWvwbVa9gtaHrexBAkgx6f7MsOCW39sGT76t0bom
        PDZPDiz9xX15Z9T787x8KBxLMZ5Y71mlsA==
X-Google-Smtp-Source: ABdhPJzZQfTIWi1bNE06O+L/CpV8DZV57I78oHTtj0EjpKg9hsL1NLm82Ig4PmoPPooR9MzCuLxF8Q==
X-Received: by 2002:ab0:3913:: with SMTP id b19mr8983984uaw.82.1642493442122;
        Tue, 18 Jan 2022 00:10:42 -0800 (PST)
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com. [209.85.222.48])
        by smtp.gmail.com with ESMTPSA id u7sm801776vsg.34.2022.01.18.00.10.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jan 2022 00:10:41 -0800 (PST)
Received: by mail-ua1-f48.google.com with SMTP id 2so10302077uax.10;
        Tue, 18 Jan 2022 00:10:41 -0800 (PST)
X-Received: by 2002:a67:e985:: with SMTP id b5mr7881629vso.77.1642493441373;
 Tue, 18 Jan 2022 00:10:41 -0800 (PST)
MIME-Version: 1.0
References: <YeG8ydoJNWWkGrTb@ls3530> <CAKMK7uGdJckdM+fg+576iJXsqzCOUg20etPBMwRLB9U7GcG01Q@mail.gmail.com>
 <c80ed72c-2eb4-16dd-a7ad-57e9dde59ba1@gmx.de> <20220117125716.yjwxsze35j2ndn2i@sirius.home.kraxel.org>
 <CAMuHMdW=Zpp2mHbrBx7i0WN8PqY3XpK5qpyAyYxgf9n88edpug@mail.gmail.com>
 <70530b62-7b3f-db88-7f1a-f89b824e5825@suse.de> <CAMuHMdW5M=zEuGEnQQc3JytDhoxCKRiq0QFw+HOPp0YMORzidw@mail.gmail.com>
 <57d276d3-aa12-fa40-6f90-dc19ef393679@gmx.de> <CAKMK7uE7jnTtetB5ovGeyPxHq4ymhbWmQXWmSVw-V1vP3iNAKQ@mail.gmail.com>
 <b32ffceb-ea90-3d26-f20e-29ae21c68fcf@gmx.de> <20220118062947.6kfuam6ah63z5mmn@sirius.home.kraxel.org>
In-Reply-To: <20220118062947.6kfuam6ah63z5mmn@sirius.home.kraxel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 18 Jan 2022 09:10:29 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWXWA2h7zrZa_nnqR_qNdsOdHJS=Vf1YExhvs08KukoNg@mail.gmail.com>
Message-ID: <CAMuHMdWXWA2h7zrZa_nnqR_qNdsOdHJS=Vf1YExhvs08KukoNg@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Add Helge as fbdev maintainer
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     Helge Deller <deller@gmx.de>, Daniel Vetter <daniel@ffwll.ch>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Sven Schnelle <svens@stackframe.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gerd,

On Tue, Jan 18, 2022 at 7:30 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
> Also note that using a shadow framebuffer allows to decouple fbcon
> updates and scanout framebuffer updates.  Can be used to speed up
> things without depending on the 2d blitter.

Assuming accesses to the shadow frame buffer are faster than accesses
to the scanout frame buffer. While this is true on modern hardware,
this is not the case on all hardware.  Especially if the shadow frame
buffer has a higher depth (XRGB8888) than the scanout frame buffer
(e.g. Cn)...

The funny thing is that the systems we are interested in, once used
to be known for their graphics capabilities and/or performance...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
