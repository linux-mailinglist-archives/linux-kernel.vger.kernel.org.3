Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2888057F071
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 18:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236429AbiGWQg1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 12:36:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233151AbiGWQgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 12:36:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C3EB13E3E;
        Sat, 23 Jul 2022 09:36:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C3B15B80D0F;
        Sat, 23 Jul 2022 16:36:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68EACC341C0;
        Sat, 23 Jul 2022 16:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658594180;
        bh=6XE73k7c7WN3uNXJTeqkHt28iWk/7jcyQroIQuT2Iu0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GokwfrX4KlLAcreXhGZM0nPPcuqMEnNKJk0Pa1Ju5JECxL51lXnw2MPVN0Z3xhUM7
         6RMx6ub7dvU//l/k2MQ4SzKCG15c6AakHHhHtU+kg0+EZOXotMY5GYmyB+msW0NSEx
         PI/FQ6tL1h/1UFbNiD+c/gLDAEDBjU91Q/svDy26nYBzSgR2ukWq5h42N6MuYSoomq
         sfBrTGz2lztUqgh1nolgBZGP3Cg7Jqi+2wdLWu7V2aKrz3zzHGfie2MBFH3hMM9DyX
         xVhZVmk7Bu/GFbQh4sdxrDhLtmGmygdXDFX3L/w3Lh5xV1Uxx23x76/JGI1dMCbs6y
         g4bvDv20JPIrA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oFI77-0002RK-Vc; Sat, 23 Jul 2022 18:36:26 +0200
Date:   Sat, 23 Jul 2022 18:36:25 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Reinhard Speyerer <rspmn@arcor.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        sdlyyxy <sdlyyxy@bupt.edu.cn>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: usb-serial-simple: add new device id for OPPO R11
Message-ID: <YtwjiWG5ZFBvCZ1M@hovoldconsulting.com>
References: <20220715142444.4173681-1-gregkh@linuxfoundation.org>
 <119D7B0F-7809-464A-AFF1-DF72FFF9E63F@bupt.edu.cn>
 <YtKrbucYNulPEKUp@arcor.de>
 <YtRtswctFMLxeglu@kroah.com>
 <YtXG3EVrRKAG7WVx@arcor.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YtXG3EVrRKAG7WVx@arcor.de>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 18, 2022 at 10:47:24PM +0200, Reinhard Speyerer wrote:
