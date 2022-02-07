Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68BAC4AB6D2
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 09:46:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243268AbiBGIoT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 03:44:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243871AbiBGIjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 03:39:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07ADDC043181;
        Mon,  7 Feb 2022 00:39:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9767E61139;
        Mon,  7 Feb 2022 08:39:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1805C004E1;
        Mon,  7 Feb 2022 08:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1644223154;
        bh=oFz9BaL9e3pbQqoR3n99qyo4Z+yc7ZCLihiceMXEhio=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TRJSbI5hpLHhuYWzgyELmIHnfhZBdVIt2QJLm49vE5pRrMapIr1UjrzVDKOQG/JJ7
         tBVe2TML5DFaRDzxEAm8YLAT+gMz4/3kWEF8X/KWcKvd+bKNsuLg3T3/DIAiJQm11f
         fA8HTUWyOQ2lYR0oA9Xai/C9THo6UFJGa+qDVVoo=
Date:   Mon, 7 Feb 2022 09:39:11 +0100
From:   gregkh <gregkh@linuxfoundation.org>
To:     Tony Huang =?utf-8?B?6buD5oe35Y6a?= <tony.huang@sunplus.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Tony Huang <tonyhuang.sunplus@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Wells Lu =?utf-8?B?5ZGC6Iqz6aiw?= <wells.lu@sunplus.com>
Subject: Re: [PATCH v8 2/2] misc: Add iop driver for Sunplus SP7021
Message-ID: <YgDar1O/CeTM8w6J@kroah.com>
References: <cover.1644212476.git.tonyhuang.sunplus@gmail.com>
 <b96f039dc071b1d32bb52fa283fd8afc6d3349cc.1644212476.git.tonyhuang.sunplus@gmail.com>
 <CAK8P3a0zNeaeOzC_tPb1KDbyktLpjUJCdEu=C6t_QX4pB9TKnQ@mail.gmail.com>
 <b440dc1dbb044a8c81d083d52774ad6b@sphcmbx02.sunplus.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b440dc1dbb044a8c81d083d52774ad6b@sphcmbx02.sunplus.com.tw>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 07, 2022 at 08:29:40AM +0000, Tony Huang 黃懷厚 wrote:
> Dear Arnd:
> 
> > -----Original Message-----
> > From: Arnd Bergmann <arnd@arndb.de>
> > Sent: Monday, February 7, 2022 3:48 PM
> > To: Tony Huang <tonyhuang.sunplus@gmail.com>
> > Cc: Rob Herring <robh+dt@kernel.org>; DTML <devicetree@vger.kernel.org>;
> > Linux Kernel Mailing List <linux-kernel@vger.kernel.org>; Derek Kiernan
> > <derek.kiernan@xilinx.com>; Dragan Cvetic <dragan.cvetic@xilinx.com>; Arnd
> > Bergmann <arnd@arndb.de>; gregkh <gregkh@linuxfoundation.org>; Tony
> > Huang 黃懷厚 <tony.huang@sunplus.com>; Wells Lu 呂芳騰
> > <wells.lu@sunplus.com>
> > Subject: Re: [PATCH v8 2/2] misc: Add iop driver for Sunplus SP7021
> > 
> > On Mon, Feb 7, 2022 at 7:30 AM Tony Huang
> > <tonyhuang.sunplus@gmail.com> wrote:
> > >
> > > IOP(8051) embedded inside SP7021 which is used as Processor for I/O
> > > control, monitor RTC interrupt and cooperation with CPU & PMC in power
> > > management purpose.
> > > The IOP core is DQ8051, so also named IOP8051, it supports dedicated
> > > JTAG debug pins which share with SP7021.
> > > In standby mode operation, the power spec reach 400uA.
> > >
> > > Signed-off-by: Tony Huang <tonyhuang.sunplus@gmail.com>
> > > ---
> > > Changes in v8:
> > >  - Addressed comments from Greg KH.
> > >
> > >  Documentation/ABI/testing/sysfs-platform-soc@B |  28 ++
> > >  MAINTAINERS                                    |   2 +
> > >  drivers/misc/Kconfig                           |  20 ++
> > >  drivers/misc/Makefile                          |   1 +
> > >  drivers/misc/sunplus_iop.c                     | 463
> > +++++++++++++++++++++++++
> > >  5 files changed, 514 insertions(+)
> > >  create mode 100644 Documentation/ABI/testing/sysfs-platform-soc@B
> > >  create mode 100644 drivers/misc/sunplus_iop.c
> > >
> > > diff --git a/Documentation/ABI/testing/sysfs-platform-soc@B
> > > b/Documentation/ABI/testing/sysfs-platform-soc@B
> > > new file mode 100644
> > > index 0000000..d26d6f5
> > > --- /dev/null
> > > +++ b/Documentation/ABI/testing/sysfs-platform-soc@B
> > > @@ -0,0 +1,28 @@
> > > +What:
> > /sys/devices/platform/soc@B/9c000400.iop/sp_iop_mailbox
> > > +Date:          January 2022
> > > +KernelVersion: 5.16
> > > +Contact:       Tony Huang <tonyhuang.sunplus@gmail.com>
> > > +Description:
> > > +               Show IOP's mailbox0 register data.
> > > +               Format: %x
> > > +
> > > +What:
> > /sys/devices/platform/soc@B/9c000400.iop/sp_iop_mode
> > > +Date:          January 2022
> > > +KernelVersion: 5.16
> > > +Contact:       Tony Huang <tonyhuang.sunplus@gmail.com>
> > > +Description:
> > > +               Read-Write.
> > > +
> > > +               Write this file.
> > > +               Operation mode of IOP is switched to standby mode by
> > writing
> > > +               "1" to sysfs.
> > > +               Operation mode of IOP is switched to normal mode by
> > writing
> > > +               "0" to sysfs.
> > > +               Writing of other values is invalid.
> > > +
> > > +               Read this file.
> > > +               Show operation mode of IOP. "0" is normal mode. "1" is
> > standby
> > > +               mode.
> > > +               Format: %x
> > 
> > As discussed before, I would suggest leaving out all custom attributes for now,
> > and first hooking up the driver to all the in-kernel subsystems.
> > 
> > The mailbox0 register data definitely feels like an implementation detail, not
> > something that should be exposed to user space as an interface.
> > 
> > For standby mode, this would normally be handled by the power management
> > subsystem in the kernel. not a custom interface. From your earlier description,
> > I assume this interface puts the main CPU into standby mode, not the IOP,
> > right?
> > 
> > CPU standby is handled by the cpuidle subsystem, so you need a driver in
> > drivers/cpuidle/ to replace your sysfs attribute.
> > If you plan to hook up the driver to multiple subsystems, keeping a generic
> > driver file is ok, so  you'll end up with two driver modules, with one of them
> > calling into the other, using
> > EXPORT_SYMBOL() to link between them.
> > 
> 
> The purpose of adding sysfs is only for users to debug.
> So this is not needed?

If this is only for debugging, please put it in debugfs and not sysfs.

thanks,

greg k-h
