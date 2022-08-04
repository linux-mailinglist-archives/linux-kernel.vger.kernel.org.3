Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFF7C589DE7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 16:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240073AbiHDOwR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 10:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240061AbiHDOwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 10:52:09 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FB5F2613B
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 07:52:07 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id gb36so11751711ejc.10
        for <linux-kernel@vger.kernel.org>; Thu, 04 Aug 2022 07:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BWfvbI/fCQxffa07xrH5Bhn2ICjeR5HGQt2MGWBy+fg=;
        b=WzTrf9lbqKCko1Ohdl7g6gYcc1+ksnl0iyuqBbyzdeXMm3kBSFu/bf5X8iSScnV1X/
         WCejVUwAXVtjzDQXUyrOUvLIH8by18+X98DTdZH2GXlm6S178Sd3QUaJ9cVbfr/eQIkb
         /jVRYJ2OR9h9YmhtibjX/Sd+txsGUFoAaKvzfZNQgkJsgDi9jJdjICHvTjCnvCAaKfrJ
         RjNZHm/zVBCnsHAmFSAFRuXmbbBBY98dNgMTdUqtO2CYfdgVC/vd0ChQK+QhuswXHD9r
         0B8rXxJiRUBj8qkgxHrQfrJOTNJh6QlMAdtAP3AD9Slv+iW0QUPtrtvSahpRRrsD8AuU
         AOQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BWfvbI/fCQxffa07xrH5Bhn2ICjeR5HGQt2MGWBy+fg=;
        b=DBiBWEmiPawWd696bVJCETg/oUi+WQlDHAKtTGDNUwwD/Ju0233Dpz+IpAhkBhvIJS
         FmnKIxXfHDDMZw/Q8CX5DYYNPtR2duCgnOd6phhKm4djfPXY51q47QkZbk+N1+HOf2Qv
         9A092Bc5PCI2WPY3K4UmmTK7VhOZ/JGhcW20rQnASOypdbGdqWpSFJBeXlRzRJ7fiXZH
         yzyD8F+/wTFjcNg2mY09+DQ8QK701Dadwlh23yWGx++L7ClyD1bLYLgn+JrEKAEPymIf
         FdqAZ61FlaqFV2itk3MVnbv0G3EZDQaHCSk4G8lM+TTgRE16UC60RbSX//oBbcDQEusJ
         Khvg==
X-Gm-Message-State: ACgBeo0k3xwNuYOnQJ232rKURcUwPypEetLHkT4yt/muJcwf+uIw55LB
        U7/Vxg9070j0c4kv6h+lH5fiusXYexYk3k5CIvj1lw==
X-Google-Smtp-Source: AA6agR6dicmwfDEC/wLJzQTmUC5hwNo5Ku3TMvN+XWyi0mIjTYltdiGX2XrBVVs+SBHlPOLwnMoNtu9g/OACV35QSwk=
X-Received: by 2002:a17:907:c07:b0:730:b91b:2cab with SMTP id
 ga7-20020a1709070c0700b00730b91b2cabmr1762872ejc.294.1659624725670; Thu, 04
 Aug 2022 07:52:05 -0700 (PDT)
MIME-Version: 1.0
References: <CAHCN7xJy6X5733m3zwcFMuWM9oGHJEmKrs2KUNhzMzNVggRx0g@mail.gmail.com>
 <20220802080820.jyf3tfpgcj3pvbtp@pengutronix.de> <CAHCN7xL-7wGnEhY9+zDXYjigZfnfsnY_NsRf+enYt_BPsFxgnQ@mail.gmail.com>
 <CAHCN7xLpCbOY+Ma6gKJievw6aUZ5-Qs4S=zxjTgRu=Be7zvhoQ@mail.gmail.com>
 <CAHCN7xKzYcCPL0ddTENGw6xdCMNdYw-m5u4NSBHb96Vb_tByGg@mail.gmail.com>
 <20220803062024.vn7awasmifkp5xow@pengutronix.de> <CAHCN7xL3maPyX8eUiT6mKYei==6pkEvVTwX3vY+1uLTSNDGQ3Q@mail.gmail.com>
 <CAPY8ntBBz56Es=pK+KpqhyYLUET95DT_zE6gorOWx4WkCSxJAg@mail.gmail.com>
 <20220804093829.42kdelp7u4r743nv@pengutronix.de> <CAPY8ntBovVq1HVt_UneDF8OB9KBdEBv52o=4BCTmf9VpiODxVg@mail.gmail.com>
 <20220804125152.idyzetjqkjzgbbm2@pengutronix.de>
