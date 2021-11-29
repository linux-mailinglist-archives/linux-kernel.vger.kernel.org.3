Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FC1A4625D0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 23:40:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234326AbhK2Wns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 17:43:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234378AbhK2WnJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 17:43:09 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0517FC04C31B
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 10:56:57 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id 137so9988070pgg.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 10:56:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jXj5bTskBhM/inldINGFbo3ZZXdzWlhgorUbjoQAtas=;
        b=Lmn6AsNCssbYh6bNKKH6i6K2CJ6w+hfTb9W0XlxElmbvxxgeqsv2pQBe1P0DeAb5mf
         TrOC61nmzwEvKBzNB4gldDuPfgynMGjjTkQXy3iONEpuocFvW877d9XY1PMT2IQiPuFc
         pzGHYoTnfpnhOAtqXW8VUVIK/hU7KSQ02Xf8bhDtV6pdxtfxA5DfKvPwUKTRseI8Krbp
         J2TyYWjbQE6B50juuPKsYyQWcYTpFZi1bRP/xk9YNIggq7Rh4QUpvXwiIFICOk4ZUos8
         chEpkA85G5M44HYyJLAfwGc8NGNDcqIzRskR/j+bJIZuAWEDSy/9OnmuSCEuEy6Zw0d5
         RvOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jXj5bTskBhM/inldINGFbo3ZZXdzWlhgorUbjoQAtas=;
        b=Wf5Z7UO9drijBBVmtf89XVZKFS/DRfCjgXWEeKOGew7PhE2xrGT/nZ6O25AjYxlf8n
         IOBuGcvocmHLTZ31ieuY/HVadpKyP1iMchrC53JmZT0STkEncrGt3ucaPdjHvXQhvJZF
         DkZqdwzr3Et3j6TXMs3D73pFT9lNT2WNNiTUjB3tTutxwiyKOIoozJ/jWxvoW4AuVeEg
         Go1lhtWTZnKZcigFETWAEh+ZmLgeEbYzx+A2aMKrHnbjrcLiWr37gEuI24wjs9FgSfr9
         Vw/Bas+s+SQmR01RIUvg0El+AVP7CRy0Vh3dH0F0y1BeCUJddTMhHrowmBM4tWxDD4vj
         rzug==
X-Gm-Message-State: AOAM530k3mRSqLdHH58roCAx8KmGx6GvrGhiA9ZzgsR2pgPPxRqAcD3v
        W4/9PKWScsHcRPf/DWSoc8+2KWB05qaMk7Yg+dGoJQ==
X-Google-Smtp-Source: ABdhPJw3Pvd2m+oeVtAYOMti2klhh9NIOU3uqMbIsXqzXYUhkGcKUSybIrkrs7v4GuExpBWgJs9t1jjA0qQNoD8X1pA=
X-Received: by 2002:a63:4244:: with SMTP id p65mr36817494pga.440.1638212216494;
 Mon, 29 Nov 2021 10:56:56 -0800 (PST)
MIME-Version: 1.0
References: <20211106155427.753197-1-aford173@gmail.com> <20211106155427.753197-4-aford173@gmail.com>
 <YZrTyVJR8VN6dQAf@pendragon.ideasonboard.com> <CAHCN7xK=SNgiC2kRzX4gftjkZX4Ms8PVbL69n7+eR-EAe68xag@mail.gmail.com>
 <YZwyhWPJVlC0JmpK@pendragon.ideasonboard.com> <0c3b4cdd075919ca5cc27c56e792f510e3b76cd7.camel@ew.tq-group.com>
 <YZy4nFgkIyNXpIo3@pendragon.ideasonboard.com>
In-Reply-To: <YZy4nFgkIyNXpIo3@pendragon.ideasonboard.com>
From:   Tim Harvey <tharvey@gateworks.com>
Date:   Mon, 29 Nov 2021 10:56:45 -0800
Message-ID: <CAJ+vNU3BtKABmBNcqdcrXmmqHzkoOZ9hJwEhC11WLh4w2popyA@mail.gmail.com>
Subject: Re: (EXT) Re: [PATCH V2 4/5] arm64: dts: imx8mm-beacon: Enable OV5640 Camera
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>
Cc:     Adam Ford <aford173@gmail.com>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        Schrempf Frieder <frieder.schrempf@kontron.de>,
        linux-media <linux-media@vger.kernel.org>,
        Adam Ford-BE <aford@beaconembedded.com>,
        cstevens@beaconembedded.com,
        Jagan Teki <jagan@amarulasolutions.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        Peng Fan <peng.fan@nxp.com>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 23, 2021 at 1:47 AM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Alexander,
