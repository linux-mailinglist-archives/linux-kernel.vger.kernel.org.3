Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16BEF596BA5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 10:53:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232041AbiHQIwQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 17 Aug 2022 04:52:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiHQIwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 04:52:12 -0400
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA16A77546
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 01:52:10 -0700 (PDT)
Received: by mail-qk1-f176.google.com with SMTP id m5so9923451qkk.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 01:52:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=2JD+X/GOYgljDqW3V4/txiGVTXdbLlGZCC1UfMUdTQc=;
        b=RiLyjaEdkb0sad34/Z9F1qpo4iFREOywuUFhZ5fRXjH2EjlUBQ05LrMxVRlH5uyYqT
         UmSPpMJHdnb8ls7ISmU86OczESISmzukh9ZUG9VjST9w73Xy3ld/4YKeucj6aYRh9K3N
         SVgyJg1PAPMFgvsb/xiduVCJTJJUwn95f4MPgp6I6fH4e7nE81CxbR2OGvyqL7SQ+4f1
         gpBCNYbRGAe9ZlxzEaVK1ZJ5n9BhaMUW4T2DimSLywAot7yqcpEm0pwX+w/BgaHdfCIg
         SPwke9dpIVpMKeXl2dzFtI6QJlsAhUKFynkrdITdb/EFfKyRCqimDxjMqa6p+RJn9N4L
         ezRg==
X-Gm-Message-State: ACgBeo37P9Sx5isDAVSrT6FFoq35KKUKwux4QReRpSho6FaaKohcK18Z
        NSQuvg8LzIWEQ5iZxpGTMOCtJlpDmIibbQ==
X-Google-Smtp-Source: AA6agR7lkcM6zN0VX/P6C7FcA53Ww1P7dzs6mEf/ats2WxY8MieXmFEJ/Y0rf1zOt8ES5FVRAcKq3Q==
X-Received: by 2002:a05:620a:371e:b0:6b8:b7a4:42c8 with SMTP id de30-20020a05620a371e00b006b8b7a442c8mr17730864qkb.608.1660726329770;
        Wed, 17 Aug 2022 01:52:09 -0700 (PDT)
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com. [209.85.128.180])
        by smtp.gmail.com with ESMTPSA id t201-20020a37aad2000000b006b9b7879964sm14471537qke.28.2022.08.17.01.52.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Aug 2022 01:52:07 -0700 (PDT)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-333b049f231so102722877b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 01:52:07 -0700 (PDT)
X-Received: by 2002:a25:880f:0:b0:67c:2727:7e3c with SMTP id
 c15-20020a25880f000000b0067c27277e3cmr18847109ybl.36.1660726327196; Wed, 17
 Aug 2022 01:52:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220728-rpi-analog-tv-properties-v1-0-3d53ae722097@cerno.tech>
 <20220728-rpi-analog-tv-properties-v1-4-3d53ae722097@cerno.tech>
 <CAMuHMdUrwzPYjA0wdR7ADj5Ov6+m03JbnY8fBYzRYyWDuNm5=g@mail.gmail.com>
 <20220816132636.3tmwqmrox64pu3lt@houat> <CAMuHMdUNLPbjs=usYQBim5FxsrC1oJLuF+3JB7auzHHRoOqavQ@mail.gmail.com>
 <20220817075351.4xpsqdngjgtiqvob@houat>
In-Reply-To: <20220817075351.4xpsqdngjgtiqvob@houat>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 17 Aug 2022 10:51:55 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUusnhYodWGCxJBu-1Hd2KW-xdT8jxE_iVdQjDo8b3Y5Q@mail.gmail.com>
Message-ID: <CAMuHMdUusnhYodWGCxJBu-1Hd2KW-xdT8jxE_iVdQjDo8b3Y5Q@mail.gmail.com>
Subject: Re: [PATCH v1 04/35] drm/modes: Introduce 480i and 576i modes
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Jernej Skrabec <jernej.skrabec@gmail.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Samuel Holland <samuel@sholland.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel@ffwll.ch>, Emma Anholt <emma@anholt.net>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        =?UTF-8?Q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-sunxi@lists.linux.dev,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Phil Elwell <phil@raspberrypi.com>,
        Mateusz Kwiatkowski <kfyatek+publicgit@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Dom Cobley <dom@raspberrypi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime,

