Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80BC15878BA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 10:08:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236398AbiHBIIk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 04:08:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236389AbiHBIIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 04:08:36 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 023004D80D
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 01:08:35 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1oImx1-0003jR-7i; Tue, 02 Aug 2022 10:08:27 +0200
Received: from mfe by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1oImwu-0007oM-Cu; Tue, 02 Aug 2022 10:08:20 +0200
Date:   Tue, 2 Aug 2022 10:08:20 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Adam Ford <aford173@gmail.com>
Cc:     Fabio Estevam <festevam@gmail.com>, Marek Vasut <marex@denx.de>,
        Stefan Agner <stefan@agner.ch>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jonas Karlman <jonas@kwiboo.se>,
        David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Robert Foss <robert.foss@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        Jagan Teki <jagan@amarulasolutions.com>, robert.chiras@nxp.com,
        laurentiu.palcu@nxp.com
Subject: Re: imx8mm lcdif->dsi->adv7535 no video, no errors
Message-ID: <20220802080820.jyf3tfpgcj3pvbtp@pengutronix.de>
References: <CAHCN7xJ=N1vWVTBjArskJ59fyaLzmAGWfc0E=_iGizrDNR_Udw@mail.gmail.com>
 <CAOMZO5BAheG4r1Umnd7bLhOqezsxJgE0x1c-858EcabbpPm6Pg@mail.gmail.com>
 <20220801225538.qtdb5zd66g6ipewz@pengutronix.de>
 <CAOMZO5DUTxQKbpTVOgaVC0V7hPqJG77sgmkW8p=aNpG8th-aLw@mail.gmail.com>
 <CAHCN7xL2w7a=SeXbwcNNxqb3kpRV9Bs0AbK0Nmjbj+dm0NDaVA@mail.gmail.com>
 <CAOMZO5BQWnUj4Ouq3=vhqq55zN8otO_9vPX8ht+muFM_5pg9Fg@mail.gmail.com>
 <CAHCN7xJy6X5733m3zwcFMuWM9oGHJEmKrs2KUNhzMzNVggRx0g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHCN7xJy6X5733m3zwcFMuWM9oGHJEmKrs2KUNhzMzNVggRx0g@mail.gmail.com>
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

Hi Adam, Fabio,

On 22-08-01, Adam Ford wrote:
> On Mon, Aug 1, 2022 at 8:53 PM Fabio Estevam <festevam@gmail.com> wrote:
> >
> > On Mon, Aug 1, 2022 at 10:39 PM Adam Ford <aford173@gmail.com> wrote:
> >
> > > I managed to get my HDMI output working. I had the lanes set to 2
> > > instead of 4.  Once I switched to 4-lanes, the monitor came up in
> > > 1080p.  I haven't yet been able to get other modes to work.
> >
> > Ok, good. On another thread, you mentioned that you were also trying
> > to get LVDS to work via SN65DSI83.
> >
> > Does LVDS work for you on this branch?
> 
> I haven't tried with Marek's latest suggestion.  In the other thread
> he mentioned a burst mode and setting the DSI speeds to higher
> frequencies, but the patch he had didn't look like it would apply
> cleanly, so I will need to dig into that a bit further. 

Can you provide me a link to this thread?

> Since my company doesn't really ship the LVDS displays with the kits,
> the HDMI is the default video, so I've been focusing on it.
> 
> To answer Marco's question, I was able to revert "MLK-21958-13:
> drm/bridge: adv7511: Limit supported clocks" and still get a display
> at 1080p, but all the other resolutions I tried appear to come up
> blank. 

Cool so now you have the same state as we are.

I think that the most important one is the blanking calc. Can you try to
revert "drm/bridge: adv7511: Repair bus_flags and bus_format" and check
if you can get a output still? Also something to try would be to disable
the internal timing generator by specifying
'adi,disable-timing-generator'. Also if you have an oscilloscope for
such frequencies you can check the hdmi clk-lane. I noticed that this is
sometimes wrong.

Regards,
  Marco

> I didn't try every one.  With that revert, more options come
> available, but 1440x900 and 800x600 were options I tried
> unsuccessfullyl.

> 
> adam
> 
