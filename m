Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB7FB4ACDF3
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 02:24:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242267AbiBHBX3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 20:23:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238805AbiBHBXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 20:23:12 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19BA1C05399E;
        Mon,  7 Feb 2022 17:20:45 -0800 (PST)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id EC7FD340;
        Tue,  8 Feb 2022 02:20:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1644283243;
        bh=FOx2O+Q5eRBt13yhfsJU83umtjQXEq4HwL+/c5mmv9s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gvNeqEvcQD0MAerxqXYOGua5Su1zGTwAxns59IGCARk09XiuvN6qrKe12Cdf6ZCBV
         IWRmQ6OklCYi7s0h18uZiHke1DfFxwvAs8rigQcGHp85F+TzfBWqra+9Yijc2kpTIT
         b2bwxrO+stKJJZQjKQg/PMQlRnCmY82hFfHlAjMk=
Date:   Tue, 8 Feb 2022 03:20:40 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Alexander Stein <alexander.stein@ew.tq-group.com>
Cc:     Steve Longerbeam <slongerbeam@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        Dorota Czaplejewicz <dorota.czaplejewicz@puri.sm>,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: (EXT) Re: [PATCH 0/8] imx7/imx8mm media / csi patches
Message-ID: <YgHFaJ99ny3PvM/c@pendragon.ideasonboard.com>
References: <20220204121514.2762676-1-alexander.stein@ew.tq-group.com>
 <Yf3sJuyNJWMOOo2D@pendragon.ideasonboard.com>
 <3154909.aeNJFYEL58@steina-w>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3154909.aeNJFYEL58@steina-w>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexander,

On Mon, Feb 07, 2022 at 09:59:48AM +0100, Alexander Stein wrote:
> Am Samstag, 5. Februar 2022, 04:16:54 CET schrieb Laurent Pinchart:
> > On Fri, Feb 04, 2022 at 01:15:06PM +0100, Alexander Stein wrote:
> > > Hey everyone,
> > > 
> > > this is a set of patch for imx[7] media drivers based on next-20220203.
> > > With this set I was able to capture video frames from a MIPI CSI-2 camera
> > > in my TQMa8MQML + MBA8MX hardware. The actual camera used is a Vision
> > > Components 'VC MIPI IMX327 C' camera. IMX327 is compatible to IMX290.
> > > Patch 8 shows the DT overlay I'm using, not suitable for merging.
> > 
> > You may be interested in
> > https://gitlab.com/ideasonboard/nxp/linux/-/commits/pinchartl/v5.17/sensors
> > /
> 
> Thanks for your feedback. Working on imx290 driver for proper imx327 support 
> is on my todo. For the records, there are also patches at [1].

There's also a driver for the Vision Components FPGA controller in my
branch. If you would like me to review yours, please CC me when posting
it.

