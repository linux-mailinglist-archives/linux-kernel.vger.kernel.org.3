Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76B33589A70
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 12:28:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239004AbiHDK2S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 06:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236209AbiHDK2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 06:28:14 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC880422FA
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 03:28:13 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1oJY59-0003UY-H3; Thu, 04 Aug 2022 12:27:59 +0200
Received: from mfe by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1oJY57-0001fs-D1; Thu, 04 Aug 2022 12:27:57 +0200
Date:   Thu, 4 Aug 2022 12:27:57 +0200
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
Message-ID: <20220804102757.pc7hljonea43ytwg@pengutronix.de>
References: <CAHCN7xJy6X5733m3zwcFMuWM9oGHJEmKrs2KUNhzMzNVggRx0g@mail.gmail.com>
 <20220802080820.jyf3tfpgcj3pvbtp@pengutronix.de>
 <CAHCN7xL-7wGnEhY9+zDXYjigZfnfsnY_NsRf+enYt_BPsFxgnQ@mail.gmail.com>
 <CAHCN7xLpCbOY+Ma6gKJievw6aUZ5-Qs4S=zxjTgRu=Be7zvhoQ@mail.gmail.com>
 <CAHCN7xKzYcCPL0ddTENGw6xdCMNdYw-m5u4NSBHb96Vb_tByGg@mail.gmail.com>
 <20220803062024.vn7awasmifkp5xow@pengutronix.de>
 <CAHCN7xL3maPyX8eUiT6mKYei==6pkEvVTwX3vY+1uLTSNDGQ3Q@mail.gmail.com>
 <CAPY8ntBBz56Es=pK+KpqhyYLUET95DT_zE6gorOWx4WkCSxJAg@mail.gmail.com>
 <CAHCN7x+HSPJpYYDgV_F91ZsPHW9Uwze8KRAqWE-XAyp5yzB9Hw@mail.gmail.com>
 <CAPY8ntCeUXRqNVyxU7ey6P99pZ3XAXcVHL65bdb3f0qbcK+rBA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPY8ntCeUXRqNVyxU7ey6P99pZ3XAXcVHL65bdb3f0qbcK+rBA@mail.gmail.com>
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

On 22-08-03, Dave Stevenson wrote:
> On Wed, 3 Aug 2022 at 13:31, Adam Ford <aford173@gmail.com> wrote:

...

> > Mine also states the DSI source needs to provide correct video timing
> > with start and stop sync packets.
> >
> > If I remember correctly, it seemed like Marek V wanted the hard coded
> > samsung,burst-clock-frequency to go away so the clock frequency could
> > be set dynamically.
> 
> I've never worked with Exynos or imx8, but my view would be that
> samsung,burst-clock-frequency should only be used if
> MIPI_DSI_MODE_VIDEO_BURST is set in the mode_flags (it isn't for
> adv7533/5).

Some notes on that. The samsung,burst-clock-frequency is the
hs-bit-clock-rate which is twice the dsi-clock-rate. This has nothing to
do with the MIPI_DSI_MODE_VIDEO_BURST.

> Without that flag the DSI link frequency should be running at the rate
> defined by the mode clock, number of lanes, bpp, etc.

IMHO the DSI link have only to guarantee the bandwidth is sufficient for
the mode.

> From the DSI spec (v 1.1 section 8.11.1):
> "Non-Burst Mode with Sync Pulses – enables the peripheral to
> accurately reconstruct original video timing, including sync pulse
> widths."
> "RGB pixel packets are time-compressed, leaving more time during a
> scan line for LP mode (saving power) or for multiplexing other
> transmissions onto the DSI link."
> How can the peripheral reconstruct the video timing off a quirky link frequency?

If the ADV couldn't reconstruct the sync signals, then we should not get
any mode working but we get the 1080P mode working.

> Unless the Exynos DSIM_CONFIG_REG register bit DSIM_BURST_MODE [1]
> reconfigures the clock setup of the DSI block, then I don't see how
> the Exynos driver can follow the DSI spec in that regard.

Why do you think that the Exynos driver isn't following the spec? We
configure the host into video mode with sync signals which is working
for the 1080P mode.

Regards,
  Marco