On Wed, Aug 17, 2022 at 9:54 AM Maxime Ripard <maxime@cerno.tech> wrote:
> On Tue, Aug 16, 2022 at 05:00:38PM +0200, Geert Uytterhoeven wrote:
> > On Tue, Aug 16, 2022 at 3:26 PM Maxime Ripard <maxime@cerno.tech> wrote:
> > > On Fri, Aug 12, 2022 at 03:18:58PM +0200, Geert Uytterhoeven wrote:
> > > > On Fri, Jul 29, 2022 at 6:35 PM Maxime Ripard <maxime@cerno.tech> wrote:
> > > > > Multiple drivers (meson, vc4) define the analog TV 525-lines and 625-lines
> > > > > modes in the drivers.
> > > >
> > > > Nit: strictly speaking these are not analog modes, but the digital
> > > > variants (ITU-R BT.656 and DVD-Video D1) of NTSC and PAL, using a
> > > > 13.5 MHz sampling frequency for pixels.
> > > >
> > > > In analog modes, the only discrete values are the number of lines, and
> > > > the frame/field rate (fixing the horizontal sync rate when combined).
> > > >
> > > > The number of (in)visible pixels per line depends on the available
> > > > bandwidth.  In a digital variant (which is anything generated by a
> > > > digital computer system), the latter depends on the pixel clock, which
> > > > can wildly differ from the 13.5 MHz used in the BT.656 standard. (e.g.
> > > > Amiga uses 7.09/14.19/28.38 MHz (PAL) or 7.16/14.32/28.64 MHz (NTSC)).
> > > >
> > > > So I think we probably need some way to generate a PAL/NTSC-compatible
> > > > mode based not only on resolution, but also on pixel clock.
> > >
> > > This would also fix the comments made by Jani and Thomas, so I quite
> > > like the idea of it.
> > >
> > > I'm struggling a bit to find how would could implement this though.
> > >
> > > From what you were saying, I guess the prototype would be something like
> > >
> > > struct drm_display_mode *drm_create_analog_mode(unsigned int pixel_clock,
> > >                                                 unsigned int lines,
> > >                                                 unsigned int frame_rate)
> > >
> > > But I have zero idea on what the implementation would be. Do you have
> > > some resources for this you could point me to?
> >
> > Horizontally, I think you should calculate left/right margins and
> > hsync length to yield timings that match those for the BT.656 PAL/NTSC
> > modes.  I.e. when a 640x512 mode with a pixel clock of 14 MHz is
> > requested, you want to calculate left', right', and hslen' for
> >
> > | <---- left' ---> | <- 640 pixels -> | <---- right' ---> | <--- hslen' --> |
> >                         @ 14 MHz
> >
> > so they match the timings for left, right, and hslen for
> >
> > | <--- left ---> | <--- 720 pixels ---> | <--- right ---> | <--- hslen ---> |
> >                         @ 13.5 MHz
> >
> > As 640 pixels @ 14 MHz are less wide than 720 pixels @ 13.5 MHz,
> > you want to make sure to align the center of the visible part.
>
> So I guess in that example if we want to center it, left == right and
> left' == right'? What about the sync length?

No, left and right are asymmetrical, cfr. front and back porch in
https://en.wikipedia.org/wiki/PAL#PAL_signal_details
I.e. if the pixel part is reduced, both the left and right margins
should be increased by the same amount.

From the table linked above, hslen should be ca. 4.7µs (fixed).

> > Vertically, it's simpler, as the number of lines is discrete.
> > You do have to take into account interlace and doublescan, and
> > progressive modes with 262/312 lines.
>
> So we only have to deal with 525 and 625 lines total (without taking
> interlace and doublescan into account), right?

Yes.

> I guess we still have the same question, we probably want to center it,
> so top == bottom, but what about the vsync length?

Unfortunately that table does not mention top and bottom margins.
But according to drivers/video/fbdev/amifb.c (see the "Broadcast
video timings" comment block and the definitions of the "ntsc-lace"
and "pal-lace" video modes), they are asymmetrical, too.

Vsync length is 0.576ms, so that's 9 scan lines (I guess I didn't
have that info when I wrote amifb, as I used 4 lines there).

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