>
> On Tue, Nov 23, 2021 at 08:38:47AM +0100, Alexander Stein wrote:
> > Am Dienstag, dem 23.11.2021 um 02:15 +0200 schrieb Laurent Pinchart:
> > > On Sun, Nov 21, 2021 at 09:07:26PM -0600, Adam Ford wrote:
> > > > On Sun, Nov 21, 2021 at 5:18 PM Laurent Pinchart wrote:
> > > > > On Sat, Nov 06, 2021 at 10:54:26AM -0500, Adam Ford wrote:
> > > > > > The baseboard has support for a TDNext 5640 Camera which
> > > > > > uses an OV5640 connected to a 2-lane CSI2 interface.
> > > > > >
> > > > > > With the CSI and mipi_csi2 drivers pointing to an OV5640 camera, the media
> > > > > > pipeline can be configured with the following:
> > > > > >
> > > > > >     media-ctl --links "'ov5640 1-003c':0->'imx7-mipi-csis.0':0[1]"
> > > > > >
> > > > > > The camera and various nodes in the pipeline can be configured for UYVY:
> > > > > >     media-ctl -v -V "'ov5640 1-003c':0 [fmt:UYVY8_1X16/640x480 field:none]"
> > > > > >     media-ctl -v -V "'csi':0 [fmt:UYVY8_1X16/640x480 field:none]"
> > > > > >
> > > > > > Signed-off-by: Adam Ford <aford173@gmail.com>
> > > > >
> > > > > As the ov5640 is on an add-on module, would a DT overlay be better ?
> > > >
> > > > At least for the Beacon / LogicPD boards, I would prefer to avoid the
> > > > overlays.  We have an i.M6Q and an OMAP3 board with cameras enabled in
> > > > our development kit device trees.  If the cameras are not connected,
> > > > they just display a message that the cameras are not communicating and
> > > > move on.  I'm OK with that.
> > >
> > > You know the board better than I do, so I won't push against this, but I
> > > still think it may not lead to the best user experience, especially if a
> > > user wanted to connect a different sensor to the development board.
> >
> > I see the advantages of overlays compared to "stacked" .dts files. But
> > is there any general supported interface how to actually apply an overlay?
> > Documentation/devicetree/overlay-notes.rst
> > states of_overlay_fdt_apply() but there is only exactly one user in-
> > kernel (rcar-du). Is it expected that the bootloader like u-boot shall
> > apply the .dtbo files?
>
> I believe the boot loader is expected to apply overlays nowadays, yes.
> That's my personal workflow.
>

That is my understanding as well. I believe the support to apply dt
overlays within Linux (which the rpi kernel still uses) never got
merged due to race conditions so the focus was moved to bootloader.

I also have begun submitting some dt overlay files [1] [2] which I
will likely repost later this week removing the RFC.

My understanding is that these should be '.dtbo' files in the Linux
Makefile which are handled. My boards use the U-Boot bootloader and to
handle the dt overlays there you need to:
- set CONFIG_OF_LIBFDT_OVERLAY=y which gives you the 'fdt apply' command
- use 'fdt addr <addr> && fdt resize && fdt apply <loadaddr>' prior to
booting with booti
- Note that there is some support at the FIT level as well for
overlays if you need them applied to U-Boot's live dt (I don't for my
needs)

In my U-Boot environment I use scripts for loading the fdt and
applying the overlays. For example for booting kernel/dtb from network
I use:
boot_net setenv fsload tftpboot; run loadfdt && run apply_overlays &&
$fsload $kernel_addr_r venice/Image && booti $kernel_addr_r -
$fdt_addr_r
loadfdt if $fsload $fdt_addr_r $dir/$fdt_file1; then echo loaded
$fdt_file1; elif $fsload $fdt_addr_r $dir/$fdt_file2; then echo loaded
$fdt_file2; elif $fsload $fdt_addr_r $dir/$fdt_file3; then echo loaded
$fdt_file3; elif $fsload $fdt_addr_r $dir/$fdt_file4; then echo loaded
$fdt_file4; elif $fsload $fdt_addr_r $dir/$fdt_file5; then echo loaded
$fdt_file5; fi
apply_overlays fdt addr $fdt_addr_r && fdt resize && for i in
"$fdt_overlays"; do $fsload $loadaddr $dir/$i && fdt apply $loadaddr
&& echo applied $i...; done

Best regards,

Tim
[1] https://www.spinics.net/lists/arm-kernel/msg933447.html
[2] https://www.spinics.net/lists/arm-kernel/msg933638.html
