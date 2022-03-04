Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 963DF4CCAE9
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 01:44:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237428AbiCDApX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 19:45:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232515AbiCDApV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 19:45:21 -0500
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36BF04926C;
        Thu,  3 Mar 2022 16:44:35 -0800 (PST)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-2dbd8777564so75281947b3.0;
        Thu, 03 Mar 2022 16:44:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dLALxItWgxsNG6U1YXWFhnvuFaV/f2JixE+QQyWv5pA=;
        b=CWMrONUQctSs6jCZezdQqCCf6KUhCpp0jGoVYjqRE/Rkq5HjstSsywv2hwFS2r0GwC
         1uLcNOejJJMVP01lDF069p3imMR9yAUdzmyvjtDOjOqvHWL8f7BELDPZMwK32Gj3D8W1
         3u4KEiwehBlCW7DEhk9CXXR/lSVGb0Kve9okeRgyVlaCisKYdOv124w9inQAzML5rvng
         2JVrTvhSDcDldQ11IwtLL2s+TnBLXuSyZy5q0Pr00taAA208enLNByIi2/lEF3Imjxb1
         MN1dGuT5dglZtmrRk/iPwBxnh6gPdJon2ioRKEzIBtFyMpFFtWcKID8HV+fLB3BE+TMn
         BVAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dLALxItWgxsNG6U1YXWFhnvuFaV/f2JixE+QQyWv5pA=;
        b=beazFVFh18mynId7CzmCZCGi4boeraEuE4IjkY0WkqhT57KmIUeBFzP2XyCK3b56Gr
         FIvsobKSNsI12lIIPxtUCtT3C5QQoOzsB8X4G5nAEt5+PJBp+JQJ4urhdqORWYecOTNV
         i/sPo9n117tnnrAndlMnsvKqsXg7inL2gL+/ggp7AA0W0DYC2n8JmbtcEUA6uADRJ/p4
         vkhKONK5c6KgGzBH8o2JMgUiWCDyjNFq3rbvLw8irV4tmG5H3x3RsN+WiDvy6q5APtnE
         Mhyz2Nw4rlRiIMXhLN66ToxC+q0Z3J2s9QkQTbvivPgerxznjqbQISpAjEYVq8Lzdfri
         lI2A==
X-Gm-Message-State: AOAM532dQWzfVaxzQopV7ciLLoy2nKOwIbcRj4f4fqvxprRI9eseYSxK
        stejD+660nOM+hSDIacz4fTWXp5LJxiqXe59qyc=
X-Google-Smtp-Source: ABdhPJxgyR4NRb1o1kAOq1BTPJL+QzB9Ac7XvOvDSLUUPxhXNO8bv+HXwT9gBSTQaqMPPovALbZXCYt6+fV2BheasL8=
X-Received: by 2002:a0d:d550:0:b0:2db:da84:7adf with SMTP id
 x77-20020a0dd550000000b002dbda847adfmr16250043ywd.241.1646354674337; Thu, 03
 Mar 2022 16:44:34 -0800 (PST)
MIME-Version: 1.0
References: <20220303015151.1711860-1-pgwipeout@gmail.com> <CAPDyKFrk+HCbSZtB7uv6u9tjTgzFDjpB9oP9FYJUqNxcCzQ9iw@mail.gmail.com>
 <CAMdYzYrndAwWJELRRL4kP-BCdWuF6bLVwS2PUMVx_UcJZE=nsQ@mail.gmail.com>
 <CAPDyKFp8tZ-Ty0Wo2jkTjr6Jun83QczQfQRQ1zvFBBCOCWjtng@mail.gmail.com> <CAMdYzYof0GrYV+R3R7q+sjqOe6f5eT7yhy8AYKAd0udaybbHVw@mail.gmail.com>
In-Reply-To: <CAMdYzYof0GrYV+R3R7q+sjqOe6f5eT7yhy8AYKAd0udaybbHVw@mail.gmail.com>
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Thu, 3 Mar 2022 19:44:23 -0500
Message-ID: <CAMdYzYqgGbB2CLjW0PT_dTCeHf_pPwD3aCuJAb-Btx=1AkGzhw@mail.gmail.com>
Subject: Re: [PATCH] mmc: host: dw-mmc-rockchip: fix handling invalid clock rates
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Addy Ke <addy.ke@rock-chips.com>,
        Doug Anderson <dianders@chromium.org>,
        linux-mmc@vger.kernel.org,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 3, 2022 at 4:28 PM Peter Geis <pgwipeout@gmail.com> wrote:
