Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86BAD4635F9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 15:00:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235326AbhK3OEG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 09:04:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241951AbhK3OD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 09:03:57 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F787C061748
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 06:00:38 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id t5so87498662edd.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 06:00:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QaxZlmGeTiNSpZpCZqH57v2oCRS32AJdCJEiZtFl+fo=;
        b=UAL3sYoqWMmwujNOP724FqBzW5uObd++LAtVKS3v5u5Uf2OdsqcJyTAd46VvaTh5Bd
         CI7BPxy7k5sgJDqLq1RcsS3wNsihI78jdpDJIITTaw/+RdV8uJbwUA5jL3bVoiO2CnZz
         ECP+wZYQCeXwsVT03Cwq3TmyYVTdLKIqSaQxxB77ysN7pTZ6rhWOALXsXCermCrGDEm9
         xTqkC17qeHkGGjhP+HwJkZNAmoWQo1WEBi97ntM6TwL06wMqG3TUZavTpeNmgqXB4xXm
         gxbfUwfLqghdmcJf/K4rHwrkHT+sXq/VtbjNBGcKK6hDHJkwFOSBqyz3GYb+FTIsRGl6
         hXsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QaxZlmGeTiNSpZpCZqH57v2oCRS32AJdCJEiZtFl+fo=;
        b=ORdr+E1/qpGKSuXmVEDMZQRv50qDTp61ItGu1GiDcr0LLka81R3+XaO6D+mVmh322G
         uWSSVriz21lgvA6BBhoDHt9444/jw49vwcJSlFES5eVSkNV7858r7XOQ7/p3Sbm1qcfe
         yT8Zgw+qp8WptUur9A6wVU/lTsf1K5u6N7gC3VXVbP1J/W5hhOVkN9UTkwKDBOPq6I9I
         scHgYBBpw7MtueWZQ9wWvulfbj6NwR8cHBe+fo7mr2jvV936nS9MsNMzCS/M4OQoznH6
         8MnO8hyUfMso3yWfCq4p6oVg3BtPCaf3MR40s3vxBQnzxif6NqHcFXA8iCp5kd5nbkFQ
         1Rmw==
X-Gm-Message-State: AOAM533SAqTuu9WRYlg0vJ6z+oCTJKM3a39WuP3IJZWiU7CIgQZnpLS+
        dOALbga5XFcTkZMhZtfC0gPiDkCDaeE5Gwf1BZxJwg==
X-Google-Smtp-Source: ABdhPJwnUIPwozxEvD8GWiVDDYw5ZDqSXm6R85I9zeuQ3bp/QzgWXBdhWWpkvOKxcxv7W9iIJOUZHicmrUxw7zSXQ5g=
X-Received: by 2002:a05:6402:34c1:: with SMTP id w1mr83741602edc.179.1638280836615;
 Tue, 30 Nov 2021 06:00:36 -0800 (PST)
MIME-Version: 1.0
References: <20211106183802.893285-1-aford173@gmail.com> <718f7f6d6cd564d031c1963f1590c62d549ae725.camel@ndufresne.ca>
 <CAHCN7xKM9RUE7z-+ug1on+D=nDoEm589R4m03ofys92Aq75ZVQ@mail.gmail.com>
 <8db00a4b6faa99c940d9bc86e17161eb0db5efe3.camel@ndufresne.ca>
 <CAJ+vNU28UJffFv9jQ2KryJMudqYxvCaoVOVcU5dPqRA209iN6A@mail.gmail.com>
 <d91532c2c0772f9aa708ead36b2a97203727a7ea.camel@ndufresne.ca>
 <CAJ+vNU3H-V+bPoZ3qKead45h=W7AhQK6Lhjrx5ssdF4c_qfe=A@mail.gmail.com>
 <CAHCN7x+0LwwU_rEST+TZxGquswGKL19gnTy9WLofsXtGAtWqdw@mail.gmail.com>
 <7f94eaacfddb8c5434c17f1e069ea87a17657ce9.camel@ndufresne.ca>
 <CAHCN7xKRzxMBmPbDobWTuvNNSpTXk5XENvfBnfkhRY3eZKhn6w@mail.gmail.com>
 <CAHCN7xJFLNi_g+HX8PCy1Rkgf0jnWpO5QGYVz8nH19xrJkwHrA@mail.gmail.com>
 <CAJ+vNU3zFd=6k_Emc5aafxKkGwCPp4crgOFezQ-E_MbWsn1_EA@mail.gmail.com>
 <fed6c2fd7cf4971062c417ce41ed1e3812b900e0.camel@ndufresne.ca>
 <CAHCN7xK+wROHaqDcsY-3WYFQ82qX17L-LHNL3siSWnWvwFShzQ@mail.gmail.com>
 <CAAEAJfC1xXvemaFP+vTFVJ3S-SpYtrxyZgDamSOgLC1F3ua5xw@mail.gmail.com>
 <CAHCN7x+UMMP6RXsNm0=OC=UTQzh=RKqQo6B7FD5e4eoJAEfmpg@mail.gmail.com> <CAJ+vNU1epi9SwPMHkuDmKcb68RLemYF=bsp7AVnzz06zKc2efw@mail.gmail.com>
