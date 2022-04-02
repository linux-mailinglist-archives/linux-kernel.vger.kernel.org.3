Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E49684F051C
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 19:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358600AbiDBRCH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 13:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358592AbiDBRCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 13:02:05 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4C7023BFC;
        Sat,  2 Apr 2022 10:00:12 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id bh17so11849892ejb.8;
        Sat, 02 Apr 2022 10:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1d95uWgxWqAEeS4NzrjhRN8csVGHge7TtaFw1w6jEY8=;
        b=ZzzTEiNcOz6o5GUT7vuX//kk+RW6606LKchRehEWCNxLZu+MW1SOPdKnY47EFDbHJ/
         Y0UlF4fy1WyfQPTgq0QEJSzWKdwdUlWvyR6fONIfjL3BvkFPaOyJ5Cky1+WeQoxn35Ce
         S8qZ1hEU89JiLruTWnolT+yTDiuAwsPTEA1DbkuVAewBMQhLR5y0nJlpqr0ZEe1YsfQ2
         no7ZDwTU7mx6/WXxm8T/7VJeuZAU63Eh40402PNgrOXLs1ezZAMR2wnVg39lO/xseyrv
         x1AgAeEB4Ti7eyw9nd8cn5M4Yk5BcwMY5eoHCxh6g+rPfR54H6gOcI6JmEHaAeb/+t+6
         /q2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1d95uWgxWqAEeS4NzrjhRN8csVGHge7TtaFw1w6jEY8=;
        b=0A1QWUEhRrXUboeC12yGAlL0A4lyc6Ia6eolA4VbW+vnmnLKhyDbMD5gIi/2FGBZhP
         EhqDIBUTN8KmXuewPfWOgMhQYDuzgccx/E1n4C01Dz39TCojU+srZuPkbpu4XEUmuU57
         cULPPFqC+Jc7Bp+tEEvfg/i62sD1azMiIP1wIUw0ZjCLc5547kLhqmwJPBJ3vr3TRMSU
         h/+QdqAB9dEsSkHl65v21ZDXLfv8tpPEWz1/R0NtpGLZAFqutF/m448jvH9mVnvUeDmj
         Fw909fYWDzdA3roFFwEDv9L8PVeAicDnm3UUftNuOh1KHBSVJtVWd0kIMcZEwZdSEEdo
         ac7A==
X-Gm-Message-State: AOAM532UqfvcNY7/PySIQlo7E6+yQ5fi2Agna4b7tgyMO+jpZbdtwLvG
        9XuYBAXwb4Hh7yli1gBvRgT64LDauQV5IsYWdWg=
X-Google-Smtp-Source: ABdhPJwdHs58RuuBXxWvaveuDf18gJaMH2ifHAlVaxf1JGpRCsshkezcQMGFLtDGyYlhogs/yaHWYcwviWboY1uhUuA=
X-Received: by 2002:a17:907:62a9:b0:6da:7953:4df0 with SMTP id
 nd41-20020a17090762a900b006da79534df0mr4337079ejc.316.1648918811224; Sat, 02
 Apr 2022 10:00:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220228140838.622021-1-benjamin.gaignard@collabora.com>
 <eefa63b3-2a4d-4470-9a4e-517087ebcfaf@collabora.com> <CAHCN7xL2uZTMy30FGfDkDK4Lym6wvfr_MTv7QwtchrkTXMQiuw@mail.gmail.com>
 <79a9c925-d930-ad23-dc53-9ebc16d1328a@collabora.com> <3f778844-f655-74a7-0a00-05caa84eca35@collabora.com>
 <CAHCN7xLy2381AFLWhLxk5YuRV7C=OwLX=XPXONX8sbkg-SqMjA@mail.gmail.com>
