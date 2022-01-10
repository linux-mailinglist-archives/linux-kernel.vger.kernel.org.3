Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 661FD48A132
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 21:55:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343635AbiAJUzh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 15:55:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343592AbiAJUzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 15:55:36 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4CEAC061748
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 12:55:35 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id y17so16183345qtx.9
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 12:55:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ecWPxInl3HuP8zOydPTQ3TyGOk0YKWcSUbIGRlu6DQo=;
        b=OCWREoFiQ3peJdDuddWx04e96pfHnNKIpidF4JEhieM8c+x5PQxNxUD7HdoFHeXUxy
         CWTM44zMcwTDAo7INmbjhwPqwOKjpJ6vswlrZS18jbq88eCtlgfA8ZaZvshdI7PiR4FD
         BUqcE+lF8PxrYzEgIjGj8fs58fBzbY61a2u98gbnKn30IotJACwfBcgvSrqoWwsgeZmK
         RBj5PDWm/FsqRqFipzIyCmR06kmoQQ2H/QQaEd/vr2zXC5DvtF398aAPb3cgiz3FlJYL
         dskr9KuTnL09ZAjUI7Di3wsBLDITX/dBErmBd0EHa/MtS83g9flXKStN7BtNfyOoxouQ
         e1dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ecWPxInl3HuP8zOydPTQ3TyGOk0YKWcSUbIGRlu6DQo=;
        b=XJPOxQK2Vt7KbF/CgXW92BJgnNFsPuormqtmXKzPyq7uNCquBCfhVdEZ+vSAzKOcnf
         ULnSy3SHvWT8TaQ1MwXLnQnbGb000bjKlmpX803xrAi823632vL/7cJmWJC4pp537HV2
         geIAu21GeUq1UB/Z/qK+Lzkh4hQnpu01LfpbXP8uy3O/kpqJt4eZlkAPV2RjM9S+5x2M
         yi7c1qMU1HggUjMbAz+azoJ9ixDMSAF58RHVLqdufFKDfeJItknUy08oNFlF9mZra74F
         0TQgE6lbM5Rnb0TR21qsJPJfGGq2fY2jHMtAWX9U4Hr3oF+rv7XCBjWlZ6z+HBmngjLK
         X0KA==
X-Gm-Message-State: AOAM532breuU9xstNxLjXDhVA4Y0HsckyWv5Dr+ZhYN0fPjVd1VOvCnB
        MDFjqHKUN1Wf29uyrPrVCNxeDCiTfnqAjbhoNylLKQ==
X-Google-Smtp-Source: ABdhPJwqwCU2bepKHhHkYQ8PhLUT5YRCWxRrLotXlsesVDPXR8iqaSMIYdOmhhGHfbBzJz8Xa4vvlsf6WIsA8QH6l1I=
X-Received: by 2002:a05:622a:3ca:: with SMTP id k10mr1341029qtx.130.1641848135011;
 Mon, 10 Jan 2022 12:55:35 -0800 (PST)
MIME-Version: 1.0
References: <20211125183622.597177-1-dmitry.baryshkov@linaro.org>
 <CAGETcx-_6OvcJM1nAoX3pxE3Rard5CRxEuEsmhfLANOzOS1BSQ@mail.gmail.com>
 <CAGETcx86iFm04PxnmrRQhooxtd4_kv87rAu=T0RauqFXmRLKNA@mail.gmail.com>
 <CAA8EJpr4+B1Q3voOr__3M37jxxBRi0g3avzE1Y8CDLkZB+rSGg@mail.gmail.com>
 <CAA8EJpr47F6x+GhV1z_uLWmGFKCdYCoohvi_A83SBynKGf=qkA@mail.gmail.com> <CAGETcx9kaFw3sG8bPdDin8pCBzwzZ70ZnZhpkF2ZHq0U4OHJ9A@mail.gmail.com>
In-Reply-To: <CAGETcx9kaFw3sG8bPdDin8pCBzwzZ70ZnZhpkF2ZHq0U4OHJ9A@mail.gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Mon, 10 Jan 2022 23:55:23 +0300
Message-ID: <CAA8EJpqELXvRMPWJdTLCURjwkcMxyPDPj1tVZPkdOT_JVQb4-w@mail.gmail.com>
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

