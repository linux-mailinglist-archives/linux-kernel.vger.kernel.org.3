Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B9FE4A5EA6
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 15:54:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239554AbiBAOyY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 09:54:24 -0500
Received: from mail-ua1-f44.google.com ([209.85.222.44]:40890 "EHLO
        mail-ua1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239536AbiBAOyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 09:54:24 -0500
Received: by mail-ua1-f44.google.com with SMTP id w21so13977390uan.7;
        Tue, 01 Feb 2022 06:54:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kzlQhpMq4Ctc2cxxIgF+2UWQv9yJB23c2S2KJFtJK5I=;
        b=45yp7NFXNwmKIOiLsyRll/NNZOxk4C+TmfeoLBB5oudMYOpfRAkqlR3qFYm0yH644W
         fja5KYoJGLfIk8KZ9O1mi7i0BUpaNdMe4X/kAdKEuv6isyl1gPq6SiRokz/tV8CR+nga
         YELgNY9mK///FGIRcDGiCIExw5tXzjlShqgbVYJ7Tq7fuvi32WhF7X0Cbfu1bUH6lwu9
         pEkp7x08F6ssqETSxF/NSeDGY4/BC6fVSCtsj6qZQuGUg0ZVwGaIv52bHmIPekAi99uk
         pLgLLdBpLtewf8cd+/XaXZWHLCY+RZ0ZRx8q3yguk/Zc0r/+q5E2K6p7XlZzbMlbNBdP
         Wrog==
X-Gm-Message-State: AOAM532nWNh4q2jKur9xraS8zVcotvcN1b6Nmjl9iUWhWGS81pLZCS7y
        JS+d2l49dmcE25jkUjizRVOo9nEg10MN+gQH
X-Google-Smtp-Source: ABdhPJwXKkRxVjNJEd5j1UGzhpYT9mh5Ph2kMcYOaqssL83fo4/KNkwui1fitOtYbUlV3kh1g+Fcfw==
X-Received: by 2002:ab0:b3:: with SMTP id 48mr9612857uaj.85.1643727263177;
        Tue, 01 Feb 2022 06:54:23 -0800 (PST)
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com. [209.85.217.53])
        by smtp.gmail.com with ESMTPSA id w188sm4298830vsb.32.2022.02.01.06.54.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Feb 2022 06:54:22 -0800 (PST)
Received: by mail-vs1-f53.google.com with SMTP id a19so16373344vsi.2;
        Tue, 01 Feb 2022 06:54:21 -0800 (PST)
X-Received: by 2002:a67:a401:: with SMTP id n1mr9369281vse.38.1643727260868;
 Tue, 01 Feb 2022 06:54:20 -0800 (PST)
MIME-Version: 1.0
References: <20220131210552.482606-1-daniel.vetter@ffwll.ch> <20220131210552.482606-2-daniel.vetter@ffwll.ch>
In-Reply-To: <20220131210552.482606-2-daniel.vetter@ffwll.ch>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 1 Feb 2022 15:54:09 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWxFFMJ6W70SJzJynfAuqF=NjHbx64-=vgo=FQL_fqNVA@mail.gmail.com>
Message-ID: <CAMuHMdWxFFMJ6W70SJzJynfAuqF=NjHbx64-=vgo=FQL_fqNVA@mail.gmail.com>
Subject: Re: [PATCH 01/21] MAINTAINERS: Add entry for fbdev core
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dave Airlie <airlied@gmail.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Pavel Machek <pavel@ucw.cz>, Sam Ravnborg <sam@ravnborg.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Claudio Suarez <cssk@net-c.es>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Sven Schnelle <svens@stackframe.org>,
        Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 31, 2022 at 10:06 PM Daniel Vetter <daniel.vetter@ffwll.ch> wrote:
> Ever since Tomi extracted the core code in 2014 it's been defacto me
> maintaining this, with help from others from dri-devel and sometimes
> Linus (but those are mostly merge conflicts):
>
> $ git shortlog -ns  drivers/video/fbdev/core/ | head -n5
>     35  Daniel Vetter
>     23  Linus Torvalds
>     10  Hans de Goede
>      9  Dave Airlie
>      6  Peter Rosin
>
> I think ideally we'd also record that the various firmware fb drivers
> (efifb, vesafb, ...) are also maintained in drm-misc because for the
> past few years the patches have either been to fix handover issues
> with drm drivers, or caused handover issues with drm drivers. So any
> other tree just doesn't make sense. But also, there's plenty of
> outdated MAINTAINER entries for these with people and git trees that
> haven't been active in years, so maybe let's just leave them alone.
> And furthermore distros are now adopting simpledrm as the firmware fb
> driver, so hopefully the need to care about the fbdev firmware drivers
> will go down going forward.
>
> Note that drm-misc is group maintained, I expect that to continue like
> we've done before, so no new expectations that patches all go through
> my hands. That would be silly. This also means I'm happy to put any
> other volunteer's name in the M: line, but otherwise git log says I'm
> the one who's stuck with this.

> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
