Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EE1E46AE6A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 00:25:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376903AbhLFX3I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 18:29:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376880AbhLFX3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 18:29:06 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3DF9C061746;
        Mon,  6 Dec 2021 15:25:36 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id g14so48969446edb.8;
        Mon, 06 Dec 2021 15:25:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4jV+KqtpM7JW+L5upscVKEEk6MlCh5LAGBK1hWf/qpE=;
        b=Z/V3La0yEBh0sB7xYAIMGrElf+AakB+TTvh3Mipj2EpT+5gAHOceeF+fJ5BxtXEwmg
         lPABrBeTNgT2Zusv9Wk0K7YA23Pb+j90UBHgF03X6l+yn5NmXaTix3IKpzLjhaJ3pE9I
         vfQRB4dborFnqmnSIyYScI4E5k6wrW7+ai1HDlzGgFeNnwjE6ghtcrtnUWz+fqhAGtf9
         RnRYqVllvx7oui9kbHhIWMNBDGHDfMfU0eeSnFlgPmOcr7qQ4r9KaBUno0l2qI9EsZtT
         dLUNyNqRZ+qoiyw/rOOPoUj2exN8xnj0/lhEcdi2JSuD84553WTct1N1NrP0QUcompYL
         5PlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4jV+KqtpM7JW+L5upscVKEEk6MlCh5LAGBK1hWf/qpE=;
        b=mxfyUi3IdQ3gUSl+KORdHHPbBNsvUE3rdd8YCxgXse1p670m7mdUjR4qU2YuBImN4y
         U2iAKYDS2NKU+cciaNLvQVCTcSQMeoW5BkrydBTp9OgJzT68KRUiYqIrTwXtGyr+9UjR
         IuvfnUn7tv9jLKkVNXGDd5gh7k2+uQx9t95qNycY8bX4jCP0OB/TwXiKTIQAdoiKlUuZ
         b4gDO86jw+WoNeD1IBUHSposVN4heud9arSAbYOAKf3WUrIGzxADdMmkKQPjCbyooSiY
         4cNXwHiJdM540eECLnRbS2Kg6KIKP9EHHDr+RkBqYMYIXyoKbr3nkeOh9y0GFAjO5cEI
         Avcw==
X-Gm-Message-State: AOAM532gu3Ml7K1wLFTdu0aR50Z8SXcaHM0DXzhQBSTwUE63XEnCoG65
        ew7k086FIX9/22tOJJzl/5MBhfXsKXMr5IQSw4I=
X-Google-Smtp-Source: ABdhPJxrfMVHSOouoxr/+cSB16Q7UzeaTBXSxd4bv1eKjaKdQrKDvpgt4H1AK8+o2kVsbxd2nVyWpOLXNjYHIfnafec=
X-Received: by 2002:a05:6402:3549:: with SMTP id f9mr3446135edd.23.1638833135041;
 Mon, 06 Dec 2021 15:25:35 -0800 (PST)
MIME-Version: 1.0
References: <20211205181618.1041699-1-aford173@gmail.com> <CAHCN7xL3PSbHKZK_4NKRwhNGOZYM+i54CoKCq01a6kdbCLc2KA@mail.gmail.com>
 <3b81a33d9bbadd10bc61c3daedecc5b73b99a435.camel@ndufresne.ca> <CAHCN7xKb4YhH83oOnbXtkAKWk-3QWNNxE8EhVJ=i7xKW0wjYXw@mail.gmail.com>
In-Reply-To: <CAHCN7xKb4YhH83oOnbXtkAKWk-3QWNNxE8EhVJ=i7xKW0wjYXw@mail.gmail.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Mon, 6 Dec 2021 17:25:23 -0600
Message-ID: <CAHCN7xLh-daWTOJXxQmrjprX8uT6xn5WjvZo1M3xPW4W27vusw@mail.gmail.com>
Subject: Re: [RFC 0/5] Split iMX8MQ Hantro VPU into G1 and G2 with blk-ctrl support
To:     Nicolas Dufresne <nicolas@ndufresne.ca>
Cc:     linux-media <linux-media@vger.kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Chris Healy <cphealy@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        devicetree <devicetree@vger.kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:HANTRO VPU CODEC DRIVER" 
        <linux-rockchip@lists.infradead.org>,
        "open list:STAGING SUBSYSTEM" <linux-staging@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 6, 2021 at 4:30 PM Adam Ford <aford173@gmail.com> wrote:
>
> On Mon, Dec 6, 2021 at 2:51 PM Nicolas Dufresne <nicolas@ndufresne.ca> wr=
ote:
> >
> > Le dimanche 05 d=C3=A9cembre 2021 =C3=A0 13:51 -0600, Adam Ford a =C3=
=A9crit :
> > > On Sun, Dec 5, 2021 at 12:16 PM Adam Ford <aford173@gmail.com> wrote:
> > > >
> > > > Currently, the VPU in the i.MQ8MQ is appearing as one codec, but in=
 reality, it's
