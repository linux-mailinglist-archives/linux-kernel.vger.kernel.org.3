Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFA3E5998B4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 11:37:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346754AbiHSJf7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 05:35:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbiHSJf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 05:35:57 -0400
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B131D21CA
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 02:35:55 -0700 (PDT)
Received: by mail-qv1-f53.google.com with SMTP id b2so2976156qvp.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 02:35:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=oXk24pt8yzz//H9K/Ms8QIvLemhYFXzzYPTlQRFRJUQ=;
        b=d+DsZwN5LfRCFd+Pw64FVQK5thqlkAc9dJKIWMGmDWEEAv/AUIPRZHm9QS0spuVc4n
         u7qDSAGNgnEHyNHerAJ57mQDxf7YmXs+mJU7llkCnOCnZbphrbfv/tMQRlZ77dh0aUpu
         Npd8PbIN6MkZHjunvE1CMXpHlsoxS22HM+vLg2BnUYQLPk1AM+ZjCPGe0KtTtkVN7Fw8
         1nmtSh9U/0EE7y/V0+xVtpHyJERkkO+gZmK87vf/NcpvMa8O4lA4Wk5CU/JgYw3q1McP
         jxujSfNJZ+HqyHQ+QWGxh5W9W/nDFmkKJHN8o1j7Ci6dGMyG6XjskSUj8lHiWPjjK7fu
         hjAg==
X-Gm-Message-State: ACgBeo1fbeVgCVSkUY4p41V4LOW1HzkHqLPzHxZP/iqcKeznZGO1BHzT
        ItnSK4+6RlSzSrVLPk5bZvlxhTHt1kxT5w==
X-Google-Smtp-Source: AA6agR5ur2t7RznfJDsY5uKFySVGt2YT/6IZsmeSQsGhWbRnI/AX1UQlCiZOZb8pQ/IiphZv3sdcpQ==
X-Received: by 2002:a0c:90a2:0:b0:47b:6b36:f94a with SMTP id p31-20020a0c90a2000000b0047b6b36f94amr5580495qvp.26.1660901754134;
        Fri, 19 Aug 2022 02:35:54 -0700 (PDT)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com. [209.85.128.174])
        by smtp.gmail.com with ESMTPSA id d22-20020ac847d6000000b0034367ec57ecsm2753902qtr.9.2022.08.19.02.35.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Aug 2022 02:35:53 -0700 (PDT)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-33365a01f29so107295897b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 02:35:53 -0700 (PDT)
X-Received: by 2002:a81:b812:0:b0:328:68e4:c886 with SMTP id
 v18-20020a81b812000000b0032868e4c886mr6398447ywe.502.1660901753206; Fri, 19
 Aug 2022 02:35:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220816154956.pkdpxmmw27mia5ix@houat> <CAMuHMdX0L6cO_jYXKZTv0sm9V39Eiy_STiknSkdRQG4k-9GJeg@mail.gmail.com>
 <20220817074710.w4c4xwj7edly2b5p@houat> <CAMuHMdXeBakWr6geOWGxnjQYaU9Pi4tRvVFFtubyMJZTT2nPnw@mail.gmail.com>
 <20220817111454.pn2iltvyo2drebq7@houat> <CAMuHMdU57g1rNoLo65jhLK8mk4YkNEbMz1E7XKWk2dnCxTr=gg@mail.gmail.com>
 <20220817131854.jwmhqvhfhp77bbr3@houat> <CAMuHMdXrfH9MArXesfNCvqayiq17u7XaqtSvXTNt4V10=obSHQ@mail.gmail.com>
 <20220818145436.vqojnhmvhjxdzooe@houat> <CAMuHMdW5kTUeg59fym7QxfN5oisTZHWbiAPeSYKJVShZWduJcA@mail.gmail.com>
 <20220818153442.u4knumkfbe7j6zj3@houat>
In-Reply-To: <20220818153442.u4knumkfbe7j6zj3@houat>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 19 Aug 2022 11:35:42 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUNYErf4PJLbSFFdB1EhvzbscqxHE74FnsjYQXLy8DLZA@mail.gmail.com>
Message-ID: <CAMuHMdUNYErf4PJLbSFFdB1EhvzbscqxHE74FnsjYQXLy8DLZA@mail.gmail.com>
Subject: Re: [PATCH v1 05/35] drm/connector: Add TV standard property
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
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime,

