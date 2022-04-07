Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAB6D4F70D3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 03:21:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239414AbiDGBWp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 21:22:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238467AbiDGBSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 21:18:20 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B12419852C;
        Wed,  6 Apr 2022 18:13:03 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id d10so4713542edj.0;
        Wed, 06 Apr 2022 18:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=g8v4shd25GPDKxW8/72Sn4jdIkSgn2LhNRd6B8RvtA0=;
        b=LjO0NIze8f21wcPliVRZEASPSuBMJxi7795FiThHlhYnCWFvy1BLzyLlMrjxjEAN5Q
         svtqL8oicLBWHKO6XfAxPWS2uhEzCDNuLw3eKKqdQQ6ivxmq7++PicRFr4a/eB1oQrGl
         09hAY+2i7kUDpweNjMFDGW5dVTomZTqS8UCYcFqy/4KHZ5a1KIMPNJD2+qkG6ddoohoe
         LUOOfikm8ZsoZ9v5CWS7TkNjkKlDQO+SL3uPRaZqcKWbKXbgeihLPVFbVtGXidWLBg2g
         Ir4N7J0o/QVusDOlmLATF/KUsVprh0R4VxT4DxwNyoowHVGdE5EYOivRMsH5ndYYTSrg
         zg7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=g8v4shd25GPDKxW8/72Sn4jdIkSgn2LhNRd6B8RvtA0=;
        b=cELaUdi/o6WhzbVasG1pHnhjRLG8p1OGNqOLPeeiRwTVr6Mzgl1f6EIfDoUQl8Fo1J
         3RQyh2dDACDWzs0QnmbhQMA6ArYmfgjPZRPuRmPXEzBtlnjCQwcIuAAX2yePh7xV03cZ
         LCIuBcNMz5yeZCrL/J4bBSstYGmHuRHaux8SnR1zNQ2+yVGAnHU84ySimd4bMm1Ew6eo
         vuYiY4nXlx/3Bk8V2d9Dew1GBmuACD8iQs5zlOBGxLQm9VqC8fG8jEZKT8e4/J1VjSR6
         vZKupxHGpCrurHbwpG+x7z4V5o3qeHxrUxQ0Jlc/upwy3ohYxXZPuAx8tjOe1mgZKhyw
         5yWw==
X-Gm-Message-State: AOAM533b8aHU3ezyZzt11mFfa99Q0oF/2WN/Tj5oVvSMVZu8Errw89Pt
        NsYSGHTtGK4udyoXQJFFOnUJOjsIHdP48/tEWaA=
X-Google-Smtp-Source: ABdhPJx/echMntfDFyiyVPC/gqKLWAbfPZwzsjwI+pWr4XJoT64OjDw/V+f5Mt+WFWOjjMUFwrwleMIKabyvLtVswQY=
X-Received: by 2002:a05:6402:430d:b0:419:45cd:7ab1 with SMTP id
 m13-20020a056402430d00b0041945cd7ab1mr11485971edc.367.1649293981787; Wed, 06
 Apr 2022 18:13:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220228140838.622021-1-benjamin.gaignard@collabora.com>
 <eefa63b3-2a4d-4470-9a4e-517087ebcfaf@collabora.com> <CAHCN7xL2uZTMy30FGfDkDK4Lym6wvfr_MTv7QwtchrkTXMQiuw@mail.gmail.com>
 <79a9c925-d930-ad23-dc53-9ebc16d1328a@collabora.com> <3f778844-f655-74a7-0a00-05caa84eca35@collabora.com>
 <CAHCN7xLy2381AFLWhLxk5YuRV7C=OwLX=XPXONX8sbkg-SqMjA@mail.gmail.com>
 <CAHCN7xJWQa-uXb0-+CSvAr1JhFmQYt80Q=uGvaY8uyptNcfbgw@mail.gmail.com>
 <163202bd-ea51-e80a-1481-568fae25b045@collabora.com> <CAHCN7x+AwNauiyaVL=NGARkmxWOL9uLS5-AO4TjkvLGNQ=3r+Q@mail.gmail.com>
 <bb462ee8-7bf9-5574-7cc2-098cc66e5ef0@collabora.com> <CAHCN7x+DTjeP7zQJYPyqzdz=hXWjz6Br0v1sWh4n1J3TJPb+9g@mail.gmail.com>
 <8d23c99a-4ad0-e65a-0134-12f5d119e8bb@collabora.com> <CAHCN7x+YuXFrMe6dYo_VhkG7ey1jcPTpOMCM1=qoTivZO9U2Rw@mail.gmail.com>
 <f495aa2b-81f7-a3cd-a6dd-cc5ae5f0a81f@collabora.com> <439e5c67e66dfff8f44f63787e2cdb8379f87446.camel@ndufresne.ca>
 <a1069c94-4c3c-ee4d-738a-752bb1d12dac@collabora.com> <CAHCN7x+hvYjoZFA6uaTXq-XfLMck-ht7Z-VzzvGpkh7H7BBbEQ@mail.gmail.com>
