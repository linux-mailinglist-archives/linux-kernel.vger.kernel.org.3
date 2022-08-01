Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAD0B586AE5
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 14:36:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231269AbiHAMg2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 08:36:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234350AbiHAMgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 08:36:09 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 013BDBF40
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 05:15:20 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id b96so3156468edf.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Aug 2022 05:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=CVzfo9DdvisneyDXyobtn/e72u2h3ldYCnBHERW/QDg=;
        b=AzXDGT8PxyvKO2GDmJBHBhkMSyIE+rqMegJ1iSeOWOptSdPzzCOkEv4KXhKyW2pd0C
         aWS1EOIVCL6Nl5X22R7fZkmVLgSsLMagBd/pGJ2vV6udhZa8NraikeHKLRGLVNORIDUm
         qS2YsL1gUA+i4jhZy61a44KqSvY1eXMvdVgPNSEHQa8niAJK8pz9y14DwgktEKBdyp1x
         g0XCgLBvbJfX3WocJDHQu07L2SFQZeyyGXt7l9GIE06i+ykTumxKcZ6AStmkS9jj4WRP
         kUjGKyCNvtGXpVH0GanQ6LKUUv3chImjv3h5WPZSYMg24Py/tKGrepMsQ9y402jH8Rvl
         CV8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=CVzfo9DdvisneyDXyobtn/e72u2h3ldYCnBHERW/QDg=;
        b=o2dHUdi1VcdceX6zbwfg/bUh4QCHxEFTPf1tKtrJGog+sXTuoYCck2DTw0Wik4wbT4
         uXb+nVhDmRAHDQMTzivSaL1/THbgEJDTVgZHE7OIlFrl7cvwswfsFQsp9wlSTXeDI54g
         M3GUR1EiXou1XMpxtbCXJetiFiKP9SE5L/u1JSsHVEC5UouZ5q3OhJ5Mzx+ggR5/4BZm
         SkyhfHSHfP1U8LKBtjmF6bZNRdRN1abrBsJDlZXtHu4v84OwvkNSpDGgKBvMm4BCRwD/
         eD+hYZMANvGHABjix6GbBWyOjC6cZkr5CeqoTBvN8mi402gFy3KiXuK1f/E+JL9IPpv4
         op0Q==
X-Gm-Message-State: ACgBeo2ea+G2S5aZcqdPnGJwA38DYtCxjftS+4FGs0sC6PrD1Jfhg2Me
        HfOwlntTTG2ckFLwo1mjpIQV6LIaoyeLuPfea8IwdkJ7CgmNbQ==
X-Google-Smtp-Source: AA6agR526khjrrpLYsW1IgG91hYvV5KATrbamHAryv/kbSTBgGUs6YndPqhMLeLaGOlrgw5dvWh8puw+QSBPyXScJgI=
X-Received: by 2002:a50:bace:0:b0:43d:370a:e1c1 with SMTP id
 x72-20020a50bace000000b0043d370ae1c1mr12778947ede.193.1659356118908; Mon, 01
 Aug 2022 05:15:18 -0700 (PDT)
MIME-Version: 1.0
References: <CAHCN7xJ=N1vWVTBjArskJ59fyaLzmAGWfc0E=_iGizrDNR_Udw@mail.gmail.com>
 <20220801061956.3wkakhwatvqlngff@pengutronix.de> <CAHCN7xLSqyGHZwo=brm4xrj0jVi6R43wE8EJmWrYF72qDtYV0g@mail.gmail.com>