> > > > two IP blocks called G1 and G2.  There is initialization code in VP=
U code to
> > > > pull some clocks, resets and other features which has been integrat=
ed into
> > > > the vpu-blk-ctrl for the i.MX8M Mini and a similar method can be us=
ed to make
> > > > the VPU codec's operate as stand-alone cores without having to know=
 the details
> > > > of each other or the quirks unique to the i.MX8MQ, so the remaining=
 code can be
> > > > left more generic.
> > > >
> > > > This series was started by Lucas Stach, and picked up by me so some=
 patches have
> > > > his s-o-b and mine where I might have changed a few minor items.  I=
t's in an RFC state
> > > > because the G2 VP9 operations appear to hang, but the parent code f=
rom which I started doesn't
> > > > appear to show VP9 support, and it looks like it should.
> > > >
> > > > since the g-streamer and media trees are in a constant state of cha=
nge, this series is based on
> > > > git://linuxtv.org/hverkuil/media_tree.git for-v5.17e
> > > >
> > >
> > > I forgot to post Fluster results.
> > >
> > > Before the patches to this branch:
> > >
> > > 2gst-main] root@localhost:~/gstreamer/fluster# ./fluster.py list -c |=
grep -i v4l
> > >
> > >     GStreamer-H.264-V4L2-Gst1.0: GStreamer H.264 V4L2 decoder for
> > > GStreamer 1.0... =E2=9D=8C
> > >     GStreamer-H.264-V4L2SL-Gst1.0: GStreamer H.264 V4L2SL decoder for
> > > GStreamer 1.0... =E2=9C=94=EF=B8=8F
> > >     GStreamer-H.265-V4L2-Gst1.0: GStreamer H.265 V4L2 decoder for
> > > GStreamer 1.0... =E2=9D=8C
> > >     GStreamer-H.265-V4L2SL-Gst1.0: GStreamer H.265 V4L2SL decoder for
> > > GStreamer 1.0... =E2=9D=8C
> > >     GStreamer-VP8-V4L2-Gst1.0: GStreamer VP8 V4L2 decoder for GStream=
er 1.0... =E2=9D=8C
> > >     GStreamer-VP8-V4L2SL-Gst1.0: GStreamer VP8 V4L2SL decoder for
> > > GStreamer 1.0... =E2=9C=94=EF=B8=8F
> > >     GStreamer-VP9-V4L2SL-Gst1.0: GStreamer VP9 V4L2SL decoder for
> > > GStreamer 1.0... =E2=9D=8C
> > >     GStreamer-AV1-V4L2SL-Gst1.0: GStreamer AV1 V4L2SL decoder for
> > > GStreamer 1.0... =E2=9D=8C
> > > [gst-main] root@localhost:~/gstreamer/fluster#
> > >
> > > There was no VP9 support.
> > >
> > > ./fluster.py run -dGStreamer-H.264-V4L2SL-Gst1.0
> > > GStreamer-H.264-V4L2SL-Gst1.0
> > > Ran 90/135 tests successfully               in 58.787 secs
> > >
> > > AFTER this series, two decoders appear:
> > >
> > > [   15.919137] hantro-vpu 38300000.video-codec: registered
> > > nxp,imx8mq-vpu-g1-dec as /dev/video0
> > > [   15.983579] hantro-vpu 38310000.video-codec: registered
> > > nxp,imx8mq-vpu-g2-dec as /dev/video1
> > >
> > > VP9 was listed:
> > >
> > >     GStreamer-H.264-V4L2-Gst1.0: GStreamer H.264 V4L2 decoder for
> > > GStreamer 1.0... =E2=9D=8C
> > >     GStreamer-H.264-V4L2SL-Gst1.0: GStreamer H.264 V4L2SL decoder for
> > > GStreamer 1.0... =E2=9C=94=EF=B8=8F
> > >     GStreamer-H.265-V4L2-Gst1.0: GStreamer H.265 V4L2 decoder for
> > > GStreamer 1.0... =E2=9D=8C
> > >     GStreamer-H.265-V4L2SL-Gst1.0: GStreamer H.265 V4L2SL decoder for
> > > GStreamer 1.0... =E2=9D=8C
> > >     GStreamer-VP8-V4L2-Gst1.0: GStreamer VP8 V4L2 decoder for GStream=
er 1.0... =E2=9D=8C
> > >     GStreamer-VP8-V4L2SL-Gst1.0: GStreamer VP8 V4L2SL decoder for
> > > GStreamer 1.0... =E2=9C=94=EF=B8=8F
> > >     GStreamer-VP9-V4L2SL-Gst1.0: GStreamer VP9 V4L2SL decoder for
> > > GStreamer 1.0... =E2=9C=94=EF=B8=8F
> > >     GStreamer-AV1-V4L2SL-Gst1.0: GStreamer AV1 V4L2SL decoder for
> > > GStreamer 1.0... =E2=9D=8C
> > >
> > > ./fluster.py run -d GStreamer-VP8-V4L2SL-Gst1.0
> > > Ran 55/61 tests successfully               in 8.565 secs
> > >
> > >
> > > ./fluster.py run -dGStreamer-H.264-V4L2SL-Gst1.0
> > > Ran 90/135 tests successfully               in 60.269 secs
> > >
> > > Same results for H.264
> > >
> > > VP9 Hangs, where it didn't even appear as available before:
> > >
> > > ./fluster.py run -d GStreamer-VP9-V4L2SL-Gst1.0
> > > *********************************************************************=
*******************************
> > > Running test suite VP9-TEST-VECTORS with decoder GStreamer-VP9-V4L2SL=
-Gst1.0
> > > Using 4 parallel job(s)
> > > *********************************************************************=
*******************************
> > >
> > > [TEST SUITE      ] (DECODER                    ) TEST VECTOR
> > >                           ... RESULT
> > > ---------------------------------------------------------------------=
-
> > > [VP9-TEST-VECTORS] (GStreamer-VP9-V4L2SL-Gst1.0)
> > > vp90-2-00-quantizer-00.webm                     ... Success
> > > [VP9-TEST-VECTORS] (GStreamer-VP9-V4L2SL-Gst1.0)
> > > vp90-2-00-quantizer-01.webm                     ... Success
> > > [VP9-TEST-VECTORS] (GStreamer-VP9-V4L2SL-Gst1.0)
> > > vp90-2-00-quantizer-02.webm                     ... Succes
> > >
> > > <hang > - and yes, 'Success' didnt' finish writing to the serial port=
.
> >
> > Looks like hope to me ! Do you get further with -j 1 (one concurrent de=
code) ?
>
> Anything after the first attempt appears to fail.  I haven't figured
> out if it's the G2 code or the power domain stuff.  Since VP9 didn't
> work I migrated it to use the vpu-blk-ctrl, I can't really compare to
> know if it was a regression or an improvement.
>
> :-)
>
I managed to get the vpu-blk-ctrl updated to address the G2 hanging.

