Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC0784CC805
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 22:28:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231768AbiCCV3e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 16:29:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiCCV3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 16:29:33 -0500
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8349990240;
        Thu,  3 Mar 2022 13:28:47 -0800 (PST)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-2dc348dab52so36973677b3.6;
        Thu, 03 Mar 2022 13:28:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5kzCO6ZuG1IB0yxdpaRVHfSrOW7x6a/kjGmERey6dz8=;
        b=ixomibzc2d7CYBNzMn49vkEgHURtgDpn4TKa2tFJaFJ0gSDjbP8KwdFdmFKVHO7WB6
         8aM0+FRjAggQZVC7iR8iVLkSGESftaCA60+Fgkjclys/rXL+LL3mkf3cYZ9Rhnc9t8zN
         sp2953w+QTHjPV3VriPb2r5dhVQYnE+39SJ7d9fgI27WijVdZX6yYRmyC7auwU8aLvtU
         lolPBO7MeRxV+OxnrrIFL1BJNCq3H9pKJB9ijSaEye9XeWXTuSJhEHXTcPjY7+DN+LlW
         jdriBM2dgmjJAV3c9/uzaMBEqbOmuDt8eAJWxcUrbh+dsDf9JllFokAKZUSTLuuzX/Jp
         SLNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5kzCO6ZuG1IB0yxdpaRVHfSrOW7x6a/kjGmERey6dz8=;
        b=q7VGlAApYGJD40tvmY/y9xZo3y4OXxHNnivbXG7n5wdw43vuUAHp+fvQk/IH2lK3Cu
         O0qaDekTCc/sA1vEv215ExSwyuBRowEGMBQ0GdJU2PDT1MqTIKZlb2bxbFWkKzcUWMic
         Hp4Cutr1dOTvxLgwNo0/+ZNqW/jWGSGXth0USDKV8e7CSVCLQUiGVMDqB/0uHDD04HMH
         pbkmX4+UAHcL+fAIa8vZVAN/dTaQpyWiYsHJhW8C7lvFHwysFbcHoiIWlvaBxYTbwARx
         BjvoBV07OLWpbm+ch5IA5cv9oHvkca8HWKxtXBjfd/jebseRQdnQ6D6Wc2b8AKbK80zU
         FzYw==
X-Gm-Message-State: AOAM531A5+HjaqubMlr27XAcgIdePt7RrBSeXSB4+aSYdqY9zH4nY3SZ
        Hq+Q0v+kOUJz9dDlTof8NELEk4I7/eZo8/L7sU4=
X-Google-Smtp-Source: ABdhPJxKsaSouh8e/GcwT+Id1vzHp/eI19ubtJnWHGGauGO2ZZGOAPrzzwl8bH0fK2cMFxENk9RcUgMQFb8DVPbDAfo=
X-Received: by 2002:a05:690c:89:b0:2d7:fb7d:db7 with SMTP id
 be9-20020a05690c008900b002d7fb7d0db7mr40208107ywb.219.1646342926666; Thu, 03
 Mar 2022 13:28:46 -0800 (PST)
MIME-Version: 1.0
References: <20220303015151.1711860-1-pgwipeout@gmail.com> <CAPDyKFrk+HCbSZtB7uv6u9tjTgzFDjpB9oP9FYJUqNxcCzQ9iw@mail.gmail.com>
 <CAMdYzYrndAwWJELRRL4kP-BCdWuF6bLVwS2PUMVx_UcJZE=nsQ@mail.gmail.com> <CAPDyKFp8tZ-Ty0Wo2jkTjr6Jun83QczQfQRQ1zvFBBCOCWjtng@mail.gmail.com>
In-Reply-To: <CAPDyKFp8tZ-Ty0Wo2jkTjr6Jun83QczQfQRQ1zvFBBCOCWjtng@mail.gmail.com>
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Thu, 3 Mar 2022 16:28:35 -0500
Message-ID: <CAMdYzYof0GrYV+R3R7q+sjqOe6f5eT7yhy8AYKAd0udaybbHVw@mail.gmail.com>
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

