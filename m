Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1A5851CC3B
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 00:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386437AbiEEWjs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 18:39:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386491AbiEEWio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 18:38:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C65D606D6
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 15:34:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 71A0EB8306F
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 22:34:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06947C385A8;
        Thu,  5 May 2022 22:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1651790086;
        bh=WI8QLFqK75r2HXo5FfrBnTLOY0nctWS77VW+kxLMDnU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tl/wYOGsIhkZwOn4lj4ydl9gkmOXb87kvwJhPZ9VU3wgCKZcZjh0zEwjLKRd6RpRP
         ZOsS2j7ItAW0I87QNLAGl5I5QuKpeEBCxn2OY0tJ2A+IoJBfMUMFAO3l3Fc8iGhmFm
         FAfEoeaOzhiPyARTeQQry3VnMBIclBAcNZZi1BFA=
Date:   Thu, 5 May 2022 23:16:15 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Artur Bujdoso <artur.bujdoso@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: octeon-usb: remove unnecessary parentheses
Message-ID: <YnQ+n2+nYVLns2r+@kroah.com>
References: <Yk/knRtaujd/PzK7@crux>
 <Yk/uxoi4VUaR9OpO@kroah.com>
 <YmqFGS2e45SEUbe/@crux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YmqFGS2e45SEUbe/@crux>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 28, 2022 at 02:14:17PM +0200, Artur Bujdoso wrote:
> On Fri, Apr 08, 2022 at 10:13:58AM +0200, Greg Kroah-Hartman wrote:
> > On Fri, Apr 08, 2022 at 09:30:37AM +0200, Artur Bujdoso wrote:
> > > Adhere to Linux kernel coding style.
> > > 
> > > Reported by checkpatch:
> > > 
> > > CHECK:UNNECESSARY_PARENTHESES: Unnecessary parentheses
> > > 
> > > Signed-off-by: Artur Bujdoso <artur.bujdoso@gmail.com>
> > > ---
> > >  drivers/staging/octeon-usb/octeon-hcd.c | 62 ++++++++++++-------------
> > >  1 file changed, 31 insertions(+), 31 deletions(-)
> > > 
> > > diff --git a/drivers/staging/octeon-usb/octeon-hcd.c b/drivers/staging/octeon-usb/octeon-hcd.c
> > > index a1cd81d4a114..32bcd6c582f5 100644
> > > --- a/drivers/staging/octeon-usb/octeon-hcd.c
> > > +++ b/drivers/staging/octeon-usb/octeon-hcd.c
> > > @@ -1101,9 +1101,9 @@ static struct cvmx_usb_pipe *cvmx_usb_open_pipe(struct octeon_hcd *usb,
> > >  	pipe = kzalloc(sizeof(*pipe), GFP_ATOMIC);
> > >  	if (!pipe)
> > >  		return NULL;
> > > -	if ((device_speed == CVMX_USB_SPEED_HIGH) &&
> > > -	    (transfer_dir == CVMX_USB_DIRECTION_OUT) &&
> > > -	    (transfer_type == CVMX_USB_TRANSFER_BULK))
> > > +	if (device_speed == CVMX_USB_SPEED_HIGH &&
> > > +	    transfer_dir == CVMX_USB_DIRECTION_OUT &&
> > > +	    transfer_type == CVMX_USB_TRANSFER_BULK)
> > >  		pipe->flags |= CVMX_USB_PIPE_FLAGS_NEED_PING;
> > 
> > Nah, the original is fine, no need to change this.
> > 
> > Unless, do you have this hardware?  If so, getting this out of staging
> > would be nice to have happen one day.
> > 
> > thanks,
> > 
> > greg k-h
> 
> Hi,
> 
> So I do have the hardware, an Ubiquiti Edgerouter POE. This has a Cavium Octeon+ SoC and a single USB port.
> This is used for booting and for rootfs (in a form of a squasfs image) and configuration.
> 
> I cross-compiled an unmodified kernel with a sufficient configuration - with the octeon-usb driver added - to get to user space.
> I am not sure how should I present it - sorry in advance if it's not the right way - so here is the boot log as it happened. 
> 
> I should note that I tried to plug in other devices such as usb pendrives, wifi dongles, a hub and even an Elgato card, all showed up.
> Partitions were also detected on all usb drives, all of them had some sort of FAT partitions with MBR.
> 
> What else can I help with to get this driver out of staging?

Is it checkpatch and sparse clean?  If so, then propose a patch that
adds it to the proper place in the kernel tree and we can go from there.

thanks,

greg k-h
