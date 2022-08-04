Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 544B25899F9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 11:38:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239139AbiHDJiu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 05:38:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbiHDJis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 05:38:48 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 446574199C
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 02:38:47 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1oJXJL-0005oZ-BR; Thu, 04 Aug 2022 11:38:35 +0200
Received: from mfe by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1oJXJF-0007CX-Os; Thu, 04 Aug 2022 11:38:29 +0200
Date:   Thu, 4 Aug 2022 11:38:29 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Dave Stevenson <dave.stevenson@raspberrypi.com>
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
Subject: Re: imx8mm lcdif->dsi->adv7535 no video, no errors
Message-ID: <20220804093829.42kdelp7u4r743nv@pengutronix.de>
References: <CAHCN7xL2w7a=SeXbwcNNxqb3kpRV9Bs0AbK0Nmjbj+dm0NDaVA@mail.gmail.com>
 <CAOMZO5BQWnUj4Ouq3=vhqq55zN8otO_9vPX8ht+muFM_5pg9Fg@mail.gmail.com>
 <CAHCN7xJy6X5733m3zwcFMuWM9oGHJEmKrs2KUNhzMzNVggRx0g@mail.gmail.com>
 <20220802080820.jyf3tfpgcj3pvbtp@pengutronix.de>
 <CAHCN7xL-7wGnEhY9+zDXYjigZfnfsnY_NsRf+enYt_BPsFxgnQ@mail.gmail.com>
 <CAHCN7xLpCbOY+Ma6gKJievw6aUZ5-Qs4S=zxjTgRu=Be7zvhoQ@mail.gmail.com>
 <CAHCN7xKzYcCPL0ddTENGw6xdCMNdYw-m5u4NSBHb96Vb_tByGg@mail.gmail.com>
 <20220803062024.vn7awasmifkp5xow@pengutronix.de>
 <CAHCN7xL3maPyX8eUiT6mKYei==6pkEvVTwX3vY+1uLTSNDGQ3Q@mail.gmail.com>
 <CAPY8ntBBz56Es=pK+KpqhyYLUET95DT_zE6gorOWx4WkCSxJAg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPY8ntBBz56Es=pK+KpqhyYLUET95DT_zE6gorOWx4WkCSxJAg@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave, Adam,

On 22-08-03, Dave Stevenson wrote:
> Hi Adam
> 
> On Wed, 3 Aug 2022 at 12:03, Adam Ford <aford173@gmail.com> wrote:

...

> > > Did managed to get access to the ADV7535 programming guide? This is the
> > > black box here. Let me check if I can provide you a link with our repo
> > > so you can test our current DSIM state if you want.
> >
> > I do have access to the programming guide, but it's under NDA, but
> > I'll try to answer questions if I can.
> 
> Not meaning to butt in, but I have datasheets for ADV7533 and 7535
> from previously looking at these chips.

Thanks for stepping into :)

> Mine fairly plainly states:
> "The DSI receiver input supports DSI video mode operation only, and
> specifically, only supports nonburst mode with sync pulses".

I've read this also, and we are working in nonburst mode with sync
pulses. I have no access to an MIPI-DSI analyzer therefore I can't
verify it.

> Non-burst mode meaning that the DSI pixel rate MUST be the same as the
> HDMI pixel rate.

On DSI side you don't have a pixel-clock instead there is bit-clock.

> Section 6.1.1 "DSI Input Modes" of adv7533_hardware_user_s_guide is
> even more explicit about the requirement of DSI timing matching

Is it possible to share the key points of the requirements?

> The NXP kernel switching down to an hs_clk of 445.5MHz would therefore
> be correct for 720p operation.

It should be absolute no difference if you work on 891MHz with 2 lanes
or on 445.5 MHz with 4 lanes. What must be ensured is that you need the
minimum required bandwidth which is roughly: 1280*720*24*60 = 1.327
GBps.

> If you do program the manual DSI divider register to allow a DSI pixel
> rate of 148.5MHz vs HDMI pixel rate of 74.25MHz, you'd be relying on

There is no such DSI pixel rate to be precise, we only have a DSI bit
clock/rate.

> the ADV753x having at least a half-line FIFO between DSI rx and HDMI
> tx to compensate for the differing data rates. I see no reference to
> such, and I'd be surprised if it was more than a half dozen pixels to
> compensate for the jitter in the cases where the internal timing
> generator is mandatory due to fractional bytes.

This is interesting and would proofs our assumption that the device
don't have a FIFO :)

Our assumptions (we don't have the datasheet/programming manual):
  - HDMI part is fetching 3 bytes per HDMI pixclk
  - Ratio between dsi-clk and hdmi-pixelclk must be 3 so the DSI and
    HDMI are in sync. So from bandwidth pov there are no differences
    between:
      - HDMI: 74.25 MHz * 24 Bit  = 1782.0 MBit/s
      - DSI:    891 MHz * 2 lanes = 1782.0 MBit/s (dsi-clock: 445.5 )
      - DSI:  445.5 MHz * 4 lanes = 1782.0 MBit/s (dsi-clock: 222.75)

    But the ratio is different and therefore the faster clocking option
    let something 'overflow'.

Anyway, but all this means that Adam should configure the
burst-clock-rate to 445.5 and set the lanes to 4. But this doesn't work
either and now we are back on my initial statement -> the driver needs
some attention.

Regards,
  Marco
