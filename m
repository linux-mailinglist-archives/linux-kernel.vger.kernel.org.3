Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06630465D32
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 04:57:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345072AbhLBEA7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 23:00:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237252AbhLBEA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 23:00:57 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9969AC061574;
        Wed,  1 Dec 2021 19:57:35 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id y13so110465842edd.13;
        Wed, 01 Dec 2021 19:57:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YlKQPDxpV/h32bfzHyXwLgHWLQ7A/j9Axl547x4MUrk=;
        b=qSz+SuKtf1jCQmreavI1Pzz6CFGKIiURsL5JQM6Kx3h1aPcmGfX8QI0Mmq8Cb8RVh5
         BestNW3PYdoSAPnNLGQA480CioJXAzIw6/ppbAWcddIXkBo+J76tGoyR5hvoTSySVx4W
         RBdNrWFvt1c8ae1sc3+a43BkpOS+52ql84PQb/9FJ+JZg6dpIXDfLb18uFuxoTIkFLJC
         nMnZBy7IeP0a1EbRIe1S86tGdj9MyWioCZ11TY17Hv8MzgpI4z4rE35Y2RVYdUPYWpUB
         6MhPFOCRtx9o/5uB5+GFiRnfKNHlb/iyk5XQqHAAD0DJJ+a0OwzNwCQcaN03sergve21
         Qv4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YlKQPDxpV/h32bfzHyXwLgHWLQ7A/j9Axl547x4MUrk=;
        b=VYqmAGnauHSUbgEljJI2T8wKJjfSbKdpkxqwzY17TGfx2VnG7RJfLTfExhLYERtkLv
         CrZT0A9+qiZARqVtk4m0j4A1YIJYZz1bGiX5LoQUz6siMnJ4G+Is8/FuL4tGrTLspJzB
         /srDO7ELsIyJ4/h+TYIx5fRd+e6E/A12Oro8Z725Dd8Tl30yuR8g00c55Y7kGenZUKvx
         JbJLttv2Bfwc4sQNBkblAWH4NlmiUAj6KH7UbDvVhlF5UZZVHQxd6NDPQslBuODNKBRe
         t63ugHX3GEAEWxfOHWOTjI6Yyb10ibj7Qq3ScUGiPjfqsri/VhgjdDGib+fjaewKjo1A
         0jKQ==
X-Gm-Message-State: AOAM532HLuPrQDenB3fibf7i5FlesXpdQjS/Bn4R2smkxwntCMFa/ZXO
        fSB8rpW2ZjK1vTgwviWqKzb1YmRamgcIbgMbI+8=
X-Google-Smtp-Source: ABdhPJzNLhw/9tG+1sb+amcW9j6cLzC0R+hAR2N6aBeW13Pp8nMX8+Y8TYV2WzasodpXIgP8NS/n/eOBnuRKhQhmYxM=
X-Received: by 2002:a05:6402:3595:: with SMTP id y21mr14321561edc.332.1638417453841;
 Wed, 01 Dec 2021 19:57:33 -0800 (PST)
MIME-Version: 1.0
References: <20211201013329.15875-1-aford173@gmail.com> <CAJ+vNU1jENmWAR_5E98Vgb53ctxjxSWJewPW0YC4Yp4DuYTn3g@mail.gmail.com>
 <7216bc863d89faa9fdc5cd8d44c319f7a6d88159.camel@pengutronix.de>
 <CAJ+vNU2PxgdN414Ufd4NAG5CJgnftNSAHDGpt9Nj+RfgkNmxaw@mail.gmail.com>
 <ccfc08bbb6ec0debd523bd106e7eff4a747aaa23.camel@pengutronix.de>
 <CAJ+vNU3GgwW02VCiqQJhpR_D_fFse42zyWHrB-ETj6V+c4KqtA@mail.gmail.com> <CAHCN7xJN=Qg8JF0fhcS-xbzY7wmnqcNhGG7JyuzP_xAL31rjWw@mail.gmail.com>