On Tue, 7 Dec 2021 at 05:24, Saravana Kannan <saravanak@google.com> wrote:
>
> On Mon, Dec 6, 2021 at 6:00 PM Dmitry Baryshkov
> <dmitry.baryshkov@linaro.org> wrote:
> >
> > Hi Saravana,
> >
> > On Tue, 30 Nov 2021 at 03:24, Dmitry Baryshkov
> > <dmitry.baryshkov@linaro.org> wrote:
> > >
> > > On Tue, 30 Nov 2021 at 02:53, Saravana Kannan <saravanak@google.com> wrote:
> > > >
> > > > On Mon, Nov 29, 2021 at 3:48 PM Saravana Kannan <saravanak@google.com> wrote:
> > > > >
> > > > > On Thu, Nov 25, 2021 at 10:36 AM Dmitry Baryshkov
> > > > > <dmitry.baryshkov@linaro.org> wrote:
> > > > > >
> > > > > > Do not create device link for clock controllers.
> > > > >
> > > > > Nak.
> > > > >
> > > > > > Some of the clocks
> > > > > > provided to the device via OF can be the clocks that are just parents to
> > > > > > the clocks provided by this clock controller. Clock subsystem already
> > > > > > has support for handling missing clock parents correctly (clock
> > > > > > orphans). Later when the parent clock is registered, clocks get
> > > > > > populated properly.
> > > > > >
> > > > > > An example of the system where this matters is the SDM8450 MTP board
> > > > > > (see arch/arm64/boot/dts/qcom/sdm845-mtp.dts). Here the dispcc uses
> > > > > > clocks provided by dsi0_phy and dsi1_phy device tree nodes. However the
> > > > > > dispcc itself provides clocks to both PHYs, to the PHY parent device,
> > > > > > etc. With just dsi0_phy in place devlink is able to break the
> > > > > > dependency,
> > > > >
> > > > > Right, because I wrote code to make sure we handle these clock
> > > > > controller cases properly. If that logic isn't smart enough, let's fix
> > > > > that.
> > >
> > > As I said, devlink was delaying dispcc probing ,waiting for the second
> > > DSI PHY clock provider.
> > > Thus came my proposal to let clock orphans handle the case (which it
> > > does perfectly).
> > >
> > > > >
> > > > > > but with two PHYs, dispcc doesn't get probed at all, thus
> > > > > > breaking display support.
> > > > >
> > > > > Then let's find out why and fix this instead of hiding some
> > > > > dependencies from fw_devlink. You could be breaking other cases/boards
> > > > > with this change you are making.
> > > >
> > > > Btw, forgot to mention. I'll look into this one and try to find the
> > > > reason why it wasn't handled automatically. And then come up with a
> > > > fix.
> > > >
> > > > If you want to find out why fw_devlink didn't notice the cycle
> > > > correctly for the case of 2 PHYs vs 1 PHY, I'd appreciate that too.
> > > >
> > > > Btw, same comment for remote-endpoint. I'll look into what's going on
> > > > in that case. Btw, I'm assuming all the code and DT you are testing
> > > > this on is already upstream. Can you please confirm that?
> > >
> > > All the code and basic DT is upstreamed. The DT part I
> > > referenced/posted was written for the custom extender for the
> > > qrb5165-rb5 board that I use here to test MSM DRM driver, but the
> > > result DT should be more or less the same as smd845-mtp.
>
> Can you point me to some upstream DTS file (not dtsi) that you think
> will definitely have this issue (ideally you've actually hit it), and
> the specific DT nodes in question? That'd make it much easier for me
> to jump in and look as I'm not up to speed on all the MSM boards.

I've been under the load thanks to the NY holidays.
I have verified that ach/arm64/boot/dts/qcom/sdm845-mtp.dts exhibits
the same behaviour. dispcc being deferred forever because of the
dependencies on dsi phy.

>
> > So, is there a way we can assist you in debugging these issues? I
> > still can not get dual DSI setup to work without this patch (or
> > without disabling fw_devlink).
>
> Sorry I've been a bit swamped. I'll try to take a look at this soon.
>
> Another thing you could do is look at the existing code that detects
> these cycles and fixes them up and figure out why it's not noticing a
> cycle for your use case or not fixing the cycle correctly. You'll want
> to look at calls to fw_devlink_relax_cycle() inside
> fw_devlink_create_devlink().

Could you please post patches that can assist you in debugging this?

>
> -Saravana
>
> >
> > >
> > > >
> > > > -Saravana
> > > >
> > > > >
> > > > > -Saravana
> > > > >
> > > > > > Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> > > > > > Cc: Stephen Boyd <swboyd@chromium.org>
> > > > > > Cc: Saravana Kannan <saravanak@google.com>
> > > > > > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > > > > > ---
> > > > > >  drivers/of/property.c | 16 +++++++++++++++-
> > > > > >  1 file changed, 15 insertions(+), 1 deletion(-)
> > > > > >
> > > > > > diff --git a/drivers/of/property.c b/drivers/of/property.c
> > > > > > index a3483484a5a2..f7229e4030e3 100644
> > > > > > --- a/drivers/of/property.c
> > > > > > +++ b/drivers/of/property.c
> > > > > > @@ -1264,7 +1264,6 @@ struct supplier_bindings {
> > > > > >         bool node_not_dev;
> > > > > >  };
> > > > > >
> > > > > > -DEFINE_SIMPLE_PROP(clocks, "clocks", "#clock-cells")
> > > > > >  DEFINE_SIMPLE_PROP(interconnects, "interconnects", "#interconnect-cells")
> > > > > >  DEFINE_SIMPLE_PROP(iommus, "iommus", "#iommu-cells")
> > > > > >  DEFINE_SIMPLE_PROP(mboxes, "mboxes", "#mbox-cells")
> > > > > > @@ -1294,6 +1293,21 @@ DEFINE_SIMPLE_PROP(backlight, "backlight", NULL)
> > > > > >  DEFINE_SUFFIX_PROP(regulators, "-supply", NULL)
> > > > > >  DEFINE_SUFFIX_PROP(gpio, "-gpio", "#gpio-cells")
> > > > > >
> > > > > > +static struct device_node *parse_clocks(struct device_node *np,
> > > > > > +                                       const char *prop_name, int index)
> > > > > > +{
> > > > > > +       /*
> > > > > > +        * Do not create clock-related device links for clocks controllers,
> > > > > > +        * clock orphans will handle missing clock parents automatically.
> > > > > > +        */
> > > > > > +       if (!strcmp(prop_name, "clocks") &&
> > > > > > +           of_find_property(np, "#clock-cells", NULL))
> > > > > > +               return NULL;
> > > > > > +
> > > > > > +       return parse_prop_cells(np, prop_name, index, "clocks",
> > > > > > +                                      "#clock-cells");
> > > > > > +}
> > > > > > +
> > > > > >  static struct device_node *parse_gpios(struct device_node *np,
> > > > > >                                        const char *prop_name, int index)
> > > > > >  {


-- 
With best wishes
Dmitry