In-Reply-To: <CAHCN7xLy2381AFLWhLxk5YuRV7C=OwLX=XPXONX8sbkg-SqMjA@mail.gmail.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Sat, 2 Apr 2022 11:59:59 -0500
Message-ID: <CAHCN7xJWQa-uXb0-+CSvAr1JhFmQYt80Q=uGvaY8uyptNcfbgw@mail.gmail.com>
Subject: Re: [PATCH v4 00/15] Move HEVC stateless controls out of staging
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        mripard@kernel.org, paul.kocialkowski@bootlin.com,
        Chen-Yu Tsai <wens@csie.org>,
        "jernej.skrabec" <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Nicolas Dufresne <nicolas@ndufresne.ca>,
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
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 2, 2022 at 11:22 AM Adam Ford <aford173@gmail.com> wrote:
>
> On Fri, Apr 1, 2022 at 8:18 AM Benjamin Gaignard
> <benjamin.gaignard@collabora.com> wrote:
> >
> >
> > Le 31/03/2022 =C3=A0 08:53, Benjamin Gaignard a =C3=A9crit :
> > >
> > > Le 30/03/2022 =C3=A0 20:52, Adam Ford a =C3=A9crit :
> > >> On Wed, Mar 30, 2022 at 2:53 AM Benjamin Gaignard
> > >> <benjamin.gaignard@collabora.com> wrote:
> > >>>
> > >>> Le 28/02/2022 =C3=A0 15:08, Benjamin Gaignard a =C3=A9crit :
> > >>>> This series aims to make HEVC uapi stable and usable for hardware
> > >>>> decoder. HEVC uapi is used by 2 mainlined drivers (Cedrus and Hant=
ro)
> > >>>> and 2 out of the tree drivers (rkvdec and RPI).
> > >>>>
> > >>>> After the remarks done on version 2, I have completely reworked to
> > >>>> patches
> > >>>> split so changelogs are meaningless. I have also drop "RFC" from t=
he
> > >>>> titles.
> > >>>>
> > >>>> Version 4:
> > >>>> - Add num_entry_point_offsets field in  struct
> > >>>> v4l2_ctrl_hevc_slice_params
> > >>>> - Fix V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSETS name
> > >>>> - Initialize control V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSETS
> > >>>> - Fix space/tab issue in kernel-doc
> > >>>> - Add patch to change data_bit_offset definition
> > >>>> - Fix hantro-media SPDX license
> > >>>> - put controls under stateless section in v4l2-ctrls-defs.c
> > >>>>
> > >>>> At the end fluster tests results on IMX8MQ is 77/147 for HEVC code=
c.
> > >>> Dear reviewers,
> > >>>
> > >>> This series is waiting for your feedback,
> > >> I tried several times with the suggested repos for both the kernel a=
nd
> > >> g-streamer without success getting Fluster to pass any tests on the
> > >> imx8mq.  I can try again but I likely won't get to it until this
> > >> weekend.  If I can get it working, I'll test both the 8mq and 8mm.
> > >
> > > Thanks a lot for that.
> > >
> > > Benjamin
> >
> > Adam,
> >
> > You may need to check if h265parse and v4l2slh265dec are available on y=
our board.
>
> I ran gst-inspect to see what showed up with 265 in the name.
>
> # gst-inspect-1.0 |grep 265
> libav:  avdec_h265: libav HEVC (High Efficiency Video Coding) decoder
> rtp:  rtph265depay: RTP H265 depayloader
> rtp:  rtph265pay: RTP H265 payloader
> typefindfunctions: video/x-h265: h265, x265, 265
> v4l2codecs:  v4l2slh265dec: V4L2 Stateless H.265 Video Decoder
> videoparsersbad:  h265parse: H.265 parser
>
> It appears I have both h265parse and v4l2slh265dec.
>
> >
> > fluster check if v4l2slh265dec is working fine with this command line:
> >
> > gst-launch-1.0 appsrc num-buffers=3D0 ! h265parse ! v4l2slh265dec ! fak=
esink
> >
> > so if one of them is missing it won't work.
>
> gst-launch-1.0 appsrc num-buffers=3D0 ! h265parse ! v4l2slh265dec ! fakes=
ink
> Setting pipeline to PAUSED ...
> 0:00:00.098389938   526 0xaaaaf9d86ac0 ERROR     v4l2codecs-decoder
> gstv4l2decoder.c:725:gst_v4l2_decoder_get_controls:<v4l2decoder2>
> VIDIOC_G_EXT_CTRLS failed: Invalid argument
> ERROR: from element
> /GstPipeline:pipeline0/v4l2slh265dec:v4l2slh265dec0: Driver did not
> report framing and start code method.
> Additional debug info:
> ../subprojects/gst-plugins-bad/sys/v4l2codecs/gstv4l2codech265dec.c(155):
> gst_v4l2_codec_h265_dec_open ():
> /GstPipeline:pipeline0/v4l2slh265dec:v4l2slh265dec0:
> gst_v4l2_decoder_get_controls() failed: Invalid argument
> ERROR: pipeline doesn't want to preroll.
> ERROR: from element
> /GstPipeline:pipeline0/v4l2slh265dec:v4l2slh265dec0: Could not
> initialize supporting library.
> Additional debug info:
> ../subprojects/gst-plugins-base/gst-libs/gst/video/gstvideodecoder.c(2909=
):
> gst_video_decoder_change_state ():
> /GstPipeline:pipeline0/v4l2slh265dec:v4l2slh265dec0:
> Failed to open decoder
> ERROR: pipeline doesn't want to preroll.
> Failed to set pipeline to PAUSED.
> Setting pipeline to NULL ...
> Freeing pipeline ...
>
> Does this mean I have a wrong version of the kernel and/or incomplete pat=
ches?

