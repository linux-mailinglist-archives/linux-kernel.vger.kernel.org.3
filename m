Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64630465675
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 20:27:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236459AbhLATbF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 14:31:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239436AbhLATal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 14:30:41 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07C31C061574;
        Wed,  1 Dec 2021 11:27:20 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id y13so106197106edd.13;
        Wed, 01 Dec 2021 11:27:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JAv+a8iChUvwqOY5lIjki0ZUA4EpmPS1I3AqCsxWKaA=;
        b=C4txjCwm3xDKfmaX5oVjU/e2fbmP3gKFWv2gYVGrXCne7LzW2nuJAuTe47lj3Xti3d
         gF6/MTjUqynCFWLDuUyB1xDP5znJx/eqiiPkeYNs5ZIxOccOUX8HwuaDiFcXAStwHVEA
         y61hNacUznJejZBJfHOrN+IYOMFMb6z1rv1C1+R2fS90bBBdXcnZDJ3eIwtKkFEVb/ma
         eQ+WwCPN/grOWJ73ousVBalkFe0n8ov/Vk53Y1KTwtWmexQ5escN8yO5rnBmGtRiDaGz
         D9TgTO1VKJQe23vyXcdTC2H+nKPg+OjcB4uQ4yXWHWKpEv7mUqEupjVZpcA0aPSllNAr
         9WLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JAv+a8iChUvwqOY5lIjki0ZUA4EpmPS1I3AqCsxWKaA=;
        b=DWiR2+vlxhIbV3jvMc1RiiVqETLPrfxyvCBo8BJuHwofpzjsAgnVJP+mkqyfgXH9jY
         iW/skQtvBhZX265kqw9wCrMrpK9JnDMhoZ8Gm/Mu+6C8wdl09+BayHN051a64N8BtwTW
         cgMaGQdd3ZLejIjEmfNkQBMZTjb5zxu8sT705XsgNpwV5IHMBnWXe3HDXBzBf3/R+XLR
         1O1c4ud3FEF6OmMo1NXORgxON3n06g9YpbpY/rZNb99nCMEkSJ8dHJV1PoF3O63i4huN
         NHcCsQH/tiTOy2SFV+Hw2S4x0trBcDvtTTDMxtNl6vDEm55a7dpZEGACrJTaJbRt4VdL
         Uv4A==
X-Gm-Message-State: AOAM530LT+1YCnwnQ/BMI/SPY5/uLhdQqUp4JPrzF9wDj2CSQB8rufVc
        2uUZrAbOdoNQ3cAErLaKpbKBXSTKDGxnPyLZJX6zbHalHwwZLw==
X-Google-Smtp-Source: ABdhPJzlutLYnRXY7oNgCBeUPmCoR5PdT2Y3yu0by3ZRURhZA7664xM0tbkih3XmSHR+97JmFdGGwKBZIt5MEzIs7t8=
X-Received: by 2002:a17:906:79c3:: with SMTP id m3mr9108224ejo.332.1638386838377;
 Wed, 01 Dec 2021 11:27:18 -0800 (PST)
MIME-Version: 1.0
References: <20211201013329.15875-1-aford173@gmail.com> <CAJ+vNU1jENmWAR_5E98Vgb53ctxjxSWJewPW0YC4Yp4DuYTn3g@mail.gmail.com>
 <7216bc863d89faa9fdc5cd8d44c319f7a6d88159.camel@pengutronix.de>
 <CAJ+vNU2PxgdN414Ufd4NAG5CJgnftNSAHDGpt9Nj+RfgkNmxaw@mail.gmail.com>
 <ccfc08bbb6ec0debd523bd106e7eff4a747aaa23.camel@pengutronix.de>
 <CAHCN7xKfRj3f03kC5TuBv-Te1OyeWNRe2aaqJNaW9VdHgbWqbg@mail.gmail.com> <62d99a764d3a8071f061a0127cfba6d7df53fc19.camel@pengutronix.de>
In-Reply-To: <62d99a764d3a8071f061a0127cfba6d7df53fc19.camel@pengutronix.de>
From:   Adam Ford <aford173@gmail.com>
Date:   Wed, 1 Dec 2021 13:27:07 -0600
Message-ID: <CAHCN7xKVPtjx+YpPQKeUOZYUb0W6NWacYdsB-HHe-3AUbSGAFw@mail.gmail.com>
Subject: Re: [RFC V2 0/2] arm64: imx8mm: Enable Hantro VPUs
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     Tim Harvey <tharvey@gateworks.com>,
        linux-media <linux-media@vger.kernel.org>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Nicolas Dufresne <nicolas@ndufresne.ca>,
        Adam Ford-BE <aford@beaconembedded.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Device Tree Mailing List <devicetree@vger.kernel.org>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:HANTRO VPU CODEC DRIVER" 
        <linux-rockchip@lists.infradead.org>,
        "open list:STAGING SUBSYSTEM" <linux-staging@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 1, 2021 at 1:04 PM Lucas Stach <l.stach@pengutronix.de> wrote:
