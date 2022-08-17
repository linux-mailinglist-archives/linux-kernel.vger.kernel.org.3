Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C446596FAD
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 15:19:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239654AbiHQNIt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 09:08:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239726AbiHQNIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 09:08:24 -0400
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 061729677F
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 06:06:07 -0700 (PDT)
Received: by mail-qt1-f182.google.com with SMTP id h21so10289079qta.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 06:06:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=wT+w/e1pir6od65k8fW73wcIBpWHrOcKqnuAFp6tc4E=;
        b=n8XRE76JvvAIouDx6x746plNd5MtzBj9qOBFDMQvbQzmcg7bbBscetGNpsqi8biuVp
         OBEeNx5IVFI75/t9WkxPdZEhuTJnbfw6Kgb/07+8Wf8yp6wq8gxNR6DntLhoWX4TNGHg
         Uk5sCdFWcrk0OV57zZjn3BDsMnUNoh+CafjCZTSPKDDFvuUE3L6ysxsd/q0WCBQ7h6ey
         6bWcDLiM5w2Fvgo8FwWp+HezmGJMHhop9QE9coTUpGlIolW0TpiUPQRKXvo93ChU2KdB
         3vw0WkrHe0+CCVNwbAwsLhcpurPKe3glo7Ja+3+fAjSYkYGTKKJp9Zc2KBPKoBjKuRlo
         zk/Q==
X-Gm-Message-State: ACgBeo3o2v2QQ47Y5o5xiGhBfCbbiTFdDyiglESJYc4yqs4zehoJ7P9i
        huJFuf4Z6bYVky+qGC4KnuSFKxohyKM3Bg==
X-Google-Smtp-Source: AA6agR7ZEWfL1o7H7FKdtRLkzNe+fnQBB3x6ZRXqnuLGqnEfcjWp+5xrU1Fy3JUM1uxm/l8GjnYsfw==
X-Received: by 2002:ac8:7dcd:0:b0:344:5abb:afeb with SMTP id c13-20020ac87dcd000000b003445abbafebmr12983062qte.133.1660741565635;
        Wed, 17 Aug 2022 06:06:05 -0700 (PDT)
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com. [209.85.128.180])
        by smtp.gmail.com with ESMTPSA id t201-20020a37aad2000000b006b9264191b5sm14872846qke.32.2022.08.17.06.06.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Aug 2022 06:06:05 -0700 (PDT)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-332fc508d88so159680747b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 06:06:04 -0700 (PDT)
X-Received: by 2002:a81:502:0:b0:32f:dcc4:146e with SMTP id
 2-20020a810502000000b0032fdcc4146emr14565309ywf.316.1660741564697; Wed, 17
 Aug 2022 06:06:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220728-rpi-analog-tv-properties-v1-5-3d53ae722097@cerno.tech>
 <CAMuHMdWYo7M44uLNhTmJenGDreGALBZ9E48oyBDEeAuL=0h=dw@mail.gmail.com>
 <20220816132040.uwirtjm5yr6rdd3q@houat> <CAMuHMdWevP=3af=NneAJEDfOR+sz1thrQEhAQPNGrgitBtLjGA@mail.gmail.com>
 <20220816141116.5nuszmilqv2exdb3@houat> <CAMuHMdXq_xGPx46bdnUFGDiG4kcgdxtXaRGTucFd3TRq8353dg@mail.gmail.com>
 <20220816154956.pkdpxmmw27mia5ix@houat> <CAMuHMdX0L6cO_jYXKZTv0sm9V39Eiy_STiknSkdRQG4k-9GJeg@mail.gmail.com>
 <20220817074710.w4c4xwj7edly2b5p@houat> <CAMuHMdXeBakWr6geOWGxnjQYaU9Pi4tRvVFFtubyMJZTT2nPnw@mail.gmail.com>
 <20220817111454.pn2iltvyo2drebq7@houat>
In-Reply-To: <20220817111454.pn2iltvyo2drebq7@houat>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 17 Aug 2022 15:05:52 +0200
X-Gmail-Original-Message-ID: <CAMuHMdU57g1rNoLo65jhLK8mk4YkNEbMz1E7XKWk2dnCxTr=gg@mail.gmail.com>
Message-ID: <CAMuHMdU57g1rNoLo65jhLK8mk4YkNEbMz1E7XKWk2dnCxTr=gg@mail.gmail.com>
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
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime,

On Wed, Aug 17, 2022 at 1:15 PM Maxime Ripard <maxime@cerno.tech> wrote:
> On Wed, Aug 17, 2022 at 10:35:07AM +0200, Geert Uytterhoeven wrote:
> > On Wed, Aug 17, 2022 at 9:47 AM Maxime Ripard <maxime@cerno.tech> wrote:
> > > On Wed, Aug 17, 2022 at 09:31:18AM +0200, Geert Uytterhoeven wrote:
> > > > On Tue, Aug 16, 2022 at 5:50 PM Maxime Ripard <maxime@cerno.tech> wrote:
> > > > > On Tue, Aug 16, 2022 at 04:43:44PM +0200, Geert Uytterhoeven wrote:
> > > > > > > > > > Either you have to add them here (e.g. "hd720p50" and "hd720p60"), or
> > > > > > > > > > handle them through "@<refresh>".  The latter would impact "[PATCH v1
> > > > > > > > > > 09/35] drm/modes: Move named modes parsing to a separate function", as
> > > > > > > > > > currently a named mode and a refresh rate can't be specified both.
> > > > > > > > >
> > > > > > > > > I think the former would make more sense. It simplifies a bit the
> > > > > > > > > parser, and we're going to use a named mode anyway.
> > > > > > > > >
> > > > > > > > > > As "[PATCH v1 34/35] drm/modes: Introduce the tv_mode property as a
> > > > > > > > > > command-line option" uses a separate "tv_mode" option, and not the main
> > > > > > > > > > mode name, I think you want to add them here.
> > > > > > > > >
> > > > > > > > > It's a separate story I think, we could have a named mode hd720p50,
> > > > > > > > > which would be equivalent to 1280x720,tv_mode=hd720p
> > > > > > > >
> > > > > > > > So where's the field rate in "1280x720,tv_mode=hd720p"?
> > > > > > >
> > > > > > > Yeah, sorry I meant 1280x720@50,tv_mode=hd720p
> > > > > >
> > > > > > Above you said "I think the former would make more sense", so that
> > > > > > should be "1280x720,tv_mode=hd720p50"?
> > > > >
> > > > > No, 720p at 50Hz would be either hd720p50 or 1280x720@50,tv_mode=hd720p
> > > > > and 60Hz would be hd720p60 or 1280x720@60,tv_mode=hd720p
> > > >
> > > > I disagree: hd720p50 and hd720p60 are different TV modes.
> > >
> > > I agree, and I don't see how that command-line doesn't express that?
> >
> > Oh, I see what you mean: yes, it expresses that.
> > But it is inconsistent with the NTSC/PAL/SECAM/hd{480,576}[ip] modes,
> > where the TV mode specifies both number of lines and frame rate.
>
> Only if we're using a named mode, and naming is hard :)

That's not true: "640x480,tv_mode=PAL-N" would give me a mode with
625 lines and 25 frames/s, "640x480,tv_mode=PAL-M" would give me a
mode with 525 lines and 30 frames/s.

> Honestly, I'd be inclined to drop the hd* for now from this series. I
> don't have a hardware to test it with, for some we don't even have
> drivers that could implement these modes, we don't have a spec to work
> from, it looks like a recipe for failure :)

OK.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
