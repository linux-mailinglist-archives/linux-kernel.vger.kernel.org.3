Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 758C5596B67
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 10:37:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233471AbiHQIfl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 04:35:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbiHQIf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 04:35:26 -0400
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED1746B8C4
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 01:35:24 -0700 (PDT)
Received: by mail-qk1-f179.google.com with SMTP id t11so9878848qkt.6
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 01:35:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=oGUO+aRsBeoQZf7v2A5uqTblY/HRl0z6pHKiV+qcGIw=;
        b=g2NTkCq+uUd7EHpqMzcwq8Bca/f8Nj5w9BBQp5/JubnVdRgcsBsyniTZmi8GmjBz3F
         ejIb6AT/bEoWBPJkOUApmyG9I5HLVIlL8ze31tLXrwkydiL9YG6F7eDJT3lqTjcOfLQA
         CjZkxRyWzwiiGxWdHWj3bjdTBdPNMx9DPPqSvEQ72mDQMesHVN54m97iCDQPYHVD0RMQ
         OaMjNq3xsuQxhLL7muXW2pD7gXLv2HrLYuAGqyWsqsBiZrtm2NRTd5Ketz5I1+gDmaLt
         dK0Er/JKvD6oNKeo05vicZu5GBjMnEVMFCmjw8JucjajQIxZ6pEz1d1K7NVkBMvv9oBC
         T2wQ==
X-Gm-Message-State: ACgBeo3zGUnpOTvBhBJOLOjIPjWaWr3zs78FCxzYmv6n5BC0I2mRUgRV
        nHR4WgWdfJWa4fd/jhxS+V87+R8BVr+JTQ==
X-Google-Smtp-Source: AA6agR4F+HLiaDZnJ4aLWsB8qYNowZJijAHG/aCZU7ByvMegW6vmTSQDbXX23HzRNd26jS5Llxk0rw==
X-Received: by 2002:a05:620a:4692:b0:6bb:5a0c:9ca1 with SMTP id bq18-20020a05620a469200b006bb5a0c9ca1mr5927724qkb.318.1660725323654;
        Wed, 17 Aug 2022 01:35:23 -0700 (PDT)
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com. [209.85.128.170])
        by smtp.gmail.com with ESMTPSA id o3-20020ac85a43000000b00342f8d4d0basm12627687qta.43.2022.08.17.01.35.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Aug 2022 01:35:21 -0700 (PDT)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-3321c2a8d4cso160476977b3.5
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 01:35:20 -0700 (PDT)
X-Received: by 2002:a05:6902:100a:b0:676:ed53:25b0 with SMTP id
 w10-20020a056902100a00b00676ed5325b0mr17391450ybt.365.1660725320216; Wed, 17
 Aug 2022 01:35:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220728-rpi-analog-tv-properties-v1-0-3d53ae722097@cerno.tech>
 <20220728-rpi-analog-tv-properties-v1-5-3d53ae722097@cerno.tech>
 <CAMuHMdWYo7M44uLNhTmJenGDreGALBZ9E48oyBDEeAuL=0h=dw@mail.gmail.com>
 <20220816132040.uwirtjm5yr6rdd3q@houat> <CAMuHMdWevP=3af=NneAJEDfOR+sz1thrQEhAQPNGrgitBtLjGA@mail.gmail.com>
 <20220816141116.5nuszmilqv2exdb3@houat> <CAMuHMdXq_xGPx46bdnUFGDiG4kcgdxtXaRGTucFd3TRq8353dg@mail.gmail.com>
 <20220816154956.pkdpxmmw27mia5ix@houat> <CAMuHMdX0L6cO_jYXKZTv0sm9V39Eiy_STiknSkdRQG4k-9GJeg@mail.gmail.com>
 <20220817074710.w4c4xwj7edly2b5p@houat>
In-Reply-To: <20220817074710.w4c4xwj7edly2b5p@houat>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 17 Aug 2022 10:35:07 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXeBakWr6geOWGxnjQYaU9Pi4tRvVFFtubyMJZTT2nPnw@mail.gmail.com>
Message-ID: <CAMuHMdXeBakWr6geOWGxnjQYaU9Pi4tRvVFFtubyMJZTT2nPnw@mail.gmail.com>
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

On Wed, Aug 17, 2022 at 9:47 AM Maxime Ripard <maxime@cerno.tech> wrote:
> On Wed, Aug 17, 2022 at 09:31:18AM +0200, Geert Uytterhoeven wrote:
> > On Tue, Aug 16, 2022 at 5:50 PM Maxime Ripard <maxime@cerno.tech> wrote:
> > > On Tue, Aug 16, 2022 at 04:43:44PM +0200, Geert Uytterhoeven wrote:
> > > > > > > > Either you have to add them here (e.g. "hd720p50" and "hd720p60"), or
> > > > > > > > handle them through "@<refresh>".  The latter would impact "[PATCH v1
> > > > > > > > 09/35] drm/modes: Move named modes parsing to a separate function", as
> > > > > > > > currently a named mode and a refresh rate can't be specified both.
> > > > > > >
> > > > > > > I think the former would make more sense. It simplifies a bit the
> > > > > > > parser, and we're going to use a named mode anyway.
> > > > > > >
> > > > > > > > As "[PATCH v1 34/35] drm/modes: Introduce the tv_mode property as a
> > > > > > > > command-line option" uses a separate "tv_mode" option, and not the main
> > > > > > > > mode name, I think you want to add them here.
> > > > > > >
> > > > > > > It's a separate story I think, we could have a named mode hd720p50,
> > > > > > > which would be equivalent to 1280x720,tv_mode=hd720p
> > > > > >
> > > > > > So where's the field rate in "1280x720,tv_mode=hd720p"?
> > > > >
> > > > > Yeah, sorry I meant 1280x720@50,tv_mode=hd720p
> > > >
> > > > Above you said "I think the former would make more sense", so that
> > > > should be "1280x720,tv_mode=hd720p50"?
> > >
> > > No, 720p at 50Hz would be either hd720p50 or 1280x720@50,tv_mode=hd720p
> > > and 60Hz would be hd720p60 or 1280x720@60,tv_mode=hd720p
> >
> > I disagree: hd720p50 and hd720p60 are different TV modes.
>
> I agree, and I don't see how that command-line doesn't express that?

Oh, I see what you mean: yes, it expresses that.
But it is inconsistent with the NTSC/PAL/SECAM/hd{480,576}[ip] modes,
where the TV mode specifies both number of lines and frame rate.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