In-Reply-To: <20220804125152.idyzetjqkjzgbbm2@pengutronix.de>
From:   Dave Stevenson <dave.stevenson@raspberrypi.com>
Date:   Thu, 4 Aug 2022 15:51:49 +0100
Message-ID: <CAPY8ntAatYvbf5ehfsj4qcSDC=sODeN1Cj0vDjn6p0M=k320NA@mail.gmail.com>
Subject: Re: imx8mm lcdif->dsi->adv7535 no video, no errors
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     Adam Ford <aford173@gmail.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Marek Vasut <marex@denx.de>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jagan Teki <jagan@amarulasolutions.com>, robert.chiras@nxp.com,
        laurentiu.palcu@nxp.com, NXP Linux Team <linux-imx@nxp.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Robert Foss <robert.foss@linaro.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Aug 2022 at 13:51, Marco Felsch <m.felsch@pengutronix.de> wrote:
>
> Hi Dave,
>
> On 22-08-04, Dave Stevenson wrote:
> > Hi Marco
> >
> > On Thu, 4 Aug 2022 at 10:38, Marco Felsch <m.felsch@pengutronix.de> wrote:
> > >
> > > Hi Dave, Adam,
> > >
> > > On 22-08-03, Dave Stevenson wrote:
> > > > Hi Adam
> > > >
> > > > On Wed, 3 Aug 2022 at 12:03, Adam Ford <aford173@gmail.com> wrote:
> > >
> > > ...
> > >
> > > > > > Did managed to get access to the ADV7535 programming guide? This is the
> > > > > > black box here. Let me check if I can provide you a link with our repo
> > > > > > so you can test our current DSIM state if you want.
> > > > >
> > > > > I do have access to the programming guide, but it's under NDA, but
> > > > > I'll try to answer questions if I can.
> > > >
> > > > Not meaning to butt in, but I have datasheets for ADV7533 and 7535
> > > > from previously looking at these chips.
> > >
> > > Thanks for stepping into :)
> > >
> > > > Mine fairly plainly states:
> > > > "The DSI receiver input supports DSI video mode operation only, and
> > > > specifically, only supports nonburst mode with sync pulses".
> > >
> > > I've read this also, and we are working in nonburst mode with sync
> > > pulses. I have no access to an MIPI-DSI analyzer therefore I can't
> > > verify it.
> > >
> > > > Non-burst mode meaning that the DSI pixel rate MUST be the same as the
> > > > HDMI pixel rate.
> > >
> > > On DSI side you don't have a pixel-clock instead there is bit-clock.
> >
> > You have an effective pixel clock, with a fixed conversion for the
> > configuration.
> >
> > DSI bit-clock * number of lanes / bits_per_pixel = pixel rate.
> > 891Mbit/s * 4 lanes / 24bpp = 148.5 Mpixels/s
>
> Okay, I just checked the bandwidth which must equal.
>
> > As noted elsewhere, the DSI is DDR, so the clock lane itself is only
> > running at 891 / 2 = 445.5MHz.
> >
> > > > Section 6.1.1 "DSI Input Modes" of adv7533_hardware_user_s_guide is
> > > > even more explicit about the requirement of DSI timing matching
> > >
> > > Is it possible to share the key points of the requirements?
> >
> > "Specifically the ADV7533 supports the Non-Burst Mode with syncs. This
> > mode requires real time data generation as a pulse packet received
> > becomes a pulse generated. Therefore this mode requires a continuous
> > stream of data with correct video timing to avoid any visual
> > artifacts."
> >
> > LP mode is supported on data lanes. Clock lane must remain in HS mode.
> >
> > "... the goal is to accurately convey DPI-type timing over DSI. This
> > includes matching DPI pixel-transmission rates, and widths of timing
> > events."
>
> Thanks for sharing.
>
> > > > The NXP kernel switching down to an hs_clk of 445.5MHz would therefore
> > > > be correct for 720p operation.
> > >
> > > It should be absolute no difference if you work on 891MHz with 2 lanes
> > > or on 445.5 MHz with 4 lanes. What must be ensured is that you need the
> > > minimum required bandwidth which is roughly: 1280*720*24*60 = 1.327
> > > GBps.
> >
> > Has someone changed the number of lanes in use? I'd missed that if so,
> > but I'll agree that 891MHz over 2 lanes should work for 720p60.
>
> The ADV driver is changing it autom. but this logic is somehow odd and
> there was already a approach to stop the driver doing this.

