Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A1FB46B08D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 03:24:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241322AbhLGC2W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 21:28:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238230AbhLGC2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 21:28:21 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F220DC0613F8
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 18:24:51 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id e136so36713391ybc.4
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 18:24:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2OMixw9Me0yHhWDDFaCGdGZaAxF8n91aCEtHks1Fm+k=;
        b=CGZbhBmdY5MHv2LFP5YUvDRPTzIFRZu1FsTDtGhF9qgzXDYoAsK68UvPmq/QhFY3QQ
         YTV2rd/IMY67472eI/UY7WiVkJVpuHBh+G/8pL2L+YMYp74z6CvHMdq66+3k9QBNNe7M
         DJPZZCKaRNNgydzIVvjFBowrz6D3uPn1B26YVmO/7KotpsKxVZefoSJDStMkcqM8QHPZ
         VHaQw4MNp+i6h/y4Z+6P57te1oqSWi6wYCAPPH+FKhoZhyxLUWhQ9aNcTG/v2YkqBerO
         sSpb0CLj897HnY35eaZkBYwTlBj0fofJzClPY3052lGVbwBXiDWlLynvOB7audlWW4Lu
         KWRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2OMixw9Me0yHhWDDFaCGdGZaAxF8n91aCEtHks1Fm+k=;
        b=NQr3lH2MQBsJTdiGtwJ+r2HaeFzVZgnKbhM3hAIGzF8+c6UHqgPBs6L3/Yn7IgHv2t
         xo7Y22HiOYjZnpmk2Iv7v2kuZ9YOsdJizft7KL/wN6V53oK5VD3GZU/Us+oVMWb0WQ0Y
         vQoREgAbNapXTFr9rz33QNtzOFZSz1vKgHH1HFR666qpRAaDb/CQrxbXD7+jl2soFAqS
         PqgebGrXk9ubemCzXiusBSwhgLuNngIHz5Dn14BdMDylEft7LQxE4YZC9CBPY2vWKuHt
         k0fGn95ZhECvkjsgTFoJHJi5R3lmKt0cb1bR6CsuhpqqAQp6lykb6vKWmotFo0tCAw4I
         u/lg==
X-Gm-Message-State: AOAM530UkQlnoRrVn/HUucwvd/4J0yAsj28rkL0MAu3ErRvuv8Phpejd
        tx+OtQw7FkEmgBfQIV64SsDFkk9/2/aKIBkFjMDZ7g==
X-Google-Smtp-Source: ABdhPJz4iot5xR5ycz2pnVGAMO4lq4a50xzmyMnRXGumF6yGCeBGm4Djut0AsSC8Z9NssHyuMmZxcc3IN0gvH+mqqqk=
X-Received: by 2002:a25:6c6:: with SMTP id 189mr47279877ybg.753.1638843890905;
 Mon, 06 Dec 2021 18:24:50 -0800 (PST)
MIME-Version: 1.0
References: <20211125183622.597177-1-dmitry.baryshkov@linaro.org>
 <CAGETcx-_6OvcJM1nAoX3pxE3Rard5CRxEuEsmhfLANOzOS1BSQ@mail.gmail.com>
 <CAGETcx86iFm04PxnmrRQhooxtd4_kv87rAu=T0RauqFXmRLKNA@mail.gmail.com>
 <CAA8EJpr4+B1Q3voOr__3M37jxxBRi0g3avzE1Y8CDLkZB+rSGg@mail.gmail.com> <CAA8EJpr47F6x+GhV1z_uLWmGFKCdYCoohvi_A83SBynKGf=qkA@mail.gmail.com>
In-Reply-To: <CAA8EJpr47F6x+GhV1z_uLWmGFKCdYCoohvi_A83SBynKGf=qkA@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Mon, 6 Dec 2021 18:24:15 -0800
Message-ID: <CAGETcx9kaFw3sG8bPdDin8pCBzwzZ70ZnZhpkF2ZHq0U4OHJ9A@mail.gmail.com>
Subject: Re: [PATCH] of: property: do not create clocks device link for clock controllers
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Android Kernel Team <kernel-team@android.com>,
        Rob Clark <robdclark@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 6, 2021 at 6:00 PM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> Hi Saravana,