I double checked the branches.

Kernel:
https://gitlab.collabora.com/benjamin.gaignard/for-upstream.git
branch:  origin/HEVC_UAPI_V4

Gstreamer:
https://gitlab.freedesktop.org/benjamin.gaignard1/gstreamer.git
branch:  origin/benjamin.gaignard1/gstreamer-HEVC_aligned_with_kernel_5.15


I am still not able to run h.265/HEVC tests.

adam
>
> adam
> >
> > Regards,
> > Benjamin
> >
> > >
> > >>
> > >> adam
> > >>> Thanks,
> > >>> Benjamin
> > >>>
> > >>>> Benjamin
> > >>>>
> > >>>>
> > >>>> Benjamin Gaignard (12):
> > >>>>     media: uapi: HEVC: Add missing fields in HEVC controls
> > >>>>     media: uapi: HEVC: Rename HEVC stateless controls with STATELE=
SS
> > >>>>       prefix
> > >>>>     media: uapi: HEVC: Add document uAPI structure
> > >>>>     media: uapi: HEVC: Define V4L2_CID_STATELESS_HEVC_SLICE_PARAMS
> > >>>> as a
> > >>>>       dynamic array
> > >>>>     media: uapi: Move parsed HEVC pixel format out of staging
> > >>>>     media: uapi: Add V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSETS
> > >>>> control
> > >>>>     media: uapi: Move the HEVC stateless control type out of stagi=
ng
> > >>>>     media: controls: Log HEVC stateless control in .std_log
> > >>>>     media: uapi: Create a dedicated header for Hantro control
> > >>>>     media: uapi: HEVC: fix padding in v4l2 control structures
> > >>>>     media: uapi: Change data_bit_offset definition
> > >>>>     media: uapi: move HEVC stateless controls out of staging
> > >>>>
> > >>>> Hans Verkuil (3):
> > >>>>     videodev2.h: add V4L2_CTRL_FLAG_DYNAMIC_ARRAY
> > >>>>     v4l2-ctrls: add support for dynamically allocated arrays.
> > >>>>     vivid: add dynamic array test control
> > >>>>
> > >>>>    .../userspace-api/media/drivers/hantro.rst    |   5 -
> > >>>>    .../media/v4l/ext-ctrls-codec-stateless.rst   | 833
> > >>>> ++++++++++++++++++
> > >>>>    .../media/v4l/ext-ctrls-codec.rst             | 780
> > >>>> ----------------
> > >>>>    .../media/v4l/pixfmt-compressed.rst           |   7 +-
> > >>>>    .../media/v4l/vidioc-g-ext-ctrls.rst          |  20 +
> > >>>>    .../media/v4l/vidioc-queryctrl.rst            |   8 +
> > >>>>    .../media/videodev2.h.rst.exceptions          |   5 +
> > >>>>    .../media/test-drivers/vivid/vivid-ctrls.c    |  15 +
> > >>>>    drivers/media/v4l2-core/v4l2-ctrls-api.c      | 103 ++-
> > >>>>    drivers/media/v4l2-core/v4l2-ctrls-core.c     | 198 ++++-
> > >>>>    drivers/media/v4l2-core/v4l2-ctrls-defs.c     |  37 +-
> > >>>>    drivers/media/v4l2-core/v4l2-ctrls-priv.h     |   3 +-
> > >>>>    drivers/media/v4l2-core/v4l2-ctrls-request.c  |  13 +-
> > >>>>    drivers/staging/media/hantro/hantro_drv.c     |  27 +-
> > >>>>    drivers/staging/media/hantro/hantro_hevc.c    |   8 +-
> > >>>>    drivers/staging/media/sunxi/cedrus/cedrus.c   |  24 +-
> > >>>>    .../staging/media/sunxi/cedrus/cedrus_dec.c   |  10 +-
> > >>>>    .../staging/media/sunxi/cedrus/cedrus_h265.c  |   2 +-
> > >>>>    include/media/hevc-ctrls.h                    | 250 ------
> > >>>>    include/media/v4l2-ctrls.h                    |  48 +-
> > >>>>    include/uapi/linux/hantro-media.h             |  19 +
> > >>>>    include/uapi/linux/v4l2-controls.h            | 439 +++++++++
> > >>>>    include/uapi/linux/videodev2.h                |  13 +
> > >>>>    23 files changed, 1697 insertions(+), 1170 deletions(-)
> > >>>>    delete mode 100644 include/media/hevc-ctrls.h
> > >>>>    create mode 100644 include/uapi/linux/hantro-media.h
> > >>>>