I'd missed that bit in the driver where it appears to drop to 3 lanes
for pixel clock < 80000 via a mipi_dsi_detach and _attach. Quirky, but
probably the only way it can be achieved in the current framework.

> To sync up: we have two problems:
>   1) The 720P mode with static DSI host configuration isn't working
>      without hacks.
>   2) The DSI link frequency should changed as soon as required
>      automatically. So we can provide all modes.
>
> I would concentrate on problem 1 first before moving on to the 2nd.

If you change your link frequency, it may be worth trying a lower
resolution again such as 720x480 @ 60fps on 2 lanes. (720480@60 on 4
lanes is again listed as mandatory for using the timing generator).

> > I have just noted that 720p59.94 at 24bpp on 4 lanes is listed as one
> > of the modes that is mandatory to use the timing generator (reg 0x27
> > bit 7 = 1). On 2 lanes it is not required.
> > I don't know why it's referencing the 1000/1001 pixel clock rates and
> > not the base one, as it's only a base clock change with the same
> > timing (74.176MHz clock instead of 74.25MHz).
>
> Interesting! I would like to know how the HDMI block gets fetched by the
> DSI block and how the timing-generator can influence this in good/bad
> way. So that we know what DSI settings (freq, lanes) are sufficient.
>
> > > > If you do program the manual DSI divider register to allow a DSI pixel
> > > > rate of 148.5MHz vs HDMI pixel rate of 74.25MHz, you'd be relying on
> > >
> > > There is no such DSI pixel rate to be precise, we only have a DSI bit
> > > clock/rate.
> > >
> > > > the ADV753x having at least a half-line FIFO between DSI rx and HDMI
> > > > tx to compensate for the differing data rates. I see no reference to
> > > > such, and I'd be surprised if it was more than a half dozen pixels to
> > > > compensate for the jitter in the cases where the internal timing
> > > > generator is mandatory due to fractional bytes.
> > >
> > > This is interesting and would proofs our assumption that the device
> > > don't have a FIFO :)
> > >
> > > Our assumptions (we don't have the datasheet/programming manual):
> > >   - HDMI part is fetching 3 bytes per HDMI pixclk
> > >   - Ratio between dsi-clk and hdmi-pixelclk must be 3 so the DSI and
> > >     HDMI are in sync. So from bandwidth pov there are no differences
> > >     between:
> > >       - HDMI: 74.25 MHz * 24 Bit  = 1782.0 MBit/s
> > >       - DSI:    891 MHz * 2 lanes = 1782.0 MBit/s (dsi-clock: 445.5 )
> > >       - DSI:  445.5 MHz * 4 lanes = 1782.0 MBit/s (dsi-clock: 222.75)
> > >
> > >     But the ratio is different and therefore the faster clocking option
> > >     let something 'overflow'.
> >
> > I'll agree that all looks consistent.
> >
> > > Anyway, but all this means that Adam should configure the
> > > burst-clock-rate to 445.5 and set the lanes to 4. But this doesn't work
> > > either and now we are back on my initial statement -> the driver needs
> > > some attention.
> >
> > Things always need attention :-)
>
> ^^
>
> > I suspect that it's the use of the timing generator that is the issue.
> > The programming guide does recommend using it for all modes, so that
> > would be a sensible first step.
>
> But I tested it without the timing-generator too. Can you or Adam verify
> the timing-generator diable logic?

Sorry, running without the use of the timing generator is the issue.
It is mandatory in some modes, but supported in all modes. Always
using it should therefore avoid not using it in one of the mandatory
modes (the list looks a little arbitrary).

> > I will say that we had a number of issues getting this chip to do
> > anything, and it generally seemed happier on 2 or 3 lanes instead of
> > 4. Suffice to say that we abandoned trying to use it, despite some
> > assistance from ADI.
>
> Even more interessting, what is your alternative to this chip?

BCM2711 which supported dual HDMI natively.
Our investigation of ADV7535 was when trying to build what became
Pi400 using BCM2710/BCM2837 (only has a single HDMI output). Whilst I
do have the prototype, the ADV was wired up weirdly with I2C so I
never really got it running with Linux.

  Dave