In-Reply-To: <CAJ+vNU1epi9SwPMHkuDmKcb68RLemYF=bsp7AVnzz06zKc2efw@mail.gmail.com>
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Date:   Tue, 30 Nov 2021 11:00:24 -0300
Message-ID: <CAAEAJfCpjk5nWWkJYjjDT-YEpJi4pTZqZbzp_if9OGC0HKspzw@mail.gmail.com>
Subject: Re: [RFC 0/5] arm64: imx8mm: Enable Hantro VPUs
To:     Tim Harvey <tharvey@gateworks.com>
Cc:     Adam Ford <aford173@gmail.com>,
        Nicolas Dufresne <nicolas@ndufresne.ca>,
        linux-media <linux-media@vger.kernel.org>,
        Schrempf Frieder <frieder.schrempf@kontron.de>,
        Marek Vasut <marek.vasut@gmail.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Adam Ford-BE <aford@beaconembedded.com>,
        cstevens@beaconembedded.com,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Lucas Stach <l.stach@pengutronix.de>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        Alice Guo <alice.guo@nxp.com>, Peng Fan <peng.fan@nxp.com>,
        "open list:HANTRO VPU CODEC DRIVER" 
        <linux-rockchip@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:STAGING SUBSYSTEM" <linux-staging@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tim,

On Mon, 29 Nov 2021 at 16:36, Tim Harvey <tharvey@gateworks.com> wrote:
>
> On Mon, Nov 29, 2021 at 10:59 AM Adam Ford <aford173@gmail.com> wrote:
..
> >
>
> Adam,
>
> What deps did you install in order to get v4l2codecs building? I
> installed libgudev-1.0-dev based on Nicolas' suggestion and rebuilt
> (not sure if I needed to re-configure somehow) but there is still
> nothing in build/subprojects/gst-plugins-bad/sys/v4l2codecs/. A 'meson
> configure' tells me that v4l2codecs is set to 'auto' but I'm not sure
> how to find out what dependencies are needed or what may be missing.
>

At least in my case (Centps-derivative), this is what I've done:

...
gst-plugins-bad| Run-time dependency gudev-1.0 found: NO (tried
pkgconfig and cmake)

Installed gudev ... and then:

...
gst-plugins-bad| Dependency gudev-1.0 found: YES 232 (cached)
...
gst-plugins-bad 1.19.3.1

    Plugins               : accurip, adpcmdec, adpcmenc, aiff, asfmux,
audiobuffersplit, audiofxbad, audiomixmatrix, audiolatency,
audiovisualizers, autoconvert, bayer,
                            camerabin, codecalpha, coloreffects,
debugutilsbad, dvbsubenc, dvbsuboverlay, dvdspu, faceoverlay,
festival, fieldanalysis, freeverb, frei0r,
                            gaudieffects, gdp, geometrictransform,
id3tag, inter, interlace, ivfparse, ivtc, jp2kdecimator, jpegformat,
rfbsrc, midi, mpegpsdemux,
                            mpegpsmux, mpegtsdemux, mpegtsmux, mxf,
netsim, rtponvif, pcapparse, pnm, proxy, legacyrawparse,
removesilence, rist, rtmp2, rtpmanagerbad,
                            sdpelem, segmentclip, siren, smooth,
speed, subenc, switchbin, timecode, transcode, videofiltersbad,
videoframe_audiolevel, videoparsersbad,
                            videosignal, vmnc, y4mdec, decklink, dvb,
fbdevsink, ipcpipeline, nvcodec, shm, v4l2codecs, hls, sctp

GStreamer current master build fails. It's a known issue which will be
fixed today:

[...]
[8/9] Compiling C object
subprojects/gst-plugins-bad/sys/v4l2codecs/libgstv4l2codecs.so.p/gstv4l2cod=
ecvp9dec.c.o
FAILED: subprojects/gst-plugins-bad/sys/v4l2codecs/libgstv4l2codecs.so.p/gs=
tv4l2codecvp9dec.c.o
cc -Isubprojects/gst-plugins-bad/sys/v4l2codecs/libgstv4l2codecs.so.p
-Isubprojects/gst-plugins-bad/sys/v4l2codecs
-I../subprojects/gst-plugins-bad/sys/v4l2codecs
-Isubprojects/gst-plugins-bad -I../subprojects/gst-plugins-bad
-Isubprojects/gstreamer/libs -I../subprojects/gstreamer/libs
-Isubprojects/gstreamer -I../subprojects/gstreamer
-Isubprojects/gst-plugins-bad/gst-libs
-I../subprojects/gst-plugins-bad/gst-libs
-Isubprojects/gst-plugins-base/gst-libs
-I../subprojects/gst-plugins-base/gst-libs -Isubprojects/orc
-I../subprojects/orc -Isubprojects/gstreamer/gst
-Isubprojects/gst-plugins-base/gst-libs/gst/video
-Isubprojects/gst-plugins-base/gst-libs/gst/pbutils
-Isubprojects/gst-plugins-base/gst-libs/gst/audio
-Isubprojects/gst-plugins-base/gst-libs/gst/tag
-I/usr/include/glib-2.0 -I/usr/lib64/glib-2.0/include
-I/usr/include/gudev-1.0 -fdiagnostics-color=3Dalways
-D_FILE_OFFSET_BITS=3D64 -Wall -Winvalid-pch -O2 -g -fvisibility=3Dhidden
-fno-strict-aliasing -DG_DISABLE_DEPRECATED -Wmissing-prototypes
-Wdeclaration-after-statement -Wold-style-definition
-Wmissing-declarations -Wredundant-decls -Wwrite-strings -Wformat
-Wformat-security -Winit-self -Wmissing-include-dirs -Waddress
-Wno-multichar -Wvla -Wpointer-arith -fPIC -pthread -DHAVE_CONFIG_H
-MD -MQ subprojects/gst-plugins-bad/sys/v4l2codecs/libgstv4l2codecs.so.p/gs=
tv4l2codecvp9dec.c.o
-MF subprojects/gst-plugins-bad/sys/v4l2codecs/libgstv4l2codecs.so.p/gstv4l=
2codecvp9dec.c.o.d
-o subprojects/gst-plugins-bad/sys/v4l2codecs/libgstv4l2codecs.so.p/gstv4l2=
codecvp9dec.c.o
-c ../subprojects/gst-plugins-bad/sys/v4l2codecs/gstv4l2codecvp9dec.c
../subprojects/gst-plugins-bad/sys/v4l2codecs/gstv4l2codecvp9dec.c:92:3:
error: unknown type name =E2=80=98grefcount=E2=80=99
   grefcount ref_count;
   ^~~~~~~~~
../subprojects/gst-plugins-bad/sys/v4l2codecs/gstv4l2codecvp9dec.c: In
function =E2=80=98gst_v4l2_codec_vp9_dec_picture_data_new=E2=80=99:
../subprojects/gst-plugins-bad/sys/v4l2codecs/gstv4l2codecvp9dec.c:106:3:
warning: implicit declaration of function =E2=80=98g_ref_count_init=E2=80=
=99; did you
mean =E2=80=98g_cond_init=E2=80=99? [-Wimplicit-function-declaration]
   g_ref_count_init (&pic_data->ref_count);
   ^~~~~~~~~~~~~~~~
   g_cond_init
../subprojects/gst-plugins-bad/sys/v4l2codecs/gstv4l2codecvp9dec.c: In
function =E2=80=98gst_v4l2_codec_vp9_dec_picture_data_ref=E2=80=99:
../subprojects/gst-plugins-bad/sys/v4l2codecs/gstv4l2codecvp9dec.c:118:3:
warning: implicit declaration of function =E2=80=98g_ref_count_inc=E2=80=99=
; did you
mean =E2=80=98g_strv_contains=E2=80=99? [-Wimplicit-function-declaration]
   g_ref_count_inc (&data->ref_count);
   ^~~~~~~~~~~~~~~
   g_strv_contains
../subprojects/gst-plugins-bad/sys/v4l2codecs/gstv4l2codecvp9dec.c: In
function =E2=80=98gst_v4l2_codec_vp9_dec_picture_data_unref=E2=80=99:
../subprojects/gst-plugins-bad/sys/v4l2codecs/gstv4l2codecvp9dec.c:125:7:
warning: implicit declaration of function =E2=80=98g_ref_count_dec=E2=80=99
[-Wimplicit-function-declaration]
   if (g_ref_count_dec (&data->ref_count)) {
       ^~~~~~~~~~~~~~~
ninja: build stopped: subcommand failed.

Hope this helps get you started!
Ezequiel