>
> On Tue, 30 Nov 2021 at 03:24, Dmitry Baryshkov
> <dmitry.baryshkov@linaro.org> wrote:
> >
> > On Tue, 30 Nov 2021 at 02:53, Saravana Kannan <saravanak@google.com> wrote:
> > >
> > > On Mon, Nov 29, 2021 at 3:48 PM Saravana Kannan <saravanak@google.com> wrote:
> > > >
> > > > On Thu, Nov 25, 2021 at 10:36 AM Dmitry Baryshkov
> > > > <dmitry.baryshkov@linaro.org> wrote:
> > > > >
> > > > > Do not create device link for clock controllers.
> > > >
> > > > Nak.
> > > >
> > > > > Some of the clocks
> > > > > provided to the device via OF can be the clocks that are just parents to
> > > > > the clocks provided by this clock controller. Clock subsystem already
> > > > > has support for handling missing clock parents correctly (clock
> > > > > orphans). Later when the parent clock is registered, clocks get
> > > > > populated properly.
> > > > >
> > > > > An example of the system where this matters is the SDM8450 MTP board
> > > > > (see arch/arm64/boot/dts/qcom/sdm845-mtp.dts). Here the dispcc uses
> > > > > clocks provided by dsi0_phy and dsi1_phy device tree nodes. However the
> > > > > dispcc itself provides clocks to both PHYs, to the PHY parent device,
> > > > > etc. With just dsi0_phy in place devlink is able to break the
> > > > > dependency,
> > > >
> > > > Right, because I wrote code to make sure we handle these clock
> > > > controller cases properly. If that logic isn't smart enough, let's fix
> > > > that.
> >
> > As I said, devlink was delaying dispcc probing ,waiting for the second
> > DSI PHY clock provider.
> > Thus came my proposal to let clock orphans handle the case (which it
> > does perfectly).
> >
> > > >
> > > > > but with two PHYs, dispcc doesn't get probed at all, thus
> > > > > breaking display support.
> > > >
> > > > Then let's find out why and fix this instead of hiding some
> > > > dependencies from fw_devlink. You could be breaking other cases/boards
> > > > with this change you are making.
> > >
> > > Btw, forgot to mention. I'll look into this one and try to find the
> > > reason why it wasn't handled automatically. And then come up with a
> > > fix.
> > >
> > > If you want to find out why fw_devlink didn't notice the cycle
> > > correctly for the case of 2 PHYs vs 1 PHY, I'd appreciate that too.
> > >
> > > Btw, same comment for remote-endpoint. I'll look into what's going on
> > > in that case. Btw, I'm assuming all the code and DT you are testing
> > > this on is already upstream. Can you please confirm that?
> >
> > All the code and basic DT is upstreamed. The DT part I
> > referenced/posted was written for the custom extender for the
> > qrb5165-rb5 board that I use here to test MSM DRM driver, but the
> > result DT should be more or less the same as smd845-mtp.

Can you point me to some upstream DTS file (not dtsi) that you think
will definitely have this issue (ideally you've actually hit it), and
the specific DT nodes in question? That'd make it much easier for me
to jump in and look as I'm not up to speed on all the MSM boards.

> So, is there a way we can assist you in debugging these issues? I
> still can not get dual DSI setup to work without this patch (or
> without disabling fw_devlink).

Sorry I've been a bit swamped. I'll try to take a look at this soon.

Another thing you could do is look at the existing code that detects
these cycles and fixes them up and figure out why it's not noticing a
cycle for your use case or not fixing the cycle correctly. You'll want
to look at calls to fw_devlink_relax_cycle() inside
fw_devlink_create_devlink().

-Saravana

>
> >
> > >
> > > -Saravana
> > >
> > > >
> > > > -Saravana
> > > >
> > > > > Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> > > > > Cc: Stephen Boyd <swboyd@chromium.org>
> > > > > Cc: Saravana Kannan <saravanak@google.com>
> > > > > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > > > > ---
> > > > >  drivers/of/property.c | 16 +++++++++++++++-
> > > > >  1 file changed, 15 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/drivers/of/property.c b/drivers/of/property.c
> > > > > index a3483484a5a2..f7229e4030e3 100644
> > > > > --- a/drivers/of/property.c
> > > > > +++ b/drivers/of/property.c
> > > > > @@ -1264,7 +1264,6 @@ struct supplier_bindings {
> > > > >         bool node_not_dev;
> > > > >  };
> > > > >
> > > > > -DEFINE_SIMPLE_PROP(clocks, "clocks", "#clock-cells")
> > > > >  DEFINE_SIMPLE_PROP(interconnects, "interconnects", "#interconnect-cells")
> > > > >  DEFINE_SIMPLE_PROP(iommus, "iommus", "#iommu-cells")
> > > > >  DEFINE_SIMPLE_PROP(mboxes, "mboxes", "#mbox-cells")
> > > > > @@ -1294,6 +1293,21 @@ DEFINE_SIMPLE_PROP(backlight, "backlight", NULL)
> > > > >  DEFINE_SUFFIX_PROP(regulators, "-supply", NULL)
> > > > >  DEFINE_SUFFIX_PROP(gpio, "-gpio", "#gpio-cells")
> > > > >
> > > > > +static struct device_node *parse_clocks(struct device_node *np,
> > > > > +                                       const char *prop_name, int index)
> > > > > +{
> > > > > +       /*
> > > > > +        * Do not create clock-related device links for clocks controllers,
> > > > > +        * clock orphans will handle missing clock parents automatically.
> > > > > +        */
> > > > > +       if (!strcmp(prop_name, "clocks") &&
> > > > > +           of_find_property(np, "#clock-cells", NULL))
> > > > > +               return NULL;
> > > > > +
> > > > > +       return parse_prop_cells(np, prop_name, index, "clocks",
> > > > > +                                      "#clock-cells");
> > > > > +}
> > > > > +
> > > > >  static struct device_node *parse_gpios(struct device_node *np,
> > > > >                                        const char *prop_name, int index)
> > > > >  {
> > > > > --
> > > > > 2.33.0
> > > > >
> >
> >
> >
> > --
> > With best wishes
> > Dmitry
>
>
>
> --
> With best wishes
> Dmitry
