Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A719749216F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 09:42:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344657AbiARImE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 03:42:04 -0500
Received: from mail-ua1-f50.google.com ([209.85.222.50]:44596 "EHLO
        mail-ua1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344701AbiARIl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 03:41:58 -0500
Received: by mail-ua1-f50.google.com with SMTP id f24so1240293uab.11;
        Tue, 18 Jan 2022 00:41:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CNdm03VJLU0BRz6mn7wssWGuiqSMikdKv8hszmF1Z7g=;
        b=g3UQqCGhHkB7yHyvffwnlEESjutj77sY/OcPPNBnoHu9xwsutLeBcYD7BIpOJ4OkZ7
         colSEHfgH3bwDjG3/RXU2wihGIXdlzATS0lIe8u3Dz27Ao5ymvETuFnSc+U4WokYrbOh
         jBx0fO3u8HbDYnJflRBZiVlbv8riSxchZ04ZIocPqvT+migfYLuPZzwf0EEPDjq25BNT
         3WWihrzvm0gROQhTxtzLOPZFGCiYH2AGONA48L7HFHPZ3NNrXbjwaPfFkHIbrEE1u7aj
         kqBQNSM7KeQu+rzSj6/9s8JqL5G2951fwHQwgUfsO+MjMKKH53TLm+Zq9hQ+JuJNnmGl
         I9cg==
X-Gm-Message-State: AOAM5325jjcuLjQ1TlNxEtqic8spq6GX0B8cUGV791UzFBCbYExzETo0
        s2ay3utmapCsuZ3a+bJ36PAUZQ6SSe1IsQ==
X-Google-Smtp-Source: ABdhPJzWMlMHGBcWTmLbIh7K0nV2J8g33Ha714r8Bp6wCSmahrOz7BYet7kQwivTAr3Vy2wr1FhyMg==
X-Received: by 2002:a67:24c3:: with SMTP id k186mr8631164vsk.74.1642495317829;
        Tue, 18 Jan 2022 00:41:57 -0800 (PST)
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com. [209.85.222.51])
        by smtp.gmail.com with ESMTPSA id 109sm239562uaf.18.2022.01.18.00.41.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jan 2022 00:41:57 -0800 (PST)
Received: by mail-ua1-f51.google.com with SMTP id y4so35209657uad.1;
        Tue, 18 Jan 2022 00:41:57 -0800 (PST)
X-Received: by 2002:ab0:1861:: with SMTP id j33mr8946930uag.14.1642495317021;
 Tue, 18 Jan 2022 00:41:57 -0800 (PST)
MIME-Version: 1.0
References: <YeG8ydoJNWWkGrTb@ls3530> <CAKMK7uGdJckdM+fg+576iJXsqzCOUg20etPBMwRLB9U7GcG01Q@mail.gmail.com>
 <c80ed72c-2eb4-16dd-a7ad-57e9dde59ba1@gmx.de> <CAKMK7uHVHn9apB6YYbLSwu+adEB2Fqp4FM0z582zf4F-v3_GnQ@mail.gmail.com>
 <cf21018b-f231-7538-169e-2ad450643cbf@gmx.de> <97d49bca-f5f7-dba4-b62d-b6fcdd4276ac@suse.de>
 <87ee5659dt.fsf@intel.com> <4f1d6018-d74e-8e62-ea4d-0ca79c6bbbc5@gmx.de> <87a6ft5thv.fsf@intel.com>
In-Reply-To: <87a6ft5thv.fsf@intel.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 18 Jan 2022 09:41:45 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVE6OY29qB+F-QPgQt2q5xAYfyuPhKqSDrh_HhD9PPw9g@mail.gmail.com>
Message-ID: <CAMuHMdVE6OY29qB+F-QPgQt2q5xAYfyuPhKqSDrh_HhD9PPw9g@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Add Helge as fbdev maintainer
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     Helge Deller <deller@gmx.de>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel@ffwll.ch>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Javier Martinez Canillas <javierm@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jani,

On Tue, Jan 18, 2022 at 9:38 AM Jani Nikula <jani.nikula@linux.intel.com> wrote:
> On Mon, 17 Jan 2022, Helge Deller <deller@gmx.de> wrote:
> > On 1/17/22 22:40, Jani Nikula wrote:
> >> On Mon, 17 Jan 2022, Thomas Zimmermann <tzimmermann@suse.de> wrote:
> >>> Seems like few people read linux-fbdev these days.
> >>
> >> How much traffic is there to linux-fbdev that is *not* Cc'd to dri-devel
> >> also?
> >
> > Doesn't seem like much traffic - which IMHO is OK for such a tree with
> > mostly just maintenance patches.
> >
> >> Do we still need a separate linux-fbdev mailing list at all?
> >
> > Yes. I want to have it seperate of dri-devel.
> > Actually I'd prefer to drop dri-devel from the list where patches
> > for fbdev are sent...
>
> Disagreed. If anything, this thread shows we can't have fbdev and drm in
> silos of their own.

Unless DRM drops fbdev support. Isn't that the long-term plan anyway?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
