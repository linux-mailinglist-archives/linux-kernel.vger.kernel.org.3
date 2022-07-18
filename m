Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0243F578C08
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 22:48:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231274AbiGRUsC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 16:48:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbiGRUsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 16:48:00 -0400
Received: from mr5.vodafonemail.de (mr5.vodafonemail.de [145.253.228.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFC497669;
        Mon, 18 Jul 2022 13:47:58 -0700 (PDT)
Received: from smtp.vodafone.de (unknown [10.0.0.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by mr5.vodafonemail.de (Postfix) with ESMTPS id 4LmvDX47m0z1yGF;
        Mon, 18 Jul 2022 20:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arcor.de;
        s=vfde-mb-mr2-21dec; t=1658177276;
        bh=SNrPLMGCpjQRbb6blJwXA2sn6QML20WYwo9AlatwEoM=;
        h=Date:From:To:Subject:Message-ID:References:Content-Type:
         In-Reply-To:From;
        b=UK60cWTiNUJ82bDP0Xzs0CxFOlU+yVfPGEZqC/RTGqrqJTYc/MJniyEJ41LhQ4CD4
         cJ8t9wYHC8vH8LrGHEpejX8BNKUpBrJpsGu3iGPWBIQOqhVsENDdAfbcGGofF+fyIi
         fNdV6pYc2sQl6UTwCmHWwQNq28t4EGPDYLd9rnpI=
Received: from arcor.de (p3ee2cf42.dip0.t-ipconnect.de [62.226.207.66])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp.vodafone.de (Postfix) with ESMTPSA id 4LmvDG6MBmz9sNt;
        Mon, 18 Jul 2022 20:47:39 +0000 (UTC)
Date:   Mon, 18 Jul 2022 22:47:24 +0200
From:   Reinhard Speyerer <rspmn@arcor.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     sdlyyxy <sdlyyxy@bupt.edu.cn>, johan@kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: usb-serial-simple: add new device id for OPPO R11
Message-ID: <YtXG3EVrRKAG7WVx@arcor.de>
References: <20220715142444.4173681-1-gregkh@linuxfoundation.org>
 <119D7B0F-7809-464A-AFF1-DF72FFF9E63F@bupt.edu.cn>
 <YtKrbucYNulPEKUp@arcor.de>
 <YtRtswctFMLxeglu@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YtRtswctFMLxeglu@kroah.com>
X-purgate-type: clean
X-purgate: clean
X-purgate-size: 4575
X-purgate-ID: 155817::1658177275-BA9E322F-1671A4FF/0/0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Sun, Jul 17, 2022 at 10:14:43PM +0200, Greg Kroah-Hartman wrote:
> On Sat, Jul 16, 2022 at 02:13:34PM +0200, Reinhard Speyerer wrote:
> > On Fri, Jul 15, 2022 at 10:59:13PM +0800, sdlyyxy wrote:
> > > 
> > > > On Jul 15, 2022, at 22:24, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> > > > 
> > > > The Oppo R11 diagnostic USB connection needs to be bound to the
> > > > usb-serial-simple driver as it just wants to use a dumb pipe to
> > > > communicate to the host.
> > > > 
> > > > usb-devices output:
> > > > T: Bus=03 Lev=01 Prnt=01 Port=01 Cnt=01 Dev#= 10 Spd=480 MxCh= 0
> > > > D: Ver= 2.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs= 1
> > > > P: Vendor=22d9 ProdID=276c Rev=04.04
> > > > S: Manufacturer=OPPO
> > > > S: Product=SDM660-MTP _SN:09C6BCA7
> > > > S: SerialNumber=beb2c403
> > > > C: #Ifs= 2 Cfg#= 1 Atr=80 MxPwr=500mA
> > > > I: If#=0x0 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=30
> > > > 
> > > > Reported-by: Yan Xinyu <sdlyyxy@bupt.edu.cn>
> > > > Cc: Johan Hovold <johan@kernel.org>
> > > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > ---
> > > > drivers/usb/serial/usb-serial-simple.c | 4 +++-
> > > > 1 file changed, 3 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/drivers/usb/serial/usb-serial-simple.c b/drivers/usb/serial/usb-serial-simple.c
> > > > index 4c6747889a19..eb832b94aa3a 100644
> > > > --- a/drivers/usb/serial/usb-serial-simple.c
> > > > +++ b/drivers/usb/serial/usb-serial-simple.c
> > > > @@ -60,7 +60,9 @@ DEVICE(flashloader, FLASHLOADER_IDS);
> > > > 	{ USB_VENDOR_AND_INTERFACE_INFO(0x18d1,			\
> > > > 					USB_CLASS_VENDOR_SPEC,	\
> > > > 					0x50,			\
> > > > -					0x01) }
> > > > +					0x01) },		\
> > > > +	{ USB_DEVICE_AND_INTERFACE_INFO(0x22d9, 0x276c,		\
> > > > +					0xff, 0xff, 0x30) }
> > > > DEVICE(google, GOOGLE_IDS);
> > > > 
> > > > /* Libtransistor USB console */
> > > > -- 
> > > > 2.37.1
> > > Tested-by: Yan Xinyu <sdlyyxy@bupt.edu.cn>
> > 
> > While this may work sufficiently well for real low-volume diag traffic I'd
> > expect a significant percentage of diag messages to be lost in practice
> > with the usb-serial-simple driver.
> > 
> > According to the usb-devices output this looks like the Qualcomm USB gadget
> > in the DIAG + ADB composition to me.
> > 
> > Since the option driver uses the usb-wwan framework my suggestion would be
> > for the original patch to be applied instead similar to what has been done
> > e.g. for the Quectel RM500Q diag port.
> 
> But this is not using the option chip, nor using the option flow control
> protocol at all, so it should not be showing up as a device controlled
> by the option driver.  It just will not work properly, the simple driver
> should be doing the exact same thing here.
> 

you seem to have the misconception that devices handled by the option driver
would use a USB to serial converter chip from Option similar to e.g. the
ftdi_sio driver which is not the case.

Quoting from option.c:
  ===
  This driver exists because the "normal" serial driver doesn't work too well
  with GSM modems. Issues:
  - data loss -- one single Receive URB is not nearly enough
  - nonstandard flow (Option devices) control
  - controlling the baud rate doesn't make sense

  This driver is named "option" because the most common device it's
  used for is a PC-Card (with an internal OHCI-USB interface, behind
  which the GSM interface sits), made by Option Inc.
  ===

The GSM/UMTS interface in the Option card actually contains a Qualcomm chip
which exports its serial ports via USB. The data loss mentioned by Matthias
above also applies to the diag port.

As can be seen from the sendsetup code in the qcserial driver the
"nonstandard flow (Option devices) control" mentioned above is actually
a Qualcomm "feature" required for some of their USB serial implementations
on tne device to work properly.

In case you suspect potential problems with the sendsetup code and the OPPO
R11 diag port Yan's option.c patch could be extended like this:
	{ USB_DEVICE_AND_INTERFACE_INFO(OPPO_VENDOR_ID, OPPO_PRODUCT_R11, 0xff, 0xff, 0x30),
	  .driver_info = NCTRL(0) },

With a few more lines of code you could also add a new layout to the qcserial
driver if you prefer for the OPPO R11 to be handled by it for some reason.

Either one would be fine with me.

Please don't give the OPPO R11 diag port on Linux a bad name by letting
the usb-serial-simple driver handle it.

Thanks,
Reinhard
