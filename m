Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEF5A4CD49F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 13:59:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235242AbiCDNAQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 08:00:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231825AbiCDNAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 08:00:14 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFD2417CC5C;
        Fri,  4 Mar 2022 04:59:26 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id r13so17356468ejd.5;
        Fri, 04 Mar 2022 04:59:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ln4FCzFPSro+Ut4SgBBNjvILZ4e+LysX8Gy/fmSPh5g=;
        b=P+Ohi+IdH1WH7ELc1GY8Dqz3xuAIwLJFPIogyC/GDStdmMkEcFMOWUl3yGCIrWZ34w
         DJVISgjifRusB8R56aA7KAgi7u7t/Sg/6nLMlDDPmsL09r8TMtawC8eb2qZ+ddqRu8Eg
         XhNINQWf3mCr0wbiFRLiQQBpcAlDeQUBlAR1AUFIkGQSKz8TVQrjNc+BFyKBTtAS82Kx
         Iw0gBeeHaknqA/eXD9Sx8oTmWW0tMKFbiqglhyOIvoRx1FledNnO07r8z0MJbHsRBUTD
         oH37WGe29ACtCA59dzHW9NSndYxEvgQ8NNKFKMDGbSERPDCrKN0e46vaM0m2Qg9KMSdn
         CH3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ln4FCzFPSro+Ut4SgBBNjvILZ4e+LysX8Gy/fmSPh5g=;
        b=8MXlxPPULvCDyqIapQtGEOKJshc6kZh7kU93Zm/Ys5RKE+nSNrUKQM174RKoIGKVhS
         A2nrCDIfQ0cQUNk/Kqkmvkgc9M2/Tm+leZRI6nPMAH7WRIAnjhf9TJOjFdt7SEAMnuC9
         HSvJ8IKofhoLizS9OCvuli5ZksVpWWY30yDUSzXHLRPNaxPgPFYDWIjBPMjzWk+m0erv
         oNvimBateCKmlhNc42htuZ5molIOqdjawiTfElj0+DBuMqKipA8Ph7URygKY15C7y13T
         2rin5hB54udyZXdpZg1UQHSlhU5leRgZyoxUXKMmGm1buO2R3Brclj9kN70/Bys6OeHD
         /Bmw==
X-Gm-Message-State: AOAM532el8dph99ZbWhH40b4M8dmFeNpDdsR/2sn9tEttRQxAlASqzeN
        7bLrYlXrbKwwVt+7k4kA2m1X89dP5pGOAgKIa7s=
X-Google-Smtp-Source: ABdhPJy5ATyl9FikK6JTQ2LV3A6ScWCl741hg3bhCI4Kftprbltxss7tD4scm6SywmqRJeO57KOSgF/1m8GMnBhA3jc=
X-Received: by 2002:a17:907:7704:b0:6cf:48ac:b4a8 with SMTP id
 kw4-20020a170907770400b006cf48acb4a8mr30127074ejc.305.1646398764922; Fri, 04
 Mar 2022 04:59:24 -0800 (PST)
MIME-Version: 1.0
References: <20220225164600.1044663-1-benjamin.gaignard@collabora.com>
 <CAHCN7x+AUy4JsqfdyZFqg4ScR1OgoLvqF91za0AZ278NSBJj4A@mail.gmail.com>
 <b832271d-cecd-a373-48ff-ba5ce736e47d@collabora.com> <CAHCN7xJ3K2bLEc8dcTM+x-E0brDW-t4yrUdkUe0jCfuzH8v9pA@mail.gmail.com>
 <678c1f01-c6cd-d1be-bd0b-277a808b006a@collabora.com>
In-Reply-To: <678c1f01-c6cd-d1be-bd0b-277a808b006a@collabora.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Fri, 4 Mar 2022 06:59:14 -0600
Message-ID: <CAHCN7xL-+1cXbcOpRU8BRXoyAkecERqT-O8vM_069er8WWWEaw@mail.gmail.com>
Subject: Re: [PATCH v3 00/14] Move HEVC stateless controls out of staging
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