In-Reply-To: <CAHCN7x+hvYjoZFA6uaTXq-XfLMck-ht7Z-VzzvGpkh7H7BBbEQ@mail.gmail.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Wed, 6 Apr 2022 20:12:50 -0500
Message-ID: <CAHCN7xJwu1VnCNLHc9RNcbZ2yT4RooacA-hpwcXE3XvLrEJPGA@mail.gmail.com>
Subject: Re: [PATCH v4 00/15] Move HEVC stateless controls out of staging
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc:     Nicolas Dufresne <nicolas@ndufresne.ca>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        mripard@kernel.org, paul.kocialkowski@bootlin.com,
        Chen-Yu Tsai <wens@csie.org>,
        "jernej.skrabec" <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        linux-media <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:STAGING SUBSYSTEM" <linux-staging@lists.linux.dev>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        linux-sunxi@lists.linux.dev, kernel <kernel@collabora.com>,
        knaerzche@gmail.com, jc@kynesim.co.uk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 6, 2022 at 8:34 AM Adam Ford <aford173@gmail.com> wrote:
>
> On Wed, Apr 6, 2022 at 8:05 AM Benjamin Gaignard
> <benjamin.gaignard@collabora.com> wrote:
> >
> >
> > Le 06/04/2022 =C3=A0 15:02, Nicolas Dufresne a =C3=A9crit :
> > > Le mercredi 06 avril 2022 =C3=A0 14:50 +0200, Benjamin Gaignard a =C3=
=A9crit :
> > >>> default=3D1 value=3D1
> > >>> 1: Frame-Based
> > >>>                    hevc_start_code 0x00a40a96 (menu)   : min=3D1 ma=
x=3D1
> > >>> default=3D1 value=3D1
> > >>> 1: Annex B Start Code
> > >> It is the same so that suggest the issue is coming from GStreamer pl=
ugin.
> > > Can you report the GStreamer commit hash you have building on ? Also =
please
> > > validate the creation date of the plugin (libgstv4l2codecs.so) agains=
t your
> > > source update date. Reminder that GStreamer is now mono-repo (just in=
 case).
> > >
> > > https://gitlab.freedesktop.org/benjamin.gaignard1/gstreamer/-/tree/HE=
VC_aligned_with_kernel_5.15
> > > Hash: 54b7c1f98084c85d103446cc3f2edce42ad53b0f
> > >
> > > Benjamin, can you confirm you have no local changes and this is the h=
ash you are
> > > building from ?
> >
> > Yes that is the hash I'm using without local changes
>
> I was on (gstreamer-HEVC_aligned_with_kernel_5.15) with a hash of
> 4b78eaa48c0c924afd57f85c47396b77497e69f8
>
> Benjamin's hash wasn't listed before, but I did a git pull, and now it is=
.
>
> I've checked out that hash, and I am rebuilding it now. I'll report my
> findings when it's done.  It's building on the imx8mq, so it may take
> some time.

We're getting closer:

# gst-launch-1.0 appsrc num-buffers=3D0 ! h265parse ! v4l2slh265dec ! fakes=
ink
Setting pipeline to PAUSED ...
Pipeline is PREROLLING ...
Pipeline is PREROLLED ...
Setting pipeline to PLAYING ...
Redistribute latency...
New clock: GstSystemClock
Got EOS from element "pipeline0".
Execution ended after 0:00:00.000563180
Setting pipeline to NULL ...
Freeing pipeline ...

GStreamer-H.265-V4L2SL-Gst1.0: GStreamer H.265 V4L2SL decoder for
GStreamer 1.0... =E2=9C=94=EF=B8=8F

The statemless decoder appears to show it can do h.265, but it fails
all the fluster tests.

Ran 0/147 tests successfully               in 9.376 secs

I checked other V4L2SL decoders and items that previously passed are
failing now, so I think something is wrong or corrupted with my
system.

For some reason, my system seems unstable, so I might reinstall
everything, but it will be a slow process.  I don't know if my sd card
is wearing out, or something is wrong, but simple things like mounting
a thumb drive are taking a very long time.

I am not sure when I'll get back to this again, but I'll try to do a
re-install this weekend to see if I can get my system more stable.

adam

>
> adam
>
> >
> > Benjamin
> >
> > >
> > > regards,
> > > Nicolas
> > >
