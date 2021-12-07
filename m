Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFD3C46B062
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 03:00:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233870AbhLGCEE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 21:04:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231330AbhLGCEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 21:04:02 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F7E4C061746
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 18:00:32 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id p4so13201323qkm.7
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 18:00:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LHUXbPRT25ZDGyYQUP9EBdAS2w1po8K23wsE9IxclQk=;
        b=qlYV3iClS+ewTz9MNtRVV068VCFdmh32g7bxah8hRW43G3UhX8MDE0ve7Rv1DOE7BY
         Q/O/2i/m3At0lBx/bfJfJWjxy+9FHg5G0pjtLuG0/Zu7IkAI3tIKe3hd7onOt+jlYPH8
         CMa+YMPbdvXUlkHEh5DAFrVexOfscXuuDXujz/+/Q//NV14eKWnqyJmqmP3YtYV5j2FS
         lwbDHQYWCbKVw07jcvyxPffdZZ08K36mNnnnKNKLL2PVlARA8cXmDvauPU/l811uzvr7
         aaw4IpslGK20NREkJB3aaEq1D1D+pNlIQOGwngIN/G8OyonYFwMnvFmteEJAhZeNmdQk
         NIpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LHUXbPRT25ZDGyYQUP9EBdAS2w1po8K23wsE9IxclQk=;
        b=YsxUnveqGNckWZoeXhYXlwZkqW9l5yfMjJhtSIiYBt92BPVblNSQdY4STfmkSWYJ1N
         nBqxHxddNBJwWJ3mF4bn1fa87xxKNT2Cn8GybOaDTs3MQvwW8nwVDhlcU5ooFiFp27a0
         dS9BvyUwOcB2473of1w8jOdtwTk40Gocl6jiiGHC733sKNpX3vYpU/qsfvrkmhdzN7Iu
         llD3tsAbj/uB6X4FlDp1jhUDwBVs75yNNeeOazy7ZPb1Nr9i1XFwvzgdhO28lsowdeHw
         f2/Efq2+t/0GtOXsxWU14T8ylOCoHhHUqM+Yg02/oD/XemrHPS31SUbtUFSnu2XSPvxs
         RzFQ==
X-Gm-Message-State: AOAM531wUhUbH1ueEjFKP7JHXjDDInRrm77ZF2vXOImnCY1W6vzgSFI7
        euOYqj4n3ir8cMHWqfOqW+Fqpn8oiBcKmFIycHa73g==
X-Google-Smtp-Source: ABdhPJw97MStNRFea+NYyfM5DcUImSj/8TRCrOrCZq/Nm/PIVjOTf+7OL70Rwjttb0VO9ssJzBfqKKOJBNi7jXWamEc=
X-Received: by 2002:a05:620a:c50:: with SMTP id u16mr38296709qki.203.1638842431627;
 Mon, 06 Dec 2021 18:00:31 -0800 (PST)
MIME-Version: 1.0
References: <20211125183622.597177-1-dmitry.baryshkov@linaro.org>
 <CAGETcx-_6OvcJM1nAoX3pxE3Rard5CRxEuEsmhfLANOzOS1BSQ@mail.gmail.com>
 <CAGETcx86iFm04PxnmrRQhooxtd4_kv87rAu=T0RauqFXmRLKNA@mail.gmail.com> <CAA8EJpr4+B1Q3voOr__3M37jxxBRi0g3avzE1Y8CDLkZB+rSGg@mail.gmail.com>
In-Reply-To: <CAA8EJpr4+B1Q3voOr__3M37jxxBRi0g3avzE1Y8CDLkZB+rSGg@mail.gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 7 Dec 2021 05:00:20 +0300
Message-ID: <CAA8EJpr47F6x+GhV1z_uLWmGFKCdYCoohvi_A83SBynKGf=qkA@mail.gmail.com>
Subject: Re: [PATCH] of: property: do not create clocks device link for clock controllers
To:     Saravana Kannan <saravanak@google.com>
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

Hi Saravana,