On Thu, Aug 18, 2022 at 5:34 PM Maxime Ripard <maxime@cerno.tech> wrote:
> On Thu, Aug 18, 2022 at 05:20:42PM +0200, Geert Uytterhoeven wrote:
> > On Thu, Aug 18, 2022 at 4:54 PM Maxime Ripard <maxime@cerno.tech> wrote:
> > > On Wed, Aug 17, 2022 at 04:04:24PM +0200, Geert Uytterhoeven wrote:
> > > > On Wed, Aug 17, 2022 at 3:19 PM Maxime Ripard <maxime@cerno.tech> wrote:
> > > > > On Wed, Aug 17, 2022 at 03:05:52PM +0200, Geert Uytterhoeven wrote:
> > > > > > On Wed, Aug 17, 2022 at 1:15 PM Maxime Ripard <maxime@cerno.tech> wrote:
> > > > > > > On Wed, Aug 17, 2022 at 10:35:07AM +0200, Geert Uytterhoeven wrote:
> > > > > > > > On Wed, Aug 17, 2022 at 9:47 AM Maxime Ripard <maxime@cerno.tech> wrote:
> > > > > > > > > On Wed, Aug 17, 2022 at 09:31:18AM +0200, Geert Uytterhoeven wrote:
> > > > > > > > > > On Tue, Aug 16, 2022 at 5:50 PM Maxime Ripard <maxime@cerno.tech> wrote:
> > > > > > > > > > > On Tue, Aug 16, 2022 at 04:43:44PM +0200, Geert Uytterhoeven wrote:
> > > > > > > > > > > > > > > > Either you have to add them here (e.g. "hd720p50" and "hd720p60"), or
> > > > > > > > > > > > > > > > handle them through "@<refresh>".  The latter would impact "[PATCH v1
> > > > > > > > > > > > > > > > 09/35] drm/modes: Move named modes parsing to a separate function", as
> > > > > > > > > > > > > > > > currently a named mode and a refresh rate can't be specified both.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > I think the former would make more sense. It simplifies a bit the
> > > > > > > > > > > > > > > parser, and we're going to use a named mode anyway.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > As "[PATCH v1 34/35] drm/modes: Introduce the tv_mode property as a
> > > > > > > > > > > > > > > > command-line option" uses a separate "tv_mode" option, and not the main
> > > > > > > > > > > > > > > > mode name, I think you want to add them here.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > It's a separate story I think, we could have a named mode hd720p50,
> > > > > > > > > > > > > > > which would be equivalent to 1280x720,tv_mode=hd720p
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > So where's the field rate in "1280x720,tv_mode=hd720p"?
> > > > > > > > > > > > >
> > > > > > > > > > > > > Yeah, sorry I meant 1280x720@50,tv_mode=hd720p
> > > > > > > > > > > >
> > > > > > > > > > > > Above you said "I think the former would make more sense", so that
> > > > > > > > > > > > should be "1280x720,tv_mode=hd720p50"?
> > > > > > > > > > >
> > > > > > > > > > > No, 720p at 50Hz would be either hd720p50 or 1280x720@50,tv_mode=hd720p
> > > > > > > > > > > and 60Hz would be hd720p60 or 1280x720@60,tv_mode=hd720p
> > > > > > > > > >
> > > > > > > > > > I disagree: hd720p50 and hd720p60 are different TV modes.
> > > > > > > > >
> > > > > > > > > I agree, and I don't see how that command-line doesn't express that?
> > > > > > > >
> > > > > > > > Oh, I see what you mean: yes, it expresses that.
> > > > > > > > But it is inconsistent with the NTSC/PAL/SECAM/hd{480,576}[ip] modes,
> > > > > > > > where the TV mode specifies both number of lines and frame rate.
> > > > > > >
> > > > > > > Only if we're using a named mode, and naming is hard :)
> > > > > >
> > > > > > That's not true: "640x480,tv_mode=PAL-N" would give me a mode with
> > > > > > 625 lines and 25 frames/s, "640x480,tv_mode=PAL-M" would give me a
> > > > > > mode with 525 lines and 30 frames/s.
> > > > >
> > > > > In that series, "640x480,tv_mode=PAL-N" would be rejected as invalid:
> > > > >
> > > > > https://lore.kernel.org/dri-devel/20220728-rpi-analog-tv-properties-v1-14-3d53ae722097@cerno.tech/
> > > >
> > > > It would become supported once the ideas from thread "[PATCH v1 04/35]
> > > > drm/modes: Introduce 480i and 576i modes" are implemented...
> > >
> > > Indeed, but I'm still not sure what your concern is here.
> > > "640x480,tv_mode=PAL-N" and "640x480,tv_mode=PAL-M" are both fairly
> > > obvious.
> > >
> > > You were initially saying that you had concern over the inconsistency of
> > > NTSC/PAL/SECAM where the TV mode would specify a number of lines and
> > > frame rate, but hd720p50 also specifies a number of line and frame rate?
> >
> > My concern is that you want to call the TV mode "hd720p", which
> > does not dictate the frame rate.
> > I would like to have both "720p50" and "720p60", as they do dictate
> > the frame rate, like all the non-hd modes.
>
> But they don't?
>
> The refresh rate is part of the drm_display_mode, whereas that property
> is metadata and entirely separate from the display mode.
>
> You can even change it without changing the mode at all

Yes, the refresh rate is part of drm_display_mode.  Vdisplay also
is, but that doesn't mean you can set it to e.g. 700 when using
"tv_mode=PAL-B". Some (combination of) parameters in drm_display_mode
are dictated by the tv_mode.

Perhaps the meaning of "tv_mode" should be clarified? What does it
really mean, and what parameters does it (not) constrain?

For e.g. "PAL-B", I know it's a mode with 625 lines and 30 frames/s
(60 fields/s).
For "hd720p" I know it is an analog mode with 750 lines, but it's still
ambiguous, as I don't know if it is the variant with 60 or 50 frames/s.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