On Thu, Mar 3, 2022 at 4:13 AM Benjamin Gaignard
<benjamin.gaignard@collabora.com> wrote:
>
>
> Le 03/03/2022 =C3=A0 02:23, Adam Ford a =C3=A9crit :
> > On Mon, Feb 28, 2022 at 4:13 AM Benjamin Gaignard
> > <benjamin.gaignard@collabora.com> wrote:
> >>
> >> Le 26/02/2022 =C3=A0 23:25, Adam Ford a =C3=A9crit :
> >>> On Fri, Feb 25, 2022 at 4:41 PM Benjamin Gaignard
> >>> <benjamin.gaignard@collabora.com> wrote:
> >>>> This series aims to make HEVC uapi stable and usable for hardware
> >>>> decoder. HEVC uapi is used by 2 mainlined drivers (Cedrus and Hantro=
)
> >>>> and 2 out of the tree drivers (rkvdec and RPI).
> >>>>
> >>>> After the remarks done on version 2, I have completely reworked to p=
atches
> >>>> split so changelogs are meaningless. I have also drop "RFC" from the
> >>>> titles.
> >>>>
> >>>> In this v3 I do all the changes (new controls, documentation, etc..)
> >>>> in the staging directory before moving the HEVC uAPI to stable
> >>>> steps by steps (unlike the big one patch in v2).
> >>>>
> >>>> At the end fluster tests results on IMX8MQ is 77/147 for HEVC codec.
> >> I have push a branch here:
> >> https://gitlab.collabora.com/benjamin.gaignard/for-upstream/-/commits/=
HEVC_UAPI_V4
> >>
> >> it is the incoming version 4 of this series + patches to enable G2 on =
my IMX8MQ
> > Benjamin,
> >
> > I checked this repo out, and built it along with pulling the latest
> > versions of G-streamer and fluster.
> > When I check for v4l2 compatibility, I get the following:
> >
> >      GStreamer-H.264-V4L2-Gst1.0: GStreamer H.264 V4L2 decoder for
> > GStreamer 1.0... =E2=9D=8C
> >      GStreamer-H.264-V4L2SL-Gst1.0: GStreamer H.264 V4L2SL decoder for
> > GStreamer 1.0... =E2=9C=94=EF=B8=8F
> >      GStreamer-AV1-V4L2SL-Gst1.0: GStreamer AV1 V4L2SL decoder for
> > GStreamer 1.0... =E2=9D=8C
> >      GStreamer-H.265-V4L2-Gst1.0: GStreamer H.265 V4L2 decoder for
> > GStreamer 1.0... =E2=9D=8C
> >      GStreamer-H.265-V4L2SL-Gst1.0: GStreamer H.265 V4L2SL decoder for
> > GStreamer 1.0... =E2=9D=8C
> >      GStreamer-VP8-V4L2-Gst1.0: GStreamer VP8 V4L2 decoder for GStreame=
r 1.0... =E2=9D=8C
> >      GStreamer-VP8-V4L2SL-Gst1.0: GStreamer VP8 V4L2SL decoder for
> > GStreamer 1.0... =E2=9C=94=EF=B8=8F
> >      GStreamer-VP9-V4L2SL-Gst1.0: GStreamer VP9 V4L2SL decoder for
> > GStreamer 1.0... =E2=9C=94=EF=B8=8F
> >
> > I see H,264, VP8 and VP9, but I would have also expected
> > GStreamer-H.265-V4L2SL-Gst1.0 to return with a check box.
> >
> > When I checked to see if both decoders were being enumerated, I found t=
hey were.
> > [gst-main] root@localhost:~/gstreamer/fluster# dmesg |grep -i hantro
> > [   16.044243] hantro_vpu: module is from the staging directory, the
> > quality is unknown, you have been warned.
> > [   16.044243] hantro_vpu: module is from the staging directory, the
> > quality is unknown, you have been warned.
> > [   16.095661] hantro-vpu 38300000.video-codec: registered
> > nxp,imx8mq-vpu-g1-dec as /dev/video0
> > [   16.096782] hantro-vpu 38310000.video-codec: registered
> > nxp,imx8mq-vpu-g2-dec as /dev/video1
> >
> > Did I do something wrong, or did I miss something?
>
> Hi Adam,
>
> I guess it could be a misalignment between v4l2 kernel headers
> and GStreamer v4l2 headers.
> I have push a new version of the GST merge request which is aligned with
> HEVC uAPI v4 proposal.
>
> When you inspect v4l2codecs gst plugin (gst-inspect-1.0 v4l2codecs) do
> you see v4l2slh265dec plugin ?
> I have fluster happy with it:
> ./fluster.py list -c

I pulled the latest from g-streamer's git repo again, and re-built.
gst-instpect does not appear to show the h265 codec anymore.

# gst-inspect-1.0 |grep v4l2codecs
v4l2codecs:  v4l2slh264dec: V4L2 Stateless H.264 Video Decoder
v4l2codecs:  v4l2slmpeg2dec: V4L2 Stateless Mpeg2 Video Decoder
v4l2codecs:  v4l2slvp8alphadecodebin: VP8 Alpha Decoder
v4l2codecs:  v4l2slvp8dec: V4L2 Stateless VP8 Video Decoder
v4l2codecs:  v4l2slvp9alphadecodebin: VP9 Alpha Decoder
v4l2codecs:  v4l2slvp9dec: V4L2 Stateless VP9 Video Decoder

Is there a specific branch of g-streamer I should be using that can
handle the newer API?

