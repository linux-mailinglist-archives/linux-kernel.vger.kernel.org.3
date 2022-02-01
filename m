Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A89A44A5ADB
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 12:07:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237090AbiBALHX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 06:07:23 -0500
Received: from mail-vs1-f53.google.com ([209.85.217.53]:45975 "EHLO
        mail-vs1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235963AbiBALHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 06:07:22 -0500
Received: by mail-vs1-f53.google.com with SMTP id t20so15551652vsq.12;
        Tue, 01 Feb 2022 03:07:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UFAIMQcU3dCvJZn8Zuan8C8Op7u0lxfrOEd/qthi1mk=;
        b=ucvHtK9PqGQQfJX0hCsx68e3hYRn3gZ/T+h/5DS3mFb11EECKG1kBxk5RTBuA04Dgu
         nyQY5aGyHEHRKel1UOP42r/bCBPAskWGjuGojQlC+8uLm55d0mlT9elnr1wJ6RqDp8sR
         DTqkeo4qA1z5gQeUR5o74ayGCYotZpO849nnpVE+4KgB+zD2T+2iaxkR42KlGVijl8rF
         blh5inicg4psEm3HUeij3DyPZdOPXDYA1sJLGuA6u52FXIK799HshG8K9VSg6+mp5s/Z
         j+HFvPKwONsNQhakKlqFWEpw8yvUq0ONi60PVxlG1Gx+NQHdfDU1mbpD0HzQJpA33uqE
         3scw==
X-Gm-Message-State: AOAM530ToXK0xyR1Xf/ofbTFZMePPRLKWrKktDbu1060cn/3Ovsa9him
        LjXhlnCMb8NUycWjNH0tv12DP93fLJvuyDG6
X-Google-Smtp-Source: ABdhPJx+xkNm7hytdvBRIhna3Z7B6rmrGIs08GfKfcPgilpnOmLHrXk4lNL8qq9Uby9pumW5uyD/9g==
X-Received: by 2002:a67:ee01:: with SMTP id f1mr9737221vsp.0.1643713642079;
        Tue, 01 Feb 2022 03:07:22 -0800 (PST)
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com. [209.85.217.50])
        by smtp.gmail.com with ESMTPSA id p2sm4993584uao.1.2022.02.01.03.07.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Feb 2022 03:07:20 -0800 (PST)
Received: by mail-vs1-f50.google.com with SMTP id g10so15552702vss.1;
        Tue, 01 Feb 2022 03:07:19 -0800 (PST)
X-Received: by 2002:a67:b00e:: with SMTP id z14mr9303063vse.57.1643713639387;
 Tue, 01 Feb 2022 03:07:19 -0800 (PST)
MIME-Version: 1.0
References: <20220131201225.2324984-1-javierm@redhat.com> <tIMIWqepcZGntnez-1ss4Kn4K8btXnzDRL7EWd19-745WK90YIC19E_4di9RNvB3gtx-PzWEjBEGQLPNJE_x0T1yyyaWFCoFcCiG4StR9RU=@emersion.fr>
 <wuXPJN-K-rvjoV51c4EBmTBScov8rcJTPoYmlfHe04_-4wD1khVxo9HnUsP7UFd5m4AkzGSw2hXe_c77jbSRhjEJ0JZIYwuvuIkcv_KsR-Y=@emersion.fr>
 <CAMuHMdXKZ=BkvVqdpiNPNJgxm9SzQ3Z0n4SqV2-4oPRveybd6g@mail.gmail.com>
 <qmhzv6kqs6QdAOP3bNB39glOpc8eeJ6flgjfjcaBniT-shDKZkxo5uB71weGOUKxPE6dq_WBhtHmY5vMmuYwqMoHgtMWnX0ESE5R1Y5g5F8=@emersion.fr>
 <CAKMK7uGPuhrDf8fdDgfuPt5rzO30Rm54T7GvWb203NRbVoVDgw@mail.gmail.com>
 <b0788b3d-9c77-0e96-0969-380d21663909@redhat.com> <20220201124208.39c31e59@eldfell>
In-Reply-To: <20220201124208.39c31e59@eldfell>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 1 Feb 2022 12:07:07 +0100
X-Gmail-Original-Message-ID: <CAMuHMdX_uyEznHy5vYwS8Q=+bBKPddeJa41KTWi4Fwh3tjX+zQ@mail.gmail.com>
Message-ID: <CAMuHMdX_uyEznHy5vYwS8Q=+bBKPddeJa41KTWi4Fwh3tjX+zQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] drm/tiny: Add driver for Solomon SSD1307 OLED displays
To:     Pekka Paalanen <ppaalanen@gmail.com>
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Simon Ser <contact@emersion.fr>,
        Linux PWM List <linux-pwm@vger.kernel.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        =?UTF-8?Q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>,
        David Airlie <airlied@linux.ie>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pekka,

On Tue, Feb 1, 2022 at 11:42 AM Pekka Paalanen <ppaalanen@gmail.com> wrote:
> On Tue, 1 Feb 2022 10:49:03 +0100
> Javier Martinez Canillas <javierm@redhat.com> wrote:
> > On 2/1/22 09:38, Daniel Vetter wrote:
> > > On Tue, Feb 1, 2022 at 9:34 AM Simon Ser <contact@emersion.fr> wrote:
> > >> On Tuesday, February 1st, 2022 at 09:26, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > >>> What's the story with the Rn formats?
> > >>>
> > >>> The comments say "n bpp Red", while this is a monochrome (even
> > >>> inverted) display?
> > >>
> > >> I don't think the color matters that much. "Red" was picked just because it was
> > >> an arbitrary color, to make the difference with e.g. C8. Or am I mistaken?
> > >
> > > The red comes from gl, where with shaders it really doesn't matter
> > > what meaning you attach to channels, but really just how many you
> > > have. So 2-channel formats are called RxGx, 3-channel RxGxBx,
> > > 4-channel RxGxBxAx and single-channel Rx. And we use drm_fourcc for
> > > interop in general, hence why these exist.
> > >
> > > We should probably make a comment that this really isn't a red channel
> > > when used for display it's a greyscale/intensity format. Aside from
> > > that documentation gap I think reusing Rx formats for
> > > greyscale/intensity for display makes perfect sense.
> > > -Daniel
> >
> > To sump up the conversation in the #dri-devel channel, these drivers
> > should support the following formats:
> >
> > 1) Dx (Daniel suggested that for darkness, but inverted mono)
>
> Did you consider format C1 instead?

That would be a 2-color display, which is not necessarily black
and white. Cfr. Amiga or Atari bit planes with bpp=1.
That's why fbdev has separate visuals for monochrome.

> I have no idea how this would map to fbdev API though.

    #define FB_VISUAL_MONO01                0       /* Monochr.
1=Black 0=White */
    #define FB_VISUAL_MONO10                1       /* Monochr.
1=White 0=Black */
    #define FB_VISUAL_TRUECOLOR             2       /* True color   */

The above is RGB (or grayscale, see below).

    #define FB_VISUAL_PSEUDOCOLOR           3       /* Pseudo color
(like atari) */

Palette

    #define FB_VISUAL_DIRECTCOLOR           4       /* Direct color */

Usually used as RGB with gamma correction, but the actual hardware
is more flexible.

    #define FB_VISUAL_STATIC_PSEUDOCOLOR    5       /* Pseudo color readonly */

Fixed palette

And:

    struct fb_var_screeninfo {
            ...
            __u32 grayscale;                /* 0 = color, 1 = grayscale,    */

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