In-Reply-To: <CAHCN7xJN=Qg8JF0fhcS-xbzY7wmnqcNhGG7JyuzP_xAL31rjWw@mail.gmail.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Wed, 1 Dec 2021 21:57:21 -0600
Message-ID: <CAHCN7x+B3zb8WnQ6Xsdm2NzSmBEdULkxnmY5Af_-kzvrF7hY6Q@mail.gmail.com>
Subject: Re: [RFC V2 0/2] arm64: imx8mm: Enable Hantro VPUs
To:     Tim Harvey <tharvey@gateworks.com>
Cc:     Lucas Stach <l.stach@pengutronix.de>,
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

On Wed, Dec 1, 2021 at 7:07 PM Adam Ford <aford173@gmail.com> wrote:
>
> On Wed, Dec 1, 2021 at 2:04 PM Tim Harvey <tharvey@gateworks.com> wrote:
> >
> > On Wed, Dec 1, 2021 at 10:37 AM Lucas Stach <l.stach@pengutronix.de> wrote:
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
> > >
>
> I haven't been able to repeat your findings on G1, but when testing
> VP9 on the G2 decoder, I get the following:
>
> [VP9-TEST-VECTORS] (GStreamer-VP9-V4L2SL-Gst1.0)
> vp90-2-07-frame_parallel.webm                   ... Success
> [VP9-TEST-VECTORS] (GStreamer-VP9-V4L2SL-Gst1.0)
> vp90-2-07-frame_parallel-1.webm                 ... Success
> [VP9-TEST-VECTORS] (GStreamer-VP9-V4L2SL-Gst1.0)
> vp90-2-08-tile_1x4_frame_parallel.webm          ... Timeout
> [VP9-TEST-VECTORS] (GStreamer-VP9-V4L2SL-Gst1.0)
> vp90-2-08-tile_1x2.webm                         ... Timeout
> [VP9-TEST-VECTORS] (GStreamer-VP9-V4L2SL-Gst1.0)
> vp90-2-02-size-lf-1920x1080.webm                ... Timeout
> [VP9-TEST-VECTORS] (GStreamer-VP9-V4L2SL-Gst1.0)
> vp90-2-08-tile_1x2_frame_parallel.webm          ... Timeout
> [  192.971101] cma: cma_alloc: reserved: alloc failed, req-size: 3548
> pages, ret: -12
> [  192.979748] hantro-vpu 38310000.video-codec: dma alloc of size
> 14532608 failed
> [  192.988683] cma: cma_alloc: reserved: alloc failed, req-size: 938
> pages, ret: -12
> [VP9-TEST-VECTORS] (GStreamer-VP9-V4L2SL-Gst1.0)
> vp90-2-08-tile_1x8.webm                         ... Error
> [  195.296712] imx-pgc imx-pgc-domain.6: failed to command PGC
> [  195.302396] imx8m-blk-ctrl 38330000.blk-ctrl: failed to power up bus domain
>
> At some point the G2 times out, starts to choke on memory, then the
> power domain fails, and then the system hangs.  I have a heartbeat
> GPIO running so I know if the kernel is alive or not.  The heartbeat
> stops, so I know it's locked up tightly.
> I guess the good news is that the G2 decoder is able to run 100-ish
> successful tests before it falls down.
>
> Either way, I'll post a RFC V3 for the Hantro stuff, but I wonder if
> the order of operations on the power-domain powerdown is an issue.
>
> adam
>
> >
> > Adam,
> >
> > Adding keep_clocks=true to VPUG1/VPUG2 domains did not help
> >
> > Lucas,
> >
> > I bumped the regmap_read_poll_timeout timeouts from 1m to 100ms and
> > still saw the same issue.
> >
> > Here's some added debugging to show the regs:
> > [  648.037903] imx8m_blk_ctrl_power_on vpublk-g1
> > [  648.042346] imx_pgc_power_up vpumix
> > [  648.146178] imx-pgc imx-pgc-domain.6: imx_pgc_power_up: failed to command PGC
> > [  648.153355] imx-pgc imx-pgc-domain.6: GPC_PU_PGC_SW_PUP_REQ(0x0f8)=0x00000100
> > [  648.162339] imx-pgc imx-pgc-domain.6:
> > GPC_A53_PU_PGC_PUP_STATUS0(0x14c)=0x00000000
> > [  648.169988] imx-pgc imx-pgc-domain.6:
> > GPC_A53_PU_PGC_PUP_STATUS1(0x150)=0x00000000
> > [  648.177618] imx-pgc imx-pgc-domain.6:
> > GPC_A53_PU_PGC_PUP_STATUS2(0x154)=0x00000000
> > [  648.185281] imx8m-blk-ctrl 38330000.blk-ctrl: failed to power up bus domain
> >