On Tue, 30 Nov 2021 at 03:24, Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On Tue, 30 Nov 2021 at 02:53, Saravana Kannan <saravanak@google.com> wrote:
> >
> > On Mon, Nov 29, 2021 at 3:48 PM Saravana Kannan <saravanak@google.com> wrote:
> > >
> > > On Thu, Nov 25, 2021 at 10:36 AM Dmitry Baryshkov
> > > <dmitry.baryshkov@linaro.org> wrote:
> > > >
> > > > Do not create device link for clock controllers.
> > >
> > > Nak.
> > >
> > > > Some of the clocks
> > > > provided to the device via OF can be the clocks that are just parents to
> > > > the clocks provided by this clock controller. Clock subsystem already
> > > > has support for handling missing clock parents correctly (clock
> > > > orphans). Later when the parent clock is registered, clocks get
> > > > populated properly.
> > > >
> > > > An example of the system where this matters is the SDM8450 MTP board
> > > > (see arch/arm64/boot/dts/qcom/sdm845-mtp.dts). Here the dispcc uses
> > > > clocks provided by dsi0_phy and dsi1_phy device tree nodes. However the
> > > > dispcc itself provides clocks to both PHYs, to the PHY parent device,
> > > > etc. With just dsi0_phy in place devlink is able to break the
> > > > dependency,
> > >
> > > Right, because I wrote code to make sure we handle these clock
> > > controller cases properly. If that logic isn't smart enough, let's fix
> > > that.
>
> As I said, devlink was delaying dispcc probing ,waiting for the second
> DSI PHY clock provider.
> Thus came my proposal to let clock orphans handle the case (which it
> does perfectly).
>
> > >
> > > > but with two PHYs, dispcc doesn't get probed at all, thus
> > > > breaking display support.
> > >
> > > Then let's find out why and fix this instead of hiding some
> > > dependencies from fw_devlink. You could be breaking other cases/boards
> > > with this change you are making.
> >
> > Btw, forgot to mention. I'll look into this one and try to find the
> > reason why it wasn't handled automatically. And then come up with a
> > fix.
> >
> > If you want to find out why fw_devlink didn't notice the cycle
> > correctly for the case of 2 PHYs vs 1 PHY, I'd appreciate that too.
> >
> > Btw, same comment for remote-endpoint. I'll look into what's going on
> > in that case. Btw, I'm assuming all the code and DT you are testing
> > this on is already upstream. Can you please confirm that?
>
> All the code and basic DT is upstreamed. The DT part I
> referenced/posted was written for the custom extender for the
> qrb5165-rb5 board that I use here to test MSM DRM driver, but the
> result DT should be more or less the same as smd845-mtp.

So, is there a way we can assist you in debugging these issues? I
still can not get dual DSI setup to work without this patch (or
without disabling fw_devlink).

>
> >
> > -Saravana
> >
> > >
> > > -Saravana
> > >
> > > > Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> > > > Cc: Stephen Boyd <swboyd@chromium.org>
> > > > Cc: Saravana Kannan <saravanak@google.com>
> > > > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > > > ---
> > > >  drivers/of/property.c | 16 +++++++++++++++-
> > > >  1 file changed, 15 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/of/property.c b/drivers/of/property.c
> > > > index a3483484a5a2..f7229e4030e3 100644
> > > > --- a/drivers/of/property.c
> > > > +++ b/drivers/of/property.c
> > > > @@ -1264,7 +1264,6 @@ struct supplier_bindings {
> > > >         bool node_not_dev;
> > > >  };
> > > >
> > > > -DEFINE_SIMPLE_PROP(clocks, "clocks", "#clock-cells")
> > > >  DEFINE_SIMPLE_PROP(interconnects, "interconnects", "#interconnect-cells")
> > > >  DEFINE_SIMPLE_PROP(iommus, "iommus", "#iommu-cells")
> > > >  DEFINE_SIMPLE_PROP(mboxes, "mboxes", "#mbox-cells")
> > > > @@ -1294,6 +1293,21 @@ DEFINE_SIMPLE_PROP(backlight, "backlight", NULL)
> > > >  DEFINE_SUFFIX_PROP(regulators, "-supply", NULL)
> > > >  DEFINE_SUFFIX_PROP(gpio, "-gpio", "#gpio-cells")
> > > >
> > > > +static struct device_node *parse_clocks(struct device_node *np,
> > > > +                                       const char *prop_name, int index)
> > > > +{
> > > > +       /*
> > > > +        * Do not create clock-related device links for clocks controllers,
> > > > +        * clock orphans will handle missing clock parents automatically.
> > > > +        */
> > > > +       if (!strcmp(prop_name, "clocks") &&
> > > > +           of_find_property(np, "#clock-cells", NULL))
> > > > +               return NULL;
> > > > +
> > > > +       return parse_prop_cells(np, prop_name, index, "clocks",
> > > > +                                      "#clock-cells");
> > > > +}
> > > > +
> > > >  static struct device_node *parse_gpios(struct device_node *np,
> > > >                                        const char *prop_name, int index)
> > > >  {
> > > > --
> > > > 2.33.0
> > > >
>
>
>
> --
> With best wishes
> Dmitry



-- 
With best wishes
Dmitry
