Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49B425867DB
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 12:54:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231295AbiHAKyU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 06:54:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231298AbiHAKyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 06:54:16 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E86892D1D7
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 03:54:14 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id ss3so19550931ejc.11
        for <linux-kernel@vger.kernel.org>; Mon, 01 Aug 2022 03:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=Wbcc09xUaIf01C1E4HXm0dIDLsAKCmlGM3/QPcRFjyo=;
        b=PsE/4CIWpVzsAX4KrNjGaY5eP7PjaJ+eVshBNmEg6EF1jLsSaHI3fOjqlHEPtclF18
         QuPts7lzxQGe7dh8OrgVKcm8yrJ6DrsAJ6kJX5kq0VaNymOK2Zo1pmAr4OMJux/flYtG
         PT3mIEKgnF7Kpkq1tbUmgSEwTLmCezPPvfBnnD8XpNrVP8qkV2WMp1e3qQl9QhPkmr9r
         aENjATsYRUl7HGCgJvr0ncXWIjicBieSVXeHXDoWWQjVeT1MbrdSXfYthA4rvEdtAKNE
         6nHNpcq1YxiUwzfDSSv/wtZj+vt1fc1HoCTIYiiDThgSsS1gEqAszxAGMZoCHnZXrmJP
         OD8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=Wbcc09xUaIf01C1E4HXm0dIDLsAKCmlGM3/QPcRFjyo=;
        b=jHmXHcAKPPcC+tGWj+QRASSL6xLICjKN1LTHVnIUxyQ2Swm1yxflOtTwiuT03z5exq
         91JPLafuUGPENjGSVsvT83LjAWhpGyyt8pAnqPdSsgATriZb9LacdV4cDqygsA1OTfLZ
         TYLd4KXEcHZyqse7XLiVbZe0LbAH7thYujYNcuEXht3B8zhba+WzbTrNtSahflFH4KCJ
         6ynaBzy1RgzVal/iZ66Cm/IIKlAZ3WPB23/2Ep8HZQzifTtpCq+p0tBbRs2jJUbXJOeG
         0ZvPcuCsA1uhqnLi11RKPA8Owmn1Au099HHYXfFqZiJIumrcaYfMH5POOIkkD4s+dA0u
         /E7w==
X-Gm-Message-State: AJIora95rECp8kJL2MYFJDYfnd0IbHm7Z5T3RvVxoeLNGpmsFrZ51jPN
        K6olnkkdG6WNMsXZQxP3+YEpx/S1iIQk7Boqg/A=
X-Google-Smtp-Source: AGRyM1sCUcD7NqeJM5MgA4r77ZTTgYdj2zBCrytU/4cA3J1S85UcqaGpqyd5zZybVr5SM1fkJ4KPykuQvSDHU0einh0=
X-Received: by 2002:a17:907:6e12:b0:72e:6774:cb80 with SMTP id
 sd18-20020a1709076e1200b0072e6774cb80mr11686350ejc.504.1659351253340; Mon, 01
 Aug 2022 03:54:13 -0700 (PDT)
MIME-Version: 1.0
References: <CAHCN7xJ=N1vWVTBjArskJ59fyaLzmAGWfc0E=_iGizrDNR_Udw@mail.gmail.com>
 <20220801061956.3wkakhwatvqlngff@pengutronix.de>
In-Reply-To: <20220801061956.3wkakhwatvqlngff@pengutronix.de>
From:   Adam Ford <aford173@gmail.com>
Date:   Mon, 1 Aug 2022 05:54:02 -0500
Message-ID: <CAHCN7xLSqyGHZwo=brm4xrj0jVi6R43wE8EJmWrYF72qDtYV0g@mail.gmail.com>
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

On Mon, Aug 1, 2022 at 1:20 AM Marco Felsch <m.felsch@pengutronix.de> wrote:
>
> Hi Adam,
>
> On 22-07-30, Adam Ford wrote:
> > Hey all,
> >
> > I am trying to test Jagan's patch series [1] to add support for the
> > samsung dsim bridge which is used on the imx8mm to output DSI video.
> > The DSIM gets the video from the mxsfb, and in my case, the DSI is
> > sent to the adv7535 for connecting to HDMI.
>
> So you're using the NXP recommended evalboard setup :)

Yes and no.  Our design also adds audio to theADV7535 in addition to
the video signal.
For the 8M Plus design, we're looking to see if there are any 4K
DSI->HDMI bridge chips available.

>
> > I have been able to get the device tree setup and I don't get any
> > errors.  The Linux system appears to think the video is connected as
> > determined by modetest:
>
> ...
>
> > Unfortunately, there is no video in my monitor, and my monitor states
> > there is no signal.
>
> This is pretty much known, at least on our side. We also have a few more
> patches on top of the series [1] for fixing the horizontal porches.  Our
> current status is that we can get only one mode out of the ADV7535 which
> is 1080P. Our assumption is that the ADV7535 needs some attentions
> (fixes) but we can't verify that since the documentation is under NDA.

I am glad I am not alone.   Thanks for the tip.  That gives me
something to investigate.
>
> > If I use NXP's downstream kernel, this same hardware configuration
> > works fine and I can see the video.
>
> This is because of the NXP downstream kernel porch 'calculation' and
> workarounds. The values they are using for calculation don't take any
> mode values into account and instead they are using a table. We don't
> know where those values come from.

I would think the VESA group would have something like these published.
>
> > I have checked the clk_summary, and the working and non-working
> > conditions both have clock rates that are the same for DSI, LCDIF and
> > related items.  The power domains connected to the lcdif and the dsi
> > show they are active.
> >
> > Since I go no errors, and  Linux looks like it's happy, I was hoping
> > someone from who better understands the interconnections between all
> > these bridge layers might be able to offer a suggestion of something
> > to investigate and/or try.
> >
> > The kernel repo I am using is from Jagan located here:
> >
> > [1] - https://github.com/openedev/kernel
> >
> > I am not convinced it's a device tree issue since I get no errors when
> > the drivers enumerate, but I can provide my device tree updates if
> > that helps.
>
> Please see above. Our debugging showed that there is a strange behaviour
> of the ADV7535 but we don't have any documentation.
Thanks for the comments.

I'll look to see what I have for documentation.  I know my company
signed a bunch of NDA stuff and we have an HDMI license.  I'll go
through NXP's patches to their kernel and compare with whatever
documentation I can find to see if I can make any improvements.

adam
>
> Regards,
>   Marco