./fluster.py run -d GStreamer-VP9-V4L2SL-Gst1.0
Ran 144/303 tests successfully               in 224.847 secs

Since I couldn't get it to work before the split, I am not sure if
this is good or not.  I also wasn't sure if I needed to allocate more
CMA for this.

If/when people can give me some feedback on the RFC's, I'll submit an
updated formal patch for both the i.MQ8MQ and the i.MQ8M Mini as one
series based on  "for-v5.17e" from
git://linuxtv.org/hverkuil/media_tree.git

I wasn't sure if I needed to break up the migration from a combined
VPU to split G1 and G2.  I might need some help/suggestions on the
YAML, because I struggle with that part a little, but I'd like the 8MM
to use the 8MQ dt-binding yaml file since they are so similar.

I hope to have some more time this week because my weekends are
completely booked for the rest of the year, and leave for London, on
23 Dec 2021 and I won't return until 5 Jan 2022.


> adam
>
> >
> > >
> > >
> > >
> > > > Adam Ford (2):
> > > >   media: hantro: split i.MX8MQ G1 and G2 code
> > > >   arm64: dts: imx8mq: Split i.MX8MQ G1 and G2 with vpu-blk-ctrl
> > > >
> > > > Lucas Stach (3):
> > > >   dt-bindings: power: imx8mq: add defines for VPU blk-ctrl domains
> > > >   dt-bindings: soc: add binding for i.MX8MQ VPU blk-ctrl
> > > >   soc: imx: imx8m-blk-ctrl: add i.MX8MQ VPU blk-ctrl
> > > >
> > > >  .../soc/imx/fsl,imx8mq-vpu-blk-ctrl.yaml      |  71 +++++++++++
> > > >  arch/arm64/boot/dts/freescale/imx8mq.dtsi     |  69 ++++++----
> > > >  drivers/soc/imx/imx8m-blk-ctrl.c              |  67 ++++++++++
> > > >  drivers/staging/media/hantro/hantro_drv.c     |   4 +-
> > > >  drivers/staging/media/hantro/hantro_hw.h      |   2 +-
> > > >  drivers/staging/media/hantro/imx8m_vpu_hw.c   | 119 +++-----------=
----
> > > >  include/dt-bindings/power/imx8mq-power.h      |   3 +
> > > >  7 files changed, 205 insertions(+), 130 deletions(-)
> > > >  create mode 100644 Documentation/devicetree/bindings/soc/imx/fsl,i=
mx8mq-vpu-blk-ctrl.yaml
> > > >
> > > > --
> > > > 2.32.0
> > > >
> >