In-Reply-To: <CAHCN7xLSqyGHZwo=brm4xrj0jVi6R43wE8EJmWrYF72qDtYV0g@mail.gmail.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Mon, 1 Aug 2022 07:15:07 -0500
Message-ID: <CAHCN7xJ3deUnYMN5-NVmdknHZeFc-YOePVsGKNPb_XKqAFYLOQ@mail.gmail.com>
Subject: Re: imx8mm lcdif->dsi->adv7535 no video, no errors
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        Marek Vasut <marex@denx.de>, Stefan Agner <stefan@agner.ch>,
        Fabio Estevam <festevam@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jonas Karlman <jonas@kwiboo.se>,
        David Airlie <airlied@linux.ie>,
        Robert Foss <robert.foss@linaro.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Neil Armstrong <narmstrong@baylibre.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        Jagan Teki <jagan@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 1, 2022 at 5:54 AM Adam Ford <aford173@gmail.com> wrote:
>
> On Mon, Aug 1, 2022 at 1:20 AM Marco Felsch <m.felsch@pengutronix.de> wrote:
> >
> > Hi Adam,
> >
> > On 22-07-30, Adam Ford wrote:
> > > Hey all,
> > >
> > > I am trying to test Jagan's patch series [1] to add support for the
> > > samsung dsim bridge which is used on the imx8mm to output DSI video.
> > > The DSIM gets the video from the mxsfb, and in my case, the DSI is
> > > sent to the adv7535 for connecting to HDMI.
> >
> > So you're using the NXP recommended evalboard setup :)
>
> Yes and no.  Our design also adds audio to theADV7535 in addition to
> the video signal.
> For the 8M Plus design, we're looking to see if there are any 4K
> DSI->HDMI bridge chips available.
>
> >
> > > I have been able to get the device tree setup and I don't get any
> > > errors.  The Linux system appears to think the video is connected as
> > > determined by modetest:
> >
> > ...
> >
> > > Unfortunately, there is no video in my monitor, and my monitor states
> > > there is no signal.
> >
> > This is pretty much known, at least on our side. We also have a few more
> > patches on top of the series [1] for fixing the horizontal porches.  Our
> > current status is that we can get only one mode out of the ADV7535 which
> > is 1080P. Our assumption is that the ADV7535 needs some attentions
> > (fixes) but we can't verify that since the documentation is under NDA.
>
> I am glad I am not alone.   Thanks for the tip.  That gives me
> something to investigate.
> >
> > > If I use NXP's downstream kernel, this same hardware configuration
> > > works fine and I can see the video.
> >
> > This is because of the NXP downstream kernel porch 'calculation' and
> > workarounds. The values they are using for calculation don't take any
> > mode values into account and instead they are using a table. We don't
> > know where those values come from.
>
> I would think the VESA group would have something like these published.
> >
> > > I have checked the clk_summary, and the working and non-working
> > > conditions both have clock rates that are the same for DSI, LCDIF and
> > > related items.  The power domains connected to the lcdif and the dsi
> > > show they are active.
> > >
> > > Since I go no errors, and  Linux looks like it's happy, I was hoping
> > > someone from who better understands the interconnections between all
> > > these bridge layers might be able to offer a suggestion of something
> > > to investigate and/or try.
> > >
> > > The kernel repo I am using is from Jagan located here:
> > >
> > > [1] - https://github.com/openedev/kernel
> > >
> > > I am not convinced it's a device tree issue since I get no errors when
> > > the drivers enumerate, but I can provide my device tree updates if
> > > that helps.
> >
> > Please see above. Our debugging showed that there is a strange behaviour
> > of the ADV7535 but we don't have any documentation.
> Thanks for the comments.
>
> I'll look to see what I have for documentation.  I know my company
> signed a bunch of NDA stuff and we have an HDMI license.  I'll go
> through NXP's patches to their kernel and compare with whatever
> documentation I can find to see if I can make any improvements.

I checked our datasheet vault and I found no programming guide for the
ADV7535.  :-(
I've put in a request to see if we can get one.

I found one for the adv7511 on Analog Device's web site:
https://www.analog.com/media/en/technical-documentation/user-guides/ADV7511_Programming_Guide.pdf

They have a table of values for the different resolutions.  I am
guessing they might be the same or similar for 7535.
I'm going to look into NXP's alterations to this driver when I have more time.

adam
>
> adam
> >
> > Regards,
> >   Marco