On Thu, Mar 3, 2022 at 5:21 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Thu, 3 Mar 2022 at 10:49, Peter Geis <pgwipeout@gmail.com> wrote:
> >
> > On Thu, Mar 3, 2022 at 2:53 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > >
> > > On Thu, 3 Mar 2022 at 02:52, Peter Geis <pgwipeout@gmail.com> wrote:
> > > >
> > > > The Rockchip ciu clock cannot be set as low as the dw-mmc hardware
> > > > supports. This leads to a situation during card initialization where the
> > > > ciu clock is set lower than the clock driver can support. The
> > > > dw-mmc-rockchip driver spews errors when this happens.
> > > > For normal operation this only happens a few times during boot, but when
> > > > cd-broken is enabled (in cases such as the SoQuartz module) this fires
> > > > multiple times each poll cycle.
> > > >
> > > > Fix this by testing the minimum frequency the clock driver can support
> > > > that is within the mmc specification, then divide that by the internal
> > > > clock divider. Set the f_min frequency to this value, or if it fails,
> > > > set f_min to the downstream driver's default.
> > > >
> > > > Fixes: f629ba2c04c9 ("mmc: dw_mmc: add support for RK3288")
> > > >
> > > > Signed-off-by: Peter Geis <pgwipeout@gmail.com>
> > > > ---
> > > >  drivers/mmc/host/dw_mmc-rockchip.c | 31 ++++++++++++++++++++++++++----
> > > >  1 file changed, 27 insertions(+), 4 deletions(-)
> > > >
> > > > diff --git a/drivers/mmc/host/dw_mmc-rockchip.c b/drivers/mmc/host/dw_mmc-rockchip.c
> > > > index 95d0ec0f5f3a..c198590cd74a 100644
> > > > --- a/drivers/mmc/host/dw_mmc-rockchip.c
> > > > +++ b/drivers/mmc/host/dw_mmc-rockchip.c
> > > > @@ -15,7 +15,9 @@
> > > >  #include "dw_mmc.h"
> > > >  #include "dw_mmc-pltfm.h"
> > > >
> > > > -#define RK3288_CLKGEN_DIV       2
> > > > +#define RK3288_CLKGEN_DIV      2
> > > > +#define RK3288_MIN_INIT_FREQ   375000
> > > > +#define MMC_MAX_INIT_FREQ      400000
> > > >
> > > >  struct dw_mci_rockchip_priv_data {
> > > >         struct clk              *drv_clk;
> > > > @@ -27,6 +29,7 @@ struct dw_mci_rockchip_priv_data {
> > > >  static void dw_mci_rk3288_set_ios(struct dw_mci *host, struct mmc_ios *ios)
> > > >  {
> > > >         struct dw_mci_rockchip_priv_data *priv = host->priv;
> > > > +       struct mmc_host *mmc = mmc_from_priv(host);
> > > >         int ret;
> > > >         unsigned int cclkin;
> > > >         u32 bus_hz;
> > > > @@ -34,6 +37,10 @@ static void dw_mci_rk3288_set_ios(struct dw_mci *host, struct mmc_ios *ios)
> > > >         if (ios->clock == 0)
> > > >                 return;
> > > >
> > > > +       /* the clock will fail if below the f_min rate */
> > > > +       if (ios->clock < mmc->f_min)
> > > > +               ios->clock = mmc->f_min;
> > > > +
> > >
> > > You shouldn't need this. The mmc core should manage this already.
> >
> > I thought so too, but while setting f_min did reduce the number of
> > errors, it didn't stop them completely.
> > Each tick I was getting three failures, it turns out mmc core tries
> > anyways with 300000, 200000, and 100000.
> > Clamping it here was necessary to stop these.
>
> Ohh, that was certainly a surprise to me. Unless the dw_mmc driver
> invokes this path on it's own in some odd way, that means the mmc core
> has a bug that we need to fix.
>
> Would you mind taking a stack trace or debug this so we understand in
> what case the mmc core doesn't respect f_min? It really should.

I thought it was odd too, will check into where it's happening.
Thanks!

>
> [...]
>
> Kind regards
> Uffe