> > > Please ignore the FPGA part, this is mainly for power supply and GPIO
> > > reset
> > > line. This is currently a custom driver I'm working on, but I do not want
> > > to focus on in this series.
> > > 
> > > Please note I tested this only on this imx8 platform.
> > > 
> > > First thanks to Dorota for the patchset at [1] (patches 1-4) which is
> > > necessary to capture correct images. I integrated Hans' review into it. I
> > > hope the I didn't make a mistake and the original author is kept along. I
> > > used v4 for that patchset, it is v1 again in this set. I hope this is not
> > > confusing.
> > > 
> > > Starting from patch 5 there are small fixes which allows me to configure my
> > > media device.
> > > 
> > > Device configuration:
> > > ```
> > > media-ctl -l "'imx290 2-001a':0->'csis-32e30000.mipi-csi':0 [1]"
> > > media-ctl -V "'imx290 2-001a':0 [fmt:SRGGB10_1X10/1920x1080 field:none colorspace:raw]"
> > > media-ctl -V "'csi':0 [fmt:SRGGB10_1X10/1920x1080 field:none colorspace:raw]"
> > > v4l2-ctl -d0 --set-fmt-video width=1920,height=1080,pixelformat='RG10',field=none
> > > media-ctl -p
> > > ```
> > > 
> > > The media-ctl topology is:
> > > ```
> > > # media-ctl -p
> > > Media controller API version 5.17.0
> > > 
> > > Media device information
> > > ------------------------
> > > driver          imx7-csi
> > > model           imx-media
> > > serial
> > > bus info        platform:32e20000.csi
> > > hw revision     0x0
> > > driver version  5.17.0
> > > 
> > > Device topology
> > > - entity 1: csi (2 pads, 2 links)
> > > 
> > >             type V4L2 subdev subtype Unknown flags 0
> > >             device node name /dev/v4l-subdev0
> > >         
> > >         pad0: Sink
> > >         
> > >                 [fmt:SRGGB10_1X10/1920x1080 field:none colorspace:raw
> > >                 xfer:none ycbcr:601 quantization:full-range] <-
> > >                 "csis-32e30000.mipi-csi":1 [ENABLED,IMMUTABLE]
> > >         
> > >         pad1: Source
> > >         
> > >                 [fmt:SRGGB10_1X10/1920x1080 field:none colorspace:raw
> > >                 xfer:none ycbcr:601 quantization:full-range] -> "csi
> > >                 capture":0 [ENABLED,IMMUTABLE]
> > > 
> > > - entity 4: csi capture (1 pad, 1 link)
> > > 
> > >             type Node subtype V4L flags 0
> > >             device node name /dev/video0
> > >         
> > >         pad0: Sink
> > >         
> > >                 <- "csi":1 [ENABLED,IMMUTABLE]
> > > 
> > > - entity 10: csis-32e30000.mipi-csi (2 pads, 2 links)
> > > 
> > >              type V4L2 subdev subtype Unknown flags 0
> > >              device node name /dev/v4l-subdev1
> > >         
> > >         pad0: Sink
> > >         
> > >                 [fmt:SRGGB10_1X10/1920x1080 field:none colorspace:raw
> > >                 xfer:709 ycbcr:601 quantization:lim-range] <- "imx290
> > >                 2-001a":0 [ENABLED]
> > >         
> > >         pad1: Source
> > >         
> > >                 [fmt:SRGGB10_1X10/1920x1080 field:none colorspace:raw
> > >                 xfer:709 ycbcr:601 quantization:lim-range] -> "csi":0
> > >                 [ENABLED,IMMUTABLE]
> > > 
> > > - entity 15: imx290 2-001a (1 pad, 1 link)
> > > 
> > >              type V4L2 subdev subtype Sensor flags 0
> > >              device node name /dev/v4l-subdev2
> > >         
> > >         pad0: Source
> > >         
> > >                 [fmt:SRGGB10_1X10/1920x1080 field:none colorspace:raw]
> > >                 -> "csis-32e30000.mipi-csi":0 [ENABLED]
> > > 
> > > ```
> > > 
> > > Note: MIPI CSI settle times are not calculated correctly right now and
> > > need a manual overwrite:
> > > echo 13 > /sys/kernel/debug/32e30000.mipi-csi/ths_settle
> > > echo 2 > /sys/kernel/debug/32e30000.mipi-csi/tclk_settle
> > 
> > The reference manual isn't very prolix on tclk_settle :-S That's
> > something I'd love to figure out one day.
> > 
> > For ths_settle, is the issue on the CSIS driver side, or the sensor
> > driver side ?
> 
> I can't answer that yet, but during my work on a fslc linux-5.10 I noticed 
> that the link frequency and/or some other clock was wrong, so the calculated 
> value didn't match.
> Anyway I get the impression that the final values might also be affected by 
> the actual hardware. But I do not know any details regarding this.
> 
> > > I ignored the settings for xfer, ycbcr and quantization for now. I do
> > > neither know how they will affect me nor what it should be.
> > > Also I did not focus on v4l2-compliance tool, this is a further task as
> > > well. IMHO imx7-mipi-csis.c should also create an immutable link to the
> > > camera sensor.
> > 
> > That makes sense, but note that, while CSI-2 is meant to be a
> > point-to-point bus, there are boards designed with multiple sensors
> > connected to the same CSI-2 RX without any hardware multiplexer. They
> > keep one of the two sensors in reset at all times and are lucky that the
> > signal reflections don't mess things up.
> 
> Still, even if only one device is actually powered, it is a immutable link 
> from v4l2 perspective. You don't switch the sensors on the fly, or do you 
> really do that? In the end immutable links are only a minor issue (to me).

The sensor couldn't be switched while streaming, but you could control
which sensor to use before starting streaming by enabling and disabling
links. An immutable link can never be disabled.

We could create the link as immutable if only once sensor is connected,
which is the usual case. However, I wonder if it wouldn't make things
more difficult for userspace that would need to avoid trying to disable
the link in that case.

> [1] https://github.com/raspberrypi/linux/commits/rpi-5.10.y/drivers/media/i2c/
> imx290.c

-- 
Regards,

Laurent Pinchart