>
> On Thu, Mar 3, 2022 at 5:21 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > On Thu, 3 Mar 2022 at 10:49, Peter Geis <pgwipeout@gmail.com> wrote:
> > >
> > > On Thu, Mar 3, 2022 at 2:53 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > > >
> > > > On Thu, 3 Mar 2022 at 02:52, Peter Geis <pgwipeout@gmail.com> wrote:
> > > > >
> > > > > The Rockchip ciu clock cannot be set as low as the dw-mmc hardware
> > > > > supports. This leads to a situation during card initialization where the
> > > > > ciu clock is set lower than the clock driver can support. The
> > > > > dw-mmc-rockchip driver spews errors when this happens.
> > > > > For normal operation this only happens a few times during boot, but when
> > > > > cd-broken is enabled (in cases such as the SoQuartz module) this fires
> > > > > multiple times each poll cycle.
> > > > >
> > > > > Fix this by testing the minimum frequency the clock driver can support
> > > > > that is within the mmc specification, then divide that by the internal
> > > > > clock divider. Set the f_min frequency to this value, or if it fails,
> > > > > set f_min to the downstream driver's default.
> > > > >
> > > > > Fixes: f629ba2c04c9 ("mmc: dw_mmc: add support for RK3288")
> > > > >
> > > > > Signed-off-by: Peter Geis <pgwipeout@gmail.com>
> > > > > ---
> > > > >  drivers/mmc/host/dw_mmc-rockchip.c | 31 ++++++++++++++++++++++++++----
> > > > >  1 file changed, 27 insertions(+), 4 deletions(-)
> > > > >
> > > > > diff --git a/drivers/mmc/host/dw_mmc-rockchip.c b/drivers/mmc/host/dw_mmc-rockchip.c
> > > > > index 95d0ec0f5f3a..c198590cd74a 100644
> > > > > --- a/drivers/mmc/host/dw_mmc-rockchip.c
> > > > > +++ b/drivers/mmc/host/dw_mmc-rockchip.c
> > > > > @@ -15,7 +15,9 @@
> > > > >  #include "dw_mmc.h"
> > > > >  #include "dw_mmc-pltfm.h"
> > > > >
> > > > > -#define RK3288_CLKGEN_DIV       2
> > > > > +#define RK3288_CLKGEN_DIV      2
> > > > > +#define RK3288_MIN_INIT_FREQ   375000
> > > > > +#define MMC_MAX_INIT_FREQ      400000
> > > > >
> > > > >  struct dw_mci_rockchip_priv_data {
> > > > >         struct clk              *drv_clk;
> > > > > @@ -27,6 +29,7 @@ struct dw_mci_rockchip_priv_data {
> > > > >  static void dw_mci_rk3288_set_ios(struct dw_mci *host, struct mmc_ios *ios)
> > > > >  {
> > > > >         struct dw_mci_rockchip_priv_data *priv = host->priv;
> > > > > +       struct mmc_host *mmc = mmc_from_priv(host);
> > > > >         int ret;
> > > > >         unsigned int cclkin;
> > > > >         u32 bus_hz;
> > > > > @@ -34,6 +37,10 @@ static void dw_mci_rk3288_set_ios(struct dw_mci *host, struct mmc_ios *ios)
> > > > >         if (ios->clock == 0)
> > > > >                 return;
> > > > >
> > > > > +       /* the clock will fail if below the f_min rate */
> > > > > +       if (ios->clock < mmc->f_min)
> > > > > +               ios->clock = mmc->f_min;
> > > > > +
> > > >
> > > > You shouldn't need this. The mmc core should manage this already.
> > >
> > > I thought so too, but while setting f_min did reduce the number of
> > > errors, it didn't stop them completely.
> > > Each tick I was getting three failures, it turns out mmc core tries
> > > anyways with 300000, 200000, and 100000.
> > > Clamping it here was necessary to stop these.
> >
> > Ohh, that was certainly a surprise to me. Unless the dw_mmc driver
> > invokes this path on it's own in some odd way, that means the mmc core
> > has a bug that we need to fix.
> >
> > Would you mind taking a stack trace or debug this so we understand in
> > what case the mmc core doesn't respect f_min? It really should.
>
> I thought it was odd too, will check into where it's happening.
> Thanks!

[   11.376608] Hardware name: Pine64 RK3566 Quartz64-A Board (DT)
[   11.377127] Workqueue: events_freezable mmc_rescan
[   11.377567] Call trace:
[   11.377788]  dump_backtrace.part.0+0xd8/0xe4
[   11.378177]  show_stack+0x24/0x80
[   11.378479]  dump_stack_lvl+0x68/0x84
[   11.378812]  dump_stack+0x1c/0x38
[   11.379111]  dw_mci_rk3288_set_ios+0x128/0x150
[   11.379512]  dw_mci_set_ios+0xb0/0x280
[   11.379849]  mmc_power_up.part.0+0xd0/0x17c
[   11.380225]  mmc_rescan+0x184/0x2f0
[   11.380538]  process_one_work+0x1e0/0x48c
[   11.380901]  worker_thread+0x148/0x46c
[   11.381238]  kthread+0x100/0x110
[   11.381530]  ret_from_fork+0x10/0x20

Seems to be happening here:
https://elixir.bootlin.com/linux/latest/source/drivers/mmc/core/core.c#L2233
But it should be guarded.
I'm continuing to dig into it.

>
> >
> > [...]
> >
> > Kind regards
> > Uffe