adam
>
>
> H265
>      ...
>      GStreamer-H.265-V4L2-Gst1.0: GStreamer H.265 V4L2 decoder for GStrea=
mer 1.0... =E2=9D=8C
>      GStreamer-H.265-V4L2SL-Gst1.0: GStreamer H.265 V4L2SL decoder for GS=
treamer 1.0... =E2=9C=94=EF=B8=8F
>      GStreamer-H.265-VA-Gst1.0: GStreamer H.265 VA decoder for GStreamer =
1.0... =E2=9D=8C
>      GStreamer-H.265-VAAPI-Gst1.0: GStreamer H.265 VAAPI decoder for GStr=
eamer 1.0... =E2=9D=8C
>      JCT-VT-H.265: JCT-VT H.265/HEVC reference decoder... =E2=9D=8C
>
> I hope that will help you,
>
> Regards,
> Benjamin
>
> >
> > adam
> >
> >> Regards,
> >> Benjamin
> >>
> >>> Benjamin,
> >>>
> >>> I have an imx8mm and imx8mq that I can test. Do you happen to have a
> >>> repo that I can clone to test this?  The imx8m stuff is spread around
> >>> between the media tree and the imx tree since it hasn't been fully
> >>> merged yet.
> >>>
> >>> thanks,
> >>>
> >>> adam
> >>>
> >>>> Benjamin
> >>>>
> >>>> Benjamin Gaignard (11):
> >>>>     media: uapi: HEVC: Add missing fields in HEVC controls
> >>>>     media: uapi: HEVC: Rename HEVC stateless controls with STATELESS
> >>>>       prefix
> >>>>     media: uapi: HEVC: Add document uAPI structure
> >>>>     media: uapi: HEVC: Define V4L2_CID_STATELESS_HEVC_SLICE_PARAMS a=
s a
> >>>>       dynamic array
> >>>>     media: uapi: Move parsed HEVC pixel format out of staging
> >>>>     media: uapi: Add V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSET cont=
rol
> >>>>     media: uapi: Move the HEVC stateless control type out of staging
> >>>>     media: controls: Log HEVC stateless control in .std_log
> >>>>     media: uapi: Create a dedicated header for Hantro control
> >>>>     media: uapi: HEVC: fix padding in v4l2 control structures
> >>>>     media: uapi: move HEVC stateless controls out of staging
> >>>>
> >>>> Hans Verkuil (3):
> >>>>     videodev2.h: add V4L2_CTRL_FLAG_DYNAMIC_ARRAY
> >>>>     v4l2-ctrls: add support for dynamically allocated arrays.
> >>>>     vivid: add dynamic array test control
> >>>>
> >>>>    .../userspace-api/media/drivers/hantro.rst    |   5 -
> >>>>    .../media/v4l/ext-ctrls-codec-stateless.rst   | 831 +++++++++++++=
+++++
> >>>>    .../media/v4l/ext-ctrls-codec.rst             | 780 -------------=
---
> >>>>    .../media/v4l/pixfmt-compressed.rst           |   7 +-
> >>>>    .../media/v4l/vidioc-g-ext-ctrls.rst          |  20 +
> >>>>    .../media/v4l/vidioc-queryctrl.rst            |   8 +
> >>>>    .../media/videodev2.h.rst.exceptions          |   5 +
> >>>>    .../media/test-drivers/vivid/vivid-ctrls.c    |  15 +
> >>>>    drivers/media/v4l2-core/v4l2-ctrls-api.c      | 103 ++-
> >>>>    drivers/media/v4l2-core/v4l2-ctrls-core.c     | 198 ++++-
> >>>>    drivers/media/v4l2-core/v4l2-ctrls-defs.c     |  32 +-
> >>>>    drivers/media/v4l2-core/v4l2-ctrls-priv.h     |   3 +-
> >>>>    drivers/media/v4l2-core/v4l2-ctrls-request.c  |  13 +-
> >>>>    drivers/staging/media/hantro/hantro_drv.c     |  27 +-
> >>>>    drivers/staging/media/hantro/hantro_hevc.c    |   8 +-
> >>>>    drivers/staging/media/sunxi/cedrus/cedrus.c   |  24 +-
> >>>>    .../staging/media/sunxi/cedrus/cedrus_dec.c   |  10 +-
> >>>>    include/media/hevc-ctrls.h                    | 250 ------
> >>>>    include/media/v4l2-ctrls.h                    |  48 +-
> >>>>    include/uapi/linux/hantro-media.h             |  19 +
> >>>>    include/uapi/linux/v4l2-controls.h            | 436 +++++++++
> >>>>    include/uapi/linux/videodev2.h                |  13 +
> >>>>    22 files changed, 1686 insertions(+), 1169 deletions(-)
> >>>>    delete mode 100644 include/media/hevc-ctrls.h
> >>>>    create mode 100644 include/uapi/linux/hantro-media.h
> >>>>
> >>>> --
> >>>> 2.32.0
> >>>>
