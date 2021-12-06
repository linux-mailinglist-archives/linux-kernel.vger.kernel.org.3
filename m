Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5107D46A8CE
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 21:51:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349842AbhLFUyn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 15:54:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238973AbhLFUyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 15:54:41 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 832B6C061746
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 12:51:12 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id p4so12504144qkm.7
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 12:51:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20210112.gappssmtp.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=GRaAwXK2rSzM3Lp9oMiYyXb3xjjCWbcFm8UXB1aGFXg=;
        b=IgCiPPgf6cAcBl8evExqjZpZyZkUljOdEjcAQ1qlxo9kgYTgNJUF2CvuRpfWAhDLY+
         3ylzpEiMUVSssnlEBPpvEnCX55SpYmtBqO25yJilivDfDBtxI+PqtsAMJ9SAfEeKVJKU
         lHLAbadtcxJnSVOjIVUSYzXRETj2Y1Vd2pNWdORdY2bo1HIcud1+p9gWXZ2KHsQy30ii
         U5+yEhiCvimw/jx7FcMDiDJCw+VVeqIThIZr6z9xMHiMFEVeFwvL1VY4iD6RXfPr7PAc
         5x/B90Z1ozEB4DghEGQjZ5vi6ULI52TZSB5yStKxltcVasX+wwi96QDRCjMMAOeM/UcP
         ux2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=GRaAwXK2rSzM3Lp9oMiYyXb3xjjCWbcFm8UXB1aGFXg=;
        b=33Wy7Qg9UTKs3BZvRhSlpefRTi1iDrC0MeGaOlYD9ImW8/tlxAoz4jfhankFDtdGW8
         yy2E/FDJoknZ4p5zuXc4djkSR7yRgfxuyWauHK5BEUPgbSZjXqbIv9J74h0MVjP65As6
         cMP+g8GRJmtfa8BQ47tVuyOmPWb02bliCSZLJ9mkbAJGxjDL1pMicT1+RMTc1Pxi0NCL
         o5iFF6hn0Ki5LJefPj+yeg1SvUbEoZ+fj8G5vnJZnr1gyMXZhwFBg7WL/J52mXlbjFyr
         h4NZLoAyqQJyVxEzxjnDjWJdq5OrxOPbKdxjjXDfiSYy5tg45XXp4vaANpE1LabL8UMT
         j6QQ==
X-Gm-Message-State: AOAM5305P3spWwTq8UCEJ7EooIEkUYJtCbASwnXycE4CGwjxh6JBh0kg
        o1SUd7M/7wUwGiNnx6rxoHvs9g==
X-Google-Smtp-Source: ABdhPJztSx9XHqWzMQjln614SKGQowAKOpctDFZUB6VnU0E80ndRg9LQhOP1cBDd6pBfwMJ3FDLSyQ==
X-Received: by 2002:a05:620a:4307:: with SMTP id u7mr33471597qko.15.1638823871635;
        Mon, 06 Dec 2021 12:51:11 -0800 (PST)
Received: from nicolas-tpx395.localdomain (mtl.collabora.ca. [66.171.169.34])
        by smtp.gmail.com with ESMTPSA id h3sm7374741qko.78.2021.12.06.12.51.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 12:51:11 -0800 (PST)