>
> Am Mittwoch, dem 01.12.2021 um 12:52 -0600 schrieb Adam Ford:
> > On Wed, Dec 1, 2021 at 12:37 PM Lucas Stach <l.stach@pengutronix.de> wrote:
> > >
> > > Am Mittwoch, dem 01.12.2021 um 10:16 -0800 schrieb Tim Harvey:
> > > > On Wed, Dec 1, 2021 at 9:32 AM Lucas Stach <l.stach@pengutronix.de> wrote:
> > > > >
> > > > > Hi Tim,
> > > > >
> > > > > Am Mittwoch, dem 01.12.2021 um 09:23 -0800 schrieb Tim Harvey:
> > > > > > On Tue, Nov 30, 2021 at 5:33 PM Adam Ford <aford173@gmail.com> wrote:
> > > > > > >
> > > > > > > The i.MX8M has two Hantro video decoders, called G1 and G2 which appear
> > > > > > > to be related to the video decoders used on the i.MX8MQ, but because of
> > > > > > > how the Mini handles the power domains, the VPU driver does not need to
> > > > > > > handle all the functions, nor does it support the post-processor,
> > > > > > > so a new compatible flag is required.
> > > > > > >
> > > > > > > With the suggestion from Hans Verkuil, I was able to get the G2 splat to go away
> > > > > > > with changes to FORCE_MAX_ZONEORDER, but I found I could also set cma=512M, however
> > > > > > > it's unclear to me if that's an acceptable alternative.
> > > > > > >
> > > > > > > At the suggestion of Ezequiel Garcia and Nicolas Dufresne I have some
> > > > > > > results from Fluster. However, the G2 VPU appears to fail most tests.
> > > > > > >
> > > > > > > ./fluster.py run -dGStreamer-H.264-V4L2SL-Gst1.0
> > > > > > > Ran 90/135 tests successfully               in 76.431 secs
> > > > > > >
> > > > > > >  ./fluster.py run -d GStreamer-VP8-V4L2SL-Gst1.0
> > > > > > > Ran 55/61 tests successfully               in 21.454 secs
> > > > > > >
> > > > > > > ./fluster.py run -d GStreamer-VP9-V4L2SL-Gst1.0
> > > > > > > Ran 0/303 tests successfully               in 20.016 secs
> > > > > > >
> > > > > > > Each day seems to show more and more G2 submissions, and gstreamer seems to be
> > > > > > > still working on the VP9, so I am not sure if I should drop G2 as well.
> > > > > > >
> > > > > > >
> > > > > > > Adam Ford (2):
> > > > > > >   media: hantro: Add support for i.MX8M Mini
> > > > > > >   arm64: dts: imx8mm: Enable VPU-G1 and VPU-G2
> > > > > > >
> > > > > > >  arch/arm64/boot/dts/freescale/imx8mm.dtsi   | 41 +++++++++++++++
> > > > > > >  drivers/staging/media/hantro/hantro_drv.c   |  2 +
> > > > > > >  drivers/staging/media/hantro/hantro_hw.h    |  2 +
> > > > > > >  drivers/staging/media/hantro/imx8m_vpu_hw.c | 57 +++++++++++++++++++++
> > > > > > >  4 files changed, 102 insertions(+)
> > > > > > >
> > > > > >
> > > > > > Adam,
> > > > > >
> > > > > > That's for the patches!
> > > > > >
> > > > > > I tested just this series on top of v5.16-rc3 on an
> > > > > > imx8mm-venice-gw73xx-0x and found that if I loop fluster I can end up
> > > > > > getting a hang within 10 to 15 mins or so when imx8m_blk_ctrl_power_on
> > > > > > is called for VPUMIX pd :
> > > > > > while [ 1 ]; do uptime; ./fluster.py run -d GStreamer-VP8-V4L2SL-Gst1.0; done
> > > > > > ...
> > > > > > [  618.838436] imx-pgc imx-pgc-domain.6: failed to command PGC
> > > > > > [  618.844407] imx8m-blk-ctrl 38330000.blk-ctrl: failed to power up bus domain
> > > > > >
> > > > > > I added prints in imx_pgc_power_{up,down} and
> > > > > > imx8m_blk_ctrl_power_{on,off} to get some more context
> > > > > > ...
> > > > > > Ran 55/61 tests successfully               in 8.685 secs
> > > > > >  17:16:34 up 17 min,  0 users,  load average: 3.97, 2.11, 0.93
> > > > > > ********************************************************************************
> > > > > > ********************
> > > > > > Running test suite VP8-TEST-VECTORS with decoder GStreamer-VP8-V4L2SL-Gst1.0
> > > > > > Using 4 parallel job(s)
> > > > > > ********************************************************************************
> > > > > > ********************
> > > > > >
> > > > > > [TEST SUITE      ] (DECODER                    ) TEST VECTOR               ... R
> > > > > > ESULT
> > > > > > ----------------------------------------------------------------------
> > > > > > [ 1023.114806] imx8m_blk_ctrl_power_on vpublk-g1
> > > > > > [ 1023.119669] imx_pgc_power_up vpumix
> > > > > > [ 1023.124307] imx-pgc imx-pgc-domain.6: failed to command PGC
> > > > > > [ 1023.130006] imx8m-blk-ctrl 38330000.blk-ctrl: failed to power up bus domain
> > > > > >
> > > > > > While this wouldn't be an issue with this series it does indicate we
> > > > > > still have something racy in blk-ctrl. Can you reproduce this (and if
> > > > > > not what kernel are you based on)? Perhaps you or Lucas have some
> > > > > > ideas?
> > > > > >
> > > > > Did you have "[PATCH] soc: imx: gpcv2: Synchronously suspend MIX
> > > > > domains" applied when running those tests? It has only recently been
> > > > > picked up by Shawn and may have an influence on the bus domain
> > > > > behavior.
> > > > >
> > > >
> > > > Lucas,
> > > >
> > > > Good point. I did have that originally before I started pruning down
> > > > to the bare minimum to reproduce the issue.
> > > >
> > > > I added it back and now I have the following:
> > > > arm64: dts: imx8mm: Enable VPU-G1 and VPU-G2
> > > > media: hantro: Add support for i.MX8M Mini
> > > > soc: imx: gpcv2: keep i.MX8MM VPU-H1 bus clock active
> > > > soc: imx: gpcv2: Synchronously suspend MIX domains
> > > > Linux 5.16-rc3
> > > >
> > > > Here's the latest with that patch:
> > > > ...
> > > > [VP8-TEST-VECTORS] (GStreamer-VP8-V4L2SL-Gst1.0)
> > > > vp80-00-comprehensive-007 ... Success
> > > > [  316.632373] imx8m_blk_ctrl_power_off vpublk-g1
> > > > [  316.636908] imx_pgc_power_down vpu-g1
> > > > [  316.640983] imx_pgc_power_down vpumix
> > > > [  316.756869] imx8m_blk_ctrl_power_on vpublk-g1
> > > > [  316.761360] imx_pgc_power_up vpumix
> > > > [  316.765985] imx-pgc imx-pgc-domain.6: failed to command PGC
> > > > [  316.772743] imx8m-blk-ctrl 38330000.blk-ctrl: failed to power up bus domain
> > > > ^^^ hang
> > >
> > > Hm, I wonder if there's some broken error handling here somewhere, as a
> > > failure to power up a domain shouldn't lead to a hang.
> > >
> > > However, that doesn't explain why the PGC isn't completing the request.
> > > Can you try to extend the timeout some more. Even though I think that
> > > 1msec should already be generous. Can you dump the content of the
> > > GPC_PU_PGC_SW_PUP_REQ and GPC_A53_PU_PGC_PUP_STATUSn (all 3 of them)
> > > registers, when the failure condition is hit?
> >
> > I submitted a patch [1]  to enable the commented-out if statement
> > which waits for the handshake if the gpc domain was invoked by the
> > blk-ctrl or we knew if the bus clock was operational.
> >
> > I am not 100% certain it can work as-is with the vpumix, but based on
> > what I've seen from my testing, it's not hanging or causing errors.
> >
> > [1] - https://lore.kernel.org/linux-arm-kernel/20211120194900.1309914-1-aford173@gmail.com/T/
> >
> > I didn't have it applied to my latest RFC for the G1 and G2 because I
> > had not noticed a change in behavior one way or the other with that
> > patch.
>
> That's not going to work with all the MIX domains. The handshake
> requires some clocks to be enabled in the blk-ctrl (the secondary clock
> gates in the blk-ctrl) to work properly. This is only done by the blk-
> ctrl driver _after_ the GPC bus domain is powered up, so you can not
> wait for the handshake to complete inside the GPC power up routine.

I wasn't exactly sure how the handshake worked.  What your saying makes sense.
Will you NAK my patch so it doesn't accidentally get applied.

adam
>
> Regards,
> Lucas
>
