Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C03946923B
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 10:20:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240455AbhLFJYX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 04:24:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240440AbhLFJYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 04:24:22 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03C6BC061746
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 01:20:53 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1muAAi-0003X6-Sy; Mon, 06 Dec 2021 10:20:33 +0100
Message-ID: <2c3fdfec1144ec8179396b24010bc2e8bdb4fcd4.camel@pengutronix.de>
Subject: Re: [RFC 0/5] arm64: imx8mm: Enable Hantro VPUs
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Nicolas Dufresne <nicolas@ndufresne.ca>,
        Tim Harvey <tharvey@gateworks.com>
Cc:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Adam Ford <aford173@gmail.com>,
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
Date:   Mon, 06 Dec 2021 10:20:26 +0100
In-Reply-To: <838c44e1eb1387c68a1b8b4da18e69ef6b5ad9c2.camel@ndufresne.ca>
References: <20211106183802.893285-1-aford173@gmail.com>
         <718f7f6d6cd564d031c1963f1590c62d549ae725.camel@ndufresne.ca>
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
         <CAHCN7x+UMMP6RXsNm0=OC=UTQzh=RKqQo6B7FD5e4eoJAEfmpg@mail.gmail.com>
         <CAJ+vNU1epi9SwPMHkuDmKcb68RLemYF=bsp7AVnzz06zKc2efw@mail.gmail.com>
         <CAAEAJfCpjk5nWWkJYjjDT-YEpJi4pTZqZbzp_if9OGC0HKspzw@mail.gmail.com>
         <CAJ+vNU2we5mGXgYsR6CfimvFXZsc0zktR3fDa-h6RRa02jTT0g@mail.gmail.com>
         <1403b14061883f746bda2998b2bf4a2676f9f328.camel@ndufresne.ca>
         <CAJ+vNU1-gq2nB5oOcgo9zj5xR+qxmqyKAS-N4De1A_8SNRO_Aw@mail.gmail.com>
         <838c44e1eb1387c68a1b8b4da18e69ef6b5ad9c2.camel@ndufresne.ca>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, dem 03.12.2021 um 14:37 -0500 schrieb Nicolas Dufresne:
> Le vendredi 03 décembre 2021 à 08:46 -0800, Tim Harvey a écrit :
> > On Thu, Dec 2, 2021 at 8:34 PM Nicolas Dufresne <nicolas@ndufresne.ca> wrote:
> > > 
> > > Le mardi 30 novembre 2021 à 11:28 -0800, Tim Harvey a écrit :
> > > > On Tue, Nov 30, 2021 at 6:00 AM Ezequiel Garcia
> > > > <ezequiel@vanguardiasur.com.ar> wrote:
> > > > > 
> > > > > Hi Tim,
> > > > > 
> > > > > On Mon, 29 Nov 2021 at 16:36, Tim Harvey <tharvey@gateworks.com> wrote:
> > > > > > 
> > > > > > On Mon, Nov 29, 2021 at 10:59 AM Adam Ford <aford173@gmail.com> wrote:
> > > > > ..
> > > > > > > 
> > > > > > 
> > > > > > Adam,
> > > > > > 
> > > > > > What deps did you install in order to get v4l2codecs building? I
> > > > > > installed libgudev-1.0-dev based on Nicolas' suggestion and rebuilt
> > > > > > (not sure if I needed to re-configure somehow) but there is still
> > > > > > nothing in build/subprojects/gst-plugins-bad/sys/v4l2codecs/. A 'meson
> > > > > > configure' tells me that v4l2codecs is set to 'auto' but I'm not sure
> > > > > > how to find out what dependencies are needed or what may be missing.
> > > > > > 
> > > > > 
> > > > > At least in my case (Centps-derivative), this is what I've done:
> > > > > 
> > > > > ...
> > > > > gst-plugins-bad| Run-time dependency gudev-1.0 found: NO (tried
> > > > > pkgconfig and cmake)
> > > > > 
> > > > > Installed gudev ... and then:
> > > > > 
> > > > > ...
> > > > > gst-plugins-bad| Dependency gudev-1.0 found: YES 232 (cached)
> > > > > ...
> > > > > gst-plugins-bad 1.19.3.1
> > > > > 
> > > > >     Plugins               : accurip, adpcmdec, adpcmenc, aiff, asfmux,
> > > > > audiobuffersplit, audiofxbad, audiomixmatrix, audiolatency,
> > > > > audiovisualizers, autoconvert, bayer,
> > > > >                             camerabin, codecalpha, coloreffects,
> > > > > debugutilsbad, dvbsubenc, dvbsuboverlay, dvdspu, faceoverlay,
> > > > > festival, fieldanalysis, freeverb, frei0r,
> > > > >                             gaudieffects, gdp, geometrictransform,
> > > > > id3tag, inter, interlace, ivfparse, ivtc, jp2kdecimator, jpegformat,
> > > > > rfbsrc, midi, mpegpsdemux,
> > > > >                             mpegpsmux, mpegtsdemux, mpegtsmux, mxf,
> > > > > netsim, rtponvif, pcapparse, pnm, proxy, legacyrawparse,
> > > > > removesilence, rist, rtmp2, rtpmanagerbad,
> > > > >                             sdpelem, segmentclip, siren, smooth,
> > > > > speed, subenc, switchbin, timecode, transcode, videofiltersbad,
> > > > > videoframe_audiolevel, videoparsersbad,
> > > > >                             videosignal, vmnc, y4mdec, decklink, dvb,
> > > > > fbdevsink, ipcpipeline, nvcodec, shm, v4l2codecs, hls, sctp
> > > > > 
> > > > > GStreamer current master build fails. It's a known issue which will be
> > > > > fixed today:
> > > > > 
> > > > > [...]
> > > > > [8/9] Compiling C object
> > > > > subprojects/gst-plugins-bad/sys/v4l2codecs/libgstv4l2codecs.so.p/gstv4l2codecvp9dec.c.o
> > > > > FAILED: subprojects/gst-plugins-bad/sys/v4l2codecs/libgstv4l2codecs.so.p/gstv4l2codecvp9dec.c.o
> > > > > cc -Isubprojects/gst-plugins-bad/sys/v4l2codecs/libgstv4l2codecs.so.p
> > > > > -Isubprojects/gst-plugins-bad/sys/v4l2codecs
> > > > > -I../subprojects/gst-plugins-bad/sys/v4l2codecs
> > > > > -Isubprojects/gst-plugins-bad -I../subprojects/gst-plugins-bad
> > > > > -Isubprojects/gstreamer/libs -I../subprojects/gstreamer/libs
> > > > > -Isubprojects/gstreamer -I../subprojects/gstreamer
> > > > > -Isubprojects/gst-plugins-bad/gst-libs
> > > > > -I../subprojects/gst-plugins-bad/gst-libs
> > > > > -Isubprojects/gst-plugins-base/gst-libs
> > > > > -I../subprojects/gst-plugins-base/gst-libs -Isubprojects/orc
> > > > > -I../subprojects/orc -Isubprojects/gstreamer/gst
> > > > > -Isubprojects/gst-plugins-base/gst-libs/gst/video
> > > > > -Isubprojects/gst-plugins-base/gst-libs/gst/pbutils
> > > > > -Isubprojects/gst-plugins-base/gst-libs/gst/audio
> > > > > -Isubprojects/gst-plugins-base/gst-libs/gst/tag
> > > > > -I/usr/include/glib-2.0 -I/usr/lib64/glib-2.0/include
> > > > > -I/usr/include/gudev-1.0 -fdiagnostics-color=always
> > > > > -D_FILE_OFFSET_BITS=64 -Wall -Winvalid-pch -O2 -g -fvisibility=hidden
> > > > > -fno-strict-aliasing -DG_DISABLE_DEPRECATED -Wmissing-prototypes
> > > > > -Wdeclaration-after-statement -Wold-style-definition
> > > > > -Wmissing-declarations -Wredundant-decls -Wwrite-strings -Wformat
> > > > > -Wformat-security -Winit-self -Wmissing-include-dirs -Waddress
> > > > > -Wno-multichar -Wvla -Wpointer-arith -fPIC -pthread -DHAVE_CONFIG_H
> > > > > -MD -MQ subprojects/gst-plugins-bad/sys/v4l2codecs/libgstv4l2codecs.so.p/gstv4l2codecvp9dec.c.o
> > > > > -MF subprojects/gst-plugins-bad/sys/v4l2codecs/libgstv4l2codecs.so.p/gstv4l2codecvp9dec.c.o.d
> > > > > -o subprojects/gst-plugins-bad/sys/v4l2codecs/libgstv4l2codecs.so.p/gstv4l2codecvp9dec.c.o
> > > > > -c ../subprojects/gst-plugins-bad/sys/v4l2codecs/gstv4l2codecvp9dec.c
> > > > > ../subprojects/gst-plugins-bad/sys/v4l2codecs/gstv4l2codecvp9dec.c:92:3:
> > > > > error: unknown type name ‘grefcount’
> > > > >    grefcount ref_count;
> > > > >    ^~~~~~~~~
> > > > > ../subprojects/gst-plugins-bad/sys/v4l2codecs/gstv4l2codecvp9dec.c: In
> > > > > function ‘gst_v4l2_codec_vp9_dec_picture_data_new’:
> > > > > ../subprojects/gst-plugins-bad/sys/v4l2codecs/gstv4l2codecvp9dec.c:106:3:
> > > > > warning: implicit declaration of function ‘g_ref_count_init’; did you
> > > > > mean ‘g_cond_init’? [-Wimplicit-function-declaration]
> > > > >    g_ref_count_init (&pic_data->ref_count);
> > > > >    ^~~~~~~~~~~~~~~~
> > > > >    g_cond_init
> > > > > ../subprojects/gst-plugins-bad/sys/v4l2codecs/gstv4l2codecvp9dec.c: In
> > > > > function ‘gst_v4l2_codec_vp9_dec_picture_data_ref’:
> > > > > ../subprojects/gst-plugins-bad/sys/v4l2codecs/gstv4l2codecvp9dec.c:118:3:
> > > > > warning: implicit declaration of function ‘g_ref_count_inc’; did you
> > > > > mean ‘g_strv_contains’? [-Wimplicit-function-declaration]
> > > > >    g_ref_count_inc (&data->ref_count);
> > > > >    ^~~~~~~~~~~~~~~
> > > > >    g_strv_contains
> > > > > ../subprojects/gst-plugins-bad/sys/v4l2codecs/gstv4l2codecvp9dec.c: In
> > > > > function ‘gst_v4l2_codec_vp9_dec_picture_data_unref’:
> > > > > ../subprojects/gst-plugins-bad/sys/v4l2codecs/gstv4l2codecvp9dec.c:125:7:
> > > > > warning: implicit declaration of function ‘g_ref_count_dec’
> > > > > [-Wimplicit-function-declaration]
> > > > >    if (g_ref_count_dec (&data->ref_count)) {
> > > > >        ^~~~~~~~~~~~~~~
> > > > > ninja: build stopped: subcommand failed.
> > > > > 
> > > > > Hope this helps get you started!
> > > > > Ezequiel
> > > > 
> > > > Ezequiel and Nicolas,
> > > > 
> > > > Thanks - I did manage to get gstreamer 1.19.3 built successfully with
> > > > v4l2codecs finally by getting the correct dependencies. I've attempted
> > > > to software encode from another system and decode/display on the IMX8M
> > > > Mini but thus far have not been successful.
> > > > 
> > > > I see that v4l2codecs plugin v4l2slh264dec/v4l2slmpeg2dec/v4l2slvp8dec
> > > > and these all can output video/x-raw NV12/YUY2 which kmssink should
> > > > accept so I'm attempting the following :
> > > > 
> > > > # vp8 encode from x86
> > > > gst-launch-1.0 -v videotestsrc ! video/x-raw,width=800,height=480 !
> > > > vp8enc ! rtpvp8pay ! udpsink host=172.24.33.15 port=9001
> > > > # vp8 decode on imx8mm@172.24.33.15 which has a 800x480 display
> > > > [gst-main] root@focal-venice:~/gstreamer/build# gst-launch-1.0 -v
> > > > udpsrc port=9001 caps = "application/x-rtp, media=(string)video,
> > > > clock-rate=(int)90000, encoding-name=(string)VP8, payload=(int)96,
> > > > ssrc=(uint)2745262155, timestamp-offset=(uint)2515032683,
> > > > seqnum-offset=(uint)19579, a-framerate=(string)30" ! rtpvp8depay !
> > > > v4l2slvp8dec ! kmssink
> > > > Setting pipeline to PAUSED ...
> > > > Pipeline is live and does not need PREROLL ...
> > > > /GstPipeline:pipeline0/GstKMSSink:kmssink0: display-width = 800
> > > > /GstPipeline:pipeline0/GstKMSSink:kmssink0: display-height = 480
> > > > Pipeline is PREROLLED ...
> > > > Setting pipeline to PLAYING ...
> > > > /GstPipeline:pipeline0/GstUDPSrc:udpsrc0.GstPad:src: caps =
> > > > application/x-rtp, media=(string)video, clock-rate=(int)90000,
> > > > encoding-name=(string)VP8, payload=(int)96, ssrc=(uint)2745262155,
> > > > timestamp-offset=(uint)2515032683, seqnum-offset=(uint)19579,
> > > > a-framerate=(string)30
> > > > New clock: GstSystemClock
> > > > /GstPipeline:pipeline0/GstRtpVP8Depay:rtpvp8depay0.GstPad:sink: caps =
> > > > application/x-rtp, media=(string)video, clock-rate=(int)90000,
> > > > encoding-name=(string)VP8, payload=(int)96, ssrc=(uint)2745262155,
> > > > timestamp-offset=(uint)2515032683, seqnum-offset=(uint)19579,
> > > > a-framerate=(string)30
> > > > /GstPipeline:pipeline0/GstRtpVP8Depay:rtpvp8depay0.GstPad:src: caps =
> > > > video/x-vp8, framerate=(fraction)0/1, height=(int)480, width=(int)800,
> > > > profile=(string)0
> > > > ERROR: from element /GstPipeline:pipeline0/GstUDPSrc:udpsrc0: Internal
> > > > data stream error.
> > > > Additional debug info:
> > > > ../subprojects/gstreamer/libs/gst/base/gstbasesrc.c(3127):
> > > > gst_base_src_loop (): /GstPipeline:pipeline0/GstUDPSrc:udpsrc0:
> > > > streaming stopped, reason not-negotiated (-4)
> > > > Execution ended after 0:00:02.076839644
> > > > Setting pipeline to NULL ...
> > > > Freeing pipeline ...
> > > > 
> > > > I'm getting the same thing when trying to use h264.
> > > > 
> > > > I've never quite been able to grasp how to debug GStreamer's
> > > > negotiation issues. If I end with fakesink it appears to decode so it
> > > > must be the v4l2slvp8dec to kmssink. I tried forcing the pixel format
> > > > using 'v4l2slvp8dec ! "video/x-raw,format=(string)NV12" ! kmssink' but
> > > > I still get the negotiation error.
> > > > 
> > > > What interrupts should I be seeing in /proc/interrupts? I don't see
> > > > anything vpu/hantro related there.
> > > > 
> > > > I also want to make sure I have a basic understanding of the vpu
> > > > drivers and usersapce on the IMX8M Mini. The IMX6Q/DL that I'm more
> > > > familiar with has a vpu that is supported by the GStreamer video4linux
> > > > plugin which shows the following (on GStreamer 1.16.2):
> > > >   v4l2jpegenc: V4L2 JPEG Encoder
> > > >   v4l2jpegdec: V4L2 JPEG Decoder
> > > >   v4l2h264enc: V4L2 H.264 Encoder
> > > >   v4l2mpeg4enc: V4L2 MPEG4 Encoder
> > > >   v4l2mpeg4dec: V4L2 MPEG4 Decoder
> > > >   v4l2mpeg2dec: V4L2 MPEG2 Decoder
> > > >   v4l2h264dec: V4L2 H264 Decoder
> > > > The IMX6Q/DL also has an IPU that has an M2M driver that provides the
> > > > following for scaling/colorspace conversion:
> > > >   v4l2convert: V4L2 Video Converter
> > > > 
> > > > I believe what I'm reading is that the IMX8M Mini Hantro codecs are
> > > > 'stateful' where more software is required to drive them and is
> > > 
> > > 'stateless'. the rest is right.
> > > 
> > > > supported by the newer v4l2codecs plugin. I haven't been able to
> > > > understand what kernel version/requirements the v4l2codecs plugin
> > > > users/requires.
> > > 
> > > After H264 debacle with 5.9, 5.10 and 5.11 API break and GStreamer not getting
> > > enough release to support all of these we started merging support for CODECs
> > > only when the stable uAPI land. I made an exception for VP9 as it is already
> > > applied in the media tree and didn't want to miss 1.20 release.
> > > 
> > > So to answer you question, it depends on when the CODEC uAPI landed.
> > > 
> > 
> > Ok, thanks for the explanation.
> > 
> > > > 
> > > > I'm also trying to understand how we can get scaling/colorspace
> > > > conversion on the IMX8M Mini. The IMX8M lacks an IPU... is there some
> > > > way to utilize scaling/colorspace conversion from the 2D GPU bound to
> > > > the etnaviv driver?
> > > 
> > > The concept of the mini, is that you would be using th encoder for anything that
> > > isn't going to the display. So they only integrated the Hantro PP on the
> > > encoder. Unfortunately, you'll have to be patient for mainline stateless encoder
> > > support, we barely scratch the surface of this subject, but its being worked on.
> > 
> > After some searching for Hantro PP I see that the IMXMQ (IMX8M
> > Dual/QuadLite/Quad) mentions Hantro PP. From the IMX8MDQLQRM section
> > 14.1.2.1 Decoder Features:
> > <quote>
> > Video post-processing features
> >  - Frame rotation 90 degrees left/right
> >  - Frame mirroring horizontally/vertically
> >  - Frame cropping
> >  - Frame conversion from YCbCr formats to 16-bit or 32-bit RGB formats
> >  - Frame scaling with maximum up-scaling factor of 3
> >  - Two rectangular or alpha blending masks for output frame
> > 
> >  The post-processing features can be used in pipeline with the
> > decoder. The postprocessing features can also be used as stand-alone,
> > without performing any decoding
> > </quote>
> > 
> > The above is under the VPU_G1 section and the same is not mentioned
> > for VPU_G2 and the IMX8MQ doesn't have encode support. Where do you
> > see that the IMX8MM has the Hantro PP on the H1? I know the TRM's lack
> > a lot of info so perhaps you know more about the internals than what
> > the TRM states.
> 
> I've got told that by someone with contacts at NXP recently (in IRC). I haven't
> verified it though, it just made sense for the targeted use of th mini. Hantro 
> G1 driver does not yet expose an M2M for the standalone mode of the PP, but
> shall be possible. Decode an PP cannot run concurrently though, so concurrent PP
> and decode will have big impact on performance.
> 
> The G2 PP is different, but I *think* its always there. It's not doing much,
> linear NV12 (detiling from 4x4 linear tiles), and can scale down by factor of 2,
> 4 an 8. If there is more feature I'm not aware.
> 
> > 
> > I also found on a forum
> > (https://community.nxp.com/t5/i-MX-Processors/imx8mq-Hantro-G1-scaling/m-p/1285343)
> > that NXP's BSP doesn't use the Hantro for scaling (and likely not csc
> > either) and they use the GPU instead. I'm still unclear if/how you
> > could tap into the 2D GPU to use its scaling/conversion if it's bound
> > to the etnaviv driver.
> > 
> > > Unlike the IMX8MQ, you don't have the option to output YUYV (packed yuv 4:2:2)
> > > which would satisfy the 2D GPU support hoold to the DMABuf import path.
> 
> As I'm saying above, you can't, there is no NV12 support in that 2D GPU from
> what I was old by Etnaviv folks, only YUYV (4:2:2 packed). Shaders is the only
> option.
> 
That's not correct. The 3D GPU can sample directly from YUYV, so it's
the optimal zero-copy format if you are going to use the video with the
3D GPU. Most of the 2D GPU cores (and I think the one of the 8MM is no
exception) can handle planar formats, some of them only at reduced rate
of 1 Pixel/clock, instead of the usual 2 Pixels/clock.
> > > 
> > > When the display driver gets ready and upstream (it's been only 2-3 years now),
> > > you'll get linear NV12 support along with G2 compression support (this one is
> > > not supported by the GPU, so it will be tricky to expose in userland). I don't
> > > think the display support 4L4 tiles, but you GPU most likely can do with the
> > > right shared and texelFetch() or vulkan equivalent if that exist on that target.
> > 
> > Do you mean the Samsung Exynos DRM driver (which doesn't yet have
> > support for IMX8MM) or drivers/gpu/drm/mxsfb?
> > 
> > I'm currently using a pretty old patchset that adds IMX8MM support to
> > the drm/exynos driver. I'm way out of my realm when talking about
> > GPU/VPU and display drivers.
> 
> Didn't know the mini was using Samsung display controller. Didn't even know that
> chip could exist outside of Exynos chips. On imx8mq, they have a NXP display
> chip and it is new. Downstream driver exist, and upstream driver is being worked
> on.

The display controller on the 8MM is derived from the existing simple
eLCDIF controllers found on earlier i.MX SoCs. 8MQ is the only one with
the very capable DCSS display controller. In fact the 8MQ DCSS is
upstream, what is missing is the Cadence eDP/HDMI bridge driver. The
MIPI-DSI controller and PHY on the 8MM is Samsung IP.

Regards,
Lucas