Message-ID: <3b81a33d9bbadd10bc61c3daedecc5b73b99a435.camel@ndufresne.ca>
Subject: Re: [RFC 0/5] Split iMX8MQ Hantro VPU into G1 and G2 with blk-ctrl
 support
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Adam Ford <aford173@gmail.com>, linux-media@vger.kernel.org
Cc:     benjamin.gaignard@collabora.com, cphealy@gmail.com,
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
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-staging@lists.linux.dev
Date:   Mon, 06 Dec 2021 15:51:09 -0500
In-Reply-To: <CAHCN7xL3PSbHKZK_4NKRwhNGOZYM+i54CoKCq01a6kdbCLc2KA@mail.gmail.com>
References: <20211205181618.1041699-1-aford173@gmail.com>
         <CAHCN7xL3PSbHKZK_4NKRwhNGOZYM+i54CoKCq01a6kdbCLc2KA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.1 (3.42.1-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le dimanche 05 décembre 2021 à 13:51 -0600, Adam Ford a écrit :
> On Sun, Dec 5, 2021 at 12:16 PM Adam Ford <aford173@gmail.com> wrote:
> > 
> > Currently, the VPU in the i.MQ8MQ is appearing as one codec, but in reality, it's
> > two IP blocks called G1 and G2.  There is initialization code in VPU code to
> > pull some clocks, resets and other features which has been integrated into
> > the vpu-blk-ctrl for the i.MX8M Mini and a similar method can be used to make
> > the VPU codec's operate as stand-alone cores without having to know the details
> > of each other or the quirks unique to the i.MX8MQ, so the remaining code can be
> > left more generic.
> > 
> > This series was started by Lucas Stach, and picked up by me so some patches have
> > his s-o-b and mine where I might have changed a few minor items.  It's in an RFC state
> > because the G2 VP9 operations appear to hang, but the parent code from which I started doesn't
> > appear to show VP9 support, and it looks like it should.
> > 
> > since the g-streamer and media trees are in a constant state of change, this series is based on
> > git://linuxtv.org/hverkuil/media_tree.git for-v5.17e
> > 
> 
> I forgot to post Fluster results.
> 
> Before the patches to this branch:
> 
> 2gst-main] root@localhost:~/gstreamer/fluster# ./fluster.py list -c |grep -i v4l
> 
>     GStreamer-H.264-V4L2-Gst1.0: GStreamer H.264 V4L2 decoder for
> GStreamer 1.0... ❌
>     GStreamer-H.264-V4L2SL-Gst1.0: GStreamer H.264 V4L2SL decoder for
> GStreamer 1.0... ✔️
>     GStreamer-H.265-V4L2-Gst1.0: GStreamer H.265 V4L2 decoder for
> GStreamer 1.0... ❌
>     GStreamer-H.265-V4L2SL-Gst1.0: GStreamer H.265 V4L2SL decoder for
> GStreamer 1.0... ❌
>     GStreamer-VP8-V4L2-Gst1.0: GStreamer VP8 V4L2 decoder for GStreamer 1.0... ❌
>     GStreamer-VP8-V4L2SL-Gst1.0: GStreamer VP8 V4L2SL decoder for
> GStreamer 1.0... ✔️
>     GStreamer-VP9-V4L2SL-Gst1.0: GStreamer VP9 V4L2SL decoder for
> GStreamer 1.0... ❌
>     GStreamer-AV1-V4L2SL-Gst1.0: GStreamer AV1 V4L2SL decoder for
> GStreamer 1.0... ❌
> [gst-main] root@localhost:~/gstreamer/fluster#
> 
> There was no VP9 support.
> 
> ./fluster.py run -dGStreamer-H.264-V4L2SL-Gst1.0
> GStreamer-H.264-V4L2SL-Gst1.0
> Ran 90/135 tests successfully               in 58.787 secs
> 
> AFTER this series, two decoders appear:
> 
> [   15.919137] hantro-vpu 38300000.video-codec: registered
> nxp,imx8mq-vpu-g1-dec as /dev/video0
> [   15.983579] hantro-vpu 38310000.video-codec: registered
> nxp,imx8mq-vpu-g2-dec as /dev/video1
> 
> VP9 was listed:
> 
>     GStreamer-H.264-V4L2-Gst1.0: GStreamer H.264 V4L2 decoder for
> GStreamer 1.0... ❌
>     GStreamer-H.264-V4L2SL-Gst1.0: GStreamer H.264 V4L2SL decoder for
> GStreamer 1.0... ✔️
>     GStreamer-H.265-V4L2-Gst1.0: GStreamer H.265 V4L2 decoder for
> GStreamer 1.0... ❌
>     GStreamer-H.265-V4L2SL-Gst1.0: GStreamer H.265 V4L2SL decoder for
> GStreamer 1.0... ❌
>     GStreamer-VP8-V4L2-Gst1.0: GStreamer VP8 V4L2 decoder for GStreamer 1.0... ❌
>     GStreamer-VP8-V4L2SL-Gst1.0: GStreamer VP8 V4L2SL decoder for
> GStreamer 1.0... ✔️
>     GStreamer-VP9-V4L2SL-Gst1.0: GStreamer VP9 V4L2SL decoder for
> GStreamer 1.0... ✔️
>     GStreamer-AV1-V4L2SL-Gst1.0: GStreamer AV1 V4L2SL decoder for
> GStreamer 1.0... ❌
> 
> ./fluster.py run -d GStreamer-VP8-V4L2SL-Gst1.0
> Ran 55/61 tests successfully               in 8.565 secs
> 
> 
> ./fluster.py run -dGStreamer-H.264-V4L2SL-Gst1.0
> Ran 90/135 tests successfully               in 60.269 secs
> 
> Same results for H.264
> 
> VP9 Hangs, where it didn't even appear as available before:
> 
> ./fluster.py run -d GStreamer-VP9-V4L2SL-Gst1.0
> ****************************************************************************************************
> Running test suite VP9-TEST-VECTORS with decoder GStreamer-VP9-V4L2SL-Gst1.0
> Using 4 parallel job(s)
> ****************************************************************************************************
> 
> [TEST SUITE      ] (DECODER                    ) TEST VECTOR
>                           ... RESULT
> ----------------------------------------------------------------------
> [VP9-TEST-VECTORS] (GStreamer-VP9-V4L2SL-Gst1.0)
> vp90-2-00-quantizer-00.webm                     ... Success
> [VP9-TEST-VECTORS] (GStreamer-VP9-V4L2SL-Gst1.0)
> vp90-2-00-quantizer-01.webm                     ... Success
> [VP9-TEST-VECTORS] (GStreamer-VP9-V4L2SL-Gst1.0)
> vp90-2-00-quantizer-02.webm                     ... Succes
> 
> <hang > - and yes, 'Success' didnt' finish writing to the serial port.