Tim / Lucas,

I was able to run the G2 decoder for 203 seconds using fluster, and it
didn't lock up.  I used a combination of the synchronous suspend, and
I removed the VPU reset reference.
Looking at the NXP power domain controller in both Linux and ATF,
neither appear to be referencing IMX8MQ_RESET_VPU_RESET anywhere.  We
are referencing it in the pgc_vpumix node, so I commented it out.
With those two items changed, I was able to get the G2 operational.
I'm going to post another RFC with the reset in the vpumix removed and
a note to what I am using for a starting point.

Ran 127/303 tests successfully               in 203.873 secs

adam

> > diff --git a/drivers/soc/imx/gpcv2.c b/drivers/soc/imx/gpcv2.c
> > index 8176380b02e6..8124a3434655 100644
> > --- a/drivers/soc/imx/gpcv2.c
> > +++ b/drivers/soc/imx/gpcv2.c
> > @@ -67,6 +67,9 @@
> >
> >  #define GPC_PU_PGC_SW_PUP_REQ          0x0f8
> >  #define GPC_PU_PGC_SW_PDN_REQ          0x104
> > +#define GPC_A53_PU_PGC_PUP_STATUS0     0x14c
> > +#define GPC_A53_PU_PGC_PUP_STATUS1     0x150
> > +#define GPC_A53_PU_PGC_PUP_STATUS2     0x154
> >
> >  #define IMX7_USB_HSIC_PHY_SW_Pxx_REQ           BIT(4)
> >  #define IMX7_USB_OTG2_PHY_SW_Pxx_REQ           BIT(3)
> > @@ -224,6 +227,7 @@ static int imx_pgc_power_up(struct generic_pm_domain *genpd)
> >         u32 reg_val, pgc;
> >         int ret;
> >
> > +printk("%s %s\n", __func__, genpd->name);
> >         ret = pm_runtime_get_sync(domain->dev);
> >         if (ret < 0) {
> >                 pm_runtime_put_noidle(domain->dev);
> > @@ -258,9 +262,17 @@ static int imx_pgc_power_up(struct
> > generic_pm_domain *genpd)
> >                 ret = regmap_read_poll_timeout(domain->regmap,
> >                                                GPC_PU_PGC_SW_PUP_REQ, reg_val,
> >                                                !(reg_val & domain->bits.pxx),
> > -                                              0, USEC_PER_MSEC);
> > +                                              0, 100 * USEC_PER_MSEC);
> >                 if (ret) {
> > -                       dev_err(domain->dev, "failed to command PGC\n");
> > +                       dev_err(domain->dev, "%s: failed to command
> > PGC\n", __func__);
> > +                       if (!regmap_read(domain->regmap,
> > GPC_PU_PGC_SW_PUP_REQ, &reg_val))
> > +                               dev_err(domain->dev,
> > "GPC_PU_PGC_SW_PUP_REQ(0x%03x)=0x%08x\n", GPC_PU_PGC_SW_PUP_REQ,
> > reg_val);
> > +                       if (!regmap_read(domain->regmap,
> > GPC_A53_PU_PGC_PUP_STATUS0, &reg_val))
> > +                               dev_err(domain->dev,
> > "GPC_A53_PU_PGC_PUP_STATUS0(0x%03x)=0x%08x\n",
> > GPC_A53_PU_PGC_PUP_STATUS0, reg_val);
> > +                       if (!regmap_read(domain->regmap,
> > GPC_A53_PU_PGC_PUP_STATUS1, &reg_val))
> > +                               dev_err(domain->dev,
> > "GPC_A53_PU_PGC_PUP_STATUS1(0x%03x)=0x%08x\n",
> > GPC_A53_PU_PGC_PUP_STATUS1, reg_val);
> > +                       if (!regmap_read(domain->regmap,
> > GPC_A53_PU_PGC_PUP_STATUS2, &reg_val))
> > +                               dev_err(domain->dev,
> > "GPC_A53_PU_PGC_PUP_STATUS2(0x%03x)=0x%08x\n",
> > GPC_A53_PU_PGC_PUP_STATUS2, reg_val);
> >                         goto out_clk_disable;
> >                 }
> >
> > @@ -318,6 +330,7 @@ static int imx_pgc_power_down(struct
> > generic_pm_domain *genpd)
> >         u32 reg_val, pgc;
> >         int ret;
> >
> > +printk("%s %s\n", __func__, genpd->name);
> >         /* Enable reset clocks for all devices in the domain */
> >         if (!domain->keep_clocks) {
> >                 ret = clk_bulk_prepare_enable(domain->num_clks, domain->clks);
> > @@ -335,7 +348,7 @@ static int imx_pgc_power_down(struct
> > generic_pm_domain *genpd)
> >                 ret = regmap_read_poll_timeout(domain->regmap, GPC_PU_PWRHSK,
> >                                                reg_val,
> >                                                !(reg_val & domain->bits.hskack),
> > -                                              0, USEC_PER_MSEC);
> > +                                              0, 100 * USEC_PER_MSEC);
> >                 if (ret) {
> >                         dev_err(domain->dev, "failed to power down ADB400\n");
> >                         goto out_clk_disable;
> > @@ -359,9 +372,9 @@ static int imx_pgc_power_down(struct
> > generic_pm_domain *genpd)
> >                 ret = regmap_read_poll_timeout(domain->regmap,
> >                                                GPC_PU_PGC_SW_PDN_REQ, reg_val,
> >                                                !(reg_val & domain->bits.pxx),
> > -                                              0, USEC_PER_MSEC);
> > +                                              0, 100 * USEC_PER_MSEC);
> >                 if (ret) {
> > -                       dev_err(domain->dev, "failed to command PGC\n");
> > +                       dev_err(domain->dev, "%s: failed to command
> > PGC\n", __func__);
> >                         goto out_clk_disable;
> >                 }
> >         }
> > @@ -712,6 +725,7 @@ static const struct imx_pgc_domain imx8mm_pgc_domains[] = {
> >                         .map = IMX8MM_VPUG1_A53_DOMAIN,
> >                 },
> >                 .pgc   = BIT(IMX8MM_PGC_VPUG1),
> > +               .keep_clocks = true,
> >         },
> >
> >         [IMX8MM_POWER_DOMAIN_VPUG2] = {
> > @@ -723,6 +737,7 @@ static const struct imx_pgc_domain imx8mm_pgc_domains[] = {
> >                         .map = IMX8MM_VPUG2_A53_DOMAIN,
> >                 },
> >                 .pgc   = BIT(IMX8MM_PGC_VPUG2),
> > +               .keep_clocks = true,
> >         },
> >
> >         [IMX8MM_POWER_DOMAIN_VPUH1] = {
> > diff --git a/drivers/soc/imx/imx8m-blk-ctrl.c b/drivers/soc/imx/imx8m-blk-ctrl.c
> > index 519b3651d1d9..028f38d45892 100644
> > --- a/drivers/soc/imx/imx8m-blk-ctrl.c
> > +++ b/drivers/soc/imx/imx8m-blk-ctrl.c
> > @@ -68,6 +68,7 @@ static int imx8m_blk_ctrl_power_on(struct
> > generic_pm_domain *genpd)
> >         struct imx8m_blk_ctrl *bc = domain->bc;
> >         int ret;
> >
> > +printk("%s %s\n", __func__, genpd->name);
> >         /* make sure bus domain is awake */
> >         ret = pm_runtime_get_sync(bc->bus_power_dev);
> >         if (ret < 0) {
> > @@ -119,6 +120,7 @@ static int imx8m_blk_ctrl_power_off(struct
> > generic_pm_domain *genpd)
> >         const struct imx8m_blk_ctrl_domain_data *data = domain->data;
> >         struct imx8m_blk_ctrl *bc = domain->bc;
> >
> > +printk("%s %s\n", __func__, genpd->name);
> >         /* put devices into reset and disable clocks */
> >         regmap_clear_bits(bc->regmap, BLK_SFT_RSTN, data->rst_mask);
> >         regmap_clear_bits(bc->regmap, BLK_CLK_EN, data->clk_mask);
> >
> > Tim