> Hi Greg,
> 
> On Sun, Jul 17, 2022 at 10:14:43PM +0200, Greg Kroah-Hartman wrote:
> > On Sat, Jul 16, 2022 at 02:13:34PM +0200, Reinhard Speyerer wrote:
> > > On Fri, Jul 15, 2022 at 10:59:13PM +0800, sdlyyxy wrote:
> > > > 
> > > > > On Jul 15, 2022, at 22:24, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> > > > > 
> > > > > The Oppo R11 diagnostic USB connection needs to be bound to the
> > > > > usb-serial-simple driver as it just wants to use a dumb pipe to
> > > > > communicate to the host.
> > > > > 
> > > > > usb-devices output:
> > > > > T: Bus=03 Lev=01 Prnt=01 Port=01 Cnt=01 Dev#= 10 Spd=480 MxCh= 0
> > > > > D: Ver= 2.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs= 1
> > > > > P: Vendor=22d9 ProdID=276c Rev=04.04
> > > > > S: Manufacturer=OPPO
> > > > > S: Product=SDM660-MTP _SN:09C6BCA7
> > > > > S: SerialNumber=beb2c403
> > > > > C: #Ifs= 2 Cfg#= 1 Atr=80 MxPwr=500mA
> > > > > I: If#=0x0 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=30
> > > > > 
> > > > > Reported-by: Yan Xinyu <sdlyyxy@bupt.edu.cn>
> > > > > Cc: Johan Hovold <johan@kernel.org>
> > > > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > > ---
> > > > > drivers/usb/serial/usb-serial-simple.c | 4 +++-
> > > > > 1 file changed, 3 insertions(+), 1 deletion(-)
> > > > > 
> > > > > diff --git a/drivers/usb/serial/usb-serial-simple.c b/drivers/usb/serial/usb-serial-simple.c
> > > > > index 4c6747889a19..eb832b94aa3a 100644
> > > > > --- a/drivers/usb/serial/usb-serial-simple.c
> > > > > +++ b/drivers/usb/serial/usb-serial-simple.c
> > > > > @@ -60,7 +60,9 @@ DEVICE(flashloader, FLASHLOADER_IDS);
> > > > > 	{ USB_VENDOR_AND_INTERFACE_INFO(0x18d1,			\
> > > > > 					USB_CLASS_VENDOR_SPEC,	\
> > > > > 					0x50,			\
> > > > > -					0x01) }
> > > > > +					0x01) },		\
> > > > > +	{ USB_DEVICE_AND_INTERFACE_INFO(0x22d9, 0x276c,		\
> > > > > +					0xff, 0xff, 0x30) }
> > > > > DEVICE(google, GOOGLE_IDS);
> > > > > 
> > > > > /* Libtransistor USB console */
> > > > > -- 
> > > > > 2.37.1
> > > > Tested-by: Yan Xinyu <sdlyyxy@bupt.edu.cn>
> > > 
> > > While this may work sufficiently well for real low-volume diag traffic I'd
> > > expect a significant percentage of diag messages to be lost in practice
> > > with the usb-serial-simple driver.
> > > 
> > > According to the usb-devices output this looks like the Qualcomm USB gadget
> > > in the DIAG + ADB composition to me.
> > > 
> > > Since the option driver uses the usb-wwan framework my suggestion would be
> > > for the original patch to be applied instead similar to what has been done
> > > e.g. for the Quectel RM500Q diag port.
> > 
> > But this is not using the option chip, nor using the option flow control
> > protocol at all, so it should not be showing up as a device controlled
> > by the option driver.  It just will not work properly, the simple driver
> > should be doing the exact same thing here.
> > 
> 
> you seem to have the misconception that devices handled by the option driver
> would use a USB to serial converter chip from Option similar to e.g. the
> ftdi_sio driver which is not the case.
> 
> Quoting from option.c:
>   ===
>   This driver exists because the "normal" serial driver doesn't work too well
>   with GSM modems. Issues:
>   - data loss -- one single Receive URB is not nearly enough

This was written on 2006 and the single-receive URB statement hasn't
been true for the last decade or so.

>   - nonstandard flow (Option devices) control
>   - controlling the baud rate doesn't make sense
> 
>   This driver is named "option" because the most common device it's
>   used for is a PC-Card (with an internal OHCI-USB interface, behind
>   which the GSM interface sits), made by Option Inc.
>   ===
> 
> The GSM/UMTS interface in the Option card actually contains a Qualcomm chip
> which exports its serial ports via USB. The data loss mentioned by Matthias
> above also applies to the diag port.

Not necessarily true anymore even if the buffer sizes may need to be
increased somewhat to support dumping modem traffic.

And note that qcaux has always used the generic implementation (also
when it only used a single URB).
 
> As can be seen from the sendsetup code in the qcserial driver the
> "nonstandard flow (Option devices) control" mentioned above is actually
> a Qualcomm "feature" required for some of their USB serial implementations
> on tne device to work properly.

It's actually only used by some Sierra modems managed by that driver,
but yeah, those should be Qualcomm based.

> In case you suspect potential problems with the sendsetup code and the OPPO
> R11 diag port Yan's option.c patch could be extended like this:
> 	{ USB_DEVICE_AND_INTERFACE_INFO(OPPO_VENDOR_ID, OPPO_PRODUCT_R11, 0xff, 0xff, 0x30),
> 	  .driver_info = NCTRL(0) },
> 
> With a few more lines of code you could also add a new layout to the qcserial
> driver if you prefer for the OPPO R11 to be handled by it for some reason.

I think we decided not to use qcserial unless it matches one of the
fixed GOBI port layouts.

> Either one would be fine with me.
> 
> Please don't give the OPPO R11 diag port on Linux a bad name by letting
> the usb-serial-simple driver handle it.

So while I'm not sure bandwidth is really a problem, I still tend to
agree that we should add this one to the option driver for now as that
is how we handle (non-GOBI) Qualcomm modems and their QCDM ports.

Johan