Looks like hope to me ! Do you get further with -j 1 (one concurrent decode) ?

> 
> 
> 
> > Adam Ford (2):
> >   media: hantro: split i.MX8MQ G1 and G2 code
> >   arm64: dts: imx8mq: Split i.MX8MQ G1 and G2 with vpu-blk-ctrl
> > 
> > Lucas Stach (3):
> >   dt-bindings: power: imx8mq: add defines for VPU blk-ctrl domains
> >   dt-bindings: soc: add binding for i.MX8MQ VPU blk-ctrl
> >   soc: imx: imx8m-blk-ctrl: add i.MX8MQ VPU blk-ctrl
> > 
> >  .../soc/imx/fsl,imx8mq-vpu-blk-ctrl.yaml      |  71 +++++++++++
> >  arch/arm64/boot/dts/freescale/imx8mq.dtsi     |  69 ++++++----
> >  drivers/soc/imx/imx8m-blk-ctrl.c              |  67 ++++++++++
> >  drivers/staging/media/hantro/hantro_drv.c     |   4 +-
> >  drivers/staging/media/hantro/hantro_hw.h      |   2 +-
> >  drivers/staging/media/hantro/imx8m_vpu_hw.c   | 119 +++---------------
> >  include/dt-bindings/power/imx8mq-power.h      |   3 +
> >  7 files changed, 205 insertions(+), 130 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/soc/imx/fsl,imx8mq-vpu-blk-ctrl.yaml
> > 
> > --
> > 2.32.0
> > 

